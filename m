Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDACCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPk-0008PU-1W; Wed, 03 Sep 2025 06:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPc-0008G6-Ea
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPY-0008CU-E1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so39281895e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894094; x=1757498894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xIKx74hKoGIgNHpZV/Ej5B/b/1PDyxWy9u19GsHuyM=;
 b=tn23gcsBtoxiagMEjYKXp8jURsflucEM4kbXl9TyMQko9ugNdZv1VOMRp+4ZNKjGtr
 a57zM+V/2R0koSC3yTBPYmlGCVMmeMMRnjMtHbuL/dhwIH7skz2puaWl3FEZi6Av4pvR
 uMup6vGcKE+14rOHQaIR/Ea+3IGnMTyWQ1s4siBns6SK5E/SJKQATDlG2ABoHhJBUu67
 n32DDyE9MfrOYgUoLhQREzxkQlE08e4/Oog6PI8fyVNb0Vycoh9GPb1J+cTIjmhs037f
 zeSZ2PwZqe4mU4/0i8jhRwJmr+h9vqSLLDxpOr1MnzmksF5JUf+n6soXTrQ6jMBi+9WV
 fMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894094; x=1757498894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xIKx74hKoGIgNHpZV/Ej5B/b/1PDyxWy9u19GsHuyM=;
 b=tdS9NYCg23ljXC9nudXTa6mM8Yp+wDFFPvZYMCvf9uAgYpSj5IQJTM1nSR6fMC9iUE
 cN83/F7akLUa0iNXH4uVVLBxra+FSobRZE3lMUVGIukx+OsdIjXfsGfAS6pyto3wTr7+
 LDI9cOPHBZztO3Fj5vtWwfIpQmyR4hHgYprkBn+N/4cb/7/OMUQNLL9mAYN1IeTDgduR
 fddkxEOJb3HwfDCTZJhdnjGlXeulOL/qWTo3IXJ5J3t445Kbqtq3tQz8uIsIBAz3gR1O
 415zhB5XJutIxZ3eZr8gStLdAJituCmGYuH8ZoI9/4Ls2fwMvMX78ErXwU2YnOYSLH9+
 JYgg==
X-Gm-Message-State: AOJu0YypwiiRBwxOCuy0ZgoiikXcG+F6N0Y5QZ4VklT+2WAhEw5exeDR
 ZG9T59UgBv1qwHtUp9T8r0PzchhMUBdgAL5VwrIeseYchqqn7XLwvkicLaeVys+Rp3bhxC0YmHQ
 jgVR0/5I=
X-Gm-Gg: ASbGnculZF8nYE21CDeUa9u88WAKkwH/3TiqRr5gAZUhlZ7cf3rrAbIIGpvxk460Y8v
 hD/fIwZTeLgD1Xm8Db/dMtF9yaaM2P3ANMaLoc/LYtLzNT+MlvjfMfaqJ+LVq+ZiBlvrB4n4Bl9
 CCb4E+FzgyKT05tfbPxXMTVF3qAi1kx2YS2tB/Y7Ax82FvxwiuOZWDRWDjpGCWm3dkxBPPFkPVf
 4Y87Quclhk/yrjZPoR6PUMxQ3dOHvKEhy6xsk+6M9qkrSS296skZLar8qBGnWebwnfOgRUR1Fpv
 KJfXR5eVLBT8QsmqC7Fz7FpXMtuWPZKAStdrsQczCs3zLfGxaJldNsXbDMf8sdSFurv6Q0Nu69H
 7pmDmNYAujqejw2naszjyQ3uPuVVGk8/5Y2JYJf9ytaQZKpk/OY3s3gy4s1MiUCnrLNST+J6s9j
 giTzxUgjLismU8HIxZ
X-Google-Smtp-Source: AGHT+IH1mwV8Reth6QfjA32CG0rSB2IBb1Npxe6WxFKeltdz4jD4dGafLAxcotUYeu1Kwmzct1QW0w==
X-Received: by 2002:a05:600c:c48f:b0:45b:71ac:b45a with SMTP id
 5b1f17b1804b1-45b85533650mr116086415e9.11.1756894094370; 
 Wed, 03 Sep 2025 03:08:14 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7fec07sm228060375e9.10.2025.09.03.03.08.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/24] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
Date: Wed,  3 Sep 2025 12:06:41 +0200
Message-ID: <20250903100702.16726-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
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

hvf_put_registers() and hvf_get_registers() are implemented per
target, rename them using the 'hvf_arch_' prefix following the
per target pattern.

Since they call hv_vcpu_set_reg() / hv_vcpu_get_reg(), mention
they must be called on the vCPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  | 6 ++++--
 accel/hvf/hvf-accel-ops.c | 2 +-
 target/arm/hvf/hvf.c      | 8 +++++---
 target/i386/hvf/hvf.c     | 2 +-
 target/i386/hvf/x86hvf.c  | 4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 32b32e1d024..8fce627b08c 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -74,12 +74,14 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
-int hvf_put_registers(CPUState *);
-int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
+/* Must be called by the owning thread */
+int hvf_arch_put_registers(CPUState *);
+/* Must be called by the owning thread */
+int hvf_arch_get_registers(CPUState *);
 
 struct hvf_sw_breakpoint {
     vaddr pc;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c1415b0949a..b6b7b462144 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -81,7 +81,7 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-        hvf_get_registers(cpu);
+        hvf_arch_get_registers(cpu);
         cpu->vcpu_dirty = true;
     }
 }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7427ac240fb..21002f419f5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -549,7 +549,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
 };
 
-int hvf_get_registers(CPUState *cpu)
+int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -688,7 +688,7 @@ int hvf_get_registers(CPUState *cpu)
     return 0;
 }
 
-int hvf_put_registers(CPUState *cpu)
+int hvf_arch_put_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -817,11 +817,12 @@ int hvf_put_registers(CPUState *cpu)
 static void flush_cpu_state(CPUState *cpu)
 {
     if (cpu->vcpu_dirty) {
-        hvf_put_registers(cpu);
+        hvf_arch_put_registers(cpu);
         cpu->vcpu_dirty = false;
     }
 }
 
+/* Must be called by the owning thread */
 static void hvf_set_reg(CPUState *cpu, int rt, uint64_t val)
 {
     hv_return_t r;
@@ -834,6 +835,7 @@ static void hvf_set_reg(CPUState *cpu, int rt, uint64_t val)
     }
 }
 
+/* Must be called by the owning thread */
 static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 {
     uint64_t val = 0;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 15f79e523e6..73c50175048 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -734,7 +734,7 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            hvf_put_registers(cpu);
+            hvf_arch_put_registers(cpu);
             cpu->vcpu_dirty = false;
         }
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index a502437c303..afcf737759b 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -236,7 +236,7 @@ void hvf_get_msrs(CPUState *cs)
     env->tsc = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
 }
 
-int hvf_put_registers(CPUState *cs)
+int hvf_arch_put_registers(CPUState *cs)
 {
     X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
@@ -280,7 +280,7 @@ int hvf_put_registers(CPUState *cs)
     return 0;
 }
 
-int hvf_get_registers(CPUState *cs)
+int hvf_arch_get_registers(CPUState *cs)
 {
     X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
-- 
2.51.0


