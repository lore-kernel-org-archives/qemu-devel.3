Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E910CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfw-00030K-RT; Wed, 13 Aug 2025 12:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfQ-0002fE-2r; Wed, 13 Aug 2025 12:49:36 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfG-0007rG-Eh; Wed, 13 Aug 2025 12:49:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 76A9781215;
 Wed, 13 Aug 2025 19:49:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-2x9qfGo2; Wed, 13 Aug 2025 19:49:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103756;
 bh=BWMv7GCTh1zLrolstH3IcsKkRYEicDVqwv8C15LlkPE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0l/xxhjkxW5F90hxGQKjQlAhyTdwvLnjDkFJfSBQdJ1uyKTXtSo2iSshHkYJUwAD2
 /zRk710A0Y3BexD8hbBjaVRZEFMGksulbzT7a9QSEF2jFc+8ENZzlg41WCF96eLZK/
 oVDpEWqc1PyksRnNkgvSBQFkSBFlnDUJ1+ZpO3yU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 17/33] vhost: move busyloop timeout initialization to
 vhost_virtqueue_init()
Date: Wed, 13 Aug 2025 19:48:38 +0300
Message-ID: <20250813164856.950363-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's all per-virtqueue initializations be in one place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a3620c82d8..a8f8b85012 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1489,7 +1489,8 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
 }
 
 static int vhost_virtqueue_init(struct vhost_dev *dev,
-                                struct vhost_virtqueue *vq, int n)
+                                struct vhost_virtqueue *vq, int n,
+                                bool busyloop_timeout)
 {
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, n);
     struct vhost_vring_file file = {
@@ -1526,6 +1527,14 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
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
@@ -1589,24 +1598,14 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
     hdev->_features = features;
 
     hdev->memory_listener = (MemoryListener) {
-- 
2.48.1


