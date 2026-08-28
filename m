Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12E2C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplF-0006F1-S8; Fri, 28 Aug 2026 02:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplD-00062w-Ap
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplB-0000uI-DW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22OVs624689
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sqTl6cYR6/m+O8+vm
 mscSlqACpqTlHWApsmHu5VflNU=; b=DwATeiazcfly1IWuWYLuVL67bKCxfmRw1
 3pL6GOBa3Vf6uiHHfDCU0iVuzfTp7mz20ujMRkCOCeTzrKLhGQmlK/hF9g2j4VIQ
 mFLbPRUz1Eqcd0XCVME4jLwSRivR/Kfm3NmwKwVdYSzv80DJ6Zn01VQFakn1aFpR
 8p29Ul42z2HDoWHuuGoxGYIo5r7az1YI79eWdeml0Aa4RjJSIiShxCjjviWptaAR
 6JAo9PMKLYMxVyxE5bKb/rRbJ7TtjQE7u7chwAuslaqNJOhVs31rWpJbG1uRDATN
 FRMfugAVv1+nLNf3LhH+JmZB7V6lVk75GcaWE/gkYequdAVSgQGtw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5afk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uFRi007418
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsymbyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68AkF42074446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9172220043;
 Fri, 28 Aug 2026 06:08:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BB6720040;
 Fri, 28 Aug 2026 06:08:08 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:08 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 17/41] target/ppc: Move isync instruction to decodetree
Date: Fri, 28 Aug 2026 11:36:52 +0530
Message-ID: <20260828060716.91672-18-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7Q0ndZGK21v_yawcsnnacwLj9mu-vxT9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX8sZSYeQptmXt
 wlt0vNDnExwdyZkI0QU2svJrLi0ZUL+DZakl3W95cZr2vzFCZwyLks/BJsAoLplgKoz1sKDU3PQ
 wDQctFpPzxsyU6Cwn06rGOMlNLbVpk4=
X-Proofpoint-GUID: 7Q0ndZGK21v_yawcsnnacwLj9mu-vxT9
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a9125cf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3RUvYVtxcIq7NUn8s_cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX6SNGw0hnUCAQ
 2AdKn+1PmAeENeATpQvWe1VD/sAmfYBNtyx1uPe3OBzphQB1A7/QRzPjJVLh9vehBoywhaBzP9k
 PKGhKrpODkrY17RYPtgYlqVurXTUKEiGA0tZOsOw9Lz7tPcmer7kcCh+HYedRPFr350chXLvJTH
 DjkdmCkyW6/z0nDCoCrvewQcMqocjhu57VBfXp//91Rnae8yVJa5tQIcAofzK4bnR8eO4gwJPcp
 PGmXh3UkWDm6e3CS2dLWCxdujnbaAVNfAwknEYGNR+HgQb2xlmgwQOVBPcxAvSg3K4kL9xU3yME
 VWWwEWo2iA04PgxwUnvEePUrA/ziIWVmfyxu4v7tkBPjLDUYlUapasz25vc2QvE2TgFxLRs5Ezm
 fWwOb0+IqlP4q3bg5ijaOMIeDojoLWiiLVYZFGA1i++ngMSviiGGUL2a8YCrgeInKfDFxE7PltA
 t5SrO9SFc4MNcoyYt2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Moving the following instructions to decodetree specification :
isync

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-14-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode                     |  1 +
 target/ppc/translate.c                       | 15 ---------------
 target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index e8326a9d0b..6fb7754566 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1470,6 +1470,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
 @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
 SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
 EIEIO           011111 ----- ----- ----- 1101010110 -
+ISYNC           010011 ----- ----- ----- 0010010110 -
 
 # Condition Register Field Instruction
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c44cffb5e8..84589716b3 100644
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
@@ -5364,7 +5350,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
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
2.52.0


