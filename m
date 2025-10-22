Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E00CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 13:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYqQ-00069Y-QI; Wed, 22 Oct 2025 09:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYqP-00068r-5k; Wed, 22 Oct 2025 09:25:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBYqK-0006Aw-44; Wed, 22 Oct 2025 09:25:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7lJ7a014602;
 Wed, 22 Oct 2025 13:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=bU3bHT79nzoDR1oK6typvFXx+fF0
 3XmwwaxjFM84Et4=; b=dhx86EO2Y4lCbfBSEMvgrKAFsvFdt192cBdn36mSyDDf
 Q/cv+ELjzxcBSLfqGJ3bIQw+dejcp68oXFguboEN96drsVxFc+EFSfsi7cZ5PJua
 JF3ojE1FTFbu7PiKrhiT1M36+GutVnfX2CEi487pvKWQ0ewcn12IBg4zZS+8GMXk
 ct28e9W94QolBFXNBrYrSWfayVi/rxnPBdvyvJydPJT4OmHS8o8sTKpiIetvzgIs
 b/wkWqIv+6/O3tKsS1cEVYP/Vm7spPDACePhwNVwhWVhy6bNIv6APs78YLRP+Xbt
 9gQ07s6P01x/TdSqdHEnalT/umICkjhLAbkwMB6g4Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s4x65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:25:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MClZDl004862;
 Wed, 22 Oct 2025 13:25:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s4x5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:25:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAMM8V017066;
 Wed, 22 Oct 2025 13:25:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky0n3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 13:25:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MDPJEm57213248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 13:25:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE42220043;
 Wed, 22 Oct 2025 13:25:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B666A2004B;
 Wed, 22 Oct 2025 13:25:16 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.31])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 13:25:16 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v6 0/6] hw/core/loader: capture Error from load_image_targphys
Date: Wed, 22 Oct 2025 18:54:59 +0530
Message-ID: <20251022132507.1597232-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pQOXk4oSCZcL2q9GB-9z_oVSlh8dEWK7
X-Proofpoint-GUID: -1WIFo2sKx6RRfXhmXhw8cMBWh3dOzkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7fCCgByFBUXq
 FfjCM7qo+hkhp+w36Rh2e23w3TCq6znBsLsILLbU4zHDmuH+7nlwa7CVaodz5sP9rUiva9NnJ6V
 x7u+geqkhTOU/7T8N46sackPkgbXcJ99RN/zWQp8bSt0NZyWu+55dJCwykTquDqGgc4RYYxDY3s
 Zjd87A3Jr9xmALjyeE/rI8l8BvQ2U1M+F01KRZTUWhj/byxeIQXVk/YyH1d1dK+rxJ9Gvf9gNAS
 Gvswe3I7qhsGVQTDXS+0Fv7K5DqobkbJHxUqnzd/H8AZSpzKSkhNgDPUOJ8OpItNtz1ZYof5dPD
 H+aqpC/2sVYsLXsrVZzyDrzcgJHLOTwl5LTfheSsUMSPbqatGqRlGd048wcLfJv35A6akMJ+ekE
 HaLBDYf21bMDYjukvKNUEq9RNm0cOg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8db46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=tC3Qo0kugqxd9oclSfAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
load_image_targphys(), the error messages are not descriptive enough
for users to understand why the loading failed. This series adds the
ability to add Error information through the loader functions to
provide more detailed error reporting.

v6:
- Pass error_fatal instead of errp where caller exits right after
  load_image_targphys() fails
- Include filename in error messages.

v5:
- Moved the patch which replaces open() with qemu_open() earlier in the
  series
- Incorporated minor changes in the error messages requested by Balaton
- Moved check for size zero in load_image_targphys_as() into it's
  separate patch 

v4:
- Reject empty files (`size == 0`) with an appropriate error. [1/5]
- Populate error when `rom_add_file_fixed_as()` fails. [1/5]
- Add missing check in hw/ppc/virtex_ml507.c [5/5]
- Fixed checkpatch warnings [5/5]
- Check errp for failures from load_image_targphys/load_image_targphys_as [3,5/5]
- Remove unused variables [5/5]

v3:
- Use qemu_open() instead of open() in get_image_size() (danpb)
- Remove redundant error_setg_file_open() call (danpb)
- Use error_prepend()/error_reportf_err() to preserve underlying
  error details (danpb)

[v5]: https://lore.kernel.org/all/20251021105442.1474602-2-vishalc@linux.ibm.com
[v4]: https://lore.kernel.org/all/20251017181250.1421446-2-vishalc@linux.ibm.com
[v3]: https://lore.kernel.org/all/20251016173502.1261674-1-vishalc@linux.ibm.com
[v2]: https://lore.kernel.org/all/20251015134716.1099351-2-vishalc@linux.ibm.com
[v1]: https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com

Vishal Chourasia (6):
  hw/core/loader: Use qemu_open() instead of open() in get_image_size()
  hw/core/loader: capture Error from load_image_targphys
  hw/core/loader: add check for zero size in load_image_targphys_as
  hw/core: Pass errp to load_image_targphys_as()
  hw/ppc/spapr: Rename resize_hpt_err to errp
  hw/ppc: Pass errp to load_image_targphys() and report errors

 hw/alpha/dp264.c         |  4 ++--
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            |  5 +++--
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/highbank.c        |  3 ++-
 hw/arm/raspi.c           |  2 +-
 hw/arm/vexpress.c        |  2 +-
 hw/core/generic-loader.c |  8 +++++---
 hw/core/guest-loader.c   |  7 ++++---
 hw/core/loader.c         | 37 +++++++++++++++++++++++++++++--------
 hw/hppa/machine.c        |  5 +++--
 hw/i386/multiboot.c      |  2 +-
 hw/i386/x86-common.c     |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c   |  2 +-
 hw/loongarch/boot.c      |  5 ++---
 hw/m68k/an5206.c         |  2 +-
 hw/m68k/mcf5208.c        |  4 ++--
 hw/m68k/next-cube.c      |  2 +-
 hw/m68k/q800.c           |  7 ++++---
 hw/m68k/virt.c           |  4 ++--
 hw/microblaze/boot.c     |  5 +++--
 hw/mips/boston.c         |  2 +-
 hw/mips/fuloong2e.c      |  9 +++++----
 hw/mips/jazz.c           |  2 +-
 hw/mips/loongson3_virt.c | 10 ++++++----
 hw/mips/malta.c          |  9 +++++----
 hw/nubus/nubus-device.c  |  2 +-
 hw/openrisc/boot.c       |  5 +++--
 hw/pci/pci.c             |  2 +-
 hw/ppc/amigaone.c        | 13 ++-----------
 hw/ppc/e500.c            | 20 ++++----------------
 hw/ppc/mac_newworld.c    | 19 ++++++-------------
 hw/ppc/mac_oldworld.c    | 19 ++++++-------------
 hw/ppc/pegasos2.c        | 10 +++-------
 hw/ppc/pnv.c             | 27 ++++++---------------------
 hw/ppc/ppc440_bamboo.c   |  9 ++-------
 hw/ppc/prep.c            | 19 ++++++-------------
 hw/ppc/sam460ex.c        |  8 ++------
 hw/ppc/spapr.c           | 33 ++++++++++++---------------------
 hw/ppc/virtex_ml507.c    | 11 +++--------
 hw/riscv/boot.c          |  7 ++++---
 hw/rx/rx-gdbsim.c        |  2 +-
 hw/s390x/ipl.c           |  8 +++++---
 hw/sh4/r2d.c             |  8 +++++---
 hw/smbios/smbios.c       |  2 +-
 hw/sparc/leon3.c         |  4 ++--
 hw/sparc/sun4m.c         |  8 +++++---
 hw/sparc64/sun4u.c       |  7 ++++---
 hw/xtensa/xtfpga.c       |  3 ++-
 include/hw/loader.h      |  8 +++++---
 system/device_tree.c     |  2 +-
 51 files changed, 181 insertions(+), 221 deletions(-)

-- 
2.51.0


