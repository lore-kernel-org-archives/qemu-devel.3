Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B98C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxc9-0003MF-7E; Fri, 28 Feb 2025 05:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbV-0002Sk-59
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbS-00030R-2D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=526G1Z9wzI1iTnPfOImX/D4V1GSB+sV0TwnKXWej2o4=;
 b=Wot8VQolyF6hKBYHrToOwdeFearSr6po8jFYDo2hrDp1KeQQAGBt/WwSWanhDhlsgPt9Of
 rpJxhMGgHdJKHEta/8hjyi2fb6H+NldPP31hhbSDWOAxExxrv3v+L/k4GujEjx385ANA/6
 9jvw0IVPQiDwk0ZgrlT7PT+ZwnoHn0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fWy9ihReP2ObCH3Rkwiz2A-1; Fri, 28 Feb 2025 05:28:20 -0500
X-MC-Unique: fWy9ihReP2ObCH3Rkwiz2A-1
X-Mimecast-MFC-AGG-ID: fWy9ihReP2ObCH3Rkwiz2A_1740738499
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-390ddebcbd1so1141932f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738498; x=1741343298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=526G1Z9wzI1iTnPfOImX/D4V1GSB+sV0TwnKXWej2o4=;
 b=tLbpfJ46wJPthuDxEfbvs1/uRNo2edo+ykngVV3ygposqc7fRyikZjEGcH/m8zYfrp
 qy8YboriocLQSNlB3N8AQNx92HjtqsI6a2GYsf/0O3cNCbxUkncIbSe8/VIg6EzVXMkr
 7i5LDaQCP8h/xO6OlrGYG8DNC23cK8gIMn7XX1FFFXtECIcuepo1HVy9iBuOb7oIs+nY
 Io8MN3YozBGlvSowxkGJqFcNdWFO9FLGy+fvJu27evCW1t+UnMCZACdGz3R/etYrLC3d
 RMuHK8qcrRQhgsJhzIshyuli/rdX7dSdFqD4AEIvXoz9WI+ypKTacaAL63u2pp4mJCgB
 R+Yw==
X-Gm-Message-State: AOJu0YwmGvRKzvZa0D2pEdd+wBkS7CUG77SfRBXGjT15P6jr32nA4ZgN
 xNqQQEXTO3BDZRPv1G/HjgZ2UqCXKf0bXuWL+uUTPrpTFd2Bnn4NywKfjU4N+XTzxBlzA9XqHSg
 jyOypL8TXR/q6xTsOoKzXqKOA5RJm6gdyH2J4z/NR82KW8X3mB0IxG7hTHzfYwYXjeckRUP5ZgD
 lJtSmzP50GQf3t0TorFwUU121yizzV+nAAjjkI0yw=
X-Gm-Gg: ASbGncuaImpdfGH/+U+Xiv/n52Yy5tWz7Wckl3EESZvcPH7jbp5DBEIpznv8hjoYsqQ
 zCh6C1HkOSXd/ATYXMDzTASl3Xw+qCsdsTwbQ6TSoPfRvXNW7U24tTmxOPEn9mWE4DOMJQGl7ZT
 rHA4j6wJW48IRF6RQVw5ytdyOMAD/TGwKcDYTpFvbh5CMQVftQMCmDaFW53PTkNFQUIVs+afFQT
 iWwT9NOJwwR4V9iV2BrdVFyJNc6WEbRhxlIBbIcDPS8571/fk7zc/y5J/SVMKOLx5eZo4MwnLB1
 DRRB72DPL5dZDmYqLaKI
X-Received: by 2002:a5d:5988:0:b0:38f:229a:b4d with SMTP id
 ffacd0b85a97d-390eca4179cmr2797747f8f.35.1740738497695; 
 Fri, 28 Feb 2025 02:28:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvalui9qZT0clSgzhPuaiHN0hmINzCEVw1GNhKzNQzbSOxJBvUxGmFmNoY3LA0LNCAAl2/rQ==
X-Received: by 2002:a5d:5988:0:b0:38f:229a:b4d with SMTP id
 ffacd0b85a97d-390eca4179cmr2797713f8f.35.1740738497259; 
 Fri, 28 Feb 2025 02:28:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47965ddsm4902466f8f.18.2025.02.28.02.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 13/22] target/riscv: convert SiFive E CPU models to RISCVCPUDef
Date: Fri, 28 Feb 2025 11:27:37 +0100
Message-ID: <20250228102747.867770-14-pbonzini@redhat.com>
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
 target/riscv/cpu.c     | 74 ++++++++++++------------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf24..bfe1455254c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
+#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c605efa2b92..049d3f90f47 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -501,23 +501,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv64_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -706,23 +689,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv32_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv32_ibex_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -744,23 +710,6 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zbc = true;
     cpu->cfg.ext_zbs = true;
 }
-
-static void rv32_imafcu_nommu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3085,6 +3034,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3093,8 +3051,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVF,  /* IMAFCU */
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
@@ -3120,7 +3084,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV64
+    ),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
-- 
2.48.1


