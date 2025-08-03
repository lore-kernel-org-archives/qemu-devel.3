Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A0FC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNiI-0006nX-GO; Sat, 02 Aug 2025 21:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiG-0006kn-S8
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:36 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiF-0004bZ-AA
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:36 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71840959355so33813597b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185234; x=1754790034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbRbPDY2xoRqId21bMDT0xVX8cUKze6JV5vAtkR4wEg=;
 b=lIu4ktoLzY1A3dpgzysRMo7Gv+2CPJC32JQYzM2SWoSLP//fBP/FV/YTVY55I45QGc
 S/i1Ll1oOQuCG/izhhNAOINiQNPRrNEvFdYCHP/YTwthB1ljf7zAN2ZG0IplFv7aiW9D
 0wAdhv0pqozwoh626izRq94FcTWpRCqPXtFnGDKBI1ndj/zBDmlJXp7au0rgQUR6PuKj
 Hko5BDxzCZvTYdJi5bGqNLwu1oK+E+JTrCxMXVxaz2JO//0uWzQnfbd+EaSTI3boADpL
 hxg0WJj6r/DuEAjZli8ugqBvm/1B8f1b0GGML7XxVEdGP+4F2uChvBtOmt+64idLyp35
 G0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185234; x=1754790034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbRbPDY2xoRqId21bMDT0xVX8cUKze6JV5vAtkR4wEg=;
 b=UEL5yRrE5Cme1U+Feu5z8LWEnCfh1cK60St3RQx7TOsgfJcsgwYf6psudDftb7VNdy
 cGmQXEAifHiZed2sLYgZ8kfD9R1oPQ9tuDdsaH7ijfT9iv58tGgJO3zIEq5YvLWykzGT
 jy/fAJODJ5JyBJwEKURFgNQSHPvzSe3htMT6u/r8ziD5EJZ9meW/HReOIviFb7l0nDME
 JQ6+Y3C2GF3S/aDeTmPybvouExRnH17wMljnEjA/x5qi0eU8N2G1UTbNUWSJop5UaTYm
 5dl1uRGB5Z1XLn2MuHotgC6re+U+YDluFELEMSDXy20Ej3qJNFZIIfxEfcPr5iigXG4i
 +f2w==
X-Gm-Message-State: AOJu0YzAUWz+gMj5rHtpP7zIFS9NgZ6dEInSsIMzvDYdgQfjSjBPv3Ge
 bdDFK7aT6+JV1YOlG1jih0jxaQD+nvSmJS2x8kAbjCFWyFqbhc5qHyLh8RCFfEVaRFx/F4rzKPn
 gzyCjbS0=
X-Gm-Gg: ASbGncs922MNq88ejIv+LPBleGeZwm2qXddkXqLD78bggb4zg3rU6xc7FixsmpxBQM1
 9ZQTL1PF8Lycced9ko4gbrOy4H1kalfRgY5J7FzwYJFLjU7ptd2pVA13NTSs+gWUEOZSykVnWCp
 jiRZlyUp+3dyRO+bO5xhkDICZivoEU03rVRPYIFGxFZwaJKf57WJEIpltHsbR/hDvFjMwgGxx4M
 gGHqId8Jp4HXKU9GFsM2qoqrjBebQ5JrX4oU2pG0AOSBKF24QaFLHnA7uj4SdU1gMRenk84Z44v
 uNRF08m4JGGPnCS7sjhP3dc8emmYA//9s6AISPM/zrhBI2QoRzyKp7IMmIz/dFzqQDlyQJsqcYs
 YAcmLkfAIC6Rb0ecJAGHTgN/rfC/gqf3h5loBwHSctW3bZAVYBSn2
X-Google-Smtp-Source: AGHT+IEtSRn8NUbqRKE920EBw5ICwQKkp+/tuDUaqcl3spANNJHnAZzM0NEf5/jRgSPq4ZjsFWqifQ==
X-Received: by 2002:a05:690c:fd6:b0:71b:69b6:9438 with SMTP id
 00721157ae682-71b69b6a1a3mr112635847b3.0.1754185234082; 
 Sat, 02 Aug 2025 18:40:34 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/11] target/arm: Add feature predicate for FEAT_CSSC
Date: Sun,  3 Aug 2025 11:40:09 +1000
Message-ID: <20250803014019.416797-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..f12c5c8be7 100644
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


