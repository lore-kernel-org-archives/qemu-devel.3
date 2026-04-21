Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728B8F327DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtR-000434-Fr; Tue, 21 Apr 2026 13:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtB-0003nT-Sx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:59 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt6-0006hS-GW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:55 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-41708f6c3feso2904203fac.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792463; x=1777397263; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mfdyYv/dTUTBorCKUtHWx0TpDUjZosLCy+lrLFfRytI=;
 b=hwfD3oZNj2o4QL5AwNjmvhyX9LrVVc1JHOtQdbSQWMEsfFHTqFVdUraN7RQHD/11tk
 /cO7tDf/G0wcFhykfUJIjogURpgnL9IgX73bFZ7pTbLdyI1bUDhkSnOeak/ykj3v3lX6
 1irxuaCWwLFnnAnMcrzOsi2+HAX5D6ZR0UPjo+dAr7QbtNjNi3NpbrjBVdGEQzCuFlH2
 kkkhpn7xzt9Z/oY9Xnxh2zyXOtHzG7ekjEut72jOjrgcjNKtutpuS2SYGCEQwGSN9XNw
 NahIr12lZeA5Tlid0a1X20A92jEua/KXXoL6szTanxYFKEkzMx7aAqf+KoINpvO9/410
 jUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792463; x=1777397263;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mfdyYv/dTUTBorCKUtHWx0TpDUjZosLCy+lrLFfRytI=;
 b=DoI3h45dbKqUfWLelEr9aDvPN8LeLo6Ig6O+xQb2Jau3shsaKXkVMDdZ98Eu6jeGww
 LCWPVDIVn7G+Ixb37yij88ZAQe8MKw5s8lObAs319zNWOE2WVU+yZPCOvPnqSSc+GRdR
 sD6lSo/WLjZ71ckOol58c69AegQKgZHH7gPU1d7YmqQpsauGaP7oOqLOoDHk9KvWn+WX
 GfSN0nQw+ya+4nX4V0GFfpx84Z0nwR6ZxoVCAa13K2gT2mYxcXz+44f3Q6kwLSq3yP69
 JIMUO8ZXw/VXROhKV6SSci55u+4WthDsa9QfkqIqvV7E+0wU8CUgd/WVYd67Us43Stcx
 vOQg==
X-Gm-Message-State: AOJu0Yxs+zT0CJ8bDylV9kSQiKEVHmq7XWhPLFrTHnnb5tjU5ukfooF1
 GQ3C7oRrY8gEKOIk2EJwTlW45w3kzWoH+ol3uL+CKjnJd8jh5j5aAdS8
X-Gm-Gg: AeBDietJN9aqtpzaB0D4dCaa6hbSdZQz1g8q9igDOsYJz/+JCRvIMbPrtDXMw61vPUb
 sXKbWf9N/IdtWeVugzMpDyQM2I7YQ1Tk98myciYXhpNLauAPs6Sh0U2zZE/6tBMWGgwEo1VqkjV
 AVFZlrgQI6kqKV7KQdygmskj1JVzmvjN+Jb7zAXktLGqXD/SM8YXpC9uTenysqGASSYqnMRWv0a
 qMNR76LNTh5XQruuDSyOYPOTfZ/wc3pZNZOfxIjSRA7vi1NbkkJT0LSET6zCh0tT3CnWd0LSGQn
 DYPPuIHBi/a0qRaY4az6nj7Ev0569CXw3uRqwpwWoZjS/pCc+DWvboUJwTLJ1E7o42g7JqrM+2g
 XVUaCX93TgIM6CQKcmxtA+4LIihPGVwIZC66+itnm9ZCjla0Ri7eZffrdEp0gnw6kwzyro6nFGR
 1K3ykJZKPVnSk0HEGVIxDWESpqXKnYzhPD+GN02t4WhcAMwQ70HB6TJFwhugi3D5m2Pbb7tm6gx
 C9ApmtjriibUDj0yG2Fixx3M2YV3sUaJ79oTcvveee7dUEocooczkCO26Z9rel4ooZ0AvdZ3mkl
 iQdiMjwJGnrJEYi1
X-Received: by 2002:a05:6870:44d1:b0:3f1:6d93:4386 with SMTP id
 586e51a60fabf-42abf2171f5mr11561447fac.1.1776792462967; 
 Tue, 21 Apr 2026 10:27:42 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:31 -0600
Subject: [PATCH v2 04/13] target/mips: use explicit i64 TCG ops for Octeon
 translation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-4-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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

Octeon instructions are only available on 64-bit CPUs. Use explicit i64
TCG temporaries and operations in the existing Octeon translator paths,
and reject 64-bit-only forms when decoding for a non-64-bit target.

This matches the architectural restriction directly and avoids depending
on target_ulong width in translator code that is only valid for MIPS64.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/tcg/octeon_translate.c | 76 +++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index fce01eb196..73090ce6d8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,9 +13,15 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+static bool octeon_check_64(DisasContext *ctx)
+{
+    check_mips_64(ctx);
+    return ctx->base.is_jmp == DISAS_NEXT;
+}
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
-    TCGv p;
+    TCGv_i64 p;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         LOG_DISAS("Branch in delay / forbidden slot at PC 0x%" VADDR_PRIx "\n",
@@ -25,14 +31,14 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
     }
 
     /* Load needed operands */
-    TCGv t0 = tcg_temp_new();
+    TCGv_i64 t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
 
-    p = tcg_constant_tl(1ULL << a->p);
+    p = tcg_constant_i64(1ULL << a->p);
     if (a->set) {
-        tcg_gen_and_tl(bcond, p, t0);
+        tcg_gen_and_i64(bcond, p, t0);
     } else {
-        tcg_gen_andc_tl(bcond, p, t0);
+        tcg_gen_andc_i64(bcond, p, t0);
     }
 
     ctx->hflags |= MIPS_HFLAG_BC;
@@ -43,15 +49,15 @@ static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 
 static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
@@ -63,15 +69,19 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 
 static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
+
+    if (!octeon_check_64(ctx)) {
+        return true;
+    }
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
@@ -82,74 +92,78 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 
 static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
-    tcg_gen_sextract_tl(t0, t0, a->p, a->lenm1 + 1);
+    tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
 }
 
 static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
-    tcg_gen_deposit_z_tl(t0, t0, a->p, a->lenm1 + 1);
+    tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
     gen_store_gpr(t0, a->rt);
     return true;
 }
 
 static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
+
+    if (a->dw && !octeon_check_64(ctx)) {
+        return true;
+    }
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {
         tcg_gen_andi_i64(t0, t0, 0xffffffff);
     }
-    tcg_gen_ctpop_tl(t0, t0);
+    tcg_gen_ctpop_i64(t0, t0);
     gen_store_gpr(t0, a->rd);
     return true;
 }
 
 static bool trans_seqne(DisasContext *ctx, const arg_cmp3 *a)
 {
-    TCGv t0, t1;
+    TCGv_i64 t0, t1;
 
     if (a->rd == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
-    t1 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     if (a->ne) {
-        tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
+        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
     } else {
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
+        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
     }
     return true;
 }
@@ -166,23 +180,23 @@ static bool trans_SNE(DisasContext *ctx, arg_cmp3 *a)
 
 static bool trans_seqnei(DisasContext *ctx, const arg_cmpi *a)
 {
-    TCGv t0;
+    TCGv_i64 t0;
 
     if (a->rt == 0) {
         /* nop */
         return true;
     }
 
-    t0 = tcg_temp_new();
+    t0 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
 
     /* Sign-extend to 64 bit value */
     int64_t imm = a->imm;
     if (a->ne) {
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
+        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
     } else {
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
+        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
     }
     return true;
 }
@@ -199,6 +213,10 @@ static bool trans_SNEI(DisasContext *ctx, arg_cmpi *a)
 
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
+    if (mop == MO_UQ && !octeon_check_64(ctx)) {
+        return true;
+    }
+
     gen_lx(ctx, a->rd, a->base, a->index, mop);
 
     return true;

-- 
2.53.0


