Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E44FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kH-0003HU-5X; Thu, 17 Sep 2026 00:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k6-0003Cn-T1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006oA-Ib
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ec6188so2603075ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619332; x=1790224132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O+YCLO2jpwn3gMUqHmlY3kGGdcEL1JHvmbKOcEmNGsc=;
 b=wzFP882AqiPVfJmtKJDOZoQscblB4OvxuS6XIPQG5SNyz1aj6tJMkpLI4UXRZQmPFN
 C+zrsYHzUydGb/wiMhefVhMFZT2X+SZlEZ+AegEhgCwoOoe0EZwzRk860tnuXrEMmWCE
 LbRe+KlD+wk7oHJ3dNmW2yfdnI8sVA27G8rpYcYCjMbOTpnuHW5D8Oa/Mdi5CwpoQmUE
 OnAJHKiRoj2G2AULPPMz4kjj+XrhCnmY202NWzR5PosrlNNR8vdoxyXoBXaml9JQj5mr
 218OL3TaeIMkB0V9mWMDfT0SWTeYJnhcMeEqfBWZI0L8bBU+jN5FPtq84vzSRBJ0M/dI
 qZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619332; x=1790224132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O+YCLO2jpwn3gMUqHmlY3kGGdcEL1JHvmbKOcEmNGsc=;
 b=JeT40cHlKHo2iaQtIclsEi0hDob78CikMPplpisxGA9KilXsjqQf0HnZGTG6XyAUbp
 mBPmziz78VK+N7Jpk3vFIP4+v650XmUdWf49opro0VS8MG9owa7cX6ZqJwlLlANm/HO8
 tVwQj9NynHRA4yhptRKR9C9lcDp+HGeleAXR8CK/U9FT66P/YUIy6XOOZS4BpaO4bJD2
 DkMMHJ54kcIVcgp1RkX0UiPKx6O/+zJKc/NP/TYLUejxdQ9heEY2rYJMyIvOMl3xU2dP
 XtVdoMHslkwumm2/0yBUACI/pGlxEzta0dOKi8yi1w4KDDUg/8orjNcp2mrGMa371r/s
 mhaw==
X-Gm-Message-State: AFuF++m+wztyxnmfRY+6cg4TTFFqVOrwhzJAefpWupMAcuWPkE/EtB3u
 oSbS2Oq+Rh8lUbpLBr4rI2fFw8SY86k+Rpp2Q3KRR3DWeMyPriac9qBwdVxLWC/ifyyYx8VLlnt
 6X7w7+7k=
X-Gm-Gg: AYBFou1gDzg66c3gsAt7SLceISs/smIqQHFlNAkCLFShCZGrMZf1jE44fJ0lOZ75mx0
 qK7/QeQwswv18oCCFrsYlhSGcg4c+sXU6W09BXCVN/fFLvPryzpQuzUxhofIHvqXnVO8DZxzEp2
 j3ZRSDUNZL9tWNc0lK5kb06oQMVKluW1iGf3lKkM0PA9CE8l+rbNKzv7Fx2vONGpsYjggswnK0+
 xj4wq/3lf61os5bWkborwdguwawisXSwaFvxVmLxru9rZeXmktmnjauk7+jiPMV2pPkMIQG/QnM
 uB4TJ4YXXjv07NzCtlnq40cyPs3JveBp+UUp8rWWGtoFExM6JmmAsz/Duu1dy+Ur3Rtxt+u2cn4
 LK93Oiz8DaTXagQ0siytjrKQEYxHzWH3kzeElQDrQfkNX0Fu00udCMXiOG1Hv3IDb2h5f+vpoOV
 T7ciYMScfnbaQ71e49Jrvw/qF4DtNGJuJAf7Qq/oojcLJtXuS65U2rKdJVSFW7Kbc3QNiwUVYtu
 mKvfyrf/H+m761mMg==
X-Received: by 2002:a17:90b:46:b0:39e:35a0:9c0f with SMTP id
 98e67ed59e1d1-39e35a0a211mr5492449a91.14.1789619332107; 
 Wed, 16 Sep 2026 21:28:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 024/101] tcg: Generic expansion of tcg_gen_mul_*
Date: Wed, 16 Sep 2026 18:27:06 -1000
Message-ID: <20260917042823.542588-25-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eff7bf11d6f..f45e5961a22 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 247d35bdc14..b318ddd74e2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c7e95dba241..2d0e2c4b34a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -635,11 +640,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


