Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273D5C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6b9-0001A1-TP; Thu, 06 Feb 2025 13:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b7-00019j-GT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b5-00013N-LO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GllRVwZqikZ6I8SMf3iZgKJhB7/mY0TuIcEQDqVnWg=;
 b=Rrt0SqARUlzSAP4I4LO1814kCPmDCKLUauZeekmDhk28SvrIFHG2tLiZU2TWxAf0/gxL2J
 tlX8g2cIHgz7iaz77S+LFxfio9P/f328UFXnXaa8raUSzOV8LncDb+4pSBtiCTBwYnctP8
 lj6qBML8XHvKvwNt1KuAVEpbK69akGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-k_bsiNLpMnG6EOOgr7UcoQ-1; Thu, 06 Feb 2025 13:27:29 -0500
X-MC-Unique: k_bsiNLpMnG6EOOgr7UcoQ-1
X-Mimecast-MFC-AGG-ID: k_bsiNLpMnG6EOOgr7UcoQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso9925775e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866448; x=1739471248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GllRVwZqikZ6I8SMf3iZgKJhB7/mY0TuIcEQDqVnWg=;
 b=k/M7sYQXrSj4zTBbTnL8BwOEwKpMw0R3PwgXN0ER5tNstrka0rVUHXAx150R1A5mkj
 udNnvVf3ab30AxHlWhqx9Cp5EAOXzoETHVtziZ5TXqOjctBQICmzLqCM25WdWjwlzgED
 tRnv15VMr7v2G+TGSYgwY5DyoGT00t/qQf2r8PVAFI4xlRcc9JxucQ1/yN2Lz7cE3kiA
 Ih9ffUOglcfysIpjcnDnh9PEiwJTA9z5zHbW3/+zJ5mZ7Zk6QzQ4chbI4pWielsZsDSm
 19RcLOEQE+hrmwe8AxlnFWgawsmVMOGDHcgCYYr301rsDdDIqJuJcMCVOR+UL+2QSMMl
 hNnQ==
X-Gm-Message-State: AOJu0YzRw+gZcdm92j29oRljHReniKMSnqfYFU7lEjqRCbugd7ethBHW
 opWbuSSqqbGJw6480L9N5EKVQpVpoztVq0noNOOZQvYJsIUmO4E7y7XtMWI1TrKRnoUDUr2Sit3
 3SoF4Uu/AFAgIDjjYAEniK6Jl2i+FpEUueNB3eoNBXm7B/6BIquCQio3gIT2GRqQ3WxOkD6eRE+
 p2dCbTJIBV0ghU5jYXcdvRPxC5h9KAyujLljlYSQM=
X-Gm-Gg: ASbGncu076upbqoh38GW58y1mDZeNVif/k0mo+2TP1DMeDY4qqsJ4wMcuA1n8nbEwnn
 dypdA3mprAjtuxM1WsWvaxdtUdhabCj4Rj6MK+EYirgYVffonEsEOWpBHTbaTnHoEqjEBztqOaw
 SnlM1Nu9ZXxAfw26BZmTcxR2/vDGMVqdrkIsybJiDcCC9KTDC2TTQwkOWLE8MMg2imh0IHnOhzi
 eEAVlCOYIu9ucxW2o1cIrOfvcf9e0I8XOW6hEtq8vv5rAYhCI5EWQM06phJviUwC4HzL9/vLfRT
 +ZKfkC4=
X-Received: by 2002:a5d:5f96:0:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-38dc937496bmr9359f8f.50.1738866447862; 
 Thu, 06 Feb 2025 10:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNz1GWZl59mNs7sjrOqXZ1GHXyKr7cCp7aQfBprVEfIDSKYXmb73BGCcAG8dYZQnLN7o7Ehg==
X-Received: by 2002:a5d:5f96:0:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-38dc937496bmr9344f8f.50.1738866447482; 
 Thu, 06 Feb 2025 10:27:27 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc7711bbbsm204063f8f.47.2025.02.06.10.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 06/22] target/riscv: add more RISCVCPUDef fields
Date: Thu,  6 Feb 2025 19:26:54 +0100
Message-ID: <20250206182711.2420505-7-pbonzini@redhat.com>
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

Allow using RISCVCPUDef to replicate all the logic of custom .instance_init
functions.  To simulate inheritance, merge the child's RISCVCPUDef with
the parent and then finally move it to the CPUState at the end of
TYPE_RISCV_CPU's own instance_init function.

STRUCT_FIELD is introduced here because I am not sure it is needed;
it is a bit ugly and I wanted not to have it in the patch that
introduces cpu_cfg_fields.h.inc.  I don't really understand why satp_mode
is included in RISCVCPUConfig; therefore, the end of the series includes
a patch to move satp_mode directly in RISCVCPU, thus removing the need
for STRUCT_FIELD; it can be moved before this one in a non-RFC posting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h                |  6 ++++
 target/riscv/cpu_cfg.h            |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  6 +++-
 target/riscv/cpu.c                | 48 ++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f757f0b6210..9b25c0c889b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -519,6 +519,12 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    uint32_t misa_ext;
+    int priv_spec;
+    int32_t vext_spec;
+    int satp_mode32;
+    int satp_mode64;
+    RISCVCPUConfig cfg;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ad02693fa66..07789a9de88 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -39,6 +39,7 @@ typedef struct {
 struct RISCVCPUConfig {
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x) type x;
+#define STRUCT_FIELD(type, x) type x;
 #include "cpu_cfg_fields.h.inc"
 };
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 56fffb5f177..cbedf0a703b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -4,6 +4,9 @@
 #ifndef TYPED_FIELD
 #define TYPED_FIELD(type, x)
 #endif
+#ifndef STRUCT_FIELD
+#define STRUCT_FIELD(type, x)
+#endif
 
 BOOL_FIELD(ext_zba)
 BOOL_FIELD(ext_zbb)
@@ -160,8 +163,9 @@ TYPED_FIELD(uint16_t, cbop_blocksize)
 TYPED_FIELD(uint16_t, cboz_blocksize)
 
 #ifndef CONFIG_USER_ONLY
-TYPED_FIELD(RISCVSATPMap, satp_mode);
+STRUCT_FIELD(RISCVSATPMap, satp_mode)
 #endif
 
 #undef BOOL_FIELD
 #undef TYPED_FIELD
+#undef STRUCT_FIELD
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index baf4dd017b2..1d999488465 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -74,6 +74,15 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, RISCVCPUConfig *src)
+{
+#define BOOL_FIELD(x) dest->x |= src->x;
+#define TYPED_FIELD(type, x) if (src->x) dest->x = src->x;
+    /* only satp_mode, which is initialized by instance_init */
+#define STRUCT_FIELD(type, x)
+#include "cpu_cfg_fields.h.inc"
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -432,7 +441,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -1476,6 +1485,24 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
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
+#ifndef CONFIG_USER_ONLY
+    if (riscv_cpu_mxl(env) == MXL_RV32 && mcc->def->satp_mode32 != RISCV_PROFILE_ATTR_UNUSED) {
+        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode32);
+    }
+    if (riscv_cpu_mxl(env) >= MXL_RV64 && mcc->def->satp_mode64 != RISCV_PROFILE_ATTR_UNUSED) {
+        set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode64);
+    }
+#endif
 }
 
 static void riscv_bare_cpu_init(Object *obj)
@@ -2968,6 +2995,25 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
+        if (def->satp_mode32 != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->satp_mode32 <= VM_1_10_SV32);
+            mcc->def->satp_mode32 = def->satp_mode32;
+        }
+        if (def->satp_mode64 != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->satp_mode64 <= VM_1_10_SV64);
+            mcc->def->satp_mode64 = def->satp_mode64;
+        }
+        mcc->def->misa_ext |= def->misa_ext;
+
+        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
     }
 
     if (!object_class_is_abstract(c)) {
-- 
2.48.1


