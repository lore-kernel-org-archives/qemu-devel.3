Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD36C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3JF-0005Z0-By; Sat, 08 Mar 2025 18:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JC-0005Rn-R1
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3J9-0001QS-V0
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so26055325e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475414; x=1742080214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEvdVMyvXjdezRQS+46yXb37w36/326vMxQlDhu7A50=;
 b=Bh6xbQk1zoJDHOgVuciI18zYZE3pJ4JkZlC3WxJ8hIKogV6NL21g6BtrWDJbnx+AZj
 q6P9h6v1R6REMpbIfV5EClsQTc3dTymlVyFr2+rEEZX2UO9GjUIUGqg+uKkdOg0+R4s3
 25bMgcNIMO/WjLG8/Vv5FE1/QhCY5yArP6yM9y0+o67kpc/qP/+KWTWb7MrcEoem24Xa
 EHCbmYFUoZFtyj/ujq/GHamzwYJAWIG0QUMeAWUet9jReD/CCNVFE+ADE0nqElUN4c4G
 KjSIqB5GZWDsaVRxjaDBodeykohUXFOrr+B5tt935typSxFOLQBBHcqVifKYdY3AkZVE
 d0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475414; x=1742080214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEvdVMyvXjdezRQS+46yXb37w36/326vMxQlDhu7A50=;
 b=pnu86qXnSbD9Za7BbjStygrP1cg8QsB08Qi0FR7QUKyF54hLQq9NT4WdG+Jm/4fG2k
 dKtRGd3ndQ+7mcO974IxXbHdBV1sZVA1FSitoQCkjzKAXK2gEba4fpM741v/tmERiypI
 XSKw3o3YSEGH+RlXzgnHrNPSEwYX8yE5MT0IFjYBrOYp2Kqg5nvPJgZQmub1luOkbjUL
 sZQbrnryFJFYuuO44VuQWudyfhXZuRK+uaL5c9HW1e6oK1LngwKUFTkWaiwPEmIELRjq
 SYKUH4EGF//N90fZSjTys/V1QoNY6olbMyFdKoB3PJD1LZkPMa7N4dCE1aXYju93kNtZ
 NHNA==
X-Gm-Message-State: AOJu0YzqlC4NPOtKfpFOIv78i8/Y/yqcye4EuZox2mJnywNc+xA6nBK9
 0JoTEEopjULCKlcDnN/LXBd26nbCSe4VL1NlHe73pFWGWfobuQsPJ2Aa3IXJTUmAvT52+K9ko/D
 mN8g=
X-Gm-Gg: ASbGnctw2ChRskgo9X+rEbVcl5EQout/jBpyKpVZMHNkMd1xKm/uLm43tfP5AKk3tgj
 s7abEIoGR2d7UDIvBAUY+hcOfsW/OC0uGmEtXKU0s5qdHrXNdqm3G9Z4vKoizNZhFgS78wFLp1H
 FQIrcibE33pCzN/XNcxlfE3anmrKQb+8xzsfOkzf1gT5LExO0pIPIblkTy+UMfjJu4FElquQ7CI
 +wYoz3ulxtUAg7yqQe9bAi8gu1+GdJIsWB8VNy6zeW3dFLfQNZYFvexxqyZ8frm/g4b/dL1KMft
 M4TydyKjqB2fS2Avo8TdNh0UCSB8LaONcltiSBswEFhdtBacKBK5r8tyDhhGWLV8FkRW8ayL5pQ
 PSBasEYSd8nHRnAagO9w=
X-Google-Smtp-Source: AGHT+IHU+xQMgt3dsdiNnJgEOhNSs6YqxwcUDocahOsxR/CmDr32kZwcNq5kvICgYKsd1qnYF/NWOQ==
X-Received: by 2002:a05:600c:35d1:b0:439:967b:46fc with SMTP id
 5b1f17b1804b1-43c601d9167mr53509045e9.8.1741475414122; 
 Sat, 08 Mar 2025 15:10:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ceef2fb8dsm14915575e9.18.2025.03.08.15.10.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/21] hw/vfio/pci: Convert CONFIG_KVM check to runtime one
Date: Sun,  9 Mar 2025 00:09:05 +0100
Message-ID: <20250308230917.18907-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the runtime kvm_enabled() helper to check whether
KVM is available or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fdbc15885d4..9872884ff8a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -118,8 +118,13 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
-    int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
+    int irq_fd;
+
+    if (!kvm_enabled()) {
+        return true;
+    }
+
+    irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
@@ -171,16 +176,13 @@ fail_irqfd:
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+
     return false;
-#else
-    return true;
-#endif
 }
 
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
-#ifdef CONFIG_KVM
-    if (!vdev->intx.kvm_accel) {
+    if (!kvm_enabled() || !vdev->intx.kvm_accel) {
         return;
     }
 
@@ -211,7 +213,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
-#endif
 }
 
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
@@ -278,7 +279,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(vdev->pdev.config, pin);
 
-#ifdef CONFIG_KVM
     /*
      * Only conditional to avoid generating error messages on platforms
      * where we won't actually use the result anyway.
@@ -287,7 +287,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         vdev->intx.route = pci_device_route_intx_to_irq(&vdev->pdev,
                                                         vdev->intx.pin);
     }
-#endif
 
     ret = event_notifier_init(&vdev->intx.interrupt, 0);
     if (ret) {
-- 
2.47.1


