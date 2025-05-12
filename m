Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D638C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrZ-00088W-Qr; Mon, 12 May 2025 05:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPr5-0007dA-2X
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPr3-0000i7-52
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekn9/GQugUZnoEqpA+KgEGCpBYph2vRTt042rN3fDGs=;
 b=jLTSRY9VZjdmrMP8IzzdE32HrW8vAAu90El0eBnxZCQ7XsWYeDE2LVrklXzyqjIXrn0/ue
 OJYzmpW4TzRslsJ3XzDm4SI1ZIdUT9zBuevnrpD5Lx+bijkfEoyQnkai9oe97rC4VwoS/d
 DULpnLusr4AgcAt0CAIMflNSOw7aRcw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-AmC5bDrqNUqojkWm-9kjpA-1; Mon, 12 May 2025 05:53:47 -0400
X-MC-Unique: AmC5bDrqNUqojkWm-9kjpA-1
X-Mimecast-MFC-AGG-ID: AmC5bDrqNUqojkWm-9kjpA_1747043626
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad240e3f501so138046566b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043625; x=1747648425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekn9/GQugUZnoEqpA+KgEGCpBYph2vRTt042rN3fDGs=;
 b=XfdRCP3kBMqQzwy08S7i4gxzJi9/3S9Tpva8znex8eK65KvdxiXYOOjhpcE7HOpkGo
 0ARPy97OwZwxE0WJdcNhf49FCLjR+YibDMDz7USeF4xi5OZ7m3Z9A3dZKhX8AsyqS7ow
 PZI/RQugT1g5pMPCPatzfVb617SLEqbVr5DWF3g5/BjoZo5cmpZJEbrnTeElqHcqY8cX
 r/X+hY9krwYR8g/KxxtHeB3zCtz4NUkqUKoRQrkviNFtKFBEWCN5XJLDKWWelEj/bOpv
 aj8/PLn5UdKuwmLse45nLkPJiNs9/gtgOScuX/in6clfT/qwF8vgUVAOUfwzITVoq89O
 EWVg==
X-Gm-Message-State: AOJu0YziPEtgBPLFS8A3KeNYKdnCL/SgXDMNWYEiyG8GecHW+mCS9F53
 LAblSzWv5IZs6MI2oXurZuCdOLN+HCBNoGZYJl5QPSm0IH6AWBuuZ3sx5E6b4/M3JPuufUCz6W8
 PPuwl4lT7lod5oOEgZIhjxkN8GPvitrraaKGKJ/SZf09G6RJPoHl70ye196QVw/xmp79NEa76g3
 oPiE0/GPuQ827Ut/V5u2dbY1bYSx6C/L7a7l0p
X-Gm-Gg: ASbGncuAWW8QWM549+Tdqp9cwDweVznH1AdCvf0G7dKwc1DK3Jq4as6ljFSRgfx8ayS
 RGdar75QZAHfzHRMbCjW2byWECTwKhA9k+WBVXAZkDvY7wCWuqPF7yH8hDN4YsJWJL777Vp+8yt
 nKP74McBgQOtieEiAlIljruVNu1HkR4k8V4TAPoxSkCXrRMJ7e2uQf4YyRW5Mgt9eQ3loSoaEnx
 9YWo00ublX+0N3NcIe4XG4GovBJB9i0Ep6U7v209X3XChIVfnJfO0AvjoVXRyGQIBwz6D1Xg9fA
 kNkrsvflIzw4tqtfX6ehJdSIJ6lnZwy8cTNkCp6nZZdRlh4=
X-Received: by 2002:a17:907:1c1f:b0:ad2:595d:dd3f with SMTP id
 a640c23a62f3a-ad2595de0f3mr192242466b.56.1747043624486; 
 Mon, 12 May 2025 02:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS2a3187G7TgWO9e++fORCrLnVOj+opKNXKGEmP+to2FZ8uiODJ3Uk9/4ZEkzNrSbisiE3FA==
X-Received: by 2002:a17:907:1c1f:b0:ad2:595d:dd3f with SMTP id
 a640c23a62f3a-ad2595de0f3mr192239566b.56.1747043623971; 
 Mon, 12 May 2025 02:53:43 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2417f2341sm320167966b.19.2025.05.12.02.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 12/26] target/riscv: convert abstract CPU classes to
 RISCVCPUDef
Date: Mon, 12 May 2025 11:52:12 +0200
Message-ID: <20250512095226.93621-13-pbonzini@redhat.com>
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
index f9ba305e3ad..0330d74ab6b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -543,6 +543,7 @@ typedef struct RISCVCPUDef {
     int priv_spec;
     int32_t vext_spec;
     RISCVCPUConfig cfg;
+    bool bare;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7864c7e27c6..f66560442a9 100644
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
@@ -1498,36 +1498,6 @@ static void riscv_cpu_init(Object *obj)
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
@@ -3100,6 +3070,7 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
     if (data) {
         const RISCVCPUDef *def = data;
+        mcc->def->bare |= def->bare;
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3253,6 +3224,19 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
+#define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
+    {                                                       \
+        .name = (type_name),                                \
+        .parent = (parent_type_name),                       \
+        .abstract = true,                                   \
+        .class_data = &(const RISCVCPUDef) {                \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
+        },                                                  \
+    }
+
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
@@ -3279,22 +3263,35 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


