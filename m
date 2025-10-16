Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92E7CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNK-0007Fn-Vx; Thu, 16 Oct 2025 07:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMp-00078K-9N; Thu, 16 Oct 2025 07:41:59 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMa-0003V0-RV; Thu, 16 Oct 2025 07:41:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 543BEC01CB;
 Thu, 16 Oct 2025 14:41:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-cwh9id8l; Thu, 16 Oct 2025 14:41:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614891;
 bh=SF+Ue84XhT+g2RO+Jl8Tk8MZ2adI/UHd1mhcu8QJuxs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Q0FyYiPede9zuXeL3XOfmFfI1nsupeMyRbH+AoYJ+K9lzRlMaf5x+2m7P2Ks14pnV
 0xP8ZM1JYLcUs7GBpF34ir9uQiGhXQ2eY7gasFzKNhpr5RmZtVVC8yIL5cSKFW6Ol4
 OG3a89Rs7DcC5nxGfsbmyCIB6SdIwT6QaovbXt5M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 11/25] vhost-user-blk: move initial reconnect loop to
 separate function
Date: Thu, 16 Oct 2025 14:40:48 +0300
Message-ID: <20251016114104.1384675-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Simplify _realize function, and prepare to further changes.

While being here, also rename virtio_err: label to more generic
fail:, virtio_err doesn't improve readability here.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 54 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9c727c3977..36e32229ad 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -489,14 +489,40 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
     return 0;
 }
 
-static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
+static int vhost_user_blk_realize_connect_loop(VHostUserBlk *s, Error **errp)
 {
     ERRP_GUARD();
+    DeviceState *dev = DEVICE(s);
+    int ret, retries = VU_REALIZE_CONN_RETRIES;
+
+    assert(!*errp);
+    do {
+        if (*errp) {
+            error_prepend(errp, "Reconnecting after error: ");
+            error_report_err(*errp);
+            *errp = NULL;
+        }
+        ret = vhost_user_blk_realize_connect(s, errp);
+    } while (ret < 0 && retries--);
+
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* we're fully initialized, now we can operate, so add the handler */
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
+                             vhost_user_blk_event, NULL, (void *)dev,
+                             NULL, true);
+
+    return 0;
+}
+
+static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
+{
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
     size_t config_size;
-    int retries;
-    int i, ret;
+    int i;
 
     trace_vhost_user_blk_device_realize_in(vdev);
 
@@ -540,31 +566,15 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->inflight = g_new0(struct vhost_inflight, 1);
     s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
 
-    retries = VU_REALIZE_CONN_RETRIES;
-    assert(!*errp);
-    do {
-        if (*errp) {
-            error_prepend(errp, "Reconnecting after error: ");
-            error_report_err(*errp);
-            *errp = NULL;
-        }
-        ret = vhost_user_blk_realize_connect(s, errp);
-    } while (ret < 0 && retries--);
-
-    if (ret < 0) {
-        goto virtio_err;
+    if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
+        goto fail;
     }
 
-    /* we're fully initialized, now we can operate, so add the handler */
-    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
-                             vhost_user_blk_event, NULL, (void *)dev,
-                             NULL, true);
-
     trace_vhost_user_blk_device_realize_out(vdev);
 
     return;
 
-virtio_err:
+fail:
     g_free(s->vhost_vqs);
     s->vhost_vqs = NULL;
     g_free(s->inflight);
-- 
2.48.1


