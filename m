Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B925CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 12:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1lSb-0005wu-5F; Thu, 25 Sep 2025 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1lSX-0005wG-9h; Thu, 25 Sep 2025 08:52:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1lSM-00043g-3p; Thu, 25 Sep 2025 08:52:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9VRdX008650;
 Thu, 25 Sep 2025 12:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GDPak2
 OH9WUAEfzX1MXIBwYw5iCngR34ohOL1TGZJuI=; b=DoENV1f8OXKrl+9dNN3xdx
 LJHjRppkVpanvXRAepQUBtYlhNvEFp5z/h9oKEcngVoQpI8LjsiZLz3xh7H6xIDo
 1Txsz4rGBxudX0poUqZEcN8Y3ZD9uuDabo7O587nGJvKVmHzEDX1Q9HbEUo8D+HZ
 1Q64cGBDmbH2rY6pwWzC/8l8WFKeKdHBC/Uc3pm3CH+2MW73ODeQc4fa5x+KelCy
 5eK1DXf71kZRIFSsvfekYM29t2XLhjbG92VD9+KcFLBSAxKIoQiinEipCPpzuF6c
 UYZp2pLRrpCuNn5PLEifyMNMaeDjzDqyaKttLrphCfJo//77epWSg0joCgFF/7Ow
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyvunb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 12:52:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PClvag002516;
 Thu, 25 Sep 2025 12:52:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyvun8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 12:52:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAOGeT013638;
 Thu, 25 Sep 2025 12:52:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjnpe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 12:52:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PCq3sX41288058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 12:52:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1E9020043;
 Thu, 25 Sep 2025 12:52:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B7F820040;
 Thu, 25 Sep 2025 12:52:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Sep 2025 12:52:01 +0000 (GMT)
Date: Thu, 25 Sep 2025 18:21:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Ganesh G R <ganeshgr@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 gautam@linux.ibm.com
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
Message-ID: <of64frvhccos2fbzufdrqze4vqt6tr7qu322mryhvqakkcrzlc@ysvmkca3owoz>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
 <baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com>
 <yo6uk5z6dlq4jlk5hsaoyhymozdpo6ijpq5bz4fipkf5ftws4b@um57vsttgf65>
 <wdkarichs5jrmpz3k4gxosw42dt6qxwodnc6t6tcuecsmxgqcd@km4q644fiixb>
 <04eb08b6-b787-47f3-86b7-b2d3a0f50ed6@redhat.com>
 <utzcz3bpixqmviolacg7qv2f526tedqovvx6wcrl6ypk3v4v7w@nmjtwot6lhjs>
 <3456f764-616b-412c-839c-aaef4bf1e47c@redhat.com>
 <f22953e3-5e87-4c86-844a-aba5c35ca3ca@linux.ibm.com>
 <900db31c-54d5-410d-934e-347ca0b22ec2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900db31c-54d5-410d-934e-347ca0b22ec2@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d53af8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gDPyuUbt8ubQmREcO3oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3y21MwkdDJrmA_8fzc0qtkRrSZZaFCQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX+wKPbJD+2ah2
 6Tj2akHH7Ys4XO9jLXBk9kijgMahiPT8sxiXqKNXgni+k7KF6MVR/GdAAm4MXqulDG0yhA3Nsc2
 54cxqo4WljN3A4/Jq8ks1mYriyzLI4QmGVAxp4MQZvgW9yc6tDJbh6VQp+HY/gHyvumpPfFP1NN
 TAuRsQ3U37wsWTY9Xu9jb9f/Szx+uZB4p+v6GhgU2lr/5jtrFHYbK/Mp2A6pfLuoGlrrDhTUhLD
 PcTyX22DyhlcmZuPjOKIQ8YPCGgRLmfgVXY4xo4KUwjfjifMeFtreLrcPA8qRbyAOgMet3jbZ2I
 cjf5uAtt9hQ4VZkRstxYihnuUUHjKz7UVrewAf+lO2n7l37ZQPQ7gIEx3PoaTcWrnB9xD+4oI+X
 rqYqK0y5
X-Proofpoint-ORIG-GUID: 9X4eV-dT1lAoZTxJ0B_DoOx1uMWZOIXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On 25/09/25 08:38AM, Cédric Le Goater wrote:
> On 9/24/25 14:14, Ganesh G R wrote:
> > 
> > On 8/29/25 3:19 AM, Cédric Le Goater wrote:
> > > On 8/28/25 14:04, Aditya Gupta wrote:
> > > > + Ganesh
> > > > 
> > > > On 25/08/10 02:46PM, Cédric Le Goater wrote:
> > > > > + Glenn
> > > > > + Gautam
> > > > > 
> > > > > On 8/10/25 12:45, Aditya Gupta wrote:
> > > > > > On 25/08/10 12:26PM, Aditya Gupta wrote:
> > > > > > > > <...snip...>
> > > > > > > 
> > > > > > > About the error, seems xive2 always expecting powernv10 chip, I will
> > > > > > > have to rethink how should I use the same xive2 for powernv11.
> > > > > > > 
> > > > > > 
> > > > > > There's a type cast to Pnv10Chip in 'pnv_xive2_get_remote'.
> > > > > > The cast is only temporarily used to get the 'PnvXive2' object in the
> > > > > > Pnv10Chip.
> > > > > > It's the only place in hw/intc/pnv_xive2.c assuming Pnv10Chip object.
> > > > > > 
> > > > > > Thinking to have a helper function to just return the 'PnvXive2' object
> > > > > > inside the chip, given a 'PnvChip'.
> > > > > > 
> > > > > > Or the below change where we are adding another pointer in PnvChipClass:
> > > > > > 
> > > > > >       diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> > > > > >       index e019cad5c14c..9832be5fd297 100644
> > > > > >       --- a/hw/intc/pnv_xive2.c
> > > > > >       +++ b/hw/intc/pnv_xive2.c
> > > > > >       @@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
> > > > > >            int i;
> > > > > >            for (i = 0; i < pnv->num_chips; i++) {
> > > > > >       -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> > > > > >       -        PnvXive2 *xive = &chip10->xive;
> > > > > >       +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
> > > > > >       +        PnvXive2 *xive = k->intc_get(pnv->chips[i]);
> > > > > >                /*
> > > > > >                 * Is this the XIVE matching the forwarded VSD address is for this
> > > > > > 
> > > > > > Which one do you suggest ? Or should I look for another way ?
> > > > > > 
> > > > > > I am preferring the first way to have a helper, but both ways look hacky.
> > > > > 
> > > > > Any call to qdev_get_machine() in device model is at best
> > > > > a modeling shortcut, most likely it is a hack :
> > > > > 
> > > > >    /*
> > > > >     * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
> > > > >     * scan of all the chips INT controller is good enough.
> > > > >     */
> > > > > 
> > > > > So all these calls are suspicious :
> > > > > 
> > > > >    $ git grep qdev_get_machine hw/*/*pnv*
> > > > >    hw/intc/pnv_xive2.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/pci-host/pnv_phb.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/pci-host/pnv_phb3.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/ppc/pnv.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/ppc/pnv_chiptod.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > >    hw/ppc/pnv_lpc.c:    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> > > > > 
> > > > > In the particular case of XIVE2, the solution is to rework
> > > > > pnv_xive2_get_remote() like it was for P9. See b68147b7a5bf
> > > > > ("ppc/xive: Add support for the PC MMIOs").
> > > > > 
> > > > 
> > > > Hi Cedric,
> > > > 
> > > > While I am working with XIVE engineers to get the pnv_xive2_get_remote()
> > > > reworked as suggested (since it's a bit more work due to multiple cases
> > > > of indirect/direct vst, nvg/nvc types in case of XIVE2), I would like
> > > > to propose below patch to have as an interim solution to unblock
> > > > the PowerNV11 support patches.
> > > 
> > > pHyp is an unknown FW implementation for opensource. Until an image
> > > is released somewhere (please think about it), QEMU has nothing to
> > > worry about other than supporting OPAL.
> > > 
> > > For now, let's forget about the grouping aspect of XIVE2, simply
> > > rework pnv_xive2_get_remote() as it was done in b68147b7a5bf for
> > > XIVE. This shouldn't take long. And, for the nvg/nvc types, report
> > > an error of some sort and add a TODO in the code.
> > > 
> > A similar change cannot be done to XIVE2, because Fredric’s commit (96a2132ce95) has introduced modifications to the NVPG and NVC MMIO callbacks in order to support backlog counter operations.
> 
> Thanks for looking.
> 
> Indeed. So I guess Aditya's proposal adding a new PnvChipClass handler
> is then the best alternative :
> 
> @@ -170,6 +170,7 @@ struct PnvChipClass {
>      void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>      void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
>      void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
> +    void* (*intc_get)(PnvChip *chip);
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>      void (*dt_populate)(PnvChip *chip, void *fdt);
>      void (*pic_print_info)(PnvChip *chip, GString *buf);
> 
> Aditya,
> 
> Could you please resend the whole powernv11 series including this
> new patch for xive2 ?

Sure, will post v10 today.

Thanks Cedric !

> 
> Thanks,
> 
> C.
> 
> 
> 

