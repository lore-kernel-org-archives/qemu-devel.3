Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DFCC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM58l-0003Hj-1V; Tue, 25 Jun 2024 08:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58f-0003Ge-64; Tue, 25 Jun 2024 08:19:09 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM58c-0006eF-AZ; Tue, 25 Jun 2024 08:19:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C3AAF608EC;
 Tue, 25 Jun 2024 15:19:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jIOnbJ0r9iE0-kgF7JREr; Tue, 25 Jun 2024 15:19:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719317941;
 bh=nE8KRYNH/UdPTwy4qr33SLrQDzML5H/fRCmZwPtMmDI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fkmubWaZFTJrkggu15L/B1nBUHEWVX9WZv+DlU5kf74PLUyGps7eZ24IwGeWCym+F
 qDsqP6gmToOYa/8Vh4YsHCF+lWb4iQWTQjj9VqYeg8aU2xqXd7lOd0UOa0gE1c4zdE
 YuQCgf9VsjsHLC+87ytBVjTzVapfAPaVu27MrEj0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: [PATCH v5 2/3] vhost-user-blk: split vhost_user_blk_sync_config()
Date: Tue, 25 Jun 2024 15:18:42 +0300
Message-Id: <20240625121843.120035-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121843.120035-1-vsementsov@yandex-team.ru>
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Split vhost_user_blk_sync_config() out from
vhost_user_blk_handle_config_change(), to be reused in the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..091d2c6acf 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     s->blkcfg.wce = blkcfg->wce;
 }
 
+static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
+{
+    int ret;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                               vdev->config_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(vdev);
+
+    return 0;
+}
+
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    VirtIODevice *vdev = dev->vdev;
-    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
 
     if (!dev->started) {
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
-                               vdev->config_len, &local_err);
+    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-    virtio_notify_config(dev->vdev);
-
     return 0;
 }
 
-- 
2.34.1


