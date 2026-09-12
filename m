Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFAFC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1m-0005Hm-6b; Sat, 12 Sep 2026 06:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1L-0004nU-Bz
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:43 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1J-0007Gx-KD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:43 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so249159a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209100; x=1789813900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Miy706JDg0TNIqtiwZjFaqbPKM0e5bWad0RRf1CV95U=;
 b=Pqg78AqU8Dte9cR5AAmC7BlZlX5Gpv5E9BvU+TlmLIfLNybCcraC3d1NVowqVmS0s3
 sWbKtJwfmIDqSqoeKHqddyGIeCo0DZCCCHEb9gT8lyN0F9Bq14RW92GnePSvAQcjnWzb
 CyuOtXjDW6jv8EefuZqjTi3/IRK1xUyIVbD2iGNIRZYOGKOPnjQzVi2M81UK20rmcILF
 3zsw9WmYCETa/W5y56Wl0JwBqn2UfYz+c+grOOd8gVxFuQT5fwTP6I3S5V8+vSIRZFh8
 Y1ZMn3ccLG+7kePi22Z7YG+jJ4kRJWIwX7r/wS9df3tNpeKi1S7+q7CndBc/UoaMhua1
 Psew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209100; x=1789813900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Miy706JDg0TNIqtiwZjFaqbPKM0e5bWad0RRf1CV95U=;
 b=aIsj8ayCRtRXdPeX5OzQO83BI32SFCFPANKbrEP1002kvN9hAwDIzvKC++nD8ORu2T
 FR92RqCrHo+fmBhYSLnIcDr0dvRIBCFwKK1Vh/U7PoguF7+JhX5xlfXMLWh7GSWnnxeZ
 uEIh+aPnq+kOrcnzVg+06wEflEy4/bWpGBo1//zyF1Sm1Kw3sgJcFK163akZtHQIAToI
 2wJCZL9qxVndYJ1Hzr7xIsdauJvfbyMk1Q0KTAvx0fOT6c5lIankdFXWGYfkZyw3TzuT
 92dQPX9oSjzCGjpFTMRGehk2mZ7vgOWQBRiKNT30JEWETIPzv9FD1Wv92nc6my4ExtrY
 PeRA==
X-Gm-Message-State: AFuF++nKHQ7EZ/xnCg/aK0kVWVS7CM6EBUKQekgtfkrAHlqEWuNYLMyr
 BRUGC2ARF6UE2or4xWLokjookiTCYl2k1y6R5cZanLT7syoQJzaRw7vVH5lrXVV58PKcrdLlcvD
 5gCDPIoQ=
X-Gm-Gg: AYBFou2h+yek6R1QVUb3RFDjHukRmrorlG8KdrPmCrQQ270fILnoAo93db/yicjgAzi
 bJzHi3BQNP4/3M0w9JAcJID0VPmzNZZv0GeIMbVVoCipAZHLV2PDys4USXrxDhSsk4mdQpip4ZD
 LdfeIqxxTlR7IYV7wPQhIKE1rdUvSoriSrNKxB8Vg2LrDDBKf5ml0YClzFFFynBTzAH2IoSP/zO
 hqhtKPCEFstN/AU/3eBf9zHofIAldg90IaMHasU3h0vB4EdSdi3/mfJesL6+4WO3oXqbDBTtjyT
 HTeKjAEnPBg+WsWvoZ2e9Z6/bgo8Sj2kpp/kV+euHNJrCVdZp7jnlHAUXi0fYkMuaG9iSvw4GsJ
 Z0RqE1EXsY6Ot6qKKYfSLjWgc9T913xz3+JTfiVgdx3+MJjCZmNVeoVY8iSduDn1F5Hz8/uSSIc
 WgdXXzhJIZJjU1R5jElh/xIMySuqrqdAUnrl+OWrDY0mJ3sUD1NKxUqKyHEvt/1l0ACvoE+N8LV
 INguE8=
X-Received: by 2002:a17:90b:58e4:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39dbc70b960mr4345107a91.24.1789209100148; 
 Sat, 12 Sep 2026 03:31:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/82] tcg: Generic expansion of tcg_gen_and_*
Date: Sat, 12 Sep 2026 00:30:16 -1000
Message-ID: <20260912103126.598030-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 35288a19a79..c957cc95b1e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index a739c198a56..ce21bf5b965 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -8,4 +8,5 @@ DEF_RR(neg)
 DEF_RRI(addi)
 DEF_RRI(subi)
 DEF_RRR(add)
+DEF_RRR(and)
 DEF_RRR(sub)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5e971d8bf54..5d0ffe4d70d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -367,6 +367,11 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -447,11 +452,6 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


