Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FDBCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOVA-0005ig-KT; Thu, 01 Oct 2026 17:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xCOV8-0005iK-FO; Thu, 01 Oct 2026 17:39:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xCOV6-00083H-8s; Thu, 01 Oct 2026 17:39:38 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691G5kno369149; Thu, 1 Oct 2026 21:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Un1AFaKh39v+J0OuS6Xn7izWF7pqev3m1svx42eL3Mo=; b=VpVLTLYBn854
 6zFeDqozh5WxjN6XSiEBToiN6rNBIEvfAaIyOd4PDZo0DnpJN4OJPrJqGcImHsvb
 OKNYrupP6YwQxGeRcUT1N2fot/ZSiKooYVJ6kebs3qS2ZdHuFBqJ0J/r1gYoGD/0
 Jo9S5tn4vO7qTaClUdy/e9r8jIcfLvKD6IlFXU9NaArLZ4gStVAXrQd84erYTs1Z
 AAnXxI0wbYKL9k+qE7rEZ1VNROcqe8IVkXL5LbpHRW/OiQZMHRS7A2T9EOqGvFJf
 wES2hwbT8kmRy1GpQKmRmXFiJZZQi3RUaerQXrvQoYzc3vHH+mT4U+xE4Y5kNdgI
 ZIli52Vzhw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrp4ny-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 21:39:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 691KRqx61481405; Thu, 1 Oct 2026 21:39:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h1xk108uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Oct 2026 21:39:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 691LdLQm27853388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Oct 2026 21:39:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF02358056;
 Thu,  1 Oct 2026 21:39:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3560B5803F;
 Thu,  1 Oct 2026 21:39:20 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Oct 2026 21:39:20 +0000 (GMT)
Message-ID: <583c2f44e7dce2f948908fc1cb012589c810335e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
From: Miles Glenn <milesg@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, "Kirill A. Korinsky"
 <kirill@korins.ky>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 01 Oct 2026 16:39:19 -0500
In-Reply-To: <826a6e78-6e61-4a47-bdfe-eb5c3adbbe6e@linux.ibm.com>
References: <20260923230452.3765-1-kirill@korins.ky>
 <20260923230452.3765-3-kirill@korins.ky>
 <20261001143415.3f3b33fc-f8-amachhiw@linux.ibm.com>
 <826a6e78-6e61-4a47-bdfe-eb5c3adbbe6e@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NiBTYWx0ZWRfX42xYZIdSbsAQ
 BD9Pti4ulWNprTo0mjovKuckxDDKggpJhys8Zbh/6KAN616HCzmEpqNOgDYvXcK3GTf8MPkLXZI
 zLMFuabd6fQ67UFvHtv0fYY/jKVfnM8ZzCC9jz92oQwXZMW5iH1/FKED512EDDfKPb+nRgV0AHo
 f4FeZ+IGgqMTwc48gWdGcVwz6Jwtyq+gH5G9YjTyneIPO+guU9NyELL230vv3Gl/ruKTe+ldD1z
 Dw0K6TwavZpxr92ZuDcvrXfztnrDVz60LHMmFLWcXHbxiPEgKJbtXZHt+otnKjRSKiAZcJcpvdM
 XertOa2rOkxYy7IgQLJT1Lk0R4+VVyXHFJVLLz0/kpwJT6qDzlP7PnpZxlM5P5MrpVbpIjUS1zy
 zps2ntVrcN5m2Tdxgy4o/ZNUQkkNyU1r1GB14/75SXoaaxaS/UEnT3BK4mSkxp25zhTac74hOcM
 pJYaBvlkTFDZCHO0ppA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abed30c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pcZqCyVeAAAA:8 a=oDiNktlHzzYgXybswTkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SGy6VSG0Ue1xmPAwIFl9:22 a=ojN_UKswjOqU4wFocON6:22
X-Proofpoint-ORIG-GUID: FBLVaBdtlvhaiRSCdz2lxp5hXnA3TZyI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NiBTYWx0ZWRfXzH2xgSuEyH3B
 9QJiLwCVYTXFs201iqvTp7lO81SiQWNEW09btkgfIddt9F7pZd138IBVCpWEMlqU6DfjEpRhONS
 9YzyJ0dS0rCSrdr1Oh5/0gls1cvgb0k=
X-Proofpoint-GUID: JOgSdD-Tl7eiy-zi35SSxr8QO7G2VY9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Harsh,

I will try to take a look tomorrow or Monday.

Thanks,

Glenn

On Thu, 2026-10-01 at 14:46 +0530, Harsh Prateek Bora wrote:
> + BALATON
> 
> Hi Glenn, BALATON,
> 
> Any review feedback on below patch?
> 
> Thanks
> Harsh
> 
> On 01/10/26 2:40 pm, Amit Machhiwal wrote:
> > On 2026/09/24 01:03 AM, Kirill A. Korinsky wrote:
> > > From: "Kirill A. Korinsky" <kirill@korins.ky>
> > > 
> > > OpenBSD writes zero to an edge triggered decrementer, then enters idle
> > > expecting its interrupt. QEMU defers the already due edge to a timer at
> > > the current virtual time, leaving the guest stalled.
> > > 
> > > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > > Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > > ---
> > >   hw/ppc/ppc.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > > index b123b4cc1c..736a37d32b 100644
> > > --- a/hw/ppc/ppc.c
> > > +++ b/hw/ppc/ppc.c
> > > @@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
> > >        * an edge interrupt, so raise it here too.
> > >        */
> > >       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> > > +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
> > 
> > Thanks for the v2 — you got the guard right (PPC_DECR_ZERO_TRIGGERED in
> > __cpu_ppc_store_decr), but the flag-setting landed in the wrong place.
> > 
> > >           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
> > >             && signed_decr >= 0)) {
> > >           (*raise_excp)(cpu);
> > >           return;
> > > +    } else {
> > > +        /*
> > > +         * Classic 32-bit edge-triggered decrementer: zero write fires
> > > +         * immediately
> > > +         */
> > > +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
> > 
> > My suggestion was to set PPC_DECR_ZERO_TRIGGERED once at init time in
> > cpu_ppc_tb_init().  In v2 it ended up inside the else block of
> > __cpu_ppc_store_decr() instead.
> > 
> > That mutates tb_env->flags at runtime on every DEC write that does not
> > immediately fire.  PPE42 goes through ppc_booke_timers_init() and gets
> > PPC_DECR_UNDERFLOW_TRIGGERED but not PPC_DECR_ZERO_TRIGGERED.  The first time a
> > guest writes a non-zero value to DEC on PPE42, this else block stamps
> > PPC_DECR_ZERO_TRIGGERED onto tb_env->flags — from that point on, every zero
> > write fires immediately, which contradicts the PPE42 architecture (commit
> > 7197f6f7baf2).
> > 
> > The fix is the same two-liner I included in my v1 response:
> > 
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index b123b4cc1cce..6f99b61a2876 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
> >        * an edge interrupt, so raise it here too.
> >        */
> >       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> > +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
> >           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
> >             && signed_decr >= 0)) {
> >           (*raise_excp)(cpu);
> > @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
> >       if (is_book3s_arch2x(env)) {
> >           /* All Book3S 64bit CPUs implement level based DEC logic */
> >           tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
> > +    } else {
> > +        /*
> > +         * Classic 32-bit edge-triggered decrementer: zero write fires
> > +         * immediately
> > +         */
> > +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
> >       }
> >       /* Create new timer */
> >       tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > 
> > PPE42 never enters cpu_ppc_tb_init() — it uses ppc_booke_timers_init() — so it
> > never gets PPC_DECR_ZERO_TRIGGERED and the new clause does not fire for it.  All
> > 32-bit classic CPUs that go through cpu_ppc_tb_init() (7400, 750, 604, 7457)
> > take the else branch and get the flag set statically at boot, which is the right
> > place for it.
> > 
> > Thanks,
> > Amit


