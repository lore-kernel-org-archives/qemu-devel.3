Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B47C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEfL-00040m-Qi; Sun, 05 Jul 2026 00:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfJ-0003v9-H1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfF-0006PW-88
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84592b55832so1646703b3a.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226468; x=1783831268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gI8TJyVj//txxRRFeEfE8QbpaSNpGX4bw5i0vl11MXk=;
 b=l/mcXxbViPdpyYG2Z442l0785fzu/Kg/8sys0O6nEyqVk2SZAjUQEXE/ITolPTW0tu
 TGi35J0lBrkdYACkCA723cq5NyfOjRMXR5p+uOPaAX56IWS2Yw8vzS+K2q8jKajJ8zAU
 AaWgSEi7KpFN1XafV6dwotQxYiPdRICn4a7uyWVbwUaL2TXBH/dbfQmjoLkfjKXxlKNr
 TUKBJa3YuO9gTi5Cz4oWlzRfOfPrZ3WikKqMPcev6haAKUMlIUqMETwpD7GqikDG1a3y
 BhQjqc2EMWXgzy97ZpJHBMu6BLFRRjh/l0ckH284L/URuDx84sF2tMdhzFhzrOdLpAq+
 JE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226468; x=1783831268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gI8TJyVj//txxRRFeEfE8QbpaSNpGX4bw5i0vl11MXk=;
 b=q30WntbGEdyruu/9g8w2m4roWJEOUDkHAcf7vK6/Vh7sWMHgn2gqx5Aawt7ff2/VKu
 hudkAfmnEMZwga2ttEd7uEdhV7ja9bCp7QKQUw72Rbc9eSOT477jaL+R1Tm2yt/++WNz
 CStTg/6KWW//s9YNQUf57XSFQUTOdVfvf5GoAVnAazS7woe+ZxpqbUWkC/vMnwT0zKOf
 B3AF7YUsq/WET3yoeT81Rp51UeB4H4lSKrdCUFmpy5ZYjggRvFYYrGcyJyPxFPIZYu7c
 xuENfC3C+krMkAegwLUlKVg49VeCB95xrtMk6nD0LQNl4XlFmVUkjvW8sOUXXV1wUoMk
 JDaQ==
X-Gm-Message-State: AOJu0Ywk8Nt/UVryBVurVdNsbFMyGrxQcLqOw5Rt7up6hEeiAMw130eh
 wlaMvabdw8g6QYegRRb8zv3bJpBq/gK4NinTFOIDwqEdCRIeQck7Nj/wdJpLjUYa+YUG5XsdzYC
 hktiG
X-Gm-Gg: AfdE7cnhUP2UpEFsFSQRUP9Wybpja4G/YOjALMoQS/XGkE6CvnKdvIspYc+2lNEe8f8
 Vi3m8G9VBtVb2r7hIa8GJlZB2RtDLvJsiEZZ07/tOg21LgT0zuIEMQOV+arKQn6IEuvuux1Ke9w
 9vmPJ13jyRQ+MtwYBr42Be5a2bIV9dRZ7/M+Vza0ZMFoGTmzrjLrXew+rlHbY1YWy7rle6RhZIi
 nOVktNnU3snNWcjTDc6319N3StrUTsOWAMFjWaR0HzvvLMyrsMV8lK5UY18RANq1h/5G0EF/tUi
 CTYunPeTaxHjykN1yPhgKlK1k5BF1hLeP1V8gUNKyq7QcVBhEAQk0eNeORuiYklC61SpZ9kl4OT
 7DK0jurBh1iIMauR6Ep/vCCENqdKxct/RXg3peihq8TGbmAj5CV0nfSF9v1fSWn+q7y9Yy7T1FQ
 wuR/hWCAag1vMOn/i0ycBmJ3z1sYFxThI6PNrxnibeaGAY3fs=
X-Received: by 2002:a05:6a00:2914:b0:847:8f8a:a055 with SMTP id
 d2e1a72fcca58-847f6dd6d35mr5137805b3a.17.1783226467780; 
 Sat, 04 Jul 2026 21:41:07 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6952a0dsm1952615b3a.0.2026.07.04.21.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 46/46] accel/tcg: Merge CPUState.{break,watch}point_hit
Date: Sat,  4 Jul 2026 21:37:25 -0700
Message-ID: <20260705043725.1373137-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 gdbstub/system.c       | 51 ++++++++++++++++++++++--------------------
 target/arm/hvf/hvf.c   |  5 ++---
 target/arm/kvm.c       |  2 +-
 target/i386/kvm/kvm.c  |  4 ++--
 target/ppc/kvm.c       |  2 +-
 target/s390x/kvm/kvm.c |  2 +-
 9 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index dc1c634258..34f2850879 100644
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
index c1e4cdbc19..f1dc130bfa 100644
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
index cbb72be33b..f7d6df5e77 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -126,7 +126,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
     CPUState *cpu = gdbserver_state.c_cpu;
     g_autoptr(GString) buf = g_string_new(NULL);
     g_autoptr(GString) tid = g_string_new(NULL);
-    const char *type;
     int ret;
 
     if (running || gdbserver_state.state == RS_INACTIVE) {
@@ -151,32 +150,36 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
 
     switch (state) {
     case RUN_STATE_DEBUG:
-        if (cpu->watchpoint_hit) {
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
-            }
-            trace_gdbstub_hit_watchpoint(type,
-                                         gdb_get_cpu_index(cpu),
-                                         cpu->watchpoint_hit->hitaddr);
-            g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
-                            GDB_SIGNAL_TRAP, tid->str, type,
-                            cpu->watchpoint_hit->hitaddr);
+        {
+            CPUBreakpoint *hit = cpu->bp_wp_hit;
 
-            cpu->watchpoint_hit->flags &= ~BP_WATCHPOINT_HIT;
-            cpu->watchpoint_hit = NULL;
-            goto send_packet;
-        } else {
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
+            }
             trace_gdbstub_hit_break();
+            ret = GDB_SIGNAL_TRAP;
         }
-        ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
         trace_gdbstub_hit_paused();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 48c2a02bfb..10d707a452 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2372,13 +2372,12 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
 
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
index 7670041423..20c9631ccb 100644
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
index 3cc941cf00..c7a326e560 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6261,13 +6261,13 @@ static int kvm_handle_debug(X86CPU *cpu,
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
index 8f9c16fcef..0050bd7648 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1590,7 +1590,7 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
             n = find_hw_watchpoint(arch_info->address, &flag);
             if (n >= 0) {
                 handle = DEBUG_RETURN_GDB;
-                cs->watchpoint_hit = &hw_watchpoint;
+                cs->bp_wp_hit = &hw_watchpoint;
                 hw_watchpoint.hitaddr = arch_info->address;
                 hw_watchpoint.flags = flag;
             }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index aff4d26096..8c56074304 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1861,7 +1861,7 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
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


