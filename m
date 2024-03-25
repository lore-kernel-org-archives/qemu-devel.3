Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354B0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokqJ-0005Yf-2l; Mon, 25 Mar 2024 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokqH-0005WB-9y; Mon, 25 Mar 2024 09:58:25 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokqE-000333-A3; Mon, 25 Mar 2024 09:58:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3DzX20Syz4wcg;
 Tue, 26 Mar 2024 00:58:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3DzQ0jkHz4wyR;
 Tue, 26 Mar 2024 00:58:09 +1100 (AEDT)
Message-ID: <496a56ca-4c20-4990-a0ed-dffd89038a98@kaod.org>
Date: Mon, 25 Mar 2024 14:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] pnv/phb4: Implement write-clear and return 1's on
 unimplemented reg read
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-6-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-6-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On 3/21/24 11:04, Saif Abrar wrote:
> Implement write-1-to-clear and write-X-to-clear logic.
> Update registers with silent simple read and write.
> Return all 1's when an unimplemented/reserved register is read.
> 
> Test that reading address 0x0 returns all 1's (i.e. -1).
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/pci-host/pnv_phb4.c              | 190 ++++++++++++++++++++++------
>   include/hw/pci-host/pnv_phb4_regs.h |  12 +-
>   tests/qtest/pnv-phb4-test.c         |   9 ++
>   3 files changed, 170 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index a81763f34c..4e3a6b37f9 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -683,8 +683,41 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           return;
>       }
>   
> -    /* Handle masking */
> +    /* Handle RO, W1C, WxC and masking */
>       switch (off) {
> +    /* W1C: Write-1-to-Clear registers */
> +    case PHB_TXE_ERR_STATUS:
> +    case PHB_RXE_ARB_ERR_STATUS:
> +    case PHB_RXE_MRG_ERR_STATUS:
> +    case PHB_RXE_TCE_ERR_STATUS:
> +    case PHB_ERR_STATUS:
> +    case PHB_REGB_ERR_STATUS:
> +    case PHB_PCIE_DLP_ERRLOG1:
> +    case PHB_PCIE_DLP_ERRLOG2:
> +    case PHB_PCIE_DLP_ERR_STATUS:
> +    case PHB_PBL_ERR_STATUS:
> +        phb->regs[off >> 3] &= ~val;
> +        return;
> +
> +    /* WxC: Clear register on any write */
> +    case PHB_PBL_ERR1_STATUS:
> +    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR_LOG_1:
> +    case PHB_REGB_ERR1_STATUS:
> +    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR_LOG_1:
> +    case PHB_TXE_ERR1_STATUS:
> +    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR_LOG_1:
> +    case PHB_RXE_ARB_ERR1_STATUS:
> +    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR_LOG_1:
> +    case PHB_RXE_MRG_ERR1_STATUS:
> +    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR_LOG_1:
> +    case PHB_RXE_TCE_ERR1_STATUS:
> +    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR_LOG_1:
> +    case PHB_ERR1_STATUS:
> +    case PHB_ERR_LOG_0 ... PHB_ERR_LOG_1:
> +        phb->regs[off >> 3] = 0;
> +        return;
> +
> +    /* Write value updated by masks */
>       case PHB_LSI_SOURCE_ID:
>           val &= PHB_LSI_SRC_ID;
>           break;
> @@ -723,7 +756,6 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>       case PHB_LEM_WOF:
>           val = 0;
>           break;
> -    /* TODO: More regs ..., maybe create a table with masks... */
>   
>       /* Read only registers */
>       case PHB_CPU_LOADSTORE_STATUS:
> @@ -732,6 +764,12 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>       case PHB_PHB4_TCE_CAP:
>       case PHB_PHB4_IRQ_CAP:
>       case PHB_PHB4_EEH_CAP:
> +    case PHB_VERSION:
> +    case PHB_DMA_CHAN_STATUS:
> +    case PHB_TCE_TAG_STATUS:
> +    case PHB_PBL_BUF_STATUS:
> +    case PHB_PCIE_BNR:
> +    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
>           return;
>       }
>   
> @@ -752,6 +790,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>               pnv_phb4_update_all_msi_regions(phb);
>           }
>           break;
> +
>       case PHB_M32_START_ADDR:
>       case PHB_M64_UPPER_BITS:
>           if (changed) {
> @@ -797,27 +836,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           break;
>   
>       /* Silent simple writes */
> -    case PHB_ASN_CMPM:
> -    case PHB_CONFIG_ADDRESS:
> -    case PHB_IODA_ADDR:
> -    case PHB_TCE_KILL:
> -    case PHB_TCE_SPEC_CTL:
> -    case PHB_PEST_BAR:
> -    case PHB_PELTV_BAR:
> +    /* PHB Fundamental register set A */
> +    case PHB_CONFIG_DATA ... PHB_LOCK1:
>       case PHB_RTT_BAR:
> -    case PHB_LEM_FIR_ACCUM:
> -    case PHB_LEM_ERROR_MASK:
> -    case PHB_LEM_ACTION0:
> -    case PHB_LEM_ACTION1:
> -    case PHB_TCE_TAG_ENABLE:
> +    case PHB_PELTV_BAR:
> +    case PHB_PEST_BAR:
> +    case PHB_CAPI_CMPM ... PHB_M64_AOMASK:
> +    case PHB_NXLATE_PREFIX ... PHB_DMA_SYNC:
> +    case PHB_TCE_KILL ... PHB_IODA_ADDR:
> +    case PHB_PAPR_ERR_INJ_CTL ... PHB_PAPR_ERR_INJ_MASK:
>       case PHB_INT_NOTIFY_ADDR:
>       case PHB_INT_NOTIFY_INDEX:
> -    case PHB_DMA_SYNC:
> -       break;
> +    /* Fundamental register set B */
> +    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
> +    /* FIR & Error registers */
> +    case PHB_LEM_FIR_ACCUM:
> +    case PHB_LEM_ERROR_MASK:
> +    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
> +    case PHB_ERR_INJECT ... PHB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_ERR_STATUS_MASK ... PHB_ERR1_STATUS_MASK:
> +    case PHB_TXE_ERR_INJECT ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_TXE_ERR_STATUS_MASK ... PHB_TXE_ERR1_STATUS_MASK:
> +    case PHB_RXE_ARB_ERR_INJECT ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_ARB_ERR_STATUS_MASK ... PHB_RXE_ARB_ERR1_STATUS_MASK:
> +    case PHB_RXE_MRG_ERR_INJECT ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_MRG_ERR_STATUS_MASK ... PHB_RXE_MRG_ERR1_STATUS_MASK:
> +    case PHB_RXE_TCE_ERR_INJECT ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_TCE_ERR_STATUS_MASK ... PHB_RXE_TCE_ERR1_STATUS_MASK:
> +    /* Performance monitor & Debug registers */
> +    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
> +    /* REGB Registers */
> +    /* PBL core */
> +    case PHB_PBL_CONTROL:
> +    case PHB_PBL_TIMEOUT_CTRL:
> +    case PHB_PBL_NPTAG_ENABLE:
> +    case PHB_PBL_SYS_LINK_INIT:
> +    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
> +    case PHB_PBL_ERR_STATUS_MASK ... PHB_PBL_ERR1_STATUS_MASK:
> +    /* PCI-E stack */
> +    case PHB_PCIE_SCR:
> +    case PHB_PCIE_DLP_STR ... PHB_PCIE_HOTPLUG_STATUS:
> +    case PHB_PCIE_LMR ... PHB_PCIE_DLP_LSR:
> +    case PHB_PCIE_DLP_RXMGN:
> +    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_TRCRDDATA:
> +    case PHB_PCIE_DLP_ERR_COUNTERS:
> +    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
> +    case PHB_PCIE_TRACE_CTRL:
> +    case PHB_PCIE_MISC_STRAP ... PHB_PCIE_PHY_EQ_CTL:
> +    /* Error registers */
> +    case PHB_REGB_ERR_INJECT:
> +    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
> +    case PHB_REGB_ERR_STATUS_MASK ... PHB_REGB_ERR1_STATUS_MASK:
> +        break;
>   
>       /* Noise on anything else */
>       default:
> -        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=%"PRIx64"\n",
> +        qemu_log_mask(LOG_UNIMP,
> +                      "phb4: unimplemented reg_write 0x%"PRIx64"=%"PRIx64"\n",
>                         off, val);
>       }
>   }
> @@ -905,36 +980,75 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           return val;
>   
>       /* Silent simple reads */
> +    /* PHB Fundamental register set A */
>       case PHB_LSI_SOURCE_ID:
> +    case PHB_DMA_CHAN_STATUS:
>       case PHB_CPU_LOADSTORE_STATUS:
> -    case PHB_ASN_CMPM:
> +    case PHB_CONFIG_DATA ... PHB_LOCK1:
>       case PHB_PHB4_CONFIG:
> +    case PHB_RTT_BAR:
> +    case PHB_PELTV_BAR:
>       case PHB_M32_START_ADDR:
> -    case PHB_CONFIG_ADDRESS:
> -    case PHB_IODA_ADDR:
> -    case PHB_RTC_INVALIDATE:
> -    case PHB_TCE_KILL:
> -    case PHB_TCE_SPEC_CTL:
>       case PHB_PEST_BAR:
> -    case PHB_PELTV_BAR:
> -    case PHB_RTT_BAR:
> +    case PHB_CAPI_CMPM:
> +    case PHB_M64_AOMASK:
>       case PHB_M64_UPPER_BITS:
> -    case PHB_CTRLR:
> -    case PHB_LEM_FIR_ACCUM:
> -    case PHB_LEM_ERROR_MASK:
> -    case PHB_LEM_ACTION0:
> -    case PHB_LEM_ACTION1:
> -    case PHB_TCE_TAG_ENABLE:
> +    case PHB_NXLATE_PREFIX:
> +    case PHB_RTC_INVALIDATE ... PHB_IODA_ADDR:
> +    case PHB_PAPR_ERR_INJ_CTL ... PHB_ETU_ERR_SUMMARY:
>       case PHB_INT_NOTIFY_ADDR:
>       case PHB_INT_NOTIFY_INDEX:
> -    case PHB_Q_DMA_R:
> -    case PHB_ETU_ERR_SUMMARY:
> -        break;
> -
> -    /* Noise on anything else */
> +    /* Fundamental register set B */
> +    case PHB_CTRLR:
> +    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
> +    case PHB_TCE_TAG_STATUS:
> +    /* FIR & Error registers */
> +    case PHB_LEM_FIR_ACCUM ... PHB_LEM_ERROR_MASK:
> +    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
> +    case PHB_ERR_STATUS ... PHB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_ERR_LOG_0 ... PHB_ERR1_STATUS_MASK:
> +    case PHB_TXE_ERR_STATUS ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR1_STATUS_MASK:
> +    case PHB_RXE_ARB_ERR_STATUS ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR1_STATUS_MASK:
> +    case PHB_RXE_MRG_ERR_STATUS ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR1_STATUS_MASK:
> +    case PHB_RXE_TCE_ERR_STATUS ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR1_STATUS_MASK:
> +    /* Performance monitor & Debug registers */
> +    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
> +    /* REGB Registers */
> +    /* PBL core */
> +    case PHB_PBL_CONTROL:
> +    case PHB_PBL_TIMEOUT_CTRL:
> +    case PHB_PBL_NPTAG_ENABLE:
> +    case PHB_PBL_SYS_LINK_INIT:
> +    case PHB_PBL_BUF_STATUS:
> +    case PHB_PBL_ERR_STATUS ... PHB_PBL_ERR_INJECT:
> +    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
> +    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR1_STATUS_MASK:
> +    /* PCI-E stack */
> +    case PHB_PCIE_BNR ... PHB_PCIE_DLP_STR:
> +    case PHB_PCIE_DLP_LANE_PWR:
> +    case PHB_PCIE_DLP_LSR:
> +    case PHB_PCIE_DLP_RXMGN:
> +    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_CTL:
> +    case PHB_PCIE_DLP_TRCRDDATA:
> +    case PHB_PCIE_DLP_ERRLOG1 ... PHB_PCIE_DLP_ERR_COUNTERS:
> +    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
> +    case PHB_PCIE_TRACE_CTRL:
> +    case PHB_PCIE_MISC_STRAP ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
> +    /* Error registers */
> +    case PHB_REGB_ERR_STATUS ... PHB_REGB_ERR_INJECT:
> +    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
> +    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR1_STATUS_MASK:
> +        break;
> +
> +    /* Noise on unimplemented read, return all 1's */
>       default:
> -        qemu_log_mask(LOG_UNIMP, "phb4: reg_read 0x%"PRIx64"=%"PRIx64"\n",
> -                      off, val);
> +        qemu_log_mask(LOG_UNIMP, "phb4: unimplemented reg_read 0x%"PRIx64"\n",
> +                      off);
> +        val = ~0ull;
>       }
>       return val;
>   }
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index 391d6a89ea..c1d5a83271 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -372,6 +372,7 @@
>   #define P32_CAP                                 0x228
>   #define P32_CTL                                 0x22C
>   #define P32_STAT                                0x230
> +
>   /* PHB4 REGB registers */
>   
>   /* PBL core */
> @@ -406,6 +407,7 @@
>   #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
>   #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
>   #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
> +#define PHB_PCIE_DLP_STR                0x1A18
>   #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
>   #define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
>   #define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
> @@ -416,6 +418,7 @@
>   #define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
>   #define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
>   
> +#define PHB_PCIE_DLP_LANE_PWR           0x1A38
>   #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
>   #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
>   #define   PHB_PCIE_DLP_LINK_SPEED       PPC_BITMASK(36, 39)
> @@ -435,18 +438,21 @@
>   #define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
>   #define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
>   #define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
> -
> +#define PHB_PCIE_DLP_LSR                0x1A48
> +#define PHB_PCIE_DLP_RXMGN              0x1A50
> +#define PHB_PCIE_DLP_LANEZEROCTL        0x1A70
>   #define PHB_PCIE_DLP_CTL                0x1A78
>   #define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
>   #define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
> -
>   #define PHB_PCIE_DLP_TRWCTL             0x1A80
>   #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
>   #define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
> +#define PHB_PCIE_DLP_TRCRDDATA          0x1A88
>   #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
>   #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
>   #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
>   #define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
> +#define PHB_PCIE_DLP_EIC                0x1AC8
>   
>   #define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
>   #define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
> @@ -458,6 +464,7 @@
>   #define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
>   #define PHB_PCIE_TRACE_CTRL             0x1B20
>   #define PHB_PCIE_MISC_STRAP             0x1B30
> +#define PHB_PCIE_PHY_EQ_CTL             0x1B38
>   #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 0x1B40
>   #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15 0x1B98
>   
> @@ -591,5 +598,4 @@
>   
>   #define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
>   
> -
>   #endif /* PCI_HOST_PNV_PHB4_REGS_H */
> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> index 0c8e58dd5f..96d1bd6724 100644
> --- a/tests/qtest/pnv-phb4-test.c
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -139,6 +139,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
>       g_assert_cmpuint(val, ==, 0x0);
>   }
>   
> +/* Check that reading an unimplemented address 0x0 returns -1 */
> +static void phb4_unimplemented_read_test(QTestState *qts)
> +{
> +    g_assert_cmpint(pnv_phb4_xscom_read(qts, 0x0), ==, -1);
> +}
> +
>   static void test_phb4(void)
>   {
>       QTestState *qts = NULL;
> @@ -157,6 +163,9 @@ static void test_phb4(void)
>       /* Check write-only logic */
>       phb4_writeonly_read_test(qts);
>   
> +    /* Check unimplemented register read */
> +    phb4_unimplemented_read_test(qts);
> +
>       qtest_quit(qts);
>   }
>   


