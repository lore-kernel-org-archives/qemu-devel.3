Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687FACD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUjyy-0004vT-Hc; Wed, 03 Jun 2026 07:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wUjys-0004uT-5l; Wed, 03 Jun 2026 07:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wUjyp-0004w7-Ur; Wed, 03 Jun 2026 07:41:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65385KxW2915774; Wed, 3 Jun 2026 11:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NbUreS
 SuPQuDNNpxQQ98+BHiEWnwj9quqxozkYxYJg8=; b=IKSHOwZ5NLrRy/9CqxamWh
 E4ie7LwpzUSVr9LeaRbp9aqJu3nHGTpzP9s+rMzLS4WSVF/np2DInH57OOHu7RC1
 VFPrIGLcvpXKAldlLXGKcgfjy6bxY4aFj/ji/uxWczFP4gULJlnlf6CWuRlXFQXK
 O+8n00nm98D8sO9aoHBZcXQtBDVDK4Y7WF5ocLreA1WJ1dxyYU7yRXAlzn/hdR87
 rczVM5kxN7SGIsEGBYjOsnPfY6mhVbgQdihT7AQSqHturpeAM+HlR/aY1d5wcGvY
 90sjpjPWB6zlBYtwONqPFXc6xSma9Jqm3rVlOQR3Qo3aUhk5h7trTeNvcvEUpPag
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4apqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 11:41:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Bd7il029798;
 Wed, 3 Jun 2026 11:41:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k7y9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 11:41:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653BfePr33423928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jun 2026 11:41:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8767358055;
 Wed,  3 Jun 2026 11:41:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AB5658059;
 Wed,  3 Jun 2026 11:41:32 +0000 (GMT)
Received: from [9.124.223.250] (unknown [9.124.223.250])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  3 Jun 2026 11:41:31 +0000 (GMT)
Message-ID: <285fdd30-f22d-4d4b-b8ee-5f04fccfca6d@linux.ibm.com>
Date: Wed, 3 Jun 2026 17:09:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExMSBTYWx0ZWRfX46KoaX2xwqjo
 6w+RdVMhy63pAs4d/mirZqoDEeSa7iElWj0d7MNqlWDfGlPa1QZn7UD1LD9/B2NX2g0maBzu25R
 1ctTv6i3wQcC1QmF42ov6zYNRMd54OPwe/E5bZdQ5dlbvo9rHWyPQ+Y8PhxOik97QnlhY/A04Nz
 nS4oR87v1TKgBKb/TmQS5U2Iow0NNs/xxCX7/TXj/1N6BpF6vpv8ebdhMhfdsd8FXaEaF3a80W/
 1pwe+4BYFwkdJdl3c1nJW8pJgSHe5G4SU9kcEBp0bXB0D9iVDGPQ8GXYbkXdwoWt9zk8pMiS/cV
 Tm7qI4y9dDKsXeDaJTHtBOaqurKj5TJqlQJwrEkWIPe9QvRCYZjNL0MCT0A6lfISpw9PC3Imj50
 ER+efncQ150exx0FssA3j2NQMb1ROmP9BCD/9KzmNjAFh4EjqOAof3DgzZr7gKp+rl6RN72s6Td
 qTU2c8qoS492y/LVdAw==
X-Proofpoint-GUID: CJlC5dhijTvIsvGPpVtara6NXqmRIpbp
X-Proofpoint-ORIG-GUID: PH6VcVIWhzsDgRJJGh2qfVEv01KAxK0B
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2012f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=h1SniR8Z0XukoVBHosoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 5/20/26 21:37, Chinmay Rath wrote:
> We recently had a QEMU decodetree hackathon at our org focusing on moving
> instructions to decodetree specification. I have consolidated the patches
> generated out of this effort in this series. Though I have done a round
> of review on all of them, might share some more review comments later.
>
> The checkpatch.pl script emits false error for a couple of patches which
> are of the following nature :
>
> TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
>
> static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
>                                                      ^
> I see this happening in the last pointer argument in function
> definitions after macros (like TRANS(..) in this case).
>
> Richard, Peter, Stefan,
> Could you please advise if it would be okay to have the above false
> positive in the patches ?
Hi Chao,
I was wondering if you would be able to advise a way forward for this 
checkpatch issue ? TIA.
> Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
> Please note that check-python-tox and migration-compat-aarch64 from CI
> fails in the upstream master branch as seen in the following:
> https://gitlab.com/rathc/qemu/-/pipelines/2537246569
>
> Thanks,
> Chinmay
Hi Glenn,
If possible, would you like to have a look at this series when you get a 
chance ? TIA.

Thanks,
Chinmay
> Aboorva Devarajan (3):
>    target/ppc: Move vector merge instructions to decodetree
>    target/ppc: Move vector pack instructions to decodetree
>    target/ppc: Move GPR atomic load/store instructions to decodetree
>
> Amit Machhiwal (2):
>    target/ppc: Move fixed-point Shift insns to decodetree
>    target/ppc: Move fixed-point byte-reversal store insns to decodetree
>
> Mukesh Kumar Chaurasiya (IBM) (2):
>    target/ppc: convert slw,srw instruction via decode spec
>    target/ppc: convert sraw[i] instruction via decode spec
>
> Nikhil Kumar Singh (3):
>    target/ppc: Migrate extswsli to decodetree
>    target/ppc: Migrate atomic loads to decodetree
>    target/ppc: Convert cache instructions to decodetree
>
> Ojaswin Mujoo (7):
>    target/ppc: Move isync instruction to decodetree.
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
>    target/ppc : Convert mcrf to decode tree
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
>   target/ppc/helper.h                           |  100 +-
>   target/ppc/insn32.decode                      |  244 ++
>   target/ppc/int_helper.c                       |   76 +-
>   target/ppc/internal.h                         |    7 -
>   target/ppc/mem_helper.c                       |   18 +-
>   target/ppc/tcg-excp_helper.c                  |   10 +-
>   target/ppc/translate.c                        | 2592 ++++-------------
>   target/ppc/translate/branch-impl.c.inc        |  181 ++
>   target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
>   target/ppc/translate/misc-impl.c.inc          |  175 ++
>   .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
>   target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
>   target/ppc/translate/vmx-impl.c.inc           |  360 +--
>   target/ppc/translate/vmx-ops.c.inc            |   41 -
>   14 files changed, 2529 insertions(+), 2358 deletions(-)
>

