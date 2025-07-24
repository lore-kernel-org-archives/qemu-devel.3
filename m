Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626A1C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepaG-0004Cx-Aw; Thu, 24 Jul 2025 02:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZV-0003wm-7B; Thu, 24 Jul 2025 02:36:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZQ-0007OR-8q; Thu, 24 Jul 2025 02:36:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NIGHs1028685;
 Thu, 24 Jul 2025 06:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jUwINT
 aO51Drd4LUsxBQ2jnMSk5i0U7NBoq747uf/MA=; b=TWTptAk3O4qJv/mi2LCcs3
 HS6Zx5vdBnZMY/iORyF3qRi6JMeJUHFfAq4UAaiCNs9DYutV7Kqvh17g0k1UmIB4
 Lpcj+cRHy+zmPUXZ/NVF+ZQUgqXQzhY5OMgOCAQ8oiLlztw9EyIiHVR94JBGQZ16
 sIi6GSaZT63RyrqDdpr9aAVKmfP/ZE0wGqchCnOsQhS+0Bg2YUE2kx9yNnz3MsLC
 TUPCgTdhoRFGLUmdh3naOWZVxfqRw7zgCsWW5Y86Bvm991inFL2ENR+66qaYYIda
 pHqxzlILaFM09FAHbBWuYNUKxvyk3l4A1V7FVqXfVUpSXaJ9Mcn1U3csWBfPi30g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyqrgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O6WDHT030564;
 Thu, 24 Jul 2025 06:36:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyqrgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O46dHZ024744;
 Thu, 24 Jul 2025 06:36:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2k075-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O6afxv19333510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 06:36:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07A8A2004B;
 Thu, 24 Jul 2025 06:36:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28CDF20040;
 Thu, 24 Jul 2025 06:36:39 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 06:36:38 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
Subject: [PATCH 3/5] MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
Date: Thu, 24 Jul 2025 12:06:08 +0530
Message-ID: <20250724063623.3038984-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724063623.3038984-1-harshpb@linux.ibm.com>
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SFjD7lgvY_t1xad-5zkIjrh7QmTIvub3
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6881d47e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=DuJFUVMG8awct7Q4CXcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 1wLx0U8LMcwuBCtUQEmBqkMRX7Zqs3N7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MCBTYWx0ZWRfX16kBAGQY5ljM
 ELGl7U0LnG5pfmZ7XX2X+CLITVlwn6yRqZR/I5WUODvsYtLswFsYNQ2V93slCe8iy8NqUgn4MXh
 ikrhAZiSaMDr+Iel83gDqY4uHNZgaF2FmFDOJudOVNzUXs17HjmY09GCfG9yik7MxhR2vVb3l4o
 kQBBK6L48exi8ei7qKuSXUxO/RU3wlAmcMAag2oivLZxNpMvrGwhzzGqBBdUePwankuyeGAFAac
 isvzAPmwQjQJMtvaKvvoK56rVQEFVMZeY7wKg5DAjubs/Bvw4vbVQAFuWl35Gn+5bqxqU/b6v/1
 9nTkzJdZf3JgwNdTlpwBdjsxyfG6vV+G4dAHAx8jMtQhTz4QmW1OLCIt1/Q9zNfqYL5itQLLvEo
 nfla9pbyGyC8hhBIflFNMX1Xt4Hs/Sj7ce+S0w2HvG5OioiZrgbkkxvOE53RszRR8IGUOivx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240040
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

From: Chinmay Rath <rathc@linux.ibm.com>

I have been working on Power ISA for a long time now and have mostly
contributed in TCG instruction translation area (moved 300+ instructions to
decodetree as of yet) and would like to continue contributing to PPC TCG in
best possible ways I can. I think it's time to step up and assist in reviewing
related patches to enable myself contribute more effectively in this direction.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e95ef00c1..31bcb82e93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,6 +296,7 @@ F: tests/tcg/openrisc/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Daniel Henrique Barboza <danielhb413@gmail.com>
+R: Chinmay Rath <rathc@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
-- 
2.43.5


