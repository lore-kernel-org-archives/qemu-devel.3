Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93CEC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfNr-0005tC-R1; Fri, 20 Jun 2025 13:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLQ-0002OQ-Jo
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLP-0004bC-0L
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453608ed113so19665915e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439761; x=1751044561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qi1v+rhQhzB0wXkGwXHpVQj60b4txNx12WYFBH8tbM=;
 b=VDqMuFv/OXkY0AW63joPyVMgu7QJZS9/YwRiH1+sjNg4dY6BypynP8CFAy7HUA4V8u
 F9z1Q6LsA7k3fNFbGGgNs+TAsIIVCwJYoCfkytvc0VspXfYsav8CWxE7TiNVFqMkoCB2
 y0sKMHohdr7crcUc/RV0VFurpk3mYfdT2Jy0HuIkO9Sq6VbXtIprLkX9fRUM152jCsSb
 ckh/dyqqZOPg4A9dUCljzGfgiMUQCmzVgeU42MFy404XLkgeL5StHK/jFjv0nGQqHFCp
 ZqqLNdQyxStKu6cMMBY5+k3uWNM4XvILwAxcDn0l1reUQzr2Po3R6VyKI43iuqYahq2g
 wQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439761; x=1751044561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qi1v+rhQhzB0wXkGwXHpVQj60b4txNx12WYFBH8tbM=;
 b=dDjpqzspLFPC9jbdHJkWDmTAVVCwv9zf3sgK6nCJYVhYQoCrEliV39EkbneqfAVTd0
 QErQ5G730OoelXICLZ0DXxMuoxcSR4eS9t3xZROzIyW/qaavLU2km41lK/bYiJlrPEcI
 Cyem+yfMrulMTB0lU0WixyO9HVaHFZbdJxKcln3tpbVsys0gB48rsia3yIL3tg3sM+CW
 PR5C01RLwuU36WtvGfgvotH5yiRdp9X3dcy986RAbdyBKeuFWfs81rIJxG2v5GrTI9He
 gLA6VD6xNnCGNvd3vs23hgxQD+/ftcKquHptiCWbd3vqLag0M5/yf+1EdFTcg6KEE57v
 dN9g==
X-Gm-Message-State: AOJu0YxllwIbNCzFjb+uODkClLp394HeTzTYIFBAuS6uydB3tT+mm6X7
 GuCvdl7QRDZPud7o+0/YCwMG4kwOOh6cA6id14X+UzcBvNorvzSDZgxfbJ5hxMSxZL+dStlgMUF
 LXGQCfQg=
X-Gm-Gg: ASbGncvvTubR9IIyXx7t7wLGQ14CWjLFDK3jNiwEPU/c5PGK/TbPQLeCu+GMfysmFSD
 s9+jSEzgQx7NOPHAE+7fsQwQGBiEcIW7B52+m+XEmHJ3ZiWwApqRukrHBpUkPPAocnN0cZtmKeb
 zPS2k/Cz2bAsCX5PGU+dz6gqncmm6wHHcCIGscSU1lCfKvrPoPkVNdLWkG3vvIqyJTtFWzmsD1V
 CpYiJcz6lJy5OoWEFZH9qQDqYZhrhVE2ARmB+TTWI8+cFIQX58c5q6y7z81QJVIR1/dxGuGnmgh
 qt4JF23NbTSx82OLd2RL8ubQwfdLoP6tKeHTLf5c6YzTazZRdAb94luY6gDC2magHM1xgiVV3V3
 FNutDY+svNVbPrtXT5i9PKnEIr+nrVUqREtYs
X-Google-Smtp-Source: AGHT+IEQq6HaQLqzewlCiIo0FiAPIW82X7045GWBJkcjw26Y78qbiA/ikMP4FEvvKY5au5QxFDGFUg==
X-Received: by 2002:a05:600c:6206:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-453659caa7dmr35829875e9.12.1750439760968; 
 Fri, 20 Jun 2025 10:16:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c71esm2579551f8f.61.2025.06.20.10.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 28/48] accel/dummy: Factor tcg_vcpu_thread_precreate()
 out
Date: Fri, 20 Jun 2025 19:13:21 +0200
Message-ID: <20250620171342.92678-29-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Factor tcg_vcpu_thread_precreate() out for re-use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 3 +--
 accel/tcg/tcg-accel-ops-rr.c    | 3 +--
 accel/tcg/tcg-accel-ops.c       | 7 +++++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..129af89c3e7 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,6 +14,7 @@
 
 #include "system/cpus.h"
 
+void tcg_vcpu_thread_precreate(CPUState *cpu);
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index dfcee30947e..462be7596b9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -133,8 +133,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+    tcg_vcpu_thread_precreate(cpu);
 
     /* create a thread per vCPU with TCG (MTTCG) */
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee9..fc33a13e4e8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -311,8 +311,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
 
-    g_assert(tcg_enabled());
-    tcg_cpu_init_cflags(cpu, false);
+    tcg_vcpu_thread_precreate(cpu);
 
     if (!single_tcg_cpu_thread) {
         single_tcg_halt_cond = cpu->halt_cond;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 95ff451c148..861996649b7 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -41,6 +41,7 @@
 #include "gdbstub/enums.h"
 
 #include "hw/core/cpu.h"
+#include "hw/boards.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
@@ -69,6 +70,12 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     tcg_cflags_set(cpu, cflags);
 }
 
+void tcg_vcpu_thread_precreate(CPUState *cpu)
+{
+    g_assert(tcg_enabled());
+    tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
+}
+
 void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.49.0


