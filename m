Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EF3C3ABD2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrb-0008FO-Oo; Mon, 12 May 2025 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrG-0007g8-Cw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrE-0000jf-D1
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYbcPBc2KU6+jAujfsP0SWcps8Zkpi6VAZOChhEYUo4=;
 b=P0AcBbTgH5sNJ0URmK2ZQRf9sIdp8WTInDSudE3bmOImNscNFAr4W0rdl2+v3cUBxc651R
 yG1FRQibWjW2RhVw5VunJgvwqNeIXgIkrWin7ONDHzJE8h/rToU6BN86RaLygV38iDDdeL
 9cAaO8DUPdwkkbXGbo3SmVUuAZTmuZI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-VxmBjLK9PN-YTJGw75KTXg-1; Mon, 12 May 2025 05:53:57 -0400
X-MC-Unique: VxmBjLK9PN-YTJGw75KTXg-1
X-Mimecast-MFC-AGG-ID: VxmBjLK9PN-YTJGw75KTXg_1747043636
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad240e3f501so138066266b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043635; x=1747648435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYbcPBc2KU6+jAujfsP0SWcps8Zkpi6VAZOChhEYUo4=;
 b=WbWJ9hL60cw9HxoaOyOA87oQ3CCRDUoM5Tmu7g9yF/KgbZ1Wh40r+aUJwMuyMzMpDd
 87Owi8JmtNf5nwSGR5QlUnLAxjavzSfxGszaBBh0WH14HYZepwXD8O+4QuqVFUUE+073
 yILnUMSQbUE/4Pnt8ao/im5jlR6bodd/6uFuShccLoN4ak1OkQqcdl5MnOlwJoi5rflt
 JL5tASWIrrGlw/eRj88hdO/J2XXYtg9PWHyMdZbwZ1AUwVeNY2sa9A6qr2suW+TMaGaz
 SpX8VxScBOVwZWXBKxSCVZS/blJY5MVwnVsj6Dv2ufuj775zfEXB5vCWVReG7OVQLNTR
 nkAA==
X-Gm-Message-State: AOJu0YyMmCFIeEZ1F2aDt+oXs+4o/4RdlMj0PhWZ8fRZaIkPHtL4eqGb
 PTvm5b9jKHcPBM9OQUxBcMWAwWv6dorQBR/tAGDRP8ouiJOcDLxF8KOagavDxZk1OPu0W93Z/PS
 lNaR4I0BcWszjdLbKQ2tvpOvh+Zp3Qtaej4HZ/kaIawXv4bnkg7uiBeWTs+GOxm1wGVABGOXmtu
 5hiqr8NP2JSe3VtQsGnvdcvcPUlgzUN6RFd1+c
X-Gm-Gg: ASbGnctc0Hfmb4RWQfnJ5uZgmrESN6kVc7ak1DHe3nbImGkMb/uvfQp5veCq3mufZRP
 VKhdfOMsk0pCgA4oDeHI4spYjkHORaIc7Qhdtt1ov2HOATjjmfVl7Gn5g2FcRdMvGJI91rmL32M
 4rGyYBS4uFVrk/U3ijMTY8ELkTIHavgI83zh8LU6NDIhRAjsetThlIfO5i27d+vpTslzNZ7otQs
 GGNWFj64kpxV52T6tQd5k6PjW0ggglaPl5ExISJA9MdneDLlbQiZprwOFWLruWMOR7PTrRZQ8Pk
 7cLuNJayK9Net0EeRqYxxHYnz+sdoQ1tO1LyxMQNdNiAc08=
X-Received: by 2002:a17:907:7f9e:b0:ad2:411b:589e with SMTP id
 a640c23a62f3a-ad2411b5dbbmr728105166b.43.1747043635614; 
 Mon, 12 May 2025 02:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlxMEnrQkXeEA7j5s5PdUSGOwihmAMKqROfc2ezZFqL7lbZbblz7b6j4RPIo0290gfKpY48Q==
X-Received: by 2002:a17:907:7f9e:b0:ad2:411b:589e with SMTP id
 a640c23a62f3a-ad2411b5dbbmr728103366b.43.1747043635141; 
 Mon, 12 May 2025 02:53:55 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad225a6bac2sm514703266b.101.2025.05.12.02.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 15/26] target/riscv: convert dynamic CPU models to RISCVCPUDef
Date: Mon, 12 May 2025 11:52:15 +0200
Message-ID: <20250512095226.93621-16-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 113 +++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 82 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index af5b4af4814..b4f6e34eac7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,38 +485,7 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -717,41 +686,11 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
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
@@ -3166,19 +3105,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
-        .instance_init = (initfn),                          \
-        .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        },                                                  \
-    }
-
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3235,7 +3161,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3263,15 +3194,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3288,11 +3227,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
@@ -3302,8 +3248,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


