Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE0C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX3K-0001SJ-19; Tue, 01 Apr 2025 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX3D-0001Mc-3F
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX3B-00012w-E9
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso40389125e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496367; x=1744101167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hqxnb6HRgZx4zMBcClLax+N04cp1fAmMIfTPJWgUr0=;
 b=oiwQc0DdeFREHSFMUbvm4hA2756LIT3ut5eEhGlz8rm45AKHLMd9/Nox9YkbX89X5s
 vtHQkTl9oMrApaUUNKhrRIuonOvUrsGvDdAlkFVbB0Xq0wePFJNBzuqvQw7XazGuSDWk
 S5EeZdfjmBtWs3k+wKziwIZWFFguilYD6E692CG4NUIGM41bxPcjb4zbpLAm4XyqdEwc
 w8xynJJWyaLo0PC5PX5aiQoL80bIeQiBgevEnaJpzyw1kZXBJCvelSLCJZupobZUebZ3
 k+ZN6DIWCwgvVi5AIPieiop/CLgQOPeB941NuKBD0L80VUBYtj9zyw+ezTrHEeo2Nj3M
 QQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496367; x=1744101167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hqxnb6HRgZx4zMBcClLax+N04cp1fAmMIfTPJWgUr0=;
 b=hXAJF34OhDnr5d+NeGo9o6HNNg0+LBDUqC7jh4Wj+rrD3jcu4C2vjqZugH55oM1M1V
 3VXwv7P+AM2L7y7eY/XtL/kMcNWqwI5wC/H3Ngiq1WWwNuTfm+PhVgqnap7uhSs4HP7N
 lf+0eWJRvSKHL1Qn4m56665ZSVwRZIVo9Kr3t4eqDCNoUwSrEQ0vijvIjOu78IJeepHk
 I0ZYdSXY2KsMhVHE5iB4sesHyUSnBcSnIzi+qkO8K4ONWIjzyRWdCQXBIPRoJjtibTTV
 og2vGCizy0e8G6pdPvbyTFezGCLZ2R8K/PlLU7EFzUSzeNeW28J+2O7ah9T7x3KkjWWJ
 pGDw==
X-Gm-Message-State: AOJu0Yzd0sN1jmnlq334pbjwfrPBXMa54B44kzSt5VrvI40laCEGGi9F
 wM/vYe/g8238ztW8iw1OOht8YZSXUOopx3oAmnxnu6O9dZYV5QymujJ1kXkVIZE5lHXEgImpW12
 4
X-Gm-Gg: ASbGncu4HxZ26oGJQyVFBcyEbP1L1BxPWLw/7KcqO6XB4BI2z3kN8oHG4r1ogY76dZu
 v8G/gLEv7iBchq3WStST/C3Vwggd7ZoYJIH7KyMYeiCpYw5SViXrwGmRnpqEa8j9xiNAMXMS8P/
 gYezHsCjxm84msY7IGOcCqwl//KaNZbFFhaXklrDFfH3A4HQZdAotmhw0NRbCQSEjYSQsQRZUQM
 S+01WvLiJKHEnXrawjnO7Zmznz2Wt/sZN7Q47t47qQCEfQaYGmVdWVG0sBru9KiMUCPm/Wlzk/C
 +C7hM3TBxwZVwrZTrpBeF3XEjH5UNsEgU5JVfz6fKyGxo4CHBX8AWS9r4rSJBUNo4rNK/6lpfze
 cpuy4YfcPSiPYEqX7BCU=
X-Google-Smtp-Source: AGHT+IHGOURURP1beKwRoF7gU8FCjJsNnPQEnCWFihYh6MQq+ifMcOgvbQwgsWvSS0/q6iXyHGkbUw==
X-Received: by 2002:a05:600c:34c7:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-43db61d6ac0mr124099915e9.5.1743496367479; 
 Tue, 01 Apr 2025 01:32:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc12bbsm148735865e9.13.2025.04.01.01.32.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:32:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/3] exec: Do not include 'accel/tcg/cpu-ldst.h' in
 'exec-all.h'
Date: Tue,  1 Apr 2025 10:32:32 +0200
Message-ID: <20250401083232.33773-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401083232.33773-1-philmd@linaro.org>
References: <20250401083232.33773-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index 6c6098955f0..8057a5a0ce8 100644
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


