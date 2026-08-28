Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817CFC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpkV-00054k-D7; Fri, 28 Aug 2026 02:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkT-00054M-P3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkR-0000a5-Ke
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22rkX679496
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=SM5FMmDbSspQAeDXsBl2OTbjrI6C
 C87fU1fxWbxfeDs=; b=ekqdEF7z/lxql1vnX6eKEij4NBMovmgCFdj9Ch/R6UK7
 cJsirftKleNbXNkrdB3T4hOYSLPAvEKCtyCA8HKF4PzN21NaRZnYINDQ4waFk23I
 5c/ns067BZH8YuYdAmpB7e+v2Ts48H6Mb0GMyCIW08dZj5h3V2I0RwkfRsU5JKAX
 YDntmkgozvKH07dOC2BmG4LU6slgPzfdjOFJe0XpKQbzZK0gtbvI6mIDGaKZz504
 kW6T67XcQhnZRkooJTx7BB2wO1RW59HiBlwfdGiss/cBjuRcpbFtblzNlgS/UTiR
 +d7cWdTluD5OkkJLvMlASdthWh2PN1JBVtPCnJyGvg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uJ91025847
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwmpyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67P1047513906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 720CF20040
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D070020043
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:24 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:24 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] ppc-for-11.2 queue
Date: Fri, 28 Aug 2026 11:36:35 +0530
Message-ID: <20260828060716.91672-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX9+1TmPHFAgkE
 nlEQf7ZwnhjnvC1s8gAWWKXx1QCe5m1A8vwfauQO26RegyF/3ItYwHYZqHXvzgT3JnSMp1XiHuF
 wgCcRwW+1lmZ1BQUZrUSvhV81m37Uu0=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9125a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=qp4i-BRBZYRMbXeXiI8A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 6PKY0nAB939dxDTgLWBjn5RhaE0KOpX5
X-Proofpoint-GUID: 6PKY0nAB939dxDTgLWBjn5RhaE0KOpX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX0w03m2uzOuZl
 NyhzRvFj3BfyuoYacnDd6PnmVb+rN1biRckLWAF8PsrrhMIz+5PPwEhAiBjki8lY/USyzAp3ZOG
 iJnSPjW/NaxzaHHIOlRFTEsvU5giDBow4p0JUjyE/ICAdAijazae80aHkyFAskef97bTGbqouqh
 tc8m38X9c1crETdlqEOfdF502XPFtODNrJXKsUuDz94mul/0KRMtgHVyRr7QR20sQf9vgL4jPtE
 ownzYq3B9Inzit/gl2WdzsQJSLFYoAx8FGPzFUNECmCC+60zaEa2S3d39lHPdNN5SLgWfceQ050
 aukDMiYkGed5VzsiC0Q5JE1E109X1+xg7kWoWGMCs2Gj5Pob6Vx1DiPZjmwLdK3EmGbPRELt1On
 jdsB4f1Ab/tHitrkfTMEbFTYw4a6otT96iwUWbVu3duPikdhYPzH1VdzXKp4DtWVRd5dBC5prYh
 IjavL75g6k4Pl+FD4fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 0a1ebd448b38afaa118597cbb633dbec24ef74d3:

  tcg/loongarch64: Fix compile issue LoongArch host (2026-08-27 11:04:01 -0700)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-20260828

for you to fetch changes up to fe511b25417e01f1fdb50dc8ce158db0b7522705:

  target/ppc: Add self as maintainer for PowerPC TCG CPUs (2026-08-28 11:09:28 +0530)

----------------------------------------------------------------
PPC patches for 2026-08-28
* TCG Improvements (decodetree migrations and ISA 2.07 flag updates)
* Compat mode fixes for nested guests
* XIVE fix for pending interrupts post migration
* MAINTAINERS: Chinmay transitioning as PPC TCG maintainer

Checkpatch errors can be ignored as suggested here:
https://lore.kernel.org/qemu-devel/846d7958-6515-4e4e-8c15-513e282aaaa3@linaro.org/

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmqRIDkACgkQRUTplPnW
j7srSQ/+Ob7CDbz5tK0D7jOdNMxdSIKjNaGgWWXtUsbEJcX59rCy3qwrvPMU6Hk7
MBPwIw7+d+IlxPeDeriQjI20JFt2h7QkdjJZBdNgt4zC7YtQxD/g2JCErsI3R1hu
/MC20tvIf9Yj7FywSJ52m1PZU1wWzP0ogGJvMzJtk6aFoe8CPhhNm5yomJnIW0BL
GrZxLIUzOwE/bV/e739Uge3bEXHzQaxmUi+U+PUnfnDm9XB4EZqxhh3Tf5NsqFQV
+xNIOdJCrc0Yz9wRXWiCz0osgRO5yl4c2CmUsUBOOoKo66KbbZ0LwrFoFV2gknuU
hYkuPeUHdQQfrUmYEGC8pYP0DHxwHBpbBYrSwtksaVGsg0zFcL2scQZFB2jzkXPO
37tVobFmpj6ABO7wFxKLwMd2YenZPTu9eN3A8GVbFzvizZxlEXfJ2CMU85jriFYf
gIx15ZBh2RICVK0spAbT3w9ABrLO0u3bb9RqSID2EGJIatxDwO8PlT02766VRDbS
dqoU0YuNGRxDdRzVDI036nQc4ige2xFR5rogEJcrK84P2UsdcMSEx+27VxXTQ5xk
HUMtybfONMqYptfnXZB1SRST+NVaS40ddlmyj5Kop64l/YdEno5IdcVdG5QtCIIE
14LXZd30f3kdt7b53VFyiI7bB305Ts9zQsglMmLoYhVqtgTq4o8=
=Vp0X
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aboorva Devarajan (3):
      target/ppc: Move vector merge instructions to decodetree
      target/ppc: Move vector pack instructions to decodetree
      target/ppc: Move GPR atomic load/store instructions to decodetree

Amit Machhiwal (5):
      linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
      target/ppc/kvm: Add support for querying host compatibility mode
      target/ppc/kvm: Use host compatibility mode for nested guests
      target/ppc: Move fixed-point Shift insns to decodetree
      target/ppc: Move fixed-point byte-reversal store insns to decodetree

Chinmay Rath (9):
      target/ppc: make do_ea_calc_ra available for 32 bit builds
      target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
      target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
      target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
      target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
      target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
      target/ppc: Reorder PPC2 flags
      target/ppc: Add ICBT support for ISA version 2.07
      target/ppc: Add self as maintainer for PowerPC TCG CPUs

Gautam Menghani (1):
      ppc/xive: Trigger the pending interrupt for a guest after migration

Mukesh Kumar Chaurasiya (IBM) (2):
      target/ppc: convert slw, srw instruction via decode spec
      target/ppc: convert sraw[i] instruction via decode spec

Nikhil Kumar Singh (3):
      target/ppc: Migrate extswsli to decodetree
      target/ppc: Migrate atomic loads to decodetree
      target/ppc: Convert cache instructions to decodetree

Ojaswin Mujoo (7):
      target/ppc: Move isync instruction to decodetree
      target/ppc: Convert b{a, l, la} to decode tree
      target/ppc: move various conditional branch insns to decodetree
      target/ppc: Fix TRANS* macro variadic arguments handling
      target/ppc: Move wait instruction to decodetree
      target/ppc: Move sleep & friends to decodetree
      target/ppc: Refactor sleep and its variants to use a common helper

Shivang Upadhyay (4):
      target/ppc: Move Condition Register access instructions to decodetree.
      target/ppc: Move Condition Register logical instructions to decodetree.
      target/ppc: Move Fixed-Point Load/Store String instructions to decodetree.
      target/ppc: Move VMX integer arithmetic and BCD instructions to decodetree.

Shivani Nittor (1):
      target/ppc: Convert mcrf to decode tree

Tanushree Shah (2):
      target/ppc: Move rlwimi, rlwinm instructions to decodetree
      target/ppc: Move lmw, stmw instructions to decodetree

Utkarsh Verma (1):
      target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree

Vishal Chourasia (3):
      target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
      target/ppc: Move byte-reverse instructions to decodetree
      target/ppc: Move system call and rfi instructions to decodetree

 MAINTAINERS                                    |    2 +-
 include/standard-headers/linux/const.h         |    4 +-
 linux-headers/asm-arm64/unistd_64.h            |    1 +
 linux-headers/asm-generic/unistd.h             |    6 +-
 linux-headers/asm-loongarch/unistd_64.h        |    1 +
 linux-headers/asm-mips/unistd_n32.h            |    1 +
 linux-headers/asm-mips/unistd_n64.h            |    1 +
 linux-headers/asm-mips/unistd_o32.h            |    1 +
 linux-headers/asm-powerpc/kvm.h                |   18 +
 linux-headers/asm-powerpc/unistd_32.h          |    1 +
 linux-headers/asm-powerpc/unistd_64.h          |    1 +
 linux-headers/asm-riscv/unistd_32.h            |    1 +
 linux-headers/asm-riscv/unistd_64.h            |    1 +
 linux-headers/asm-s390/unistd_64.h             |    1 +
 linux-headers/asm-x86/unistd_32.h              |    1 +
 linux-headers/asm-x86/unistd_64.h              |    1 +
 linux-headers/asm-x86/unistd_x32.h             |    1 +
 linux-headers/linux/const.h                    |    4 +-
 linux-headers/linux/kvm.h                      |    3 +
 target/ppc/cpu.h                               |   38 +-
 target/ppc/cpu_init.h                          |    7 +-
 target/ppc/helper.h                            |   96 +-
 target/ppc/internal.h                          |    7 -
 target/ppc/kvm_ppc.h                           |    7 +
 target/ppc/insn32.decode                       |  252 +++
 hw/intc/xive.c                                 |    3 +
 hw/ppc/spapr_caps.c                            |    2 +-
 hw/ppc/spapr_hcall.c                           |   14 +
 linux-user/ppc/elfload.c                       |    6 +-
 target/ppc/cpu_init.c                          |    6 +-
 target/ppc/int_helper.c                        |   76 +-
 target/ppc/kvm.c                               |   84 +
 target/ppc/mem_helper.c                        |   14 +-
 target/ppc/tcg-excp_helper.c                   |   18 +-
 target/ppc/translate.c                         | 2258 ++++--------------------
 target/ppc/translate/bhrb-impl.c.inc           |    4 +-
 target/ppc/translate/branch-impl.c.inc         |  182 +-
 target/ppc/translate/fixedpoint-impl.c.inc     |  947 +++++++++-
 target/ppc/translate/fp-impl.c.inc             |    4 +-
 target/ppc/translate/misc-impl.c.inc           |  172 ++
 target/ppc/translate/processor-ctrl-impl.c.inc |   39 +-
 target/ppc/translate/storage-ctrl-impl.c.inc   |  116 ++
 target/ppc/translate/vmx-impl.c.inc            |  457 +++--
 target/ppc/translate/vmx-ops.c.inc             |   59 +-
 target/ppc/translate/vsx-impl.c.inc            |   56 +-
 target/ppc/translate/vsx-ops.c.inc             |   24 +-
 46 files changed, 2624 insertions(+), 2374 deletions(-)

