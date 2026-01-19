Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C019CCF2DD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNV-00079J-0P; Mon, 19 Jan 2026 13:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN5-0006Nf-Ec
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:05 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN2-0005up-Cf
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:01 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2151E80760;
 Mon, 19 Jan 2026 21:52:59 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-TmfdUmKd; Mon, 19 Jan 2026 21:52:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848778;
 bh=E+nk2j9Vw8tQaoGmGSs+VyhHBPWP5Zy1keFCbK64NrA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RVs7t1IeGSb4TpRrkCyGUmM22MExm1cuA7Leh0EK13UU0gZHJUsXb5m53MSWnGOnL
 GYBteonox61xdRjh7B4024q4CotLr4CQrMPe+YW6/iVsSF6nlIXqnRR1JI3ENYjxHk
 y+bi8QvX0IYuSFnRMUSs/VtDSu17MPgmVS8sAx0s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v4 19/23] vhost: vhost_dev_init(): simplify features
 initialization
Date: Mon, 19 Jan 2026 21:52:23 +0300
Message-ID: <20260119185228.203296-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
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
index b9f26a4ee8..ad49b9cc2f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1561,18 +1561,17 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
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
 
@@ -1580,7 +1579,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    uint64_t features[VIRTIO_FEATURES_NU64S];
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
@@ -1601,9 +1599,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_get_features(hdev, features);
+    r = vhost_dev_init_features(hdev);
     if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_get_features failed");
+        error_setg_errno(errp, -r, "vhost_init_features failed");
         goto fail;
     }
 
@@ -1629,8 +1627,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    virtio_features_copy(hdev->_features_ex, features);
-
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
         .begin = vhost_begin,
-- 
2.52.0


