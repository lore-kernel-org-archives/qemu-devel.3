Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF95CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGic7-0004Mz-Ol; Wed, 05 Nov 2025 13:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGib3-0003zW-Mb
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vGiaz-0003C0-5I
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:51:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47755de027eso1083125e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1762368659; x=1762973459;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kEAytXiAZieewyrZPC8a4xUKmBzYD9xvtE9UlfGJ7s=;
 b=EFhzQbbv0wPlWykprjP3WKV6CmO+27CXO3CmArVK+u9jl8is1/7IErjbmBb5oYYaos
 OhXU8AWnL+P0ABXDugPA64dKfztoZW/uC9kZuX/nAMyf+aeT2Rj2q17Wm/oV+GPq5m5K
 MA0N5af18KTnbDLSVBOUSiC1GdIDPpkh6bhfLVbXaJ17cPztfVtlvgG7sumhV+ABoT+Z
 KzsqyHyCOVdm69/ykmEbO4WrFr9LL/wsjavTQ1DQQCHzK7ZeBCK3SifhYaJYMWAjEXTS
 UdP1bN41pZMqrrZ0KgLRaG9SiLq6mdKSIR4CUKHjHWzmHvvYxnIeyhEEVSLamonclYHe
 a/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762368659; x=1762973459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kEAytXiAZieewyrZPC8a4xUKmBzYD9xvtE9UlfGJ7s=;
 b=j6EeavBCFdrTlxD1wxIds8tOBlwB67PoERTrBSjvo723dLgkPWWanPYBE2q12K5okg
 iYTqe4zBNfZ/vBl/3Emb9J1Nry3SGkQDHTO81TI9TwifIabQN5KPleoOL5ndv1sNwjzN
 Y1Zd2FYa/T4WSq0eCpiTKxtVyCme/o4IzGJs1OVLsQwuftFfM2JUtXXM2o0+murqszd7
 vNpfrkiluipuQebYpcrZW/eR8D5asnYNqQYNhAoTqDUogT99fYbHoLarRIn4cuvvrnp0
 FDICk9kKT9FXnb1cLKXdW/+qqW5R+EJ91QmQXuO3dU6V3yvf646BFvFU0QSCt0jIc2oV
 /71g==
X-Gm-Message-State: AOJu0YwwCn39K3OKfVRhmiebLJaI9BoG/FBu9C0lHjlZ4KmDl12iay3x
 nfWC3Uz3g8GK/Xbd6Cc903IV6/jBIGXsJAFc+np/D04Rm8cSPRN6w76OebgesWjrp6swrHDgduo
 EOAwvMgk=
X-Gm-Gg: ASbGncuyTThAIbabqx7UYUaivDxoeGve0PpCf4mXvBnkKjStGuAg+FzMbCD/NTMzZiu
 JRsfIWBRKAHFGNt+0gZiSqNuS+ymgvZvD5yglwxGw4KJFnVMu3D7HyyWbrZQlrBmj18w3vff3JP
 /sxwbLLNsAdFblagMj6Vq7JybHEgtw0O8i4JPWWbv0JbQAbDu6yyVIT94fbbQ0XSeh+6I/fQz2+
 2O/uUBFVf5tGpFClneqz0AYq/BzfqKe9ht8N+ao0cd+xVK6FGHwH6Xd7DDL6Z3/j68E/aHQH3ju
 2WjZYQqqljxAzF2x4eW/sLQIHJXrpc7E9sr9hNk1qv/72LSqON3gdFzUGd0k9+/qWvyrqAhsefT
 zakMJMWFiBqq9y0ma4PZwc/9gFxD4dR8izkRVNInOaXxLf0H5Dd67RtScnlspqCnOUfNbAX3g+G
 YEVhyq
X-Google-Smtp-Source: AGHT+IFr3rNa2xQ4e9vLjx1Y/rvEMSbm9dL0Zbqa9OTH9Dnzfb9Wt0IYMagpbyuMQh9ZJht7z2oaxg==
X-Received: by 2002:a05:600c:6288:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-4775cdf4317mr34076545e9.22.1762368659324; 
 Wed, 05 Nov 2025 10:50:59 -0800 (PST)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb42a354sm270622f8f.20.2025.11.05.10.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 10:50:58 -0800 (PST)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v3 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor CSR
 hooks
Date: Wed,  5 Nov 2025 20:50:52 +0200
Message-ID: <20251105185056.23565-2-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105185056.23565-1-michael@videogpu.com>
References: <20251105185056.23565-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::335;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Michael <michael@videogpu.com>

Introduce NEORV32 RV32 CPU type under target/riscv, wire NEORV32 vendor ID,
and add a vendor CSR (CSR_MXISA) guarded by mvendorid match, plus meson glue.

Signed-off-by: Michael Levit <michael@videogpu.com>
---
 target/riscv/cpu-qom.h            |  2 ++
 target/riscv/cpu.c                | 18 ++++++++++++++
 target/riscv/cpu.h                |  3 +++
 target/riscv/cpu_cfg.h            |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/cpu_vendorid.h       |  2 ++
 target/riscv/meson.build          |  1 +
 target/riscv/neorv32_csr.c        | 40 +++++++++++++++++++++++++++++++
 8 files changed, 68 insertions(+)
 create mode 100644 target/riscv/neorv32_csr.c

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..d091807160 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -43,6 +43,7 @@
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
+#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
@@ -58,6 +59,7 @@
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
+
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
 
 #endif /* RISCV_CPU_QOM_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..ffe99f71e1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -233,6 +233,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xneorv32xisa, PRIV_VERSION_1_10_0, ext_xneorv32xisa),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
 
     { },
 };
@@ -3032,6 +3034,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp_regions = 8
     ),
 
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3075,6 +3078,21 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVE
     ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 16,
+        .cfg.mvendorid = NEORV32_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs = neorv32_csr_list
+#endif
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..6a9918a25a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -985,5 +985,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
 
+/* Implemented in neorv32_csr.c */
+extern const RISCVCSR neorv32_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..9ad38506e4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -64,5 +64,6 @@ MATERIALISE_EXT_PREDICATE(xtheadmemidx)
 MATERIALISE_EXT_PREDICATE(xtheadmempair)
 MATERIALISE_EXT_PREDICATE(xtheadsync)
 MATERIALISE_EXT_PREDICATE(XVentanaCondOps)
+MATERIALISE_EXT_PREDICATE(xneorv32xisa)
 
 #endif
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..b84e1bd287 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xneorv32xisa)
 
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..66a8f30b81 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -7,4 +7,6 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define NEORV32_VENDOR_ID       0xF0000001
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..44e706ad3f 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -40,6 +40,7 @@ riscv_system_ss.add(files(
   'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
+  'neorv32_csr.c',
 ))
 
 subdir('tcg')
diff --git a/target/riscv/neorv32_csr.c b/target/riscv/neorv32_csr.c
new file mode 100644
index 0000000000..3b0f0cab05
--- /dev/null
+++ b/target/riscv/neorv32_csr.c
@@ -0,0 +1,40 @@
+/*
+ * NEORV32-specific CSR.
+ *
+ * Copyright (c) 2025 Michael Levit
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+#define    CSR_MXISA    (0xfc0)
+
+static RISCVException smode(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+    /* We don't support any extension for now on QEMU */
+    *val = 0x00;
+    return RISCV_EXCP_NONE;
+}
+
+static bool test_neorv32_mvendorid(RISCVCPU *cpu)
+{
+    return cpu->cfg.mvendorid == NEORV32_VENDOR_ID;
+}
+
+const RISCVCSR neorv32_csr_list[] = {
+    {
+        .csrno = CSR_MXISA,
+        .insertion_test = test_neorv32_mvendorid,
+        .csr_ops = { "neorv32.xisa", smode, read_neorv32_xisa }
+    },
+    { }
+};
+
-- 
2.51.1


