Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1EFC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepaJ-0004Jn-I8; Thu, 24 Jul 2025 02:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZW-0003xM-O1; Thu, 24 Jul 2025 02:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZU-0007Ot-3z; Thu, 24 Jul 2025 02:36:54 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O2IePY013612;
 Thu, 24 Jul 2025 06:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ensLu7
 M7uUO8B7Mnd5GJYYhzKSXqz/fTxMf5mKkUrwY=; b=h9D0dM8XocoDWHotJKpr6L
 X+j8MWCEgm7VoXmOSVWxFeH5f6PrDEUzsStFgffTjCouYrFUTdK3kJ5vefvceFmd
 8vq4fHJnB14t3e33WjWj+NL/FPMOPmVGD4tW7cMQwSYMJin23uj7b2KT38wc/8iL
 a2qypV1iKzEP9x7Xn2Br/W/v6KJgthyoN98Oo94zzIsoLL2VAwt6h+wn7Y6aevvh
 c2co6i56hfjeLl05V9H99ucqxJoKm0vMn7bef3QbXtprg6h+AM8zyLOulnzzHF/T
 F0c76xBzoNpX/GDWKrdbpnzxgNouAmzSgGnS+0wNCz80H0++mrCd9QSuitULYKeA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqh0er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O6aZGx006984;
 Thu, 24 Jul 2025 06:36:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqh0en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O29Gk4012827;
 Thu, 24 Jul 2025 06:36:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p30bcp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O6ahbS53084474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 06:36:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 391632004B;
 Thu, 24 Jul 2025 06:36:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56FAA20040;
 Thu, 24 Jul 2025 06:36:41 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 06:36:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
Subject: [PATCH 4/5] MAINTAINERS: Add myself as a reviewer of PowerNV emulation
Date: Thu, 24 Jul 2025 12:06:09 +0530
Message-ID: <20250724063623.3038984-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724063623.3038984-1-harshpb@linux.ibm.com>
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MCBTYWx0ZWRfXxVp4ZRsrl11z
 XBQ1lTrAXcSdE6acRfHz4qtZvx6IjzrTb4zLOOPPuAPQZ8gGrAL0XWRZDBFtY7M49ZddP9QQek9
 RFVwsQsx8yHv+kjcnR8l6GJaHw2L+0HRk+LsD3rlp8RGK3UrhJMpBpb34mm8Q0zrWJxDuFkyTwC
 0lVkhixEGyB+kMGHg6gK+hYEh7g84F+g4LZE6b3yoBjXPelOMEzs51Q8/xFPpNmfVP4iha47Rzb
 xJqv+cUy/3ppixXhokCfR8OZlLE+8MsXZjK1UyUoexHeQLYzXaPM9Rfh2ZY41IkE46lmBsVj80+
 d0NEHVIewCMqnBn6q0lRAauBh5WclyiShRoMrDP9ATNPkqVIUTqfY/u9Vb/UcCqm356Tn1tW8Cf
 R4u/sFt31QehIVXc07WUps6Ha95fMJcDN33pvzFfGkS4eJaeXNDxFR4yoOfdeUWBV2/UzU+j
X-Proofpoint-ORIG-GUID: 8jVa4QezpM9WqHQRHR1D1Sy9pXP3-4m-
X-Proofpoint-GUID: Ocrb00JyNvacayqhHYlWu8w7yV8swI7D
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=6881d480 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=vuDgblk52OjkwLTa9dgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Proposing myself as a reviewer in the PowerNV emulation in QEMU

Have been working on PowerNV QEMU for sometime, with contributions in
Power11, MPIPL and minor fixes and things such as dtb support

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31bcb82e93..1ba161d75b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1579,6 +1579,7 @@ F: tests/functional/test_ppc64_tuxrun.py
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
+R: Aditya Gupta <adityag@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
-- 
2.43.5


