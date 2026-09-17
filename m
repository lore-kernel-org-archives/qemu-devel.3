Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C99C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rT-0004Qd-Jq; Thu, 17 Sep 2026 00:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r2-00041X-41
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:12 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r0-0007yB-Cz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:11 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso360866a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619769; x=1790224569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=07fvl0WaBM0yySjdM7M1wp/5mJtQ8eihJCwoTtXcH9o=;
 b=L2DmD7/91kQsejH1w8BXt+UyrVqZRLaW5kAuMs0VPAkOWir+cweIIlhzhhLz6Riv6e
 6o0JHUeqGmQ018QlZd1tbx4PYDwGN9rmaK6evJHepPYF/BykvF2Sszs+RcbIC/8b6STU
 WI6aCn6foA5FY55Re07F5gCFy5Hi+8UpC0tpyljEponxpAWOFaRkKVeBjaYMSL1JTeIp
 ZhCmF+2+jOO1wvfKjZrY/2ROExVbadwityWE9UWDY4ZOq8Y2ABe0nmPPnl+WEZHUKSR0
 B2gXxSDuhh2t7FUGI0TYaH5WXHcehJZv7GGmqxrJ11BK0bx3yE1mpxNV5p9kVWGwV0Kk
 RCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619769; x=1790224569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=07fvl0WaBM0yySjdM7M1wp/5mJtQ8eihJCwoTtXcH9o=;
 b=caQRlBuPULEX3KUS86hLVFyW7nm59NUQa43nmhjKZ73fsWwFsDql0bBh+8EeZ3h7HT
 u91vTbpJ1LNlYVBMsFLu8BrAQ53atnYTNstKGlIZRi4BjO/83olWENPTofB54G9OpZky
 MzHkwY57FuUKVzDnfJdxn9lOL3gKNTa6eTT9Peh2SWsU38QhpuE9DzGHNUogcuSHMgm1
 alYI1+O1wPxQHM2uVbAseJoC7tYDNEaf7YTKx6bNqBhHU8us2HLWEGl18JxrXkBHkNMi
 AUDOcWZRcNBrKfbIZDZGeYg90xAzxISZV7E0pVMD7C1oxaSfIgRRG1IbadXttf7Ugajj
 xwfg==
X-Gm-Message-State: AFuF++liHLUF+lz6tApKT8mOkHP+blmC6Ka+kZWTKUjJ4sk3zZrM6YvR
 VjkJnWY0RwWnoa1gWLA8kF0IC1ZE405FGRaC7BhPV9OtROILB9j5aSJTxE6ZwruaKnQkdkVnn/+
 Nz9f3Z78=
X-Gm-Gg: AYBFou2MCk/Ucly8sBTwPdRdqJp1+rzPJgq0yelJ7hhnqR6fTqcO3swUYt8I3oyTBBs
 6hXNZbCa0/yoaAXMMfzB0OgwSh1e23u7xccUderCVP5wsc8tv75zukKzETWDmcASlGF4TdEbwGI
 CSipUcZfeTvLRG5ZaInGYrciXtIoyAcFyxJ+juY9jNTC18GpUWeniIZiJvfUz8j+frAtx4+rysX
 FntPwiLNibET5zqxylaU72xACntqeG9k3ekb3ZLE90vQAQd8fB8NF7cVALgOGjsoJI3CpaRBxNq
 tKb791Fo3pjQf1KkUNnL1dNIIn9LzzpRKzDRmpvTHaFmBcP1hcPvKT6PAL9TIEZBfWcXPRToZuN
 ELCS1ETYnYwb4HTUHYIrVbZD0/TWQEesszYmAdA6E8OuYEpuF2lA0mvr45cfrFQ1jocbiqik1+f
 XeWYriD/bpkS8rriZMitH97M4YYNHct/VW2grHniuiDboViEL0/CzIakQjaJQTEH4sgpxi5e5Zn
 zO5yjojBxF1YnUPWQ==
X-Received: by 2002:a17:90b:3c91:b0:39b:370e:c807 with SMTP id
 98e67ed59e1d1-39e1e4c5116mr12396400a91.17.1789619769094; 
 Wed, 16 Sep 2026 21:36:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 097/101] tcg: Generic expansion of tcg_gen_st8_*
Date: Wed, 16 Sep 2026 18:28:19 -1000
Message-ID: <20260917042823.542588-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 942d8168325..0640774f8b1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
@@ -159,7 +158,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a002163b04c..0bb9f894564 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -70,6 +70,7 @@ DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9216e8cb95d..080c7ce1982 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1380,6 +1380,12 @@ static void gen_st(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_st, type, dst, base, ofs);
 }
 
+static void gen_st8(TCGType type, TCGTemp *dst,
+                    TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1531,11 +1537,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
@@ -1553,11 +1554,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-- 
2.53.0


