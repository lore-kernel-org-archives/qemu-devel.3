Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C0CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 06:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uocVS-0002jo-Qm; Wed, 20 Aug 2025 02:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uocVP-0002iw-08; Wed, 20 Aug 2025 02:41:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uocVJ-0004Xa-OE; Wed, 20 Aug 2025 02:41:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNmeHJ008042;
 Wed, 20 Aug 2025 06:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uYrR5l
 slRk6yArhQOuNucY+LpgFXy9iL3zOGvOrShhE=; b=GBKt2uIMQJ2zaK6E1tHS7u
 HArmtCM/IyKjbWiiXQkS3I5pNU1Op2c5iUfddtfPP6WceCjLabXXkPWTQnmvRjHf
 o7zTI0MwUqKXB90EvRsnxQh/6YIGsj1zJPzjH4yfhBuiH0NaN2h0qml0gWHWmaUx
 5aVx2fuzB7lmPfhNxIv6WTU7W4eCPxCz7KloezPwipvrOmLeW3qiKHX3RvKcdRah
 fDY55luMIqiugCLF7Vc9WtLFiqgKzFu+unoXNywuwcIJcWdjBOtp9ApVDi7P+Aw6
 iACpWiW6O8ijnyBQlU2wt1XikPNoc4CCVOz8wEEN8wr1+ST1rufbn7WyA0MuTdmg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vsbaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:40:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57K6ehxV015175;
 Wed, 20 Aug 2025 06:40:56 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vsba8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:40:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K50seu016038;
 Wed, 20 Aug 2025 06:40:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my4223j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 06:40:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57K6epUx52429082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 06:40:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9ADD2004B;
 Wed, 20 Aug 2025 06:40:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D66D420040;
 Wed, 20 Aug 2025 06:40:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.140]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Aug 2025 06:40:46 +0000 (GMT)
Date: Wed, 20 Aug 2025 12:10:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 gautam@linux.ibm.com
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
Message-ID: <omhrnrjejatsmuzqxz5ifpxtwo3zy5vhd6l3dw4ni35ghrjv4f@j4ghd2mxxvtj>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
 <wdkarichs5jrmpz3k4gxosw42dt6qxwodnc6t6tcuecsmxgqcd@km4q644fiixb>
 <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YRMHGFGmV3LlCl8N8UmuW2M8jdiIue7f
X-Proofpoint-GUID: FMbHcLdpDateWGoDp3_E6MvLCpyLAQMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX6aQdR1rjqPv7
 +AGUS2a/k1cuueTsE0k2OsPYJZ50dtAdh+5Gld8bTC6V24oyFP56NDALwtesJzS9efSgV/71KTf
 FZm4IzqgMkjtg7kGbj9eQ64NPVqz+NqfvoremJqywEyFCURGWvUor8kkSCKtR6zJDl+uhKfybVu
 U0HMS9FT2GVtVOd+Yju7VtYw/fYFA379nt6wSBtmhnvloCNiFTfuR/egKtXM4iw9jb0P6qMniOV
 Wbctye9S8WeLIeX2vVcExBZXI2xxVHZIEUy0wSFaKVZAxPetCael27RtbZyUvn81NqYHtPrWURO
 2FqvSE96uxXOI3vsEVgENc1gQ4cRq7KFyyjprO/JG5h3dIqJcODBonc22cFSAOrXuVElfjZsf5c
 wvrpGw6WlH4HNi7h+oX/Ovv0xMoQzQ==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a56df8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=PQQO-Onz_kKJoEko3rkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/08/10 02:46PM, Cédric Le Goater wrote:
> + Glenn
> + Gautam
> 
> On 8/10/25 12:45, Aditya Gupta wrote:
> > On 25/08/10 12:26PM, Aditya Gupta wrote:
> > > > <...snip...>
> > > 
> > > About the error, seems xive2 always expecting powernv10 chip, I will
> > > have to rethink how should I use the same xive2 for powernv11.
> > > 
> > 
> > There's a type cast to Pnv10Chip in 'pnv_xive2_get_remote'.
> > The cast is only temporarily used to get the 'PnvXive2' object in the
> > Pnv10Chip.
> > It's the only place in hw/intc/pnv_xive2.c assuming Pnv10Chip object.
> > 
> > Thinking to have a helper function to just return the 'PnvXive2' object
> > inside the chip, given a 'PnvChip'.
> > 
> > Or the below change where we are adding another pointer in PnvChipClass:
> > 
> >      diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> >      index e019cad5c14c..9832be5fd297 100644
> >      --- a/hw/intc/pnv_xive2.c
> >      +++ b/hw/intc/pnv_xive2.c
> >      @@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
> >           int i;
> >           for (i = 0; i < pnv->num_chips; i++) {
> >      -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> >      -        PnvXive2 *xive = &chip10->xive;
> >      +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
> >      +        PnvXive2 *xive = k->intc_get(pnv->chips[i]);
> >               /*
> >                * Is this the XIVE matching the forwarded VSD address is for this
> > 
> > Which one do you suggest ? Or should I look for another way ?
> > 
> > I am preferring the first way to have a helper, but both ways look hacky.
> 
> Any call to qdev_get_machine() in device model is at best
> a modeling shortcut, most likely it is a hack :
> 
>   /*
>    * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
>    * scan of all the chips INT controller is good enough.
>    */
> 
> So all these calls are suspicious :
> 
>   $ git grep qdev_get_machine hw/*/*pnv*
>   hw/intc/pnv_xive2.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/pci-host/pnv_phb.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/pci-host/pnv_phb3.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>   hw/ppc/pnv_lpc.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> 
> In the particular case of XIVE2, the solution is to rework
> pnv_xive2_get_remote() like it was for P9. See b68147b7a5bf
> ("ppc/xive: Add support for the PC MMIOs").

I am having difficulties making a change here, don't know this path.
Going through the docs to understand XIVE2.
Will post once I have a patch.

Thanks Cedric,
- Aditya G


