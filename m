Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE35AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKx-0002mU-QZ; Thu, 03 Apr 2025 19:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKs-0002NY-3e
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKq-0000oJ-DH
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso14216065e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724258; x=1744329058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tt83rZuXJ2P2CGUhlOB2w3nk8Oq8J5HbWrTGgOM9cNo=;
 b=zwr9tp/PaGONxw6Mgf2kGo51aSTxa9VqP56S9eNgpJzIN+ylBG2/HpFXbot/zTK+mw
 6XA/Cbs7S7Bfft4vu0C6HAVTTIfoJCL1jPebEdipsIr95Ic5ScjgiPjKl3jkuNd37miY
 uBKVyESGo1tImsWC8A40vC9QWpBh68sjHH2mlX63Utabe7m1bmZCYBd4MDJabvPQbrVZ
 p1a31TYw2PdEWwcD0Luey2NcIeH/9nd78VVn8P7MSBIZzS6g5OKqFNfLu6DsvdQ7zuVJ
 oWdPzHWICN9MQFBMLriAlorgOGHq3tpXweCmznEwDbpS5OoVBEjnA5fH6QpKDAzAGlrz
 Cbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724258; x=1744329058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tt83rZuXJ2P2CGUhlOB2w3nk8Oq8J5HbWrTGgOM9cNo=;
 b=eTAuPouwIb4V0KHsKc9XDdA2mC3+mvFhqdtcta6jmKMaN3avo5Ue5Hw2gFyoM78N5i
 MUaooMDfq3FYfmrvJO5W8br244T5MjFgHl8P4U0OrdaqdUKIqtQIZX+I70KmdbE5KTsZ
 JH1HmfjJzL4BJS4GmT5Vj3qbybx5bkKkiBivjcymBINytO92uPs2swz8RzWIhC0P4Q65
 WA7I0FcjO5ZrC4rV4E5x8vnUsRA0itxFVwT7Aore3myBaw6GHPvvko9FFt9RKkaPmuid
 NjHhnzynGqGPvt/d0K5btuNfTFj5QGwfGhgBKn06AyRTve/hPiF1yOr06q4DVVEjjdCs
 xQOw==
X-Gm-Message-State: AOJu0YwLIIPfpZvzqQauKcLZ/pHunLyqiIWumuQzUeRfYdx66Wy/IFie
 sZV6kaCVv5zJztLLSx0duvGJg45Mv9dVnmyPT7I+vQYZxIwfbj8ihOsRzZyKHGiy+XWo6yPKb9d
 K
X-Gm-Gg: ASbGncsztbuMNgNJYFuRH4HQMHtXd5ioPQXkNmF4ilEAyJYJPSFFnLjG00Joh46nzF5
 FjIaOaYji02lz9cJ8qxeGi5F/hlMgaMHP4Yab1cMUPUr0jqJqusKPgN9hq5PCgfiaaAajqNE48P
 M2Hxa4DdpPvtT/XAOOtFo3TE10Wvv8q2N39ZXdociE45iKU5OEtP66B8c3+CdPjmW60uLGAmuUC
 dB0Unjs0K0/OkNv/ssqMXxiG0jRozINWk/8keeQizsCjicQrPy4lFETUbDhEK0Y+KOR0WcnA2uJ
 J3XPT9LGOtbskNHozvSzg6wvL41AKNqEiKMzuceWVW2LcZ/QM4EZQ3ePS19QI/aZEkjeSLOHqhC
 GAiUONjg5KMeR4Yb+uBI=
X-Google-Smtp-Source: AGHT+IEeBTRAIwOV8EHnXBMSLabygT1G9AHFpz9wef62Ze7/gbASL9kWKhLYbuM3hQjk22xXEFayKQ==
X-Received: by 2002:a05:600c:4f0c:b0:43d:aed:f7de with SMTP id
 5b1f17b1804b1-43ed0d98ffbmr3255405e9.21.1743724258408; 
 Thu, 03 Apr 2025 16:50:58 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096889sm2927727f8f.2.2025.04.03.16.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 16/19] accel: Make AccelCPUClass structure
 target-agnostic
Date: Fri,  4 Apr 2025 01:49:11 +0200
Message-ID: <20250403234914.9154-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Include missing "hw/core/cpu.h" header in "accel/accel-cpu.h" to avoid:

include/accel/accel-cpu-target.h:39:28: error: unknown type name 'CPUClass'
   39 |     void (*cpu_class_init)(CPUClass *cc);
      |                            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 12 +-----------
 include/accel/accel-cpu.h        | 23 +++++++++++++++++++++++
 accel/accel-target.c             |  1 -
 3 files changed, 24 insertions(+), 12 deletions(-)
 create mode 100644 include/accel/accel-cpu.h

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
index 6fa5c3ef04e..769a90230bf 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -27,7 +27,6 @@
 #include "qemu/accel.h"
 #include "qemu/target_info.h"
 
-#include "cpu.h"
 #include "accel/accel-cpu-target.h"
 #include "accel-internal.h"
 
-- 
2.47.1


