Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31948CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSYcF-0006PZ-0V; Thu, 28 May 2026 07:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wSYcC-0006P3-SU; Thu, 28 May 2026 07:09:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wSYcA-0006xq-Gc; Thu, 28 May 2026 07:09:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RL6Zjw3426678; Thu, 28 May 2026 11:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=mv9lsgkiga7nEXSSwdaNczl05rcAFJ
 /pUnZo6t8EErM=; b=nmN9fZwTOJlMDtKacFKN8UXvpyJiKCkcl6SJ8EbIaRH7Ue
 66yYTo+iEI/b9dA8XG0Voy2WIQl4AlpEEb3k5uPuypKNxc/FX3BnscLbS3hxxQIZ
 nglgXbt1WTiiqodlsSNTpQ3KhS6PEYNkFviyohr+raeVC+dpP+uFs4MEpMRqfnjI
 3z5v844grxUt4hJ9/rlACWrmqk7vjGvNQgGykJSOxP7yaGIWihKnLNaZ1sFdOshP
 GCyRnblArcOqV2BWwNCZULMAMPAQmiulhIQHczW6GqVvc7sgk5Hdnn6J3HonxAoo
 nuCfmGoULMszmcNXpWi4hnVmkDIA3x86HEItvbLg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884jn8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 11:09:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SAs7qk011867;
 Thu, 28 May 2026 11:09:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7rqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 11:09:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64SB9I1O61342022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 11:09:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F151220043;
 Thu, 28 May 2026 11:09:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 932522004B;
 Thu, 28 May 2026 11:09:02 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.220.88])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 May 2026 11:09:01 +0000 (GMT)
Date: Thu, 28 May 2026 16:38:02 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 sv@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
Message-ID: <ahgiEkyC3vreEWbH@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <ca4dfe89-78ea-4fc1-bb0c-71650ca2d8f8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca4dfe89-78ea-4fc1-bb0c-71650ca2d8f8@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a182263 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-5pvrLmQvQ8hwVyCCD8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: zkdOMe5YcXQTM_VmRN2qbmgy8FWpa6gg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExMyBTYWx0ZWRfX9+/Giwdhl4tF
 9Bwe8uLPN1+mLXxmMsTjzM1BdR0ut9WCQGmE/av1YHGTBWvjSAzqNCCJ7b/1fOhcTHFpUCACrxV
 ekpgUWG1BJc708XQdRM2a3wp6x9TWHbj7WAhA/J1XYHxhE502mDNrCD8FjuD7w2BxQk6G74WRc4
 RmJLthQskUvBk+A7iCrbNn/b3fMg1cbFSoDgTFnnW5jq15jxpmLypFJs9sH1+kglQ/GzSlDuJxY
 8IH+fdp7A7UgU+ovGkOr35O/8gM/GP5Qcm4ab4Kxl68hLN8c5M7MN6wKifwaLzw6Sn/ZOiH1o0v
 8vPKll/hrXhyiN+zM/5CbvL1lsFSgvXBju6xhRGk+rKyQepbjFiTV5skJwmKeZPg9y3eXqe+9i1
 qnKKglBQu+H6v3QpEamTzPJNTXZIK1qI8Lr/vHR+QJXDXDcY7xYEetRNiND41uYIOydQ51cRsRP
 imk1CrLCgh3esC1GDbw==
X-Proofpoint-GUID: p7ZGLO_gogiINRbR8qD7rj-GkcrS4Bgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280113
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

On Fri, May 22, 2026 at 01:59:27PM +0530, Vishal Chourasia wrote:
> Hi All,
> 
> I see there is a test case that fails during the CI run.
> https://gitlab.com/rathc/qemu/-/jobs/14481511189/
> 
> Looking into it
Hi All,

In v1, do_rfi() effectively only handled user-only and 64-bit builds, so
on 32-bit qemu-system-ppc every rfi was treated as invalid.

OpenBIOS uses rfi to return from exceptions, so it got stuck in the
exception path and the test timed out.

I have a fix that restores the 32-bit system-emulation rfi path while
keeping rfid, hrfid, and rfscv 64-bit-only.
https://lore.kernel.org/all/20260528105907.623794-2-vishalc@linux.ibm.com/

Link to the Gitlab CI
https://gitlab.com/vishalc-ibm/qemu/-/pipelines/2558504095


Thanks,
vishalc
> 
> Thanks,
> vishalc
> 
> On 20/05/26 21:37, Chinmay Rath wrote:
> > We recently had a QEMU decodetree hackathon at our org focusing on moving
> > instructions to decodetree specification. I have consolidated the patches
> > generated out of this effort in this series. Though I have done a round
> > of review on all of them, might share some more review comments later.
> > 
> > The checkpatch.pl script emits false error for a couple of patches which
> > are of the following nature :
> > 
> > TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
> > 
> > static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
> >                                                      ^
> > I see this happening in the last pointer argument in function
> > definitions after macros (like TRANS(..) in this case).
> > 
> > Richard, Peter, Stefan,
> > Could you please advise if it would be okay to have the above false
> > positive in the patches ?
> > 
> > Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
> > Please note that check-python-tox and migration-compat-aarch64 from CI
> > fails in the upstream master branch as seen in the following:
> > https://gitlab.com/rathc/qemu/-/pipelines/2537246569
> > 
> > Thanks,
> > Chinmay
> > 
> > Aboorva Devarajan (3):
> >    target/ppc: Move vector merge instructions to decodetree
> >    target/ppc: Move vector pack instructions to decodetree
> >    target/ppc: Move GPR atomic load/store instructions to decodetree
> > 
> > Amit Machhiwal (2):
> >    target/ppc: Move fixed-point Shift insns to decodetree
> >    target/ppc: Move fixed-point byte-reversal store insns to decodetree
> > 
> > Mukesh Kumar Chaurasiya (IBM) (2):
> >    target/ppc: convert slw,srw instruction via decode spec
> >    target/ppc: convert sraw[i] instruction via decode spec
> > 
> > Nikhil Kumar Singh (3):
> >    target/ppc: Migrate extswsli to decodetree
> >    target/ppc: Migrate atomic loads to decodetree
> >    target/ppc: Convert cache instructions to decodetree
> > 
> > Ojaswin Mujoo (7):
> >    target/ppc: Move isync instruction to decodetree.
> >    target/ppc: Convert b{a, l, la} to decode tree
> >    target/ppc: move various conditional branch insns to decodetree
> >    target/ppc: Fix TRANS* macro variadic arguments handling
> >    target/ppc: Move wait instruction to decodetree
> >    target/ppc: Move sleep & friends to decodetree
> >    target/ppc: Refactor sleep and its variants to use a common helper
> > 
> > Shivang Upadhyay (4):
> >    target/ppc: Move Condition Register access instructions to decodetree.
> >    target/ppc: Move Condition Register logical instructions to
> >      decodetree.
> >    target/ppc: Move Fixed-Point Load/Store String instructions to
> >      decodetree.
> >    target/ppc: Move VMX integer arithmetic and BCD instructions to
> >      decodetree.
> > 
> > Shivani Nittor (1):
> >    target/ppc : Convert mcrf to decode tree
> > 
> > Tanushree Shah (2):
> >    target/ppc: Move rlwimi, rlwinm instructions to decodetree
> >    target/ppc: Move lmw, stmw instructions to decodetree
> > 
> > Utkarsh Verma (1):
> >    target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
> > 
> > Vishal Chourasia (3):
> >    target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
> >    target/ppc: Move byte-reverse instructions to decodetree
> >    target/ppc: Move system call and rfi instructions to decodetree
> > 
> >   target/ppc/helper.h                           |  100 +-
> >   target/ppc/insn32.decode                      |  244 ++
> >   target/ppc/int_helper.c                       |   76 +-
> >   target/ppc/internal.h                         |    7 -
> >   target/ppc/mem_helper.c                       |   18 +-
> >   target/ppc/tcg-excp_helper.c                  |   10 +-
> >   target/ppc/translate.c                        | 2592 ++++-------------
> >   target/ppc/translate/branch-impl.c.inc        |  181 ++
> >   target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
> >   target/ppc/translate/misc-impl.c.inc          |  175 ++
> >   .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
> >   target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
> >   target/ppc/translate/vmx-impl.c.inc           |  360 +--
> >   target/ppc/translate/vmx-ops.c.inc            |   41 -
> >   14 files changed, 2529 insertions(+), 2358 deletions(-)
> > 
> 

