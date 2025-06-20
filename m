Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B105BC77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5q-0003Lp-Jk; Fri, 20 Jun 2025 18:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfME-0003zb-3o
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfMC-0004i7-AT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453426170b6so19313005e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439810; x=1751044610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGiIpCI9oREWc4YqUQzJuNASCWMFgjiRQFZt8ebtteA=;
 b=X+Q6AzkB5DKFNwlD18S+WkELPbuksaIz6F3UCFUeu60hqiPKQ7muoJ6HtLCRZMzjfE
 5XmqjpDZ2tm8NJAUBXd22obLblQ3SbH/K8gaRYyeK+JezNZm5+zC5gGdeoVkhSWUYKff
 +sKaON7rntWpwVlBLOOgvTzG/TqiGeiI30FnMlNctwwsxWK1zmJCw1SnvxRuSWDTHZXt
 qPie1KP7PEhJpgUFSiZSUk0OTT5rUoMxeS1kvqsyyS03esXOGIj9tZPKFBpDVuWlCC7Y
 ofIn2ylH5yufKgf/qkJbOxV8B/uD36uL1FtGidI+zGUBd4642JvKmpfXSCGk7HlI23vB
 P6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439810; x=1751044610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGiIpCI9oREWc4YqUQzJuNASCWMFgjiRQFZt8ebtteA=;
 b=PS+BF5EGGGRzsBGIKXo0gKBWKgNJ/2hvOVBaF5dn7pRgdmlY/GE+anFWtuvy1ns0r8
 LOnMBAF822VyIl9DGSl5ylqInleycVjYx5oGJLBtsqP0Y919oLjvjYfuBIP5HUQ9g9Nj
 IcRbLH8k2TDrOyA19/t+TZ4iJN1GHqc2w0IsT7W50Vc76gyNan0JPoIIsgGk8ZUarOYf
 3eNhD6JCURdwee9r27oqOIz+hLQUCo7xSOKovwtEycxbJpdHcOyrVFeEvpcDcqzVpiIY
 ewjLxggRMp3rQ7xp40ys3Yk6VZrTIkGKyi+pCTt2qbr7vEj19j3HvAWQrLW5q/ixgoQf
 va1A==
X-Gm-Message-State: AOJu0Yx3Ynve7RZ1WX6cHS9O6/0ivkwsjSl3llOxS96xEi9RnU2jTM47
 LHbmeNf05DkCA0jTyh2Bu6Qe3ljbumcOTsOnotbC8oAuVzO7BQqjMuYsl8E8UJbrgeyHKNZf9Vq
 GvbRMTFk=
X-Gm-Gg: ASbGncvzz9xauSWGEgRPjtPetIqfWE1ZYGEA0NEkzmf8wjqdpnFpkzFLpFLMexkl5Un
 nccPNX72SCOfi2jRLzcGMfvHEmtCgqf23fIXATQUCP0ERrX70D/5vPYe0JqMJQA8lbCEFlQHDWh
 6ywXnwR9IWE1l71iH+J0G9YcPdpos/21YWUA5i5Gfjd3vgyVeJbjBjLgCZqEYfYt+mQ3aAQZ7Ch
 0weKpSlsphsylNQGPM3o57ZAjgSw9lsAvup7DCSryfRxNg4YEOuIzAGdABwXAQ+6TIj5G0PWdBW
 yy0pW3wgnAhNJA7NwxReiKc0pX6umE0dau5y2XExny72sXBol2wAD+jIaHsAbBM1sIZMVIzZCi2
 SiD4JqgLahSICXaVFKBqhr/jiOqzDzO+y1yOT
X-Google-Smtp-Source: AGHT+IGsMbguJ1Dnu8tEYbCgltk/O+N6U35RAxF9SVHE9IeiyebBP9kOazEDqqDTCyc8JLomFn1M0A==
X-Received: by 2002:a05:6000:2011:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a6d277a9bcmr3308507f8f.1.1750439810487; 
 Fri, 20 Jun 2025 10:16:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1193593sm2596138f8f.96.2025.06.20.10.16.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 38/48] accel/whpx: Expose whpx_enabled() to common code
Date: Fri, 20 Jun 2025 19:13:31 +0200
Message-ID: <20250620171342.92678-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
index 77af84a87d4..feea5a57429 100644
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


