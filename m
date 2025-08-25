Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C176CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVGD-0006f9-VI; Mon, 25 Aug 2025 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVGC-0006e9-Ey
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:12 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVG8-0004Xd-1t
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:12 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-55f4345cfd3so975506e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756120865; x=1756725665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aZ7WRieTxHOe4UDLjbjFmRke7uWAvoTTSDbNjcwRWk=;
 b=I/C/Z1HKYXDcT24mBJ/M988sSeKoJipxUumCWXy+IWzbiU5ONgdBUdG2fysB+t/ClS
 DOUfHlUNq1ziM+dXVlyrqEGTsTHinly4DmOaP9o176mrK4pdM0SB9bgiMrNhsHUtJUtx
 7m1FE80IMkcutZURtKqqYXEc9/1LKR74ycoO/sz5pbl4lCP2kFVLBVhFy143xVY47F5l
 dFfl/xvAGSwo+kmBowJbRh5Cs0tdqTfP7ikgDQZylnbrm3C3VGs1m7ODiecRMZXcUGYx
 OL/9hTfzl3ULTht9SaqktOh9SZSkLurCRo78aZYpc2Dyt61sWgF5fGewPNC5p4rjfDKb
 w7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756120865; x=1756725665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aZ7WRieTxHOe4UDLjbjFmRke7uWAvoTTSDbNjcwRWk=;
 b=uRHOyRTrwP9DDcZppVQrqLaF5Jzgoa04gB5wcI/MzP3cgnL8HU56rj2MF/SG6unflt
 Rl3iyrd18i5w1ZnMfLEQlIUa+rb938J6ci/wCqbgHyWnGrU655a8E80McZEY7vdKQQAh
 A4ApESEu0feL4QKc+CririB69ENeT2ruBDGozwC5HhiDR1vOj4h9k/L0GuZb1652qSKD
 EwnmwNgVk3Dk11FYw32N4ZhL/QPsNwkhmyhFJ893MBEg7M/IhKqY2S1ve7Ll9Hum9Zak
 SZ0ITX30r368es87AMelQfbabxTu1Ww0BSoCEt0LZ6q1V7a039bNFGVB6OvKqAlU+lej
 8oCw==
X-Gm-Message-State: AOJu0YyUU3l3/sgvM+5y4gtBpPkpZzO4UKh1FcLsXrhBvRxs35Vk9uXU
 KIdgbftQGMM6qVMzgrTMqTCS/Rrv5lhjtOeDYGtoFHIQ++aS8tJQpd027Xz+m4Ik
X-Gm-Gg: ASbGncsrNJONdKlpZQ/EqGlB1b3RcRuFgLiBrk6X/iwIdApdOaBVKxsKOUQ2C1UhiA+
 SI3lXPlK4j1x/dVAS+sjms4z7cAx9OLfDne3GPR9etlOW6ojJhrDXfNURHfDdm+BEtS1bEphQ8W
 doGIpePxRQfmHvXaF8RWUKrpuBNahEsQCWI7/fcENSTKhJlKycfXT7Y7IOYpULSSVUY7MedYKIc
 NuAkI75vSfkD6rDmPoEozQOXj/4LuBZOKJplv+zWRbdctqxMpZm4AuX6nSLpkO0b+mbrMvy0VVk
 LZbYT+ba7eXvwJp3c2d5DfqCN1wTsh0q8uLfzGPOi6Vt86QnR8ekggWEL9XfUsfO6cdNV7yO3Hp
 eIRkCrZlcujeUi3JooaBIrfIzMFg3Uz6nBtOLLq7qMfBTpzceWW99VxZuTQA/n4CrQRMSJgDAtl
 iM1+0j
X-Google-Smtp-Source: AGHT+IHrU4+/yqDnrB3rzj7p1jBysBENok775/oufxYhWUlAg17VzBUxJbRbBs/u/lIG8wvdfdiSWw==
X-Received: by 2002:ac2:58e7:0:b0:55f:3f0c:e267 with SMTP id
 2adb3069b0e04-55f3f0ce489mr1203342e87.17.1756120864764; 
 Mon, 25 Aug 2025 04:21:04 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c8bce3sm1591036e87.95.2025.08.25.04.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 04:21:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	philmd@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 2/3] target/microblaze: div: Break out raise_divzero()
Date: Mon, 25 Aug 2025 13:20:50 +0200
Message-ID: <20250825112051.4155931-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
References: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Break out raise_divzero() and take the opportunity to rename
and reorder function args to better match with spec and
pseudo code.

No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/op_helper.c | 38 +++++++++++++++++------------------
 target/microblaze/translate.c | 12 ++---------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 470526ee92..fbc9c8ca4f 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,38 +69,36 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
+/* Raises ESR_EC_DIVZERO if exceptions are enabled.  */
+static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
 {
-    if (unlikely(b == 0)) {
-        env->msr |= MSR_DZ;
-
-        if ((env->msr & MSR_EE) &&
-            env_archcpu(env)->cfg.div_zero_exception) {
-            CPUState *cs = env_cpu(env);
-
-            env->esr = ESR_EC_DIVZERO;
-            cs->exception_index = EXCP_HW_EXCP;
-            cpu_loop_exit_restore(cs, ra);
-        }
-        return false;
+    env->msr |= MSR_DZ;
+
+    if ((env->msr & MSR_EE) && env_archcpu(env)->cfg.div_zero_exception) {
+        CPUState *cs = env_cpu(env);
+
+        env->esr = esr;
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, unwind_pc);
     }
-    return true;
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return (int32_t)a / (int32_t)b;
+    return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
-    if (!check_divz(env, b, GETPC())) {
+    if (!ra) {
+        raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
-    return a / b;
+    return rb / ra;
 }
 
 /* raise FPU exception.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5098a1db4d..2f5fd5c271 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -450,16 +450,8 @@ DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
 DO_TYPEA0_CFG(fsqrt, use_fpu >= 2, true, gen_fsqrt)
 
-/* Does not use ENV_WRAPPER3, because arguments are swapped as well. */
-static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divs(out, tcg_env, inb, ina);
-}
-
-static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
-{
-    gen_helper_divu(out, tcg_env, inb, ina);
-}
+ENV_WRAPPER3(gen_idiv, gen_helper_divs)
+ENV_WRAPPER3(gen_idivu, gen_helper_divu)
 
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
-- 
2.43.0


