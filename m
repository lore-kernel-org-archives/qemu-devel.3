Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F7CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F24-0006of-FX; Tue, 22 Apr 2025 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F20-0006oH-8Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1y-0005Bd-Ev
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso49743965e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333723; x=1745938523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZe+aJwBDegj3PLTEtUrkIMyeX/avzFZQ0Hl5Euk3tc=;
 b=lnQOa+veaejbCIedbwbN8AjknXSVRM6dbGjxlFlb3Ii86YyQjuWmMtFn3TlVvOMRHf
 oreq1EyauV3tq9jul3EXwZHlScXQRQOYdwshDG2H9xd+X2PbA/wHlySfnPwrfWmu0tKO
 yTkwJrqsivqnKLdrGZydrpjrGdSUAQRPaHbXaCR6XbrOsKNOqrrBz5gH9L8GQDoTUN8w
 4IGZ5z8FziM7juwxWPAbhWmyNWf9FW7Lus8Nb7vHcuxoffAlKHc2TGMurJ+fWmq4+ozG
 IiTrSS9C5+ZHuJKc+xzbNONJwPiIQ9wmYMcNI6pyjxtZnPsM7qNpUzMKKJ6hyKFDouya
 EGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333723; x=1745938523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZe+aJwBDegj3PLTEtUrkIMyeX/avzFZQ0Hl5Euk3tc=;
 b=H/MqHp1mgJiSvGgnINLT/eEDCk54/xu4fpBD47+y1747bpJfpI+fyZ8/8MYZ6Qc+IX
 BuugscEwD0Xo4d5HxcNC0Zd5iOoOcJpWxeYCWUvEjqPttYKceh7pAmC4ZaKe5ss4wjW7
 DToAy5qSFFtXxJerM/uHM/OvdaubscNSCvdxEzsMmVAjEUqm0txi4cGEQcXh1Ly/aTvK
 8U90wKmyAS3rpzKz9te62MFqlWGAlVOZ5wQXK26HnIcy+JCJrX4FPDcooxEwWB0sT4sz
 T7+Iw8HE4Z986CceRzGsw4QbT7dq7kF9mf5V6Yu3uJip0ka0S8V/WibcScl8NDxSlWU5
 gG5Q==
X-Gm-Message-State: AOJu0Yyhw32c+T17MEzfH9B6b2g6QTyARm+93OkScriPEzUv/MMfbr3P
 WylakEDBCeoX/Xm2LqZJy5HcZ/R37wmoK6f4v0IufL4GEPbb7QYxTHXM36vIyUIfElhC64IS5zG
 d
X-Gm-Gg: ASbGncvrMCUpKNNkBqHsEcEaNHdbskNV8maC4hdNrZ65d7aKFZ479IvQYsSO84oW3+O
 4SAvmksBlr4FnlElBT7B9TMREMBxIqwPwZJtK5LBNouEa39LvquCM7c2x278woVlOUJLYMcbBbZ
 41yYi8ynyUZ1knIOZBfut6KuSLoFEvtLvMrUqoXojumKl6R2U5ixbfMcwAfiAKnP+RagDNvzpyp
 Q+xdiuskeMTp+IjMSbBh7uKc+8AIVl6ZksUVACkCq0cEdr7QvvbgdVJkRjlq8Y6dwOn0D5Sys/P
 QjbDgqOhVeP8dZ+Xal6/15rnI2UnqX3puBVCeTNgjv5Z+H0t6ntjNSceewvp1hVxnlBTXWlwQqi
 Ej8Dtd4s0p3D39JE=
X-Google-Smtp-Source: AGHT+IEG7lyP+wO+c9tK9HnkLdKO4zC5TVPHS61a/xwvx3AA+Gf0Mt3t7yVI1nO+1to0jgITaYEZSg==
X-Received: by 2002:a5d:64cb:0:b0:39c:2665:2c13 with SMTP id
 ffacd0b85a97d-39efbb05caamr12349918f8f.54.1745333723001; 
 Tue, 22 Apr 2025 07:55:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ce6bsm15633259f8f.55.2025.04.22.07.55.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 04/19] hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE
 QOM interfaces
Date: Tue, 22 Apr 2025 16:54:46 +0200
Message-ID: <20250422145502.70770-5-philmd@linaro.org>
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

Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
QOM interface names to allow machines to implement them.

Register these interfaces in common code in target_info-qom.c used
by all binaries because QOM interfaces must be registered before
being checked (see next commit with the 'none' machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/arm/machines-qom.h | 18 ++++++++++++++++++
 target-info-qom.c             |  9 +++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/hw/arm/machines-qom.h

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
new file mode 100644
index 00000000000..a17225f5f92
--- /dev/null
+++ b/include/hw/arm/machines-qom.h
@@ -0,0 +1,18 @@
+/*
+ * QOM type definitions for ARM / Aarch64 machines
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_MACHINES_QOM_H
+#define HW_ARM_MACHINES_QOM_H
+
+#define TYPE_TARGET_ARM_MACHINE \
+        "target-info-arm-machine"
+
+#define TYPE_TARGET_AARCH64_MACHINE \
+        "target-info-aarch64-machine"
+
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index a6fd8f1d5a3..7fd58d24818 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -8,8 +8,17 @@
 
 #include "qemu/osdep.h"
 #include "qom/object.h"
+#include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_TARGET_ARM_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_AARCH64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
 };
 
 DEFINE_TYPES(target_info_types)
-- 
2.47.1


