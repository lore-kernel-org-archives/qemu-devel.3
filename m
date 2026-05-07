Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2573DCD37AD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SD-00089W-Ln; Thu, 07 May 2026 19:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S0-0007Sh-UE
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:17 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rw-0002A8-1X
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:16 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso781553fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197688; x=1778802488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=bmayzxRP/klsWtO8J4Rf5j3Zjto3fKL42LiYarYtmf+K+yhHLsxQtyT8nXOdohtXIh
 n2qnwcKWXa3PRm/A3AAABpwPc2Hc3GfIQBTeQNoaiw7KGZfINlOWWkLtlStBT006EYHY
 8F1lBSZEAWVUBPb2xdcnarPqBe5sP1TxE7sxSgAkKj1XKPQ8dcucN2GNbQq9YsLRghXM
 AUjmaZJjRx7MzCCVb6DF+cSJ23+pY/m2gLpBEPz8fpdti6bGrJNu56m2qdU46Oxnl3ix
 wSS3HTU6KtsZwPFRs0d07IjqDKVuhUf9a4q1xuPljUtcBHgSNXcIVJPM2nSgy/O9jRzy
 cc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197688; x=1778802488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mgEG0/OuigOMwClChXrRoaFDD6e1qpvZV0h5+lZSYqk=;
 b=hsMgBPk2TymNE9YA//rdg0Ax2ZjogSUm347YSef4zhvGyq7kG+cAWGZ2+cx38xX1/q
 f4Cbx+fPjL/rHn9vhs4uBYUcKA3kjJQjnzrJCjXgpS9PZAGetbCfIT8GLZuk/BkOGLIH
 GRGIi5GRExQjtW9UzS2jYTTk3Zx+fZiT0YgiBJkQEAKdZVDGx4Is5uCwnbyc4dSYkuYW
 K38Eaym4pI4KrEeAdkTKBDRJB3oSEt5ppM2g5Cs5gNYfpgsYpDAC8OI8+DN3IX/DF3qA
 JiCT+fFIdDDdBlZIdPstxhG9V9+HG1CPrNOIM0GpAtwxJuURDAhJKgxE82WKbzMV+zPT
 aCMw==
X-Gm-Message-State: AOJu0YxtQz3SfYvjXgr3O8XDcqZmAZbglBi5Snv5v42OCO26yzgJCvJH
 Rrla9HacZwP5wE+TMJUhI/x/HJ8Tz42f6AHKphrzBRNjyHRpqRUWvfXRuWVg60E1Xcl4/WGsUxG
 G75br
X-Gm-Gg: Acq92OEqJ/+uWIns4QkK2nP5cL+eoPoLby24Qoz46LHYcDwqyNvxGpHEPtjwCI2PTRT
 G/lUrtG0ANVt9cmqUPKVwlOVFc/gwRsIo9gzkIuBFH5Zo1A5yIZv3UoXpDbDlPoGgtGToh2LjoL
 CKnXp4wkxJPyYFXIHq/G1u6S0HFCIPwjwKznDAnaCAEAmOhZfWfu4Ea6a+v0zxIw1bJr7MeKawO
 OGGOOmAgwP0XkO/pJB1Q6KLVtyFkZc75QgDsfhpE8Xcy+F11631NaPm86goUGx8QpBkfsMgiS36
 QHoEosC0shG9znPVIr2/83KtbDFwJZTWIeJBnoihEGyrz3YoMLTSjy0O701qMhbJtj0vbdcAD43
 a3pPE9+xUMSU/8Dz3JbV9WOjuA1JAoCBfpANQN+pOtOyzc4YE9Yfkadp806takUCYhNRJ2mUZ7m
 V/3XF4f5X4DCWn005QX0p2DhSov/RcUIJJOI95BI8CEZKZiwSYZ2FLx+9L7E0mPzzE/po=
X-Received: by 2002:a05:6870:7d01:b0:42c:2421:5777 with SMTP id
 586e51a60fabf-434f613bb6amr6897234fac.13.1778197688577; 
 Thu, 07 May 2026 16:48:08 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 54/60] target/arm: Enable FEAT_FP8DOT2,
 FEAT_SSVE_FP8DOT2 for -cpu max
Date: Thu,  7 May 2026 18:44:07 -0500
Message-ID: <20260507234413.643512-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
 target/arm/tcg/cpu64.c        | 2 ++
 docs/system/arm/emulation.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6dec7e045d..a43b6367a4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1377,6 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
     t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
@@ -1397,6 +1398,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64FPFR0);
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
     t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index bee4e36dc6..875716d18f 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -75,6 +75,7 @@ the following architecture extensions:
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FP8 (FP8 convert instructions)
+- FEAT_FP8DOT2 (FP8 2-way dot product to half-precision instructions)
 - FEAT_FP8DOT4 (FP8 4-way dot product to single-precision instructions)
 - FEAT_FP8FMA (FP8 multiply-accumulate to half-precision and single-precision instructions)
 - FEAT_FPAC (Faulting on AUT* instructions)
@@ -161,6 +162,7 @@ the following architecture extensions:
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
+- FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
 - FEAT_SVE (Scalable Vector Extension)
-- 
2.43.0


