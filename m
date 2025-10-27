Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A93CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQ3B-00008P-4R; Mon, 27 Oct 2025 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vDQ30-0008TI-VG; Mon, 27 Oct 2025 12:26:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1vDQ2p-00062d-1Z; Mon, 27 Oct 2025 12:26:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBkFJh030841;
 Mon, 27 Oct 2025 16:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ga3FTh
 HUkA6YWdMZGG0tqgW78GPBjqDhV45dXMX46Gg=; b=m+T9H1DdaPL17u5kXKa0VU
 hx+2sHCSepvA51WpNaic8tI8JB0TocviM0sCNJcubrC8mSOET3FSD7hQ36kuNTgU
 t1TGyYbChffOkt5yO2wI5rjDhLIpDUkW94QgUXm+A7ScGzkAhZgR7Hfh4nrW9xOC
 PRbxFqRO6IqDOYIJ+NX13IzYSvyHq+nLZWUbQGmuoTlyEdg+dUGaBltUgaZbZNZ1
 oCGQ5LKh1GkjCMR1oJdWH7TpDrhTBCjYhRYocgQ7QoFtFcIx4aTFhzEUF3+Sk8Kj
 1Ts8PITikRaB1cJHrozi9uigag5m1DP5bTynrB5F6tSqCZ2Ww7tZh25xs8iRGu7A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81qs8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 16:25:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RGPtsC000585;
 Mon, 27 Oct 2025 16:25:55 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81qs8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 16:25:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFuwTV009411;
 Mon, 27 Oct 2025 16:25:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hx9dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 16:25:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59RGPrFH20120140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Oct 2025 16:25:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9C7F58050;
 Mon, 27 Oct 2025 16:25:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3DEB58045;
 Mon, 27 Oct 2025 16:25:51 +0000 (GMT)
Received: from [9.124.208.205] (unknown [9.124.208.205])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 27 Oct 2025 16:25:51 +0000 (GMT)
Message-ID: <dbba1c6c-93a4-4971-bc78-50d462071101@linux.ibm.com>
Date: Mon, 27 Oct 2025 21:55:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: Cleanup MSI IRQ number handling
To: Yoges Vyas <yvyas1991@gmail.com>, qemu-ppc@nongnu.org, philmd@linaro.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org
References: <20251026074852.53691-1-yvyas1991@gmail.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20251026074852.53691-1-yvyas1991@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=68ff9d13 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=-ID4gspGWmwj0WES3LgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xNlY0R0cnVghUoU-duN37Pms9MyNYkCs
X-Proofpoint-GUID: S-w-5JLFhdQr1nNv9_lEBD-QZLLLqMH3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX7SaD/VYnZcB1
 DB5CXLV8tkK9EIxZZIjLnfx3zBxD0U3zk0pHstf4J9pfgQRCZbd3TSxwz5awasIA5h3ISxLEMmD
 EdRnZPxkKUcocNC1jelrX4rOdjtT4wD3LWOAVcOs51+0FQbXdUCyYJx/bm2pxNZIsvhr4sxmq4/
 XHIiI6vl0WnqySEjsr689RhjB2mM2G0Rh5WbR7pmvlZEHEZBhSs0m+mEjqHwNzosFj3qL+epK2E
 fbV03td3Sx39qU2QJsoIj3uRKx5Vn642x0kctaJd3s0PnvUtPFA1KOwc+vfYwER42MBtZrOfncD
 cnKPm4Pd1AUmfqw4qWXH9vymtHnVjuOFZdiFOR7XzJ2xk09ofP7plKK4RsTujuYiOBwFyzEv/YS
 3BOTsMJyAh8Q+X6ZaXNG8JiLrsePsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 10/26/25 13:18, Yoges Vyas wrote:
> Now that spapr_irq_nr_msis() returns a constant value,
> lets replace it with a macro.
> Ref: https://lore.kernel.org/qemu-devel/bf149815-9782-4964-953d-73658b1043c9@linux.ibm.com/
>
> Suggested-by: Chinmay Rath <rathc@linux.ibm.com>
> Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   hw/ppc/spapr_irq.c         | 7 +------
>   hw/ppc/spapr_pci.c         | 2 +-
>   include/hw/ppc/spapr_irq.h | 2 +-
>   3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2ce323457b..fc45a5d5d6 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -33,7 +33,7 @@ static const TypeInfo spapr_intc_info = {
>   
>   static void spapr_irq_msi_init(SpaprMachineState *spapr)
>   {
> -    spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
> +    spapr->irq_map_nr = SPAPR_IRQ_NR_MSIS;
>       spapr->irq_map = bitmap_new(spapr->irq_map_nr);
>   }
>   
> @@ -277,11 +277,6 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>       sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
>   }
>   
> -uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
> -{
> -    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
> -}
> -
>   void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>   {
>       if (kvm_enabled() && kvm_kernel_irqchip_split()) {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bdec8f0728..d596a9e38e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2279,7 +2279,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
>       _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>       _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1));
>       _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> -                          spapr_irq_nr_msis(spapr)));
> +                          SPAPR_IRQ_NR_MSIS));
>   
>       /* Dynamic DMA window */
>       if (phb->ddw_enabled) {
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5ddd1107c3..265d43e06b 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -40,6 +40,7 @@
>   #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
>   
>   #define SPAPR_NR_XIRQS       0x1000
> +#define SPAPR_IRQ_NR_MSIS    (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_IRQ_MSI)
>   
>   struct SpaprMachineState;
>   
> @@ -89,7 +90,6 @@ void spapr_irq_print_info(struct SpaprMachineState *spapr, GString *buf);
>   void spapr_irq_dt(struct SpaprMachineState *spapr, uint32_t nr_servers,
>                     void *fdt, uint32_t phandle);
>   
> -uint32_t spapr_irq_nr_msis(struct SpaprMachineState *spapr);
>   int spapr_irq_msi_alloc(struct SpaprMachineState *spapr, uint32_t num, bool align,
>                           Error **errp);
>   void spapr_irq_msi_free(struct SpaprMachineState *spapr, int irq, uint32_t num);

