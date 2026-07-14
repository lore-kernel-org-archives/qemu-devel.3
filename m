Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F226C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgIm-00008Z-Az; Tue, 14 Jul 2026 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIk-00007e-HY; Tue, 14 Jul 2026 12:48:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIj-0000ny-2b; Tue, 14 Jul 2026 12:48:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGBjYk1720888; Tue, 14 Jul 2026 16:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=51TQlO
 Ih+gyScDPA1S7tiTfxjfsvaxcm21ugDpS7fWs=; b=HBx7L2Icvo9q2+6qF2npf4
 cvJVvV49q8SKe1FxpVVv7vxYIIeI/vsn5uI4SYDJ0Nzw6nX80idMjnFCCw1fut+2
 qqb3iUFuid/PF4QVySKjSML1cZ/a7pAhqsTheW//abtBXIHBQKfCnobWuqMWOJFd
 eL0Q0sQl8yMvlsCkJRl9zkwB78T3p0zgOn9jk5vY/5zAZkPEdXLj6hzSzk1SZRT1
 +dBDgXcKJgAGCgpTlP8VcJFfUL/qLjf3qSYiwSaDmcot9h6u+E55GMPF5KoLPX7Z
 PU324WMUbB8ys1cGnt/dTabHMpc/0GOvLdZHYKX3e34Rw8jqDiqhM/7tezPon96g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwpqp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EGYec9019982;
 Tue, 14 Jul 2026 16:48:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhbnje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:48:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EGm22f59113980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 16:48:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E908120043;
 Tue, 14 Jul 2026 16:48:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CF8320040;
 Tue, 14 Jul 2026 16:47:59 +0000 (GMT)
Received: from shivang.com (unknown [9.124.218.131])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 16:47:59 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 mahesh@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 2/3] MAINTAINERS: add dedicated PowerPC RAS section
Date: Tue, 14 Jul 2026 22:17:43 +0530
Message-ID: <20260714164745.573141-3-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714164745.573141-1-shivangu@linux.ibm.com>
References: <20260714164745.573141-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DHXhEzfP_skPJWHZGkuSAd8AoWUpPYnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfX+iG38vkhkB9c
 n69e3bLAh43NEGHhS4oSyie3Ph4eNAfojM/8kRYui2daYJfcQstFd9xANPebUSzFs/DhZKWhtFu
 N5/sJr3nuebU1jV4/bsG2+xTTrHXQ5Dabbj3FLDlYV6AaNvj0uTz35sTnV+Q6ZO82wbaSXHR6hx
 Lj/gNTMuF3BByDgsM+zlyuebGh4CXh+vyOJulZIWrHnj3ifEfgj7qKhtBjpeyxxTMytkyBZ6atC
 M2OQvEQRRh7gIIvqgL5VdcLrlaeutj/1wFEGvxeJD4gsA40p0LIkVSHH5THr8IRy5SpLJCfQIiF
 xxvz4GA/ziAoTX6GLVN/ioXwwr+I+1xtkaBvs6hAa4aGFCEGsW0AJRWu0l3LgHoewvtguUG5AS+
 3mFJLw03ecETcb066BgJQ3VRcnnlkOQqzFnF9EzTIRbWBeqiUbFOi/1Bb3fh07H3FNCUO+DIM/x
 BexksnjnOLp6am19sPA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a566847 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=s2Fq2CiAU11NuBAKINYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: Gee6rbRhikuDgjhFK8q3-xoHyGscgkHw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfX5YW7p4s5oiDG
 3Od3pjjN5Q2yVM1seuSjSnuORauGhrnPUNxPx1tF4fKyJBXeFUc/WyRKXcEhGJvy5m1Cdfz0QQc
 0xxQP9fTcLX/1y1wC7Eztr4FzE8WZYg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Introduce a new "PowerPC RAS (Reliability, Availability and
Serviceability)" entry in the PowerPC Machines block, replacing the
existing Fadump/MPIPL sections. Retaining the maintainer and
reviewer entries from Fadump/MPIPL sections for this broader umbrella.

Additionally adding spapr_events.c, as it implements RTAS error logging
infrastructure and spapr_pci_vfio.c, since its all EEH related code.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 MAINTAINERS | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e25df9493c..4a010d4807 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1745,6 +1745,21 @@ F: include/hw/ppc/vof*
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
+F: hw/ppc/spapr_rtas_ras.c
+F: hw/ppc/pnv_mpipl.c
+F: include/hw/ppc/spapr_fadump.h
+F: include/hw/ppc/pnv_mpipl.h
+F: tests/functional/ppc64/test_fadump.py
+
 RISC-V Machines
 ---------------
 OpenTitan
@@ -3361,23 +3376,6 @@ F: scripts/coccinelle/remove_local_err.cocci
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
2.54.0


