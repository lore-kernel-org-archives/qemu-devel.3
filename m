Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D18DCD3423
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIp8J-0005Lh-Ky; Fri, 01 May 2026 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIp8H-0005L4-Kx; Fri, 01 May 2026 10:46:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIp8G-0000hL-2t; Fri, 01 May 2026 10:46:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6410Qc4B2648672; Fri, 1 May 2026 14:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4jpKkYQDufrOZixFrw2aVywgJNKHCJDyFQfsL8fus
 /o=; b=bPAr5l812HYReSs7tFM44kgHN/vKBOe2YgI5btoRtqqgNPpGdtsZ698J6
 VYUoFkvBY2es618tnSzN5bziK4XOPxIyAhC0/AXHf2zTZ+mI6fN3iu/ZwdySo3/m
 hG0ZULwO1V+t42GVtkmZ66uaq2rDvp+EL0xWHy4TR7FK8OaJdRpGGVNY/aVYxtY0
 TersOHKCy8e+MUYz4BP/XWjBYTZm0rUtLSWCwDX/fdw7zZLA7oohOZm5dbE69AJe
 ibUevhUSyfRRs/Uc8uQM4UuZQD1GAKSmBAiiiiHwG2YgydXsVs2LbSoWqzt3Fv38
 O9mxS7x1b4z7AEdnvgC5MiXiC0G1A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vu1v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:46:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641EcuSN022626;
 Fri, 1 May 2026 14:46:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5gqq5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:46:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641EkDvg55116232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 14:46:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65EAD20049;
 Fri,  1 May 2026 14:46:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0A1620040;
 Fri,  1 May 2026 14:46:10 +0000 (GMT)
Received: from Mac.com (unknown [9.124.223.14])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 14:46:10 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 adityag@linux.ibm.com
Subject: [PATCH] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
Date: Fri,  1 May 2026 20:15:58 +0530
Message-ID: <20260501144558.24491-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f4bcba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=baZIeI3FYBhAsU0McMkA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: -8xEI7ZS6ADiS7SlgB42CNBML70Zh7tG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEzOSBTYWx0ZWRfX9+ecgqNRMXnF
 fpgOuLo7Ezh/L9oAJXUQIvbC7U6Snt/k0fPn8Op/Cv9OTDFLaiSsRQUgL3J3RoT8iABhd/8OIt6
 BIyjWC3TZO4hZraiqWwyMXvLkD91SVgt6Xm73OciV/VWtFjVYViirKNSZPihsG06MdvcPzRrnPd
 EOUc/JloOJArw44kFzEC18kXBI93AAFRI1QVnF8d50mUi3Ib7OsIP5FuQXVet7C0H9fCHo5On5H
 jqGjOXGLIXvDniQH4QCCEnRHGG+FLCqPrC1g4ZV/tnMO//kjyFMe7vzosfLuYgXIRrp7eI1Lka7
 UyioRlyOCzIsB6ChD38XHn/3ajgiC1Cr9azQDczpewLX5nEIhZ0xWKx1nEEHi9uHwpTmpqgAia2
 Ku+7Jk5EpOZTdohAykjtBbojBdOk/RjyXTOAP+kQWwW3VHJdyStzW0Ybt0ziJcCDvZnVxr1rG2i
 j4upyz/g+5mdq01JrlQ==
X-Proofpoint-GUID: UfYuaCfA2FNnbPciCBn8nprvjfZ6REZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Also remove the redundant entry for pseries.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e41f0eb92c..0ad8770fa0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -323,6 +323,7 @@ PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -1617,7 +1618,6 @@ F: tests/functional/ppc/test_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
-R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/spapr*
@@ -1643,6 +1643,7 @@ PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
-- 
2.52.0


