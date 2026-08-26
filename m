Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31894C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5wI-0005Zd-KD; Wed, 26 Aug 2026 01:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wG-0005U6-6T; Wed, 26 Aug 2026 01:12:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5wD-0005XQ-7Y; Wed, 26 Aug 2026 01:12:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vlem1702446; Wed, 26 Aug 2026 05:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=osbj4v24jDas9jXEU
 VqNeJ9W8KW7z8MlMJ5r6wvkqmE=; b=sX0ZQJbEP9TXwUJfwofr0/vRV/q6ITVXu
 l1sGYXXgsH0R1tDwMjqhzGATYRiGFFA+nQjF15HyK9/z9A7try7O2Mbqh2Cpfy5v
 Kk/PkIQE1gIiChp1LgoScLpESgcGr7JIsehpWqYOgerhwHYFjbtMgSOxouzdK/Ta
 wNSAL5P7fNBkBU3aeLuIhXKMYYXzNbRmZeh8jro5VHLo3nZKR4TgCTblB3mMkFWn
 To3w/3tzxmBsHZmNsdvYOQN666WC8Sh75xciyKN4EetAW7oy+ExVXMtPibvEzLQL
 wyAThMQcGcry6cvocAYmoN4ZT3H8CLC67vidj9giZAtUz4MEer9zg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emk63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BFoc029245;
 Wed, 26 Aug 2026 05:12:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q8e4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:12:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5CUbl35783032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:12:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C1120043;
 Wed, 26 Aug 2026 05:12:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64CC520040;
 Wed, 26 Aug 2026 05:12:25 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:12:25 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 28/37] target/ppc: Move byte-reverse instructions to
 decodetree
Date: Wed, 26 Aug 2026 10:38:54 +0530
Message-ID: <20260826050923.74756-29-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e75c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8
 a=FHjUtwKLEPW3gRv7zYcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX/Lq6dldVVvMH
 jO0TkTwh7hOfKMkM7Ajbz2WZOzsZD2518KEvpMjnaJSf1aqTLUPjHiLarBxrJRsNWcnN7b0xeig
 ltq4SgPcOSQYZTRZvjPN+kGCYShCghA=
X-Proofpoint-GUID: YWnUEtV8FdwyetUIBw-muFUMUa3FY4QQ
X-Proofpoint-ORIG-GUID: qK-Er1ktpECnX7VMFcs-RU6Owass_0rh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXwS56lXbOigO1
 DyFhoKNtEcNdJXCOB71WUAoEdmC/70hRiecy5kMJ8DqUh9H0OJQSz20QKZS4S5JyV3tTTq8IHre
 Iy0oKNez01ewEZGtZEw7QuMJ1aIsAJClycVBxs/lDqT8AWQ0i1FfK7PqIQgzkdR12JC9U6H/gaH
 yPV8DODJK7V/j9Wyd0v0CzqKIhV4COnBHVMWuDrO5UuL3s0RfOWWFGyHTiGdYp2rusuK4bIMjca
 uBjhHHw6oCCGMVy5+eO7FX5XsAfpV334rO96K1Q8oxzi76IjgiiqdgCLuC163NSYiquOyN+5Dti
 RyCv83/gFyqCJelNUsNSpHsrLz72kz8Ot7QlPSY5REln7MYtscuhJJohkyjXUWxb/pItRaJCdJQ
 1HIQBiYHk5nbGA2bqN7pgDf1XkzVS/xHRc2wKSpprM3ySIK201QXFURbmlXvS5Og0UpAySOFqGe
 B9l1mbtmw4Mvi4OVzsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Moving the following instructions to decodetree specification:
            brd, brw, brh                   : X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the
`-d in_asm,op` flag.

This also includes improvements from review feedback:
- Add TARGET_PPC64 guards with qemu_build_not_reached() for 32-bit builds

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  5 +++
 target/ppc/translate.c                     | 35 -------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 40 ++++++++++++++++++++++
 3 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f7ab08704f..7614655f72 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -320,6 +320,11 @@ MFMSR           011111 ..... ----- ----- 0001010011 -   @X_t
 MTMSR           011111 ..... ---- . ----- 0010010010 -  @X_rs_l
 MTMSRD          011111 ..... ---- . ----- 0010110010 -  @X_rs_l
 
+### Fixed-Point Byte-Reverse Instructions
+BRW             011111 ..... ..... ----- 0010011011 -   @X_sa
+BRD             011111 ..... ..... ----- 0010111011 -   @X_sa
+BRH             011111 ..... ..... ----- 0011011011 -   @X_sa
+
 ### Fixed-Point Load Instructions
 
 LBZ             100010 ..... ..... ................     @D
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9d29134fa1..8950476be7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4532,42 +4532,7 @@ static void gen_dform3D(DisasContext *ctx)
     return gen_invalid(ctx);
 }
 
-#if defined(TARGET_PPC64)
-/* brd */
-static void gen_brd(DisasContext *ctx)
-{
-    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-}
-
-/* brw */
-static void gen_brw(DisasContext *ctx)
-{
-    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
-    tcg_gen_rotli_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], 32);
-
-}
-
-/* brh */
-static void gen_brh(DisasContext *ctx)
-{
-    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
-    TCGv_i64 t1 = tcg_temp_new_i64();
-    TCGv_i64 t2 = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
-    tcg_gen_and_i64(t2, t1, mask);
-    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], mask);
-    tcg_gen_shli_i64(t1, t1, 8);
-    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
-}
-#endif
-
 static opcode_t opcodes[] = {
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
-GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
-GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
-#endif
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index a75279022c..cef67d6431 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -17,6 +17,46 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/*
+ * Byte-Reverse Instructions
+ */
+static bool do_byte_reverse_X_sa(DisasContext *ctx, arg_X_sa *a, int kind)
+{
+#if defined(TARGET_PPC64)
+    switch (kind) {
+    case 0: /* brd */
+        tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+        break;
+    case 1: /* brw */
+        tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+        tcg_gen_rotli_i64(cpu_gpr[a->ra], cpu_gpr[a->ra], 32);
+        break;
+    case 2: /* brh */
+    {
+        TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i64 t2 = tcg_temp_new_i64();
+
+        tcg_gen_shri_i64(t1, cpu_gpr[a->rs], 8);
+        tcg_gen_and_i64(t2, t1, mask);
+        tcg_gen_and_i64(t1, cpu_gpr[a->rs], mask);
+        tcg_gen_shli_i64(t1, t1, 8);
+        tcg_gen_or_i64(cpu_gpr[a->ra], t1, t2);
+        break;
+    }
+    default:
+        g_assert_not_reached();
+    }
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+TRANS64_FLAGS2(ISA310, BRD, do_byte_reverse_X_sa, 0)
+TRANS64_FLAGS2(ISA310, BRW, do_byte_reverse_X_sa, 1)
+TRANS64_FLAGS2(ISA310, BRH, do_byte_reverse_X_sa, 2)
+
 /*
  * Fixed-Point Load/Store Instructions
  */
-- 
2.55.0


