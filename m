Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F184C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGVC-0002LG-Ot; Tue, 08 Jul 2025 18:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFs-0000fE-Jt
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGFp-0003JS-LO
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso34453145e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011612; x=1752616412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulkx3Q5KroTiu66enU0LDbqVfAkkR9CFQ9rrQaIZwyo=;
 b=YXUFZUu4eXxSK9LTaUhjcuu+zooO9X12Z/TUDK4IDR5EmuYL+PPACDDhOSnkxovAsb
 7mjcZODQDjlMuX1CJcMS9QPSznB7K9YjlwqsMP0WyJ0nP5yLgzMwVpGr5t8RocfR+kCf
 nlsNAfmGr/BErm5SmfXcEXmO61zPuj0fOGOZXB29z5g15a9X7Ip7x5ru/W5v4QCLbAHv
 85DiF/Ial/gEGs8iQf/GKYhzX+vMxGBUXd6X8y9Xu5s3yA3kTq+gtpTj3tHK4/6fV02w
 zK3qC/hVVLRzAiquB2uUHWDurDSx9SudGdFE1NWrw5eJSCavd2WFDjOHpRD/taAfkjzq
 ciTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011612; x=1752616412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulkx3Q5KroTiu66enU0LDbqVfAkkR9CFQ9rrQaIZwyo=;
 b=YUQkKesfGAPnUyWe5v/x7ch3klWMQ0s/C8NgLb4N6rA22+hImTnBbMrzxEp1Dy4uDW
 w3+fSDn7I3ySu5CavhWgvCwQ6bNih3mb3IhJ9M5u0qoOYGgY20twcOUD0oUMZlVx2vHL
 +MZj136032OWe10mtZEVKr4Mp7vqXOJO77q5AS6KagYPArg95exD1WM8fhI/3KLJ5ARH
 DUdXAzMcgf5hcPdRhxklzP9cMVWdN1+yNR/HXEdMQbD0Cz7Del4BEZWvVQzb713xULHA
 WL/P8lecKD0iG6xAQ/0d1paUDjpaAgx23fyKfQk2DAzPW6EqeushksZk7dViiVDqZ5yk
 v4TA==
X-Gm-Message-State: AOJu0YwG/lXCHJHXUVqKaSQaWAK5WVkZtoxE5KaTbayNjWRoipdZSNf7
 BqPmoZ6VkH5F5Ri5OyZYh+oBUsEPAyGb+PTdftZTZqxMGmk9xwfS1Fx+VO9E/RyEhpOOKSoTWZ/
 uRZNs
X-Gm-Gg: ASbGncvd4DPc/TIjE1mr05JivQzY4OZPnrukGXbRVexifhQ5I0DcyQXJ63PmJJ0FSkm
 OgNbmI9Ag4YCrRMz7hemAnEoaOfwFzNBMd5jDYE6uGhO7wmMlIQTFuyfvdCQ1dh4GFnxVrVfKAw
 DY9JeNAZR65FpeVOtQOevCuVNFvbEl/kcoxUqaUW5iCOSQDS6Skb5Nm9COtErT+5ObWhExHFNSu
 mH9DGEenjae3VhMA2g3rv2Vt1IYH5re6DreLOIVFvB02YCWMyWp4260Jq8TrdAo+ePTOeLHjKAc
 2j2TXUtRpvFRPKa5yhazsWXXySlwdPRlmCLyIIpii1i08kYJ/rqx9otYE5Ye1n74oX7GLJ4hX+r
 0bttGD/lGmlFAXumyMBI7c7WE1JFn0ARX/Jscl4wH9w==
X-Google-Smtp-Source: AGHT+IH8OH7XAiQSqNzM/QS/p5Dh4S9WqsdBq0wqNadTp3JEBu2Z/Zy2qBF4g9jMlLss+j+3c8l1Jg==
X-Received: by 2002:a05:600c:8b57:b0:450:cfcb:5c9b with SMTP id
 5b1f17b1804b1-454d52f4e4fmr26845e9.1.1752011611852; 
 Tue, 08 Jul 2025 14:53:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c9f9sm14231973f8f.93.2025.07.08.14.53.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:53:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-10.1 RESEND v8 2/8] qemu/target-info: Factor target_arch()
 out
Date: Tue,  8 Jul 2025 23:53:13 +0200
Message-ID: <20250708215320.70426-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708215320.70426-1-philmd@linaro.org>
References: <20250708215320.70426-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To keep "qemu/target-info.h" self-contained to native
types, declare target_arch() -- which returns a QAPI
type -- in "qemu/target-info-qapi.h".

No logical change.

Keeping native types in "qemu/target-info.h" is necessary
to keep building tests such tests/tcg/plugins/mem.c, as
per the comment added in commit ecbcc9ead2f ("tests/tcg:
add a system test to check memory instrumentation"):

/*
 * plugins should not include anything from QEMU aside from the
 * API header. However as this is a test plugin to exercise the
 * internals of QEMU and we want to avoid needless code duplication we
 * do so here. bswap.h is pretty self-contained although it needs a
 * few things provided by compiler.h.
 */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
 include/qemu/target-info.h      |  2 +-
 hw/core/machine-qmp-cmds.c      |  8 +++-----
 target-info.c                   |  8 ++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 include/qemu/target-info-qapi.h

diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
new file mode 100644
index 00000000000..a337c867bfb
--- /dev/null
+++ b/include/qemu/target-info-qapi.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU target info API (returning QAPI types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_EXTRA_H
+#define QEMU_TARGET_INFO_EXTRA_H
+
+#include "qapi/qapi-types-machine.h"
+
+/**
+ * target_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
+ */
+SysEmuTarget target_arch(void);
+
+#endif
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 850a2958b9c..dde0e7d968a 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -1,5 +1,5 @@
 /*
- * QEMU target info API
+ * QEMU target info API (returning native types)
  *
  *  Copyright (c) Linaro
  *
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d82043e1c68..cd98daedd18 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
-#include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
@@ -37,8 +37,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, target_name(),
-                                          -1, &error_abort);
+    SysEmuTarget target = target_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
@@ -139,8 +138,7 @@ QemuTargetInfo *qmp_query_target(Error **errp)
 {
     QemuTargetInfo *info = g_malloc0(sizeof(*info));
 
-    info->arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
-                                 &error_abort);
+    info->arch = target_arch();
 
     return info;
 }
diff --git a/target-info.c b/target-info.c
index 16fdca7aaaf..9ebabec988f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -8,7 +8,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
+#include "qapi/error.h"
 
 const char *target_name(void)
 {
@@ -20,6 +22,12 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
+SysEmuTarget target_arch(void)
+{
+    return qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                           &error_abort);
+}
+
 const char *target_cpu_type(void)
 {
     return target_info()->cpu_type;
-- 
2.49.0


