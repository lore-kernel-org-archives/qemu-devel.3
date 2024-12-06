Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC2E7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOxg-0008Ur-8d; Thu, 05 Dec 2024 22:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJOxe-0008Ud-Ie; Thu, 05 Dec 2024 22:24:58 -0500
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJOxZ-00076l-6i; Thu, 05 Dec 2024 22:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1733455484; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=2SR9Ue5Pf6dwQz5HcLwzsaxqBr/N+/ZDl4C1/BXWZS0=;
 b=Hh9zrWz/esx6jm3tC5YO8TQgQLadLT5+P0hHVQlD5eejQrFYXsTNeNzvrtglAXcrxyvV6dNDT4AOEz+xIfJwslcqGoltwxKzBy3X7tEX45EZ4bwhxK7dL3O1i/W6mDpjhGepaxsqOm3tNdAe1vlwSocdD0YczD3hn1+G1na6K9A=
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WKv.iKe_1733455480 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 06 Dec 2024 11:24:41 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 richard.henderson@linaro.org, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 1/1] disas/riscv: Guard dec->cfg dereference for host
 disassemble
Date: Fri,  6 Dec 2024 11:24:11 +0800
Message-Id: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For riscv host, it will set dec->cfg to zero. Thus we shuld guard
the dec->cfg deference for riscv host disassemble.

And in general, we should only use dec->cfg for target in three cases:

1) For not incompatible encodings, such as zcmp/zcmt/zfinx.
2) For maybe-ops encodings, they are better to be disassembled to
   the "real" extensions, such as zicfiss. The guard of dec->zimop
   and dec->zcmop is for comment and avoid check for every extension
   that encoded in maybe-ops area.
3) For custom encodings, we have to use dec->cfg to disassemble
   custom encodings using the same encoding area.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9c1e332dde..4075ed6bfe 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2611,7 +2611,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            if (dec->cfg->ext_zcmop) {
+            if (dec->cfg && dec->cfg->ext_zcmop) {
                 if ((((inst >> 2) & 0b111111) == 0b100000) &&
                     (((inst >> 11) & 0b11) == 0b0)) {
                     unsigned int cmop_code = 0;
@@ -2712,7 +2712,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 op = rv_op_c_sqsp;
             } else {
                 op = rv_op_c_fsdsp;
-                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
+                if (dec->cfg && dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
                     switch ((inst >> 8) & 0b01111) {
                     case 8:
                         if (((inst >> 4) & 0b01111) >= 4) {
@@ -2738,7 +2738,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 } else {
                     switch ((inst >> 10) & 0b011) {
                     case 0:
-                        if (!dec->cfg->ext_zcmt) {
+                        if (dec->cfg && !dec->cfg->ext_zcmt) {
                             break;
                         }
                         if (((inst >> 2) & 0xFF) >= 32) {
@@ -2748,7 +2748,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         }
                         break;
                     case 3:
-                        if (!dec->cfg->ext_zcmp) {
+                        if (dec->cfg && !dec->cfg->ext_zcmp) {
                             break;
                         }
                         switch ((inst >> 5) & 0b011) {
@@ -2956,7 +2956,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 5:
             op = rv_op_auipc;
-            if (dec->cfg->ext_zicfilp &&
+            if (dec->cfg && dec->cfg->ext_zicfilp &&
                 (((inst >> 7) & 0b11111) == 0b00000)) {
                 op = rv_op_lpad;
             }
@@ -4058,7 +4058,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
             case 4:
-                if (dec->cfg->ext_zimop) {
+                if (dec->cfg && dec->cfg->ext_zimop) {
                     int imm_mop5, imm_mop3, reg_num;
                     if ((extract32(inst, 22, 10) & 0b1011001111)
                         == 0b1000000111) {
@@ -5112,28 +5112,28 @@ static GString *format_inst(size_t tab, rv_decode *dec)
             g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
             break;
         case '3':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rd]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rd]);
             }
             break;
         case '4':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs1]);
             }
             break;
         case '5':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs2]);
             }
             break;
         case '6':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs3]);
@@ -5439,7 +5439,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         const rv_opcode_data *opcode_data = decoders[i].opcode_data;
         void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
 
-        if (guard_func(cfg)) {
+        /* always_true_p don't dereference cfg */
+        if (((i == 0) || cfg) && guard_func(cfg)) {
             dec.opcode_data = opcode_data;
             decode_func(&dec, isa);
             if (dec.op != rv_op_illegal)
-- 
2.25.1


