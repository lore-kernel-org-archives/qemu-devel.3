Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D88ED111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObt4-0005VX-9Z; Thu, 27 Nov 2025 08:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr6-0002k2-P2
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr0-0001J8-Vt
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osLpdyomL1kLDOW62zjri3pzkHGpZdG1pApBmgLdITo=;
 b=aYx3II8wKG7P5pb/YIBrVc6Kfv8swy6fwq4cdrbeMdAl4paFN4UzZH2DxsuMLM2qaVw3v8
 m1javGFMjesSgaTp7Q82FvX0REPj67Rdp4zpYZ4hpos61Pr4x8U8bTxyZ3jeb5n1kq11ri
 2HISRicNU1CkDC58g0zZhZbbsNvbnyk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-1znOJPIDNN-GPHfoZlAcnw-1; Thu, 27 Nov 2025 08:16:07 -0500
X-MC-Unique: 1znOJPIDNN-GPHfoZlAcnw-1
X-Mimecast-MFC-AGG-ID: 1znOJPIDNN-GPHfoZlAcnw_1764249367
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b70b974b818so77265666b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249366; x=1764854166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=osLpdyomL1kLDOW62zjri3pzkHGpZdG1pApBmgLdITo=;
 b=JXw6Bs+sIG+59d78eyeyFoM/DzwCZ8KabfwF+Wn0fIJ3NL3WSoblonqC46yrs4WWZj
 tWJ4pj/E56B6Z7Ow6iBfAJi8XSdBzXAoqP5pKL1WHdlGaA+bLMqmXn3nkCbC4PumOQOw
 Xo6Nk2hEyiAeyDr9OZdamjZdQTI8cejF4v+t/wCGMbV/FljE6KQkRbfQEzUK+2Zg929l
 fKQ1C6nK6AVE6jiEtejIavE/HkPA17yDn9R5JUIRpWyIRH827n0i0F/tTSF4bLGiEfWE
 /EsUwSCGGjA4TKWMOzbYVWW28rxfLGQo3iYRWhfFqIBNu7jkaBeXz0+sw7XrlSxvNC5E
 jXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249366; x=1764854166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=osLpdyomL1kLDOW62zjri3pzkHGpZdG1pApBmgLdITo=;
 b=eNQx5unadG00uOutZDDq5aKdVz2TvfWHIEaJpu8m+gEP4BmQBDZj666HK0dgtKmI2k
 pQTSIw03svOK2+SUI/kmA9THt1GICTssiuS5SWwfSQeBuxk0ZMOtDHDWne8jWsuHMld9
 tzJoRuS7rRxCcVaPVUI81XIDpCIJI7P4qm+w8IJZNXYBspkmCWO76cmDx0KdkXSPLvr2
 TdtsrN2Ay1qk4n0ycqaAdoiCXCKt8DDmBC4abTmbfO8Q7trNcPIoGCdQ8L8yXgq3Otso
 gfBauPMurlzRXVj2io2pONw7tjsxx3U/byVNJELTEEOnPwl94w4rzmv287rhXsYICm6v
 hdrA==
X-Gm-Message-State: AOJu0YxLz29aKM1/m2QYWdbRbPbXteG13javE3JTyMCMhVcWIkvnhUZT
 PMuePYuwK3gjoGb4gFemmUsnDbXZeQ+wNKCBgqgikoVLDLKCkZfdJHMCuwl5j806/ue3iovyemL
 BDjOgiXOxP5F2/6wxbhY0lxYcEElAeMGYKTkGew+R+YVWZY5dXDgTYlUafjDNlzJRx2HG9S1Y6n
 3IeJwXdw1m31Hi1+q9TXCV8QhYfEBHb5/vUeccHzmC
X-Gm-Gg: ASbGnct9QHB6JQknGmGA1Xj4eRDrbbapIhGW9Ei6X7yqzCbyt3bJOVJz5/bJN6P0AjT
 tp8iPaTj63SueKRjt0VcNKocf1sv4IYngG5xSlwXxADXiju/PFN71TLj0ghto41SPFN2wfX5arN
 JwSfMKgGXAnHXvR1FVrS1BpediTG4hzLmEbKWRO3M0f/q9kdfTkuh19+jyN6GpuYMddJoUZM1CK
 WN1BHcP15laPZUskkTOlRYVdTB4DMoLh+lB4LDKOLg4GibthgsOE+q2rmitMG1HC9hWysL9pR/C
 8Q1lOK+3iOZfHcCVY6QPYU2hmQi2mJ6RgMC4T7rmg0/urVS6TLKpnokYQoUHc/guarI1Y9Wnosi
 yjobt3TF2GBcmwRpVdJKpsrWESO3HpZG26iSLX8cjlTU5zxuuuDUYezTPOVvo7GFv4yx54ar5UO
 qPobzZ7QLJvD5qsD0=
X-Received: by 2002:a17:907:968c:b0:b3c:8940:6239 with SMTP id
 a640c23a62f3a-b7671b12672mr2645651166b.52.1764249365801; 
 Thu, 27 Nov 2025 05:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxnjLD2zswcEFH6KoF41qgXdt7eW78+4OGnrKgPy2H2fDIuCMJXXwa3ogW1DOMlNIEOQ3DGw==
X-Received: by 2002:a17:907:968c:b0:b3c:8940:6239 with SMTP id
 a640c23a62f3a-b7671b12672mr2645643766b.52.1764249365027; 
 Thu, 27 Nov 2025 05:16:05 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51721b6sm162860566b.5.2025.11.27.05.16.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:16:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/28] include: move hw/hw.h to hw/core/, rename
Date: Thu, 27 Nov 2025 14:15:14 +0100
Message-ID: <20251127131516.80807-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Call it include/hw/core/hw-error.h since that is the only
thing it contains.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{hw.h => core/hw-error.h} |  0
 hw/arm/integratorcp.c                |  2 +-
 hw/arm/omap1.c                       |  2 +-
 hw/arm/xen-stubs.c                   |  2 +-
 hw/audio/lm4549.c                    |  2 +-
 hw/core/loader.c                     |  2 +-
 hw/display/bcm2835_fb.c              |  2 +-
 hw/display/exynos4210_fimd.c         |  2 +-
 hw/display/g364fb.c                  |  2 +-
 hw/dma/pl080.c                       |  2 +-
 hw/dma/xilinx_axidma.c               |  2 +-
 hw/i386/xen/xen-hvm.c                |  2 +-
 hw/intc/exynos4210_combiner.c        |  2 +-
 hw/misc/omap_clk.c                   |  2 +-
 hw/net/e1000e.c                      |  2 +-
 hw/net/igb.c                         |  2 +-
 hw/net/igbvf.c                       |  2 +-
 hw/net/vmxnet3.c                     |  2 +-
 hw/net/xilinx_axienet.c              |  2 +-
 hw/ppc/ppce500_spin.c                |  2 +-
 hw/timer/a9gtimer.c                  |  2 +-
 hw/timer/arm_mptimer.c               |  2 +-
 hw/vfio/device.c                     |  2 +-
 hw/vfio/helpers.c                    |  2 +-
 hw/vfio/igd.c                        |  2 +-
 hw/vfio/listener.c                   |  2 +-
 hw/vfio/migration.c                  |  2 +-
 hw/vfio/pci.c                        |  2 +-
 hw/vfio/region.c                     |  2 +-
 hw/vfio/spapr.c                      |  2 +-
 hw/xen/xen-hvm-common.c              |  2 +-
 system/cpus.c                        |  2 +-
 target/ppc/kvm.c                     |  2 +-
 target/ppc/mmu-hash64.c              |  2 +-
 target/s390x/mmu_helper.c            |  2 +-
 scripts/analyze-inclusions           | 10 +++++-----
 36 files changed, 39 insertions(+), 39 deletions(-)
 rename include/hw/{hw.h => core/hw-error.h} (100%)

diff --git a/include/hw/hw.h b/include/hw/core/hw-error.h
similarity index 100%
rename from include/hw/hw.h
rename to include/hw/core/hw-error.h
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 118808f2dc7..0bf519b6bb8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -23,7 +23,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index f3d6be1e295..f5ff4b107ae 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
index 6a830435533..00bc310252f 100644
--- a/hw/arm/xen-stubs.c
+++ b/hw/arm/xen-stubs.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-migration.h"
 #include "system/xen.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/arch_hvm.h"
 
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index bf711c49c04..f85226d1ac5 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "qemu/log.h"
 #include "qemu/audio.h"
 #include "lm4549.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 40cb187a113..8252616fdd3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -50,7 +50,7 @@
 #include "qapi/type-helpers.h"
 #include "qemu/units.h"
 #include "trace.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "disas/disas.h"
 #include "migration/cpr.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 8eec0dc600b..75d7c0f8499 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/display/bcm2835_fb.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "ui/console.h"
 #include "framebuffer.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 7f841b88047..a97054132fb 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 2eefafcaf67..50952e9934b 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 514206b7c31..3f8acb03deb 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -13,7 +13,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 8488f125b5f..22dec8b3eb2 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -26,7 +26,7 @@
 #include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 591da26d453..a6e1683885a 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -15,7 +15,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "trace.h"
 
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/i386/pc.h"
 #include "hw/core/irq.h"
 #include "hw/i386/apic-msidef.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index ec935a084db..e8cac331e4c 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -33,7 +33,7 @@
 #include "qemu/module.h"
 #include "hw/intc/exynos4210_combiner.h"
 #include "hw/arm/exynos4210.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index 37afef09903..e927ef22a09 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/arm/omap.h"
 
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 3d4683370c6..9faf0c74c3d 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -41,7 +41,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "system/system.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/net/mii.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/net/igb.c b/hw/net/igb.c
index d39eba9f64d..c076807e711 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -45,7 +45,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "system/system.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/net/mii.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 9b0db8f8411..48d56e43aca 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -38,7 +38,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/net/mii.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index bae3a44cb0c..97156dd33b9 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
 #include "net/tap.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 29c09b88ebf..d85f8bb23fe 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index a066ada77ed..85bdcac43a1 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/sysbus.h"
 #include "system/hw_accel.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index a2363a89a5f..3a086915c81 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/timer/a9gtimer.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 869db913d40..88158144b23 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 76869828fc8..19d1236ed75 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,7 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 23d13e5db5f..2cbc7b4964f 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -24,7 +24,7 @@
 
 #include "system/kvm.h"
 #include "hw/vfio/vfio-device.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "qapi/error.h"
 #include "vfio-helpers.h"
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index cff413c16f5..6aacf27284f 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/core/boards.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "pci-quirks.h"
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2d7d3a46457..7af01075359 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -30,7 +30,7 @@
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 4c06e3db936..fde343f06e3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -30,7 +30,7 @@
 #include "exec/ramlist.h"
 #include "pci.h"
 #include "trace.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "vfio-migration-internal.h"
 
 /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a0a66b105aa..c7344727214 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -23,7 +23,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index b165ab0b937..ca75ab1be4d 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -23,7 +23,7 @@
 
 #include "hw/vfio/vfio-region.h"
 #include "hw/vfio/vfio-device.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 0f23681a3f9..a9f093c3570 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,7 +16,7 @@
 #include "system/address-spaces.h"
 
 #include "hw/vfio/vfio-container-legacy.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 5d11b50db9c..59c73dfaeb5 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -7,7 +7,7 @@
 #include "exec/target_page.h"
 #include "trace.h"
 
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/pci/pci_host.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen-bus.h"
diff --git a/system/cpus.c b/system/cpus.c
index a0e1debfea8..49deeb9468a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -45,7 +45,7 @@
 #include "system/cpu-timers.h"
 #include "system/whpx.h"
 #include "hw/core/boards.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "trace.h"
 
 #ifdef CONFIG_LINUX
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 43124bf1c78..2c96eca584e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -34,7 +34,7 @@
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/ppc/ppc.h"
 #include "migration/qemu-file-types.h"
 #include "system/watchdog.h"
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index dd337558aa6..d026abadd11 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -28,7 +28,7 @@
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
 #include "exec/log.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "internal.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-books.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 7a7b3810590..7063f1a905f 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -26,7 +26,7 @@
 #include "system/memory.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "hw/hw.h"
+#include "hw/core/hw-error.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/core/boards.h"
 
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index d2c566667df..50a7d95d9e7 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -46,7 +46,7 @@ grep_include() {
 }
 
 echo Found $(find . -name "*.d" | wc -l) object files
-echo $(grep_include -F 'hw/hw.h') files include hw/hw.h
+echo $(grep_include -F 'hw/core/hw-error.h') files include hw/core/hw-error.h
 echo $(grep_include 'target/[a-z0-9]*/cpu\.h') files include cpu.h
 echo $(grep_include -F 'qapi-types.h') files include qapi-types.h
 echo $(grep_include -F 'trace/generated-tracers.h') files include generated-tracers.h
@@ -85,8 +85,8 @@ analyze() {
 echo osdep.h:
 analyze ../include/qemu/osdep.h
 
-echo hw/hw.h:
-analyze -include ../include/qemu/osdep.h ../include/hw/hw.h
+echo hw/core/hw-error.h:
+analyze -include ../include/qemu/osdep.h ../include/hw/core/hw-error.h
 
 echo trace/generated-tracers.h:
 analyze -include ../include/qemu/osdep.h trace/generated-tracers.h
@@ -94,5 +94,5 @@ analyze -include ../include/qemu/osdep.h trace/generated-tracers.h
 echo target/i386/cpu.h:
 analyze -DCOMPILING_PER_TARGET -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target/i386/cpu.h
 
-echo hw/hw.h + COMPILING_PER_TARGET:
-analyze -DCOMPILING_PER_TARGET -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
+echo hw/core/hw-error.h + COMPILING_PER_TARGET:
+analyze -DCOMPILING_PER_TARGET -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/core/hw-error.h
-- 
2.51.1


