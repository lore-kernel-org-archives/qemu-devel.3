Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC16CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpq-0006YL-Al; Fri, 10 Oct 2025 09:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpo-0006UR-Fo
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp9-0003vu-Q1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso1890208f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101570; x=1760706370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MSvmoSrAJV0PHNDRdiCeXCMzEorMA5U6KlLoiYYoLb8=;
 b=Jp0AYb9b9tX+BD9wDlnsFRl7y6do17NAB1bBm39nvLl9+ZsDgPNDjEVby50fxu76dU
 gY6DSsGHpOJNBc/pfDuHqap0z7SlsJ3RqO6k9TTMh7IS9DVxNEf+vFbgc85i+gFp2I1l
 9I8PUUVqn6yzN2Za33LRJmAcUIxUGweENMrRp9NN9qKXordzsw209ELgtC3pE2d8fRR1
 lRH98pD0ILO1ToeDa4LVrmsE5QPICZ5VrX8bpOqyBCTDmj2BRRU/wSb8wo98OoqcyLD3
 U4QjcinAy1z7vbaGmajRnVlHVZ7qR4UPKE3lYg8MrKpyVPwg4l/alkm5H7MCGHomSHKP
 n1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101570; x=1760706370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSvmoSrAJV0PHNDRdiCeXCMzEorMA5U6KlLoiYYoLb8=;
 b=UIwtId7mfkTmFhrV6Cq0rNoBzVCTsWLxu6HWBBtdbK3PTJefzHl/ozLAtSL0rZzT9N
 7nl7+0hdH6enw1WPUlbQ2KK56wkis9lbU/tGMQZTHSnSNlQVYU/Ni5Ih8n3pbqgUi7Gb
 XKBsnkk5pQvsgpVAgzajn1LlXZUoJgorZTGbyEXQgCfU8upz4y27iyIxvGR5TWsj2cad
 I9JE9NoQft21Qb8m52MXeUwQoqkPeDkTs4BskMiCo7sOrzTS0GlRgZ3qiIUUUZVEMDcH
 TgBcsiV+mUs5zi/Gh+Rpm6STw31ll5o0ob8FFS05T9MeZVZWnOio4R+0OQ6E5tUU6HTd
 uvnA==
X-Gm-Message-State: AOJu0YzYwx0kWhZPw0pGk8uh45ESmq31TE7aedZTOPrqlKO0A6L9lai4
 vlJ3ESS5ikuvxMluB74yDvibIw7Fm59sswobYxv8qmmylBp+Il1Odo85HZrMOtFfvFZTp794PYt
 5JTTG
X-Gm-Gg: ASbGncs5FyR2veoT9idrywB2nI/dycbWHedYq9bHnHzy2LwZra0+TRldn34+37tEgrQ
 LZHIi4CksdloyFXJchY39Ihf5HFcoHxHuzH2tBP2M2dZaphj6f+hdniwNcNm5UoSaygAy8PwtTO
 qku8juqvL3MH6wRTV/a8NlPy4MdyHTrnkgLp3Vccq5nqS2rUp6ElcpJQk7yvpUCq5OFDTHbjUbh
 Wcl/pzlp5LCe2xDds0gFeEtxPU+8arBipH5+n9mFWAAfyk3MxLyUPKq0DD3fvh2aSMZnIYgQHCT
 JEtTBBP5+U+qpeLHYIrbHajvtCTedzLW9jBXhII79GzTxU/9ami1IyaUAqgQCbk/MoKLt8jfNCn
 LyPTYr4lpj7JYbPUjwuwjM93OUHjIBNmU2Kp03Fr5zkv/FbQdSlBK545tcN5cAw==
X-Google-Smtp-Source: AGHT+IHBYYq0SSa26Yiarw1d+oFjkaSog5I5DWzqGHjO70xW0bzhJKcxHV6c12vfTzn2Nm+5YcMqdw==
X-Received: by 2002:a5d:5f47:0:b0:3eb:c276:a361 with SMTP id
 ffacd0b85a97d-4266e8dd630mr7793595f8f.54.1760101569583; 
 Fri, 10 Oct 2025 06:06:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/76] target/arm: Export cpsr_{read_for, write_from}_spsr_elx
Date: Fri, 10 Oct 2025 14:04:46 +0100
Message-ID: <20251010130527.3921602-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move cpsr_write_from_spsr_elx from tcg/helper-a64.c to
helper.c, so that it's present with --disable-tcg.
Declare both in internals.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h      |  2 ++
 target/arm/helper.c         | 20 +++++++++++++++++++-
 target/arm/tcg/helper-a64.c | 20 --------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 109aa104bfe..2a85ab762d5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1897,6 +1897,8 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
+uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
 
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 64b6c21aef7..def4edf808c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8896,7 +8896,7 @@ static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
     }
 }
 
-static uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
+uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
 {
     uint32_t ret = cpsr_read(env);
 
@@ -8911,6 +8911,24 @@ static uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
     return ret;
 }
 
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val)
+{
+    uint32_t mask;
+
+    /* Save SPSR_ELx.SS into PSTATE. */
+    env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
+    val &= ~PSTATE_SS;
+
+    /* Move DIT to the correct location for CPSR */
+    if (val & PSTATE_DIT) {
+        val &= ~PSTATE_DIT;
+        val |= CPSR_DIT;
+    }
+
+    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+    cpsr_write(env, val, mask, CPSRWriteRaw);
+}
+
 static bool syndrome_is_sync_extabt(uint32_t syndrome)
 {
     /* Return true if this syndrome value is a synchronous external abort */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 6d77fd0113d..eaea7859d35 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -615,26 +615,6 @@ static int el_from_spsr(uint32_t spsr)
     }
 }
 
-static void cpsr_write_from_spsr_elx(CPUARMState *env,
-                                     uint32_t val)
-{
-    uint32_t mask;
-
-    /* Save SPSR_ELx.SS into PSTATE. */
-    env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
-    val &= ~PSTATE_SS;
-
-    /* Move DIT to the correct location for CPSR */
-    if (val & PSTATE_DIT) {
-        val &= ~PSTATE_DIT;
-        val |= CPSR_DIT;
-    }
-
-    mask = aarch32_cpsr_valid_mask(env->features, \
-        &env_archcpu(env)->isar);
-    cpsr_write(env, val, mask, CPSRWriteRaw);
-}
-
 void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
 {
     ARMCPU *cpu = env_archcpu(env);
-- 
2.43.0


