Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61251C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOp7y-0005Fa-69; Tue, 02 Jul 2024 21:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp7w-0005DD-Pa; Tue, 02 Jul 2024 21:49:44 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp7u-0003GH-Hi; Tue, 02 Jul 2024 21:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719971377; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=oc7hLj9TA+xntZOXNaglhfbhL9qRiZrXTNam8MYrmTQ=;
 b=ft6AV5l4vP30SALfsOFVE0l+5NVNsSbokPc+yqUMZ+PEKHmRl3oh1OBb2mXVzqKBgJdwckhqKP1fvPPOTFioZd1OEAh3C6OUX6W6cYujdEpAOhN4VTI/DQdkUnjHvoI/sLA6lcS0d3oZUXVfTOaSP4PCloWB3SrQLTFDYD3LpU0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045046011;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9kB1oG_1719971375; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9kB1oG_1719971375) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 09:49:36 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 03/11] target/riscv: Add zcmop extension
Date: Wed,  3 Jul 2024 09:46:27 +0800
Message-Id: <20240703014635.1020-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
References: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Zcmop defines eight 16-bit MOP instructions named C.MOP.n, where n is
an odd integer between 1 and 15, inclusive. C.MOP.n is encoded in
the reserved encoding space corresponding to C.LUI xn, 0.

Unlike the MOPs defined in the Zimop extension, the C.MOP.n instructions
are defined to not write any register.

In current implementation, C.MOP.n only has an check function, without any
other more behavior.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.c                          |  2 ++
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/insn16.decode                  |  1 +
 target/riscv/insn_trans/trans_rvzcmop.c.inc | 29 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |  5 ++++
 target/riscv/translate.c                    |  1 +
 6 files changed, 39 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d3853a5804..1d1402775a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -131,6 +131,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zcf, PRIV_VERSION_1_12_0, ext_zcf),
     ISA_EXT_DATA_ENTRY(zcd, PRIV_VERSION_1_12_0, ext_zcd),
     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
+    ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
@@ -1473,6 +1474,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
+    MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9f53512053..d85e54b475 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -72,6 +72,7 @@ struct RISCVCPUConfig {
     bool ext_zihintpause;
     bool ext_zihpm;
     bool ext_zimop;
+    bool ext_zcmop;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..3953bcf82d 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -140,6 +140,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  c_mop_n         011 0 0 n:3 1 00000 01
   illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/insn_trans/trans_rvzcmop.c.inc
new file mode 100644
index 0000000000..7205586508
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzcmop.c.inc
@@ -0,0 +1,29 @@
+/*
+ * RISC-V translation routines for compressed May-Be-Operation(zcmop).
+ *
+ * Copyright (c) 2024 Alibaba Group.
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
+#define REQUIRE_ZCMOP(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zcmop) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_c_mop_n(DisasContext *ctx, arg_c_mop_n *a)
+{
+    REQUIRE_ZCMOP(ctx);
+    return true;
+}
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ae25686824..28cc3f80a9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -547,6 +547,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zcmop && !cpu->cfg.ext_zca) {
+        error_setg(errp, "Zcmop extensions require Zca");
+        return;
+    }
+
     if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 379b68289f..8a546f4ece 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1114,6 +1114,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_rvzcmop.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
-- 
2.25.1


