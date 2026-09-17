Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E3C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kY-0003PI-Ta; Thu, 17 Sep 2026 00:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k5-0003Ci-6C
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jr-0006nO-SP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso3703985ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619324; x=1790224124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZC9cjz2S7VvubAvVoEtjxyzeRaMdSDwzLQ+JpOUV5dw=;
 b=hAX/g/brGzbTxTEQxHkgeekqhN9A7CY/iHMZuJ/BkuLMI4LEARmn27TII+c9eA9Bfo
 Ian90taczyDL29I2e1pX1lYlWp6AxVG/VQkULStlrqts0oUJJpwe6zFN9W+BqEWqWQen
 Ms81ana6I9FbzROGqy99Rhx4wmiE/tG8cG+eKQX14UTZVeH/NCSMBN3tIwoBXsNaBvEp
 dToR52jfUDLbvx3cHiaRJy54bZar9HZhyZZLh646cf1UIkmD5G6HKg74vpeGZ3IykHQS
 aLrWXycnOtt1lqRJ6xvskOgD6RdWLUL9Yr9WApT6vsAYYDpIXqQq9RhgPJjar5e0VWh5
 8NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619324; x=1790224124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZC9cjz2S7VvubAvVoEtjxyzeRaMdSDwzLQ+JpOUV5dw=;
 b=yi0MoKRBYzz/4AmaYMXsW7orYflHQna+9Lp/1HS4/96qCZcLWIagRKksjCTLxD0QvA
 WUOcz7H9FqhyfbInSnn19DgCyl6W05pHsisCYG2OJkMJ0hKWeSBM4y5++PxVqxswG1Ef
 YW4oBnRmp7OXyxS5Akeq2HwtW9hAAOLKZt4+/HohLyfPLlau6DyNmWhXvijlcVUKXYhq
 fHACFiCvKSocBac0mlGyML0JBI4Nj76RJmVcRg1P1lHo0HYWyLljOAMx4elLs9k2IPVs
 q7+CrIoex9i+cXVsqInvRRU21ob9WZ9+jPMSxygHCMjaIbm+C/hMOMqe/Qp+IUgjEpS+
 JExQ==
X-Gm-Message-State: AFuF++lpA6IgoU2Uhjf33xujD0aeUT+L/xSSF1UPDC/pg+WkUfWKk3Zc
 /+NMVv95e74ePDNodDLE4tAruBQNtyKWPXAczxrDpkVeHr7gQ5V+5fOb9qo7Blun2yQYjzA63OX
 VyWzf27Y=
X-Gm-Gg: AYBFou2Fn8NX3cyOcLn9yiT+wRwRpjX+YkN5EnIe4m2YQmOEQnUSQAk50CRdsecfx7I
 jIcamVM9qlBC7ChfWJm1aKamJPt6F76yCisDXG8djCTdlHOrLEUkTZPNz5+uOBrKCbzV23W7K7d
 TvirscckGlq24dOoM2xt4gUOGsh3e8ay8S80FeKHMta3I3ZfJUCI5+YzPpyZ/hCPx0O6quvWfDf
 DDs+GNFClugZnD7r9NLewGT3gQi+camdMbtZqsnyznxtNz35zc0gSnvzqAYh0sAluMmA4Rt6cRO
 oG5YGRn6rvtnQWuR3mAqJpO2YbvUpVOuJRuLzpj1oyY5FahhmyDaavWRWc2/2QnRUl3LjRC2Cbd
 rdEyZUAllBEGkW6hEmxWNowoH0m5LXuGVFJ7MbTOEkscNTHY4qbuf9B3jVkOLyQL8bM0lqlWUQD
 A9ZWOQtmEVTAHFfXLlIemplg2mbIZlbmabEA2V3+eRTStqWfNKHjo+akDX/C9Y8qDLW+3R4xKls
 TOh0VA=
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39e1e504f3fmr17413402a91.20.1789619323604; 
 Wed, 16 Sep 2026 21:28:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 016/101] tcg: Generic expansion of tcg_gen_neg_*
Date: Wed, 16 Sep 2026 18:26:58 -1000
Message-ID: <20260917042823.542588-17-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index db5315a5cd5..7d4765460b2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -218,7 +218,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -327,8 +326,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 122a71d7c4a..77b1260a292 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,5 +5,6 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ba756d4aa69..6aee0190e0d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_neg, type, dst, src);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -449,11 +454,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1571,11 +1571,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


