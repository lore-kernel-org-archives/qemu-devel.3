Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926ECC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpkz-0005ie-8j; Fri, 28 Aug 2026 02:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkx-0005gO-FZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkv-0000ro-Ep
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S230Ph679537
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UUbMOZ7MRiAulERyw
 ObL8UdDAT4Hu2mpjdCMVTJMDF8=; b=hwBnSztRVInkc3+zJizN9Lnd2oa2dsdUG
 bEyw+7C4u5uupbrdqcF9QRyPbrooTn/pJ1i9CeyovMCmjOXKU8uauydMaL5m+ve5
 31BP3sr8BnAExemh1OirDQBZK7MXQ0IrDpdwg+NVaHuD8Wpa2EuNrt7yjZ99zdC1
 htaIH60xFJ5dwNfDk1CRLs+RtZe9xGbdatGROh+7CcstbDY6AwElA099pOa0UbGm
 kc5nyobGVwwDELvUPVRrfgy6vyIoKPCvy6zQhGb5U8UfC7dl5IwLHuY0PFf3lWdi
 CtXanlLJS2LLl+9pu99+4NDSbt+NApVdRP4Wpd/ux/7KprIngSKdQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:07:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uHFU003648;
 Fri, 28 Aug 2026 06:07:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmjy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:07:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67soN50331920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB02620043;
 Fri, 28 Aug 2026 06:07:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF6BE20040;
 Fri, 28 Aug 2026 06:07:52 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 11/41] target/ppc: convert slw, srw instruction via decode spec
Date: Fri, 28 Aug 2026 11:36:46 +0530
Message-ID: <20260828060716.91672-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX5g+psMpB/5P2
 1+3i1yqgEJYk0nVfQYqPn5Tm+zVXur1VgqCbcu+4buQmZ1K/H6K871oThBnGg5gunwGTvEeGSZr
 6yVPI9jDuftNPrvTeoFd1GjgIf2Oih8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9125bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=xO4CFU3ef3RllDxvDoMA:9
X-Proofpoint-ORIG-GUID: d_EwjYifPMqpcuN3Z3oxDktGJ7ggBWwz
X-Proofpoint-GUID: 0OiShLVE4ezlCiM9vZ_8P-KZli7bR-mq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX77XgVqNGYT4O
 TfDugACbWhohbgFTYwyh6R/xhu6OtiTRIrr+7aqKsO/8SL0J6I/e3KY76f9kVo0S7wPSq0j8Eua
 JaBBTw1ZU7JaphTLn0cah41emAwtxwVvYzX4yzobpiC9UbjeWsThV4hzXYeZNkA7gGEwsYeCFmU
 xXaH4k0ZFQwR9Om8N7CCKx6nIyRfU1kOj6u3USNT3NiAj9mPSPAIjX3NWXeHg4j9nTOikGD3+y+
 OsQQnAdLUedwa6ME3z+IqH/Q95dAGHsfjEkyR1SACM8JEvSj6aPykG2SzibnjC2EN1d5jgqcTly
 PSs6UQ2rwhOsFoXlO39UcjbFez0YAxHE4FwlNbBJSgScPh+p2D6H4smZRopMad0lycbjuWZSF+H
 qAI+vjZLD+7t2wssr9LbTEKgMvswUgqGdeKZf6JHCHyZbMgoQzIMQh/bJz5xuVrqb2nuq866JE9
 XyhBAY87HlhQBJuSYkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Move slw and srw to decodetree specification using the @X_rc
format. The existing shift-masking logic from gen_slw/gen_srw is
preserved verbatim in the new trans_SLW/trans_SRW handlers.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-8-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  5 +++
 target/ppc/translate.c                     | 49 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 48 +++++++++++++++++++++
 3 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 824181eb4e..189f9c6fe7 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -505,6 +505,11 @@ HASHCHK         011111 ..... ..... ..... 1011110010 .   @X_DW
 HASHSTP         011111 ..... ..... ..... 1010010010 .   @X_DW
 HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
 
+# Fixed-Point Shift Instructions
+
+SLW             011111 ..... ..... ..... 0000011000 .   @X_rc
+SRW             011111 ..... ..... ..... 1000011000 .   @X_rc
+
 ## BCD Assist
 
 ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 821363e7fb..3d26e1144e 100644
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
@@ -5764,10 +5717,8 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
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
2.52.0


