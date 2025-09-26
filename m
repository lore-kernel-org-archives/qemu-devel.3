Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DFCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299t-0000jr-Q1; Fri, 26 Sep 2025 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299Z-0000Ih-No
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298f-0005nH-Lq
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso2254996f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895767; x=1759500567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=71SPKxC6TrHmGazKirT7T3wwRBAuIbbjNemK5xYBRvE=;
 b=R506isnkVKQCkcpnMEvhQ4S+5Uz2Qre1azpmxekKIPEt5+ceEYoWsikOeIKaxAa4F9
 tbCn0c/KAUxhAIcDjL8hZ4jP29kgLV8hKO7VAghMrG4XH03Wbocu9T6AMkZhyPFVROWP
 eWXCRe+R0fL369tQQQiq1WmfcmODHHgAZAIp7dI29pNS0kjx6Br1qclSfCLoaKAGZiXe
 sq065h2R01uC9J2Xn9qmVSwHjXZxMKCUNZWyNYPVzXrtLMjmGcvrpc0vK4yttHeS3/GP
 CZ6VtJ4/TDQ3Yt6cWLfFO3Np8pxR+q2sBreQAulQ7XpdDWpPMINzdifMAbnrOQ8ldWBm
 L/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895767; x=1759500567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71SPKxC6TrHmGazKirT7T3wwRBAuIbbjNemK5xYBRvE=;
 b=vT89RSaVPiqGn3SO5vINzcbjsQpjCurAVe0T6W4Pbr/XVhiZ8VCIU8dCD0stCyyTnW
 zawRPoMxIRtAD3NcoIJWCqRVKzXgK+Kch523oyiEHYUIZ+Sp6BjhIdwgFjo0w1cnsdcH
 BS5If0NEKc/EpU3bxicd/XVtC7eaFQQHnc3NB3YeNpYDh0JGjeBJ9XnZavR0R759YxRd
 Cv8g5gb+ZxVcivDu4k/+HORDLHa7U8BqmttwFFY3rCv0SFrqC3rWuw577kfWvvA3NpWb
 vSTmtz+Y4ALMH151X4h2CT4+lyvYlJarX2KkngDjDDxLK9Gydc4SSZFvKtm9o7Ink8PT
 ppIA==
X-Gm-Message-State: AOJu0YxdcEiZrplF1iMVaeLrdC6xiRjJlCse4acpRMMxcLleCwJT+eDV
 GFC/UNX8Q0xktN1pQar3mGfC9f84VgZn+wM9XnQkBF8y73YtcW35A58By6K3K5pDYyd+iqYbw9g
 93i/H
X-Gm-Gg: ASbGnctvr0skKiq0TUKct18+Fn4yFptz4G6FgH3Lt5J1tGzhZh98zgYa1stvr0mAo5m
 0TVn7S1imY4WkAFtbpBBHDz5t4Yjwa5e6uRmHQwWfK9EaGiZjybREFY2Qt/pHgZLAgb7PkRr3Kv
 rs9uB9Ybo32h0TBmM78ainlmZDbrwXAsUBWFZU7cYMezpJNEF9kdDEBcscRz0Ax+N6FCtTeHZdG
 K/O9B3JVu7uknLPcakA9KTI5Cw1HNZ/SKJs8GB6CGku3MeF2hmmFZ01YNF8P0aHoU2g6AQrQWNO
 haWZeTACpWFI2fFPzQMZOvdmfg5kVAH0qV3MDgRPeBpjNgJD0FQsJnMhVY0gGxglDVwmhAv3DKV
 B2z4voFEdTMNIUGLOx+muISX9NG/t
X-Google-Smtp-Source: AGHT+IH0GPA4leIYJ4GAHnBWiOgP3uXcszdD9znqzIx+Pa9PtWHDB0lnho3sjW4pd0zjPrN4wlKMVg==
X-Received: by 2002:a05:6000:400b:b0:3f4:84d0:401a with SMTP id
 ffacd0b85a97d-40e46514cb5mr6071138f8f.4.1758895767011; 
 Fri, 26 Sep 2025 07:09:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/44] target/arm: Convert power control DPRINTF() uses to
 trace events
Date: Fri, 26 Sep 2025 15:08:40 +0100
Message-ID: <20250926140844.1493020-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-powerctl.c | 26 ++++++++------------------
 target/arm/trace-events   |  6 ++++++
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 20c70c7d6bb..a788376d1d3 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -17,24 +17,12 @@
 #include "qemu/main-loop.h"
 #include "system/tcg.h"
 #include "target/arm/multiprocessing.h"
-
-#ifndef DEBUG_ARM_POWERCTL
-#define DEBUG_ARM_POWERCTL 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_ARM_POWERCTL) { \
-            fprintf(stderr, "[ARM]%s: " fmt , __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 CPUState *arm_get_cpu_by_id(uint64_t id)
 {
     CPUState *cpu;
 
-    DPRINTF("cpu %" PRId64 "\n", id);
-
     CPU_FOREACH(cpu) {
         ARMCPU *armcpu = ARM_CPU(cpu);
 
@@ -102,9 +90,9 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
 
     assert(bql_locked());
 
-    DPRINTF("cpu %" PRId64 " (EL %d, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
-            "\n", cpuid, target_el, target_aa64 ? "aarch64" : "aarch32", entry,
-            context_id);
+    trace_arm_powerctl_set_cpu_on(cpuid, target_el,
+                                  target_aa64 ? "aarch64" : "aarch32",
+                                  entry, context_id);
 
     /* requested EL level need to be in the 1 to 3 range */
     assert((target_el > 0) && (target_el < 4));
@@ -208,6 +196,8 @@ int arm_set_cpu_on_and_reset(uint64_t cpuid)
 
     assert(bql_locked());
 
+    trace_arm_powerctl_set_cpu_on_and_reset(cpuid);
+
     /* Retrieve the cpu we are powering up */
     target_cpu_state = arm_get_cpu_by_id(cpuid);
     if (!target_cpu_state) {
@@ -261,7 +251,7 @@ int arm_set_cpu_off(uint64_t cpuid)
 
     assert(bql_locked());
 
-    DPRINTF("cpu %" PRId64 "\n", cpuid);
+    trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are powering up */
     target_cpu_state = arm_get_cpu_by_id(cpuid);
@@ -297,7 +287,7 @@ int arm_reset_cpu(uint64_t cpuid)
 
     assert(bql_locked());
 
-    DPRINTF("cpu %" PRId64 "\n", cpuid);
+    trace_arm_powerctl_set_cpu_off(cpuid);
 
     /* change to the cpu we are resetting */
     target_cpu_state = arm_get_cpu_by_id(cpuid);
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 4438dce7bec..252c05a9ebe 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,3 +13,9 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+
+# arm-powerctl.c
+arm_powerctl_set_cpu_on(uint64_t mp_aff, unsigned target_el, const char *mode, uint64_t entry, uint64_t context_id) "cpu %" PRIu64 " (EL %u, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
+arm_powerctl_set_cpu_on_and_reset(uint64_t mp_aff) "cpu %" PRIu64
+arm_powerctl_set_cpu_off(uint64_t mp_aff) "cpu %" PRIu64
+arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.43.0


