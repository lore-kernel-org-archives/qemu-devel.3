Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BA1C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJj-00016K-2m; Wed, 16 Sep 2026 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJT-00010y-F9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:36 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJR-0000IF-Uj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:35 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c72bd8a017so690596eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563873; x=1790168673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e5JPmZJzpt96w73KehN/JsFKf4BffDhuPjFz5scKOmk=;
 b=XBu+lT1qvZzAWSOeDFjSC+7rzQAKkhfl7OkjfilWdLexFIEMURx1+HB6nWTYh52xXf
 a0KApoGDWdagPES87ChgVQyaZ+iegEUTg/EISuRLkgI9k/g+mOLS/vM2k67UMMRYUXuY
 +Loia553i3Dtgbb80UcNx5nFhWeWw45y1wBpxYkgdd6KS4ByFFAN6OakLsLPgFx5hLjt
 OKrJDEfrUBCjgSzO9SqzQ7lF2CuB6d3PZP1hBCXh+cRezv4QOnSNPM9EUq6UUCoRQF6V
 WHyUYrSmKVHMSy6vPXmxhbx+qXpjCBo7Sdix8rnqwLFL7SYiVMYVb1KSwGsJcVFXy2Pr
 IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563873; x=1790168673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e5JPmZJzpt96w73KehN/JsFKf4BffDhuPjFz5scKOmk=;
 b=GWpnbinO6eHQeINAs1vqD5GbFHSLR/UGsxzVyXo5GifjSUIElbIpKFcC5Geu9StwSl
 vN2UYUWpHzynuwIjEXOwKnlAPTQ8Gg08UgnNm6IcNNCiJXs5GP8L+LAfpNTFPOTP06vk
 2DVWuIC/9ve35+g/Pg+JukqOuk9tmG0dvurFb346JClyjga4feP2oRZlLKi+5D1vvqSo
 nJed643sgXfSgjiaQR3OHcX2zyBqew8kyIxSCIk2Q3Y54NigKUOKLxSP0gMBPKrcOf4m
 m6kQEOqsVebPaP/V/T+eNqKnGfiZZJ8pDb+QWgZLYnyeLHyQY1QUwS/uoxY8PtS1DGTM
 xNmQ==
X-Gm-Message-State: AFuF++mL/DnZMmY3cIPIGMBY5nKgfZ9UJHGVQMZuguly8kyeuTdTQT6r
 L+GrhprhGYTsI4BowoAmJSSqpMD7/yuEh+iJlemXuRC6Hsm8AbzwYZNEwRN5B9Y0o3pb2ycvZUF
 MMeWLvRs=
X-Gm-Gg: AYBFou3x0SyM8RCtZh+p7G2jBPv+gHfXzFn4fwG7koSnuzMDcvWLtjdsmy95bcwKUh1
 vsvRyjyNENlD5k7Sq2nGe8OA1Q71TsBu6P+vwJA7MQj5l016WysQc9bRtirX9nUstcqOKOnX8J0
 qu+WbZ2qWsvJ5sdLbJ8+MMEVH7GGWiu1sFCBG0UN8sLxRfihf0cR6HGaYeeQUr4l942D1cxAMQ/
 PApP5GReQV+kKaSdoyx16FNZTtgUs0e7S3rnGe7vTnlXiPMh3mBwJGYohGsfqZjIUc4HiQ9xOYH
 TwehMSHrb99iB8ilTc0FmbwEVylHnt6fIJhtaVDKzY0rJfzZfNhaugmC4prN4tqD9OTXVBwdE4S
 W8l1Tpw5a859nWTZKgvcxyaF1/k0FT7c9EfirKE4USoaHg60xwEEgc97BfPA1L+eApRe+i0FzXo
 Vsxwq9MnYz4+qJP3nGD07+BaSOKbv6GMfhzqmC5BNHk02sjd9BFuOfFgEy3x8tsOAKstVAmh1Ef
 53kbBc=
X-Received: by 2002:a05:6820:4d09:b0:6c7:7668:a2a9 with SMTP id
 006d021491bc7-6c7d16ca0a0mr2825636eaf.26.1789563872803; 
 Wed, 16 Sep 2026 06:04:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/92] tcg: Generic expansion of tcg_gen_subi_*
Date: Wed, 16 Sep 2026 03:02:47 -1000
Message-ID: <20260916130409.3382710-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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
index 6be93865326..db5315a5cd5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index aac64105175..122a71d7c4a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index be0db3195c2..ba756d4aa69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -444,11 +449,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1571,11 +1571,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


