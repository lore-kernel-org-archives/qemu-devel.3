Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JKJ-0008Sh-Ky; Fri, 26 Apr 2024 07:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JJw-0008Lm-6C; Fri, 26 Apr 2024 07:00:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0JJu-00089X-8s; Fri, 26 Apr 2024 07:00:47 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QA3X6G025264; Fri, 26 Apr 2024 11:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=J2RHWWrl4bmfmnJcL1BJ4i/0hMI84HQ84oLifSo4hK8=;
 b=hoOX/kY4SjCnrDqF066S2DSA6mzAiAcpcOsllKe6O1NqVnW8ViKtxRP53+PPPxaRPe6A
 PInAY00Z/iUnk51Dh3A/q2qjmm1hdMQ/JCXim3rlY3HfVdwVHRWy+lQ83AOGB6nnRWoF
 T4GlUDWGEIX7YereqLlUaK782O8EFtD7oGBaigRVZ1sQUxMK+bS35aa82YEQa9hyz4rM
 VVLQ61Fo7duW2XkDHkDfoKftkCB8GuXQ8vqXEgIZYePoff6EvN5+AesGTpEwaMSSDc5g
 uwPvONrRZPVt9iBwYR9qzhVa+HsB06s8RCON8N3qSTo4JxzwX518wtzDpXm0vcQp9ZRn Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra63g3kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QB0AiE012411;
 Fri, 26 Apr 2024 11:00:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xra63g3kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q8D8W8020953; Fri, 26 Apr 2024 11:00:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmre0fey9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:00:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB0RIi40108292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:00:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97C142005A;
 Fri, 26 Apr 2024 11:00:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A53C42004E;
 Fri, 26 Apr 2024 11:00:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.171.14.245]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Apr 2024 11:00:25 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v2 00/10] Power11 support for QEMU
Date: Fri, 26 Apr 2024 16:30:13 +0530
Message-ID: <20240426110023.733309-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nijed8ITn8Joo7QZgBee5wwie9SgOs5y
X-Proofpoint-ORIG-GUID: 5XzVrdXSewAoR7T_7fhxRzGiAkfFYXLW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
============

Add support for Power11 pseries and powernv machine types, to emulate VMs
running on Power11.

As Power11 core is same as Power10, hence much of the code has been reused from
Power10.

Also make Power11 as default cpu type for 'pseries' and 'powernv'
machine types, with Power11 being the newest supported Power processor in QEMU.

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v2

Has been tested with following cases:
* '-M pseries' / '-M pseries -cpu Power11'
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested
* with compat mode: 'max-cpu-compat=power10' and 'max-cpu-compat=power9'
* with/without device 'virtio-scsi-pci'
* with/without -kernel and -drive with qcow_file

skiboot with Power11 support: https://github.com/maheshsal/skiboot/tree/upstream_power11

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
v2:
  + split powernv patch into homer,lpc,occ,psi,sbe
  + reduce code duplication by reusing power10 code
  + make power11 as default
  + rebase on qemu upstream/master
  + add more information in commit descriptions
  + update docs
  + update skiboot.lid

Aditya Gupta (10):
  ppc/pseries: Add Power11 cpu type
  ppc/pnv: Introduce 'PnvChipClass::chip_type'
  ppc/pnv: Add a Power11 Pnv11Chip, and a Power11 Machine
  ppc/pnv: Add HOMER for POWER11
  ppc/pnv: Add a LPC controller for POWER11
  ppc/pnv: Add OCC for Power11
  ppc/pnv: Add a PSI bridge model for Power11
  ppc/pnv: Add SBE model for Power11
  ppc: Make Power11 as default cpu type for 'pseries' and 'powernv'
  ppc/pnv: Update skiboot.lid to support Power11

 docs/system/ppc/powernv.rst |   9 +--
 docs/system/ppc/pseries.rst |   6 +-
 hw/ppc/pnv.c                | 107 ++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv_core.c           |  16 +++++-
 hw/ppc/pnv_homer.c          |   8 +++
 hw/ppc/pnv_lpc.c            |  14 +++++
 hw/ppc/pnv_occ.c            |  14 +++++
 hw/ppc/pnv_psi.c            |  24 ++++++++
 hw/ppc/pnv_sbe.c            |  15 +++++
 hw/ppc/spapr.c              |   2 +-
 hw/ppc/spapr_cpu_core.c     |   1 +
 include/hw/ppc/pnv.h        |   5 ++
 include/hw/ppc/pnv_chip.h   |  20 +++++++
 include/hw/ppc/pnv_homer.h  |   3 +
 include/hw/ppc/pnv_lpc.h    |   4 ++
 include/hw/ppc/pnv_occ.h    |   2 +
 include/hw/ppc/pnv_psi.h    |   2 +
 include/hw/ppc/pnv_sbe.h    |   2 +
 pc-bios/skiboot.lid         | Bin 2527328 -> 2527328 bytes
 target/ppc/compat.c         |   7 +++
 target/ppc/cpu-models.c     |   2 +
 target/ppc/cpu-models.h     |   2 +
 target/ppc/cpu_init.c       |  99 +++++++++++++++++++++++++++++++++
 23 files changed, 350 insertions(+), 14 deletions(-)

-- 
2.44.0


