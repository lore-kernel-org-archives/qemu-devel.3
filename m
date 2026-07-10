Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CE1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEl-00019a-35; Fri, 10 Jul 2026 16:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEi-00018X-PJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEc-0000cz-Tv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1546403b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716849; x=1784321649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OV4mwuDsn3z8Z/dPHFM9BZdKpLpXqp3lTFEeDocPdGc=;
 b=UlorlOHBHM92YmlIm/ywMVPGGNyMAoSCCTqX2eVoymkHh/hTa3EbJP+k/RF7S3o8pU
 AIG4CzOPfGhO6ZqOT6cr29SYnoyqUUaph5NIIukIj8GQc4mSH6qHylFoElH1B5B7KbHq
 dX8avpBN1JF7GXFxirLCeGMHLJK2rctN4PGC9oISxUu3ZhVT1ArJcfCGjJzTWFx7UA4f
 zOykBuRYC3RUEC51OWv3/UHoqlwdyV4KlrcIQR82k7+Ikeh8NDg5xvFvdHeFU3SoLfNX
 cP73NisInEKyHzy4D+vVBt+HRSGcXbNbqUEkGocj3mKNuwD8OdM4ueR1Dx117ICOAlJ0
 vucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716849; x=1784321649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OV4mwuDsn3z8Z/dPHFM9BZdKpLpXqp3lTFEeDocPdGc=;
 b=U2IBuDVpmtsUAEGv2rR7jlRT4ANmApOJLqE9msYcPy93cKSUjJJfCHuwFCnR9nwDfj
 Io+pFwx4i6nwEhwU/BDE2vTFWxMQ5EVPdiPkZ8WzT5CAXac8VQ6qIQ81K/pdotdvRr8O
 UbEYeZxc0ENQ4XcK2QyfBHPeNj2t4yR/7K8J1GYgy2EcrelwtHFxdoz0KO4s/p2dLuta
 l0DQUSLz38UMnHCvFju7VxCex4tytgZIHapsyBQBgo6bBVjyYpRoToMas75gqi/0LcWi
 nPjoVldoEwQ1hrE8yNwUH4GMgvIL9D8T1kCKetkugCu/Afmvq3/ubt/tDDRVLfkuAJE4
 g9Cw==
X-Gm-Message-State: AOJu0Yyzg4Z/YJIAdhmWhMVczbY6VXKO+KWlhYpQZIoiy97WsoF9Q1Si
 xLZiiuDBhKR/rHqONSjVGDafMytIGUTNoXUG5tIlPl8qPqADHApZ1VhoN1QJLEMKHz21ZN+bNVk
 dw32F
X-Gm-Gg: AfdE7cn3Xa565kaxxmf3zGx7XneKfufKOhLq/azNknQSE7k8MhUHJnOrXHIQIC0gGno
 acLx0ce3ETbYx83pdAkAbRQA1A2L42WLmlhkZzUAgNeHH42oLygtDGoIfZp9ImLP+Ye1kUG2ZCn
 RlMgHi/fuXQ/40u39F8MHzEEe77gHUd4tSazXMJVXz3c28P6RpW2RRxJAC/ySAFFI+qUbdfD6JV
 2wrTZaPI1g2hxvq9KrKRQ34PUsv8+0IyPwgsjuSwNxppUKpzOSW/rpmG3Y9pkKZBm+aBECEAF0A
 6DAEcsO407W9Mj5QBAYGJtIgLKK3gOnjkD8JW6MXuPPrD/DXPreNzoCqJuXQyw6++pO/O0sSn62
 geHEEI70/BKUIpHVRjpbLlCZDU0Ls3SimxtxwQie428myEsKWMIFTy8z6eNDhQWJPcInR3rcz0R
 M++xBPqqU6jOG/5dN90g==
X-Received: by 2002:a05:6a00:a27:b0:848:2f7a:2e5e with SMTP id
 d2e1a72fcca58-8488976671amr487362b3a.77.1783716849246; 
 Fri, 10 Jul 2026 13:54:09 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 04/51] qemu/typedefs: Declare CPUBreakpoint and
 CPUWatchpoint globally
Date: Fri, 10 Jul 2026 13:53:14 -0700
Message-ID: <20260710205401.836304-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Adjust all uses of 'struct' in the uses of this type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 8 ++++----
 include/hw/core/cpu.h     | 2 --
 include/qemu/typedefs.h   | 2 ++
 target/arm/cpu.h          | 4 ++--
 target/i386/cpu.h         | 4 ++--
 target/ppc/cpu.h          | 4 ++--
 target/riscv/cpu.h        | 4 ++--
 target/xtensa/cpu.h       | 4 ++--
 target/riscv/debug.c      | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index c886f3afb7..f1186b909f 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -28,20 +28,20 @@ typedef uint32_t BreakpointFlags;
 #define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
 #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
 
-typedef struct CPUBreakpoint {
+struct CPUBreakpoint {
     vaddr pc;
     BreakpointFlags flags;
     QTAILQ_ENTRY(CPUBreakpoint) entry;
-} CPUBreakpoint;
+};
 
-typedef struct CPUWatchpoint {
+struct CPUWatchpoint {
     vaddr vaddr;
     vaddr len;
     vaddr hitaddr;
     MemTxAttrs hitattrs;
     int flags; /* BP_* */
     QTAILQ_ENTRY(CPUWatchpoint) entry;
-} CPUWatchpoint;
+};
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 786e9b8aad..481646f5b9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -84,8 +84,6 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
     typedef struct ArchCPU CpuInstanceType; \
     OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
 
-typedef struct CPUWatchpoint CPUWatchpoint;
-
 /* see physmem.c */
 struct CPUAddressSpace;
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182..919fe8ebff 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -39,9 +39,11 @@ typedef struct Chardev Chardev;
 typedef struct Clock Clock;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUArchState CPUArchState;
+typedef struct CPUBreakpoint CPUBreakpoint;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
+typedef struct CPUWatchpoint CPUWatchpoint;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisasContextBase DisasContextBase;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a30afcbe..f0b4599d7a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -754,8 +754,8 @@ typedef struct CPUArchState {
         ARMVectorReg za[ARM_MAX_VQ * 16];
     } za_state;
 
-    struct CPUBreakpoint *cpu_breakpoint[16];
-    struct CPUWatchpoint *cpu_watchpoint[16];
+    CPUBreakpoint *cpu_breakpoint[16];
+    CPUWatchpoint *cpu_watchpoint[16];
 
     /* Optional fault info across tlb lookup. */
     ARMMMUFaultInfo *tlb_fi;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d..9dbfa7c9b9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2185,8 +2185,8 @@ typedef struct CPUArchState {
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
     union {
-        struct CPUBreakpoint *cpu_breakpoint[4];
-        struct CPUWatchpoint *cpu_watchpoint[4];
+        CPUBreakpoint *cpu_breakpoint[4];
+        CPUWatchpoint *cpu_watchpoint[4];
     }; /* break/watchpoints for dr[0..3] */
     int old_exception;  /* exception in flight */
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cbd5964b1a..bda8ad16ad 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1320,8 +1320,8 @@ struct CPUArchState {
     /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
-    struct CPUBreakpoint *ciabr_breakpoint;
-    struct CPUWatchpoint *dawr_watchpoint[2];
+    CPUBreakpoint *ciabr_breakpoint;
+    CPUWatchpoint *dawr_watchpoint[2];
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bdd28d329b..9cd38d10a3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -491,8 +491,8 @@ struct CPUArchState {
     uint64_t *tdata1;
     uint64_t *tdata2;
     uint64_t *tdata3;
-    struct CPUBreakpoint **cpu_breakpoint;
-    struct CPUWatchpoint **cpu_watchpoint;
+    CPUBreakpoint **cpu_breakpoint;
+    CPUWatchpoint **cpu_watchpoint;
     QEMUTimer **itrigger_timer;
     int64_t last_icount;
     bool itrigger_enabled;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1b..ab42b4be00 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -545,9 +545,9 @@ struct CPUArchState {
     unsigned static_vectors;
 
     /* Watchpoints for DBREAK registers */
-    struct CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
+    CPUWatchpoint *cpu_watchpoint[MAX_NDBREAK];
     /* Breakpoints for IBREAK registers */
-    struct CPUBreakpoint *cpu_breakpoint[MAX_NIBREAK];
+    CPUBreakpoint *cpu_breakpoint[MAX_NIBREAK];
 };
 
 /**
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index b8fea64bec..67c09b1a53 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1060,8 +1060,8 @@ void riscv_trigger_realize(CPURISCVState *env)
     env->tdata1 = g_new0(uint64_t, env->num_triggers);
     env->tdata2 = g_new0(uint64_t, env->num_triggers);
     env->tdata3 = g_new0(uint64_t, env->num_triggers);
-    env->cpu_breakpoint = g_new0(struct CPUBreakpoint *, env->num_triggers);
-    env->cpu_watchpoint = g_new0(struct CPUWatchpoint *, env->num_triggers);
+    env->cpu_breakpoint = g_new0(CPUBreakpoint *, env->num_triggers);
+    env->cpu_watchpoint = g_new0(CPUWatchpoint *, env->num_triggers);
     env->itrigger_timer = g_new0(QEMUTimer *, env->num_triggers);
 
     for (i = 0; i < env->num_triggers; i++) {
-- 
2.43.0


