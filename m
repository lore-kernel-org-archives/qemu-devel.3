Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE045C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 19:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZEhi-0002Xa-8F; Wed, 31 Jul 2024 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZEha-0002Us-Hl; Wed, 31 Jul 2024 15:09:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZEhY-0005Zq-HJ; Wed, 31 Jul 2024 15:09:34 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VHKZDq026382;
 Wed, 31 Jul 2024 19:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=U
 ZqAfn4T2UL4Y917Z+CmBvL/S9TKcTke18OJfNlBQQc=; b=pTGJy/pv7QwZo4nAu
 oKjKkQhDMdUM4ToBuo+Kpn9MLRxC0Vu72QDzAds21hzcDdxMUIWM5HNsVpJfQiPr
 CPZnc29PO2uiNGGp2StNJ2YauLcr/Kf6AY+6zs/CY2Kmjzl4nsAVJoawle/xos6J
 6MqFKSjgMWm3cJZyc0l5ARJLSu2zpm55RTvCOvbykQAlllI6tI+evCqP4FkuxWlu
 6eqczXKtAVY42HAUwsPUyKTesEZkl1nXROZYh7oeVhrQXcN0DC/0ehfcXDwBMPSP
 07zg+f+q5e9+wA2S1wxwKOiYD6khWI33PGDPafrA93cZfuQrTESRt+DhuAb9unm1
 A9TWA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qpmcgy7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 19:09:27 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46VJ9RCw030776;
 Wed, 31 Jul 2024 19:09:27 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qpmcgy7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 19:09:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VGSHE8009218; Wed, 31 Jul 2024 19:09:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx353np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 19:09:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VJ9KpY52035900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 19:09:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D49C22004B;
 Wed, 31 Jul 2024 19:09:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 962A520040;
 Wed, 31 Jul 2024 19:09:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.219])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 31 Jul 2024 19:09:18 +0000 (GMT)
Date: Thu, 1 Aug 2024 00:38:24 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] hw/ppc: Implement -dtb support for PowerNV
Message-ID: <rnb5kipb2zi7npkiq7vhdftiv6qdwmmu44wdlkcqjlxgvxd3j6@5cyzat6wgydz>
References: <20240731132235.887918-1-adityag@linux.ibm.com>
 <5dfc59ec-fa30-47c5-a4e0-edea921098d3@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dfc59ec-fa30-47c5-a4e0-edea921098d3@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iAD38pcozIIYd3Do90wviI7BrWsDeHqf
X-Proofpoint-ORIG-GUID: LG4MiwzJlS13fWpSC8pzkL9_S8-48Q9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=327 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407310132
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cedric,

On 24/07/31 04:43PM, Cédric Le Goater wrote:
> Hello Aditya,
> 
> On 7/31/24 15:22, Aditya Gupta wrote:
> > Currently any device tree passed with -dtb option in QEMU, was ignored
> > by the PowerNV code.
> > 
> > Read and pass the passed -dtb to the kernel, thus enabling easier
> > debugging with custom DTBs.
> 
> I thought we had enough controls with the QEMU command line options to
> generate a custom DTB. We should improve that first. Unless you want
> to mimic a bogus DTB as generated by hostboot and check skiboot behavior.
> 
> Can you explain more the use case please ? Is it for skiboot testing ?

My usecase is mostly experimental, where I am changing skiboot's
relocation, trying to boot with almost no/minimal parts of skiboot, and
thereby I am passing a custom DTB.

Though the DTB I pass is basically the DTB QEMU passes to skiboot, and
edited it to remove things, add an 'opal' node, and basically have more
control on what device nodes QEMU passes to the firmware/kernel.

The usecase you told seems interesting though, I have not encountered
bogus DTBs by hostboot yet (still new), but might help test skiboot when
that happens.

'-dtb' option will not be for the usual usecase, but can help try these
experimental things with a quick and dirty dtb.

Thanks,
Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> > The existing behaviour when -dtb is 'not' passed, is preserved as-is.
> > 
> > But when a '-dtb' is passed, it completely overrides any dtb nodes or
> > changes QEMU might have done, such as '-append' arguments to the kernel
> > (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> > when -dtb is being used
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > 
> > ---
> > This is an RFC patch, and hence might not be the final implementation,
> > though this current one is a solution which works
> > 
> > ---
> >   hw/ppc/pnv.c | 29 ++++++++++++++++++++++++++---
> >   1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 3526852685b4..12cc909b9e26 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -714,6 +714,8 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
> >       PnvMachineState *pnv = PNV_MACHINE(machine);
> >       IPMIBmc *bmc;
> >       void *fdt;
> > +    FILE *fdt_file;
> > +    uint32_t fdt_size;
> >       qemu_devices_reset(reason);
> > @@ -736,10 +738,31 @@ static void pnv_reset(MachineState *machine, ShutdownCause reason)
> >           }
> >       }
> > -    fdt = pnv_dt_create(machine);
> > +    if (machine->dtb) {
> > +        warn_report("with manually passed dtb, some options like '-append'"
> > +                " might ignored and the dtb passed will be used as-is");
> > -    /* Pack resulting tree */
> > -    _FDT((fdt_pack(fdt)));
> > +        fdt = g_malloc0(FDT_MAX_SIZE);
> > +
> > +        /* read the file 'machine->dtb', and load it into 'fdt' buffer */
> > +        fdt_file = fopen(machine->dtb, "r");
> > +        if (fdt_file != NULL) {
> > +            fdt_size = fread(fdt, sizeof(char), FDT_MAX_SIZE, fdt_file);
> > +            if (ferror(fdt_file) != 0) {
> > +                error_report("Could not load dtb '%s'",
> > +                             machine->dtb);
> > +                exit(1);
> > +            }
> > +
> > +            /* mark end of the fdt buffer with '\0' */
> > +            ((char *)fdt)[fdt_size] = '\0';
> > +        }
> > +    } else {
> > +        fdt = pnv_dt_create(machine);
> > +
> > +        /* Pack resulting tree */
> > +        _FDT((fdt_pack(fdt)));
> > +    }
> >       qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >       cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
> 

