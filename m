Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F670C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutl4-0004df-Vm; Wed, 19 Mar 2025 09:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkI-0003n9-F2
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:13 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkG-00048f-9n
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso414940f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391966; x=1742996766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giq5jVWaUOn7Cy+Hw51AnglHBMySE1InchxU7/kS33s=;
 b=O1R/6uBH+i2igYFfMo5PK8/wZF6/mVztD37pLm48XHaRsmX20ZnbNkwgPP7nBzCUfO
 fP3V7nxcbgYDTYnsBGjXlYHD73MF0d/l0zpaoRJYSqDKZT6kKcwFz5E1gauCEyA9h4OW
 KrKZtEHotvdnw/h+YoQ76gMZvh0RpPjUApMinaI8IPMoyvqG1vCJeOhkm8GocBxMoqzT
 VwPozpRGwvH3nwnGxH1qft48pT/kqcAkS/c8veJAPaq7PUPI63COPQUTZqlO+TpsrWDF
 lhVpqvPyVb11JWpyrB9Gri4sPqGfWwnTOGL1XqmFFQLUIfQz9xx8O39ta8F2F9YQsmza
 Z7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391966; x=1742996766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giq5jVWaUOn7Cy+Hw51AnglHBMySE1InchxU7/kS33s=;
 b=YSosoWVHVFsgA+5lkSRFgWnz5lD6gHodqrZcmMOc3a3MbcNl81TrgAQhbzpgsG3rco
 49YHlkb+f1+inWUYJwWMhNi/n9aK7J24T+NOicHqo7cYD5diWmuKFl/Yt51FboGpemTX
 wMp9+qr7YGP2dbUL993ecZ6UotyA9uXqB+x67Y3oyX9xi77Nn6rRYbMmgFUdab50coe5
 3Y7AZNHRqQandmlchzv412QotSQykyGDM1ermPd67yt38gZfaYvkxqAEiDY+M0n2p8Ea
 RGWQipqPIhEhaY23wnFBv19paJzTXRCiVcWaaXTYznKSTOiR+UZGfEKwfEqi/7t6BST6
 PATg==
X-Gm-Message-State: AOJu0YzYacPP5eRX7n9hYsg+BqtXewntwygaszaCXfAYr98av6dOTQ57
 R4hgKuzyaMlN6P2/wnvNxoXDfsEJp16OqMlMKkZ6bJI+yEsgfTDNf3dQWLdBIZDrrqC3H2a5YNN
 3
X-Gm-Gg: ASbGncsJfOcmnVyWKflwEaijrYJGpA52xo6eRTbvm4NfnL9S08bO7qFXTE1snLPCzSd
 IX4mLwXhtNOeiBdT4W9eu6c83fH+urj/G+WhIGZDgjFGOT413Vcw8q+b7pF1Ssq9pmQyPibCJYs
 Jx+X8EUcmb48kKdLZz2vdhQh5Jdw4UQZ4dGckoonjfVkYOJWbbWDtjvGByGybIiR1zSELdnTiMs
 1Gmmk+I9fgurr9HpaVksVf1N3GISujpCGgLX0AQQw4Bv60iX/i0YJgU+mr3gSCJvRgJEbK2Lrdb
 ONQjtHetAKWQAFNHkqbzsyA327+zlrsQC98x/hjfX0kqMapz8pAMuUzxfBnNqApuLV92WI2gKX8
 JXBqfYujpaxhbv3FCrG8=
X-Google-Smtp-Source: AGHT+IFE2eR3qjdmLyouXQp4PcOAXlZIAbBD/kRc4fLt4hHhKuBEB/NtxA27zukszUAReDELudsMPg==
X-Received: by 2002:a5d:47c1:0:b0:391:39fb:a4d3 with SMTP id
 ffacd0b85a97d-39973bf74a7mr2064119f8f.4.1742391966240; 
 Wed, 19 Mar 2025 06:46:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdd0sm21104325f8f.77.2025.03.19.06.46.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:46:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 11/12] tcg: Unify tcg_gen_insn_start() to handle 0 or
 2 arguments
Date: Wed, 19 Mar 2025 14:45:05 +0100
Message-ID: <20250319134507.45045-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Merge the tcg_gen_insn_start() definition using no extra word
with the definition using 2, using a1=0 and a2=0 in callers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h             | 15 +++------------
 target/alpha/translate.c         |  4 ++--
 target/avr/translate.c           |  2 +-
 target/loongarch/tcg/translate.c |  2 +-
 target/ppc/translate.c           |  2 +-
 target/rx/translate.c            |  2 +-
 target/tricore/translate.c       |  2 +-
 target/xtensa/translate.c        |  2 +-
 8 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index df234d4e1e0..cf177a1fd3b 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -22,16 +22,6 @@
 # error
 #endif
 
-#if TARGET_INSN_START_EXTRA_WORDS == 0
-static inline void tcg_gen_insn_start(uint64_t pc)
-{
-    unsigned insn_start_words = tcg_ctx->insn_start_words;
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
-
-    tcg_set_insn_start_param(op, 0, pc);
-}
-#elif TARGET_INSN_START_EXTRA_WORDS >= 1
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
     unsigned insn_start_words = tcg_ctx->insn_start_words;
@@ -39,12 +29,13 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
                             insn_start_words * 64 / TCG_TARGET_REG_BITS);
 
     tcg_set_insn_start_param(op, 0, pc);
-    tcg_set_insn_start_param(op, 1, a1);
+    if (insn_start_words > 1) {
+        tcg_set_insn_start_param(op, 1, a1);
+    }
     if (insn_start_words > 2) {
         tcg_set_insn_start_param(op, 2, a2);
     }
 }
-#endif
 
 #if TARGET_LONG_BITS == 32
 typedef TCGv_i32 TCGv;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2156c022146..6586ad0a69a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2905,9 +2905,9 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     if (ctx->pcrel) {
-        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK, 0, 0);
     } else {
-        tcg_gen_insn_start(dcbase->pc_next);
+        tcg_gen_insn_start(dcbase->pc_next, 0, 0);
     }
 }
 
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4ab71d8138b..c4f1a446467 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2686,7 +2686,7 @@ static void avr_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->npc);
+    tcg_gen_insn_start(ctx->npc, 0, 0);
 }
 
 static void avr_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index e59e4ed25b1..ee359e804af 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -158,7 +158,7 @@ static void loongarch_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 /*
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a52cbc869ae..70458526282 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6558,7 +6558,7 @@ static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void ppc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start(dcbase->pc_next, 0, 0);
 }
 
 static bool is_prefix_insn(DisasContext *ctx, uint32_t insn)
diff --git a/target/rx/translate.c b/target/rx/translate.c
index bbda703be86..16a865bd40f 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2210,7 +2210,7 @@ static void rx_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6819b776686..636137a5f73 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8376,7 +8376,7 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f02cefde34..888752f2279 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1159,7 +1159,7 @@ static void xtensa_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 
 static void xtensa_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start(dcbase->pc_next, 0, 0);
 }
 
 static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.47.1


