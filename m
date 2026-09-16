Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0755C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKg-0002xC-DH; Wed, 16 Sep 2026 09:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK5-0001pH-4E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:14 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK2-0000Yc-OA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:12 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc88a9baso683663fac.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563909; x=1790168709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9f9DyXWd+AEgfGwk8FS/+nASQmdznA6xYwGP3lWH3us=;
 b=zQ9rc39BlhGtAt4u/kAneCYAMzrwREaQOLZ8r1ULbfk99w0XQXN+Nak5LG165dbhVt
 oEHV9xM6Tk2e6v6bHhVDzuGIZiUWEt2zgnX5eGo662k8zL0fsrPrIh8DBB/Wc352Mmwq
 fV0vzL1+WnzM8DPO5YtrmcEM3vXiDEiCQ048z9Zti/xagbis8EfcWqMXbmfcwlZiWCXs
 8OwptmQiVf9UeGV5VyA3XgZVy33lBFJvYgNimNbq83mowBSl8y8od3CDexNUaHbT2474
 Hg3qpL/QXladZgIhocZdeNpxHfZa7KPRgIwM0dkU+LpgyDt3yqcKu/JBdkhiNcInxuHV
 ffrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563909; x=1790168709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9f9DyXWd+AEgfGwk8FS/+nASQmdznA6xYwGP3lWH3us=;
 b=K9csYufkH33uYvB71egldSNOOeBhgUFZZr7KKcO3oDM/2cwCIF/Z5wkF64hO05fU88
 yipppts5ZQ8sh80M5I+0fXAPvDxCKd3+mkQxyVBgtzDiHjeZdbROLFKCLfFGasLCUKd/
 Dw7uqrIPNSdBQ5OaiaEwIEnL/VLROcZTAl66bTjqKZVhSYMRdkHTZaIodf5VNQDXhiXi
 ifSL8pWuK/t7dd7COS+tpfXdEegIv0bhv1q/gFPcptcyMwEftSmv7yiaVp2Z5BD0bx5W
 nNOUTDmCWBdbZiGqJ1Kvzcun+saEdAkVfXOfLCKFUQr/pxnY8NbiE0TBJ3LsKsMeSmCY
 1LbA==
X-Gm-Message-State: AFuF++kU78CZMWzljLEcSmCa8MvCfNsOTIaXTnBKbJGhlhTe/26oCJGy
 Epu2SiaaBbDePPWtDh66jn9ia+On90zlOLW+57xOXbsaAR5BG7IQamjOyOO5MNoN9Sw39+Ouw5l
 NBgn5jV8=
X-Gm-Gg: AYBFou1B+zW7KTIrAiAlO3vMeSVLG0kEL97YBGGHr7si9+5cv6VBKqAoA7SA6+9OTnZ
 UH7D1KcMWKjJKBrEx68KHHIQ4nQHeUzfv/NpyWFnLtmcesngJWrYlIkOMUDnBA5lILdLlskp82I
 QA23OnYF3OUDsD8nM4g+eBqyfEhgN7kjmCgsyKisWz+jreuCqaXgqnmCW1D4hCzILzN/Patkh0X
 YrQ8pc2KoptmRJ9cPgdPRjxXren1riqoK4IV3yryQJMogIIoLCDBw6SwKKlflG2s0so75Dd1xZ8
 bIdV+sa8vIFC8tVo1VJS1oyhq9ndXZYg/eggy667ecYFeMiZwAudiNVBNQ5yR9xfcY0BXyGjdCH
 66nEOIKgelactZNS+87VcRTrnnDqFtz22qCpDq7qyKltC1hBvTfqMyKzwKqv+69vDaf35qZfXv9
 eGz1bLJ3xfaN2Ja2BoDQl2q2UV/TrhUGIPsyw6S431UUIphChXLwqg0hmbVgKnG8eP3UYJjbiZW
 KfOH/0yQTNYf8nocw==
X-Received: by 2002:a05:6820:3107:b0:6c1:7804:55ec with SMTP id
 006d021491bc7-6c7d2df9183mr2470331eaf.44.1789563909388; 
 Wed, 16 Sep 2026 06:05:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 37/92] tcg: Generic expansion of tcg_gen_nand_*
Date: Wed, 16 Sep 2026 03:03:12 -1000
Message-ID: <20260916130409.3382710-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
index fbbc3acad83..613e844aecb 100644
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
index c1b99a280ac..80d174a6cb1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1cb450bba9c..f5edd77602a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -527,6 +527,16 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        gen_and(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -740,16 +750,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


