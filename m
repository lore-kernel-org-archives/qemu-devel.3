Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6A4C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiR-0003SB-Nr; Thu, 03 Jul 2025 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHff-0006lk-Tt
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfL-0003Vw-By
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso4371438f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540380; x=1752145180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UiewseZoW7++jqLIzKMJ/OYq1tgfsCyntten+qzSRY=;
 b=zzM7SngbgxQyfKTTAA8B/8wCriS9CF+aXn3rjX4u85meJirTjTyxaGsA2uWCFoflSO
 KEnImqc0agwaa0TWB+YE8ELCMOKxZFdQHcSmn8GpGQc2yGPJqS3TSydUfu/4ErtiCRB+
 K0TPFq1R0ET2GXGjdBo01sR7ztbY/zz3OSwzhfb+YFnPLWPlreyTPyMsdsEg0L4lRplI
 Wdk1amYHzSLTTWDrM/lGDkzjKTMlQbdJhr7xM2ydShZW1olQ5D9P/BOfibuMfYzfWNl8
 nan8HA7zTzVMdn73vaLkWsvLGbC7fpwI38zwhpwIOemn3P9Paeu1L7QoD4yHp9nUgv+P
 +Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540380; x=1752145180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UiewseZoW7++jqLIzKMJ/OYq1tgfsCyntten+qzSRY=;
 b=C/vBEnWEIYHXTLFsiavcMW1GMcszrgSRiI6I53jSZUhXk94Tv/zbT/humM26bEZW0f
 YeD/ixvQrlzDjc7KTYTQSe/x9P7Asb+dEm06BC/Jar8mT77hdSrWr3qu2YJ8yvA1hzWO
 kCxLcMCoZfAHvxS4DQJd93EYR8KvHpc3MyeTaTAkCYD6AVi0MeAsFsO2ju+wE57crSdT
 vvF756zlngRLBzAo5+V18SX+cfROcrNphb7VJPSwiKTXxwT99WOslofV/BdV3EpuC5ZJ
 xp0HDdtf1ePG5OQKVtgqWxGY+7kbpWIctGFoJ3K1xykhb4DaGmYEA4D6ZF/Q3X48HDF/
 Udhw==
X-Gm-Message-State: AOJu0YyogninMFZIJ7ygyVAfoYS5/9BcQro9ZAfxKwCZ6LNJcN/Mo6IN
 TsBejsE/6qiZlQ6wo7J0s43L2pdNKKmPyhMfgAmldaxZtAWGBRd9f8WG1oOrHEam8XQLSsicZGo
 l3TzYW1c=
X-Gm-Gg: ASbGncvw+bheyPvZk41of5jubcZ+eOR8D4fNmlTUUkAGNB5B79CeC755FGKrghFci7Q
 IDrc0C/vtIuyGiKf4lsd0pWkqrGasngdXdWUa375ViIcpH4+DFBGRFjLVeHDzKJ+7BnYUYTL/jj
 fbxV84chEyomD0dd6SPzN4bGGt6jGQ1MkR6O+i63Y1APXgEbKC2foZFzJTWD95rkHs8Y07QpKz9
 8bDX9lOE33DQFHgHWY8W1VckoL/iZB6/jKoo4CQcyoHfGALsjsXCZbZNqBTyH/WWSqpvAoE/Cuo
 UwgmNi2DI4iISckLt3yk8Iw0tlxr5iTkAtFPouIhLzCyJoTGnOj5lWCt+QW1MxB0e8FEQieev16
 rZXOKZedqDq8=
X-Google-Smtp-Source: AGHT+IEglrs09yE017jiPqaImjRQF60pKbLzM7xZkDB3/SBr13de9FGL9F2tO1sQQvTsqyjGi5baPQ==
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b2005840cdmr3299331f8f.47.1751540380213; 
 Thu, 03 Jul 2025 03:59:40 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde35dsm23115255e9.30.2025.07.03.03.59.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v5 45/69] accel/whpx: Expose whpx_enabled() to common code
Date: Thu,  3 Jul 2025 12:55:11 +0200
Message-ID: <20250703105540.67664-46-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
index 525d6a9567b..1732d108105 100644
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


