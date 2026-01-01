Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63C3EED626
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 18:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbNEi-0001pZ-HA; Thu, 01 Jan 2026 13:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbNCz-0001GL-B3
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:37 -0500
Received: from 14.mo583.mail-out.ovh.net ([188.165.51.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vbNCh-0006ay-14
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 13:15:32 -0500
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.37.251])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4dhw3S0YtSz6TmJ
 for <qemu-devel@nongnu.org>; Thu,  1 Jan 2026 18:15:15 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-kbmwb (unknown [10.110.164.150])
 by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 42C57C02A2;
 Thu,  1 Jan 2026 18:15:15 +0000 (UTC)
Received: from petrot.fr ([37.59.142.99])
 by ghost-submission-7d8d68f679-kbmwb with ESMTPSA
 id QUyEM6q5Vmlo/w0A7Yva2g:T2
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>);
 Thu, 01 Jan 2026 18:15:15 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00396cbf9ef-74af-4aa7-989c-49a740ff6e7a,
 8D8ADDDE20E1118D614694FD1C3138A4D0B19743) smtp.auth=frederic@petrot.fr
X-OVh-ClientIp: 79.90.201.35
To: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/2] trans_rvi.c.inc: Make lq and sq use 128-bit ld/st
Date: Thu,  1 Jan 2026 19:14:41 +0100
Message-ID: <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
References: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13381038920107758875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGnNtrAJs39FpE0Twq4JNjjdBsKLWoaqa4J+CX+hvG+0w/PRsXo64kOrscY1GxzcqPZ3BqLsu1oY/rUrvUbO9OccY+eDD/OUPn7GxlYS+S3uoG5zOT9glgA8O3Fl86WvgG+VfOdPGV8A0bPCJ/64361RaDZqOcwWJpOpt5QYJhTK7PHbLc3+TvuuqV+sTe/YlXCOrdMRIEADKplZegvkvO+kcsrZ0PgRM/ysAmatkz1x87U1jpzlllGwMja6glIWFtEjLHM1FMRV0rmXRk7zdkRsSpxZwakpISXenwl3g9ui2OiHDfJiNgWXca/qR5co1O9HiwcV8iiRnvl9HOirkwtkky0UcxLkh1HF3mulok+dK3fcOLDAOIEU2NqlB9QbEscTpJn+GL2ctLeUM6RpV8zmi94+5YWW35LGxx3izBplobrqXdPw5PdCvKIX8x6uBlyIX0XRaPF+7ee+L3okrCMW6Gw/+fWdZv0C4t0zjnhntF9Ygnuoy/rmRKt64JwgmsyZrySd/jlKgnXzJUrfXMgdgU3y8ZD7izF8bd/YS/ka1mqLunuixO/kq0VDc33d9Zmmc3P943ksupXsKXRFRpH5dRB3L7dHqja6LAwTzN/UwLI4NQyxZz1KAaKlBD7NfkEKCepsoP3FdB7tRjDdgC1ceG7jUCmHFgNACBZwf/ZRw
Received-SPF: softfail client-ip=188.165.51.82;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=14.mo583.mail-out.ovh.net
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Reply-to:  =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
From: frederic.petrot--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The lq and sq helpers for the experimental rv128 architecture currently
use direct memory accesses.
Replace these direct accesses with the standard tcg_gen_qemu_{ld,st}_i128
TCG helpers that handle endianness issues.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..2c82ae41a7 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -377,6 +377,9 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
     TCGv destl = dest_gpr(ctx, a->rd);
     TCGv desth = dest_gprh(ctx, a->rd);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
@@ -388,10 +391,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
             tcg_gen_movi_tl(desth, 0);
         }
     } else {
-        /* assume little-endian memory access for now */
-        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_extr_i128_i64(tl, th, t16);
+        } else {
+            tcg_gen_extr_i128_i64(th, tl, t16);
+        }
+        tcg_gen_trunc_i64_tl(destl, tl);
+        tcg_gen_trunc_i64_tl(desth, th);
     }
 
     gen_set_gpr128(ctx, a->rd, destl, desth);
@@ -488,16 +495,25 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv src2h = get_gprh(ctx, a->rs2);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
     if ((memop & MO_SIZE) <= MO_64) {
         tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
     } else {
-        /* little-endian memory access assumed for now */
-        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
+
+        tcg_gen_ext_tl_i64(tl, src2l);
+        tcg_gen_ext_tl_i64(th, src2h);
+
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_concat_i64_i128(t16, tl, th);
+        } else {
+            tcg_gen_concat_i64_i128(t16, th, tl);
+        }
+        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
     return true;
 }
-- 
2.43.0


