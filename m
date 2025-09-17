Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95019CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvOH-0005yp-0Y; Wed, 17 Sep 2025 12:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uyvOB-0005xv-9N; Wed, 17 Sep 2025 12:52:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uyvO8-00088k-Vf; Wed, 17 Sep 2025 12:52:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAU5DH012559;
 Wed, 17 Sep 2025 16:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=uqGo4rQVEfKq0psXSgxlGa+40u7ISpCkJM7wssvpwds=; b=FvuUfi1fDN57
 ag2tTw1a0IGw/USc0OGp2CYG1lbtzLBZffhuCDpTsdK5GiynE37usFTDOr1iCjfX
 mbpuF9ky/LzUn64r4p5juXe7hK85t9tW/i6FM7xIsV6KimnOutmcZGnEJlx2nwx8
 D/36mhJ53WC9F0Z7rPW4nK1X5Yn61a4kH0aERQx/0+W9GvVgUQE9pi7csIHmTh3P
 3cFvvXia9uNIdbNpxSnPRR77YqCGGABCLr2fOg+Hu8aEVDbELNB75dwHeN5/K4so
 yNvvGxYhsoM5kHNeaQPWV0ibFzbKJu8GDwRoJJzAkxlJncEkSfokzIgRhtwYpqza
 XOnp1gxXcQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nctn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 16:52:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HGo2Y4025852;
 Wed, 17 Sep 2025 16:52:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nctn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 16:52:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDqL47029514;
 Wed, 17 Sep 2025 16:52:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb12fnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 16:52:07 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HGq6rg24118010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 16:52:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B17905805B;
 Wed, 17 Sep 2025 16:52:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56CE758058;
 Wed, 17 Sep 2025 16:52:06 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 16:52:06 +0000 (GMT)
Message-ID: <9d5e6647f6225814ce421faf840e3db3723f75fd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Date: Wed, 17 Sep 2025 11:52:06 -0500
In-Reply-To: <f698514c-798f-43f8-80cb-dc1b35b15f5e@redhat.com>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
 <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
 <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
 <2e4a6d39-650e-74a4-ad60-56d5422c83a1@eik.bme.hu>
 <f698514c-798f-43f8-80cb-dc1b35b15f5e@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cae738 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=jRLB2SoPAAAA:8
 a=VnNF1IyMAAAA:8 a=4dRC11KYM-O5vsRAHF0A:9 a=QEXdDO2ut3YA:10
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-GUID: vc3WTe3P8isLPXzUFZgs9pfxOmwqMrtj
X-Proofpoint-ORIG-GUID: MWXA02IaXJa9NylVjuxjq05lus4kz9bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4l0y4YIRgQmV
 kw7FkyOucNt4HuR6GIgmEXO/wpIr+IL9JyWt6lOnOZXdWoKrOS8pemEJ2Ga6JsozGoD6xbiQqzY
 5fQn62XWdnFzgnqnMT4QtBX7iV1MoMLxn6SVQev7ct3f0dMWA+2UORbVQQ0csfZJjs37ppp5xTT
 huz+z0r3HKXGBRvEe2WHfW1Hg2o7Y/T7ju7KP6Vrz88Ia/Zf5WOpfgzNu+LIXDtBFsA87qWFA0o
 q6n1lvU/T8CdUldPaA8woBq6VTvpj0xWytTD2RlaWn73RlNGuMj3SBhiM1/Q0mHsUvJapfNuK8E
 YFPjybkD6BxxDBLI3szDSa3LFC3LZ/k2vTyobZQ2PHgG3Upjh6Z/iGmUIbW0rOgwl9pK0J+8v/L
 N7YgNUvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
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

On Wed, 2025-09-17 at 18:43 +0200, Thomas Huth wrote:
> On 17/09/2025 18.07, BALATON Zoltan wrote:
> > On Wed, 17 Sep 2025, Miles Glenn wrote:
> > > On Wed, 2025-09-17 at 08:20 +0200, Thomas Huth wrote:
> > > > On 17/09/2025 06.57, Harsh Prateek Bora wrote:
> > > > > On 9/12/25 22:17, Glenn Miles wrote:
> > > > > > Adds the following instructions exclusively for
> > > > > > IBM PPE42 processors:
> > > > > > 
> > > > > >    LSKU
> > > > > >    LCXU
> > > > > >    STSKU
> > > > > >    STCXU
> > > > > >    LVD
> > > > > >    LVDU
> > > > > >    LVDX
> > > > > >    STVD
> > > > > >    STVDU
> > > > > >    STVDX
> > > > > >    SLVD
> > > > > >    SRVD
> > > > > >    CMPWBC
> > > > > >    CMPLWBC
> > > > > >    CMPWIBC
> > > > > >    BNBWI
> > > > > >    BNBW
> > > > > >    CLRBWIBC
> > > > > >    CLRWBC
> > > > > >    DCBQ
> > > > > >    RLDICL
> > > > > >    RLDICR
> > > > > >    RLDIMI
> > > > > > 
> > > > > > A PPE42 GCC compiler is available here:
> > > > > > https://github.com/open-power/ppe42-gcc
> > > > > > 
> > > > > > For more information on the PPE42 processors please visit:
> > > > > > https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
> > > > > > 
> > > > > > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > > > > > ---
> > > > > > Changes from v3:
> > > > > >    - Removed copy of CHECK_VDR
> > > > > >    - Refactored ld/st instructions
> > > > > > 
> > > > > >   target/ppc/insn32.decode            |  66 ++-
> > > > > >   target/ppc/translate.c              |  29 +-
> > > > > >   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
> > > > > >   3 files changed, 750 insertions(+), 10 deletions(-)
> > > > > >   create mode 100644 target/ppc/translate/ppe-impl.c.inc
> > > > > > 
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > > diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/
> > > > > > ppe-impl.c.inc
> > > > > > new file mode 100644
> > > > > > index 0000000000..792103d7c2
> > > > > > --- /dev/null
> > > > > > +++ b/target/ppc/translate/ppe-impl.c.inc
> > > > > > @@ -0,0 +1,665 @@
> > > > > > +/*
> > > > > > + * IBM PPE Instructions
> > > > > > + *
> > > > > > + * Copyright (c) 2025, IBM Corporation.
> > > > > > + *
> > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > + */
> > > > > > +
> > > > > > +
> > > > > > +#if !defined(TARGET_PPC64)
> > > > > > +static bool vdr_is_valid(uint32_t vdr)
> > > > > > +{
> > > > > > +    const uint32_t valid_bitmap = 0xf00003ff;
> > > > > > +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
> > > > > > +}
> > > > > > +
> > > > > > +static bool ppe_gpr_is_valid(uint32_t reg)
> > > > > > +{
> > > > > > +    const uint32_t valid_bitmap = 0xf00027ff;
> > > > > > +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
> > > > > > +}
> > > > > > +#endif
> > > > > > +
> > > > > > +#define CHECK_VDR(CTX, VDR)                             \
> > > > > > +    do {                                                \
> > > > > > +        if (unlikely(!vdr_is_valid(VDR))) {             \
> > > > > > +            gen_invalid(CTX);                           \
> > > > > > +            return true;                                \
> > > > > > +        }                                               \
> > > > > > +    } while (0)
> > > > > > +
> > > > > > +#define CHECK_PPE_GPR(CTX, REG)                         \
> > > > > > +    do {                                                \
> > > > > > +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
> > > > > > +            gen_invalid(CTX);                           \
> > > > > > +            return true;                                \
> > > > > > +        }                                               \
> > > > > > +    } while (0)
> > > > > > +
> > > > > > +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
> > > > > > +
> > > > > > +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
> > > > > > +    do {                                                \
> > > > > > +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
> > > > > > +            gen_invalid(CTX);                           \
> > > > > > +            return true;                                \
> > > > > > +        }                                               \
> > > > > > +    } while (0)
> > > > > > +
> > > > > > +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
> > > > > > +{
> > > > > > +#if defined(TARGET_PPC64)
> > > > > > +    return false;
> > > > > > +#else
> > > > > 
> > > > > If we are building the PPE42 instructions only for !TARGET_PPC64, does
> > > > > it still make it usable with qemu-system-ppc64?
> > > > 
> > > > As explained in an earlier thread already, qemu-system-ppc64 is a superset
> > > > of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system- 
> > > > ppc64, too.
> > > > 
> > > >   Thomas
> > > > 
> > > 
> > > Ah, yes, I don't think I fully understood the ramifications of Thomas's
> > > statements earlier.  Looks like I'll need to scrub the code to ensure
> > > that PPE42 can run even if TARGET_PPC64 is defined.
> > > 
> > > Cedric, this requires me to change my response to your request to add
> > > the check for TARGET_PPC64 inside the is_ppe() function.  I will need
> > > to leave that function as-is if we want PPE42 to be supported in both
> > > targets.  Will you be ok with that?
> > 
> > Does it make sense to support it with !TARGET_PPC64 if its only use is in 
> > qemu-system-ppc64? Even if the CPU is 32-bit it has some 64-bit instructions 
> > IIUC so does that make it TARGET_PPC64 only?
> 
> As long as the GPRs are 32 bit only (which is the case here, I assume), it's 
> a 32-bit PPC CPU, isn't it? So that certainly should not go into the ppc64 
> binary only.
> 
>   Thomas
> 

I agree.  While the PPE42 does support some 64 bit operations, it
actually is using two 32 bit register pairs to accomplish the 64 bit
operations.  Also, the address space is a 32 bit space.

Glenn


