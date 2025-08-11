Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB7CA0ECD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUHP-0000lA-8t; Mon, 11 Aug 2025 11:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ulUHF-0000jf-Jz; Mon, 11 Aug 2025 11:17:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ulUHC-0007gf-LF; Mon, 11 Aug 2025 11:17:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B95vKL023799;
 Mon, 11 Aug 2025 15:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=a4V/h7w5IGRNK+00AdBSa7FEIxAE53em51iG0G00REk=; b=PgFH30+oH70p
 P6t6uTCST3t/2fFcLk/803poMHwsKLgg0R1pRWCVYbe6Zk+rktGTOrsCbljSjNOi
 HcKH/8Qy3eVheRbzPrUEZv6ix8IP77wa/EUGX0il4yzE352yXWPNtEaRPjj5Hgwl
 r61q62yWBO3ZRHfiyRciEuU7alpI5peNrPB5LJQVq/HgYW4JRTSt9eWmUvdwX56x
 cIU8U4nRwIIVbTwa7a52p+4Wx5lKUAt93s/bkXluUR8Y8ynarOpeBt8pVpHNa3aC
 6hNjQVVahIBKJHJJTZmSQ2ahbwJpYSYhgpaXrYI5F9WeytTWk0TCyA/6JuuIO0ie
 fPt9pmZAPA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnsu3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 15:17:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BFGbRn020180;
 Mon, 11 Aug 2025 15:17:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnsu3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 15:17:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEU6o0020615;
 Mon, 11 Aug 2025 15:17:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnppcts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Aug 2025 15:17:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57BFH77Q5964318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 15:17:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C7258067;
 Mon, 11 Aug 2025 15:17:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E81C15805E;
 Mon, 11 Aug 2025 15:17:06 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Aug 2025 15:17:06 +0000 (GMT)
Message-ID: <145a086f73ac33d11bbeb51157de3f14a6982f2b.camel@linux.ibm.com>
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Aditya Gupta
 <adityag@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, gautam@linux.ibm.com, kowal@linux.ibm.com
Date: Mon, 11 Aug 2025 10:17:06 -0500
In-Reply-To: <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
 <wdkarichs5jrmpz3k4gxosw42dt6qxwodnc6t6tcuecsmxgqcd@km4q644fiixb>
 <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NSBTYWx0ZWRfX5ao2nUwJS+m+
 gflM7W46/nr+I9pdUxxLSV0IuwDilHorbBQqTsmfQksTXVWrgml4DVCcBpNkMFUSSMmZPEbsFq5
 uBjSsGrC9GgL24Z1EKld2/yDt0Q4URVjBRCIomN2HRME5S3cZv3R7p8Qxo0P7xdG7rkdi/JRaDo
 Vn8uKnu2m0vWoF40Rfg6RDd8kswF5PZy6q+YiqL3WDe0An8ZMD6Zo8wzcuRqhNKMVoqc0UiY17H
 wWvUtcHrihgDrwHmETgNaoDn/A0cay2NkWoLKYSnGm9s/rJIQYVs4MrGNW2RR7WsstbrUzDoRpT
 B2HzFGz96Lgv+ccMDgrJbrbyKF+YEvMSoue5saKWYugu83R99CfIVLt+27rAK30TyNIuePpKj8b
 9q+9FRGDTJszqpE3tErlk/DgywmEe8mGRqj1a7Y7DDAtT22/mwJlYwfreqsqGpvVcCxs7kMg
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689a0976 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GckNcg_KGMA48mpdwiYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gq7kTDOWNnb6P-zSx7pDVPLiWf_mGSiP
X-Proofpoint-ORIG-GUID: I4LkSQwGlpqC6uY_ACMBnASwe4zSNWCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110095
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

+ Mike Kowal

On Sun, 2025-08-10 at 14:46 +0200, Cédric Le Goater wrote:
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
> >       
> >           for (i = 0; i < pnv->num_chips; i++) {
> >      -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> >      -        PnvXive2 *xive = &chip10->xive;
> >      +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
> >      +        PnvXive2 *xive = k->intc_get(pnv->chips[i]);
> >       
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
>    /*
>     * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
>     * scan of all the chips INT controller is good enough.
>     */
> 
> So all these calls are suspicious :
> 
>    $ git grep qdev_get_machine hw/*/*pnv*
>    hw/intc/pnv_xive2.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/pci-host/pnv_phb.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/pci-host/pnv_phb3.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>    hw/ppc/pnv_lpc.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> 
> In the particular case of XIVE2, the solution is to rework
> pnv_xive2_get_remote() like it was for P9. See b68147b7a5bf
> ("ppc/xive: Add support for the PC MMIOs").
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> 
> 
> 


