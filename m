Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BA6CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNW-0007O3-CG; Thu, 16 Oct 2025 07:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMm-00077W-5Q; Thu, 16 Oct 2025 07:41:57 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMa-0003V1-UX; Thu, 16 Oct 2025 07:41:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A45E8C01C0;
 Thu, 16 Oct 2025 14:41:31 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-kbTFYAzO; Thu, 16 Oct 2025 14:41:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614891;
 bh=s9yCrQBHmEqUJP+BAtrGs9xnsIszRjeHBLrqv/k9/kY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nGMFivfrKNwEYIg4qwdqbFWpAbeT2qjkF2VfBM6/5cHP4iADYxGoBuyFaeYKhyjCE
 nTuClrPtD2w8Gm2KvZ4UojN8fA31c+j9bTunxgzi2ta2nXtoE9VELDvlS43fuq4mq2
 aKRDhC38KQ64KEkYt2XCUupg+hX9++fFFxuTvOhs=
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
Subject: [PATCH v2 10/25] vhost-user-blk: split vhost_user_blk_init()
Date: Thu, 16 Oct 2025 14:40:47 +0300
Message-ID: <20251016114104.1384675-11-vsementsov@yandex-team.ru>
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split it into _init() and _connect() part, following pattern of
vhost_dev_init / vhost_dev_connect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c31c265a0e..9c727c3977 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -58,6 +58,7 @@ static const int user_feature_bits[] = {
 };
 
 static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
+static int vhost_user_blk_connect(DeviceState *dev, Error **errp);
 
 static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -352,9 +353,6 @@ static int vhost_user_blk_init(DeviceState *dev, bool connect, Error **errp)
 
     trace_vhost_user_blk_init_in(vdev);
 
-    /* TODO: implement support for connect=false */
-    assert(connect);
-
     assert(!s->connected);
 
     s->dev.num_queues = s->num_queues;
@@ -371,6 +369,29 @@ static int vhost_user_blk_init(DeviceState *dev, bool connect, Error **errp)
         return ret;
     }
 
+    if (connect) {
+        ret = vhost_user_blk_connect(dev, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    trace_vhost_user_blk_init_out(vdev);
+
+    return 0;
+}
+
+static int vhost_user_blk_connect(DeviceState *dev,
+                                  Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int ret = 0;
+
+    trace_vhost_user_blk_connect_in(vdev);
+
+    assert(!s->connected);
+
     ret = vhost_dev_connect(&s->dev, errp);
     if (ret < 0) {
         return ret;
-- 
2.48.1


