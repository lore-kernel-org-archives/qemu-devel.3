Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECF606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=FMQYlPC6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvqJ-0002LA-7U; Thu, 05 Nov 2026 06:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqC-0002JZ-3d
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:12 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqA-0005Hr-M5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IX2s5FOKwLuntAmNIkgPK9S3/yywQuzdbBqMAIeuOHc=; b=FMQYlPC60EFErCa
 k736Pg2EZbkyYfc6vNGK9MEUabJxa1BcPujioKsoUWMzx4hcyYPyWrcSRDZ/9uISraxlsBbiN45CB
 idSZb4RObvegajgNuC4F3prlkljdaKEb1Dh5bxSfwee23E5569VM9FnIso7LpTa+kpgsbJSMreZ/L
 oY=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 1/4] target/hexagon: HLX,
 preserve scalar :mem_noshuf ordering
Date: Thu,  5 Nov 2026 12:46:30 +0100
Message-ID: <20261105114633.597-2-anjo@rev.ng>
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

A packet containing HLX instructions currently defers all stores to the
end of the packet, this breaks scalar :mem_noshuf ordering.  Only
reorder HLX stores.

Fixes: a6fae6da070d66b9 ("target/hexagon: translate packets with HLX instructions")
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/translate.c  |  7 ++++---
 tests/tcg/hexagon/hlx_mem.c | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8ab28d40d3..f9d4c3fb66 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1525,8 +1525,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
             for (int pass = 0; pass < 3; pass++) {
                 for (i = 0; i < ctx->pkt.num_insns; i++) {
                     Insn *insn = &ctx->pkt.insn[i];
+                    bool hlx = GET_ATTRIB(insn->opcode, A_HLX);
                     bool tmp = GET_ATTRIB(insn->opcode, A_HLX_TMP);
-                    bool store = !tmp && GET_ATTRIB(insn->opcode, A_STORE);
+                    bool store = !tmp && hlx &&
+                                 GET_ATTRIB(insn->opcode, A_STORE);
                     if (pass != (tmp ? 0 : store ? 2 : 1)) {
                         continue;
                     }
@@ -1534,8 +1536,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
                     if (insn->hlx_new_zero) {
                         gen_hlx_new_zero(insn);
                     }
-                    if (GET_ATTRIB(insn->opcode, A_HLX) &&
-                        trace_event_get_state_backends(
+                    if (hlx && trace_event_get_state_backends(
                             TRACE_HEXAGON_HLX_OP)) {
                         gen_helper_hlx_trace_op(tcg_env,
                             tcg_constant_i32(insn->opcode));
diff --git a/tests/tcg/hexagon/hlx_mem.c b/tests/tcg/hexagon/hlx_mem.c
index 643b499fd9..f5af95115a 100644
--- a/tests/tcg/hexagon/hlx_mem.c
+++ b/tests/tcg/hexagon/hlx_mem.c
@@ -229,6 +229,25 @@ static void test_store_fault(void)
     check_h("LX_S16b_new (fault)", buf_out, expected, HLX_HALF_ELEMS);
 }
 
+static void test_preserve_scalar_noshuf(void)
+{
+    uint32_t ret = 0;
+    uint32_t ptr = 0;
+    uint32_t val = 0x1234;
+    asm volatile("{\n"
+                 ".word 0xe5007822\n"
+                 "    memw(%1) = %2\n"
+                 "    %0 = memw(%1)\n"
+                 "}:mem_noshuf\n"
+                 : "=r"(ret)
+                 : "r"(&ptr), "r"(val)
+                 : "memory");
+    if (ret != val) {
+        printf("FAIL broken scalar :mem_noshuf ordering\n");
+        err++;
+    }
+}
+
 int main(void)
 {
     init_vtcm();
@@ -253,6 +272,9 @@ int main(void)
     /* Store in a faulting packet */
     test_store_fault();
 
+    /* Make sure HLX packets preserve scalar :mem_noshuf ordering */
+    test_preserve_scalar_noshuf();
+
     puts(err ? "FAIL" : "PASS");
     return err;
 }
-- 
2.52.0


