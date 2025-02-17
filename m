Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74AEC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvQ1-0000v4-AL; Mon, 17 Feb 2025 02:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvPz-0000u3-5C; Mon, 17 Feb 2025 02:19:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvPx-0002of-6Q; Mon, 17 Feb 2025 02:19:50 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GGko6I026098;
 Mon, 17 Feb 2025 07:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=83dxMYricrlP1/HLBWVGAmyp2ym7K2z4t48lhb34d
 vk=; b=UdNU00KMXe/MFlCHcqg/J4hAbgPKXZbY5CMKgsTIZE0U9hP38OzPWr/Vb
 zGEGfaQ5GWdPcAlpNS5ctPcHP9GaNrbxB74GM57Wb+62GOPq7l8QXdy08cX81erK
 jY6qWn6of0StCUiA3n7CWr0nOk9iQ+HUr5njTPocei/Psh/gAVhOZuKJkSvx5OJA
 kQd1cf1qhucMfmDDbMKcgeD1kq3mUF+7g41y4i7c9WV2dsIcAI6F+W/CzhwuKeXl
 tt7VfC9abY4juXsmuonuc4I/4m/goCTTSxJEb0k4M6UZY9Xlv5JqcN423bdgbrK2
 K9kCIr0eFFTre3I5fP7kfpTKXcv9g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7ILpP028545;
 Mon, 17 Feb 2025 07:19:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ubqnuyej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H355dT008164;
 Mon, 17 Feb 2025 07:19:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58td542-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:19:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7JhO145482350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:19:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15D5220040;
 Mon, 17 Feb 2025 07:19:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAFBB20049;
 Mon, 17 Feb 2025 07:19:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:19:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 0/7] Implement MPIPL for PowerNV
Date: Mon, 17 Feb 2025 12:49:27 +0530
Message-ID: <20250217071934.86131-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cMyLWa5fnlYt0VgWMSoRFfFnT-tiGH8m
X-Proofpoint-ORIG-GUID: X_C8f_ngnP4bdtu6JJ5ZOUQyS0UPFuFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=749 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Overview
=========

Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
in QEMU.

Note: It's okay if this isn't merged as there might be less users. Sending
for archieval purpose, as the patches can be referred for how fadump/mpipl
can be implemented in baremetal/PowerNV/any other arch QEMU.

Fadump is an alternative dump mechanism to kdump, in which we the firmware
does a memory preserving boot, and the second/crashkernel is booted fresh
like a normal system reset, instead of the crashed kernel loading the
second/crashkernel in case of kdump.

MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)

For implementing in baremetal/powernv QEMU, we need to export a
"ibm,opal/dump" node in the device tree, to tell the kernel we support
MPIPL

Once kernel sees the support, and "fadump=on" is passed on commandline,
kernel will register memory regions to preserve with Skiboot.

Kernel sends these data using OPAL calls, after which skiboot/opal saves
the memory region details to MDST and MDDT tables (S-source, D-destination)

Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
along with OPAL's relocated base address.

SBE then stops all core clocks, and only does particular ISteps for a
memory preserving boot.

Then, hostboot comes up, and with help of the relocated base address, it
accesses MDST & MDDT tables (S-source and D-destination), and preserves the
memory regions according to the data in these tables.
And after preserving, it writes the preserved memory region details to MDRT
tables (R-Result), for the kernel to know where/whether a memory region is
preserved.

Both SBE's and hostboot responsiblities have in implemented in the SBE code
in QEMU.

Then in the second kernel/crashkernel boot, OPAL passes the "mpipl-boot"
property for the kernel to know that a dump is active, which kernel then
exports in /proc/vmcore

Git Tree for Testing
====================

https://github.com/adi-g15-ibm/qemu/tree/fadump-powernv-v1

Known Issues
============

* CPU save area has not been implemented

Aditya Gupta (7):
  hw/ppc: Log S0/S1 Interrupt triggers by OPAL
  hw/ppc: Implement S0 SBE interrupt as cpu_pause then host reset
  hw/ppc: Handle stash command in PowerNV SBE
  hw/ppc: Add MDST/MDDT/MDRT table structures and offsets
  hw/ppc: Preserve Memory Regions as per MDST/MDDT tables
  hw/ppc: [WIP] Add Processor Dump Area offsets in Pnv SBE
  hw/ppc: Implement MPIPL in PowerNV

 hw/ppc/pnv.c             |  49 +++++++
 hw/ppc/pnv_sbe.c         | 295 +++++++++++++++++++++++++++++++++++++--
 include/hw/ppc/pnv_sbe.h |   7 +
 3 files changed, 342 insertions(+), 9 deletions(-)

-- 
2.48.1


