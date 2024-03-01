Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEA3C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Qi-0007F7-EU; Fri, 01 Mar 2024 12:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QX-000764-VO; Fri, 01 Mar 2024 12:12:07 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QS-0003L3-Jl; Fri, 01 Mar 2024 12:12:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 6704C60D81;
 Fri,  1 Mar 2024 20:11:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jBfRBH2IW0U0-wiXVmiU8; Fri, 01 Mar 2024 20:11:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709313115;
 bh=L5rxMwIIpGLyB14vljKNg1rTNtf+X2c73o7+H0OgEoQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XeNuD5OtZQP0ukwHRRyKYVMl5jjp1zuyvmGC1JTNxnYEx5Qxn6LUXN0aoI3dmpTB8
 niwbhxnqckLjM5H6to7c6k6MNIbDMRB/FJeQPCzEtRbAi49RouRBeC+1FouAeaxF6w
 DNWbagvf0jUz0hs+R7cJOY/MZcb9gDXYrM157c2s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v2 1/6] vhost-user-blk: simplify and fix
 vhost_user_blk_handle_config_change
Date: Fri,  1 Mar 2024 20:11:38 +0300
Message-Id: <20240301171143.809835-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301171143.809835-1-vsementsov@yandex-team.ru>
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's not care about what was changed and update the whole config,
reasons:

1. config->geometry should be updated together with capacity, so we fix
   a bug.

2. Vhost-user protocol doesn't say anything about config change
   limitation. Silent ignore of changes doesn't seem to be correct.

3. vhost-user-vsock reads the whole config

4. on realize we don't do any checks on retrieved config, so no reason
   to care here

Comment "valid for resize only" exists since introduction the whole
hw/block/vhost-user-blk.c in commit
   00343e4b54ba0685e9ebe928ec5713b0cf7f1d1c
    "vhost-user-blk: introduce a new vhost-user-blk host device",
seems it was just an extra limitation.

Also, let's notify guest unconditionally:

1. So does vhost-user-vsock

2. We are going to reuse the functionality in new cases when we do want
   to notify the guest unconditionally. So, no reason to create extra
   branches in the logic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/block/vhost-user-blk.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 6a856ad51a..9e6bbc6950 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -91,7 +91,6 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    struct virtio_blk_config blkcfg;
     VirtIODevice *vdev = dev->vdev;
     VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
@@ -100,19 +99,15 @@ static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&blkcfg,
+    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
                                vdev->config_len, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    /* valid for resize only */
-    if (blkcfg.capacity != s->blkcfg.capacity) {
-        s->blkcfg.capacity = blkcfg.capacity;
-        memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-        virtio_notify_config(dev->vdev);
-    }
+    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(dev->vdev);
 
     return 0;
 }
-- 
2.34.1


