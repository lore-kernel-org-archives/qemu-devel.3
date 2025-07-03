Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpd-0007Sk-Qq; Thu, 03 Jul 2025 13:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpO-0006Sm-Pu
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpL-0000UC-RH
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso599525e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564066; x=1752168866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0qV/fhVJIjz1bwc8Z/fAa3vtgS6Ly+7flgKH+q/xGQ=;
 b=i8/osWmGUM5OKFFedS5xSsR7PHejwVBtGUQSgvCqj94Rp3b5hpsiE2a5CQVAYLGR/M
 CbqFg6L8C8SB3KQxFxNWBZG02d+VYCUhMA+JmgyxYPfPpZJLaAvr8GvTW0XpN5p9QvxS
 QDdMBDifnuoY9rOQfQhviiYtz+8gJzUsrxCcj9RdwlZRIq86V3xlSlFx6hyMwBE8fcD7
 MCBa6Ldx20xF8XskfFvauomQLql8xLYWyXFE0erTqi72y6J9Nf+TsI5Jxpii03pPK+oM
 ww0k6c9LM7nNE/TS6pOn60WxGNNacEjVE3Wirb7SfVDA7HLKFSCRlp1gCVZoJtoIeGaS
 r4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564066; x=1752168866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0qV/fhVJIjz1bwc8Z/fAa3vtgS6Ly+7flgKH+q/xGQ=;
 b=lN2F+EfISNlEnKL/PE8iPNbYxMhaF5+9Q6NjZ5O2mK04jNyF/sWLXt5OXBgPqrVI9r
 VirGdhIc7D7j2sBiBFayTG+DgsncSHLmi87UQ8L6xFibvvXzUtIzUh8A25QynHltOZmE
 rozsoB/DAGqOoUihz8ivXkXOSkbbR3WM0Nll5HYUDFZRPaVLrnEgTpDwFXy8GHN/+enW
 XdPejuESkvH7UDZK79wqDOPtYYic5SUdhb4FCPpUnQfst6zWZ0Stn0mbXQFPqrz8j3Hw
 JYWFYUQbOsFyo7v0Ds1ThMKPLprM2+mPlt3gVd9OHa4Q2MZ/K3K/llgeqtQOmMO+Ox9T
 jADw==
X-Gm-Message-State: AOJu0Yy90WHcEBjJQeel4pyuXmRqaM+NRmHkN2+WNwzsG/cvJPp+EmB4
 AnnL7KpPkRrojlHE58KRVhfdsC7HC4759tMG1HFVj3tcp2sORULkyr2MHpbfXz4cuMV4vCtOf7q
 +J7ppcRk=
X-Gm-Gg: ASbGncuBqQBryi9sTtZR475qLFygnRaZ+USwVsxT2X9FeFFcgpQik6690QuEooOU7J5
 2A0M4cTdBWP+cxTudVrywbk2cicemEDM+0hJEuDIi98OgSc/mqdRLLjHqqReHYx7cwsTrtWZSlM
 H8DHbpzNOh8ZmV3Dg9lVp07HvYAfPufLYcO5OuQhpSjDsyqvp2SBg7pOhLv1Q1SgckD7h6X5f/M
 uv5ZgLdAHIsJUnKg3J0d68BUbuiNsmt/jJ5JfekBa1YeUWdEwORC250iFdNVmL6BcWEILB6D7s0
 p5T1zMjxFWzkHCCekuVvLWU8AxBcqBsEOCGsK9ffCT5LDwNKtrzQKXOmms7xtAFechQZ9MAsU+d
 dWvitFxF4beM0z1KZn7jKJI6NgWzCNmjEckc0
X-Google-Smtp-Source: AGHT+IHcIHY9lMMNmkvv5V+f3SofuDuAff/K4Ge3x+w//CdiWmivy2xE9xv/5wuK0iKf5DJ+gBSq/A==
X-Received: by 2002:a05:600c:3509:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-454a9c6fe94mr55040495e9.12.1751564065841; 
 Thu, 03 Jul 2025 10:34:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997b1ecsm32801235e9.11.2025.07.03.10.34.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH v6 18/39] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 19:32:24 +0200
Message-ID: <20250703173248.44995-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf_int.h  |  1 -
 accel/hvf/hvf-accel-ops.c | 10 +++++-----
 target/arm/hvf/hvf.c      |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86hvf.c  |  2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index dcf06f53d97..ecc49a309cf 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -62,7 +62,6 @@ struct AccelCPUState {
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
-    bool dirty;
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6b1a256deb5..2944e350ca9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -79,15 +79,15 @@ hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         hvf_get_registers(cpu);
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void hvf_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -96,7 +96,7 @@ static void do_hvf_cpu_synchronize_set_dirty(CPUState *cpu,
                                              run_on_cpu_data arg)
 {
     /* QEMU state is the reference, push it to HVF now and on next entry */
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void hvf_cpu_synchronize_post_reset(CPUState *cpu)
@@ -150,8 +150,8 @@ static int hvf_init_vcpu(CPUState *cpu)
 #else
     r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
-    cpu->accel->dirty = true;
     assert_hvf_ok(r);
+    cpu->vcpu_dirty = true;
 
     cpu->accel->guest_debug_enabled = false;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 995a6a74b06..ac0d6ef8187 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -813,9 +813,9 @@ int hvf_put_registers(CPUState *cpu)
 
 static void flush_cpu_state(CPUState *cpu)
 {
-    if (cpu->accel->dirty) {
+    if (cpu->vcpu_dirty) {
         hvf_put_registers(cpu);
-        cpu->accel->dirty = false;
+        cpu->vcpu_dirty = false;
     }
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b25bff0df41..9b8acd5a946 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -733,9 +733,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             hvf_put_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (hvf_inject_interrupts(cpu)) {
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 2057314892a..17fce1d3cdd 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -427,7 +427,7 @@ int hvf_process_events(CPUState *cs)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cs->accel->dirty) {
+    if (!cs->vcpu_dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
-- 
2.49.0


