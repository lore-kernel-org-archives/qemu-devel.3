Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B80C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3s-0003tt-7a; Fri, 25 Apr 2025 11:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3L-0002wN-7K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3J-0004JH-5V
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so2397225f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595199; x=1746199999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fRMkD1jN0vYS+nWz550ADZSuDTJFtt+Q3jzZlSl7HM=;
 b=AYWHyyarFwWfxeyfm2G1if8+08WcxcwaHRKFwpF8nAEPcD0PRqW9PSCiNHErLdlasn
 dqTqO6BEQiIdWCo6ZvAownqCdIhWJr/ulvujHWCg9PTAxfk7sCiCa02Y/Qug2ZG7WtkA
 WUqmOJcuxhugtb11vSqJVvCNrI/c+jhuqLV1A/anaEc/KZ3O2vHITZkCh8e5vRhA+Dfp
 GalpChTBxVIh1lQ7ikA2aiYcUjuBpuWscc8Q5jYXBw22uggZQVBfn4S+XfBDPbrZW4Jr
 yKjVDl674J63zQzNfTBdRfQGvUpZK/GmrYDL+3cghRXn70oL47EwrXTaOdo6A0YpPMYo
 Y4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595199; x=1746199999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fRMkD1jN0vYS+nWz550ADZSuDTJFtt+Q3jzZlSl7HM=;
 b=FWhEig/cXxbh+0aWHdCC0W3fCOe/MHv2GWJi4I1D7rqLLFrMF/nwQy82mUyeEmGE+W
 ogByDNQeSI72Or02v/c/QTmYjN9wV8/1+FEnYdFNtoxuxUhIMRTAgKZhYW8RKxoT7f9x
 UJlwEXMc+3atJxyGaQvyOvl5ElrhlHrqA5SUMAY7SxeYa88HYi/s4E1kd2whxGjIUZvZ
 y9cyLmyS+0b0A1yqlApcSWnhTEo9uH75NdC+34bsQ/3vOW9lsfxl9cv8W/Geef6LmBvx
 RrHr1tdNK1jwdx2vNZIXHx4F36voZgG8F3SAn89d51O2sVNfKFfDKPakBwT0WTr5bDE2
 a9JA==
X-Gm-Message-State: AOJu0Yz5nL8JGXF4eAfRCKHrxUNdyjZJ2czIkhGNxkSXNPxIXDYgxD34
 Kr+ynVFBG+ONYTrlOIorf7cex6KchyaWu1EVB39ZATstpyHYMaOGRtmI9OG7OQlEO+PXTGBjH1d
 T
X-Gm-Gg: ASbGncsE+x8lJB1cFvHbUZmiKubQ4XrusKoDj99CV8xoSuEN5HxklK03QLI+CpJcDqe
 Vjwtf/PUT6mqg2DnIPkK0mD89F888bLExkD0MfYJZM/+5EwBALCRPlNXJXrqv4eZZabBNg5RKIU
 Sq15qIa04EWE4896W4tIuIYO3FGMQUs6KvmgMANuy2FLNtkMFZlPqypnSvSd5T8JNldQa/fKEMi
 574jteiiJQQUfIrnf3m9r8A0po2hmqheHnY4ztTmIuWMmaNtncln7uQwVvvph6KrLvP4l/ZnzQc
 NlzjK36Ecu4Z0ojQY+pxIgLwKZSIfBGWoLxu/Mtl/KtmpJKMmZrD2Gq1o9XUme8G/gNicx8Mk2R
 sXR1iqN3uH0Y9TDU=
X-Google-Smtp-Source: AGHT+IHAG+4qshCBLY5vy2/J9fOHZOTUiCoxG54arP2mHU7w0XsdfDrK8v+ZNnvCOiBLxtg+ZLPUTw==
X-Received: by 2002:a5d:64aa:0:b0:394:ef93:9afc with SMTP id
 ffacd0b85a97d-3a074e2e9a8mr2392935f8f.18.1745595199084; 
 Fri, 25 Apr 2025 08:33:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a52f8800sm28682025e9.3.2025.04.25.08.33.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 56/58] accel: Make AccelCPUClass structure target-agnostic
Date: Fri, 25 Apr 2025 17:28:40 +0200
Message-ID: <20250425152843.69638-57-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Move the target-agnostic parts of "accel/accel-cpu-target.h"
to "accel/accel-cpu.h".

Doing so we need to include missing "hw/core/cpu.h" header
in "accel/accel-cpu.h" otherwise we get:

  include/accel/accel-cpu-target.h:39:28: error: unknown type name 'CPUClass'
     39 |     void (*cpu_class_init)(CPUClass *cc);
        |                            ^

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250417165430.58213-7-philmd@linaro.org>
---
 MAINTAINERS                      |  2 +-
 include/accel/accel-cpu-target.h | 12 +-----------
 include/accel/accel-cpu.h        | 23 +++++++++++++++++++++++
 accel/accel-target.c             |  1 -
 4 files changed, 25 insertions(+), 13 deletions(-)
 create mode 100644 include/accel/accel-cpu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 07711cfd381..59d97128199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -499,7 +499,7 @@ F: include/qemu/accel.h
 F: include/qemu/target-info*.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
-F: include/accel/accel-cpu-target.h
+F: include/accel/accel-cpu*.h
 F: accel/accel-*.?
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 37dde7fae3e..6feb344e29b 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -21,21 +21,11 @@
  */
 
 #include "qom/object.h"
+#include "accel/accel-cpu.h"
 #include "cpu.h"
 
 #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
 #define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
-typedef struct AccelCPUClass AccelCPUClass;
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
-typedef struct AccelCPUClass {
-    /*< private >*/
-    ObjectClass parent_class;
-    /*< public >*/
-
-    void (*cpu_class_init)(CPUClass *cc);
-    void (*cpu_instance_init)(CPUState *cpu);
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
-} AccelCPUClass;
-
 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
new file mode 100644
index 00000000000..9e7eede7c3c
--- /dev/null
+++ b/include/accel/accel-cpu.h
@@ -0,0 +1,23 @@
+/*
+ * Accelerator interface, specializes CPUClass
+ *
+ * Copyright 2021 SUSE LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_CPU_H
+#define ACCEL_CPU_H
+
+#include "qom/object.h"
+#include "hw/core/cpu.h"
+
+typedef struct AccelCPUClass {
+    ObjectClass parent_class;
+
+    void (*cpu_class_init)(CPUClass *cc);
+    void (*cpu_instance_init)(CPUState *cpu);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+} AccelCPUClass;
+
+#endif /* ACCEL_CPU_H */
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 7f3bbf31a8b..82a29e61476 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -27,7 +27,6 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 
-#include "cpu.h"
 #include "accel/accel-cpu-target.h"
 #include "accel-internal.h"
 
-- 
2.47.1


