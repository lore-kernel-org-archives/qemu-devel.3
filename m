Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A76F8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDamn-0005z4-Nk; Fri, 17 Apr 2026 00:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamm-0005yi-3z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamk-0006Mw-Kj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso2244875e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776399989; x=1777004789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2/j0lOvBO3DmQSFFQJaOFAPLEgLpTImUbZ3zpQz9DI=;
 b=ncs+cKY3R9yRhdRvBZBsd1op8zXPvMXH90+Td3d+lJ1ik72zBUQRL5NnnmQJhb17wx
 l9UvSqpE1PleHXdrGaoC5KWZpuonOmfBkjU3FOs2zi9RuX79tWQIi9M/BwOCRPjqKx4c
 DkwxnpWLfIsMPwIQ3pjFhoKmtYMEiVXti4JAruA396m4vbFfZ0I6qDXlbNNSLl06tXSZ
 X8WQftD5z6MA1IlXZ6GCU9bNTU4OnfmcbZzpP+jtW1uwJ/N+vgwhZFq4IKD5HO9CgR58
 ildZJE0o46VcyHLDYoM+hnEB9diTQD+qv5y2WT6hHzZbUlV3cra8algUaieymOguHfd3
 77qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399989; x=1777004789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r2/j0lOvBO3DmQSFFQJaOFAPLEgLpTImUbZ3zpQz9DI=;
 b=dqqhb1juqGeFxGj1trktkT2e4LN2X9zyK7+JwezWDhybRb7b8ybKkGxK4m1o6bRdgF
 BFYMz6ctR6/WgidCLTqTQjPW/DGAFEPlQuDnpPvwmCnEyZUWUiSqlCcKscLiMWZKsDZf
 xKpmn7KRxZBmXqi4xlSHGXyh+t11rvWl1tZP34dQrALk36yIwrJi+CUsnGa3moAxqkyF
 jUnKxkeKQrX9LIkPXdoQgS8RtN4tNPHRlx6VEA9/ZL5x18eJew/FlbE5kcU2T1AINCV+
 cWmm87oDJoznlrHc2gA+mc+ivyPzyU3cSrWiTI99qmYVun31OtQWIzwqCsdVaoui3GEN
 wYFA==
X-Gm-Message-State: AOJu0Yzlr7g5cpG0jbxNqKs4nQP6kM+EZwiuRQc9cwYRvfdjq32Mf9o+
 KqXQvwpZjiH+tOqAR3+y9nNzs50lHDuQFMfdqZO5WUVN13KhNSyXfTxOviOowYQU2ghqTRC+LPH
 wFLcmJLs=
X-Gm-Gg: AeBDietZOCjGr8ZzC4odRbndhZyN42mV8nx91HIIjEJvRgADI/b9mLVhBGozyhJs4/U
 7RkjbQFaNnupyQm2sCCaMkLjVZYV0sZSXCl5KhkA4AgRlzl2cYQfX4mOQQ+VvALaRqGiszqPZVl
 HK+lvMfBvzZsXfFiqjSuTyeFWGJhNPmICeRaiy/6jFZ2Z5Zb83CJmQWt19QzMGaGm//vnYani48
 IG4jpSPAKzXa61pN7Q/JikNubDw3QfgV9M8xtgsBGQptSvM/Jdim7Pq/DRh61KEzJEXY7mQKYam
 sJF5QREo4++qwowHIG6y0EDGv9AIxKYTQq2Y2MZ8/ozJJ4IVn4WpNoZp9L8cgvGom2M7owQtCyB
 ZYGEU4qll2pRL15iDV5rofrFgMjOmHc95pY7Rh9Mdl6XrKgrtWGjoX6wR3jP7bTrxF+cboJXW67
 GZxF/88PdEBA+FV0UzXhOTwFhKvcYOHGbbAbdB3L2tAqodOCIXJZdqPHw5CtNNbwL+WpZzKpxJA
 7dUxy5U5A/ciF8n3atLlQ==
X-Received: by 2002:a05:600c:3513:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488fb77a3a7mr14414325e9.16.1776399988832; 
 Thu, 16 Apr 2026 21:26:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm12609935e9.10.2026.04.16.21.26.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 21:26:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 1/4] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
Date: Fri, 17 Apr 2026 06:26:16 +0200
Message-ID: <20260417042620.35329-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417042620.35329-1-philmd@linaro.org>
References: <20260417042620.35329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
index 6d4b6412d70..839bfe18bab 100644
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
+    MemOpIdx oi = make_memop_idx(memop, mem_idx);                          \
+    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
 OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
-- 
2.53.0


