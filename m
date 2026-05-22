Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A7BCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY04-0003JR-9t; Fri, 22 May 2026 18:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxv-0007lM-8f
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxq-0008Ie-NG
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36622412e97so5751890a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487407; x=1780092207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNNMgucSf5F2JSSLk6zTH4DWxK3ilmSb/cxYYREeEYg=;
 b=ZqqBMAf+cL1NYELF3jmf5MFF75ZHMuVU8li6se+rI+3yEn+ChnhyFgnPciUzK9C33S
 xSZBqVSTGSf47AS4jy20G99FR/uEHcOis8q4vXT6S3hbMvNY8cRayVs/4usZC6yye+g8
 l4ugixKnqjcnN71yYAj6917EpElWugo6qwuTz5MASAisc2kSg/2IH0reA9g44+xnHcgf
 bXvp6wrU2OESnBJxn7C4rgAvWKw7q1y7Wd2hHm2p6vZCTMAsZ5K3yZJNi1FFtJRADiEC
 VBUnhKAB7Svq3whq+PFP5TOOVrQrt6ofFR00RJDaQ/5gU/YPZoZyrirKpJjkI7KEF4iX
 JkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487407; x=1780092207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iNNMgucSf5F2JSSLk6zTH4DWxK3ilmSb/cxYYREeEYg=;
 b=aSEKyogV4WB3tT0NRNTxJ4uIwDXa0TXJONaCeGia8/u5l5sxSYshHHDxwUHUs4YINi
 KU6T4F+RgZd1G52b7osJ/7+OpHeeANxoRpWU4ze7NRrof8aoJqiQg+Clm0gU5MPPNfBU
 Pt5UiXciW0sWzG4CTfrM1Qns9ssHBjKJebrKF/21s3Wcs4CYS7fuIiUyp7Gk9etNnB30
 e/3JR9bFc5eXVvHidVOAH9+CMxkVga6khwzZUHZoQ37dqfS1ev547w9AqWmorB3/VnKr
 vMEmyOzMmSjwUen2Cf6gv2izA76t5ZNBTjRRp81rXr5B3RBVxttEEl92wxra1uaYi1Bc
 4+Cg==
X-Gm-Message-State: AOJu0Yw4cZr5ARXlAn/E1vpx4yEmSIODBw9IoeSUa8X0+ehEfCMa+5jJ
 BpXEG/031hjYF3aB57G98LIypR1e4MGFsh4HYSZrsXiHbDwmK66FP9CZZzGiEmvujdWTNq+lKa4
 s0CqL
X-Gm-Gg: Acq92OEmN6MxDT6vpGmO3sjE7F4HbjCkxA29YJOzqf9Tb1mstDkfwaALkbJeZAIwCf/
 WajEXElHwUgiAKe8ljEtQqjRjXMyEheAPELS+soFUdPtUCVKbuzgvsORSMcLRpuBxAOZ1UDT5j0
 mbavyicBcDCr0bkyJnE+gGtlKSXuvnQA4vtA56DuqTsqhD0a4rY0bWLIVv+Ylk9glHotB6ZfhTb
 Prd0k0Y4wahAOxDKTH7o4JxC9bqCRkTGabGnTrU+c/8yzIRnTHyBkr1ISOy5orBageR1tfDtZSX
 2WJ9M202SOYSCctY7K07Ll22hylCsHus0PFELuFQxlcaZAM8huTeAPIEsz/QqoSLymi4fs3XbVS
 2l4M2OLwxqPeWDGV2xPGq0xPtlPUNW20nB1tsRUBjyaYBscPAAOTRGTr2AJeT4wMDhokreNP4ra
 XRPAL4AIpniN5FfDIztUZ87slCNWjj9setgUUBO9g=
X-Received: by 2002:a17:90b:568d:b0:366:159a:c228 with SMTP id
 98e67ed59e1d1-36a67422347mr5270084a91.6.1779487406802; 
 Fri, 22 May 2026 15:03:26 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 19/64] target/arm: Add isar_feature_aa64_f8cvt
Date: Fri, 22 May 2026 15:02:21 -0700
Message-ID: <20260522220306.235200-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1bb77d78da..1fde3e9231 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1569,6 +1569,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


