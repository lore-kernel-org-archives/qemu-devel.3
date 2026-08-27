Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB7AC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaCi-0000vZ-8v; Thu, 27 Aug 2026 09:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCg-0000sc-T5; Thu, 27 Aug 2026 09:31:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCf-0001YE-74; Thu, 27 Aug 2026 09:31:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVlHV3056734; Thu, 27 Aug 2026 13:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0K04v8Hp+0A2+sNAB
 1lXbKW+qEnZWajGEgqWuGnLC5k=; b=VBc3E16sRDiaya020kMjzs1qa9OP9u1cK
 jruv4M/LuNi3rj/MK1o8Z1VuRuT6/hKwNBYZHW5qmoX7t7QdM1J9nz7ntmZEaCZT
 oEX8Syy/Tzmfg5eLqDdodsAj8YcJJpaAlT//GWkg/474JqKJiNEBZHxjL3F/QoU4
 xZZmy53lDOjX0IFkhjNFow+th6kfWM8cIJcvHo+4Eb1NMErthJyKOpGTEAzcn9R+
 wS9C8Kb3oufQ1S17ENxzKPIsJnGPPQwrsaGIU0WU4ss4TN+EEVWDAGwtshJAw9Gd
 baIi1X1+HlynIkW+I9z+xaJ2wfy5XUi+WuThEPy7n0QWJh4CQ4khw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn9gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQIMh027485;
 Thu, 27 Aug 2026 13:31:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyg1a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDVTNf46268802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:31:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30B1C20040;
 Thu, 27 Aug 2026 13:31:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5E02004D;
 Thu, 27 Aug 2026 13:31:23 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:31:23 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 09/37] target/ppc: Convert mcrf to decode tree
Date: Thu, 27 Aug 2026 18:59:24 +0530
Message-ID: <20260827133010.278889-10-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXxzVW//1krhb3
 xnodZ2+xyiuNaoxfGmXDGeoXQa0rjrOp8xQxYDQavO0vV1lOF0FnvGllgxRYDwskf9zYH3SV9IE
 VunIKyVSDwWR1uP8EDkel/jSITNODgw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903c37 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vy6McjWATDkKsZsaVXEA:9
X-Proofpoint-ORIG-GUID: hhYFROW73PQwy6VOXA_au4fxYVCcFXXd
X-Proofpoint-GUID: Db3Zpjm0VATJ6P9RuXhLsHxpvCenxftf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX/Dp03IhnPzDZ
 iXjZivSx0FMIA8j61l2vozQjO+pW82rvYKj68eVYoYPSEqXpy8+1LAdwbnczZ5cxu7WFl1dSoUn
 q/qo1Wo1oPWSoLyXlYpgJDFgrtkcJkHhcaFadYlfyNTJPet/qKiB77pU9wjhA1J6g964ZDKNYgs
 fcc2U8+/+H/3qyQftkiAFnLZYfvNcQtGryjurV1l4TOqrYcfirOGk3VxleM7+E4kRfox/JR3YXH
 mMZTEo2tql0XrVvp2Chp2mO8EvJHHnqQpVRvdyktJUSYSfQeKCdJd14zMaormHuoZHA3yd1G+EW
 H2UTDZ4LvoV/kACOJd7KOPI/3rrsMKwiw+ce5ODR/RkJ4x3/0HNAyrxTzjju4Uey52J9ozG68k/
 1hTT0CSiqmbtMlFbNIVSf+ge6R8bxbGsER16KvQkerdVEDyWqyJabZBYKalH2OGn4OKLRZcX6SJ
 ojUrKlQvpoMbZR418cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270113
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

From: Shivani Nittor <shivani@linux.ibm.com>

Convert mcrf to decode tree specification. The functionality
was tested by comparing the qemu -D log -d op,in_asm output
as well as single stepping gdb.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode             | 6 ++++++
 target/ppc/translate.c               | 7 -------
 target/ppc/translate/misc-impl.c.inc | 6 ++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index ef0fe12959..f928cd6602 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1452,6 +1452,12 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
 
+# Condition Register Field Instruction
+
+&XL_bfa         bf bfa
+@XL_bfa         ...... bf:3 .. bfa:3 .. ..... ..... ..... .
+MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
+
 # Branch History Rolling Buffer (BHRB) Instructions
 
 &XFX_bhrbe      rt bhrbe
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 53acd54ad4..7e7ef4e32d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3642,12 +3642,6 @@ GEN_CRLOGIC(crorc, tcg_gen_orc_i32, 0x0D);
 /* crxor */
 GEN_CRLOGIC(crxor, tcg_gen_xor_i32, 0x06);
 
-/* mcrf */
-static void gen_mcrf(DisasContext *ctx)
-{
-    tcg_gen_mov_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfS(ctx->opcode)]);
-}
-
 /***                           System linkage                              ***/
 
 /* rfi (supervisor only) */
@@ -5709,7 +5703,6 @@ GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
 GEN_HANDLER_E(bctar, 0x13, 0x10, 0x11, 0x0000E000, PPC_NONE, PPC2_BCTAR_ISA207),
-GEN_HANDLER(mcrf, 0x13, 0x00, 0xFF, 0x00000001, PPC_INTEGER),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
index cbf82b1ea0..890fbb209e 100644
--- a/target/ppc/translate/misc-impl.c.inc
+++ b/target/ppc/translate/misc-impl.c.inc
@@ -155,3 +155,9 @@ static bool trans_ATTN(DisasContext *ctx, arg_ATTN *a)
     return false;
 #endif
 }
+
+static bool trans_MCRF(DisasContext *ctx, arg_MCRF *a)
+{
+    tcg_gen_mov_i32(cpu_crf[a->bf], cpu_crf[a->bfa]);
+    return true;
+}
-- 
2.55.0


