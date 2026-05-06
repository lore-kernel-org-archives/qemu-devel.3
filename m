Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8A7CD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsV-00043F-23; Wed, 06 May 2026 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcs5-0002wE-Pd
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcs3-0001Mn-Sw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso48843405e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076301; x=1778681101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tvq+099Ewmsxo5/FLHJHRAl7PF0Oc4kiXLP6AKah8Jw=;
 b=QGVacd4b4tyx5zXgAEfVie6HksNNZ4MvTU33hhg8GmqcTorvRpO2d55rqFZyI0dbuo
 jo0Ytcd+t7LeBheS4y+wiUIsFW2WJMdA82d/nkopb/apPINty3ElcQIvQ5aPdMaZVjOM
 mXxuBUlLhLwHDOqAdouqvPLR8UyPeT1JN/B5zAdQmdzcmUN+EXzXGtGxdHE37FuuP6pT
 qtIvxvo41RYRoTvFbhLsdM9TpuSRUJQVOqIOFuQU0F13BLe/FSLxgONarHXMny5AT1RU
 HEjooWlKvC5Vv7Wy66vMBxcsabE3aTfxTZvIlE2Hxp16389+xMAH1KkZyXvfETZIpuL7
 sCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076301; x=1778681101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tvq+099Ewmsxo5/FLHJHRAl7PF0Oc4kiXLP6AKah8Jw=;
 b=oTGwPEhBh6uQDZNZT/Uq6pnaYfYErnQLeab/Z7gQs6w1HvzRthWuJwvdGeKJMfm624
 MRyEB4RxLC3HnakohUBmQdUZBQ4/6qHqhiBN7W3UyS8SX3jZdJvZQNnkndBzWX/FGWwx
 3Z7W1XYFxE+IISPIWA3zzY80/DS8fjl8tM0JQUJFwsx4cIad763i3a2NyBWpZ5epb30r
 9I+VeFLPp3/4cxPt/dqsmubPuK1l3myKEQ1SrCq13vRbH5DO5NWeoHaSFssWRXE6PL2C
 ygpiZMRXQpabBlm4cXLlqInpii2M4cLQSA0ATGjXL8FHHHsz/kvsIb0G3lQmoGN6bq4G
 98iQ==
X-Gm-Message-State: AOJu0Yw9WaZLKIuokUg+ktALAvRQ39kLxQvcpFeP3AWuh9gYm9xPYG7K
 ZBNMAnhxfiBLG1h6HzA7RFl5EY783IjvTAhRv1BJzv3qYSUuhzzj9m66jlILnCBmpyPb94wU5ha
 ApZ9YQBE=
X-Gm-Gg: AeBDietOjxUXe+vfnGuuifaqjQxcwZ4R0VX+22Gc7RqV7gFzuAKSsFK+OnIIqHfHtiX
 AVQD/h6KhCGzmzSIcm51k89IdqTck7l+dei7cU0qGoDoJntNACfxGoZ46blKLMgoMVBHpElNAYp
 KvZUC6bjl9RmnmifCuBVt+VMB9d1Hk48FY0vR2ajC4xW/uQDHg2UeBvquNvohQE6vZtaWBpbesj
 RPOiQcOTDcZX7+szoKOpQIK/9RYY3aoV+2M8sL3sUpblZeRdHSjtBZahdNeV4rPODitSS2Z6dS3
 cbA3Fi38wBO+ONE3FZNT7s1c9wWqNrUGC73cDgluWXjA5dFQcBd1FdsOH/QlxfoSJERfVMXMGXV
 +SF7Ka7UDJieB0ASbvruKUcZDNAjaIikLGTM7Vet4vVzM35N1ImxORRQi8u9v6CKJ2X76lHLsqD
 LFgzaPEd0dPKakWZ4X6sqSojESGxMjvC1dOYKWmN0NSpIxTZz039M0V/gKeOxHuPOzkIxK9VYY6
 YAFja4rxk0=
X-Received: by 2002:a05:600c:4256:b0:48e:51f8:eb39 with SMTP id
 5b1f17b1804b1-48e51f8eb5amr35596455e9.28.1778076301020; 
 Wed, 06 May 2026 07:05:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm47117065e9.11.2026.05.06.07.04.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 073/110] target/mips: Pass MemOpIdx argument to Linked
 Load/Store helpers
Date: Wed,  6 May 2026 15:54:45 +0200
Message-ID: <20260506135524.20617-74-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417042620.35329-2-philmd@linaro.org>
---
 target/mips/helper.h          | 4 ++--
 target/mips/tcg/ldst_helper.c | 5 ++++-
 target/mips/tcg/translate.c   | 7 ++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index b6cd53c8538..e2b83a1d19d 100644
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
index 537f3e87bc0..b36b12d87d6 100644
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
index e334cf98b78..ee6199875cf 100644
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


