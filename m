Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DFDCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9id-0001LI-2r; Tue, 21 Oct 2025 06:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vB9iW-0001Kl-In; Tue, 21 Oct 2025 06:35:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vB9iT-0007KM-FE; Tue, 21 Oct 2025 06:35:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8gw06027261;
 Tue, 21 Oct 2025 10:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jDhN/f
 NFzoR77A4VdcFCyljO8WeAyN6Xkp3r2pTuW/s=; b=L0Fg9/igVvff72Pt+QhHDE
 G18CZ3n4QioUcrQFNuxE47NvXOkLDpANgsCL1ShJM+ZgLpVu08VBbtv0C6CpLuG7
 xhT6BRnk76KRU8z6n+E16TdZmuwu0GwfzvdLvPrWseLXHAJI0NoHOLcGYdeJpbfF
 axy10CmoH1euo39YVz3ZDAGMEfi24ESuX8HfWbccKSqwWMTbLk/yyY6/UhH+ddtb
 0JvdOS0x+12uA0B5OPJq9+8ere0QiP2t2TGZuOzSaz4bj1LUMmTlXR/dr/SqGILU
 5AC17yNyfGzN8h/rW02vVmqnoK0nbok/1uAF0xH8vWPfA326OQeyJPkZbx2KunGg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f6fdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:35:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LALWfY006604;
 Tue, 21 Oct 2025 10:35:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f6fdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:35:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8iuc3024686;
 Tue, 21 Oct 2025 10:35:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjt67p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:35:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LAZOoB23396972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 10:35:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D6825805C;
 Tue, 21 Oct 2025 10:35:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C15345805F;
 Tue, 21 Oct 2025 10:35:34 +0000 (GMT)
Received: from [9.79.201.141] (unknown [9.79.201.141])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 10:35:34 +0000 (GMT)
Message-ID: <003640ee-8bd6-4366-b9eb-841c671bbf93@linux.ibm.com>
Date: Tue, 21 Oct 2025 16:05:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs
 field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <20251021084346.73671-3-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251021084346.73671-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f761fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=E3IZGcUWJODU3JGwBZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: j7Rch_yy3CGt35pD3RIwzm29faEQDqPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1H0M0HH5d3UD
 zCUpykDAXfpbwtpo9QUoFbp9w0wYvLJcmln772XmMRsJgvB2zis6UlDlAjAwJXTzC5I8gI2vFtm
 MFd7cUi9lo/kinDR9veMP6t9JvD6G+VRcHv/EOBtyTloPi4s4GpWc7Rqh5+3OeYHsuFzdGEDrKH
 UNce58FW1BbPDqmG2eHMiT+frHCEi7MyOTHBeUNWfOTri1hKWWJ6Olvrel0L0AzbUgVKWcyrI1R
 IE93U7I/yq3yV1CJaWkN1MaVVPCnIMViv7dbIeOlfNQgX2WfVpJhVCXF0I5fzey5MrTOa9JZrm3
 UIobfd9iH1vzlrIf+Cjt71oy2qA6lDjzHxjvdq89CZYYDEQ3Kw/jCs5GNBeQEt3+Psmoh4tEQhN
 DsVK5VgwRVHyKsWD+ngr1l6ADjJ38A==
X-Proofpoint-ORIG-GUID: p36Pj74-xOpFNMmX3qz_Aq_ACeNhUSkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 10/21/25 14:13, Philippe Mathieu-Daudé wrote:
> The SpaprMachineClass::nr_xirqs field was only used by the
> pseries-3.0 machine, which got removed. Remove it as now unused.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/spapr.h |  1 -
>   hw/ppc/spapr.c         |  1 -
>   hw/ppc/spapr_irq.c     | 22 +++++++---------------
>   3 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0c1e5132de2..494367fb99a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -145,7 +145,6 @@ struct SpaprMachineClass {
>       /*< public >*/
>       bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
>       bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> -    uint32_t nr_xirqs;
>       bool broken_host_serial_model; /* present real host info to the guest */
>       bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>       bool linux_pci_probe;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 426a778d3e8..b5d20bc1756 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4691,7 +4691,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
>       smc->dr_phb_enabled = true;
>       smc->linux_pci_probe = true;
>       smc->smp_threads_vsmt = true;
> -    smc->nr_xirqs = SPAPR_NR_XIRQS;
>       xfc->match_nvt = spapr_match_nvt;
>       vmc->client_architecture_support = spapr_vof_client_architecture_support;
>       vmc->quiesce = spapr_vof_quiesce;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 317d57a3802..2ce323457be 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -279,15 +279,11 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>   
>   uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>   {
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> -
> -    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
> +    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
>   }
Hey,
With this cleanup, I think we can get rid of the SpaprMachineState 
argument passed to spapr_irq_nr_msis function since it is not used 
anymore ^.

Regards,
Chinmay
>   
>   void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>   {
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> -
>       if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>           error_setg(errp, "kernel_irqchip split mode not supported on pseries");
>           return;
> @@ -308,7 +304,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>           object_property_add_child(OBJECT(spapr), "ics", obj);
>           object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                    &error_abort);
> -        object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, &error_abort);
> +        object_property_set_int(obj, "nr-irqs", SPAPR_NR_XIRQS, &error_abort);
>           if (!qdev_realize(DEVICE(obj), NULL, errp)) {
>               return;
>           }
> @@ -322,7 +318,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>           int i;
>   
>           dev = qdev_new(TYPE_SPAPR_XIVE);
> -        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
> +        qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
>           /*
>            * 8 XIVE END structures per CPU. One for each available
>            * priority
> @@ -349,7 +345,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>       }
>   
>       spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
> -                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
> +                                      SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
>   
>       /*
>        * Mostly we don't actually need this until reset, except that not
> @@ -364,11 +360,10 @@ int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>   {
>       SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
>       int i;
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>       int rc;
>   
>       assert(irq >= SPAPR_XIRQ_BASE);
> -    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
>   
>       for (i = 0; i < ARRAY_SIZE(intcs); i++) {
>           SpaprInterruptController *intc = intcs[i];
> @@ -388,10 +383,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>   {
>       SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
>       int i, j;
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>   
>       assert(irq >= SPAPR_XIRQ_BASE);
> -    assert((irq + num) <= (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert((irq + num) <= (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
>   
>       for (i = irq; i < (irq + num); i++) {
>           for (j = 0; j < ARRAY_SIZE(intcs); j++) {
> @@ -408,8 +402,6 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>   
>   qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>   {
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> -
>       /*
>        * This interface is basically for VIO and PHB devices to find the
>        * right qemu_irq to manipulate, so we only allow access to the
> @@ -418,7 +410,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>        * interfaces, we can change this if we need to in future.
>        */
>       assert(irq >= SPAPR_XIRQ_BASE);
> -    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
>   
>       if (spapr->ics) {
>           assert(ics_valid_irq(spapr->ics, irq));

