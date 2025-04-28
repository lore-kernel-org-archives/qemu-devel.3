Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F8C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1Z-0006KR-Ti; Mon, 28 Apr 2025 03:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1Q-0006DY-G5
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1O-0001CG-7O
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AczQQ33dOcPVWVkSR/LhT954/DWhM7eEqSQ3hB8gI+Y=;
 b=WfnfxCweL2q9RCmfE1FKYfyqSsrxbFNwjWIkzKm3M3P9pW4RNCyt8c1WfJdise8ii8n6o8
 JOO3fxSZxKO9OvJdPz6gdcLDcU66rJqtr0By+VLB3tyZYPtO0tO3eleMLiTXqWTIeVrRVz
 U11iML/YSV8Xwclc3G/K+3aqkTWeDlY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-rg4zjWIpM4Ob6IN986sQ9w-1; Mon, 28 Apr 2025 03:35:18 -0400
X-MC-Unique: rg4zjWIpM4Ob6IN986sQ9w-1
X-Mimecast-MFC-AGG-ID: rg4zjWIpM4Ob6IN986sQ9w_1745825717
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c184b20a2so1398802f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825716; x=1746430516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AczQQ33dOcPVWVkSR/LhT954/DWhM7eEqSQ3hB8gI+Y=;
 b=vgMJCzVZadlrhlWYKrLpkPeokpC8kSNxTT4YLbUl3Hx4iLMezJOXEi6OYQ/c8Bi7+p
 PWOSMaHop233a94TmRvYbWdWS0Uax+p812d6At6HF2z+eBR1X7gXpqmkShQvXAHMWNEk
 BKkxsy+MlZWYz+w5ZGhybAMddBIi9o9eHCS6VB/B8GTmQFz8TigksQI/485SsAjL/XfE
 Ka9KzVwFyxzOtodRkwHmW6AYLSVyHtxvTbPhnP+ZJ2OUt5GSh2ro2bICJ2DjvIBPrlwp
 oGR/1sndfvZJ6v7l71vLccjCKReb2EoJKHky6P35DKV7xnZLE8Tt09iYCcTR0N9Gz0fz
 nyGQ==
X-Gm-Message-State: AOJu0YybEWTBhp3c8YmBaL746tFGsyR+ysornoVzjTMmrmT6tXQPbjIF
 v2vS6uORIyIlBIGamvXVnvIjxZgpcJtsREeQSC8ORgLM+8qL+39I5oLNTk8K7fyR5nWxwxq2uEZ
 hyJfOdolMcTFJ7N4lcVDLdIoVJotxtB6TdDm81NfMFC6HAJYI2jpvD4xce3d9aVMngyO+W9jxxm
 oW7zh7JEdJmdoiSwG93h/SzIt1gd286SSs1DTU
X-Gm-Gg: ASbGncst0DVFaplRXsJfKnF/MTaOWA4YssEv/RivpFE1v02q8uPLUJOO4nGKW2bRUfI
 nsIc8LcKsGvHZObcmxPxboHeDryjxgnMy/nsO3N7KhQep+TiQ1eIVCfbhpyVkaGAdrlRlCWsbAn
 YAo2clx1qZ5WgZ7YAgZVh1dhTpy9mezdK4u0QOGPIfZ2gR3l4NHdMXqtDowXXLgK9l5oXBVif3Q
 9O+jvb0IiJAOAr8Az0py14U+GmzVAFLb4td+z5z0X/NneMsZ6iwT0Nt7zcCkStluv8gTiBCp4d5
 LlxlIXUwyjttNfs=
X-Received: by 2002:adf:ec87:0:b0:39c:1257:c96f with SMTP id
 ffacd0b85a97d-3a07adb1766mr4206273f8f.59.1745825716024; 
 Mon, 28 Apr 2025 00:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZsw+qjimAYNtW9HD0kljb/W6caZ+A/vrXcPNCi3ul1UrqhJKFVJoj+V+/Nvr2Fe8ncn96uQ==
X-Received: by 2002:adf:ec87:0:b0:39c:1257:c96f with SMTP id
 ffacd0b85a97d-3a07adb1766mr4206226f8f.59.1745825715603; 
 Mon, 28 Apr 2025 00:35:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca543bsm10395966f8f.34.2025.04.28.00.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 12/26] target/riscv: add more RISCVCPUDef fields
Date: Mon, 28 Apr 2025 09:34:27 +0200
Message-ID: <20250428073442.315770-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Allow using RISCVCPUDef to replicate all the logic of custom .instance_init
functions.  To simulate inheritance, merge the child's RISCVCPUDef with
the parent and then finally move it to the CPUState at the end of
TYPE_RISCV_CPU's own instance_init function.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  4 ++++
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  6 ++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 842c9d3f194..5015763b7f4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -539,6 +539,10 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    uint32_t misa_ext;
+    int priv_spec;
+    int32_t vext_spec;
+    RISCVCPUConfig cfg;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0beaed2f340..de831c8004d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -74,6 +74,13 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
+{
+#define BOOL_FIELD(x) dest->x |= src->x;
+#define TYPED_FIELD(type, x, default_) if (src->x != default_) dest->x = src->x;
+#include "cpu_cfg_fields.h.inc"
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -435,7 +442,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -1480,6 +1487,16 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
+
+    env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
+    riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
+
+    if (mcc->def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.priv_ver = mcc->def->priv_spec;
+    }
+    if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.vext_ver = mcc->def->vext_spec;
+    }
 }
 
 static void riscv_bare_cpu_init(Object *obj)
@@ -3088,6 +3105,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
         }
+        if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->priv_spec <= PRIV_VERSION_LATEST);
+            mcc->def->priv_spec = def->priv_spec;
+        }
+        if (def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->vext_spec != 0);
+            mcc->def->vext_spec = def->vext_spec;
+        }
+        mcc->def->misa_ext |= def->misa_ext;
+
+        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3194,6 +3222,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3204,6 +3235,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3214,6 +3248,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3224,6 +3261,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 41b6f34552a..644b05988af 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2004,10 +2004,16 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
         .class_data = &((const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV32,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #elif defined(TARGET_RISCV64)
         .class_data = &((const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV64,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #endif
     }
-- 
2.49.0


