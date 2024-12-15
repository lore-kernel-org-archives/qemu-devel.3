Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D6E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx7-0002DI-2A; Sun, 15 Dec 2024 14:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwg-0001VT-I3
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwd-0001E7-Ce
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:26 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f2e31139d9so1484450eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289581; x=1734894381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfCF1LRxG493UFC81jH6VdLMnVW4fkTSqxZcidADjdE=;
 b=TVAhGUxlcLAPQs6BjCxZiqj78MYs1RZ8kkvwUiXqFgeLJNY0XZp9PaR0pR9gmVfunB
 paEWGE14SSG5LAvDef8GW8gcshnPRwam+l/eMuyWYaRN976tkUWB13eMHKG+Cr7WwMFP
 zJ2lzPAva7fV/PlnHNE4AVsi7MrgyX+o/j0oiqpW/Nz4S5st5qof+a4jmjtUX62KudcB
 eqD7w7N2buLrePOmG+mjg/RPrMygSAjRL76sILATdUnat/7wjjzHYjt1fM1avB4qWaYO
 jCGwDlUkolGMWSW44oq80FZzF3jS/bCLUkmra620RgBxMtHLVcUWoOpV4PBopg8nT2JF
 l0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289581; x=1734894381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfCF1LRxG493UFC81jH6VdLMnVW4fkTSqxZcidADjdE=;
 b=ljYRoonqkFz2rvkp2Gro8bmi0bqQSkvZuHVbZJkrzEyPKYB9h8dCIn43S/CqQdy195
 KRQJOWk+PH9BtOG6ntKlbVvu+n8UBvjpPbP9idRmax112iiSGk/2bTmGKGZutscFG7xV
 l31EG5E3qZIuJzlpQTXUggaU5gdDFQSMvkuYXibvNsQYt/A6ewIFiR4Yl1ROsgEv6a91
 IwF6nwDsZgyc+Z75YF1GevxtvRHS0bev0M26DPVxixep86zaVZRnu/fyum75Si3snnZA
 Bid6b04F8dBe8Q/O+mb/uajKvHJYtbvsy50IQqUxxOssZPMkmtZDk8UAbjv0g5phXfED
 gT8A==
X-Gm-Message-State: AOJu0YxmR2Bf6aa87UuGLWJOtOHFkl/lmp7+OfiUGQ4aoUYeNG58kKj2
 kD2Ax1MOulpCvroWFkV0xDF25bqCUF+qwVtIwKOq2R8ToJm8nyKCWTzJfqJK12a2Z+YWm/zBNft
 rWjybj7JI
X-Gm-Gg: ASbGncvXZomZ0AnUsbBeDUpgu6yhPCWsIIWX8h9fi9cRugMGwvcQLrcbPN+mF+i64x4
 XtAnl5GMu/u6UCvjBTEuRm0F9eDNM1Y1VNGWjbtG1Vom0f+uhEfl7Y7tbBrLrBG/wXTE1TY/76d
 sKqAOPehNjp+sqFbKm9fEkH+dxA8dzdhb9+zHgx9xUAH8qgrnRO8So3etBLAC4H3CHkYxMzAWJb
 hAzGEEUiiqxXML0/MxDukqJP6BIPXIte8iy9xSm7j32ETqD0FVYh48YyyKZr8rBeNZX0CwARYvW
 I4Dpbc3rqXHs10EchZxIOdE9VOPaVSyjubh27gBLqNo=
X-Google-Smtp-Source: AGHT+IHVt/D3+fIZ08CiOej+hh0jYM/aunqZ70iYggjnAHdLLrtqUPSvBnFU7fyefTQDZCC+B3l6hQ==
X-Received: by 2002:a05:6870:2199:b0:29e:2d50:11aa with SMTP id
 586e51a60fabf-2a3ac5dae51mr5760715fac.18.1734289581564; 
 Sun, 15 Dec 2024 11:06:21 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/67] hw/intc: Constify all Property
Date: Sun, 15 Dec 2024 13:04:57 -0600
Message-ID: <20241215190533.3222854-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/apic_common.c         | 2 +-
 hw/intc/arm_gic_common.c      | 2 +-
 hw/intc/arm_gicv2m.c          | 2 +-
 hw/intc/arm_gicv3_common.c    | 2 +-
 hw/intc/arm_gicv3_its.c       | 2 +-
 hw/intc/arm_gicv3_its_kvm.c   | 2 +-
 hw/intc/armv7m_nvic.c         | 2 +-
 hw/intc/exynos4210_combiner.c | 2 +-
 hw/intc/exynos4210_gic.c      | 2 +-
 hw/intc/goldfish_pic.c        | 2 +-
 hw/intc/grlib_irqmp.c         | 2 +-
 hw/intc/i8259_common.c        | 2 +-
 hw/intc/ioapic.c              | 2 +-
 hw/intc/loongarch_extioi.c    | 2 +-
 hw/intc/loongarch_pch_msi.c   | 2 +-
 hw/intc/loongarch_pch_pic.c   | 2 +-
 hw/intc/loongson_ipi_common.c | 2 +-
 hw/intc/m68k_irqc.c           | 2 +-
 hw/intc/mips_gic.c            | 2 +-
 hw/intc/omap_intc.c           | 2 +-
 hw/intc/ompic.c               | 2 +-
 hw/intc/openpic.c             | 2 +-
 hw/intc/openpic_kvm.c         | 2 +-
 hw/intc/pnv_xive.c            | 2 +-
 hw/intc/pnv_xive2.c           | 2 +-
 hw/intc/ppc-uic.c             | 2 +-
 hw/intc/riscv_aclint.c        | 4 ++--
 hw/intc/riscv_aplic.c         | 2 +-
 hw/intc/riscv_imsic.c         | 2 +-
 hw/intc/rx_icu.c              | 2 +-
 hw/intc/s390_flic.c           | 4 ++--
 hw/intc/sifive_plic.c         | 2 +-
 hw/intc/spapr_xive.c          | 2 +-
 hw/intc/xics.c                | 4 ++--
 hw/intc/xilinx_intc.c         | 2 +-
 hw/intc/xive.c                | 8 ++++----
 hw/intc/xive2.c               | 4 ++--
 hw/intc/xlnx-pmu-iomod-intc.c | 2 +-
 38 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 62f3bbf203..8be9f22de8 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -408,7 +408,7 @@ static const VMStateDescription vmstate_apic_common = {
     }
 };
 
-static Property apic_properties_common[] = {
+static const Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
                     true),
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 53fb2c4e2d..e961cd9156 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -348,7 +348,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
     }
 }
 
-static Property arm_gic_common_properties[] = {
+static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
     DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
     /* Revision can be 1 or 2 for GIC architecture specification
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index d564b857eb..ffa830b433 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -170,7 +170,7 @@ static void gicv2m_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property gicv2m_properties[] = {
+static const Property gicv2m_properties[] = {
     DEFINE_PROP_UINT32("base-spi", ARMGICv2mState, base_spi, 0),
     DEFINE_PROP_UINT32("num-spi", ARMGICv2mState, num_spi, 64),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index bd50a1b079..a8ec615a3f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -605,7 +605,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
     }
 }
 
-static Property arm_gicv3_common_properties[] = {
+static const Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICv3State, num_cpu, 1),
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
index bf31158470..f50b1814ea 100644
--- a/hw/intc/arm_gicv3_its.c
+++ b/hw/intc/arm_gicv3_its.c
@@ -2002,7 +2002,7 @@ static void gicv3_its_post_load(GICv3ITSState *s)
     }
 }
 
-static Property gicv3_its_props[] = {
+static const Property gicv3_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "arm-gicv3",
                      GICv3State *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 35539c099f..68a6144add 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -234,7 +234,7 @@ static void kvm_arm_its_reset_hold(Object *obj, ResetType type)
     }
 }
 
-static Property kvm_arm_its_props[] = {
+static const Property kvm_arm_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3",
                      GICv3State *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 98f3cf59bc..6e2803b123 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2569,7 +2569,7 @@ static const VMStateDescription vmstate_nvic = {
     }
 };
 
-static Property props_nvic[] = {
+static const Property props_nvic[] = {
     /* Number of external IRQ lines (so excluding the 16 internal exceptions) */
     DEFINE_PROP_UINT32("num-irq", NVICState, num_irq, 64),
     /*
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index afecef1e15..221dfa912a 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -325,7 +325,7 @@ static void exynos4210_combiner_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property exynos4210_combiner_properties[] = {
+static const Property exynos4210_combiner_properties[] = {
     DEFINE_PROP_UINT32("external", Exynos4210CombinerState, external, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index fcca85c6c6..e1b956d990 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -111,7 +111,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->dist_container);
 }
 
-static Property exynos4210_gic_properties[] = {
+static const Property exynos4210_gic_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", Exynos4210GicState, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index 166a3cba1e..f5343c9d2f 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -181,7 +181,7 @@ static void goldfish_pic_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), goldfish_irq_request, GOLDFISH_PIC_IRQ_NB);
 }
 
-static Property goldfish_pic_properties[] = {
+static const Property goldfish_pic_properties[] = {
     DEFINE_PROP_UINT8("index", GoldfishPICState, idx, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 37ac63fd80..bf53251ea2 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -376,7 +376,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &irqmp->iomem);
 }
 
-static Property grlib_irqmp_properties[] = {
+static const Property grlib_irqmp_properties[] = {
     DEFINE_PROP_UINT32("ncpus", IRQMP, ncpus, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index d9558e3940..c3174f4fdc 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -193,7 +193,7 @@ static const VMStateDescription vmstate_pic_common = {
     }
 };
 
-static Property pic_properties_common[] = {
+static const Property pic_properties_common[] = {
     DEFINE_PROP_UINT32("iobase", PICCommonState, iobase,  -1),
     DEFINE_PROP_UINT32("elcr_addr", PICCommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", PICCommonState, elcr_mask,  -1),
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index e73c8d4f07..6d566165b0 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -476,7 +476,7 @@ static void ioapic_unrealize(DeviceState *dev)
     timer_free(s->delayed_ioapic_service_timer);
 }
 
-static Property ioapic_properties[] = {
+static const Property ioapic_properties[] = {
     DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 97d1af5ccc..dd91f89361 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -423,7 +423,7 @@ static const VMStateDescription vmstate_loongarch_extioi = {
     }
 };
 
-static Property extioi_properties[] = {
+static const Property extioi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
     DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
                     EXTIOI_HAS_VIRT_EXTENSION, 0),
diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index ecf3ed0267..e2eca30660 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -83,7 +83,7 @@ static void loongarch_pch_msi_init(Object *obj)
 
 }
 
-static Property loongarch_msi_properties[] = {
+static const Property loongarch_msi_properties[] = {
     DEFINE_PROP_UINT32("msi_irq_base", LoongArchPCHMSI, irq_base, 0),
     DEFINE_PROP_UINT32("msi_irq_num",  LoongArchPCHMSI, irq_num, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index b958180591..6a87b1aab7 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -411,7 +411,7 @@ static void loongarch_pch_pic_init(Object *obj)
 
 }
 
-static Property loongarch_pch_pic_properties[] = {
+static const Property loongarch_pch_pic_properties[] = {
     DEFINE_PROP_UINT32("pch_pic_irq_num",  LoongArchPCHPIC, irq_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index a6ce0181f6..d3f894a5bd 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -315,7 +315,7 @@ static const VMStateDescription vmstate_loongson_ipi_common = {
     }
 };
 
-static Property ipi_common_properties[] = {
+static const Property ipi_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongsonIPICommonState, num_cpu, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index b4471e185a..b5d10ab1f6 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -85,7 +85,7 @@ static const VMStateDescription vmstate_m68k_irqc = {
     }
 };
 
-static Property m68k_irqc_properties[] = {
+static const Property m68k_irqc_properties[] = {
     DEFINE_PROP_LINK("m68k-cpu", M68KIRQCState, cpu,
                      TYPE_M68K_CPU, ArchCPU *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 77ba7348a3..996db095c3 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -438,7 +438,7 @@ static void mips_gic_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property mips_gic_properties[] = {
+static const Property mips_gic_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSGICState, num_vps, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSGICState, num_irq, 256),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index a98358d92e..28606f102b 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -375,7 +375,7 @@ void omap_intc_set_fclk(OMAPIntcState *intc, omap_clk clk)
     intc->fclk = clk;
 }
 
-static Property omap_intc_properties[] = {
+static const Property omap_intc_properties[] = {
     DEFINE_PROP_UINT32("size", OMAPIntcState, size, 0x100),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 99032ea7f7..8ee1bd64bd 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -128,7 +128,7 @@ static void or1k_ompic_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property or1k_ompic_properties[] = {
+static const Property or1k_ompic_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", OR1KOMPICState, num_cpus, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 2ead4b9ba0..2257ae2ee7 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1606,7 +1606,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, openpic_set_irq, opp->max_irq);
 }
 
-static Property openpic_properties[] = {
+static const Property openpic_properties[] = {
     DEFINE_PROP_UINT32("model", OpenPICState, model, OPENPIC_MODEL_FSL_MPIC_20),
     DEFINE_PROP_UINT32("nb_cpus", OpenPICState, nb_cpus, 1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 838c6b9d99..135fe8301a 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -262,7 +262,7 @@ int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs)
                                kvm_arch_vcpu_id(cs));
 }
 
-static Property kvm_openpic_properties[] = {
+static const Property kvm_openpic_properties[] = {
     DEFINE_PROP_UINT32("model", KVMOpenPICState, model,
                        OPENPIC_MODEL_FSL_MPIC_20),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 5bacbce6a4..581659839b 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -2059,7 +2059,7 @@ static int pnv_xive_dt_xscom(PnvXScomInterface *dev, void *fdt,
     return 0;
 }
 
-static Property pnv_xive_properties[] = {
+static const Property pnv_xive_properties[] = {
     DEFINE_PROP_UINT64("ic-bar", PnvXive, ic_base, 0),
     DEFINE_PROP_UINT64("vc-bar", PnvXive, vc_base, 0),
     DEFINE_PROP_UINT64("pc-bar", PnvXive, pc_base, 0),
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 834d32287b..5dd305453a 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2354,7 +2354,7 @@ static void pnv_xive2_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(pnv_xive2_reset, dev);
 }
 
-static Property pnv_xive2_properties[] = {
+static const Property pnv_xive2_properties[] = {
     DEFINE_PROP_UINT64("ic-bar", PnvXive2, ic_base, 0),
     DEFINE_PROP_UINT64("esb-bar", PnvXive2, esb_base, 0),
     DEFINE_PROP_UINT64("end-bar", PnvXive2, end_base, 0),
diff --git a/hw/intc/ppc-uic.c b/hw/intc/ppc-uic.c
index f2a224f3aa..d683413a83 100644
--- a/hw/intc/ppc-uic.c
+++ b/hw/intc/ppc-uic.c
@@ -259,7 +259,7 @@ static void ppc_uic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, ppcuic_set_irq, UIC_MAX_IRQ);
 }
 
-static Property ppc_uic_properties[] = {
+static const Property ppc_uic_properties[] = {
     DEFINE_PROP_UINT32("dcr-base", PPCUIC, dcr_base, 0xc0),
     DEFINE_PROP_BOOL("use-vectors", PPCUIC, use_vectors, true),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e9f0536b1c..db195fb1ff 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -262,7 +262,7 @@ static const MemoryRegionOps riscv_aclint_mtimer_ops = {
     }
 };
 
-static Property riscv_aclint_mtimer_properties[] = {
+static const Property riscv_aclint_mtimer_properties[] = {
     DEFINE_PROP_UINT32("hartid-base", RISCVAclintMTimerState,
         hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", RISCVAclintMTimerState, num_harts, 1),
@@ -462,7 +462,7 @@ static const MemoryRegionOps riscv_aclint_swi_ops = {
     }
 };
 
-static Property riscv_aclint_swi_properties[] = {
+static const Property riscv_aclint_swi_properties[] = {
     DEFINE_PROP_UINT32("hartid-base", RISCVAclintSwiState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", RISCVAclintSwiState, num_harts, 1),
     DEFINE_PROP_UINT32("sswi", RISCVAclintSwiState, sswi, false),
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4a262c82f0..353eec8136 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -904,7 +904,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static Property riscv_aplic_properties[] = {
+static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_UINT32("aperture-size", RISCVAPLICState, aperture_size, 0),
     DEFINE_PROP_UINT32("hartid-base", RISCVAPLICState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", RISCVAPLICState, num_harts, 0),
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 9ef65d4012..adc36151b4 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -388,7 +388,7 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
     msi_nonbroken = true;
 }
 
-static Property riscv_imsic_properties[] = {
+static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVIMSICState, mmode, 0),
     DEFINE_PROP_UINT32("hartid", RISCVIMSICState, hartid, 0),
     DEFINE_PROP_UINT32("num-pages", RISCVIMSICState, num_pages, 0),
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index b2d4338f61..dfe11ade20 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -361,7 +361,7 @@ static const VMStateDescription vmstate_rxicu = {
     }
 };
 
-static Property rxicu_properties[] = {
+static const Property rxicu_properties[] = {
     DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
                       qdev_prop_uint8, uint8_t),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index c3d2b8d765..2963bd5bd6 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -445,7 +445,7 @@ static void qemu_s390_flic_instance_init(Object *obj)
     }
 }
 
-static Property qemu_s390_flic_properties[] = {
+static const Property qemu_s390_flic_properties[] = {
     DEFINE_PROP_BOOL("migrate-all-state", QEMUS390FLICState,
                      migrate_all_state, true),
     DEFINE_PROP_END_OF_LIST(),
@@ -471,7 +471,7 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
     fsc->inject_crw_mchk = qemu_s390_inject_crw_mchk;
 }
 
-static Property s390_flic_common_properties[] = {
+static const Property s390_flic_common_properties[] = {
     DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
                        adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
     DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index ed74490dba..49895be803 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -430,7 +430,7 @@ static const VMStateDescription vmstate_sifive_plic = {
         }
 };
 
-static Property sifive_plic_properties[] = {
+static const Property sifive_plic_properties[] = {
     DEFINE_PROP_STRING("hart-config", SiFivePLICState, hart_config),
     DEFINE_PROP_UINT32("hartid-base", SiFivePLICState, hartid_base, 0),
     /* number of interrupt sources including interrupt source 0 */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 283a6b8fd2..09f643d633 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -627,7 +627,7 @@ static void spapr_xive_free_irq(SpaprInterruptController *intc, int lisn)
     xive->eat[lisn].w &= cpu_to_be64(~EAS_VALID);
 }
 
-static Property spapr_xive_properties[] = {
+static const Property spapr_xive_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
     DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
     DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e893363dc9..81bbfdd84b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -344,7 +344,7 @@ static void icp_unrealize(DeviceState *dev)
     vmstate_unregister(NULL, &vmstate_icp_server, icp);
 }
 
-static Property icp_properties[] = {
+static const Property icp_properties[] = {
     DEFINE_PROP_LINK(ICP_PROP_XICS, ICPState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
     DEFINE_PROP_LINK(ICP_PROP_CPU, ICPState, cs, TYPE_CPU, CPUState *),
@@ -676,7 +676,7 @@ static const VMStateDescription vmstate_ics = {
     },
 };
 
-static Property ics_properties[] = {
+static const Property ics_properties[] = {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_LINK(ICS_PROP_XICS, ICSState, xics, TYPE_XICS_FABRIC,
                      XICSFabric *),
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 6e5012e66e..3e860ab582 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -176,7 +176,7 @@ static void xilinx_intc_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
 }
 
-static Property xilinx_intc_properties[] = {
+static const Property xilinx_intc_properties[] = {
     DEFINE_PROP_UINT32("kind-of-intr", XpsIntc, c_kind_of_intr, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 245e4d181a..308e5743bd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -927,7 +927,7 @@ static const VMStateDescription vmstate_xive_tctx = {
     },
 };
 
-static Property xive_tctx_properties[] = {
+static const Property xive_tctx_properties[] = {
     DEFINE_PROP_LINK("cpu", XiveTCTX, cs, TYPE_CPU, CPUState *),
     DEFINE_PROP_LINK("presenter", XiveTCTX, xptr, TYPE_XIVE_PRESENTER,
                      XivePresenter *),
@@ -1403,7 +1403,7 @@ static const VMStateDescription vmstate_xive_source = {
  * The default XIVE interrupt source setting for the ESB MMIOs is two
  * 64k pages without Store EOI, to be in sync with KVM.
  */
-static Property xive_source_properties[] = {
+static const Property xive_source_properties[] = {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
@@ -2002,7 +2002,7 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
     xive_router_end_notify_handler(xrtr, &eas);
 }
 
-static Property xive_router_properties[] = {
+static const Property xive_router_properties[] = {
     DEFINE_PROP_LINK("xive-fabric", XiveRouter, xfb,
                      TYPE_XIVE_FABRIC, XiveFabric *),
     DEFINE_PROP_END_OF_LIST(),
@@ -2170,7 +2170,7 @@ static void xive_end_source_realize(DeviceState *dev, Error **errp)
                           (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_ends);
 }
 
-static Property xive_end_source_properties[] = {
+static const Property xive_end_source_properties[] = {
     DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
     DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_LINK("xive", XiveENDSource, xrtr, TYPE_XIVE_ROUTER,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index d1df35e9b3..3233d3f14e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1028,7 +1028,7 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
                              xive_get_field64(EAS2_END_DATA,  eas.w));
 }
 
-static Property xive2_router_properties[] = {
+static const Property xive2_router_properties[] = {
     DEFINE_PROP_LINK("xive-fabric", Xive2Router, xfb,
                      TYPE_XIVE_FABRIC, XiveFabric *),
     DEFINE_PROP_END_OF_LIST(),
@@ -1242,7 +1242,7 @@ static void xive2_end_source_realize(DeviceState *dev, Error **errp)
                           (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_ends);
 }
 
-static Property xive2_end_source_properties[] = {
+static const Property xive2_end_source_properties[] = {
     DEFINE_PROP_UINT32("nr-ends", Xive2EndSource, nr_ends, 0),
     DEFINE_PROP_UINT32("shift", Xive2EndSource, esb_shift, XIVE_ESB_64K),
     DEFINE_PROP_LINK("xive", Xive2EndSource, xrtr, TYPE_XIVE2_ROUTER,
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 48cd3ae94b..21b9c83658 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -474,7 +474,7 @@ static const MemoryRegionOps xlnx_pmu_io_intc_ops = {
     },
 };
 
-static Property xlnx_pmu_io_intc_properties[] = {
+static const Property xlnx_pmu_io_intc_properties[] = {
     DEFINE_PROP_UINT32("intc-intr-size", XlnxPMUIOIntc, cfg.intr_size, 0),
     DEFINE_PROP_UINT32("intc-level-edge", XlnxPMUIOIntc, cfg.level_edge, 0),
     DEFINE_PROP_UINT32("intc-positive", XlnxPMUIOIntc, cfg.positive, 0),
-- 
2.43.0


