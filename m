Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20225C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutl0-0004IO-Jl; Wed, 19 Mar 2025 09:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkD-0003lX-LK
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutkB-00047b-NX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:46:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso3815947f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391961; x=1742996761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adKcjdToncFNSb7FtMey2mB2jyzU5Dr+yeVuZvMoV7M=;
 b=CS0rW8zIwLB0HACM0jYNy01jBs/70pOjGg/LkmB6fc7iu2t7+tkL7ZMryOzNVjcRzl
 BAe05fYBTC6SKLvnlR6kO48Tl8L4C2tdigme+HbFn4NYpPex08wZuE9MmX6/B7p836uz
 8mRjtYrAkQ38QI2ouyN6KjaS7VmkfrGk1a/AV3uShJZfs5UfDVzKaU6ZdnBwSRSzlx74
 3WjrXLFMiojQZ0CfvbboJEflc0Of1rUj+G8eTHu+6kUp5IL6ENmvcq822bkDM1WtXMat
 rmM8cJyISTqnIFheLb6uPL2W/IizB9mItYTALTTZn51oYjB4hN7v5twjtrKa22IeAdQ6
 tO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391961; x=1742996761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adKcjdToncFNSb7FtMey2mB2jyzU5Dr+yeVuZvMoV7M=;
 b=FRXNg8i7ALZoccZH31o6Ow3P27O4bYKcE8U7kYd4+qjpROSTvZ2j9sKPdf5B2db4KU
 711h4ijAoP1BolqswkJy2a2bNss/E2Y30OwvoVtKbF+9NMSL2HacSw2/9+uwiTyNO2Ig
 323h0FEfbu11L0BtHLRNyFTioJj4VfVBBaRCGt/97JjLxlnQsNKR45WFDMGSkGbSbD79
 TZtKP26d+ZlW/K7EB9dBeY2+vh0r+mvFaSBMqTO1OJQsdvAeTCAPofEtpLV5W307tMaG
 3U2GXQ8umz3SDLH18LMW0T2oBQqRgT+A4Mf4rCq8xrcOR5gNZ47XcrgFA/9GWqYph9Tm
 OFjw==
X-Gm-Message-State: AOJu0YxVP44mZsh/uMYDBDW/WvYJo/hEOowQiPKxGcGP02FN2jDwUbKr
 u9UL8wJZew0lPPJa9KYHhwzNykk//yC323xxk3sUnt2vE0rf9OSAy95Bok+FPBnyeENhUrQWl9n
 g
X-Gm-Gg: ASbGnct6Q9CvDhodJJ+F10mYyX9Q8DHiDmEdVva2USwsNO9fhy7dvjq1D4DlJWf3KvV
 zA98emKoz0fGke70T6R0WGSRO3OyOgmW+sWFtGZA1TpXugZfhDhSHDneatTuOuGha/WMdz6Va5t
 M1N5TGk2q50spARtF5n2ZgYQ7X9sZ0ncMsmurbtyAxtX4AtZ4qGKIGKqVVWNFPkSFjrcM1CMsCK
 HSAr63jyaDgheL0JFvM/kgK8WkjCyf8CuvOQdDTjOlx1aC0U3aNkK0NrTiunS59RVXk3cG2JSfr
 8yeQIEzZbzXtLLz8BX6WUv4tQ5llRBVVPbzIZMxWoULdL6fykLvoLBFUQn4p4S3TynyGwDYpY8B
 xkQ1BPoGmbWVPNkP47Ho=
X-Google-Smtp-Source: AGHT+IEjX6tvwnBr1n8VHg6BP7kYI0NmPVF5UDonLRan+TqxJhN7lbinO23mzZDTqW565KZjfAMDfQ==
X-Received: by 2002:a05:6000:1844:b0:391:31c8:ba58 with SMTP id
 ffacd0b85a97d-399739b64fcmr2590852f8f.10.1742391957999; 
 Wed, 19 Mar 2025 06:45:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df31f6sm20958392f8f.6.2025.03.19.06.45.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 10/12] tcg: Unify tcg_gen_insn_start() to handle 1 or
 2 arguments
Date: Wed, 19 Mar 2025 14:45:04 +0100
Message-ID: <20250319134507.45045-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Merge the tcg_gen_insn_start() definition using 1 extra word
with the definition using 2, using a2=0 in callers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h          | 16 ++++------------
 target/i386/tcg/translate.c   |  2 +-
 target/m68k/translate.c       |  2 +-
 target/microblaze/translate.c |  2 +-
 target/openrisc/translate.c   |  2 +-
 target/sh4/translate.c        |  2 +-
 target/sparc/translate.c      |  2 +-
 7 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 0915043adf8..df234d4e1e0 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -31,17 +31,7 @@ static inline void tcg_gen_insn_start(uint64_t pc)
 
     tcg_set_insn_start_param(op, 0, pc);
 }
-#elif TARGET_INSN_START_EXTRA_WORDS == 1
-static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
-{
-    unsigned insn_start_words = tcg_ctx->insn_start_words;
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
-
-    tcg_set_insn_start_param(op, 0, pc);
-    tcg_set_insn_start_param(op, 1, a1);
-}
-#elif TARGET_INSN_START_EXTRA_WORDS >= 2
+#elif TARGET_INSN_START_EXTRA_WORDS >= 1
 static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
     unsigned insn_start_words = tcg_ctx->insn_start_words;
@@ -50,7 +40,9 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
-    tcg_set_insn_start_param(op, 2, a2);
+    if (insn_start_words > 2) {
+        tcg_set_insn_start_param(op, 2, a2);
+    }
 }
 #endif
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487aa..0f1e72b1bc0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3766,7 +3766,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
     }
-    tcg_gen_insn_start(pc_arg, dc->cc_op);
+    tcg_gen_insn_start(pc_arg, dc->cc_op, 0);
 }
 
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dec2967fce4..9f7052aa6b5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6037,7 +6037,7 @@ static void m68k_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 static void m68k_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
 }
 
 static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b54e5ac4b2f..d256b317cfb 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1631,7 +1631,7 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
-    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
+    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK, 0);
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae2..ff720e7fb6b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1558,7 +1558,7 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
-                       | (dc->base.num_insns > 1 ? 2 : 0));
+                       | (dc->base.num_insns > 1 ? 2 : 0), 0);
 }
 
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd5588183..f140080c08c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2248,7 +2248,7 @@ static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags);
+    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags, 0);
 }
 
 static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bfe63649db2..a775f425658 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5725,7 +5725,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
             g_assert_not_reached();
         }
     }
-    tcg_gen_insn_start(dc->pc, npc);
+    tcg_gen_insn_start(dc->pc, npc, 0);
 }
 
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.47.1


