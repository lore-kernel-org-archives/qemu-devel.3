Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B719BC369D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1g-0006OT-9w; Mon, 28 Apr 2025 03:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1a-0006Kd-0o
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1X-0001E5-6u
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tK3EkYYpgKbS5XRPB8ZZmBre6mMLsPoslKj2QtUM8fE=;
 b=f1OcBwazSRNFTGUypWjSarhJ+JQ44Ojj+2ewEl+cBmQ4VCGt5WSpp4IlX94Egyg82PLpc6
 wwZdrpdMHHGxuyqrnAbw+7N6Gqawivpn5LDSCEFnrcEjIj/B3HFEsd+6rdn+u062a3cbhD
 gZF6RrJ6gfK8JzHwOSyB2G35pc9T2tE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-NbTzgj1PPZ2H4cO1df8BhQ-1; Mon, 28 Apr 2025 03:35:28 -0400
X-MC-Unique: NbTzgj1PPZ2H4cO1df8BhQ-1
X-Mimecast-MFC-AGG-ID: NbTzgj1PPZ2H4cO1df8BhQ_1745825727
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cec217977so22179815e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825726; x=1746430526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tK3EkYYpgKbS5XRPB8ZZmBre6mMLsPoslKj2QtUM8fE=;
 b=jm+kLAbtzZ5P5zUgT4zkX+33YWBey+2L2xV2x6IDfHHkEjuxSKJYyxpPs2KjzN4C5V
 5XVL6fk0sYUogh/5gwXS2/77RIa169owHtBOCz4xTkYAYEmMgP2Lh8mtijRErx+7LZAr
 hnTo+/L1V9z/3NudUOZa3fazyHMXS9Slrcx19Iy+Z9pMVoaxDkEbVCvYi5BTCyDyb1t4
 x8G1w2WR+OQlQXoxZcq7p+lM7XhnoxzAcMjiWINE18nsYPTCZ4GmZ4kiSsJzSVUOSlLN
 7MhIyLvY9f8uVxbVw2eN4FvhRy55sD25LJBMtIi92Q7bhwAAM476Esp9vUvxdJGgsZB9
 fEAg==
X-Gm-Message-State: AOJu0YwGyms3h1N9K4cxzAIdMwfo6lYZwPDA2orZmWadVReP0IQQEnaC
 CVAJBn4b3d34yIKv40Vp2OAcQMIHv30tmV88qKiBuh3ncAevXzKN47gVPXnBD+Qdt5gJEXh36gw
 6u3NcIO6k0+faNWJvxgmn8ZP1zjPADyHvmyv54jAdeKqNJY1P1iNnKyPcEKzKEZktHKl3W4kjQu
 Vwl+tFdRoK3IwFWPFN9SoJ/UW+w1TbHbwPwNcO
X-Gm-Gg: ASbGncsqqQVN4z58O5QFjCocnQYUT2iivO0wb+Ko8m+NgGCmSQvPxokRFzpqi9kITSB
 bg+WF4BggIwmmCVqd/aOuk4CZw7QzurUWpMoBjazQDxQ1dRCA8psZpvPSyamYIz+kBkFDj/MXoo
 +gq0/uk/tyI/kywbzIGIV0q6P6a+3dt9rYT0ewvKsloqTJP1LCWNPmpi0moRsF4J13g/2ULBRf0
 VJnXhOn/pgTaMwioJD9cSsJrZ3G11M99ft4T6n+6vxOdteSLnIMUUkzWh3yZqmFyk/kkc67zh9R
 f1iXhLGBg8qmMb0=
X-Received: by 2002:a05:600c:34c7:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-440ab8713a1mr58368525e9.27.1745825726192; 
 Mon, 28 Apr 2025 00:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjPHPKbyo/ZaNtp11oDDtBaLL8idhoxOWJjxmYNpq0UmWnvkqzXTDPH8PiJ95QTDMmb231Ww==
X-Received: by 2002:a05:600c:34c7:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-440ab8713a1mr58368215e9.27.1745825725720; 
 Mon, 28 Apr 2025 00:35:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2aab65sm145954045e9.17.2025.04.28.00.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 16/26] target/riscv: convert dynamic CPU models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:31 +0200
Message-ID: <20250428073442.315770-17-pbonzini@redhat.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 113 +++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 82 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 93992be6c4d..56f292a3616 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -486,38 +486,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-static void riscv_max_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-}
-
 #if defined(TARGET_RISCV64)
-static void rv64_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
-}
-
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -718,41 +687,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-static void rv128_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-}
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
 
-static void rv32_base_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-    /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_LATEST;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-}
-
 static void rv32_sifive_u_cpu_init(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
@@ -3167,19 +3106,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
-        .instance_init = (initfn),                          \
-        .class_data = &((const RISCVCPUDef) {               \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        }),                                                 \
-    }
-
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3236,7 +3162,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_base_init = riscv_cpu_class_base_init,
     },
 
-    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+        .priv_spec = PRIV_VERSION_LATEST,
+    ),
+
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
         /*
@@ -3264,15 +3195,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV32,
+        .cfg.max_satp_mode = VM_1_10_SV32,
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
 #endif
+    ),
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
@@ -3289,11 +3228,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
 #endif
 
 #if defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
@@ -3303,8 +3249,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
-#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV128,
+    ),
+#endif /* CONFIG_TCG */
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI
-- 
2.49.0


