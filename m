Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8341FCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXen-0004Y9-Cn; Thu, 14 Aug 2025 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdu-0003MM-Kc
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdl-0005WS-3W
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2ea94c7dso1333814b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176702; x=1755781502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTzILFxOh9VPP18+18G2a8oDIZLGKqGhECeVoAfm6S8=;
 b=XGFf3B2ld4uo57k7Y6eHIZg9zR9q7YuIzF+TwzZ+kL14f0VFXgFKyD112sJ25f9I+C
 Fc2WYov+FbHOm8S3cZYsSf5bfynbhnm+NwSaHgqPJJpdZ5d4XUyoYtk1r9ZS0vYs5DTr
 R6YfAfNvn82UKodIs85Hl8W6NSnMhF/DZ9wx1W3D+o+6AgyZ0Um9Os3ySMbzH+iSXqpx
 M75daqiErGqTvWVpq0J1n4V4+m0E9E4i/UIfVpip8MPFr6fNKtnZmxBujuDO1AKB3vDE
 H0w6gDo+vubiytQ8Bzv/I136RWVedWc57EAahEEh1v1Qtb2e5XjkzRDQjWmiOptIGYEF
 PCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176702; x=1755781502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTzILFxOh9VPP18+18G2a8oDIZLGKqGhECeVoAfm6S8=;
 b=tSApT4Y7aSAq96KSkmITNz6kYSgZF1tCj+Iysgou9PtpnU8twMAXwubpvBg0S18pVj
 +u8dpPRsTTJt7P5RdWIlgbPw8DscgYrW06JkkC7O4VkJTkSao/yhLWxyfdyT6CtVVvpO
 QtB8XVpYnSEAWrPIksUAN569KolJw1aqY1PqYnf82hIVYmRffV/X6fTZJxFbBKbQeAwx
 QTBkER0uWTa4VkKnsfZKzajXhuWWWaSIXLTVfvYQvbjzZ1Y9fli2G/DcoTW5HDQ/IcIG
 5ymiAB664nLe3/iqKnZX745woaJFEfgjVnhiejVJzriSJaJiE908LRlo5jvLLVYI+TDE
 dRfA==
X-Gm-Message-State: AOJu0Yynr4h80lwnXcxDX1/8HUG54bfBTXFfbQARXtKch0UuawZmc+x2
 6i8RS5UQ3X6jlOiOwKt3nT+fCqmdHhhNmmqXgPIuFMDUycGy+X0c9mc4D/hHjGbc4ubdO8AgOo4
 Ab6buMrM=
X-Gm-Gg: ASbGnctxO7j1LBaIkNBwGi1l7wyzvnS6qgC1/CV7fSermBJG+niU31v5q/YeKGR9kN2
 R1NJr7j1JgrImDDj/rjVHfIs9ZYQmG7/eHmaJzKXCnb9w67PFcGS1kj6eTW20B6c/hUAUk84f5I
 c6EjoQlbLQZjHy/2guza47TWWf5AIopoHWW95bVJlqNXoTbkvCjlutxATJ0+nXMvQzguRWlmOxa
 UEyBtSJgbFkgBonancJUrpjrQAIVpeTJHvPbhIp+p8jGe4Zb6GkhEBUGcPUv0sos84FqRe9d7oD
 WrWciUPF5FFbsAWh/iMALjaCHa7yBSY71sl5QYSIYbdnR4ynLJpc/js103X+4T/t/AXzaj0xKh+
 bzsAPVb3WPHkIeK0k5jiutrkPTs99YQJixUr64lMlb/mOARk=
X-Google-Smtp-Source: AGHT+IH/yhMZGJainqAx6hHcFZvlcDOdk2i/f3M6T3xLNUelT7aLU9oeggaV/hW28XdEfr90dG/Y+Q==
X-Received: by 2002:a05:6a00:1995:b0:76b:e144:1d91 with SMTP id
 d2e1a72fcca58-76e2fd72ca2mr4558954b3a.16.1755176702220; 
 Thu, 14 Aug 2025 06:05:02 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 73/85] target/arm: Enable FEAT_GCS with -cpu max
Date: Thu, 14 Aug 2025 22:57:40 +1000
Message-ID: <20250814125752.164107-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
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
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f4a41c854f..0c3408c0a0 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1205,6 +1205,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b894aced89..9e3df48e00 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -72,6 +72,7 @@ the following architecture extensions:
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
+- FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
-- 
2.43.0


