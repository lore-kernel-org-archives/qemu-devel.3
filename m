Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF8CA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBv2O-00007U-IH; Wed, 30 Sep 2026 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2K-0008PE-Fl; Wed, 30 Sep 2026 10:11:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2I-00027z-Jv; Wed, 30 Sep 2026 10:11:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5otI3167020; Wed, 30 Sep 2026 14:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uutb+K
 Hj/TRu9DfJFfs2wgyIJy8kXvPDqbOebPV9Hos=; b=n40GYtrcEktkCxxNw5D+L/
 70pyTKhqHSA51lfwPYtxPogf2tUNdtJCXPr8vZZ/6sNWRT9xO9RxFsE7kj4PeUie
 L///g2WSkUoxWCz/HxFMfliRSpktLO3K6ZYjAao5Hof8jeiJIij8f/HWBpidy3Bm
 Js7y9uL3x8F0jcQ7E9Uz9vzKV6EPt5Lrdr5/hI5jvVGIHPV+FNAEB39Dya9+bltL
 Nvc+Hd0DMuPkVPutkjnJMkpCgkfEq+0yEYSfdrXgyQ9uYQlpi8wlhQn7jJoaVojT
 nOh9c477Q8n8ugPhYd+YP3vRYHmmYJwNSb7cJlv1yCQ+FtLdpd87A6FkUFcQiWxQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptcf6s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:11:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UBWWQF3341800; Wed, 30 Sep 2026 14:11:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9bem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:11:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEBgFK11731506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:11:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04B5B5804E;
 Wed, 30 Sep 2026 14:11:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FA8D58056;
 Wed, 30 Sep 2026 14:11:40 +0000 (GMT)
Received: from [9.40.186.87] (unknown [9.40.186.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:11:40 +0000 (GMT)
Message-ID: <6ca36263-a1c6-4b06-8256-93ac0731937e@linux.ibm.com>
Date: Wed, 30 Sep 2026 09:11:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yAQd-8l1JiFoCBHtuk9JR0O-MlzZ27YN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX9VSwmhk+ZfZN
 JSqC9Jsns5vssQO03vOlz+u0cltBzHQy+AfsT95mVk+Ps9LiINiKKKFsC7gW2x/Nrw6dh/i9pAt
 NWzcDc+HqG3VWQ+qckuaUdQ1JY/MUT5WblehNAceOidMW4IMt6PlesWmViE1w1AbSSC8XER6OM2
 KIP++uEWuooLaThjvOyhU+rPQPKUmX0dww7wCt97DDPSEOl+rHKMQ+ItO3XZaStgwh73aU0AqjT
 VgO6GrYrfZYs2Y38zJ2t9s/ZKMUFLNO0o1svMCtvOrcLR8bQaPGr1DFPmpXl8hpcudw45/4IX4U
 oUC45ek2Rkq6IDxA1uS08I+gFqhBwLA3djvf4EDEux1aOrGsTRlhbAJBDfd66RFqVb0VlD8S3sT
 kauoq4XMX8j1KjRLEXdyVW6Kj/Y9WyM2rECW1l7i4rxtQwP80eQl9fPrEDqw5G0NyBazdjCSG0y
 6kS7NyZFWFgpDVK7H8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX20D4A3YVUs6l
 nRlCseA4kONWpcBEodXb1NA1w/g5dWjpCnAOswyPRC4QLheIId84lFkSjFO5ViXnbvQWxdHgWe5
 PQU+e+xAquQcHw8KUxbV1y8btgBiL08=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd18a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=4oHMkCvJoxaUTQewvasA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oetGSDNCs2ocX1i9po2QiL_dEV9B0XAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300056
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

On 8/31/26 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> Config-read the link-status register in the PCI-E macro,
> Depending on the link-active bit, set the link-active status
> in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
> Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
> after config-reading the slot-status in the PCI-E macro.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/pci-host/pnv_phb4.c | 74 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index b13165f84d..87446aedc8 100644
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
> +
>  void pnv_phb4_cfg_core_reset(PCIDevice *d)
>  {
>      uint8_t *conf = d->config;
> @@ -680,6 +708,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          val = 0;
>          break;
>  
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* For normal operations, Simspeed diagnostic bit is always zero */
> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
> +        break;
> +
>      /* Read only registers */
>      case PHB_CPU_LOADSTORE_STATUS:
>      case PHB_ETU_ERR_SUMMARY:
> @@ -827,6 +860,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>  uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>  {
>      PnvPHB4 *phb = PNV_PHB4(opaque);
> +    /* Get the PCI-E capability offset from the root-port */
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_base = get_exp_offset(pdev);
>      uint64_t val;
>  
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> @@ -895,8 +932,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>          val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
>          return val;
>  
> +    /*
> +     * Read PCI-E registers and set status for:
> +     * - Card present (active low bit 10)
> +     * - Link active  (bit 12)
> +     */
>      case PHB_PCIE_HOTPLUG_STATUS:
> -        /* Clear write-only bit */
> +        /*
> +         * Presence-status bit hpi_present_n is active-low, with reset value 1.
> +         * Start by setting this bit to 1, indicating the card is not present.
> +         * Then check the PCI-E register and clear the bit if card is present.
> +         */
> +        val |= PHB_PCIE_HPSTAT_PRESENCE;
> +
> +        /*
> +         * Config-read the PCI-E macro register for slot-status.
> +         * Method for config-read converts to BE value.
> +         * To check actual bit in the PCI-E register,
> +         * convert the value back to host format.
> +         * Clear the Presence-status active low bit.
> +         */
> +        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
> +                                                4))
> +                    & PCI_EXP_SLTSTA_PDS) {
> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
> +        }
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
> +        }
> +
> +        /* Clear write-only resample-bit */
>          val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
>          return val;
>  
> @@ -904,6 +971,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      case PHB_PCIE_LMR:
>          /* These write-only bits always read as 0 */
>          val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_LMR_LINKACTIVE;
> +        }
>          return val;
>  
>      /* Silent simple reads */


