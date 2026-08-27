Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97797C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaBh-00004y-2a; Thu, 27 Aug 2026 09:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaBf-0008WM-8e; Thu, 27 Aug 2026 09:30:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaBc-0001K4-Uj; Thu, 27 Aug 2026 09:30:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVchK3056424; Thu, 27 Aug 2026 13:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=S/M3EfSXYtFddxXPfZM7RFX43eYe
 w4NnJqkxSEOhqqQ=; b=Im5WahV0TJrTbZ29QsU/RhPHlyACac/hRfLaAEbvoXlb
 tfy2G8MI9ckJlCpNXb1pyGCB5d2hgr0cIV6dhiZ8+TLkmeZGEucOTDlfpuN1LvWI
 jhdh18V+mtkQGW97ixkzCStRPz5qAabqFIKtgwWZ8XFwYgxTTCaBY+AIoMQ7R4b1
 5S2H8prJjaCVSabrxu+tz8ZGU0NIKnbyctGx9Cb9zPAt320njE8fdjfe3MAfE3It
 mNPz0GoQNHlxol+ANBeSQjqWTgi1pvmfNGcrBVSZKh0/rLXuatFm69Bh0ieo4Z23
 cdplgG6b5oYyrifCKE5o25yK20A6Gvq+uqTp4FyaEw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn9a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:30:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQHb6003840;
 Thu, 27 Aug 2026 13:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwgcj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:30:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDUMBB31916634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:30:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CDE820043;
 Thu, 27 Aug 2026 13:30:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91A4B2004B;
 Thu, 27 Aug 2026 13:30:16 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:30:16 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 00/37] target/ppc: PPC TCG Improvements (decodetree
 migrations + ISA 2.07 flag updates)
Date: Thu, 27 Aug 2026 18:59:15 +0530
Message-ID: <20260827133010.278889-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXx7IxY4x4upg1
 OgU48ObMdvKqKntTg0U+YIoDAd+oMI5K9Isu9g5hkOQqmyn6tis5bfPsRSts1pEhC8hZwfRhx2U
 xHlzn92zEr33VWux2y1UqZogelbzTfo=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903bf5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SrywxPvrAqHmf2QoqzIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kgBhUnHX4xAY6mFuN_L0p4sxDf2rkaC7
X-Proofpoint-GUID: bdknaCrI4f49wEA_HiOiPf9eGo7r1C1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX4eq4w2y2jzjs
 qQbZQgYKQR7ZrXFtBUrnzXeLa2uuaQnnu9p9JOoyTyzPO1GEGr8YKCEiIZgix1vq7azCDvk9w3G
 F46txilgDWQp+GUzWrxJEDdXSGIU1V6qg7C0ZHyg/TIzxA7qWdWoGx01bcLUrUy3/QAgFcrTp1y
 pf6pVhtBXwLN7JVNxeryNA34fyKt00SpUGk7eCpAydbzaHJeHc2UL8A1YlIjqrpJPb2E/Dri/Gc
 pX9yFt1C3Ez90zgM0jqpeT2qL+cWStefdkGvKrRS0LiRXB2M+TOwD05yGWasrbslMjI05fjE+QS
 CY+cs/hoCMC+itkxWQ78BawsSGPImBmXnqYgnNpzgHzMZIOBNpArMazhvhrHKmCRJdRV1B/x8iW
 /TXRdJOGenZUXqCVtNgOT+C24gG3ELkUafn7pDZZEDiwYeiVW9vZkQStq3Wg8M366EbbSmMUOxa
 YxxOeFKtE4VJqqayTeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270109
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

1. PPC instructions movement to decodetree specification
Changes from v2 :
- Addressed review comments from Amit, as discussed in the v2 series.
- Retained Rbs received.

2. PPC ISA 2.07 flag cleanup and updates
This series is based on top the above decodetree series.
- No changes. Only Rbs added.

3. Stepping up as an active maintainer for PowerPC TCG CPUs module.

Link to v2: https://lore.kernel.org/qemu-devel/20260826050923.74756-1-rathc@linux.ibm.com/

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
  target/ppc: Move isync instruction to decodetree
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
 target/ppc/helper.h                           |   96 +-
 target/ppc/insn32.decode                      |  252 ++
 target/ppc/int_helper.c                       |   76 +-
 target/ppc/internal.h                         |    7 -
 target/ppc/mem_helper.c                       |   14 +-
 target/ppc/tcg-excp_helper.c                  |   18 +-
 target/ppc/translate.c                        | 2258 +++--------------
 target/ppc/translate/bhrb-impl.c.inc          |    4 +-
 target/ppc/translate/branch-impl.c.inc        |  182 +-
 target/ppc/translate/fixedpoint-impl.c.inc    |  947 ++++++-
 target/ppc/translate/fp-impl.c.inc            |    4 +-
 target/ppc/translate/misc-impl.c.inc          |  172 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |   39 +-
 target/ppc/translate/storage-ctrl-impl.c.inc  |  116 +
 target/ppc/translate/vmx-impl.c.inc           |  457 ++--
 target/ppc/translate/vmx-ops.c.inc            |   59 +-
 target/ppc/translate/vsx-impl.c.inc           |   56 +-
 target/ppc/translate/vsx-ops.c.inc            |   24 +-
 24 files changed, 2473 insertions(+), 2369 deletions(-)

-- 
2.55.0


