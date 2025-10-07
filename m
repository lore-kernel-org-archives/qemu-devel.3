Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69BCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R5-00069M-A5; Tue, 07 Oct 2025 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qk-0005tG-Qk
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QU-0002Lr-HW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso4892513f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846338; x=1760451138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zw5KMxceB9NmKCgbX8APAj8IVt3ga1wC/nI26rLINp0=;
 b=RBv2D9Uj1fgIVR11ObkBkMJRm+A/2KtI2c5Ifjdn+1qdwdmAvxOj1n39pRnUq9dQEZ
 Ao3DoAdbKssjnvaRYAn4jUiVODcnTSxTvdBw4aCCSrYh3iUtD0+SVfw4ZsdYQWRo89E3
 RM6s5gvZ8bv8PuSLPeAwov9t79/C+0ZBOQvrtGa/Mzf87ZHhlEYmlNTwzieXdBrFD4ZI
 eh/Y1ToPT7QfjgVRTdcyGUaIt33gyNAnpFAr7N2Shgoz+QHge/NhS65RPx6b2P+RUpTH
 qEccUCe8u3XHjUBbwEU+ea2N3mGgSphM2UFv/QzIfWiCZdgAo3hMfZdd1IM7ycZCeaKP
 VWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846338; x=1760451138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zw5KMxceB9NmKCgbX8APAj8IVt3ga1wC/nI26rLINp0=;
 b=ndRwjUjQN0qGH19i9Ad7+1alAwHKp7Lsln9HmFcOZRW7FcHn8yzpjhBlilU1oA0URL
 rv0Z5K8Qm+rWD28mzLIgcBTLBs0CQgU6L9o2VeXn3r4lJmuX29s2Tc359i2gfbDFJ6V2
 wBKEN41IKKuynPjax4Fo/RweaYtbrfrCQ/etvwIq8xdrPwc0gCLj52T7xTF6KV+fwUtk
 2tqh4BsFS5TTRiT7p7rhcj0MqYDtvLW/Zq6KZDk6HAZaf4gibAOu1KpUemZEhPuXYevB
 MGC+U45HbLSK1vZaqZ716EqF0wEB3zltTVjz5QaJj5VVR+xqEPHGAsxye3AUy1zA0kPy
 nuCw==
X-Gm-Message-State: AOJu0Yzpcy1KjnVCxSGIamzLw+Nr2zDKY2BPPD4rOp4ZxsgyhHLhMNkg
 dQ40bM4w90W6ScrKtyJT6R7XsN03ElmxiDgYmZeJBItWn7SrpKmsPjg2U7fal57qQy7KPN1/3I2
 6kXp9
X-Gm-Gg: ASbGncs+jWFRUqsWPhGbP1phks6EaX3B0vBCQBx+J7edLy0PiU9J4NUUP7ldtDA0TD8
 PbTEaxa+8nVvkCbHEGNIxSY4hXJfIvKooncnOCBQldivhdXgvDIWx6G1+mYZTameapQu2uGDMw+
 +EVVdiLvn4mFKgh6Yta30eyMQKrsH76qzw0ORTZY/4QMwV3ROpnVFc4iyheyZZ6xx6QbZ+K3dru
 uzzqW1/IUUtTLLEYpUKVEPl9TbearrSGZ2Z+Ig5WahYX2PhKgb1+7PKZhx4IW1nlUeAKF+bHqFH
 Ihs3JCW8hAL8WDMXGxOt1SQOwwAilp7ybdTIma9tva2nqT4/u4qJXqkhOIk9kFvgaqIoDpEaxVL
 unR60AVmtKs8r93Sk3WguIUwotKH09W7oJ+TxmLPv2YxzSmMmpIuwC7Y2
X-Google-Smtp-Source: AGHT+IFLO9HiqM0xoS+SEuvUqgSGcisvp3xLuPD33qVzQKzRw1TkoObGIrPSkVr2gnCgv6ZtRRTcrQ==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:dbcc:8104 with SMTP id
 ffacd0b85a97d-425671aa874mr11644847f8f.36.1759846338202; 
 Tue, 07 Oct 2025 07:12:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/62] hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in
 header
Date: Tue,  7 Oct 2025 15:11:09 +0100
Message-ID: <20251007141123.3239867-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Clément Chigot <chigot@adacore.com>

This define will be needed in a later patch in XlnxZynqMPState
structure, hence move it within xlnx-zynqmp header.

Add XLXN_ZYNQMP prefix as it's now public.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20250930115718.437100-2-chigot@adacore.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h |  1 +
 hw/arm/xlnx-zynqmp.c         | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c137ac59e85..6a407c29624 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -67,6 +67,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
 #define XLNX_ZYNQMP_OCM_RAM_SIZE 0x10000
 
 #define XLNX_ZYNQMP_GIC_REGIONS 6
+#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160
 
 /*
  * ZynqMP maps the ARM GIC regions (GICC, GICD ...) at consecutive 64k offsets
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ec96a46eec3..d7adc070f8b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,8 +26,6 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define GIC_NUM_SPI_INTR 160
-
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
 #define ARM_HYP_TIMER_PPI   26
@@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 {
-    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
@@ -454,7 +452,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
-    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
+    qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
     Error *err = NULL;
 
     ram_size = memory_region_size(s->ddr_ram);
@@ -502,7 +500,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(ocm_name);
     }
 
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
+                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
@@ -613,7 +612,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < GIC_NUM_SPI_INTR; i++) {
+    for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
         gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
     }
 
-- 
2.43.0


