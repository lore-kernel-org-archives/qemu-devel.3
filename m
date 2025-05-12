Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E479C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPr6-0007dQ-Oj; Mon, 12 May 2025 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPr1-0007cl-Cv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqz-0000hu-HC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2GOosq1QAk+nmWmd2CR004eJ/M8Ta3nFkhlOEQYl4E=;
 b=TwnSUiRRulo07bCogyh8Fpep3jqAuMLjPrpPcKa7UZrDvIWpinkQZDpi90PPuYPKvgFEVL
 fEu8AVvzhWBhBe/bz5DNJf16FVtQ2bvtMUooaA4lnS5GAoLPtwH44sD2FUcddzfmpWUIMj
 2ndY/cYyyecEqKdkIndiV3CazfPqHAE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-A0NUGSPRNX6D7lcRYYEjoQ-1; Mon, 12 May 2025 05:53:43 -0400
X-MC-Unique: A0NUGSPRNX6D7lcRYYEjoQ-1
X-Mimecast-MFC-AGG-ID: A0NUGSPRNX6D7lcRYYEjoQ_1747043622
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fbecca2c90so3349160a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043621; x=1747648421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2GOosq1QAk+nmWmd2CR004eJ/M8Ta3nFkhlOEQYl4E=;
 b=KYpXkQ/AYbfQKcg3D97hW0lY1qs8hBaFL0yByqw4rsEvaFiqksN9xXaUvdQehCcQ9j
 NnxcAS4OWB73HyJ+FHIl/CsZEAOIPX9xVkvjr5vJy2Bau4j8MJbjkjolrPUI00//iHyg
 lRS4OI53RsT/bObP99hsu1iivDrznprCuPynCcy9VUFyRZU+XT+QY0lXIVPZEo5Ceydb
 +WwH1pu5tzyxav/GnCfWOSRxaniMEx9Zb40AaVGP/j8cxZV1Gaw3opinK3e4iGX2lwIy
 MDHvs13DdV51/S2pKnsEIHVdLii7gVhVWn5HG/ZriSgtZcp9qrr3zz5+c7AOw2X2kOTr
 PCZA==
X-Gm-Message-State: AOJu0YyX1KQsZ4MREkZUUkKo2pcGVnWeb58M7vMqOQ3oiKTiZAlsuRU6
 hDHHCShFxZGHNmyn8aVY+toEvkIGcIQ/DgKB2pjv6Zsc126IwhmVI9iwjVBYAEZurTr5jYWvhlW
 5HGFQcloinHmSL8jH/T87Xz3yBeNyZbBVAKhAZnS4CyVI9WV0VThLSCp3m8SN92BeYSk205PLry
 bdRrYSiI8X80JTp5UyeWl9J0O8+/0YKrx1XprT
X-Gm-Gg: ASbGnctLxAJ09MsN65gWnkyygEy0dT129doYEoO+cJn8puA2p4g2V3uPD4WyWldKcW9
 m6q0zsdR/JvGDAUZl5nY5Bfh/SogOp0YTYMvUwHl/FDXmQYH7U656HlEoWMvbp8U2KSAud+F+wO
 uAy08IPDUE8o94ZOVoMg73pgvKsvtmIJEYnpisljHrKmnCbDHSAOO5g1KxQD7RavmSZKkIXTbuv
 BvxhcJi8eLYRvtGSMpqKqjanRZAwp7C8RAyMtQD9Al8IuSqAjo+RjnFTsDY6LGpWwBFyi7izbvX
 /Tmct7rDMBWWa8AHgSRqAWgaCivbx7rPu4hP/gOfde5UK+A=
X-Received: by 2002:a05:6402:2711:b0:5fd:1971:6d85 with SMTP id
 4fb4d7f45d1cf-5fd19716d88mr4866552a12.5.1747043621504; 
 Mon, 12 May 2025 02:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEklu93u8w7oNIk9qyZKD0m/ERxN2rTiQxTpd6iqbIMYGqRlsjryapYmlX/AiYRAXOqlsDefQ==
X-Received: by 2002:a05:6402:2711:b0:5fd:1971:6d85 with SMTP id
 4fb4d7f45d1cf-5fd19716d88mr4866534a12.5.1747043621048; 
 Mon, 12 May 2025 02:53:41 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9d700590sm5631176a12.59.2025.05.12.02.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 11/26] target/riscv: add more RISCVCPUDef fields
Date: Mon, 12 May 2025 11:52:11 +0200
Message-ID: <20250512095226.93621-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index 7edefc80d73..f9ba305e3ad 100644
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
index ddade8a4370..7864c7e27c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,13 @@ bool riscv_cpu_option_set(const char *optname)
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
 
@@ -434,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -1479,6 +1486,16 @@ static void riscv_cpu_init(Object *obj)
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
@@ -3087,6 +3104,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
@@ -3193,6 +3221,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3203,6 +3234,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3213,6 +3247,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
@@ -3223,6 +3260,9 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .instance_init = (initfn),                          \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
         },                                                  \
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cd82b29567c..03f9b36f0c3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2004,10 +2004,16 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
         .class_data = &(const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV32,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #elif defined(TARGET_RISCV64)
         .class_data = &(const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV64,
+            .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .vext_spec = RISCV_PROFILE_ATTR_UNUSED,
+            .cfg.max_satp_mode = -1,
         },
 #endif
     }
-- 
2.49.0


