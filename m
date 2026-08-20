Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05D1C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3NZ-0001mj-PR; Thu, 20 Aug 2026 10:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3NO-0001fK-5c; Thu, 20 Aug 2026 10:04:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3NM-00061E-LB; Thu, 20 Aug 2026 10:04:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8Kt8A362205; Thu, 20 Aug 2026 14:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NNgfyXLnkMb+YEc0v
 Q6qudc+U3CXTnmFl9STxG3X8v4=; b=KiNYnFothWnyionp34QthwJbPpZgaYjrB
 CDyl0ynn+CDd5Xcy7cgIxPv2al6Qk1R9k8HLjhJdr2xGRtlyYVu+sKe28I3RGzQv
 eH8TviTnHaICBjp6deSiVX3mh7NqYovvl4AKK9IKrtqZ+AXyFO771XI5FkgT7pEI
 U3Ghvmz3CVdr6XRTJbnK0uCABItJogHHLar6eezSgAqzTqItFmwhNsG/ImDc6pE8
 pqIWPGuIRkCbK32bCOOCg4P5NMmebgTRUqv4XY6DysDDxXYkJF73HiY7ttEn94Ya
 Cjykc9BzGUYi/2gb8DPpEnzilWHJTMBq+nsD87XLMikBuV/qIlqzA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4an59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuH5r027511;
 Thu, 20 Aug 2026 14:04:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqf3fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:04:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE42X030015894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:04:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9888F20043;
 Thu, 20 Aug 2026 14:04:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED19A20040;
 Thu, 20 Aug 2026 14:03:55 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:03:55 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 09/29] target/ppc: Convert mcrf to decode tree
Date: Thu, 20 Aug 2026 19:30:38 +0530
Message-ID: <20260820140114.327023-10-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX523lZuyu/ReI
 7ECjkPwBjXqK5ziZ05rvKzYy3OmrzYuyquVk2mHKJVQDRWz+WGDMlSs5Wv7CxfO7tDmi2Nu2ei1
 9FEty+vyGssaq9/nWek5yaIrsRNnMWw=
X-Proofpoint-GUID: vvxOOyIrpZVUjdv7Q4E8W5XcBogOiuqe
X-Proofpoint-ORIG-GUID: QaBeUigxVExnJXG2fCItq75uUPASn7uE
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a870959 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vy6McjWATDkKsZsaVXEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfXzf4Y9/uzXIAs
 FOA8khbg5vypvM89sNFauIHJ8rOjQ3G3jScjoLaxKux+81aqyX5RiQAWrnCrl/4ob0nw5AD85Di
 NstQAK+S5sIZg2CNe8VqNO2oNQFLCAzqbLuIViQjudB01EHjt/tlyrzRWW6OaowykFyMHxAd8HE
 l3pYdfMAYuKAN2p+Y+V6icOqiEUlVzP5Wc6M9lRhVrs5wWsWaGHg7Ol/9IE7VtCI7lhNsLEBaCi
 t4s/wMKWHCOXUZyn2OB6TwWCqwG2uJFTab0JflhV89b9NqWDoxsiW6Z5T6mFARTBT4dwM3D9VFM
 BhMfIpXrF2oYWYxhVrGmAV6SGmXhtUvPSGqHA2llp8SbkKG/CF2R5sErFio96x0IZA+rzBD4RFG
 GUNg+tfnlmiN0QIB0ZJl85xFqLx6xtgOIVX550wSWP9LqnPNFvW4jqdrJmwZ9cV4yjJXASOaR2X
 0cJi2XWuUNJYT2OSPVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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

Convert mcrf to decode tree specification.The functionality
was tested by comparing the qemu -D log -d op,in_asm output
as well as single stepping gdb.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode             | 6 ++++++
 target/ppc/translate.c               | 7 -------
 target/ppc/translate/misc-impl.c.inc | 6 ++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index af35a44223..7d792d2318 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1455,6 +1455,12 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
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
index f00071aa91..55b515cec7 100644
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
@@ -5722,7 +5716,6 @@ GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
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


