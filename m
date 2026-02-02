Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CABE7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvCv-0005FM-Nl; Mon, 02 Feb 2026 09:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vmvCt-0005El-3h; Mon, 02 Feb 2026 09:47:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vmvCr-0002or-C2; Mon, 02 Feb 2026 09:47:14 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611MidE9026786;
 Mon, 2 Feb 2026 14:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=nwAyPK9ljXUJeXhUzXfBbB2sQwsTRuQG3zHGfjaCJ
 OM=; b=FmHUSPrY4VbwBYd7wUUIoG3PtGqD+H0G+TuNOOz/B+7xacPs36gM6NoVJ
 4Oq+unhbKWV6OwlJjaJ6w/k73KPLOzsKr30W81gpc+h+WtRwtFYJpiASHdrUZEU0
 NzOMC9bCLDlpvLjIE4JTqwFeOvmQaZ4S7YbomFSRm1Doqq83H2pJZFFPWOAWjBGZ
 zHyn0lyns3AsevUMpZUca9ybrf8SO8hduq0d5+lqALR6DmEe+XXe8mSMjqXyCIoc
 nHGZWhW2ZP6lB4eKFomJ8S5ZLVCLQPnz3yhuWSfS1zZgxd0EbnY10IVePIKgIUP1
 r50+d1YZ52fJlimLrRqL5sI5Jbbog==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cvya07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:47:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612Dosd7009600;
 Mon, 2 Feb 2026 14:47:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vexwhb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 14:47:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612El3Gi61473028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 14:47:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 996202004B;
 Mon,  2 Feb 2026 14:47:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 899FE20043;
 Mon,  2 Feb 2026 14:47:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  2 Feb 2026 14:47:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 61043E0B7E; Mon, 02 Feb 2026 15:47:03 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Replace backup for s390 PCI
Date: Mon,  2 Feb 2026 15:47:02 +0100
Message-ID: <20260202144702.1783102-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwOSBTYWx0ZWRfX57SFWq9R/f/l
 U90iEgYDSdj5AKRiCZIT6eAMJkVWutLFTQpMRy0x8ihQpFp8+8znk4ZnrIqBHtEnsEHaqZxhrW7
 IwO4zkUJmq+lWAjqdkC7q1cCsQ4olcn/D/woJ3OaXVBx0qGrXQzFsgMlKGe/ZwfWR+Nm089vqOf
 8/hv3ctWoBQ0qNw6HWtTUe3do3BNqlM0rtqZio21+tTnU16lpvPYZGwzFCSlVUNkGp3uuNjQ6x0
 dky524xuEgm0RX6JKwL9K0SU3GHCuKZcTH/TyMvoZLjxx9I9BO4sAEv+OOh4krSCyXhvV2SCHQ4
 UkqLJ51S7FG2SIQh7QiCu1ZiWPjHfX6yCxpfFG61ToB9Y5j24MX8gqOAUgM6a/skiazyaQtxq7/
 keg5MJ+hnwYL0LR6xthIVfS8gk+i63d5NjE2GzLIhypqM23/lJ6OPdv6xyFvkNJyPV0Zst4pfzj
 dfgVVKEwzSkUQEcy+FQ==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=6980b8ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=oNv3vKmlw4bC7Cr8AvsA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: iklZMmmLYQWKJykbccjnSSenepcRDjbo
X-Proofpoint-GUID: iklZMmmLYQWKJykbccjnSSenepcRDjbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Farhan has been doing a masterful job coming on in the
s390 PCI space, and my own attention has been lacking.
Let's make MAINTAINERS reflect reality.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b7ed4fccb..32d60dd673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1862,7 +1862,8 @@ L: qemu-s390x@nongnu.org
 
 S390 PCI
 M: Matthew Rosato <mjrosato@linux.ibm.com>
-M: Eric Farman <farman@linux.ibm.com>
+M: Farhan Ali <alifm@linux.ibm.com>
+R: Eric Farman <farman@linux.ibm.com>
 S: Supported
 F: hw/s390x/s390-pci*
 F: include/hw/s390x/s390-pci*
-- 
2.51.0


