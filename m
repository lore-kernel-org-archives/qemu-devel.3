Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B8C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Kq-0007sJ-T8; Fri, 15 Mar 2024 09:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Ju-0006GH-Nz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:59 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jr-0007oa-Ee
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:58 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-568b8e0f94fso119577a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508194; x=1711112994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySG/dFK2HZQD+JLMFszQWRBPaJ0ef+Mlaqjr0ZCyRnE=;
 b=tuqz9HFZlx17dZBgoNJXeIqQekDWSLeSnWaxNzUh2kPjqhh2NI6iM0awgV3ecbynib
 Bem2/FOZH82gSms8U3TLKflZIPYjNZiEQIaMGhMjt5K/ZDZi/owwQC5ZUIdNO2eWTKNj
 ba3OU8Joeq7FlwAXszCr7CR0ReNDX+lqABOKd1RORKMAry7J06OHE+hG64GmQqZpMI5R
 VzpFQynQbfNZL/bquJl7/Xez0Yr+eJ4Qru9X1jII2f0vImtEmjY9eb1XCo5XOd9i9w+T
 lUaex0zTN7ZbT1BT2f7d6RUcHsdvLQOZFYt2kATeoccRlkTkajGZoqdCGLSh67JYQuDR
 ImDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508194; x=1711112994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySG/dFK2HZQD+JLMFszQWRBPaJ0ef+Mlaqjr0ZCyRnE=;
 b=TOjc3hXiiRrYNHfeJGebj0XzWGCqCe2HCxblcyfQiD4kvNpkC0GgTvLRLDrfa9QeYh
 xgEsK/QfYnbv3MhxLNvcsOR3xN5pslW0KtU7dGQAE+HoUtDNB66GS0Np41deCUaGSaqP
 FOcTKrrDNBnWh9mnCVzje6asIHxtNr0hI6LUhOiibMSJYS1JaCaPVtX1PD00GLdA3oYr
 8gZscSpV5odigkTzH+TSU1Qyrs06yv3D4+D9xRMMEVziCA9v7iwSu/omM0/WyNzmvS+U
 3pMaCIWYRCEPKQSZw0p2hFIYSV0YABoizjgyE7UfBD+xQVcAGxQIMMzzygW/9MuYDc4J
 3g0g==
X-Gm-Message-State: AOJu0YzAtANgifugijgfR/Gl4MeMoJNIGDTCAUaMbKj8umPlOGs5X0gb
 5lV72wp14faSkluGRxKEuH7w6QC6lurbvSfeM/IZ+4UItbMx2aaDgqh3i32n53kAZM5R/ta1e8b
 f
X-Google-Smtp-Source: AGHT+IExmkLmMqoSeV72lixftAHxYOtVn4ReIk8rzurrdOHIVhJgEKO7oZjURsJA9vDI1+WjYK1UFA==
X-Received: by 2002:a05:6402:c50:b0:568:93bb:d0c2 with SMTP id
 cs16-20020a0564020c5000b0056893bbd0c2mr4363087edb.20.1710508193742; 
 Fri, 15 Mar 2024 06:09:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 6-20020a0564021f4600b005682a0e915fsm1675523edz.76.2024.03.15.06.09.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH-for-9.1 06/21] target/i386: Make X86_CPU common to new
 I386_CPU / X86_64_CPU types
Date: Fri, 15 Mar 2024 14:08:54 +0100
Message-ID: <20240315130910.15750-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"target/foo/cpu-qom.h" can not use any target specific definitions.

Currently "target/i386/cpu-qom.h" defines TYPE_X86_CPU depending
on the i386/x86_64 build type. This doesn't scale in a heterogeneous
context where we need to access both types concurrently.

In order to do that, introduce the new I386_CPU / X86_64_CPU
types, both inheriting a common TYPE_X86_CPU base type.

Keep the current "base" and "max" CPU types as 32 or 64-bit,
depending on the binary built.

Adapt the cpu-plug-test, since the 'base' architecture is now
common to both 32/64-bit x86 targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu-qom.h       | 16 ++++++++++------
 target/i386/cpu.c           | 20 ++++++++++++++++++--
 tests/qtest/cpu-plug-test.c |  2 +-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index d4e216d000..de28d7ea20 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU x86 CPU
+ * QEMU x86 CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -22,14 +22,18 @@
 
 #include "hw/core/cpu.h"
 
-#ifdef TARGET_X86_64
-#define TYPE_X86_CPU "x86_64-cpu"
-#else
-#define TYPE_X86_CPU "i386-cpu"
-#endif
+#define TYPE_X86_CPU    "x86-cpu"
+#define TYPE_I386_CPU   "i386-cpu"
+#define TYPE_X86_64_CPU "x86_64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(X86CPU, X86CPUClass, X86_CPU)
 
+OBJECT_DECLARE_CPU_TYPE(I386CPU, X86CPUClass, I386_CPU)
+OBJECT_DECLARE_CPU_TYPE(X86_64CPU, X86CPUClass, X86_64_CPU)
+
+#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
+#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
+
 #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
 #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ebf555f50f..07f64c1ea5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8057,12 +8057,28 @@ static const TypeInfo x86_cpu_types[] = {
         .class_size     = sizeof(X86CPUClass),
         .class_init     = x86_cpu_common_class_init,
     }, {
-        .name           = X86_CPU_TYPE_NAME("base"),
+        .name           = TYPE_I386_CPU,
         .parent         = TYPE_X86_CPU,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_X86_64_CPU,
+        .parent         = TYPE_X86_CPU,
+        .abstract       = true,
+    }, {
+        .name           = X86_CPU_TYPE_NAME("base"),
+#ifdef TARGET_X86_64
+        .parent         = TYPE_X86_64_CPU,
+#else
+        .parent         = TYPE_I386_CPU,
+#endif
         .class_init     = x86_cpu_base_class_init,
     }, {
         .name           = X86_CPU_TYPE_NAME("max"),
-        .parent         = TYPE_X86_CPU,
+#ifdef TARGET_X86_64
+        .parent         = TYPE_X86_64_CPU,
+#else
+        .parent         = TYPE_I386_CPU,
+#endif
         .instance_init  = max_x86_cpu_initfn,
         .class_init     = max_x86_cpu_class_init,
     }
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 7f5dd5f85a..97316d131f 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -90,7 +90,7 @@ static void add_pc_test_case(const char *mname)
     data->machine = g_strdup(mname);
     data->cpu_model = "Haswell"; /* 1.3+ theoretically */
     data->device_model = g_strdup_printf("%s-%s-cpu", data->cpu_model,
-                                         qtest_get_arch());
+                                         qtest_get_base_arch());
     data->sockets = 1;
     data->cores = 3;
     data->threads = 2;
-- 
2.41.0


