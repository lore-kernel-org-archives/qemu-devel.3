Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C1BC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1x-0006d5-LR; Mon, 28 Apr 2025 03:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1k-0006UJ-Iu
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1h-0001G6-Ga
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIWShWLTWMaQL287TpegRqOa9wrFxpjkzyqyGPXitHY=;
 b=Elfp/9A2un75beTR2kXcRNnIYZHyJtTxrFrRrwxEqX0ZGajaVhZAQ7i/gTUp/KHDWJA6lx
 Ka2QGwLkazvj57JIhkEO0+l4wCyjIBWe7KEHF704OW6u3kjAbojjsn1QcYb1dfUOwIsQNu
 FsU378lITkFUdnBX1JOdta1zVxq26o0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-8ILbUkvmMZe21iHtUH0KEw-1; Mon, 28 Apr 2025 03:35:34 -0400
X-MC-Unique: 8ILbUkvmMZe21iHtUH0KEw-1
X-Mimecast-MFC-AGG-ID: 8ILbUkvmMZe21iHtUH0KEw_1745825733
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so22493625e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825732; x=1746430532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIWShWLTWMaQL287TpegRqOa9wrFxpjkzyqyGPXitHY=;
 b=YXNIQbZKldqGsz+NECEW+C7GNhJvkQYa1fEZPGQVjMWU0aRuMfXlDQY5u2aM3MAjT0
 WsW5CRtOZkHXvu2xfxojMwbVnudLAhDUYBfe+0jgBPg+YK2vqhmoqGjEVq9KjBGKGkGJ
 hMkOnGufRLnqbLh+EI+UiTPrPe+sEZdbJF//j5zI48Vk655v8UMaZdsQSQMKbhXswAPY
 CKNKx0POSZdq3yamZA9/rqGX4/3hF/MfMDx4k497Tm7Eu3QxqS/Dx3Cdi7t0iO3PsQVe
 D4Ozf63s47vcIzxeHTrBLYrNBOzi4mzaSrhh6ZlEOHDxwP4EuXR8duIsAPigVAhI8/dF
 rW6w==
X-Gm-Message-State: AOJu0YxBPgkH6+U6l8ibxBexNumnXCnCSqWDOqcMpguwrN3wZKySBSnP
 YekVf/JeGGLrhdYuoU+3+SIY3u9N5n5eYrZKLW6onDShoMP7cTbVKjMxKmZEQvqeXfSRLeyE51B
 Lf9bi2StWq10qMax2oKWi+7Q1W+ZnKYZ2tB4zcWCO3yZjPQQWwj6ojQ0wBiFiHNnOSWfCWUmC2a
 BP2SJJZwlduBo2NuqLkKub/7vp8t2WsyLR4nmj
X-Gm-Gg: ASbGncuWf/kex7j6uy24vVQpvsI6i/0OfeA9OZcEdEFhPxU/cMs0zUY4ZxuI66E5V0L
 hhrO9fRS9C21lvZVJ13EvVSL6a7nhEbpOheXOxKtRzjanVCavdqXn2UJ3yeIDYGz/oUF5kDntmU
 +PICErL5uBLm0eT8LlHvo6lUDfg4HWPFA3sXr9Ak+rcuCCz1snEzoI5QpgKDLY2AUmo5IKrwaQi
 +eGRgh4g5qe2FLLNn8ENkq+bY+M4Ha9pFy+aqRyg89MQwai5yJ2tFjPDEXomnP7TIsGaziXFoeS
 iGPsh1NR/iugZ40=
X-Received: by 2002:a05:600c:4f8f:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-440ab7b5f6emr69226495e9.10.1745825732655; 
 Mon, 28 Apr 2025 00:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/MGBCT+y5DlWK07DanvrfgyXnZYfDNw6AIHep+WafxD8zOLk2t/QVRW5T+m5R0WyjlHDDlA==
X-Received: by 2002:a05:600c:4f8f:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-440ab7b5f6emr69226165e9.10.1745825732246; 
 Mon, 28 Apr 2025 00:35:32 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5303c68sm114200005e9.12.2025.04.28.00.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 19/26] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:34 +0200
Message-ID: <20250428073442.315770-20-pbonzini@redhat.com>
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
index 4f531711655..9a28f590c45 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -441,8 +441,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        int satp_mode)
+static void __attribute__((unused))
+set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -487,23 +487,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -672,27 +655,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
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
@@ -2922,6 +2884,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
@@ -3141,6 +3114,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3172,7 +3156,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32,
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3200,8 +3186,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


