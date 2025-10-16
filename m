Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F6CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNb-0007SQ-6n; Thu, 16 Oct 2025 07:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MN2-0007BJ-GJ; Thu, 16 Oct 2025 07:42:14 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMt-0003VV-B4; Thu, 16 Oct 2025 07:42:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0144EC01D2;
 Thu, 16 Oct 2025 14:41:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-FQH2tMY6; Thu, 16 Oct 2025 14:41:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614892;
 bh=BasLlhPIqn3NnKJfMKRrLdXARiWRvWkkx7fEK4BDITM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aUzwRa9NcHF2nAN8O9zds2QgLx91o99px4R3pRqrBvtXwtbLu1Zlnp4rsllZougzg
 WesjxSQ5o0pHew+GF26TcNxR6Mr/OaZ/hLy6HRxfm8OZnWxynIOwNEEGVzNcajxfVE
 VKNaGxwGH4M2Yi4Aakfx9LmoJVqKPjPscH4MNIvo=
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
Subject: [PATCH v2 12/25] vhost-user-blk: move first vhost_user_blk_init() to
 _realize()
Date: Thu, 16 Oct 2025 14:40:49 +0300
Message-ID: <20251016114104.1384675-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll need to postpone further connecting/reconnecting logic to the
later point to support backend-transfer migration for vhost-user-blk.
For now, move first call to vhost_user_blk_init() to _realize() (this
call will not be postponed). To support this, we also have to move
re-initialization to vhost_user_blk_realize_connect_loop().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 36e32229ad..af4a97b8e4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -464,14 +464,12 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
     DeviceState *dev = DEVICE(s);
     int ret;
 
-    s->connected = false;
-
     ret = qemu_chr_fe_wait_connected(&s->chardev, errp);
     if (ret < 0) {
         return ret;
     }
 
-    ret = vhost_user_blk_init(dev, true, errp);
+    ret = vhost_user_blk_connect(dev, errp);
     if (ret < 0) {
         qemu_chr_fe_disconnect(&s->chardev);
         return ret;
@@ -501,7 +499,16 @@ static int vhost_user_blk_realize_connect_loop(VHostUserBlk *s, Error **errp)
             error_prepend(errp, "Reconnecting after error: ");
             error_report_err(*errp);
             *errp = NULL;
+
+            s->connected = false;
+
+            ret = vhost_user_blk_init(dev, false, errp);
+            if (ret < 0) {
+                /* No reason to retry initialization */
+                return ret;
+            }
         }
+
         ret = vhost_user_blk_realize_connect(s, errp);
     } while (ret < 0 && retries--);
 
@@ -566,6 +573,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     s->inflight = g_new0(struct vhost_inflight, 1);
     s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
 
+    if (vhost_user_blk_init(dev, false, errp) < 0) {
+        goto fail;
+    }
+
     if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
         goto fail;
     }
-- 
2.48.1


