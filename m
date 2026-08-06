Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D959BC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1sL-0001XU-Aa; Thu, 06 Aug 2026 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sG-0001VB-QS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sF-0000e5-Af
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so3541974b3a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037237; x=1786642037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0GHCx+PLEdVxrjRrYZVoHQH2Ai3ea4uOXYSZWccrLI=;
 b=FQ0vFrXm4VuMohgYNP9Uk4RX60JMo7koEWgDIigQ7aE1gjr+aP+WFhtjKBRfJenD4Y
 LuSNo1Ersok1xAZWTpB/F2MrNCjSOn4EesrznjVZMCL0Q0eqnROxCkxVFhaMsD++cl41
 EhwI6DEWDasPlBsgVMMAvqja70rIG544RApz7QjRa6WCAd+kj2ohdrK0SY3azLcWTSAN
 4eN+5NRZz1ynXCl5jdWaSxs/yYdyDoF2o76SKxhdpsP1msTb05nPtjYIj05pU5cZEhQz
 8SgapOPB5WsMiw9K2/USSCyC/D/JF8URtSlxz+vn030VShhm+j5OMEUQ1dOJWevqjJGW
 i5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037237; x=1786642037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x0GHCx+PLEdVxrjRrYZVoHQH2Ai3ea4uOXYSZWccrLI=;
 b=ZjmbgnolbAxRF1Pn8tQuUvu7KP1nyxheWig6nbzKWVa3rJoiUfgWMMf7mJZHfxtE1v
 aB738OsGuQ26e4OTolXGSf+SODNsgTLUryXx9JnX8euIK4J3BgqF8dEf9yq9+LdF7Y6J
 /0GG7+k1mp7yYP6GHW5QOXWkFtUKLoqmSVn4Pf/LIA4KYG/I0CEViScjoS9GI6D5/qnD
 pOUqSNPfcAicd/gNIKj1npu0+ZlwrtWTeygBkwVkU1nPqxAGZxKRKp5Tsns35WVFU1w2
 iItyZsjLUGKzewM+Y6NX6dV7qr0axUZCX2/KW+wgVIMYts3mEO2Y+lW/+XRLfArwQ9bu
 cE+Q==
X-Gm-Message-State: AOJu0Yx3+0aqNnlUKTZowmfyTX+7dRVSm1lUTl1x6g8XJp2KPVvOGojd
 xlxVv54M/jGnFbDEaf1+u9DDpiUZmFOIq/dyqchlYx2/G1HTC/QmbBWJ8JAs/jnMGKfTHKOtQEL
 N2Bk6
X-Gm-Gg: AR+sD13PGwoyCQ3BKMGYZNKX5bQiQjWXg1y08yenGDIExn0AuGaFe4nHZomWMUBM6FY
 MxMfTSuR6eDQR/4iDWObn5U3g2Yc0IsSD1zG7fWeQobbd38K+6wtmOhniL1iVRQMuS/DxmedKgt
 DKtUi3WVgDsU8li6BfZyFsrT7+YeXFMLzwrjJ3h+5yQTcPABHwUmbnS1gsKAcM7ipSNhwwAdP6F
 mE0zRwEcl4khRkHmKsr7w9hxlcvRbhR+d1XL4mVO8TJ+LPG3C9EkkMXd8MvZe6x9h/WGbw2Yeyg
 7N2AV9sQNcWz/PlaBWot/jIcSDyZWTEvUvNSd1bOZEON8q7Tsyk9I3T7H2BhTYjn6u2U3eji8tH
 UoqMCj6ilWo1LZSOreZzzuAe5dttoXanbFZ79V5BJeVqP43dbTjm5gHdjpyC2uIYVnH/4m1TWRW
 +KxFyecVKGNJfylbHVtPPZfjJZrp5lHGziurndUNdjRjjdILEtLfTKmsPCb47OyIYoN7Vk9V2Uc
 qip954hxiZImrziFH1n
X-Received: by 2002:a05:6a00:2e10:b0:843:49f0:f5a0 with SMTP id
 d2e1a72fcca58-84f2e0ed3famr16816416b3a.32.1786037237211; 
 Thu, 06 Aug 2026 10:27:17 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45389e68sm1803272b3a.4.2026.08.06.10.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:27:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 6/6] target/arm: Enable FEAT_FGWTE3 for -cpu max
Date: Thu,  6 Aug 2026 10:27:09 -0700
Message-ID: <20260806172709.333300-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806172709.333300-1-richard.henderson@linaro.org>
References: <20260806172709.333300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9cd2200823..4b9d01420a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1462,6 +1462,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64MMFR4);
     t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
+    t = FIELD_DP64(t, ID_AA64MMFR4, FGWTE3, 1);   /* v9.4: FEAT_FGWTE3 */
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3400de6b76..392db5ccf9 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -78,6 +78,7 @@ the following architecture extensions:
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
+- FEAT_FGWTE3 (Fine-Grained Write Trap EL3)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
-- 
2.43.0


