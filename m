Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F30E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRT-00061j-Oz; Fri, 06 Dec 2024 07:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRL-0005xA-Ha; Fri, 06 Dec 2024 07:28:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRI-00041X-CO; Fri, 06 Dec 2024 07:28:10 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UdIh000889;
 Fri, 6 Dec 2024 12:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=H1XSzfzQ35MJNhtuvUSSmG+6rA5kKQH2J2mPrsp90
 uw=; b=M7c46/Polbz2oQFL07ZHlFeV/zjiaxR1dByBXYOLCwun+Ct/Dvrm4EsvU
 XMCdAnod42iEejxAuX0k/F+IPUlRHrNtV6bn6n6tZZmeu9n2nvRnUmxi4Mk1j0ND
 uMxjaOSfJVCYWrnPSHNolfokPSJdmQuewGJHvt7zZ8ZCn4lx7VSjb+r06pUwT+a0
 tet8hS2M6tu7uWZQtl5f/thxjciLzpHFTA6Zf0LPhCVR6yRaExfQPLUkAoNcvE/e
 hRQwThdczzYDrbQ/sFkEAQmm7L7qyTgI3fT/SFuww65S/BIal9IxAD+gLXRl7swz
 3ELXFwo7BeUvd27ZjuRWGI/gkWp2g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxks5qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6BFOr7020058;
 Fri, 6 Dec 2024 12:28:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1xmpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CRwJe26936038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:27:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086A42004B;
 Fri,  6 Dec 2024 12:27:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D51A20043;
 Fri,  6 Dec 2024 12:27:57 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:27:57 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 00/15] KVM: s390: CPU model for gen17
Date: Fri,  6 Dec 2024 13:27:36 +0100
Message-ID: <20241206122751.189721-1-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nnYr2wzTeivzXbIGiDN7eZDvD1JZR_AF
X-Proofpoint-ORIG-GUID: nnYr2wzTeivzXbIGiDN7eZDvD1JZR_AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Introducing the gen17 CPU model with feature indications
comprising of:

* Concurrent-function facility with subcodes
* More vector extensions
* Ineffective-nonconstrained-transaction facility
* Even more msa crypto extensions
* Additional PLO subfunctions

For reference, see also the kernel part:
https://lore.kernel.org/kvm/20241107152319.77816-1-brueckner@linux.ibm.com/T/#me506dc2ca538aee3cfc13620a48bdb686c459ab0

Changelog v1->v2:
- Linux headers update to Linux 6.13-rc1 as pre-req
  for the Concurrent-function facility
- Added missing CPU feature (group) initialization
  for the msa12 and PLO extensions


Feedback and review is always welcome.  Thanks a lot!

Kind regards,
Hendrik


Hendrik Brueckner (15):
  s390x/cpumodel: add msa10 subfunctions
  s390x/cpumodel: add msa11 subfunctions
  s390x/cpumodel: add msa12 changes
  s390x/cpumodel: add msa13 subfunctions
  s390x/cpumodel: Add ptff Query Time-Stamp Event (QTSE) support
  linux-headers: Update to Linux 6.13-rc1
  s390x/cpumodel: add Concurrent-functions facility support
  s390x/cpumodel: add Vector Enhancements facility 3
  s390x/cpumodel: add Miscellaneous-Instruction-Extensions Facility 4
  s390x/cpumodel: add Vector-Packed-Decimal-Enhancement facility 3
  s390x/cpumodel: add Ineffective-nonconstrained-transaction facility
  s390x/cpumodel: Add Sequential-Instruction-Fetching facility
  s390x/cpumodel: correct PLO feature wording
  s390x/cpumodel: Add PLO-extension facility
  s390x/cpumodel: gen17 model

 include/standard-headers/drm/drm_fourcc.h     |   1 +
 include/standard-headers/linux/ethtool.h      |   5 +
 include/standard-headers/linux/pci_regs.h     |  38 ++-
 .../standard-headers/linux/virtio_crypto.h    |   1 +
 include/standard-headers/linux/virtio_pci.h   | 131 ++++++++++
 linux-headers/asm-arm64/kvm.h                 |   6 +
 linux-headers/asm-arm64/unistd_64.h           |   4 +
 linux-headers/asm-generic/mman-common.h       |   3 +
 linux-headers/asm-generic/mman.h              |   4 +
 linux-headers/asm-generic/unistd.h            |  11 +-
 linux-headers/asm-loongarch/kvm.h             |  20 ++
 linux-headers/asm-loongarch/unistd_64.h       |   4 +
 linux-headers/asm-mips/mman.h                 |   3 +
 linux-headers/asm-mips/unistd_n32.h           |   4 +
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |   4 +
 linux-headers/asm-powerpc/unistd_32.h         |   4 +
 linux-headers/asm-powerpc/unistd_64.h         |   4 +
 linux-headers/asm-riscv/kvm.h                 |   4 +
 linux-headers/asm-riscv/unistd_32.h           |   4 +
 linux-headers/asm-riscv/unistd_64.h           |   4 +
 linux-headers/asm-s390/kvm.h                  |   3 +-
 linux-headers/asm-s390/unistd_32.h            |   4 +
 linux-headers/asm-s390/unistd_64.h            |   4 +
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/mman.h                  |   3 -
 linux-headers/asm-x86/unistd_32.h             |   4 +
 linux-headers/asm-x86/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_x32.h            |   4 +
 linux-headers/linux/iommufd.h                 | 224 +++++++++++++++++-
 linux-headers/linux/kvm.h                     |   8 +
 linux-headers/linux/psci.h                    |   5 +
 linux-headers/linux/vfio.h                    |   2 +-
 target/s390x/cpu_features.c                   |  11 +
 target/s390x/cpu_features.h                   |   1 +
 target/s390x/cpu_features_def.h.inc           |  94 +++++++-
 target/s390x/cpu_models.c                     |  61 +++++
 target/s390x/gen-features.c                   | 178 ++++++++++++++
 target/s390x/kvm/kvm.c                        |   6 +
 39 files changed, 851 insertions(+), 29 deletions(-)

-- 
2.43.5


