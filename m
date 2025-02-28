Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582EFC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcE-0003Yq-Nh; Fri, 28 Feb 2025 05:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbY-0002VH-U5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbW-00031C-VM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hQ/kZdFGA7Aq52A7O4JjUDVsinstaQPMiRzhTr8i0o=;
 b=HnB3OGIM/LDFwKLle5Vckn9qgfDfq1yZ5o3oeseSVTrp0DFV+uIIrS4tw+PxXhwAr2uPno
 dR/y1TnV16BU2s49MQcd5gn1mM8ONREcW0ReN4RqLC1iJ/ZHQCt7QMgYrk1x+BE60qWBPy
 QdWpZPsti1WrDkhmMLDj9/k+Rr/FsRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686--SDihZagMAigHOp2rYS-6Q-1; Fri, 28 Feb 2025 05:28:24 -0500
X-MC-Unique: -SDihZagMAigHOp2rYS-6Q-1
X-Mimecast-MFC-AGG-ID: -SDihZagMAigHOp2rYS-6Q_1740738503
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so1640382f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738503; x=1741343303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hQ/kZdFGA7Aq52A7O4JjUDVsinstaQPMiRzhTr8i0o=;
 b=KWKLndm76u0dfeWb3s0jaP01Ib0VxYyCYVUqto3DzHbGDAEfcNFZs5n7vhfpvtfeJi
 9Xv8BGKmwCwoYHBP0l+HuaX6pULSK9+mVCgtoCz3y/Q+ekk+8WDbRdv6TZ5d1+PN/1JA
 6T+5yVckelMYsN2TVsbCc1P4ZB162m5YrYDZg9hO9EVvrqgzov8sDISi/+AEstFXjKE5
 CSrkMCPccDFFszU8lLHY2ilUulo19imiVywgQaCQAaRhgKozIhHzESE/n7Eu+rskPm8S
 3dudstAOKl8EOqCTdqf9eN1HzMYqDxlaUrSyAiXHBgqPYLqfN+YZuQ7VQnH6yHIHMaT6
 buvQ==
X-Gm-Message-State: AOJu0YycWgEU3J6pxpcNt73ltS55OwTKNwsNpHftByRJXeDF9RlK13KD
 gvS3QtfB27LT/yCEOgLARfTuQ8CP5tuNx5S+i/4G+0Ub4ZakdwMZmGJ7cV4dvRjGGgNuGCXb5ix
 6bHCfBJ5FrP7FC5kgAq5xw5WHMuz81p/Mhj8+7BFaMf+TpqXirenfsXMfilP6n/2Pp7gXYkN/Lg
 pBSAsweqtZrhJD/6eUkYc0ZNK141uF/K068WQhSUM=
X-Gm-Gg: ASbGncui9KPqR6K38SgFSj0UlWGt9ih+CA16gCgjUftEp6vvtOJUXGKfTWb9CV0qEgz
 tXuhNBckLWr7DJBR005uocgWIEW7AT8a2lSrRmOiGUK1lTGN8/DLIWfPmxhW11rfZaw3FmvIbdy
 gcXhOb1mi2rrUydFh08IB2hGMlBlhDb82d+0jIELafTACnAqp8ckDC88VMnzOvocfTnH6ZWg1rP
 8mS7R/Vuxkas4Z4CHsGaNhkHWWVV+3sd0zdpt201C3MOvNw0klxRN2QKjKhqVE7H5phls/xixyi
 cDVVCVoQ5wGFSB94ZPQJ
X-Received: by 2002:a05:6000:4404:b0:390:eb46:1894 with SMTP id
 ffacd0b85a97d-390ec9bb93emr1667043f8f.21.1740738502765; 
 Fri, 28 Feb 2025 02:28:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzDCbULQknEGLaeok/q7aKmwEt48Zv1ZsdXGAwOG4UyXEvJ9+Oh2wQ0HkzFP0L11XwFAGNZw==
X-Received: by 2002:a05:6000:4404:b0:390:eb46:1894 with SMTP id
 ffacd0b85a97d-390ec9bb93emr1667016f8f.21.1740738502169; 
 Fri, 28 Feb 2025 02:28:22 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4847e62sm4779545f8f.67.2025.02.28.02.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 15/22] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:39 +0100
Message-ID: <20250228102747.867770-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 75 +++++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index bfe1455254c..398cb4f583c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -46,6 +46,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
+#define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fc5bf6def8c..e05fb5d07e0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -484,23 +484,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -669,27 +652,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
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
@@ -2807,6 +2769,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
@@ -3021,6 +2994,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3052,7 +3036,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32,
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3080,8 +3066,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
2.48.1


