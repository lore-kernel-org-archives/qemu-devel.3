Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A7CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXkvF-00015Z-JZ; Thu, 11 Jun 2026 15:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wXkvE-00015B-6i; Thu, 11 Jun 2026 15:18:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wXkvC-00088i-3u; Thu, 11 Jun 2026 15:18:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCEshp1742328; Thu, 11 Jun 2026 19:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=+jkPVLCV4+1lT13kc4vKx2dXh9jm96hSHVM72mrA72w=; b=KcTGFrOt3dmt
 I+x71H71aZtMS/aHzS6JLZrwDmiLi3PCmtCVTCE7zciKzkMlOudC5/zw0FlnB6M1
 vi9wnTZjOpzmUakV6EHrDtwnYiLOls5a9+aCaMyDJ9f+/+fL70/M63YtUTPgC5mv
 Vx1wvclaEA+CILYLN0HBBpId+eenNkKR3SH1tkZ7K9UYkw2EDwx+wk6iHpjDIDfg
 lkp7Za0wE7P2HvkTfgvmwK6xjCGcKQMAcVDR5a7YAXgL6hA9A2SHxC1LU9YRWpmj
 Z6/qOUGvWnvE1tNwX++N12mGDYVgkPkPquzQUSuXbGgFANSikk6qrApWclit96+T
 8j0x/oHsbg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bnckp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 19:18:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BJ4d1V003636;
 Thu, 11 Jun 2026 19:18:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09vn2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 19:18:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65BJISkg14746216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2026 19:18:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79AC85804B;
 Thu, 11 Jun 2026 19:18:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16FAC58059;
 Thu, 11 Jun 2026 19:18:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2026 19:18:26 +0000 (GMT)
Message-ID: <1c2a47848384c57ceb2d2ed929d3ccdf16d72ed3.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 sv@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
Date: Thu, 11 Jun 2026 14:18:26 -0500
In-Reply-To: <f96c5fde-b4d6-48ee-8778-7255ecb3236e@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <285fdd30-f22d-4d4b-b8ee-5f04fccfca6d@linux.ibm.com>
 <4ef1791085a32802185b2c68686aab273f4dfcbd.camel@linux.ibm.com>
 <f96c5fde-b4d6-48ee-8778-7255ecb3236e@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2b0a06 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=rW9r5uX3dROKkisGniEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5MiBTYWx0ZWRfX6BXLyqtuaDdC
 8uu52fqK/r4wnNcO9MpkzlUhwtQHyOeqx2/KWtXuKa/43xfXajKzIHwlx4KxQe5Em73aaCzBPRr
 llwdNAwewsUGRIcCe9pIdxCYcrRtmqlTXrYg8jer+hMZ2IAG2GZh04ajLJhYd1WtlC4nIpupMEE
 gIPFnBicx95qcaojQmdMRsH+COkgeHMORp1oVFclO52BH5CM5JjiFGSzevoRvtnsC5xpLq6HJ+G
 xWrYFsryB8fLdSLY/Tc2H8g2AYyP0Fkdgh8sq7iw0x36tmOZzLn0Z+TDelpSsXj4ZOKZqEPEWEr
 AXnORw2/+19g82czxceA5YMkisAHJEG/oEqxgQg367V2qqgzcE3pWms2J4wcyzQ+IIfy/gkNqBL
 6m2aqgU6/La4MzcJ5H9x5SLZAt/pSQWaz415PZEw3fmRhG3OFS9HyjjjT3lmRQu4Kwn0xMkFVYG
 /nSnwcKydQSijWRFAXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5MiBTYWx0ZWRfX8gLk+3PDrhhW
 xQ8NjDH6WHvWXm744nZJoyo+pEIYH52ABPEVSiQIYd88hAPE0+t+cStz2dTpC2X/gPqfKxTPFF7
 5mC/JFCni72UY0xkv9KMb1dKOO8PNR4=
X-Proofpoint-ORIG-GUID: 1a0YBX028gRjQwW6eeuGJDMwmOlD72HJ
X-Proofpoint-GUID: diPdYVJSBBhpSMZjwhO5SY2p4BhqiF0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110192
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-06-04 at 15:59 +0530, Chinmay Rath wrote:
> On 6/3/26 19:40, Miles Glenn wrote:
> > On Wed, 2026-06-03 at 17:09 +0530, Chinmay Rath wrote:
> > > On 5/20/26 21:37, Chinmay Rath wrote:
> > > > We recently had a QEMU decodetree hackathon at our org focusing on moving
> > > > instructions to decodetree specification. I have consolidated the patches
> > > > generated out of this effort in this series. Though I have done a round
> > > > of review on all of them, might share some more review comments later.
> > > > 
> > > > The checkpatch.pl script emits false error for a couple of patches which
> > > > are of the following nature :
> > > > 
> > > > TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
> > > > 
> > > > static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
> > > >                                                       ^
> > > > I see this happening in the last pointer argument in function
> > > > definitions after macros (like TRANS(..) in this case).
> > > > 
> > > > Richard, Peter, Stefan,
> > > > Could you please advise if it would be okay to have the above false
> > > > positive in the patches ?
> > > Hi Chao,
> > > I was wondering if you would be able to advise a way forward for this
> > > checkpatch issue ? TIA.
> > > > Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
> > > > Please note that check-python-tox and migration-compat-aarch64 from CI
> > > > fails in the upstream master branch as seen in the following:
> > > > https://gitlab.com/rathc/qemu/-/pipelines/2537246569
> > > > 
> > > > Thanks,
> > > > Chinmay
> > > Hi Glenn,
> > > If possible, would you like to have a look at this series when you get a
> > > chance ? TIA.
> > Hi Chinmay,
> > 
> > First, I'd like to thank you and everyone that worked on this for their
> > efforts!  This seems like one of those tasks that everyone knows is
> > needed but everyone would rather work on other more interesting things
> > (myself included).  I would like to take a look at this series when I
> > get the chance.  I do have a lot on my plate right now, but hopefully I
> > can get to it in the next week or so.
> > 
> > Thanks,
> > 
> > Glenn
> Sure Glenn, thanks !

I had a little time to look over the changes today and I didn't see any
major issues.  I did notice that the change, "Refactor sleep and its
variants to use a common helper", didn't seem related to moving things
into decodetree, so maybe that should be reviewed separately?  There
was also a lot of moving of implementation code out of translate.c into
more specific files, like fixedpoint-impl.c.inc.  This didn't seem
required in order to use decodetree either, so perhaps those changes
should be split out into another patch?

Otherwise, I think it looks pretty good.

Thanks,

Glenn


> -Chinmay
> > > Thanks,
> > > Chinmay
> > > > Aboorva Devarajan (3):
> > > >     target/ppc: Move vector merge instructions to decodetree
> > > >     target/ppc: Move vector pack instructions to decodetree
> > > >     target/ppc: Move GPR atomic load/store instructions to decodetree
> > > > 
> > > > Amit Machhiwal (2):
> > > >     target/ppc: Move fixed-point Shift insns to decodetree
> > > >     target/ppc: Move fixed-point byte-reversal store insns to decodetree
> > > > 
> > > > Mukesh Kumar Chaurasiya (IBM) (2):
> > > >     target/ppc: convert slw,srw instruction via decode spec
> > > >     target/ppc: convert sraw[i] instruction via decode spec
> > > > 
> > > > Nikhil Kumar Singh (3):
> > > >     target/ppc: Migrate extswsli to decodetree
> > > >     target/ppc: Migrate atomic loads to decodetree
> > > >     target/ppc: Convert cache instructions to decodetree
> > > > 
> > > > Ojaswin Mujoo (7):
> > > >     target/ppc: Move isync instruction to decodetree.
> > > >     target/ppc: Convert b{a, l, la} to decode tree
> > > >     target/ppc: move various conditional branch insns to decodetree
> > > >     target/ppc: Fix TRANS* macro variadic arguments handling
> > > >     target/ppc: Move wait instruction to decodetree
> > > >     target/ppc: Move sleep & friends to decodetree
> > > >     target/ppc: Refactor sleep and its variants to use a common helper
> > > > 
> > > > Shivang Upadhyay (4):
> > > >     target/ppc: Move Condition Register access instructions to decodetree.
> > > >     target/ppc: Move Condition Register logical instructions to
> > > >       decodetree.
> > > >     target/ppc: Move Fixed-Point Load/Store String instructions to
> > > >       decodetree.
> > > >     target/ppc: Move VMX integer arithmetic and BCD instructions to
> > > >       decodetree.
> > > > 
> > > > Shivani Nittor (1):
> > > >     target/ppc : Convert mcrf to decode tree
> > > > 
> > > > Tanushree Shah (2):
> > > >     target/ppc: Move rlwimi, rlwinm instructions to decodetree
> > > >     target/ppc: Move lmw, stmw instructions to decodetree
> > > > 
> > > > Utkarsh Verma (1):
> > > >     target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
> > > > 
> > > > Vishal Chourasia (3):
> > > >     target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
> > > >     target/ppc: Move byte-reverse instructions to decodetree
> > > >     target/ppc: Move system call and rfi instructions to decodetree
> > > > 
> > > >    target/ppc/helper.h                           |  100 +-
> > > >    target/ppc/insn32.decode                      |  244 ++
> > > >    target/ppc/int_helper.c                       |   76 +-
> > > >    target/ppc/internal.h                         |    7 -
> > > >    target/ppc/mem_helper.c                       |   18 +-
> > > >    target/ppc/tcg-excp_helper.c                  |   10 +-
> > > >    target/ppc/translate.c                        | 2592 ++++-------------
> > > >    target/ppc/translate/branch-impl.c.inc        |  181 ++
> > > >    target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
> > > >    target/ppc/translate/misc-impl.c.inc          |  175 ++
> > > >    .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
> > > >    target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
> > > >    target/ppc/translate/vmx-impl.c.inc           |  360 +--
> > > >    target/ppc/translate/vmx-ops.c.inc            |   41 -
> > > >    14 files changed, 2529 insertions(+), 2358 deletions(-)
> > > > 


