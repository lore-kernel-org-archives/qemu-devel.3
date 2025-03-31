Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00301C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGTz-0005Di-FT; Mon, 31 Mar 2025 10:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzGTp-0005Cc-Ig; Mon, 31 Mar 2025 10:51:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzGTn-0001U8-EW; Mon, 31 Mar 2025 10:51:13 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso7905598a91.2; 
 Mon, 31 Mar 2025 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743432669; x=1744037469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wx1e8TJLFx3SMD6ixJqL/KCNmj54ZolT8Vf2+oBfH6A=;
 b=c23Ukg8jvWhiIS/zZfC5Olx1z79dzZezM4xfwM4p6Usnbljpy+wkljPMBKnq6W6Lqk
 /SUS59j+jz6lScfiJ65EtCefVFIzfJDz3TArMmVkoRjCM8vn+ElWVgS1Y+SomCGKgW/S
 1KzmGsbgRkZQdk+MNPjqE1OyxHDNYxr0t5kI3pObs0cBx6oKIB3uzNJTiEBanl6VGL0I
 tuLAxPUHcUnbcTbu3nH0vqtEpc0jb2N6r2ofSndlfiTNShwaREaOyTr8BfGDNxKF+pGC
 xTvMPVsgZKrjFNP2VSO2HajAUyYjdwpxNTjCDrpGNRDjXvRV0XPUHFJIst/ZibGTdufW
 lNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743432669; x=1744037469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wx1e8TJLFx3SMD6ixJqL/KCNmj54ZolT8Vf2+oBfH6A=;
 b=uDGOUGHqSXRM8w/GbU+vJaOWpiIkZ9qhtSnTkWq0VLYO6/ogz0l9OyMGR/djfHna7Z
 Xk3YJRZojQYltgsbakXIwDqKhFCBES69hNQDE8UC4i7FOz/0i0GYJcNMjw1hibGnFCYI
 lRaBe6MMtsArUhAIj+LYOaMsUDYsgvsT2yZtAF7t0IqXkqhSeZGecUiwmlWUUtla5s9a
 cn7YIN6MX93voFlQ7ADYngJNOaBLiBpEYIf+Nm1Q6WPSi2tdm8dByCJp+3pc/RBYqpo8
 9/zMfapXLFFm64SdBz7YbTKUyOb4JwcYZ8osC+gWz2Vp5K/+W0xp/4SUQDLLZrnYmwkJ
 EXgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrVqlLRtC36en5sLieUdiMHxe/aXBVWWW1q903cqS0W3PKCSpTceqGQmg6K9Rp/r9MLG7DuRW8ItIl@nongnu.org
X-Gm-Message-State: AOJu0YwbS69kAF5tciA9aBlDETL1C50KVch4TPaTK3TEtqdH5DBkfWMa
 RzakpWDzHWLmWHv8EPwwVEiDf9h3ot1RU/gy5Vr7rpPe5z2q7FjTTEMbEQ==
X-Gm-Gg: ASbGncvt4CONit8SLXT0Z+/yzg8cQeLt9C2Nd4S8tE6pXheJA5PAJxbbHJiw7at1iEA
 vCJM4P5H4ljFiBfdbWO/+dagPMDQ183e5cKVMxb7PAuPpoOinpTiSCYiSNw3wuqNjOsd3xLpd+m
 GnEfpwZb2dJvJuBb92lm6ZM+/S/wf2GCtA3k8zBNRcRJd2xvmJPLd7NRm83SAAwLNmzxk2jDIXE
 CCh7eOuBdZn3GX/dvtAqjXqFoNsqVlc4SVBUhIxrbBu6uvWT8vpdLoEHHOUe1sPdxYZEBMtm4/v
 ajjDiLf6vCjd9BodU9rHNsjji2qK2ad+FNSGZTHvFmfbI2CBWg==
X-Google-Smtp-Source: AGHT+IGdEh4j07FmVNGdkb+X3l7ra+TnIUE/116qO1Q6NZuxneidW9iq7BYNDOrb5RVB6STLtw8ncQ==
X-Received: by 2002:a17:90b:2dc2:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30531fa18b7mr17048590a91.14.1743432669230; 
 Mon, 31 Mar 2025 07:51:09 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30516d5786dsm8102171a91.11.2025.03.31.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:51:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] ppc: Implement print_info interface function for the CPU class
Date: Tue,  1 Apr 2025 00:51:01 +1000
Message-ID: <20250331145101.617232-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

PPC CPU has TYPE_INTERRUPT_STATS_PROVIDER interface but it does not
implement the print_info function. This causes 'info pic' to print
a line like:

    Interrupt controller information not available for
    power10_v2.0-powerpc64-cpu.

Add a print_info panel for CPUs with irq delivery status.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |   3 +
 target/ppc/cpu_init.c    |   1 +
 target/ppc/excp_helper.c | 116 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ff14f5b8a7f..dca84ca23cd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -27,6 +27,7 @@
 #include "cpu-qom.h"
 #include "qom/object.h"
 #include "hw/registerfields.h"
+#include "hw/intc/intc.h"
 
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
@@ -1604,6 +1605,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 void ppc_maybe_interrupt(CPUPPCState *env);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void ppc_cpu_irq_print_info(InterruptStatsProvider *obj, GString *buf);
 void ppc_cpu_do_system_reset(CPUState *cs);
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
@@ -2686,6 +2688,7 @@ enum {
 #endif
 
 /* Hardware exceptions definitions */
+/* Keep powerpc_intr_name in sync */
 enum {
     /* External hardware exception sources */
     PPC_INTERRUPT_RESET     = 0x00001,  /* Reset exception                    */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b3d6599abd2..36742136309 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7527,6 +7527,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->sysemu_ops = &ppc_sysemu_ops;
     INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = ppc_get_irq_stats;
+    INTERRUPT_STATS_PROVIDER_CLASS(oc)->print_info = ppc_cpu_irq_print_info;
 
     /* check_prot_access_type relies on MMU access and PAGE bits relations */
     qemu_build_assert(MMU_DATA_LOAD == 0 && MMU_DATA_STORE == 1 &&
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1890ec9ccb6..7ea5798e95b 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -104,6 +104,49 @@ static const char *powerpc_excp_name(int excp)
     }
 }
 
+static const char *powerpc_intr_name(uint32_t intr)
+{
+    switch (intr) {
+    case PPC_INTERRUPT_RESET:      return "RSET";
+    case PPC_INTERRUPT_WAKEUP:     return "WAKE";
+    case PPC_INTERRUPT_MCK:        return "MCHK";
+    case PPC_INTERRUPT_EXT:        return "EXTN";
+    case PPC_INTERRUPT_SMI:        return "SMI";
+    case PPC_INTERRUPT_CEXT:       return "CEXT";
+    case PPC_INTERRUPT_DEBUG:      return "DEBG";
+    case PPC_INTERRUPT_THERM:      return "THRM";
+    case PPC_INTERRUPT_DECR:       return "DECR";
+    case PPC_INTERRUPT_HDECR:      return "HDEC";
+    case PPC_INTERRUPT_PIT:        return "PIT";
+    case PPC_INTERRUPT_FIT:        return "FIT";
+    case PPC_INTERRUPT_WDT:        return "WDT";
+    case PPC_INTERRUPT_CDOORBELL:  return "CDBL";
+    case PPC_INTERRUPT_DOORBELL:   return "DBL";
+    case PPC_INTERRUPT_PERFM:      return "PMU";
+    case PPC_INTERRUPT_HMI:        return "HMI";
+    case PPC_INTERRUPT_HDOORBELL:  return "HDBL";
+    case PPC_INTERRUPT_HVIRT:      return "HVRT";
+    case PPC_INTERRUPT_EBB:        return "EBB";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool powerpc_is_hv_intr(uint32_t intr)
+{
+    switch (intr) {
+    case PPC_INTERRUPT_RESET:
+    case PPC_INTERRUPT_MCK:
+    case PPC_INTERRUPT_HDECR:
+    case PPC_INTERRUPT_HMI:
+    case PPC_INTERRUPT_HDOORBELL:
+    case PPC_INTERRUPT_HVIRT:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static void dump_syscall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
@@ -2438,6 +2481,79 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
     }
 }
 
+void ppc_cpu_irq_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(obj);
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    const char *priv1 = "";
+    const char *priv2;
+    bool none;
+    int i;
+
+    g_string_append_printf(buf, "CPU[%x] interrupt info\n", cs->cpu_index);
+
+    g_string_append_printf(buf, "    state:%s",
+                           cs->halted ? "stopped" : "running");
+    if (env->resume_as_sreset) {
+        g_string_append_printf(buf, "(wake with sreset)");
+    }
+
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        priv2 = "user";
+    } else {
+        priv2 = "privileged";
+    }
+    if (env->has_hv_mode) {
+        if (FIELD_EX64_HV(env->msr)) {
+            priv1 = "host-";
+        } else {
+            priv1 = "guest-";
+        }
+    }
+    g_string_append_printf(buf, " mode:%s%s\n", priv1, priv2);
+
+    if (env->has_hv_mode) {
+        g_string_append_printf(buf, "    hypervisor irqs:%s\n",
+                !FIELD_EX64_HV(env->msr) || FIELD_EX64(env->msr, MSR, EE) ?
+                    "enabled" : "disabled");
+    }
+    g_string_append_printf(buf, "    supervisor irqs:%s\n",
+            FIELD_EX64(env->msr, MSR, EE) ? "enabled" : "disabled");
+
+    if (env->has_hv_mode) {
+        none = true;
+        g_string_append_printf(buf, "    pending hypervisor interrupts: ");
+        for (i = 0; i < 32; i++) {
+            uint32_t intr = (1U << i);
+            if (powerpc_is_hv_intr(intr) && (env->pending_interrupts & intr)) {
+                none = false;
+                g_string_append_printf(buf, "%s ", powerpc_intr_name(intr));
+            }
+        }
+        if (none) {
+            g_string_append_printf(buf, "none\n");
+        } else {
+            g_string_append_printf(buf, "\n");
+        }
+    }
+
+    none = true;
+    g_string_append_printf(buf, "    pending supervisor interrupts: ");
+    for (i = 0; i < 32; i++) {
+        uint32_t intr = (1U << i);
+        if (!powerpc_is_hv_intr(intr) && (env->pending_interrupts & intr)) {
+            none = false;
+            g_string_append_printf(buf, "%s ", powerpc_intr_name(intr));
+        }
+    }
+    if (none) {
+        g_string_append_printf(buf, "none\n");
+    } else {
+        g_string_append_printf(buf, "\n");
+    }
+}
+
 /*
  * system reset is not delivered via normal irq method, so have to set
  * halted = 0 to resume CPU running if it was halted. Possibly we should
-- 
2.47.1


