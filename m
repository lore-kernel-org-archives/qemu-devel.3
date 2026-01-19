Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7100CCF2DD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNR-00071X-QZ; Mon, 19 Jan 2026 13:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN3-0006Km-BP
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:01 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN1-0005uV-Na
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:01 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 64CC98863C;
 Mon, 19 Jan 2026 21:52:58 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-JHmy9Ipu; Mon, 19 Jan 2026 21:52:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848777;
 bh=lLXxusRw2YZVf5A40u70o3SKR8jxXl1iK3azs8RLRWQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yX8qGZ3bMjs3kCw0obZq1JH8NSo1usY0DiV+x++swBA3HGMEOVBthttLmvICHD6XU
 fIN7wSCXztj9Ox8rkxfctvA8Ks1gMa3QE0SXm8tb3BNjqTfyNpRc1ew8bq/87dvu69
 njGj4QB0KIDWmVRyIp1gmyo+UuT98G9GjwqJxcyc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v4 18/23] vhost: move busyloop timeout initialization to
 vhost_virtqueue_init()
Date: Mon, 19 Jan 2026 21:52:22 +0300
Message-ID: <20260119185228.203296-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Let's all per-virtqueue initializations be in one place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 412bbd9063..b9f26a4ee8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1497,7 +1497,8 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
 }
 
 static int vhost_virtqueue_init(struct vhost_dev *dev,
-                                struct vhost_virtqueue *vq, int n)
+                                struct vhost_virtqueue *vq, int n,
+                                bool busyloop_timeout)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, n);
     struct vhost_vring_file file = {
@@ -1534,6 +1535,14 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
                                    vhost_virtqueue_error_notifier);
     }
 
+    if (busyloop_timeout) {
+        r = vhost_virtqueue_set_busyloop_timeout(dev, n, busyloop_timeout);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "Failed to set busyloop timeout");
+            goto fail_err;
+        }
+    }
+
     return 0;
 
 fail_err:
@@ -1612,24 +1621,14 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     }
 
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
-        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i);
+        r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
+                                 busyloop_timeout);
         if (r < 0) {
             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
             goto fail;
         }
     }
 
-    if (busyloop_timeout) {
-        for (i = 0; i < hdev->nvqs; ++i) {
-            r = vhost_virtqueue_set_busyloop_timeout(hdev, hdev->vq_index + i,
-                                                     busyloop_timeout);
-            if (r < 0) {
-                error_setg_errno(errp, -r, "Failed to set busyloop timeout");
-                goto fail;
-            }
-        }
-    }
-
     virtio_features_copy(hdev->_features_ex, features);
 
     hdev->memory_listener = (MemoryListener) {
-- 
2.52.0


