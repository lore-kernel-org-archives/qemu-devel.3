Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952E7C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6cQ-0006hk-CP; Thu, 06 Feb 2025 13:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6cN-0006PQ-8a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6cL-0001je-Bi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfQdeCQldvCzU2bB21S1eT25+I26YnRTxVCOSd/76gs=;
 b=NzxyaLoil/DXv4g9I+Ivp32yCcPBcstLtMoJyK0I2zxYxmLIOs17CqnUlpMTO/L3pO8sYd
 2RuvfwocNBywVq5BXOOvnR1LxwqFJDmDKP+g5YcaOtWTZZDyXafoQ7a+zTczdcPXSu6IbO
 EEGZlNZSvZud7SCYhJIkf9z7P04VjE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-7jiWc187MKKS8Xs4T7Bq0Q-1; Thu, 06 Feb 2025 13:27:41 -0500
X-MC-Unique: 7jiWc187MKKS8Xs4T7Bq0Q-1
X-Mimecast-MFC-AGG-ID: 7jiWc187MKKS8Xs4T7Bq0Q
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dbe50b2d0so467703f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866459; x=1739471259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfQdeCQldvCzU2bB21S1eT25+I26YnRTxVCOSd/76gs=;
 b=vTO3L2VV1/k+0MCXC/LLJ0CVa4Y311EAixvKapRtIDR3J/SzoEJ+3424cGdeQ7tEWS
 1Rv2PKyflEXNhJUiX9IB2jK7QEJNhZbnQdqCu+Q8PsBLRN+A/FkSKWgtG3pfZhGBcQWz
 Nx2wWG1xS4lnLPBet6XyIJEJaJ/J+KwbFaVHTHhZeTMlLRh3Gc9avbJ5fHMWXKS1Py+k
 vn6oWwSMn+cOl93fL5rAXGrpHC0bK7rHvPWTezewFJt5pO7SLAS43b6Z2II1hHyAQpJB
 Rw+qb6uGxy0qzLsjBNnSiLcuwhWPfwZJ8OYjKY7fVNLIr7D5VgQ4UE8ARSiZRr9ozwCa
 r2Yw==
X-Gm-Message-State: AOJu0Yw7+zovAIES3Lnk0bJx3WQ+wDzFM93jG/RWPHW5+SGIUXu23PJs
 qdih5dObqJI8CUDa3nttKgtYcid3VzXvr5+DfvG0AOZSvAKJGWN+sF3OlEF5yxGdwY5d+dj6Bc2
 hIrr/jfdHy9BSCKYmkwVSLr/9SnjTdNIv5LPmXdexIKb7b+5765f3fw0ebVF9jXQ29EvrO/Wsvt
 5h/ZHxtZBT1E2638Op6ZicXIjDxcsuoNZ2VdX96jI=
X-Gm-Gg: ASbGncuva2SUq92gDT8w/Ac83gH1JATRqbuf5fcXNg/UWzgFqQlrUfx1oDQnEGKDwiL
 lAzCQsqqhi7jCbat0dCURd9XSbzIkCL4c0ruQ5xuKKZ6jwqovFdB7fvgldwlGxlrFR5AfGbYfTl
 0KA9Obri+jenTit9yBuw3jGyVz9VfYCW9sj8/zRykb0lbMl+494ApBRdchFbVt05dgeJWhdtFsV
 O46EVtPPbyL4xbXyRuw1SG8ScXt2QWpnqgfheLtsjg1yDp0YfPtq9OtR1vjmNfM9gT5kmbyA5uB
 pCi1/nE=
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38dc9346494mr20517f8f.32.1738866458909; 
 Thu, 06 Feb 2025 10:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+c4opaFVEZmdjft9gm5GyTM7YgJ0k5g+8F9RZ0jBDk7frQA6OT3tYGuvjy4kzd4jo7mOdag==
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38dc9346494mr20476f8f.32.1738866457987; 
 Thu, 06 Feb 2025 10:27:37 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d40csm62479165e9.9.2025.02.06.10.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 11/22] target/riscv: convert dynamic CPU models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:26:59 +0100
Message-ID: <20250206182711.2420505-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 110 +++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 80 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8fa05912698..ce439f1159d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -471,38 +471,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -703,43 +672,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
-#ifdef CONFIG_TCG
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
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
-#endif
-}
-#endif /* CONFIG_TCG */
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
@@ -3064,16 +3001,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
-        .instance_init = (initfn),                          \
-        .class_data = &((RISCVCPUDef) {                     \
-             .misa_mxl_max = (misa_mxl_max_),               \
-        }),                                                 \
-    }
-
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3129,7 +3056,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3154,15 +3086,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .satp_mode64 = VM_1_10_SV64
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
+        .satp_mode32 = VM_1_10_SV32,
 #if defined(TARGET_RISCV32)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
+        .misa_mxl_max = MXL_RV32,
 #elif defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV64,  riscv_max_cpu_init),
+        .satp_mode64 = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV64,
 #endif
+    ),
 
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE32,    MXL_RV32,  rv32_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
+        .satp_mode32 = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
@@ -3179,11 +3119,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX32,     MXL_RV32,  riscv_max_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX32, TYPE_RISCV_DYNAMIC_CPU,
+        .satp_mode32 = VM_1_10_SV32,
+        .misa_mxl_max = MXL_RV32,
+    ),
 #endif
 
 #if defined(TARGET_RISCV64)
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE64,    MXL_RV64,  rv64_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
+        .satp_mode64 = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV64,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
@@ -3193,7 +3140,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
-    DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
+        .satp_mode64 = VM_1_10_SV57,
+        .misa_mxl_max = MXL_RV128,
+    ),
 #endif /* CONFIG_TCG */
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV64,
-- 
2.48.1


