Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAA0C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpo-0000jG-1L; Sun, 27 Sep 2026 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknj-0004P3-LP
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:06 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknZ-0007bc-Ek
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:03:55 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so925290a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499832; x=1791104632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51CZ2xpfdkCXHB9ibTz57bSsek3b4ljykHln8pFfn50=;
 b=Iy0cv0kRLSAzfuwBKfXaPlSbp1mxUeC4R+WAhDtkIXRpZ+v6rYG1Kv5EFaFlUD8A0O
 yEcnKOsRS21kAXlCa5KPx+O3BwrD0FzyiPBGqoKPghAITJyimymTTqmXMGqBjKX40cwp
 p4yk1cgZ51/Go4YeaW2xIbGAt3dfrn84G74dKbhyjhw96uwzi6+odKMyg36GywoyBxev
 P3q1NfLkt0CnW+tzvgzUc3y5Re6v9ojoQI6fc/XDGPX5xoxPDlSLkAc5oCnjtw1fXikh
 Uf/FA66WbuZ/xiEuHDhWKPfL+NF4UklcMR0ZERVQZ8jsFXmWO67DzxKalyPFfsnyc9RR
 DOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499832; x=1791104632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51CZ2xpfdkCXHB9ibTz57bSsek3b4ljykHln8pFfn50=;
 b=dELcQcYWbTkWVlTcrUu7Xdxq6dP1aSQ2+or40y+zLuRI5M67n1ZKqux2e4N7Uh8vmL
 dNB5/DF2ErXxYCgmobJuJAa7x2hdVebGp6BfGDVSblZ5q+btTGdE5tdNaXMjdkubsBFi
 gZBrgWHVuk1a5VOgqPQkJ6xmlLt1KvI+oIPIe2vKpogiwFg0Re9x2+3mND1iGy8XnxOk
 lnNteeH/eeTlKF/D94yCnO1IspsTIHDLf8+GVNO0vYK3EEOx2jlplXlkZv4rPts7lWmU
 5B00m0JuRYP+QS5Koa+ERoGCd3CrVx1zQlKEbReySeMRUZdIWYSSfqNuX8RRZYBdfR/W
 yTfA==
X-Gm-Message-State: AFq9FYJGB7KaA8dofEPgDKNxG0rDnMWF7OeHdYJUcPMFFvxhqkN2unD2
 yuCoRsCjBYNl/k+ZJL2Ofg+eVMCygRCpGG+yumkCmkYPtChFIfLZUF7nsNmJ5JCgTuJgFLOLhsz
 91nWm
X-Gm-Gg: AYBFou0lHblylzsAd6DpjlgQp5yvGXOZzTarKpomakIlvXxdHYzAVEb2bgIHfnLoBaj
 OryxLkMALViO454+HoDb41UGGlmcEYo4+RgzRd+rBOlaFst7n+dX2gdYdk1z7MmPyY8LFUZE/i9
 va0tz/+J19/UEsgvitm+BdzK8q7nxZwojI0rj69RBVBHOBsZ+4NY5YRIGCvTNnzWUgCRx1TKezC
 x/ym3zIYpYIGicyjcZNaVSSa+aIOxSr9fkAGZMxNPIchMPEYn3nfg5ZMhJgWV7vYlAhYmlIFPHK
 mDUA8P+7BxomA6v4O+vw4WqwfP08KatY77rH53HxQprk+KjVZYjqP2BgHJQ0EJhK6+/WyZYMi3x
 G2YyN4bXfF0DzuVMswtya17NezVIKJo8KtK7WtEhIj7kDrKsudYW81vPtK/esj8XkxoCj2z0wtd
 f0uZdTP1Bx7HttF6lCqMgjwd6Dfnw41e8O8hKwuut+vxGsgGOikJyZs07AODXw1mFAj+KO2MGU0
 DHZPPujyzEpPcdIct5qGmxilHLfRw==
X-Received: by 2002:a17:90a:ec83:b0:39e:21a7:5dff with SMTP id
 98e67ed59e1d1-3a098d453aamr8010143a91.11.1790499831908; 
 Sun, 27 Sep 2026 02:03:51 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 040/101] tcg: Generic expansion of tcg_gen_nand_*
Date: Sun, 27 Sep 2026 01:59:10 -0700
Message-ID: <20260927090011.10724-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
index cfa94a1f5dc..04d85e25d68 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6a4d726b799..fc40bca553f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f33b25734e0..0e9a1758ed9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -476,6 +476,16 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        tcg_gen_and(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -687,16 +697,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1724,16 +1724,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0


