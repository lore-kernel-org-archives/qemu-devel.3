Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E646CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iww-0006GQ-HN; Sat, 11 Oct 2025 19:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iws-0006F1-VQ
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:26 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwr-0000ug-8B
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E1579C01D9;
 Sun, 12 Oct 2025 02:24:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-jCIlRWQX; Sun, 12 Oct 2025 02:24:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225063;
 bh=OMhmUaU9DNTaQUYOhlrO4kclp+J0BsKC+ljy90fIMbc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=GaGr/8GiV0WNXrjz7Pyc/YAExVacom948D7y/uveE1cCYgYZMPHARisla2Nvhluof
 bruXYTaoC7usBSTJCYo7Vvm3NViLCRmyjZNVSQ4V6YLkNWF6ZcrCiXoU213yK6F63u
 50o9qejSqgHZST87KJUEQKhjlUo2TsK5cOlvPSOY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 19/23] vhost: vhost_dev_init(): simplify features
 initialization
Date: Sun, 12 Oct 2025 02:23:58 +0300
Message-ID: <20251011232404.561024-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
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

Drop extra variable and extra function parameter passing, initialize
dev._features directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c990029756..d02d1d4c34 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1557,18 +1557,17 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
-static int vhost_dev_get_features(struct vhost_dev *hdev,
-                                  uint64_t *features)
+static int vhost_dev_init_features(struct vhost_dev *hdev)
 {
     uint64_t features64;
     int r;
 
     if (hdev->vhost_ops->vhost_get_features_ex) {
-        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
+        return hdev->vhost_ops->vhost_get_features_ex(hdev, hdev->_features_ex);
     }
 
     r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
-    virtio_features_from_u64(features, features64);
+    virtio_features_from_u64(hdev->_features_ex, features64);
     return r;
 }
 
@@ -1615,7 +1614,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    uint64_t features[VIRTIO_FEATURES_NU64S];
     int i, r, n_initialized_vqs = 0;
 
     hdev->vdev = NULL;
@@ -1635,9 +1633,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_get_features(hdev, features);
+    r = vhost_dev_init_features(hdev);
     if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_get_features failed");
+        error_setg_errno(errp, -r, "vhost_init_features failed");
         goto fail;
     }
 
@@ -1650,8 +1648,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    virtio_features_copy(hdev->_features_ex, features);
-
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
         .begin = vhost_begin,
-- 
2.48.1


