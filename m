Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DA5C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urau1-0003Ic-Eo; Thu, 28 Aug 2025 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratz-0003Gn-B9
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratw-0005fp-2a
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b7c01a708so1555895e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380882; x=1756985682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xuy/HnGxlj+ennOmSNrgDfp/IdNzHUoZQxb6SbArPQ4=;
 b=lIliu+sprZ63H49zSKTiB6eR/r6yxOvG1lOvMsGtvUuoA2UT7wp2VpgakLqvsoFBEY
 UlnJwqcwDTZeRmBQfANYXeSOW3q8U3Wt6+zOBDIQhaU7KWjVdcXKe1fJ/UZD4PuT4u/O
 0dXOEacu23yr+e7Eb3WM7N/zzrjiG5LVsC+EzGUjQWt7DftXH9XkTAmpXsxqlh2Z8mdr
 mNcDa4GgalP2IQkIPQOmxIY0fW/gVvkDjhJvx8JKWT4+LKqw5IFRXAcSM0m7TF3dE4/o
 JHBGjkUO01rkp6VP71jSaEVm0yXzI+2Bd7pHV+bPTLTYBptC5cjJweoRVV/CbrkRcCs9
 WggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380882; x=1756985682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuy/HnGxlj+ennOmSNrgDfp/IdNzHUoZQxb6SbArPQ4=;
 b=u9wcCrpoy49Uo+GJV4HJxmAzkLH4NUZE0YOMc7EOoM5drTHCsJLw0rpdowcMEQtMaP
 8RYl6mv7KEEAwH5RsAZCed61kO/hiix5N6mLSdaDLAncZ/wgOuhB+vElx6HZPrYg55eD
 SM6wDpAQgHoJoq5cBCLLFHIrYL2mQjykQ5aqG2qEA2hUcrQKInSkPZh02hw8Y6krvPn/
 6ctrrrwEOi+TtbBglvCVJ2AkBJNTzT2s0qhaAZ5RUGe6xbjDRzn/qDBdC2YjYjAQXgmN
 na5O/ULL7Blpm5YrJDV/YAJRVLx2X2opoKeXCGOVFjEw+J4+HbpgdTDLVbwc2YXtLugt
 KhVA==
X-Gm-Message-State: AOJu0YxZ+OvA8eWGQR5R5mVjnkMERaeImOP93ooTlF4u/hzN69llKgvv
 00LcjjM4qzrlh5nMQOx0d20xZofunGtwOSed9LMj8sg2U7NqNJkpMYuZpqouCUlRhBDKxc4gis/
 /1ALb
X-Gm-Gg: ASbGncvCmrT65XbaXH2q22H76COjaIaroxjAATXanEc/9kvqIgmQZgy5AH/Y4mP2N2m
 xCQ4siBx5+RxcDXhqWsIaa1EMuhATvE34CWBf7DeRCnZNGgnmKiglV17AIU54kv5nzsBEVJcTFN
 DrTpqwDVUp1D1mM6v4bIU25hf6j6X8iOiu4iS+qp0A+T6gmA9GWGpQKR/LMXFJraMRGBrGpLhE4
 ZJprJHvw02j06eJpXq96OrxkOeYQHzVChj2gquEYnHhr9uObCsZXU2et2WMKZghPvidGcyNEGRk
 U9cdZHMAIXoYefZiqUkiRGHEUuS4hYQUpeZsJmDugfN4jD+m/e0m7rSu5goIHfv8LsNOCqEnntM
 Az+OW8tDfpbIJea4RgO4BXXr+GXzl
X-Google-Smtp-Source: AGHT+IG3BunqCNMxuxLJOnSKpfKKFmxQHSX687x2mI50vc1GNqfJG1sZV4B+wFCoT3jnynIkc2ZshA==
X-Received: by 2002:a05:600c:1911:b0:453:23fe:ca86 with SMTP id
 5b1f17b1804b1-45b5178e8a9mr194268595e9.4.1756380882283; 
 Thu, 28 Aug 2025 04:34:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] target/arm: Add feature predicate for FEAT_CSSC
Date: Thu, 28 Aug 2025 12:34:05 +0100
Message-ID: <20250828113430.3214314-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250803014019.416797-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8ec8c3feb3d..41511d08350 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -604,6 +604,11 @@ static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
 }
 
+static inline bool isar_feature_aa64_cssc(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, CSSC) != 0;
+}
+
 static inline bool isar_feature_aa64_lut(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, LUT);
-- 
2.43.0


