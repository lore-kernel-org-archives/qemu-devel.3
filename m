Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C3CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjU6-0001SJ-TR; Wed, 20 May 2026 12:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTf-0000Pt-Fl; Wed, 20 May 2026 12:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTX-0002k1-Af; Wed, 20 May 2026 12:08:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K859bV2166376; Wed, 20 May 2026 16:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fQRqzWfQu0MuWyVCj
 uoQtVymyiJIMZ2VEAgetY75isM=; b=Lh7vsqbWL+LkmuOlWU/iCclRAmsaCGg0F
 p1q+sqPy1avl8m+h7DkpYH3URUh/TMneJ9ttNM7zw1jVxUBgBevjJcAp/DQJb6nw
 /4xC44dqOq/lpAE3RrK3n0cdmk0y3LxRRbBuggmweNU4ytGR1QC5xwsi1RwnWSbO
 TfkR+0+sUfHXp5EPIpraObeGHESDI7YLOqo+5onEsc+Xq3fJwW3uHJix3jw7nut4
 itviYyTIvphIpmdM9waudvM9upotfgWcXwDcfAfqv4kJYbokHhJ5Vj9A6R4rH5QR
 wVRpkuZ3QWSeJ8N+rnFzAs56FVoMox4BC3bxUadHqZKwaGTFOu5kA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752wxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFs48N015333;
 Wed, 20 May 2026 16:08:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk83h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG8gOD53936462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:08:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3970120043;
 Wed, 20 May 2026 16:08:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A723020040;
 Wed, 20 May 2026 16:08:36 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:08:36 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 09/28] target/ppc : Convert mcrf to decode tree
Date: Wed, 20 May 2026 21:37:09 +0530
Message-ID: <20260520160728.2283628-10-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0ddc8f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=vy6McjWATDkKsZsaVXEA:9
X-Proofpoint-ORIG-GUID: 2NG37qJ6cNz5h5qo6gVz0fvg6VUg-vlN
X-Proofpoint-GUID: 0Q92y532vGHmphFFp_v0vWvHPN2nuzXj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX9usWDX2U3t89
 VsMaSqFEBxvctDpcZG2WlU0JEcJY5NdOS0AGIU2DNZKFkg5a3Rcopss/EKIpiYKVf2NoynFvDFG
 8KNLWJ0l+MD7f/xlKMC2m7AAZtUruK1HbtuwAAXQhJ4aVV0C1yPh7cnIKZjz/g806gInT42Oq92
 VV6siuXbDAQIAswEfNDPV8FUG86B6NrEtfknp+Bcobhaz4W9ZgUWKTO38Z6+akgvlFhJkY/678p
 ggLXvGGYNNagx7+sl7JUCrgxTUJGkddJW/r7lx3yqAuix2roqRw0z/fSIETOGqUqo9OQH/TMFkZ
 //3xEwHsXpRhxoy8sZVe12zAsa+9kSK7SB/s7seEULMXGRQBUC2jjF/nXVcvI4yqxEE91jucRs3
 1Umao3w9IPkuHYSkMnIiVrHPwEjyz8lI8u1uoTkafEfwOfbvlqnP74lDGqQ1fggAA7F6W7ayVkl
 X5Jmcp2oasFwl63uPRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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
index dd80a25472..db6e9418f3 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1445,6 +1445,12 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
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
index c9d04b4a3c..5be508fcb1 100644
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
@@ -5746,7 +5740,6 @@ GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
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
2.53.0


