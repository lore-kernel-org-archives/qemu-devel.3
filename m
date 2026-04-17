Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC655F8E4A9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDan6-00060T-Cd; Fri, 17 Apr 2026 00:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDan1-000603-Pu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamz-0006O0-Vn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so111320f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776400004; x=1777004804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nN2LV2iBk8TS7rfDPF67a2VsFd0jJs7Szwor3jxaf7Y=;
 b=g7UWd3W2wrGQbGBvzwXA3a/QMGk9H7bMKrqdym4veqRUoQyfAfjl53K8qTrPJG4AGY
 9/J3yyK8iYb3DxKrb9nIyN7uk2q5nwLkA7H9K9fytahZ9mYWZj7gKen5t8mYz1ruwG+U
 StmJcFqNQykYeiQECutThgB1nKrgrgWQXjHK/uNHSAU/ZtW0xWjbl4WFP+zMnblaOpEK
 PhAy6RVH1RhlFh6N67u6vPSYsuxxSHoqmvqlqg3PMrkJVxLIeyhWPX/ywiPBJgL/Bc9N
 eVW5owtsVzOVgr+QFfjRbG2KB+KXrraZ+EKxY9siZxjvlPrp7NA2IdCO6kxZH9JpuR+p
 cQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776400004; x=1777004804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nN2LV2iBk8TS7rfDPF67a2VsFd0jJs7Szwor3jxaf7Y=;
 b=gH3i6oY8nGVzfQy94dEKVqMgWdZAmMt2NATZEUsB7tjOTyExjBTe87U2L4cPjghABT
 zIaPZu/pDb3K8LPMloz2rXRF+gx0J/TiwytIe5Gj/6TzU4Y6/0Xhsx1/6uLp3vVYGjbi
 x8dL/Oi6q7gy1w30X+aNnGNLt7u8n10Ij3GsN8meyk/7m+xG06V7qev62bg7buiBmZog
 ZJzyoaCJ1R54Dw+HPnLTKXrol5xHPowjyib/3rWWYbDzkGaWG8xvOMsIGydFTu10ea68
 l0xv3GMZmV4lLCtUqXVl5L5KUTwcio+OBITDAU5AfGvaQQQ0QpC8Jh6d7uaOADmcnIYu
 Ju0A==
X-Gm-Message-State: AOJu0YxXI0ii5BvziGM3yAksLjOffvVtuaLNwRQQZR6FVARBkdmNRwFp
 QIpGQnFVZtHp7m+YTPfWaETMpecZyXNxrYIGlt4CqrvX9pfaXHASEt5febr4tvr6HPIHBg8pydm
 xg10Mp3s=
X-Gm-Gg: AeBDiev5XQKNixnbn7nt247q90N9XEWePpiVCg09aeGv6MT6kwfsJ1RRFYimcmmXbO/
 0dmwvFD2lhgpvWVf7/S/OJqvXtLAQDybsgS52yaxXsM95yhzt9o2iMGBZd9kWojfPcNB9NQklH6
 BoxQ5Q6wB/uAnaNKIh6Vi3Roq54lvm+C5QG48l7XiUkRfhovvjCIr3iQkSv+4avHzXcIwdgRJLV
 6FC7lvBy3WGIEEGUjvQQwfmqbhSnOaGPLzQWipxAfr6T78/6mmPPj7uCvbtCzE58Nr0gMyQLsGK
 l01njChgsmFNcqa87rsZv22oqH/sj/GTZGhnx0yYLgemSZadfYdYsu7IAGFDNK/4y13RlJcEzCj
 gbgDl+azYiZGDQ5P9kZer1fftc7JOIqHrIhosCCLfRFZshjDZ5qhJXt4wYbkD0kBWHUHaTK2HZ0
 2MHhJBtLMOjcRYjgFZIDJefuublcWpI9imL7m2K8tWcWtsrHcdOhj+wLaneVMNOSp/PesXYspUP
 GJGcdnhOfc=
X-Received: by 2002:a05:6000:2890:b0:43d:7aa8:f64e with SMTP id
 ffacd0b85a97d-43fe3e0a2c4mr1540321f8f.32.1776400004139; 
 Thu, 16 Apr 2026 21:26:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc26a3sm1249153f8f.15.2026.04.16.21.26.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 21:26:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 3/4] target/mips: Inline translator_ld[uw,l,q]() calls
Date: Fri, 17 Apr 2026 06:26:18 +0200
Message-ID: <20260417042620.35329-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417042620.35329-1-philmd@linaro.org>
References: <20260417042620.35329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the MIPS target, expanding MO_TE by a runtime
check on mo_endian(ctx).

Mechanical change using the following Coccinelle 'spatch' script:

  @@
  expression env, db, pc;
  @@
  (
  - translator_lduw(env, db, pc)
  + translator_lduw_end(env, db, pc, mo_endian(ctx))
  |
  - translator_ldl(env, db, pc)
  + translator_ldl_end(env, db, pc, mo_endian(ctx))
  |
  - translator_ldq(env, db, pc)
  + translator_ldq_end(env, db, pc, mo_endian(ctx))
  )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c               | 12 ++++++++----
 target/mips/tcg/micromips_translate.c.inc |  2 +-
 target/mips/tcg/mips16e_translate.c.inc   |  6 ++++--
 target/mips/tcg/nanomips_translate.c.inc  |  5 +++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 4889bd1e518..8b570188538 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15147,17 +15147,21 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
     if (ctx->insn_flags & ISA_NANOMIPS32) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_isa_nanomips(env, ctx);
     } else if (!(ctx->hflags & MIPS_HFLAG_M16)) {
-        ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                         mo_endian(ctx));
         insn_bytes = 4;
         decode_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_isa_micromips(env, ctx);
     } else if (ctx->insn_flags & ASE_MIPS16) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_ase_mips16e(env, ctx);
     } else {
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 8fda7c8a214..b38c37194ad 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1623,7 +1623,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
     uint32_t op, minor, minor2, mips32_op;
     uint32_t cond, fmt, cc;
 
-    insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2, mo_endian(ctx));
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = (ctx->opcode >> 21) & 0x1f;
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 97da3456ea5..beb5b04ea29 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -453,7 +453,8 @@ static void decode_i64_mips16(DisasContext *ctx,
 
 static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
-    int extend = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    int extend = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                     mo_endian(ctx));
     int op, rx, ry, funct, sa;
     int16_t imm, offset;
 
@@ -686,7 +687,8 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
         /* No delay slot, so just process as a normal instruction */
         break;
     case M16_OPC_JAL:
-        offset = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+        offset = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                     mo_endian(ctx));
         offset = (((ctx->opcode & 0x1f) << 21)
                   | ((ctx->opcode >> 5) & 0x1f) << 16
                   | offset) << 2;
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 9d4e0bee81f..4b0b01ba37a 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3551,7 +3551,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
     int offset;
     int imm;
 
-    insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2, mo_endian(ctx));
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = extract32(ctx->opcode, 21, 5);
@@ -3665,7 +3665,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_P48I:
         {
-            insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 4);
+            insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 4,
+                                       mo_endian(ctx));
             target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
             switch (extract32(ctx->opcode, 16, 5)) {
             case NM_LI48:
-- 
2.53.0


