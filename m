Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFEAC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wek7b-00035b-MF; Tue, 30 Jun 2026 21:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wek7Z-00033L-BC; Tue, 30 Jun 2026 21:52:13 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wek7U-0004aZ-F2; Tue, 30 Jun 2026 21:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782870708; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=9Qp9WyQgZCGMQw/BzdFmRIuqWaTT7FH5KiLpIpJJz54=;
 b=UnIbCJQ5CbI7OM3cbh4UgL10QVgZzRoX923LVqAhvDZEmT9S9oMjU2RgOaxN9tBFkCIj2Ad9HRlFj4Zd/DzO00Umr9bXNp0VwDuQayejrEuUHfs+12IxrEJyPTdkistWbCgB0HmCLEr1eWdZoujiDck4pLKxEBE7tOVopxTgIwU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X61Frtn_1782870706; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X61Frtn_1782870706 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 09:51:47 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 01 Jul 2026 09:51:34 +0800
Subject: [PATCH v2 4/5] disas/riscv: Decode unsigned vector immediates as
 unsigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-disas-xthead-fix-riscv-next-v2-4-e6e4ff5a7847@linux.alibaba.com>
References: <20260701-b4-disas-xthead-fix-riscv-next-v2-0-e6e4ff5a7847@linux.alibaba.com>
In-Reply-To: <20260701-b4-disas-xthead-fix-riscv-next-v2-0-e6e4ff5a7847@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782870704; l=9235;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=tImFSjPmU33K6q3EkmJwGTaBYcGu4Ak+aNy0XMBBkqg=;
 b=npeV81SzyREjx1q0bGtMvKXzrNeMNcMUej2PTC5bjh//TC9DuhYZiQqYGZd/07ZtqR+5Ic3V1
 tQfb1Q09QRGAL3+zb4gx7O6k2JvUqA0TJKWQBbmLaZoc1uuG4AWU+xp
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
---
 disas/riscv.c | 45 ++++++++++++++++++++++++++++-----------------
 disas/riscv.h |  1 +
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e9dcc173d8fa2f89d85b76595a76931c4dddb462..4b3f90418f8f17dd3fcb71f70c39607fa293eb0e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1803,19 +1803,19 @@ const rv_opcode_data rvi_opcode_data[] = {
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
@@ -1909,16 +1909,16 @@ const rv_opcode_data rvi_opcode_data[] = {
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
@@ -2048,15 +2048,15 @@ const rv_opcode_data rvi_opcode_data[] = {
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
@@ -2144,8 +2144,8 @@ const rv_opcode_data rvi_opcode_data[] = {
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
@@ -2169,14 +2169,14 @@ const rv_opcode_data rvi_opcode_data[] = {
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
@@ -4492,6 +4492,11 @@ static int32_t operand_vimm(rv_inst inst)
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
@@ -4895,6 +4900,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
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
index 379e642ec84e2da12ffd7905b590cdcee7bf215f..91ada8b531eb9a03bae49d8d36fc42c497f277ed 100644
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
2.43.0


