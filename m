Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA02CC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaIL-0006c7-Uj; Thu, 27 Aug 2026 09:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaIK-0006Zp-Bz; Thu, 27 Aug 2026 09:37:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaII-0003Jj-Bw; Thu, 27 Aug 2026 09:37:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVdhQ1871545; Thu, 27 Aug 2026 13:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cqxqjg
 sJK6Qvtm3QYpSzMNsRdnVs0RprR0MXJ39k4+I=; b=azVSvfrfsUDsnV7ye4/o/6
 oLa442pUf9NL8LXiuNrT1teLCdSA3VhQenIwp+S32ggRX5lHDp21v54sTyyQJiRr
 qv/qVKpMoLkEqZu6pJ6oWDuxJygrwvrmZngyoCsOaX9AmaT5B1EvBi7FH3JMrRtp
 VUEI5MLd5KWDsHPcyuJ50j44rH0zvGm2oh3DVfPzllFrFpvHrcEGvmQ2yNRjv5Nr
 IBoOu6Xz9OgwMBxQ9x3R3OtcLFSbL17ng43+Vks1tf46avzS6yLhiFAmMhQf9RNl
 Q/AGACntNB1aMej3v/nGgL/E+b3PYpZGQZRSXuGRdtMc9+WeitcV1+xsBi2q/qTg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ewhun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:37:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQIOh027485;
 Thu, 27 Aug 2026 13:37:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyg28p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:37:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDbLkX14942732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:37:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D9A5805A;
 Thu, 27 Aug 2026 13:37:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0BBC58056;
 Thu, 27 Aug 2026 13:37:19 +0000 (GMT)
Received: from [9.111.12.1] (unknown [9.111.12.1])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:37:19 +0000 (GMT)
Message-ID: <590b897c-2b1c-4eb9-a1f5-3d4eb7235350@linux.ibm.com>
Date: Thu, 27 Aug 2026 19:07:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] target/ppc: PPC TCG Improvements (decodetree
 migrations + ISA 2.07 flag updates)
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 asahu1x@linux.ibm.com
References: <20260827133010.278889-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a903d94 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qNCrWNZkRuKrpyOj1ycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX4KHkvc0KdOwJ
 Tx8ojunk5s1ybvl9jCNewhHChyaf1FjKOfkBWxPJUPlYZwTQOlQxtfhaAD2TYOrLF34DkA7Y8wG
 4oO0sbUEhML3rxGgzMsfO5DVPDigFWc=
X-Proofpoint-GUID: iB1NrrfA_G6j31L6Xl7qc6AjN64HSJ2P
X-Proofpoint-ORIG-GUID: iB1NrrfA_G6j31L6Xl7qc6AjN64HSJ2P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX6t30tTM/nX0h
 aRNKlEXRBGwNqUut9fPKiFMkAQPToHLyCeTJr3mB3+rndFqyOr+b6iILUS/wjN0ONJQu2iZXG0y
 FKWLG6wi+JzyuuNHmyR4M6TOThIOetVBEJkzyMbmF1cl//BxXK8DjQMYbZMJkyM6xFWERUEfSBK
 7Y63ql4IIw0Z/nQrYOMzv7A2MpJ8IXqWFhgdt4iP5c76OUsUrE5Rfx2HQUp8tSZgKYqfyneibHA
 7PvDapm3QrIDfh6ddjDwR6x9BMq2x7zDu0tsypjXqGU2o/L9MhILUNewSZmxY0xEDz02j3Ekf5a
 tALRSdgCV1uuAcGJrD319RdR0M4bMm9tIc+1Rh8PxLyyTE35Z9bq9xh45hMhs+ZsQ9XZvt16IVo
 m2n5oeDz7w+VVFI4jNUO8opfHLfjmGnjhgvYYbTyGVfw9TbgWN31yAPdJoP38KBfHbVuy8WFTju
 L4Do4eQE9sbNI1AnelQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113
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


On 8/27/26 18:59, Chinmay Rath wrote:
> This series primarily contains 3 changes :
>
> 1. PPC instructions movement to decodetree specification
> Changes from v2 :
> - Addressed review comments from Amit, as discussed in the v2 series.
> - Retained Rbs received.
>
> 2. PPC ISA 2.07 flag cleanup and updates
> This series is based on top the above decodetree series.
> - No changes. Only Rbs added.
>
> 3. Stepping up as an active maintainer for PowerPC TCG CPUs module.
>
> Link to v2: https://lore.kernel.org/qemu-devel/20260826050923.74756-1-rathc@linux.ibm.com/
Harsh,
Aniket's Tested-by is missing in this v3. v2 got the Tested-by after I 
had prepared the v3 patches, hence missed.

>
> Aboorva Devarajan (3):
>    target/ppc: Move vector merge instructions to decodetree
>    target/ppc: Move vector pack instructions to decodetree
>    target/ppc: Move GPR atomic load/store instructions to decodetree
>
> Amit Machhiwal (2):
>    target/ppc: Move fixed-point Shift insns to decodetree
>    target/ppc: Move fixed-point byte-reversal store insns to decodetree
>
> Chinmay Rath (9):
>    target/ppc: make do_ea_calc_ra available for 32 bit builds
>    target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
>    target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
>    target/ppc: Reorder PPC2 flags
>    target/ppc: Add ICBT support for ISA version 2.07
>    target/ppc: Add self as maintainer for PowerPC TCG CPUs
>
> Mukesh Kumar Chaurasiya (IBM) (2):
>    target/ppc: convert slw, srw instruction via decode spec
>    target/ppc: convert sraw[i] instruction via decode spec
>
> Nikhil Kumar Singh (3):
>    target/ppc: Migrate extswsli to decodetree
>    target/ppc: Migrate atomic loads to decodetree
>    target/ppc: Convert cache instructions to decodetree
>
> Ojaswin Mujoo (7):
>    target/ppc: Move isync instruction to decodetree
>    target/ppc: Convert b{a, l, la} to decode tree
>    target/ppc: move various conditional branch insns to decodetree
>    target/ppc: Fix TRANS* macro variadic arguments handling
>    target/ppc: Move wait instruction to decodetree
>    target/ppc: Move sleep & friends to decodetree
>    target/ppc: Refactor sleep and its variants to use a common helper
>
> Shivang Upadhyay (4):
>    target/ppc: Move Condition Register access instructions to decodetree.
>    target/ppc: Move Condition Register logical instructions to
>      decodetree.
>    target/ppc: Move Fixed-Point Load/Store String instructions to
>      decodetree.
>    target/ppc: Move VMX integer arithmetic and BCD instructions to
>      decodetree.
>
> Shivani Nittor (1):
>    target/ppc: Convert mcrf to decode tree
>
> Tanushree Shah (2):
>    target/ppc: Move rlwimi, rlwinm instructions to decodetree
>    target/ppc: Move lmw, stmw instructions to decodetree
>
> Utkarsh Verma (1):
>    target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
>
> Vishal Chourasia (3):
>    target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
>    target/ppc: Move byte-reverse instructions to decodetree
>    target/ppc: Move system call and rfi instructions to decodetree
>
>   MAINTAINERS                                   |    2 +-
>   hw/ppc/spapr_caps.c                           |    2 +-
>   linux-user/ppc/elfload.c                      |    6 +-
>   target/ppc/cpu.h                              |   38 +-
>   target/ppc/cpu_init.c                         |    6 +-
>   target/ppc/cpu_init.h                         |    7 +-
>   target/ppc/helper.h                           |   96 +-
>   target/ppc/insn32.decode                      |  252 ++
>   target/ppc/int_helper.c                       |   76 +-
>   target/ppc/internal.h                         |    7 -
>   target/ppc/mem_helper.c                       |   14 +-
>   target/ppc/tcg-excp_helper.c                  |   18 +-
>   target/ppc/translate.c                        | 2258 +++--------------
>   target/ppc/translate/bhrb-impl.c.inc          |    4 +-
>   target/ppc/translate/branch-impl.c.inc        |  182 +-
>   target/ppc/translate/fixedpoint-impl.c.inc    |  947 ++++++-
>   target/ppc/translate/fp-impl.c.inc            |    4 +-
>   target/ppc/translate/misc-impl.c.inc          |  172 ++
>   .../ppc/translate/processor-ctrl-impl.c.inc   |   39 +-
>   target/ppc/translate/storage-ctrl-impl.c.inc  |  116 +
>   target/ppc/translate/vmx-impl.c.inc           |  457 ++--
>   target/ppc/translate/vmx-ops.c.inc            |   59 +-
>   target/ppc/translate/vsx-impl.c.inc           |   56 +-
>   target/ppc/translate/vsx-ops.c.inc            |   24 +-
>   24 files changed, 2473 insertions(+), 2369 deletions(-)
>

