Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444EC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDL-000310-Px; Tue, 01 Jul 2025 10:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDJ-0002yJ-3A
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDC-00076y-AM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3785162f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381031; x=1751985831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wciRvu6Mv5iLkeR7CaW4jXpg3dCUm5JQrl1yg9dituM=;
 b=hGdcwdlHC1j8ybLPNX8nYkPBFf+BmLwuN8nFZgyl2uaigPoSo762R+NeI70Id3+MhC
 94Yg6OFHusTAEi7UEOaG3tB6ViDyJBO46tzdKj/RcWhQ0v666ECYkTPsLFquMT6ncn3S
 btYhQxvv7hXTiJadjVG8KW5eGhoLARw6IPPj3S5NZ3kkfEjJdNLTly4D+Y5LCVVnX/no
 87lkzI3A7OqniB//gRF6dBOre6hzzcbyK4Ivg4tYNk5KdLWgq/Xhubw3XfLqLEOn3S8j
 4etpor3CRHbI/V8yBU81t2IwWc5ktNJBxI9VLghi5gQyAIR6AEHemqpU3u4op0qAfUWZ
 KbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381031; x=1751985831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wciRvu6Mv5iLkeR7CaW4jXpg3dCUm5JQrl1yg9dituM=;
 b=pgW5BYHHtGvEp7rsDX0KXZ442sWGwf37UiPgalJqfVHT0ub4UGwJycg6kLBqQW5WQQ
 deY0DtmHaE4knT3JAp8Iq7l3aUWzYbctAzNHHRsIPNYJd6g9cCKJpt7M5+FNycJzH+Jk
 860VEveQcq5jBfdEFLIm3OPG4RPpOrHGyOesIsegKDagcgiCmCb3clNgaiwa1H/N9Hs1
 JKKiwYyvQZNnwHzhNszPr/XlDH/uEgKOUJ752v/xSSAZfAO/xjstJ1d5BTtb8mPjrUI2
 wD9wCgwFh7zMApLxW69MF7XZwAZnOUAZA2tDfk8QoCRMyXz4q1dbO4v5KJ3gRRN0pLLN
 P2DA==
X-Gm-Message-State: AOJu0YxiAWhYwNOgBOXnpgXFdTb+G+BTTkkkjeUMCwbTbxaVO1KIj2Wa
 Pn9ZxfOqy4v/63Iu+/GoJT+1cEimBiskTtrmu9mFvOWpxxLoe8wBC1UGNFNRe4y7pThq6OZQa9M
 oCR3a
X-Gm-Gg: ASbGncvO7PnT1HIg5YYWNtS2ZHcL5zOvkUrf539G/oVSZf9+2rsnyoXg0jwXEu9YaQp
 jMzY+ZRVpL9VQYs327D4y4B+wQXuLcd4+zYYzROQpu/EdLW5VrkAn2mDwdYhbFq9SGdgc9NMTkS
 niQ2XbX3TFECk+kIER7GRI/aFQHdhSMgysCi51ifOx2WQVi9EXuVCituidArn/gh4SUPZwLSet/
 kv7phM6bEpzxWizMSaViv6lmY3zRoR+zUzIfVfe/ceX9XQnoyb6L6hU34Oxa18ApAuQvwv74sVi
 R9Sq20iAPbIqhl+jcwFmWtl4nLlNQSMaGFzZjck3I+/a5GuOzALyTyqORbxUnNELsMcih/TncgU
 HB899XvOmEODqS7fwhVzrXmgjGh6i5nndcDnE
X-Google-Smtp-Source: AGHT+IHWrqI0mk+ZW/TuTbctyClgd1FQLW8HANcGmYYuozbepQ+aDEI8GgUVx30VvEK56qqkYdbNaA==
X-Received: by 2002:a5d:6a0f:0:b0:3a5:8cc2:a4a1 with SMTP id
 ffacd0b85a97d-3a9001a1921mr13703246f8f.39.1751381031229; 
 Tue, 01 Jul 2025 07:43:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c4acsm194797115e9.1.2025.07.01.07.43.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:43:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 40/68] accel/whpx: Expose whpx_enabled() to common code
Date: Tue,  1 Jul 2025 16:39:48 +0200
Message-ID: <20250701144017.43487-41-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
 target/i386/whpx/whpx-all.c |  5 -----
 accel/stubs/meson.build     |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)
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
index f812aa36c46..4052fadb97c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
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


