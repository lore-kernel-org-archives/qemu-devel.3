Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DAACD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL0w7-0001t0-JE; Thu, 07 May 2026 11:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wL0vg-0001rR-Fb; Thu, 07 May 2026 11:46:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wL0ve-00024y-RL; Thu, 07 May 2026 11:46:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477lY3A2492757; Thu, 7 May 2026 15:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vlKlXDx9UoYVlv82m958jQUZGk+y21EV3O3Gwf46n
 lk=; b=UzOQ52MegjOfX4qk3+WgjyRI0HBkYy2ThnWMx5UYgwFcwrzgW9fM1EGPg
 gMnraRjtekBeDY3v6Wochf663dyfQr2q17+fXAagKI8EFVfx578CyIYASLXNrSW/
 JolAGPFQMhRuH38V73hcV33d+dSoBnpB0R8JczB0G9RXrdR2iKfHshp1GmSZmwb1
 br1+0PVCtYq0F4K8ca1n02DJd7C8wbMjYfvo5vMbUuHsNTDlD3UUDsh8HYTgbXK8
 UDmXfznAcDiHxpszTEcKywQ1+Wc6fy4hNa7sFczP31w7+suDwu8ewxPMIh9A6Ten
 R+Vebw4lb71vyz2ltKxB5iozjrURg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6pdeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 15:46:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647FdUsP022987;
 Thu, 7 May 2026 15:46:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk49w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 15:46:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 647FkEqC4522730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 15:46:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E291658056;
 Thu,  7 May 2026 15:46:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 727C15803F;
 Thu,  7 May 2026 15:46:14 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 15:46:14 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Markus Armbruster" <armbru@redhat.com>,
 "Caleb Schlossin" <calebs@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Add self as maintainer for XIVE
Date: Thu,  7 May 2026 10:45:20 -0500
Message-ID: <20260507154530.364296-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fcb3c8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rsca2mb1Y4WhbDFA_AAA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: ylCCsZY03MnZ_cETrRvFIyy72MLKUp5M
X-Proofpoint-GUID: ylCCsZY03MnZ_cETrRvFIyy72MLKUp5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NiBTYWx0ZWRfX5kCR9AnG7xMx
 B1bmHyl9VhEzSnaRQFj5a1UH5JLwtUpeMUgu5vUZYs7YSEM0/fUasRLCDIysmss9Y98geRAAfMS
 rdTlPNYutodoZS88DIE7pw3O69oX0gz6gXZ/ECJk0NtqtOm0vsthrbyyIyqtiVx3zpKY/XHSDYy
 VEwRrTOy9ENG9l3YZn8HZ8N00CQL3Q1Yq9bzdMMdwih9V+9thaHvNQTk034q3b3k7jaGrU/CGOb
 KBGUpx17fIF2XjMntsjn1bWL4OfTRTiz5in6jKY1WIZq6sr3vyS89lc6z/4xET/QtdtKt+87jES
 yLKdmRunjCzMA+sZNPJljOOKDOfqziBcZkdF+rsjB6rv1ExSNV9areR1cfnjlHlYPbuXQrkjVL6
 EK64sZcZM+xjtCC9J4exJ5viHEwyJhEIhtNlMmJZmAPJFa91Pb1moapc+uVFVD17DFyuO+31q4e
 70XgcLpayS+UZW6W+hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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

Adding self as maintainer for XIVE

Signed-off-by: Glenn Miles (milesg@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..37fb460a2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2877,8 +2877,8 @@ F: tests/qtest/libqos/fw_cfg.c
 F: tests/qtest/fw_cfg-test.c
 
 XIVE
+M: Glenn Miles <milesg@linux.ibm.com>
 R: Gautam Menghani <gautam@linux.ibm.com>
-R: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/*xive*
-- 
2.43.7


