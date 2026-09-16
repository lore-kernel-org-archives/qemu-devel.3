Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5829BC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pK4-0001nD-P7; Wed, 16 Sep 2026 09:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJW-00011f-J8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:40 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJU-0000Ik-KN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:38 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398c066106cso677331a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563875; x=1790168675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mRS7vobS39woljInot0zu4ep78CVsfZV7P7veSlVxro=;
 b=MlREuVnlDJ6BDHuZ0Hnf+ooeH6bsWIG0PLiJduchQ/B40WSo950XBJvAdu9t9AAwUY
 SSNWoKPitVzW3SCcP8dNMcMp2S6kJPHg2Go4EVmCic9VBoncHLm/raWv/gCY5gJgF4Cy
 L50u2WTwQXHz8N9imY4xQNCG+IVU2MkZCcxXueZmE7TKbaev0/zMIvy1ulMxq9iMjm4x
 Mkk2LdEyCf2Z+4yD8eTdloG7/wrjW7EZbikTxmFTN29Fn1Dp67nvmAdUkiNeYMfbOObm
 CzE2VWVpUiKdWKyUx4TpB+s8LrSE9a5555PYYYfaHDN/XtkON1GIPk3AzOR+DUUmTXD5
 so1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563875; x=1790168675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mRS7vobS39woljInot0zu4ep78CVsfZV7P7veSlVxro=;
 b=qkt26TsVtreXv2W7BTLpg6gYTJAVtm6+h4SxekjPbgaJ0jbqdLFKCfa8FBPMnWekr9
 bSOsLI1PS8Cx66KnQVn+plP5JQ+lDjFhtR9pq9f/g6he4jdmmZaW327+fKO1t07l26Hk
 3utmG7SXyhhN+OOzFHYB5lczQhEQDTneWZoGGrA6uJX9WUShKaKXGfKT7j8sgjaxh3PQ
 Hj2JhARMNo8ijyq1keBCyHbWNokSczYO5DVZwzZHKCjYMehunVEJdX/WtnNLd9f6qEmv
 fhpTtHpiOAmnQ9HQmsa4gGmcG1SpQXkVJfnCQ42al8oD5lD1fKEVucUeZNbfsJssu9XO
 ByrA==
X-Gm-Message-State: AFuF++kCJb//PZCoahSb4SAoEtag5GwjQhy7TZVQDvSwQn4FwV7TWCAx
 5AK2H1FP7usqays51U+YtBD1DspN6kPomSNGY+fy7Esjeiyen+WkjS1EWS/FZniAMll7HluUdlo
 /U49Mb/s=
X-Gm-Gg: AYBFou31AI2IL/Qtaa5UP7h6mOvLjf4Yw/be+RI2m9G2pderDLm8DCb5da70uJU8Ebb
 RORuGfE7+9qaP/7Ktnoz4zv9GebWvpihxtniA+9JMchKinUF7WZeBF7xmfRfVYP4S8vNBaZ0rME
 FR/LgytcRDyA2UuZmV9PubQr8RzbrOwBWdjzms3nlrm3j8jVUOJ25v/WZaE1g01Bappe0sPyZJ6
 PBhx9NbyzRgjqTFeMjlYnv3NZDDbN9hTHuM9j/bOieJuR/l8VYB+wSktzBPO0/SCvVk64kaq/rM
 QbvjBeQTM6bpbRQ5WC8lwcRvUeu5B2SVQRYfc2WlLljCru3Qjx4iF2SoNy28fUtau+de5+UBTqJ
 mhIjD1bmaDPsaJvt+e8BDb3PxBDa6nVumo+uOxKQfryYNYMf3n3xjvDfY8QsRfIqkfq9POiIDun
 4QbvcLEd8bv9c4DAlI41NJ+Ms0FjUVmx8iBw4iN4oxhn6AG7Op15eVi5PzZrxJKzP5RzOr+jhVC
 tzbGtSfnQl09tAf2w==
X-Received: by 2002:a17:90b:2585:b0:39e:261:4e10 with SMTP id
 98e67ed59e1d1-39e1e5380cdmr6945845a91.22.1789563875199; 
 Wed, 16 Sep 2026 06:04:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/92] tcg: Generic expansion of tcg_gen_subfi_*
Date: Wed, 16 Sep 2026 03:02:49 -1000
Message-ID: <20260916130409.3382710-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 21 ++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7d4765460b2..390df36f1c2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -222,7 +221,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 77b1260a292..9084171d6fc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,3 +8,4 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6aee0190e0d..bc902d04d53 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,17 +443,17 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
+static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
-    if (arg1 == 0) {
-        tcg_gen_neg_i32(ret, arg2);
+    if (src1 == 0) {
+        gen_neg(type, dst, src2);
     } else {
-        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
+        gen_sub(type, dst, tcg_constant_internal(type, src1), src2);
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1562,15 +1562,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
-{
-    if (arg1 == 0) {
-        tcg_gen_neg_i64(ret, arg2);
-    } else {
-        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
-    }
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


