Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC7FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWa-00026c-4D; Thu, 25 Apr 2024 06:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWR-00020M-HU
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWP-0007Bi-Mk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34af8b880e8so514426f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041608; x=1714646408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zL893TbguEiecy15rywhbwwUs63qI5E247V3sEKStjY=;
 b=G95NYyVTWwuPMgTF26x6ZVNQSqr9vRS7h7Xp9SsrblBbQww8fe2Tdn8ypOTOEwwkME
 XTluFPQ2gRGk5kWd3VD38DABFAUx1a1Sj8l/ODF+kf13P8byqwP68GuwJw257znMHN6z
 plDk2enUFdTM95rZPCYdfgdCrSonqt2wnsKnK+1B/DUOqZkVeWpowkdOAozIGB1vtVAY
 apdgm4rfsCL5TlIih3WvjdacioOx0JJQ9bJpoAdCc7xlVWJ05WFgq+75Rd5vyOzuYgw0
 QAMf5Xf1vMNhoDI3URygOTmoTUJpxmhS+W3TiUDe6b8CuR/bQMWssK8NspsGKe8cA+sZ
 bK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041608; x=1714646408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zL893TbguEiecy15rywhbwwUs63qI5E247V3sEKStjY=;
 b=Zz5pDLcjxyg13v926CzBt99ibOceZ0RzBLBKmIBgya7aUGhVRVm+LvuLjUhRlentV7
 t0sXMRKYvyxFbOE1qpOFtNgwlLJzv6f3DdexeHNE1noH/1bCHE0xDvyX/z6Ojt0pDW6K
 Dz83flL/awI1DMAuqgcrN+MH02h+1sCH7VY+RHFoRDQFLd6HEabubEQ2v4wXF3KJ0Sb5
 ijsl1oJF10IawuZ0eRGZGjuBc8Ql0fZDmF3w/rIyV1EgJ533PeywdyQz/aksNVBTYOA2
 a51V2Ahr0rpJhfjsP9Oqr9GJ9ea2DDwm9wviVD76DGue6LM+OmSsVKaZ0PE89Dl83hng
 t1HA==
X-Gm-Message-State: AOJu0Yz+lwGvwesxK/VcWZrdkTbdbrNhe2aQ0UAumi9io6Bvj06LQG/Q
 8isDVLlMD9saKlBPw1J2mk6Pn0nEKLw2wKJFBlfrFKOtaDsLofU0/yAGdyeJm7YYxjFoYWluxsV
 p
X-Google-Smtp-Source: AGHT+IGmBhCLFLnZyFRaTA+1RvpEWQZvX4SIeWDi2w6sEnxkT1zdfC8oZPT8I//CkFDwgzelp9w/Bw==
X-Received: by 2002:a5d:47c8:0:b0:349:fb67:896e with SMTP id
 o8-20020a5d47c8000000b00349fb67896emr2192912wrc.3.1714041608261; 
 Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/37] hw/intc/arm_gicv3: Add irq non-maskable property
Date: Thu, 25 Apr 2024 11:39:36 +0100
Message-Id: <20240425103958.3237225-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

A SPI, PPI or SGI interrupt can have non-maskable property. So maintain
non-maskable property in PendingIrq and GICR/GICD. Since add new device
state, it also needs to be migrated, so also save NMI info in
vmstate_gicv3_cpu and vmstate_gicv3.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-16-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  4 ++++
 hw/intc/arm_gicv3_common.c         | 38 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 4358c5319c1..88533749ebb 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -146,6 +146,7 @@ typedef struct {
     int irq;
     uint8_t prio;
     int grp;
+    bool nmi;
 } PendingIrq;
 
 struct GICv3CPUState {
@@ -172,6 +173,7 @@ struct GICv3CPUState {
     uint32_t gicr_ienabler0;
     uint32_t gicr_ipendr0;
     uint32_t gicr_iactiver0;
+    uint32_t gicr_inmir0;
     uint32_t edge_trigger; /* ICFGR0 and ICFGR1 even bits */
     uint32_t gicr_igrpmodr0;
     uint32_t gicr_nsacr;
@@ -275,6 +277,7 @@ struct GICv3State {
     GIC_DECLARE_BITMAP(active);       /* GICD_ISACTIVER */
     GIC_DECLARE_BITMAP(level);        /* Current level */
     GIC_DECLARE_BITMAP(edge_trigger); /* GICD_ICFGR even bits */
+    GIC_DECLARE_BITMAP(nmi);          /* GICD_INMIR */
     uint8_t gicd_ipriority[GICV3_MAXIRQ];
     uint64_t gicd_irouter[GICV3_MAXIRQ];
     /* Cached information: pointer to the cpu i/f for the CPUs specified
@@ -314,6 +317,7 @@ GICV3_BITMAP_ACCESSORS(pending)
 GICV3_BITMAP_ACCESSORS(active)
 GICV3_BITMAP_ACCESSORS(level)
 GICV3_BITMAP_ACCESSORS(edge_trigger)
+GICV3_BITMAP_ACCESSORS(nmi)
 
 #define TYPE_ARM_GICV3_COMMON "arm-gicv3-common"
 typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2d2cea6858a..9810558b076 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -164,6 +164,24 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
     }
 };
 
+static bool gicv3_cpu_nmi_needed(void *opaque)
+{
+    GICv3CPUState *cs = opaque;
+
+    return cs->gic->nmi_support;
+}
+
+static const VMStateDescription vmstate_gicv3_cpu_nmi = {
+    .name = "arm_gicv3_cpu/nmi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gicv3_cpu_nmi_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gicr_inmir0, GICv3CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3_cpu = {
     .name = "arm_gicv3_cpu",
     .version_id = 1,
@@ -196,6 +214,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         &vmstate_gicv3_cpu_virt,
         &vmstate_gicv3_cpu_sre_el1,
         &vmstate_gicv3_gicv4,
+        &vmstate_gicv3_cpu_nmi,
         NULL
     }
 };
@@ -238,6 +257,24 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
     }
 };
 
+static bool gicv3_nmi_needed(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+    return cs->nmi_support;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_nmi = {
+    .name = "arm_gicv3/gicd_nmi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gicv3_nmi_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(nmi, GICv3State, GICV3_BMP_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -266,6 +303,7 @@ static const VMStateDescription vmstate_gicv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_gicd_no_migration_shift_bug,
+        &vmstate_gicv3_gicd_nmi,
         NULL
     }
 };
-- 
2.34.1


