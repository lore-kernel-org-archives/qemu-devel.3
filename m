Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIII-0000es-Jh; Fri, 10 Jul 2026 16:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIF-0000Sy-Fg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:55 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiII7-0001sD-VF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:57:54 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38426d04bb4so1080848a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717066; x=1784321866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WjLEtohWc+o9MkE1PG7oePLniabIWGoiT7bdPR5cyO4=;
 b=R1FhU5TuOzouHoUPCsTkOGJIq5qTLqCUghcA84TMQUJYpQ/R00PP7xlLpjIL3EO79d
 +CiDHwh5fq2fgvnSNECOk4QUhyO5oGFet35aQb0GjIDgVmV8kCiI8IAp6vrnqLs7KpaK
 7yU8dZbLE9biM31a8Z93tddzXQ4cRPZphzJ2Cf+yEGqjDHUUKkMtxp/C7kVNyrP0g5nC
 AXWh26aoLY/qlervp3OC2lNgDjCD1vQyeVGCJSwkALI7g7isR4RZZzVgvSagKkYBjCXY
 So47DvGe+swiWbRNgquQkTZSIxQ6GTJ2CIBjmG6MSNgGVFXPkotKbG6Ukt3nWD/KHW6w
 AGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717066; x=1784321866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WjLEtohWc+o9MkE1PG7oePLniabIWGoiT7bdPR5cyO4=;
 b=UD3/tnWlpQdtO0LvTTcQFkKeOT5E7OAIk3opKNmOvkqh+n1jQnH3AUdg+eIg7Q5AIh
 T9e3A/486v+XuVQD+zX1xn/45TIuLV6gtIvHYuU805AdZa1Uyj9Q519H//8iXZzeQSUt
 iTqc8+3OJP/gHwoFstvop1XJpobghY+WdyhwJi5J0EPcEZ9An1+JaF7tmzxJgoR8pGXe
 2BsEfSTVJyBTzrp7qM0SPJMuMCXIVTGWw+UGgiAQ5vYHW82zShctkpjPZvWGtj1Z4YM8
 NG1BLgGNxps7MwrmBE35TsyYuhc57G9KaV3yjGGmFH41rCk62BZjPxHSsSeJ66aGc8S3
 9bng==
X-Gm-Message-State: AOJu0YxeC9DlW1EQVXrLchYlU5K6IADC4Mf2d8uitKMd54GjXAFJXhK4
 daUOajjlRHW8JW/5uyI8LxDUIxj+QHV/hqOfdzaOliZwcwBBKgeIZi5Pw9aUBEPV9oUlyz4nks9
 Qp6Us
X-Gm-Gg: AfdE7ckzWmhO1D+dYekSSWD3bXrNHgoGGP0IbekKNL+VtvcyNiOWsJ3zRGNnmiCQjus
 h1brb0mWLIor5KojxR/pUMdxeNLbuXg+1vsoG8S8OHy1F97ueiZnP+EsZBTnKJfpdCFZP+RPkWf
 YKIpPN1fK5xIW6T3GSxzWFR4Cgwu4ZlaUeSMN9TpwRO7JHi533zKpAsscYmflIjidAm3yPy1C0H
 o2qemQSLq0SpCKAPHszeUmDgCOR0TWYqf0t5ChcMUPXU0L3CXkOTT0kJ6PazkWexbLxiUWNDs67
 jcNIy4ZlSBIg+Ww510Vi3tjWmL75T3m6Bniyz7k3gMldh3J3Po6a5oIvw/kjy8um+fzugcWYeqH
 7PEPEXKv0AaLCM1/nqAA6iEd06VKCBttTRqnINJ86bbhVImKTkd8dYBojwxzjlp56WT2QPGtP5e
 grgJV/rGTEuTnt8exqGQ==
X-Received: by 2002:a17:90b:2248:b0:37f:fd70:6790 with SMTP id
 98e67ed59e1d1-38dc81c1b09mr281371a91.9.1783717066451; 
 Fri, 10 Jul 2026 13:57:46 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 42/51] accel/tcg: Merge CPUState.{break,watch}point_hit
Date: Fri, 10 Jul 2026 13:53:52 -0700
Message-ID: <20260710205401.836304-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Merge and name bp_wp_hit.  Now that all targets have been
converted to use debug_excp_handler hit argument, we only
need one pointer to an outstanding debug event.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h  |  3 +--
 accel/tcg/cpu-exec.c   |  7 +++---
 accel/tcg/watchpoint.c |  4 ++--
 gdbstub/system.c       | 50 ++++++++++++++++++++++--------------------
 target/arm/hvf/hvf.c   |  5 ++---
 target/arm/kvm.c       |  2 +-
 target/i386/kvm/kvm.c  |  4 ++--
 target/ppc/kvm.c       |  2 +-
 target/s390x/kvm/kvm.c |  2 +-
 9 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1a42940d92..5401d7c14b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -526,8 +526,7 @@ struct CPUState {
     /* ice debug support */
     IntervalTreeRoot breakpoints;
     IntervalTreeRoot watchpoints;
-    CPUBreakpoint *breakpoint_hit;
-    CPUBreakpoint *watchpoint_hit;
+    CPUBreakpoint *bp_wp_hit;
 
     void *opaque;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 68d434fff4..d0cf89e5bf 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -366,7 +366,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
     bp->hitaddr = pc;
     bp->hitlast = pc;
     bp->hitattrs = MEMTXATTRS_UNSPECIFIED;
-    cpu->breakpoint_hit = bp;
+    cpu->bp_wp_hit = bp;
     cpu->exception_index = EXCP_DEBUG;
     return true;
 }
@@ -685,14 +685,13 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    CPUBreakpoint *hit = cpu->watchpoint_hit ? : cpu->breakpoint_hit;
+    CPUBreakpoint *hit = cpu->bp_wp_hit;
 
     if (hit && hit->flags & BP_CPU) {
         cpu->cc->tcg_ops->debug_excp_handler(cpu, hit);
 
         hit->flags &= ~BP_WATCHPOINT_HIT;
-        cpu->watchpoint_hit = NULL;
-        cpu->breakpoint_hit = NULL;
+        cpu->bp_wp_hit = NULL;
     }
 }
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index bf4c46c393..f96ffc018d 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -56,7 +56,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
     bool have_cpu_wp = false;
 
     assert(tcg_enabled());
-    if (cpu->watchpoint_hit) {
+    if (cpu->bp_wp_hit) {
         /*
          * We re-entered the check after replacing the TB.
          * Now raise the debug interrupt so that it will
@@ -146,7 +146,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
         return;
     }
 
-    cpu->watchpoint_hit = found_wp;
+    cpu->bp_wp_hit = found_wp;
 
     /* This call also restores vCPU state */
     tb_check_watchpoint(cpu, ra);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c78fb330c4..3f31b75173 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -150,34 +150,36 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
 
     switch (state) {
     case RUN_STATE_DEBUG:
-        if (cpu->watchpoint_hit) {
-            const char *type;
+        {
+            CPUBreakpoint *hit = cpu->bp_wp_hit;
 
-            switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
-            case BP_MEM_READ:
-                type = "r";
-                break;
-            case BP_MEM_ACCESS:
-                type = "a";
-                break;
-            default:
-                type = "";
-                break;
+            if (hit) {
+                unsigned watch = hit->flags & BP_MEM_ACCESS;
+
+                hit->flags &= ~BP_WATCHPOINT_HIT;
+                cpu->bp_wp_hit = NULL;
+
+                if (watch) {
+                    static const char hit_type[4][2] = {
+                        [BP_MEM_READ] = "r",
+                        [BP_MEM_WRITE] = "",
+                        [BP_MEM_ACCESS] = "a",
+                    };
+                    const char *type = hit_type[watch];
+
+                    trace_gdbstub_hit_watchpoint(type, gdb_get_cpu_index(cpu),
+                                                 hit->hitaddr);
+                    g_string_printf(buf, "T%02xthread:%s;%swatch:%"
+                                    VADDR_PRIx ";",
+                                    GDB_SIGNAL_TRAP, tid->str, type,
+                                    hit->hitaddr);
+                    goto send_packet;
+                }
+                /* else breakpoint */
             }
-            trace_gdbstub_hit_watchpoint(type,
-                                         gdb_get_cpu_index(cpu),
-                                         cpu->watchpoint_hit->hitaddr);
-            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
-                            GDB_SIGNAL_TRAP, tid->str, type,
-                            cpu->watchpoint_hit->hitaddr);
-
-            cpu->watchpoint_hit->flags &= ~BP_WATCHPOINT_HIT;
-            cpu->watchpoint_hit = NULL;
-            goto send_packet;
-        } else {
             trace_gdbstub_hit_break();
+            ret = GDB_SIGNAL_TRAP;
         }
-        ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
         trace_gdbstub_hit_paused();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 32e5f43ee3..0fd72c5bde 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2370,13 +2370,12 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 
         cpu_synchronize_state(cpu);
 
-        CPUBreakpoint *wp =
-            find_hw_watchpoint(cpu, excp->virtual_address);
+        CPUBreakpoint *wp = find_hw_watchpoint(cpu, excp->virtual_address);
         if (!wp) {
             error_report("EXCP_DEBUG but unknown hw watchpoint");
         }
         wp->hitaddr = excp->virtual_address;
-        cpu->watchpoint_hit = wp;
+        cpu->bp_wp_hit = wp;
         break;
     }
     case EC_DATAABORT: {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c2f921095a..f66332299c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1520,7 +1520,7 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
         CPUBreakpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
         if (wp) {
             wp->hitaddr = debug_exit->far;
-            cs->watchpoint_hit = wp;
+            cs->bp_wp_hit = wp;
             return true;
         }
         break;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2e1ecb1c83..c4f0dc1e02 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6263,13 +6263,13 @@ static int kvm_handle_debug(X86CPU *cpu,
                         break;
                     case 0x1:
                         ret = EXCP_DEBUG;
-                        cs->watchpoint_hit = &hw_watchpoint;
+                        cs->bp_wp_hit = &hw_watchpoint;
                         hw_watchpoint.hitaddr = hw_breakpoint[n].addr;
                         hw_watchpoint.flags = BP_MEM_WRITE;
                         break;
                     case 0x3:
                         ret = EXCP_DEBUG;
-                        cs->watchpoint_hit = &hw_watchpoint;
+                        cs->bp_wp_hit = &hw_watchpoint;
                         hw_watchpoint.hitaddr = hw_breakpoint[n].addr;
                         hw_watchpoint.flags = BP_MEM_ACCESS;
                         break;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f161ba6415..f11f8457d0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1592,7 +1592,7 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
             n = find_hw_watchpoint(arch_info->address, &flag);
             if (n >= 0) {
                 handle = DEBUG_RETURN_GDB;
-                cs->watchpoint_hit = &hw_watchpoint;
+                cs->bp_wp_hit = &hw_watchpoint;
                 hw_watchpoint.hitaddr = arch_info->address;
                 hw_watchpoint.flags = flag;
             }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b75dab5f3c..5c3cde97b8 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1863,7 +1863,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
     switch (arch_info->type) {
     case KVM_HW_WP_WRITE:
         if (find_hw_breakpoint(arch_info->addr, -1, arch_info->type)) {
-            cs->watchpoint_hit = &hw_watchpoint;
+            cs->bp_wp_hit = &hw_watchpoint;
             hw_watchpoint.hitaddr = arch_info->addr;
             hw_watchpoint.flags = BP_MEM_WRITE;
             ret = EXCP_DEBUG;
-- 
2.43.0


