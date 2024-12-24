Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E2FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDl-0008Hu-Jy; Tue, 24 Dec 2024 15:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDK-00060F-Q0
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:11 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDH-0002vi-Me
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:09 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso53767515ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070946; x=1735675746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaOVBhCtGffzz8f2KF+gUKNW0uB05LssizAuZqhSk0o=;
 b=m62Ut5Zm/lKIFsfrNtU482mx2TIgy6DpzQLEUslYMRMwPZRi1J7BVNG+VTpQ2O3kbZ
 wF35q24jpWHBsq7hEPbnTlMExzMu51188r6Ew/BYxbhFG6r35BFgKbd4wvOFo8RtVUnH
 REANyzsxvEK5JoNsPUegl8jGl3veYEiw41wk1V5vr8AtqvdEqDnQxv7kdOFanMD6SMKm
 c9AreYPcUL7ZTcWTl2rln+b/wTpE0AKvE2ZTWIc+kKfcq7y5L3VHiThJfTXAe2iyX+Y/
 6PIzrhwQiqkeJdeiFuBA8a7IXOKBF8fwrq7WI3tWSdBeVB0UTJ8q9J83QDKGIX4nGt3+
 Rkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070946; x=1735675746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaOVBhCtGffzz8f2KF+gUKNW0uB05LssizAuZqhSk0o=;
 b=nuPlFw6u1SxaM8Zp6Ttu0JcuvXP0wRH67LfcUmgJs2uAFddXAaqp/dUWdaBsFxVnMP
 /G36radPjq1+lu6ablUiOzpxtFHQiRrCmTGrPpEqNcTcBfPxs8ddcP99AQBna6Q1GW58
 XvH8MaxP4Z7q0s1iputw+/MGTQ+bFb61p9QIEH+XJgYluNGdptLRk58A04xRBaBwPTrC
 UV822Rl80uieJSiifbMreiOqV57b5I3GU7j/c6Kfxl55iA54Ej7d6tWoKi+ezvugsSkG
 /wUWKfRJ/hMxCLukLCIU9w5122CFR7nQzMP6s4xruQmNmN6F1bN2RgHGEH88ReuAQwk2
 Ue/w==
X-Gm-Message-State: AOJu0Ywadbz2OD2Csqd3obEI8giLRDV+isnaDoLvidtkD+zaqt87zDpc
 wlgCgxhNwV7q23C4aEBw/6BLtkIl0sctpyPqSop58fJrTBHsNNMEQJY3qQp+mir7cAbw21yO9US
 YwZs=
X-Gm-Gg: ASbGncsqPgnYfUra8q9fQjO+CQ80xW0BwHbpRnpVjOPZGR3aflc9DCSnNy45DmP0Jci
 OyYpOSOY1rtmQMceBEmVF9HyRg5SYNZyiMPzUv5TeJ3EdBWPDPsIee5v1pIWFqdRLGzmbDE7Sxj
 Rcs2HvQ2KLkci9KMefacXrhNqQLWds0g0mKWwqtRThZ1I79bttVzqYnprvGBnvy5w1kC40Tpb84
 TNibZsT5ggFqqWmlmWdbIWbFnMuk+2cfrzck92N3Kvwh7UQhmWJuM59jJZ/vrIJdeOIa0mRpINe
 +YEEwFzCPj7B0rAQbT7gztUQ6g==
X-Google-Smtp-Source: AGHT+IEJbzMwr7gmQ6l0Sxq0x5Vonl10//ccB8vC5bz+vivVu9lMFC7NbIkcCKw0ENuAS0uUmhPtbg==
X-Received: by 2002:a05:6a20:a10b:b0:1d9:aa1:23e3 with SMTP id
 adf61e73a8af0-1e5e080c43fmr32208483637.32.1735070946442; 
 Tue, 24 Dec 2024 12:09:06 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 46/72] tcg/optimize: Use fold_masks_zs in fold_tcg_ld
Date: Tue, 24 Dec 2024 12:04:55 -0800
Message-ID: <20241224200521.310066-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cd052a2dbf..7141b18496 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2650,30 +2650,32 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
 
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask = -1, s_mask = 0;
+
     /* We can't do any folding with a load, but we can record bits. */
     switch (op->opc) {
     CASE_OP_32_64(ld8s):
-        ctx->s_mask = MAKE_64BIT_MASK(8, 56);
+        s_mask = INT8_MIN;
         break;
     CASE_OP_32_64(ld8u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 8);
+        z_mask = MAKE_64BIT_MASK(0, 8);
         break;
     CASE_OP_32_64(ld16s):
-        ctx->s_mask = MAKE_64BIT_MASK(16, 48);
+        s_mask = INT16_MIN;
         break;
     CASE_OP_32_64(ld16u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 16);
+        z_mask = MAKE_64BIT_MASK(0, 16);
         break;
     case INDEX_op_ld32s_i64:
-        ctx->s_mask = MAKE_64BIT_MASK(32, 32);
+        s_mask = INT32_MIN;
         break;
     case INDEX_op_ld32u_i64:
-        ctx->z_mask = MAKE_64BIT_MASK(0, 32);
+        z_mask = MAKE_64BIT_MASK(0, 32);
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
-- 
2.43.0


