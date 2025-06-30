Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FAAC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEHN-0006IZ-IN; Mon, 30 Jun 2025 09:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEH4-00065Z-61
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGx-0004FN-2z
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso2327252f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751289007; x=1751893807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RlmNXlhYATHcqGzuUYY9u+iNysqBplPIi1ujnVq9xc=;
 b=rFPAhExG6Lq+jI7pp9/BK7HqI8b39dlaB7HbD+yOi0RyU3SBnPFBzwHNrvO/jH7chX
 Tkh9QMNRcxDNL/YKQWTIcv81in0Hoyhw3VNYIcohwPPMk1YOpFv+fHZWLyXOWb9ZUshw
 jBzTMI59hfktlXlmxRzIIkwIaZp9kLf1v8MTHO5BORKZ3n4G8/+hCUjLaNmwFYOz574Z
 x/8168+S9ibGRyJlKlgM6j65gnfwSjGZP6iORq0Q6q8SJZiXHuDyWgkzbAOWWJJ9+m0j
 L//kUfVFhH53tL2acO30/3keBDZmvErSwUx2nYPO1WzXemFABiFolf+EVWFEOBJgHqBT
 UbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289007; x=1751893807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RlmNXlhYATHcqGzuUYY9u+iNysqBplPIi1ujnVq9xc=;
 b=Geyk6R8Z18Nl5tzj8uP/7YpsLtnv0EL7VTGCDJ8TT9eXhZ8Qota0E47d7UAmXMT39a
 J/yPgB42ShWtCKT+nsPPwr0PxG6uiSQQsuP2/TytjP/aucs5OXLPqAgthWyHXlx1KBw8
 Bma/8/bn9XQIPOOQnkkIripzL7OcfB+hmervKBSS1A1l4h02xzPKL938jb6YOdCy4Vb1
 YPreXckBNnczxxv31NgKXDOvnbWGdZa8u6fsqJolZ+MikDbtOuJcDTmlLGIP5ggGzuSP
 2bTq04BG9dsQ7JMveogn2e4oA+rQ23d/fiTbv/cp4qLNWsyQrgJvoybG+NRk7aT5v5tf
 tX2g==
X-Gm-Message-State: AOJu0Yw6zoCTKM+mbK6ntNiBEPCXaASMdu5Tsk9PhcQs+jmP+vwf+v6U
 6HVPxjrPBSi1siRx4nLbEwpq1Mkl5agLu3KlaJPUzZUn7jbE9G4N2ziiHF//4llhuPw7VgIteX2
 TPFX2
X-Gm-Gg: ASbGncsqoyvKDweGsMbLH+61PWZpPF6mGnBDjMOCneOnsxV0gtkT+ekSiXvINTGyRbp
 w+3vxR0UJA6nfBsN60PExrL+lgXv9MafRUctkWJULXkZAWP5RRjxLgqOxUpJgenae0NbRwBj9nP
 PklFpig0oWZ2cFagTKBm796r05WktNMJtF5281qdAZhU5to7GmlQ1VMSt3rSqfAI+ha3oNCmZAZ
 Sr0xsN0vZv6kWIE+lZoXXNp0kitlbjyd5MkJWBiX6eQVL191jOP+fs8sBQJNwlHv40W8owX+bIN
 /oIyQVXcGBjN7iabnyIhdflKE1mK7oA8/rgs4guuAMDHr1dTnppKpx3LZtD5ZZ2HYAHNroQTNsh
 AB9qaJSBMGByoMj/tHNS/OuPRaKySYUdpyu7c
X-Google-Smtp-Source: AGHT+IEDl8M5F+MobCB3JAO2gQTMzxkCii5P0pswMIQwCksbt96XXTeibZfmDV/cScD+EFyz1kmVaQ==
X-Received: by 2002:a05:6000:4204:b0:3a3:5f36:33ee with SMTP id
 ffacd0b85a97d-3a8fdeff5a6mr10622405f8f.32.1751289007376; 
 Mon, 30 Jun 2025 06:10:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7518sm10255872f8f.2.2025.06.30.06.10.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:10:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between TCG
 and HVF
Date: Mon, 30 Jun 2025 15:09:36 +0200
Message-ID: <20250630130937.3487-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

It is useful to compare PSCI calls of the same guest running
under TCG or HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c    | 3 ++-
 target/arm/tcg/psci.c   | 3 +++
 target/arm/trace-events | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7a99118c8c2..6309c5b872e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -34,6 +34,7 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 #include "trace.h"
+#include "../trace.h"
 #include "migration/vmstate.h"
 
 #include "gdbstub/enums.h"
@@ -1149,7 +1150,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     int target_el = 1;
     int32_t ret = 0;
 
-    trace_hvf_psci_call(param[0], param[1], param[2], param[3],
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
                         arm_cpu_mp_affinity(arm_cpu));
 
     switch (param[0]) {
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index cabed43e8a8..8df27ca123e 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -25,6 +25,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
+#include "../trace.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
@@ -79,6 +80,8 @@ void arm_handle_psci_call(ARMCPU *cpu)
          */
         param[i] = is_a64(env) ? env->xregs[i] : env->regs[i];
     }
+    trace_arm_psci_call(param[0], param[1], param[2], param[3],
+                        arm_cpu_mp_affinity(cpu));
 
     if ((param[0] & QEMU_PSCI_0_2_64BIT) && !is_a64(env)) {
         ret = QEMU_PSCI_RET_NOT_SUPPORTED;
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 4438dce7bec..a9cb5e0f5c6 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,3 +13,6 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+
+# tcg/psci.c and hvf/hvf.c
+arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
-- 
2.49.0


