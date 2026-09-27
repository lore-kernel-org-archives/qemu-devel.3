Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BFAC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksB-0006Y1-F1; Sun, 27 Sep 2026 05:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004R6-Ij
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:09 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknh-0007bk-2m
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:04 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1202116a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499834; x=1791104634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wEcUFHQg1GZg7tDPlQnRu10ZOlApiawywfRqQij+n4s=;
 b=TIzorUbSBVErX0AOnEfpFGZgdEdjGwqdQ5mztE/MfVZmPg0ZcFpJxHSf7qdbqwqBPa
 3eMdupYytGugVCdbSFLMasNZ7fKd/fFM31BZBBprvjaiyd+eMH4nuzM16O6OLcM1BAry
 lzSxxvofeUVetMFBPV8nB/vMK5j8c1mowupmkFtyI+uAMJjlOUjTCGAfbehrWihG2fvQ
 LSE3Q1EilE95GjCAOuWQpOWQ5ftcqRddFcLrvKhvQxj2QfNw1XEgGCm6U9BxqE2+hrXk
 YQJfGrSM49Xj0uwop/joxaaFnpAMGV4+EZ5DoAvVW5w9UveTIFecFHHnp/YgltEYE1sC
 xdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499834; x=1791104634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wEcUFHQg1GZg7tDPlQnRu10ZOlApiawywfRqQij+n4s=;
 b=MIonPKSdT8AmVfw9sxO298zUhvddBrv4XqSg4RrB65kM8Iu1Ld3NqfnoYvREGpdrMQ
 tlPItwelpfQGimlGw/j34k3yMpwKdsIZyXOerJyu255KpbXdc1Ne0eO7VjGxkYXedt89
 wyiBocxQ0LnbWXhNmco7rifWnlexm1YJk0t9/KBu4iSRINk0qwRGWbIwiC2AmtA6EAPH
 RVvjDrIPvwKJhklriZ+qLeRWPEDXw/uZWWiLNbQhIif3AEJlDupnNcNJXXtlUHqQToYo
 8KEoHX9YHnzhCjqVtKU86/poQPr97YU/egddcICL+hq3A3tdfI12AOFRKJ0+ocOrJxRx
 h6zg==
X-Gm-Message-State: AFq9FYKs0vDEgRq/kT8eopHOb1nMuH6bW56QED5JaRZDjLiwenNu0j02
 Uzb0iLbbimP4NS6//Cx4C5PuWsh19DLFSUV7Zb9CNJ83Fyp93iYXdJPPImVa8GxuRV2I4Ti1zSc
 BNS72
X-Gm-Gg: AYBFou2OMUkBdhvu3MO+NJXUnt+5NPqj5Ehe+Ea1shJvHr5yostfkYJt9Nlibs+a8OH
 bBIMYE/Q/2qEKjLKPRqibatx66jk1rVyfC9Fg8rR8YXj1HK8tTZs12nqbjbPO3mgYOrGX+m9Cv9
 84GsQ1ZhK5UxwQ+zLHrLQ7WB5W9KuGrwuudcAm+qz0nSQJVIve/3VcEbV0egNlwy5IAONJCe201
 ooDNv3Aiq2JxEamfInFCrAtAIf+wbfxRSJwGmznxJ/3fultHhS4O0cCdRr4qV41y0YG6D1Q5R/d
 slqWVjhgJ2iKg7GydEn8hMrlicmpJWzU2iyipQth0/GYtuJPNGLsOwk5QGuEEQLESkJNz4Ww9/d
 sD2Cd7HitWDxWLOqg/ho9CpUjiEusswsw5XygraKFTydqcDoIyz2pZb24ZrHB4tn07K3UpcJdLZ
 FXuQ6wFVa34E7WNuf0LyiiSur1pnooLzWBEmnqEpCWj1MExmboJY3hkXg4UZ26G/lPOdnlVdpno
 XKshy/iNl7nEwPGcs39fyREaP6XSoayNBTYB4R6HP+dWUPeMTU=
X-Received: by 2002:a17:90b:3d82:b0:3a1:6719:6892 with SMTP id
 98e67ed59e1d1-3a167198c41mr1257426a91.11.1790499833882; 
 Sun, 27 Sep 2026 02:03:53 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 041/101] tcg: Generic expansion of tcg_gen_nor_*
Date: Sun, 27 Sep 2026 01:59:11 -0700
Message-ID: <20260927090011.10724-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 04d85e25d68..f5bb4d8031f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index fc40bca553f..7d94e0cdfeb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0e9a1758ed9..f06c00f7263 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -491,6 +491,16 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        tcg_gen_or(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -697,16 +707,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1724,16 +1724,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


