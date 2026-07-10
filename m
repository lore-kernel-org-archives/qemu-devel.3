Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2BBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEp-0001GY-Lq; Fri, 10 Jul 2026 16:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEn-0001E3-26
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEe-0000eV-Us
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-848593533cbso1076684b3a.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716851; x=1784321651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ljn/yVxdDHENjIfYHhJCyU1c+qAG4dmbxzH4PmdcUfQ=;
 b=G86MH8gvtRvLoAUIl9k7YzL3l/VCXLWETAJGV6efpvpfmMZfFYTe26+dLjzyNB9Dtw
 MnXxHe4zNkVfXsJX9HEzdVZpDVkHrD6Np9yq54d0TZC77vBMY/VZ7KbEZ29UAQcrtLIf
 dtEKrPuevJ2+SAxDvoxMm0kzbLISrDEiveffOLGrKTGCMyQB+a1DsnuKWobMtMeeOO0u
 FbofBnswBo2zR7XVPvPq0grA64ivOVMZT9/GrY1R98PPwG6jx3Tvav3mlfHvxxEytNoZ
 pTia2rL4m6BqE15+xy9NArU/Mf0o+2JoSlGe5fdaYcEXTmWwRtT7SzGpgO9ua8pATbLL
 +fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716851; x=1784321651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ljn/yVxdDHENjIfYHhJCyU1c+qAG4dmbxzH4PmdcUfQ=;
 b=ElLuQS2CbFc1oTQ2ibJ3YTDXGB+fWwu8Ot6Qgq+Z1mbCvJe7iCqPVc+Z+FEyH8Ha53
 VRtPgNZ+ejnVJ2Gz01j8reBDtO0cJCx2TNLgY30oG9Iqkbny/LTMtaxZP0kYR8sYhkho
 NNrfHMFMpYqwaOQdAPeUraPjLHAe0VEzUUrmmeQZacQ8+kA8e++EcfJJGH5m71C/zDTj
 QZdMHRpOzvyCO25nTKYHwPdZVUBeQSuDf8SWfKLC8BvQ5M4Mk15CEBkfJdcRSifHD/kK
 ucLwyaMQpO4752Wnv7XYysGPztrsmu93M0iGm5Ub7BcOMUOVfsVyESE0Bze/DG0BIrss
 cMog==
X-Gm-Message-State: AOJu0YxeYLvuGyqbxDqonWd5TVjpyTXzOp5OFMT4Ov5qhIzf2gFV6zWs
 klruUElOFQZ/ihNPYbXWgg8miaGD4Z7LuGu9HEP3HJvEqR2b5T8C0SiAolIWphklFCet+tH/Baa
 fDzwY
X-Gm-Gg: AfdE7ck1LCGOs0k8joR8x2C6OuU4HYAdaeNYART2CcL/eo04Th1lKJ8JpeXgoZoE216
 +Getv5TEuMXTbl4Si5TcxvzcpER1TdwLwQuYUey2Qea0MWytqhE4TOmzV4B0X3XuD9uCRGgxmnn
 p444IKc4M/2g+L38sdTIsULLEzHe1ce9VnufiEVwAvJq0NMmyhSOGVOoBIvuUbeBcVwcWfNWPJp
 9yVQFdG/imXcOp8PtAcqH8E8J4prxWthz/fJe1ovqjuU4uUQOewW5DFUgoM4bVIyL04UCfPkdyT
 TAcXZN8pxjhVoGQsv6BmbrEtxOCdMIFB19KYKSz4ed5b3+7QtO3ylz4OrRAg/Q2/hGUuGsD8BB9
 umQfBLjytgqDt7QOjRTvqRCOXv77asoTTWkx+qOBc0tSBlMND3Im80vOe9GlC9nN6zJboKf103M
 9wLdzyK+UjHygU1Ubzn769/nxR16cR
X-Received: by 2002:a05:6a00:f89:b0:842:2419:6c0b with SMTP id
 d2e1a72fcca58-84889637ff9mr468318b3a.10.1783716851410; 
 Fri, 10 Jul 2026 13:54:11 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 07/51] exec/watchpoint: Add CPUWatchpoint.id
Date: Fri, 10 Jul 2026 13:53:17 -0700
Message-ID: <20260710205401.836304-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 588ff13fe1..6da8a007df 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -41,6 +41,7 @@ struct CPUWatchpoint {
     vaddr hitaddr;
     MemTxAttrs hitattrs;
     int flags; /* BP_* */
+    unsigned id;
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
@@ -52,7 +53,8 @@ void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags mask);
 bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags mask);
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
+                          BreakpointFlags flags, unsigned id,
+                          CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, BreakpointFlags flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 88d0c093eb..afac859b8d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -148,7 +148,7 @@ static int tcg_insert_gdbstub_breakpoint(CPUState *cs, GdbBreakpointType type,
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
index 020c8126b3..581fa6a575 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -171,7 +171,8 @@ void ppc_update_daw(CPUPPCState *env, int rid)
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


