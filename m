Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC99CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLjCi-0000WV-PQ; Sat, 09 May 2026 11:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjCf-0000W2-0u; Sat, 09 May 2026 11:02:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLjCd-0007Po-Ag; Sat, 09 May 2026 11:02:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649DjSSN4135533; Sat, 9 May 2026 15:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tslNXr
 1JlS6tYeq/5h1kRu4Hr+TAZcditdbuv9qQQoY=; b=jiqn6LT3xZv9ET1CCukc7P
 egZiTK4Rdeh77JytP7+Ruia6wLZxiDQeDA68rP+qqZleC4hnc7XJZV4heIwKKEIt
 CF60dzhAe80KlpCqJD+JTi1Jof06iz3MVskshQ/H+MsTPzW0Irgf6x4W/4ivrlje
 SzN8coVdH62STip0wB2EHAYJ3COeDFNH+LXSuiaamKijbchnrVmniMr72Zbrw4FK
 nviVYkFcosnwYpwgBAOaavdj8/xmz/NFgrvq1ZETsCQrT+jhZFpX5aQR3AMqGcju
 HrB/i2+MolEg7lFkcKJ1XkPvoc2dzQQvnvkOBIEEuMWDwt/Z27xMvkUQoTN/PUSA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqhx8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:02:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EdeZf009190;
 Sat, 9 May 2026 15:02:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkkcws5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 15:02:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649F2aG147120708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 15:02:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 736EC20043;
 Sat,  9 May 2026 15:02:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8366F20040;
 Sat,  9 May 2026 15:02:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 15:02:29 +0000 (GMT)
Date: Sat, 9 May 2026 20:32:25 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
Subject: Re: [PATCH v4 7/9] pnv/phb4: Set link speed and width in the DLP
 training control register
Message-ID: <af9MP4rWy-CBRI42@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-8-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-8-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1OSBTYWx0ZWRfX2rTOJNdvVBdB
 tbiWlfxJ9ZtexyLOTSCCVSpWt9r9PNbpMp8FgMBERd9bD4uBYGbAjg637MfXCCdd+kil/VkPV+x
 vaX2NKI+kccqz0Mg05KTXUcV9QTHDH69Ms8A0lZfZqDWpFC3mTjrzTaAPjRfKK0A0nnUcEt2cbr
 hw26+vGpbiCNIJ8h6v/4dz9CwP89M5ftBAn5bgOrRd+N2h5LlinPJoq9avmh/m3r2koLfF5E/oL
 qNPzSZQvbFwG9nZTAgXKit9xKS+7F1n5aqUwElx/JqDo8OvHbPq3BQ9FU0Nmh5+xPQiKuykjUcY
 OHWgo4jWqH2lid3pvoVNJ2ngsHpvhBr7GJpFRnqJW+BQoe4f+V46uQZsvhlCRxpsD/br+hxK6zO
 A9QK1W9kJXNLO+T8z1J18OxVcjctJsvV/MHdTMR7DJY25MvO2XJfQZHFGY1GykE7S9SB3C+OAhD
 6ONZgBbF6/tVF6n2rBw==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=69ff4c91 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=9FJ1V3p8FmpjOwqi5U0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: _Y3H5IOFgP0ybiU7Iwu4rmVuePEAxXVa
X-Proofpoint-GUID: C7jNu-VSufdWpnZ5y9bwfFcyZhj9ydas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> Get the current link-status from PCIE macro.
> Extract link-speed and link-width from the link-status
> and set in the DLP training control (PCIE_DLP_TCR) register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
> v3: Updates for coding guidelines.
> 
>  hw/pci-host/pnv_phb4.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index c35f632e64..a6fa578e85 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -900,6 +900,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>      uint32_t exp_base = get_exp_offset(pdev);
>      uint64_t val;
> +    uint32_t v, lnkstatus;
>  
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>          return pnv_phb4_config_read(phb, off & 0x3, size);
> @@ -961,10 +962,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>          val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>          break;
>  
> -    /* Link training always appears trained */
>      case PHB_PCIE_DLP_TRAIN_CTL:
> -        /* TODO: Do something sensible with speed ? */
> +        /* Get the current link-status from PCIE */
> +        lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
> +                                exp_base + PCI_EXP_LNKSTA, 4));

nit: s/bswap32/be32_to_cpu/ ?
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

v is little-endian, while val is supposed to be big-endian, is it correct ?
if so, should v be converted to big-endian before SETFIELDs ?

>          return val;
>  
>      /*

- Aditya G


