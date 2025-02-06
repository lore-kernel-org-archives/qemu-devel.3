Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5CEC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bi-0002B3-C3; Thu, 06 Feb 2025 13:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bg-00027Q-DJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bd-0001YN-VF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UeZ54cd4QT2QzCN3ymHN6MRSpqc20i7oyquy6KA3VTI=;
 b=Yz09Cu0LDLoajQzoKnxe6e6b6Y8Fgnrs5DsExW/lfsaYz4Yn+x05tEpm+p/e2FGIFxknf/
 snMJ5lueS7JA/I9UvDWxYGgAy2sLiAwGWK9Jc9Mqev5DobMvSOkoOM0feW6fBRJmyUz5qf
 FZ8QbL43NueX5rroTPrg+gydjagJfiY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-CWGIXMZ9PXigdMVU2NVMiQ-1; Thu, 06 Feb 2025 13:28:03 -0500
X-MC-Unique: CWGIXMZ9PXigdMVU2NVMiQ-1
X-Mimecast-MFC-AGG-ID: CWGIXMZ9PXigdMVU2NVMiQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso9850805e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866481; x=1739471281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeZ54cd4QT2QzCN3ymHN6MRSpqc20i7oyquy6KA3VTI=;
 b=rFjYy5h9saLZZCFoSbYl/H1awXLraMOALYU5iEr5nw/LXfg5+h6Dt/2smBz715xAHg
 szMmCp8ZBA1rgY0WLEiHFas99tpTB7WyEIpnMsZNeBy5dN35dkz1UgeLn+sSnd47hOAm
 rP02X1IYH1W4rKFS8PyvmBcKEc+O4nmIfW69WbQJQaTnKulW5pvmam2PzF0WR9PBNzHc
 ShusDonn/9i0eIxhglr8PbnRBsrlVldkvgFeuAxD6hl43VUk85FikkSs+wNSJDZAhxDV
 A5EKQZk5Hrhb06IbWRPf6b8mj7jcbKoUR4/yn3XsR9cF3use74jb8KAgxlnXJS4SXOYF
 TZ1A==
X-Gm-Message-State: AOJu0YzlGYadTAmTyZLEUzmACj6P91W7QLdlrzqZKhdMsuZEqfuIjpAd
 K457gSF8NBN8Hm0LUhB7tqvEx57SxUFI4zWYmJ0DU3oHEv2sPpMPCTAoodOaGFC37ugn0dG9E6L
 NKsHIpZsG95As5XihhFQ6ojfy8pwLFMZyT1u3RXzMWW/sAvFEb89h5xh+gW86FJLtPFfeshFmNl
 uoKIyuKt8fMxFJ6fHWzugqv5cGvbZL3nlns32V6pc=
X-Gm-Gg: ASbGncuGHkWS2rV5VpBz+JEMFAXrJ1CTd9vINVtHK1pTPZJFXhQfS7SVjdQdEga0hNF
 AZkjM3cVwhGFkOZ/IggoxgyNq6dOFmAajXPu8/u5xYFQ+OhXhAAUiggsZ7uIiPZlCYuXSLFkNDK
 fpcUqBc6xrJuFAGlbvc4xxHyDDUWYq+m/yaFfx49fU0UraVt6FNrOKm3bRP9SjZzz7UhjqoH/C0
 qqz8fuj/5LqBFbY3gYlCH+bcOFkmWrttYSWo5eGDoyXQdbg/5ZPpVM5lpjYT7Po7z1MOhghmB4H
 okEmZ2Q=
X-Received: by 2002:a05:600c:45ca:b0:438:a20b:6a2a with SMTP id
 5b1f17b1804b1-43924992049mr4964425e9.14.1738866481541; 
 Thu, 06 Feb 2025 10:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+7zd71QrkxBIb3BPYbVEWxknwIgl9+IDgQ6Qb08AJasCfk1fGysNioECv+LF/bXi8qdxZmQ==
X-Received: by 2002:a05:600c:45ca:b0:438:a20b:6a2a with SMTP id
 5b1f17b1804b1-43924992049mr4964105e9.14.1738866480874; 
 Thu, 06 Feb 2025 10:28:00 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1e034sm2328841f8f.89.2025.02.06.10.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 22/22] target/riscv: move SATP modes out of CPUConfig
Date: Thu,  6 Feb 2025 19:27:10 +0100
Message-ID: <20250206182711.2420505-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

They are never accessed together with the rest of the CPUConfig data,
so just store it in the ArchCPU struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h                | 16 +++++++++
 target/riscv/cpu_cfg.h            | 16 ---------
 target/riscv/cpu_cfg_fields.h.inc |  8 -----
 hw/riscv/virt-acpi-build.c        |  6 ++--
 hw/riscv/virt.c                   |  4 +--
 target/riscv/cpu.c                | 56 +++++++++++++++----------------
 target/riscv/csr.c                |  2 +-
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 8 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 00ec475fbba..7f6c4fd138c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -492,6 +492,21 @@ struct CPUArchState {
     uint64_t rnmi_excpvec;
 };
 
+/*
+ * map is a 16-bit bitmap: the most significant set bit in map is the maximum
+ * satp mode that is supported. It may be chosen by the user and must respect
+ * what qemu implements (valid_1_10_32/64) and what the hw is capable of
+ * (supported bitmap below).
+ *
+ * init is a 16-bit bitmap used to make sure the user selected a correct
+ * configuration as per the specification.
+ *
+ * supported is a 16-bit bitmap used to reflect the hw capabilities.
+ */
+typedef struct {
+    uint16_t map, init, supported;
+} RISCVSATPModes;
+
 /*
  * RISCVCPU:
  * @env: #CPURISCVState
@@ -508,6 +523,7 @@ struct ArchCPU {
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
+    RISCVSATPModes satp_modes;
 
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 07789a9de88..e9bf75730a6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -21,25 +21,9 @@
 #ifndef RISCV_CPU_CFG_H
 #define RISCV_CPU_CFG_H
 
-/*
- * map is a 16-bit bitmap: the most significant set bit in map is the maximum
- * satp mode that is supported. It may be chosen by the user and must respect
- * what qemu implements (valid_1_10_32/64) and what the hw is capable of
- * (supported bitmap below).
- *
- * init is a 16-bit bitmap used to make sure the user selected a correct
- * configuration as per the specification.
- *
- * supported is a 16-bit bitmap used to reflect the hw capabilities.
- */
-typedef struct {
-    uint16_t map, init, supported;
-} RISCVSATPMap;
-
 struct RISCVCPUConfig {
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x) type x;
-#define STRUCT_FIELD(type, x) type x;
 #include "cpu_cfg_fields.h.inc"
 };
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index cbedf0a703b..b8cadf02a4e 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -4,9 +4,6 @@
 #ifndef TYPED_FIELD
 #define TYPED_FIELD(type, x)
 #endif
-#ifndef STRUCT_FIELD
-#define STRUCT_FIELD(type, x)
-#endif
 
 BOOL_FIELD(ext_zba)
 BOOL_FIELD(ext_zbb)
@@ -162,10 +159,5 @@ TYPED_FIELD(uint16_t, cbom_blocksize)
 TYPED_FIELD(uint16_t, cbop_blocksize)
 TYPED_FIELD(uint16_t, cboz_blocksize)
 
-#ifndef CONFIG_USER_ONLY
-STRUCT_FIELD(RISCVSATPMap, satp_mode)
-#endif
-
 #undef BOOL_FIELD
 #undef TYPED_FIELD
-#undef STRUCT_FIELD
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1ad68005085..60e607d12ac 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -281,7 +281,7 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
-    if (cpu->cfg.satp_mode.supported != 0) {
+    if (cpu->satp_modes.supported != 0) {
         num_rhct_nodes++;
     }
 
@@ -341,8 +341,8 @@ static void build_rhct(GArray *table_data,
     }
 
     /* MMU node structure */
-    if (cpu->cfg.satp_mode.supported != 0) {
-        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    if (cpu->satp_modes.supported != 0) {
+        satp_mode_max = satp_mode_max_from_map(cpu->satp_modes.map);
         mmu_offset = table_data->len - table.table_offset;
         build_append_int_noprefix(table_data, 2, 2);    /* Type */
         build_append_int_noprefix(table_data, 8, 2);    /* Length */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 241389d72f8..41f0a9c4caf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -251,8 +251,8 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             s->soc[socket].hartid_base + cpu);
         qemu_fdt_add_subnode(ms->fdt, cpu_name);
 
-        if (cpu_ptr->cfg.satp_mode.supported != 0) {
-            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
+        if (cpu_ptr->satp_modes.supported != 0) {
+            satp_mode_max = satp_mode_max_from_map(cpu_ptr->satp_modes.map);
             sv_name = g_strdup_printf("riscv,%s",
                                       satp_mode_str(satp_mode_max, is_32_bit));
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 006d8696216..d9f06e3f0c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -78,8 +78,6 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, RISCVCPUConfig *src)
 {
 #define BOOL_FIELD(x) dest->x |= src->x;
 #define TYPED_FIELD(type, x) if (src->x) dest->x = src->x;
-    /* only satp_mode, which is initialized by instance_init */
-#define STRUCT_FIELD(type, x)
 #include "cpu_cfg_fields.h.inc"
 }
 
@@ -448,7 +446,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
 
     for (int i = 0; i <= satp_mode; ++i) {
         if (valid_vm[i]) {
-            cpu->cfg.satp_mode.supported |= (1 << i);
+            cpu->satp_modes.supported |= (1 << i);
         }
     }
 }
@@ -463,11 +461,11 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
      */
     if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_BARE_CPU) != NULL) {
         warn_report("No satp mode set. Defaulting to 'bare'");
-        cpu->cfg.satp_mode.map = (1 << VM_1_10_MBARE);
+        cpu->satp_modes.map = (1 << VM_1_10_MBARE);
         return;
     }
 
-    cpu->cfg.satp_mode.map = cpu->cfg.satp_mode.supported;
+    cpu->satp_modes.map = cpu->satp_modes.supported;
 }
 #endif
 
@@ -826,15 +824,15 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     uint8_t satp_mode_map_max, satp_mode_supported_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
-    if (cpu->cfg.satp_mode.supported == 0) {
+    if (cpu->satp_modes.supported == 0) {
         return;
     }
 
     satp_mode_supported_max =
-                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+                    satp_mode_max_from_map(cpu->satp_modes.supported);
 
-    if (cpu->cfg.satp_mode.map == 0) {
-        if (cpu->cfg.satp_mode.init == 0) {
+    if (cpu->satp_modes.map == 0) {
+        if (cpu->satp_modes.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
             set_satp_mode_default_map(cpu);
         } else {
@@ -844,11 +842,11 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
              * valid_vm_1_10_32/64.
              */
             for (int i = 1; i < 16; ++i) {
-                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
-                    (cpu->cfg.satp_mode.supported & (1 << i))) {
+                if ((cpu->satp_modes.init & (1 << i)) &&
+                    (cpu->satp_modes.supported & (1 << i))) {
                     for (int j = i - 1; j >= 0; --j) {
-                        if (cpu->cfg.satp_mode.supported & (1 << j)) {
-                            cpu->cfg.satp_mode.map |= (1 << j);
+                        if (cpu->satp_modes.supported & (1 << j)) {
+                            cpu->satp_modes.map |= (1 << j);
                             break;
                         }
                     }
@@ -858,7 +856,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
         }
     }
 
-    satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+    satp_mode_map_max = satp_mode_max_from_map(cpu->satp_modes.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
     if (satp_mode_map_max > satp_mode_supported_max) {
@@ -874,9 +872,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
      */
     if (!rv32) {
         for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-            if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
-                (cpu->cfg.satp_mode.init & (1 << i)) &&
-                (cpu->cfg.satp_mode.supported & (1 << i))) {
+            if (!(cpu->satp_modes.map & (1 << i)) &&
+                (cpu->satp_modes.init & (1 << i)) &&
+                (cpu->satp_modes.supported & (1 << i))) {
                 error_setg(errp, "cannot disable %s satp mode if %s "
                            "is enabled", satp_mode_str(i, false),
                            satp_mode_str(satp_mode_map_max, false));
@@ -887,8 +885,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 
     /* Finally expand the map so that all valid modes are set */
     for (int i = satp_mode_map_max - 1; i >= 0; --i) {
-        if (cpu->cfg.satp_mode.supported & (1 << i)) {
-            cpu->cfg.satp_mode.map |= (1 << i);
+        if (cpu->satp_modes.supported & (1 << i)) {
+            cpu->satp_modes.map |= (1 << i);
         }
     }
 }
@@ -968,11 +966,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
 static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
-    value = satp_map->map & (1 << satp);
+    value = satp_modes->map & (1 << satp);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -980,7 +978,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    RISCVSATPMap *satp_map = opaque;
+    RISCVSATPModes *satp_modes = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
 
@@ -988,8 +986,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    satp_map->map = deposit32(satp_map->map, satp, 1, value);
-    satp_map->init |= 1 << satp;
+    satp_modes->map = deposit32(satp_modes->map, satp, 1, value);
+    satp_modes->init |= 1 << satp;
 }
 
 void riscv_add_satp_mode_properties(Object *obj)
@@ -998,16 +996,16 @@ void riscv_add_satp_mode_properties(Object *obj)
 
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
         object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
         object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
-                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mode);
+                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index afb7544f078..1000fe1f07f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1862,7 +1862,7 @@ static RISCVException read_mstatus(CPURISCVState *env, int csrno,
 
 static bool validate_vm(CPURISCVState *env, target_ulong vm)
 {
-    uint64_t mode_supported = riscv_cpu_cfg(env)->satp_mode.map;
+    uint64_t mode_supported = env_archcpu(env)->satp_modes.map;
     return get_field(mode_supported, (1 << vm));
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 46cd8032c79..d30d9f427ab 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -693,7 +693,7 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
                                             RISCVCPUProfile *profile,
                                             bool send_warn)
 {
-    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    int satp_max = satp_mode_max_from_map(cpu->satp_modes.supported);
 
     if (profile->satp_mode > satp_max) {
         if (send_warn) {
-- 
2.48.1


