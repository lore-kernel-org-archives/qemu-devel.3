Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC83EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADos-00088h-13; Fri, 25 Sep 2026 17:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoA-0007lV-QF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:26 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo8-0007lp-4M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:18 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-86212a185dcso1075190b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373012; x=1790977812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qf9HpDmhr2X/BPeZxdfFZ3PfLAE7JfKlZsgAf57xaSM=;
 b=snfWqfk7Xu5HaipT/pz0RSxTc+uTKxKdICXFLYY4+ZU4leG+QNUZE63r3kOLNEuTOL
 pHcu76vM5JmtswXOvAjgOD2wD+ec6LzcWxXtv+QYucUNX9CVWMD/xGTjBC2ZRyzRXBfj
 2MQGJjQzltcl6+nsrVBWlWHoFFp7iN8noVgH/xUtLYWmdP1kMTCmSUd5fulZfeeznvTg
 tHCaCRD1njYLWQyCRSmMTiXbg4RUumGTy0dccL/xmjXorgKzRRBOyNAllZaK7wliscut
 UQmZm/12dKjjeIke2JQYfLWJWTKiiWj5u9fgwKYxgRNpMTqClpChY3ECsxtkQFmcqM/v
 MNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373012; x=1790977812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qf9HpDmhr2X/BPeZxdfFZ3PfLAE7JfKlZsgAf57xaSM=;
 b=m+vJe+0auUIqUG0rt0l360tBXOv8ZGj0iusZWdueyMEsbPHMkPfFhntKxRw3LlTMe4
 oIV3IdIoBEn0S1rwpqK3TZHfVjM0/prQbzSgHs92elm9COKVfeOc5eP/xNsaenNt7cDI
 v7FDmIwqo2t4Pu1GBOKd2JcSP//+flQ6adKQSJt0YmyAUOVfJi6M16oTYBtDvR9ksWvz
 UGygK6IBg7Ezg4NYKY18io2SmNx7yX8TNoKuSe84MKt/7W3H/AH1NJL2GsFI7ioZjA2y
 7M2GqOUklkOIiCQkt9d5byaYK+FOpkD3ZplN8ZSFqHFxlWqnuwHejCZTZExbcmQ7kDuL
 XBaA==
X-Gm-Message-State: AFuF++mLPRlRtMA3nuq44nFqLS9+HP2cvPDWdpvKt3i23U5I2RbecDhW
 IhxOOnig5MkDG/toA+qIF7mtCs2n8e6Gl1aDNzswkWLV/5h0/SwGaRyiqV1etG/jX5JXlg6j9ga
 mSDhS
X-Gm-Gg: AYBFou1wTGQtDB3/QCESjAoIxHTfMG+RD/3OQSxu43EJF+oZ1PoDo0EAj/yO9wFPMLA
 Zcl5DU4f9p/+xmFX2yN0IOJ019IrB1mTd/+qO9fKGvMcvdhF5rGVk8MmR5MloIiVrkUVVLCCwzB
 /syg/hgRF6QZmrI3oMcBp2cSf6MNiSJKIPLLOlfuUulsF0ObRFfB1S0OnBGE/zahLgRiPwNqB0d
 ge6hoUi78qH8pbadXr5tR5iQAIWbtlrBXL70SWLn4LIk1tGnQ4g901lUwzCk5Vq7YdjsPKX9/wV
 Wlp8XRO0k6rlVsbKiXSH5R5fW6Z2QNlEG88HVEA4TwtjbBvPfxvmge0/W8JxdpOYDXZ09qOfKa7
 3iTS80knzQ7RPHsm4xTdljr2fl/l9UOBLwEll3V0lxce1Vb0g8bs12ibI0bGvO7aO7Pszx+UWXr
 SBj6R297/l8R7hprPCUEG1W+SPhD8r0IxICZNP5j+Q9UDJNs8Aale8syQwAmNGEzEYbHK/FFGjZ
 l33m22yiXD4ggL1cYkDqWMl86yM6A==
X-Received: by 2002:a05:6a00:414b:b0:878:34d7:6a30 with SMTP id
 d2e1a72fcca58-87e9ea6226bmr5185886b3a.36.1790373011756; 
 Fri, 25 Sep 2026 14:50:11 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/14] target/arm: Add isar_feature_aa64_uinj
Date: Fri, 25 Sep 2026 14:49:56 -0700
Message-ID: <20260925215004.456336-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 06318d12f9f..a9eebb45564 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -290,6 +290,7 @@ FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
 FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
 FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
 FIELD(ID_AA64PFR2, GCIE, 12, 4)
+FIELD(ID_AA64PFR2, UINJ, 16, 4)
 FIELD(ID_AA64PFR2, FPMR, 32, 4)
 
 FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
@@ -1242,6 +1243,11 @@ static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
 }
 
+static inline bool isar_feature_aa64_uinj(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, UINJ) != 0;
+}
+
 static inline bool isar_feature_aa64_fpmr(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, FPMR) != 0;
-- 
2.53.0


