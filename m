Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A078EC36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USC-0004Oe-NE; Thu, 03 Apr 2025 19:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USB-0004OP-6M
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0US9-0002Q3-IT
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso1073249f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724712; x=1744329512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geI/22Nys2tzXx8N0Oa1NtqG7J0932lhMqpg1NTfRdM=;
 b=eExupvnu41B1mrQg0nmDxQUhfO9x8jn90x/bYDl9FjInrLYzx8+hWx6pmHKQLCjh/G
 aaDBezGCH6/vb0+93RvR3iPIHH9DBjTrKI4fNuwwZEiZ0tBbXtbMH7vYFTeHJQpOe6dI
 7iHrnre58Jw3NbkVT8DgIaJUaNmUK5oo1LMHv4T3El8n2hxViGf1NDRrTXKrI79sKOcq
 aYatzLtTyetYAO/yQVSeoGVWjEubgUxZPdTrrF47bZqGJ8SPntsjqZT+HcV9xR6u+fiz
 SsDgW8+nsN/fgI+OscShjKzIH3Hj8f0iGHd6q4hApe+nQjpogYLeNNCo35OC4qPE8dXT
 SbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724712; x=1744329512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geI/22Nys2tzXx8N0Oa1NtqG7J0932lhMqpg1NTfRdM=;
 b=IEVFBMyRtHoBe7MWHzT38ertSrsdmv80F3Ltvppo2e+EVjWugXcQFJDor7ULG7tODq
 lvAss/g0TnMJAroqeX70LdQ4r15++qryhA1Ma7GODMhsnXu0svHpe75RGcTUk2C/U6jD
 9eEYm/86QbLxNegHzR6f5Edter8CJnBcm+0v6Mw6RMHBsQxjVn+oz3v8gY648PmO9KGo
 aK5d++KopAC/gt9FVP6/ubav5XYDhIVwmx3aJdKpp/sFU2icYaD8VER7fVySju/OIJNU
 uCsYeNpI7PYyqNze+svQAUsU50ufqRUuAASgfSG+nw73jVv9EG+Q9VBF7NJEKfrvKgbU
 mkBw==
X-Gm-Message-State: AOJu0YxvFFEAyDI8xYbt8X/A2mfmhy0dXjQ3okGYxK5oLsbvYF459N6i
 wUCLCIlbDtFEyXO4N2oNxIkRNW2FX4E1elrUHKpiara153wjlkJWGFxa9gu0Nn7CJL8zkwI40gQ
 d
X-Gm-Gg: ASbGnctl/xaU1bp8HMY1+7Km1SO23qqfwLgutGE0QMakyKJsKgo/d/yWJmwNE2kw0x3
 TlNn5jF6taBibTZ01JkjSfDpnFFIV0hGaGP69Bit/355VjlaXTAWaUARZ8XgRwbUOKFJsfF/aI6
 F25nUtjTDX7MNrCIQ61k8xubAyECSWuaENM42FY39v577vav+9cxQnjZpRKd5yRhaLLS/bcNeLr
 uYq2q6OjHVgYki9LkdW/U3k5TsajbW1Ltq4GLE4zQIiW6mcpbiyhrShE7o1OTjcJc2fWepyb9vc
 hzozO8O+OhYghW6YZRLxocnghs9R51jTJGJIWo5cJTrI+lojsgaoM/56mMbOGYqcHewwm7zQLeU
 jlyOWt09rBGZEkxXkWmg=
X-Google-Smtp-Source: AGHT+IGrX0bHIUfeU3zfouq8ynBbp0cwbk8yb3+si00wVTuly90CP9aQR5JxVqKC5mWstynH6uekXg==
X-Received: by 2002:a05:6000:290d:b0:391:3f64:ed00 with SMTP id
 ffacd0b85a97d-39cba9324b9mr873943f8f.26.1743724711683; 
 Thu, 03 Apr 2025 16:58:31 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020da49sm2905632f8f.80.2025.04.03.16.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 01/39] target/arm: Implement per-binary
 TargetInfo structures
Date: Fri,  4 Apr 2025 01:57:43 +0200
Message-ID: <20250403235821.9909-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                              |  1 +
 target/arm/target_info-aarch64-softmmu.c | 24 ++++++++++++++++++++++++
 target/arm/target_info-arm-softmmu.c     | 24 ++++++++++++++++++++++++
 target/arm/meson.build                   |  5 +++++
 4 files changed, 54 insertions(+)
 create mode 100644 target/arm/target_info-aarch64-softmmu.c
 create mode 100644 target/arm/target_info-arm-softmmu.c

diff --git a/meson.build b/meson.build
index b93253166c8..9df662932a4 100644
--- a/meson.build
+++ b/meson.build
@@ -3263,6 +3263,7 @@ host_kconfig = \
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
 target_info = [
+  'arm-softmmu', 'aarch64-softmmu',
 ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
diff --git a/target/arm/target_info-aarch64-softmmu.c b/target/arm/target_info-aarch64-softmmu.c
new file mode 100644
index 00000000000..002aac642f8
--- /dev/null
+++ b/target/arm/target_info-aarch64-softmmu.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "cpu-qom.h"
+
+static const BinaryTargetInfo target_info_aarch64_system = {
+    .name = "aarch64",
+    .system_arch = SYS_EMU_TARGET_AARCH64,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .long_bits = 64,
+    .cpu_resolving_type = TYPE_ARM_CPU,
+};
+
+const BinaryTargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
diff --git a/target/arm/target_info-arm-softmmu.c b/target/arm/target_info-arm-softmmu.c
new file mode 100644
index 00000000000..24b68b1ad8b
--- /dev/null
+++ b/target/arm/target_info-arm-softmmu.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "cpu-qom.h"
+
+static const BinaryTargetInfo target_info_arm_system = {
+    .name = "arm",
+    .system_arch = SYS_EMU_TARGET_ARM,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .long_bits = 32,
+    .cpu_resolving_type = TYPE_ARM_CPU,
+};
+
+const BinaryTargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..706c49c1b2a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -25,6 +25,11 @@ arm_system_ss.add(files(
   'machine.c',
   'ptw.c',
 ))
+arm_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'target_info-aarch64-softmmu.c',
+), if_false: files(
+  'target_info-arm-softmmu.c',
+))
 
 arm_user_ss = ss.source_set()
 
-- 
2.47.1


