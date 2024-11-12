Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF81D42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtJs-0004ZI-JA; Tue, 12 Nov 2024 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE8-0001th-JY; Tue, 12 Nov 2024 10:54:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE4-00015s-9d; Tue, 12 Nov 2024 10:54:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEedbZ008402;
 Tue, 12 Nov 2024 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Dob0u/Pl1EKkQKbVk
 zTrWRb5nwjEXkabC04/F2m4dvU=; b=lqb8SaQ0qdD6OKii5DUzDiNNzuxNW5iPo
 oScbwrIYf8qoSnoSPAhgifz5EvQrXwTVQPGE9JzMyDxfqCV3jQzm8d8sDVr5Q1qh
 bbkUDsFnS4b23PMnxRtFY1/CEj0rm9sgl5iawbNOMXHPH36SCtrGCHrBCopdUWOK
 Z7tmJyLyE0eDzhAmwFog7gZHe9DV0eKh4wyDGaZIDFI1RIDYmAEH8PrAkaiyZ3/L
 0+7enEzwCEBzuEFKqIrRDq5XZZ79GJosvNOk2uwElVxUIrD8HiwjSCnK6dCJDv9j
 a5Hni7AuUdP6d/r46yNVdZ7ST76jJUwehnEL0+9JYpepLqH9/Q9dA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v8yv8css-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFDQNv010507;
 Tue, 12 Nov 2024 15:54:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s4jjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFscAT41091574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F1320040;
 Tue, 12 Nov 2024 15:54:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F8EA2004B;
 Tue, 12 Nov 2024 15:54:38 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:38 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 13/14] s390x/cpumodel: Add PLO-extension facility
Date: Tue, 12 Nov 2024 16:54:18 +0100
Message-ID: <20241112155420.42042-14-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mN2-FDyMNv26Jc2okv6OHNDCyfrLyi1B
X-Proofpoint-ORIG-GUID: mN2-FDyMNv26Jc2okv6OHNDCyfrLyi1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=613 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:37 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The PLO-extension facility introduces numerous locking related
subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 39 +++++++++++++++++++++++++++
 target/s390x/cpu_models.c           | 38 ++++++++++++++++++++++++++
 target/s390x/gen-features.c         | 41 +++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index fe7e1bd19c..e23e603a79 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -93,6 +93,7 @@ DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
 DEF_FEAT(MISC_INSTRUCTION_EXT4, "minste4", STFL, 84, "Miscellaneous-Instruction-Extensions Facility 4")
 DEF_FEAT(SIF, "sif", STFL, 85, "Sequential-instruction-fetching facility")
 DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
+DEF_FEAT(PLO_EXT, "plo-ext", STFL, 87, "PLO-extension facility")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
 DEF_FEAT(SIDE_EFFECT_ACCESS_ESOP2, "sea_esop2", STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2")
@@ -180,6 +181,44 @@ DEF_FEAT(PLO_CSTST, "plo-cstst", PLO, 20, "PLO Compare and swap and triple store
 DEF_FEAT(PLO_CSTSTG, "plo-cststg", PLO, 21, "PLO Compare and swap and triple store (64 bit in parameter list)")
 DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (64 bit in general registers)")
 DEF_FEAT(PLO_CSTSTX, "plo-cststx", PLO, 23, "PLO Compare and swap and triple store (128 bit in parameter list)")
+DEF_FEAT(PLO_CLO, "plo-clo", PLO, 24, "PLO Compare and load (256 bit in parameter list)")
+DEF_FEAT(PLO_CSO, "plo-cso", PLO, 25, "PLO Compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_DCSO, "plo-dcso", PLO, 26, "PLO Double compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_CSSTO, "plo-cssto", PLO, 27, "PLO Compare and swap and store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSDSTO, "plo-csdsto", PLO, 28, "PLO Compare and swap and double store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and trible store (256 bit in parameter list)")
+DEF_FEAT(PLO_TCS, "plo-tcs", PLO, 30, "Triple compare and swap (32 bit in parameter list)")
+DEF_FEAT(PLO_TCSG, "plo-tcsg", PLO, 31, "Triple compare and swap (64 bit in parameter list)")
+DEF_FEAT(PLO_TCSX, "plo-tcsx", PLO, 32, "Triple compare and swap (128 bit in parameter list)")
+DEF_FEAT(PLO_TCSO, "plo-tcso", PLO, 33, "Triple compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_QCS, "plo-qcs", PLO, 34, "Quadruple compare and swap (32 bit in parameter list)")
+DEF_FEAT(PLO_QCSG, "plo-qcsg", PLO, 35, "Quadruple compare and swap (64 bit in parameter list)")
+DEF_FEAT(PLO_QCSX, "plo-qcsx", PLO, 36, "Quadruple compare and swap (128 bit in parameter list)")
+DEF_FEAT(PLO_QCSO, "plo-qcso", PLO, 37, "Quadruple compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_LO, "plo-lo", PLO, 38, "Load (256 bit in parameter list)")
+DEF_FEAT(PLO_DLX, "plo-dlx", PLO, 39, "Double load (128 bit in parameter list)")
+DEF_FEAT(PLO_DLO, "plo-dlo", PLO, 40, "Double load (256 bit in parameter list)")
+DEF_FEAT(PLO_TL, "plo-tl", PLO, 41, "Triple load (32 bit in parameter list)")
+DEF_FEAT(PLO_TLG, "plo-tlg", PLO, 42, "Triple load (64 bit in parameter list)")
+DEF_FEAT(PLO_TLX, "plo-tlx", PLO, 43, "Triple load (128 bit in parameter list)")
+DEF_FEAT(PLO_TLO, "plo-tlo", PLO, 44, "Triple load (256 bit in parameter list)")
+DEF_FEAT(PLO_QL, "plo-ql", PLO, 45, "Quadruple load (32 bit in parameter list)")
+DEF_FEAT(PLO_QLG, "plo-qlg", PLO, 46, "Quadruple load (64 bit in parameter list)")
+DEF_FEAT(PLO_QLX, "plo-qlx", PLO, 47, "Quadruple load (128 bit in parameter list)")
+DEF_FEAT(PLO_QLO, "plo-qlo", PLO, 48, "Quadruple load (256 bit in parameter list)")
+DEF_FEAT(PLO_STO, "plo-sto", PLO, 49, "Store (256 bit in parameter list)")
+DEF_FEAT(PLO_DST, "plo-dst", PLO, 50, "Double store (32 bit in parameter list)")
+DEF_FEAT(PLO_DSTG, "plo-dstg", PLO, 51, "Double store (64 bit in parameter list)")
+DEF_FEAT(PLO_DSTX, "plo-dstx", PLO, 52, "Double store (128 bit in parameter list)")
+DEF_FEAT(PLO_DSTO, "plo-dsto", PLO, 53, "Double store (256 bit in parameter list)")
+DEF_FEAT(PLO_TST, "plo-tst", PLO, 54, "Triple store (32 bit in parameter list)")
+DEF_FEAT(PLO_TSTG, "plo-tstg", PLO, 55, "Triple store (64 bit in parameter list)")
+DEF_FEAT(PLO_TSTX, "plo-tstx", PLO, 56, "Triple store (128 bit in parameter list)")
+DEF_FEAT(PLO_TSTO, "plo-tsto", PLO, 57, "Triple store (256 bit in parameter list)")
+DEF_FEAT(PLO_QST, "plo-qst", PLO, 58, "Quadruple store (32 bit in parameter list)")
+DEF_FEAT(PLO_QSTG, "plo-qstg", PLO, 59, "Quadruple store (64 bit in parameter list)")
+DEF_FEAT(PLO_QSTX, "plo-qstx", PLO, 60, "Quadruple store (128 bit in parameter list)")
+DEF_FEAT(PLO_QSTO, "plo-qsto", PLO, 61, "Quadruple store (256 bit in parameter list)")
 
 /* Features exposed via the PTFF instruction. */
 DEF_FEAT(PTFF_QTO, "ptff-qto", PTFF, 1, "PTFF Query TOD Offset")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7fa1712d78..c169c080d1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -513,6 +513,44 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
         { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
         { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
+        { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6d00ffcda7..58c8708a72 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -46,6 +46,47 @@
     S390_FEAT_PLO_CSTSTGR, \
     S390_FEAT_PLO_CSTSTX
 
+#define S390_FEAT_GROUP_PLO_EXT \
+    S390_FEAT_PLO_EXT, \
+    S390_FEAT_PLO_CLO, \
+    S390_FEAT_PLO_CSO, \
+    S390_FEAT_PLO_DCSO, \
+    S390_FEAT_PLO_CSSTO, \
+    S390_FEAT_PLO_CSDSTO, \
+    S390_FEAT_PLO_CSTSTO, \
+    S390_FEAT_PLO_TCS, \
+    S390_FEAT_PLO_TCSG, \
+    S390_FEAT_PLO_TCSX, \
+    S390_FEAT_PLO_TCSO, \
+    S390_FEAT_PLO_QCS, \
+    S390_FEAT_PLO_QCSG, \
+    S390_FEAT_PLO_QCSX, \
+    S390_FEAT_PLO_QCSO, \
+    S390_FEAT_PLO_LO, \
+    S390_FEAT_PLO_DLX, \
+    S390_FEAT_PLO_DLO, \
+    S390_FEAT_PLO_TL, \
+    S390_FEAT_PLO_TLG, \
+    S390_FEAT_PLO_TLX, \
+    S390_FEAT_PLO_TLO, \
+    S390_FEAT_PLO_QL, \
+    S390_FEAT_PLO_QLG, \
+    S390_FEAT_PLO_QLX, \
+    S390_FEAT_PLO_QLO, \
+    S390_FEAT_PLO_STO, \
+    S390_FEAT_PLO_DST, \
+    S390_FEAT_PLO_DSTG, \
+    S390_FEAT_PLO_DSTX, \
+    S390_FEAT_PLO_DSTO, \
+    S390_FEAT_PLO_TST, \
+    S390_FEAT_PLO_TSTG, \
+    S390_FEAT_PLO_TSTX, \
+    S390_FEAT_PLO_TSTO, \
+    S390_FEAT_PLO_QST, \
+    S390_FEAT_PLO_QSTG, \
+    S390_FEAT_PLO_QSTX, \
+    S390_FEAT_PLO_QSTO
+
 #define S390_FEAT_GROUP_TOD_CLOCK_STEERING \
     S390_FEAT_TOD_CLOCK_STEERING, \
     S390_FEAT_PTFF_QTO, \
-- 
2.43.5


