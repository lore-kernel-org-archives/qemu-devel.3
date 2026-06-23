Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90722CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc7yQ-00032W-UG; Tue, 23 Jun 2026 16:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7yO-00031o-KI; Tue, 23 Jun 2026 16:43:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc7yM-0005aV-M8; Tue, 23 Jun 2026 16:43:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NKIEFN3272488; Tue, 23 Jun 2026 20:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DGP6ns
 blVkMx4IYlc6V3hrxrhxgeYzvHI/GqNegdNJY=; b=JVV1tfeKrDf/HbLY7jbe5I
 EJsQr1fhJg9f6EVlk44i2JeLDfIRQxNQo3nYaILbM2w9nGVWs7Z3d7L6aKRH6mcD
 wZEVYYBoVnn74hD80XrhbIS9XntfQIQqg7MlkLq2+aszVAF2jT7jQ6HSPfxY6QA1
 50U1b0oDdJp9yQEXJha2eAeaEirnuGkTK+m6syglvGPQY9+vE2V0CWqNVv9jstqH
 lHFUsMB7ezIEqGqADUcfR2P0BkN8CSGM5Y3jT768bziC2oTxkclWssFNPjBm84H9
 1/ZYbeG2TY0jlFON+pvSmQVi7JDly9/3nsSARMvRnaz+IClbC3wgarVrehR/XeUA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqrt8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:43:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NKYe0R028340;
 Tue, 23 Jun 2026 20:43:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k5cg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 20:43:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NKhgjP51184108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 20:43:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 180C85805A;
 Tue, 23 Jun 2026 20:43:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41EEB58054;
 Tue, 23 Jun 2026 20:43:40 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 20:43:40 +0000 (GMT)
Message-ID: <3889e623-d5fb-4d13-b192-01bae5e95a06@linux.ibm.com>
Date: Tue, 23 Jun 2026 15:43:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-7-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-7-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3af000 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=utTTN3X8DS7UbbIJwekA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfX5uvTqlpQEHXl
 fgWo43oJ8T60f9gtTddBphoRZY5k5GhA/lW3YEfB1vOKegFYI7Lr/Hm7GNND5Csrsj+mY2DS7rD
 XGKtBIm0mbUWGGazk3v41ojnJ+Nh17yG3hWrPAHj1s0dVrfKLGmcPkZQNeYX9/lzNbLb0adyIzC
 XLVWlv2yni7IBFfFx58OHjXDEluhrsHeVBOsks8cALOdHsrfobzuf3su8DXYW7voECm9YcJLAnX
 TbRsPBNjfEa7m+TfdNzcjlOvsgfU4mzsCXbfN+kHbhYklUSsFvlzdER1Ng4EnKciYdezNcwACr9
 K3q6zl5M3JPuCBCFTTI2aGTDhj45AGpCfR3fY+3kpdINIDrJ1LaxDOaY6oRIJPcYPsvTgpP0kpD
 bMfgiqvIlnYi4NT2haYT+1E1PLaVDpXH/s2+XsD9d47mVrJSApvV14GZ5tc93luxRSPPfLUwLzI
 RAm4qp224pgqJADFoAQ==
X-Proofpoint-GUID: uTSpVadKxKli66HhxrEGZYaOOUXI1oBr
X-Proofpoint-ORIG-GUID: -MT1fSiScNTJ3choNbfZfgdVBjh5hCKR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE2NyBTYWx0ZWRfX3xeBshAGqbM9
 2AZkAaQHHj84bZ23buwL2rh6Z2ZpOZ0o65qMuac7HfywY07JpUZkS24bZKm2gVWYcU0vCTNyYzA
 303yA300GRXasEkhfM+qbEKNIxNL/2E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
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

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 6/17/26 4:50 AM, Saif Abrar wrote:
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
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5: Using be16_to_cpu as required.
> v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
> v3: Updates for coding guidelines.
> 
> 
>  hw/pci-host/pnv_phb4.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 838f9d3c23..125f610790 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -511,6 +511,21 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
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
>  /*
>   * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>   * RC-config space values and masks are LE.
> @@ -727,6 +742,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
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
> @@ -874,6 +894,10 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>  static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>  {
>      PnvPHB4 *phb = PNV_PHB4(opaque);
> +    /* Get the PCI-E capability offset from the root-port */
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_base = get_exp_offset(pdev);
>      uint64_t val;
>  
>      if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> @@ -942,8 +966,38 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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
> @@ -951,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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


