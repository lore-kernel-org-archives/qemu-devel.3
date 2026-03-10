Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A11EB105A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxxo-0006Ik-1S; Tue, 10 Mar 2026 10:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzxxl-0006Ho-Cy; Tue, 10 Mar 2026 10:21:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzxxj-0008M9-Be; Tue, 10 Mar 2026 10:21:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A7UNJL1200596; Tue, 10 Mar 2026 14:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=M1kpYcBBOzSa1HI0ADnN6S7ADmGCiWr/HA3ISTd4+
 aQ=; b=NH/ysRKvni4bYkAYrbPeYBKaM8rj5+eUFotKNzGBWfow+UqVM5XnwvgfH
 F6yK9fd1qci9wO37QJB3/zSlHcOSQyBwxLrJInJ9NKlaA5R5EWTJ3oddYYKngBYM
 FyQMANY5nRR7Z2rycOEYIRw4wDV2MNwQszX2Kib01pt+QOthz9TXvgl8VMGZr3Gg
 AHBc75G5AqydX10CvHEpXhnUOzdWI7kj4dnjwrS3pK0c4TFJyf0qQZs/hPAYTIrU
 QE9yfN+aOZ8OaXW8ONtJYK+Ubd2mIdRMZPsmOSJyuUkIqFoSu0mKqfUItLksYgis
 ajY5QhspecVXARAgJiX8iNHYSVUMQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywb859-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:21:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AD0JCd015771;
 Tue, 10 Mar 2026 14:21:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs12215pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:21:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AELQ6Q24904246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 14:21:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03F2058062;
 Tue, 10 Mar 2026 14:21:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C6158052;
 Tue, 10 Mar 2026 14:21:25 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.79.36])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 14:21:25 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 borntraeger@linux.ibm.com
Cc: mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH] MAINTAINERS: Update S390-ccw boot maintainers/reviewers
Date: Tue, 10 Mar 2026 10:21:18 -0400
Message-ID: <20260310142118.1120291-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMiBTYWx0ZWRfX3FsD64mwfZ3s
 YoZZiv/GxNRwgo1Ut2ntgcCfvS5u/Pkeqb2J1jclUQNeVxk3VGNDyJo1btJ3yN0fAE4/B5DbPYE
 FcmSrJJAns4+k3ZIP4/zExipeO/QSZtDhK5uhePJetg5h7wphtExQgod1rcIMr+zvpcznzKGCk6
 03xz3UWOGjweTPrRzv4YdLvCZfVRUqf0WrFLF4whj9EAKUVlLimQ7egiKAOCTIY2/GjoMyuO/Io
 y2DwX4aDriYHysdl5C8B5O/vCoGI+Lk1A9GiurcqJUCw1h8DkwlHhO2KMta9L2YnlyrckJeYvps
 n3SN9cVRE8vmlnkoYi3Om887vFnAmzXLwF06dVBFb0zvDTZGkcjgLd3shmIgMb0xDqKvMWWcwso
 3cIqpKq70wgM1Ola+CzfT3AUuP76wNiDHgB78mGF8nf7p8r3vbY/40XtJrJoqLxqhS8cUZ60vRu
 xTpCmlYqW5BYqx2MTgw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b028e7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=20KFwNOVAAAA:8 a=4VVcHpUFlTeZ-k0x__MA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: w18uur4QVE8gJp8eVb327IFZiBsSL7YI
X-Proofpoint-ORIG-GUID: w18uur4QVE8gJp8eVb327IFZiBsSL7YI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Christian Borntraeger is no longer active in this space.  Promote myself to
maintainer and demote Christian to reviewer.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80e10e43b5..1012135dd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1862,10 +1862,10 @@ T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 S390-ccw boot
-M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
-R: Jared Rossi <jrossi@linux.ibm.com>
+M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
+R: Christian Borntraeger <borntraeger@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
-- 
2.52.0


