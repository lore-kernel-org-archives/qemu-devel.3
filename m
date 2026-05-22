Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E979CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLGK-0001td-Ol; Fri, 22 May 2026 04:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wQLGJ-0001tR-Tq; Fri, 22 May 2026 04:29:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wQLGH-0005ma-VR; Fri, 22 May 2026 04:29:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LMOudt2818971; Fri, 22 May 2026 08:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hp8laJ
 1YbdJuWUCYzrXg/znq7QILkNLs/b+UFi2juPI=; b=Rf2EOLfu2tle1bpmiYottn
 vhUM6tW25T52vyCira9+WOghHypn6K7uQl4MuvnURoeCnAAW0ThMPUJ8Zz2YApDN
 NMXgP7Lau3mHHmHkltvX29pcnl6YANblbtkPX8tODLxHc0JEtcs+hhxAjTn9SYaI
 gmKdOVilji3ZsrHYXXXBIsiYeaqbW3l9fU1qLMcUSnqZio/RJgHEtR6uIpSZqYoM
 s2579pUBP1pt/x0dfwxbARSgPuVJygJtZ67c2h6wJYtO+eBSiKPqQNFkCQ/umkzM
 MgLgJRGLsQUKi+RXbJG0e05G6dxdziN9zJj5VmxWC0ppKyCFzYU1wJKY90VkZFSA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9yb62h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:29:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M8ORRh030398;
 Fri, 22 May 2026 08:29:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj01qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:29:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64M8TVZS27328802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 08:29:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A07EE2004D;
 Fri, 22 May 2026 08:29:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A81B20040;
 Fri, 22 May 2026 08:29:28 +0000 (GMT)
Received: from [9.123.2.84] (unknown [9.123.2.84])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 08:29:28 +0000 (GMT)
Message-ID: <ca4dfe89-78ea-4fc1-bb0c-71650ca2d8f8@linux.ibm.com>
Date: Fri, 22 May 2026 13:59:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 sv@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MCBTYWx0ZWRfX9vQwj5Zlw64H
 sqXLWiNl7BjOsufC1QvNFH8MABFB0r6b9MiTVPterDDok3OwYhquFNxlh9dKcIHxSRIcOyOUWbf
 JUIDwOV2d5YXPwCpkYLI5MYckTzMHqz+voNOPU6KXraXZxCiJJEcmzceAP8Eg9utOT+zfNK3IEn
 +MJiiQMEdICd/mOJJNRIQVvRbgbsphIVqSgdn4G6Pu5MlA8Xp1SprrUYt4GslWu7J5/dqsZ0IOs
 omEOAiqfPkogOVPqShMkkLxedb8nnETaYycqUzpmkNisq0Y3PUY1n4qUbW071Ct9xdNvT5f8UhQ
 7Dquz86YsJ1++NS/nRfhaG8bM+k2XJe4Obt9hflBueAAtXOQvglrZJdFkCMDv6Xmy6IzF/rIJws
 HeORzVBn9KZht4AIHl0aigHuUrM4064INqOBCDe+0JMgyaIDI5kMr7Kan+vXxmVgI1Jjs1EmlyJ
 4EkH1VgeTnriVvL/6Hg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a1013f1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=h1SniR8Z0XukoVBHosoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Z__rRd0q3FcLBG3Sda84bFSGtaprip0p
X-Proofpoint-GUID: ME4dhm5xZSnRkTV9FpYZxUa8VOGJeLte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
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

Hi All,

I see there is a test case that fails during the CI run.
https://gitlab.com/rathc/qemu/-/jobs/14481511189/

Looking into it

Thanks,
vishalc

On 20/05/26 21:37, Chinmay Rath wrote:
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
>
> Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
> Please note that check-python-tox and migration-compat-aarch64 from CI
> fails in the upstream master branch as seen in the following:
> https://gitlab.com/rathc/qemu/-/pipelines/2537246569
>
> Thanks,
> Chinmay
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

