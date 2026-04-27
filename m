Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D156FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUW-0007wv-E0; Mon, 27 Apr 2026 08:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOC-0008KB-BI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOA-0005p1-Fn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso53245405e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294117; x=1777898917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=88UCjHkoy1vmDeZmG5DzL1f9FS5Tx4PV0gRNHIRsxWs=;
 b=qRf2jCiE0yL8tRM5SQO7KUSHiqaRGrEwNxBKbEa/0BVFecD59BZ17407o3Uk2leGGG
 rzBKJVUCJ3ICRsUkCh/j7foL0F5t8zrlFJj69syS/5Jps6QXTx2pUY0i+iDEsrfYTNGJ
 jwgppGpuPm/Qxnx1RmLgDwN4iClRKjsEFCtvvPqVJr0Cgl9oU/wo/CcAbK0gbPRKG00y
 EMOgO6tik2XpJqNwkCKmjZIeIb1psKyvVGulERqLqh3n5z4Nqj2rwRWWmwPHp8XJwXYz
 yTbIywjx0LDrwCu5TuOTH/1V1RUFyLXzNHU/RUqN4htT/OwfnRV5RfVN1ML7Y7QHsXvS
 YDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294117; x=1777898917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=88UCjHkoy1vmDeZmG5DzL1f9FS5Tx4PV0gRNHIRsxWs=;
 b=gGu2IIXkzIpuNFaK/Hu+eeN8ERdbVtYjTEBYiyxaCdlMj3cxzUdphO6jO0n/ysovNj
 /xqrHd6/mnPiXeJzJRen4zVJlTkFaW62RsSnVBQABuuVXFWQYBVS0XZ2GZVrpYeF0oO8
 PaPAJ6VBGcKJdMPvd6i8wZypOe/NOOeVjDBbwgvftHqlnM4DiBHMHTxFP10reEmVRwlM
 rlp0pDjFgFspYZ44w6MTjiTCqVBPVzwEgEcduU0XumnMNgg0lE5SHO3wDEQcDUZMQDWN
 2XfvOFcbev5MEcGbCD0R+OEehqR688O7YQO1b29U7hB6mtSq2X+SAroJPPA2ubEXUxGh
 htcA==
X-Gm-Message-State: AOJu0Yx2mMJrva754NzOSKQihq+KnTuuhMVr2/TA2HPmfJjAPj0cMDnK
 gOM1a+oHeYlXLxWgReJCTpUYwa0a+V47flT2ZzrIVlxgazIJoxorqZ8ADUBiQr6yd86yNnw3qYD
 D+kWI
X-Gm-Gg: AeBDietIiAH3zaee734NGqsX3Z+jbV/UgKBPZLyRG47JfsxlnbJqKz6YrmGDSl0bSpK
 fB2xOSjELCpaps4Ly+RWWFna26Lq+TcE4UOPzer1Pah2G++5LmT9qcjGexdBoiAbWiPeetIOOBG
 hb9CfzDwk0kNizXDCMGmBHKYhaG4XEsyX3Jpgnit3lLEvlAV+Eo/52DNDpojJfl2ODStQNgmbUI
 gNEguH6cIlT+tBfWEZNLcrOoWT+yFahcVEqTi7yxXzyJOrZHa78eewVst0R1nr724EbLRh1BGeq
 UZdksdsTufN+PSwb3+/QjGo//sjM3lLjun8+SoKmxBI21V1Mo0y8FZ5Ho5qom767Xz/+CbqTFVF
 8sqFbaZKQFodHFhbhzcZVZ/3uT/7SoheEW1XkVGRbqf1/SwSylpyAIKlACxowiDs9WvBBHo5El/
 +gtECHjhkB6SKIlyIAkR2pcRaAKRKT8ASq1zzlUQ9oERFFVROU8Z2xMSHmrM0IxPfuyzm1JmE7R
 h2HSKloeXh1KPuMriK4llLJ22PPUXTfpi97cULrkA==
X-Received: by 2002:a05:600c:8b8c:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-4891d7406famr512996805e9.29.1777294117004; 
 Mon, 27 Apr 2026 05:48:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/63] target/arm: report register in WFIT syndromes
Date: Mon, 27 Apr 2026 13:47:37 +0100
Message-ID: <20260427124738.966578-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Pass the register number (rd) to the wfit helper and report it in the
syndrome ISS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-24-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h          | 11 ++++++++++-
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     |  7 ++++---
 target/arm/tcg/translate-a64.c |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 04a71eebcb..4d1f1c529e 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -670,7 +670,14 @@ FIELD(WFX_ISS, RN, 5, 5)
 FIELD(WFX_ISS, COND, 20, 4)
 FIELD(WFX_ISS, CV, 24, 1)
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
+typedef enum {
+    WFI = 0b00,
+    WFE = 0b01,
+    WFIT = 0b10,
+    WFET = 0xb11
+} wfx_ti;
+
+static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
     res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
@@ -678,6 +685,8 @@ static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
     res = FIELD_DP32(res, WFX_ISS, CV, cv);
     res = FIELD_DP32(res, WFX_ISS, COND, cond);
     res = FIELD_DP32(res, WFX_ISS, TI, ti);
+    res = FIELD_DP32(res, WFX_ISS, RN, rn);
+    res = FIELD_DP32(res, WFX_ISS, RV, rv);
 
     return res;
 }
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 5a10a9fba3..a05f2258f2 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
-DEF_HELPER_2(wfit, void, env, i64)
+DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 75ad53ec6c..e8f0996ed3 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -398,7 +398,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFI, insn_len == 2),
                         target_el);
     }
 
@@ -408,7 +408,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
-void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
+void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -427,6 +427,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
+    uint64_t timeout = env->xregs[rd];
     /*
      * We want the value that we would get if we read CNTVCT_EL0 from
      * the current exception level, so the direct_access offset, not
@@ -447,7 +448,7 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFIT, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 48b5c57255..9a27c4c6ec 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2065,7 +2065,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *a)
     }
 
     gen_a64_update_pc(s, 4);
-    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
+    gen_helper_wfit(tcg_env, tcg_constant_i32(a->rd));
     /* Go back to the main loop to check for interrupts */
     s->base.is_jmp = DISAS_EXIT;
     return true;
-- 
2.43.0


