Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E48C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp7w-0002yH-Mf; Tue, 25 Aug 2026 07:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7s-0002ip-S0; Tue, 25 Aug 2026 07:15:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7q-0000YB-6J; Tue, 25 Aug 2026 07:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=9BOrZsaYURfZM2YijYKjrrBqnHc/RMnHuXvFEe+Tito=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T/sXP0pa9hZReRNEwqWTzUTyJWoJcREBNL9T9vDYmQPDlT42sHZFwHl9vQEjZUupL
 FsHkyylpSgKUfX0U8xHCGEp6uvJdpYElxxkk/4J91heyYQQAeES0KcOj7Xg+nFVuf5
 pHW+P3SK96aWq1RLhoBzZzOmZ/9/9Yc/nPZwFU3hFreiYO6eVsHYamGB3euR+cAX70
 9gtJMiVJOIZq17/y4p07yu5fxeiPkly6zE/FXNibux2N+NUZRZTesbLqhtyaCVesMM
 9IBR4B1ivrbgPyuWaTlIarumuumL6umz+7rkn3aDshiCv2vrpCCjUPVCS2uqVctvaa
 yD+rpBweLeWNQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A05D1CE4B8;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82CC6416284;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A173A325B3; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 156/166] disas/riscv: Decode unsigned vector
 immediates as unsigned
Date: Tue, 25 Aug 2026 14:11:52 +0300
Message-ID: <20260825111206.482723-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_v_i decodes all .vi operands with operand_vimm(), which
sign-extends bits 19:15. That matches spec operands named imm, but not the
.vi forms whose operand is uimm; uimm=31 is decoded as -1 and printed by
the shared 6-bit 'u' formatter as 63.

Add rv_codec_v_i_u/operand_vuimm() for the 5-bit uimm forms: vsll.vi,
vsrl.vi, vsra.vi, vnsrl.wi, vnsra.wi, vssrl.vi, vssra.vi, vnclipu.wi,
vnclip.wi, vslideup.vi, vslidedown.vi, vrgather.vi, vaeskf1.vi,
vaeskf2.vi, vsm3c.vi, vsm4k.vi and vwsll.vi. The remaining rv_codec_v_i
entries are the signed imm forms.

Fixes: 07f4964d1785 ("disas/riscv.c: rvv: Add disas support for vector instructions")
Fixes: 9d92f56d4a44 ("disas/riscv: Add support for vector crypto extensions")
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-4-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 00cec77a7f9f80eb6dc8f0c27009403729e3641e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 99d7474aff2..5cb9fdaa044 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1801,19 +1801,19 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL, 0, 0, 0 },
     { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vsra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnsrl.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnsra.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm, NULL, 0, 0, 0 },
@@ -1907,16 +1907,16 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vssrl.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vssra.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnclipu.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vnclip.wi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm, NULL, 0, 0, 0 },
     { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
@@ -2046,15 +2046,15 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2, NULL, 0, 0, 0 },
     { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1, NULL, 0, 0, 0 },
     { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vslideup.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vslidedown.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
     { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vrgather.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
@@ -2142,8 +2142,8 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
-    { "vaeskf1.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
-    { "vaeskf2.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
@@ -2167,14 +2167,14 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
     { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
-    { "vsm3c.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
-    { "vsm4k.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
     { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
     { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
     { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
-    { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
     { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
@@ -4484,6 +4484,11 @@ static int32_t operand_vimm(rv_inst inst)
     return (int64_t)(inst << 44) >> 59;
 }
 
+static uint32_t operand_vuimm(rv_inst inst)
+{
+    return extract32(inst, 15, 5);
+}
+
 static uint32_t operand_vzimm11(rv_inst inst)
 {
     return (inst << 33) >> 53;
@@ -4887,6 +4892,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = operand_vimm(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_v_i_u:
+        dec->rd = operand_rd(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_vuimm(inst);
+        dec->vm = operand_vm(inst);
+        break;
     case rv_codec_vror_vi:
         dec->rd = operand_rd(inst);
         dec->rs2 = operand_rs2(inst);
diff --git a/disas/riscv.h b/disas/riscv.h
index d211700cb2f..36baf5a9880 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -149,6 +149,7 @@ typedef enum {
     rv_codec_v_r,
     rv_codec_v_ldst,
     rv_codec_v_i,
+    rv_codec_v_i_u,
     rv_codec_vsetvli,
     rv_codec_vsetivli,
     rv_codec_vror_vi,
-- 
2.47.3


