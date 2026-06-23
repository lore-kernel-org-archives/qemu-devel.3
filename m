Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB19CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7yh-00035t-0L; Tue, 23 Jun 2026 16:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7yc-00035Q-EJ; Tue, 23 Jun 2026 16:44:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7ya-0005bi-Gc; Tue, 23 Jun 2026 16:44:10 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NKIW702962017; Tue, 23 Jun 2026 20:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Q4DNCH
 DIFADXGpwk1XQ5oQQ6sgGWgBDSqWDXcSsImk4=; b=EZVAlEVEzJYyLgYRz0mNQg
 kGesP0yHvipckzWmjdWDkivrt5z4tnDANHjkEUAnI2MuuNA7x4a4RpI0tFvpw/j3
 O9R4319HJbpyn+tIUZRpifmo+5oGWvl9CSMDzUNOJXQ5Yr/bPCXTsI7yqObkhDNs
 q2YaIRhyVULCB5QrOe592j/gayMkWkiuttbxzIXVhlh74BY7HzC1+Otsz2B62+C9
 zxNSREyta3z7XosImWbvAyYXEgQIlnLs64FbRl1NZqkPB2yl2QHh2a2qWMNezVij
 Ik2i4nBEzNJkZy0sCSn+90DX0pty2ttTv5BElAmEra/DgB+4UeiJZe6OzjeFwUPw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsrp8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:43:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NKYfox028347;
 Tue, 23 Jun 2026 20:43:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k5cgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:43:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NKhtKR27001344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 20:43:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ACB058054;
 Tue, 23 Jun 2026 20:43:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5B5E5805A;
 Tue, 23 Jun 2026 20:43:53 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 20:43:53 +0000 (GMT)
Message-ID: <d3d7e6fe-2d22-4bd5-b944-f93a9f549436@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:43:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] pnv/phb5: Set link speed and width in the DLP
 training control register
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-8-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-8-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfX05tVja3oev3H
 I6gOy7LoeB6ZKRZ1P0UOO0t9/efGXq0S0vmJH7TS6H7+IYFvAQvKd4gA7d1PECpMOyXNIVPtoGq
 dYJ3GeJJXdBqikmwkiX5TCoxyRoDRB2fUcRfGSxydqz3XVgl2CzD9htjzMAL7KqnwO0NdJkpu5t
 AmE5iziIOcUDdcohNk05j5+CItEDuMXFwH/j5SuhAXXvJvaMeRt5T88FD7RcoshlNh82z54iyMj
 A+m2vfEjTRkz2mLO4SKdTGEx+JgDm6uPSseR0eHL0NS1h3JK1QIj33hMeeiriN50u4v8LEsE1a9
 6f1FDPk6aaWqYRa7OgioGm3Yt7ElaQjxnIuTyEJeeRPuDCTcnTELMhE01ep9t00fCbfvVDdnJP7
 fqWZiza1IVqqPktWyA185tkg6XnupQ==
X-Proofpoint-GUID: mPhBtJ98Iyvdj9dtVAAfgt96GYcW-AcB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfXxbgIczsWmzUB
 tEDyNkv9n+KrGtEtGuUhQhjVMzj9/cFocyZwZvUSjUXC00GSyQKApi+gzfpiHpgww7sETw/Unen
 3PxtxOYJpz4W3lAT9TbRMoelW2x/JD8=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3af00d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=ziolJ_MlSwNb-FFgIvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: xj6Lq120AG7aeapKPSAB6CGvWVXGJ2F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230167
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
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

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 6/17/26 4:50 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> Get the current link-status from PCIE macro.
> Extract link-speed and link-width from the link-status
> and set in the DLP training control (PCIE_DLP_TCR) register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5: Using be16_to_cpu as appropriate.
> v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
> v3: Updates for coding guidelines.
> 
> 
>  hw/pci-host/pnv_phb4.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 125f610790..e9d9323dba 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -899,6 +899,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>      uint32_t exp_base = get_exp_offset(pdev);
>      uint64_t val;
> +    uint32_t v, lnkstatus;
>  
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>          return pnv_phb4_config_read(phb, off & 0x3, size);
> @@ -960,10 +961,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>          val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>          break;
>  
> -    /* Link training always appears trained */
>      case PHB_PCIE_DLP_TRAIN_CTL:
> -        /* TODO: Do something sensible with speed ? */
> +        /* Get the current link-status from PCIE */
> +        lnkstatus = be16_to_cpu(pnv_phb4_rc_config_read(phb,
> +                                exp_base + PCI_EXP_LNKSTA, 4));
> +
> +        /* Extract link-speed from the link-status */
> +        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
> +
> +        /* Link training always appears trained */
>          val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +
> +        /* Set the current link-speed at the LINK_SPEED position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
> +
> +        /*
> +         * Extract link-width from the link-status,
> +         * after shifting the required bitfields.
> +         */
> +        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +        /* Set the current link-width at the LINK_WIDTH position */
> +        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
>          return val;
>  
>      /*


