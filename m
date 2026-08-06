Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F8C5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wL-0004nd-LI; Thu, 06 Aug 2026 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wK-0004mf-G1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wI-0001gM-5a
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:32 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2918248a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037489; x=1786642289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T3c2UdkmGaD6yBf6bG1TdPxdxNZUO4yArA0BVPODz2U=;
 b=Kd30hxZbcrCzP5UzaE6tyd3VusW5AJ0ErS1GMJFXa9jFpEYMj8ooyv3YBa3FPMkdCQ
 9WsBpq2cZs9GxfpzB2v8vE1Ofu2QOjiBrHbo7qDTPPLdfe1Riks+YQAEAosIhGl+HlZi
 H1PuQ4uQeDwLNY7yMImT3FixpJRatsG43RIKzuDjHbCQUi1xEHpGPDmSzOY4Q0iiASDJ
 GuOx1XDfG2iNbhRfDcSOjzgN2ohE+e9/D6YGfcQ9XJIiUa9xwuwGAa9oObRUkPnmkOHD
 xi8ovwMu6tsau9jhDNRyxnIZejPtAwJuaABPwBrlp4qBQVVfTXP2HkGdfTVaIqDb1Qnv
 43/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037489; x=1786642289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T3c2UdkmGaD6yBf6bG1TdPxdxNZUO4yArA0BVPODz2U=;
 b=W6AFpRr0fK4+Rb+g+1iDxa9Lp4txYMroOhVbej2pNvWfCEVEJMpZBrzlVhVfb8UQfd
 GwG6IFhmm8cGU3MxCbTh3Na0/66xH16RlddA5r5D5xnX+nyAqQKi82mGL4jcK4iU9P1H
 fhwKtJJBBWnzgwtop8vfXwaQn2FA9U6EiZa3yZqniDUF0zLP1nh6XJUnEJpKziqy/+Lt
 rzZ/iKYdwo92d1xa/rqnUDORjeQuMyzipPZryn5HfsSTSmbHVq65girJc8z3hhr7WyZX
 n6QADfnmgk0S61r5ShbOrRBhN9xh3i/8vKvfZ8u6+4AtupZ7xYC1TPFgpfNZspyWskZo
 LsCg==
X-Gm-Message-State: AOJu0Yz5luBldiL7eGpKjBOEGxCX3Vm71Cl16AtCbtXnl8xvX8fK1+04
 asROak8Vh91H/tTrKrHmRSVC6ngImYyLRymDsw/tD7p0CBOCO7t+QaEMY14XW89ELZvHi9pR9Od
 2qRnT
X-Gm-Gg: AR+sD13WLoQ95U7KUTMLyYXvGqxq0bDwwRxUieb2WnKG1wtibAyql3td+0m2HDpHae9
 fsj7AD7sX1kCI+r48bSD9Ys/Swtxo9CeASo7JoFjdwfzihr8rSySR8VJ/K0dCMXXBUcXYkPEfzv
 /Cxf75UCfhcVOFkIaNFq2LjO3Jikt5EBcXEhLLK5xJ1mkPZN4fm55wlqpf1gMjsGe83rO+smrRt
 xB790TI4DkqQODcprf0DtyjBFx1aXy+QGA3ssrQWzGq2/jKx+UhYsWQDYEY+3hEwS6sONkxIMtx
 5Y8DGMyl5ppuUMSC34uxFNUpKWynHY5J4z6ZIkJdDRYPCPttYR2xTU3tEdk94MvAQyT2iz8WnxW
 Dzg1kaIIRODAy3EVUU72X1bBGLrnEWvy/d1GbaDikbR+7J8cexOSC1JOKcz8dVySJ4cwwiFoVgN
 Z9iosHxbNZ87NfLC9cdY6FbUS/lkzFOBCoCHXVACArM1SH8w1VPngrrszoX+S1hXFoCLLnCm1qY
 /HUpIMrjkweI7YVLRUn
X-Received: by 2002:a17:90b:278c:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-3903c5bf6fbmr17873314a91.17.1786037487300; 
 Thu, 06 Aug 2026 10:31:27 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on undefined
 TID3 registers
Date: Thu,  6 Aug 2026 10:31:20 -0700
Message-ID: <20260806173123.333423-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
within the range which are not explicitly listed.  Previously we chose
not to honor the TID3 bit.

However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
on these registers, so we might as well honor HCR_EL2.TID3 too.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  8 ++++++++
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 19 +++++++++++++++++++
 target/arm/tcg/translate-a64.c | 12 ++++++++++--
 target/arm/tcg/translate.c     | 18 ++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 9f2532fe66..b1fc1f9f85 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1213,6 +1213,14 @@ static inline bool arm_cpreg_in_idspace(const ARMCPRegInfo *ri)
                                       ri->crn, ri->crm);
 }
 
+/* The TID3 subset of idspace. */
+static inline bool
+arm_cpreg_encoding_in_tid3(uint8_t opc0, uint8_t opc1, uint8_t opc2,
+                           uint8_t crn, uint8_t crm)
+{
+    return opc0 == 3 && opc1 == 0 && crn == 0 && crm >= 2 && crm < 8;
+}
+
 #ifdef CONFIG_USER_ONLY
 static inline void define_cortex_a72_a57_a53_cp_reginfo(ARMCPU *cpu) { }
 #else
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 0077aeb4e2..97b8678f19 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -86,6 +86,7 @@ DEF_HELPER_FLAGS_2(check_bxj_trap, TCG_CALL_NO_WG, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, cptr, env, i32, i32, i32)
 DEF_HELPER_FLAGS_2(lookup_cp_reg, TCG_CALL_NO_RWG_SE, cptr, env, i32)
+DEF_HELPER_FLAGS_2(tid3_udef_el1, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_2(tidcp_el0, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(tidcp_el1, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9fc4f86825..6d1feb5b33 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1191,6 +1191,25 @@ const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
     return ri;
 }
 
+/* Raise an exception for an unimplemented sysreg in TID3 space, from EL1. */
+void HELPER(tid3_udef_el1)(CPUARMState *env, uint32_t syndrome)
+{
+    int target_el = 1;
+    int excp = EXCP_UDEF;
+
+    if (arm_hcr_el2_eff(env) & HCR_TID3) {
+        target_el = 2;
+        excp = EXCP_HYP_TRAP;
+    } else if (is_a64(env)) {
+        if (!cpu_isar_feature(aa64_idst, env_archcpu(env))) {
+            syndrome = syn_uncategorized();
+        }
+    } else {
+        syndrome = syn_uncategorized();
+    }
+    raise_exception(env, excp, syndrome, target_el);
+}
+
 /*
  * Test for HCR_EL2.TIDCP at EL1.
  * Since implementation defined registers are rare, and within QEMU
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8c7a0294ee..6fde2c7bff 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2675,9 +2675,17 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
      */
     uint32_t syndrome;
 
-    if (isread && dc_isar_feature(aa64_idst, s) &&
-        arm_cpreg_encoding_in_idspace(op0, op1, op2, crn, crm)) {
+    if (isread && arm_cpreg_encoding_in_idspace(op0, op1, op2, crn, crm)) {
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
+        if (s->current_el == 1 &&
+            arm_cpreg_encoding_in_tid3(op0, op1, op2, crn, crm)) {
+            gen_a64_update_pc(s, 0);
+            gen_helper_tid3_udef_el1(tcg_env, tcg_constant_i32(syndrome));
+            return;
+        }
+        if (!dc_isar_feature(aa64_idst, s)) {
+            syndrome = syn_uncategorized();
+        }
     } else {
         syndrome = syn_uncategorized();
     }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 055f3c5b40..7f6a7e0aff 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1824,6 +1824,24 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
                           isread ? "read" : "write", cpnum, opc1, crn,
                           crm, opc2, s->ns ? "non-secure" : "secure");
         }
+
+        /*
+         * With v8, we have the possibility of FEAT_FGT which requires
+         * trapping with HCR/HCR_EL2.TID3.  Without FEAT_FGT, it is
+         * IMPLEMENTATION DEFINED whether TID3 affects IDs in the range
+         * that weren't explcitly listed.  We choose to trap.
+         *
+         * With v7, there is vague language about "not required" to trap:
+         * see access_v7a_tid3.  We choose to not trap.
+         */
+        if (arm_dc_feature(s, ARM_FEATURE_V8)
+            && isread && s->current_el == 1 && cpnum == 15
+            && arm_cpreg_encoding_in_tid3(3, opc1, opc2, crn, crm)) {
+            gen_set_condexec(s);
+            gen_update_pc(s, 0);
+            gen_helper_tid3_udef_el1(tcg_env, tcg_constant_i32(syndrome));
+        }
+
         unallocated_encoding(s);
         return;
     }
-- 
2.43.0


