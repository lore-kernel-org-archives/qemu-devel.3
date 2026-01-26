Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA557D13C13
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 13:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkN47-0002RG-5L; Mon, 26 Jan 2026 08:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3r-0002IH-T2; Mon, 26 Jan 2026 08:55:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vkN3q-0004qU-Bs; Mon, 26 Jan 2026 08:55:23 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PLTdNC019338;
 Mon, 26 Jan 2026 13:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vkiNVGvCd/GvJ7o833dKTqIjZbIJlQXyGY+AWR72z
 to=; b=H8KJ9/uYAvmmTG/I+Cu8q1TLMkEWNDEF6wjsYQYXRERjA0iV4/kMP4Sux
 +Bi28hkg7BK8Rq0Yt3DpeIW9fOv8YqPfP7XDrGkOrGpBQHw5Vo+l8kR38AxWNU6s
 nXhvnyaRZB6t3ZJkeNMeZrTO1BBLjh8lCH//G8c0zgCEbc1MlTkXx2aGswncTZvL
 BkW8fOG0gMafm6nIdRlldrf9jt1lP1L5wh81EBJMKC9ItuIw4s5JqVaLvX6aIqj8
 g/Lox3fTrzTShyqKR+MBO4PrShd7BG7U9FczoKkgqzqYeqDkhTAOom4sgPexqD2F
 ntEgw6ODR/hcK6+LpXp20hTjA+5Ow==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfq451-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QDq19T019823;
 Mon, 26 Jan 2026 13:55:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfq44y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QBA6W2006725;
 Mon, 26 Jan 2026 13:55:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy4v38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 13:55:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QDtEPB29360666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 13:55:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAEBA58055;
 Mon, 26 Jan 2026 13:55:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3912558043;
 Mon, 26 Jan 2026 13:55:14 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jan 2026 13:55:14 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 0/3] Power10 PowerVM bringup fixes
Date: Mon, 26 Jan 2026 07:55:04 -0600
Message-ID: <20260126135507.771552-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=69777245 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=dDllZO3bd90xPMzrtHEA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 6lXlO2XVF6iRr9FqfHdkOOQl-cjtyA5r
X-Proofpoint-ORIG-GUID: hMzYp3FOpnDDvabQQsA_IVZ3w2q4mEZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNyBTYWx0ZWRfX15YAMY+mgFpo
 OVkLnq3tqUpPDfeEPgCBPR9gRb90UkK/TymXCKRbITyzHvQv+8IQVjdjcLqBEFWREUzSJWLoagj
 gse8KERw7cafRl1YeYbVfAbspo6fgqySbqMgr0QDmdCAlzxG3aNF0p2br1uu8YALussp0tAy+CQ
 C8KXVsSB4LoNiGpq3d3j8Ux9wN1tG8V6txwqq6OvPCS5v4R7EfWNRK5wDvouFcHRvG7s03M8Ajq
 j9Wr8gaY3EkxXZLXVVv/2fkHRiwnQ6Fk3BOkW8Y7eTuowAMG9fiFHg2V/tSh/uV/R/pE0CN1eOj
 +EVyla4jiy+9ilzJn1MMqEZtcVoZxpTielk9D8Xd2thMf30Ay6Cs6e83RioaM3NQNdx3P2fvEPx
 y8m1TePVypMFEvKjxdaGKN8Sd9u/dmkpfmmLnmWaE4tLDmX8uYNyYrzlOMYkBkRohvE9BzuTKL/
 wpnqM1icknefAgJhBuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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

Updates in V2:
- Removed pnv_chiptod patch, per review comments
- Spelling cleanup in pnv_occ.c

Tested:
passed make check

Glenn Miles (1):
  ppc/pnv: Support for SECURITY_SWITCH XSCOM register access

Chalapathi V (2):
  ppc/pnv: Add unimplemented quad and core regs
  ppc/pnv: Add OCC FLAG registers

 hw/ppc/pnv_core.c        | 81 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++--
 hw/ppc/pnv_xscom.c       |  2 +
 include/hw/ppc/pnv_occ.h |  4 ++
 4 files changed, 139 insertions(+), 3 deletions(-)

-- 
2.47.3


