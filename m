Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00854CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMC-0007T0-Ao; Thu, 30 Oct 2025 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM1-0007Pc-Em
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOLw-0007JY-DX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:49:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TNUBom019696
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=zn+/4dJXifR3troMeOFDpBpIgl0K
 Th+A3MnoPG6xGyI=; b=jUxS5RxsXPCblWK1qkWHoiewmkPMxfUaEUxVJnhYfCo2
 fbM76mnOvdjOgy7vBjAcO8drl780dap69Db7ZGCsDQ//yL98mLhVbt4D9iqI9dIj
 KuVElV5ApqUnRzz3qqhYjkK5d84D+R9ckQoCS5570m0ndf5gDhjQA7xTVYRtHBTg
 D0vy7cpR3s4jrkTJEcfJ8xUV5pgLo8nkjRpL/T6JMbQnqu+Qg+SzYBXw9uq4yGWV
 1ZgYjj9c2QCWrre0qU0UeZpdapI+tqi9C+AWWIfoa9MtClW6b57yEj384pNIUEXY
 crSP9o31MIgzCaQLEzrrjEQhlNAxRU47UoVRstcqLg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agq81p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5pKme018766
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwfq4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8njTb22479344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D31D2004B
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BACBA20043
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] ppc-for-10.2-d4 queue
Date: Thu, 30 Oct 2025 14:19:26 +0530
Message-ID: <20251030084936.1132417-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=690326ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=jjtAk04wAErTeE8O4MgA:9
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 1PAGDr19-HYDjyHH0cC4jEjQt3B135s5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXzFnlo1QfPfM6
 IXM2W0Cnt9IerQX0xCtGHCEH6aa8livfs6vLXJb9cz7hNBYxVSonz0ltn09ACCoLWuplnk2IQhR
 QGYR9ciXoLcNWR5lIxi6FRkoWgqn9hM0Du9ljFd+NUFwYci4j+LF8sX0onkkePd0abISNwqg8w9
 vIXBH7YbBUTIYRFZE9CrPfD24sbm2KTFInBf3ZoinmVTvd2ujdJKDJn23nrZdBp8YY1jktq/Hbo
 eRzSv/cMsDn5Sstjh2sWwgVciOB5G6Ai5P10K7lfCUwbbibra4DL7GHcdmBfjuknY7WUlUwx2s3
 ILSaKBQyxrjaY13E7XLFb8s8iHrijG1illYKGrMaRneMip5keTInBHEDzomzbvtRi2FXqIfd8d7
 2bgjGH72jQrb41zGgEd8AkLRChyoFg==
X-Proofpoint-GUID: 1PAGDr19-HYDjyHH0cC4jEjQt3B135s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d4-20251030

for you to fetch changes up to 5795c7650e4b149e19020f95cc4892bf7b2beef6:

  hw/ppc/pegasos: Update documentation for pegasos1 (2025-10-30 13:40:38 +0530)

----------------------------------------------------------------
ppc queue for 10.2

* Firmware updates for SLOF, sam460ex u-boot
* Removal of unusable e200 CPUs
* Coverity fixes for fadump
* Other minor fixes, cleanups for pegasos, spapr.

----------------------------------------------------------------
BALATON Zoltan (4):
      hw/ppc/sam460ex: Update u-boot-sam460ex
      hw/ppc/pegasos2: Add /chosen/stdin node with VOF
      hw/ppc/pegasos2: Rename to pegasos
      hw/ppc/pegasos: Update documentation for pegasos1

Shivang Upadhyay (2):
      hw/ppc: Fix missing return on allocation failure
      hw/ppc: Fix memory leak in get_cpu_state_data()

Thomas Huth (3):
      pseries: Update SLOF firmware image to release 20251027
      target/ppc/cpu_init: Simplify the setup of the TLBxCFG SPR registers
      target/ppc: Remove the unusable e200 CPUs

Yoges Vyas (1):
      ppc/spapr: Cleanup MSI IRQ number handling

 MAINTAINERS                             |   6 +-
 docs/system/ppc/amigang.rst             |  29 ++---
 configs/devices/ppc-softmmu/default.mak |   7 +-
 include/hw/ppc/spapr_irq.h              |   2 +-
 target/ppc/cpu-models.h                 |   4 -
 hw/ppc/{pegasos2.c => pegasos.c}        |   1 +
 hw/ppc/sam460ex.c                       |   7 +-
 hw/ppc/spapr_fadump.c                   |   3 +-
 hw/ppc/spapr_irq.c                      |   7 +-
 hw/ppc/spapr_pci.c                      |   2 +-
 target/ppc/cpu-models.c                 |   5 -
 target/ppc/cpu_init.c                   | 185 +++-----------------------------
 hw/ppc/Kconfig                          |   2 +-
 hw/ppc/meson.build                      |   4 +-
 pc-bios/README                          |   2 +-
 pc-bios/meson.build                     |   2 +-
 pc-bios/slof.bin                        | Bin 996184 -> 994176 bytes
 pc-bios/u-boot-sam460-20100605.bin      | Bin 524288 -> 0 bytes
 pc-bios/u-boot-sam460.bin               | Bin 0 -> 524288 bytes
 roms/Makefile                           |   5 +-
 roms/SLOF                               |   2 +-
 roms/u-boot-sam460ex                    |   2 +-
 22 files changed, 55 insertions(+), 222 deletions(-)
 rename hw/ppc/{pegasos2.c => pegasos.c} (99%)
 delete mode 100644 pc-bios/u-boot-sam460-20100605.bin
 create mode 100644 pc-bios/u-boot-sam460.bin

