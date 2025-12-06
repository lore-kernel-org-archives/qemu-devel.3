Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5BED374BD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 05:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRlJK-00043f-OC; Sat, 06 Dec 2025 00:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJJ-00043J-Sc; Sat, 06 Dec 2025 00:58:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vRlJI-0005Wg-5G; Sat, 06 Dec 2025 00:58:25 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B60OOn7026227;
 Sat, 6 Dec 2025 05:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=W+i1W0P4rmivtdj6md0qmpgIMTrpmlTSfhRUzTC6o
 g0=; b=ppxjU0g4Rdh6sYw8OFYcWNAwJORvcRwEy1lzZDYRGC+3nb4DK76QZwJrk
 Bze+C5Gd+qEAZ2OeQ+TM9ME7gV53Ee/0/s87HAzhFz+VJ7fh89CmYauW15b3G797
 zAq+yLqLNmiPCKi3+GTRyRELHPONVfUN/s+KlH7YS2lGx0UhivI/jajQWnvIjOoA
 Leh+RjL/chESDYsPrFJ+XDalQlbRpzREOdTO46b1lXjopmbdMgyJmdUzxhK5//sO
 CjPs+71PmmCSUeOtVgw2UjT1HfdrzQM2Tkvl0UDRtXWloul2z8E+Z/WhbzM8DIRk
 PRAMRaGgXhMNtrUCroJApa0idO3Pw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wv8r1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B61Z6Ca019035;
 Sat, 6 Dec 2025 05:58:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhyh1vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Dec 2025 05:58:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B65wGgJ8388960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Dec 2025 05:58:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4511920043;
 Sat,  6 Dec 2025 05:58:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55A8420040;
 Sat,  6 Dec 2025 05:58:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.31.93]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Dec 2025 05:58:14 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 0/9] Implement MPIPL for PowerNV
Date: Sat,  6 Dec 2025 11:26:39 +0530
Message-ID: <20251206055648.1908734-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -rmSMytNHsvqHjWa4pwfXq7MU7-Byt6c
X-Proofpoint-ORIG-GUID: -rmSMytNHsvqHjWa4pwfXq7MU7-Byt6c
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6933c5fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=Ln0G2CSHtJ96cT1x5koA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX9hrRgUpWZr/W
 qNG+N7qiNw5Cev2iJCATHlU6bSkrq5Hui6F8zeixYNWswiWLzOhl8Q6UXEQTAV7q0HrdOPo58va
 HVDVrwbfSYJyjhzi4ihPCKEC2PmoPGnf8C9ybtaAfYi813wvvxfc5iO7j/J5fXnf8cPY1PUgo4S
 LbzweyfQPYKD8j6JfsnwOo2TXYb+VcO6TQ1jz/zoQSLs8t6B+XfNVMWPXwtD0JEfhdBZWPFM8E6
 NOsgZgFC8SywqzEOjtHByQ+r1OFQV74wXAOwPPw+2JJW/7EE164JEQBesMjI3nE5Bvz/ri/OTef
 NhRiufy9W9kpBv7JaxBfJEqwwacj8baKkJlN/OWpmTN9otHevSoQlwzlgnAh3wyQ3QmMlC4or+4
 879uHftGWd1nufU58SVuAJ4nB45q/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

https://github.com/adi-g15-ibm/qemu/tree/fadump-powernv-v2

Aditya Gupta (9):
  hw/ppc: Move SBE host doorbell function to top of file
  hw/ppc: Implement S0 SBE interrupt as cpu_pause then host reset
  hw/ppc: Handle stash command in PowerNV SBE
  pnv/mpipl: Preserve memory regions as per MDST/MDDT tables
  pnv/mpipl: Preserve CPU registers after crash
  pnv/mpipl: Set thread entry size to be allocated by firmware
  pnv/mpipl: Write the preserved CPU and MDRT state
  pnv/mpipl: Enable MPIPL support
  tests/functional: Add test for MPIPL in PowerNV

 hw/ppc/meson.build                    |   1 +
 hw/ppc/pnv.c                          |  90 ++++++
 hw/ppc/pnv_mpipl.c                    | 388 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c                      |  74 ++++-
 include/hw/ppc/pnv.h                  |   7 +
 include/hw/ppc/pnv_mpipl.h            | 167 +++++++++++
 tests/functional/ppc64/test_fadump.py |  35 +--
 7 files changed, 731 insertions(+), 31 deletions(-)
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 include/hw/ppc/pnv_mpipl.h

-- 
2.52.0


