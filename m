Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808D1C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kZ-0002Yn-50; Sun, 23 Aug 2026 03:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kV-0002Wl-3i
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kS-0005ps-5J
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N720ip2538450
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G6NgKS
 AgedLyjqfYuugwsQmywhsyTIMuPo2XWUyOyY4=; b=fNYIh68Z4shEZcU1Sjn9bt
 tRdAQ5Q53G8PSNZIGe8E40m4CEvOnYI8mc9tNexcVUvpZZnO5nqVZ6VqmN3AnyQ/
 xtueXfFcELyh9kY64nxxD7cnoporgE0vwNEyBWw4xhU7xGN8c6kEuZtat8DUT35e
 fUTSUMFrr/ei+3LXQhIeXnl0oGx9iaGemUEfy5/0tPO0D8C1t6Fm4Q64THOwG2Nb
 AJvgqRIhYdePs4/ev0UpXYRc4aVxwDvUyJMy9s8qtu6GnQbjUcdGR4xxeM+OzLnm
 MBmknyGfDH1C8bnyAxCO+ZOCGUpsiOxidcxFVQa5Mf95+gPEVSelCnLd1T0TG/Ew
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwuxwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QdHA010527
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxrhkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7a2eC39649652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 07:36:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A9D52004B;
 Sun, 23 Aug 2026 07:36:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1741520040;
 Sun, 23 Aug 2026 07:36:00 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 07:35:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Subject: [PULL 6/7] MAINTAINERS: add dedicated PowerPC RAS section
Date: Sun, 23 Aug 2026 13:05:32 +0530
Message-ID: <20260823073536.40282-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX2N0AKn/MyR6L
 PWRZbIVc2Ggg0q6jgN8M0h3u63bHxcjBl2Nmeidh49/bw1PwZ6bk1g9PEJTeKePdQlMDiHLoZVM
 rg1KtQfw63TdvBTZBGRxl2j4OHTyvEY=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8aa2e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8
 a=S56xvJB5AAAA:8 a=rEi7gjlmwzq3UfRUHTgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: yvFOD-yjoGLAwdaRwOrsULhYl4QFncZf
X-Proofpoint-GUID: yvFOD-yjoGLAwdaRwOrsULhYl4QFncZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX1TEAlt98WPqq
 IMPxRiH88t/3maIoNg3xUb/8sCvCCGsdFQdGMDt+xoy64sX8WT13vW3Atn7zRl0bE1AFpomHqyQ
 O7YRL8xWGfkpcb9G7WtWgGZiaLJpNj2A2poUeiNc4kQ9+gtTsh78y0pC6DNkooDVNCV54fosKqA
 nEaVqdhOP+T3BSZHL4f5TWLHDm5Rh3sAIIISPFAQxz7cbqQ6Ie5cywDbIeJ2Ge8Q6IHWSt/WAPD
 ZiP+5SY8akzEqMo9GHJqVMKUU33DRD28Ec99LiDOlducRLxqZcv84t2+4czdguTosUw9SROKfKd
 n2g/CshniFfIpbgcQeq9ohBlOM4Sd5ir5MhrejC1LwohUawfzyx4cAUo9o0/16U+YGej7TK/gXz
 T1CxrtRbQ1a6lgvvC7dr5SA3C2gEyZAiPueHwKc7c28VoI4lqmuw4tTk5dXwmLW05ESgb8haIxp
 stSo8Trq7BUZb9Rl5DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Introduce a new "PowerPC RAS (Reliability, Availability and
Serviceability)" entry in the PowerPC Machines block, replacing the
existing Fadump/MPIPL sections. Retaining the maintainer and
reviewer entries from Fadump/MPIPL sections for this broader umbrella.

Currently most of RAS related code sits in spapr_rtas.c, So Adding
it to PowerPC RAS section. Additionally adding spapr_events.c, as it
implements RTAS error logging infrastructure and spapr_pci_vfio.c, since
its all EEH related code.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260819193757.1072909-2-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79e6c8e0b2..c47e0790ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1765,6 +1765,21 @@ F: include/hw/ppc/vof*
 F: pc-bios/vof/*
 F: pc-bios/vof*
 
+PowerPC RAS (Reliability, Availability and Serviceability)
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Sourabh Jain <sourabhjain@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/spapr_events.c
+F: hw/ppc/spapr_fadump.c
+F: hw/ppc/spapr_pci_vfio.c
+F: hw/ppc/spapr_rtas.c
+F: hw/ppc/pnv_mpipl.c
+F: include/hw/ppc/spapr_fadump.h
+F: include/hw/ppc/pnv_mpipl.h
+F: tests/functional/ppc64/test_fadump.py
+
 RISC-V Machines
 ---------------
 OpenTitan
@@ -3402,23 +3417,6 @@ F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 F: scripts/coccinelle/errp-guard.cocci
 
-Firmware Assisted Dump (fadump) for sPAPR (pseries)
-M: Aditya Gupta <adityag@linux.ibm.com>
-R: Sourabh Jain <sourabhjain@linux.ibm.com>
-S: Maintained
-F: include/hw/ppc/spapr_fadump.h
-F: hw/ppc/spapr_fadump.c
-F: tests/functional/ppc64/test_fadump.py
-
-Memory-Preserving Initial Program Load (MPIPL) for PowerNV
-M: Aditya Gupta <adityag@linux.ibm.com>
-R: Hari Bathini <hbathini@linux.ibm.com>
-R: Sourabh <sourabhjain@linux.ibm.com>
-S: Maintained
-F: include/hw/ppc/pnv_mpipl.h
-F: hw/ppc/pnv_mpipl.c
-F: tests/functional/ppc64/test_fadump.py
-
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
-- 
2.52.0


