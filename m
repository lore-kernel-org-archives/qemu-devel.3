Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15DEF8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOJA-0007mc-7e; Thu, 16 Apr 2026 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOJ8-0007mK-AU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:06 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDOJ6-0000jx-Ov
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:07:06 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso3544999f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352022; x=1776956822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHZbH8NF/lYrzFgfuFqRfZFX4V6yynxs314wd9vwmAA=;
 b=ZUbzEHsUSRdkI0ONEyZUySOV5WdX/IC3ceezWvTaoDjWVz/y4/xVJKRXxM5Kn2HBYK
 G1c97OxkBHdewQ7R4jh+SWHgxLFhWouiJYRKyNUf9tiM/lQ79K7w5so1t5jrmVVQT8XL
 68ZIgLByUHFaAc4YnOCOflzyf7gTxnnBpPNVoK5G0ubpQqDpopULBHgSslspnwrC8EO4
 dObAAR0gyfuDNi+AgMiifZDsUUDHuPdrLASikSaQluccMdld9CYs+i4HmKtwUfSAKopH
 CJ2hrZuwCKGVqOflo6O9s7AwaIRz8F7Af94L6SvpdgWcJSlB3NY3PeRdFfY5vO1FfEmu
 tG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352022; x=1776956822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iHZbH8NF/lYrzFgfuFqRfZFX4V6yynxs314wd9vwmAA=;
 b=jH260RdSJ+EuaJWt+265jVoxqXqkU4CTDbffIQnmRcFGildxs9+SQoGuxLga1bSKps
 p5R/jsdaWEam/+bjSdWGk7DGCco/ujVPHQLBNTT/5jfTFPgmlNk64uFo4aO4rhYwzZ4V
 u4ctm0rBnTTPj8eqgzBi77QH0RisrROtFU61CSDxfQqBfTUjcLJnjbg0DbQfW4+xw1/9
 kKFIh1otCZ3WY6G3tEZGmm0YhJnmj4lUaA/hLFQPCIt87BdTzdXy4SOZXpPjgr0jubeU
 WRuQO925TZOITnATydAHrY2YiHeBVKgYVm0DpI+1kk4fYutWqUFSalIyRkMkyMlaPR/T
 /kCw==
X-Gm-Message-State: AOJu0YxjAfcN1QrWU+EELW/p21qjMA/+FOXYGychCNW7r56fL8z/BZQH
 8zdrd73MJcpE+aHr4s2BUwWMTjbVuTOgAnwA3y7oybwBxdwgovJWTp1LoP9ru97ogcIP8bEnI1N
 jclpq0R4=
X-Gm-Gg: AeBDievR+EOAAtf5Ksuj07UBZF3lzIlbtgrgjYMIVRMGyKKpWLcWN51GjFX2utUpIi/
 3vWikbVpkIjC5DNa270MPt+4S8vDPExordeUy9t5xmbFqVGeEwWR1gAiaNL9CNob9RBVVgwoxhP
 QIzuvrKe05FWUNMLZNcgYhjk/3EMDqQ+ggg3G1DnJxSNhgqssZziCGvCq+zuB1PsmnQnvP/YAvT
 lllKGsExq1E6cbTqkcRihnn8EuqxumtVWTa5splHlhT9WSSy5AiScOc9UU9UiNBsCU5TVojFuTA
 ZOFUyGGpcOCTF0u1il/gnBL3MypvlU0BOiRjvKRyC9p4zvC+DUzQSnNYbfuxkqYmeoFxNTcvRpI
 vloQ9Uj9fnpcX5FgHF3s3vM5tU1MZ8wt9WCmKgKzCRmjLtkpHBhD0iDO6LWfFEdlRMQGSQhsmgZ
 VugHdQ0OZ/rWzFpzsoXLZ9ImB4ortDdK8v807SbHDbm6LRD4lCphMP8W7JiH1kiSb6QeOAMBRM
X-Received: by 2002:a05:6000:2dc1:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-43d7af03e24mr22688225f8f.29.1776352019989; 
 Thu, 16 Apr 2026 08:06:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5c8fsm15254949f8f.19.2026.04.16.08.06.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 08:06:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 1/2] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
Date: Thu, 16 Apr 2026 17:06:48 +0200
Message-ID: <20260416150649.23671-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416150649.23671-1-philmd@linaro.org>
References: <20260416150649.23671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In preparation of using the MemOp content in the next commit
(thus stopping ignoring it), pass it as MemOpIdx.

The helper prototype declaration always took a TCGv_i32 as
last argument, correct that.

Rename the ignored 'mem_idx' argument on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/helper.h          | 4 ++--
 target/mips/tcg/ldst_helper.c | 5 ++++-
 target/mips/tcg/translate.c   | 7 ++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e70a3942fac..10c6470514d 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -10,9 +10,9 @@ DEF_HELPER_4(swl, void, env, tl, tl, int)
 DEF_HELPER_4(swr, void, env, tl, tl, int)
 
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_3(ll, tl, env, tl, int)
+DEF_HELPER_3(ll, tl, env, tl, i32)
 #ifdef TARGET_MIPS64
-DEF_HELPER_3(lld, tl, env, tl, int)
+DEF_HELPER_3(lld, tl, env, tl, i32)
 #endif
 #endif
 
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 10319bf03a6..b725c6d0333 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -30,8 +30,11 @@
 #ifndef CONFIG_USER_ONLY
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
+target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
+                           uint32_t memop_idx)                                \
 {                                                                             \
+    MemOpIdx oi = memop_idx; \
+    unsigned mem_idx = get_mmuidx(oi); \
     if (arg & almask) {                                                       \
         if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
             env->CP0_BadVAddr = arg;                                          \
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6d4b6412d70..4889bd1e518 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1922,7 +1922,7 @@ FOP_CONDNS(s, FMT_S, 32, gen_store_fpr32(ctx, fp0, fd))
 /* load/store instructions. */
 #ifdef CONFIG_USER_ONLY
 #define OP_LD_ATOMIC(insn, memop)                                          \
-static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
+static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx_ignored,  \
                                 DisasContext *ctx)                         \
 {                                                                          \
     TCGv t0 = tcg_temp_new();                                              \
@@ -1932,11 +1932,12 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
 }
 #else
-#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
+#define OP_LD_ATOMIC(insn, memop)                                          \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
+    MemOpIdx oi = make_memop_idx(memop | MO_ALIGN, mem_idx);               \
+    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
 OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
-- 
2.53.0


