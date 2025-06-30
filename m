Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5960DC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEeg-00059d-Cs; Mon, 30 Jun 2025 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWEed-00054G-8E
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:34:39 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWEeZ-0000Vp-IA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:34:38 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d45b80368dso118119685a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751290473; x=1751895273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJHmyagZgSRthH9fu6ABDOGhNEkejt6dd0IXbVCsbQo=;
 b=V8yGCdr11XNig2/np5k5G2E7YY5ZlonS3OZMikYz/Z8c5efHBkN+YtxyDQj6gZUcPZ
 eLoC26tBKDSqEEgD2uXZyZp5kc0tE2+Yxomt7FXQPEu36DTRO9Dq033iJntMZSpupg+/
 a5bXqR4j5Hsw3LnxxeJ4P6O42anO0kFUxPpJlpaCUYjJw0Asid2Yw3HOeWbubsQb6zFZ
 t7TZ1f/SzTz64D8eHYAQw03+imAVXOhOXsSSUERLLxwEOlaKgmMfGPgH1HtyN1/yqsFN
 8G1APNSfsbCbNNd2E6Zi9sGHLGWxup9wDDdvrjiL7/OxHSldHyuBRzeUiYhNOWYwgiGv
 +2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751290473; x=1751895273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJHmyagZgSRthH9fu6ABDOGhNEkejt6dd0IXbVCsbQo=;
 b=sGsEHXigerqX/8kGMqX6W6Z+s64p3nx+X/Lk2TpYeE5GhlanwTqf9LzXYZddF7tcd8
 MbVYG2AJvqThHztF7SVlUVPm/VyvL3iducCoDFLRLWvlgWRUofLD1qrylMFDlTQnDjEc
 d/jgpHtUSeW5F5RjwDdOLWiJbCtfGJ2SWHcL9KAJCetH31QkL6/03Uool/IG7K+vTvcX
 EfjVqT+LxwWcHnsvifuuSnuSFWSsxDdmGKFgBMhCw+UMBvUEYRESY43nqBNu6/j70wZz
 ENMbrUh1/23A/hYY5pM9IMx++hJ+1z8bfsD6/2KP13uKuIYqDJOOtnMNWMyD6Aypzf1i
 b6TA==
X-Gm-Message-State: AOJu0YywyKUaM/QhvtbndJyq8oSrxyO7hbtnOgsn5o34M2KOna6xXpNo
 0Ip6b0SK40Y9+3xMLr+o1J5dCpy1S2A7SYmRvx5fhvNrM48OuQP5fdskYv02VUFC3aU3/ot2Jph
 4kMGt
X-Gm-Gg: ASbGnctRylRjyzFY3YGzvL0VnlA6UtnqnOZUl9LbOuj8mqga2VRBGz/3SoLXfClO7bE
 3bWecOocQ0WZogl/kdysx0TpEFZgV2WicX9fQoP6Nlm78zLBK+KKFjnaUd1M7JvnOU7mjHcCwAN
 +5XGzmmVVyoFaYbjX177GuTVrPgyBo6/RAEvCKvsnQ2pvi7TPes+AMgIZtD+cuzpDcQ2GluE8gs
 9THzKDowhuffIpP72HHw3Fm7DXG1x2crItnVULj4ze5Rl9XihIq03JbY9L+m0nhXWjaFdSRvwwl
 WUDe9PuKQG6ksx9gJ8vNpFNy95hBGOB7pM6vzCQj12nj7rhsqDTh9ePZKefNriQ=
X-Google-Smtp-Source: AGHT+IF/rkADL2Gvk3VHHG/Fl4omjLMNoohJZT5PxXM5S+otftNQYDBLH3OsM85JKpPCZVyEMh7YOg==
X-Received: by 2002:a05:620a:3f85:b0:7d2:265:c2c1 with SMTP id
 af79cd13be357-7d443969610mr2056103485a.27.1751289755138; 
 Mon, 30 Jun 2025 06:22:35 -0700 (PDT)
Received: from grind.. ([179.93.20.232]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45a7b35edsm203807785a.13.2025.06.30.06.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 06:22:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hmp-cmds-target, target/riscv: add 'info register'
Date: Mon, 30 Jun 2025 10:22:28 -0300
Message-ID: <20250630132228.1276838-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x729.google.com
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

The RISC-V target has *a lot* of CPU registers, with more registers
being added along the way when new extensions are added. In this world,
'info registers' will throw a wall of text that can be annoying to deal
with when the user wants to verify the value of just a couple of
registers.

Add a new 'info register' HMP command that prints a specific register.
The semantics, and implementation, is similar to what 'info registers'
already does, i.e. '-a' will print a register for all VCPUs and it's
possible to print a reg for a specific VCPU.

A RISC-V implementation is included via riscv_cpu_dump_register().

Here's an example:

Welcome to Buildroot
buildroot login: QEMU 10.0.50 monitor - type 'help' for more information
(qemu) info register mstatus

CPU#0
 mstatus  0000000a000000a0
(qemu) info register mstatus -a

CPU#0
 mstatus  0000000a000000a0

CPU#1
 mstatus  0000000a000000a0
(qemu)

The API is introduced as TARGET_RISCV only.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hmp-commands-info.hx         | 17 +++++++++++++
 hw/core/cpu-common.c         |  8 ++++++
 include/hw/core/cpu.h        | 11 +++++++++
 include/monitor/hmp-target.h |  1 +
 monitor/hmp-cmds-target.c    | 30 ++++++++++++++++++++++
 target/riscv/cpu.c           | 48 ++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee5..f3561e4a02 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -113,6 +113,23 @@ SRST
     Show the cpu registers.
 ERST
 
+#if defined(TARGET_RISCV)
+    {
+        .name       = "register",
+        .args_type  = "register:s,cpustate_all:-a,vcpu:i?",
+        .params     = "[register|-a|vcpu]",
+        .help       = "show a cpu register (-a: show the register value for all cpus;"
+                      " vcpu: specific vCPU to query; show the current CPU's register if"
+                      " no vcpu is specified)",
+        .cmd        = hmp_info_register,
+    },
+
+SRST
+  ``info register``
+    Show a cpu register.
+ERST
+#endif
+
 #if defined(TARGET_I386)
     {
         .name       = "lapic",
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca2..9c65ce1537 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -108,6 +108,14 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
     }
 }
 
+void cpu_dump_register(CPUState *cpu, const char *reg, FILE *f)
+{
+    if (cpu->cc->dump_register) {
+        cpu_synchronize_state(cpu);
+        cpu->cc->dump_register(cpu, reg, f);
+    }
+}
+
 void cpu_reset(CPUState *cpu)
 {
     device_cold_reset(DEVICE(cpu));
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 33296a1c08..b9ddce22bd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -160,6 +160,7 @@ struct CPUClass {
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
+    void (*dump_register)(CPUState *cpu, const char *reg, FILE *);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
@@ -693,6 +694,16 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
+/**
+ * cpu_dump_register:
+ * @cpu: The CPU whose register state is to be dumped.
+ * @reg: CPU register name to be dumped.
+ * @f: If non-null, dump to this stream, else to current print sink.
+ *
+ * Dumps CPU register state.
+ */
+void cpu_dump_register(CPUState *cpu, const char *reg, FILE *f);
+
 /**
  * cpu_get_phys_page_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbf..da9d690f89 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -57,6 +57,7 @@ void hmp_info_via(Monitor *mon, const QDict *qdict);
 void hmp_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_registers(Monitor *mon, const QDict *qdict);
+void hmp_info_register(Monitor *mon, const QDict *qdict);
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 8eaf70d9c9..43f509aa60 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -121,6 +121,36 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
     }
 }
 
+/*
+ * Based on hmp_info_registers().
+ */
+void hmp_info_register(Monitor *mon, const QDict *qdict)
+{
+    const char *reg = qdict_get_try_str(qdict, "register");
+    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
+    int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
+    CPUState *cs;
+
+    if (all_cpus) {
+        CPU_FOREACH(cs) {
+            cpu_dump_register(cs, reg, NULL);
+        }
+    } else {
+        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
+
+        if (!cs) {
+            if (vcpu >= 0) {
+                monitor_printf(mon, "CPU#%d not available\n", vcpu);
+            } else {
+                monitor_printf(mon, "No CPU available\n");
+            }
+            return;
+        }
+
+        cpu_dump_register(cs, reg, NULL);
+    }
+}
+
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
                         hwaddr addr, int is_physical)
 {
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3f8ecef68..8b3edf7b23 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -640,6 +640,53 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
+static void riscv_cpu_dump_register(CPUState *cs, const char *reg, FILE *f)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    bool match_found = false;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
+        RISCVException res;
+        target_ulong val = 0;
+        int csrno = i;
+
+        /*
+         * Early skip when possible since we're going
+         * through a lot of NULL entries.
+         */
+        if (csr_ops[csrno].predicate == NULL) {
+            continue;
+        }
+
+        /*
+         * We're doing partial register name matching,
+         * e.g. 'mhpm' will match all registers that
+         * starts with 'mhpm'.
+         */
+        if (strncasecmp(csr_ops[csrno].name, reg, strlen(reg)) != 0) {
+            continue;
+        }
+
+        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
+
+        /*
+         * Rely on the smode, hmode, etc, predicates within csr.c
+         * to do the filtering of the registers that are present.
+         */
+        if (res == RISCV_EXCP_NONE) {
+            if (!match_found) {
+                match_found = true;
+                qemu_fprintf(f, "\nCPU#%d\n", cs->cpu_index);
+            }
+
+            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                         csr_ops[csrno].name, val);
+        }
+    }
+}
+
 static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -2690,6 +2737,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->dump_state = riscv_cpu_dump_state;
+    cc->dump_register = riscv_cpu_dump_register;
     cc->set_pc = riscv_cpu_set_pc;
     cc->get_pc = riscv_cpu_get_pc;
     cc->gdb_read_register = riscv_cpu_gdb_read_register;
-- 
2.49.0


