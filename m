Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAB8EA795E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIXA-0001sq-4C; Fri, 06 Feb 2026 04:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWf-0001mD-V7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:24 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWe-0000H1-BV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 267EBC01C0;
 Fri, 06 Feb 2026 12:53:19 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-STxLk9IU; Fri, 06 Feb 2026 12:53:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371598;
 bh=lpL8uE8V3uEHboVyYaQrvTNi0QOZLD0l0McQR8T9lWA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ymQ6/0O2aU44LXwsFO4Gt90l1Pkxh1742n743Vaeh794/jf2Avywha+vuFDldInMR
 hUX047v6PwHDi2u15J1rRmjs3QRMjhzNRq/SW7alBWOb0fkBBseSO85PAVzMiHH7CX
 JH8XIuijsk48sM9WYRJnjCnuUlBHv+DSpNyYOiFU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v5 09/23] virtio: drop *_set_guest_notifier_fd_handler()
 helpers
Date: Fri,  6 Feb 2026 12:52:43 +0300
Message-ID: <20260206095258.894504-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
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
index 6d1ee577a4..d9fe615bb2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3831,73 +3831,32 @@ static void virtio_config_guest_notifier_read(EventNotifier *n)
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


