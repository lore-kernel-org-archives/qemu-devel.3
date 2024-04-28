Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C92C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnm-0005ug-Qt; Sun, 28 Apr 2024 18:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cni-0005tf-GY
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:15 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cng-0005Ul-Mj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:14 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516d4d80d00so4881409e87.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342509; x=1714947309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EC394qSuW4mbz7HKeTozfqIySzPWTIg+XxWvBDEtDQ0=;
 b=TGhJZcceXRQ6GrFka5EFRsFF3/gwKlkQPugCLG/NT/cXvmFwBI6J3VVjwFti5PU/t2
 lSfSDSC1+WOUcIfZId5NtwSrMin1a20CmX6sahHVR//wNWmpNJpChDjUebFLrVrJmHmv
 e4QNw99KXpZb8IqID65aRgmFu4r+zZfOzYJuOIGyqGdVcnJXo9mfB8NOc2DaR6Ioyc32
 AkwQr1hxLTod22KShMY3N1Iaux6YtH22vDUwFknUo1uC/MwwRGQJJ+8OeXkItNcTN6Wm
 1XdVkGafy1n/BrPHlsdsy72LOkgw9AVt7Am/a3p/5agP1NUAZSDKv/lwRYLGjcymPgJi
 WMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342509; x=1714947309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EC394qSuW4mbz7HKeTozfqIySzPWTIg+XxWvBDEtDQ0=;
 b=flVICcaZh36qiICKarBAI2shQwpkSiA2H//QkZISW0TnYsiTUaTCpCW2Fx/QaQ5C3G
 Bwf0F4nk2JohMrpdQlYD1mJJ5ZcSRVKBqRCl1y78zSn5hYRpFzXB6FnGlTanPh8jKI35
 XCEGnh6pPmPksCejEUoyV5Qpfv4UjxzfTJtdEKjOwpQxBBgaUaF9yg3jWZX09elUoDkh
 OWZPkpXLiw4BisRo3h0XgPN02FQU2VxHQwvA9SsadhzdXFNjtsfiH+SXxrlHX/Ki2yCX
 9BS3/JayEh+xGimcJLtzKcjwYO0Z7vw3BoCpYIGqpSiGSwL3eauP22iK+c6p3o3Zetra
 d8TQ==
X-Gm-Message-State: AOJu0YyzFDZ84iszfSHfaQLTNAWNyHfEI/zZWyrtFTndBAgfe5Yc6fUy
 +CUCNtylsjzlRXuLbRFF6/kpAYxbOYKbBnYA0kxV4b9NHkymBt9rRRJ1YUDJ0IQUKd47pv3msAY
 6
X-Google-Smtp-Source: AGHT+IG06gdHkbUcQaaw/Jh1yxLnNDG1oltU4qR6/u1hWiYZiddIR1+gy02T0aS8pZz0ClVMzeERRA==
X-Received: by 2002:a05:6512:3983:b0:518:d5c5:7276 with SMTP id
 j3-20020a056512398300b00518d5c57276mr6961240lfu.58.1714342509485; 
 Sun, 28 Apr 2024 15:15:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 i21-20020a170906091500b00a5216df5d25sm13117569ejd.3.2024.04.28.15.15.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/24] accel/tcg: Move user definition of cpu_interrupt() to
 user-exec.c
Date: Mon, 29 Apr 2024 00:14:29 +0200
Message-ID: <20240428221450.26460-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 9 ---------
 accel/tcg/user-exec.c     | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..fdf6d8ac19 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -644,15 +644,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu_loop_exit_noexc(cpu);
 }
 
-#else /* CONFIG_USER_ONLY */
-
-void cpu_interrupt(CPUState *cpu, int mask)
-{
-    g_assert(bql_locked());
-    cpu->interrupt_request |= mask;
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
-}
-
 #endif /* CONFIG_USER_ONLY */
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index ca27746fe4..f49435df9d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -24,6 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/main-loop.h"
 #include "exec/translate-all.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
@@ -38,6 +39,13 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_interrupt(CPUState *cpu, int mask)
+{
+    g_assert(bql_locked());
+    cpu->interrupt_request |= mask;
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.41.0


