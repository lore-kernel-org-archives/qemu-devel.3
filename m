Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED2C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 17:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc5sP-0001Mq-Ld; Wed, 16 Jul 2025 13:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uc5sJ-0001I3-Qz; Wed, 16 Jul 2025 13:25:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uc5sH-0007na-LF; Wed, 16 Jul 2025 13:24:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDcXTF005568;
 Wed, 16 Jul 2025 17:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=iy4nfG27XKR7VYLYyJH5yVGd/Fzt2+Jv5A+GDuoDCpk=; b=NHdNruhACzjz
 fA55Lp34Sb8O6Bfcn8NdxjBnmgc3h4F1A8QD8O+sUs7g6liMfcmPftYdK9A0D2Xu
 FziFBJDfIT5TatY+U1n/LLdtIAGMheE4grR8fyy/znFp6Pi4NpYxlMzRDnINt/2o
 +5SghnveXcOdzAkNCLdXBj3S0JvfgHVqRLA+2ZSGWqYSEPQxdSW4PQefwRvvFNXl
 KnUxhPQJx2xfpRZxQMOxYPlJhOtgObl2R5CdOsXz6ZRS4fgRftIwCZl8mVDjpCU0
 msVt0CTl0CGhvkNSmjiaeVvt7/Sss62ACVb/RCz34tgW13v6Ht4CHCKYNnF/Q4Z9
 OkouduKL9g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmsg7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 17:24:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56GHI8qi005742;
 Wed, 16 Jul 2025 17:24:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmsg7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 17:24:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFLUhx008914;
 Wed, 16 Jul 2025 17:24:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmrc1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 17:24:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56GHOp5F26739434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 17:24:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DADE558055;
 Wed, 16 Jul 2025 17:24:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 900E058043;
 Wed, 16 Jul 2025 17:24:51 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jul 2025 17:24:51 +0000 (GMT)
Message-ID: <957b82100001831432cd29fc3af5f022c14018c7.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/pci-host: PowerNV PCIe Device On Small PHB Seg Faults
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: kowal@linux.ibm.com, saif.abrar@linux.ibm.com, npiggin@gmail.com
Date: Wed, 16 Jul 2025 12:24:51 -0500
In-Reply-To: <20250716165017.2770845-1-milesg@linux.ibm.com>
References: <20250716165017.2770845-1-milesg@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5HAFQ7ywXrKVlsNj9jNOog6r2mrDlMV6
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=6877e067 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=TkP9fagCgQ7bEH1i6vAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: CWRnD5tE4lIQvy-XDKSMw-LXSaLpTFUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1NiBTYWx0ZWRfX6fZtTRfSYKlR
 SWens2zSSkn1y8sW3KkAfP2DPcJAhwxZoClxkA13H3Uzv4Dj0OSIz95KFs+MUiS7xWVNdaSTrOg
 DTycPAFQFgAAo1LG49BnPkBF7X/JQuX+QuVcYSMQgc9d+ND5bGvP7KFjz5w3MB54TyDJjkM6d9V
 6jLqb8SdNZoV6DE124xNJjtsX5mGLV2NX/yeONs0WS0nhHQofY25pwqyt+ecc0GNvBH459ED7LO
 e8GPUsSkcUt8S7358RxbSeGEeqqaXl2+ARvbYFrHil1Q3FwCWWoljaKdUdCrykm0hu3mvUAIPoZ
 Phc8mGBE0GtnBLWwmM2+Qq+odSJY3O6ZacNxh6XTq7HHEXZoipLl5jit/y7bcUIrtf+YId8kDW/
 8M8qiiLVyHsXu0+YM9C1YDmx7LPSlowGp6g/pSk20fhQQ4Dzhea2DbJVxNxZO8QVK+Zs3Mqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

+qemu-ppc@nongnu.org

On Wed, 2025-07-16 at 11:50 -0500, Glenn Miles wrote:
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
>  


