Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCa9-0000Dx-8S; Wed, 12 Aug 2026 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZo-0000Ar-K3; Wed, 12 Aug 2026 13:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZm-0000oE-AJ; Wed, 12 Aug 2026 13:17:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1U3l2217828; Wed, 12 Aug 2026 17:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Tl1lKCHRhNK+gdSaGRFd/2evLFj4xEySAUYuf0tuB
 kw=; b=OPIMpeRXzuxxnRAlCn7IFUJL9eZRtwouj9lpBW1adqhKPHpA01R/OdvY1
 WCuLc0/psrg+6tU12gklovmMonG7WNjfghtH2jfosuKa7rg48/ehTpUnSQPDwMzi
 CaOsLFrMO1G6xtVLUcvH26zoOg6dT4hhIy5lnHhJexlu4OsBWWBmHmG0OHNnb022
 B3eMk24M+tGgWuXNVB9PsiB7efvcVHL4EnSKMMqWrF/M7zWyfNghTbBSglKHkpp1
 XCwhub685VKKSv2IdKhAvAmntXys1xLDBzY2hGs325M1TFKvhmGiAB7PUuMV1E79
 l1KI0xQ4TdXSyT1dqjxt+kHRGsEEQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk03qav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBObI008043;
 Wed, 12 Aug 2026 17:17:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w78cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHH9RY24183384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB9AD5805C;
 Wed, 12 Aug 2026 17:17:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65CCE5805A;
 Wed, 12 Aug 2026 17:17:09 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:09 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 00/15] s390x queue
Date: Wed, 12 Aug 2026 13:16:52 -0400
Message-ID: <20260812171707.1605637-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX4fwyk9Vo8W5V
 IJV22TP/uaBdyxqH6VRBVQHqpDRSCj/PvJu+q4/wZoX18pqdDjoB6Xxg4L4K8pvMsqV5t1HQ9bs
 Mq6o9GeyRnWXqLX65KuDvH1RgJxGuOfkRc+mN+4gdGAk59WLbZHU8Pdq1G2D7PGEwin1RaAnyAS
 I2kBIIxiuaebvpLLS7Rpk17QRjzR8GkVtKyfqE7skTQthY5YYHL6rfvqgamOKttT/xSX9Nmt2Xp
 rcKqq2+xqYaKhmIRnfVcMwv96nSzmjbScpyS7FaLDLuZ5Ss72AIs+8uGUjdvi1ySnMTXRlWoDoZ
 JIBkrNE4vLXYbWDqYDj91tYnXL5S8xSwCirOxTFA7Y2ZA9vwJMOxneqAh/fcC1yE3OsP8Pdntfv
 UrZAB38+NiCvBc87plHQ0+0vLDa4KhP0mPJbGOoTF/bliZLW5OTrpt9YmHTyvKyf/eOcYbiW7/w
 dT/ioipZPCyjBnJMezg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX+ZGzEcvf4weW
 ESrzZhDdrk2u4+youzGr4mIYFQijvVZiqeIDVyjjeZXgKB+yOdmFt9WbTs5kTZP4YVXSXSxiS1e
 dYCS3RhSXvL03KtOAhyrYEU/Mx8Auwg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7caa98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8 a=dDm5mMPXSCKf8wx44mcA:9
X-Proofpoint-GUID: L3l2LoUwovk6sPwxT5aevdPqBfqR_HPU
X-Proofpoint-ORIG-GUID: L3l2LoUwovk6sPwxT5aevdPqBfqR_HPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e22:

  Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20260812

for you to fetch changes up to 9b3d68edb24d4e04f49822c6e11641e4eb23dfd5:

  pc-bios/s390-ccw.img: update s390x bios (2026-08-12 11:13:28 -0400)

----------------------------------------------------------------
First batch of s390x updates for 11.2:
 - compat machines for 11.2
 - allow guest backing with 2G hugepages
 - fixes to TCG (and a couple tests on them)
 - hardening fixes in boot/sclp code
 - regenerate s390-ccw.img

----------------------------------------------------------------

Christian Borntraeger (1):
  hw/char/sclpconsole-lm: avoid guest triggerable assert

Claudio Imbrenda (1):
  target/s390x: Allow 2G hugepages guest backing

Cornelia Huck (1):
  hw: add compat machines for 11.2

Eric Farman (1):
  pc-bios/s390-ccw.img: update s390x bios

Ilya Leoshkevich (6):
  target/s390x: Make PRNO TRNG interruptible
  tests/tcg/s390x: Test PRNO TRNG interruptibility
  target/s390x: Fix DR/D INT64_MIN / -1 host crash
  tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
  target/s390x/tcg: Set STCK/STCKF condition code after the store
  tests/tcg/s390x: Test STCKF condition code on a faulting store

Jared Rossi (1):
  pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries

Joshua Daley (4):
  s390x/ipl: validate num_comp against iplb length before iterating
  pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
  pc-bios/s390-ccw: bounds-check zipl menu entry index before array
    write
  pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in
    zipl_print_entry

 hw/arm/virt.c                    |   9 ++++-
 hw/char/sclpconsole-lm.c         |   3 +-
 hw/core/machine.c                |   3 ++
 hw/i386/pc.c                     |   3 ++
 hw/i386/pc_piix.c                |  13 +++++-
 hw/i386/pc_q35.c                 |  13 +++++-
 hw/loongarch/virt.c              |  11 ++++-
 hw/m68k/virt.c                   |   9 ++++-
 hw/ppc/spapr.c                   |  15 ++++++-
 hw/s390x/ipl.h                   |   6 +++
 hw/s390x/s390-virtio-ccw.c       |  14 ++++++-
 include/hw/core/boards.h         |   3 ++
 include/hw/i386/pc.h             |   3 ++
 include/hw/s390x/ipl/qipl.h      |   2 +
 pc-bios/s390-ccw.img             | Bin 104136 -> 104216 bytes
 pc-bios/s390-ccw/bootmap.c       |   6 ++-
 pc-bios/s390-ccw/helper.h        |  10 +++++
 pc-bios/s390-ccw/menu.c          |  42 +++++++++++++++----
 pc-bios/s390-ccw/netmain.c       |  11 +++--
 pc-bios/s390-ccw/s390-ccw.h      |   4 +-
 target/s390x/diag.c              |   2 +-
 target/s390x/kvm/kvm.c           |  36 ++++++++---------
 target/s390x/kvm/kvm_s390x.h     |   2 +-
 target/s390x/kvm/stubs.c         |   2 +-
 target/s390x/tcg/crypto_helper.c |  22 +++++++---
 target/s390x/tcg/insn-data.h.inc |   4 +-
 target/s390x/tcg/int_helper.c    |   3 +-
 target/s390x/tcg/translate.c     |   2 +
 tests/tcg/s390x/Makefile.target  |   2 +
 tests/tcg/s390x/div.c            |  37 +++++++++++++++++
 tests/tcg/s390x/prno-trng.c      |  67 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/stckf.c          |  44 ++++++++++++++++++++
 32 files changed, 344 insertions(+), 59 deletions(-)
 create mode 100644 tests/tcg/s390x/prno-trng.c
 create mode 100644 tests/tcg/s390x/stckf.c

-- 
2.55.0


