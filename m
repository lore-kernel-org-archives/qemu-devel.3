Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443C0CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKAw-0001yD-Tz; Mon, 27 Oct 2025 06:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vDKAq-0001wV-LH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:10:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vDKAf-00040B-Qb
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:10:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so32280245e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1761559782; x=1762164582;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtRQJoFiB7pcTJCh+ZvnNXtLRl+nmZQ4jx3qoxA5tBk=;
 b=YbySV2tIQmmgIjqYxRKslY/wiFV07pMO6efwzarUtTWR+V8sYujhKPgeNZe8kkWoRn
 /oQ1SZ7VGE5uWqKunVvP5HNdpi5HcAkWYzjKYt+zimIyIIxYtD1PtLDeXK/yJm0cgeAY
 xLWzq/qapYgdUpW6wv6A7U5cgfPv4bJ+pqG4/ZdJNIv8sq3Xd2mbfrA3qbuFcL1etTd4
 6/bmRhcLtRHH/7rQWGjQh7zyN4PSpDbVsitI4WYcJil9aAt1Q4skRdREXnzVhA7z3HlI
 9hBwrP3ypn4UGJTag5ON5I32STf5dnx21jAZ+eQSfuzfsiwphAJjPAwtPfQVijBltOW0
 XhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761559782; x=1762164582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtRQJoFiB7pcTJCh+ZvnNXtLRl+nmZQ4jx3qoxA5tBk=;
 b=HRF1/O0JvPylpHzY7yN3l4/iHIFtn1+hic7dZVXOsmE8h4QFNL3vfEufIsUzLekoFG
 N8gvNUDteMlNEneTkQVP5NunDTTjE/JBbRlt4BXPaqz2QCdV6JAjUlXB7pMPlk7p32/K
 TdTfTXmDBMcZW2dy0M2oQ19s/27o7wF3PM27PqRmpa6t2s5HDQN1eOK8blPPkOBCkerk
 m0s0h94WAmuIxRrBp0MB5+4XYtBa9v0SEzMyGzffDT+C9N6Q11AfVFqQfax5WiIxjJyY
 upJQW30C+Vj7m0ZmZgNQQGIobXfQr4JS8zHSll9NnHDyLozHAC+vMP2usoNp5OqlXrYq
 /lBQ==
X-Gm-Message-State: AOJu0YySs/Eja5jbXv5huDHuctKe8s4nn8by7NdR0GMXQ/8FwAmMiOOM
 imeH0UVYaqmGtBwobbr9l7Qj2Aw0NbFYINzGAI5RBg1lTSp5PqfxEDaV44IGPuFOWcqYE40NemG
 7XyPNwvY=
X-Gm-Gg: ASbGncvOVp0bgSVwj3JUlSpymnsq/dTBO+B7tZ+9qJtZWHiy1CR1GowDWw+6Pah5GMW
 SMOaQ8lc5j21mfs8XAHikSi4d8if7B6lr6fdflZ6WAaFS3mP9XUe5GUJgkUWrBIQ6yeckM5a2sm
 1yjRjDxNXOVSqz8YCze0wJ5zyVBbr31T/vDi00GR37Xjg41GtrSGbwjqaT12G+9fZh3yj9V0DZd
 Dj8PmU40mGojVbJ6BxnadpVHcmFR9JpRGMAywhMx0jtDdRM0Qb7Y/muo3JhTsrS/Vy3awWak/LN
 YFGejqeWqL0WzbSIgHCl/U1na/TJZRV8koN9PF7jA9zujuMdL8XE1uS11a4hdDL6ArTPB9z2E4z
 /csWGM6KPPsiNduWmD5MCaHb6La3E99IUoDVz/7BkG7o2N6Ol44J8H8KgTNXssAszgFEEcdjF8A
 eLcUfDiuHMb0JRO7E=
X-Google-Smtp-Source: AGHT+IFMy/yGpwSLnbhwF8Ns79k3ADjKozexDFT+nkocGz91RvifcgzOmOpWlobffcHHka6vsUksrw==
X-Received: by 2002:a05:600c:4ed0:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-475d2426e58mr93920965e9.11.1761559782105; 
 Mon, 27 Oct 2025 03:09:42 -0700 (PDT)
Received: from DDesktop.local ([2a10:8012:d:eea4:f4de:376b:66b1:d7b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd494d5csm128625465e9.9.2025.10.27.03.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 03:09:41 -0700 (PDT)
From: Michael Levit <michael@videogpu.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
Subject: [PATCH v2 1/5] target/riscv: add NEORV32 RV32 CPU type and vendor CSR
 hooks
Date: Mon, 27 Oct 2025 12:09:34 +0200
Message-ID: <20251027100938.11822-2-michael@videogpu.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027100938.11822-1-michael@videogpu.com>
References: <20251027100938.11822-1-michael@videogpu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::332;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..a39bf853cc 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,8 @@
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
+#define TYPE_RISCV_CPU_NEORV32          RISCV_CPU_TYPE_NAME("neorv32")
+
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..7bcf93c66c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempair),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
+    ISA_EXT_DATA_ENTRY(xneorv32xisa,PRIV_VERSION_1_10_0,ext_xneorv32xisa), 
 
     { },
 };
@@ -1366,6 +1367,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+	MULTI_EXT_CFG_BOOL("xneorv32xisa", ext_xneorv32xisa, false),
 
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
+	DEFINE_RISCV_CPU(TYPE_RISCV_CPU_NEORV32, TYPE_RISCV_VENDOR_CPU,
+		.misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.pmp_regions = 16,
+		.cfg.mvendorid = NEORV32_VENDOR_ID,
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
index 0000000000..0cb8663436
--- /dev/null
+++ b/target/riscv/neorv32_csr.c
@@ -0,0 +1,54 @@
+/*
+ * Neorv32-specific CSR.
+ *
+ * Copyright (c) 2025 Michael Levit
+ *
+ * Author:
+ *   Michael Levit <michael@videogpu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
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
+	return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_neorv32_xisa(CPURISCVState *env, int csrno,
+                                       target_ulong *val)
+{
+	/* We don't support any extension for now on QEMU */
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

