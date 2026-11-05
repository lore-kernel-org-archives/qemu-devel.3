Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CA606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=kfqC6BDj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvqJ-0002Lo-Tw; Thu, 05 Nov 2026 06:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqD-0002Js-CG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:13 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqB-0005Hx-8U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=JUb/pXiQVev4JAys45i1iRg1UIcTa9J9UmXGod6AghI=; b=kfqC6BDj9mW2i1N
 f1QHuf91r4IWn2HgOy2cVghj8VKeJbiH518hoMPseA6TEJ133LkgkJ94wrAF5sb94E3JfRrzG3H3S
 hn0OMxCekHaWQz0a1E8sLu9KdwVQLqckAKxM1DF7FlrlXggmQxX0JNPP5/Bomrb/Cwy9H9qkgoO1e
 EI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 2/4] target/hexagon: HLX,
 search for .new values in pair high register
Date: Thu,  5 Nov 2026 12:46:31 +0100
Message-ID: <20261105114633.597-3-anjo@rev.ng>
In-Reply-To: <20261105114633.597-1-anjo@rev.ng>
References: <20261105114633.597-1-anjo@rev.ng>
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
      L7:6 = combine(L0, L1)
      memw(R7) = L7.new
  }

results in memw(R7) being zero-intialized, compared to L6.new which
would correctly write the lower bytes of the pair.

Fixes: ef81d1b047337e81 ("target/hexagon: decode HLX packets and add load and store")
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/decode.c             | 20 +++++++++++++++--
 tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index d48630da87..8921ff765d 100644
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
+            (GET_ATTRIB(insn->opcode, A_HLX_PAIRED_ALU) && regno + 1 == lreg)) {
             return i;
         }
     }
diff --git a/tests/tcg/hexagon/hlx_assign_conv.c b/tests/tcg/hexagon/hlx_assign_conv.c
index 8192882b8e..aef82dd63b 100644
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
+     *     L7:6 = combine(L0, L1)
+     *     memw(R7) = L7.new
+     * }
+     */
+    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
+                 ".word 0xef24602d\n"
+                 ".word 0xa487c007\n"
+                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
+    Q6_mem_Ku16_new_AL(buf_a, hlx_get_v(7));
+
+    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
+        expected[j] = VAL_A;
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
-- 
2.52.0


