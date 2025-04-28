Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3622BC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1Q-0006Dj-K2; Mon, 28 Apr 2025 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J13-0005eG-NG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J11-0000x0-5n
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfwR/a21SWY9F6iegkDWjLKEBUAAM/iuKQlRukGNYto=;
 b=ipU202+9I0Llr70sQ1KzAwwGO9vLG0cnPUQreRmruB5cWRexjjsUwoSErytCU6fdZCe9I3
 053qY022p3MVlzF/7hXF988K42bRhhpmcTtVa80VIg2l01FMbZSdfmTLedmAzWfMIThDgX
 L+YNuNW3CgQfffjScAcuuFZKU2AK4zs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-8fTtbP6wM4-uUPssmrwluQ-1; Mon, 28 Apr 2025 03:34:56 -0400
X-MC-Unique: 8fTtbP6wM4-uUPssmrwluQ-1
X-Mimecast-MFC-AGG-ID: 8fTtbP6wM4-uUPssmrwluQ_1745825695
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so1887318f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825694; x=1746430494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zfwR/a21SWY9F6iegkDWjLKEBUAAM/iuKQlRukGNYto=;
 b=Hd8W1F39iI/GXsYqsIxY7NJcLoZT44v79siL5MvxoaU05W8p4+Wfx7v4K/GjFvmqbN
 7bsGVR30KCG+8dpLZtCz6eWGfUlDiJP0PeAzxfcVRRROKpZ/Ygm47lnyu0E6hx/fmEGA
 Q7cTC7U99Y3XYmbxCZ7iGXW2gDLxVWndLe5D9GHbzCVkhlszvY2ZZYMGdvIiReF+fRZx
 pwvjr4KedPhpRBOEliFVYe+6TjZj68QsLou597ZkV9yKUzt5cshUTXEl8ZPbFnTObQpI
 Ud7TEjT8eEAobuJrvenaea0OK2U1nGtnQTwzL6vIHSGa+QLMOdE1DAHal62rxyk+oF01
 bNmQ==
X-Gm-Message-State: AOJu0YyG2q/9Pfva6PvDT/JmrIayKzjuCgm+D9ZTCnKBb5zHhgYj/S5s
 jbCfKMKR18lLwFb8RXLCzagw6FVYoW2dxYdf0f4+0EOZ8sJmFg+PUd2/ZMbkOmML+ZXBfdrynNb
 d3NWtj+4Y0S+4/Sa6cwwni7Y6yVTuQ+51B5GZHv8lF6SkiUvjYdfXXGLGHdXmOulI9b6DcyGfUE
 SMcerHOagYqyUBujBF80+RfVmpBqNkeYNruPAG
X-Gm-Gg: ASbGnctCiq5HD7EH9ej4PJu1YHzP5eLmdtQXsNoCyu7Oy/aKPSDYBMt+YjRTJRiMmHi
 92nGWkq1QkOJjy00ZN35wbb3oLSvzD5RM+D/SngXrPUuX3MS2LHRrvuhihNbnS0tyheVZTME+rv
 ARVR97kaUh/YtseOc4GzaePW7Ahul5qZQvRt4uXAT/rfs5gGo3wwxkpoDByAI4zcCOXPJOxWr5K
 FbQN1ZYOMKJ03DiCsxf59N5nQS8s45CWpvsqeeaXnDdkxD7UGwk1etRf83tszu5yre0G/6fjvp4
 JQp6fRYtg/TCLYw=
X-Received: by 2002:a05:6000:144b:b0:3a0:7c88:8f02 with SMTP id
 ffacd0b85a97d-3a07c888f61mr6024694f8f.1.1745825694256; 
 Mon, 28 Apr 2025 00:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJnMm0x3WHtNnXoq140Kf2vkGMwKwlMhT+PD7yS8UiJgCHX71a5XMFQlFD2rUdivfGj7obJg==
X-Received: by 2002:a05:6000:144b:b0:3a0:7c88:8f02 with SMTP id
 ffacd0b85a97d-3a07c888f61mr6024669f8f.1.1745825693849; 
 Mon, 28 Apr 2025 00:34:53 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408c8b0ea0sm100588715e9.2.2025.04.28.00.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 04/26] target/riscv: update max_satp_mode based on QOM
 properties
Date: Mon, 28 Apr 2025 09:34:19 +0200
Message-ID: <20250428073442.315770-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Almost all users of cpu->cfg.satp_mode care about the "max" value
satp_mode_max_from_map(cpu->cfg.satp_mode.map).  Convert the QOM
properties back into it.  For TCG, deduce the bitmap of supported modes
from valid_vm[].

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  1 -
 hw/riscv/virt-acpi-build.c | 14 +++++---------
 hw/riscv/virt.c            |  5 ++---
 target/riscv/cpu.c         | 27 ++++++++++-----------------
 target/riscv/csr.c         |  9 +++++++--
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 167909c89bc..4f3668012de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -931,7 +931,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask);
 
-uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
 /* Implemented in th_csr.c */
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 2b374ebacbf..1a92a84207d 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -261,7 +261,6 @@ static void build_rhct(GArray *table_data,
     uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
-    uint8_t satp_mode_max;
     bool rv32 = riscv_cpu_is_32bit(cpu);
     g_autofree char *isa = NULL;
 
@@ -282,8 +281,7 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
-    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
-        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
+    if (!rv32 && cpu->cfg.max_satp_mode >= VM_1_10_SV39) {
         num_rhct_nodes++;
     }
 
@@ -343,20 +341,18 @@ static void build_rhct(GArray *table_data,
     }
 
     /* MMU node structure */
-    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
-        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
-        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    if (!rv32 && cpu->cfg.max_satp_mode >= VM_1_10_SV39) {
         mmu_offset = table_data->len - table.table_offset;
         build_append_int_noprefix(table_data, 2, 2);    /* Type */
         build_append_int_noprefix(table_data, 8, 2);    /* Length */
         build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
         build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
         /* MMU Type */
-        if (satp_mode_max == VM_1_10_SV57) {
+        if (cpu->cfg.max_satp_mode == VM_1_10_SV57) {
             build_append_int_noprefix(table_data, 2, 1);    /* Sv57 */
-        } else if (satp_mode_max == VM_1_10_SV48) {
+        } else if (cpu->cfg.max_satp_mode == VM_1_10_SV48) {
             build_append_int_noprefix(table_data, 1, 1);    /* Sv48 */
-        } else if (satp_mode_max == VM_1_10_SV39) {
+        } else if (cpu->cfg.max_satp_mode == VM_1_10_SV39) {
             build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
         } else {
             g_assert_not_reached();
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index be1bf0f6468..719365a95e0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -237,10 +237,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
     uint32_t cpu_phandle;
     MachineState *ms = MACHINE(s);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
-    uint8_t satp_mode_max;
 
     for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
         RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
+        int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
         g_autofree char *cpu_name = NULL;
         g_autofree char *core_name = NULL;
         g_autofree char *intc_name = NULL;
@@ -252,8 +252,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             s->soc[socket].hartid_base + cpu);
         qemu_fdt_add_subnode(ms->fdt, cpu_name);
 
-        if (cpu_ptr->cfg.satp_mode.supported != 0) {
-            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
+        if (satp_mode_max != -1) {
             sv_name = g_strdup_printf("riscv,%s",
                                       satp_mode_str(satp_mode_max, is_32_bit));
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ba57685a66..33a36a24737 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -390,7 +390,7 @@ static uint8_t satp_mode_from_str(const char *satp_mode_str)
     g_assert_not_reached();
 }
 
-uint8_t satp_mode_max_from_map(uint32_t map)
+static uint8_t satp_mode_max_from_map(uint32_t map)
 {
     /*
      * 'map = 0' will make us return (31 - 32), which C will
@@ -456,15 +456,13 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
     /*
      * Bare CPUs do not default to the max available.
      * Users must set a valid satp_mode in the command
-     * line.
+     * line.  Otherwise, leave the existing max_satp_mode
+     * in place.
      */
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
         warn_report("No satp mode set. Defaulting to 'bare'");
-        cpu->cfg.satp_mode.map = (1 << VM_1_10_MBARE);
-        return;
+        cpu->cfg.max_satp_mode = VM_1_10_MBARE;
     }
-
-    cpu->cfg.satp_mode.map = cpu->cfg.satp_mode.supported;
 }
 #endif
 
@@ -1176,8 +1174,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     bool rv32 = riscv_cpu_is_32bit(cpu);
     uint8_t satp_mode_map_max;
 
-    /* The CPU wants the OS to decide which satp mode to use */
-    if (cpu->cfg.satp_mode.supported == 0) {
+    if (cpu->cfg.max_satp_mode == -1) {
+        /* The CPU wants the hypervisor to decide which satp mode to allow */
         return;
     }
 
@@ -1196,14 +1194,14 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
                     (cpu->cfg.satp_mode.supported & (1 << i))) {
                     for (int j = i - 1; j >= 0; --j) {
                         if (cpu->cfg.satp_mode.supported & (1 << j)) {
-                            cpu->cfg.satp_mode.map |= (1 << j);
-                            break;
+                            cpu->cfg.max_satp_mode = j;
+                            return;
                         }
                     }
-                    break;
                 }
             }
         }
+        return;
     }
 
     satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
@@ -1233,12 +1231,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    /* Finally expand the map so that all valid modes are set */
-    for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-        if (cpu->cfg.satp_mode.supported & (1 << i)) {
-            cpu->cfg.satp_mode.map |= (1 << i);
-        }
-    }
+    cpu->cfg.max_satp_mode = satp_mode_map_max;
 }
 #endif
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c52c87faaea..038be009c82 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1906,8 +1906,13 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
-    uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
-    return get_field(mode_supported, (1 << vm));
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    RISCVCPU *cpu = env_archcpu(env);
+    int satp_mode_supported_max = cpu->cfg.max_satp_mode;
+    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
+
+    assert(satp_mode_supported_max >= 0);
+    return vm <= satp_mode_supported_max && valid_vm[vm];
 }
 
 static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
-- 
2.49.0


