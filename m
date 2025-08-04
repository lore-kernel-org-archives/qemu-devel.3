Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847EBC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0S4-0001AY-55; Mon, 04 Aug 2025 15:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uiz8T-00033U-Ss; Mon, 04 Aug 2025 13:38:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uiz8O-00062U-UA; Mon, 04 Aug 2025 13:38:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574CbdFk032462;
 Mon, 4 Aug 2025 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=kXQXYNeH6sDMBkqtuMibSavym928/HVAbUQIXW3IJDY=; b=oUnfV/ckpOsy
 xwCI0yu2bXAxYZpfbg7poJxHs49DlhntqzFiKvdoZQFE4fP687L0CVRCO8ykTjSP
 iRigLwofsQ4Vd5svGgMOSTuc0D96555HTv7FA6uhzNxslv1rm3RQYv+wZFq0Elsm
 pDRJoouht8X90QJ4S4wtOLDRBZn8tr9lardXcIpgU2uuiWgXcTmsFCBPRaDolKD9
 i4CgxwnkFrDoUYFh4w0wHTgN/FTCB81HtOa9AFoh78hDodqQSU6uvHg+68CEs5E+
 g4659hSAaYiApVEjBqlkt4eDeHmTpTSk/4nmOvwxOiDu1LUUMiJDQrT3uV62+ntq
 NXq8RL+6Mw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993paers-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 17:38:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 574HbncT028207;
 Mon, 4 Aug 2025 17:37:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993paerq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 17:37:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 574HWa10009807;
 Mon, 4 Aug 2025 17:37:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tf2nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 17:37:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 574HbvvH27525750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Aug 2025 17:37:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ECA758055;
 Mon,  4 Aug 2025 17:37:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 940A35804B;
 Mon,  4 Aug 2025 17:37:56 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Aug 2025 17:37:56 +0000 (GMT)
Message-ID: <dd46b9656f99b23a52f60b8d4150985e5934384d.camel@linux.ibm.com>
Subject: Re: [PATCH 00/50] ppc/xive: updates for PowerVM
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Mon, 04 Aug 2025 12:37:56 -0500
In-Reply-To: <56c95bf5-45bd-43c0-a6ca-62845b2bdca6@redhat.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <b192697a-f936-450d-8e19-6cb364b7e747@redhat.com>
 <D9X71WIPID90.1W1RJIDOU9DID@gmail.com>
 <56c95bf5-45bd-43c0-a6ca-62845b2bdca6@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G-vPGGvRlL9IHWZXAvdabgayB1nR41c0
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=6890eff8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-nMebG13ZnQKKsIKi0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k49kimEywWtG12rDKxAZOmkbtlxxOnW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5OCBTYWx0ZWRfXwt4QH7LetaCU
 TNy91vDWTluHlpMpH8AiNmSNib405D8VsCCQbKsujwkpm8YxxNOj+pPNAO6Y6ANcNq15dheJ8y+
 5Y5QNjAyBRUaI4xv7UyaQFGZDvAe4//3OlNJxRHNl9vlkeVBgoXtgFq0+KHk6a1cNW+MwRMilU1
 htjJp5/B7A5EA8mzxuIttqSNuHUOKEU8VzyLH3k0V82psByGlnJOgGNToUNvjGUa81UaTt0SkI0
 r9snSr+rKpBXOJE19vUJP6hgS4o1v0l9Fc2G20YnzTX4BApjc16WFdJc0n72RDnF+TM3SKkyxgo
 eMCFpKFRWIhnRIb3VJDhMt7vr9oTqnjF3WjSF83VBWL6it/irxPBOguwFGAOmpOAtA1StJwGbI0
 LOH/yOK3Pn0jjOERi37kuzCFAU+Q9cIQuKSraIQO4u2qIsNOOmnZd1xzSMu9eldo7PkRPawP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040098
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 2025-07-20 at 23:26 +0200, Cédric Le Goater wrote:
> On 5/16/25 03:29, Nicholas Piggin wrote:
> > On Fri May 16, 2025 at 1:36 AM AEST, Cédric Le Goater wrote:
> > > On 5/12/25 05:10, Nicholas Piggin wrote:
> > > > These changes gets the powernv xive2 to the point it is able to run
> > > > PowerVM with good stability.
> > > > 
> > > > * Various bug fixes around lost interrupts particularly.
> > > > * Major group interrupt work, in particular around redistributing
> > > >     interrupts. Upstream group support is not in a complete or usable
> > > >     state as it is.
> > > > * Significant context push/pull improvements, particularly pool and
> > > >     phys context handling was quite incomplete beyond trivial OPAL
> > > >     case that pushes at boot.
> > > > * Improved tracing and checking for unimp and guest error situations.
> > > > * Various other missing feature support.
> > > > 
> > > > The ordering and grouping of patches in the series is not perfect,
> > > > because it had been an ongoing development, and PowerVM only started
> > > > to become stable toward the end. I did try to rearrange and improve
> > > > things, but some were not worth rebasing cost (e.g., some of the
> > > > pool/phys pull redistribution patches should have ideally been squashed
> > > > or moved together), so please bear that in mind.  Suggestions for
> > > > further rearranging the series are fine, but I might just find they are
> > > > too much effort to be worthwhile.
> > > > 
> > > > Thanks,
> > > > Nick
> > > > 
> > > > Glenn Miles (12):
> > > >     ppc/xive2: Fix calculation of END queue sizes
> > > >     ppc/xive2: Use fair irq target search algorithm
> > > >     ppc/xive2: Fix irq preempted by lower priority group irq
> > > >     ppc/xive2: Fix treatment of PIPR in CPPR update
> > > >     pnv/xive2: Support ESB Escalation
> > > >     ppc/xive2: add interrupt priority configuration flags
> > > >     ppc/xive2: Support redistribution of group interrupts
> > > >     ppc/xive: Add more interrupt notification tracing
> > > >     ppc/xive2: Improve pool regs variable name
> > > >     ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
> > > >     ppc/xive2: Redistribute group interrupt precluded by CPPR update
> > > >     ppc/xive2: redistribute irqs for pool and phys ctx pull
> > > > 
> > > > Michael Kowal (4):
> > > >     ppc/xive2: Remote VSDs need to match on forwarding address
> > > >     ppc/xive2: Reset Generation Flipped bit on END Cache Watch
> > > >     pnv/xive2: Print value in invalid register write logging
> > > >     pnv/xive2: Permit valid writes to VC/PC Flush Control registers
> > > > 
> > > > Nicholas Piggin (34):
> > > >     ppc/xive: Fix xive trace event output
> > > >     ppc/xive: Report access size in XIVE TM operation error logs
> > > >     ppc/xive2: fix context push calculation of IPB priority
> > > >     ppc/xive: Fix PHYS NSR ring matching
> > > >     ppc/xive2: Do not present group interrupt on OS-push if precluded by
> > > >       CPPR
> > > >     ppc/xive2: Set CPPR delivery should account for group priority
> > > >     ppc/xive: tctx_notify should clear the precluded interrupt
> > > >     ppc/xive: Explicitly zero NSR after accepting
> > > >     ppc/xive: Move NSR decoding into helper functions
> > > >     ppc/xive: Fix pulling pool and phys contexts
> > > >     pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
> > > >     ppc/xive: Change presenter .match_nvt to match not present
> > > >     ppc/xive2: Redistribute group interrupt preempted by higher priority
> > > >       interrupt
> > > >     ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
> > > >     ppc/xive: Fix high prio group interrupt being preempted by low prio VP
> > > >     ppc/xive: Split xive recompute from IPB function
> > > >     ppc/xive: tctx signaling registers rework
> > > >     ppc/xive: tctx_accept only lower irq line if an interrupt was
> > > >       presented
> > > >     ppc/xive: Add xive_tctx_pipr_set() helper function
> > > >     ppc/xive2: split tctx presentation processing from set CPPR
> > > >     ppc/xive2: Consolidate presentation processing in context push
> > > >     ppc/xive2: Avoid needless interrupt re-check on CPPR set
> > > >     ppc/xive: Assert group interrupts were redistributed
> > > >     ppc/xive2: implement NVP context save restore for POOL ring
> > > >     ppc/xive2: Prevent pulling of pool context losing phys interrupt
> > > >     ppc/xive: Redistribute phys after pulling of pool context
> > > >     ppc/xive: Check TIMA operations validity
> > > >     ppc/xive2: Implement pool context push TIMA op
> > > >     ppc/xive2: redistribute group interrupts on context push
> > > >     ppc/xive2: Implement set_os_pending TIMA op
> > > >     ppc/xive2: Implement POOL LGS push TIMA op
> > > >     ppc/xive2: Implement PHYS ring VP push TIMA op
> > > >     ppc/xive: Split need_resend into restore_nvp
> > > >     ppc/xive2: Enable lower level contexts on VP push
> > > > 
> > > >    hw/intc/pnv_xive.c          |  16 +-
> > > >    hw/intc/pnv_xive2.c         | 139 +++++--
> > > >    hw/intc/pnv_xive2_regs.h    |   1 +
> > > >    hw/intc/spapr_xive.c        |  18 +-
> > > >    hw/intc/trace-events        |  12 +-
> > > >    hw/intc/xive.c              | 555 ++++++++++++++++++----------
> > > >    hw/intc/xive2.c             | 717 +++++++++++++++++++++++++++---------
> > > >    hw/ppc/pnv.c                |  48 +--
> > > >    hw/ppc/spapr.c              |  21 +-
> > > >    include/hw/ppc/xive.h       |  66 +++-
> > > >    include/hw/ppc/xive2.h      |  22 +-
> > > >    include/hw/ppc/xive2_regs.h |  22 +-
> > > >    12 files changed, 1145 insertions(+), 492 deletions(-)
> > > > 
> > > 
> > > I am impressed :) and glad that you are still taking care of XIVE.
> > > 
> > > I suggest adding new names under the XIVE entry in the MAINTAINERS file.
> > 
> > Yeah it's good to see. They are building a lot more cool stuff with
> > powernv at the moment, hopefully almost all should get upstreamed
> > eventually.
> > 
> > I will try to convince them to add MAINTAINER entries :)
> > 
> > Thanks,
> > Nick
> > 
> 
> This is a major update for XIVE and, since I am not sure anyone
> is going to send a PR for QEMU 10.1, I am volunteering to do
> it again on monday, once and only for these fixes.
> 
> We should clarify in the next cycle who is charge of ppc. IMO,
> If we don't have maintainers, we should orphan all non-pseries
> PPC components. I can send a maintainer update on this as soon
> as the QEMU 10.2 cycle opens.
> 
> 
> Thanks,
> 
> C.
> 

Cédric,

Thanks for doing the PR for these XIVE changes!  It sounds like if we
want to continue having our XIVE changes upstreamed we will need
someone on our IBM QEMU development team to volunteer as a maintainer.
Does becoming a maintainer still require physically attending a key
signing party at KVM Forum?

Thanks,

Glenn


