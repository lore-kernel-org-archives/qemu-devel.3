Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6337C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnz-00019o-0Y; Tue, 20 May 2025 07:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnv-0000yv-8x
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKns-0003IY-HG
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl0LCbPEvchG6572FkpZMEourGBm16C5tJpn9HWtYJc=;
 b=Ci1p4ZX94WBU2SfYFtRto+kS1VcAGuGKTN8yo9TbnxxNaZ7PQYPs30+QLd5uUe31HS27lC
 nAlBJhwytS9l1CDIMQuZQJLZ7fRonwDjOWKmhiRw19zWFWahUXx5MUgrsMnyyk3BoRgNq5
 FHm3sUEV/NcPvc5VGQ5BlTY3bstFeEI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-YvpmgmeHMV6yg0i8qhkJkQ-1; Tue, 20 May 2025 07:06:34 -0400
X-MC-Unique: YvpmgmeHMV6yg0i8qhkJkQ-1
X-Mimecast-MFC-AGG-ID: YvpmgmeHMV6yg0i8qhkJkQ_1747739193
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601a3e44997so2411485a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739192; x=1748343992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xl0LCbPEvchG6572FkpZMEourGBm16C5tJpn9HWtYJc=;
 b=PQkOpetSy6zengHKWa4RtoGsoCKAAA3iQl5j3/UsQheYpsT+YbnTegoaJwiJJQ6PB3
 vx8+HsjEp9K0TYNaNTJATDL/vYNr7lIC/s8C1wMYvSwhYNHQOu0cPN2JCENM+ok/Udaf
 8MKMtDNsJHpNifZyWjQDA00LkBcu+d38cDKXdNI5FuxewIvG+dhlptZHZyyOr3wBWodu
 HEbTxVojaxW6P/jiRSdUOr/3FaMxRtvDSXI0KMD37BEcJq5+KD9turOTtyJmJMH+kPbz
 27CiKnCEiy7HXtnvqGiFxr4HFFkND2VtBiaBGp2ObYUnKQSpJtxgWCqBo2yo37UU2D06
 zxaA==
X-Gm-Message-State: AOJu0YzXzmqgDczO86nFoMLjuRZbVkLluFakNVso/77c7DFtikSaMlEj
 IqMxqiQ69+fHPM+KX67A3jjsnxuOgS3jJdMsazpnASNTe6Z0jh/3NFRpdjMxW6C10rUxEZrZKKX
 CEFVZdAXn3nlx/siOWVMiisik9L4hrjkG1U9NC3cLvy7o3ghrlZ26DCRYh/QACbkiqX3UpGIdAw
 NSrpmWA04NjP3+h6p+Tw8DgFHKZHxk7JqTtFNoAva5
X-Gm-Gg: ASbGncu76r+MD4mpJqSZq+2wuSvyl8WaPB+yyVu85ARojxP03nLCQCI9leMK8eIlmCv
 zgg1LZ5oikblX4xyfkIwu+qnLRcy8Oza9joomjxM9BiaXahcW0z6niAPnA+aRV+xrzmQXHw5SqA
 d0Z9llzhny7lK/XPo1vpB986W6DV///kA4RgHUVwcZFjLs6h/Yj3VpyOhUZNYRY9Zv4BIjX5PTc
 PFLaI3Yge+/pOBLSX6ViuH5FBXDe58tMCG2h++NHrh7eW0iuPK0QCYdnzEy8tJl8NHcZ4TgeGVW
 sRDvTwm/B9cEsg==
X-Received: by 2002:a05:6402:5110:b0:601:bcc5:a50 with SMTP id
 4fb4d7f45d1cf-601bcc50ccemr8205009a12.8.1747739192366; 
 Tue, 20 May 2025 04:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqP/KiZAvuAJ7g58ft/JVpfa3O3/iNbKBl0/DV4/5dJfULc56QhHUIHa3EHD93ptko6YVcMA==
X-Received: by 2002:a05:6402:5110:b0:601:bcc5:a50 with SMTP id
 4fb4d7f45d1cf-601bcc50ccemr8204976a12.8.1747739191866; 
 Tue, 20 May 2025 04:06:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d4f2968sm6979041a12.2.2025.05.20.04.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/35] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:22 +0200
Message-ID: <20250520110530.366202-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 79 +++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 0f9be15e47b..1ee05eb393d 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -48,6 +48,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
+#define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 689c33916e0..01b028653a3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,8 +440,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        int satp_mode)
+static void __attribute__((unused))
+set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -486,23 +486,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -671,27 +654,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
 #endif /* !TARGET_RISCV64 */
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-
-static void rv32_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-#endif
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2921,6 +2883,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
+
+#ifndef CONFIG_USER_ONLY
+            /*
+             * Hack to simplify CPU class hierarchies that include both 32- and
+             * 64-bit models: reduce SV39/48/57/64 to SV32 for 32-bit models.
+             */
+            if (mcc->def->misa_mxl_max == MXL_RV32 &&
+                !valid_vm_1_10_32[mcc->def->cfg.max_satp_mode]) {
+                mcc->def->cfg.max_satp_mode = VM_1_10_SV32;
+            }
+#endif
         }
         if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
             assert(def->priv_spec <= PRIV_VERSION_LATEST);
@@ -3140,6 +3113,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3171,7 +3155,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32,
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3199,8 +3185,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
-- 
2.49.0


