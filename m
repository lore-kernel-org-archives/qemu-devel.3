Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1EDC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5uA-0005zg-T6; Wed, 26 Aug 2026 01:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uA-0005w3-0W; Wed, 26 Aug 2026 01:10:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5u8-0005Ad-5m; Wed, 26 Aug 2026 01:10:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VjA31702347; Wed, 26 Aug 2026 05:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iSxCRarAZujScXfdS
 dC26J4IAUAJxWPkOkEZR4ehaUY=; b=JnCXnH4Ry6WAtSpJNzVZtbM8zjeATHTKx
 7CM5v+B+2hUC2kKH74GtEOxcC76rFXFHsnuWxzLNqinJdBDo7LuZQQOKhrAx9gYg
 19K3oNytq6sZvGpNvaciYOCOhcNCSJFqPGGJ1hzNcqK1Ybmgkg7YoubWhufG2QfN
 yBB/jpekuolTdiA2WNofkPgRy2K6hRiKrJF3zHpw2mXt8rZlnWGnAHcpymvXK+Yw
 OUeyaUKnEn+v18vruenNLWcaocz3B6Bx5cER65Vx47qJlAgb+xTEypwpwcd0xftY
 5pPz3n+pg1HMTjYoW8yQdZ8mbohZ0JJtMyjhSsXUljiGIhR4kVoJw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726emjw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:10:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4fG4G020015;
 Wed, 26 Aug 2026 05:10:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k070p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:10:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5ALrc26477268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:10:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 804EB2004B;
 Wed, 26 Aug 2026 05:10:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D7AC20040;
 Wed, 26 Aug 2026 05:10:16 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:10:15 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 07/37] target/ppc: convert slw,
 srw instruction via decode spec
Date: Wed, 26 Aug 2026 10:38:33 +0530
Message-ID: <20260826050923.74756-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8e7542 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Fp1rp7siH0uluUpQqjEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXyUdJKcvulAW+
 y0sx5qP1ahCQU46jnoR001+8aOHMfFP+m7GdtrALSdw35Kka0ldDtorGQ/z1ul+ESMRGvuU24zl
 R+ZGIFw0XQqiI8dKqmjNU0qGciljYE8=
X-Proofpoint-GUID: ak1EPs1oSPu48tLoDHMwePJuf7zDuzKH
X-Proofpoint-ORIG-GUID: oOT8AskVlE785SduKgFu3v7wjyMnuiGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX7MH3S8lH28Eu
 OxcnyIsVujCO+1PKBOGJ0WzhrhxAodq1GaybBRwKp3h2WLsKYDjDwVfu84YFG1dvCOF6fdNFhk9
 lpUyyo+fn/7jNcUXrFpdX8ZLzL+MaWlrtU5jYTtX4ipstdaKxMj/nP7bf9g5I3Cb+PoXeR/FYR3
 E4enbVvsjvlEzaI7WbGEQ02RPvXHemK/J+mjU/d2qVpv9Ip0EKZpYdwgMUdg5J8KLQbIvljb/3C
 gnNDLEPv2Xd1Jst5VFZwtg9ONPWymGQbnNWYLUb5S8KQ4RfUgvDmXi3VIhJ1MXHaxKeooqkfJ30
 SIoSE3kx+YLkXhpcnD3xCj82nOldUUozGBhIc74waNlr7xxCpZEh6j6cjnPLQ4B1DftP6lUeZK5
 0Idoy0O9m2US4TZk0VCTNgjXrhF7ZF6n9OqjP0//oavcheDmi4GjKrUPR5MkarKPbBjATqEtgD8
 tsHJxZvxurHWYCDHGSg==
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

From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>

Instructions converted:

- slw
- srw

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  6 +++
 target/ppc/translate.c                     | 49 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 48 +++++++++++++++++++++
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 701c66b347..66d2f455a9 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -505,6 +505,12 @@ HASHCHK         011111 ..... ..... ..... 1011110010 .   @X_DW
 HASHSTP         011111 ..... ..... ..... 1010010010 .   @X_DW
 HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
 
+# Fixed-Point Shift Instructions
+
+SLW		011111 ..... ..... ..... 0000011000 .	@X_rc
+SRW		011111 ..... ..... ..... 1000011000 .	@X_rc
+
+
 ## BCD Assist
 
 ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ee14fbfd96..f2b7505634 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2315,29 +2315,6 @@ GEN_PPC64_R4(rldimi, 0x1E, 0x06);
 
 /***                             Integer shift                             ***/
 
-/* slw & slw. */
-static void gen_slw(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
-    tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    tcg_gen_ext32u_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
 
 /* sraw & sraw. */
 static void gen_sraw(DisasContext *ctx)
@@ -2379,30 +2356,6 @@ static void gen_srawi(DisasContext *ctx)
     }
 }
 
-/* srw & srw. */
-static void gen_srw(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    tcg_gen_ext32u_tl(t0, t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
-    tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
 #if defined(TARGET_PPC64)
 /* sld & sld. */
 static void gen_sld(DisasContext *ctx)
@@ -5777,10 +5730,8 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(slw, 0x1F, 0x18, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(sraw, 0x1F, 0x18, 0x18, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(srawi, 0x1F, 0x18, 0x19, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(srw, 0x1F, 0x18, 0x10, 0x00000000, PPC_INTEGER),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
 GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 91f9c6c391..9d04b96316 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1406,3 +1406,51 @@ TRANS(HASHST, do_hash, false, gen_helper_HASHST)
 TRANS(HASHCHK, do_hash, false, gen_helper_HASHCHK)
 TRANS(HASHSTP, do_hash, true, gen_helper_HASHSTP)
 TRANS(HASHCHKP, do_hash, true, gen_helper_HASHCHKP)
+
+static bool trans_SLW(DisasContext *ctx, arg_SLW *a)
+{
+    TCGv t0, t1;
+
+    t0 = tcg_temp_new();
+    /* AND rt with a mask that is 0 when rB >= 0x20 */
+#if defined(TARGET_PPC64)
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
+    tcg_gen_sari_tl(t0, t0, 0x3f);
+#else
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
+    tcg_gen_sari_tl(t0, t0, 0x1f);
+#endif
+    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
+    t1 = tcg_temp_new();
+    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
+    tcg_gen_shl_tl(cpu_gpr[a->ra], t0, t1);
+    tcg_gen_ext32u_tl(cpu_gpr[a->ra], cpu_gpr[a->ra]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+static bool trans_SRW(DisasContext *ctx, arg_SRW *a)
+{
+    TCGv t0, t1;
+
+    t0 = tcg_temp_new();
+    /* AND rt with a mask that is 0 when rB >= 0x20 */
+#if defined(TARGET_PPC64)
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
+    tcg_gen_sari_tl(t0, t0, 0x3f);
+#else
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
+    tcg_gen_sari_tl(t0, t0, 0x1f);
+#endif
+    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
+    tcg_gen_ext32u_tl(t0, t0);
+    t1 = tcg_temp_new();
+    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
+    tcg_gen_shr_tl(cpu_gpr[a->ra], t0, t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
-- 
2.55.0


