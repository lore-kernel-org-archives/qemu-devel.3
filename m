Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBA9CCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jGj-0001RH-N6; Fri, 03 Oct 2025 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGh-0001Pu-IE
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGP-0006EV-Bo
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso16957465ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511284; x=1760116084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wam4ovVWEJXomxfMisa0loZ5Yxe7ZnqMnNvTf95AQVo=;
 b=HqxsZgOMs/qhbWiVecqkvg+59sCm5CBbwORQp9lHLhhYcOQUwHElK5mELwUHBLGjmd
 ZvUAdAlQfXn8FadKYbD5tvtNkYL+TO6zFHic1Gv+PKfonYm+1yiFpuhlZA/1YEtjrFQj
 NnyyWbaYijF+4BkAOZpytQ67n+zwyWS0jnL5hYxPwi8ZjFMlIL1kGPnhj66FyUrVbLUH
 ph1Pdp78vN8QU4ENyMejKy+8bqjVjO2RRCLXwIEnbndNvOuh5GuqhIOP/PXIjDbsbRrE
 yxkyjsHgC6JE61BdO3OEFiY4Q1QJo6JfF9YfHbk6bZMW292Dq/FvjYAop/hZ6sDHXjcA
 BfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511284; x=1760116084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wam4ovVWEJXomxfMisa0loZ5Yxe7ZnqMnNvTf95AQVo=;
 b=KhK57xDUI1Xf0cmP+kzWwiA4pOGxdPXIOn7sGlkTUeLggDuH5CwCIrS+/B3nUMW4tj
 TnIwX1j7Mjbgj1gKjDK9TKsSQ+6/sS5hPVV+9GBtrBmhBuRNwjwawjlTtxhlhswvVjer
 k1dv5/OpSPBJO2X0IOIdJ5IVZOT9UFE2G0X2xgeQwww836DLZQ1QPk3H2j2wup/kuYaa
 VcG/kNQ+yrEZJkWZLcdyVK7Hy0N5dw0+znN51RbcGvM0tktFlmPDsbgrZxKrP33Cg6WX
 /l+3npyjzpAovfZbNeoCDo/mSCZLM7rnXjD6w1pkFU4r64ukzBp+Hth9rA77YTkhJy0I
 1W3A==
X-Gm-Message-State: AOJu0YwYEW4dgFujQJwrF28tuyxuvE6HAnOb1f1ZbRMd8ufBNfHCV6fR
 6fz1HqqiAByw5GqJOilbL2vTQbGx7FkTqlQYUXdG81d30HsuS7oyjqyPmknk132pHuI0I+183ik
 24sojJns=
X-Gm-Gg: ASbGncufuUQlAbpI9DWjoW990mvOyqgf9GNmWR5o1exmkItKsGh8m5CU7WmMMrvpykB
 HH/GYTNIfkUjJbKzOWj3hlO128Z+xMZvsOc861Dlgn3d0iQPX3fQcCv2mJHuZxvRT7Xq27EA3MU
 xqq1fgF1WJ0C2MVzlCPLZMSSOCvMectnU/XdubffuElkQHAiMVU3VMT36WRJr7VuDiSzI+z0kaW
 ljbQnXP8JRUbkENMqqUpybb0a5fou+9rDDYJixw9WSojMX9aIMVlXsVTL1p92TO+indB16dpjVJ
 7YMOEQbYzA/mmXnzt0CH38CtZgOXkIF/Umdpk3/7+baY1S84icfcZk+boQI1qsB6OTNnfnCOufA
 p/a1Fc+6qVZWtPowzy3Y15V6gCVxepicjCN75d6dN90/C3pIYpvrhX/pM
X-Google-Smtp-Source: AGHT+IGrcH38tRQy+h09Y6Zrh7iitKTh5VocZXkFdPhncy1LLVCM8VImpnxdJCqujlLTqMHk/72EAQ==
X-Received: by 2002:a17:903:1b70:b0:24b:2336:e1c5 with SMTP id
 d9443c01a7336-28e9a68dbc3mr43307805ad.55.1759511284050; 
 Fri, 03 Oct 2025 10:08:04 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 02/73] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Fri,  3 Oct 2025 10:06:49 -0700
Message-ID: <20251003170800.997167-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 602f6a88e5..8d5952558c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1344,6 +1344,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.43.0


