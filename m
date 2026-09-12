Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E71FC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1n-0005JD-7G; Sat, 12 Sep 2026 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1N-0004nv-K9
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1L-0007HZ-Jm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:45 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so300450a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209102; x=1789813902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a5bBXZdHg8V8eGTTmdhn5oLUwYALwfHCCdaSOV7FuAs=;
 b=apDtAvyULl0vZtfUjLP+g2at7K8DZ9+AHXDgMdhtf95D9NdVAtPLldmg2C4K++rsXA
 1l1fvz9TWCUQSUkulDdiCs8GIcEgH6kKci8v4xUu+DWcMbK63hDIXUKmOgcrAzn1gjfZ
 7XANFy0gr9AG4GMULt0hVlyUTCrv+Hcrvmx1yxrs1bHzfyXrYvKeN6qD1eRfzQ02kwhC
 eHbqJbqoPrnmVxo3DwoCyHFiqhPVwEcfzha9E506xnYLyLldktdHCpiw7UWtAZYz1Ev6
 fSuNbXOr08VqAwWemD+3ZHijUWQoFBhDQhmR5ESHmVQ6OwuoHLCSRgLhT1oY60ffFy6q
 a3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209102; x=1789813902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a5bBXZdHg8V8eGTTmdhn5oLUwYALwfHCCdaSOV7FuAs=;
 b=UcOX+EIKjSlScVnqBbwam9LufEFcw5D8En0PeiCtSKs43FPN9aQ4WHY4WcFNseblAN
 6TlKfuvid5pWqnhPhkpDpZm7WlLMvXQwWxzqUHct/dQuHp3rztpQIoYoaNG5QONZfyDp
 nnT+4ObK1URjjt+qZAmJO0D/TRfQkEdiOjrvCEwOMUMzvXDHYfCRUvzuLUZtUj7OLQdJ
 kq2xg6DHwQWE5Vz5Eegkt4Y1vlOZB7Xev2rgTvk7UYZUzaMnGb/31NS1dAh68Ojoz3wh
 JrRlTy0USRvaURxsjZxHdZlw588LEyNT0Tln8+PkP4ENSwSagsLwBHc0s8Cdr0GeFxDh
 I/9Q==
X-Gm-Message-State: AFuF++lDBiSnECVBwM7x7ZrCrRHYQqBQ2iyhYsYpo2s+cYl9qHr5D/nj
 qu+EolWh9DfDpfZGxXGH6tvAWyLgJiUS5p19QVT5t6BV+7dKTINYKEh4rVmkudPlaWaFSnxcrAj
 dDzwyBqY=
X-Gm-Gg: AYBFou2V3g/xVSi8U2QTEEAexxBH12eGCk1JdR7n+/qoI5RlP8ddNgN0GXMOd8GYPu0
 bh1vBrsFbbC0yWwkuKokCUe0t5HEWMkgGbEFzxF8KVL2n6/YQLu8UAqslNVxzmZUi6QQ80EcZId
 pOxJxoDH519y4CUx45hcG1dOtfKOQdLisCPqeUPwaV96BhW7j9hHmhCmOkfRE+qb+gYV3QDg15E
 10SYZz9rUbyDiM80XbTS0zbIvWsvM+sv9DtFgtLZQMo8ZMWQ0QLiXZA9yGZv4edX7zHWLeLB/76
 2YxYqRMtkWbcXZcydH+DOIpTVNUUlUW/JJDtPSwkNCkROipoB39EgxelXtw76EzSRd/EGKhSf7W
 Mm1qNhM0vFsOUq/ELOtj+2vpntbOeRdC2IaamK8Lfk+HIduGbCR/GnF2e6Mx0WUyupbZB+UMBcS
 EATAuzp9WCdPyuS2Kzl0h59Qnavv9JOwdah0jVG3ecvsH3urmxBXMWtyxLJsN/sQjaCO1+bPskA
 iuxHAA=
X-Received: by 2002:a17:90b:2c86:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-39dbbe84fb6mr4298824a91.2.1789209102105; 
 Sat, 12 Sep 2026 03:31:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/82] tcg: Generic expansion of tcg_gen_xor_*
Date: Sat, 12 Sep 2026 00:30:18 -1000
Message-ID: <20260912103126.598030-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9d309fed4ed..04fc920acf0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index e42f57a7a8f..35301c12fef 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -11,3 +11,4 @@ DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(or)
 DEF_RRR(sub)
+DEF_RRR(xor)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6e00dda3ad0..6949a02736e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -418,6 +418,11 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /*
  * Templated operations.
  */
@@ -499,11 +504,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
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
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


