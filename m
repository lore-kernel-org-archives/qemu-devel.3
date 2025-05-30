Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC7C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBf-00023d-Lm; Fri, 30 May 2025 08:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBb-000213-QH
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBY-0001pi-W5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso15402885e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609406; x=1749214206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hjPafosfBtpp6OfR6vWfKqeDiH1uNVyM2/xwKvCmH7s=;
 b=QuOdu0YcXrU22Dd/g8HJDX+cyKwqsRnuvkzC/AKdpfoWcb7W7dOUvcXENVnMCW+tZS
 FuIz27m/VwVFH6HDRLsQL1L8sQ4xJFe/e45GRexRWpla9mhvdHucVw+RDAH4H9xrSKi8
 CCKdXVkF+IbphnSDjYNM0zANePaAipo/Kba7fjVe6j0LthcYWwI+vT8YTWrmx/MfauM6
 Gmz+1ety+lf6u6UJrHcRFSsv7vBII0zJUUgtQvmvMzcsZHGPx45O928WjNRpnApFy1ue
 fd42KKZgg+Mh2kC0aWjb+LF5WRY+HTbJ2AGbAHwLSAP18mrO1Vcpev6IwFDOA4pTSQYZ
 bfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609406; x=1749214206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjPafosfBtpp6OfR6vWfKqeDiH1uNVyM2/xwKvCmH7s=;
 b=FHjhlZOWqiqXVJ2NT69oYCMt/Z8iaeRbU9e0J60A7ErEYYPaP+UNCRqNAtEmdNYDcC
 rNQsmdYjd2d7vtGKUhjSyx+eFuHMWNr8lOvMq0UWzDPog3yEi6C65Lxe4ePoDGDhn8RW
 hB+ST5Lv4Gn2IdpOs3N4PFzqsSQwU8uPzC57smLtkQus3MIzMDdYFHSJff1kSnOUkG5i
 dyO7qG0XLjUlqOqZn5GjxMbBdDyfwz655+zNqfXJszftyAN0EorLwDY/FRWedP8uKS32
 I3GlszjD4jy0itqVEnhUJhm7brctPMsVQnJ9pTYph8nRDJkF30xwP1hCfhxDEcboSjzn
 6dNQ==
X-Gm-Message-State: AOJu0Yyh6jR1vu1fB8sq4+UUWp5EiipYYj5YclBkv69tTnTv15P5VmE6
 qQYbDGLiVLSh5YPkPiT9P5b6YcS0MzIon9tCf+h5pCgSnd56ROpxOE3lLIqEm4LMBFkTxXtQjLV
 I92ZJ
X-Gm-Gg: ASbGncugbjUMqhYMgg1Nd3hmY0Ty9cfqpeYN0ClbtXrNXtDpVFGyGEZoU1R8N1sVgEy
 XQmaNFCJ5GQ71/HHPHyL09HKOs6H0/idlUVJrg/3Paer5p6S9yjZyW/YtD+Rg4Sil3rui1pv+KD
 km3SB8NQ9i6Kc7jvVCd0PC2QGSPw8elNnHg/fyXmDnpw6iWzlDOXVQeBNDTnFEzOgLirb31Qgcn
 Feq/bFgXxeOHNgV+/0mif425uMlFlMYIWi5a74Y2TiQcvpWTWPhEB279Ir//6Hz3OWWn6Bsu5wR
 mdprJxLCGChmtSr8l/JXD8Q8CUIwk6BHK45cdy62GijviYQ3DsP6eTKumKc5NrR4D6RP
X-Google-Smtp-Source: AGHT+IEWHRmr1dPZ+pfmMmxLNw5hfWHw1hLTJ0aK3sUww8aexTM6ERSD4/n5DeZUel30umgM9kUSjQ==
X-Received: by 2002:a05:600c:4fcb:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-450d658f66amr31883255e9.27.1748609405862; 
 Fri, 30 May 2025 05:50:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF
 definition
Date: Fri, 30 May 2025 13:49:43 +0100
Message-ID: <20250530124953.383687-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to allow non-target specific code to include
"hvf_arm.h", define the stubs in hvf-stub.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250513173928.77376-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS            |  1 +
 target/arm/hvf_arm.h   | 16 ----------------
 target/arm/hvf-stub.c  | 20 ++++++++++++++++++++
 target/arm/meson.build |  1 +
 4 files changed, 22 insertions(+), 16 deletions(-)
 create mode 100644 target/arm/hvf-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e68333623e..973254fae79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -510,6 +510,7 @@ Apple Silicon HVF CPUs
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
2.43.0


