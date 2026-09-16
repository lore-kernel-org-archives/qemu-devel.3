Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5CFC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKk-0003E8-VN; Wed, 16 Sep 2026 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK5-0001oy-3u
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK2-0000Xv-DQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2dd68a16955so22301785ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563909; x=1790168709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6ro3HYJ3hdQ6ae4Mr5BVXt8Debu3Ago/nOyJblBRJ5w=;
 b=Xlxo6+RtAs+zvqLw4Ryy03ZrdOKVG/9q4eglFRXU+bdhLM9DBgULl66Yk1qowyUJ0W
 PkK3gzppqglTAFKjIQzY30aBBt12c2q2yeGZZZ284R2H0HxWCQr+JhdhanuUigQhke5Z
 qFPomxI/JSowv8GpqayTCMlOx8/zBSvhCfWSusF0fDKZiwvXIP9dGDZT1Id2LFpTpOqa
 s0I+CZ8Gj6wZUfPynX9e+uqXgRLv691KBEZVBZ4A+o9biYWxtwDYl4paIRCtiZgsDYqa
 0LMYbXlOMoQNi5NuCd5awrS3+HgaOllL5lBCYZOeaw+uvPpArgCB7l9HkdVHpzRmA9bm
 Bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563909; x=1790168709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6ro3HYJ3hdQ6ae4Mr5BVXt8Debu3Ago/nOyJblBRJ5w=;
 b=hwHp96q+kH/hdaG5xkrxKqj+bJuOZgSp/oI8a000fsCpsMgkLYcJj9Pc11J56L7dau
 mDw+yjLFpbWPbpdw7ShiAcW3S0wnyxPJ+Gudhw28wV3U+fRhQzahD/z0oT+CSDEQLhbe
 h7EkFdnI5T34qN912wsTAYJIef6GtvVrOlQlTIZzzYyIfyn5X1qcj1veRtiRx5A6ixPY
 5ER46/zwkH+ArIvvGeTqMykD7xRihG04QWFAvIAADcXxowACDYtoWIh+t2LyNPQJkzyO
 VSe2hKRax0bp92RtajqJAUI5CT0VLxatLwjjLZpDR2UtAlYLLptI1XrHcFvgraMDiZVy
 U2cw==
X-Gm-Message-State: AFuF++klaaI1CGlnwbfemBfAeBj9khuW31XV0nIGEAGV6f+fOy/5vg4Y
 JEs+xtqiALDjTtcBJWxW90eigt9IAEWA88k9is7lyV2Utfi6WwATObV9I74AeyhqChEvcQE9XgT
 SMVhg
X-Gm-Gg: AYBFou0e47eaF8LuKWmESTvEGvga+YhDmhzJ5QPzzR91NiyxHg58vcaDNEryM71cHPO
 haSj4jUWg/7lm14osH1TwGmNFzRYJXKbKkyLa5gLfIyI7n0pjso2PsRAXler8cguFjngs9e69Uv
 jxWRa7NHCMPgLS0WzVvzaJnk9+Llq5JZKwe05JDECWzTgAu/8v1aIXhkjpnuTIZ6wGt/2vOGapg
 YmWeYm0kVie/MONqI+gr5dMdEHui3SaB0G/glr3KpZaujfzmMcRzCqB8Cb6Vux5FTAaDaUeEuGD
 0o8AaVBDHV7i+SMvzmmsPX5n8+Bg0uerH9lpIkirLtdpYsJeZZw3sEXco8Uq2n7qrAUh6I0Jx+y
 yT1IYgKd1wVBVO3Le96TWyMY2EzngJnVvQwsf9ZcWGt1XGCeUQ2oCt2N1OAg3bykitc8QHgDarH
 ZiVyoIbu+uxe2P9rx9KaT1DZTUAkUyefN8o4HjbHkKYdEpzZ3T6kk/aKc74VcHLPIU+/g4dlBQc
 1Zmz98=
X-Received: by 2002:a17:90b:4a92:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39dfe1ca2dbmr12184286a91.27.1789563908393; 
 Wed, 16 Sep 2026 06:05:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 36/92] tcg: Generic expansion of tcg_gen_eqv_*
Date: Wed, 16 Sep 2026 03:03:11 -1000
Message-ID: <20260916130409.3382710-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7517e8d9d9e..fbbc3acad83 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b05a1782513..c1b99a280ac 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 12837fc394b..1cb450bba9c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -489,6 +489,16 @@ static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        gen_xor(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -730,16 +740,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0


