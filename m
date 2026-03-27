Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A3010ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CB-0006zt-D8; Fri, 27 Mar 2026 07:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C9-0006vn-0l
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C7-0008Ca-6j
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so17943745e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610258; x=1775215058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22dNZBfMp70lJSs9tv9FQMfyO2cJBi2NY6IZf7t/OiY=;
 b=gUdcvKvXm4fBcAtzJLGSWsUZAg39DNLd9/C9pLboWIVW6iZ2vJU3ul9q2DPFRfIOYv
 8sMvmxcX94PDK+TdqU9Xe2bfWWl5HWhIzb0SdWmf9c1GRxo/roJ6w7J/qJto/hAD4elp
 BFSKCdLs9eJzCSy2O+FCK+7Aa/8tXOT7WdGe6Ib5JCw5OncMNuInY2By+VBWsdCfWOQp
 dY8lcwW3U5xmec+0Kn2jXJEtFv3b4lHRoNV4tVOBGMm/J6cgmvcLHXmLpEj9fzKfJs6t
 +gcW0XHeaJ0sDxpC4fE4q9zwtVkGcMmUCGRqOZtTt0qgbIGQZco13SFOdGKfT8mggEXQ
 ga8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610258; x=1775215058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=22dNZBfMp70lJSs9tv9FQMfyO2cJBi2NY6IZf7t/OiY=;
 b=i7I2POgTwbOpC+Sida0zfjPI2VJlIE4Y8M48WYDHRIFmlNNarhCWEMISpLerkM8rfr
 8R2WeraS1ihI4xsL2/LkbC6alzW2qycJWMzEZ6JNmAwRGSlRkYoy39AW1cfzZ6r6R+J1
 ZyrbZuGwof4ZQTPIDIQwWzHqgHweeV/j7tidYLBRJhetzePIANbuavqopPjniw1CV6Wa
 fuAoE0bNzyR5aj8/gJJ5/2//RwNVogA+Vbu+GM9K1ixv/p/XMdYewu0Ugq/wk4Wd8PhD
 3H0aYRERMIVnnSPKKwAxgDi7MwRhQh+AErzI3zDyeonkLgC5IWOhhswlXtMDAu28sQ2L
 kyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVi7ctML9f19AaEMOHUUE5TeRiY9zkv7pIhGl4xNbzceEeXf6Dl32Vbk2MTLLjMI0z0BG7sKlcQy0Z@nongnu.org
X-Gm-Message-State: AOJu0Yy8mAtj7iSpKxeWO711i8bQ60kfrPY52VK5CCA/44HzrhYxWFIe
 UZore8gwCgn5Fxb9TZrZQvfwcYjaR7P10i8+/qsFdMKOM7sVfu2PkpNSPIAx11kWDaA=
X-Gm-Gg: ATEYQzwK2EDi8oSDdAWJYOUj1BIQgiIl8UDjsj2k6+6u0+F3ZOPixxFXifxKQSpu0uC
 B/fyWZ/h4wie++GJ1jtReuIQ7yj9Du/Ys39GYUBHvjj++o7inqTyqb4VQXeA7NHrc5uu35qLgX1
 Vj5h644jaugpGLg9HeTCD4WBbHEurtmMy7CVNpSb9adPmSoSZFNNt1t+sSNYsYWCNB3h6iyYySb
 aLf7COc4tNn3ClkRRFUimaCPGzKXi1P7SnoaDIdmAvsvzJdyCkbNFdW0WgzbBh50Xwj4rkBeB5j
 3C/gKc55mSHNGJVzPYWU+feTC9y8kR9moGuDO87iBhhKp4U2S6covobRzEKwqpo78tsbERm9y3l
 VuWNYZKcRkHecZrKFXfxQWZrYUR53VY9VPKV8oW4hlVNeNkAyV4wuKYjYEGoxK2vsbFg81kQ7ad
 gKXIhCkWotGFFvLMuHgmf+Jld637La6hbER8Y3YUp4Tmw8GyuErAu/dq2enBIlURwGrL2vK1u7b
 SYwrFp4Fxjc704mTc+EpHC+VkTPT8g=
X-Received: by 2002:a05:600c:1d15:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48727ee99f6mr32789585e9.5.1774610257609; 
 Fri, 27 Mar 2026 04:17:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 37/65] target/arm: GICv5 cpuif: Implement PPI handling mode
 register
Date: Fri, 27 Mar 2026 11:16:32 +0000
Message-ID: <20260327111700.795099-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In the GICv5 the handling mode of a PPI is not software configurable;
it is reported via read-only CPU interface registers ICC_PPI_HMR0_EL1
and ICC_PPI_HMR1_EL1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index dd4dc12feb..4574f7005d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -605,6 +605,7 @@ typedef struct CPUArchState {
         uint64_t icc_icsr_el1;
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
+        uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
     } gicv5_cpuif;
 
     struct {
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 6672cda37f..e65bd56b3d 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -50,6 +50,16 @@ FIELD(ICC_IDR0_EL1, GCIE_LEGACY, 8, 4)
     ((4 << R_ICC_IDR0_EL1_PRI_BITS_SHIFT) |     \
      (1 << R_ICC_IDR0_EL1_ID_BITS_SHIFT))
 
+/*
+ * PPI handling modes are fixed and not software configurable.
+ * R_CFSKX defines them for the architected PPIs: they are all Level,
+ * except that PPI 24 (CTIIRQ) is IMPDEF and PPI 3 (SW_PPI) is Edge.
+ * For unimplemented PPIs the field is RES0.  The PPI register bits
+ * are 1 for Level and 0 for Edge.
+ */
+#define PPI_HMR0_RESET (~(1ULL << GICV5_PPI_SW_PPI))
+#define PPI_HMR1_RESET (~0ULL)
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -292,6 +302,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
         .writefn = gic_ppi_sactive_write,
     },
+    {   .name = "ICC_PPI_HMR0_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 0,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[0]),
+        .resetvalue = PPI_HMR0_RESET,
+    },
+    {   .name = "ICC_PPI_HMR1_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 10, .opc2 = 1,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_hm[1]),
+        .resetvalue = PPI_HMR1_RESET,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


