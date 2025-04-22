Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FDFC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOc-0004HZ-Uc; Tue, 22 Apr 2025 15:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLX-0000Gi-Rr
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLU-0006b0-Ps
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2255003f4c6so63552385ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350311; x=1745955111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwbKvRdGoMiUrRuxJx+msL79vGWbZKojWAn1/Wo2xRE=;
 b=KSz90U91TxbwPs/YPi+i/N99eEfoa84OjYJKvwWnTzG7HxRdjUxNagdz/x75zBUQF4
 kWcACnWEhzdtbcMrIqTZRLvS4dHYCkG5941TnnB66JhVaQmY0qvpGVDnCHTgVpNASY2+
 bSmBHcci1KAt40/1pSXi99wkKTG/UFaZYYMUoSnbDSNEdFgNhh40KZqGzrIisyhLCInZ
 HWhfblGA0M1EdItAgbiCkyTL7qHv5YmB6k9WLSIMdavg6pQ8zRE5Vg4QA1uKB3Yr4CIh
 ZtAQSy03F5+BsXZqkHvaLjizLW4Vlo64C+ypu8GDQd6tuBIdVqBnNXtGBwbm0qhO+Evu
 9Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350311; x=1745955111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwbKvRdGoMiUrRuxJx+msL79vGWbZKojWAn1/Wo2xRE=;
 b=usylenuvNFbs5qBglX3FSCvyy0FTmBphUqZw9AEk/SEWlWAJKbVpUZs1xOno5hJWcJ
 E7ShoUMam3HhsU1ywwOOkNx01FAb6zalOPVyQg4SD5/ajc/8X2LDE83esngvakia9MRv
 nJb8RQ0beg4HVhOPPdosS1zuB6wa6KsdpjIxXy4H2+ieKgNXA5U2Of/rsdqXLa1CawnD
 dwIOtoZEcVZQKYD+27GXbudrZ7hLSO2beOe4PCoH+Ygj/3I5uCHqOH9ehicadd73ab/o
 zA+P1nQqp1HuGACQq2xKCmcWwusu1Kdwt5fOcM/cN0PA9xBGY8cC2EY6NnM541iG7MQZ
 qnAg==
X-Gm-Message-State: AOJu0YxvVT2Z3tVVsc/Gw6Dg43mg+B2wpz9+/33QCHcyGfEza0xJ30Z1
 BRG1988uu3i+wulSv4tGomIFX9RW7h/MGpXtxBVv2UOm2MdGXBqc50waLGsZCL3KlhJynh0yIFH
 n
X-Gm-Gg: ASbGnctY6NM36t7ou63m+gyzlCKZnmyIG7u0ZVUu6+HZtEtQy2i0I2FeaxEKIy2J3DB
 myo9p+mzLWVatUR7TIqqMLBIk6kXB/4pNqPhxqJI6YLqazZ28PLSPex3DsU3jY9qt/syLVJCzIq
 SRawr4Hen0PvYOq55j2bPctk8epsvMKqJde/W5drXGx9u4474oSzqf/DPBPnh2uh5L/cfIgK7Mx
 yaMFjVUS8aE2S2m70rzQfmUt3AnKGeXZiQmNRQ65GPEUPxLIiuIDAJMk7LIZo2DEPTh6sbYPtNf
 NYINqA9DOuRKxo47ixrzF/7Au0oGkhFtvmzYC5RZYULO3G6o8B0/VztI0DLjk8Cf+zH+Apfq5Rc
 =
X-Google-Smtp-Source: AGHT+IFmNxNoVahXz9LwSUsDMR5zF1z1flQ3FMOvTfGLGyrmwVIUO1rT4eb7MxAPLwTGwZinlK5otQ==
X-Received: by 2002:a17:903:228f:b0:223:653e:eb09 with SMTP id
 d9443c01a7336-22c5356e485mr203047305ad.7.1745350311285; 
 Tue, 22 Apr 2025 12:31:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 046/147] semihosting: Move user-only implementation out-of-line
Date: Tue, 22 Apr 2025 12:26:35 -0700
Message-ID: <20250422192819.302784-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DIET_1=0.001, DKIM_SIGNED=0.1,
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

Avoid testing CONFIG_USER_ONLY in semihost.h.
The only function that's required is semihosting_enabled.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/semihosting/semihost.h | 29 ++---------------------------
 semihosting/stubs-all.c        |  6 ++++++
 semihosting/stubs-system.c     |  6 ------
 semihosting/user.c             | 20 ++++++++++++++++++++
 semihosting/meson.build        |  5 +++--
 5 files changed, 31 insertions(+), 35 deletions(-)
 create mode 100644 semihosting/user.c

diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index 97d2a2ba99..b03e637578 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -26,32 +26,6 @@ typedef enum SemihostingTarget {
     SEMIHOSTING_TARGET_GDB
 } SemihostingTarget;
 
-#ifdef CONFIG_USER_ONLY
-static inline bool semihosting_enabled(bool is_user)
-{
-    return true;
-}
-
-static inline SemihostingTarget semihosting_get_target(void)
-{
-    return SEMIHOSTING_TARGET_AUTO;
-}
-
-static inline const char *semihosting_get_arg(int i)
-{
-    return NULL;
-}
-
-static inline int semihosting_get_argc(void)
-{
-    return 0;
-}
-
-static inline const char *semihosting_get_cmdline(void)
-{
-    return NULL;
-}
-#else /* !CONFIG_USER_ONLY */
 /**
  * semihosting_enabled:
  * @is_user: true if guest code is in usermode (i.e. not privileged)
@@ -59,17 +33,18 @@ static inline const char *semihosting_get_cmdline(void)
  * Return true if guest code is allowed to make semihosting calls.
  */
 bool semihosting_enabled(bool is_user);
+
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
+
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
 int qemu_semihosting_config_options(const char *optstr);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
-#endif /* CONFIG_USER_ONLY */
 void qemu_semihosting_guestfd_init(void);
 
 #endif /* SEMIHOST_H */
diff --git a/semihosting/stubs-all.c b/semihosting/stubs-all.c
index a2a1fc9c6f..c001c84574 100644
--- a/semihosting/stubs-all.c
+++ b/semihosting/stubs-all.c
@@ -11,6 +11,12 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 
+/* Queries to config status default to off */
+bool semihosting_enabled(bool is_user)
+{
+    return false;
+}
+
 SemihostingTarget semihosting_get_target(void)
 {
     return SEMIHOSTING_TARGET_AUTO;
diff --git a/semihosting/stubs-system.c b/semihosting/stubs-system.c
index f26cbb7c25..989789f373 100644
--- a/semihosting/stubs-system.c
+++ b/semihosting/stubs-system.c
@@ -22,12 +22,6 @@ QemuOptsList qemu_semihosting_config_opts = {
     },
 };
 
-/* Queries to config status default to off */
-bool semihosting_enabled(bool is_user)
-{
-    return false;
-}
-
 /*
  * All the rest are empty subs. We could g_assert_not_reached() but
  * that adds extra weight to the final binary. Waste not want not.
diff --git a/semihosting/user.c b/semihosting/user.c
new file mode 100644
index 0000000000..515de3d2c0
--- /dev/null
+++ b/semihosting/user.c
@@ -0,0 +1,20 @@
+/*
+ * Semihosting for user emulation
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "semihosting/semihost.h"
+
+bool semihosting_enabled(bool is_user)
+{
+    return true;
+}
+
+SemihostingTarget semihosting_get_target(void)
+{
+    return SEMIHOSTING_TARGET_AUTO;
+}
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 86f5004bed..f3d38dda91 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -7,8 +7,9 @@ specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: fil
   'uaccess.c',
 ))
 
-common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
+user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
+system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
 ), if_false: files(
-- 
2.43.0


