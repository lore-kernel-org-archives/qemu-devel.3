Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BBCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92y3-0007qu-KU; Wed, 15 Oct 2025 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xx-0007oU-TO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:59:01 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xo-0000ek-FZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:59:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9D037C0684;
 Wed, 15 Oct 2025 17:58:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-CgNmny3c; Wed, 15 Oct 2025 17:58:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540307;
 bh=e9/Yv3dJf43GhwZe5cd7CVMTYBfmA9K1KYNbAWzvgrs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=tHaXFpdjj/xacL9NU7FuvSzwVA0zTyKbl/L12Z+1ZJI7ZSRe+s45ZZshvqJaCdp7/
 j4p4kZV8yDAqFzSgCjC7NFfWUnxdCS8PrUBPFPKiQ1BRvputpBPynx8Ccrj1P0XRjq
 KfK5edgk7Ec/EHBfcE2Nqe71JPQnFUuGRtPuVO+M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 19/23] vhost: vhost_dev_init(): simplify features
 initialization
Date: Wed, 15 Oct 2025 17:58:03 +0300
Message-ID: <20251015145808.1112843-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
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

Drop extra variable and extra function parameter passing, initialize
dev._features directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56a812b06b..fb5c4ba1ca 100644
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


