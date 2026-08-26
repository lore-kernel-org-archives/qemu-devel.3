Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61121C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5tT-0005Wi-Jj; Wed, 26 Aug 2026 01:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5tS-0005WV-HH; Wed, 26 Aug 2026 01:09:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5tQ-0004vK-GN; Wed, 26 Aug 2026 01:09:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VueH2716654; Wed, 26 Aug 2026 05:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=etk0TCHrp5Qgpd7po0BRtCzpNZDN
 H5AijVClPuCfnd4=; b=qwUYWyiiQE09GCMdwExPbYBBdlrWSt26qQyyFmfEENHW
 BDAHlOSM+KyGWTbKEhEr8h7Dw1LLoNQs28TXUGquqoNrBM9O8yGYufYeb3Nrctv5
 aGKbOGfpjuIy+kskYMG/bnwfyAJJtyPwuKce+NkkdXF+QtNFcqoguqpwFY3mv5xj
 V2YlaPvPQNAlv3TYrb8T8eKKMMbwI74fKILeTddCxOAMDx90T1+WFiADvkDxe83h
 zxlF6MRTS1wuwASMDx1zYHz+or6f20cr7s6u3o6Rbh/Y4RUZBJi0dpyEZJp4JFZY
 b7Nlb5kuNe3DTwx1y9norCjsYE0NYsiM6YwbhPWGGw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hvrdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:09:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4uH55011616;
 Wed, 26 Aug 2026 05:09:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8ak4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:09:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q59bfU38404414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:09:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BEC420040;
 Wed, 26 Aug 2026 05:09:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CFF920043;
 Wed, 26 Aug 2026 05:09:32 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:09:31 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 00/37] target/ppc: PPC TCG Improvements (decodetree
 migrations + ISA 2.07 flag updates)
Date: Wed, 26 Aug 2026 10:38:26 +0530
Message-ID: <20260826050923.74756-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX6xjr3ss09cSb
 h5NeE7ju13ewZfNDV+to4vD7CW4f8q0v5+X0kXiFTkoAYaN0wBXIA78tfxKCvHRDKiR+wXi6G9S
 CRzkXDO5mf8rrOsdSochJkUszNPVC3c=
X-Proofpoint-GUID: 6PQZDg3N3N1-9DXVmMmF_geC8taXt0Da
X-Proofpoint-ORIG-GUID: mtRSw-fYgq7nkxiz7lNV0Rs2FZZ_x02-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXzm8sp3fgxxh1
 lvZ3ol4mqWBgfC+gspJebDv6zQKvsj9LMd5jlAhPzEiCCWwfiHtb6bv14ZiGS1VEEmO0n1B1PVL
 HSDQS46lExnJZRFK7jBkjHxYrPgRjCfsRboykg9Uu3REKev446EhBA0AxLiTJaWmfdI8Iit1If7
 Cm3HoB5xQHT5LqAmQXTWAmVJ4rGs4qg5z9KMWGmv76hPT7bBsHLXNX1gsZGaHWIGj0Q9vuLEwb4
 0yY04C/6/j8vzQeyqZgd9MKANi3det+ExW2CSXvuFoHzH28aNyC5rUqTOhHVcA5RrZJgEtoK2h4
 PZGDytv6hWA+k1/vwS8W1YOYKNpHM7/Skoi88RJEUiDHpkfYj0Brp+Uk1HWbwsfrTynMPrG385v
 IeSGh6RHUV0GDosGBAUgA6a0N8FJjD5mbC9GW51dPJfoQTQHD3sL3tCA6MOE98S2Nb9zJ4wxW09
 PtKwvFJ+70hc6eLaAyQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8e7516 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=f0ZxCjuzLixylr5JRsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

This series primarily contains 3 changes :

1. PPC instructions movement to decodetree specification (Only patch 19 needs Rb)
Link to the original v1 : https://lore.kernel.org/qemu-devel/20260820140114.327023-1-rathc@linux.ibm.com/
Changes from v1 :
- Patch 19 commit log updated as suggested by Glenn.
- Retained Rbs received.

2. PPC ISA 2.07 flag cleanup and updates (Already reviewed)
Link to the original v2 : https://lore.kernel.org/qemu-devel/20260820142717.337686-1-rathc@linux.ibm.com/
This series is based on top the above decodetree series.
- No changes. Only Rbs added.

3. Stepping up as an active maintainer for PowerPC TCG CPUs module.


Aboorva Devarajan (3):
  target/ppc: Move vector merge instructions to decodetree
  target/ppc: Move vector pack instructions to decodetree
  target/ppc: Move GPR atomic load/store instructions to decodetree

Amit Machhiwal (2):
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

Mukesh Kumar Chaurasiya (IBM) (2):
  target/ppc: convert slw, srw instruction via decode spec
  target/ppc: convert sraw[i] instruction via decode spec

Nikhil Kumar Singh (3):
  target/ppc: Migrate extswsli to decodetree
  target/ppc: Migrate atomic loads to decodetree
  target/ppc: Convert cache instructions to decodetree

Ojaswin Mujoo (7):
  target/ppc: Move isync instruction to decodetree.
  target/ppc: Convert b{a, l, la} to decode tree
  target/ppc: move various conditional branch insns to decodetree
  target/ppc: Fix TRANS* macro variadic arguments handling
  target/ppc: Move wait instruction to decodetree
  target/ppc: Move sleep & friends to decodetree
  target/ppc: Refactor sleep and its variants to use a common helper

Shivang Upadhyay (4):
  target/ppc: Move Condition Register access instructions to decodetree.
  target/ppc: Move Condition Register logical instructions to
    decodetree.
  target/ppc: Move Fixed-Point Load/Store String instructions to
    decodetree.
  target/ppc: Move VMX integer arithmetic and BCD instructions to
    decodetree.

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

 MAINTAINERS                                   |    2 +-
 hw/ppc/spapr_caps.c                           |    2 +-
 linux-user/ppc/elfload.c                      |    6 +-
 target/ppc/cpu.h                              |   38 +-
 target/ppc/cpu_init.c                         |    6 +-
 target/ppc/cpu_init.h                         |    7 +-
 target/ppc/helper.h                           |  100 +-
 target/ppc/insn32.decode                      |  254 ++
 target/ppc/int_helper.c                       |   76 +-
 target/ppc/internal.h                         |    7 -
 target/ppc/mem_helper.c                       |   18 +-
 target/ppc/tcg-excp_helper.c                  |   18 +-
 target/ppc/translate.c                        | 2297 +++--------------
 target/ppc/translate/bhrb-impl.c.inc          |    4 +-
 target/ppc/translate/branch-impl.c.inc        |  183 +-
 target/ppc/translate/fixedpoint-impl.c.inc    |  938 ++++++-
 target/ppc/translate/fp-impl.c.inc            |    4 +-
 target/ppc/translate/misc-impl.c.inc          |  170 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |   38 +-
 target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
 target/ppc/translate/vmx-impl.c.inc           |  457 ++--
 target/ppc/translate/vmx-ops.c.inc            |   59 +-
 target/ppc/translate/vsx-impl.c.inc           |   56 +-
 target/ppc/translate/vsx-ops.c.inc            |   24 +-
 24 files changed, 2494 insertions(+), 2387 deletions(-)

-- 
2.55.0


