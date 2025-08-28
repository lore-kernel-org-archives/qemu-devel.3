Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FF8CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbMp-0007WN-TN; Thu, 28 Aug 2025 08:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1urbMh-0007Ur-Vd; Thu, 28 Aug 2025 08:04:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1urbMe-00065L-UL; Thu, 28 Aug 2025 08:04:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SB17IS008810;
 Thu, 28 Aug 2025 12:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iNhtsC
 xtyXKRyGljNUYKyuUQbuXOucegUS+0eWZQnhA=; b=GtXl5VJ7WuRTqkjaYodAjA
 qEme7nbnhWyYzg0ITrkoQIL3fwRvkj2McB3sjwU2wvF3/jzeJHI2CVJI1uZtRJVe
 XDdGddfKUObIZpQ1zUX5rNf93r+Uq0eyYY3zb+e3eITnGvkuTSnofQQ87AZRAHCl
 A0/YXCD0fMTDeuWiog2PWGGwDjknSf782KsZzW/k3/q/llnp22fMe3KA43Wi9ewq
 u493dCJMciOpGyR8P/ujZbAxdZcBg06bsj03PWUG5MYaQhzeSRO628fwSeD7RCDH
 kIviblPlyocrle8yLH3AigSUSKIMaqXaYMMHba2hE64BmlfMKxXl2zxofoW+CnqA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tnv109sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 12:04:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57SC0k0O005057;
 Thu, 28 Aug 2025 12:04:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tnv109ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 12:04:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57S9RemE029986;
 Thu, 28 Aug 2025 12:04:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmvqjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 12:04:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57SC4DtY50004278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 12:04:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 760BB2004B;
 Thu, 28 Aug 2025 12:04:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E88420040;
 Thu, 28 Aug 2025 12:04:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Aug 2025 12:04:10 +0000 (GMT)
Date: Thu, 28 Aug 2025 17:34:08 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 gautam@linux.ibm.com, Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: Access to remote XIVE2 units (was Re: [PATCH v9 0/7] Power11
 support for QEMU [PowerNV])
Message-ID: <utzcz3bpixqmviolacg7qv2f526tedqovvx6wcrl6ypk3v4v7w@nmjtwot6lhjs>
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
X-Proofpoint-ORIG-GUID: EHeRsOlc8f7KmjaoZt4Sf4Gt7Gk-6Wgo
X-Authority-Analysis: v=2.4 cv=KMhaDEFo c=1 sm=1 tr=0 ts=68b045c3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gTffBqDDbQl0XjqN62EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MCBTYWx0ZWRfX9U0ky2jgUkHF
 omkY44bcvYHWfvsiogjvfXII4bW1fx5eQ4EKj7Gg+CqLGPH9G6MQvJw4mx9XGMcLmuJo5XHtwE5
 uJK64KpahuuIJ4v9sh3ZZBx7x2EMmhfW+W5V+SK3Hc1gz1lYUeJ6W5Lnn1WliVdhO4oGfIXDMmM
 75hMK2jXVeSI3nzpxjAliYNM2OQ5Vk1qD92BbxHNRRJuvPgGcJTSBTYJLzfUbG5SOB+Dccq5b/e
 GpNLS11l6vyDf/Y06axBR5EzFitJAloZW9aNlwp4h0b+XALrXnn3LcLc9tBKgZ9gb7hC+k08LuL
 x/7xC6xWuwETb72womts2vg8Fd2NdhkFMPxT/ywYJeoXB7SRwWJicvj/2BYC/uapLZKKXHnyREP
 nuMqkg+z
X-Proofpoint-GUID: -vM6pu0dRGv9xt7bzd5xy2OsHLemYOx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

+ Ganesh

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
> 

Hi Cedric,

While I am working with XIVE engineers to get the pnv_xive2_get_remote()
reworked as suggested (since it's a bit more work due to multiple cases
of indirect/direct vst, nvg/nvc types in case of XIVE2), I would like
to propose below patch to have as an interim solution to unblock
the PowerNV11 support patches.

Please let me know if it looks good to you.
I am planning to have this as part of the pnv11 patches.

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e019cad5c14c..0663baab544c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
-        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
-        PnvXive2 *xive = &chip10->xive;
+        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
+        PnvXive2 *xive = PNV_XIVE2(k->intc_get(pnv->chips[i]));
 
         /*
          * Is this the XIVE matching the forwarded VSD address is for this
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 673bb54c6789..907e029c51eb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1488,6 +1488,11 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
 }
 
+static void *pnv_chip_power10_intc_get(PnvChip *chip)
+{
+    return &PNV10_CHIP(chip)->xive;
+}
+
 static void pnv_chip_power11_intc_create(PnvChip *chip, PowerPCCPU *cpu,
                                         Error **errp)
 {
@@ -1532,6 +1537,11 @@ static void pnv_chip_power11_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
 }
 
+static void *pnv_chip_power11_intc_get(PnvChip *chip)
+{
+    return &PNV11_CHIP(chip)->xive;
+}
+
 /*
  * Allowed core identifiers on a POWER8 Processor Chip :
  *
@@ -2716,6 +2726,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
     k->intc_print_info = pnv_chip_power10_intc_print_info;
+    k->intc_get = pnv_chip_power10_intc_get;
     k->isa_create = pnv_chip_power10_isa_create;
     k->dt_populate = pnv_chip_power10_dt_populate;
     k->pic_print_info = pnv_chip_power10_pic_print_info;
@@ -2749,6 +2760,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k->intc_reset = pnv_chip_power11_intc_reset;
     k->intc_destroy = pnv_chip_power11_intc_destroy;
     k->intc_print_info = pnv_chip_power11_intc_print_info;
+    k->intc_get = pnv_chip_power11_intc_get;
     k->isa_create = pnv_chip_power11_isa_create;
     k->dt_populate = pnv_chip_power11_dt_populate;
     k->pic_print_info = pnv_chip_power11_pic_print_info;
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 6bd930f8b439..a5b8c49680d3 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -170,6 +170,7 @@ struct PnvChipClass {
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
+    void* (*intc_get)(PnvChip *chip);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, GString *buf);

Thanks,
- Aditya G


