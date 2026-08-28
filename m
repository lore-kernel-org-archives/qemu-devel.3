Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A93FC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpl3-0005kZ-Sg; Fri, 28 Aug 2026 02:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl2-0005jv-39
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpl0-0000sV-4M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S2255v2940748
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AlLa+CBRhmd2U2jAL
 la36qI1QKgZbklY4C07ji1UORs=; b=mj+BMx0kS+MCl8tjRktwh4yjhxm7yJlFY
 JnpdIcq+K38zTefrlS1WR8yZYR7mcipxUYjeRMf3pjw9QrsXZL9cUobWK9Oc89nv
 b64Gpx9BNMIfzBALdbdBwyPxoOS2OTHQGmmlMNwRqjV+CvM3t3QPf5Ui3u13o1MK
 tOmjfuSypP3IuP0X0P+iE7Oek9TBZ3sUoPft5RrWIJtfx6oh3UFmtk2hAgDzQUm1
 9dSERQW85cNINTMFrP2NjUwJlJ7xlbnoKTBgWTJp/6J/Z0VpGZqje1g2Q/ky2Bxb
 CoNAQ99ciWvgp2VwE8GU02wWQI7LOhr3oSM/6UsANkCwMcT4cFgUA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eraauw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uEsD025163
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvgbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67xKU51577102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4D5720043;
 Fri, 28 Aug 2026 06:07:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB06320040;
 Fri, 28 Aug 2026 06:07:57 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:57 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivani Nittor <shivani@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 13/41] target/ppc: Convert mcrf to decode tree
Date: Fri, 28 Aug 2026 11:36:48 +0530
Message-ID: <20260828060716.91672-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eht4Drjp4xu7Q9NV1_nqXeMNJJSATlWZ
X-Proofpoint-ORIG-GUID: eht4Drjp4xu7Q9NV1_nqXeMNJJSATlWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX9zYmoItq3d1n
 ox56Urm9B9TUpuMfbxlWn3cD0lP7/v/gh0kzqqRLLB02pM1At2CFB8tu3H//TVp4NaikS0HVcko
 5v03pRPv4mf5yyqNYueZnZy64O/mFPBiy1Vor3ot1ZtUV1O4wtkDALo14CWrPmVvWYl81R9eXfM
 xFlD429SRcA48BBAUYLE+XxWUJW5TXA+Hjr+kNHPqRKWpFiTo3JJ4WgzLjQfquGNvuu33eSFiSn
 iUfQp0KO3pTXUAhWtU9fQ1lufjrjGtL5BkoERN8gVDhP2lAhw6XtmS3bbm9dJ3y1Wb3Sz5sFurA
 JrPheIvRQTBQr0Qh2/UkeqLNeG3Wk+qWkkisg80vETFhOJiK1/etRq5DNjdJ62mY67gu3jKv0Xq
 92DlD9Hi1htrGkEMpQM/DSWFGTVWUVx3/+EF45390Y8lhRaFBhr939bRlofN+GLFP3SrdnSQS9G
 Jdxv567xYssgU/UNikg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a9125c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vy6McjWATDkKsZsaVXEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXxdbiKM2q0flP
 +xZYX4bj3qdtrDf58SWrdJ+23keePDJI7YsfKiXANtybjj1g2Yp4NiCt6CV5SvFLIc2+yvpkwVU
 wMUR+dpKYgAlbBqtHseppRVTCPq3YLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
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

From: Shivani Nittor <shivani@linux.ibm.com>

Convert mcrf to decode tree specification. The functionality
was tested by comparing the qemu -D log -d op,in_asm output
as well as single stepping gdb.

Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-10-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
2.52.0


