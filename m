Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17779C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3l-0003Sv-Gc; Fri, 25 Apr 2025 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L30-0002Gv-4P
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2x-0004Dh-SR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1851372f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595176; x=1746199976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUdfoAicTmAVMZSDJ0CeHB42H/1jrXgR0Zf2khN7jvw=;
 b=x6ZtimFddQgknVtSK7LxnkfCfr4A/oBiJ7n6KNbyEEKoj9Y/m1sQJONegkA2Log0X5
 ML2agV0MiU+A7cuetBop5l0bElvk1h+NpZVlYX2w526z+oVGqYP7rAPV9HSb6YPg/2E/
 1wkRrH0Ph8HRJnmqeTWiYtPBm/xHUcvEscBrJSLBFdaKAq3tVc37n6PeXkDJGdnGvZTZ
 k4n7/AxqZKQv5yLZ3lPknEkzMjrsfMUBZ9Gbq9OGnxzLXBV+UVFMhw9xWLLk1b3jv83Q
 6Ca4lXJXx9dt9MJCV7VEK9qbS5/E7BtYtrivaRfjHgvUfq4alr/4zEMUaI4cdIjccEQC
 +QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595176; x=1746199976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUdfoAicTmAVMZSDJ0CeHB42H/1jrXgR0Zf2khN7jvw=;
 b=XRD5xJH1Ot97u18UirjwHz1rhwX9ZmD5F0p9cxvrdCukDyBTmO+oHEF44i//P9Hf+Q
 zHonuUXdCYFBKHLHi9M7FbYv7RFWsB3CArkNKR2TSuhcevgEQhXu7ok8zG7Amh2ZAaYY
 vIOAuD92mzhBCmVAY/EI4G8BK32xTMwFNH1dK4VaE2w4lrMqCCm7xiFujVtu2pADW3sc
 tRT8nUA0jeaX0sfW3S6NoVkawtphz3wUlIWnsd+O/MRFrFfj5aCDfNiyg/rhTPtjY2O5
 8s7JQGH42pgEq5K8SPGXFr7PI4sGFGBFuEc50JjT744VGjj7HRPi3bSubdYYitcUF0sr
 gG/g==
X-Gm-Message-State: AOJu0YzNtzR0odjAn2rRrmOjLh7V+8JAoCfyqmDP+G6jb2acg9zB9qgF
 Ibr598dcfnbLmoPzDn2HhD1B7m2Tng9ETpmHOYj79R8yqQ/OhWuFowOTscQtGBWoTrYsg73S4Jn
 G
X-Gm-Gg: ASbGncvqxlWWg+MkSvated02R4wPRpNZRuCTZjwMhUy8B2+PIYe0Yw+UAWRIO7j653N
 TSULrWUOsPEX/LyE0xjDz62WPHqN6no2Ii6uv6fIRiBvu6zSSZGRO70UspKIj4iKnV7S3V4eBDb
 fu69qTdueh/KR3GWvV2PWS/jlRUzYUBKL4eTRvhV5ZPEHiWzvde6GiM8C89r9TxYgZSocBXUTUR
 FBStVHrTPFwnyDMynG7HLvd8XMK7Ofku3kZDBGX6O9x6gw5UHf61gaTGALAQy1/3Vn36zrmgr6d
 v3CZvoDBYYsErfxmesl8m2b7IiqcSZd0GnVVVyUkpMdmwt1M4rjgwhIy+d6kd0obUCZ1YgrmU4f
 4JZlLxuRvA4WnYDY=
X-Google-Smtp-Source: AGHT+IFLZ0yorphPVTOaMhju8600nJZ8wvnR8ncyK5T9gyEr+WzpnY7rrwkdSvRdQx1IZ45bQntRyQ==
X-Received: by 2002:a5d:5986:0:b0:391:1923:5a91 with SMTP id
 ffacd0b85a97d-3a074f7f5b7mr2553259f8f.55.1745595175789; 
 Fri, 25 Apr 2025 08:32:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e6daa0sm2599220f8f.101.2025.04.25.08.32.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 51/58] qemu: Introduce target_cpu_type()
Date: Fri, 25 Apr 2025 17:28:35 +0200
Message-ID: <20250425152843.69638-52-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Introduce the target_cpu_type() helper to access the
CPU_RESOLVING_TYPE target-specific definition from
target-agnostic code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250417165430.58213-2-philmd@linaro.org>
---
 MAINTAINERS                |  2 ++
 meson.build                |  2 ++
 include/qemu/target-info.h | 19 +++++++++++++++++++
 target-info-stub.c         | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 include/qemu/target-info.h
 create mode 100644 target-info-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d82d962f1a4..28b1e9ba443 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -496,6 +496,7 @@ F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/target_long.h
 F: include/qemu/accel.h
+F: include/qemu/target-info*.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
@@ -504,6 +505,7 @@ F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
 F: cpu-target.c
+F: target-info*.c
 F: system/cpus.c
 
 Apple Silicon HVF CPUs
diff --git a/meson.build b/meson.build
index c736a6f4c4b..185c2fb0d1b 100644
--- a/meson.build
+++ b/meson.build
@@ -3795,6 +3795,8 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+specific_ss.add(files('target-info-stub.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
new file mode 100644
index 00000000000..b4cc4888cac
--- /dev/null
+++ b/include/qemu/target-info.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU target info API
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_H
+#define QEMU_TARGET_INFO_H
+
+/**
+ * target_cpu_type:
+ *
+ * Returns: target CPU base QOM type name (i.e. TYPE_X86_CPU).
+ */
+const char *target_cpu_type(void);
+
+#endif
diff --git a/target-info-stub.c b/target-info-stub.c
new file mode 100644
index 00000000000..e5d2195e896
--- /dev/null
+++ b/target-info-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU target info stubs (target specific)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "cpu.h"
+
+const char *target_cpu_type(void)
+{
+    return CPU_RESOLVING_TYPE;
+}
-- 
2.47.1


