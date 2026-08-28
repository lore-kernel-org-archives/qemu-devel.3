Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA4DC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplt-0008Cy-Gb; Fri, 28 Aug 2026 02:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplr-0008A5-LB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplp-00010v-KQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S225bL596414
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hpVkAcbw3nerWUnRU
 NrZCmO8cYwxH8keK7e6aoP+YO4=; b=dTwLbsmYz2Fqut1Joiw2M26df9zMv48UA
 dmx93gAN1dd5tcqs1poJNw6q+kc8R2O9YRAmPtYOA1Sbh1fj/DsJVrcLxK7Ikjrx
 Zf1Q7qnQQQ37FhSuLcRoHNsKQIchsVO2vR1paDalYliVbxYRScaBMusy/Yy0k20i
 MmaQntihTDhjIVRS+5nelGj/d83uzxFThacjinte8vAy8FG62SpuHQZuQaLmoUnN
 b16cjSt6Nr9v9MjF2VhT2z1RyhdcfOHMMge+E6J1PGNOwx+A7m/7WiarW6C/+Tmm
 ITR+Ov38lXYp/kdfqTMHA1HbBSsGRXWl1bu8HpKSTpslZ3elgxztA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uUe7025941
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwmq67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68oPt36569528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 917D220043;
 Fri, 28 Aug 2026 06:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F26E20040;
 Fri, 28 Aug 2026 06:08:48 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 32/41] target/ppc: Move byte-reverse instructions to decodetree
Date: Fri, 28 Aug 2026 11:37:07 +0530
Message-ID: <20260828060716.91672-33-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h2mVzFJb8wMqcFHsW9LToXLtNGwmQ2P9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX1Z0Yqxrlx5Fy
 PBUnrgESoV875t+27TIpQze829QxjQhSvQzTxx75yMVLr4B9CCj4d/zct/Sryy+KOKhVELSzOtq
 N7ivOh++5EKqpiue+PD9DodMFz8bgv1YEuzQjaOi+IxIXbgcTYIA3Wbr4PFI2uPKs8Cz5H3vzGM
 BYWD9H8By0WxWtMOaVC7w1eNvSYbPfNDHjWo85uxO3NyHSYJjnfKLR7cSki9LVlmlrBnkWstP5Z
 n6//OZSTsMy+QWT1nxqXm8vh6koJj0bgihPCFrlHdImXbxuL9rfjncriYLj4c712G7qyywG8X+k
 U8hIvL4Xbu9qyApI0a0zuItBHjVb/pg++txCJrAAmb6o1M3xi/gGMwd0XtFdcAr29Oois0R924D
 oa26PKa8Fg0Fa6zhO5tOAvWv+qfRYW1K36V+sqSguxS59yF+79z6k8lXzH5YnnnuwBUjVxavyN7
 8JvWE+5yGPm7vFa0igg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=mDV3o1hIAAAA:8 a=ib4F3-l9mLf_7KlTbjIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX68Ms1zoaRgkL
 45amZm6lgK64sy2bhcHsWDO19nvfuKMhoC8nJRtDNN585HU467GLHZWtvSRsPIZuNng8P8FIgtL
 M6/D7ZtNFrWJpp7zrKzfkaUg5Iyun6Y=
X-Proofpoint-ORIG-GUID: h2mVzFJb8wMqcFHsW9LToXLtNGwmQ2P9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-29-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  5 +++
 target/ppc/translate.c                     | 35 ----------------
 target/ppc/translate/fixedpoint-impl.c.inc | 48 ++++++++++++++++++++++
 3 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 1e263449a5..7bbe1f8838 100644
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
index 1d069c5250..20d3e7c1ab 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4519,42 +4519,7 @@ static void gen_dform3D(DisasContext *ctx)
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
index 8475205f14..0e1960a272 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -17,6 +17,54 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/*
+ * Byte-Reverse Instructions
+ */
+static bool trans_BRD(DisasContext *ctx, arg_BRD *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
+#if defined(TARGET_PPC64)
+    tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_BRW(DisasContext *ctx, arg_BRW *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
+#if defined(TARGET_PPC64)
+    tcg_gen_bswap64_i64(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+    tcg_gen_rotli_i64(cpu_gpr[a->ra], cpu_gpr[a->ra], 32);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_BRH(DisasContext *ctx, arg_BRH *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA310);
+#if defined(TARGET_PPC64)
+    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(t1, cpu_gpr[a->rs], 8);
+    tcg_gen_and_i64(t2, t1, mask);
+    tcg_gen_and_i64(t1, cpu_gpr[a->rs], mask);
+    tcg_gen_shli_i64(t1, t1, 8);
+    tcg_gen_or_i64(cpu_gpr[a->ra], t1, t2);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 /*
  * Fixed-Point Load/Store Instructions
  */
-- 
2.52.0


