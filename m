Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBBCC3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2x-00034s-0s; Sun, 06 Apr 2025 03:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2g-0002wN-GG
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2e-00022N-T5
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM85iOFJ7D2LNztNVwl/GtU0zhKlUrzMK5IyZFzSnaM=;
 b=fbpeJY9PFOO+dI+jbmZ24SvQ6T/dhBoLbB0vxm+JJJv+xdgMa+EOmCSeIcP2PtpEAJzn5G
 WJNCYRgJ9kbfxH1HW40wqHfG2XpDkb/PR4lhluFW97Nz7NVLQhCk4jYo8oAvnmdCnZd1ZI
 30lM1VbujCjh4qrt//+ledtNMBZ4WsA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Kn_8cBOfNi2WcpZglNNIIw-1; Sun, 06 Apr 2025 03:03:36 -0400
X-MC-Unique: Kn_8cBOfNi2WcpZglNNIIw-1
X-Mimecast-MFC-AGG-ID: Kn_8cBOfNi2WcpZglNNIIw_1743923016
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so27471765e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923015; x=1744527815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XM85iOFJ7D2LNztNVwl/GtU0zhKlUrzMK5IyZFzSnaM=;
 b=iL4KCqrlTx68BxzvcByWzRUcDI7Hh8atbkXp3AVWPlYxAwgdb49iX6UgTnJp3Fw7xS
 KHE0E5cSS0euzHuij+gyN3kGKnEp3K4UqYX5rb3p+aRNEMGJhZFvPJgDD3IM1KvKQZrD
 Xe2jPrYA6s3La8hR9nbU8emeALmbUYmOi4n95mCXk4TL+9a3HwRyTxnf8xMUOPfYOtXS
 TjilfLjyjdkYCMIqnym7SC+IGILx3hbKZr9LFPrbhy9P+Jodm107oD1KTcIgW70ey/EV
 bFkVUe5W9UrZhg9RceeP3/BhtSnjyYyp2kssWxRBdN4rqUMFbq1+oePYr3F4I/gQleHT
 AKZw==
X-Gm-Message-State: AOJu0YzMaxS85LctcxfskoMTJCB/JCFiFUQLMIJi8+9Opee+Dena3C9H
 F5hZ6rkG88/YCz5TBb83cBDBcsMngu2tDWbWlt0mqE21yaxSA9yObuQWG/oAYBXogdIHch06GZs
 zPUjIodepUNcHI91W23GcVegrKBMCABW8N5KN+hQxz6fpsyX9b6Pz3hj/yvKe/ZlZFMhMLdRabm
 S1WbK8WzcwkxX5AI0CFmgb/IJAhqIBlBHRjwKv
X-Gm-Gg: ASbGncslTfqRb3jMUFR4Vc+XWhyjOcbE8bv1HKwbcY6WeW+itncHU8HyoHU+LdwaLJ9
 ReWTo57tQvBMejg7kBMsl2/P8Rx2wjJ8abvs4JO9kbe+HqsNPywZ6taEwZKyXhQwjsXCKZgTCR/
 xk/aj5mNQKXQerQZHTtWbfcbgtjYyz7rcrm0B9oel+mN60v6SKD8kggkfZ0/8U9gORH5ScviuH1
 bNp0UVho1cqgPNftbwfR4rpCLEpt4b6RQhp0FHCOk6+pGuUrm6Z8A3DUiKm4esSUBsm0uMqdt00
 hMRWPYhOldKf1ffWRQ==
X-Received: by 2002:a5d:5f42:0:b0:39c:e0e:bb48 with SMTP id
 ffacd0b85a97d-39d6fc0c1b2mr3401509f8f.8.1743923014772; 
 Sun, 06 Apr 2025 00:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtsFi4fgr/TK/lWsXWFMe6xDFHtNkWuql2PMNQVDvndvjXfIpF9Kg9ooKXOT8AHbxwosAfUA==
X-Received: by 2002:a5d:5f42:0:b0:39c:e0e:bb48 with SMTP id
 ffacd0b85a97d-39d6fc0c1b2mr3401485f8f.8.1743923014395; 
 Sun, 06 Apr 2025 00:03:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795243sm96088125e9.32.2025.04.06.00.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 14/27] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:41 +0200
Message-ID: <20250406070254.274797-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Start from the top of the hierarchy: dynamic and vendor CPUs are just
markers, whereas bare CPUs can have their instance_init function
replaced by RISCVCPUDef.

The only difference is that the maximum supported SATP mode has to
be specified separately for 32-bit and 64-bit modes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 93 ++++++++++++++++++++++------------------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index acaa49b979c..d247b9007a6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,6 +547,7 @@ typedef struct RISCVCPUDef {
     int priv_spec;
     int32_t vext_spec;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 620641fbed6..002f5a15ba2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1482,8 +1482,8 @@ static void riscv_cpu_init(Object *obj)
      * for all CPUs. Each accelerator will decide what to do when
      * users disable them.
      */
-    RISCV_CPU(obj)->cfg.ext_zicntr = true;
-    RISCV_CPU(obj)->cfg.ext_zihpm = true;
+    RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
+    RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
@@ -1506,36 +1506,6 @@ static void riscv_cpu_init(Object *obj)
     }
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
-    set_satp_mode_max_supported(RISCV_CPU(obj),
-        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
-        VM_1_10_SV32 : VM_1_10_SV57);
-#endif
-}
-
 typedef struct misa_ext_info {
     const char *name;
     const char *description;
@@ -3106,6 +3076,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 
     if (data) {
         const RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3259,6 +3230,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = (void*) &((const RISCVCPUDef) {       \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
+        }),                                                 \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3285,22 +3269,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
+         * Support all available satp_mode settings. By default
+         * only MBARE will be available if the user doesn't enable
+         * a mode manually (see riscv_cpu_satp_mode_finalize()).
+         */
+#ifdef TARGET_RISCV32
+        .cfg.max_satp_mode = VM_1_10_SV32,
+#else
+        .cfg.max_satp_mode = VM_1_10_SV57,
+#endif
+    ),
+
 #if defined(TARGET_RISCV32)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_MAX,       MXL_RV32,  riscv_max_cpu_init),
 #elif defined(TARGET_RISCV64)
-- 
2.49.0


