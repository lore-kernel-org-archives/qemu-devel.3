Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB222C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXOD-0007Wc-Mi; Thu, 18 Apr 2024 15:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXO8-0007UA-CE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:40 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXO5-0007FO-FX
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:25:40 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516db2214e6so1664070e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468335; x=1714073135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a05kQu+3IE9JJfcYC8SvHu7OLyLA4nojU3zTAPx26K0=;
 b=F4hSO3e6Nq99Q23RPlrRgQSJyhcKyRF0hhqc8N3XLNvNLL49i9X4li5zlFd1ZPaPbq
 AG/8vS8omBz05xV2R2lRam/vuW7m7cMl3plwui0WURyi6Kh7aHHwDXWwDpeNgYkVKgrJ
 mZ8eRXr+kvjm2jntI3kIgbO0zRE9hFY3uWMi2b0TVKf7xiGA8xEF/jyRVACn1ib0w46P
 +gTKAJLnDgGjo/8yoIOhjiH4guI+fpRUYfNQG95iUfBx2+IY6+9ezUL7VgyyIIwtE+nb
 f2MTmlfOZpgwu9YwSg3uHcCWOoyj3jDkhfpOMlw2sQIzrCYmBb8kS01hojo/IX3ss71q
 +fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468335; x=1714073135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a05kQu+3IE9JJfcYC8SvHu7OLyLA4nojU3zTAPx26K0=;
 b=g2cfKcK/Ntn9XNMubPoBbfXUjvusgbkgORMmNwd5k3tW9MF7675pJQnPSpaVdacwMy
 Wqu1cJQrscmTB+4aAWsYGTK0s8873Y61DIE5vYM8UDY51LnU2e8MbEoT4HbRhj9R9DZQ
 GwL5t5PVsHlDoY0vdmxUbsBK4Qn6cIBR/dIcsO2bK7Gi9a+KuxOsZuK0TABX8ykaOYtM
 FNvHQM4cM7EdBnNpb5wQJ2q5jfzDx6YhBO+t3vVkA3OCql59ifHRjr5LrOlmVfgqZEL9
 E7T3cAaNbJr7Fd5JiSPWTq0mF7GF/Qz37kDXeBMuuvU4nxTvXUGp4NR9jyPDtppj9N6+
 RB8g==
X-Gm-Message-State: AOJu0YwfwKmYDhWDjiG7U8Mgj04vXRs2C9LW8x2MKkV90LEJPQpQEM7w
 bwiyzs56xJ8RnQ1rOOj50oGdtBeDZH1W/d9ebHP2S49OLOvoFPU023m/vNEpfLTdSIprkmEkwNw
 Y
X-Google-Smtp-Source: AGHT+IHfNUYllVyhV+QY71Ro4Kj4dJNcZ5I4DM2/UYYkrguyOxfOHqu9Q/5fh3sLLZjgbH1NDAnw6A==
X-Received: by 2002:a19:2d42:0:b0:519:67f6:cd93 with SMTP id
 t2-20020a192d42000000b0051967f6cd93mr2279810lft.49.1713468334923; 
 Thu, 18 Apr 2024 12:25:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a1709070b1100b00a558206b2c5sm77249ejl.99.2024.04.18.12.25.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:25:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 01/24] exec: Declare MMUAccessType type in 'mmu-access-type.h'
 header
Date: Thu, 18 Apr 2024 21:25:00 +0200
Message-ID: <20240418192525.97451-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

The MMUAccessType enum is declared in "hw/core/cpu.h".
"hw/core/cpu.h" contains declarations related to CPUState
and CPUClass. Some source files only require MMUAccessType
and don't need to pull in all CPU* declarations. In order
to simplify, create a new "exec/mmu-access-type.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h        |  1 +
 include/exec/exec-all.h        |  1 +
 include/exec/mmu-access-type.h | 18 ++++++++++++++++++
 include/hw/core/cpu.h          |  8 +-------
 4 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 include/exec/mmu-access-type.h

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 64e0319996..5b99666702 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -64,6 +64,7 @@
 
 #include "exec/memopidx.h"
 #include "exec/abi_ptr.h"
+#include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
 #include "cpu.h"
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index e932d364b6..5cddfea01b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -25,6 +25,7 @@
 #include "exec/abi_ptr.h"
 #include "exec/cpu_ldst.h"
 #endif
+#include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 #include "qemu/clang-tsa.h"
 
diff --git a/include/exec/mmu-access-type.h b/include/exec/mmu-access-type.h
new file mode 100644
index 0000000000..28bbb05b94
--- /dev/null
+++ b/include/exec/mmu-access-type.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU MMU Access type definitions
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef EXEC_MMU_ACCESS_TYPE_H
+#define EXEC_MMU_ACCESS_TYPE_H
+
+typedef enum MMUAccessType {
+    MMU_DATA_LOAD  = 0,
+    MMU_DATA_STORE = 1,
+    MMU_INST_FETCH = 2
+#define MMU_ACCESS_COUNT 3
+} MMUAccessType;
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 3a66d8581e..5f0422493b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -25,6 +25,7 @@
 #include "exec/hwaddr.h"
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
+#include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
@@ -80,13 +81,6 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
     typedef struct ArchCPU CpuInstanceType; \
     OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
 
-typedef enum MMUAccessType {
-    MMU_DATA_LOAD  = 0,
-    MMU_DATA_STORE = 1,
-    MMU_INST_FETCH = 2
-#define MMU_ACCESS_COUNT 3
-} MMUAccessType;
-
 typedef struct CPUWatchpoint CPUWatchpoint;
 
 /* see accel-cpu.h */
-- 
2.41.0


