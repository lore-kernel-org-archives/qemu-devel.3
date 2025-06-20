Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA90C7EE2E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMm-00058D-2a; Fri, 20 Jun 2025 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfM9-0003oX-8G
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfM7-0004h9-9t
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so23584405e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439805; x=1751044605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTeMJjNyNvpDzcgK78dXTDRXnTQKYPQw/ldYN09UYyU=;
 b=frkOILCDjE0xE4nABt8trZf7rJiI84t2J7HKeYMUJKwOZYiDFQONDO+RhtWYNCMEYy
 gADfwOoGq21beY/lOXMgw0WBf1h0R9KA93vVanTG5s8rDKbIzEHSjrORSIG10IChM1tN
 yGOGVeRCOCNKM3kPY5vUshk9wA4kyvC8VLNAvKm028J7mTcik0nkLajdaTNw8Z/fzRDb
 YrmbDOgQ540W6J197+EZpC7fq/HlbzoLyQELCPG8qIBeZ89GME8ahwlT9zDyBLXaf7+F
 /GQ0cSGYWM6VLRgY9wGK2DXhXfOoMqGjeWG6XCqnlb+RttKCb1eQvPFmO5I4hXGQrNzd
 eekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439805; x=1751044605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTeMJjNyNvpDzcgK78dXTDRXnTQKYPQw/ldYN09UYyU=;
 b=btaF0PvhWVrO16bBbA2itWgg2t7b3MGsUdtl9WrcXwaEJB4YgViryQ42gejo/7pNF3
 KnS2oWsVzn1zKJa/ocEYtqf0b6EiEplt95uFATA85POP7e+c4N3iYnEBFBLbcSbVJHMF
 d0TdaxQMSg6agR/9Za0b379kMMzL1zbO8wh91KORkuTHkBZuvVGrqP04/0tymlHidHtX
 nXo0IO/47IDhTqqA7n12WMWZoJ3sHJmhlQanXsEd7qTlLM8fgGYZSQdfzsY7l7CDvph7
 fdx/0MG7629DYSBb4XS2ZoEdflXJXXCw8r0JdwGYjxmqjhRJAhcd4gwl4/+h6ypMHhSw
 H0AA==
X-Gm-Message-State: AOJu0YwfNW13wbNim2+Eg81irOQUt2hrL7kwVRBUhC4VvS62DNUuZ382
 A9O/MHoVWnmElEnvSCM1LDK6zBs28bsR8ZFnO208L0zz7+WrFdsIyA18/J8JaRPbF/ahlH1VA5q
 an6yZjeg=
X-Gm-Gg: ASbGncsW3mN4ZWRb8nrRNch3k2dK8KeINQeVYgdzBeo0DQybdvASnywdWYVseA6Cp34
 546oIl9nPAx7/STvbiWTg9Uj5ICqDtMeflb/ygjj5GNdWG19/P4+V81hSRJRPgo/R5ocpLmo87a
 gK+a7UPk5rboP8rYBK+BVk4BiEedhF8h4NZqzGA/5oJAK1Nl8tS534toBb2OxqIEJXyl1sITtsE
 1BPEu1NQLxVkmR9JePC6/esNi/mYrUrbLu5ba4FfTyzC3TWaZvbmyB/HDYvEckvkebaW/j91Dj9
 zuHFDJOWNAkI9/Bv9xH2+SCPcB7Mn3XKl3IhmWA9AxcooORkgXIo/PQhHZG5KYQjYfiVolxqVvq
 evfXvNtbFE/UTYqUlvfEUcGE9dFKAvL4QrUMa
X-Google-Smtp-Source: AGHT+IHbGvP0xlrFYG6lP5GLXqtrd/zPfuk7gBQa52LEG1WSLiPQWCevVvnJh0cA1KqdQQSMtB8zow==
X-Received: by 2002:a05:600c:4747:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-453659c0a51mr31415225e9.13.1750439805241; 
 Fri, 20 Jun 2025 10:16:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2a1bsm66117935e9.33.2025.06.20.10.16.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 37/48] accel/nvmm: Expose nvmm_enabled() to common code
Date: Fri, 20 Jun 2025 19:13:30 +0200
Message-ID: <20250620171342.92678-38-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
index 5c8e2857a8b..46a57c78feb 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1192,12 +1192,6 @@ nvmm_accel_init(MachineState *ms, AccelState *as)
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


