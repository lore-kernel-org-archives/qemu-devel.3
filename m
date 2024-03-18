Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E728C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9R5-00042H-7L; Mon, 18 Mar 2024 05:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rm9Qs-0003vd-LA; Mon, 18 Mar 2024 05:37:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rm9Qi-0000uA-JZ; Mon, 18 Mar 2024 05:37:26 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TyqSQ2Yvxz1QBrV;
 Mon, 18 Mar 2024 17:34:30 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B68B1400CB;
 Mon, 18 Mar 2024 17:37:02 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 17:37:01 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v8 04/23] target/arm: Implement ALLINT MSR (immediate)
Date: Mon, 18 Mar 2024 09:35:26 +0000
Message-ID: <20240318093546.2786144-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318093546.2786144-1-ruanjinjie@huawei.com>
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
EL0 check is necessary to ALLINT, and the EL1 check is necessary when
imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
unconditional write to pc and use raise_exception_ra to unwind.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v7:
- Add Reviewed-by.
v6:
- Fix DISAS_TOO_MANY to DISAS_UPDATE_EXIT and add the comment.
v5:
- Drop the & 1 in trans_MSR_i_ALLINT().
- Simplify and merge msr_i_allint() and allint_check().
- Rename msr_i_allint() to msr_set_allint_el1().
v4:
- Fix the ALLINT MSR (immediate) decodetree implementation.
- Remove arm_is_el2_enabled() check in allint_check().
- Update env->allint to env->pstate.
- Only call allint_check() when imm == 1.
- Simplify the allint_check() to not pass "op" and extract.
- Implement it inline for EL2/3, or EL1 with imm==0.
- Pass (a->imm & 1) * PSTATE_ALLINT (i64) to simplfy the ALLINT set/clear.
v3:
- Remove EL0 check in allint_check().
- Add TALLINT check for EL1 in allint_check().
- Remove unnecessarily arm_rebuild_hflags() in msr_i_allint helper.
---
 target/arm/tcg/a64.decode      |  1 +
 target/arm/tcg/helper-a64.c    | 12 ++++++++++++
 target/arm/tcg/helper-a64.h    |  1 +
 target/arm/tcg/translate-a64.c | 19 +++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8a20dce3c8..0e7656fd15 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -207,6 +207,7 @@ MSR_i_DIT       1101 0101 0000 0 011 0100 .... 010 11111 @msr_i
 MSR_i_TCO       1101 0101 0000 0 011 0100 .... 100 11111 @msr_i
 MSR_i_DAIFSET   1101 0101 0000 0 011 0100 .... 110 11111 @msr_i
 MSR_i_DAIFCLEAR 1101 0101 0000 0 011 0100 .... 111 11111 @msr_i
+MSR_i_ALLINT    1101 0101 0000 0 001 0100 000 imm:1 000 11111
 MSR_i_SVCR      1101 0101 0000 0 011 0100 0 mask:2 imm:1 011 11111
 
 # MRS, MSR (register), SYS, SYSL. These are all essentially the
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ebaa7f00df..7818537890 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -66,6 +66,18 @@ void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
     update_spsel(env, imm);
 }
 
+void HELPER(msr_set_allint_el1)(CPUARMState *env)
+{
+    /* ALLINT update to PSTATE. */
+    if (arm_hcrx_el2_eff(env) & HCRX_TALLINT) {
+        raise_exception_ra(env, EXCP_UDEF,
+                           syn_aa64_sysregtrap(0, 1, 0, 4, 1, 0x1f, 0),
+                           exception_target_el(env), GETPC());
+    }
+
+    env->pstate |= PSTATE_ALLINT;
+}
+
 static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 575a5dab7d..0518165399 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -22,6 +22,7 @@ DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
+DEF_HELPER_1(msr_set_allint_el1, void, env)
 DEF_HELPER_3(vfp_cmph_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmpeh_a64, i64, f16, f16, ptr)
 DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, ptr)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..21758b290d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2036,6 +2036,25 @@ static bool trans_MSR_i_DAIFCLEAR(DisasContext *s, arg_i *a)
     return true;
 }
 
+static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
+{
+    if (!dc_isar_feature(aa64_nmi, s) || s->current_el == 0) {
+        return false;
+    }
+
+    if (a->imm == 0) {
+        clear_pstate_bits(PSTATE_ALLINT);
+    } else if (s->current_el > 1) {
+        set_pstate_bits(PSTATE_ALLINT);
+    } else {
+        gen_helper_msr_set_allint_el1(tcg_env);
+    }
+
+    /* Exit the cpu loop to re-evaluate pending IRQs. */
+    s->base.is_jmp = DISAS_UPDATE_EXIT;
+    return true;
+}
+
 static bool trans_MSR_i_SVCR(DisasContext *s, arg_MSR_i_SVCR *a)
 {
     if (!dc_isar_feature(aa64_sme, s) || a->mask == 0) {
-- 
2.34.1


