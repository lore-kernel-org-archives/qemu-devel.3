Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA59EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgqT-0008N2-8i; Tue, 14 Jan 2025 08:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqR-0008Mr-RN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:35 -0500
Received: from mail-oa1-x42.google.com ([2001:4860:4864:20::42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqQ-0003uR-3T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:35 -0500
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-29fad34bb62so2938753fac.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736860831; x=1737465631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abnY8U3wK6nUZ8NcZvVZddJMO8Mh8IA8tUD5yUUM9ig=;
 b=XuKg/SUnDeidGAHAqz19OJP3PUQthMdlPxwrjCOX44xLGclD3t/F6bhOGpf1TKwjuW
 K+vSyjeYmEb4YcnRR0DmF1pDJaHC/Hp7Y5IQNdj7uiTYz7FVpYsN3KbGpAxog66PkV9u
 FC/p5TcXzdGKygFCRfDJ52DjPEOYnZ/Hf2eqY0TQWR0r5YUXjhHLQg8Cjy0iClZFj4mR
 IjLD4WsCDlyDepVobydY6bCf+xDe8Il1S0uRnejc8warYLTuhWeSVoE3Z1YK8IVk9Bpy
 qlMiPgRyf4/LRNbUWcwrHxHW0na48Y3IMlWw7BJxWSMI26w/BU1MkfvMtfzfvfzh5mqE
 R4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860831; x=1737465631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abnY8U3wK6nUZ8NcZvVZddJMO8Mh8IA8tUD5yUUM9ig=;
 b=IvkKB34+rkNVFrFoq5acp4LkZ36l8nRsmRBZjPUwGwFu1mcFJDjNTFaoFCpr6Kd5b4
 KuPoQM3Bza9sqfHTFkxsmE1Ih2bA+bTjG3FpIb29IVKphi21tdcIqgGoRTIj4is1al4d
 Cn0F0VhLVz6q4FLcYmaM27n98RYYQVc1caK4DwN4ngqKyzgyljpqMOTHaLmYNtQ6I1eq
 t6h7tqUtb3jZrWm1IXubmsZVQWkDuTteYWlkZzjRE1xHrmG5I8T2MjZA1VPMHCOmcwPQ
 Jd0U5+k9C06JIbV3OtmZj5om0dxQ8wjeXGoTU5wppNx86WMaInTuHaJGL2LGYY/ha+kx
 iLMg==
X-Gm-Message-State: AOJu0YwvMYIi31ADdwl5BLf7/nOXVxcOsZP7pqogTgWGGS42HtRB07jl
 OEDN1tHjjjhSrxQYcjPa1/ismQ5cX9Skyc6wh3v6ck24e1vx7SLf76MCzNmeG0LR9Tk2bYoXYNu
 1jhVLRQ==
X-Gm-Gg: ASbGncvnRfOE42wQPzGGIeeM6cnAaZMjO64lpwIG+rvNKTRIJ3zBMfPe114lFaI78/s
 UykJGX7EFwOAe3UUZxfnNXZU3ZVIbZJKfQIoTt74XByz86w9xr0vXpCeelxCDSsKFMcLO3kfNsE
 FFadqXm4bFyBPBpP991SDde2gKp6OiEd1O1qHJKnWJjupDmJXFW+3xZZS9HsMN7cLUBQPgqpiGW
 9wdg7N28DYzeHHhWOF1tCOn7bCmrdDkyhtMpJgtqO+K9MlJfGtH4uO3iNpFeyQWnO/2GoBOS17o
 pnd/lOOCzQ==
X-Google-Smtp-Source: AGHT+IF1FkJz4nkwEkYMR1eM/GccftNxCVP+lemCrr5mmwmA/3sB/VweWAQ7w+V17wqflDzRf2z6iw==
X-Received: by 2002:a05:6870:6f14:b0:29e:5897:e9ed with SMTP id
 586e51a60fabf-2aa06982ebcmr16110105fac.35.1736860831086; 
 Tue, 14 Jan 2025 05:20:31 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809b10e4sm5052411fac.35.2025.01.14.05.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:20:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/4] target/riscv: add RVA23U64 profile
Date: Tue, 14 Jan 2025 10:20:11 -0300
Message-ID: <20250114132012.1224941-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::42;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x42.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add RVA23U64 as described in [1]. This profile does not share all
mandatory RVA22U64 extensions so we can't use RVA22U64 as a parent. We
need to declare all mandatory extensions from scratch.

A new "rva23u64" CPU is also added.

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf2..53ead481a9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -40,6 +40,7 @@
 #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
+#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8d0563527f..e10ecc4ece 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2394,9 +2394,35 @@ static RISCVCPUProfile RVA22S64 = {
     }
 };
 
+/*
+ * All mandatory extensions from RVA22U64 are present
+ * in RVA23U64 so set RVA22 as a parent. We need to
+ * declare just the newly added mandatory extensions.
+ */
+static RISCVCPUProfile RVA23U64 = {
+    .parent = &RVA22U64,
+    .name = "rva23u64",
+    .misa_ext = RVV,
+    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
+        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
+        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
+        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
+        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
+
+        /* mandatory named features for this profile */
+        CPU_CFG_OFFSET(ext_supm),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
+    &RVA23U64,
     NULL,
 };
 
@@ -2883,6 +2909,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
     RVA22S64.enabled = true;
 }
+
+static void rva23u64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA23U64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -3162,6 +3195,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


