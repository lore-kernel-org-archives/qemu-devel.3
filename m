Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E388C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnu-0005fC-BP; Thu, 15 May 2025 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn9-0004f3-Lo
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVn7-0008AX-Ku
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso5247835e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304774; x=1747909574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Dy35+lWv+I9/27nBCmYWY9enGRMPHxuuOHBDG39r8w=;
 b=CiJh5cxgTUOrZlT0zNgLpGafG1jhFbrxrPYnQaPMcOeXmgVWT1KDNsJ6Bgxpbyyyd2
 Bj6erS8bqxLT5H1o1TtPcvfm9VLGwf16HVAJS1OXZgHKCx+1bysJxBOCdBb5TMFwuCYM
 PSsmaI63BDCxB3R8A6T+vyjTKUOytQP5eZXPP6MzLPx+D+aQ1wNUyMpX30i54owMPKXS
 28uKA1urNKB0ruSDZeydQlks58ZbIBeVtUe01LCFI37kZhD54fgAZ+HL+q2+D+2xnC61
 KvY1JB3r8RtdTgfofjR0w+RziMSxGtjzMUArSOAGSJ5YI+lVE/nXzReyh6pTi8r11Z4x
 +3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304774; x=1747909574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Dy35+lWv+I9/27nBCmYWY9enGRMPHxuuOHBDG39r8w=;
 b=eH/0BBgZfouI/PI6mA5SffsPkaeEDroDPj/Vve8L1eshWGXVs8mAsZRoEdv17hfpKI
 UcbSvFt1KlE4grooJsnQI8kFypKdX4wW/ZWvks2ivnZlqnw+DQGdKJmsL551N0pKE+uJ
 UOLDYe3vUrWF64ccBqvpaSSMGY6z4lAZt+hLIk7o56HpR36vLJfAkIE3NfhAHTvSmsFk
 wag7zpgknMI2Jk8gFZZLvUKnLAhD4NLwOBny8B7x/gsp7OIZD6mBMM9lhy0HypJa6p0w
 l6gq7by1/r9CWExjLHib1ffpILcwL/PJ4Hr1wE7sxKXGsgs+y9hIUNmH9KdW9M/gBNd+
 UmyA==
X-Gm-Message-State: AOJu0YxyTJMgqK9e67FfSDrSsBotUHDu3dSBxmINmtPawCv70TecWdZ+
 lcVVmE1noNC+V6Q+IQrb9QIUDcP+6KwikroxsmHG1Z5X10BcVyGcSW8RwawUOguyelOgYsF0Wa8
 P3wg=
X-Gm-Gg: ASbGncsuzq/GrzgXJAjygf6zZIPlDUhNuK5gDuNC207wwwM2l1wdyQn7lkSjCWaOdev
 QOycH9Nx3TIUqM6KryrCZzOs5Yy0GnGBLQzodxCXBObnWkJ7cYtyMR+5GvBnDg8jsQizmiE/q0R
 M8IA71uyqQ/gjK8eUCFVNV1yYfQYothj05ebURPYdGotklkv/DfcPT925i4IekvGSwrNQcTwJVk
 ROwMNFG3gWfl5ZNB0Kau2L6NFdcKARoogecJtMx1c5rWlfFUpHH0GmvnPKON3pVjoMZcP242wz1
 SgwgHz+U71vaT2i3TvfFDNA5vFAKED20NN/QKuthlXzxLD66MAiTznv+7g==
X-Google-Smtp-Source: AGHT+IEux5BITD43FWgl6eNKalTYpC6/BmLEc1Dou2+Hx4D4PtdVw/cQtd3Yrs0YXLxGN67vlVnzZg==
X-Received: by 2002:a05:600c:a014:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-442f9714d93mr20815915e9.30.1747304774408; 
 Thu, 15 May 2025 03:26:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/58] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Thu, 15 May 2025 11:25:06 +0100
Message-ID: <20250515102546.2149601-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Call is guarded by is_a64(env), so it's safe to expose without needing
to assert anything.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-9-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c7e00e64325..ec9bc72c3d6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1182,8 +1182,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1341,15 +1339,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.43.0


