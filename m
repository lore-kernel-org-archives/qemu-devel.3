Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B494AC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxX-0006FQ-B9; Sun, 26 May 2024 08:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxV-0006Et-A6; Sun, 26 May 2024 08:26:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxQ-0001Jd-1t; Sun, 26 May 2024 08:26:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f8edddf756so1998275b3a.3; 
 Sun, 26 May 2024 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726392; x=1717331192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMU/SV7wlBDuGZ1ZDSAsXuFBkdwCg9D8akYR9UPruqE=;
 b=Z8M7rt/EMSh0hM6Nwo87xbl7XfwCn1qlGLzeIDqzyxmtJNXCg72DuOaa9shkz8u4zy
 E5KkKZMT4Ta6LjiCk20JD+2LY8GJ7ZF2Sj+rrPq3cB4neIU+ZmAOsnMXs5rroj/c9gX3
 agHRRJeONuj1g2FXslxtFXxN7dNc5nvWjb9MvkwD1lCX960q63VTFhx1zoLH4mXavemk
 3pgVJlF4izq9KY7yIwL4fCrzDEFNxy1wCdZXzGITNbaqcHL1kbMynzuaihLNeLucQqFf
 hNUIaIwGDST6yXCASyYOX7mcKxJiAbWkKcY+yOdv+bEiT8K2iQ3PnxJZe7hooyAeN/j/
 LFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726392; x=1717331192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMU/SV7wlBDuGZ1ZDSAsXuFBkdwCg9D8akYR9UPruqE=;
 b=ddTOycgWOJVTSNGSkY//KSn5CXXKKYsy0iC32f6wxVC7GcjEYF97s3c2uQZhDqWPG6
 u7yd/9jldKXIgKzQL+V6GKT+LhEnAUoBM8NZIAK/inXSvRgF1s/TkbS1vNmHw+K6ExV0
 ZQFhFNW8QQ/rVnjx37WPEFZugjzQXxXvF6Z6eVlRKGi+7hSMIjMN2mheyQx9nVWQOsLR
 HBW0N+ecBZgRKjiTMAdaK+Ejcj/LN92OBFmv278DYcB8gLovbB5NZPuJO88T4IeYYUii
 h9q3MeHEJD2XEVgckA5P5gbKYIBIDnU7hC0eRa8EXVnDVeqLqXzrRWTZ3qYW7NrvLW+I
 BMRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxC/kt064D1dRCUDzcIDLiVwpL+6piSLJJiPcbNNxFdDor1yQeW8IOojJ7QhibZFeAaKkmhSOSMhWbYirGUKn5S9CKZFQ=
X-Gm-Message-State: AOJu0YzW0UPIK4X/pstrKrAnhzmloXO9JsaFbcNLt8RbIWgcIbhmE3i/
 UBH0ct36+F2JoI2X5KRfrftyU/zyvAu0VBUzaxD/nUYa5Ae52tgCx3rgfQ==
X-Google-Smtp-Source: AGHT+IG6KtJW8CFPYp0GSiF4Dxu3ij1jf7gMOMMiN8apl6Nq6p3GarmVC73/1vzoadtc8PhIOHsUng==
X-Received: by 2002:a05:6a00:35c7:b0:6f3:ee81:13b5 with SMTP id
 d2e1a72fcca58-6f8f34aad7amr11812935b3a.17.1716726391994; 
 Sun, 26 May 2024 05:26:31 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 03/10] target/ppc: Improve SPR indirect registers
Date: Sun, 26 May 2024 22:26:04 +1000
Message-ID: <20240526122612.473476-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SPRC/SPRD were recently added to all BookS CPUs supported, but
they are only tested on POWER9 and POWER10, so restrict them to
those CPUs.

SPR indirect scratch registers presently replicated per-CPU like
SMT SPRs, but the PnvCore is a better place for them since they
are restricted to P9/P10.

Also add SPR indirect read access to core thread state for POWER9
since skiboot accesses that when booting to check for big-core
mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h |  1 +
 target/ppc/cpu.h          |  3 --
 target/ppc/cpu_init.c     | 21 ++++++------
 target/ppc/misc_helper.c  | 67 ++++++++++++++++++++-------------------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index f434c71547..21297262c1 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -53,6 +53,7 @@ struct PnvCore {
     uint32_t hwid;
     uint64_t hrmor;
 
+    target_ulong scratch[8]; /* SCRATCH registers */
     struct pnv_tod_tbst pnv_tod_tbst;
 
     PnvChip *chip;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1e86658da6..dac13d4dac 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1253,9 +1253,6 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
-
-    /* POWER CPU regs/state */
-    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 01e358a4a5..ae483e20c4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5759,16 +5759,6 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_sprc,
-                 0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_sprd, &spr_write_sprd,
-                 0x00000000);
 #endif
 }
 
@@ -5781,6 +5771,17 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
+    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index fa47be2298..46ba3a5584 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -26,6 +26,7 @@
 #include "qemu/main-loop.h"
 #include "mmu-book3s-v3.h"
 #include "hw/ppc/ppc.h"
+#include "hw/ppc/pnv_core.h"
 
 #include "helper_regs.h"
 
@@ -321,11 +322,25 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
 
 target_ulong helper_load_sprd(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->core;
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
 
-    switch (sprc & 0x3c0) {
-    case 0: /* SCRATCH0-7 */
-        return env->scratch[(sprc >> 3) & 0x7];
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        return pc->scratch[(sprc >> 3) & 0x7];
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used.
+             */
+            return 0;
+        }
+        /* fallthru */
     default:
         qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
@@ -334,41 +349,27 @@ target_ulong helper_load_sprd(CPUPPCState *env)
     return 0;
 }
 
-static void do_store_scratch(CPUPPCState *env, int nr, target_ulong val)
-{
-    CPUState *cs = env_cpu(env);
-    CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
-
-    /*
-     * Log stores to SCRATCH, because some firmware uses these for debugging
-     * and logging, but they would normally be read by the BMC, which is
-     * not implemented in QEMU yet. This gives a way to get at the information.
-     * Could also dump these upon checkstop.
-     */
-    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
-
-    if (nr_threads == 1) {
-        env->scratch[nr] = val;
-        return;
-    }
-
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
-        cenv->scratch[nr] = val;
-    }
-}
-
 void helper_store_sprd(CPUPPCState *env, target_ulong val)
 {
     target_ulong sprc = env->spr[SPR_POWER_SPRC];
-
-    switch (sprc & 0x3c0) {
-    case 0: /* SCRATCH0-7 */
-        do_store_scratch(env, (sprc >> 3) & 0x7, val);
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->core;
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        /*
+         * Log stores to SCRATCH, because some firmware uses these for
+         * debugging and logging, but they would normally be read by the BMC,
+	 * which is not implemented in QEMU yet. This gives a way to get at the
+	 * information. Could also dump these upon checkstop.
+         */
+        int nr = (sprc >> 3) & 0x7;
+        qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
+        pc->scratch[nr] = val;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
                                   TARGET_FMT_lx"\n", sprc);
         break;
     }
-- 
2.43.0


