Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A09DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Zg-00048g-4h; Wed, 27 May 2026 02:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZK-0003vq-8d
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:45 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZH-0003ye-Ef
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 35A3180677;
 Wed, 27 May 2026 09:16:37 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-j39ha1xi; Wed, 27 May 2026 09:16:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862596;
 bh=f+YTC8jxqRIkRV5zuadeLcBGcoK/zFyu6bOocqT+UcM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dMfzEqpYd2yGfhepVx0d4Co80kHX/oRK0/0xyT0VmECD+e+YC2JBy1cCsSq/DPh01
 YV7a9Uc4LSdt2BuWJF2NamlN2a4mmKcNCupWP82fj5uricuJUuDm4tSnlYIuyE+/ZB
 uty553lS7R8tOGw3xtEtqwlFswp5xeB/97vcZ7HM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v7 08/22] virtio: drop *_set_guest_notifier_fd_handler()
 helpers
Date: Wed, 27 May 2026 09:16:09 +0300
Message-ID: <20260527061625.11167-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
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

Now they don't make code more readable. Let's better put the whole
logic into virtio_queue_set_guest_notifier().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/virtio.c | 75 +++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 58 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3780e860391..fb7f7f0f061 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3836,73 +3836,32 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
     }
 }
 
-static void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq,
-                                                       bool assign,
-                                                       bool with_irqfd)
-{
-    if (assign && !with_irqfd) {
-        event_notifier_set_handler(&vq->guest_notifier,
-                                   virtio_queue_guest_notifier_read);
-    } else {
-        event_notifier_set_handler(&vq->guest_notifier, NULL);
-    }
-    if (!assign) {
-        /* Test and clear notifier before closing it,
-         * in case poll callback didn't have time to run. */
-        virtio_queue_guest_notifier_read(&vq->guest_notifier);
-    }
-}
-
-static void virtio_config_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 bool assign, bool with_irqfd)
-{
-    EventNotifier *n;
-    n = &vdev->config_notifier;
-    if (assign && !with_irqfd) {
-        event_notifier_set_handler(n, virtio_config_guest_notifier_read);
-    } else {
-        event_notifier_set_handler(n, NULL);
-    }
-    if (!assign) {
-        /* Test and clear notifier before closing it,*/
-        /* in case poll callback didn't have time to run. */
-        virtio_config_guest_notifier_read(n);
-    }
-}
-
-static void virtio_set_guest_notifier_fd_handler(VirtIODevice *vdev,
-                                                 VirtQueue *vq,
-                                                 int n, bool assign,
-                                                 bool with_irqfd)
-{
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        virtio_config_set_guest_notifier_fd_handler(vdev, assign, with_irqfd);
-    } else {
-        virtio_queue_set_guest_notifier_fd_handler(vq, assign, with_irqfd);
-    }
-}
-
 int virtio_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
                               bool with_irqfd)
 {
-    VirtQueue *vq = NULL;
-    EventNotifier *notifier = NULL;
-
-    if (n == VIRTIO_CONFIG_IRQ_IDX) {
-        notifier = virtio_config_get_guest_notifier(vdev);
-    } else {
-        vq = virtio_get_queue(vdev, n);
-        notifier = virtio_queue_get_guest_notifier(vq);
-    }
+    bool is_config = n == VIRTIO_CONFIG_IRQ_IDX;
+    VirtQueue *vq = is_config ? NULL : virtio_get_queue(vdev, n);
+    EventNotifier *notifier = is_config ?
+        virtio_config_get_guest_notifier(vdev) :
+        virtio_queue_get_guest_notifier(vq);
+    EventNotifierHandler *read_fn = is_config ?
+        virtio_config_guest_notifier_read :
+        virtio_queue_guest_notifier_read;
 
     if (assign) {
         int r = event_notifier_init(notifier, 0);
         if (r < 0) {
             return r;
         }
-        virtio_set_guest_notifier_fd_handler(vdev, vq, n, true, with_irqfd);
-    } else {
-        virtio_set_guest_notifier_fd_handler(vdev, vq, n, false, with_irqfd);
+    }
+
+    event_notifier_set_handler(notifier,
+                               (assign && !with_irqfd) ? read_fn : NULL);
+
+    if (!assign) {
+        /* Test and clear notifier before closing it,*/
+        /* in case poll callback didn't have time to run. */
+        read_fn(notifier);
         event_notifier_cleanup(notifier);
     }
 
-- 
2.52.0


