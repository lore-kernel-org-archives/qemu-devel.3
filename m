Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E3FE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSI-00071k-IO; Fri, 06 Dec 2024 07:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-0005xs-W0; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRJ-00042s-Uk; Fri, 06 Dec 2024 07:28:14 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5NCkIM010817;
 Fri, 6 Dec 2024 12:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8jNTm0c1qb3GZd7bU
 9ThteI47tV1tTiM/Pjr2z/YAUI=; b=g/JpVFJytCcRGFAenaR4srLKqcVPg3NK9
 ZCMdiaWO4sgDTPgZoS2m2u8gxFj0mM//S0ipwqQHDZmrMrZhhoWLD9+GB+ikD3fl
 arvh7Jjb/q5F/LfJPJc0+8WOllneS/xDFCAqiSebPEf2HiapkcmmJHVExLOCjPsh
 dSZ80mS9h8njrvXeB/EICcX2wAREEbP6JwKjtyftpkf0cTWw3wST/u4q4sBfnjlc
 M2lsTSxucSFOriTwp4htr+0VWbO2GcIAHReXoW3xwzkufZskQCSjDrLfy6R8aepD
 gW6VZFgy1nmb21UNV+a9BaVcl5MumcDGd2yI8EKvX24XGTZOVmEGQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rgxfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6CRYAT019957;
 Fri, 6 Dec 2024 12:28:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1spns8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS3tI22938132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B05B20043;
 Fri,  6 Dec 2024 12:28:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B46520040;
 Fri,  6 Dec 2024 12:28:03 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:03 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 10/15] s390x/cpumodel: add
 Vector-Packed-Decimal-Enhancement facility 3
Date: Fri,  6 Dec 2024 13:27:46 +0100
Message-ID: <20241206122751.189721-11-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T7arPtXlbrLhyLm2LiHIefo344O9hAmx
X-Proofpoint-ORIG-GUID: T7arPtXlbrLhyLm2LiHIefo344O9hAmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=802 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This facility introduces new capabilities for the signed-pack-decimal
format.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_models.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 8be2e0e46d..df154d145f 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -118,6 +118,7 @@ DEF_FEAT(RDP, "rdp", STFL, 194, "Reset-DAT-protection facility")
 DEF_FEAT(PAI, "pai", STFL, 196, "Processor-Activity-Instrumentation facility")
 DEF_FEAT(PAIE, "paie", STFL, 197, "Processor-Activity-Instrumentation extension-1")
 DEF_FEAT(VECTOR_ENH3, "vxeh3", STFL, 198, "Vector Enhancements facility 3")
+DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH3, "vxpdeh3", STFL, 199, "Vector-Packed-Decimal-Enhancement facility 3")
 DEF_FEAT(CCF_BASE, "ccf-base", STFL, 201, "Concurrent-Functions facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 5d548de79c..6a7ce77d9a 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -457,6 +457,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
         { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
         { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
+        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
         { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
         { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
         { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
-- 
2.43.5


