Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E5CC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1f-0005Ai-PZ; Sat, 12 Sep 2026 06:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1K-0004n3-23
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:42 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1I-0007GQ-1e
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:41 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso283042a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209098; x=1789813898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LxP1sbGbG+sAIcCq6AyG06BmNH17TYdRQxrrNQ1oGFY=;
 b=m8bgIHkMk2vYz+6Q0FgMpxDw9G3UVGpTwXPyPqpn1M9aNAhShgVXcmnNvkrRdqics2
 +E9QLk+TAdoNt0GzbSlC9NKLe1KCeuWgI67CtxfO/9geWU4/7b/M8LBlYh/t78BBQ12N
 WifQPnVeIYHONEWBa9oYo9JAkHSHiUUaOtzwL5rX9LNOMd+ub40++u8kzLUg0pDdr+CS
 s/YRma/EKd3G+K7shLHNydPqa8b89EbKRbkP8OoazgdUJsFnN8t3fYpS9JwI0DaerMAE
 1cV83Sfu4LuJSjc2l7md8DFXBmqk/DrCMImD93vPclLG+VQLySC6rv3yIi6amv/sqCA2
 BRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209098; x=1789813898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LxP1sbGbG+sAIcCq6AyG06BmNH17TYdRQxrrNQ1oGFY=;
 b=pWdDBPbFFRgqVrGtfu0GgM/gBwptl414m9Xu+yl0hMc5KsHC1HdgyZHoGRgstHSAJc
 KKVCYBU8DY/V8srk1LH17sQWeJt+YUvZxZdzTNWX+degbyYJpB2D82CKsNJBDE2C6EoR
 ocO9aNcduEM7gkL08/ivhLD7ktbHkyjx2SdPlfA2D3WrfFGNN+h3cTnGFkR53Yj6YNKU
 p9a2OI8OlGs7EgxSMiYOnpsI84RZ7VP6bvJvfk9bzo6aFbGyks97GtZ5tFwqnE/tHTn3
 eNpQKaIDU+b6AQ7b2rWThW8HtESvOMVGguyGlMZMkVJUb/LjaLdE1wmqSNXPVSAmybFN
 2ffQ==
X-Gm-Message-State: AFuF++n15y2pMW6xB0xlPAGVkFZjJ2qFXimHoTfcxGqCoghAtBtRbPOj
 dSO8o/wjawzrY7QJ0YaqEey5d6SwkqUXfP1sSnLIvMRC0vGmw6Cd34WEgPh/BrH9UpsDKbFWdoJ
 J0FOPU7g=
X-Gm-Gg: AYBFou2YQlWkzMO2oL0DQ/hJEpK4Bume0qhC1v0ZnpLSOR8qLWYbyzVuNFC8csJWli/
 UKAxwVulZSPBuIMwU2YnusEw66DqRO0Rkx13zsYaPZhHuNDRzbU3hYZLd7UuPl49DR4cA4e+Z0B
 Q5RFYyWLmquzjpjCOtF95XDnBkfHJ3ksQBhu8KHIEYRW0Q0GPOD3MqIXKyW9SOgLu/gzqLy7DWR
 Ik06criYeUgKRgwSNtVym2axcXJn/XlgHYBU9VXt/xPHgnWurtXD5T/SFb99zkLavwT8fS9u+eU
 1hAn3oxqmSwY9FRUy1tRSPOYzoDdh0ehlYJkffC6Epww6Q/0MDmS7WC1m8WOaIR03AriL+EMvr/
 Zm1IOwbsHa/FKDh1Hmz0Y3xiW6v1PoQzCQB1Tb9OxmeF7B5O5dd7zOAzBd1BbaO1l0yG0mi4dQQ
 iRBs1zfrexVtY7y1dT5Yl/Xxleu5PSAbysNOnCg3ibImo9O5wjuT3+Wr2VA3dYdpKhxKDNypbfu
 dHr5O6J
X-Received: by 2002:a05:6a20:918b:b0:3d0:6c90:5a33 with SMTP id
 adf61e73a8af0-3db0e0a9eafmr4023271637.4.1789209098404; 
 Sat, 12 Sep 2026 03:31:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/82] tcg: Generic expansion of tcg_gen_neg_*
Date: Sat, 12 Sep 2026 00:30:14 -1000
Message-ID: <20260912103126.598030-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  3 ---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 145197b6fc0..e6607f48592 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -321,8 +320,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 71c81429cd9..52b0ebd7ecd 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -3,6 +3,7 @@
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RR(mov)
+DEF_RR(neg)
 DEF_RRI(addi)
 DEF_RRI(subi)
 DEF_RRR(add)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 78e711fffa1..354fbe07fa7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -380,6 +380,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
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
@@ -433,11 +438,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
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
@@ -1555,11 +1555,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
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


