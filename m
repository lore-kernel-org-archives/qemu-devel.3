Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECE107BCF2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oD0-0002gd-HA; Wed, 18 Mar 2026 06:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCn-0002DY-Mh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCk-0002VM-Su
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48374014a77so73925965e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829965; x=1774434765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD08L7/tS/M0HJDnqHwQDjmjsjdzePAzezbZLq5ovR8=;
 b=hTjmWCiaNHbT3I5KPARzOobVj/DGVQGRwn23U8KXFQr5JoLNr4krbL/bB3rK0uFEPr
 FI1hz6nfCSUSsGlusrJocVlJMj332WtT/OxUvr5BtlD+CdfIbI31WVVtthkrbbtmydN3
 uyu35N8UajCMeC6vnCb4YqkHP1z5V5zFTsArkzkZYtYX9HOO2iRDgf//lhBMPxaDlhGF
 z2uFZ53yYT1zSS1TLB7jnMZz1yUB8IviRyi18YBMoC03YNKCEL0Sxx0zZBEuvPjZwId9
 svBoWvhhphed6AGjrbj0SSzycVzfXKC2OausDb7oWgJCj+74oYQz7AvyuDpbxhZXt7Ls
 Q0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829965; x=1774434765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cD08L7/tS/M0HJDnqHwQDjmjsjdzePAzezbZLq5ovR8=;
 b=nHkxahmLerVU5/MllQB8b6zKHzYhSxC04l7F2Uf2jXNj27vc4zXZUuvZfFnORKzUWd
 sbc592PVao+a1E1DWCjhzLbZZfETKGBmpu6XnzkH+U0gbAMwC9AjPjveKCX7XgcUPonp
 0ftbkBboZIYBNPy/nu67dALq0PG1STXOGbH/wyXdXLxTGkNfI21VNNaD6WyJMLueLkku
 +cyuYQqBPdMY+zb+WrNCDNUd6WmWFibbwJF8wpLt9oE49Z81zKDPhP5mfwN4BMdYcLbB
 pAWtR3tnwpik/tMvUKyFtNY9BpaCdUeND1ToV/tK6Ve2ycMI3Rpjf+qDQtnqzyeNsVot
 ARsA==
X-Gm-Message-State: AOJu0YwBCk88tOjVycfibV3D01rGlH5uuaijNgXFYWajFrt2dsqEEeZ/
 3Y1TwmoogG9zSTV0luzlYK/O9cw3LQjTNtC7drrGYk99ILI9ZBIx/jwLBOz/4LvvIbtL7zIUz4R
 +4ED6dHU=
X-Gm-Gg: ATEYQzy4u1wIYcaDBJHhsKE/5dzIb/CP+1T689THwbtW+/QGwOeVtZMbzEclyxNN4SG
 6pmswonxge6JSdWOavtZPddH+apkAIOCy65PHf80BmhVqWbs16XkN8pa1ZlMi3JQduBXgaFVZaC
 YyvsQv7RqUyKVhiTUY5HlFOYgWJmuMLk4Jy99wYcnoQmHIkbIPVjqWjWEQiQkXMPYlUSJRNAFBX
 TkFR2AUCLGYTl3ejwGLV1J2LjnbJpm0TPujlptdFBT+XV/LlOb48QM+dIpa344DS4rolbwFpb/6
 vXnSeOoAqCGT3jLM0c+TTxmJnDrK4qr+jNWyj90QM3KZhJb/C9B8WgIZWwfq8WrVX62L3sTe0Ua
 Taaodkd4UDesRJ/JKZqb/aA995E0f2ahOeMRzPoOS3Y53kEwSInNroOlO69KyYXWHyilg/H9HKx
 nFgqja+mME7q2ARPPOL1aQEdzksFuvp5oebBCphIwyJQxSX7FwFOEynh6Rczc4HQKlW2PC3m0h
X-Received: by 2002:a05:600c:4753:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-486f443799bmr49292545e9.9.1773829964712; 
 Wed, 18 Mar 2026 03:32:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3037sm131128035e9.11.2026.03.18.03.32.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 11/16] target/riscv: Replace MO_TE by mo_endian (MIPS
 extension)
Date: Wed, 18 Mar 2026 11:31:16 +0100
Message-ID: <20260318103122.97244-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_xmips.c.inc | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index 37572563ae9..c1a30156d36 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,6 +47,8 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
+    MemOp memop = MO_SQ | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
 
@@ -56,11 +58,11 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_y);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -69,6 +71,8 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
+    MemOp memop = MO_SL | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
 
     TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -77,11 +81,11 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_x);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -90,6 +94,8 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
+    MemOp memop = MO_UQ | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
 
@@ -99,10 +105,10 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_w);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
 
     return true;
 }
@@ -110,6 +116,8 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
+    MemOp memop = MO_SL | mo_endian(ctx);
+
     REQUIRE_XMIPSLSP(ctx);
 
     TCGv src = get_gpr(ctx, a->rs1, EXT_NONE);
@@ -118,10 +126,10 @@ static bool trans_swp(DisasContext *ctx, arg_swp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_v);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, memop);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, memop);
 
     return true;
 }
-- 
2.53.0


