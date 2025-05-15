Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6372CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVol-0007Ax-C6; Thu, 15 May 2025 06:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnG-0004xl-BD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnE-0008CC-KK
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so5411785e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304783; x=1747909583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2TzAtDDzJpSwPwlAZbZ50asH3mlBjtiOUxLHKYs7gC0=;
 b=l7dOSEqhlvT5HnE1Z6ClcCQBfu+naD82QwfwDAhaaISAjBxDyi0eeqfYzCnFo2Ktlb
 S2+qcFl1JReGquxv9oK18K95jVh2rQJeTnV4AG343uSa/FpUjNMazS6mXUAurVHYrpps
 7HfGk0tqHpj/dJhBg1XLztHdjT0Jbfe9iriIQ+wl8NbR4HZSLOZsyR3vSSmiMBqMdyZ3
 ZakPS2igM3U5gyeBAOIjJym0fYjoAaoOcJOR8geX1NgeLyi7vQsJ7cg9IDdtgI3Unmco
 atfEJzKqeoqcT6qaHefrtGQOlL9tuelRTcezcgiUJcNe6O5S7MJd+EwYcQVSvDJR4yF4
 f+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304783; x=1747909583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TzAtDDzJpSwPwlAZbZ50asH3mlBjtiOUxLHKYs7gC0=;
 b=JHYj87n2+QAMkPPlUG3c4bHUZXx0GKbfmMpTle+c3+yAI0YYJP9O7Rq5P230j9UKL1
 o3VMpmZVZg1K8nJbP529q4GUZ2y1jvuCulgRAF80QvedydxYNloijWChAU7jD0/nb0w4
 3ej2M1HE/kmu9E/pSWjVyh2tdtDvCZsgk92Ix2VF1C9NWaBtvDNdNpOQs77R/CafLZ/i
 l3GPFLjP9B8gxl8k8Lu5ZR/Q2VR/jZVqDhXD1piv0eAr7pBhPvCZLODRHVf9FvPbOTq7
 L4zApNye3S4vd2g4zdrSQoMqVFpERDDKqaWtHDzpqOkNuRD5UqppCSGwz+b1sfhlWPK9
 EMzQ==
X-Gm-Message-State: AOJu0YzUR0GNNUXI3JYpvgXSUJJ7pD90MxK8SM9hO3jlnWHaNlIe8Uu8
 02teKIfV8jhboHVorkHSLGYbHLCBFc1IKV7aRsUm/vEKu901850BQ4+tmyxRdtEHlJLegHd9bNA
 0wIQ=
X-Gm-Gg: ASbGncvAYCNJekeY18QAztCZiQPyrENmcvUItD8pI5GLM+h/OdJ/4N554oVcJVsbiEL
 b9H5KqKTnbvTmEUTj959mCQxvyCSkO1QOTeV9sHDneBrmUSw/Kn4BUZrLOOO8r7anzNlXt4FTeS
 oqDaNQrh7gqBPvT28mon0kM0ISRhdDfPslGNnfHZT3Msji2ZlHX0BoHpCaUVxvT1KRyjZNfo/XR
 vgoEcAKNZxCL7twWNgVTFzRsoQ5G968py/xQwa4DffJisFB++ysli2Rt5ZKJLtSK/gH5hUSuzGc
 ezhxSx9Qa/c+cX6ACCHGZ0LdJ1i2VPkNsirjKRja3ioiM8/6XtG5+k5+9Q==
X-Google-Smtp-Source: AGHT+IFOPI//ekFYMabXJ7a50nqbJVyH0Ry3nT67Vu1oeldTePkglPY1hO0wkVfm5TmgDIVTfCNMvw==
X-Received: by 2002:a05:600c:3c85:b0:442:e03b:589d with SMTP id
 5b1f17b1804b1-442f21610b5mr63347045e9.24.1747304783048; 
 Thu, 15 May 2025 03:26:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/58] target/arm/debug_helper: only include common helpers
Date: Thu, 15 May 2025 11:25:14 +0100
Message-ID: <20250515102546.2149601-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-17-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index de7999f6a94..cad0a5db707 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,10 +11,12 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
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
2.43.0


