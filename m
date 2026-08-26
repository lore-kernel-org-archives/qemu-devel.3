Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD0AC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5uM-0006Z6-EL; Wed, 26 Aug 2026 01:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uL-0006Pb-Bm; Wed, 26 Aug 2026 01:10:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uJ-0005Bj-J0; Wed, 26 Aug 2026 01:10:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3Vh6c2880683; Wed, 26 Aug 2026 05:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lMK2dJQ1tftnEO/ji
 pp2NWz7nAH6nOPtV8YTy9xSkuQ=; b=WkH+zsaXhrvaSSruzgAxJ5mTMPiVy+eGx
 0f63izBN/DU5rEnDsAOKDaRv9fBIkaIIrAy1+rFEJ4QXE5D+GOsxMaDLYymqz49K
 yQ4tQkIgggyXaLSl+pnGqFymiHbQMmk1b+Jb2lrpQIU3WX8dK7JejNXl1wBNdDJt
 y/LyM2Z40O6iAQfWR1mDaMhjUMSQ9k5ms/Dnh8q2tr7AcXUri2oI9ayXWaqpuol3
 MdxH3deXq7YmjmJQ3Hyo22P3GKQsiv0irbKIp9uC8jZmuJpL+5fmjqnX56kiTO8z
 CK0R3yq+qfyyesdUnyGZHvQF6kbk7HQmRXCjCpRfvk9CMWmKoHEiA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxcbcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:10:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4uJXg011651;
 Wed, 26 Aug 2026 05:10:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8apv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:10:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5AWuq46334360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:10:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA83520043;
 Wed, 26 Aug 2026 05:10:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA8A32004B;
 Wed, 26 Aug 2026 05:10:27 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:10:27 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 09/37] target/ppc: Convert mcrf to decode tree
Date: Wed, 26 Aug 2026 10:38:35 +0530
Message-ID: <20260826050923.74756-10-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX4Dz6/oteAcZU
 wombooGubdH7+//FhVFtXVjn/AtgnMvl48R4vF0Czs8GV1nGHbnL0WrZV0RgNgQacbDqXLF129l
 uHzIUnK/Z+RWJ2z6DBi6/LSOfajtAKY=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8e754d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vy6McjWATDkKsZsaVXEA:9
X-Proofpoint-ORIG-GUID: o8vVhMDaPc2skdG0NXoGrONOfjocFvuB
X-Proofpoint-GUID: OPfjeD_n0LgjY4C3-7hF4jrGkZaQ3rcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX74mFV9dP1e4S
 bBoKCDL3cVeOm2vT+BtpFHyBmCI8clgMBNS/SIn81QCTsniGpmRXPMS0abelQmA2bclRS/KXTGr
 j4AkSVZ418erJyBmA0NuGBsljzc9zIL/e43JmlsJbqWtxd+KMKeQFeUEx8Oa+7xzSQgTxCy+lmF
 WQCKjbRGQevIy6veHTxsBsyWGEu0CyTmuRC/sxLonRfBOwdqZQw+gUT/t2j1XdQErLhPx22uM+D
 w3s1fU58CI/s355tjH3EA0hTT197Mb4Ic1gmUHPZF4wAgUjFJwBIoaW9cWRtDapH3hkglgVp0TK
 tAocIGrTbC1OynszdKZrTT/OhYLwgdYOvMKqRTqobJnzRa4vs8WNc/oJSkoI9FGKHpMI+dNTz+6
 apAnAA3bhpqt/oqKRtwZVSmoHphsKpB9Afo+6TqVW/ZWo8uJC3xJAUiAhbRLs49dp/cMys5eE/i
 dY4Ukt1ClNApvm+mnuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260040
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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


