Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11EFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN99-0007FV-5w; Wed, 07 Oct 2026 04:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEI53-0001HN-5l; Tue, 06 Oct 2026 23:12:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xEI4o-0000kN-5b; Tue, 06 Oct 2026 23:12:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A5ufd2199189; Tue, 6 Oct 2026 10:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ePARvRh9BwVwBuVww
 rYO5ihk2fLbwZAVIHosO3ZqR1E=; b=Ejxw1uMTrbR5wSDyfye83FtH4MtKFl8qz
 ANOOSJVxT6j/bowJC3+qq+8oLW7bHAqxImCy8SL9/u/MhPZK3rW9XcokBzo3yGtT
 wmpRgVlzqw3zyfvbGlKBjScltIngmFhmWRu/EyJvRtJ8QzDUQMuBT+ulBrVUZZJQ
 PVbGhn2thXt41u2QYjSyWtUQ7LiljnbYqWiOAsqGteSpg8t77Ai2nuuDffKx3svC
 ovinmBixELbhEZhpxmec78l06rUeZjMZD5ms6KnvaQHmujJHCKdXMGZQI+DkQevU
 ZUMGr0vGwdRd4HmQtR+gJfDA2pBnMnO+PS0bB8rF+MQyd3tfZnsMw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fxrvm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696A6IkW3066172; Tue, 6 Oct 2026 10:57:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g9d52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 10:57:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696AvSV129557324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 10:57:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0027E2004D;
 Tue,  6 Oct 2026 10:57:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A78572004B;
 Tue,  6 Oct 2026 10:57:25 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.87.135.85]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 10:57:25 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, uverma@linux.ibm.com,
 milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 8/8] target/ppc: Add DMF Outer-Product accumulate to ACC
 insns
Date: Tue,  6 Oct 2026 16:26:19 +0530
Message-ID: <20261006105650.189752-9-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006105650.189752-1-rathc@linux.ibm.com>
References: <20261006105650.189752-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4d41f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=vHorKMG06VLUeFaFf2gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX0FUMMC8mnWn3
 RaBg9tQgtb4EKxhOaMzKOTKJW4Eg1l3oJnxpEk0O1nV+Rms1ZJP8p9mq49EE7CIR5457duyxoLI
 /IwOIbVE534mBeRslftGNvjqPfnx3cfqTGen4KAuoeBQdzYQVHYwDm5ZIFLwG3+Htz26XDdrDbF
 7DSXJ3JYfnryziBO+CIZX+a6L0gH90/yTPWr5QV6mXl665FjNl7x8B4vpAQIVZzdtPMt0/5ESMx
 PbcU06qqdvHuhCIDG5Rx2ge3J74UTScKE96oTG3aYsMqcdqGkcQXJPO9XMPiPPn2CWel38SVfvV
 FVsYRDefMq64retFHJc4GoFti/XJzbezMDj21wr47MeD6ssrB6h1BmayKY6R6F7iii+2Fe5/lBV
 c00MGCifjsla7Q3Jriqq2iOVYj9ru1vtaDGYiwdhHxFvkdGipw7npTQojm0wSHTGbsOhWxKP6yA
 exbyhYaEnGw0SdtD1CA==
X-Proofpoint-GUID: 81QBH2uo7WuKHKestvKCfE4hGYBS6VJv
X-Proofpoint-ORIG-GUID: mzdcHorUWQXgDOKRpB8QMsA0sr_HPuDo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXy/st6LYj0YMG
 n7U7lRqvVKhoHCR+t4Sre3ZjyMjbbRTEW7XZAMwo1RMVdkCv6FpN8/rECN+7IVOU6gED8MzbdEh
 AK3vI4RHLIu3uuHMPyvwFA65a06GQSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042
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

PowerPC ISA 3.2 DMF RFC02653 moves the exisiting VSX Outer-Product
instructions to the DMF. Add those instructions.
The instructions have new names now, though their opcode remains exactly
the same. This is handled using overlapping pattern group in the
decodetree specification. Since the operations remain logically the same,
reusing the same helpers. Results now accumulate to the accumulators in
the DMRs.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/fpu_helper.c             |   5 +
 target/ppc/insn32.decode            | 157 ++++++++++++++----
 target/ppc/insn64.decode            | 244 ++++++++++++++++++++--------
 target/ppc/int_helper.c             |   5 +
 target/ppc/translate/dmf-impl.c.inc |  86 ++++++++++
 5 files changed, 398 insertions(+), 99 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index c1bdde9e10..8e211b40b2 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3386,6 +3386,11 @@ static float64 extract_bf16(bfloat16 in, float_status *fp_status)
     return bfloat16_to_float64(in, fp_status);
 }
 
+/*
+ * ISA 3.2 onwards accumulators are assigned in DMRs instead of VSRs.
+ * However both ppc_acc_t and ppc_dmr_row_t are essentially ppc_vsr_t,
+ * hence the below helpers work for either.
+ */
 static void vsxger16(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b,
                      ppc_acc_t  *at, uint32_t mask, bool acc,
                      bool neg_mul, bool neg_acc, extract_f16 extract)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f718d550dc..ff25dfa802 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1440,41 +1440,128 @@ XXLEQV          111100 ..... ..... ..... 10111010 ...   @XX3
 XXLNAND         111100 ..... ..... ..... 10110010 ...   @XX3
 XXLORC          111100 ..... ..... ..... 10101010 ...   @XX3
 
-## VSX GER instruction
-
-XVI4GER8        111011 ... -- ..... ..... 00100011 ..-  @XX3_at xa=%xx_xa
-XVI4GER8PP      111011 ... -- ..... ..... 00100010 ..-  @XX3_at xa=%xx_xa
-XVI8GER4        111011 ... -- ..... ..... 00000011 ..-  @XX3_at xa=%xx_xa
-XVI8GER4PP      111011 ... -- ..... ..... 00000010 ..-  @XX3_at xa=%xx_xa
-XVI16GER2       111011 ... -- ..... ..... 01001011 ..-  @XX3_at xa=%xx_xa
-XVI16GER2PP     111011 ... -- ..... ..... 01101011 ..-  @XX3_at xa=%xx_xa
-XVI8GER4SPP     111011 ... -- ..... ..... 01100011 ..-  @XX3_at xa=%xx_xa
-XVI16GER2S      111011 ... -- ..... ..... 00101011 ..-  @XX3_at xa=%xx_xa
-XVI16GER2SPP    111011 ... -- ..... ..... 00101010 ..-  @XX3_at xa=%xx_xa
-
-XVBF16GER2      111011 ... -- ..... ..... 00110011 ..-  @XX3_at xa=%xx_xa
-XVBF16GER2PP    111011 ... -- ..... ..... 00110010 ..-  @XX3_at xa=%xx_xa
-XVBF16GER2PN    111011 ... -- ..... ..... 10110010 ..-  @XX3_at xa=%xx_xa
-XVBF16GER2NP    111011 ... -- ..... ..... 01110010 ..-  @XX3_at xa=%xx_xa
-XVBF16GER2NN    111011 ... -- ..... ..... 11110010 ..-  @XX3_at xa=%xx_xa
-
-XVF16GER2       111011 ... -- ..... ..... 00010011 ..-  @XX3_at xa=%xx_xa
-XVF16GER2PP     111011 ... -- ..... ..... 00010010 ..-  @XX3_at xa=%xx_xa
-XVF16GER2PN     111011 ... -- ..... ..... 10010010 ..-  @XX3_at xa=%xx_xa
-XVF16GER2NP     111011 ... -- ..... ..... 01010010 ..-  @XX3_at xa=%xx_xa
-XVF16GER2NN     111011 ... -- ..... ..... 11010010 ..-  @XX3_at xa=%xx_xa
-
-XVF32GER        111011 ... -- ..... ..... 00011011 ..-  @XX3_at xa=%xx_xa
-XVF32GERPP      111011 ... -- ..... ..... 00011010 ..-  @XX3_at xa=%xx_xa
-XVF32GERPN      111011 ... -- ..... ..... 10011010 ..-  @XX3_at xa=%xx_xa
-XVF32GERNP      111011 ... -- ..... ..... 01011010 ..-  @XX3_at xa=%xx_xa
-XVF32GERNN      111011 ... -- ..... ..... 11011010 ..-  @XX3_at xa=%xx_xa
-
-XVF64GER        111011 ... -- .... 0 ..... 00111011 ..-  @XX3_at xa=%xx_xa_pair
-XVF64GERPP      111011 ... -- .... 0 ..... 00111010 ..-  @XX3_at xa=%xx_xa_pair
-XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
-XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
-XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
+## DMF and VSX GER instruction
+
+{
+  DMXVI4GER8      111011 ... -- ..... ..... 00100011 ..-  @XX3_at xa=%xx_xa
+  XVI4GER8        111011 ... -- ..... ..... 00100011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI4GER8PP    111011 ... -- ..... ..... 00100010 ..-  @XX3_at xa=%xx_xa
+  XVI4GER8PP      111011 ... -- ..... ..... 00100010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI8GER4      111011 ... -- ..... ..... 00000011 ..-  @XX3_at xa=%xx_xa
+  XVI8GER4        111011 ... -- ..... ..... 00000011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI8GER4PP    111011 ... -- ..... ..... 00000010 ..-  @XX3_at xa=%xx_xa
+  XVI8GER4PP      111011 ... -- ..... ..... 00000010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI16GER2     111011 ... -- ..... ..... 01001011 ..-  @XX3_at xa=%xx_xa
+  XVI16GER2       111011 ... -- ..... ..... 01001011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI16GER2PP   111011 ... -- ..... ..... 01101011 ..-  @XX3_at xa=%xx_xa
+  XVI16GER2PP     111011 ... -- ..... ..... 01101011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI8GER4SPP   111011 ... -- ..... ..... 01100011 ..-  @XX3_at xa=%xx_xa
+  XVI8GER4SPP     111011 ... -- ..... ..... 01100011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI16GER2S    111011 ... -- ..... ..... 00101011 ..-  @XX3_at xa=%xx_xa
+  XVI16GER2S      111011 ... -- ..... ..... 00101011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVI16GER2SPP  111011 ... -- ..... ..... 00101010 ..-  @XX3_at xa=%xx_xa
+  XVI16GER2SPP    111011 ... -- ..... ..... 00101010 ..-  @XX3_at xa=%xx_xa
+}
+
+{
+  DMXVBF16GER2    111011 ... -- ..... ..... 00110011 ..-  @XX3_at xa=%xx_xa
+  XVBF16GER2      111011 ... -- ..... ..... 00110011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVBF16GER2PP  111011 ... -- ..... ..... 00110010 ..-  @XX3_at xa=%xx_xa
+  XVBF16GER2PP    111011 ... -- ..... ..... 00110010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVBF16GER2PN  111011 ... -- ..... ..... 10110010 ..-  @XX3_at xa=%xx_xa
+  XVBF16GER2PN    111011 ... -- ..... ..... 10110010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVBF16GER2NP  111011 ... -- ..... ..... 01110010 ..-  @XX3_at xa=%xx_xa
+  XVBF16GER2NP    111011 ... -- ..... ..... 01110010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVBF16GER2NN  111011 ... -- ..... ..... 11110010 ..-  @XX3_at xa=%xx_xa
+  XVBF16GER2NN    111011 ... -- ..... ..... 11110010 ..-  @XX3_at xa=%xx_xa
+}
+
+{
+  DMXVF16GER2     111011 ... -- ..... ..... 00010011 ..-  @XX3_at xa=%xx_xa
+  XVF16GER2       111011 ... -- ..... ..... 00010011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF16GER2PP   111011 ... -- ..... ..... 00010010 ..-  @XX3_at xa=%xx_xa
+  XVF16GER2PP     111011 ... -- ..... ..... 00010010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF16GER2PN   111011 ... -- ..... ..... 10010010 ..-  @XX3_at xa=%xx_xa
+  XVF16GER2PN     111011 ... -- ..... ..... 10010010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF16GER2NP   111011 ... -- ..... ..... 01010010 ..-  @XX3_at xa=%xx_xa
+  XVF16GER2NP     111011 ... -- ..... ..... 01010010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF16GER2NN   111011 ... -- ..... ..... 11010010 ..-  @XX3_at xa=%xx_xa
+  XVF16GER2NN     111011 ... -- ..... ..... 11010010 ..-  @XX3_at xa=%xx_xa
+}
+
+{
+  DMXVF32GER      111011 ... -- ..... ..... 00011011 ..-  @XX3_at xa=%xx_xa
+  XVF32GER        111011 ... -- ..... ..... 00011011 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF32GERPP    111011 ... -- ..... ..... 00011010 ..-  @XX3_at xa=%xx_xa
+  XVF32GERPP      111011 ... -- ..... ..... 00011010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF32GERPN    111011 ... -- ..... ..... 10011010 ..-  @XX3_at xa=%xx_xa
+  XVF32GERPN      111011 ... -- ..... ..... 10011010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF32GERNP    111011 ... -- ..... ..... 01011010 ..-  @XX3_at xa=%xx_xa
+  XVF32GERNP      111011 ... -- ..... ..... 01011010 ..-  @XX3_at xa=%xx_xa
+}
+{
+  DMXVF32GERNN    111011 ... -- ..... ..... 11011010 ..-  @XX3_at xa=%xx_xa
+  XVF32GERNN      111011 ... -- ..... ..... 11011010 ..-  @XX3_at xa=%xx_xa
+}
+
+{
+  DMXVF64GER      111011 ... -- .... 0 ..... 00111011 ..-  @XX3_at xa=%xx_xa_pair
+  XVF64GER        111011 ... -- .... 0 ..... 00111011 ..-  @XX3_at xa=%xx_xa_pair
+}
+{
+  DMXVF64GERPP    111011 ... -- .... 0 ..... 00111010 ..-  @XX3_at xa=%xx_xa_pair
+  XVF64GERPP      111011 ... -- .... 0 ..... 00111010 ..-  @XX3_at xa=%xx_xa_pair
+}
+{
+  DMXVF64GERPN    111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
+  XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
+}
+{
+  DMXVF64GERNP    111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
+  XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
+}
+{
+  DMXVF64GERNN    111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
+  XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
+}
 
 ## Cache Management Instructions
 
diff --git a/target/ppc/insn64.decode b/target/ppc/insn64.decode
index de115c1943..bb2fd6c55e 100644
--- a/target/ppc/insn64.decode
+++ b/target/ppc/insn64.decode
@@ -129,70 +129,186 @@ PSTFS           000001 10 0--.-- .................. \
 PSTFD           000001 10 0--.-- .................. \
                 110110 ..... ..... ................     @PLS_D
 
-## VSX GER instruction
-
-PMXVI4GER8      000001 11 1001 -- - - pmsk:8 ........              \
-                111011 ... -- ..... ..... 00100011 ..-  @MMIRR_XX3
-PMXVI4GER8PP    000001 11 1001 -- - - pmsk:8 ........              \
-                111011 ... -- ..... ..... 00100010 ..-  @MMIRR_XX3
-PMXVI8GER4      000001 11 1001 -- - - pmsk:4 ---- ........         \
-                111011 ... -- ..... ..... 00000011 ..-  @MMIRR_XX3
-PMXVI8GER4PP    000001 11 1001 -- - - pmsk:4 ---- ........         \
-                111011 ... -- ..... ..... 00000010 ..-  @MMIRR_XX3
-PMXVI16GER2     000001 11 1001 -- - - pmsk:2 ------ ........       \
-                111011 ... -- ..... ..... 01001011 ..-  @MMIRR_XX3
-PMXVI16GER2PP   000001 11 1001 -- - - pmsk:2 ------ ........       \
-                111011 ... -- ..... ..... 01101011 ..-  @MMIRR_XX3
-PMXVI8GER4SPP   000001 11 1001 -- - - pmsk:4 ---- ........         \
-                111011 ... -- ..... ..... 01100011 ..-  @MMIRR_XX3
-PMXVI16GER2S    000001 11 1001 -- - - pmsk:2 ------ ........       \
-                111011 ... -- ..... ..... 00101011 ..-  @MMIRR_XX3
-PMXVI16GER2SPP  000001 11 1001 -- - - pmsk:2 ------ ........       \
-                111011 ... -- ..... ..... 00101010 ..-  @MMIRR_XX3
-
-PMXVBF16GER2    000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 00110011 ..-  @MMIRR_XX3
-PMXVBF16GER2PP  000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 00110010 ..-  @MMIRR_XX3
-PMXVBF16GER2PN  000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 10110010 ..-  @MMIRR_XX3
-PMXVBF16GER2NP  000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 01110010 ..-  @MMIRR_XX3
-PMXVBF16GER2NN  000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 11110010 ..-  @MMIRR_XX3
-
-PMXVF16GER2     000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 00010011 ..-  @MMIRR_XX3
-PMXVF16GER2PP   000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 00010010 ..-  @MMIRR_XX3
-PMXVF16GER2PN   000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 10010010 ..-  @MMIRR_XX3
-PMXVF16GER2NP   000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 01010010 ..-  @MMIRR_XX3
-PMXVF16GER2NN   000001 11 1001 -- - - pmsk:2 ------ ........ \
-                111011 ... -- ..... ..... 11010010 ..-  @MMIRR_XX3
-
-PMXVF32GER      000001 11 1001 -- - - -------- .... ymsk:4 \
-                111011 ... -- ..... ..... 00011011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
-PMXVF32GERPP    000001 11 1001 -- - - -------- .... ymsk:4 \
-                111011 ... -- ..... ..... 00011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
-PMXVF32GERPN    000001 11 1001 -- - - -------- .... ymsk:4 \
-                111011 ... -- ..... ..... 10011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
-PMXVF32GERNP    000001 11 1001 -- - - -------- .... ymsk:4 \
-                111011 ... -- ..... ..... 01011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
-PMXVF32GERNN    000001 11 1001 -- - - -------- .... ymsk:4 \
-                111011 ... -- ..... ..... 11011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
-
-PMXVF64GER      000001 11 1001 -- - - -------- .... ymsk:2 -- \
-                111011 ... -- ....0 ..... 00111011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
-PMXVF64GERPP    000001 11 1001 -- - - -------- .... ymsk:2 -- \
-                111011 ... -- ....0 ..... 00111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
-PMXVF64GERPN    000001 11 1001 -- - - -------- .... ymsk:2 -- \
-                111011 ... -- ....0 ..... 10111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
-PMXVF64GERNP    000001 11 1001 -- - - -------- .... ymsk:2 -- \
-                111011 ... -- ....0 ..... 01111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
-PMXVF64GERNN    000001 11 1001 -- - - -------- .... ymsk:2 -- \
-                111011 ... -- ....0 ..... 11111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+## DMF and VSX GER instruction
+
+{
+  PMDMXVI4GER8    000001 11 1001 -- - - pmsk:8 ........              \
+                  111011 ... -- ..... ..... 00100011 ..-  @MMIRR_XX3
+  PMXVI4GER8      000001 11 1001 -- - - pmsk:8 ........              \
+                  111011 ... -- ..... ..... 00100011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI4GER8PP  000001 11 1001 -- - - pmsk:8 ........              \
+                  111011 ... -- ..... ..... 00100010 ..-  @MMIRR_XX3
+  PMXVI4GER8PP    000001 11 1001 -- - - pmsk:8 ........              \
+                  111011 ... -- ..... ..... 00100010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI8GER4    000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 00000011 ..-  @MMIRR_XX3
+  PMXVI8GER4      000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 00000011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI8GER4PP  000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 00000010 ..-  @MMIRR_XX3
+  PMXVI8GER4PP    000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 00000010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI16GER2   000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 01001011 ..-  @MMIRR_XX3
+  PMXVI16GER2     000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 01001011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI16GER2PP 000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 01101011 ..-  @MMIRR_XX3
+  PMXVI16GER2PP   000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 01101011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI8GER4SPP 000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 01100011 ..-  @MMIRR_XX3
+  PMXVI8GER4SPP   000001 11 1001 -- - - pmsk:4 ---- ........         \
+                  111011 ... -- ..... ..... 01100011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI16GER2S  000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 00101011 ..-  @MMIRR_XX3
+  PMXVI16GER2S    000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 00101011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVI16GER2SPP 000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 00101010 ..-  @MMIRR_XX3
+  PMXVI16GER2SPP  000001 11 1001 -- - - pmsk:2 ------ ........       \
+                  111011 ... -- ..... ..... 00101010 ..-  @MMIRR_XX3
+}
+
+{
+  PMDMXVBF16GER2   000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00110011 ..-  @MMIRR_XX3
+  PMXVBF16GER2     000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00110011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVBF16GER2PP 000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00110010 ..-  @MMIRR_XX3
+  PMXVBF16GER2PP   000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00110010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVBF16GER2PN 000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 10110010 ..-  @MMIRR_XX3
+  PMXVBF16GER2PN   000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 10110010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVBF16GER2NP 000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 01110010 ..-  @MMIRR_XX3
+  PMXVBF16GER2NP   000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 01110010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVBF16GER2NN 000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 11110010 ..-  @MMIRR_XX3
+  PMXVBF16GER2NN   000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 11110010 ..-  @MMIRR_XX3
+}
+
+{
+  PMDMXVF16GER2    000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00010011 ..-  @MMIRR_XX3
+  PMXVF16GER2      000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00010011 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVF16GER2PP  000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00010010 ..-  @MMIRR_XX3
+  PMXVF16GER2PP    000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 00010010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVF16GER2PN  000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 10010010 ..-  @MMIRR_XX3
+  PMXVF16GER2PN    000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 10010010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVF16GER2NP  000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 01010010 ..-  @MMIRR_XX3
+  PMXVF16GER2NP    000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 01010010 ..-  @MMIRR_XX3
+}
+{
+  PMDMXVF16GER2NN  000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 11010010 ..-  @MMIRR_XX3
+  PMXVF16GER2NN    000001 11 1001 -- - - pmsk:2 ------ ........ \
+                   111011 ... -- ..... ..... 11010010 ..-  @MMIRR_XX3
+}
+
+{
+  PMDMXVF32GER     000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 00011011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+  PMXVF32GER       000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 00011011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+}
+{
+  PMDMXVF32GERPP   000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 00011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+  PMXVF32GERPP     000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 00011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+}
+{
+  PMDMXVF32GERPN   000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 10011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+  PMXVF32GERPN     000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 10011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+}
+{
+  PMDMXVF32GERNP   000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 01011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+  PMXVF32GERNP     000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 01011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+}
+{
+  PMDMXVF32GERNN   000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 11011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+  PMXVF32GERNN     000001 11 1001 -- - - -------- .... ymsk:4 \
+                   111011 ... -- ..... ..... 11011010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa
+}
+
+{
+  PMDMXVF64GER     000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 00111011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+  PMXVF64GER       000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 00111011 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+}
+{
+  PMDMXVF64GERPP   000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 00111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+  PMXVF64GERPP     000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 00111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+}
+{
+  PMDMXVF64GERPN   000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 10111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+  PMXVF64GERPN     000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 10111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+}
+{
+  PMDMXVF64GERNP   000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 01111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+  PMXVF64GERNP     000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 01111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+}
+{
+  PMDMXVF64GERNN   000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 11111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+  PMXVF64GERNN     000001 11 1001 -- - - -------- .... ymsk:2 -- \
+                   111011 ... -- ....0 ..... 11111010 ..-  @MMIRR_XX3_NO_P xa=%xx3_xa_pair
+}
 
 ### Prefixed No-operation Instruction
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 86346f5b9a..0a576e4387 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -782,6 +782,11 @@ static int64_t ger_rank2(uint32_t a, uint32_t b, uint32_t mask)
     return psum;
 }
 
+/*
+ * ISA 3.2 onwards accumulators are assigned in DMRs instead of VSRs.
+ * However both ppc_acc_t and ppc_dmr_row_t are essentially ppc_vsr_t,
+ * hence this helpers works for either.
+ */
 static void xviger(CPUPPCState *env, ppc_vsr_t *a, ppc_vsr_t *b, ppc_acc_t  *at,
                    uint32_t mask, bool sat, bool acc, do_ger ger)
 {
diff --git a/target/ppc/translate/dmf-impl.c.inc b/target/ppc/translate/dmf-impl.c.inc
index 5bc70663f8..87762e79af 100644
--- a/target/ppc/translate/dmf-impl.c.inc
+++ b/target/ppc/translate/dmf-impl.c.inc
@@ -167,3 +167,89 @@ static bool trans_DMSETACCZ(DisasContext *ctx, arg_DMSETACCZ *a)
      */
     return trans_DMSETDMRZ(ctx, a);
 }
+
+static bool do_dm_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
+    void (*helper)(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32))
+{
+    uint32_t mask;
+    TCGv_ptr xt, xa, xb;
+    REQUIRE_INSNS_FLAGS2(ctx, ISA320);
+    REQUIRE_DM(ctx);
+    REQUIRE_VSX(ctx);
+
+    xt = gen_dmr_ptr(a->xt);
+    xa = gen_vsr_ptr(a->xa);
+    xb = gen_vsr_ptr(a->xb);
+
+    mask = ger_pack_masks(a->pmsk, a->ymsk, a->xmsk);
+    helper(tcg_env, xa, xb, xt, tcg_constant_i32(mask));
+    return true;
+}
+
+TRANS(DMXVI4GER8, do_dm_ger, gen_helper_XVI4GER8)
+TRANS(DMXVI4GER8PP, do_dm_ger,  gen_helper_XVI4GER8PP)
+TRANS(DMXVI8GER4, do_dm_ger, gen_helper_XVI8GER4)
+TRANS(DMXVI8GER4PP, do_dm_ger,  gen_helper_XVI8GER4PP)
+TRANS(DMXVI8GER4SPP, do_dm_ger, gen_helper_XVI8GER4SPP)
+TRANS(DMXVI16GER2, do_dm_ger, gen_helper_XVI16GER2)
+TRANS(DMXVI16GER2PP, do_dm_ger, gen_helper_XVI16GER2PP)
+TRANS(DMXVI16GER2S, do_dm_ger, gen_helper_XVI16GER2S)
+TRANS(DMXVI16GER2SPP, do_dm_ger, gen_helper_XVI16GER2SPP)
+
+TRANS64(PMDMXVI4GER8, do_dm_ger, gen_helper_XVI4GER8)
+TRANS64(PMDMXVI4GER8PP, do_dm_ger, gen_helper_XVI4GER8PP)
+TRANS64(PMDMXVI8GER4, do_dm_ger, gen_helper_XVI8GER4)
+TRANS64(PMDMXVI8GER4PP, do_dm_ger, gen_helper_XVI8GER4PP)
+TRANS64(PMDMXVI8GER4SPP, do_dm_ger, gen_helper_XVI8GER4SPP)
+TRANS64(PMDMXVI16GER2, do_dm_ger, gen_helper_XVI16GER2)
+TRANS64(PMDMXVI16GER2PP, do_dm_ger, gen_helper_XVI16GER2PP)
+TRANS64(PMDMXVI16GER2S, do_dm_ger, gen_helper_XVI16GER2S)
+TRANS64(PMDMXVI16GER2SPP, do_dm_ger, gen_helper_XVI16GER2SPP)
+
+TRANS(DMXVBF16GER2, do_dm_ger, gen_helper_XVBF16GER2)
+TRANS(DMXVBF16GER2PP, do_dm_ger, gen_helper_XVBF16GER2PP)
+TRANS(DMXVBF16GER2PN, do_dm_ger, gen_helper_XVBF16GER2PN)
+TRANS(DMXVBF16GER2NP, do_dm_ger, gen_helper_XVBF16GER2NP)
+TRANS(DMXVBF16GER2NN, do_dm_ger, gen_helper_XVBF16GER2NN)
+
+TRANS(DMXVF16GER2, do_dm_ger, gen_helper_XVF16GER2)
+TRANS(DMXVF16GER2PP, do_dm_ger, gen_helper_XVF16GER2PP)
+TRANS(DMXVF16GER2PN, do_dm_ger, gen_helper_XVF16GER2PN)
+TRANS(DMXVF16GER2NP, do_dm_ger, gen_helper_XVF16GER2NP)
+TRANS(DMXVF16GER2NN, do_dm_ger, gen_helper_XVF16GER2NN)
+
+TRANS(DMXVF32GER, do_dm_ger, gen_helper_XVF32GER)
+TRANS(DMXVF32GERPP, do_dm_ger, gen_helper_XVF32GERPP)
+TRANS(DMXVF32GERPN, do_dm_ger, gen_helper_XVF32GERPN)
+TRANS(DMXVF32GERNP, do_dm_ger, gen_helper_XVF32GERNP)
+TRANS(DMXVF32GERNN, do_dm_ger, gen_helper_XVF32GERNN)
+
+TRANS(DMXVF64GER, do_dm_ger, gen_helper_XVF64GER)
+TRANS(DMXVF64GERPP, do_dm_ger, gen_helper_XVF64GERPP)
+TRANS(DMXVF64GERPN, do_dm_ger, gen_helper_XVF64GERPN)
+TRANS(DMXVF64GERNP, do_dm_ger, gen_helper_XVF64GERNP)
+TRANS(DMXVF64GERNN, do_dm_ger, gen_helper_XVF64GERNN)
+
+TRANS64(PMDMXVBF16GER2, do_dm_ger, gen_helper_XVBF16GER2)
+TRANS64(PMDMXVBF16GER2PP, do_dm_ger, gen_helper_XVBF16GER2PP)
+TRANS64(PMDMXVBF16GER2PN, do_dm_ger, gen_helper_XVBF16GER2PN)
+TRANS64(PMDMXVBF16GER2NP, do_dm_ger, gen_helper_XVBF16GER2NP)
+TRANS64(PMDMXVBF16GER2NN, do_dm_ger, gen_helper_XVBF16GER2NN)
+
+TRANS64(PMDMXVF16GER2, do_dm_ger, gen_helper_XVF16GER2)
+TRANS64(PMDMXVF16GER2PP, do_dm_ger, gen_helper_XVF16GER2PP)
+TRANS64(PMDMXVF16GER2PN, do_dm_ger, gen_helper_XVF16GER2PN)
+TRANS64(PMDMXVF16GER2NP, do_dm_ger, gen_helper_XVF16GER2NP)
+TRANS64(PMDMXVF16GER2NN, do_dm_ger, gen_helper_XVF16GER2NN)
+
+TRANS64(PMDMXVF32GER, do_dm_ger, gen_helper_XVF32GER)
+TRANS64(PMDMXVF32GERPP, do_dm_ger, gen_helper_XVF32GERPP)
+TRANS64(PMDMXVF32GERPN, do_dm_ger, gen_helper_XVF32GERPN)
+TRANS64(PMDMXVF32GERNP, do_dm_ger, gen_helper_XVF32GERNP)
+TRANS64(PMDMXVF32GERNN, do_dm_ger, gen_helper_XVF32GERNN)
+
+TRANS64(PMDMXVF64GER, do_dm_ger, gen_helper_XVF64GER)
+TRANS64(PMDMXVF64GERPP, do_dm_ger, gen_helper_XVF64GERPP)
+TRANS64(PMDMXVF64GERPN, do_dm_ger, gen_helper_XVF64GERPN)
+TRANS64(PMDMXVF64GERNP, do_dm_ger, gen_helper_XVF64GERNP)
+TRANS64(PMDMXVF64GERNN, do_dm_ger, gen_helper_XVF64GERNN)
-- 
2.55.0


