Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F04C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xU-0004jl-Oj; Thu, 24 Apr 2025 18:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xT-0004jA-0u
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xP-0000zs-NJ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso17577505e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533328; x=1746138128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/LeVH0iEfwnigHnY2wTQENZ/qjw+iDaeRA3zB+Oyw4=;
 b=nj/Dy4YEys0QGeHPX/V8LhhnoVkyig+IGPxynFvmPrXnmBHHLQ+ukWylKEqEhuNM4T
 NIhddzJy/uIj5aYU8O2G8Ex2yFTT2C6WWQ/1uCRcqex6K3DlvSW4VeL1hTDYO1/g/+ZN
 SWI2jd2Z0NRAVo3imWyMegh80WvqUHquQ++6ZktRpf6DHt8YINAE4b43toM3NAhpG/D1
 S3n51xm/ViCuguRZ5arBeAgpWoWMDDoJxx20WK3fDV4N7qqhSshTbNhdUH0XXhUJSeKg
 hDU4022OvxZBL+QS8rq2p8Q+rM+b8kNYG2CU1KzAg9ay5qQz8I/SDJg8U1TGoopCnATa
 l1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533328; x=1746138128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/LeVH0iEfwnigHnY2wTQENZ/qjw+iDaeRA3zB+Oyw4=;
 b=OQU04Eh3wHppO4AbR8/0XPW1oAMnFz6nfidD8m4PB74ZxPQoRUjvog/mq1khrWG2TI
 eDDnkFUDqpAZ8IdSpJxy1l1DOFUXJPx+a29zHbLCEOEmiYe6oOZFGjBRXaqYsNz+daRE
 iV9ISS12GljOJ+8a/kC4Rb9jlm5cz73lYIE7fAG9ReMqf82YRj3fUgu2bjc7lSkj/eFY
 7IPZYngt6PjWSxb9quWfYV61UH9zmpUSbZpxnS/OTyQk3wfarmba4jx0N7iyHTixFv5a
 XxL5ZW7bSVgFvsgs12B5qzBtgga00fS4vu/cBWbTR0E2b1Xt5tpfndWJuUNuI6bYO9lg
 CXug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqCAREoBKbSCKDgsJ5FTqzeVVkZD1W+xz9UAvqUVGCxoo7eoa4RMkQt2iQpECJnhzf7ydfN1TZ8x5T@nongnu.org
X-Gm-Message-State: AOJu0YzbxZiQmlyeQruXAL/XdkCDdiGE/XdeWeWZQ6u6OEcczOkEI/9E
 JVHWXed0SBRaxCZAbHJuoEa9w73RMhuWYm+RbHE01NS2URJOKW1GoMGBQ1JQF0M=
X-Gm-Gg: ASbGncsbj+uRQwlEtOCq1J91sK2nz7XuShHTBVAFnZ5c6GfCNO4Ek9ypz0/jljZKEx5
 vWj4LaUgbf4wMDtom5eiJ7iUdxRIZ1/gFS5Z1Hhi8xiSn5XSU6Lbezd86Pkj6dzd3FE6u6f1kqZ
 9UeZgZmWFW1nPb2XogPKK124hY1k9vjbY65FW8a9dBDRNc11cP0yyB/HYcm5gj250rBGJ9KmSNs
 7YkNLWyFqZSUCMi2xwYdDYPOZ4NcMBF8JrTRRFaz+jisWd6wy73zM5BFVJgTQ8w+y0UOEiTH8D3
 HuJXqLYH/QXzOvXP9qH7msnI8/+dGQuP+XC0zPsN9RSpLvCqe3ok/rqonaN6rXHiib3BRWENLWk
 rYQcFvzDoEyTIx3o=
X-Google-Smtp-Source: AGHT+IGwsuZfuj0Y6WFeUk7U9GrMnQQgmZSl2PC6wJQ/mMNqz+sNTipZeL+ddgguKH7qBcFYWmkA7w==
X-Received: by 2002:a05:600c:3594:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-440a31137e9mr10104125e9.18.1745533328384; 
 Thu, 24 Apr 2025 15:22:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c7a4sm538641f8f.14.2025.04.24.15.22.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 11/21] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Date: Fri, 25 Apr 2025 00:21:02 +0200
Message-ID: <20250424222112.36194-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
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

Implement the TargetInfo structure for qemu-system-arm
and qemu-system-aarch64 binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-softmmu.c | 22 ++++++++++++++++++++++
 configs/targets/arm-softmmu.c     | 22 ++++++++++++++++++++++
 configs/targets/meson.build       |  1 +
 3 files changed, 45 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
new file mode 100644
index 00000000000..375e6fa0b7b
--- /dev/null
+++ b/configs/targets/aarch64-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-aarch64)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_aarch64_system = {
+    .target_name = "aarch64",
+    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
new file mode 100644
index 00000000000..d4acdae64f3
--- /dev/null
+++ b/configs/targets/arm-softmmu.c
@@ -0,0 +1,22 @@
+/*
+ * QEMU binary/target API (qemu-system-arm)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_arm_system = {
+    .target_name = "arm",
+    .machine_typename = TYPE_TARGET_ARM_MACHINE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
index a9f6b24ec01..cca2514eb51 100644
--- a/configs/targets/meson.build
+++ b/configs/targets/meson.build
@@ -1,4 +1,5 @@
 foreach target : [
+      'arm-softmmu', 'aarch64-softmmu',
   ]
   config_target_info += {target : files(target + '.c')}
 endforeach
-- 
2.47.1


