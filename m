Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A850BCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9oyC-0002bM-Sq; Fri, 17 Oct 2025 14:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9oyA-0002Zj-Mm; Fri, 17 Oct 2025 14:14:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9oy8-000703-JH; Fri, 17 Oct 2025 14:14:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HBOPqr001425;
 Fri, 17 Oct 2025 18:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=UuU6J39PibigTWmfKVGyYkwZ0vqctMB/ZFQcXpOpo
 2o=; b=iblR7iQzZFwYu8xo0RItQbmcEdsSaEVcvucxx9XYTyrVx7/UydRy+39ev
 9mn3JefnCrogA60Yb/enAMCm2VOasfCSWcEKdzoqHPs2nH7l53611h2doak88iQi
 nmpML0jPoR3L8CtJimQJ+fOQrPbrA/uqmIlDDqlKGGvOa0I3sopKY9rWm/Db2zY6
 uElAVtmcHS8drlzEP6tUDX2y0XvahKHfQ7r/jrGtAmRys/PaDcSJVsXGGUjJxuSX
 pZ708Aa4Mf/+vKuoNkYkqukpPg9fn13ugSs53OYeR7BoHnrveKbVfSAbl8mxkaDm
 GvzNc2FWrm/hGQMIER3Djojn+PXHA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fb2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:14:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HHtbOG001644;
 Fri, 17 Oct 2025 18:14:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fb2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:14:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HFZqDx028069;
 Fri, 17 Oct 2025 18:14:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9nxyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:14:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HIEB4348300324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 18:14:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BB1E20043;
 Fri, 17 Oct 2025 18:14:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D49C20040;
 Fri, 17 Oct 2025 18:14:08 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.22.45])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 18:14:08 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v4 0/5] hw/core/loader: capture Error from load_image_targphys
Date: Fri, 17 Oct 2025 23:42:45 +0530
Message-ID: <20251017181250.1421446-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VkLTSvMGLdZnU_jU6oy00k0cXxyIkisE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX34jmn4eTcqqj
 Fir7Yo6BjtfAsmi4YpJOLQYbLD0tizpyX9w9q015C1EDmCojeCpEUKelDnZiT7MhNVKsdC/7bEl
 i+Of6v8SPDyyRLowjdUwrx1x7NhPeIvIwQ9rNaZXEgmluGHDhWHvOapXkEcREREDVvTuYBFVKOx
 +lqAVD8h2Cuqurhb9TIcgnRgF3Fpd/DOK02KdMSbqi+i99zLe6vkOPXpEby0CTo1xvjiFiopP9Y
 h6kIwwXzlzSIIJ6tJeSYtyFTCBRarnRmjMJSL0xg2GH4S2Up9PTuFUhS4Iy8SI6N4bZYJJ+3jaq
 WiIDYKJME2coYP4o2MVwxEUXsdDosxiW36i6rE3eWz9nR3kp61z3kYbxq5sL9Y+AaXC27VVPT/d
 YyziIUSx6XJqnUhNl7jjpRNSKeBGhA==
X-Proofpoint-GUID: unRg5UT4jvpnpWk_rUOvMj6kqOAJkVay
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f28778 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=k9goeJRjz61ICn6m31oA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
load_image_targphys(), the error messages are not descriptive enough
for users to understand why the loading failed. This series adds the
ability to pass Error information through the loader functions to
provide more detailed error reporting.

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

Vishal Chourasia (5):
  hw/core/loader: capture Error from load_image_targphys
  hw/core/loader: Use qemu_open() instead of open() in get_image_size()
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
 hw/core/loader.c         | 41 +++++++++++++++++++++++++++++++---------
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
 hw/ppc/amigaone.c        | 15 ++++++++-------
 hw/ppc/e500.c            | 18 ++++++++++--------
 hw/ppc/mac_newworld.c    | 29 ++++++++++++++++++----------
 hw/ppc/mac_oldworld.c    | 29 ++++++++++++++++++----------
 hw/ppc/pegasos2.c        | 18 ++++++++++++------
 hw/ppc/pnv.c             | 30 ++++++++++++++---------------
 hw/ppc/ppc440_bamboo.c   | 10 ++++++----
 hw/ppc/prep.c            | 27 ++++++++++++++++----------
 hw/ppc/sam460ex.c        | 10 ++++++----
 hw/ppc/spapr.c           | 35 +++++++++++++++++-----------------
 hw/ppc/virtex_ml507.c    | 18 ++++++++++++------
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
 51 files changed, 274 insertions(+), 183 deletions(-)

-- 
2.51.0


