Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4268EE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 12:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKzj7-0004m1-Dr; Tue, 10 Dec 2024 07:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKziK-0004gb-Vy; Tue, 10 Dec 2024 07:51:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tKziH-0005dr-G0; Tue, 10 Dec 2024 07:51:44 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA81hDZ002915;
 Tue, 10 Dec 2024 12:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JTMMSgfsN/pQB2OoJ
 QGS2jo2oheEO0dCjdVjwSfr6OE=; b=eJ/bdF7Mdd/t61EHKAlTVQQPMz5tka4y6
 UUfVJiu7TReBKxxpUFXXBcIilFmZYJ2/9oZFIDQoT+dVO1gnSyo9j8lWLxa6hTpt
 2TNpWwReWQZm7pA236yHfqkIo4bbrAnbKFetunjqarL2ihfk5CB+cST/Ue18o0NY
 HcP0fa3tFZZLD8oVcvdbwCJE2xBWWIFAspmL15MRy2vqu1NY78tamM3q/YFbC+fv
 P2Q1efwSxj5fVwT8uehI1hMlw1s78V4zzqvW3M5MVlRZ2yom7SDpTbgFi65c7Bq9
 vIuc8VMOUJELVJCQSvaI/Dd5WBHDldlp4Cu9521lzsZxXVRK6OfDQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xdysh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 12:51:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA8bORX023039;
 Tue, 10 Dec 2024 12:51:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjubng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 12:51:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BACpYrt61407554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 12:51:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D92432004B;
 Tue, 10 Dec 2024 12:51:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7504020043;
 Tue, 10 Dec 2024 12:51:34 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.9.236])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 12:51:34 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH] s390x/cpumodel: add MSA 12 consistency checks
Date: Tue, 10 Dec 2024 13:51:28 +0100
Message-ID: <20241210125128.38231-1-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <07b6501d-f342-444c-bb9e-45e314c750ed@linux.ibm.com>
References: <07b6501d-f342-444c-bb9e-45e314c750ed@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NW5wiqfd81l2Y0yRG7-MaUUIHHMExJlj
X-Proofpoint-ORIG-GUID: NW5wiqfd81l2Y0yRG7-MaUUIHHMExJlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=779
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100093
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The MSA 12 facility depends on MSA 6 for which only its
subfunctions are defined as features.  Hence, require all
MSA 6 subfunctions as pre-requisite for MSA 12.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_models.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index beb50b5300..a95e54fa8c 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -553,6 +553,18 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
         { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHA3_224 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHA3_256 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHA3_384 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHA3_512 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHAKE_128 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KIMD_SHAKE_256 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHA3_224 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHA3_256 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHA3_384 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHA3_512 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHAKE_128 },
+        { S390_FEAT_MSA_EXT_12, S390_FEAT_KLMD_SHAKE_256 },
     };
     int i;
 
-- 
2.43.5


