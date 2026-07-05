Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD7C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEd6-0006HV-At; Sun, 05 Jul 2026 00:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc2-0004qU-Rm
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbr-00046X-78
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cace91f112so14395705ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226257; x=1783831057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ts+HuZq3aNUe3DQ8iFUaLx/lp/NRTeOTmx3IkWCijis=;
 b=ihew5adZs1Gq24Ie0Fy0ZU41+PNIEgKy7j4cy7//XBPiJIux4zUatNB7JnxxXdxeyN
 Pln3oKDPAEjxiL4qtVrZsksaIGh/Hqt0if5nR4WsS0FpM0drC+WGdaQj0qmpFaUVSad0
 uL5gEL6AOh4zNWwtB1pAaH/NgeTzo2SBGpBOQlunKpcg8b7Ak9+Rl6Yg0KieSiyWmxYt
 lrNkoHjScmyRIesGCIB8/7OpG1UmPrAc66NG+qv5DUqKeN3TARrmGafxGSj7YmyJ7rhi
 MYU0KDE8HPr1vhnmnVaUkg8JWhsynWyRF1WtPJW08TVlIku3/zDMdqR91Ycx84aBrMHZ
 gcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226257; x=1783831057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ts+HuZq3aNUe3DQ8iFUaLx/lp/NRTeOTmx3IkWCijis=;
 b=Dt651JDd85jj1J+LpoKagM9bR5E8fZXYTd9d5b17flYQ98hiuLmNnyDPDyteADV86M
 6uCBsQym2LrWnBNCqFNVb5tA0eN6X2za755N5/mZZir5sIP9LsGJ19xydXKxrWIyrTfo
 yeIq2XyDxsUyrDwdJAmBw6iAOh24pmktL5Hft1Waf6nrxDOTl1hpSfS6RSPmpavGVLD1
 JCU2/JJPv8Rji9bEVuv4RN+PUtpKkddNDbOhDgwGOCxI4Msv+ibZV3JdMlOEySH13Zv7
 RBlyWo1jdfm/Pf5Z7P0ecQIM32tJlUWnMnvQ8l6lxbXBkzbpEBWuC7QrRKYtfzH+VZzP
 kSmQ==
X-Gm-Message-State: AOJu0Yxgg2lBmQGdtc7dFG0BahczU7Ds99ZbAesUcu4N2GKva6Q1CNfa
 Xi/IZf4KhHL1qImYrOkRUS2gqVqtzehbcrkQj3HYeDftagdG2/AyXSBUtGozwNCp3IfjNP4RTBo
 hA0CS
X-Gm-Gg: AfdE7cmZ6O5EnpwtwaXlX/4/Ll5fgQxn/Y7ph+A/MUP886eiWb3+oqmI+FossiEc4hv
 J+7h75SuX5OG+jqGt3+jxRWzVjLCICsf7hIdEuOBuCZvHukuPjFNtxXKbzUF5psPsldYsncFLdo
 9LOnbtLJn2YopmWh7dKDfDOdB0/3L92x/yHQDBQxixIYQH4V9c6r6nt7MF9i/4JeH5D2CSqCUqL
 GQ23OeSlLnpjoB1Ps59W9FMT1hlORUDSADLQUO251KSG7CvgL1wIuSfuqOZDyl/ZPvZZIM5XWvs
 1zcPx7a0LRv+L8UNQ2PXmIXYmrbN9/BlHjfXPJMC1lnBShgMIv4DgQQT2nyssyhfAlgwzmhyJM2
 MRoeSdH/W0JvMkkudt2Nbi+Mi6lu/OyLuztUv0HLLCWWOAB2aTE0+A/IMAhIHE8Sjs3QvqHlaQp
 ZICA19MmZDrXK7LQA6XFXO7AMBL7evsPiNCnfvQszQ9WKEWMA=
X-Received: by 2002:a17:902:e892:b0:2c9:a5e9:c26e with SMTP id
 d9443c01a7336-2cbb76072d6mr48981495ad.13.1783226257100; 
 Sat, 04 Jul 2026 21:37:37 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 11/46] exec/watchpoint: Add CPUWatchpoint.id
Date: Sat,  4 Jul 2026 21:36:50 -0700
Message-ID: <20260705043725.1373137-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Add an identifier for use by targets with BP_CPU.  For most targets
the index of the hardware breakpoint resource is to hand.  For s390x,
there is only one resource so use id 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h           |  4 +++-
 accel/tcg/tcg-accel-ops.c           |  2 +-
 accel/tcg/user-exec-stub.c          |  3 ++-
 system/watchpoint.c                 |  3 ++-
 target/arm/tcg/debug.c              |  2 +-
 target/i386/tcg/system/bpt_helper.c |  4 ++--
 target/ppc/cpu.c                    |  3 ++-
 target/riscv/debug.c                |  8 ++++----
 target/s390x/tcg/debug.c            | 11 +++++------
 target/xtensa/dbg_helper.c          |  2 +-
 10 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index b22b6dabf2..963ea992cb 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -40,6 +40,7 @@ struct CPUWatchpoint {
     vaddr hitaddr;
     MemTxAttrs hitattrs;
     int flags; /* BP_* */
+    unsigned id;
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
@@ -51,7 +52,8 @@ void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
+                          BreakpointFlags flags, unsigned id,
+                          CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, BreakpointFlags flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 44bc5faf08..37cdd354f0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -152,7 +152,7 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_ACCESS:
         CPU_FOREACH(cpu) {
             err = cpu_watchpoint_insert(cpu, addr, len,
-                                        xlat_gdb_type(cpu, type), NULL);
+                                        xlat_gdb_type(cpu, type), 0, NULL);
             if (err) {
                 break;
             }
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 973bdbcd7a..42e4861868 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -22,7 +22,8 @@ void cpu_exec_reset_hold(CPUState *cpu)
 }
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, unsigned id,
+                          CPUWatchpoint **watchpoint)
 {
     return -ENOSYS;
 }
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 67e4560e78..a618bb5acd 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -26,7 +26,8 @@
 
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, unsigned id,
+                          CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
     vaddr in_page;
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 73d694ca4f..50b90ad675 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -622,7 +622,7 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
         wvr += basstart;
     }
 
-    cpu_watchpoint_insert(CPU(cpu), wvr, len, flags,
+    cpu_watchpoint_insert(CPU(cpu), wvr, len, flags, n,
                           &env->cpu_watchpoint[n]);
 }
 
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index d847d77d71..662ffbacfc 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -76,7 +76,7 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
         if (hw_breakpoint_enabled(dr7, index)) {
             err = cpu_watchpoint_insert(cs, drN,
                                         hw_breakpoint_len(dr7, index),
-                                        BP_CPU | BP_MEM_WRITE,
+                                        BP_CPU | BP_MEM_WRITE, index,
                                         &env->cpu_watchpoint[index]);
         }
         break;
@@ -85,7 +85,7 @@ static int hw_breakpoint_insert(CPUX86State *env, int index)
         if (hw_breakpoint_enabled(dr7, index)) {
             err = cpu_watchpoint_insert(cs, drN,
                                         hw_breakpoint_len(dr7, index),
-                                        BP_CPU | BP_MEM_ACCESS,
+                                        BP_CPU | BP_MEM_ACCESS, index,
                                         &env->cpu_watchpoint[index]);
         }
         break;
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index d77b88505f..cf4d97285e 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -169,7 +169,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
         flags |= BP_MEM_WRITE;
     }
 
-    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[rid]);
+    cpu_watchpoint_insert(cs, deaw, len, flags, rid,
+                          &env->dawr_watchpoint[rid]);
 }
 
 void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index bf9accf6e8..1b88cd136c 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -501,12 +501,12 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     if (flags & BP_MEM_ACCESS) {
         size = type2_breakpoint_size(env, ctrl);
         if (size != 0) {
-            cpu_watchpoint_insert(cs, addr, size, flags,
+            cpu_watchpoint_insert(cs, addr, size, flags, index,
                                   &env->cpu_watchpoint[index]);
         } else {
             def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
 
-            cpu_watchpoint_insert(cs, addr, def_size, flags,
+            cpu_watchpoint_insert(cs, addr, def_size, flags, index,
                                   &env->cpu_watchpoint[index]);
         }
     }
@@ -628,10 +628,10 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     if (flags & BP_MEM_ACCESS) {
         size = extract32(ctrl, 16, 4);
         if (size != 0) {
-            cpu_watchpoint_insert(cs, addr, size, flags,
+            cpu_watchpoint_insert(cs, addr, size, flags, index,
                                   &env->cpu_watchpoint[index]);
         } else {
-            cpu_watchpoint_insert(cs, addr, 8, flags,
+            cpu_watchpoint_insert(cs, addr, 8, flags, index,
                                   &env->cpu_watchpoint[index]);
         }
     }
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 7a838775ec..25968d9a3c 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -34,19 +34,18 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     if (env->cregs[10] == 0 && env->cregs[11] == -1LL) {
         /* We can't create a watchoint spanning the whole memory range, so
            split it in two parts.   */
-        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, NULL);
-        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, NULL);
+        cpu_watchpoint_insert(cs, 0, 1ULL << 63, wp_flags, 0, NULL);
+        cpu_watchpoint_insert(cs, 1ULL << 63, 1ULL << 63, wp_flags, 0, NULL);
     } else if (env->cregs[10] > env->cregs[11]) {
         /* The address range loops, create two watchpoints.  */
         cpu_watchpoint_insert(cs, env->cregs[10], -env->cregs[10],
-                              wp_flags, NULL);
-        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, NULL);
-
+                              wp_flags, 0, NULL);
+        cpu_watchpoint_insert(cs, 0, env->cregs[11] + 1, wp_flags, 0, NULL);
     } else {
         /* Default case, create a single watchpoint.  */
         cpu_watchpoint_insert(cs, env->cregs[10],
                               env->cregs[11] - env->cregs[10] + 1,
-                              wp_flags, NULL);
+                              wp_flags, 0, NULL);
     }
 }
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 4cf147bbfb..20ddc527f8 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -105,7 +105,7 @@ static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         mask = 0xffffffff << (32 - clo32(mask));
     }
     if (cpu_watchpoint_insert(cs, dbreaka & mask, ~mask + 1,
-                              flags, &env->cpu_watchpoint[i])) {
+                              flags, i, &env->cpu_watchpoint[i])) {
         env->cpu_watchpoint[i] = NULL;
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Failed to set data breakpoint at 0x%08x/%d\n",
-- 
2.43.0


