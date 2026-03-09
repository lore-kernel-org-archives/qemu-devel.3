Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3CDEF36F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUux-0006Se-01; Mon, 09 Mar 2026 03:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuv-0006SJ-IJ; Mon, 09 Mar 2026 03:20:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzUuu-0006F7-0u; Mon, 09 Mar 2026 03:20:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628IBSIC1039643; Mon, 9 Mar 2026 07:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9In4IW
 yOETzf1NjxZzx8uGE/CodIaAPboOABe4mb3Sw=; b=r7a531vlXCvqs7eyM/7wLc
 nc9LlQ5E5bwNputVoNSCDMCxDpP+DNGA3yTdlx0YALBXYFjxDGhNhuyID6+oDo4N
 LocVU6TSWIvrWDfojQ3k9iIjRpvoZ1XSIW97E+S8fznemEAzFp3MHkyusY9oCrzC
 9UF8LPCl+jvIctz442qIRlmKLw75zc6dGDAj5VJhazthvDWQ3rKanC/59LSYjRq3
 Zpq533KqWcblf4PlgCznKmebTsakmRN7uyNcC0YrI6VYJ9dYAuxlnxX/H6d4VKCZ
 lvzuOSoit/G9OAJ/ai05hWvx3x57fyiwmdSFLJvQzAyRe4QfEiabT+XH613ymuRg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw5g4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6295Xfid025033;
 Mon, 9 Mar 2026 07:20:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjutgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 07:20:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6297KXjx61800758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 07:20:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 392A920043;
 Mon,  9 Mar 2026 07:20:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 521C12004B;
 Mon,  9 Mar 2026 07:20:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 07:20:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v4 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
Date: Mon,  9 Mar 2026 12:49:59 +0530
Message-ID: <20260309072001.3136261-11-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MyBTYWx0ZWRfXzMMH1LcQWQVv
 3uccpO9h5rptkdwtEqonCs318roUCC/WRDlkHYfxq/cGtCc6Ver5RMJp3y3cVZ77oHCiBtkkhC2
 UM/XLV9KETJY+MU76LeLE1lvihC674Ubw9CQidFtfBu03kHkrE+BMsWZWQ87fZM6URcy82FPREw
 nPWqWXEmvYapffClxV27ZeJiE+iV35Cb4WF15cekRCO1uaXTEcgzDhS2AbvQUscxURMRDgzRFYj
 x73pE1Bav+hdzOjwpRZBGNBJ/A5+6zXmg68Nr5JDwCdid61Iyu1mV1DAHkllfrV2uzkZyWUcP/W
 Sezl8qF6yFAiE2g2rhZtnlDpcwp3xP+TsH5p35shtZODBxDE6RU2iO7egcCuhbGYx7lKSJTtKXd
 1FLw+kfppRpkpJAhyKtsi34sgI0faUhw7ldR0ecXtODZkmF34miW5ZIiTG8d2Emf4zvilSqIyfS
 IUVEfwlg2nCACwDMjTg==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae74c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=xAhUsU6pBgj2HNqxJKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: enyUCWKUac0CtdnFJCrSiMvHCyRdT31_
X-Proofpoint-ORIG-GUID: _oILtjBnQIscyaxREI_YAS_Hd_qvAAxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Add maintainer and reviewer for MPIPL subsystem.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6730cee490cf..a013277ccb95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3302,6 +3302,14 @@ F: include/hw/ppc/spapr_fadump.h
 F: hw/ppc/spapr_fadump.c
 F: tests/functional/ppc64/test_fadump.py
 
+Memory-Preserving Initial Program Load (MPIPL) for PowerNV
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+S: Maintained
+F: include/hw/ppc/pnv_mpipl.h
+F: hw/ppc/pnv_mpipl.c
+F: tests/functional/ppc64/test_fadump.py
+
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.53.0


