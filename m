Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C30BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtn6-0006bA-AI; Thu, 23 Oct 2025 07:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmk-0006AE-G0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmi-00022v-Ig
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711825a02bso5902505e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220030; x=1761824830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkbYxHoIb89CcjxtDzTwkp8toB1u3wHDHZNoatR4q6A=;
 b=tQ2FD4x7hjWKRq/wvTJV24b1bhtPm9U0aYGy1lDEOAVPQ5Tl1pHZoA3GZJl+uanAjm
 IJLum+6edCBJ4UFsYrnMWyRt032YQIQV1jRS+/wKh5DEGxmt2XaMy7YJLmKaQ3qy9OPp
 L7Fyr72P8WqLsqs9ME69RR12t9/D9ZMsm+IMoB1d9jmw2NzL8fxuKFtWWcqcNru78U8U
 t9X7d0412o8F6qd3gHg9miW54LOxl7XsZj4LTJzjdkxwNZYL5Lw/ymP2mtjZXXS1I+3n
 T3aM8WieBPv3IETrv2SnWulKzUyYVRSbGbDFECPzOOPxKpZWs5a7jJobm4BDtVQc8vhZ
 W0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220030; x=1761824830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkbYxHoIb89CcjxtDzTwkp8toB1u3wHDHZNoatR4q6A=;
 b=D/p/lii9LvWnRj/ii06nJiGOtbL4sSyTsvmkEN6/6umBuU5c6He2l5KtVGiVCRmuCs
 WhUoKp6MjYXHo6lBPOlbcKwEO98SGdefvu//dFp7FRm8U66QUvpHb/G4E/pB2YimV9Xk
 lZI5sN1V/nXTVl/UYbVVYEhL8TyWqbHymVOlSVrKNTHRoeNEUHQfmlllEmPtiCnXQRGZ
 Xtl5KzPqQSR0lAVqDEWqyGvDnZe5uMKnALUmEgVDjQaKfhc/QacWlle0YHSJcD04XJxo
 nA4Eox0DJ6y+rqa/PqMGSIukSO0BDXiRqtWeciXmp4Dn+Wumd+8Hq+cnzPPBgD7Q0h1W
 7DfQ==
X-Gm-Message-State: AOJu0YyNVG/3Ru5tPEgjulJISE+C3ivHuAikYIXqq+vJ109E+seaVyDl
 SjpPilWDxkLkD4wZNhWrrXeEyYdzDvgoz2t/CZI6jyC+sUCX/cPIxVRx//DWEz2strwCa4044PT
 ZdzyR8n4=
X-Gm-Gg: ASbGncsMaSl9n1eiEWpbwNHqpl0wEbGZdjmDglKQdkKkd3J1m5eOD2RbgT4fRh5hdBS
 pgRKaPwiFYU1dNKwqI5uUdjOW7oGOo4JMT5b/PRLW8J891+IcG1b56/DnFhlIsfnzxtHy4JnuXc
 khihVnj+mlXrWIkkcvI/ssrl2wmIWFOPqPlSuoPU5rIgMQp6JT6NB1Mjcr/kYcEwRjMvDD7DPV7
 zM5RW+oaCggL/0Kf9zOe+SoZxAeAXyG0DBiq7YfeD3HiTtr5VOi09+/IXcHIJmaBHpdAkZiRfy4
 ZD0hb/CND7i243ibTCWC3M5yxJ8dbvDkjHWR1oNKEY8c8ebqOaJGeSdI/gzQuikPdlQ86GM5aM3
 AVq685XAkGUK1WRDVxUOkyYzmxHl+nUPul1KVETiP4j+aXaf8wd1LQKgMrKQS80uzh4dwJyCSQo
 f7rOgiW24YIp98HdUvGUWYPAw/Ejcz2I/W+Kv7fmcATdK+PDYyi1WXFvayFq4j
X-Google-Smtp-Source: AGHT+IEqdT6ZWlTexgzs/QHM9TkoBB+5Z18vsHyBCjD8vD9/1grdDB4Dlk+S91jyQocD4B90fUZwIw==
X-Received: by 2002:a05:600c:548c:b0:46e:45ff:5bdb with SMTP id
 5b1f17b1804b1-4711787060fmr193393455e9.8.1761220030338; 
 Thu, 23 Oct 2025 04:47:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342946sm93131315e9.10.2025.10.23.04.47.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:47:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 06/58] accel/hvf: Rename hvf_put|get_registers ->
 hvf_arch_put|get_registers
Date: Thu, 23 Oct 2025 13:45:43 +0200
Message-ID: <20251023114638.5667-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


