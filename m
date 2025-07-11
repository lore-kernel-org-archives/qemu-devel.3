Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAFEC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDvC-0007fW-WE; Fri, 11 Jul 2025 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDuA-0004YL-I2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu8-0003QE-Oc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-454df871875so6294185e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240907; x=1752845707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T5QPHrTCpGb5IuxfuJs5tmL6/p8OyGGH647SOYA+1k8=;
 b=RP/V8aOBoiUmVHPPdfTZxB0vWkEYuOJs+NLZhGzR6GHc9UHxIhrLtybbGnI5uZ9uBW
 hncPoQAHYct3Uv/oQKnngznNzTnRzOS83cWYveT9Nr3O0WaPJ7LQ0XdWn/bmEWk8uKrn
 sTHE+vcWnFHvP33BvgpfyBOg4MYSqTPwIUJK9E5qiZQGJpZuURNbuK1AqJCKYBCq4as4
 JlZriW/y8uToflwoR06MboUjojhE3/psCoy1PWBWIkQ+2SyvxrAnwqTrP0cnNNoH2Eys
 hKqWFBQ9qmPeUcglb2hpuW4u278xLe4ge+Z7+t8apBuJ/XLNyJNY3dBNT1ALh4soQA1y
 yMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240907; x=1752845707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5QPHrTCpGb5IuxfuJs5tmL6/p8OyGGH647SOYA+1k8=;
 b=LxJdKV+nHKbkXiA5G63HZGAn3cYhUsfN/4N9OcJ2XuinhUMs3ek8w9whhTwsGv3d09
 NmMOv2wgtvWBEdbyW3PzyZn/EsKg2WMnx5LeErxCS/AGAFohep8dNuyzGsamvn+acTaZ
 7xGBligM+xyTvjCb3ccgeEu7RkHzVVI39fYRhF87GE5wbIGr9ltaJXKzLvHEOrC4zdYV
 SIAoJGfNAksrbTuDKQVFY8037FaGJzut7A5nXp3KR5ueQFRV1FmFX6iDpnry+RvN4OsN
 sTuJOYEVnSFhaKX9YWIP3BP95V2jG4GlRyT/GusB+24mppYBFTEoqJLbZlPRbEYnSZUQ
 VN9Q==
X-Gm-Message-State: AOJu0YzswKaHfBGqXozR/vU5d+67qKXEZS7BNVVKwsPhrj7O/OxvsIz2
 APm+45nRDF4P1NXcncgFXxkGmpW5lAr9CCeoEiK2Di7uxSHFyH14HK1HSH26Qxg6F92/54CAwne
 kOFu5
X-Gm-Gg: ASbGncv18JyjpChG+3LuuqDSYCj4YngzNrAJ/+7VpNpHsAIv/BKlme2fEQNLAh+IvYh
 kdE710vXnfdSm//dwsQJ1XNFIkTjkaV1It3+8iSVHNYkRpbWwv2Go20naKEO5Gp73cbdIpCjGCi
 wHeC9SDhVGBtdxO5pwbTCcsOBaxhhacxr7IzculICjFJ/sRuvEvBs4nR3tFgVFXrST5TSUJuqqG
 j7O8b/kPXHS04eMInYdRVvD5s8gnB3AE756vIqyAf3epfn2O1nCezghRYvf5tJ+MNNzoOHbbvpz
 G8bnKRcapaVzP4pc4e3KXcRw4ySLueMBqbXWs502o3s1IAB/xr8j9Dtf81CKywNa200LVN6dCwy
 /p8QpqbQ/hSy8SNhc1YTJ7JC2KWGl
X-Google-Smtp-Source: AGHT+IEDK6hGHlOjgHNHFgmZCBaXzNAul7c7LikdfmtAskEIzXSUw0XAd8m36clxTklU0z6z+XhOpg==
X-Received: by 2002:a05:600c:c116:b0:453:6424:48a2 with SMTP id
 5b1f17b1804b1-45576a7e0f5mr26438545e9.10.1752240906771; 
 Fri, 11 Jul 2025 06:35:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/36] target/arm: Remove helper_sme2_luti4_4b
Date: Fri, 11 Jul 2025 14:34:27 +0100
Message-ID: <20250711133429.1423030-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
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

This function isn't used.

Resolves: Coverity CID 1612139
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250710173945.115428-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h     | 1 -
 target/arm/tcg/vec_helper.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index d9565c80697..0a006d95142 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1209,6 +1209,5 @@ DEF_HELPER_FLAGS_4(sme2_luti4_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
-DEF_HELPER_FLAGS_4(sme2_luti4_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 0603db09093..bae6165b505 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3526,7 +3526,6 @@ DO_SME2_LUT(4,1,s, 4)
 DO_SME2_LUT(4,2,b, 1)
 DO_SME2_LUT(4,2,h, 2)
 DO_SME2_LUT(4,2,s, 4)
-DO_SME2_LUT(4,4,b, 1)
 DO_SME2_LUT(4,4,h, 2)
 DO_SME2_LUT(4,4,s, 4)
 
-- 
2.43.0


