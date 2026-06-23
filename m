Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA9ACDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5oL-0003pl-Fv; Tue, 23 Jun 2026 14:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc5oD-0003p1-H8; Tue, 23 Jun 2026 14:25:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc5o9-0000fl-M6; Tue, 23 Jun 2026 14:25:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmN911805225; Tue, 23 Jun 2026 18:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mM71QI
 NN7a2ikrurt2Pmms/MZ/ViigBAAUJcSOzdhqg=; b=LXyOGPdxI6y/cQsv0T7CrF
 4fJL4zwMvCGvfQPqg8eWMmVsnAxzh+Zr1ACaUCnHv11UCfpm6SX97maOZhW372Xd
 2jga8RG3idSfnGkWbpDTINftP4iq+q8yYgxCJf6p70UBVceuK+sJAkPA3hcOIHPi
 69V49OAS7ViTBqt9zskdWUTvCj7wq6L/uaz8HcshIUBKDF2tNSLk0VG3DvgSQ9MW
 tsCNyxsaePHjfipZ2ELWzD128dhMFTiarL8LxbsAV3i+ImFl7xe4tlBUGLOkdGye
 667KRrcw5GSo6vUmAG+glxGOnzetdjWfDFzc0RtyCSVAiynnteRrZ/IH82h+E1XQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gg4yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:25:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NIJitq031900;
 Tue, 23 Jun 2026 18:25:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k4qw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:25:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NIOTBW19792534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 18:24:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8525805D;
 Tue, 23 Jun 2026 18:25:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EE2F5805A;
 Tue, 23 Jun 2026 18:24:59 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 18:24:59 +0000 (GMT)
Message-ID: <0998b096-1b8a-4df8-994c-a86c88a7fb43@linux.ibm.com>
Date: Tue, 23 Jun 2026 13:24:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] pnv/phb5: Add reset logic to PHB5
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-3-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-3-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3acf7f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=JZLce0C29cPERfJOrJ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1MSBTYWx0ZWRfX0EKtEE5v/TYc
 7OIjcQFS9Pw1+GrNcx4pXhdiN5LNkBp/fgtVBopQELVNeKFGWlBIuvV345o/Jq+bZYHOCwVPGKH
 X+LjqYmt3SJEkI/DoGw4mLx/YYpqfUC0oR4ghI8ULahUXHVnkAVXmOFfWBCufC7Redpafd+/EUt
 VaQrMADXE0Fg6MkI/KgdzIlHA2JxnhNi3tcB2jw4WKgwff5ekOEoc5nxD9/u0E/XzhehSfYcRTb
 QLLMtgTbCQAiVVWikx/D3vbr3dW5w9G3rsLzpABSHvCtetSyZvWPpPmTAb5soGctcVPv1ER46XS
 czR0BKHUqpPM+jWybhmNubz3Y+atHatuqttvIcwndieq4QDHu5BM4m3qNrI/FSL10FmqLDCmalL
 MGNVn4qwerGyBSlVMoLq73+Denov6Q==
X-Proofpoint-GUID: pr_Jlo0BdlKL8R310vs6h-LFtOgIPwfp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1MSBTYWx0ZWRfX88C/QjtA4TEV
 eHrHuV04jnTAzPa81wHd9XkI6LSdsqy7egfp848l2MWWzNs/QS8OW53lzM4Knfh/iPQ+mQRZaH0
 XtMk+B74BT1vq2S/pJYHkqo+UW7ffXY=
X-Proofpoint-ORIG-GUID: MQ1LNNt-detuBrEAldHeESgEuiOY23cN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230151
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
> Add a method to be invoked on QEMU reset.
> Also add CFG and PBL core-blocks reset logic using
> appropriate bits of PHB_PCIE_CRESET register.
> 
> Tested by reading the reset value of a register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5:
> - New macro for SCOM to PCBA address conversion.
> - Rename phb4 to phb5 in methods and macros.
> v4: General updates.
> v3: Updates for coding guidelines.
> v2:
> - Using the ResettableClass.
> - Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
> 
> 
>  hw/pci-host/pnv_phb.c               |   1 +
>  hw/pci-host/pnv_phb4.c              | 100 +++++++++++++++++++++++++++-
>  include/hw/pci-host/pnv_phb4.h      |   1 +
>  include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>  tests/qtest/pnv-phb-test.c          |  31 ++++++++-
>  5 files changed, 145 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 0b556d1bf5..d4f452d7b2 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>      pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>      pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>      pci_config_set_interrupt_pin(conf, 0);
> +    pnv_phb4_cfg_core_reset(d);
>  }
>  
>  static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 396bc47817..c9f3b02b39 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1,7 +1,8 @@
>  /*
>   * QEMU PowerPC PowerNV (POWER9) PHB4 model
> + * QEMU PowerPC PowerNV (POWER10) PHB5 model
>   *
> - * Copyright (c) 2018-2020, IBM Corporation.
> + * Copyright (c) 2018-2026, IBM Corporation.
>   *
>   * This code is licensed under the GPL version 2 or later. See the
>   * COPYING file in the top-level directory.
> @@ -22,6 +23,7 @@
>  #include "hw/core/qdev-properties.h"
>  #include "qom/object.h"
>  #include "trace.h"
> +#include "system/reset.h"
>  
>  #define phb_error(phb, fmt, ...)                                        \
>      qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            \
> @@ -499,6 +501,78 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>      }
>  }
>  
> +/*
> + * Get the PCI-E capability offset from the root-port
> + */
> +static uint32_t get_exp_offset(PCIDevice *pdev)
> +{
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
> +
> +    return rpc->exp_offset;
> +}
> +
> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
> +{
> +    uint8_t *conf = d->config;
> +    uint32_t exp_offset = get_exp_offset(d);
> +
> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> +    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
> +    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
> +
> +    pci_set_long(conf + exp_offset, 0x420010);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
> +                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
> +                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
> +    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
> +    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
> +                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
> +                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
> +                       | PCI_EXP_LNKCAP2_SLS_32_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
> +                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
> +    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
> +    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
> +                                                       | PCI_EXT_CAP_ID_SECPCI);
> +    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
> +    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
> +    for (int i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
> +        pci_set_long(conf + i, 0x9C38);
> +    }
> +
> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
> +    pci_set_long(conf + P16_ECAP, 0x22410026);
> +    pci_set_long(conf + P32_ECAP, 0x1002A);
> +    pci_set_long(conf + P32_CAP,  0x103);
> +}
> +
> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
> +{
> +    /* Zero all registers initially */
> +    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
> +        phb->regs[i >> 3] = 0x0;
> +    }
> +
> +    /* Set specific register values */
> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
> +}
> +
>  static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>                                 unsigned size)
>  {
> @@ -612,6 +686,18 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          pnv_phb4_update_xsrc(phb);
>          break;
>  
> +    /* Reset core blocks */
> +    case PHB_PCIE_CRESET:
> +        if (val & PHB_PCIE_CRESET_CFG_CORE) {
> +            PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +
> +            pnv_phb4_cfg_core_reset(pci_find_device(pci->bus, 0, 0));
> +        }
> +        if (val & PHB_PCIE_CRESET_PBL) {
> +            pnv_phb4_pbl_core_reset(phb);
> +        }
> +        break;
> +
>      /* Silent simple writes */
>      case PHB_ASN_CMPM:
>      case PHB_CONFIG_ADDRESS:
> @@ -1532,6 +1618,13 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
>      .get_address_space = pnv_phb4_dma_iommu,
>  };
>  
> +static void pnv_phb4_reset(Object *obj, ResetType type)
> +{
> +    PnvPHB4 *phb = PNV_PHB4(obj);
> +
> +    pnv_phb4_pbl_core_reset(phb);
> +}
> +
>  static void pnv_phb4_instance_init(Object *obj)
>  {
>      PnvPHB4 *phb = PNV_PHB4(obj);
> @@ -1608,6 +1701,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>      phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>  
>      pnv_phb4_xscom_realize(phb);
> +
> +    qemu_register_resettable(OBJECT(dev));
>  }
>  
>  /*
> @@ -1701,12 +1796,15 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      XiveNotifierClass *xfc = XIVE_NOTIFIER_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->realize         = pnv_phb4_realize;
>      device_class_set_props(dc, pnv_phb4_properties);
>      dc->user_creatable  = false;
>  
>      xfc->notify         = pnv_phb4_xive_notify;
> +
> +    rc->phases.enter = pnv_phb4_reset;
>  }
>  
>  static const TypeInfo pnv_phb4_type_info = {
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index de996e718b..47a5c3edf5 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -160,6 +160,7 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
>  int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
>  PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
>  void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
> +void pnv_phb4_cfg_core_reset(PCIDevice *d);
>  extern const MemoryRegionOps pnv_phb4_xscom_ops;
>  
>  /*
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index bea96f4d91..6892e21cc9 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -343,6 +343,18 @@
>  #define PHB_RC_CONFIG_BASE                      0x1000
>  #define   PHB_RC_CONFIG_SIZE                    0x800
>  
> +#define PHB_AER_ECAP                            0x100
> +#define PHB_AER_CAPCTRL                         0x118
> +#define PHB_SEC_ECAP                            0x148
> +#define PHB_LMR_ECAP                            0x1A0
> +#define PHB_LMR_CTLSTA_2                        0x1AC
> +#define PHB_LMR_CTLSTA_16                       0x1E4
> +#define PHB_DLF_ECAP                            0x1E8
> +#define PHB_DLF_CAP                             0x1EC
> +#define P16_ECAP                                0x1F4
> +#define P32_ECAP                                0x224
> +#define P32_CAP                                 0x228
> +
>  /* PHB4 REGB registers */
>  
>  /* PBL core */
> @@ -368,7 +380,7 @@
>  #define PHB_PCIE_SCR                    0x1A00
>  #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
>  #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
> -
> +#define PHB_PCIE_BNR                    0x1A08
>  
>  #define PHB_PCIE_CRESET                 0x1A10
>  #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
> @@ -423,6 +435,8 @@
>  #define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
>  #define PHB_PCIE_TRACE_CTRL             0x1B20
>  #define PHB_PCIE_MISC_STRAP             0x1B30
> +#define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 0x1B40
> +#define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15 0x1B98
>  
>  /* Error */
>  #define PHB_REGB_ERR_STATUS             0x1C00
> diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
> index 2eda521249..54fe1838a7 100644
> --- a/tests/qtest/pnv-phb-test.c
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -17,7 +17,8 @@
>  #define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>  
>  /* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> -#define PHB4_XSCOM              0x40084800ull
> +#define PHB5_XSCOM              0x40084800ull
> +#define PNV_P10_CHIP_INDEX      3
>  
>  /* SCOM to PCBA address conversion */
>  #define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
> @@ -37,6 +38,29 @@ static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
>                                                                indirect_data)));
>  }
>  
> +#define PHB5_XSCOM_READ(a) pnv_phb_xscom_read(qts, \
> +                                   &pnv_chips[PNV_P10_CHIP_INDEX], PHB5_XSCOM, \
> +                                   PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
> +                                   PPC_BIT(0) | (a))
> +
> +/* Assert that 'PHB PBL Control' register has correct reset value */
> +static void phb5_reset_test(QTestState *qts)
> +{
> +    g_assert_cmpuint(PHB5_XSCOM_READ(PHB_PBL_CONTROL), ==, 0xC009000000000000);
> +}
> +
> +static void phb5_tests(void)
> +{
> +    QTestState *qts = NULL;
> +
> +    qts = qtest_initf("-machine powernv10 -accel tcg");
> +
> +    /* Check reset value of a register */
> +    phb5_reset_test(qts);
> +
> +    qtest_quit(qts);
> +}
> +
>  /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>  static void phb_version_test(const void *data)
>  {
> @@ -59,7 +83,7 @@ static void phb_version_test(const void *data)
>          expected_ver = 0xA4;
>      } else if (chip->chip_type == PNV_CHIP_POWER10) {
>          machine = "powernv10";
> -        phb_xscom = PHB4_XSCOM;
> +        phb_xscom = PHB5_XSCOM;
>          indirect_addr = PHB_SCOM_HV_IND_ADDR;
>          indirect_data = PHB_SCOM_HV_IND_DATA;
>          reg_phb_version |= PPC_BIT(0);
> @@ -96,5 +120,8 @@ int main(int argc, char **argv)
>      /* PHB[345] tests */
>      add_phbX_version_test();
>  
> +    /* PHB5 specific tests */
> +    qtest_add_func("phb5", phb5_tests);
> +
>      return g_test_run();
>  }


