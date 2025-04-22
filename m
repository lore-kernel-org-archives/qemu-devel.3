Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D214C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F2K-0006uD-2l; Tue, 22 Apr 2025 10:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2H-0006tw-Hq
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2F-0005D4-K8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so37767155e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333742; x=1745938542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22LQQOm056H4PYfBCVwoRoEL66DvS4+UOozPRWo0Okc=;
 b=qO48SXY0hMw8+IMqHzmEdwDc6nuEsd3IaO5nSi3sibh+eX7HfU1IDMsZcze5a3lrFv
 rVKL1zgaQ96U7q1qTu8o18/KnfI6xqPu+pzblc2qv1epA2P9yijRbgrdxuKZrc5296N4
 +CrgxobIiUzgDDcZ0A0S6X4dNcNcsc8n/G9pNi4+AhHyCaxruHTEkvU2A0LcCFONdMBv
 Kp+8LwaR+Izz8Pay9qq5Rs6xuc9IA1WT8+MKTcMoNAny+P+Jv3pEASJjZeQ+ErpGzH1L
 nA0YBctYfVPOAAum9pFQdcMacFvgYXwjpf33tVWaotkb0oQxWWmEyYnnj0QyqqqItDB7
 q/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333742; x=1745938542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22LQQOm056H4PYfBCVwoRoEL66DvS4+UOozPRWo0Okc=;
 b=bj9zZqenTgXTvtfivp8KIzSTsqyR71ILT8vObtGbGkX6+j0blbaZbxmJjKSUvkUBuC
 x/SQhA6Ow0iGcUzCxroK7LwjI1QI3XSsGlnTLj/pbHS3Bx1uMKw852bwlDDc1s8r4CeX
 80UTEl2j/OAWRbqxfBWjjCHifjj6Xz2BwBoI/S3DHiFxF2pgzJ6+vkbGf5M+E5Ju5v29
 BL6Yviv+xtxHF0keSgeX24PSlYXfaAaAeQw8g/zgLwLDPfisXK0F6UGXhN97uNI/4lwo
 oe3B3eGhVKI06I3KPX3BpYS5EoQuuXyb00OJzkZtf79oI5R3g2UkoSIO3Npa5sDA6VZR
 pczg==
X-Gm-Message-State: AOJu0YxOc34s7QXn6mrhowl3xawpXdTMKzwphT8ehgFUPpxQjB4tBtSX
 +1dMhejlEY1t5CD1tzUK7oOkqQdrp08fotpLFBDUfKp9YiqDFJBeXLpQuB68Zpa1ys3nw7K6ZfU
 6
X-Gm-Gg: ASbGncul6rijdGJMHwLb9ihIkDaO+Hq27vG5e5K1ip35e1LzqskdAChF23vBr1qUW4e
 H50gObvCF7rgxsJXdpLcCCTX0Io6UDdgmBQx3+2GRKP9sAfVh58tTWB/Dj3e4xMYHtHV38TER5e
 YRq3xJ9bboY7mm7Wmm057wjfIDBieetWfp2RUsOHIPYohqBFBLhMKqMlPsOgs9/2OcyL3yFgnSp
 P5jG+DN/X2+86E/J7ZLYvE+uQSArvhs+KBXMrhK5Xzgcw9DG+tVRapwrRRi3bfr7jBNQa63/7pp
 XbU1BIIP/wS61PKw1y687wNdJN5TwZi/MR54vYH4ZpxWE/EgbvlRjc+qUw4LzulyHcK15xK+rL0
 n1QD/nC2vGMpENjY=
X-Google-Smtp-Source: AGHT+IHrdIczPTqK1dMyQCv5FcD6/sDUdXdOKcTPHdg1x7xZAJMbj87lj5D1eWodk2rS3V87Bkwi4Q==
X-Received: by 2002:a05:600c:b8b:b0:440:66a4:8d1a with SMTP id
 5b1f17b1804b1-4406ab671d0mr134634935e9.7.1745333741722; 
 Tue, 22 Apr 2025 07:55:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d6db131sm176255965e9.28.2025.04.22.07.55.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 08/19] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Date: Tue, 22 Apr 2025 16:54:50 +0200
Message-ID: <20250422145502.70770-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 MAINTAINERS                       |  1 +
 configs/targets/aarch64-softmmu.c | 22 ++++++++++++++++++++++
 configs/targets/arm-softmmu.c     | 22 ++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a055f67b5fc..4edd1ba696a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1919,6 +1919,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
+F: configs/targets/*.c
 
 Xtensa Machines
 ---------------
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
-- 
2.47.1


