Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085BFC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklJ-0003HV-7Q; Sun, 27 Sep 2026 05:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkm-0002ZU-Or
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkf-0007UF-Lf
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:58 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc7979d1dedso470460a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499651; x=1791104451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cgqFHgbP5yHKTQHTL6K0aZ4BbCoBLWvG8Wuj8Q1dfQo=;
 b=QcdfIQe7+bRZZyIm94qqP/mGOXahIfyOdniLb47z8chu55Cegb7ZrSZISCSFWZRBLP
 OKGcri2SCIcfawV0BAWa0pP3d56/fpbj3Y8/bSbxu5h3KzfOZDZaXtuTR0aJFlnpe/++
 c0/dK1HQIzkLzCt6BEIPbA5JLf1qRQ1XVSyETl9aI5wBI7iV0iLvnvl32NL5fLAyphr6
 9yTdwngONfTBwXhF7henZWGF2F7gaoYKDoWDC37bFyarOkSrLrO8GeBrEq9Tv3/hURsY
 ecCECMWmb3uFL3JdGfgiigQc1BKfGYZNqTV92dVOhoRR5UJzNuspgSnMCNKMN3edIPcu
 7kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499651; x=1791104451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cgqFHgbP5yHKTQHTL6K0aZ4BbCoBLWvG8Wuj8Q1dfQo=;
 b=r9GCRs6KCMsesWy6H9eRCJw9NJ6MCJcvoxpTFHR9gQY6ZBrxGjOYdUQTO/dJ8yJ5vs
 cfS+btfIz8JvnUgbKHlHYRA9FvcQWGFMQMQi3eH14/KtiWAN9I8mnPq/9U8WBbM71cba
 KSTiRm6DhGbryb201SXM3nLBYZ6y4SluU70b5+kXks2noOtk6ViOMQ8/pXvWBHvnIybh
 11MCyudgil0YNtfkiwynxAWqwo67f/4Fbvuy7ptP7Oq3XO5pDwDU6m1OndMYmuO9x2TF
 1IHZa3+YOw2SMLAjibvf8JQ9GYHxzfZIyjwv7VJ6dBBADUdNQUB/VAhYe7HPDtm4n3J+
 XZKA==
X-Gm-Message-State: AFq9FYKQSCpi1rLiF+GkItfukyZQjSDlQ81/iqkisBk+TG08r+n7i+lA
 1ub7ZeGRUk94uQriajtVyBvuh+up3/eU3ukjvYSszsaNTEdPDyjLln7XOedWMAkP3h+FlJzNl1P
 UB9gV
X-Gm-Gg: AYBFou2JtmBNCItG6sldtf6gCp53OL6qnvgboNp0vcdwbWikD9UANhIzz6t94D01NH6
 jbctTxJL13EfJqmaoaDy3AAmpfg8xhvOUfBV2hj0IIS+jH0uSjJzXOWahEAR9vVGOjK6mzNxwBs
 iLZ1Dl4n75Ux5THw1ORLbV7nsuy9odFa0abV3QI6hhDa/PlwivGoA4Mg4rVMIVmARAl7I7x4JCt
 hL1I1rJayHPYZvvrRh9bL+VOuRafFX4xWQpzSwbf3hbzd8XYHojaN3owZtB1eMv/za1hur6FBMK
 AR3af4MJtyD9GTRzJJ2fOGnqh/H1qeMbJDCEtbqYbTWyHGpGRoNmaAsLn4R9KbPfJL4d7LGGxsK
 57gCXoqPBvbe3pxH/ytVpbTPcduj10z4JyH09W9TjdVU2fSR/H4iHgZSbtCySRfkuHsDkXpppFC
 bKMmz7GI5KqN1BtlvN8hg/CumIrf41Q5v4OKDjn4zW1dnNKqrc0rUIWOohnvQ1b5zcbn9kLysj2
 XPjfP3dV/aAdhPwJUSgKZX/BXexnA==
X-Received: by 2002:a17:90a:c105:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-3a098b3741amr8881256a91.16.1790499650548; 
 Sun, 27 Sep 2026 02:00:50 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 039/101] tcg: Generic expansion of tcg_gen_eqv_*
Date: Sun, 27 Sep 2026 01:59:09 -0700
Message-ID: <20260927090011.10724-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
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
index af50c90eb04..cfa94a1f5dc 100644
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
index 7386332658c..6a4d726b799 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e3ae8c2383f..f33b25734e0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,16 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        tcg_gen_xor(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -677,16 +687,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1724,16 +1724,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


