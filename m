Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161A7D42BA2
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtK6-0005Jf-Dr; Tue, 12 Nov 2024 11:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE6-0001s2-Ot; Tue, 12 Nov 2024 10:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE3-000150-HH; Tue, 12 Nov 2024 10:54:46 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACF9whi032516;
 Tue, 12 Nov 2024 15:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KdgS5eNrcn2BHz4mP
 jCET3kB1UBPqrW7f2jvmW0hmNA=; b=TqycHpJhj0+AjPcaE6gUKEQlfKzc6MBIK
 vOgZHpFimLGzHYyYVxqJMoHjpJJ3zs4JzK1ttLhlZHrhLTqeem9CIL+We67AVuGm
 kAC3hPyRv9uEB/SJpBG19LvtUOh9oyFKzkD2gtURM8rbtKME+EcxcMSDUgqzX+IX
 WXGqIBoiHZ+gGRAOq8KdEJ+RsTlDw1/tqHeB8xiKDb3o9W8h+CTj8opcckJ3oXAJ
 dYWxT1PikKq4L/oQayR0C62TMWlVyw0nSWV/KS5ofmpL2AI6q5WitVWIX0pS0MtZ
 SOmTlY7gGPLvng0ycKaXBoT1kHQD5eYPSR8Do3hdBVORYxU9e8S7w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9dv06tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC7B4R5006674;
 Tue, 12 Nov 2024 15:54:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jcdhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsZxO62980360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C542620040;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9735F2004B;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 03/14] s390x/cpumodel: add msa12 changes
Date: Tue, 12 Nov 2024 16:54:08 +0100
Message-ID: <20241112155420.42042-4-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jC7V_BfDJPBS5OyM_0JMFm3ljmdM6uXF
X-Proofpoint-ORIG-GUID: jC7V_BfDJPBS5OyM_0JMFm3ljmdM6uXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=781 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120125
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

MSA12 changes the KIMD/KLMD instruction format for SHA3/SHAKE.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/gen-features.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 15ea51fc54..2e5dc96984 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -90,6 +90,7 @@ DEF_FEAT(EDAT_2, "edat2", STFL, 78, "Enhanced-DAT facility 2")
 DEF_FEAT(DFP_PACKED_CONVERSION, "dfppc", STFL, 80, "Decimal-floating-point packed-conversion facility")
 DEF_FEAT(PPA15, "ppa15", STFL, 81, "PPA15 is installed")
 DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
+DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
 DEF_FEAT(SIDE_EFFECT_ACCESS_ESOP2, "sea_esop2", STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index d6305f945a..ab9ad51d5e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -270,6 +270,9 @@
     S390_FEAT_PCKMO_HMAC_512, \
     S390_FEAT_PCKMO_HMAC_1024
 
+#define S390_FEAT_GROUP_MSA_EXT_12 \
+    S390_FEAT_MSA_EXT_12
+
 #define S390_FEAT_GROUP_ENH_SORT \
     S390_FEAT_ESORT_BASE, \
     S390_FEAT_SORTL_SFLR, \
@@ -339,6 +342,10 @@ static uint16_t group_MSA_EXT_11[] = {
     S390_FEAT_GROUP_MSA_EXT_11,
 };
 
+static uint16_t group_MSA_EXT_12[] = {
+    S390_FEAT_GROUP_MSA_EXT_12,
+};
+
 static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
@@ -902,6 +909,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_10_PCKMO),
     FEAT_GROUP_INITIALIZER(MSA_EXT_11),
     FEAT_GROUP_INITIALIZER(MSA_EXT_11_PCKMO),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_12),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
-- 
2.43.5


