Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607DEE64002
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvI-0003uO-Ks; Sun, 05 Apr 2026 03:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvG-0003ta-DK
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:30 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvE-0007EY-LM
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:30 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso6147454eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374167; x=1775978967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/AIm7dcgDves1AjHp0rGGsirlJpDLatrdTujVTNwp8=;
 b=RiNQvrvxM434JDdJoPHd1ljF5moiN3w0vLR/XMRwe149bL+yq35jB+VIz7ijyPJznt
 rlrDnrRRi0yAiJQ+fFV3QrHXAQ+8lNjNLvgZ9hgCUUCnCshaasXzwRFiQLYIZLrYCYFm
 dssnZwd5ZEDUidM13YhQTXyLgxRxuoTgX0AKqL0BqYJl3yWKpjevsZRjB7pfuLl+mav4
 8utkZEaaz8RTYE6S3OmuQmlvvBaaEFdnBrKazcMNkJYxpbEMZ0MKcyWj0XpCiPhLcVCd
 OdfZI4RmmXPBlk6kX5wRZcw6OPdSNgFpm1gK3MAbCBZrZHA70R8vEhG3yJEIip0pJC42
 WTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374167; x=1775978967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o/AIm7dcgDves1AjHp0rGGsirlJpDLatrdTujVTNwp8=;
 b=F+8bomq4UVfkLqBq2RdU89ycX6aW8j9lWG7IZk59A2MN86UGtJa12TON3uOd2uFBMY
 4D5x85+X4ZGsphQqS8UfUAxRqygS/UlGrKltndqNjM6rMuB/tx70BuT1OpH21/QDwqV8
 pk/fJden+pzRJMmrwnk6/PrNbbMgiLAi7T2A2SO0FBxr4Twa145qJVxC8ayVR1FTrf4q
 q+utD1A/K48ynkaOfCGEDWCXmQSEGTYguSZxE239M3ANkQfV0NviR7QNAOW8pj18Vrqc
 /zb3QgtkuRFUKPTiI/0F6KEQhaRCuO5gxY+aPMhHFgCl0MKIBb6PVS79FniWsqEooS+v
 Dffg==
X-Gm-Message-State: AOJu0YzqQJ1NNgH2NjyMl2V2E2mYJmxxhe/QSfYv0iSwZDP1gkFmfade
 pWoQm9MldPJro+ZTbxhe4cOTC77/h2CTKtIHmJnrv0Jx/g+Ohsu2vkvj9BvPvPWXQXQ=
X-Gm-Gg: AeBDieuadQxAPfWjamKDQr98rz0Mk6vApArOeIjYmtFfOir0WApIfYh7YkqduKhgfar
 idBFHL/hlaSfeIIRKSmXBHe+yTR6RoV8rsa4sH1CXVme+q1142dFTXc3KglRPg3VnnoxfZVuMgo
 OYoTsh3WQK3rGC1AQq8eUSipMHVpvsHrC8FlNnFJgGA/E7/DZy7b9rH05vPrSxK4+3T7dMFWAX2
 5McKCFyk88B83V6PYnA3jqoHrOHBliGoMEWPCgxSrpCfEgAdU1Tdlom3+OmvDzKE3RIcJ4kuHy+
 +kDwLaasrf4+XxvvxeZutUmRvoQzDZaP8KzizhaMAGHlTw2HqHboY0PxntNvKGnMlIo3Ho6Js70
 P/fGRdoqy56tKZ1nGLESShttt+92GoDP5yN2I/OuYs7FXjR5x8iA7tzLXG3kE00KzJHNZdtGqW2
 VFUYOY1d9wiD93IVKFt04geKa7CHw7rSqSBw2S6JxG9+qURN8gpNtb0MSPh9LQ54WEOseAcEj7g
 lcol44CmzZr9UnANj0BEec018I=
X-Received: by 2002:a05:7300:571e:b0:2c4:4276:709f with SMTP id
 5a478bee46e88-2cbf9afdabfmr4594191eec.1.1775374166740; 
 Sun, 05 Apr 2026 00:29:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:25 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 01/10] vfio/pci: Use the write side of EventNotifier for
 IRQ signaling
Date: Sun,  5 Apr 2026 00:28:45 -0700
Message-ID: <20260405072857.66484-2-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

When passing an fd to a vfio-user server for interrupt signaling, the
write side of the EventNotifier must be used. For eventfd-backed
notifiers the read and write descriptors are the same, so the existing
kernel VFIO path is unchanged. However, on hosts that emulate
EventNotifier with a pipe pair (e.g. macOS), event_notifier_get_fd()
returns the read side, which the vfio-user server cannot write to.

Introduce vfio_irq_signal_fd() which returns event_notifier_get_wfd()
and use it at every site in vfio/pci that hands an fd to
vfio_device_irq_set_signaling() or the bulk IRQ path. The
qemu_set_fd_handler() calls continue to use the read fd as before.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio/pci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1945751ffd..ee1a42e7e0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -80,6 +80,17 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     return true;
 }
 
+/*
+ * Return the fd that the vfio kernel driver or vfio-user server should
+ * write to in order to signal an interrupt.  For eventfd-backed notifiers
+ * this is the same descriptor QEMU reads, but on hosts that emulate
+ * EventNotifier with a pipe pair the write side must be used instead.
+ */
+static int vfio_irq_signal_fd(EventNotifier *e)
+{
+    return event_notifier_get_wfd(e);
+}
+
 static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
                                   const char *name, int nr)
 {
@@ -378,7 +389,9 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+                                VFIO_IRQ_SET_ACTION_TRIGGER,
+                                vfio_irq_signal_fd(&vdev->intx.interrupt),
+                                errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
         return false;
@@ -548,9 +561,9 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         if (vdev->msi_vectors[i].use) {
             if (vdev->msi_vectors[i].virq < 0 ||
                 (msix && msix_is_masked(pdev, i))) {
-                fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
+                fd = vfio_irq_signal_fd(&vdev->msi_vectors[i].interrupt);
             } else {
-                fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
+                fd = vfio_irq_signal_fd(&vdev->msi_vectors[i].kvm_interrupt);
             }
         }
 
@@ -628,9 +641,9 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
     int32_t fd;
 
     if (vector->virq >= 0) {
-        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+        fd = vfio_irq_signal_fd(&vector->kvm_interrupt);
     } else {
-        fd = event_notifier_get_fd(&vector->interrupt);
+        fd = vfio_irq_signal_fd(&vector->interrupt);
     }
 
     if (!vfio_device_irq_set_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
@@ -770,7 +783,7 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
      * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
      */
     if (vector->virq >= 0) {
-        int32_t fd = event_notifier_get_fd(&vector->interrupt);
+        int32_t fd = vfio_irq_signal_fd(&vector->interrupt);
         Error *err = NULL;
 
         if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
@@ -3181,7 +3194,9 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
     }
 
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
-                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+                                       VFIO_IRQ_SET_ACTION_TRIGGER,
+                                       vfio_irq_signal_fd(&vdev->err_notifier),
+                                       &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
@@ -3254,7 +3269,9 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
     }
 
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
-                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+                                       VFIO_IRQ_SET_ACTION_TRIGGER,
+                                       vfio_irq_signal_fd(&vdev->req_notifier),
+                                       &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
-- 
2.50.1 (Apple Git-155)


