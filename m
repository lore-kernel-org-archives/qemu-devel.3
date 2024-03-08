Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B53C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUP-0007og-EJ; Fri, 08 Mar 2024 10:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUK-0007MU-EN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUH-0004LV-BB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e4f15710aso587102f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913019; x=1710517819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jb73dre+liBKVTGsxSnPO/03s2fFvGwYZ1zKRjJSR7I=;
 b=M4VDsNidn9Bn7KPNEXM+6maZKeicqvRKrVgT78hLPgbtuBYtQWTsEkDyp+fj0pJPu4
 A8Y/pUaVz+LUteeyLV3m+kYNlBkzAWxfj1xv49XHf5aiFBUhZNu3ym91qjUB8BIbuAzW
 4/GG06XBfsk+vvHcLiRQhStUp9Q5wAHXU430MVwoeNZtYlzkh/Hi/5RpgNsGSnwjKLuT
 ogC81dhh2iAnDz6Z271KDA1wsLgy6GZKSU8ltYD9e3hUBr6GOzSVCARXESMmeBg0eNWZ
 FhkkbgbCWGsl8Xq1omv/PLrzQC5bUL7uwGaDLYup4QbeTyk4RYHCF4FY2AnlIWodvsUj
 dqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913019; x=1710517819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jb73dre+liBKVTGsxSnPO/03s2fFvGwYZ1zKRjJSR7I=;
 b=PS4RNguEfiG7iBkAujnHWwri9eAak9mH6ynHnR8kkkE8ZiwCIG61iLkB05EHuCaY2D
 X5RJ2zIQAxi91LFr8tXTnFx5fUbStesSS+M+DyqmzuuBFxtOo4eMQz/vq2XrSsQU20C/
 QEL+SR+FMceyngCJWUeXNcSw0RxJxFCKZ9M91/m45LzS+TBRbi7xxDsXvr5VAam6L+ff
 0G6b1ttTCjqOajagB50fCB8eDH2zACZ7rODG9ZUfWNUbXDCrTJcc9YcDNvVAK9XQeIiu
 Tezgu2Z0SdIPq7POqsGV3r5yFO7Tw+s3aEkE6to+ElG/60s6Z0cKts37/cDFVZj8wVXe
 0HNA==
X-Gm-Message-State: AOJu0YyfBNdn2HN7V6Z6jTi0hzSe8Oy+nU1m5l71tmZY6UgqDrRfmzW/
 kDfsLzmjvSXEbYwk2FBrV5nVMUFHSxtzTcBR4KtLLVAqy0dem4IKaO4HbcGNd9R3jPw+IGPhG0Q
 5
X-Google-Smtp-Source: AGHT+IGwl/XduBfbQLyG3b3xbY07BWFFDj/s9llYkszmORWH7BHgr3F0X3bHv5LA5xzk6Ab2XddRSg==
X-Received: by 2002:adf:cd82:0:b0:33e:78d5:848e with SMTP id
 q2-20020adfcd82000000b0033e78d5848emr1182572wrj.12.1709913018842; 
 Fri, 08 Mar 2024 07:50:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] target/arm: Implement new FEAT_ECV trap bits
Date: Fri,  8 Mar 2024 15:50:06 +0000
Message-Id: <20240308155015.3637663-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The functionality defined by ID_AA64MMFR0_EL1.ECV == 1 is:
 * four new trap bits for various counter and timer registers
 * the CNTHCTL_EL2.EVNTIS and CNTKCTL_EL1.EVNTIS bits which control
   scaling of the event stream. This is a no-op for us, because we don't
   implement the event stream (our WFE is a NOP): all we need to do is
   allow CNTHCTL_EL2.ENVTIS to be read and written.
 * extensions to PMSCR_EL1.PCT, PMSCR_EL2.PCT, TRFCR_EL1.TS and
   TRFCR_EL2.TS: these are all no-ops for us, because we don't implement
   FEAT_SPE or FEAT_TRF.
 * new registers CNTPCTSS_EL0 and NCTVCTSS_EL0 which are
   "self-sychronizing" views of the CNTPCT_EL0 and CNTVCT_EL0, meaning
   that no barriers are needed around their accesses. For us these
   are just the same as the normal views, because all our sysregs are
   inherently self-sychronizing.

In this commit we implement the trap handling and permit the new
CNTHCTL_EL2 bits to be written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-6-peter.maydell@linaro.org
---
 target/arm/cpu-features.h |  5 ++++
 target/arm/helper.c       | 51 +++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7567854db63..b447ec5c0e6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -741,6 +741,11 @@ static inline bool isar_feature_aa64_fgt(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, FGT) != 0;
 }
 
+static inline bool isar_feature_aa64_ecv_traps(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr0, ID_AA64MMFR0, ECV) > 0;
+}
+
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37845218527..46e0c3c4fcc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2530,6 +2530,11 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
              : !extract32(env->cp15.cnthctl_el2, 0, 1))) {
             return CP_ACCESS_TRAP_EL2;
         }
+        if (has_el2 && timeridx == GTIMER_VIRT) {
+            if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1TVCT)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
         break;
     }
     return CP_ACCESS_OK;
@@ -2573,6 +2578,11 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
                 }
             }
         }
+        if (has_el2 && timeridx == GTIMER_VIRT) {
+            if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1TVT)) {
+                return CP_ACCESS_TRAP_EL2;
+            }
+        }
         break;
     }
     return CP_ACCESS_OK;
@@ -2982,6 +2992,14 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_rme, cpu)) {
         valid_mask |= R_CNTHCTL_CNTVMASK_MASK | R_CNTHCTL_CNTPMASK_MASK;
     }
+    if (cpu_isar_feature(aa64_ecv_traps, cpu)) {
+        valid_mask |=
+            R_CNTHCTL_EL1TVT_MASK |
+            R_CNTHCTL_EL1TVCT_MASK |
+            R_CNTHCTL_EL1NVPCT_MASK |
+            R_CNTHCTL_EL1NVVCT_MASK |
+            R_CNTHCTL_EVNTIS_MASK;
+    }
 
     /* Clear RES0 bits */
     value &= valid_mask;
@@ -6564,7 +6582,6 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 1) {
         /* This must be a FEAT_NV access */
-        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
@@ -6573,6 +6590,30 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_el1nvpct(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access with NVx == 101 */
+        if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1NVPCT)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return e2h_access(env, ri, isread);
+}
+
+static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access with NVx == 101 */
+        if (FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, EL1NVVCT)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+    return e2h_access(env, ri, isread);
+}
+
 /* Test if system register redirection is to occur in the current state.  */
 static bool redirect_for_e2h(CPUARMState *env)
 {
@@ -8398,14 +8439,14 @@ static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "CNTP_CTL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 2, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvpct,
       .nv2_redirect_offset = 0x180 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].ctl),
       .writefn = gt_phys_ctl_write, .raw_writefn = raw_write },
     { .name = "CNTV_CTL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvvct,
       .nv2_redirect_offset = 0x170 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].ctl),
       .writefn = gt_virt_ctl_write, .raw_writefn = raw_write },
@@ -8424,14 +8465,14 @@ static const ARMCPRegInfo vhe_reginfo[] = {
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_PHYS].cval),
       .nv2_redirect_offset = 0x178 | NV2_REDIR_NO_NV1,
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvpct,
       .writefn = gt_phys_cval_write, .raw_writefn = raw_write },
     { .name = "CNTV_CVAL_EL02", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 5, .crn = 14, .crm = 3, .opc2 = 2,
       .type = ARM_CP_IO | ARM_CP_ALIAS,
       .nv2_redirect_offset = 0x168 | NV2_REDIR_NO_NV1,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_timer[GTIMER_VIRT].cval),
-      .access = PL2_RW, .accessfn = e2h_access,
+      .access = PL2_RW, .accessfn = access_el1nvvct,
       .writefn = gt_virt_cval_write, .raw_writefn = raw_write },
 #endif
 };
-- 
2.34.1


