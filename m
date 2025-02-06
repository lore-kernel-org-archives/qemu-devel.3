Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D57C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bE-0001C9-W4; Thu, 06 Feb 2025 13:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bB-0001B5-IS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6b9-00015Z-Qv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UABiNyKZ/bmzmvGkR8mvTpjEe+8Lf7G4PtnKvqxLI9I=;
 b=hzvA9bRygNIV0COENRt1GDwXn5iPGh7CYTcr3dpnv9xBXOe8mqnZ5aE8TJLZI/V3FStfCl
 /muFJxrPbBZd+dYcr21JIpDtrEhKZM7/Rd2QwHpT8HHbYtEuE8FpxQs07jqFpJ6+ROF/dX
 P1dvaE9blhXm6Fq3QB4+OPhaRhoIvDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-XGEvwHVuPDmTfYV9lc8S2Q-1; Thu, 06 Feb 2025 13:27:34 -0500
X-MC-Unique: XGEvwHVuPDmTfYV9lc8S2Q-1
X-Mimecast-MFC-AGG-ID: XGEvwHVuPDmTfYV9lc8S2Q
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso7443215e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866452; x=1739471252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UABiNyKZ/bmzmvGkR8mvTpjEe+8Lf7G4PtnKvqxLI9I=;
 b=L6ECjT5cMu/4egSpsbAmmc+Hzqevhe08i+VAEucxHitETmvXUPqDUqO+WbwA09msfA
 e9N4QeRGhJV5S0yfiWkYcvwp/o7ZAZV0W9jT0GQlq8V0QK+SZvi29nmQgxkrf/qtnNaS
 8ZYJT2GT6yQ/ZWfTNd60ZwhZzIqFMzG0OjOUuslCevJjqedF3lyvTH2EG0OFhr72DEfC
 NJ0dB9MH+ZGnNPW82xfdHqna/pfR/caYKJXe4okWRZbmbyX9jyGURje0HipPAiCiHiNY
 OEYigWe05sFG2SKmGf20HMTPA4usx30Fq0yBh6MAGIK1vQOlcKzpWkCp0lcWCNw2ZAoT
 v8sw==
X-Gm-Message-State: AOJu0YxuS7GdsotjBB397JrvM9X1o9Yqyvaq3Vfwv/dJJHY3EoRZ+Jjz
 1nRBMClseergNEwGW3sPIYH5kmju/bPF+MAjLU/7TUVYf8q9vwdMt2kqDum0N9PDjew5HaYvmze
 5gLpoXsiv6o+c+/IF8O0FtqFVkczfgZ1HKE/SALLFeGBY84ZuH22uoHJHuXi729LwjVujOj/aHk
 kGZ8ecIhwcPsxERbaWRPOE4BqzqOk3/hDqHWMak74=
X-Gm-Gg: ASbGncvSszIDcmWhf9ZJP1kzAywHc+0qiJ8l62U6HoAlj4kTi0H2pxYyLJ2BrvRpHZC
 Q4jZqBe5+GFXYgulsT2xBsrHCIYLSwJBisQ+SmibRlOGnWz4SYDPxzBucTQQsJXV61LuIx3rR2Y
 ux8pfFqkTbmbCHh/zBz8k2RG2z6iM2At6xiPFGH3LpDdjhYVerxCNnNscP7me+qT4qgn1Sy8QJ2
 +QUiOroJ2p3Buf9GLsGAVwiQOULH1FQwoWLtI36vs+Q8x4D9lcKlW36XjwbSc5bNXRQxcR8W3V1
 AY3SIX0=
X-Received: by 2002:a05:600c:3b20:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-4392498fe53mr4665785e9.14.1738866452003; 
 Thu, 06 Feb 2025 10:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSpdlN0CPi4WDVY595nEKOIqxIr4ckz9wUgr0CLtJ06JH9+3iZr86CNLoiz/OdIaA8EHwigQ==
X-Received: by 2002:a05:600c:3b20:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-4392498fe53mr4665615e9.14.1738866451608; 
 Thu, 06 Feb 2025 10:27:31 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc8897sm26502715e9.31.2025.02.06.10.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 08/22] target/riscv: convert profile CPU models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:26:56 +0100
Message-ID: <20250206182711.2420505-9-pbonzini@redhat.com>
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

Profile CPUs reuse the instance_init function for bare CPUs; make them
proper subclasses instead.  Enabling a profile is now done based on the
RISCVCPUDef struct: even though there is room for only one in RISCVCPUDef,
subclasses check that the parent class's profile is enabled through the
parent profile mechanism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c | 61 +++++++++++++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1363a081c30..66ce72f7d41 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -519,6 +519,7 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUProfile *profile;
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1cb091ddb0c..253ed5132c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1486,6 +1486,10 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 
+    if (mcc->def->profile) {
+        mcc->def->profile->enabled = true;
+    }
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
@@ -2868,22 +2872,6 @@ static const Property riscv_cpu_properties[] = {
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
-#endif
-
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -2950,6 +2938,22 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static bool profile_has_parent(RISCVCPUProfile *trial, RISCVCPUProfile *parent)
+{
+    if (!parent) {
+        return true;
+    }
+
+    while (parent != trial) {
+        trial = trial->parent;
+        if (!trial) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -2964,6 +2968,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
     if (data) {
         RISCVCPUDef *def = data;
         mcc->def->bare |= def->bare;
+        if (def->profile) {
+            assert(profile_has_parent(def->profile, mcc->def->profile));
+            assert(mcc->def->bare);
+            mcc->def->profile = def->profile;
+        }
         if (def->misa_mxl_max) {
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
@@ -3130,16 +3139,23 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
+#define DEFINE_RISCV_CPU(type_name, parent_type_name, ...)    \
     {                                                       \
         .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
+        .parent = (parent_type_name),                       \
         .class_data = &((RISCVCPUDef) {                     \
-             .misa_mxl_max = (misa_mxl_max_),               \
+             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
+             .satp_mode32 = RISCV_PROFILE_ATTR_UNUSED,      \
+             .satp_mode64 = RISCV_PROFILE_ATTR_UNUSED,      \
+             __VA_ARGS__                                    \
         }),                                                 \
     }
 
+#define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
+    DEFINE_RISCV_CPU(type_name, parent_type_name,             \
+        .profile = &(profile_))
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -3215,8 +3231,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif /* CONFIG_TCG */
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
-    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.48.1


