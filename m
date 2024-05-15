Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B4FC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7G69-0005EE-KJ; Wed, 15 May 2024 10:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G64-0005DU-Oi
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:13 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7G5x-000799-Ve
 for qemu-devel@nongnu.org; Wed, 15 May 2024 10:59:12 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e4939c5323so84872751fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785143; x=1716389943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UEAzmz2yf/FXZrHjq+7bspL7xDnH65PbwwSYmcMRBs=;
 b=XgfbktcLWc1hDT51tXfzByvy9mfXUHz0MNUc3oP/4M83EDwmGJhRDPHyB7lDnVYPtU
 RmCCRvpG1h0jKUsVb/VL5eSP7v0K6Ma80gcyRn9vGSdJbErEXOqe+cLs4Cjg1m2KFf5C
 Pw7J/NU467lMh8pEfU8I6QXJCHrsqaXgtL7rs9XDWGlDfRxVZO8rjKpacK675SL6tPnh
 b2FXIaYeO0TpBYc4VVCUTv8Ya2t6m4yqXu55sNVTw7yd08TqzXluPRwmYqJjy8kG5W47
 Aw8qkzC3Ju850fhB5Q6p/lJZxadilbUPnBMTvRxZS/p2TETwQrE13tFGx1sCbO/zEE5f
 jSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785143; x=1716389943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UEAzmz2yf/FXZrHjq+7bspL7xDnH65PbwwSYmcMRBs=;
 b=aU1/4uWKP26IsgoPto6wqMsCzIIZBCrLMui82cDOAYmFlXbDYGarJzEZdigtbErjne
 VL17ZNmvieicDMDDdFJJo7yJEHxSkP0aWlBkLxXza14mf4nynVMdFpdF4309GEHilz53
 LdIxSf3t53v9WITQB/BtgvIRjM1/DA9N0s7aVx4S8heOHuu9UmVNOy0zestNeOMtp4ZJ
 nqF3sTkNo2ITjdjCuoOorUNTLK7LeIw2hSFWx2aSg31sJ0HZsM0OLJdL8/Oicd0qghy9
 eq8psUT3ijcP4vAIEcnP5407WnQAGEX/cxeu6seGvcjNHMozr0CXslkAcST/EIpYczbZ
 CXyA==
X-Gm-Message-State: AOJu0Ywn3YIoqUcKeenPwBzsG4QHHGtu0kjt73oZn40Ub/EzxWE5WKc4
 amzU55kSgq1Wd9WKk4gKn86opWQkoEyXsi6DjhYof02b2gtoeo8p9bP4kX5inxrA5wDbZsBe+wK
 b9go=
X-Google-Smtp-Source: AGHT+IHBAqmShW7+x0erZY7qrVPYmX9/Sj/x3k0Czp3fcp+nLRsdz0z8vY6o+cHpBJxSWC5aaRGvYw==
X-Received: by 2002:a05:6512:3294:b0:51b:6366:3459 with SMTP id
 2adb3069b0e04-5221027800cmr13784999e87.67.1715785143330; 
 Wed, 15 May 2024 07:59:03 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm272134645e9.34.2024.05.15.07.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 07:59:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 3/5] tcg/aarch64: Support TCG_TARGET_HAS_tst_vec
Date: Wed, 15 May 2024 16:58:58 +0200
Message-Id: <20240515145900.252870-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515145900.252870-1-richard.henderson@linaro.org>
References: <20240515145900.252870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.c.inc | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 138bafb9da..8bd9e6a5eb 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -167,7 +167,7 @@ typedef enum {
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
+#define TCG_TARGET_HAS_tst_vec          1
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 56fc9cb9e0..ffa8a3e519 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2737,7 +2737,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             TCGCond cond = args[3];
             AArch64Insn insn;
 
-            if (cond == TCG_COND_NE) {
+            switch (cond) {
+            case TCG_COND_NE:
                 if (const_args[2]) {
                     if (is_scalar) {
                         tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a1);
@@ -2752,7 +2753,27 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     }
                     tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
                 }
-            } else {
+                break;
+
+            case TCG_COND_TSTNE:
+            case TCG_COND_TSTEQ:
+                if (const_args[2]) {
+                    /* (x & 0) == 0 */
+                    tcg_out_dupi_vec(s, type, MO_8, a0,
+                                     -(cond == TCG_COND_TSTEQ));
+                    break;
+                }
+                if (is_scalar) {
+                    tcg_out_insn(s, 3611, CMTST, vece, a0, a1, a2);
+                } else {
+                    tcg_out_insn(s, 3616, CMTST, is_q, vece, a0, a1, a2);
+                }
+                if (cond == TCG_COND_TSTEQ) {
+                    tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a0);
+                }
+                break;
+
+            default:
                 if (const_args[2]) {
                     if (is_scalar) {
                         insn = cmp0_scalar_insn[cond];
@@ -2791,6 +2812,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                     }
                     tcg_out_insn_3616(s, insn, is_q, vece, a0, a1, a2);
                 }
+                break;
             }
         }
         break;
-- 
2.34.1


