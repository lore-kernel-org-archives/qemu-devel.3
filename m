Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981D5C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SVh-0008Oc-6h; Thu, 17 Apr 2025 12:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVc-0008Nu-RB
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVb-0003dC-3B
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso7578345e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908877; x=1745513677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wez4umbocj85ws3VgRVP4buafat+cNbKBCFumho8H2w=;
 b=JLyjSvIUzOCFqVCpN8Cu/Id2DFhkXqjF7Z9uXwKZEnDplzMDChjD4cHf5/4TMeeL+B
 JuHpC9TOymNkwr9w3uUKJPbgP7di70g0tlNqwPFywaDDiAybkurLhM97/BFKKjGuKvV6
 ue6w1acRnuK7EpnCSZT0gR1XIIrgcSf0yqcjEV1OXbZ2SVbivFb4vfnAL/UYLBJa29l+
 QPs11tD+S6qTnfBo7Mk9sc3l+s83Lzf281uwrMxucuYcujTQ0fqTuBLUxXrGAc6fS0R2
 L8Mc0yOiYhTQ/6FPScjcw58VtPLdOSa9JOCIEAz2kismFspGHj5Kt2jFsH9osE0YB4J/
 ktoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908877; x=1745513677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wez4umbocj85ws3VgRVP4buafat+cNbKBCFumho8H2w=;
 b=BOKhhxDC2UbtZBCzE379thgHs0qKS0OJKb852vikdtIoM1hV/cBjoT30gKlXXf34O4
 F3ei4WmFqGoeqpaa9CziY6m6qsXTCgvEVzsOaR2PTuK9wR3sYN9oYHFO56Nd8Q+ynnox
 9bRIpnDdV1aAvf8n6cQya4JoKmzNffN3JK7Y+OWIWcPnr5TZ2inu9T7cH+qw4cQEs5dQ
 sdtKEZ6kFYgu4et9UbfbmZKuAIf+J0QULqFYsNlLDzi8OlBRPxwTGc7eXbt42oOW+FjP
 9EXL1mECyt8jPFaV0ARo0xJIjRSO9JoY+FFNwIpPfoRUZdFE94Nqj3mq+spYuqz8LlpL
 qfbQ==
X-Gm-Message-State: AOJu0YwhX7P+LArSysmIFRuh8wTFi6/ZoegqcVFXg/avKRNi5UBQpK4W
 srlFpybziJx23I8zciQzyy0GAp1gAfL0n+HO5w1YDYOC+EB9Wn0HOpSXsbnd3TTTM2zAA/Tz6hb
 z
X-Gm-Gg: ASbGncvV0H9FHSKZgps9voEPis/aeT7S72UMEqkuNx5Yufa3x0+9LQdLpx0QF28Mppn
 M/+c68wCCf2Z8Xy7U9NF7+4iBPv0JErGFfDK0N2CuTlDu1qwcPRIKoQReIX2CCHAiJaAS9/YRoK
 ER1OUp52TjWkG6lQ8322ATgR+lNG5PqEeFnES0dzdxrcMRZXo0aHo3vjLqWY0fnUb0QEm7EauKw
 swKGMH2cuYwyf33U5uFu4QgdBNH3x9OXDG9BdbXA2S3/UXAsNocjTLxn2Q78LkT1qpuIeHB5ETw
 cIpIxzCCqLwNzA/IPUo6f8Oqgqq3iQ4Jw+tLSvPJAIYOQw/VAqiIDDF+msbigku7v38V7uCCxO2
 S13NpzmG4x65/owE=
X-Google-Smtp-Source: AGHT+IEqfu+0sWJDtPcXapmXKZXf2qJ5RoCTeoiTMfIjxq9bwB3mGv6bTsPStpPbdPpNoNVZG1jPOA==
X-Received: by 2002:a05:600c:4f90:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-44069971915mr4254335e9.12.1744908877252; 
 Thu, 17 Apr 2025 09:54:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3df8sm61241055e9.24.2025.04.17.09.54.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/7] qemu: Introduce target_cpu_type()
Date: Thu, 17 Apr 2025 18:54:24 +0200
Message-ID: <20250417165430.58213-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
---
 MAINTAINERS                |  2 ++
 meson.build                |  2 ++
 include/qemu/target_info.h | 19 +++++++++++++++++++
 target_info-defs.c         | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 include/qemu/target_info.h
 create mode 100644 target_info-defs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7083ab1d93..07ca088f7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -495,6 +495,7 @@ F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/target_long.h
 F: include/qemu/accel.h
+F: include/qemu/target_info.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
@@ -503,6 +504,7 @@ F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
 F: cpu-target.c
+F: target_info-defs.c
 F: system/cpus.c
 
 Apple Silicon HVF CPUs
diff --git a/meson.build b/meson.build
index bcb9d39a387..ad324d46428 100644
--- a/meson.build
+++ b/meson.build
@@ -3807,6 +3807,8 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+specific_ss.add(files('target_info-defs.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
new file mode 100644
index 00000000000..a53e632e735
--- /dev/null
+++ b/include/qemu/target_info.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU binary/target helpers
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
diff --git a/target_info-defs.c b/target_info-defs.c
new file mode 100644
index 00000000000..3ee89469855
--- /dev/null
+++ b/target_info-defs.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU binary/target helpers (target specific)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info.h"
+#include "cpu.h"
+
+const char *target_cpu_type(void)
+{
+    return CPU_RESOLVING_TYPE;
+}
-- 
2.47.1


