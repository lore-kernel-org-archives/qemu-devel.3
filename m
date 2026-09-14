Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB1C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6FnZ-000381-Vd; Mon, 14 Sep 2026 19:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnT-000367-C9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnR-0007Ei-NV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so411152a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427348; x=1790032148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IyVGjJQ1P54ox6RnEtsgUiCopR/0ZEh1fGFAxAbZhLs=;
 b=FkEnlurUNb5CpLV1JU6nsxVFg9ebYM1u4aSkqQL91swhPsqlFW22fo7o2Oc/hwq8S1
 UdfkVYXQ3NjQQITRZUcR5BraYn/GBWgnL7HslUttcK5he6s4IQHxwBhbCkeHh9zgk8eb
 oygp2MiQw2cvsiIRnhfyzvsie6fvGwk5hYlhPLeGOQgweMgn1RYX4dbyLglGUx328l9X
 jGiJBSJo1o5BH20a1zfjkymIiy2R/z6aRAE4D4FziWxZ9BN1M1E3jEUxBZwrF64Mb4tM
 fSGFphyrXNt0ARwT++iKvumA3cMj1SfM5EhW2nsBb1k2b/DP97ZPn9JLHhsznRdThkOG
 CcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427348; x=1790032148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IyVGjJQ1P54ox6RnEtsgUiCopR/0ZEh1fGFAxAbZhLs=;
 b=isW5VQxfSy3A8KeKSPOxZXw+vWosFNP3T50SzKewXLa3sFVfw2HWJYshmAD0H8DgUp
 a91ZH6ZIZ+ldltr2XPBOeexHKiMieQX/iNjFhZ7rHpsOuFAJxhvtKEcL5tmrdHjhPuK4
 qpdBO8IuxcSimaqepUpDbX8IN2tYDDDaQqaQAYN+0WbsT3w9B5vGxh9/9YGBWL3BTcQG
 rEITFBRBrrOQOWJkhqA7hvK975BnGhF5vTU3kvX8y5n+bcIONxWPy9bOShub+MuAJcJb
 tEElg2NcabxGmLXiykyphs8wV91PNvT2Hygk8PeyizkwuK/IQu/TAyhNbPdlA0LgYV27
 1ysQ==
X-Gm-Message-State: AFuF++kY6j5/3yyY+OTvw0ILw6UQXcz23BEHsG4ekHIVJRXxcBF83a/o
 WUwywTH0T9zrioyivR/8s8q5spPHFqT/vlmPLz4XUPvtrblBmX3StJQoEaAv9JY8cJpjAroKtK+
 zsuxz
X-Gm-Gg: AYBFou0fmQEirmyHJlkTbm2jzJlxFzVySLSW2Uv6hlYV7aLA1Zgy0GweseiSujEtw6a
 XF2yV7eMeKYrApBtpvOlT4spAwqbXRwsay6WAwn9VIIzUN5K0ePGElkJt4NoMFDA3D7z7X2J+sJ
 2iB3gBBUmAhCLFTbHDlN3oeKrKtOJ2yNLEF7ZD2hU+qW6gMKEf71/tDhmUZe2qtDxJ9RWzy13Gu
 VA4FhWKtJ/nUD9wJ+jcPfHuJB54W0zeYCkvmymYDZeZV4TDZaBqdD9HUuk8yZl3ChMY2J+A/Bg7
 vTIdaTvkcWNd6bQJvRuUamqJjhcCy55NSWMhg3JPHOHlRzR3e+gYerRSfcPvsqGi1fVWSoTFRo8
 F0aDwo52BfDhCZ0CUGo/qtV6gS9SGvNCgEG7iaXmQugEhv60V3xoTG9liuCkpSgLenFiiKJjD4G
 c7zVVlpmY0rCujdaPfGeiDNvQPoj2mm5up6NVF3QmI5jrZoNVoFvB649MORrQ1V6h3VagRAHviI
 YxEzDI=
X-Received: by 2002:a17:90b:4a92:b0:398:9beb:a2b9 with SMTP id
 98e67ed59e1d1-39dfe1ca2dbmr1911161a91.27.1789427347689; 
 Mon, 14 Sep 2026 16:09:07 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 4/6] target/mips/tcg: Use gen_mxu_logic for
 gen_mxu_S32MAX_S32MIN
Date: Mon, 14 Sep 2026 13:08:56 -1000
Message-ID: <20260914230901.1781309-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Split S32MAX, S32MIN to separate functions.
Fixes a bug in that "0" was passed in one of the zero reg cases,
aka NULL, instead of a proper zero constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 47 +++++++--------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 3f8acfcdb8f..4b2c264f031 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2045,45 +2045,14 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
  *    Update XRa with the minimum of signed 32-bit integers contained
  *    in XRb and XRc.
  */
-static void gen_mxu_S32MAX_S32MIN(DisasContext *ctx)
+static void gen_mxu_S32MAX(DisasContext *ctx)
 {
-    uint32_t pad, opc, XRc, XRb, XRa;
+    gen_mxu_logic(ctx, tcg_gen_smax_i32);
+}
 
-    pad = extract32(ctx->opcode, 21, 5);
-    opc = extract32(ctx->opcode, 18, 3);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* exactly one operand is zero register - find which one is not...*/
-        uint32_t XRx = XRb ? XRb : XRc;
-        /* ...and do max/min operation with one operand 0 */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        }
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        }
-    }
+static void gen_mxu_S32MIN(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_smin_i32);
 }
 
 /*
@@ -4328,8 +4297,10 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_S32MAX:
+        gen_mxu_S32MAX(ctx);
+        break;
     case OPC_MXU_S32MIN:
-        gen_mxu_S32MAX_S32MIN(ctx);
+        gen_mxu_S32MIN(ctx);
         break;
     case OPC_MXU_D16MAX:
     case OPC_MXU_D16MIN:
-- 
2.53.0


