Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907FCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FOv-000477-Pn; Fri, 10 Oct 2025 11:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOq-0003zP-Fo
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FOj-0002Nm-2r
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso13165065e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111468; x=1760716268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/RFRwN2hdZobqlvf83sC1ELRwPbHpkuSmCBnMOOgns=;
 b=WeFLzOdeSpsQAt3GW56usJgvv/rKe/KIeoSvripw0ycHCPIcIonkPu/HbQbkkVXCPP
 zE1vUJTxSvcZDFjV2dAr7MwnIlQRtCAgHl7Hq+VIfL5WBCF6e7F754qPzUPzwTQOtjW9
 DSvxVuaxOtpC0CddRB9+bMpp67GC6hTx7x2rnFMogEqeD0XpUVG8rlcspNWe5pnTUygr
 aLMgxCZb6rdu4PFBx4kZ1IHRXuoFNuDBDR2a+BMCykIZFVOT8MztGk6oLHq4P6aNRzlm
 dnVHIbYA4YYQhJ1/cOj+cRy4aSN+Yv+uLMp+R1pmBMmlEKFRh+RmJmoW5N2LBwcH/PIV
 xXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111468; x=1760716268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/RFRwN2hdZobqlvf83sC1ELRwPbHpkuSmCBnMOOgns=;
 b=hulhuRN/n2O2hX051UGajLDRvP0qB62FNKytoWk+huUtNlbAk8IJs0oo5vea0/gYQv
 ccBwmji/wF+gZUcTy2qtwFKG+fiQPGDKBurd67p0B/7BqKxEuexiwOJPgXaUhHLhpBGv
 cdhA00KvuAEBO+wTEeb6oW+rJ3lx3UeE6yR7QistumztG15JUNR6thvEFfczDF5eMqmb
 cE05fp1H4U/JraI9DtQzhSumMuBKiE9HaRy7f3ah0s57Z0mKcuGvGkZ6uMQ3oyvnYixQ
 llq9ogonpVPHk4m4hQJhgMeDvq0wMuwESkccaZusiqj/Fm7XDcOyyXLdBRgOCIHxB/Hq
 8hvw==
X-Gm-Message-State: AOJu0Yy5SiTEUrOMNB/oykMSzaY8CKNm4ZMmv+ozKoAtLzUQLN0FRJ5h
 v4FryaEq8UZWyPyctYxAzGaj0pjBaEWW8jqIK8Z8Y3znTCQs/OKlSNpEqFAp2MCQw2NGV4hlOmW
 9QjKU+GN27Q==
X-Gm-Gg: ASbGnct01DGw8bdw//QwmKKzx//ctSWiWQoaWfTTNCBt0DVPPV8F/KkAExsg81NIXk7
 FlcG7lfwxWZsurfCI7iwSiCjWLibR1yZhEgPnEQk+kUmojsCqFfqpRzUli0iqLlp64210XRt7Pr
 Cc+AMr1p0e13tpGvqKhC4ymA9VhXtTuuj0CG3To/7KT5Y2pSNhvy72fjmIU2PDKuJR9ZAHjQr3K
 QfD1IIvjHWohIKyz4WRBOD+7GwH+pnn7KIrz+c4Ih5pneOlYxwhs1gcGDvcLQjlATmNBVOOo0RT
 wBJ/WR32odd1IuvR4KYzk2vOPfXnR6bgvVcuFGrDmYL1qPmnxlWjFJ1Bfh+fe7jPSikhO6wvYxD
 Qd1BLWgJauWz+JVuOxjTtjuC8nLAiAYtqP84JlKmsDcFQ7CgSiaVlU/Y61Eg7+ubXr1RtjYEEJU
 V2xrR2ug2l3eaNSrAZ6/UMZ2vO+Qvfzw==
X-Google-Smtp-Source: AGHT+IEYz7cZOengOKvsj4+eOJUWxwoA6xblKbazhY/mTyx+AiEbVYFJqX2fJp12/XPhzsx/o45jxw==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-46fa9b1b277mr84754725e9.37.1760111467641; 
 Fri, 10 Oct 2025 08:51:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49bd977sm51923805e9.11.2025.10.10.08.51.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/13] target/riscv: Conceal MO_TE within gen_inc()
Date: Fri, 10 Oct 2025 17:50:35 +0200
Message-ID: <20251010155045.78220-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

All callers of gen_inc() set the MO_TE flag. Set it once in
the callee.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 754cb80e221..7e69906e5bf 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -568,6 +568,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -588,6 +589,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -598,64 +600,64 @@ static bool trans_th_ldia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SQ, false);
+    return gen_load_inc(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_ldib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SQ, true);
+    return gen_load_inc(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_lwia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SL, false);
+    return gen_load_inc(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_lwib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SL, true);
+    return gen_load_inc(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_lwuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UL, false);
+    return gen_load_inc(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_lwuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UL, true);
+    return gen_load_inc(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_lhia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SW, false);
+    return gen_load_inc(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_lhib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_SW, true);
+    return gen_load_inc(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_lhuia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UW, false);
+    return gen_load_inc(ctx, a, MO_UW, false);
 }
 
 static bool trans_th_lhuib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_inc(ctx, a, MO_TE | MO_UW, true);
+    return gen_load_inc(ctx, a, MO_UW, true);
 }
 
 static bool trans_th_lbia(DisasContext *ctx, arg_th_meminc *a)
@@ -686,38 +688,38 @@ static bool trans_th_sdia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SQ, false);
+    return gen_store_inc(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_sdib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SQ, true);
+    return gen_store_inc(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_swia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SL, false);
+    return gen_store_inc(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_swib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SL, true);
+    return gen_store_inc(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_shia(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SW, false);
+    return gen_store_inc(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_shib(DisasContext *ctx, arg_th_meminc *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_inc(ctx, a, MO_TE | MO_SW, true);
+    return gen_store_inc(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_sbia(DisasContext *ctx, arg_th_meminc *a)
-- 
2.51.0


