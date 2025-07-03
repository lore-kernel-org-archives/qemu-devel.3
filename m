Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174B1C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpX-000738-KM; Thu, 03 Jul 2025 13:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNp9-0006BE-1D
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNp7-0008OM-2k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453608ed113so1112275e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564048; x=1752168848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHktCWHXOq/fuqtnF2me8RbDnjLy8K0ph9fB+eFovTA=;
 b=b3q+lv2dqD08T5aIjk+/O5oeqAfEuBBsuG8X5kyltEs2ExUVCvzfKtM1VoSvcHXPcd
 cDKWkW92HW3pL1OgoqLxpkchBTPJSOPG8m+fwdYMC8wwt0vXCxGz4AjWsHLpVT69PG2n
 iH9GJUtKExnmaL82LbaQnnDf7TbKAMzt2Q+npl+PZ/T5GUOPcVZTy6RLf0L5l2s0VHlo
 06CRRi+MXfLB/dWMp2BoSQTjrlhhNmBpu9sCph1lJft01aWMqc8YhwBkoEvvFZugXcgR
 27cxdlaKl3NeWbBkFt9opJYXTyC+o1bLni7beaWP03Eq+Emy3ff11XN/RL3meN1qGhgv
 ahoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564048; x=1752168848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHktCWHXOq/fuqtnF2me8RbDnjLy8K0ph9fB+eFovTA=;
 b=GEIG8AfGEqofEJ/MyKgNLaVL7uT/+kda3eD5eyaMoGBxfIyIyGdjsEI4iSYgCf63I8
 A9ISOV7wSR2PgO45ZMr+dbXpReXnkRgBJzX3WeuqLzyXAjTxZ8TNoO6Gj0120NgnS+XG
 qKyXM4gXHnx8kxg6eCRh/cOK2SZN/PfMl996ksAKgLfVU6EB0MV2OA4JPuGICIGhfRN+
 CExwVK5jOGMpIog3QaM2SMETLbNsLlUawWPq1HfavszFNM2o+WWsvC554pXiqRi+z7UE
 mey4mfrtAWsWE3KmwQo+yqcefrvSeJdhpzeLkTtg1/rjnTx04yjQN3cZ5V8N1gFG7Gtf
 irDQ==
X-Gm-Message-State: AOJu0Yw2Y0oJ1pTTTnLCJYVeOSVKgNHuRuWqD9FujVMwnDlMUEgJn3C+
 zZd0qJaPiyhXNOsoeQsUChvDAVpGdVYTnAxvYU1iBRPzs2ehY43A+jzojwA+MgFTmc2THdp4e3p
 rGlQ7faU=
X-Gm-Gg: ASbGncvXCVbBAb4n6qp1aE9sOD4qARcSD4/Zji3IzUqoS0Yv0udaZbwWIvUPcTmUtpS
 y3n7+49eltD2CM1lLi979gLe3LiPM8cymGLGoo7wsRVVsEAQ+ADZSySvnjEyOov1rpEHjOcYrox
 xm5yKPv2Ppr4MHXYJJ+F9AqW/S6i07OoQRzfBh1MgZtZSXqE3vylPturcyVJ4CDNWZ4U0GTEPsJ
 dQwKU8LoiJp6O48USOcW8K27XaS5W5CL5lIRyJCXgCP+fkroaLJlLrngQNCiCMriO0GLTc6nJyJ
 rylnHKjlhnTM8/z5WnL2vF0oTALRjp3crwUH7e538bUq48jwXI/6NOmnNLJPapk3EjlITkB4b4y
 5gXsLVihsXGdTQyWbKKBjP3BqvZUxCUGmuH3L
X-Google-Smtp-Source: AGHT+IHW5sfQHvEdYYSpNdY+nvtPkanFLMgQrVJS6Qp9HQKPJM5pHqYyHIN17dwssogKLWyH3Zg1Ow==
X-Received: by 2002:a05:600c:621b:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-454a9c9e61fmr48333445e9.20.1751564047781; 
 Thu, 03 Jul 2025 10:34:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989fcesm32171615e9.16.2025.07.03.10.34.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v6 15/39] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Date: Thu,  3 Jul 2025 19:32:21 +0200
Message-ID: <20250703173248.44995-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
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

hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 30 ++++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       | 28 ----------------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index aed791a3f3e..646cd240238 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -50,9 +50,11 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/queue.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
+#include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
@@ -483,6 +485,34 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
+{
+    struct hvf_sw_breakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+int hvf_sw_breakpoints_active(CPUState *cpu)
+{
+    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
+}
+
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
+{
+    hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
+    return 0;
+}
+
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8c387fda24d..1c72c43ddb4 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -41,31 +41,3 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
     abort();
 }
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
-{
-    struct hvf_sw_breakpoint *bp;
-
-    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
-        if (bp->pc == pc) {
-            return bp;
-        }
-    }
-    return NULL;
-}
-
-int hvf_sw_breakpoints_active(CPUState *cpu)
-{
-    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
-}
-
-static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
-{
-    hvf_arch_update_guest_debug(cpu);
-}
-
-int hvf_update_guest_debug(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
-}
-- 
2.49.0


