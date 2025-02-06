Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11F7C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bD-0001Bg-Az; Thu, 06 Feb 2025 13:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bA-0001Ax-So
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b9-00015D-0T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51WHnmv/yyWpO4/EKeMo7butDirvPsrNKxtMwcf9yAM=;
 b=C2N3CXCHKFGig6Ltiwo7AO4sFxi0ykWe+qAZUKPqWisDiX10hAUb7P5lhkTxUv/UdrIbtL
 YziGtTFtrINKvrgn6dCMoEUJnSU6y5iw6e87wRv76LZXmptGs1gPLv2jYKADcUyEXCUBXK
 IZSFdyyJtbtt1289brmfKa0ym6tyZ5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-B2P6-W9OOPyEzPNScHk7lQ-1; Thu, 06 Feb 2025 13:27:32 -0500
X-MC-Unique: B2P6-W9OOPyEzPNScHk7lQ-1
X-Mimecast-MFC-AGG-ID: B2P6-W9OOPyEzPNScHk7lQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436225d4389so11225075e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866450; x=1739471250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51WHnmv/yyWpO4/EKeMo7butDirvPsrNKxtMwcf9yAM=;
 b=FAfu4qdv9p7ay+ttfNN0s2TMGCy6fkv61lIdgKVZu9KLJI6uzpoH7QB4LI+LcpE3rl
 HTxHffA20f7X26oBGIwolwk7lR01Sjuwz1sIhkT0PT65Fn3qYe/umVawpq3i6N1sLgkL
 fjZzjZxFHjbIJUST9sXtmYxzfWc+XTzPw4+gnxcBwnvwHXyx7YFvhwnHWSbYj4ZTTB5Y
 0klqLnOT3BtP4ot5Z+t1P162b6ZxJqH69T8H5DOtECdyrJaHxiCOZbk1cgtewrjpy4Lg
 iWay8AjLmRr/hBd/3xIFBCyEDA5X067/Rtu9AAAjBynxwByYHBvEVSOP/LaqFFBvTKtk
 yFsA==
X-Gm-Message-State: AOJu0YxVGjFNNheAEqb17ca2wix7LZlw0XX9NgaCmxlWCITk4W1EzQle
 1QAK+uK/A+fLAMNHTfBzcZTCVhs0PdM6bVWU7MWGKs7BxaPqHmRfkJdSpDyxtSDAeAzzL7NOiFU
 yQ0EM5wwuTu0jOaBEKGADqbR9eB/A7D3Fw0xv2jJYGqNyfxE2Zz6efabnWVZoG3iGn0yQKoK6V/
 Yifpc1MWivoB6MNhDLu8HUBsxpevxuQzDRnXIL5Es=
X-Gm-Gg: ASbGncsIwSI/cMN8k3Zd7WNGvcXTklO0BdpSbBb3Xf/zCTD3qXCxkp3PIJdAY58ovKF
 BTnAlUbSbkQ/kXTAIhI0R5uilLxyg5ziDbpAaFp9xLewoO+BjwdEDV4feLy0Zjd3gns9qd3JV3G
 0q4Cy/vQqH9cLV6puNPF2kaZ5K2BETVAi6dX8592GcsN1evGagj0ACKE/5rqbrmbwCkjbKsUoeb
 qwEaPMCPdP5jO1JQZwkybWhEb6njnN59SNMMj/9xYVaQKIVnXaOuX5NIWnnvMiCUL4p1kMRKajH
 AMzSUE0=
X-Received: by 2002:a05:600c:5807:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-43912c61fb8mr32872085e9.0.1738866449985; 
 Thu, 06 Feb 2025 10:27:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGedhDH+J+OfrtwBhuinLG/w+u0E9ub7kpuAn9HIyGsFs5zyGthAz+Ge/fp9/joFaDgSg5aPg==
X-Received: by 2002:a05:600c:5807:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-43912c61fb8mr32871875e9.0.1738866449549; 
 Thu, 06 Feb 2025 10:27:29 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da9648dsm28122195e9.7.2025.02.06.10.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 07/22] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
Date: Thu,  6 Feb 2025 19:26:55 +0100
Message-ID: <20250206182711.2420505-8-pbonzini@redhat.com>
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

Start from the top of the hierarchy: dynamic and vendor CPUs are just
markers, whereas bare CPUs can have their instance_init function
replaced by RISCVCPUDef.

The only difference is that the maximum supported SATP mode has to
be specified separately for 32-bit and 64-bit modes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 89 ++++++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9b25c0c889b..1363a081c30 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -525,6 +525,7 @@ typedef struct RISCVCPUDef {
     int satp_mode32;
     int satp_mode64;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1d999488465..1cb091ddb0c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1474,8 +1474,8 @@ static void riscv_cpu_init(Object *obj)
      * for all CPUs. Each accelerator will decide what to do when
      * users disable them.
      */
-    RISCV_CPU(obj)->cfg.ext_zicntr = true;
-    RISCV_CPU(obj)->cfg.ext_zihpm = true;
+    RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
+    RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
@@ -1505,34 +1505,6 @@ static void riscv_cpu_init(Object *obj)
 #endif
 }
 
-static void riscv_bare_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    /*
-     * Bare CPUs do not inherit the timer and performance
-     * counters from the parent class (see riscv_cpu_init()
-     * for info on why the parent enables them).
-     *
-     * Users have to explicitly enable these counters for
-     * bare CPUs.
-     */
-    cpu->cfg.ext_zicntr = false;
-    cpu->cfg.ext_zihpm = false;
-
-    /* Set to QEMU's first supported priv version */
-    cpu->env.priv_ver = PRIV_VERSION_1_10_0;
-
-    /*
-     * Support all available satp_mode settings. The default
-     * value will be set to MBARE if the user doesn't set
-     * satp_mode manually (see set_satp_mode_default()).
-     */
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
-#endif
-}
-
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -2991,6 +2963,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 
     if (data) {
         RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3143,6 +3116,20 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...)    \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = &((RISCVCPUDef) {                     \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,         \
+             .satp_mode32 = RISCV_PROFILE_ATTR_UNUSED,      \
+             .satp_mode64 = RISCV_PROFILE_ATTR_UNUSED,      \
+             __VA_ARGS__                                    \
+        }),                                                 \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3166,22 +3153,32 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .class_init = riscv_cpu_common_class_init,
         .class_base_init = riscv_cpu_class_base_init,
     },
-    {
-        .name = TYPE_RISCV_DYNAMIC_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .abstract = true,
-    },
-    {
-        .name = TYPE_RISCV_VENDOR_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .abstract = true,
-    },
-    {
-        .name = TYPE_RISCV_BARE_CPU,
-        .parent = TYPE_RISCV_CPU,
-        .instance_init = riscv_bare_cpu_init,
-        .abstract = true,
-    },
+
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_BARE_CPU, TYPE_RISCV_CPU,
+        /*
+         * Bare CPUs do not inherit the timer and performance
+         * counters from the parent class (see riscv_cpu_init()
+         * for info on why the parent enables them).
+         *
+         * Users have to explicitly enable these counters for
+         * bare CPUs.
+         */
+        .bare = true,
+
+        /* Set to QEMU's first supported priv version */
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        /*
+         * Support all available satp_mode settings. The default
+         * value will be set to MBARE if the user doesn't set
+         * satp_mode manually (see set_satp_mode_default()).
+         */
+        .satp_mode32 = VM_1_10_SV32,
+        .satp_mode64 = VM_1_10_SV64
+    ),
+
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
 #elif defined(TARGET_RISCV64)
-- 
2.48.1


