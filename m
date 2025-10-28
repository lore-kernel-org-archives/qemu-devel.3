Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A84DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcXy-0005yv-F5; Tue, 28 Oct 2025 01:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcXv-0005wy-7b
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcXt-0003LX-6R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:47:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47112a73785so34879035e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630419; x=1762235219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkbYxHoIb89CcjxtDzTwkp8toB1u3wHDHZNoatR4q6A=;
 b=xWlunJy6oyU5eNE0DHcy0n69ElUMJ1Ocjlyqj6BwpbnQLFNjzmMDx2csW9Qzajhiws
 1W+Yn53MOmSSOvW4qyl6mq8e3lELg9gg/VyxjlSMDCZPfK5Ift4Y/czS6nFLZO1cu+K/
 lKQYzOpFT1xlRhnwEIyCbwQRKQ3O7DjE1L4LOQfJTZy0HVrT39EVtkAVKsl/ntjPqryc
 I37AD5K17zRN0502PWbyfP4laHFZVlW4JTeyerr/IlwAepARjL2OCM+ZAx3KpOqUQAlo
 yxezH0bpZ4tcsolviqE81UNyfU+ecfzkybpMwVfQO/Sp1jdZBBuM1lcFRgWLrCE/xFi3
 hFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630419; x=1762235219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkbYxHoIb89CcjxtDzTwkp8toB1u3wHDHZNoatR4q6A=;
 b=kBOskWQAa3iqwdtsrQt0/9hg4Q7xFP9oTWEbXzMWDI2lrGexaLTo0wdpUh7b6k9EfG
 iK4gMgfDxBAzYnUVK34VOZWZny2BUysNVWy8ZBxTqDzLZBHsZwtTpOrCIGyeA7gTk/L7
 4t4hRFg+jaMYed+JQK1t4n7+i1g3+DJVBcz2GFEx7XZH4YGJUxvVNMUxqwK/FQihEYMZ
 LkeJuV/KCnre9Lwy+4Lw9zqiiSYwlHBaXwlu/uL3CQ2QCnjcB739RZ3RWIcb4NZ9/6SB
 JtiaIgVu0c8b6N7ghalU83elBE97Y6549rU5KwPRlUdR0LoHfMsYg04cTxpSuWGwkZZ0
 +y7Q==
X-Gm-Message-State: AOJu0YwO8YAIHzeFVrfFXWQsakVRrVvXKnoSdXtziWTjcLvdu8CZ8UOW
 0717cajn32NZc/aKDDKkUGVbvAVlUAnx8cWJYaBPYiQAwPagtVVhUrahH50RB2w+1yYUjRuuvgT
 dK5Nd6c4=
X-Gm-Gg: ASbGncuwtvLQm6QAus0qcuK6g/ymrMLT4ero9e+BYF24+EAujDAmUuUOZ5EEZv2EDb3
 QV21PVRt9Fcq1rJDkad1qYyEwtrEmuFvc8NYlPlR532W4QWCrHYxOkJLEfuLGkpebOdPhZwXcWl
 6xx1oJ1Zwef3LZjxOUgGpxfFtra4DyTfugXDO/PkEB7MVAol6WhRRuxJ4yRwUt6Wi+MBLIU25T4
 VIYSbNMTDVGdOwVqwGKFQJLxoNs+EExNwaZGC2npQ6mrYC6o99aKrRL2ijM1jEtZ4jjcblnynn/
 AMky9NMv/o+9mFb+a81Uxps0GotDEonxwC6BDF0aYH9CSmAR3mR/fvWDzp/doh/aHXbeesZXLZU
 m7iLmxKhoa99lbUeBTO2OSHsG4tqSV7tVCX29BEyXT9kdAnUum8k7njqID15iUK01o3wylI82Rg
 xjMIxeIufejTkDrtwp97ImYYtJ46Ec/KZaSMhA6DkDuTHo139UNFsVDos=
X-Google-Smtp-Source: AGHT+IGZW9oWFKpC/JlRFPeKkuOmfQTtCuwftk5aIyjez3FD00CkiwUeIhKSMAGhnp2UXASLteGcsg==
X-Received: by 2002:a05:600c:45cc:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-47717df9db5mr17235685e9.9.1761630418952; 
 Mon, 27 Oct 2025 22:46:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952e3201sm18244996f8f.47.2025.10.27.22.46.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/59] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
Date: Tue, 28 Oct 2025 06:41:42 +0100
Message-ID: <20251028054238.14949-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

hvf_put_registers() and hvf_get_registers() are implemented per
target, rename them using the 'hvf_arch_' prefix following the
per target pattern.

Since they call hv_vcpu_set_reg() / hv_vcpu_get_reg(), mention
they must be called on the vCPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
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
index 005e2bd891a..3e5feecd8a7 100644
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
index 9111c1d717b..f0a0e5d1a75 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -424,7 +424,7 @@ static const hv_sys_reg_t hvf_sreg_list[] = {
 
 #undef DEF_SYSREG
 
-int hvf_get_registers(CPUState *cpu)
+int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -564,7 +564,7 @@ int hvf_get_registers(CPUState *cpu)
     return 0;
 }
 
-int hvf_put_registers(CPUState *cpu)
+int hvf_arch_put_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
@@ -692,11 +692,12 @@ int hvf_put_registers(CPUState *cpu)
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
@@ -709,6 +710,7 @@ static void hvf_set_reg(CPUState *cpu, int rt, uint64_t val)
     }
 }
 
+/* Must be called by the owning thread */
 static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 {
     uint64_t val = 0;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b2bf59cb483..76a58cb0350 100644
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


