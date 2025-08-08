Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 03:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukEC7-0002xg-7D; Thu, 07 Aug 2025 23:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukEC5-0002c0-44
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 23:55:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukEC3-0006gm-1i
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 23:55:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577H0gsR021039
 for <qemu-devel@nongnu.org>; Fri, 8 Aug 2025 03:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=eo3URq/4g6QIdPAzb/ijREisQ9yM58
 DL/5xSKsk2i5c=; b=NyjwZDOUysquPgVMYlcBjh3hU+WFPsAF8B8f3o8UbTf8Yw
 mHDOIMRQae2fs7fQUs4jJ+AUM0NuldEnlikHUbiU7fo3t2hZU2yqaoHUBnTCrNAf
 kJLOLlb4JDkExYEcf8AIdhH29XP38gEbeXji/xFSH/+8J/sfF7XbnrH2LC9I4hz7
 JHfJBuJBOToi7blyAmt2fo9DSVe+yT+USCIU4UJfag0cOsPi48C3dU1IobbsoCJb
 /5iVA3Lez54gn6XRuLOK6CcktYvScqfzXBifXiT4r3EmSL282sUDNQI254TvL8tv
 SunrY+DZIVl5f6PxfD3zvFLUSE+lAyj8LFMUtldQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63dvyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 03:54:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5783stS4029839;
 Fri, 8 Aug 2025 03:54:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63dvyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 03:54:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5781Lh0v020626;
 Fri, 8 Aug 2025 03:54:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn3wav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 03:54:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5783soCv17957270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 03:54:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A755820040;
 Fri,  8 Aug 2025 03:54:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 227162004B;
 Fri,  8 Aug 2025 03:54:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  8 Aug 2025 03:54:48 +0000 (GMT)
Date: Fri, 8 Aug 2025 09:24:46 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, kowal@linux.ibm.com, saif.abrar@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com
Subject: Re: [PATCH] hw/pci-host: PowerNV PCIe Device On Small PHB Seg Faults
Message-ID: <45hw3enufxweiqhn5s53s4filgpev5rhjufgioxknin7ai7w4d@wjuzzilgi2kh>
References: <20250716165017.2770845-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716165017.2770845-1-milesg@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6895750f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=Y6kiNRptasqeY4QxNtoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: T6To-i49Rw8KtPAP-Q_777jpIUPuEx-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDAzMCBTYWx0ZWRfX2ZKhvEzj4qxE
 fJkFmJeJs5pGXwbYEM3fiYlMwm0mcTZfm6nIEvR8jusupg9RVGJEyfiAvpwaMmf7wA8oGLaykA1
 wslfJlEqGAeOGwPuY1EUf0T6tWVDkmlXH5/qgJaf1g34riQq2PRPep5WUOiTX9sQAXmNRALkY5L
 XeWiOHNgglvNJrAdwCan2Fhk8OwRIQ5udSphDSLHkbyZxv5x0UlXg4bVr0Fd21rbaua48F97ro3
 lnBEL+FpIAUT9OwnNUiAMCbFaFEVQIywe78zB/sTJbDSOiyJ9pvqzGS+GhKkgH2OxG8EFpR855S
 HXK5dHUxqvbIDrgyCDC885brUtDVb30aGAoVwhUuNgE5Hr/ys4XAxtr5ubiYhZvv4dwGw8njNl4
 +/+ismXKu299SRYT9WVo4PRGiF4wdHofQncD21pBdYTxNbEjVdkN3OVeUFKTYfmt4650w2yR
X-Proofpoint-ORIG-GUID: KEx2yEOflLMChH5Rt5nO-QFVHEO0N84I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080030
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

On 25/07/16 11:50AM, Glenn Miles wrote:
> The PowerNV PCI Host Bridge (PHB) supports a large and small
> configuration where the small configuration supports only
> half the number of interrupts supported by the large configuration.
> 
> Since the PCIe LSIs are allocated at the end of the PHB IRQ list,
> when calculating the LSI IRQ number, the code must take into
> consideration the number of IRQ's supported by the PHB.  This
> was not happening and was resulting in a QEMU segmentation fault
> when a PCI device was added to a PHB with the small configuration.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/pci-host/pnv_phb4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 18992054e8..aeb2a45b4b 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1167,6 +1167,7 @@ static int pnv_phb4_map_irq(PCIDevice *pci_dev, int irq_num)
>  static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
>  {
>      PnvPHB4 *phb = PNV_PHB4(opaque);
> +    XiveSource *xsrc = &phb->xsrc;
>      uint32_t lsi_base;
>  
>      /* LSI only ... */
> @@ -1175,6 +1176,7 @@ static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
>      }
>      lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>      lsi_base <<= 3;
> +    lsi_base &= xsrc->nr_irqs - 1;
>      qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
>  }

Looks good to me. And passes all powernv functional tests, hence:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


