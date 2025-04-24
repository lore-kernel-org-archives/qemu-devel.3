Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5041DC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kyV-0008Gv-Cb; Wed, 23 Apr 2025 21:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwu-0005Hh-Qp
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kws-0005WI-CA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:20 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2295d78b45cso6795035ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456416; x=1746061216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFR9lsWoMXNYRBlDfEvBXzbnQL4knAWePayfKJdKcZo=;
 b=mSyV3buJv/+sWgF7ZWKKAR1aeEs/xKb0TBY4cup1L2NUKzEwPYl/qOvubIjpY7Z0Sc
 Ec0pEdYu/WZf311cc3C/PncHDpXIxtvPTYWodjLtL6hGI3hyn4yn6Og9ThZXLZtLq1WC
 qgxJ+VOlXvgBgJy97SgycB0O+UfvY6hcAeED7d8UX1Jdm1Q2wZKcEVga1nfWuFva/Uaq
 ym+EWuIQpiC5Jw8fbjYIhetqbZApY+tNkQNGe7A1hdGftRJgeOcQoSeJ2olm/VaD/98j
 Pvgp/m2e5gN7XqegCyqxvcKfSnZRiGKDu6P65wT7yAtbdoiTlpsiASRogfCLynTjMeMT
 TshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456416; x=1746061216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFR9lsWoMXNYRBlDfEvBXzbnQL4knAWePayfKJdKcZo=;
 b=Eayf4BqQz9j/rIrZfg+OH0lADseujg3Di32L5oGeYQiRz1w2j2wx0ax2au4tLd3eqe
 KFRUdrJUPUxnV+9nWy39NvUtbV6oEATl1Sjj8gVCNETyt4hrXw+2GtcFhGKASCaksdYn
 Cuv9pXGzlC7fNBrrG/W5vk5nsLUqDbFg5G35g/flmXy1PzfM+2BydewtMql/YyNSKSZY
 UYEglhXSsO7dXa6WDd1/nCo5KLr6oK5ITUjxZFOkiC2rKSlmlrImAxMiKwj0vZust28n
 BpYselkHUYJksJeJkTkjjBJN0IwW8gTu4RomwO+WpvVHqHomAfi9TsBXeaTXnGsVwZr4
 I6PQ==
X-Gm-Message-State: AOJu0YwsiKW1nui0eHVDcE0kxrx6gyBIjJUmssNIB8miWe9y7xT1+GNa
 3ih44ET9/4K6OMwtpKTODUKPprhY/ZwC7RJB5JtabDD4Fo7YaNkNgYeU/XBeJUTt+gcWLp/J66x
 6
X-Gm-Gg: ASbGncu/hyP4DoqGhV+kXEW5tqEPL+UN0SveMnPm7VrRBG4LRioSimwX4gaCkcrW4gD
 Dqh0id4rDMeMl86xlAplzBMbN6ODzgJ5CrCSnxiFn8wKSqMXlldIq86VyIe+26UM88OX94q3n4W
 5+2pk33NLzx/C2BzNwfriFRbU1OinA/0zgwar5JjU4U6f0WH+Lljf4L7bG5AEdzN5ZIUw2iiNnW
 X93WgUWKaE0eJ26b9S45jzvwLMHFKUlJ+Ynm5kmwSMbPYzjjPZ15ZAleQzztlLHjH+oW+Zkhaz7
 t0Hr8ap5n+LaqZkmRcQYeKsOZ1GVzzEsvGC9L+5UDX6KOafoAB6vwOQ07d3Ib+T700A9aSa4XQC
 VPjZo+tGXhg==
X-Google-Smtp-Source: AGHT+IGMxWKvOA+BW9d1j56XTSQawOZ+J6MX+Es5xVHW2g6qvVMF1qhVsSzdc5krsS8rQp3G7ad/3w==
X-Received: by 2002:a17:902:ecca:b0:227:e6fe:2908 with SMTP id
 d9443c01a7336-22db3d9a1efmr8773675ad.48.1745456416548; 
 Wed, 23 Apr 2025 18:00:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 138/148] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Wed, 23 Apr 2025 17:49:23 -0700
Message-ID: <20250424004934.598783-139-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
to TCGCPUOps::guest_default_memory_order via CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 23aac39b57..f5a3fd7e40 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -46,16 +46,15 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 /**
  * tcg_req_mo:
+ * @guest_mo: Guest default memory order
  * @type: TCGBar
  *
  * Filter @type to the barrier that is required for the guest
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
- *
- * This is a macro so that it's constant even without optimization.
  */
-#define tcg_req_mo(type) \
-    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
 
 /**
  * cpu_req_mo:
@@ -67,7 +66,7 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  */
 #define cpu_req_mo(cpu, type)     \
     do {                          \
-        if (tcg_req_mo(type)) {   \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
             smp_mb();             \
         }                         \
     } while (0)
-- 
2.43.0


