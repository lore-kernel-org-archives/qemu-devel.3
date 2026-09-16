Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D294C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJs-0001Eg-NS; Wed, 16 Sep 2026 09:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJa-000120-Gb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:42 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJZ-0000JN-02
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:42 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae736c64so718198eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563879; x=1790168679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CRD0I52WWAnGnNUF8/F6bG30rfo2CUDMcZ7gqQmB5vg=;
 b=Ula3521WS8/o+zXq7zi0kr6A/ksZY4w8idC+FmpcQXE30qK5D9EnpWzn8DBH4irv1r
 uveF2MMkmx1qbv3C0e6VvuRnQBwXmhOkz8BI17z6mjj5WTMMMchV63kmKexAsVOTrXnS
 QPxH8V9iYxuz2vhnVjo5CnIEo7TOePRXfHmouRB5pQfeYmUqAwiFbMUHcnC3rPBo33xe
 g508H4eUYxgOFsUtBQEBq5hmBvFAgkrHkCrmk+BpT31tbvnaECBjDqb1Li/d2fTg/l3s
 lFy2oVDbrEenM1sxCW7Ws7ToFmbahZw1vVFCMQI+GiELVPLxY7p3D59xKDwnzl8bfydo
 UcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563879; x=1790168679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CRD0I52WWAnGnNUF8/F6bG30rfo2CUDMcZ7gqQmB5vg=;
 b=v9fWJP826LOaqx5yAQNRyXKOqEdHulQOJI3YamSjrQ+6raLrAiHElj/8psVhmIFsoN
 bsssCrBXudGWswPdBBebYgX2mHLlHbVIqrpVDOE2eAQuE1fiUZPcDTaTVelPDdHAptiU
 PFODXk+o8z03InKxGvE2Xr2ZjcLf6RPqdR4HHBO5txSUe8c/y7ssaorG1vpK8aaSvN7i
 YdCey/fxVtRID4hYU+oyDnO8PgvJiPrwmrgV78g1oeClfLG7WVq/aaOInhS8w3N1nvEA
 p/2q6mxuSOSiAnyHeFOGuo/Bt3uWQAQfdeEzPcIoy7HP/EeRiGx9SsllpauXDrEEsSEh
 J1JA==
X-Gm-Message-State: AFuF++niXSegPGHLikdmOFdoqyBT8M8b1EN3RqYG4GylCBZVDjle2/Ni
 yecejObOfjGZKS46Bvzl0Xlyc9dX6VKUeQ5R+GLnIl+qkI3YWOiQyAcUcmql5klK5kPkxxnTTil
 FoZ4WU+o=
X-Gm-Gg: AYBFou1JlgG7wEH9PGXXV5ZlI/L6EFYEofPBJuzqKtmQlNWGSXxQBaoXHQmPoLcqCX0
 ug7fGqxvFEp/atjaxepNyuXurIuI+wgRvmYTBtOjJokBQ92pyyXw7ujTaW64Uhu44yjYJTaNwrF
 WLPY2W05NbizcaWdbXcZwOTYJgy7sBERQrFMZ49pPHlpsNrxpFtEdk5f84f9IQvnRMBil1JLHZW
 010gK/FzTlQQwLoPdp6pXGzJxdLE9dvBaltQXCgITsTkjUIb8ZO5O9YvcsZSeMNOXNtD5ydAWxR
 7s1iFGEexnA27bcMIHcBINeOxVcqIdRLYZCFhiKhp10wV3qw97HV2SE3YbKPnVK2/ZFUSNuhEMh
 lVySY7QvDUaCTk5JF1ACac2v6YPFaifV09NfFoeDnuLutYQJN20kcUiY5FddmR/yP2B+90DEuhW
 3UlHFxLDjP2aqwzUKjpNDMpJ6SvfXx4nXCbOsv++jd98NMH1P9tINJ4U/2ndrm20vL2Yz8diT9Q
 QUkhQI=
X-Received: by 2002:a05:6820:308f:b0:6b7:8415:d795 with SMTP id
 006d021491bc7-6c7d3ceb66cmr2541387eaf.64.1789563879247; 
 Wed, 16 Sep 2026 06:04:39 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/92] tcg: Generic expansion of tcg_gen_xor_*
Date: Wed, 16 Sep 2026 03:02:52 -1000
Message-ID: <20260916130409.3382710-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0d.google.com
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
index 4d61eaba122..6365f67494e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 513505e35fa..47d3e6f6990 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,3 +11,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0b7fe14c7a9..2b796f3cc62 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -462,6 +462,11 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -506,11 +511,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


