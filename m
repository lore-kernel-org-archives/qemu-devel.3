Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F3DC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kK-0003Ii-TU; Thu, 17 Sep 2026 00:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k6-0003Cp-TZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006nx-Im
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so309139a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619329; x=1790224129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZMzrrEL3HX7oRdMffSDqbnrF+w9NjI3ZykN767yq/3Y=;
 b=l4+a1qWp1GCLRQvyOxcyR6O5at/gzRQZhx8OSOe/yACfyChlYsCsBR715ngWNSmadN
 rrSVCnPQ8ZgA5sDPGSCDclAEfCVh9AcFJHLGlc1lhzrOgomsn0ciXpwlR8O3VrIubOu3
 n5X3A+Ek4llOw9pxYw0z9+GdDMqA6E5BH9KR1rHk5rftMqKnLgNfxO1H7NiOi/k4GWRl
 W0SKC3NQrZFaTrTk1rpnGBJD5qshh9T3BrdeHC9yrzFJL0jZLFNzrj8NE1H6ffoWMeeS
 zOUzlZ4+0aX2ns9JS954rlfuFuQ2zoxuug65ScfmlNSHpxwnpWSWPgvVI/y42FU64WTI
 XeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619329; x=1790224129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZMzrrEL3HX7oRdMffSDqbnrF+w9NjI3ZykN767yq/3Y=;
 b=E6kXgs0W8v5qO9oGKQOKmQm2MXUO/JLH0yoLJ0l8BxY/dq0bkj7oGSg6C8OLh7pX3C
 IUDXtX2HbUoo+WsqrcBvab+taAma/LJylbnmZrmCncS7o5vr4ocMneW7mtrX3xyfnLzw
 Y5Q0DtOO1pBfJVVey5T/ZLi4zZFRGuEahMt42Y2hQ60RcVOOZakaID0GOJn2YNhmYoGg
 BghD3v1B8X4JZ8rhM4HYGs0gR+nyes51/5dfVVYu1xbxJLojG7CTk171ZTXQlUpfV37M
 IPU070NPFh0PfofccvhG04MdQHhoD/J/kc3jUatcNAoUpx4K+NIjpE+1r7lZrwqpVrgk
 Ssow==
X-Gm-Message-State: AFuF++n3TaeJeRdTxXXHeoMPgVklADJF8U2KM7ojZYpFRm89rWnyXh7H
 iXNn4HmghYbLcAcnYz7Za6rcpBc2h5otG0NwsFi8/1MwrqAzIAqk5yRVjq/vKSXBL0eN1rK1NVH
 TasFvN4U=
X-Gm-Gg: AYBFou1oWMzFflAYx0/g9zgyYC+uP1c7WnHKXyDSuiXTr11ccFtFXVDla1PfPzctzGa
 /yPvi70MHbVCbRuS2h/NmKXux1SmFccK42A4wZt/skmqPsvxWd6b0U5EGiP0uT5jL76OABChIbH
 rMJVD0oNTDlCzDBX3MvD7a5VfJ5FusSTuB6HbmYNtHcVDgDS2hNCq2oCKoOJpYBkbmETVm7QfbA
 e3vnpm+9Q+RAwKKk/LiSyemtUB9SQAyUJ+p/G1zif62lb29bkHaYG/jVkqkTk3y+lRDxbTyVZrn
 ddS0MBCxPz06L5k/esRtiKk6MvDkMdPqSybA067WPoHdPT+VTBJO479g+qfHF3DkawkruHkCEj3
 xBYlKma75Mze5SKi2oe2egM5tD4WCYZlgJFOTUWbm5vVtb7lmEwG/5AFfxU3LmWNfoqay7mAXOh
 Gg8SGuYQqjOF+spq4tW8Jqmt9KUuCB6AZ0l8TydL8b+4SXfVNC4Hvo9gQuzUkKOuqQlLABpFCT4
 R1cnT8=
X-Received: by 2002:a17:90a:d01:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-39e237c51f8mr6523166a91.13.1789619328801; 
 Wed, 16 Sep 2026 21:28:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 021/101] tcg: Generic expansion of tcg_gen_shl_*
Date: Wed, 16 Sep 2026 18:27:03 -1000
Message-ID: <20260917042823.542588-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6365f67494e..5115b07ef22 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47d3e6f6990..15cbb6c341a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2b796f3cc62..19e2c6c713f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,6 +443,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -534,11 +539,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


