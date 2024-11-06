Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65651D44D4C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e4A-0002h9-LA; Wed, 06 Nov 2024 06:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e46-0002eq-M3; Wed, 06 Nov 2024 06:19:10 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1t8e42-0008FW-TN; Wed, 06 Nov 2024 06:19:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:94a7:0:640:198e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0DAAC60B25;
 Wed,  6 Nov 2024 14:19:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b49f::1:6])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dIfYi50AYGk0-bpCY0Iee; Wed, 06 Nov 2024 14:19:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1730891940;
 bh=IEOiRJGJYlcr4g0r9xJip2sYo3/kprjCQRJKg3vrrEg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=P7LBlfC4n+WavmuPTiG9ffnqidyueBYcWsn8WWK7qVlskrcFES4713lWkciG5/DzF
 GidLSiSmNzja6UOQSp6kxZ7/jYQyBPcJpKs2W7FhqYbxoP66Up7+R/0YpaZnicGTR5
 NKIAe2WJlYFmry18wUWyt4fcFvBCyAVn4lOEVNjw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: sgarzare@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v7 2/3] vhost-user-blk: split vhost_user_blk_sync_config()
Date: Wed,  6 Nov 2024 14:18:36 +0300
Message-Id: <20241106111837.115820-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106111837.115820-1-vsementsov@yandex-team.ru>
References: <20241106111837.115820-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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
Acked-by: Raphael Norwitz <raphael@enfabrica.net>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 5b7f46bbb0..48b3dabb8d 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -90,27 +90,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
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


