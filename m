Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2132EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZL3-0002dc-Uu; Mon, 23 Feb 2026 12:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKp-0002YK-Mt
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKn-0000KR-LZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48375f10628so29379235e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866180; x=1772470980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AM/OI0jKVabZ0iq/CmOwmnbVdkGhhSHtAdP0sBiCNp4=;
 b=guECjS2X6yMGeGLohKhf+b6NxnJvmdwJB4MN8z9JGpJUIMUOEHhsPCvbsVtlZOgiY6
 UlXnsjjbjSb+NRyJPHucai4fLaNJuKN/vO2gAhi8P+sM+9r8hmfjkJ1U05sp33wkj1qS
 /7cTXyJ3n6kNgZaXNw7E4bK9J+UG6ZY1HaVwicJxid+r9YpGKSdxNIr9hZlnlRl5YOrH
 8CPvpoG0l1tOEMpre5ffpcrZZX3i1iddOvrSjJzCMo5YxtZnUxUErRdUVWvR2qvuFeSh
 V3ysXDh1fehBY99FyDmNbBlY7JEd7WqyZBPNlLDkFxsAj+Kpw8E/xEYedGBZS/olTCsM
 CYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866180; x=1772470980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AM/OI0jKVabZ0iq/CmOwmnbVdkGhhSHtAdP0sBiCNp4=;
 b=wbLtnv++DtFt9Lis2Exbcf2At2f+6I1AKCS84Wy/U7Y+ktiaCBm5hJ1hMVRWO6ds8v
 7W76f4DgquLS7OgXl4QYLBUQ5TGxwIg/sbvNh/AyAX7JTJ2UbxR7kfEwcFxNH/2tda3I
 St9DAuqDtGtCE4rkmWo6yKlhS0qUz086/VrDea7XTLKEj/ib/dD6Ht2Lboj6HvZ19tbZ
 RnfV785JDyjptj19fmBRLumcs4udOnWab0YhIFovTxSoVSobiT6VQyk2W8VebjaSPtn6
 eDNdUgQ1z+vERvFxFH714be3fQMX+UbyKvL7wTHNgIrqQLTLq74WJRdfkbYIGUByvo1n
 D59w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsPn4/fs4tllYuQpDn1W/aeg7p58x1PW1gPg64aUaOLguGEwi2J2Hjv2N0/OkpmLB6dgOAPPCWIZ+0@nongnu.org
X-Gm-Message-State: AOJu0YxDgW15jfEoe5r9M3WF/yFeQmMcPohTM6gSJR6yddsKndMtIzPo
 Rz2wf5lOnHLOKluLXjj49q1PBtQBB3NlPOUnxkTzeisZUK+ZL4rkaMlYMi5cSOfCpuA=
X-Gm-Gg: AZuq6aL0lQ40nYqGUA/AhJZSwctoOTOayARju4ghRQWFLiVy7SBUqFU/iCPdUzalkqB
 +i+l1B+pE2gUkpKJjxysx4Uh6fTiJAWC7GONty0eV5rsSIaQr5VBtCvBeKYUhch7LOpLj2ifdx9
 +1+wT5qcKFyqoo4Fbbls2CVmLdFz71N9WaUR2FsQV5n9UBtubrZc4u+x9TACpUGJT2G6WvU3i4T
 bSH0qtMcStwJ2hfEDVNRQZ3tSK9hjpW8jPtO10SRw3vXAVn5bMX+4Oz4bdgTut0Zg9CN7ElmqIm
 qw6JinzI7wpPCemth2oF9wzVgNqlkaUxAK5BmaHeKfVpJtCNvJXEeF7e/E+0mL8rt5U+Ci4xdei
 4EZiSrr4DWZB4NkPlLPgYh/Rb7JsCrgKZQ3cYWsbsAY1vT+vFC2FZAxY38wa4qqZsB+dvDfHAr/
 huZzg8i0+U0kSs66TaDhsrqkdUdaG5T/qibhB5gxv/eOtD5ErzXqdxxTzlH3R0LjF5woaQFe4YO
 z0wMPmI2Dhhhgi2Dx1Ajyb1TCsVdew=
X-Received: by 2002:a05:600c:3b0a:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-483a95be7c9mr180018785e9.13.1771866180089; 
 Mon, 23 Feb 2026 09:03:00 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 40/65] target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and
 ICC_HAPR_EL1
Date: Mon, 23 Feb 2026 17:01:47 +0000
Message-ID: <20260223170212.441276-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The ICC_APR_EL1 GICv5 cpuif register records the physical active
priorities.  Since the GICv5 always uses 5 bits of priority, this
register always has 32 non-RES0 bits, and we don't need the
complicated GICv3 setup where there might be 1, 2 or 4 APR registers.

ICC_HAPR_EL1 is a read-only register which reports the current
running priority.  This is defined to be the lowest set bit (i.e.
the highest priority) in the APR, or the Idle priority 0xff if there
are no active interrupts, so it is effectively a convenience
re-presentation of the APR register data.

The APR register is banked per interrupt domain; ICC_APR_EL1 accesses
the version of the register corresponding to the current logical
interrupt domain.  The APR data for the final domain (EL3) is
accessed via ICC_APR_EL3.  Although we are starting with an EL1-only
implementation, we define the CPU state as banked here so we don't
have to change our representation of it later when we add EL3 and RME
support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv5_types.h |  2 ++
 target/arm/cpu.h                  |  2 ++
 target/arm/tcg/gicv5-cpuif.c      | 60 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 30e1bc58cb..b69ad137aa 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -85,4 +85,6 @@ typedef enum GICv5TriggerMode {
     GICV5_TRIGGER_LEVEL = 1,
 } GICv5TriggerMode;
 
+#define PRIO_IDLE 0xff
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b97f659352..6841b6748f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,6 +35,7 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
+#include "hw/intc/arm_gicv5_types.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -603,6 +604,7 @@ typedef struct CPUArchState {
     struct {
         /* GICv5 CPU interface data */
         uint64_t icc_icsr_el1;
+        uint64_t icc_apr[NUM_GICV5_DOMAINS];
         /* Most PPI registers have 1 bit per PPI, so 64 PPIs to a register */
         uint64_t ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ppi_hm[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 60b495dd8f..d0521ce7fd 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -95,6 +95,16 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
+{
+    /*
+     * Return the current running priority; this is the lowest set bit in
+     * the Active Priority Register, or the idle priority if none (D_XMBQZ)
+     */
+    uint64_t hap = ctz64(env->gicv5_cpuif.icc_apr[domain]);
+    return hap < 32 ? hap : PRIO_IDLE;
+}
+
 static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -231,6 +241,44 @@ static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+/*
+ * ICC_APR_EL1 is banked and reads/writes as the version for the
+ * current logical interrupt domain.
+ */
+static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    /*
+     * With an architectural 5 bits of priority, this register has
+     * 32 non-RES0 bits
+     */
+    GICv5Domain domain = gicv5_logical_domain(env);
+    value &= 0xffffffff;
+    env->gicv5_cpuif.icc_apr[domain] = value;
+}
+
+static uint64_t gic_icc_apr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv5Domain domain = gicv5_logical_domain(env);
+    return env->gicv5_cpuif.icc_apr[domain];
+}
+
+static void gic_icc_apr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    for (int i = 0; i < ARRAY_SIZE(env->gicv5_cpuif.icc_apr); i++) {
+        env->gicv5_cpuif.icc_apr[i] = 0;
+    }
+}
+
+static uint64_t gic_icc_hapr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /*
+     * ICC_HAPR_EL1 reports the current running priority, which
+     * can be calculated from the APR register.
+     */
+    return gic_running_prio(env, gicv5_current_phys_domain(env));
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -382,6 +430,18 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
         .writefn = gic_ppi_spend_write,
     },
+    {   .name = "ICC_APR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 0,
+        .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_apr_el1_read,
+        .writefn = gic_icc_apr_el1_write,
+        .resetfn = gic_icc_apr_el1_reset,
+    },
+    {   .name = "ICC_HAPR_EL1", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 1, .crn = 12, .crm = 0, .opc2 = 3,
+        .access = PL1_R, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .readfn = gic_icc_hapr_el1_read, .raw_writefn = arm_cp_write_ignore,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


