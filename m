Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B979BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiJ-0002mS-Rt; Thu, 03 Jul 2025 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHff-0006l0-1J
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfF-0003Uy-P5
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso42634805e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540375; x=1752145175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=NE2cUpOykOZj4kGp8wqNaRqNXAdAWqGgNwzn6lt8ECLJwngW5vGVkF55eywGjm4VWJ
 89czEU5bkINzaLr3cu4RA9MxNXN4GJuNAEgtIsHVyjpB5NwbEUYCV+k5TgAd2QmBPvJF
 Qsugvequb4MiSRGUdNVr0J13ga6GqdszGfJxr7MgTpVOF8h0R0nHUWHe80/p/es5oPiN
 nsytQxlUnHRTAqnYzf7DgFuNx4btIlP2u7jic35Rxvh1jkMHriXSlkizrsTxz6iNngho
 CeB1Cnm28m70avkt7qEhNW1JNk/iCxqwd7IHgwouw0DsLj5vRLOuIxalEfnDWn90sHKT
 itdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540375; x=1752145175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdy11kA+VsWt7cboODkHkD4f2jxHCHYlzGKA8G7vb4M=;
 b=m5IcKcfpJWJmSStdifOBMXm0MycTeyfDFryCE1CS+2lMUaLxhgyjPTdNSUisSEtjDM
 rPdyp4UQFciEITJekxr3bvLkaHu+LoXlYQqZDuzeJn3lueMoTu/P1HZke4m0pgJ0kHIK
 NL7MmtzTHdoqDnCFyQHf7Q3dCvofRrzox7z9TTs6KI14CKTqVqIdrWkoiAHDk3ZhdNAn
 FmRS10C9iEEaf8i5yjXcbT1I/R6+ykZq2Bgja+OUlG1R+JGl+TFMQWLw7CCu+pWw5IZ5
 ajGi81HoBwX9qZbr6DrSONOSyG3nHnfONFVEooMeb5KDGAVqKSv9bk0W1uu5PV6ISKP8
 PmFw==
X-Gm-Message-State: AOJu0YyCki6Q3wC2fKJKYCXn8dV26mlbWdxiBXhpcjgdAsHAjV+j4sVV
 mjqjQ2jnZXkf163ZDZ914jddc9XhKq2DFyhYYkn1LWW1FIG5kFjAXxzQILFvt4idFJ2WrbpOOlz
 lMZPVHhg=
X-Gm-Gg: ASbGncuxlSuyAx9/yExI9Fj0cSu1JHICujfNKE7tfoKzJVwB8q8hiRKOscNtJ81DC1K
 li2G0hFSpAZBtuQU2cksqvdWZbkmWyzn9xGLkACZfhnXOnxrsWspNl5h/PGQF+a+PiDjIJ4xtlY
 Pe+WvXwiK1Ix5aff4xRmv0UbvohAN7Bk8/gPEIEh/WwrIQYkHCNG06XCTAT7L1X3tSlqyQ3phy2
 cSPGB8Nfjj65aUp9gNM+wogeq1Tl+v8HFQwFkPAbMnod42fbqHEUhglmjh1U0oLlMkjZ0wxWobE
 cuI3ySmh8QFrt1LCW7wG3G7xPZd9TktBE9DXjPCyMKvzbsy3xdLpNviFETMZ32lY2/HSVLyrtSh
 EhlPSLYiTLInGMbFfBlxpDQ==
X-Google-Smtp-Source: AGHT+IFTTmpYPe4IjWoZiJ9ZpcABpmp4ffx2q20Rr1xysL8BJLKOX6y9UzICtQUNCx6z/t7QN6DGdg==
X-Received: by 2002:a05:6000:410a:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3b32ebd79d1mr2147393f8f.59.1751540375102; 
 Thu, 03 Jul 2025 03:59:35 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b516sm17928800f8f.41.2025.07.03.03.59.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v5 44/69] accel/nvmm: Expose nvmm_enabled() to common code
Date: Thu,  3 Jul 2025 12:55:10 +0200
Message-ID: <20250703105540.67664-45-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Currently nvmm_enabled() is restricted to target-specific code.
By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/nvmm.h       | 23 ++++++++++++-----------
 accel/stubs/nvmm-stub.c     | 12 ++++++++++++
 target/i386/nvmm/nvmm-all.c |  6 ------
 accel/stubs/meson.build     |  1 +
 4 files changed, 25 insertions(+), 17 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c

diff --git a/include/system/nvmm.h b/include/system/nvmm.h
index 6971ddb3a5a..7390def9adb 100644
--- a/include/system/nvmm.h
+++ b/include/system/nvmm.h
@@ -13,17 +13,18 @@
 #define QEMU_NVMM_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_NVMM
-
-int nvmm_enabled(void);
-
-#else /* CONFIG_NVMM */
-
-#define nvmm_enabled() (0)
-
-#endif /* CONFIG_NVMM */
-
+# ifdef CONFIG_NVMM
+#  define CONFIG_NVMM_IS_POSSIBLE
+# endif /* !CONFIG_NVMM */
+#else
+# define CONFIG_NVMM_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_NVMM_IS_POSSIBLE
+extern bool nvmm_allowed;
+#define nvmm_enabled() (nvmm_allowed)
+#else /* !CONFIG_NVMM_IS_POSSIBLE */
+#define nvmm_enabled() 0
+#endif /* !CONFIG_NVMM_IS_POSSIBLE */
+
 #endif /* QEMU_NVMM_H */
diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
new file mode 100644
index 00000000000..cc58114ceb3
--- /dev/null
+++ b/accel/stubs/nvmm-stub.c
@@ -0,0 +1,12 @@
+/*
+ * NVMM stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/hvf.h"
+
+bool nvmm_allowed;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f521c36dc53..a392d3fc232 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1192,12 +1192,6 @@ nvmm_accel_init(AccelState *as, MachineState *ms)
     return 0;
 }
 
-int
-nvmm_enabled(void)
-{
-    return nvmm_allowed;
-}
-
 static void
 nvmm_accel_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 8ca1a4529e2..4c34287215f 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -3,5 +3,6 @@ system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


