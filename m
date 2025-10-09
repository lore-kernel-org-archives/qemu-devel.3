Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8E2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNw-00019e-I8; Thu, 09 Oct 2025 11:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNq-00016N-2c
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNj-000145-K6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso6809775e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022994; x=1760627794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd75KjFA70uEutIzkLumQolLFM/nmfByUkoGLhL3rMw=;
 b=J66J4an2XuN0aU0kpiJSDuvq72u10ng41fd+0kTXYx3Y4c1SfsVuNJcRf+B+ggm2gs
 2i/qqBaq7YCLPtBVtvsQ5uU4iZTKA6mRVxjA1kKb4Ccu8bVnvHfoF016FekvJZFNEtcV
 YMgUGmxkWCd2P6Z0/BRCGZpxCDaPcHEK89PZXDTrTkKOFfmgTgH5EUAACmNpibOFIcFk
 n7ncwTg6psSCfb0T3XGWzg7TuYvy3DiFJfGQHGvF4l2koq4PQ1xnmpIahPJk/+8mDkHc
 V6LSB5cMQwfWpbVOHmE2ufxbNZ345riySIGPb/lj4pROO18gga5QdOV9xmzLeQE4ECsO
 kP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022994; x=1760627794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kd75KjFA70uEutIzkLumQolLFM/nmfByUkoGLhL3rMw=;
 b=ugJXm0exRNzW1msAqHhPiJxyfIa/FiW5m5JYYdnBXfU79H1p2km8Q0tE299kCQXbeS
 sAY1PyeL5bl2QkS7H4sW5QnrnHjorlOnKIytbVIkvh0vwFrCqpTjpazx833BQUmEOWrf
 0seI2nNw/SsfnPi7Av2oavPvKBBp8kCFcJOdZ0Ap8H8ftr99OzmcnGp0dDXE4Vv8GQ5M
 O70oO99+qGr8u809hNxVj5JSL6HY5g5i0qQ1kTiYjNA/6B27WhFKuFlc20TQIbEPLcwD
 xZpfk2IZAOpRYYgZ3MJImS5dup4gK/Uw1JnswZKnRnsWTHe0qJxeIQZiLZOpoK7x64ck
 Kl9w==
X-Gm-Message-State: AOJu0YxbbIZCJX/LOg9t7rd1LO7WrqDH57KwexfksI8KxR8Y6TQ3qIcF
 yQEOVu+pTzNGFhPj0Qz5XFZeQngagdX/W8c9KmpuvQRDTOrwrpHiac5dJKjmPySYNZV8W17ZdMK
 UPlOXy0k1vw==
X-Gm-Gg: ASbGnctryA5MxnH/WMYojYtXG8I/yrFJcOZV23kAgbhAm724e1mAeWADv8rEWyH+GRE
 ICv+7tKSK2cQDzmQKE7X3xMxNfbVq9TrDOVIbyVvzM0o44Fk/1Fo8vEesjUy6MpLPDWtbK3Zzo+
 PhvxtxdG2fUL1pDDEHqWHjd4O+w1qcK5e359oQMuj4vz8uynanZhKBVy5QbxYS9eCxWgOotXEGZ
 K9GZ5ZbTKFMjVhadaI22oeXWwFmkd42pGiZ0GBFxaROapBsiZllAe5dcTiizOZoQ4ueDX3rDoS/
 XFgHvCp0I+8CY83qNVO9AfzbNgPuvzkATx1kZO139F99bycS1vIiadoJ5qzN4O05b+OqQKq4/vI
 Q7aBBma1i966iIDyEkq8jqeSX5C6BZ2WxMufzp1GABkHBLT0gSUpJOr5fe/6qm2H694SKK8aWkG
 CeHT+LqSZTQkP1C0yN5nYKhOKK
X-Google-Smtp-Source: AGHT+IEkyrxCICEi4rFc9mxJWtU6jJztbJNzJ92oryvodggCnUEE4wuOIGBJlxuJ3XB4fmwXg55fKA==
X-Received: by 2002:a05:600c:6388:b0:46e:1a07:7bd5 with SMTP id
 5b1f17b1804b1-46fa9b0797cmr56748785e9.29.1760022994318; 
 Thu, 09 Oct 2025 08:16:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm35460773f8f.3.2025.10.09.08.16.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/rx: Propagate DisasContext to gen_ld[u]() and
 gen_st()
Date: Thu,  9 Oct 2025 17:16:04 +0200
Message-ID: <20251009151607.26278-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 0d5356cd35d..ae9382e0756 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -161,19 +161,19 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(MemOp size, TCGv reg, TCGv mem)
+static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
 }
@@ -417,12 +417,12 @@ static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
 static void push(DisasContext *ctx, TCGv val)
 {
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(MO_32, val, cpu_sp);
+    rx_gen_st(ctx, MO_32, val, cpu_sp);
 }
 
 static void pop(DisasContext *ctx, TCGv ret)
 {
-    rx_gen_ld(MO_32, ret, cpu_sp);
+    rx_gen_ld(ctx, MO_32, ret, cpu_sp);
     tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
 }
 
@@ -432,7 +432,7 @@ static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
     TCGv mem;
     mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
-    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
+    rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
     return true;
 }
 
@@ -442,7 +442,7 @@ static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
     TCGv mem;
     mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
-    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -463,7 +463,7 @@ static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
     imm = tcg_constant_i32(a->imm);
     mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
-    rx_gen_st(a->sz, imm, mem);
+    rx_gen_st(ctx, a->sz, imm, mem);
     return true;
 }
 
@@ -473,7 +473,7 @@ static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
     TCGv mem;
     mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -483,7 +483,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
     TCGv mem;
     mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
+    rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
     return true;
 }
 
@@ -505,18 +505,18 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
     if (a->lds == 3) {
         /* mov.<bwl> rs,dsp[rd] */
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rs);
-        rx_gen_st(a->sz, cpu_regs[a->rd], addr);
+        rx_gen_st(ctx, a->sz, cpu_regs[a->rd], addr);
     } else if (a->ldd == 3) {
         /* mov.<bwl> dsp[rs],rd */
         addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
-        rx_gen_ld(a->sz, cpu_regs[a->rd], addr);
+        rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], addr);
     } else {
         /* mov.<bwl> dsp[rs],dsp[rd] */
         tmp = tcg_temp_new();
         addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
-        rx_gen_ld(a->sz, tmp, addr);
+        rx_gen_ld(ctx, a->sz, tmp, addr);
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rd);
-        rx_gen_st(a->sz, tmp, addr);
+        rx_gen_st(ctx, a->sz, tmp, addr);
     }
     return true;
 }
@@ -531,7 +531,7 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_st(a->sz, val, cpu_regs[a->rd]);
+    rx_gen_st(ctx, a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -547,7 +547,7 @@ static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_ld(a->sz, val, cpu_regs[a->rd]);
+    rx_gen_ld(ctx, a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -562,7 +562,7 @@ static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
     TCGv mem;
     mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
-    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -579,7 +579,7 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
     TCGv mem;
     mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -592,7 +592,7 @@ static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_ldu(a->sz, val, cpu_regs[a->rd]);
+    rx_gen_ldu(ctx, a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -647,7 +647,7 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
     val = tcg_temp_new();
     tcg_gen_mov_i32(val, cpu_regs[a->rs]);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(a->sz, val, cpu_sp);
+    rx_gen_st(ctx, a->sz, val, cpu_sp);
     return true;
 }
 
@@ -658,9 +658,9 @@ static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
     mem = tcg_temp_new();
     val = tcg_temp_new();
     addr = rx_index_addr(ctx, mem, a->ld, a->sz, a->rs);
-    rx_gen_ld(a->sz, val, addr);
+    rx_gen_ld(ctx, a->sz, val, addr);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(a->sz, val, cpu_sp);
+    rx_gen_st(ctx, a->sz, val, cpu_sp);
     return true;
 }
 
@@ -761,7 +761,7 @@ static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
         mem = tcg_temp_new();
         tcg_gen_setcondi_i32(dc.cond, val, dc.value, 0);
         addr = rx_index_addr(ctx, mem, a->sz, a->ld, a->rd);
-        rx_gen_st(a->sz, val, addr);
+        rx_gen_st(ctx, a->sz, val, addr);
     } else {
         tcg_gen_setcondi_i32(dc.cond, cpu_regs[a->rd], dc.value, 0);
     }
@@ -1898,25 +1898,25 @@ static void rx_bsetm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
-    rx_gen_ld(MO_8, val, mem);
+    rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_or_i32(val, val, mask);
-    rx_gen_st(MO_8, val, mem);
+    rx_gen_st(ctx, MO_8, val, mem);
 }
 
 static void rx_bclrm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
-    rx_gen_ld(MO_8, val, mem);
+    rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_andc_i32(val, val, mask);
-    rx_gen_st(MO_8, val, mem);
+    rx_gen_st(ctx, MO_8, val, mem);
 }
 
 static void rx_btstm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
-    rx_gen_ld(MO_8, val, mem);
+    rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_and_i32(val, val, mask);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, val, 0);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
@@ -1926,9 +1926,9 @@ static void rx_bnotm(DisasContext *ctx, TCGv mem, TCGv mask)
 {
     TCGv val;
     val = tcg_temp_new();
-    rx_gen_ld(MO_8, val, mem);
+    rx_gen_ld(ctx, MO_8, val, mem);
     tcg_gen_xor_i32(val, val, mask);
-    rx_gen_st(MO_8, val, mem);
+    rx_gen_st(ctx, MO_8, val, mem);
 }
 
 static void rx_bsetr(DisasContext *ctx, TCGv reg, TCGv mask)
@@ -2023,9 +2023,9 @@ static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
     val = tcg_temp_new();
     mem = tcg_temp_new();
     addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rd);
-    rx_gen_ld(MO_8, val, addr);
+    rx_gen_ld(ctx, MO_8, val, addr);
     bmcnd_op(val, a->cd, a->imm);
-    rx_gen_st(MO_8, val, addr);
+    rx_gen_st(ctx, MO_8, val, addr);
     return true;
 }
 
-- 
2.51.0


