Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B8E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDR-00068F-1v; Tue, 24 Dec 2024 15:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDI-0005zH-Q2
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:09 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDH-0002vV-90
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166022c5caso50556375ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070944; x=1735675744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWD89RQ9Sb2UhObXSAa3h+FC5JlParE8myCYhh3ZG/k=;
 b=Bq1TqnrfhldLnw+FKKsZKyIbN7U4gy5OzmmWatzQiW1CsPK8qltF1bx277PdTFEHEi
 o7mYtOPCi9ro3+MY88wHSb8W9ZoQIOow0k+if/YdNK9xgsBNNR8w2VlWlZY+4UuAmp8m
 MX/IzYv/NIpZlRjds9DxjZuLpiES5sbM58dFCYb5BNOElhpNyLytPZHVNRWyB+vYCtvX
 iDhDTrMYDnLIPNbdMkZLAvFKpfIhscGiiyQ2hNl5exul9QY/DgD3hTbSO98CGHss8ky2
 D7SbRd3FJeydqrLe1BD+Nvvo/BPRKXeFEZgEtUSTjhxcQwLbVI8aHV+NGENOd7HyXMzq
 Ho/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070944; x=1735675744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWD89RQ9Sb2UhObXSAa3h+FC5JlParE8myCYhh3ZG/k=;
 b=gt9M/mHhPwpDcv96kCS66V4XwMQiCNQnyzfksDOVlZdSe1CpgbcfxlSfZ0iNAHMW3S
 Kh1V/wD5wf4AUHHSE360LHJMUx/almn8bliPJ7Pf4j5/rAJEmlLXP9lqlhM3Qb20+wAe
 kZXRPeqUHQtaSWuDPE2tvmxdkPZPm3ANgw9N8qYBWjkXoZSSFdXXbMeXqGVTRUr4DQ91
 0gda4kpZquIqEf3nbuOMmEMO5dHcVhWF49ep6oCpOCCIlz4DpDLVfrbHlQ8mgZbc+4eO
 Ty/OOt5qTCfOKauTiU6GtbRZusT82FcCEUcyBtdFA0m2dG0G2umOXq++w2+zPI+4glAB
 ZMfA==
X-Gm-Message-State: AOJu0Yz/hyP/In8uSVzGcqqKaZ1VDBMv+1/pHrLLYeHyev91t9QKOf3+
 yTJGPwtLYKANdJjveGr9j+5Fvrn0542ns/d1GK+qcXwT4aM4pMCY8qbNjeQN0zqxP87sT3X8+E9
 zOUM=
X-Gm-Gg: ASbGnctNiaq1UHfD6jbbGe/riazny9FW7Iy6tkipkORPbE6q0aapLIF9z0JvoHCiNt7
 sPbaq6ggWI1hVGSgiCMl4AafL2ePDITx1SIeXiClbF6OfjsNtJehbYBRFO56u5UI8P3SEUzHmMO
 B607r0Jr7V74jukw53vmNuY3uIGhQeQ0OasXDvTDXegskeNSb3VPwjMeJOamY8Ts4J5agLcHNF9
 VEYuq5tj95hHK0MLi6FfVUwapS2tKImzGzvgMaIpQaR/00rPiJX57lVEnb6NFXgVjgKt2rslL3Y
 /yH26JbXEGfWyTmThy61QYmIAA==
X-Google-Smtp-Source: AGHT+IHeIDj6GjnsQKtX415MMii3AXMmTCqASTYs1PQrp4Yjb/dRVr2m6CH+haQeQWLhZsjeI3Gb1Q==
X-Received: by 2002:a05:6a21:1693:b0:1e0:d89e:f5cc with SMTP id
 adf61e73a8af0-1e5e04605a0mr28516895637.11.1735070944442; 
 Tue, 24 Dec 2024 12:09:04 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 44/72] tcg/optimize: Simplify sign bit test in fold_shift
Date: Tue, 24 Dec 2024 12:04:53 -0800
Message-ID: <20241224200521.310066-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Merge the two conditions, sign != 0 && !(z_mask & sign),
by testing ~z_mask & sign.   If sign == 0, the logical and
will produce false.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b70e9bdaf5..26790f7c27 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2530,7 +2530,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask, sign;
+    uint64_t s_mask, z_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2565,8 +2565,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * If the sign bit is known zero, then logical right shift
          * will not reduce the number of input sign repetitions.
          */
-        sign = -s_mask;
-        if (sign && !(z_mask & sign)) {
+        if (~z_mask & -s_mask) {
             return fold_masks_s(ctx, op, s_mask);
         }
         break;
-- 
2.43.0


