Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2CDD637AE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 21:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVcX9-0005OS-VF; Tue, 16 Dec 2025 16:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vVcX7-0005Ma-Vg
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:24:38 -0500
Received: from 11.mo550.mail-out.ovh.net ([188.165.48.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1vVcX5-00057s-FU
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:24:37 -0500
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.37.31])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4dW91B3dxDz6S5h
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 21:24:30 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-rtqmk (unknown [10.110.113.129])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 297E8C2986;
 Tue, 16 Dec 2025 21:24:29 +0000 (UTC)
Received: from petrot.fr ([37.59.142.110])
 by ghost-submission-7d8d68f679-rtqmk with ESMTPSA
 id TDJCAQ3OQWmCMBYAcfe/tA
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>);
 Tue, 16 Dec 2025 21:24:29 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00420054def-a0c6-4d02-bf6c-848c098131ab,
 447B3D2F0E3A97C97AEC376AC808067992D061BE) smtp.auth=frederic@petrot.fr
X-OVh-ClientIp: 79.90.201.35
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/1] trans_rvi.c.inc: Make lq and sq use 128-bit ld/st
Date: Tue, 16 Dec 2025 22:24:23 +0100
Message-ID: <20251216212423.2586121-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14847805024245847323
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEypbdQktD1E5Xcj31kCaeJC/ygmACJeulf1Yvf6tO9tKZwbi+i1QzTctcv4tHNavoPSoUFjUphM5i4hGY7+6HAaUpDadiKDYF0CaSwQ7vza9j0KLwdfFWtcHSwRzLDxkp/L3yDI7ICZl8FPx8d0smnbBd1WwuuS3WTgphRFrXHNalDeKtInLcbulCdAByIVsM/cIuIH7LcKCgWh+89Fr1XoN7/cB1LVUZkollnSS+uDom6+2rrlGqtxsDShKkXRERCVnKI2ToG7pk+/XSItUMMkHJZhbSjberJVVZ+09McLPX33LE1FLtsv6YzUA5xp2/P7mfjKzSCTuhOoNpzZk33MG4ExPZTUChenZvXE4LAfrIbpNsYyBXJHv+QTp9g2giqYuGc1QAn/A+uL8sfqahLXX+HwyOV0U6olSZOYCvhg4DRZvj4IHPEt7tUGelVBiGKVQf5Ma28J0oD7GcIhMSudTOTtbzCHhtzCXzNcVnv49nn4WAZZ6TPymyIoioKIpnLQgDaDpLCJhCnSnNowk7dv6IIl2J7/NNFS1wjMNBRnYzljit1zghoLT+F8N90QqpbgpJ44PWYD2ucpePjWER1YP3PU7n/fTIQ28WgmQBJVH3hTUIEb+1BxWYCek4adVW4/CWk6CG7i3y7kU8XBVWEYM6FYrNpx7FufJ1S2JGkZA
Received-SPF: softfail client-ip=188.165.48.29;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=11.mo550.mail-out.ovh.net
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
use direct (and erroneous) memory accesses.
Replace these direct accesses with the standard tcg_gen_qemu_{ld,st}_i128
TCG helpers that handle endianness issues.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..ea5a961464 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -388,10 +388,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
             tcg_gen_movi_tl(desth, 0);
         }
     } else {
-        /* assume little-endian memory access for now */
-        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
+        TCGv_i128 t16 = tcg_temp_new_i128();
+
+        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_extr_i128_i64(destl, desth, t16);
+        } else {
+            tcg_gen_extr_i128_i64(desth, destl, t16);
+        }
     }
 
     gen_set_gpr128(ctx, a->rd, destl, desth);
@@ -494,10 +498,14 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
     if ((memop & MO_SIZE) <= MO_64) {
         tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
     } else {
-        /* little-endian memory access assumed for now */
-        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
+        TCGv_i128 t16 = tcg_temp_new_i128();
+
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_concat_i64_i128(t16, src2l, src2h);
+        } else {
+            tcg_gen_concat_i64_i128(t16, src2h, src2l);
+        }
+        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
     return true;
 }
-- 
2.43.0


