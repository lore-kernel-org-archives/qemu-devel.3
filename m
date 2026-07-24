Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1215C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Jx-0004ZX-4u; Thu, 23 Jul 2026 23:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Ju-0004Rp-Qn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wn6Jt-0000TP-1t
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:11:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso996360a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 20:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784862687; x=1785467487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhO5s4iul0vXK1Y6GJ3YB3gbLNm60bTy/KydQifnUiw=;
 b=DYCczGwh8nCbEn75SPXwQ1jbPGUGt0hChJrpl1K3WowATUGJRpqaHislBNF5ri9ZsK
 wMoobxO5ouU3A8f8TJKwGY77nQtVsSftsIXBaMfJSCstV3dMNmo5EocXwFrMqtT7psvx
 Tj6R7lZvGbOyIwV13kBHbaxPaY2IGFdMxEaa5jg5DFNf4Xf22CQNxVNnec1AZt8WTVDS
 tpLLRMS7SuZ2mP2PVPkxuDwJvD4oUP4SwtyTWkHrMScxkTaGXDRKz3tLL3SHVuS5D1Qv
 JgXmpBfKwAUC/VUfNeqO1YlO37ulVSCpQ5Xa1ik0i3yQtf5oJZm7laNmoRQ37M1MGi7w
 1AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784862687; x=1785467487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhO5s4iul0vXK1Y6GJ3YB3gbLNm60bTy/KydQifnUiw=;
 b=Q/2WT+eN0iVD9+KADKuwpVypL/K51DeNjO7ghWZDAWG2iqConG/+URyLkcUVsVhq7Y
 10JhiQYEDpXV0JKA+XkirIVLlX7WtgAOSr7GpVgM8Sh/0UIiZYF12QrYaZKShqRiHQQm
 jJ36KFMtVtPWaBG6G2dbmaszlRs8cJx01mTv+ncXKuzySV2gM/SCpBf9Jo5lYSs2Mbyx
 k9Mxbr7BBu2FaaWlUpGUQPUqjhxRU/Sta2tBL3Nx8bbd7w1HA1V97mrnt2hwKi7Gu6ky
 r95wVbiWznk6+AO/u6Fep434+qVaBBphglkVvilFWcDBvOGY8fbuxXsRO3Vkwhpr6JGT
 8a0g==
X-Gm-Message-State: AOJu0YzHkW49mAiXSxrCsvNbl0npa70v7uLePRMOEuPrTvi4xtrGfykn
 IgS7guep3ldnTZJIxsfYLYQ1Xjbm8kPvfBOTuQ+9dYE6r4NhsdhpGV62ajWNjl1cnJ+NHIHwaIx
 j1z5z
X-Gm-Gg: AR+sD12S4t6ztzMRucSBmI5K2CzOj5d8rOJ00glOPKmFDwbRPgRales7KD5635PaX3f
 7llWtdpJLCk8Yy71hYQ2DRVIImP/JmJv8j5Gw3ajq7A04fhRnK4O8Gex/UvJKYLsBmZzznzVJni
 BdFU4Z7lF2TnGQT7wNYel0ky44BLOlnkzRReIvgco7Iy+U6nnyfN+B9Lp2J0dwnbOCp5Nl4DKqi
 t6cdvP4C+59luxBGmUHo8UGjQhw3h33nV3UhB9vQk8CxroGlz+RZ+0M1aad0KAhppVGvfO1RDcg
 jJ9pak02znNGcOkAgpoUwzxu3T3ffEppQu/i37TlwKqRMhTYqgvaG3Cp6+aPojJeKy8395/SA5q
 WHgxPxGLkXXPuigLlogm5fdo6wCXAPYeNTuGmcQXIGOGsQI2g3crZlOoALPdTOiaxI5IXupEkn8
 fhfTMzf3WaYdZiMiPXdk6M5w/eyTP//oW7BFO54IE64g7b
X-Received: by 2002:a05:6a21:7008:b0:3c3:8de3:8eee with SMTP id
 adf61e73a8af0-3c44b222849mr6443688637.61.1784862687359; 
 Thu, 23 Jul 2026 20:11:27 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbb8f0d872bsm3617697a12.7.2026.07.23.20.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 20:11:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/6] target/arm: Implement HCR_EL2.TID3 trap on undefined TID3
 registers
Date: Thu, 23 Jul 2026 20:11:20 -0700
Message-ID: <20260724031123.76597-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724031123.76597-1-richard.henderson@linaro.org>
References: <20260724031123.76597-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate.c     |  8 ++++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

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
index d4186b3d0a..93336daf53 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1187,6 +1187,25 @@ const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
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
index b45e1b28b2..7e78d62496 100644
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
index a1fc050618..3fa15f493a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1824,6 +1824,14 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
                           isread ? "read" : "write", cpnum, opc1, crn,
                           crm, opc2, s->ns ? "non-secure" : "secure");
         }
+        if (isread
+            && s->current_el == 1
+            && cpnum == 15
+            && arm_cpreg_encoding_in_tid3(3, opc1, opc2, crn, crm)) {
+            gen_set_condexec(s);
+            gen_update_pc(s, 0);
+            gen_helper_tid3_udef_el1(tcg_env, tcg_constant_i32(syndrome));
+        }
         unallocated_encoding(s);
         return;
     }
-- 
2.43.0


