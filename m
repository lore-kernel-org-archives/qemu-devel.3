Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D07C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqZ-0000RY-Uo; Thu, 03 Jul 2025 13:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpz-0007pw-3b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpx-0001Rv-7v
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so39786f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564103; x=1752168903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7NLj1HZVYxEPzWZInSZPj2XYJ8nPbkqoQqpybhaaZc=;
 b=tZU6qVf+Y/ekWaMq+yV4As8r/UTsVo1QKZvT6ObJHfgDCtGaZz975q1zZxK31fwp2w
 r2yHkoUycZ7PlaO0V4oPN/pr4ECpPDnA5ozUTpNpPz+o6sEjDm69hODorrJsAkUCvEWW
 iAF+Z+nThgnXtb+B5/aJ/sPDIlvI3N7qKYhIQTAGP8otBeYwns1M3fLsGwYQAxVS9Qjn
 qvg403aibJXny7sPf3tgn4hZ1ZoFm9oDVdoat2fzI1MEASpNGZmXaaxnkcblBhO9KP6T
 MdI8TWrpF71NGJRnKt1KXMCPTUFBIio7tPotJL4/AFFT5NnWAV+zcrsgi7Dk5j4PlQ8H
 UYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564103; x=1752168903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7NLj1HZVYxEPzWZInSZPj2XYJ8nPbkqoQqpybhaaZc=;
 b=i0G8agA2l2VgnRJ3MddtNU9FwlFlHV/+L0bI/jtPEOI3a6grJyh4WOJlnpdEzvrstI
 J16SVOo6+fT8BFuPg0dyM9dqUc+ZzKDC28gPq+rrGQ5lHKpWjBGipOyCtt+leP2Eb0OX
 rOYcqmXNoVsddzt5iV357kcTH105GTLFnGicrNq/b/GEfpKJRJRcqCmYOz2ueNyGgjJJ
 mFz1OkL0VO8ZZ5ahivhJeiDPB/CmoLxVtJoL2ciF+HXavduDrBx2XJwziYQwQUo2BviO
 5u6YdP/DYmsv+mOvIYvJ3RBLulk8P/RitZFlb2jsz3374Uih5zL89dldmZwS0PjUtCov
 YaGQ==
X-Gm-Message-State: AOJu0YytL3nH26qseZbtBDNOgYWA7bGeG45j4dCHF8RzP+nUS4pg9R1U
 nGzcJAkGU5ky0nAdYNMYzgoD8BrvTkhjGMfUjVsU94Uz1YaEUyX/5L7TPImHOOewVcInOQzQf0/
 GnoHD9gs=
X-Gm-Gg: ASbGncu3+WmBfm3tG2suFqy44+FA5PzMCK9JyBcHTrVG8QuzdrTZwWxWHCDUe2ily0M
 rQWUoUNLmNJtpEO0WIWO6hag8S8/Hc1wRbURMwTXlLjCoywt7K9CodFS/30H3jYRCQaAZVKPOPP
 n5EBSl8N/tz/j/Qz94/BVYk8q880/cxPoyTYBJLZJTYQiYu22I9CGrOkn2bq4Ve6pBKOO89g8Un
 0VxlfbwVW/IcWq3761/3FS5vHQOhBmnJ3toEacGlXNfBxr7j9VEyW0JKU3aSOm9oJVZRMsExyRZ
 6s2X0ktn/rK3U7gihjP7vzto8UQAHrBcplJZgTDUM5IfpiEXN+yH9MUovrrsXBtXhX93i1dnnjT
 ZBFxWkjlflBennLyilNrBfm9iGhAUTv9yUT/HQ2a2jDXWAaw=
X-Google-Smtp-Source: AGHT+IEyOBQOTlTAlVMkY2/tTLbCpBL5uIRAyviGBtyzz7xTPc6AnaeaAzCRsfUkdFYvOLHbNZtLqw==
X-Received: by 2002:a05:6000:2c11:b0:3a6:d255:7eda with SMTP id
 ffacd0b85a97d-3b20095cf70mr6400736f8f.28.1751564103178; 
 Thu, 03 Jul 2025 10:35:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c919sm310292f8f.92.2025.07.03.10.35.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v6 25/39] accel/whpx: Expose whpx_enabled() to common code
Date: Thu,  3 Jul 2025 19:32:31 +0200
Message-ID: <20250703173248.44995-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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

Currently whpx_enabled() is restricted to target-specific code.
By defining CONFIG_WHPX_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/whpx.h       | 27 ++++++++++++++-------------
 accel/stubs/whpx-stub.c     | 12 ++++++++++++
 target/i386/whpx/whpx-all.c |  7 +------
 accel/stubs/meson.build     |  1 +
 4 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c

diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00ff409b682..00f6a3e5236 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -16,19 +16,20 @@
 #define QEMU_WHPX_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_WHPX
-
-int whpx_enabled(void);
-bool whpx_apic_in_platform(void);
-
-#else /* CONFIG_WHPX */
-
-#define whpx_enabled() (0)
-#define whpx_apic_in_platform() (0)
-
-#endif /* CONFIG_WHPX */
-
+# ifdef CONFIG_WHPX
+#  define CONFIG_WHPX_IS_POSSIBLE
+# endif /* !CONFIG_WHPX */
+#else
+# define CONFIG_WHPX_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_WHPX_IS_POSSIBLE
+extern bool whpx_allowed;
+#define whpx_enabled() (whpx_allowed)
+bool whpx_apic_in_platform(void);
+#else /* !CONFIG_WHPX_IS_POSSIBLE */
+#define whpx_enabled() 0
+#define whpx_apic_in_platform() (0)
+#endif /* !CONFIG_WHPX_IS_POSSIBLE */
+
 #endif /* QEMU_WHPX_H */
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
new file mode 100644
index 00000000000..c564c89fd0b
--- /dev/null
+++ b/accel/stubs/whpx-stub.c
@@ -0,0 +1,12 @@
+/*
+ * WHPX stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/whpx.h"
+
+bool whpx_allowed;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5001afad3a7..94fd5fc7849 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -242,7 +242,7 @@ struct AccelCPUState {
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
 };
 
-static bool whpx_allowed;
+bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform, hWinHvEmulation;
 static uint32_t max_vcpu_index;
@@ -2688,11 +2688,6 @@ error:
     return ret;
 }
 
-int whpx_enabled(void)
-{
-    return whpx_allowed;
-}
-
 bool whpx_apic_in_platform(void) {
     return whpx_global.apic_in_platform;
 }
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 4c34287215f..9dfc4f9ddaf 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,5 +4,6 @@ system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


