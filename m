Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E944AC41513
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNkvl-0006YQ-G9; Sat, 29 Jun 2024 23:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkvX-0006Y5-JA; Sat, 29 Jun 2024 23:08:31 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkvT-0000wR-GB; Sat, 29 Jun 2024 23:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719716901; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=A3JuOTMxLSbK/pXjLABAyUHquPtz88g44ruCMME92tY=;
 b=rekDcVAWzaW0xdUebNRnWIckEUU2RRy9Q5EWtUgjPyGE3ZQLIatkZEvsyIMgfZnzebv6SBbUFHMA4Ddw6cYyzFDgc/3l+6gsYcJsOR15g/rCxpyJf19cgi1M4R7VTXRQHZe+yJItp97ix/GmFepe1aSJ/xB0I4kyMleoTccP1GI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033023225041;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9UWXd0_1719716898; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9UWXd0_1719716898) by smtp.aliyun-inc.com;
 Sun, 30 Jun 2024 11:08:19 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 01/11] target/riscv: Add zimop extension
Date: Sun, 30 Jun 2024 11:05:49 +0800
Message-Id: <20240630030559.877-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
References: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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

Zimop extension defines an encoding space for 40 MOPs.The Zimop
extension defines 32 MOP instructions named MOP.R.n, where n is
an integer between 0 and 31, inclusive. The Zimop extension
additionally defines 8 MOP instructions named MOP.RR.n, where n
is an integer between 0 and 7.

These 40 MOPs initially are defined to simply write zero to x[rd],
but are designed to be redefined by later extensions to perform some
other action.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                          |  2 ++
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/insn32.decode                  | 11 ++++++
 target/riscv/insn_trans/trans_rvzimop.c.inc | 37 +++++++++++++++++++++
 target/riscv/translate.c                    |  1 +
 5 files changed, 52 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a2640cf259..d3853a5804 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -1471,6 +1472,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index fb7eebde52..9f53512053 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -71,6 +71,7 @@ struct RISCVCPUConfig {
     bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_zihpm;
+    bool ext_zimop;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..972a1e8fd1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -38,6 +38,8 @@
 %imm_bs   30:2                   !function=ex_shift_3
 %imm_rnum 20:4
 %imm_z6   26:1 15:5
+%imm_mop5 30:1 26:2 20:2
+%imm_mop3 30:1 26:2
 
 # Argument sets:
 &empty
@@ -56,6 +58,8 @@
 &r2nfvm    vm rd rs1 nf
 &rnfvm     vm rd rs1 rs2 nf
 &k_aes     shamt rs2 rs1 rd
+&mop5 imm rd rs1
+&mop3 imm rd rs1 rs2
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -98,6 +102,9 @@
 @k_aes   .. ..... ..... .....  ... ..... ....... &k_aes  shamt=%imm_bs   %rs2 %rs1 %rd
 @i_aes   .. ..... ..... .....  ... ..... ....... &i      imm=%imm_rnum        %rs1 %rd
 
+@mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
+@mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
+
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
 
@@ -1010,3 +1017,7 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
 amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 # *** RV64 Zacas Standard Extension ***
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
+
+# *** Zimop may-be-operation extension ***
+mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 0111011 @mop5
+mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 0111011 @mop3
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/insn_trans/trans_rvzimop.c.inc
new file mode 100644
index 0000000000..165aacd2b6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzimop.c.inc
@@ -0,0 +1,37 @@
+/*
+ * RISC-V translation routines for May-Be-Operation(zimop).
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
+#define REQUIRE_ZIMOP(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zimop) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)
+{
+    REQUIRE_ZIMOP(ctx);
+    gen_set_gpr(ctx, a->rd, ctx->zero);
+    return true;
+}
+
+static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)
+{
+    REQUIRE_ZIMOP(ctx);
+    gen_set_gpr(ctx, a->rd, ctx->zero);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0569224e53..379b68289f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1099,6 +1099,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
+#include "insn_trans/trans_rvzimop.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
 #include "insn_trans/trans_rvzfh.c.inc"
 #include "insn_trans/trans_rvk.c.inc"
-- 
2.25.1


