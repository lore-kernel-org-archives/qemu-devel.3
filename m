Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAFAC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10D-0004eL-3F; Fri, 31 May 2024 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zm-0004QT-4m
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zd-0003Sa-Uq
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4211245e889so18904095e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157060; x=1717761860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3znykwplHHm1akqjNJF/VSBzXcqVChFFcVdEcQ3idtY=;
 b=rgBCc0DRRdJyB20At9NVHhe03fMXu6Eyy8xBnlEVjgLEsTviquXotxhCQ3qwnPRRgo
 zkPAJyM2nesH8O/PDWFIWYVXfIdAZw/aOVpdYbd+u8WzQH9uhs8Dib1DzZk207c64xyn
 KBeRUS4ClbTOIuyoeCHayhTeCZoWIgXfrR9WzwMtc6+L1bd6jYZYVm/MYSu0q0vZ8hGm
 V69YjvIVKJ+ab0FL7fp02JFw6IHDB3Va0wDHIWHhTS6m5kOywaMaNJVr7t7Aem3ojg8Z
 K5P6y2XRokxPOtc69BBkD7SI2t9d3EkwvNs70Ob8RwYhGhKYkQaIqxj+6I7BM7GcDM4B
 Fovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157060; x=1717761860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3znykwplHHm1akqjNJF/VSBzXcqVChFFcVdEcQ3idtY=;
 b=Q2kNkhN+lt/xPxot0eLqDNAwPcbvNP4GwaJYdppDQdL07eJjDES8jKp5USxWdnXvPC
 OvSiTa7kTfu6opd2suOV5ccRwoqouYTzy0M2Tmi+vKwtcb1Ucn/m3p3K6UKnuUflissM
 hc7+3Z/b2tGriEGKiXC+IGfx9vwD1MvsRZflBhyEo1t+bIo3AZmPHcetau0LLsogqPHc
 6NU5c/KNZo3mbwhsjhsxUwwhwq6uHdlKsftf3Ih0HAfo6FYd1n1WrZKHZT62SZXqceQ0
 8tQKknoM6AxSu8OQWbStVQ0RFaQaE6juamlg+GDo955QRg3eIVL46eJsjyb144l/J8kS
 VCRg==
X-Gm-Message-State: AOJu0Yw1jPCOSVrh2lPg7IatwR5fRSYlBWO+V0jWgs/m77Q76HnPhK+s
 PEv4zG2WggIxkxxJ9i2sCPMmS0C1Gsy8UES0789meDQ2pSeLd+ybFQpA78Pa/yjNR9icDsuShHD
 /
X-Google-Smtp-Source: AGHT+IHrEfMx61JykcIdFwwtwH0mW6+ibw3O7o+nzVD/C0LDCklk9CQQaYEl9N2UI5q3G3fhLv5Ttg==
X-Received: by 2002:a05:600c:4314:b0:421:2ddf:aec4 with SMTP id
 5b1f17b1804b1-4212e09b9b9mr13081775e9.30.1717157059954; 
 Fri, 31 May 2024 05:04:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/43] target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32, i64}
Date: Fri, 31 May 2024 13:03:41 +0100
Message-Id: <20240531120401.394550-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 6dc96269d5e..e64ca02e0c1 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -934,14 +934,12 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 /* CMTST : test is "if (X & Y != 0)". */
 static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_and_i32(d, a, b);
-    tcg_gen_negsetcond_i32(TCG_COND_NE, d, d, tcg_constant_i32(0));
+    tcg_gen_negsetcond_i32(TCG_COND_TSTNE, d, a, b);
 }
 
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_and_i64(d, a, b);
-    tcg_gen_negsetcond_i64(TCG_COND_NE, d, d, tcg_constant_i64(0));
+    tcg_gen_negsetcond_i64(TCG_COND_TSTNE, d, a, b);
 }
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
-- 
2.34.1


