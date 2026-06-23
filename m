Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2838CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6FR-0006hO-9s; Tue, 23 Jun 2026 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc6FK-0006gd-JM; Tue, 23 Jun 2026 14:53:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wc6FH-0002PN-LR; Tue, 23 Jun 2026 14:53:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmNed1914475; Tue, 23 Jun 2026 18:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MifwYo
 VfNiOyIbL/jCZDZPIlK2LXjYrG97VLyTT06mc=; b=cLAbw01Gq7cIQNz2kYVJRd
 H9o6ztDQgWNtS//oivvqzGGgvlD754eFNE3Ppx6rsz2/J+AD5y3uWghHQ+2UNB7f
 5mcZtAd12dVgSdxsasqlEE/kdQCwYExUeARnrk3cC+ob8saOTaa6pg5qbPdGEmGG
 05LJz9DT62dtdVwVoaCWix6N0XYnUmpFWQo9OKOe5y9NY/a+TX6eAiTN8a3ahCHP
 +YjQf5cAVyV4vsag25PCv5/uFCXsuM2rZX2LLBhwJjJAvHTGyG5R5JFCJSc34BcP
 viSWDlvmY7IkAxmmFhUs9URQGVGUOItk+juZr1k/ypoU2n+0XP0Y7w4+hFvrqkvw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4gb68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:53:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NIneld011122;
 Tue, 23 Jun 2026 18:53:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwd06a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 18:53:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NIr1Bh42336732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 18:53:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8B4F5805D;
 Tue, 23 Jun 2026 18:53:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFB3B58054;
 Tue, 23 Jun 2026 18:52:59 +0000 (GMT)
Received: from [9.61.241.143] (unknown [9.61.241.143])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 18:52:59 +0000 (GMT)
Message-ID: <b364f458-2d3a-4f7d-a486-1bb6adeeabee@linux.ibm.com>
Date: Tue, 23 Jun 2026 13:52:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] pnv/phb5: Implement read-only and write-only bits
 of registers
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-5-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260617095058.652789-5-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX8t3usyLaDGjn
 VSQ+7JrbnhnTbnj4tpRzWj8NiWUI5atgOwb+Kf4YeGLrfhDzYyFBv5asbOtBpQ+zbkHIBXPFLdJ
 ykWSU1VDprBeaZRt6Qz2WbhEZmqjENg=
X-Proofpoint-ORIG-GUID: oXvGSEXUOsxgCH5b_U5ir2jgB6HJS6Gz
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3ad610 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=ZSk1QQv9v-AV3lKYw8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX6Bz2SqKlDF4V
 EMz1k80ZDyAT9U+ZgTjijAzO77jhYxvYgPEsfKM6Tev9C6++a1lviRWZYsg/46xhbN4JC2G4Ggg
 S54Hcd0lld2y2EPftO7iAaMoMupJ6vCdd+xdLVT868bFd1LkfXit00dbLkdzzESj+tyOzUmbPMy
 3E+fPLqSGr7VbWILibrrAVEz0Net/qWhU74iPP70aBpqqFqjDTCMWU38imD9786jiBjlPD4lR2K
 lH0LwjeroGEmFUX6M4NLUw3rRXFRxlC2azFEw/G0pBoCFK1A5zOME1+RVjpctXP717YgAbPr8RC
 IVz5PZYobphZnVoZJWTAFaKzvfIMuZxHw9V2RCzTAn0RfUZajP03CwFZW8hv5Ffm/PUNyfH6wo4
 d94nuiGFPB5VZzSjAoU943eLpyEjPoB4R98m9r5N8SCGTZETbP8MTLFxtPytZozDKN8CnosClGu
 pKaIfOYd0KCnGYNraJA==
X-Proofpoint-GUID: 0l7JaDVzbTb8aHZrrl1zyABdB3LFvAGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155
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
> SW cannot write the read-only(RO) bits of a register
> and write-only(WO) bits of a register return 0 when read.
> 
> Added ro_mask[] for each register that defines which
> bits in that register are RO.
> When writing to a register, the RO-bits are not updated.
> 
> When reading a register, clear the WO bits and return the updated value.
> 
> Tested the registers PHB_DMA_SYNC, PHB_PCIE_HOTPLUG_STATUS, PHB_PCIE_LMR,
> PHB_PCIE_DLP_TRWCTL, PHB_LEM_ERROR_AND_MASK and PHB_LEM_ERROR_OR_MASK
> by writing all 1's and reading back the value.
> The WO bits in these registers should read back as 0.
> 
> Add .class_size in pnv_phb4_type_info.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: "Michael S. Tsirkin" <mst@redhat.com>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>
> ---
> v5: Moved PnvPHB4Class initialization from instance_init class_init method.
> v3:
> - Updates for coding guidelines.
> - Added class size for PnvPHB4Class.
> v2: New PnvPHB4Class to hold each register's RO mask.
> 
> 
>  hw/pci-host/pnv_phb4.c              | 79 ++++++++++++++++++++++++++---
>  include/hw/pci-host/pnv_phb4.h      | 13 ++++-
>  include/hw/pci-host/pnv_phb4_regs.h | 20 ++++++--
>  tests/qtest/pnv-phb-test.c          | 63 ++++++++++++++++++++++-
>  4 files changed, 161 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 4d4e239deb..ee378c0cba 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -705,6 +705,12 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          return;
>      }
>  
> +    /* Update 'val' according to the register's RO-mask */
> +    PnvPHB4Class *k = PNV_PHB4_GET_CLASS(phb);
> +
> +    val = (phb->regs[off >> 3] & k->ro_mask[off >> 3]) |
> +            (val & ~(k->ro_mask[off >> 3]));
> +
>      /* Record whether it changed */
>      changed = phb->regs[off >> 3] != val;
>  
> @@ -780,7 +786,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>      case PHB_TCE_TAG_ENABLE:
>      case PHB_INT_NOTIFY_ADDR:
>      case PHB_INT_NOTIFY_INDEX:
> -    case PHB_DMARD_SYNC:
> +    case PHB_DMA_SYNC:
>         break;
>  
>      /* Noise on anything else */
> @@ -818,7 +824,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      case PHB_VERSION:
>          return PNV_PHB4_PEC_GET_CLASS(phb->pec)->version;
>  
> -        /* Read-only */
> +    /* Read-only */
>      case PHB_PHB4_GEN_CAP:
>          return 0xe4b8000000000000ull;
>      case PHB_PHB4_TCE_CAP:
> @@ -828,18 +834,49 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      case PHB_PHB4_EEH_CAP:
>          return phb->big_phb ? 0x2000000000000000ull : 0x1000000000000000ull;
>  
> +    /* Write-only, read will return zeros */
> +    case PHB_LEM_ERROR_AND_MASK:
> +    case PHB_LEM_ERROR_OR_MASK:
> +        return 0;
> +    case PHB_PCIE_DLP_TRWCTL:
> +        val &= ~PHB_PCIE_DLP_TRWCTL_WREN;
> +        return val;
>      /* IODA table accesses */
>      case PHB_IODA_DATA0:
>          return pnv_phb4_ioda_read(phb);
>  
> +    /*
> +     * DMA sync: make it look like it's complete,
> +     *           clear write-only read/write start sync bits.
> +     */
> +    case PHB_DMA_SYNC:
> +        val = PHB_DMA_SYNC_RD_COMPLETE |
> +            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
> +        return val;
> +
> +    /*
> +     * PCI-E Stack registers
> +     */
> +    case PHB_PCIE_SCR:
> +        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
> +        break;
> +
>      /* Link training always appears trained */
>      case PHB_PCIE_DLP_TRAIN_CTL:
>          /* TODO: Do something sensible with speed ? */
> -        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +        val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> +        return val;
> +
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* Clear write-only bit */
> +        val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
> +        return val;
>  
> -    /* DMA read sync: make it look like it's complete */
> -    case PHB_DMARD_SYNC:
> -        return PHB_DMARD_SYNC_COMPLETE;
> +    /* Link Management Register */
> +    case PHB_PCIE_LMR:
> +        /* These write-only bits always read as 0 */
> +        val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +        return val;
>  
>      /* Silent simple reads */
>      case PHB_LSI_SOURCE_ID:
> @@ -1684,6 +1721,30 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
>      .get_address_space = pnv_phb4_dma_iommu,
>  };
>  
> +static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
> +{
> +    /*
> +     * Set register specific RO-masks
> +     */
> +
> +    /* PBL - Error Injection Register (0x1910) */
> +    phb4c->ro_mask[PHB_PBL_ERR_INJECT >> 3] =
> +        PPC_BITMASK(0, 23) | PPC_BITMASK(28, 35) | PPC_BIT(38) | PPC_BIT(46) |
> +        PPC_BITMASK(49, 51) | PPC_BITMASK(55, 63);
> +
> +    /* Reserved bits[60:63] */
> +    phb4c->ro_mask[PHB_TXE_ERR_LEM_ENABLE >> 3] =
> +    phb4c->ro_mask[PHB_TXE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(60, 63);
> +    /* Reserved bits[36:63] */
> +    phb4c->ro_mask[PHB_RXE_TCE_ERR_LEM_ENABLE >> 3] =
> +    phb4c->ro_mask[PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(36, 63);
> +    /* Reserved bits[40:63] */
> +    phb4c->ro_mask[PHB_ERR_LEM_ENABLE >> 3] =
> +    phb4c->ro_mask[PHB_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(40, 63);
> +
> +    /* TODO: Add more RO-masks as regs are implemented in the model */
> +}
> +
>  static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>  {
>      STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> @@ -1743,6 +1804,7 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>      pnv_phb4_err_reg_reset(phb);
>      pnv_phb4_pcie_stack_reg_reset(phb);
>      pnv_phb4_regb_err_reg_reset(phb);
> +    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
>  }
>  
>  static void pnv_phb4_instance_init(Object *obj)
> @@ -1917,6 +1979,7 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      XiveNotifierClass *xfc = XIVE_NOTIFIER_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    PnvPHB4Class *phb4c = PNV_PHB4_CLASS(klass);
>  
>      dc->realize         = pnv_phb4_realize;
>      device_class_set_props(dc, pnv_phb4_properties);
> @@ -1925,6 +1988,9 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
>      xfc->notify         = pnv_phb4_xive_notify;
>  
>      rc->phases.enter = pnv_phb4_reset;
> +
> +    /* Initialize RO-mask of registers */
> +    pnv_phb4_ro_mask_init(phb4c);
>  }
>  
>  static const TypeInfo pnv_phb4_type_info = {
> @@ -1932,6 +1998,7 @@ static const TypeInfo pnv_phb4_type_info = {
>      .parent        = TYPE_DEVICE,
>      .instance_init = pnv_phb4_instance_init,
>      .instance_size = sizeof(PnvPHB4),
> +    .class_size    = sizeof(PnvPHB4Class),
>      .class_init    = pnv_phb4_class_init,
>      .interfaces = (const InterfaceInfo[]) {
>              { TYPE_XIVE_NOTIFIER },
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 47a5c3edf5..bea0684724 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -19,7 +19,7 @@
>  
>  
>  #define TYPE_PNV_PHB4 "pnv-phb4"
> -OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
> +OBJECT_DECLARE_TYPE(PnvPHB4, PnvPHB4Class, PNV_PHB4)
>  
>  typedef struct PnvPhb4PecStack PnvPhb4PecStack;
>  
> @@ -156,6 +156,17 @@ struct PnvPHB4 {
>      QLIST_HEAD(, PnvPhb4DMASpace) dma_spaces;
>  };
>  
> +typedef struct PnvPHB4Class {
> +    DeviceClass parent_class;
> +
> +    /*
> +     * Read-only bitmask for registers
> +     * Bit value: 1 => RO bit
> +     *            0 => RW bit
> +     */
> +    uint64_t ro_mask[PNV_PHB4_NUM_REGS];
> +} PnvPHB4Class;
> +
>  void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
>  int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
>  PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index df5e86d29a..dfd0e01d1e 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -180,9 +180,11 @@
>  #define PHB_M64_AOMASK                  0x1d0
>  #define PHB_M64_UPPER_BITS              0x1f0
>  #define PHB_NXLATE_PREFIX               0x1f8
> -#define PHB_DMARD_SYNC                  0x200
> -#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
> -#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
> +#define PHB_DMA_SYNC                    0x200
> +#define   PHB_DMA_SYNC_RD_START         PPC_BIT(0)
> +#define   PHB_DMA_SYNC_RD_COMPLETE      PPC_BIT(1)
> +#define   PHB_DMA_SYNC_WR_START         PPC_BIT(2)
> +#define   PHB_DMA_SYNC_WR_COMPLETE      PPC_BIT(3)
>  #define PHB_RTC_INVALIDATE              0x208
>  #define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
>  #define   PHB_RTC_INVALIDATE_RID        PPC_BITMASK(16, 31)
> @@ -370,6 +372,7 @@
>  #define P32_CAP                                 0x228
>  #define P32_CTL                                 0x22C
>  #define P32_STAT                                0x230
> +
>  /* PHB4 REGB registers */
>  
>  /* PBL core */
> @@ -395,8 +398,8 @@
>  #define PHB_PCIE_SCR                    0x1A00
>  #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
>  #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
> +#define   PHB_PCIE_SCR_PLW_X16          PPC_BIT(41) /* x16 */
>  #define PHB_PCIE_BNR                    0x1A08
> -
>  #define PHB_PCIE_CRESET                 0x1A10
>  #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
>  #define   PHB_PCIE_CRESET_TLDLP         PPC_BIT(1)
> @@ -405,7 +408,14 @@
>  #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
>  #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
>  #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
> +#define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
> +#define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
>  #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
> +#define   PHB_PCIE_HPSTAT_LINKACTIVE    PPC_BIT(12)
> +#define PHB_PCIE_LMR                    0x1A30
> +#define   PHB_PCIE_LMR_CHANGELW         PPC_BIT(0)
> +#define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
> +#define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
>  
>  #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
>  #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
> @@ -433,7 +443,7 @@
>  
>  #define PHB_PCIE_DLP_TRWCTL             0x1A80
>  #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
> -
> +#define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
>  #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
>  #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
>  #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
> diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
> index fe1ac27264..76212acacc 100644
> --- a/tests/qtest/pnv-phb-test.c
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -76,7 +76,8 @@ static void phb5_sticky_rst_test(QTestState *qts)
>       * Sticky reset test of PHB_PBL_ERR_STATUS.
>       *
>       * Write all 1's to reg PHB_PBL_ERR_INJECT.
> -     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
> +     * RO-only bits will not be written and
> +     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
>       *
>       * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
>       * Verify the sticky bits are still set.
> @@ -84,7 +85,62 @@ static void phb5_sticky_rst_test(QTestState *qts)
>      PHB5_XSCOM_WRITE(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
>      PHB5_XSCOM_WRITE(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
>      val = PHB5_XSCOM_READ(PHB_PBL_ERR_STATUS);
> -    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
> +    g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
> +                     PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
> +                     PPC_BITMASK(52, 54)));
> +
> +}
> +
> +/* Check that write-only bits/regs return 0 when read */
> +static void phb4_writeonly_read_test(QTestState *qts)
> +{
> +    uint64_t val;
> +
> +    /*
> +     * Set all bits of PHB_DMA_SYNC,
> +     * bits 0 and 2 are write-only and should be read as 0.
> +     */
> +    PHB5_XSCOM_WRITE(PHB_DMA_SYNC, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_DMA_SYNC);
> +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> +    g_assert_cmpuint(val & PPC_BIT(2), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_HOTPLUG_STATUS,
> +     * bit 9 is write-only and should be read as 0.
> +     */
> +    PHB5_XSCOM_WRITE(PHB_PCIE_HOTPLUG_STATUS, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_PCIE_HOTPLUG_STATUS);
> +    g_assert_cmpuint(val & PPC_BIT(9), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_LMR,
> +     * bits 0 and 1 are write-only and should be read as 0.
> +     */
> +    PHB5_XSCOM_WRITE(PHB_PCIE_LMR, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_PCIE_LMR);
> +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_PCIE_DLP_TRWCTL,
> +     * write-only bit-1 should be read as 0.
> +     */
> +    PHB5_XSCOM_WRITE(PHB_PCIE_DLP_TRWCTL, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_PCIE_DLP_TRWCTL);
> +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> +
> +    /*
> +     * Set all bits of PHB_LEM_ERROR_AND_MASK, PHB_LEM_ERROR_OR_MASK,
> +     * both regs are write-only and should be read as 0.
> +     */
> +    PHB5_XSCOM_WRITE(PHB_LEM_ERROR_AND_MASK, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_LEM_ERROR_AND_MASK);
> +    g_assert_cmpuint(val, ==, 0x0);
> +
> +    PHB5_XSCOM_WRITE(PHB_LEM_ERROR_OR_MASK, PPC_BITMASK(0, 63));
> +    val = PHB5_XSCOM_READ(PHB_LEM_ERROR_OR_MASK);
> +    g_assert_cmpuint(val, ==, 0x0);
>  }
>  
>  static void phb5_tests(void)
> @@ -99,6 +155,9 @@ static void phb5_tests(void)
>      /* Check sticky reset of a register */
>      phb5_sticky_rst_test(qts);
>  
> +    /* Check write-only logic */
> +    phb4_writeonly_read_test(qts);
> +
>      qtest_quit(qts);
>  }
>  


