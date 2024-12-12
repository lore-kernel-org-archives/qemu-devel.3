Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD1EE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoMR-00022Q-Pb; Thu, 12 Dec 2024 13:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMM-0001lG-9s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:26 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMF-0006sT-Nz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:56:26 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso1142042b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029777; x=1734634577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZyQqmYchOy//62KNVupcJGjIjPSDBJu9hZW1p798Mo=;
 b=wW4EZLjpA/XS7xUkXEwiqmNJxjQyDmIL/rBzswpl79RB+XtSHDqIJ+umsj3X2/Fcf1
 DZM52W1Z33XTOz1/7T5NSekbjvCli/ybiZ3X5wApSD/dLNnIkJ7xXv0G3RCNtjjQYk21
 u4jtqCjcHi+xWvP3HzaE5cRmm0ig3V61sd0lp993pIMuYaX2cA0h9pzwu7LmKfWBrOSP
 Y/ckwbmLyegt6VBcNVVIu1dRNSDycFk/RZTkOubhcGkwRfAHN9C6YIxyRfFWrbSgit0B
 dWxGxNsbR/IIm5geFIU5S3FHxqq4OgIs0J/3KBOYXg3yuBrQRa7Z1bWwCsx9Nmsi3ISD
 6ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029777; x=1734634577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZyQqmYchOy//62KNVupcJGjIjPSDBJu9hZW1p798Mo=;
 b=Qxn4SwuW1yTQEt0scZlURI94Ow02ZFVAb7h7L3vkczLZX5GgM3+iLXQ8IzMfb+nh/4
 /r+FILx8PlKV2sOKVD2F9VuHQPrFcfNuahGjZ0to4KfM7/syTuGH1KcIQbfsQvvQ1foA
 HguX65Hsra7cF3TFXnPrCQERLxIwyXmqtLMcZrqzBx3ZcIcuaZ2JX3GCA8aNPTnMIHK9
 hVJoTdiUH7A1miOVrsZwIyraXtofPk773yoZaj18ZyuCJazhPTm75PeT2ko7oKwPKHBp
 euMhcLqgEOv63rLHx2stQRqj7Fx1KuFONVA0qKEDRyAVrxIb0fT9xpUcAovRP5TU1xXO
 o4/A==
X-Gm-Message-State: AOJu0YyLvAcmDvlzuoCVnurhOo323INUcd0MP2cSYHtYnCsZSJ2H0omX
 8clobLy/VoR793XBAnDCuMhkySV1pwCA0SeZ4ECbdT3ABFszFa03CCPfE3xtVCJG/jOeQjs8B3I
 +
X-Gm-Gg: ASbGncvDoPEyaBlRAfoGj0jniiR0oYeg8wlzpmsUpqv+oxELjWCCi6UjSRz2uzarHUZ
 udIDE3f+lbqfzqDkztm6jvtcGaeFjKDntWe3zwmiUiTs7UTJTUyQStNcjhLjjV63J0K+EjBAZO3
 LS4o4KNnAJUs7ggnmgMWDJmNI65jDLhJpsLVUvyOrQwSh6bCpy9wFFbIhbfgpqCbt+2BYB1WA0R
 45lGvHg+QMg+DaEFixGCX69ffUA77qYxNHqLSB4vrAEIuZfB3ZKWijPdMorFQu55VEQS2pNoa2p
 JONNScblyAqrRZG+GxWV0Xg0nV7QRJo=
X-Google-Smtp-Source: AGHT+IHM57byOq8DidLWbTmPN2WQBgsCoNziLeUwN5Tnn5M4sqXtv1HJMh32t/398Ma0glSbYRgoiw==
X-Received: by 2002:a05:6a00:2ea7:b0:725:e309:7110 with SMTP id
 d2e1a72fcca58-72906980ae5mr1767868b3a.5.1734029777632; 
 Thu, 12 Dec 2024 10:56:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72904a0b171sm746922b3a.172.2024.12.12.10.56.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:56:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (3/4)
Date: Thu, 12 Dec 2024 19:53:36 +0100
Message-ID: <20241212185341.2857-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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

Move declarations related to page protection under user
emulation from "exec/cpu-all.h" to "user/page-protection.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h                |  1 +
 include/exec/cpu-all.h         | 12 ------------
 include/user/page-protection.h | 12 ++++++++++++
 linux-user/qemu.h              |  1 +
 target/arm/tcg/sve_helper.c    |  3 +++
 target/hppa/op_helper.c        |  3 +++
 target/sparc/ldst_helper.c     |  3 +++
 7 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3736c417860..04faee459df 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 
 #include "user/abitypes.h"
+#include "user/page-protection.h"
 
 extern char **environ;
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 86cd40020c9..73b11f58abb 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -130,18 +130,6 @@ extern const TargetPageBits target_page;
 
 int page_get_flags(target_ulong address);
 
-/**
- * page_check_range
- * @start: first byte of range
- * @len: length of range
- * @flags: flags required for each page
- *
- * Return true if every page in [@start, @start+@len) has @flags set.
- * Return false if any page is unmapped.  Thus testing flags == 0 is
- * equivalent to testing for flags == PAGE_VALID.
- */
-bool page_check_range(target_ulong start, target_ulong last, int flags);
-
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index d21fab1aaf9..bdd98a37de1 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -34,6 +34,18 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 
 void page_reset_target_data(target_ulong start, target_ulong last);
 
+/**
+ * page_check_range
+ * @start: first byte of range
+ * @len: length of range
+ * @flags: flags required for each page
+ *
+ * Return true if every page in [@start, @start+@len) has @flags set.
+ * Return false if any page is unmapped.  Thus testing flags == 0 is
+ * equivalent to testing for flags == PAGE_VALID.
+ */
+bool page_check_range(target_ulong start, target_ulong last, int flags);
+
 /**
  * page_check_range_empty:
  * @start: first byte of range
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 67bc81b1499..5f007501518 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -5,6 +5,7 @@
 #include "exec/cpu_ldst.h"
 
 #include "user/abitypes.h"
+#include "user/page-protection.h"
 
 #include "syscall_defs.h"
 #include "target_syscall.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 904296705c6..5a543b8dbc0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -29,6 +29,9 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 #include "hw/core/tcg-cpu-ops.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 744325969f5..beb8f88799e 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -25,6 +25,9 @@
 #include "exec/cpu_ldst.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 
 G_NORETURN void HELPER(excp)(CPUHPPAState *env, int excp)
 {
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d92c9f15934..4c54e456553 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -26,6 +26,9 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/page-protection.h"
+#endif
 #include "asi.h"
 
 //#define DEBUG_MMU
-- 
2.45.2


