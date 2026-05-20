Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjUB-0001oF-Rj; Wed, 20 May 2026 12:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTx-00013z-Me; Wed, 20 May 2026 12:09:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTt-0002sX-3Z; Wed, 20 May 2026 12:09:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6meTx1594906; Wed, 20 May 2026 16:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tRyk0by1v5rffRcEe
 YnPoxnSPQgDDZo/7r+oPIgc1lE=; b=Z5LL9MNRZvY+O14t1HWpKSzNeR8chs9k8
 PdjheCKY+u6i2o3pCZ05fxolC6Rb8N+ziCK0uTS2WBSjYmogH+0umunXmR5LoT07
 2tL1oUsjkkl75LIL7UvQk8CXmRjtoT/KGz2YUtNAul5h4lD+k5DVI3IsLCockU+W
 2KkLufJ6Hgwj5NPVSvDIFVrkRC3P4X2eqxi8KeQFKzIn+YK8u9EYGA2hGpRUR4B7
 yJVwPt437LkwF3l7t6L+Qwarpto2d9dt7OfIWIpnyqbhjqGLLfYrBooGj4eWzqUb
 AAexzsOHenH5/k7+oRQ0GEZLmyzLe3cFhbDtfbptzKUt0OAMsZ1wA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hw9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsGHG015878;
 Wed, 20 May 2026 16:09:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk83hx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:09:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG96fN50069778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:09:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6271920040;
 Wed, 20 May 2026 16:09:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47F3520043;
 Wed, 20 May 2026 16:09:01 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:09:01 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 13/28] target/ppc: Move isync instruction to decodetree.
Date: Wed, 20 May 2026 21:37:13 +0530
Message-ID: <20260520160728.2283628-14-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfXw/otAotkmgyz
 PuMDu/1FmmyvLbWtX/e+x3fJNmWVIf99mn7aBDQQ69xNXLgCKXuAMPultaY3PI8a3CrdhOlIv2G
 gdR/ewQ/pUsIJtfsF4RO2M/C56NgAjaP8MBsL6v8LDRZj5jb6jFrolMuZXb5ngQt/wNATCr7Gcl
 L9gskdSCsN5z6eVRsiVjkFlo4VT4VGy0hI9F4pTK0M5RtrBuyCPbrukll1SLkYrCaVSM4mQT/Wi
 brYNSO79YuiFFF4Z0iUDZVBUA4rtOf3JmXs/baOoawbdpezsSjQP0yc35qIHT8o79KQy1lopVQo
 O9eD9dQb2Nl2aKJqR/SQIagwsgUUjaH5psEMrio7JxlJwLcWuMC8goVrmQkQmmMLav0xJPOw5w4
 dHaAtyXklMuXLbo3C9Z5FGtxLUDVVIE779MJGJ/mc1lGP/zq82rDCPA9q80SO+JedgUiG1fRah1
 A5cj1hC4ViCNJwcz+iw==
X-Proofpoint-GUID: evMTthoIr8nyWPS1cDwg0-kj70ynFBE9
X-Proofpoint-ORIG-GUID: fslE-KaODBoeGBsrYdz8r0bgZ0cCkSIr
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ddca7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3RUvYVtxcIq7NUn8s_cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Moving the following instructions to decodetree specification :
isync

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                     |  1 +
 target/ppc/translate.c                       | 15 ---------------
 target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f35f7113a0..cbb7a2ed51 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1462,6 +1462,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
+ISYNC           010011 ----- ----- ----- 0010010110 -
 
 # Condition Register Field Instruction
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2345bf8867..770f52e7d4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2727,20 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
 static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
 #endif
 
-/* isync */
-static void gen_isync(DisasContext *ctx)
-{
-    /*
-     * We need to check for a pending TLB flush. This can only happen in
-     * kernel mode however so check MSR_PR
-     */
-    if (!ctx->pr) {
-        gen_check_tlb_flush(ctx, false);
-    }
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-}
-
 /* wait */
 static void gen_wait(DisasContext *ctx)
 {
@@ -5401,7 +5387,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
 GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
 GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
-GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
index b8b4454663..943229c438 100644
--- a/target/ppc/translate/storage-ctrl-impl.c.inc
+++ b/target/ppc/translate/storage-ctrl-impl.c.inc
@@ -155,6 +155,23 @@ static bool trans_SLBFEE(DisasContext *ctx, arg_SLBFEE *a)
     return true;
 }
 
+static bool trans_ISYNC(DisasContext *ctx, arg_ISYNC *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, MEM);
+
+    /*
+     * We need to check for a pending TLB flush. This can only happen in
+     * kernel mode however so check MSR_PR
+     */
+    if (!ctx->pr) {
+        gen_check_tlb_flush(ctx, false);
+    }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+
+    return true;
+}
+
 static bool trans_SLBSYNC(DisasContext *ctx, arg_SLBSYNC *a)
 {
     REQUIRE_64BIT(ctx);
-- 
2.53.0


