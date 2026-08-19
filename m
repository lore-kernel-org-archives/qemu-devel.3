Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYV7-0005qu-Ui; Wed, 19 Aug 2026 01:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wwYV6-0005qL-0G; Wed, 19 Aug 2026 01:06:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wwYV2-0006Vi-Oc; Wed, 19 Aug 2026 01:06:07 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J31tD82111589; Wed, 19 Aug 2026 05:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=cdh+MICQoZRV4oiKKqmLNiq/AhNAzwPh5MOUH0x98
 nM=; b=fQgUbfvrm3d8QjZNonVSR2HHPvrFukD7YZrDdzxQBdh3NLD1BTVT8xTnv
 Cc/MzQJ8QIPqgm2MlIYpFx3yqponvT1LMdwWaZRGX6JmFZe0YUNDjcWhUk+obSuo
 C/NHzsaA/tH+dyy9qDVIUuwCLyaMi0BVvGD+UrKZUMiL1lr4GXZt+F5xVjYROSVk
 gFCfFQom4SRTEF4KJQ6JfxyJanzakzUC2yTlv7oog3bEeZkL8C7fqXPLyJtkWZ/E
 J6lP+c+maeCIuuqjpFV7yuELYtJ+AZNN2IJHzYgIOqtaePSiMDd9qVDykW+FmYeO
 DlA4AMJwvkcz40gD6sH+9X4wMS0Ig==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu41ka6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:05:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J4uTgp006988;
 Wed, 19 Aug 2026 05:05:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yex3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:05:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67J55pSh34406700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 05:05:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0360A2004F;
 Wed, 19 Aug 2026 05:05:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 263D220040;
 Wed, 19 Aug 2026 05:05:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.134])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 05:05:48 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for PPC KVM and sPAPR
Date: Wed, 19 Aug 2026 10:35:45 +0530
Message-ID: <20260819050545.21232-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzNSBTYWx0ZWRfX7t7DnU4mf+v2
 SFlco/eBvSq/xQ8iKDTI4gppT3R6UOX+5DH3YbtoAtRVZ4oszodkOMDUZiRJXZbrFFG03x35kMu
 fJUDABQCSyyw2j/MuIfLF7U+zZaIuZw=
X-Proofpoint-GUID: n06bGkXb4-jgoU9E87d0yHlyTtoItiqa
X-Proofpoint-ORIG-GUID: i2Wty4jK6WxBQlM9MhhmLgX2sETtC_Ft
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a8539b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=W9qbZ-6vY_ul-PSnLb8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzNSBTYWx0ZWRfX6JittJ2OuA3E
 f8sVfgxlABLn4pcz8ZCizl77D1C2i3nyf2nkGMJ9uejwqBiGaVY1nFcAxxdghFGtA9KuC9VBftK
 KaZ1pVaxB9BJA6q99mvJJz/DbBaIs2l6szK1bTJ+RbmEq+2HcOxPl7vPE9B1I9eoBIjXZCP6aFo
 owKdMVNmotsiaSC9tXYg5VDIcjAqD+tLcVNv8gb2yPbC+B03RXFW6kTLl5C5Bt2txjq2mvrSS6z
 BShp61++7qYyaxatiqZnyJLrMdYioPtaTshzV2qdw+xRd+3UqtxzJfClWrQfrtQijgyBA5T1FkK
 VzHcGrsO9GJ/C3nJhX7P2Omse+iwNUvq7cTLxgeJEeIs+rjIzJQtmojZ15LKK79xsb++6mja9Ad
 ofMrbRk99gdvqY70J9vOKBOnFrhoFaMPw0/J3j+LUP1TN/REJf1Q0AhMaPMSxLuyGx22XEfnS0o
 qgTrcmgDd4YZw9CBj/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190035
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

I have been contributing to PPC KVM and sPAPR (pseries) for some time now and
would like to get notified of incoming changes to help with code reviews.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e6022..1a1c77285d3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,6 +497,7 @@ F: tests/functional/aarch64/test_kvm.py
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
+R: Amit Machhiwal <amachhiw@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
 
@@ -1661,6 +1662,7 @@ F: tests/functional/ppc/test_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
+R: Amit Machhiwal <amachhiw@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/spapr*

base-commit: fa19879df1658f96ac07365fca8835b7decd6995
-- 
2.50.1 (Apple Git-155)


