Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0D7C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPK-0002rE-RW; Mon, 13 May 2024 03:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP8-0002kQ-Dp
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP6-0001K7-8y
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41fe54cb0e3so24585415e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586442; x=1716191242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EF71oCEKPx9KffJ0nhQbR+6fCow0EB4c3hkf8VxLkbs=;
 b=MYpWRI/2Xf8UQ8dnUCdBm2fjM/mLe4wUep1V/aFN0zp4gUTbzwkAarDNM+FwO+muYJ
 IWvPZeRHWF/MnbtwHIRuQLb4C7MamnWBF3lij6I8PB+jr50E9T2GyUuyvnmSbxn5tYUR
 N3ZN6DDnEx2AwxLi1AEQpRkw03BfKXUgLjpIU4WMgikyN/HpPfNww/EtWaRzaUpQEvpR
 DZ35dFWkpErLR3CLTleC2jM6nLVVdHLf2q3lL4PtYYwO2HBffY0KsAVphWKzK6HcWUxh
 viQnhOqwkylmMRfRtoztUuhHzmZnIIENj75fULmKi2xkgdr32KHBHiVdSPhUjiPfjYHT
 +17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586442; x=1716191242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EF71oCEKPx9KffJ0nhQbR+6fCow0EB4c3hkf8VxLkbs=;
 b=Nq+JNAb2ePynh+BO3Zg9kEQ2FK7i8Mx7Vx5rNKemMLnAzvctqiLcmv1TvzBh1GeBr0
 2h6m9pC+fhTXeQRaK0NMsnrUeXay+X26JCgebMheE7Qj0BloAFAbVUX5Huzz4AuHFf+a
 840DxGFAFFJUM2hUChpZf3ma2fzJfvl3l/WVxnovuLkky4yotPORAdu6Dfw4qVQPSMGI
 j1fFLW83QiKIPqMa23IUJozGM1pOMSruNHLdQvjGHaYBcGWLDZmFPG7c0GWvtoM6CYnG
 OEbyrs4YDfh39LV4n28V4Rxa7aG2UWB3ija9h7qObiE4Mv2PV5M6UVsxYxoNh0kNmo2K
 9ajQ==
X-Gm-Message-State: AOJu0YyLsx2fr+VW/0nJJAgVacJthxsQQLx7Mx4qYihGBJbUiTzyr9kj
 7CGtRU2N41kLIzd+kQw3NToaDfhngzWnIxu80fzLH3bAp++h14eZQ7L74IztQCvBGjNnFtWL7wk
 XNGs=
X-Google-Smtp-Source: AGHT+IH0MP3m7Lw4XERojhlCysB49zTKxNdd4hpNuj2kz3lKHqAdjeLRkhzZhMCXeJ5D67E+jJpaZA==
X-Received: by 2002:a05:600c:1f93:b0:41e:dc7f:e2c with SMTP id
 5b1f17b1804b1-41feac59cddmr61728755e9.30.1715586442305; 
 Mon, 13 May 2024 00:47:22 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 04/45] target/hppa: Pass displacement to do_dbranch
Date: Mon, 13 May 2024 09:46:36 +0200
Message-Id: <20240513074717.130949-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Pass a displacement instead of an absolute value.

In trans_be, remove the user-only do_dbranch case.  The branch we are
attempting to optimize is to the zero page, which is perforce on a
different page than the code currently executing, which means that
we will *not* use a goto_tb.  Use a plain indirect branch instead,
which is what we got out of the attempted direct branch anyway.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 398803981c..4c42b518c5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1766,9 +1766,11 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static bool do_dbranch(DisasContext *ctx, uint64_t dest,
+static bool do_dbranch(DisasContext *ctx, int64_t disp,
                        unsigned link, bool is_n)
 {
+    uint64_t dest = iaoq_dest(ctx, disp);
+
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
             copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -1815,10 +1817,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     /* Handle TRUE and NEVER as direct branches.  */
     if (c == TCG_COND_ALWAYS) {
-        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
-    }
-    if (c == TCG_COND_NEVER) {
-        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+        return do_dbranch(ctx, disp, 0, is_n && disp >= 0);
     }
 
     taken = gen_new_label();
@@ -3914,22 +3913,6 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 {
     TCGv_i64 tmp;
 
-#ifdef CONFIG_USER_ONLY
-    /* ??? It seems like there should be a good way of using
-       "be disp(sr2, r0)", the canonical gateway entry mechanism
-       to our advantage.  But that appears to be inconvenient to
-       manage along side branch delay slots.  Therefore we handle
-       entry into the gateway page via absolute address.  */
-    /* Since we don't implement spaces, just branch.  Do notice the special
-       case of "be disp(*,r0)" using a direct branch to disp, so that we can
-       goto_tb to the TB containing the syscall.  */
-    if (a->b == 0) {
-        return do_dbranch(ctx, a->disp, a->l, a->n);
-    }
-#else
-    nullify_over(ctx);
-#endif
-
     tmp = tcg_temp_new_i64();
     tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
@@ -3939,6 +3922,8 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
+    nullify_over(ctx);
+
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -3968,7 +3953,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    return do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
+    return do_dbranch(ctx, a->disp, a->l, a->n);
 }
 
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
@@ -4022,7 +4007,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
-    return do_dbranch(ctx, dest, 0, a->n);
+    return do_dbranch(ctx, dest - iaoq_dest(ctx, 0), 0, a->n);
 }
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
@@ -4035,7 +4020,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         return do_ibranch(ctx, tmp, a->l, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
-        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
+        return do_dbranch(ctx, 0, a->l, a->n);
     }
 }
 
-- 
2.34.1


