Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D749CC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5N2z-0004cX-Vw; Sat, 12 Sep 2026 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N2y-0004bu-CY; Sat, 12 Sep 2026 08:41:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N2w-0002fV-PC; Sat, 12 Sep 2026 08:41:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CC1iex342052; Sat, 12 Sep 2026 12:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5pXvg0Bhl+bhfc/6kQdts/eA+36op9
 rr6FJNkM0gwM0=; b=TQO5IF/UFDPJzdI+myl2r8R2gLN3wdk0FW47V+xxpVQeFN
 gDD9ynGsQs7ELARGvLyszZcecpiYv1rcyAwL2+oyjysr8YizdTIS0XeJU4JgzMOT
 +mWTFnv54XW/mhfVB1d86pSZ3BdF5Sum1+3/RFm+/7UE3h1dv+Mjewy+jI6GFABb
 MRSZlp0LoJKRP4YptN8ONnb+ji9KQjzy5FCZFlMXu1RDbK9eHC4IaZ+NyqFH7doN
 GDiF6dhvV46/x8BRuOvGr9mZ6cbjiPLnjPlBoh2G/YUB2jtzX8sgDHIuyi2hfpgM
 KtArMN/XmAS5dKYNP48dXfE6Rij3bgaRXHj2jQQg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5h9mq6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:41:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBbHRR3208991; Sat, 12 Sep 2026 12:41:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrk1uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:41:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68CCfHC433292586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Sep 2026 12:41:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B4282004B;
 Sat, 12 Sep 2026 12:41:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBF282004D;
 Sat, 12 Sep 2026 12:41:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.87.143.209])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 12 Sep 2026 12:41:11 +0000 (GMT)
Date: Sat, 12 Sep 2026 18:11:09 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 6/9] pnv/phb5: Set link-active status in HPSTAT and
 LMR registers
Message-ID: <aqVICRVbBpb2nFGg@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX1ya3iUgE4lrQ
 FiDGx9LfXfiLkZ2OVdbricUZhOgocj07ZKv+XfOAgCQuHKBG2Cop47EPmR8Npe4/hhbFHNbHyZ4
 1wTtqaSqfSXVw4xViwK+LxtJ+EOBFvarhLDkegoooFGsSxOzQxlaFmOie/BWgWz6ulxijRoshX2
 53h2B961XpiPjOZjzDDNliMqTEr6IwAKqJlTu67KvqDyJXAPwXMwX6ln1rjR0nIUaHKMvwFj2Us
 iw5gcsL5koT49sySUiBz03qZwu2ZS5z0kQh9FOrJA68kWfO6nKrB7l5zxZkH+kuxPRKufhK3aS/
 fyvshJQWmA4duIUvBhNn7KvKmKKij8s7eNAayBj4ZKfxHscbcaLhFodIIV2AGUErNhStHy/tW49
 WTE9bT0lo7mIdnIQg5OyUfxF5TIq3puDzSGn+OSLw9hBFbvmvzUSP8qCgfTqLpQRHxIHCVBEU2O
 GFTrBQpJMjXlzrC1Hyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfXxZPTw6KI9uRY
 cT34bJcui/AL5qWA5xXIeqVBLzQBT+kV26D3aM3dlBKe+GhWLM0lipHyc/SIztP9Bn2NoMraapm
 5DrllEcSh4FrYgpy8A6T8+LXPPu67Wg=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa54872 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=9Wmz2YlmeVWVfbCXqH8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 93yeuEOQ0IH6PpzyEXxOB5LxomNI73S4
X-Proofpoint-GUID: 8gFzHlMSezhyWn_Mqyidbo3WVKQfTukA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120181
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/08/31 07:30AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> > <...snip...>
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -508,6 +508,34 @@ uint32_t get_exp_offset(PCIDevice *pdev)
>      return rpc->exp_offset;
>  }
>  
> +/*
> + * Config-read the link-status register in the PCI-E macro,
> + * convert to LE and check the link-active bit.
> + */
> +static uint32_t is_link_active(PnvPHB4 *phb)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_offset = get_exp_offset(pdev);
> +
> +    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
> +                        exp_offset + PCI_EXP_LNKSTA, 4)) &
> +                        PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +/*
> + * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
> + * RC-config space values and masks are LE.
> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
> + * Compute new value in LE domain.
> + * New value computation using sticky-mask is in LE.
> + * Convert the computed value from LE to BE before writing back.
> + */
> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
> +    (pci_set_word(conf + (a), be16_to_cpu( \
> +                     (be16_to_cpu(pci_get_word(conf + (a))) & (s)) | \
> +                     ((v) & ~(s)))))

this is already defined in a previous patch in pnv_phb4.h

may have somehow gotten added in v6, can remove this

- Aditya G


