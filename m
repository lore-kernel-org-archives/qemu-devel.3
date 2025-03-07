Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6E1C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3u-0004Ft-HE; Fri, 07 Mar 2025 13:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3m-00047k-4G
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3j-0002FR-QJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390f69f8083so1829250f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370670; x=1741975470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgqJlQXPaNCurtKb37o64LFzMpOza3vmaLhco3Sgch0=;
 b=rPeIhdYTUtupcpshUxhysVrJVQ+V76TMO64qM7dZw4WaOEGyx5Wn8QYsAHx+g1ovwV
 nYFKm/8/3NdnLLKC1gi3aA5uh6+dO0S2o3bv6yPVYa32HnMDTm0EeddIiu3LPvRUJsJz
 k4qkg4kVrjA8KMCGkxi+5k30mk09MUhfXPxRnaXNo0xGXQKCNAEpaxc1eYSkX3kEmKwS
 qfjXpkpEX1JdatQorUFbBkl+eeOa490WmsvhSWGaIcJNxF376/Uqq+HP64dkDJ75+eO+
 se0G/IlUjPVHElz3vbXvo34hiQYSB8xlFz6aBZh7iSLGDFh4AY6dPjmkH1j+J+01YC+1
 jKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370670; x=1741975470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgqJlQXPaNCurtKb37o64LFzMpOza3vmaLhco3Sgch0=;
 b=L3Ksdrg4b0hRPERZzrjrkeep3jPwyrfR1yoHvh0sNn63kpJqoNyOjsX738yreRxDwf
 NM4BOxqIDjqv5DU7qsNdlfIc/BwK5GRDsKB/t+ycOR36GuSzwqp0DGoBYJ87P50j9h6H
 VGrYGyYrwzcM4u1Nlv8D3UUKuUh//MujARmyIaxDR6TBrVcMd7zx/p+/wFZK6urX+43y
 rKwdqyPSuzLdF8qX4+PleDuyn2YSuxGl5sS9/EXrPN/OgCFizk1XqkzG/7j5WznFnVzy
 IyCDOqLZ3A14X2cUsCiwHW0WNVE1BA94yKZdvBRUP1xlfBoZ5Hl3yhvl+Ku0gqHb7AaV
 Ue8Q==
X-Gm-Message-State: AOJu0Yw78qelfpRdkZfjki19jpMX9G1ChMClXXJrmtSQa8XIPOrp3+X6
 Wxu9xo/1F8zG7jk8APFcF4n0f9acMKzcsG6dTuhCMYv9ArSFNWzS/fsIcq88ocVbgFCM0OmcCWn
 GUeM=
X-Gm-Gg: ASbGncvDMJlgSpwHJ2WTz3y+mCBl/A8Jgv+Jv9DUzvAcrcmZhhQmZoJOAE+wMk6NTZz
 yOQfTMM/4KkU857atGXbF96p/9RzPVSbkrnls88sBMsHnpGFGp0v3a0blihWUY0Nbwu/LqRRDKI
 JzsHMwXVNdDpPDUTuiUJ9wymfG6/V9hEs1UNjWQXxk2dIw5E0TN/t1X6pmWfNYEiR+jucE8GSTW
 Z6NyfLpIb0oYAKzQQ/KGjfWhvd0IBv0edWlXcY9wLnr6vdE953ExDEMxp2RGdh8qB4kHUJWbkvw
 3ejAM2bL1kvgETZ+1dhnd728bqyt8EcLvlAJRzdM8fpu4BHgA3WqTCg/GUnwBJ5do0Pif1F3IO0
 Bde7Po23Xe68Qpd21DrE=
X-Google-Smtp-Source: AGHT+IG86wo6VjNTiB+dsP2CrUpAEcNOBKsuaBqrTPoI1r5vkBrwnV0jTDl16znAZrCu0SDGfxgSlA==
X-Received: by 2002:a5d:64a4:0:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-39132d45d52mr2858940f8f.27.1741370669687; 
 Fri, 07 Mar 2025 10:04:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015a29sm5961965f8f.42.2025.03.07.10.04.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 09/14] hw/vfio/pci: Convert CONFIG_KVM check to runtime one
Date: Fri,  7 Mar 2025 19:03:32 +0100
Message-ID: <20250307180337.14811-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


