Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCACD58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fao-0001kn-2m; Sun, 15 Mar 2026 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fal-0001jN-29
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:51 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1faj-0000d1-CX
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:50 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-359f35dfef6so1879021a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558528; x=1774163328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=pjIyScWprMV9V3SyefwdoZk1u+dMQPMD+LW6o6U9tBLBPcNmKtRTx1Re/2KEiPQB6k
 RqTftvhhc0yVxOyD9Pk1EeQoKUP62Eau2rFk3n3DnXYDCsktGlBiKNLmU2G5+jFVjZtN
 S3jLP/aULnLdmVM8GwMoSXZXbCv/2FYoEfL8R6M6oHEDrpAifr1CuVGv+6QU/TjenJlY
 8sCbuOvZJ2a4ZGD+vQog9Db3G+2Iu3MiCMB7dgk1Pczif/OwVwCn8qccgCJsh3ElJqIh
 e4bFJmLHLSbfXbdY1sCe5Zss9Vhbun+KMSoKSHxXPHe4A0DVHD+wUZF4YKVbwzrQ7w7e
 NY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558528; x=1774163328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdPki2OUDvv7GbdAB4TVVTocQqYHi/i0OX7XXacQtPQ=;
 b=Vrb8bLGFHPQTpUCcp+c5EqeaGR7btYd0gbWhizEGACh9YEv5ooRBp9QOOBSw/hSQFm
 6lWGlUrOp7Vi7BitbWQ0gXCNMmqZhGwAtXyfw+ZD4iUG1cav2XeD+7mWaOSPc0epbQ+L
 3C5oJ/mNsiRSzw/R2KCNiPHCvuqtlxJ32KEjAgYgID2TYNJW486578fWUVoFjdT9sgM4
 6VFXx8a9wJ+XpxpO6k2WFq3f34BEOLuMwT8/GS/uor0OEhQ6ZIYBanYl3wK8qMExU+Um
 OkZsstggUWhcC0Hpx3nzNbNNUhPq/jAboawJsZjLTieC3+kAR3+E63VpXEnz2C+4jmoZ
 1tiw==
X-Gm-Message-State: AOJu0YxyLoJzL6alro1iNxoKbYUjljPUGGWOQNkKKhhCKxvobFKCyksE
 EtvO9YpuMvzo4gGfqzcGAi5XVu2Z5AdL2MZclBK094RSpT5EjJCjob2RaA1pAke9g02buPQgDjT
 5XSxLB4c=
X-Gm-Gg: ATEYQzzdFduSqwehAoOIcrzUaasR+9PNad4WD/yxjXtgq85RR1memkEhiMjADWiJkai
 3bl1NV0erNm58SdtlhD3TTkLNlb+TuQbZP5mBTzSJzkl4inO/UoLL4FAvvPGg6wQtUyQXdNAsWJ
 ZhKukTcrOjpYK7ZHVPXci2yQ4J2V+QLwV6dnsOtlOWmSRBuvo8g4x1GFeMpszv/BjLGhTnViIUq
 W6fa2I24O7rkC8FepMDHE1LaCIx9+tXdPGzEsAkzxV4ywalXbXIcsVq7Wsahtzt4jLUjI0793WL
 IDOhYhZ0XiRyBtAWPXnjM+Y/ONjku0u6/eUvDs9hxVX4FU4FlGv7rrYqgqAeYCef8cZr3GP08hF
 upJjo9+lGK4Ymi9NkDsFMccfePmnzuUskKgX14BH2Zzoi/IvzcFn0z0OWBghIKVoqylZDlm07rz
 k/+QdYxtgUHDvF6uS01I1CMC5pFqSestyyGgUZLoxOeVuHscs9biLcAX1PHY6VPkyB3cNbXrO75
 64=
X-Received: by 2002:a17:90a:e7d1:b0:359:fecd:1cd3 with SMTP id
 98e67ed59e1d1-35a2205551fmr7546004a91.23.1773558527895; 
 Sun, 15 Mar 2026 00:08:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
Date: Sun, 15 Mar 2026 00:08:31 -0700
Message-ID: <20260315070834.198331-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We just need to add kvm_enabled() guard when calling concerned
functions, but no need to extract those kvm functions since they are not
using any kvm specific types that would not be visible at compilation
time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/pci.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index df617f1fe46..811e5001de5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -152,7 +152,6 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
@@ -206,14 +205,10 @@ fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     return false;
-#else
-    return true;
-#endif
 }
 
 static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
@@ -236,14 +231,10 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.kvm_accel = true;
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
     return true;
-#else
-    return true;
-#endif
 }
 
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.kvm_accel) {
@@ -277,7 +268,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
-#endif
 }
 
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
@@ -287,7 +277,9 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     trace_vfio_intx_update(vdev->vbasedev.name,
                            vdev->intx.route.irq, route->irq);
 
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
 
     vdev->intx.route = *route;
 
@@ -295,7 +287,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -350,16 +342,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(pdev->config, pin);
 
-#ifdef CONFIG_KVM
     /*
      * Only conditional to avoid generating error messages on platforms
      * where we won't actually use the result anyway.
      */
-    if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
+    if (kvm_enabled() && kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
         vdev->intx.route = pci_device_route_intx_to_irq(pdev,
                                                         vdev->intx.pin);
     }
-#endif
 
     if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
                             errp)) {
@@ -370,7 +360,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
 
     if (cpr_is_incoming()) {
-        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
+        if (kvm_enabled() && !vfio_cpr_intx_enable_kvm(vdev, &err)) {
             warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         }
         goto skip_signaling;
@@ -383,7 +373,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -400,7 +390,9 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
     int fd;
 
     timer_del(vdev->intx.mmap_timer);
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(pdev);
-- 
2.47.3


