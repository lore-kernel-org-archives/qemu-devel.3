Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808FC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxc7-0003AX-In; Fri, 28 Feb 2025 05:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbR-0002GI-05
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbP-0002zg-6s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04vtRFHVbucvq2GldAg/HTrNKuWL48hVetXldSceCBo=;
 b=aop/9P+Kmca4evECeL8vF52oJ+2FySPEzOwLml5p/9MIGcJfLt05swWP8Vgyi158tbzmjz
 DG6cWE7LqTRs6L9zezCos4m2jHKgIrspWdgvHP+y6S9XNiIB4Nu+1xWE6sqsWHxvHCHYhk
 f/Ncs7d8sUZVFSreyNzX1jblPKUJ/m4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-fT3WS8UaOgSYrOISZwwgrg-1; Fri, 28 Feb 2025 05:28:16 -0500
X-MC-Unique: fT3WS8UaOgSYrOISZwwgrg-1
X-Mimecast-MFC-AGG-ID: fT3WS8UaOgSYrOISZwwgrg_1740738495
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so13520585e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738494; x=1741343294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04vtRFHVbucvq2GldAg/HTrNKuWL48hVetXldSceCBo=;
 b=GBA+vTmCxOcdbRq0/v2H4Z+Wf/JSLjXsJGKdzFxFASanUp9h4zzbil35v0K4G75P5M
 69ylpFEdPI5WA6a3ElVew4Yk9+xxOUHkf9ErJXsVutpT4vpHs43v0V0UA30kXi3qO6+o
 bR6ZBxxOQqCvFXWTdNTAXhngsI/LCU1HzNfEeFwmhEAWNytBbMD9A9Xx+BiHmGhc4a5l
 1h4IaBDqSVuHmhzSG5VgykE842PG/b8wuV+0Fkqd5ZRpXOsh/maGZ6hFDCHA9q4Ymm7j
 2TTKJJqFyKQQUHw0uLFar2JKFzs3PrfLhUOM9Tf/7bW1PyQM4WeBsX26qQ9pTuWkA/4o
 M1+g==
X-Gm-Message-State: AOJu0YxAoO0RKhppCeF5LKZi5FZ1o/OZEcY6PInEJQkUKZuwxblBcW3f
 3rzmzYZlNPOEZOhV17aggn1loZXJFUsW2IpY6ZepdX7WhigAb6M/VdwFdG8BIoHd4kTUNY7Hvnu
 mB92lcltELmNCPA1OHf5OaJPu51slgRlIGPHpv1FHAKMqwYhVEKz97EF8S+ohXYgRChO4OuBwoC
 fni8H6F6t8TjaGH2EzENva1zOcAoV2/EnFBwmlHD8=
X-Gm-Gg: ASbGncu1By2fiCgYf7srlyIDE/+cQLje80FAsrhB4VM/PT0LYEDZOlDm+zuIw9yrcKn
 zeVThg7EvttEbqFuwLx0J2JC0+Qyo8PgtKqhVWGIzlYIwv3sjLVLENOyVIt3ElUtvqddpFI61xH
 5wxOEuk5UCNWIQsjsntRm2PjI/rohiN5VvWZqSOdkn9YBeQeyYSou6Tb9JMwzzEa2mNRlBYrYBf
 0afgHz0ZExS2V/8txp3MmUJSApMTsd02wo6QS5LQW+FtjNeRcKkGoV1IMzZHDyeFrVURr/rgmns
 b4wvq9Tr8iSZr5sJNmIe
X-Received: by 2002:a05:600c:4f56:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-43ba628f76cmr21260325e9.12.1740738494009; 
 Fri, 28 Feb 2025 02:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmUKeFuCoKsuuAAhzt7XaDUThAG4IFduQ+gtSsOCDJLCmXqnfJEYWcYhWMevXj87riZjAA5Q==
X-Received: by 2002:a05:600c:4f56:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-43ba628f76cmr21260195e9.12.1740738493638; 
 Fri, 28 Feb 2025 02:28:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479652dsm4877829f8f.16.2025.02.28.02.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 11/22] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:35 +0100
Message-ID: <20250228102747.867770-12-pbonzini@redhat.com>
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
 target/riscv/cpu.c | 55 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 732a0540660..feff1c91a00 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -732,18 +732,6 @@ static void rv128_base_cpu_init(Object *obj)
 }
 #endif /* CONFIG_TCG */
 
-static void rv64i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv64e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
@@ -836,18 +824,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv32e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3098,16 +3074,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
-        .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3190,8 +3156,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVE
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
@@ -3211,8 +3184,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG */
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVE
+    ),
 
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
-- 
2.48.1


