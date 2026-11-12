Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4B606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=nuGbPPIQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRe2R-00077i-IS; Thu, 12 Nov 2026 18:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xRe2M-00076e-5Z
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 18:16:58 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xRe2K-0001Tv-71
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 18:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5S1OizVelwL+bqSVutpwpAknO5FjBS0yU0F8ElER32o=; b=nuGbPPIQFm3ULsi
 svnKXW6A37UJ48kya0sCRgodmdfbFQrDugf9t2r6CAEG6aun44ShSWk7c1KEywCqaGyzSnkijWArU
 QwpPyAN/uSz2AEyDNMCyKMpZpIt9Jkdbi8iJ+XZ7o6QWJA51o0Y/nWYUF6ztFfplPjincMDBm7f2a
 vI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 2/4] target/hexagon: HLX,
 search for .new values in pair high register
Date: Fri, 13 Nov 2026 00:20:30 +0100
Message-ID: <20261112232032.396-3-anjo@rev.ng>
In-Reply-To: <20261112232032.396-1-anjo@rev.ng>
References: <20261112232032.396-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Otherwise, the following packet

  {
      L7:6 = combine(L0, L2)
      mem(R7) = L7.new
  }

results in mem(R7) being zero-initialized, compared to L6.new which
would correctly write the lower bytes of the pair.

Compared to scalar and HVX .new instructions, HLX encodes the register
number rather than an offset to the producing instruction + an odd/even
bit.  In order to find possible producers which write to register pairs
without the odd/even bit, a Instruction::has_pair_dest field is added
for scalar, HVX, and HLX registers.

Lastly, we move the new-regno patching in decode_fill_newvalue_regno()
to the non-HLX scalar path to avoid overwriting the consumer L7 with the
base register L6 of the producer destination L7:6.  This is safe as the
patching is only required for replacing the scalar offset+odd/even
bit with the actual producer.

Fixes: ef81d1b047337e81 ("target/hexagon: decode HLX packets and add load and store")
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/insn.h               |  1 +
 target/hexagon/decode.c             | 29 +++++++++++++++++++-----
 tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
 target/hexagon/gen_trans_funcs.py   |  5 +++++
 target/hexagon/hex_common.py        |  2 ++
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 0dd36d2931..37a3111374 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -42,6 +42,7 @@ struct Instruction {
     int32_t new_read_idx;
     int32_t dest_idx;
     bool has_pred_dest;
+    bool has_pair_dest;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index d48630da87..08fa9aee2a 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -110,9 +110,25 @@ static int hlx_find_new_value_producer(Packet *packet, int consumer,
 {
     for (int i = 0; i < packet->num_insns; i++) {
         Insn *insn = &packet->insn[i];
+        uint8_t regno;
 
-        if (i != consumer && GET_ATTRIB(insn->opcode, A_HLX) &&
-            insn->dest_idx != -1 && insn->regno[insn->dest_idx] == lreg) {
+        /*
+         * Skip ourselves, instructions without return values, and
+         * any non-HLX instructions.
+         */
+        if (i == consumer || !GET_ATTRIB(insn->opcode, A_HLX) ||
+            insn->dest_idx == -1) {
+            continue;
+        }
+
+        regno = insn->regno[insn->dest_idx];
+
+        /*
+         * Compare against the base register number, and against the top
+         * register for instructions returning pairs.
+         */
+        if (regno == lreg ||
+            (insn->has_pair_dest && regno + 1 == lreg)) {
             return i;
         }
     }
@@ -172,12 +188,13 @@ decode_fill_newvalue_regno(Packet *packet)
                 if (def_idx < 0 || packet->insn[def_idx].dest_idx == -1) {
                     return false;
                 }
+
+                /* Now patch up the consumer with the register number */
+                dst_idx = packet->insn[def_idx].dest_idx;
+                packet->insn[i].regno[use_regidx] =
+                    packet->insn[def_idx].regno[dst_idx];
             }
 
-            /* Now patch up the consumer with the register number */
-            dst_idx = packet->insn[def_idx].dest_idx;
-            packet->insn[i].regno[use_regidx] =
-                packet->insn[def_idx].regno[dst_idx];
             /*
              * We need to remember who produces this value to later
              * check if it was dynamically cancelled
diff --git a/tests/tcg/hexagon/hlx_assign_conv.c b/tests/tcg/hexagon/hlx_assign_conv.c
index 8192882b8e..bca902a6e5 100644
--- a/tests/tcg/hexagon/hlx_assign_conv.c
+++ b/tests/tcg/hexagon/hlx_assign_conv.c
@@ -120,6 +120,40 @@ static void test_assign_rw(void)
     check_wp("LX_assign_rw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
 }
 
+static void test_combine_assign_hi(void)
+{
+    /*
+     * Tests that a combine operation acts as a producer of a .new value for
+     * the high vector in a pair.
+     */
+    HLX_Vector l_lo;
+    HLX_Vector l_hi;
+
+    fill_w(pw_a_lo, pw_a_hi, VAL_W);
+
+    l_lo = Q6_L_tmp_mem_A(pw_a_lo);
+    l_hi = Q6_L_tmp_mem_A(pw_a_hi);
+
+    hlx_put_v(0, l_lo);
+    hlx_put_v(2, l_hi);
+    /*
+     * {
+     *     L7:6 = combine(L0, L2)
+     *     mem(R7) = L7.new
+     * }
+     */
+    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
+                 ".word 0xef24602d\n"
+                 ".word 0xa487c007\n"
+                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
+    Q6_mem_Ku16_new_AL(buf_a, hlx_get_v(7));
+
+    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
+        expected[j] = VAL_B;
+    }
+    check_h("LX_assign_w (hi only)", buf_a, expected, HLX_HALF_ELEMS);
+}
+
 
 static void test_combine_w(void)
 {
@@ -336,6 +370,7 @@ int main(void)
     test_assign_s();
     test_assign_u();
     test_assign_rw();
+    test_combine_assign_hi();
 
     /* Combine and mux */
     test_combine_w();
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 93125bdfe4..7e65438565 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -74,6 +74,7 @@ def mark_which_imm_extended(f, tag):
 ##         insn->new_read_idx = -1;
 ##         insn->dest_idx = 0;
 ##         insn->has_pred_dest = false;
+##         insn->has_pair_dest = false;
 ##         return true;
 ##     }
 ##
@@ -94,6 +95,7 @@ def gen_trans_funcs(f):
         dest_idx = -1
         dest_idx_reg_id = None
         has_pred_dest = "false"
+        has_pair_dest = "false"
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
             f.write(code_fmt(f"""\
@@ -108,6 +110,8 @@ def gen_trans_funcs(f):
                     dest_idx_reg_id = reg_id
             if reg_type == "P" and reg.is_written() and not reg.is_read():
                 has_pred_dest = "true"
+            if reg.is_written() and reg.is_pair():
+                has_pair_dest = "true"
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -132,6 +136,7 @@ def gen_trans_funcs(f):
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
             insn->has_pred_dest = {has_pred_dest};
+            insn->has_pair_dest = {has_pair_dest};
         """))
         f.write(textwrap.dedent(f"""\
                 return true;
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index f85f063f52..8d68d8dad9 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -805,6 +805,8 @@ def is_hvx_reg(self):
         return True
     def is_hlx_reg(self):
         return False
+    def is_pair(self):
+        return len(self.regid) == 2
     def hvx_off(self):
         return f"{self.reg_tcg()}_off"
     def hvx_base(self):
-- 
2.52.0


