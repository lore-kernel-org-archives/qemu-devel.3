Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE2DC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLou-0006tY-0Z; Sat, 02 Aug 2025 19:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLms-0003To-P5
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:14 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmq-0005pb-Eb
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:14 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-741a1ee9366so584365a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177831; x=1754782631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+3uEC+2riiyjp23nwcw8E7cRhcW/LL6NmP5HEJ1ke8=;
 b=A5GR94RcaWr01avcniYLYznWWoTj7uMdjEgx9Sk3GJz2bckbErffpwgZNFwG9yaEVB
 3OWCc2FLCBJACAHX/bhoc6iHTu6iIgZIImTu3eOPSSRVomosYma94vDLKcEMnXuUqAwW
 D7i6Z/PVJ4OLT3Yt5ZYW207IBn55qR2kb4w8pZZ8MVUjdqXZ0joyd10euwPFlecxc5G9
 Axa5hH7ALq8JxgWzZ9r9LRtHgILeyEwtGUZlJyD+OdIDRrPIHY5VvEgXRvBHxVZIPhlx
 TYHFZThIK1MlK78U0m3g/bL7IiqZWQVCptMCqUkEEU1t5k1UQ08VQQRWZUA/JUuBluqc
 VfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177831; x=1754782631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+3uEC+2riiyjp23nwcw8E7cRhcW/LL6NmP5HEJ1ke8=;
 b=NGIi5iJOe91f0VPL0DhaeAKDNZIUyCHo66MhJxWE/nJmAafb6v7blZHCJEYkvU8k8/
 f3aF2jLsKdJooPXc7olt/H8sFgcjQ+f6IDwtt0aCgD7D9ECm8b/LGDupeMs3ubHvmwS8
 AIFEnizooJU0ts/sHcJgeQICVm6guhhR6T3cDaynXhgtaS7Ibjugr9QDwDmW6x4nwHRl
 sstQAu/ESu8DTSDwqTkyuD1UEPP++nGJzEdmPfRoDpHXFEgjAGoKQWbgkJzmiyGPvCNL
 fccwp9a/BrwM2tabyKkW4KfWJX9qiVjt2GHwlFWF+KvMnYFUIjLsiZGSWhjnyM2FxBFv
 xORw==
X-Gm-Message-State: AOJu0YxCl/8MJv10ptbvQUDL945+v7pJVTeidsEbN9SYC8X2dYiJ6RBn
 bqd+aMVt++TGG5HP07ocU/UnAGTDJiGfJhA9UhulV7hYOUH/tSE5RqSIYUMOsyk86qpfAJcddrf
 vt6QvdgI=
X-Gm-Gg: ASbGnctT7oe4vKuEkY4Zec1HxFPgj8F670wPRDxfch24XfwWrcSeU+Mr6awED+lSRqh
 SzmdHptc2pQek0Iq3HM+wtwfv8u+bo1FcazTvXO2ORUrWjYcGFnFDe5IAxLwVkng02Re8nSoQrF
 WDPE3HquWDk4e0Ht4R/frKY/l3vAZuLLta/PGwWPdg69w4nLDTW0MLCPjdWLvDyYhJmP++Ev/0q
 X8KY9GK7MnI1IVHT27m1DoA4VKFCpOq8xNJjZluXQ4p5FFL+lIRMU5MTYxupdoSW2NlZAF6hA7Z
 D/Th/GUtOxYBwsoRstMBHxgNcqgkJ9O3BrsIpFIPtaSX0xsnxYowSCPy2JfO3PHbJCNQswqj4oo
 110SduNwMF3tjqVkmZlsESeBVScHTwSrCHYYnOmKIRi2OMPe+aTYi
X-Google-Smtp-Source: AGHT+IF2j/FLMWL28I0rt8qkVG/eKsXp4gWxPC8O7RutzfDaoiIg8eZ4aM/BnzW5rQkZcuFaknbJZw==
X-Received: by 2002:a05:6830:dc4:b0:741:290f:4a8c with SMTP id
 46e09a7af769-7419d0ab11fmr2666637a34.7.1754177831201; 
 Sat, 02 Aug 2025 16:37:11 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 52/85] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Date: Sun,  3 Aug 2025 09:29:20 +1000
Message-ID: <20250802232953.413294-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

If PSTATE.EXLOCK is set, and the GCS EXLOCK enable bit is set,
and nested virt is in the appropriate state, then we need to
raise an EXLOCK exception.

Since PSTATE.EXLOCK cannot be set without GCS being present
and enabled, no explicit check for GCS is required.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h        |  3 ++
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 83 +++++++++++++++++++++++++++++++++++---
 target/arm/tcg/op_helper.c |  4 ++
 4 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index bc6adf5956..15894332b2 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -346,6 +346,9 @@ typedef enum CPAccessResult {
      * specified target EL.
      */
     CP_ACCESS_UNDEFINED = (2 << 2),
+
+    /* Access fails with EXLOCK, a GCS exception syndrome. */
+    CP_ACCESS_EXLOCK = (3 << 2),
 } CPAccessResult;
 
 /* Indexes into fgt_read[] */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7769c4ae3c..8eee722a9e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1520,6 +1520,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
 #define PSTATE_N (1U << 31)
+#define PSTATE_EXLOCK (1ULL << 34)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
 #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d9b2762cf..4495433ce4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3435,6 +3435,77 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_exlock_el1(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 1) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        /*
+         * EXLOCK check is disabled for NVx in 'x11'.
+         * Since we have to diagnose that, dispatch NV1 trap too.
+         */
+        if ((hcr & HCR_NV) && (hcr & HCR_NV1)) {
+            if (hcr & HCR_NV2) {
+                return CP_ACCESS_OK;
+            }
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (el_is_in_host(env, el) ? el == 2 : el == 1) &&
+        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_exlock_el2(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 3) {
+        return CP_ACCESS_OK;
+    }
+    if (el == 1) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        /*
+         * EXLOCK check is disabled for NVx in 'xx1'.
+         * Since we have to diagnose that, dispatch NV1 trap too.
+         */
+        if (hcr & HCR_NV) {
+            if (hcr & HCR_NV2) {
+                return CP_ACCESS_OK;
+            }
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_exlock_el3(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (env->cp15.gcscr_el[3] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
 #ifdef CONFIG_USER_ONLY
 /*
  * `IC IVAU` is handled to improve compatibility with JITs that dual-map their
@@ -3606,13 +3677,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_exlock_el1,
       .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_exlock_el1,
       .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
@@ -4083,7 +4154,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NV2_REDIRECT,
@@ -4101,7 +4172,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
     { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
@@ -4383,7 +4454,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
     { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
@@ -4394,7 +4465,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SPSR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 46a3b911ec..56e117c01e 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -887,6 +887,10 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         }
         syndrome = syn_uncategorized();
         break;
+    case CP_ACCESS_EXLOCK:
+        /* CP_ACCESS_EXLOCK is always directed to the current EL */
+        syndrome = syn_gcs_exlock();
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


