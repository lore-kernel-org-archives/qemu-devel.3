Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5ADC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QB-0006pK-J2; Mon, 05 May 2025 16:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q8-0006nm-Co
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0000QH-Rl
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso4075169b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476887; x=1747081687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B2Cl5cxSEvk06/qY2HwzkAkBtGDWvMDnYfpljfPamAI=;
 b=HTN2cXVWyx+9eytZmPYBifVc8Y73Mpm7WIcYPL7ufHLA7F5Y1vjHSYNkukRTWiFb4e
 IP8c9KEqcKc98LY3S4BYlHr8T0jua5rYUdYGnkYOXKjyf2s0fHSVp88bV4pbDNUxKXgt
 cfxrSQErCPl3s3Rr221EO/MaFnLsJur41xQTJnvEQCTR4psg0DFnMmIvvSbXNMWxleR/
 ZAPK6XFxktukBSa6M4wvJpsFPuSrysX8FcigFVoVP2IhfsWONWvw7d/I+7CUGTFCCbhD
 tm/s6WHEvqYXsfzMs8EvHOwwWbqln96GjAczCNc8A3keorzLaAOs61om1xY7+wN3GWdq
 HS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476887; x=1747081687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2Cl5cxSEvk06/qY2HwzkAkBtGDWvMDnYfpljfPamAI=;
 b=rtXre8LR/hy9UuwQX4K96jO52nsLlFPfbx1oXA1iKs3ey/IUe6oGpVEQ8JJ8goLNq9
 pUqlJay0bz0zNmCIf6aISOjz33VPgorW7pdfwCkVYoGHRRmZ+Y/1jh5q8KPtMjEzlkA/
 tIxgmtETHoN/hF5rM+sp70A4LLhpeF54SO6dtpy+1igVxZB3/SpLf6j5DEb79RVytP1l
 w1f7txYElcVEYkgsx+6Yr/+nhm7cro1eeRlxxruuVT0n0YqGS8gtEMYfZGx8Yjf6P/3s
 XrNVt1GN1V/HkhL6YBrjYCy75O0mrnzGXTS8RqdC5PNYm7Y21tVj8yQeclbs5twDBJ+p
 wmXg==
X-Gm-Message-State: AOJu0YywDkQePkUAkhp5eEWjwqwyvjXIqAczZFArCZuvRAHmWOc3Bpvj
 xVBRqIm4r/k8TKxjPgJCM0BH9mTcHIKt0F6Q+SeBEcAys7o9JdA/h4j5Aa9PjYgnbkoz5qZZlGS
 b
X-Gm-Gg: ASbGnctk56PLS/9yA/FE3Cvo3CXZbzz4ewfCBkHuDflkjzcFgPCmYs8WRsrkqdQQqLd
 aP3bnwWbGe44Utupb2zmzGhU//onYbJc3nsoobMiwu67oH/WXOTXupiTXgdNEQlvXLkot7tdjLP
 ZB0dYIw67CnQ2O2mXWtGwVpraYN9Q2pF6QNsEolqsikJQZnES8GckodZqv0uTeAzWPTsZePgP37
 wQ9DLcIzJCMzYW6h9n1CGJCkHOk927UNfyq09G8IWgeVQBifg26O5hRrheR8wIJ2m/U1MAnBpnV
 y256oNYG8e3jC3HRJtst6I/Qn98Owv/X0Ca+G3bvl1L9zYJOUsRtSPQyVTiaisMDlU7ehvik1+g
 =
X-Google-Smtp-Source: AGHT+IGPLdUst2Yp3+4rDabZgESdkzB0zyl5CHy5xkvQ1BWq58W3/pqzI14psi3uunSsGBLIWKmnYg==
X-Received: by 2002:a05:6a00:369b:b0:740:3830:4119 with SMTP id
 d2e1a72fcca58-7406f177d74mr12345418b3a.18.1746476887402; 
 Mon, 05 May 2025 13:28:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/20] tcg/optimize: Build and use o_bits in fold_extu
Date: Mon,  5 May 2025 13:27:48 -0700
Message-ID: <20250505202751.3510517-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
 tcg/optimize.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d7f017accf..1d722bebc2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2047,25 +2047,31 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, o_mask;
+    TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
+
     switch (op->opc) {
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
         z_mask = (uint32_t)z_mask;
+        o_mask = (uint32_t)o_mask;
         break;
     case INDEX_op_extrh_i64_i32:
         z_mask >>= 32;
+        o_mask >>= 32;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


