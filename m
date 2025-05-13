Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70709C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtfo-0003KX-90; Tue, 13 May 2025 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbV-00088d-H5
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbS-00038B-Nm
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so41382405e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157981; x=1747762781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mls/xaRakChhSn59tI4YzwbCahfEzZs0aBlZvGQ3N1E=;
 b=Lr4UIpBfcoSGYEy/IuAM349MHuzZMPtzraAaZ6CgNADoKHDhcovPQst9vKJ91Jf9sf
 c+xFNyfnJ0BWSQz18XoWykgOJjs2ej+Lho5bw+tYiNmebm4HXIJZgpHeEBIbLyFXSct/
 W8vGGxXL9jpC17+p4JS0ezqRzUWXemPpsMQCn02cStEi82lBJelWyjQwXcRzOqBt0kc0
 HUiIZ1/iERJ4l9tIJqvYzNP5o3PQ3DkAxikIveR0e8vFBWoV49jEUZKbr+7229mg10+S
 PppF1zigb4fo0ppNPxrN1PhlW4rpUPuXSLCukZRUJdWbAgQ4tR0KhqywyrdotL18df5F
 Fouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157981; x=1747762781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mls/xaRakChhSn59tI4YzwbCahfEzZs0aBlZvGQ3N1E=;
 b=JVbvIVMLUP7XJWT3lNJvIeVkNzzEKY5CydzlH9ApO4vaVPA8UQu5xSjF9mhLZr/ttG
 ZsqERzlXxKq/wiisruxYKNQwH0Mgzt5Eyv5C19221hvqYN1QCO50VfL2caX350yLRDur
 6ElboMw5LyFwHLLHw/oBewbRG+X8UwYJJ2GYU0j2aVeFAYCr5C5oQuzzO1+q2Y2IgbSf
 7lDjgXRJdqCzNkcZHAQHr+CKIZmrPqi0V/oYHrush5+cEDEvIAuW3E+WfrHaSJ1yS9cH
 UBHPFmm17AZJfEAoWnumzDukZ+bMX5GpZlu1pGKwvXOXV0dBrRSqDmfCOFqiricvCnvS
 xl6g==
X-Gm-Message-State: AOJu0Yz6NQNhaLnqwkhPyQ54vq7mRGEIxyt4Nc79IzZ85G1Zfnwa9V+u
 BVMvZPJJSc8y2PUgwpKLb3KKxZG+ORy9i5qQdycmH5hRlZjnQ6nM8QiqY0Ky4Mteh5X8C/+rffF
 loNU=
X-Gm-Gg: ASbGnctv+CozIOKvqXwG5F8BGQ5+FjYWJPlK6RFR9EV8syQbwkNhH5VkXEJqloqos4Q
 6IPYSrqL/qFU521Z91uqRJD88ZGEO3J2HS96tE3ZyJcZGZ7oklmmyHXIcZB6ptJzpa7yY1JkEga
 41kEHEMGryN4DGmWGJCMxbFlRFweQeTtwPWsSRPa4o8ECP1te4l4DKFi6FqNqfArOYfWP+OvqFf
 jf/fdqMRTfqAu99V1YxBGImeeTSEyzRaYwNgB9EZaIB3/XLL8nHL+d+O8eSVQoe9z+iTvTv8eAh
 XRQMgr+ZtNPBt01h4JdQUBDSvnbw7dX3NHwJZvuiBM5Ll2wsXyWpExAFUkCDRDvgjv5EOl2Oso/
 kNYz9s5u472BluBr2fL/6Kx4zTWyg
X-Google-Smtp-Source: AGHT+IGeLQPv0LOwwpKCn2f/260lvVtwB8SL3NefoC6gw3yni7/Q5tncJiNAF7mhRYDSGF7zx3bSLw==
X-Received: by 2002:a05:600c:35ca:b0:43d:abd:ad1c with SMTP id
 5b1f17b1804b1-442f20b94f5mr2043955e9.6.1747157980897; 
 Tue, 13 May 2025 10:39:40 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67ed1bcsm173195565e9.18.2025.05.13.10.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/19] target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF
 definition
Date: Tue, 13 May 2025 18:39:11 +0100
Message-ID: <20250513173928.77376-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In order to allow non-target specific code to include
"hvf_arm.h", define the stubs in hvf-stub.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  1 +
 target/arm/hvf_arm.h   | 16 ----------------
 target/arm/hvf-stub.c  | 20 ++++++++++++++++++++
 target/arm/meson.build |  1 +
 4 files changed, 22 insertions(+), 16 deletions(-)
 create mode 100644 target/arm/hvf-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dacd6d004d..7431f88b5d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -509,6 +509,7 @@ Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
 S: Maintained
 F: target/arm/hvf/
+F: target/arm/hvf-stub.c
 
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 26c717b3826..7a44e092620 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,23 +22,7 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
-#ifdef CONFIG_HVF
-
 uint32_t hvf_arm_get_default_ipa_bit_size(void);
 uint32_t hvf_arm_get_max_ipa_bit_size(void);
 
-#else
-
-static inline uint32_t hvf_arm_get_default_ipa_bit_size(void)
-{
-    return 0;
-}
-
-static inline uint32_t hvf_arm_get_max_ipa_bit_size(void)
-{
-    return 0;
-}
-
-#endif
-
 #endif
diff --git a/target/arm/hvf-stub.c b/target/arm/hvf-stub.c
new file mode 100644
index 00000000000..ff137267a03
--- /dev/null
+++ b/target/arm/hvf-stub.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU Hypervisor.framework (HVF) stubs for ARM
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hvf_arm.h"
+
+uint32_t hvf_arm_get_default_ipa_bit_size(void)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hvf_arm_get_max_ipa_bit_size(void)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index e568dfb706a..2747f4b404c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -32,6 +32,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+arm_common_system_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.1


