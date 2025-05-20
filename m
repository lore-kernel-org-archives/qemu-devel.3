Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F35C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKns-0000l5-SS; Tue, 20 May 2025 07:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnk-0000Fm-SO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKni-0003GL-P9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSu2alUzM9T0qhDYQxjTZn22Z500RiRCFW3ogDdklg4=;
 b=bkj1c6+U8OzWYBFlopexVmAzM2SBPrn0y3KZPvm6l1uwII7y+ZuCTSP65VclwxYFi0zdZI
 ZlOSyAWXmWApT3TQkLngJvpuzVPR4cemHwYrX03i3u3HMQGXViit2/rtw1jwmWqCNbyzkC
 2i+QzFATkvp7pQDvk6a4wOx670NFD38=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-WQZ8DWGjOT2IfS749TzP_Q-1; Tue, 20 May 2025 07:06:24 -0400
X-MC-Unique: WQZ8DWGjOT2IfS749TzP_Q-1
X-Mimecast-MFC-AGG-ID: WQZ8DWGjOT2IfS749TzP_Q_1747739184
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601a4318a39so2336489a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739183; x=1748343983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSu2alUzM9T0qhDYQxjTZn22Z500RiRCFW3ogDdklg4=;
 b=vfPlB+AIXpu8Dqz1lCHxvNdwh21xBOjq0u96KuJfIxFktCCs4flxLkjoecfWSPw72P
 XMQzvb9dtX+WxEoetQ/G6kihpHuVM+AZxF2pQOtsNm0ehiriJBrogJD9ikJ43T0qYSRu
 u7ZU/800eda1XsxRO4Z+HNuMClczUY4bmTL4nFiMdDH46ULri56XBkdEp5wVHW87rQTV
 jXGCTPKQ6s6SSfJdnk91P4+aSLA0wUtnxKT5I84fCgfwoRyOGpFC0dgc39nrd+iTQaab
 /FfD3eEBs1OWLhUCMmSmEwWDtVYF6dM/bfkb8JsNWmOtJfZH1XnJtmjdU3n0ng+pTcoB
 vW0Q==
X-Gm-Message-State: AOJu0Yy4w0fq1xZ90Gqr23+O2ZKM15wA/d+Ks83T+uid23IYWV7RGtR+
 04jIn6ClfZ7DRfpmx0jV7gtHNosxGkSADi/Pz8V7PEoyP8qTYWevBLXVP1S0xMiGEP6/PH8Q49U
 FA7a9V/HbiWrS9DnktVkfH1jv3y5H4aVOOGiD+JHCKGNLJZJZLRGBAI/az5F6Dnj9Oy2d0JiYdb
 sHnJkHDrK43O71qbldoy5xuSQmat7GJXOWnk9tP7tg
X-Gm-Gg: ASbGnct7a4LO12fC2PoWsCQ4V5W/hqyEC2IApMBGS77Ozg/P4/1N0O0E7E5Ai5c8dgt
 cd7E+5r51xzDhhtwEcnG8oqiNlEeFGtTudwFTzUpYgQUuKjnpWAIKV2jucLolEQn9uzqkpb7Cr5
 JB+SDMlYHj2dUV9sn50r4OvS1zITT5Pa0DN4p6SnT7Ldl0sZQg+kafhbv78TxxOHavCSUhj4tBD
 S+AhVMy8bxFCh1HsVa9ZrZO3mzNR4UWxpseDX/+C8fVrosDshqDbJQJGDxggph1XNEe7bW15jfx
 98j4CdrklnFvGQ==
X-Received: by 2002:a05:6402:2713:b0:5f8:cf9b:d896 with SMTP id
 4fb4d7f45d1cf-6011408876emr13252303a12.12.1747739182898; 
 Tue, 20 May 2025 04:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3dGcqms+S9LcuPCtvpf7YveTHxMASxELpeqO0IaQd/HF5ikIaejvADV3I5hCahBVCs8N0Q==
X-Received: by 2002:a05:6402:2713:b0:5f8:cf9b:d896 with SMTP id
 4fb4d7f45d1cf-6011408876emr13252280a12.12.1747739182491; 
 Tue, 20 May 2025 04:06:22 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae39181sm6967714a12.67.2025.05.20.04.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/35] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:17 +0200
Message-ID: <20250520110530.366202-23-pbonzini@redhat.com>
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

Profile CPUs reuse the instance_init function for bare CPUs; make them
proper subclasses instead.  Enabling a profile is now done based on the
RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef,
subclasses check that the parent class's profile is enabled through the
parent profile mechanism.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 85 +++++++++++++++++++++++++---------------------
 2 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f3d70afb866..ed88adef452 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -540,6 +540,7 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUProfile *profile;
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7dcaf72fc14..54fce767657 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1487,6 +1487,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2959,36 +2963,6 @@ static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
 };
 
-#if defined(TARGET_RISCV64)
-static void rva22u64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22U64.enabled = true;
-}
-
-static void rva22s64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA22S64.enabled = true;
-}
-
-static void rva23u64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA23U64.enabled = true;
-}
-
-static void rva23s64_profile_cpu_init(Object *obj)
-{
-    rv64i_bare_cpu_init(obj);
-
-    RVA23S64.enabled = true;
-}
-#endif
-
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -3057,6 +3031,32 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static bool profile_extends(RISCVCPUProfile *trial, RISCVCPUProfile *parent)
+{
+    RISCVCPUProfile *curr;
+    if (!parent) {
+        return true;
+    }
+
+    curr = trial;
+    while (curr) {
+        if (curr == parent) {
+            return true;
+        }
+        curr = curr->u_parent;
+    }
+
+    curr = trial;
+    while (curr) {
+        if (curr == parent) {
+            return true;
+        }
+        curr = curr->s_parent;
+    }
+
+    return false;
+}
+
 static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -3071,6 +3071,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
     if (data) {
         const RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;
+        if (def->profile) {
+            assert(profile_extends(def->profile, mcc->def->profile));
+            assert(mcc->def->bare);
+            mcc->def->profile = def->profile;
+        }
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3237,19 +3242,22 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         },                                                  \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)  \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
              .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
              .cfg.max_satp_mode = -1,                       \
+             __VA_ARGS__                                    \
         },                                                  \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
+    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+        .profile = &(profile_))
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -3328,10 +3336,11 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
+
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  TYPE_RISCV_CPU_RV64I,  RVA23U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  TYPE_RISCV_CPU_RV64I,  RVA23S64),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.49.0


