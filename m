Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A15C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0SgH-0008HP-G1; Thu, 03 Apr 2025 18:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgG-0008HD-5y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SgE-0003lk-4y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1153593f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717896; x=1744322696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CuFRMF8tGsrdfqJ5EAiHOu7bINkhnIQDSuUKCH5uiE=;
 b=O/E6Ba0CfytTXTC0n1TUihrdN5a7vmcNclrzXl1KPIhVZAHj/UcSsBS5JdrOpBgbqD
 ZKfa64yOTQxnM5MqwwYwvbGXBjMJ/JIKykOpv6jGqV6lJnQ4i7T2NfHZ9OIKURSVV16o
 2cKbUw6F8NICNzOt5VedoFiU+n3FxqG4HRZrgOmCgcObT1HzbYx8UKN374h034Z9uty1
 PmzJQWRZDooEjlmlv9DMXWl7sWFj98iAhFG1Y2axHAO5fi22SvBFbVLNpwuy7oIMwq0F
 pJViUaIFc5hKb43uRJrMs1X8BYe/WhYmkHOgkAasa7t7CS8PYInXcxwSlpqcUhEQyD4F
 RYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717896; x=1744322696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CuFRMF8tGsrdfqJ5EAiHOu7bINkhnIQDSuUKCH5uiE=;
 b=mhAmthLrjjGxEWrr2uNB36FAMYWMz1HQ4Jk0Rdp35dzXmYXIqW9UI5KXzZZoRuFGPE
 TErovpeGjhWEVSwImjlyTcv7yXlabKs2eOcMZCl+MMjlWvxeg4PvbXcpysIXR7MwdwGa
 2ILVI3gDC6Ye5zQaL3Nm2DDf5ikKx3WMf7sAvrBxDRJK9+yAl2GR8pYCqEMlYRWjOs8j
 divVO/Ek9zFNcPlrMWFdUjH7JcaJ06JwO1MEu7TS7T+Lz1eK9OwHjzPOIsF4KAxzkQGv
 7G9F5JpIGESBqveRq9YjoBDWnQM6c5TFmOmHefRAB2NMAl2apyxZ3nhVWSJFwxWZ/RD4
 4gBw==
X-Gm-Message-State: AOJu0YzZlyTiz8AYYiexp9cnTnDIr2qQNbuu/88cm5MfR+PWnWY8+QY0
 QLSeWwF0ZuscyFywgq2ahtBFVES6GuaqjbNcrIh7IzO2H78KNOV9rEWA6OrlyIlaMSzLJDZGSJ8
 5
X-Gm-Gg: ASbGncuy+vHJV+Zt1qCm6bB/cJnQbdX9RYlOvjo23UkvRBUFN8laWVv2CKlXIyZejL4
 mX18I4V5JqdCE5fIRuIfE19cfDoTqkuPTLKxahh7x1T8mYYHDIb1ZVUzclCqQgC/oSSTN1oh+z+
 rqf9yxHTvuHa7yFieyfYILa3QfOmyCJ0Raa8oSvfkFT0XSX3ggwgrWl4jfuSH46pQiWiwl7LlD6
 RIywNGsdyZ3Q2SDIUxe0S1xgd4ELC43i7ahpuaNKk9D7p4nGNwzdAapr72pv46b5zVPSXmfGqtw
 UMEg6c6Z5hXv2B0R75GWIvXdIMyAMZmbcUEKYRcG/ez5Ms8sNe6HzPB0dYWxrkdmZ5aRQLPnc0g
 pXxwv6A8FAootYZ0ljKUVT/7J
X-Google-Smtp-Source: AGHT+IHHVI0ooM+Q/gY/JdaeGOrZTbJOQj6mIwIbQavncB5QD5oLgjeCsMzDN8ma9ZDwNTaJ3jR7eQ==
X-Received: by 2002:a05:6000:2508:b0:39c:16a0:feef with SMTP id
 ffacd0b85a97d-39cba9826eemr648340f8f.38.1743717896357; 
 Thu, 03 Apr 2025 15:04:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b8ae1sm2860098f8f.51.2025.04.03.15.04.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 07/19] exec: Do not include 'accel/tcg/cpu-ldst.h'
 in 'exec-all.h'
Date: Fri,  4 Apr 2025 00:04:07 +0200
Message-ID: <20250403220420.78937-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Only 2 files requiring "accel/tcg/cpu-ldst.h" API do not
include it:
- accel/tcg/cpu-exec.c
- target/arm/tcg/sve_helper.c
Include it there and remove it from "exec/exec-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     | 3 ---
 accel/tcg/cpu-exec.c        | 1 +
 target/arm/tcg/sve_helper.c | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 70608a11b60..944b579d91c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,9 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#if defined(CONFIG_USER_ONLY)
-#include "accel/tcg/cpu-ldst.h"
-#endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5ced3879ac4..b00f046b29f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b0d40c9e18..87b6b4b3e64 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
-- 
2.47.1


