Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25714C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDU-0003BG-RF; Tue, 01 Jul 2025 10:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDS-00038n-Hd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDQ-00078B-CZ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4530921461aso38188405e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381046; x=1751985846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZMQYrWloyNmvDDuKbJbuu4yfXxhqFOo1POIBU2tgl8=;
 b=GDUReQ0j6I1nDcW1dDZXMtIpxjn1I8sxxKwtZPIUvdjVe5UZesJ2nkyJOcRF/6rpME
 jp3vefSAj+wgSiG5HPLHFwOiXj9t9KNRpWFvhPL/koN8cFsfPREyl0rsvrGouRQ0dYiY
 6YtvqG8MqGNO+/FYLqZCDsVpLsq95/kSzHhPfinxz8qkfeNKbgZfAAEtHfLLThDfMHFi
 0zorQdAjLknO4ivMcNwm5OQ/TmYwq1L9eFiMY7SnGmuHQhySGIVTWRijE5y1qIbx1s4H
 L6zPxd5sH+SrYpQ5hPbLspoZzB/ZqeVqcD44J6axdj5a2xrOMoHY313WOjseQEKgBg0Y
 nh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381046; x=1751985846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZMQYrWloyNmvDDuKbJbuu4yfXxhqFOo1POIBU2tgl8=;
 b=WTwmz11ZVxMytgWXxCZ2FgQqHllJ+WZeahLAx4V+2gHdpxkI6YZNEvTXgaK4v1bmiL
 7A/SwBO2p/DTiWmc6TGSwa9SL/RnrcmDjafXh/geypOZFGMtRPoFzKOew4QNVHyqgCaP
 mgrVahUKfOdeGpVecPM976NZX2y+Hkk/kJfYHu80tB3ti6pmTFWkh7Mfr5sJZJTV/JeQ
 tOkg44KpJQhEL/lTM5bG184ZC75jP4kcrLU5ZT+imIkmyrj1i9tj/hjqT0OnXf0G5WMn
 ylNA25k1VkI57B90m5Sqwte+/liNpz1TTW0PoM7+C9EIKR5g1s5zr81ptMKuLWfe/cuf
 GetQ==
X-Gm-Message-State: AOJu0Yx1DWZdo12hjp95yLHBLdbIefu33hUcTXRN43zTBQ8KgL406Ocs
 ecWcye01EX1WY4HAgjrKk8ybmTUc8cGQbmQuFSmkHKuuEmMyLKZJ/uVfwz9RE73OXsAl5ajzscC
 rNkLh
X-Gm-Gg: ASbGncvdZx770RYacmEyv/PIqCSusJfIte0jVImE6mM4gVy1ILhRpCD4JzUXOlGGx0/
 2shtWrH7WDDUW3kT7Cm49JMrI5rfD+jizMBig+V44pqy7KyFpj9WSMCmD92eXg3F7ogqn60JxoD
 /DhugEHFDFEKgatp5qDSs9PxyRENMvId2oNmTycm2u+wJlCFK5v5kiR0gWzwleZI7etqc79CskB
 b/wA77wCj17bMsj3zdzfp1w1Y1GuAJRLgNmpctsdcZyBrpUAWnvKDTMrhWN9Q6tpRRLUGo/vOf/
 RcnGXkiDfzljPC7Teubenw4+SgFdiwchaIEm4rYfa9S8K460KlUes9QXzP7tnzSTN3tyq5JncTa
 gCI6qh01YsNO6oe4KNrR7b+LXLp7EyBDW4g8n
X-Google-Smtp-Source: AGHT+IEAE043y6B+qAmq1mstGLsycdlMzPC+RDCFiq1L4Pk9vUjoazV3ikfXZ1vHhUDP09hFDQJUfA==
X-Received: by 2002:a05:600c:4f46:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4549ff26757mr25937905e9.16.1751381045655; 
 Tue, 01 Jul 2025 07:44:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad20bsm198444415e9.20.2025.07.01.07.44.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 43/68] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Date: Tue,  1 Jul 2025 16:39:51 +0200
Message-ID: <20250701144017.43487-44-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

'dummy' helpers are specific to accelerator implementations,
no need to expose them via "system/cpus.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/dummy-cpus.h    | 14 ++++++++++++++
 include/system/cpus.h |  5 -----
 accel/dummy-cpus.c    |  1 +
 accel/qtest/qtest.c   |  1 +
 4 files changed, 16 insertions(+), 5 deletions(-)
 create mode 100644 accel/dummy-cpus.h

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
new file mode 100644
index 00000000000..d18dd0fdc51
--- /dev/null
+++ b/accel/dummy-cpus.h
@@ -0,0 +1,14 @@
+/*
+ * Dummy cpu thread code
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_DUMMY_CPUS_H
+#define ACCEL_DUMMY_CPUS_H
+
+void dummy_start_vcpu_thread(CPUState *cpu);
+
+#endif
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3226c765d01..69be6a77a75 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -7,11 +7,6 @@ void cpus_register_accel(const AccelOpsClass *i);
 /* return registers ops */
 const AccelOpsClass *cpus_get_accel(void);
 
-/* accel/dummy-cpus.c */
-
-/* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
-void dummy_start_vcpu_thread(CPUState *);
-
 /* interface available for cpus accelerator threads */
 
 /* For temporary buffers for forming a name */
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 867276144fa..03cfc0fa01e 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -17,6 +17,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static void *dummy_cpu_thread_fn(void *arg)
 {
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 8b109d4c03b..2606fe97b49 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static int64_t qtest_clock_counter;
 
-- 
2.49.0


