Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACFEC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdRX-0006gJ-13; Tue, 02 Jul 2024 09:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sOZMG-0003A7-4N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:59:28 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sOZMC-00031v-NV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:59:27 -0400
DKIM-Signature: a=rsa-sha256; bh=304yZMpdTppkxIaH4Pli6Fdyapdt9qXmOKhQNI8J/8s=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To; 
 q=dns/txt; s=20240113; t=1719910755; v=1;
 b=N9jO0hy/16fL9K+9rpsWSrwt/YoDOc558U79/OM893D84XWaj0SLaItiRxsrw26LZyBdBH+t
 RpPUlzcDqbBw4J36XlYXmb4l2992R3jHbjX54i9QVR2IZ6+yGKwbnzKboydjOxxOMUgHuC/82WO
 2QBZ5IOtkT+/AcpGfU3w3Ar69BLlsRnlMRB/NJEat6k6zMvNulHk1B13UGLUrZvTON2XPktM8+5
 Hhu46WumsvzS9gAa86KcxpXAvO1YOn9JddVt4lDcBdr/sdBq2klmNHMrSsrOrxepwJFhBdV7T3d
 z6pTRVHba1BGMPhjIZTdNITrfzjRBTlBUx5gS3ubhOFPA==
Received: from git.sr.ht (unknown [IPv6:2a03:6000:1813:1337::155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 1424820154
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2024 08:59:15 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Tue, 02 Jul 2024 16:10:44 +0800
Subject: [PATCH qemu 1/1] target/riscv: Add Zilsd and Zcmlsd extension support
Message-ID: <171991075495.29791.18431108398571296272-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <171991075495.29791.18431108398571296272-0@git.sr.ht>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jul 2024 09:21:07 -0400
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: lxx <1733205434@qq.com>

This patch adds support for the Zilsd and Zcmlsd extension,
which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/v0.9=
.0

Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
Co-developed-by: LIU Xu <liuxu@nucleisys.com>
Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
---
 target/riscv/cpu.c                         |  4 +
 target/riscv/cpu_cfg.h                     |  2 +
 target/riscv/insn16.decode                 |  8 ++
 target/riscv/insn32.decode                 | 12 ++-
 target/riscv/insn_trans/trans_zcmlsd.c.inc | 98 ++++++++++++++++++++++
 target/riscv/insn_trans/trans_zilsd.c.inc  | 97 +++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                 | 13 +++
 target/riscv/translate.c                   |  2 +
 8 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zcmlsd.c.inc
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36e3e5fdaf..71274e36f8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
+    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
@@ -132,6 +133,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(zce, PRIV_VERSION_1_12_0, ext_zce),
     ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
     ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
+    ISA_EXT_DATA_ENTRY(zcmlsd, PRIV_VERSION_1_12_0, ext_zcmlsd),
     ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
     ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
     ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
@@ -1492,6 +1494,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
=20
     MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
     MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
+    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
=20
     MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
     MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
@@ -1531,6 +1534,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =3D=
 {
     MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
     MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
     MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
+    MULTI_EXT_CFG_BOOL("zcmlsd", ext_zcmlsd, false),
=20
     /* Vector cryptography extensions */
     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cb750154bd..54e93897ee 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -51,6 +51,7 @@ struct RISCVCPUConfig {
     bool ext_zcf;
     bool ext_zcmp;
     bool ext_zcmt;
+    bool ext_zcmlsd;
     bool ext_zk;
     bool ext_zkn;
     bool ext_zknd;
@@ -71,6 +72,7 @@ struct RISCVCPUConfig {
     bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_zihpm;
+    bool ext_zilsd;
     bool ext_ztso;
     bool ext_smstateen;
     bool ext_sstc;
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index b96c534e73..5014caa128 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
 {
   ld              011  ... ... .. ... 00 @cl_d
   c_flw           011  ... ... .. ... 00 @cl_w
+  # *** Zcmlsd Extension ***
+  zcmlsd_ld       011  ... ... .. ... 00 @cl_d
 }
 {
   sd              111  ... ... .. ... 00 @cs_d
   c_fsw           111  ... ... .. ... 00 @cs_w
+  # *** Zcmlsd Extension ***
+  zcmlsd_sd       111  ... ... .. ... 00 @cs_d
 }
=20
 # *** RV32/64C Standard Extension (Quadrant 1) ***
@@ -207,10 +211,14 @@ sw                110 .  .....  ..... 10 @c_swsp
   c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
   ld              011 .  .....  ..... 10 @c_ldsp
   c_flw           011 .  .....  ..... 10 @c_lwsp
+  # *** Zcmlsd Extension *** =20
+  zcmlsd_ldsp     011 .  .....  ..... 10 @c_ldsp
 }
 {
   sd              111 .  .....  ..... 10 @c_sdsp
   c_fsw           111 .  .....  ..... 10 @c_swsp
+  # *** Zcmlsd Extension ***  =20
+  zcmlsd_sdsp     111 .  .....  ..... 10 @c_sdsp
 }
=20
 # *** RV64 and RV32 Zcb Extension ***
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..f6f4b7950b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -169,8 +169,16 @@ csrrci   ............     ..... 111 ..... 1110011 @csr
=20
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
-ld       ............   ..... 011 ..... 0000011 @i
-sd       ....... .....  ..... 011 ..... 0100011 @s
+{
+  ld       ............   ..... 011 ..... 0000011 @i
+  # *** Zilsd instructions ***
+  zilsd_ld ............   ..... 011 ..... 0000011 @i
+}
+{
+  sd       ....... .....  ..... 011 ..... 0100011 @s
+  # *** Zilsd instructions ***
+  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
+}
 addiw    ............   ..... 000 ..... 0011011 @i
 slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
 srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
diff --git a/target/riscv/insn_trans/trans_zcmlsd.c.inc b/target/riscv/insn_t=
rans/trans_zcmlsd.c.inc
new file mode 100644
index 0000000000..b3587d8a7c
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zcmlsd.c.inc
@@ -0,0 +1,98 @@
+/*
+ * RISC-V translation routines for the Zcmlsd Extension.
+ *
+ * Copyright (c) 2024 Nucleisys, Inc.
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
+ * You should have received a copy of the GNU General Public License along w=
ith
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZCMLSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zcmlsd)  \
+        return false;               \
+} while (0)
+
+=20
+static bool gen_load_ld(DisasContext *ctx, arg_lb *a, MemOp memop, int flag)
+{
+    REQUIRE_ZCMLSD(ctx);
+    REQUIRE_32BIT(ctx);
+
+    if (flag&&a->rd=3D=3D0){
+        return false;
+    }
+
+    TCGv dest_low=3D dest_gpr(ctx, a->rd);
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    tcg_gen_qemu_ld_tl(dest_low, addr, ctx->mem_idx, memop);
+
+    TCGv dest_high=3D dest_gpr(ctx, a->rd+1);
+    tcg_gen_addi_tl(addr, addr, 32);
+    tcg_gen_qemu_ld_tl(dest_high, addr, ctx->mem_idx, memop);
+
+    gen_set_gpr(ctx, a->rd, dest_low);
+    gen_set_gpr(ctx, a->rd+1, dest_high);
+
+    return true;
+}
+
+// zcmlsd c.ldsp=20
+static bool trans_zcmlsd_ldsp(DisasContext *ctx, arg_zcmlsd_ldsp *a)
+{
+    return gen_load_ld(ctx, a, MO_TESL, 1);
+}
+
+//zcmlsd c.ld =20
+static bool trans_zcmlsd_ld(DisasContext *ctx, arg_zcmlsd_ld *a)
+{
+    return gen_load_ld(ctx, a, MO_TESL, 0);
+}
+
+static bool gen_store_sd(DisasContext *ctx, arg_sb *a, MemOp memop, int flag)
+{
+    REQUIRE_ZCMLSD(ctx);
+    REQUIRE_32BIT(ctx);
+
+    if(flag&&a->rs2=3D=3D0){
+        TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
+        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+        tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+
+        tcg_gen_addi_tl(addr, addr, 32);
+        tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop); =20
+
+        return true;
+    }
+
+    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data_high =3D get_gpr(ctx, a->rs2+1, EXT_NONE);
+
+
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    tcg_gen_qemu_st_tl(data_low, addr, ctx->mem_idx, memop);
+
+    tcg_gen_addi_tl(addr, addr, 32);
+    tcg_gen_qemu_st_tl(data_high, addr, ctx->mem_idx, memop); =20
+    return true;
+}
+
+//zcmlsd c.sdsp
+static bool trans_zcmlsd_sdsp(DisasContext *ctx, arg_zcmlsd_sdsp *a)
+{
+    return gen_store_sd(ctx, a, MO_TESL, 1);
+}
+
+//zcmlsd c.sd
+static bool trans_zcmlsd_sd(DisasContext *ctx, arg_zcmlsd_sd *a)
+{
+    return gen_store_sd(ctx, a, MO_TESL, 0);
+}
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_tr=
ans/trans_zilsd.c.inc
new file mode 100644
index 0000000000..25d93d3f50
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -0,0 +1,97 @@
+/*
+ * RISC-V translation routines for the Zilsd Extension.
+ *
+ * Copyright (c) 2024 Nucleisys, Inc.
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
+ * You should have received a copy of the GNU General Public License along w=
ith
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZILSD(ctx) do {    \
+    if (!ctx->cfg_ptr->ext_zilsd)  \
+        return false;              \
+} while (0)
+
+static bool gen_load_i32(DisasContext *ctx, arg_ld *a, MemOp memop)
+{
+    REQUIRE_ZILSD(ctx);
+    REQUIRE_32BIT(ctx);
+
+    if((a->rd) %2){
+        return false;
+    }
+    if(a->rd=3D=3D0){
+        TCGv dest =3D dest_gpr(ctx, a->rd); =20
+
+        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+        tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
+
+        gen_set_gpr(ctx, a->rd, dest);
+        return true;
+    }
+
+    TCGv dest_low =3D dest_gpr(ctx, a->rd);
+    TCGv dest_high =3D dest_gpr(ctx, a->rd+1);
+
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    tcg_gen_qemu_ld_tl(dest_low, addr, ctx->mem_idx, memop);
+
+    tcg_gen_addi_tl(addr, addr, 32);
+    tcg_gen_qemu_ld_tl(dest_high, addr, ctx->mem_idx, memop);
+=20
+    gen_set_gpr(ctx, a->rd, dest_low);
+    gen_set_gpr(ctx, a->rd+1, dest_high);
+
+    return true;
+}
+
+static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
+{
+    return gen_load_i32(ctx, a, MO_TESL);
+}
+
+static bool gen_store_i32(DisasContext *ctx, arg_sd *a, MemOp memop)
+{
+    REQUIRE_ZILSD(ctx);
+    REQUIRE_32BIT(ctx);
+
+    if((a->rs2) %2){
+        return false;
+    }
+    if(a->rs2=3D=3D0){
+        TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
+        TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+        tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
+
+        tcg_gen_addi_tl(addr, addr, 32);
+        tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop); =20
+
+        return true;
+    }
+
+    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data_high =3D get_gpr(ctx, a->rs2+1, EXT_NONE);
+
+    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
+    tcg_gen_qemu_st_tl(data_low, addr, ctx->mem_idx, memop);   =20
+
+    tcg_gen_addi_tl(addr, addr, 32);
+    tcg_gen_qemu_st_tl(data_high, addr, ctx->mem_idx, memop); =20
+
+    return true;
+}
+
+static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
+{
+    return gen_store_i32(ctx, a, MO_TESL);
+}
+
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b5b95e052d..8321586513 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -721,6 +721,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Er=
ror **errp)
         cpu->pmu_avail_ctrs =3D 0;
     }
=20
+    if (cpu->cfg.ext_zcmlsd) {
+        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
+            error_setg(errp,
+                    "Zcmlsd cannot be supported together with C and F extens=
ion");
+            return;
+        }
+        if (cpu->cfg.ext_zcf) {
+            error_setg(errp,
+                    "Zcmlsd cannot be supported together with Zcf extension"=
);
+            return;
+        }
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ff09ebdb6..ec39897ef6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1109,10 +1109,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
 #include "decode-xthead.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_zilsd.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
+#include "insn_trans/trans_zcmlsd.c.inc"
=20
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
--=20
2.43.4

