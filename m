Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F5BCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54M-0003wD-Sk; Thu, 23 Oct 2025 19:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54K-0003va-PR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54G-0007DE-VI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29476dc9860so9558095ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263402; x=1761868202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVk43MZU3eODXH5tqOa2IO00Re4cjN++W5+uBbDHnOk=;
 b=S5IWi7zDMrRUx7RK1XP4aoHVLnTfdhFi3H/KL3jheuaQioFnnQisAdiPENTsfZNXv5
 stTRegtWTBAC53c7blLg3nNL45ckreIvm26KV3rdzSaYZD8eUWmE6HRyM4EOkNP0Ezuz
 WCVIj80PhHoXDDI/n+6fgViTh02Z40gGO7XgdJ/j19xoGWlNaXHrNryUlS/g/Sm/PAse
 Z7r+OX3KMMN0KWPcUA8IHwdD5PFW3oiCtb0uudqhGnoSJiU0vSJWvsInrf39Voqggnll
 +h/ldfX1eJP78KAwAe7I5kF8JCkVxZbEFLXRrE/55113M5HoRzl+z5oW+CRejtf0+qDZ
 x3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263402; x=1761868202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVk43MZU3eODXH5tqOa2IO00Re4cjN++W5+uBbDHnOk=;
 b=KIFYn1ysjmjt2EfHOB/Sfmo9CWaF6qthadG0Z4kocPohnzuZwvJtcu6detT4OZhN0S
 sTBqbNfmwgU7bo4dOB+demSYaR3Bnid7mburRWV78d0udRewE91Nv6j4J0yPvGe3IQzW
 +a7yL0ofshMOkIg7DoQ44qTAl90r2SQyjIiIqzT63wZcSfYxJ9eyX5gyuWPuxoQWDgJ7
 y161uTsDV6d+Hn5vVUkloeHEbvcSmmQYTJfcQ4D1T53LKOgIMnfJSpeq7l8L/XlGVx85
 EWVMdQ5gzu744YuVGOmxm82AMdqe6TAJKjjZalg/0U375gKS/RqbbJG2uNw3QOTV0DZM
 sPsg==
X-Gm-Message-State: AOJu0YyT7a6GaFQHSG1GZaaMm5Sk6+1ifOAn1Cr8lTEzq7XY2mslYuPE
 KG5Eb902O2NYCyOL7Sb9AY6yyPuS1phbDR0wTYKXw5ErEBfaef3XwvhngJRy9w==
X-Gm-Gg: ASbGncsPfdCMpcjyX3mErATYPN+yKjcjvYWHqQqU/4Xj9jd9geGiRB93zDQxz/qivg0
 1OT8l0vLRd+5k8PmWtRWVfiYxSHZVAPifgne3MNUMDCcfvDmoQ4INgFkhHrAe2E82gIpz99doNm
 v2rp/ZLISe0uqkwrd1CNHNzHJ/X/DWnQrNtnL2CBqYahaYVavTWT1p5xB/l0Wy3qxKUvHmxVRb5
 8Kl8nHX2PIboVX6gaMzBcpkT5nYhI3IBmSIAEpk2N9phps/ANlHvko/Vspb+sWXDLkYZazMVTeQ
 npuX+vJk4hIRBQ67+3e5lDjs6WjXVwMq6FLMYvMsTk/77qXALrAipq8BHsGZ2B9hj3J9+9EQy3Y
 fDr6rwYktVdlWjU8qNK9MLMnz0sjeb9Q+ubHFI/g4AXsza02HAY3TxRJTmPcbivaN4CvU+Dbnrj
 7xNzpx9//Lc85IQYQLjZVDPLXdchVB2Sj9MBj7ZZLFAj4wh4b2EuwmBBwlxzz1uCUeiXrubA9RT
 GaSEO1vrKLTIavBr3g=
X-Google-Smtp-Source: AGHT+IHyYhPua94mQpdIABmoUjUFz6lWoI9svDYe7abn9ggnVfblc8bIwu/rf6Rtdcv6DPI6VLe9fA==
X-Received: by 2002:a17:902:d489:b0:293:e12:1bec with SMTP id
 d9443c01a7336-2948b97773cmr3174125ad.20.1761263402013; 
 Thu, 23 Oct 2025 16:50:02 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/25] target/riscv: Conceal MO_TE within gen_fload_idx() /
 gen_fstore_idx()
Date: Fri, 24 Oct 2025 09:49:09 +1000
Message-ID: <20251023234927.1864284-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

All callers of gen_fload_idx() / gen_fstore_idx() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-8-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 70c563664a..859cbc26cb 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,6 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) == MO_32) {
         gen_nanbox_s(rd, rd);
@@ -369,6 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
 
     return true;
@@ -379,7 +381,7 @@ static bool trans_th_flrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, false);
+    return gen_fload_idx(ctx, a, MO_UQ, false);
 }
 
 static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
@@ -387,7 +389,7 @@ static bool trans_th_flrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_fload_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
@@ -395,7 +397,7 @@ static bool trans_th_flurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UQ, true);
+    return gen_fload_idx(ctx, a, MO_UQ, true);
 }
 
 static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
@@ -403,7 +405,7 @@ static bool trans_th_flurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fload_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_fload_idx(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
@@ -411,7 +413,7 @@ static bool trans_th_fsrd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, false);
+    return gen_fstore_idx(ctx, a, MO_UQ, false);
 }
 
 static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
@@ -419,7 +421,7 @@ static bool trans_th_fsrw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_fstore_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
@@ -427,7 +429,7 @@ static bool trans_th_fsurd(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UQ, true);
+    return gen_fstore_idx(ctx, a, MO_UQ, true);
 }
 
 static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
@@ -435,7 +437,7 @@ static bool trans_th_fsurw(DisasContext *ctx, arg_th_memidx *a)
     REQUIRE_XTHEADFMEMIDX(ctx);
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
-    return gen_fstore_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_fstore_idx(ctx, a, MO_UL, true);
 }
 
 /* XTheadFmv */
-- 
2.51.0


