Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52CACD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11g-00043K-6C; Thu, 07 May 2026 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11f-00041U-Ax
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11d-0003wW-M9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso11500445e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169152; x=1778773952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RSKbC4/1FXYT8ot948h8jarJjuqtFpAfnwH4gEg2nA=;
 b=RNWoC4ZuFdScwCLSTKuYJIA9sEVo1Li1Hc3Ys9jNR7yYcMTpbvU8VedqYFD9Cy2QHM
 icgupXdqD5X/4VApkxPlprpm3oxupAnDCKjkkQwRgH+1NYktfmMk63y/2FKNnyRZzV78
 97VPMziocQ5kR6rvpJfLedaUEr0MnUjo3Tk34vh43FXjBolMMugnBcX/Hna5GiNRvLxV
 lQWML3lktWlfZWvGfQ7swRXjVuSWBLKsGJd2Q7RIgtIDBRKvr3KSi2PeC2P8sHH+fo+D
 6H/9Jvzt6Z9KYiP/Bhx//YuvT8nHoHiqVWk4kVd0IvaePrXt1nLbCrYG0SlgLx2TuOoL
 31UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169152; x=1778773952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RSKbC4/1FXYT8ot948h8jarJjuqtFpAfnwH4gEg2nA=;
 b=NuanYyePwwaqIEXrEvNBlK3ou7RxI2n3a+oQS1HqMQ9Eti3htDBm/ot6ayNr38k61R
 rb4FEWO3kfewpxXxowwa2/oirwIck1E3LAtuOJMZJ02J8k9p8M6a8GQwqM/iahRMAL4d
 j9nVFc/uVwO3y8ZuGhoNzEPNpSQ0Jwpw4L6AoT7NVmIm13la4lPwacpOZPvF1c+my06i
 Ycnjo7FEvtLd1TZiTb6AFBNe/sO6ZqsFHMV1TqbicmP0TxgfZ0TtiaL8lDz9zyyFoaX3
 Ea6Qt5xpYxSHnWt+hhyPzA1UCaOIEI3x4ngqDjSQJTOjDLnXNSifZ4ukK7NPss1C+gwU
 QDSg==
X-Gm-Message-State: AOJu0YzBDraipaUVCXZ4cywZnyUpNWOmaysaYu9/SkNATqbTTYh7/u7X
 +gxDNYQvTIFk+1N82BKiKVfzd0XVYoypBZoDN5yIGipttX6eyKR6k8nofFCRkwnjsaO9OyBww8X
 VqyhM
X-Gm-Gg: AeBDiet+kL3rXjKLxPbc9x3fuPttB9Zj9zx4Ed/vRSSjMTiG9To8EtlxtpqkWJss90x
 tPTCGk4m6xGV+KRFaUVUheo8dyXYTNfWLv4+YcwUi9p6ufjUN6ZGEGEE9Li8MJb14gz07kePV2k
 FW0uiBA+6PuwqsMJ+lYR0FzkTLEG4yUEgC3GFVYFj01lgbAeG04ywyM5MJKTmNwNDtMzf8+V03Q
 DfoC7AgLJhm22DSJiq3jzou1n72JmzTUdMbjAVWiwnMlhbRhOdx0z7fHnDYqgLDSPD64HEejahj
 nlQVB77WY9lCxm+eZBbYcOYRi76Nd2ew+B37FU+QssoC4PtZ0l1iVGJT1+zQRh+dXbq1w6q39Kp
 H4GOxiJqNDDcqr3TUJtYLmnphJqrJEd+kJA6PWTp4SjlF+PZJlFtJTBqWWMxOTG/HztsSXyuwvU
 8tRjgntplPmZwN+HahLuAeU9XfKdV7BGVYqldGa7c24xAuC/qNvxJwj5xu54lAcpl7DOgVi50TB
 my6TKpKqIgMVUs9y/crQhUe6pLLqhQ=
X-Received: by 2002:a05:600c:3151:b0:48a:7605:751e with SMTP id
 5b1f17b1804b1-48e51e0837amr134866565e9.4.1778169152177; 
 Thu, 07 May 2026 08:52:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/67] target/arm: GICv5 cpuif: Implement PPI handling mode
 register
Date: Thu,  7 May 2026 16:51:24 +0100
Message-ID: <20260507155154.1886557-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Message-id: 20260327111700.795099-38-peter.maydell@linaro.org
---
 target/arm/cpu.h             |  1 +
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac0891d498..b8bbc91a16 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -604,6 +604,7 @@ typedef struct CPUArchState {
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


