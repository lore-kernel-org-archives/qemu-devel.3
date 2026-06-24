Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCABCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFro-0004SK-Eq; Wed, 24 Jun 2026 01:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqh-0002yw-3K; Wed, 24 Jun 2026 01:08:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqd-0005s8-Ce; Wed, 24 Jun 2026 01:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=3pmqdTuQKL7Ee46dsIVEijwBx9RjPavHAyp1CRdfrm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pj6J+t4zkwEdS0BZLvR0EgBVnX+BZDitVqvD+PGvD7EhAwTUE4mGSTSFefY39M2mz
 6QMpP7dKi/lIuAKeJb4euPeywbxsgi0bN0FUAZOoGc5bCS0Wqq+OykVlfSwfVLuN2m
 MBFJJ2ZwI7v6St5HYjWvr8Sk3uJt8MyxXaLiIcAcol/7q/1QYC42DD4VNAE/SfU3vS
 6jyNvYfuLDgKKOaouAU0AZtGsHD45+fi1z5pSNUc5lJ9VcngtClrqqHBJhl4RHKbFJ
 Vi0nxwAH51Yx6aXZgHtdBY4cbHJlH59t/FPUc9X7JoXX/q3aX25ayup1WXPVFdRpZ4
 vlyo9ilmdI5+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1177A1BA66A;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EDC683DDB07;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 76/95] disas/riscv.c: add 'cbo' insns to disassembler
Date: Wed, 24 Jun 2026 08:05:11 +0300
Message-ID: <20260624050541.395079-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
disassembler recognizes all of them as 'lq', an insn that happens to
share the same opcode space.

While we're at it reorder cbo_* entries in insn32.decode using opcode
order instead of insn name.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9273cda72293ed2f414a0f239c4ac78fb7838c0e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2a..980da7f7e1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -984,6 +984,10 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_cbo_inval = 956,
+    rv_op_cbo_clean = 957,
+    rv_op_cbo_flush = 958,
+    rv_op_cbo_zero = 959,
 } rv_op;
 
 /* register names */
@@ -2254,6 +2258,10 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2875,7 +2883,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_fence; break;
             case 1: op = rv_op_fence_i; break;
-            case 2: op = rv_op_lq; break;
+            case 2:
+               /*
+                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
+                * with 'cbo' insns.  Check the next 5 bits to select
+                * what we want:
+                *
+                * cbo_inval  0000000 00000 ..... 010 00000 0001111
+                * cbo_clean  0000000 00001 ..... 010 00000 0001111
+                * cbo_flush  0000000 00010 ..... 010 00000 0001111
+                * cbo_zero   0000000 00100 ..... 010 00000 0001111
+                *
+                * Anything that doesn't match these will default to 'lq'.
+                */
+               switch ((inst >> 17) & 0b11111) {
+               case 0: op = rv_op_cbo_inval; break;
+               case 1: op = rv_op_cbo_clean; break;
+               case 2: op = rv_op_cbo_flush; break;
+               case 4: op = rv_op_cbo_zero; break;
+               default: op = rv_op_lq; break;
+               }
             }
             break;
         case 4:
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cd23b1f3a9..564b745c48 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -199,9 +199,9 @@ ldu      ............   ..... 111 ..... 0000011 @i
 {
   [
     # *** RV32 Zicbom Standard Extension ***
+    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
     cbo_clean  0000000 00001 ..... 010 00000 0001111 @sfence_vm
     cbo_flush  0000000 00010 ..... 010 00000 0001111 @sfence_vm
-    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
 
     # *** RV32 Zicboz Standard Extension ***
     cbo_zero   0000000 00100 ..... 010 00000 0001111 @sfence_vm
-- 
2.47.3


