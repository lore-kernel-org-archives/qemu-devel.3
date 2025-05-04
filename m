Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4693EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv6-0002Ac-To; Sun, 04 May 2025 01:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv2-00027R-Lm
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuz-0004Lw-OW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73972a54919so3272945b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336576; x=1746941376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=aj+ZjZi3wTMYDOeMfsbqWz/WERjasSOiSrSuja024hS34Hk91QnlKiEmswbDdqtM0u
 UZE7OrqnXXP6qk74LlhqK/3KEl1N8/mvAE7nSeVQd2aexfaPsWTJ3olGSIXNi5CP9V0r
 JG8kIdy/o2R0IQ05i2C0k23YNJd9QTYjVv0A0qASDfcj2vDeCsXgLmla7V/NCbAnX8LE
 YEVXtQWBJxz4W0WRuOYK+MS3IgGec2iyVHoeqhFc5rOCZQ0dMciw6fBz164dqtLsx7zF
 HURAUpaoed9ceQ/xYh4pGHtKUTlNfOa2ve9pCJeY535iBqq26lMzadpVTTdPaChYmdb0
 GJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336576; x=1746941376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=c6paiIGdEPGQUz2zW8Ov8mfKzvMprSamnzZsNf1T1Y7oFNmLb/bMVTq9MCvilzd6kN
 ApKmQ7U4y2VzrvEnLsirme9MMrvTPv+4dflTm7qmTkaJDsZGBdFykN1F3ROBMSGLjHTr
 NJ9/62kvUlQx6akILzN9//0ByuFo/TbcuUPnMHi01KPwKIckqd4GTWN2U0LrDxha/+jn
 WavCglfkkapKoMTpsGvU9ekRJsv6TBJH2BdIor00f2yztajUMtEqK1p7yRQUboIdWtr6
 zXBlzZmLLLomhg+dXvkmPBRGgBFEFdDmN/jkRd4N5yrHu4UVA3XoKCFn6SdQJI7cN/hs
 Xdig==
X-Gm-Message-State: AOJu0Yy+esCzY32c4ZzgPRJZHuBZeAfLJd4dyIAATUT7IK2J+fEA1+fe
 4R9Vuld2fpWbsXxv9VJneMa7RyKhSSt0Qi7wtFd/MmSTopVj1OUESIPjspbyVF7Gq8LIA+GSz4i
 X++8=
X-Gm-Gg: ASbGnct8IA4fEKu4FthHaundpHnaBtzOdfhlCnlySWodV8cBzrezyuA1Gp3TMbYg9vo
 NDLsSCU6/saXyeahL0Oh44B9p6HDrLQkJx++D4jEiUrXnF1AmrbkOvUgeAdyvUJ5Ml437kcv8p/
 FeqHkv2Y5M1v8QQkzDmcmy2Gjud/5vFyhCxtpqHVnQ26+UWwllu2oWkCWuoNHwM/av/E6Y436bK
 ZFKBLk9OSxx/8Om6447wP35ebpT6+Ps+usg7oNMbO3kkopLhlJ2IQrEZRJByum8J3OQQVKwjK9d
 ehHMrrl17p7NOh/4lXK6P73Tsp+QKCT8ei0+jAmG
X-Google-Smtp-Source: AGHT+IHt0nxDsMjHoseXmw2UOIivIDWLffGkOy9QVpGII4Ziv7ZjjANeetTaX9aqaJQD3dqm3X0F7A==
X-Received: by 2002:a05:6a00:279e:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-7406f0ace76mr4520291b3a.7.1746336576180; 
 Sat, 03 May 2025 22:29:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 18/40] target/arm/debug_helper: only include common helpers
Date: Sat,  3 May 2025 22:28:52 -0700
Message-ID: <20250504052914.3525365-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 473ee2af38e..357bc2141ae 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -12,10 +12,12 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


