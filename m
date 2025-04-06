Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B5C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K31-00038r-J7; Sun, 06 Apr 2025 03:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2c-0002vN-JG
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2a-00021y-RN
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoNLI/2Y96+YivIGstEd6MSnCVroqZK0PcZgw6HUGCg=;
 b=UN5M6yiS1zIh2naB8U4798Wu+xxy+oetig2ScNGgCsp5XOpUIGwblP6Nz569mFXlHYvS5A
 TrVastWIUaVVwkJvzf8o66VlTn7gjDpZPkGtmh6+lx6WOpc0eFJaIhoGWzugT9MUTWF+yr
 jMU/+mvKyLNCzFT7iqZZWUIjCQDiri0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-KsUWZwm-OnOGoCWTXlAidA-1; Sun, 06 Apr 2025 03:03:34 -0400
X-MC-Unique: KsUWZwm-OnOGoCWTXlAidA-1
X-Mimecast-MFC-AGG-ID: KsUWZwm-OnOGoCWTXlAidA_1743923013
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so25596115e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923012; x=1744527812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoNLI/2Y96+YivIGstEd6MSnCVroqZK0PcZgw6HUGCg=;
 b=OA5o28qvpU3Ar4k+xiOoD1ufVwI9FOBR2ftgQQQ55PTFeJESBxKnxV4a2LGsgrC8lN
 OSmaivZmAv6Ta5MIKcLGaqec6Iu5w5aI2tUr3dYnO352wVVZADfsmKUnG15snR4R2cDZ
 KRjMmp8ComCsWebcb+8BJy59y3sHtsYQtJZHNi5hA6QrHbYoo3ztmnoAuLn5WxE+LNOM
 qmbRiOZJTswpf/vb8I2zihXKTiCNJz2WZ0aUVTfCGA3Yzn93FVC8nXNh8BRD33TEB8K8
 QpFb3s+COf7e483dgcdWpuNTWATzf0fBEmN4hNt2aY0yDi/Alx/4ffC2elqKedSGeP2E
 DSRA==
X-Gm-Message-State: AOJu0YyLRTOCfa8Q7JQk313n9vn3NKZBGx/S9KgWZHFYHmt57x2gCbt4
 abLZODhz/o4bCuRVwtOFccU1XkR6xjHVoirelD0CCMUuRanI8Qj+51vw1MN042qawNTyuS00KRe
 0KL83pr7FkMX7KdzkYiIiuBYgKjyiDLCLMhqvW2HJQn9Ue9AILUYE0E+W/yr6luwsaQtq+m4awk
 +rPd0dcPSIXe2GWmiABwKWKyr5um8cn3Bb93a7
X-Gm-Gg: ASbGncsxzo13BSTg0sdVg+d7Ul9F069GLThtRwsag8iqUqsuWaB5VJysCxKvOF6dd3W
 5m5n5OfV9R+6fGciB3wb6ft9/FT2ASZTgzluAv4CZlEX61PICgTj+pcwBkiYZHUi0LxJyhZ6U5Y
 onp2sB265LNxL/vpmlHOV8WoplwJ9usufpP9IO/uD1xGOm+L0CeqpkoyTHbNTmJZr+1RCpPKT1H
 hJV7sQ0vzPaY/q65mhY6HI3xZpmAq6bI2w0bPMeac1cw/+g7NMndhqTapR75lTe4LoFFgA4ns6x
 r8Bhjfdaj8jiHDBcLw==
X-Received: by 2002:a05:600c:1387:b0:43c:f513:9585 with SMTP id
 5b1f17b1804b1-43ed0bde88amr85811875e9.13.1743923011777; 
 Sun, 06 Apr 2025 00:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/4ZNI32zMLjSaZBDs7veXmnN6BdWHgHDI4Fi2/1WZM10YVtWBlaD50KMWKj72Gz2qRpgU1Q==
X-Received: by 2002:a05:600c:1387:b0:43c:f513:9585 with SMTP id
 5b1f17b1804b1-43ed0bde88amr85811525e9.13.1743923011329; 
 Sun, 06 Apr 2025 00:03:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a3dfsm93649965e9.4.2025.04.06.00.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 13/27] target/riscv: add more RISCVCPUDef fields
Date: Sun,  6 Apr 2025 09:02:40 +0200
Message-ID: <20250406070254.274797-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  4 ++++
 target/riscv/cpu.c         | 42 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  6 ++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9bbfdcf6758..acaa49b979c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -543,6 +543,10 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    uint32_t misa_ext;
+    int priv_spec;
+    int32_t vext_spec;
+    RISCVCPUConfig cfg;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2c2a6a4b44a..620641fbed6 100644
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
@@ -1487,6 +1494,16 @@ static void riscv_cpu_init(Object *obj)
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
@@ -3093,6 +3110,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
@@ -3199,6 +3227,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3209,6 +3240,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3219,6 +3253,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
@@ -3229,6 +3266,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         }),                                                 \
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d7e6970a670..02bcb72cbb3 100644
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


