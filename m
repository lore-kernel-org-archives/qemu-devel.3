Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F1D42BA2
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtJu-0004iX-6B; Tue, 12 Nov 2024 11:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE5-0001rb-Cu; Tue, 12 Nov 2024 10:54:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE3-00015E-Hq; Tue, 12 Nov 2024 10:54:45 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEex6F008433;
 Tue, 12 Nov 2024 15:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yzgRIKSYiACOMfjR1
 BomBdlBXTgsoVl9JPeOPFBw9Z0=; b=SWL6WPXQktpDweFS0Xnj7o1dwLMIDc3X4
 2cZA0NDXkSUAVerKgloCetaZlHfNnWBeS8GZ02VNRTfpvjBUr6U+esxbYMy/lDjJ
 +TbkvdE9DIzw5PbH7A83QFlPHaUBevH76moqpeRl/EywKZb+iea0t50nhGDAlZhk
 dVvy9kRGpL8C4PC/wongMr0nh3SLdu8ontBVqMTaFq1+Y3PBbpJ9r7wPr77/OEY7
 gqrlBxSLn7sJarJfdhhAK3do0sq3+5PJvYW6xgGiwPYM7JvGQdEkvXwvUKlbdQs1
 wJC8pW64dQb47dNo6oEsVB22sfYXO9rnYPcc/FG/pF0RmuxRN+lfQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9020cg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC7UUgY006616;
 Tue, 12 Nov 2024 15:54:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jcdhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsaBk59441456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A15B72004B;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 734342004E;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 06/14] s390x/cpumodel: add Concurrent-functions facility
 support
Date: Tue, 12 Nov 2024 16:54:11 +0100
Message-ID: <20241112155420.42042-7-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -fvPxNvV-c0WispoArnfjD0M_hiid0MN
X-Proofpoint-GUID: -fvPxNvV-c0WispoArnfjD0M_hiid0MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:15 -0500
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

The Concurrent-functions facility introduces the new instruction
Perform Functions with Concurrent Results (PFCR) with few subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 linux-headers/asm-s390/kvm.h        |  3 ++-
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  8 ++++++++
 target/s390x/cpu_models.c           |  5 +++++
 target/s390x/gen-features.c         | 13 +++++++++++++
 target/s390x/kvm/kvm.c              |  6 ++++++
 7 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 684c4e1205..ab5a6bce59 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -469,7 +469,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kdsa[16];		/* with MSA9 */
 	__u8 sortl[32];		/* with STFLE.150 */
 	__u8 dfltcc[32];	/* with STFLE.151 */
-	__u8 reserved[1728];
+	__u8 pfcr[16];		/* with STFLE.201 */
+	__u8 reserved[1712];
 };
 
 #define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 5a85d24bb8..6c16d4af40 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -93,6 +93,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_SORTL:
     case S390_FEAT_TYPE_DFLTCC:
+    case S390_FEAT_TYPE_PFCR:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -262,6 +263,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
+    FEAT_GROUP_INIT("ccf", CONCURRENT_FUNCTIONS, "Concurrent-functions facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 661a8cd6db..5635839d03 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -44,6 +44,7 @@ typedef enum {
     S390_FEAT_TYPE_SORTL,
     S390_FEAT_TYPE_DFLTCC,
     S390_FEAT_TYPE_UV_FEAT_GUEST,
+    S390_FEAT_TYPE_PFCR,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index f96cb5a7d8..09872ab3d8 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -116,6 +116,7 @@ DEF_FEAT(BEAR_ENH, "beareh", STFL, 193, "BEAR-enhancement facility")
 DEF_FEAT(RDP, "rdp", STFL, 194, "Reset-DAT-protection facility")
 DEF_FEAT(PAI, "pai", STFL, 196, "Processor-Activity-Instrumentation facility")
 DEF_FEAT(PAIE, "paie", STFL, 197, "Processor-Activity-Instrumentation extension-1")
+DEF_FEAT(CCF_BASE, "ccf-base", STFL, 201, "Concurrent-Functions facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
 DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility")
@@ -413,3 +414,10 @@ DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block"
 /* Features exposed via the UV-CALL instruction */
 DEF_FEAT(UV_FEAT_AP, "appv", UV_FEAT_GUEST, 4, "AP instructions installed for secure guests")
 DEF_FEAT(UV_FEAT_AP_INTR, "appvi", UV_FEAT_GUEST, 5, "AP instructions interruption support for secure guests")
+
+/* Features exposed via the PFCR instruction (concurrent-functions facility). */
+DEF_FEAT(PFCR_QAF, "pfcr-qaf", PFCR, 0, "PFCR Query-Available-Functions")
+DEF_FEAT(PFCR_CSDST, "pfcr-csdst", PFCR, 1, "PFCR Compare-and-Swap-and-Double-Store (32)")
+DEF_FEAT(PFCR_CSDSTG, "pfcr-csdstg", PFCR, 2, "PFCR Compare-and-Swap-and-Double-Store (64)")
+DEF_FEAT(PFCR_CSTST, "pfcr-cstst", PFCR, 3, "PFCR Compare-and-Swap-and-Triple-Store (32)")
+DEF_FEAT(PFCR_CSTSTG, "pfcr-cststg", PFCR, 4, "PFCR Compare-and-Swap-and-Triple-Store (64)")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a62a3c3771..117434b9a8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -504,6 +504,11 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
         { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
+        { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 302b653214..6d00ffcda7 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -308,6 +308,14 @@
     S390_FEAT_DEFLATE_XPND, \
     S390_FEAT_DEFLATE_F0
 
+#define S390_FEAT_GROUP_CONCURRENT_FUNCTIONS \
+    S390_FEAT_CCF_BASE, \
+    S390_FEAT_PFCR_QAF, \
+    S390_FEAT_PFCR_CSDST, \
+    S390_FEAT_PFCR_CSDSTG, \
+    S390_FEAT_PFCR_CSTST, \
+    S390_FEAT_PFCR_CSTSTG
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -398,6 +406,10 @@ static uint16_t group_DEFLATE_CONVERSION[] = {
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
 };
 
+static uint16_t group_CONCURRENT_FUNCTIONS[] = {
+    S390_FEAT_GROUP_CONCURRENT_FUNCTIONS,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -948,6 +960,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
+    FEAT_GROUP_INITIALIZER(CONCURRENT_FUNCTIONS),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 8ffe0159d8..dd0322c43a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2195,6 +2195,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
     }
+    if (test_bit(S390_FEAT_CCF_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_PFCR, prop.pfcr);
+    }
     return 0;
 }
 
@@ -2248,6 +2251,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
     }
+    if (test_bit(S390_FEAT_CCF_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_PFCR, prop.pfcr);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.43.5


