Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222E6CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcdeh-0001Pw-6n; Thu, 25 Jun 2026 02:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcdee-0001P7-7R; Thu, 25 Jun 2026 02:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcdeb-0005oS-Ov; Thu, 25 Jun 2026 02:33:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mVWm2977929; Thu, 25 Jun 2026 06:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kcpKFX
 vTivp9kP7qB8T1/R2TF8Zj3x0QbugW4pPUHjQ=; b=FqnfGnJi8ciFIa6uS6nv/A
 h2V8Fe4TqKS4fRInHXWOEpiZNQWIkpURIkaNkglHGKnNObClyj7iAvNPwtb3lFTQ
 IcTA05q/5aKRTpnPck+EA+uLkt7mkjHma/X8wTUaO1juPywFcvBV05BK5X6FZi9j
 TOHuZU1pKdoqqosFvFqnnUKApSIZc+tcrAdgAfeG0/7HSaUQPb/EGlZkPLA+Zd1B
 WLEbTx5Na1d20hnKEEtld8uuLZNCETYrfoQ1MGuvbZeXTQOY/yoRrNMEHmQo4Keh
 +L46Umefo1Wq0aCZYvpYQo6Wadlf4VwAEUq0mieBWSD6GnYFgbs6bkArB8pkdlDw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4rb94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 06:33:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P6K8L7005392;
 Thu, 25 Jun 2026 06:33:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwmxm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 06:33:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P6X9Lj45744578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 06:33:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DED0520040;
 Thu, 25 Jun 2026 06:33:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 863C52004B;
 Thu, 25 Jun 2026 06:33:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.199]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2026 06:33:02 +0000 (GMT)
Date: Thu, 25 Jun 2026 12:02:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <ajzLOyHQDof4wO4Q@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
 <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1MyBTYWx0ZWRfX2+IdW+nAvkZm
 e+TLol9Y5ZT2N4wdL7MQJwiyll/RYHv3ZJoRf4+4iGLTM11mjUXh8RoAs6IjTa/zHM1MxSSEzbk
 nTGdo2k1k57UcpsHO/5xS2UAdtIQTKU=
X-Proofpoint-ORIG-GUID: r9K0Sw0udjjc10GPdX0yvmYJkxE-q74a
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3ccbab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=RuPvRiwboNjlD2If9HoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1MyBTYWx0ZWRfX0ANGCJBrG165
 5gDwJCeH0xMtLA2yykQUWt9YBJqY4dSNF0D3nL/qYrjDLw2/eEKy7tdzlDvc/WWl377G3CPH3E1
 SXD6CQ9X7mDeJPNq3ZwjPtd1XIWHxETxai7wlesO0q1loCA+hvi88LLi8EA5ShgRckyOnDSxdQ2
 AEwxpaWsOF/hRj/ns+JK6BD8jmUc36kVOjVjxNUpFNbxGy9FUoi6ndM5f1cyNWOhaZIjGrajXyU
 +dDQ3X/D7OSa1EnMsrsZ2mH/RBsVxpl6gbuVJyvpYuyYfuXCfPpy9ghNZ2OS1a8plkpB8ecAf/N
 nPNjQa6WYoLCqfC0pO7MTAtsfkviSwRVXTHJRcG+00U9nPBa398bLWh8T6egxF4uJ+L+6TxwJce
 IRd6/3WN2y1IUTUI3rLGRgUmWNGTmO+ADV/Q+S0zqpysJhWU94m9lYIT+H995fo1VEwV5c3OTde
 jSLXB3h6t68V1VrEb8Q==
X-Proofpoint-GUID: paGEjVdJQkFJAkStK_BinL6gH-QrwnH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250053
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/06/25 08:03AM, BALATON Zoltan wrote:
> On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
> > On 24/06/26 7:14 pm, Aditya Gupta wrote:
> > > On 26/06/23 09:24PM, Shivang Upadhyay wrote:
> > > > On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> > > > > +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> > > > > +{
> > > > > +    if (chip_type == PNV_CHIP_POWER8) {
> > > > > +        return "powernv8";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER9) {
> > > > > +        return "powernv9";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER10) {
> > > > > +        return "powernv10";
> > > > > +    } else if (chip_type == PNV_CHIP_POWER11) {
> > > > > +        return "powernv11";
> > > > > +    } else {
> > > > > +        g_assert_not_reached();
> > > > > +    }
> > > > > +}
> > > > 
> > > > How about refactoring to the following?
> > > > 
> > > >      static const char *const machine_types[] = {
> > > >          [PNV_CHIP_POWER8]  = "powernv8",
> > > >          [PNV_CHIP_POWER9]  = "powernv9",
> > > >          [PNV_CHIP_POWER10] = "powernv10",
> > > >          [PNV_CHIP_POWER11] = "powernv11",
> > > >      };
> > > >      return machine_types[x];
> > > 
> > > Has a subtle difference, that it may not assert/segfault on unknown
> > > value for x, I want the test to crash/fail if this is called with an
> > > unknown/new processor chip. I believe the if-else/switch is better as it
> > > handles (by 'crashing') unknown values too.
> > 
> > We could just do:
> > 
> > if (chip_type >= PNV_CHIP_MAX) {
> >    g_assert_not_reached();
> > } else {
> >    return machine_types[chip_type];
> > }
> 
> Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?
> 
> Regards,
> BALATON Zoltan
> 
> > That way just adding new array entry would work for future chips.

will do in v3. thanks !

- Aditya G


