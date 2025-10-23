Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13FACCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC546-0003rK-NC; Thu, 23 Oct 2025 19:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC544-0003r3-Py
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC542-00075a-RX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:49:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b550a522a49so1094021a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263389; x=1761868189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHjfQYpCTiW1R4NgEmT3AjTpMFUr4UkyBfGUa9q+sU8=;
 b=UK1IgkVdEoJFgMOLUwNM8kpvJXbRVPeU1WCm029HAUyrHezIaa0t5BEfGLG7OGfBLV
 gFaDIlClOJXWCKssLI/hT5JH5Mez3GNnkEyH9SWyXmHzaM+M8NL1ToTZV6JQDCLp4jzH
 Gi7Yw6t3xUhg4m6P69L0RSVl0+Wx5xwyYCKRLgO3XJCBZAcPipQIBnFfPlgsqbRUiD5e
 y9OHGxbrpuJqpZs/wpNdLeq0DbAYzJsWaUDl20E2ieTQ7X69H6y62WN9Sb3I/eZ+nxXN
 UJdp3hrFHW0LQ8Q5I/Tp2HIfoc7YWSILiWh08q0iFo/BuTfoS2BNF6M0uXN7viA2+l1x
 UkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263389; x=1761868189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHjfQYpCTiW1R4NgEmT3AjTpMFUr4UkyBfGUa9q+sU8=;
 b=NQwsMGUHgg64cXWPApx9jdbMGt1qqHryE0GN4PEnSNEUerv66916wSLXHutZyC7aZ1
 c99NIr9CsHUFI9bzHmxfqha3whmsq82FxwS1gzl6eRqfJjqV5f3/p803RnGdGYBA9B6y
 Q/SknjRdGndB/FDB7chclqX7lJaNmzKCo6X/LBvBsIOQhLdFTFl33UnFWnBrZj+CciSr
 M001eC69byrsgG6+F1T4uUCAlGYHamIEJeg51P9qlqGZ6Kw9yiupkd6iykm34diHclEo
 sQSCjIZfMtgZhVE6hkaNNybb9Q1ytPJNHZJFPoQLrouzy+r6b1w4iF1fqNqlMJuyi9gO
 +OeQ==
X-Gm-Message-State: AOJu0YxusqerFbVmf6zrlgR6lp3gCHWIn28pIuOK/1yrOq2yikUGc7gD
 m6hfArlrdoO7byaY1j0vkktZ/XME9X5WuxQIkWhIN8vmMmF0mMqpqxg76Jgs+A==
X-Gm-Gg: ASbGncs9dveQvmP9L5VaLBkfH9/2eF3+KFKeLvRHGg/W+W3dDePLFbqTfPa8lYUBu1/
 bkETG+GrwBbjIqtjMkHtDdSfpfbfLkGPssOcmON/STIjqF39bYtAsHIPwLdRQTPcvQ9bv3rT2HZ
 qeEwcLPgGyRf0UlEDn91ewlke21AdPXLKXZulSai1ZmbXoS5/7jcEQP31wIn4DIqglBUcjOto2z
 nBtzgRT3ZKDyAFQw03E2WJ4+zJjOh4zL9o1g7jjLBZtnbxgztNbgsQcFHhQUlinuij4Sn5uBG2v
 FlOY+rEXWEtItKdiuAzq5EVZccEGpuZBjebZM0OlpabnfwdSvUm4WOA28ynT16W/oO8AJo6NVi4
 PFFCULKNwUfuv/I3zfwXpUK4gr9Oi3UElC81mq9QK6NNeo6P95WQ7OpddxwCF8dEKOQ6GGGvFnT
 7ykhgQLvVnauAGXPjErnA9k8+rO/Zsov5RWt7FI+9WmRHzPYclfeKBpAUnXDprYA8DWRjHgDFew
 A9EQgAR
X-Google-Smtp-Source: AGHT+IFow1WHQZwpHkhQgj9fL/V+YP2nGvywYH3yoggSTZg8J1aJYCeAyNV0Qs67MMqCfP8ZNtGqng==
X-Received: by 2002:a17:902:fc4b:b0:290:a70e:6261 with SMTP id
 d9443c01a7336-290c9c93c30mr328605155ad.11.1761263388783; 
 Thu, 23 Oct 2025 16:49:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/25] target/riscv: Conceal MO_TE within gen_amo()
Date: Fri, 24 Oct 2025 09:49:05 +1000
Message-ID: <20251023234927.1864284-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_amo() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-4-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                    |  1 +
 target/riscv/insn_trans/trans_rva.c.inc     | 36 ++++++++++-----------
 target/riscv/insn_trans/trans_rvzabha.c.inc | 18 +++++------
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9a53aecbfe..94af9853cf 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1135,6 +1135,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
+    mop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 10e4c55efd..e0fbfafdde 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -111,55 +111,55 @@ static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SL);
 }
 
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SL);
 }
 
 static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SL);
 }
 
 static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SL);
 }
 
 static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SL);
 }
 
 static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SL);
 }
 
 static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SL);
 }
 
 static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SL);
 }
 
 static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SL);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SL);
 }
 
 static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
@@ -180,61 +180,61 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_UQ);
 }
 
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_UQ);
 }
 
 static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_UQ);
 }
 
 static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_UQ);
 }
 
 static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_UQ);
 }
 
 static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_UQ);
 }
 
 static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_UQ);
 }
 
 static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_UQ);
 }
 
 static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_UQ);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_UQ);
 }
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
index 25db42d24c..c1f99b65f0 100644
--- a/target/riscv/insn_trans/trans_rvzabha.c.inc
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -79,55 +79,55 @@ static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
 static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SW);
 }
 
 static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SW);
 }
 
 static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SW);
 }
 
 static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SW);
 }
 
 static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SW);
 }
 
 static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SW);
 }
 
 static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SW);
 }
 
 static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SW);
 }
 
 static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
 {
     REQUIRE_ZABHA(ctx);
-    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TE | MO_SW);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SW);
 }
 
 static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
-- 
2.51.0


