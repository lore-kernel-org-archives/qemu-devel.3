Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8371C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxCd5-0002NC-O4; Thu, 20 Aug 2026 19:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wxCd3-0002JR-UR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:57:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wxCcz-0005t1-Dx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:57:01 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc166b631f6so38899a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787270215; x=1787875015; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XETJf+7m0Q4nWU4cPfZ7HyLyQoOE9WvyFTJzcHIt8cE=;
 b=J0oXJ7B1FXlbzgJxYYvQohq2OG1t/R6ystDeUdmZBLGpD5BXbcrQgTJzP7Zhtu0AHh
 ZRKJoNvh2kikDcDXVJDVTS3GCP3eLkd7HlwO5SHH1zpUtLrldANVODJsRdcdiQ4fBL/B
 QnpDIP5RM+oF9B4VkO1WXOZCDoAtJsydL8bgsAg+FtCi8/qOut+2mIs903Th9HPhMfQ8
 bMqZ5ql8EMTMmUHc37RW88Wia8379f0EH/JkMgYKQmT7ufvlFBcFwK8lkbwnv5eOB+mc
 EsWBM1DaJVGC+p0m5sc8vI/5SR6vb74pPXbJNR0SwTsZhm/SaCpQiLxLNgOH2v06XWoT
 hxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787270215; x=1787875015;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XETJf+7m0Q4nWU4cPfZ7HyLyQoOE9WvyFTJzcHIt8cE=;
 b=IWzB63bvzJZWr/bvff2+Vm6hBscyMIKjoqZSae5uZntRbcTor2cLcjvMDCBa9WJUqe
 WwypC6TN6pSGzkY2NDeJCWA57WaHYFr07336H/VeosB/SXyVu2+G+keVm8/t6u+ncoNj
 VqoPWnQLS/VewMaJ6SLZk5IDJK4S3u0ATktBBK4eQo5QEfLKx7mFHTU29wf9PcYGNEKR
 OGBX3QmixBpCvh/NcMC8bJ+19GQ5HueQprs0DmK8/8S+6mi5SBbcQnCq3Ja/bzfcuaq6
 i0Sz2WVarxLFScdWA+RerRWltPUqMU10Tt3btEZfJgb9spkVasHa4/mqPRq+JbBOrIna
 5Fwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFKOeNOiX1kTx5bD3ZgIuJzPzS9uo+SXS6s1BD34ezV6okVgiABZ31txQdHU/Ju0bPWBVGU8GT0wtt@nongnu.org
X-Gm-Message-State: AFuF++mxMSjNXJkpiY1UcwrevqKfgVfmWnngMC0fz0itO0PdR/ABPRT9
 HBsvP0+WPAGhFoYjMcXJ9VA6WdPRazxCkkQbPtSIWmvbQWSR4YayKM/tu/XCYC8ArAY=
X-Gm-Gg: AR+sD12fnKZS4HrNUmDWdF9zCGYRI1o+lmPaloLBpRbq9SOque+etXWt918RTRYgHyr
 nUxATWN7287ycuRlXUqmQustJDc/BBF6BAEJahZKL/XyCSEtcGZCriPUjiIi8PUXll3zIIIRZl9
 hcTYTp9RaqjH7psBy3CB+ooSW+6jxzNeXBkAoixLQac0FAxqaMNfgyau6Aveup0EAHcT6S0UDRb
 yK+cb9izazCWODtk9aig0/mQXA2+0UAaxiIAFwaln9mi1ByWo8R2SiOSqPwAxJSP5Rm/xXei+30
 3UeZm2kOWIxoiGufLMVorAjyHOANeZyB4XTXsxzo2QM83JhKhBiEle8IpHXWVTh3ygJkXFQLUz/
 ECtL7m7A/uBWTMlRX8w92bX+LaLG9BzxsFVfxHaFjkPd3AgdSZUqiGUqLILu4CP6j313of0hYsv
 khfW5h0WOpq+KHJFFaAtPk5VAjy6b3WVg/zoENYthy7zoi5YgK7cQjvizzdiUT9f+T73Int1TXh
 u7EUHyGJmvzxDAg
X-Received: by 2002:a05:6a00:4888:b0:847:9b61:375d with SMTP id
 d2e1a72fcca58-851f9fca1e5mr867303b3a.3.1787270215366; 
 Thu, 20 Aug 2026 16:56:55 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3615eb0sm2173040b3a.28.2026.08.20.16.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:56:54 -0700 (PDT)
Message-ID: <582b873b-a62e-4080-9f8b-9a88718e7aa1@oss.tenstorrent.com>
Date: Fri, 21 Aug 2026 09:56:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/ssi: Add Synopsys DWC SSI standard PIO
 controller
To: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <20260808182956.290561-2-flamboyant.h.01@gmail.com>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <20260808182956.290561-2-flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=portias@tenstorrent.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/2026 4:29 AM, Kangjie Huang wrote:
> Add a reusable SysBus model for the Synopsys DWC SSI controller. The model
> uses the DWC CTRLR0 layout, where TMOD is at bits [11:10]; DW APB SSI
> variants with TMOD at bits [9:8] are not supported.
> 
> Implement the Standard SPI register subset, configurable chip-select and
> FIFO resources, the four Standard PIO transfer modes, reset handling,
> chip-select GPIOs, and RAZ/WI handling for unsupported enhanced, DMA, and
> XIP registers.
> 
> Add num-cs, fifo-depth, and imr-reset properties. Save only Standard PIO
> state in VMState and reject migration between devices with different
> resource profiles.
> 
> The Synopsys databook requires myDesignWare registration and has no stable
> public URL. The K230 TRM is the public register reference for this model:
> 
> https://github.com/revyos/external-docs/blob/79b3a79072412ead81427e6755b4d9e6d9ded8d8/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> The Linux driver and binding provide software and capability references:
> 
> https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw-core.c
> 
> https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/drivers/spi/spi-dw.h
> 
> https://github.com/torvalds/linux/blob/f9a2394a23482bfd330911e9c8295b71724feacd/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> 
> The Intel Arria 10 HPS TRM describes the DW APB SSI family variant and is
> used only for comparison with the DWC layout:
> 
> https://www.intel.com/content/www/us/en/docs/programmable/683711/21-2/hard-processor-system-technical-reference.html
> 
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Suggested-by: Chao Liu <chao.liu@processmission.com>
> Suggested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> 
> The controller is not instantiated by this patch.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>   hw/ssi/Kconfig           |   4 +
>   hw/ssi/dwc_ssi.c         | 976 +++++++++++++++++++++++++++++++++++++++
>   hw/ssi/meson.build       |   1 +
>   include/hw/ssi/dwc_ssi.h |  63 +++
>   4 files changed, 1044 insertions(+)
>   create mode 100644 hw/ssi/dwc_ssi.c
>   create mode 100644 include/hw/ssi/dwc_ssi.h
> 
> diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
> index 1bd56463c1..f48fdcf880 100644
> --- a/hw/ssi/Kconfig
> +++ b/hw/ssi/Kconfig
> @@ -6,6 +6,10 @@ config SIFIVE_SPI
>       bool
>       select SSI
>   
> +config DWC_SSI
> +    bool
> +    select SSI
> +
>   config SSI
>       bool
>   
> diff --git a/hw/ssi/dwc_ssi.c b/hw/ssi/dwc_ssi.c
> new file mode 100644
> index 0000000000..c0bcf8b869
> --- /dev/null
> +++ b/hw/ssi/dwc_ssi.c
> @@ -0,0 +1,976 @@
> +/*
> + * Synopsys DesignWare SSI
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the DesignWare SSI controller in Standard SPI mode,
> + * covering the PIO/FIFO data path and chip selects.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/irq.h"
> +#include "hw/ssi/dwc_ssi.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +/* DWC SSI 1.03 derivative (TRM v0.3.1 section 12.3). */
> +#define DWC_SSI_CTRLR0_RESET            0x00004007
> +#define DWC_SSI_SR_RESET                0x00000006
> +#define DWC_SSI_IDR_RESET               0xa1b2c3d5
> +#define DWC_SSI_VERSION                 0x3130332a
> +#define DWC_SSI_PIO_TX_BATCH            64
> +
> +enum {
> +    DWC_SSI_TMOD_TR,
> +    DWC_SSI_TMOD_TO,
> +    DWC_SSI_TMOD_RO,
> +    DWC_SSI_TMOD_EEPROM_READ,
> +};
> +
> +REG32(CTRLR0, 0x000)
> +    FIELD(CTRLR0, DFS, 0, 5)
> +    FIELD(CTRLR0, FRF, 6, 2)
> +    FIELD(CTRLR0, SCPH, 8, 1)
> +    FIELD(CTRLR0, SCPOL, 9, 1)
> +    FIELD(CTRLR0, TMOD, 10, 2)
> +    FIELD(CTRLR0, SLV_OE, 12, 1)
> +    FIELD(CTRLR0, SRL, 13, 1)
> +    FIELD(CTRLR0, SSTE, 14, 1)
> +    FIELD(CTRLR0, CFS, 16, 4)
> +    FIELD(CTRLR0, SPI_FRF, 22, 2)
> +    FIELD(CTRLR0, SPI_HYPERBUS_EN, 24, 1)
> +    FIELD(CTRLR0, SPI_DWS_EN, 25, 1)
> +REG32(CTRLR1, 0x004)
> +    FIELD(CTRLR1, NDF, 0, 16)
> +REG32(SSIENR, 0x008)
> +    FIELD(SSIENR, SSIC_EN, 0, 1)
> +REG32(MWCR, 0x00c)
> +    FIELD(MWCR, MWMOD, 0, 1)
> +    FIELD(MWCR, MDD, 1, 1)
> +    FIELD(MWCR, MHS, 2, 1)
> +REG32(SER, 0x010)
> +REG32(BAUDR, 0x014)
> +    FIELD(BAUDR, SCKDV, 1, 15)
> +REG32(TXFTLR, 0x018)
> +    FIELD(TXFTLR, TFT, 0, 8)
> +    FIELD(TXFTLR, TXFTHR, 16, 11)
> +REG32(RXFTLR, 0x01c)
> +    FIELD(RXFTLR, RFT, 0, 8)
> +REG32(TXFLR, 0x020)
> +    FIELD(TXFLR, TXTFL, 0, 9)
> +REG32(RXFLR, 0x024)
> +    FIELD(RXFLR, RXTFL, 0, 9)
> +REG32(SR, 0x028)
> +    FIELD(SR, CMPLTD_DF, 15, 17)
> +    FIELD(SR, DCOL, 6, 1)
> +    FIELD(SR, TXE, 5, 1)
> +    FIELD(SR, BUSY, 0, 1)
> +    FIELD(SR, TFNF, 1, 1)
> +    FIELD(SR, TFE, 2, 1)
> +    FIELD(SR, RFNE, 3, 1)
> +    FIELD(SR, RFF, 4, 1)
> +REG32(IMR, 0x02c)
> +    FIELD(IMR, DONEM, 11, 1)
> +    FIELD(IMR, SPITEM, 10, 1)
> +    FIELD(IMR, AXIEM, 8, 1)
> +    FIELD(IMR, TXUIM, 7, 1)
> +    FIELD(IMR, XRXOIM, 6, 1)
> +    FIELD(IMR, MSTIM, 5, 1)
> +    FIELD(IMR, RXOIM, 3, 1)
> +    FIELD(IMR, RXUIM, 2, 1)
> +    FIELD(IMR, TXOIM, 1, 1)
> +    FIELD(IMR, TXEIM, 0, 1)
> +    FIELD(IMR, RXFIM, 4, 1)
> +REG32(ISR, 0x030)
> +    FIELD(ISR, DONES, 11, 1)
> +    FIELD(ISR, SPITES, 10, 1)
> +    FIELD(ISR, AXIES, 8, 1)
> +    FIELD(ISR, TXUIS, 7, 1)
> +    FIELD(ISR, XRXOIS, 6, 1)
> +    FIELD(ISR, MSTIS, 5, 1)
> +    FIELD(ISR, RXOIS, 3, 1)
> +    FIELD(ISR, RXUIS, 2, 1)
> +    FIELD(ISR, TXOIS, 1, 1)
> +    FIELD(ISR, TXEIS, 0, 1)
> +    FIELD(ISR, RXFIS, 4, 1)
> +REG32(RISR, 0x034)
> +    FIELD(RISR, DONER, 11, 1)
> +    FIELD(RISR, SPITER, 10, 1)
> +    FIELD(RISR, AXIER, 8, 1)
> +    FIELD(RISR, TXUIR, 7, 1)
> +    FIELD(RISR, XRXOIR, 6, 1)
> +    FIELD(RISR, MSTIR, 5, 1)
> +    FIELD(RISR, RXOIR, 3, 1)
> +    FIELD(RISR, RXUIR, 2, 1)
> +    FIELD(RISR, TXOIR, 1, 1)
> +    FIELD(RISR, TXEIR, 0, 1)
> +    FIELD(RISR, RXFIR, 4, 1)
> +REG32(TXEICR, 0x038)
> +    FIELD(TXEICR, TXEICR, 0, 1)
> +REG32(RXOICR, 0x03c)
> +    FIELD(RXOICR, RXOICR, 0, 1)
> +REG32(RXUICR, 0x040)
> +    FIELD(RXUICR, RXUICR, 0, 1)
> +REG32(MSTICR, 0x044)
> +    FIELD(MSTICR, MSTICR, 0, 1)
> +REG32(ICR, 0x048)
> +    FIELD(ICR, ICR, 0, 1)
> +REG32(DMACR, 0x04c)
> +    FIELD(DMACR, RDMAE, 0, 1)
> +    FIELD(DMACR, TDMAE, 1, 1)
> +    FIELD(DMACR, IDMAE, 2, 1)
> +    FIELD(DMACR, ATW, 3, 2)
> +    FIELD(DMACR, AINC, 6, 1)
> +    FIELD(DMACR, ACACHE, 8, 4)
> +    FIELD(DMACR, APROT, 12, 3)
> +    FIELD(DMACR, AID, 15, 4)
> +REG32(AXIAWLEN, 0x050)
> +    FIELD(AXIAWLEN, AWLEN, 8, 8)
> +REG32(AXIARLEN, 0x054)
> +    FIELD(AXIARLEN, ARLEN, 8, 8)
> +REG32(IDR, 0x058)
> +    FIELD(IDR, IDCODE, 0, 32)
> +REG32(SSIC_VERSION_ID, 0x05c)
> +    FIELD(SSIC_VERSION_ID, VERSION_ID, 0, 32)
> +REG32(DR0, 0x060)
> +REG32(DR_END, 0x0ec)
> +REG32(RX_SAMPLE_DELAY, 0x0f0)
> +    FIELD(RX_SAMPLE_DELAY, RSD, 0, 8)
> +    FIELD(RX_SAMPLE_DELAY, SE, 16, 1)
> +REG32(SPI_CTRLR0, 0x0f4)
> +    FIELD(SPI_CTRLR0, CLK_STRETCH_EN, 30, 1)
> +    FIELD(SPI_CTRLR0, XIP_PREFETCH_EN, 29, 1)
> +    FIELD(SPI_CTRLR0, XIP_MBL, 26, 2)
> +    FIELD(SPI_CTRLR0, SPI_RXDS_SIG_EN, 25, 1)
> +    FIELD(SPI_CTRLR0, SPI_DM_EN, 24, 1)
> +    FIELD(SPI_CTRLR0, SSIC_XIP_CONT_XFER_EN, 21, 1)
> +    FIELD(SPI_CTRLR0, XIP_INST_EN, 20, 1)
> +    FIELD(SPI_CTRLR0, XIP_DFS_HC, 19, 1)
> +    FIELD(SPI_CTRLR0, SPI_RXDS_EN, 18, 1)
> +    FIELD(SPI_CTRLR0, INST_DDR_EN, 17, 1)
> +    FIELD(SPI_CTRLR0, SPI_DDR_EN, 16, 1)
> +    FIELD(SPI_CTRLR0, WAIT_CYCLES, 11, 5)
> +    FIELD(SPI_CTRLR0, INST_L, 8, 2)
> +    FIELD(SPI_CTRLR0, XIP_MD_BIT_EN, 7, 1)
> +    FIELD(SPI_CTRLR0, ADDR_L, 2, 4)
> +    FIELD(SPI_CTRLR0, TRANS_TYPE, 0, 2)
> +REG32(DDR_DRIVE_EDGE, 0x0f8)
> +    FIELD(DDR_DRIVE_EDGE, TDE, 0, 8)
> +REG32(XIP_MODE_BITS, 0x0fc)
> +    FIELD(XIP_MODE_BITS, XIP_MD_BITS, 0, 16)
> +REG32(XIP_INCR_INST, 0x100)
> +    FIELD(XIP_INCR_INST, INCR_INST, 0, 16)
> +REG32(XIP_WRAP_INST, 0x104)
> +    FIELD(XIP_WRAP_INST, WRAP_INST, 0, 16)
> +REG32(XIP_CTRL, 0x108)
> +REG32(XIP_SER, 0x10c)
> +REG32(XRXOICR, 0x110)
> +REG32(XIP_CNT_TIME_OUT, 0x114)
> +REG32(SPI_CTRLR1, 0x118)
> +REG32(SPITECR, 0x11c)
> +REG32(SPIDR, 0x120)
> +    FIELD(SPIDR, SPI_INST, 0, 16)
> +REG32(SPIAR, 0x124)
> +    FIELD(SPIAR, SDAR, 0, 32)
> +REG32(AXIAR0, 0x128)
> +    FIELD(AXIAR0, AXIAR_0_31, 0, 32)
> +REG32(AXIAR1, 0x12c)
> +    FIELD(AXIAR1, AXIAR_32_63, 0, 32)
> +REG32(AXIECR, 0x130)
> +    FIELD(AXIECR, AXIECR, 0, 1)
> +REG32(DONECR, 0x134)
> +    FIELD(DONECR, DONECR, 0, 1)
> +REG32(RSVD_138, 0x138)
> +REG32(RSVD_13C, 0x13c)
> +REG32(XIP_WRITE_INCR_INST, 0x140)
> +REG32(XIP_WRITE_WRAP_INST, 0x144)
> +REG32(XIP_WRITE_CTRL, 0x148)
> +
> +#define DWC_SSI_CTRLR0_STANDARD_WRITABLE_MASK \
> +    (R_CTRLR0_DFS_MASK | \
> +     R_CTRLR0_SCPH_MASK | \
> +     R_CTRLR0_SCPOL_MASK | \
> +     R_CTRLR0_TMOD_MASK | \
> +     R_CTRLR0_SLV_OE_MASK | \
> +     R_CTRLR0_SRL_MASK | \
> +     R_CTRLR0_SSTE_MASK | \
> +     R_CTRLR0_CFS_MASK)
> +
> +#define DWC_SSI_CTRLR1_WRITABLE_MASK R_CTRLR1_NDF_MASK
> +#define DWC_SSI_MWCR_WRITABLE_MASK \
> +    (R_MWCR_MWMOD_MASK | R_MWCR_MDD_MASK)
> +#define DWC_SSI_BAUDR_WRITABLE_MASK R_BAUDR_SCKDV_MASK
> +#define DWC_SSI_TXFTLR_WRITABLE_MASK \
> +    (R_TXFTLR_TFT_MASK | R_TXFTLR_TXFTHR_MASK)
> +#define DWC_SSI_RXFTLR_WRITABLE_MASK R_RXFTLR_RFT_MASK
> +#define DWC_SSI_IMR_WRITABLE_MASK \
> +    (R_IMR_TXEIM_MASK | R_IMR_TXOIM_MASK | R_IMR_RXUIM_MASK | \
> +     R_IMR_RXOIM_MASK | R_IMR_RXFIM_MASK | R_IMR_MSTIM_MASK | \
> +     R_IMR_TXUIM_MASK)
> +#define DWC_SSI_RX_SAMPLE_DELAY_WRITABLE_MASK \
> +    (R_RX_SAMPLE_DELAY_RSD_MASK | R_RX_SAMPLE_DELAY_SE_MASK)
> +
> +static bool dwc_ssi_validate_config(DwcSsiState *s, Error **errp)
> +{
> +    DeviceState *dev = DEVICE(s);
> +
> +    if (s->cfg.num_cs == 0 || s->cfg.num_cs > 8) {
> +        error_setg(errp, "%s: num-cs must be in range 1..8",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    if (s->cfg.fifo_depth < 2 || s->cfg.fifo_depth > 256) {
> +        error_setg(errp, "%s: fifo-depth must be in range 2..256",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    if (s->cfg.imr_reset & ~DWC_SSI_IMR_WRITABLE_MASK) {
> +        error_setg(errp, "%s: imr-reset contains unsupported bits",
> +                   dev->canonical_path);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool dwc_ssi_fifo_threshold_valid(const DwcSsiState *s, uint32_t value)
> +{
> +    return value < s->cfg.fifo_depth;
> +}
> +
> +static void dwc_ssi_write_masked(DwcSsiState *s, unsigned int reg,
> +                                 uint32_t value, uint32_t mask)
> +{
> +    s->regs[reg] = (s->regs[reg] & ~mask) | (value & mask);
> +}
> +
> +static uint32_t dwc_ssi_frame_masked(DwcSsiState *s)
> +{
> +    unsigned int bits = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, DFS) + 1;
> +
> +    return bits == 32 ? UINT32_MAX : MAKE_64BIT_MASK(0, bits);
> +}
> +
> +static bool dwc_ssi_is_enabled(const DwcSsiState *s)
> +{
> +    return FIELD_EX32(s->regs[R_SSIENR], SSIENR, SSIC_EN);
> +}
> +
> +static void dwc_ssi_deselect(DwcSsiState *s)
> +{
> +    if (s->active_cs < 0) {
> +        return;
> +    }
> +
> +    qemu_irq_raise(s->cs_lines[s->active_cs]);
> +    s->active_cs = -1;
> +}
> +
> +static void dwc_ssi_select(DwcSsiState *s, unsigned cs)
> +{
> +    if (cs >= s->cfg.num_cs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: invalid chip select %u\n",
> +                      DEVICE(s)->canonical_path, cs);
> +        dwc_ssi_deselect(s);
> +        return;
> +    }
> +
> +    if (s->active_cs == cs) {
> +        return;
> +    }
> +
> +    dwc_ssi_deselect(s);
> +    qemu_irq_lower(s->cs_lines[cs]);
> +    s->active_cs = cs;
> +}
> +
> +static void dwc_ssi_update_cs(DwcSsiState *s)
> +{
> +    uint32_t ser = s->regs[R_SER];
> +
> +    if (!dwc_ssi_is_enabled(s) || !ser) {
> +        dwc_ssi_deselect(s);
> +        return;
> +    }
> +
> +    if (ser & (ser - 1)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: multiple chip selects enabled: 0x%x\n",
> +                      DEVICE(s)->canonical_path, ser);
> +        dwc_ssi_deselect(s);
> +        return;
> +    }
> +
> +    dwc_ssi_select(s, ctz32(ser));
> +}
> +
> +static void dwc_ssi_abort_transfer(DwcSsiState *s)
> +{
> +    dwc_ssi_deselect(s);
> +    fifo32_reset(&s->tx_fifo);
> +    fifo32_reset(&s->rx_fifo);
> +    s->phase = DWC_SSI_PHASE_IDLE;
> +    s->remaining_frames = 0;
> +    s->dummy_frame = 0;
> +}
> +
> +static uint32_t dwc_ssi_status(DwcSsiState *s)
> +{
> +    uint32_t tx_used = fifo32_num_used(&s->tx_fifo);
> +    uint32_t rx_used = fifo32_num_used(&s->rx_fifo);
> +    uint32_t sr = 0;
> +
> +    sr = FIELD_DP32(sr, SR, BUSY, s->phase != DWC_SSI_PHASE_IDLE);
> +    sr = FIELD_DP32(sr, SR, TFNF, tx_used < s->cfg.fifo_depth);
> +    sr = FIELD_DP32(sr, SR, TFE, tx_used == 0);
> +    sr = FIELD_DP32(sr, SR, RFNE, rx_used != 0);
> +    sr = FIELD_DP32(sr, SR, RFF,
> +                    rx_used == s->cfg.fifo_depth);
> +
> +    return sr;
> +}
> +
> +static void dwc_ssi_run_transfer(DwcSsiState *s);
> +
> +static void dwc_ssi_push_tx(DwcSsiState *s, uint32_t tx)
> +{
> +    if (!dwc_ssi_is_enabled(s)) {
> +        return;
> +    }
> +
> +    if (fifo32_is_full(&s->tx_fifo)) {
> +        return;
> +    }
> +
> +    fifo32_push(&s->tx_fifo, tx);
> +
> +    if (s->phase != DWC_SSI_PHASE_STANDARD_TX_ONLY) {
> +        dwc_ssi_run_transfer(s);
> +    }
> +}
> +
> +static uint32_t dwc_ssi_send_frame(DwcSsiState *s,
> +                                   uint32_t tx)
> +{
> +    uint32_t mask = dwc_ssi_frame_masked(s);
> +    uint32_t rx;
> +
> +    tx &= mask;
> +
> +    if (FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SRL)) {
> +        rx = tx;
> +    } else {
> +        rx = ssi_transfer(s->spi, tx);
> +    }
> +
> +    return rx & mask;
> +}
> +
> +static void dwc_ssi_run_transfer(DwcSsiState *s)
> +{
> +    uint32_t tmod;
> +
> +    if (!dwc_ssi_is_enabled(s) || s->active_cs < 0) {
> +        return;
> +    }
> +
> +    /* SCKDV=0 disables sclk_out: no transfer can start. */
> +    if (FIELD_EX32(s->regs[R_BAUDR], BAUDR, SCKDV) == 0) {
> +        return;
> +    }
> +
> +    /*
> +     * TRM: the controller starts shifting only after the TX FIFO
> +     * occupancy exceeds TXFTLR.TXFTHR.  Transfers already in flight
> +     * are not interrupted when the FIFO temporarily drops below the
> +     * level.
> +     */
> +    if (s->phase == DWC_SSI_PHASE_IDLE &&
> +        fifo32_num_used(&s->tx_fifo) <=
> +            FIELD_EX32(s->regs[R_TXFTLR], TXFTLR, TXFTHR)) {
> +        return;
> +    }
> +
> +    tmod = FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, TMOD);
> +
> +    switch (tmod) {
> +    case DWC_SSI_TMOD_TR:
> +        if (s->phase == DWC_SSI_PHASE_IDLE) {
> +            s->phase = DWC_SSI_PHASE_STANDARD_TR;
> +        }
> +
> +        while (!fifo32_is_empty(&s->tx_fifo)) {
> +            uint32_t tx = fifo32_pop(&s->tx_fifo);
> +            uint32_t rx = dwc_ssi_send_frame(s, tx);
> +
> +            if (fifo32_is_full(&s->rx_fifo)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: RX FIFO full, dropping frame\n",
> +                              DEVICE(s)->canonical_path);
> +            } else {
> +                fifo32_push(&s->rx_fifo, rx);
> +            }
> +        }
> +
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DWC_SSI_PHASE_IDLE;
> +        }
> +        break;
> +    case DWC_SSI_TMOD_TO: {
> +        unsigned int frames = 0;
> +
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DWC_SSI_PHASE_IDLE;
> +            break;
> +        }
> +
> +        s->phase = DWC_SSI_PHASE_STANDARD_TX_ONLY;
> +        while (!fifo32_is_empty(&s->tx_fifo) &&
> +               frames < DWC_SSI_PIO_TX_BATCH) {
> +            uint32_t tx = fifo32_pop(&s->tx_fifo);
> +
> +            dwc_ssi_send_frame(s, tx);
> +            frames++;
> +        }
> +        if (fifo32_is_empty(&s->tx_fifo)) {
> +            s->phase = DWC_SSI_PHASE_IDLE;
> +        }
> +        break;
> +    }
> +    case DWC_SSI_TMOD_RO:
> +        switch (s->phase) {
> +        case DWC_SSI_PHASE_IDLE:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            s->dummy_frame = fifo32_pop(&s->tx_fifo);
> +            s->phase = DWC_SSI_PHASE_RX_ONLY;
> +            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
> +                                              NDF) + 1;
> +            /* Fall through. */
> +        case DWC_SSI_PHASE_RX_ONLY:
> +            while (s->remaining_frames > 0 &&
> +                   !fifo32_is_full(&s->rx_fifo)) {
> +                uint32_t rx = dwc_ssi_send_frame(s, s->dummy_frame);
> +
> +                fifo32_push(&s->rx_fifo, rx);
> +                s->remaining_frames--;
> +            }
> +            if (s->remaining_frames == 0) {
> +                s->phase = DWC_SSI_PHASE_IDLE;
> +            }
> +            break;
> +        }
> +        break;
> +    case DWC_SSI_TMOD_EEPROM_READ:
> +        switch (s->phase) {
> +        case DWC_SSI_PHASE_IDLE:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            s->phase = DWC_SSI_PHASE_EEPROM_COMMAND;
> +            /* Fall through. */
> +        case DWC_SSI_PHASE_EEPROM_COMMAND:
> +            if (fifo32_is_empty(&s->tx_fifo)) {
> +                break;
> +            }
> +            while (!fifo32_is_empty(&s->tx_fifo)) {
> +                uint32_t tx = fifo32_pop(&s->tx_fifo);
> +
> +                dwc_ssi_send_frame(s, tx);
> +            }
> +            s->phase = DWC_SSI_PHASE_EEPROM_DATA;
> +            s->remaining_frames = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1,
> +                                              NDF) + 1;
> +            /* Fall through. */
> +        case DWC_SSI_PHASE_EEPROM_DATA:
> +            while (s->remaining_frames > 0 &&
> +                   !fifo32_is_full(&s->rx_fifo)) {
> +                uint32_t rx = dwc_ssi_send_frame(s, 0x00);
> +
> +                fifo32_push(&s->rx_fifo, rx);
> +                s->remaining_frames--;
> +            }
> +            if (s->remaining_frames == 0) {
> +                s->phase = DWC_SSI_PHASE_IDLE;
> +            }
> +            break;
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static bool dwc_ssi_is_dr(hwaddr addr)
> +{
> +    return addr >= A_DR0 && addr <= A_DR_END &&
> +           (addr & 0x3) == 0;
> +}
> +
> +static bool dwc_ssi_is_unsupported_offset(hwaddr addr)
> +{
> +    switch (addr) {
> +    /* Enhanced SPI extensions. */
> +    case A_SPI_CTRLR0:
> +    case A_DDR_DRIVE_EDGE:
> +
> +    /* XIP extensions. */
> +    case A_XIP_MODE_BITS:
> +    case A_XIP_INCR_INST:
> +    case A_XIP_WRAP_INST:
> +    case A_XIP_CTRL:
> +    case A_XIP_SER:
> +    case A_XRXOICR:
> +    case A_XIP_CNT_TIME_OUT:
> +    case A_SPI_CTRLR1:
> +    case A_SPITECR:
> +    case A_RSVD_138:
> +    case A_RSVD_13C:
> +    case A_XIP_WRITE_INCR_INST:
> +    case A_XIP_WRITE_WRAP_INST:
> +    case A_XIP_WRITE_CTRL:
> +
> +    /* Internal-AXI DMA/IDMA extensions. */
> +    case A_DMACR:
> +    case A_AXIAWLEN:
> +    case A_AXIARLEN:
> +    case A_SPIDR:
> +    case A_SPIAR:
> +    case A_AXIAR0:
> +    case A_AXIAR1:
> +    case A_AXIECR:
> +    case A_DONECR:
> +
> +    /* SSI unsupported extensions. */
> +    case A_RX_SAMPLE_DELAY:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static bool dwc_ssi_write_requires_disabled(hwaddr addr)
> +{
> +    switch (addr) {
> +    case A_CTRLR0:
> +    case A_CTRLR1:
> +    case A_MWCR:
> +    case A_BAUDR:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static uint32_t dwc_ssi_unsupported_read(DwcSsiState *s,
> +                                        hwaddr addr)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unsupported read at 0x%" HWADDR_PRIx "\n",
> +                  DEVICE(s)->canonical_path, addr);
> +    return 0;
> +}
> +
> +static void dwc_ssi_unsupported_write(DwcSsiState *s,
> +                                     hwaddr addr,
> +                                     uint32_t value)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "%s: unsupported write at 0x%" HWADDR_PRIx
> +                  " value 0x%08x\n",
> +                  DEVICE(s)->canonical_path, addr, value);
> +}
> +
> +static uint64_t dwc_ssi_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    DwcSsiState *s = DWC_SSI(opaque);
> +    uint32_t value = 0;
> +
> +    if (dwc_ssi_is_dr(addr)) {
> +        if (!fifo32_is_empty(&s->rx_fifo)) {
> +            value = fifo32_pop(&s->rx_fifo) & dwc_ssi_frame_masked(s);
> +        } else {
> +            value = 0;
> +        }
> +
> +        dwc_ssi_run_transfer(s);
> +        return value;
> +    }
> +
> +    if (dwc_ssi_is_unsupported_offset(addr)) {
> +        value = dwc_ssi_unsupported_read(s, addr);
> +        return value;
> +    }
> +
> +    switch (addr) {
> +    case A_CTRLR0:
> +    case A_CTRLR1:
> +    case A_SSIENR:
> +    case A_MWCR:
> +    case A_BAUDR:
> +    case A_TXFTLR:
> +    case A_RXFTLR:
> +    case A_IMR:
> +    case A_IDR:
> +    case A_SSIC_VERSION_ID:
> +        value = s->regs[addr / sizeof(uint32_t)];
> +        break;
> +
> +    case A_SER:
> +        value = s->regs[R_SER] & MAKE_64BIT_MASK(0, s->cfg.num_cs);
> +        break;
> +    case A_TXFLR:
> +        value = fifo32_num_used(&s->tx_fifo);
> +        if (s->phase == DWC_SSI_PHASE_STANDARD_TX_ONLY) {
> +            dwc_ssi_run_transfer(s);
> +        }
> +        break;
> +    case A_RXFLR:
> +        value = fifo32_num_used(&s->rx_fifo);
> +        break;
> +    case A_SR:
> +        value = dwc_ssi_status(s);
> +        if (s->phase == DWC_SSI_PHASE_STANDARD_TX_ONLY) {
> +            dwc_ssi_run_transfer(s);
> +        }
> +        break;
> +    default:
> +        if (addr >= DWC_SSI_REGS_SIZE || (addr & 0x3) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: bad read offset 0x%" HWADDR_PRIx "\n",
> +                          DEVICE(s)->canonical_path, addr);
> +        }
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static void dwc_ssi_write(void *opaque, hwaddr addr,
> +                          uint64_t value, unsigned int size)
> +{
> +    DwcSsiState *s = DWC_SSI(opaque);
> +
> +    if (dwc_ssi_is_dr(addr)) {
> +        dwc_ssi_push_tx(s, value);
> +        return;
> +    }
> +
> +    if (dwc_ssi_is_unsupported_offset(addr)) {
> +        dwc_ssi_unsupported_write(s, addr, value);
> +        return;
> +    }
> +
> +    if (dwc_ssi_write_requires_disabled(addr) &&
> +        dwc_ssi_is_enabled(s)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write to offset 0x%" HWADDR_PRIx
> +                      " while SSI is enabled\n",
> +                      DEVICE(s)->canonical_path, addr);
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case A_CTRLR0:
> +        /* Keep SPI_FRF at Standard until enhanced SPI is fully modelled. */
> +        value &= ~R_CTRLR0_SPI_FRF_MASK;

Accidently sent this comment to your v2 patch, yesterday. Resending here.

Why does the SPI_FRF field need to be explicity cleared? It will be 
cleared in dw_ssi_write_masked since it is not contained in the 
DW_SSI_CTRLR0_STANDARD_WRITABLE_MASK .

Can you also print an unimplemented warning if a non-zero value is 
written to the SPI_FRF field. Currently configuring the device to 
enhanced mode is silently ignored.

> +        dwc_ssi_write_masked(s, R_CTRLR0, value,
> +                             DWC_SSI_CTRLR0_STANDARD_WRITABLE_MASK);
> +        break;
> +    case A_CTRLR1:
> +        dwc_ssi_write_masked(s, R_CTRLR1, value,
> +                             DWC_SSI_CTRLR1_WRITABLE_MASK);
> +        break;
> +    case A_SSIENR: {
> +        bool old_enabled = dwc_ssi_is_enabled(s);
> +        bool new_enabled = value & R_SSIENR_SSIC_EN_MASK;
> +
> +        if (old_enabled == new_enabled) {
> +            return;
> +        }
> +
> +        s->regs[R_SSIENR] = FIELD_DP32(0, SSIENR, SSIC_EN, new_enabled);
> +        if (!new_enabled) {
> +            dwc_ssi_abort_transfer(s);
> +            return;
> +        }
> +
> +        dwc_ssi_update_cs(s);
> +        dwc_ssi_run_transfer(s);
> +        break;
> +    }
> +    case A_MWCR:
> +        dwc_ssi_write_masked(s, R_MWCR, value,
> +                             DWC_SSI_MWCR_WRITABLE_MASK);
> +        break;
> +    case A_SER: {
> +        uint32_t old_ser = s->regs[R_SER];
> +        uint32_t new_ser = value & MAKE_64BIT_MASK(0, s->cfg.num_cs);
> +
> +        /*
> +         * Changing the selected slave terminates a pending transaction:
> +         * the FIFOs are flushed only by clearing SSIENR (TRM), but a
> +         * stale RO/EEPROM phase must not resume on the new chip select.
> +         */
> +        if (old_ser != new_ser && s->phase != DWC_SSI_PHASE_IDLE) {
> +            s->phase = DWC_SSI_PHASE_IDLE;
> +            s->remaining_frames = 0;
> +        }
> +        s->regs[R_SER] = new_ser;
> +
> +        dwc_ssi_update_cs(s);
> +        dwc_ssi_run_transfer(s);
> +        break;
> +    }
> +    case A_BAUDR:
> +        dwc_ssi_write_masked(s, R_BAUDR, value,
> +                             DWC_SSI_BAUDR_WRITABLE_MASK);
> +        break;
> +    case A_TXFTLR:
> +        if (!dwc_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, TXFTLR, TFT)) ||
> +            !dwc_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, TXFTLR, TXFTHR))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid txftlr value %x\n",
> +                          DEVICE(s)->canonical_path, (unsigned int)value);
> +            break;
> +        }
> +        dwc_ssi_write_masked(s, R_TXFTLR, value,
> +                             DWC_SSI_TXFTLR_WRITABLE_MASK);
> +        dwc_ssi_run_transfer(s);
> +        break;
> +    case A_RXFTLR:
> +        if (!dwc_ssi_fifo_threshold_valid(
> +                s, FIELD_EX32(value, RXFTLR, RFT))) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid rxftlr value %x\n",
> +                          DEVICE(s)->canonical_path, (unsigned int)value);
> +            break;
> +        }
> +        dwc_ssi_write_masked(s, R_RXFTLR, value,
> +                             DWC_SSI_RXFTLR_WRITABLE_MASK);
> +        break;
> +    case A_TXFLR:
> +    case A_RXFLR:
> +    case A_SR:
> +        break;
> +    case A_IMR:
> +        dwc_ssi_write_masked(s, R_IMR, value,
> +                             DWC_SSI_IMR_WRITABLE_MASK);
> +        break;
> +    case A_IDR:
> +    case A_SSIC_VERSION_ID:
> +        break;
> +    default:
> +        if (addr >= DWC_SSI_REGS_SIZE || (addr & 0x3) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: bad write offset 0x%" HWADDR_PRIx "\n",
> +                          DEVICE(s)->canonical_path, addr);
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps dwc_ssi_ops = {
> +    .read = dwc_ssi_read,
> +    .write = dwc_ssi_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void dwc_ssi_enter_reset(Object *obj, ResetType type)
> +{
> +    DwcSsiState *s = DWC_SSI(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    fifo32_reset(&s->tx_fifo);
> +    fifo32_reset(&s->rx_fifo);
> +    s->phase = DWC_SSI_PHASE_IDLE;
> +    s->remaining_frames = 0;
> +    s->dummy_frame = 0;
> +
> +    s->regs[R_CTRLR0] = DWC_SSI_CTRLR0_RESET;
> +    s->regs[R_SR] = DWC_SSI_SR_RESET;
> +    s->regs[R_IMR] = s->cfg.imr_reset & DWC_SSI_IMR_WRITABLE_MASK;
> +    s->regs[R_IDR] = DWC_SSI_IDR_RESET;
> +    s->regs[R_SSIC_VERSION_ID] = DWC_SSI_VERSION;
> +}
> +
> +static void dwc_ssi_hold_reset(Object *obj, ResetType type)
> +{
> +    DwcSsiState *s = DWC_SSI(obj);
> +    s->active_cs = -1;
> +
> +    if (s->cs_lines) {
> +        for (int i = 0; i < s->cfg.num_cs; i++) {
> +            qemu_irq_raise(s->cs_lines[i]);
> +        }
> +    }
> +}
> +
> +static bool dwc_ssi_fifo_valid(const Fifo32 *fifo, uint32_t depth)
> +{
> +    const Fifo8 *fifo8 = &fifo->fifo;
> +    uint32_t capacity = depth * sizeof(uint32_t);
> +
> +    return fifo8->capacity == capacity &&
> +           (fifo8->capacity % sizeof(uint32_t)) == 0 &&
> +           fifo8->head < fifo8->capacity &&
> +           fifo8->num <= fifo8->capacity &&
> +           (fifo8->head % sizeof(uint32_t)) == 0 &&
> +           (fifo8->num % sizeof(uint32_t)) == 0;
> +}
> +
> +static int dwc_ssi_post_load(void *opaque, int version_id)
> +{
> +    DwcSsiState *s = opaque;
> +    uint32_t ndf = FIELD_EX32(s->regs[R_CTRLR1], CTRLR1, NDF) + 1;
> +
> +    if (s->active_cs < -1 || s->active_cs >= (int)s->cfg.num_cs) {
> +        return -EINVAL;
> +    }
> +    if (!dwc_ssi_fifo_valid(&s->tx_fifo, s->cfg.fifo_depth) ||
> +        !dwc_ssi_fifo_valid(&s->rx_fifo, s->cfg.fifo_depth)) {
> +        return -EINVAL;
> +    }
> +    if (s->phase > DWC_SSI_PHASE_STANDARD_TR) {
> +        return -EINVAL;
> +    }
> +    if (s->phase == DWC_SSI_PHASE_RX_ONLY ||
> +        s->phase == DWC_SSI_PHASE_EEPROM_DATA) {
> +        if (s->remaining_frames == 0 || s->remaining_frames > ndf) {
> +            return -EINVAL;
> +        }
> +    } else if (s->remaining_frames != 0) {
> +        return -EINVAL;
> +    }
> +    if (s->active_cs >= 0 &&
> +        (!dwc_ssi_is_enabled(s) ||
> +         s->regs[R_SER] != BIT(s->active_cs))) {
> +        return -EINVAL;
> +    }
> +
> +    for (int i = 0; i < s->cfg.num_cs; i++) {
> +        qemu_irq_raise(s->cs_lines[i]);
> +    }
> +    if (s->active_cs >= 0) {
> +        qemu_irq_lower(s->cs_lines[s->active_cs]);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_dwc_ssi = {
> +    .name = TYPE_DWC_SSI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = dwc_ssi_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_EQUAL(cfg.num_cs, DwcSsiState),
> +        VMSTATE_UINT32_EQUAL(cfg.fifo_depth, DwcSsiState),
> +        VMSTATE_UINT32_EQUAL(cfg.imr_reset, DwcSsiState),
> +        VMSTATE_UINT32_ARRAY(regs, DwcSsiState, DWC_SSI_NUM_REGS),
> +        VMSTATE_FIFO32(tx_fifo, DwcSsiState),
> +        VMSTATE_FIFO32(rx_fifo, DwcSsiState),
> +        VMSTATE_UINT32(phase, DwcSsiState),
> +        VMSTATE_UINT32(remaining_frames, DwcSsiState),
> +        VMSTATE_UINT32(dummy_frame, DwcSsiState),
> +        VMSTATE_INT32(active_cs, DwcSsiState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void dwc_ssi_init(Object *obj)
> +{
> +    DwcSsiState *s = DWC_SSI(obj);
> +    DeviceState *dev = DEVICE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    s->spi = ssi_create_bus(dev, "spi");
> +
> +    memory_region_init_io(&s->mmio, obj, &dwc_ssi_ops, s,
> +                          TYPE_DWC_SSI, DWC_SSI_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    s->active_cs = -1;
> +}
> +
> +static void dwc_ssi_realize(DeviceState *dev, Error **errp)
> +{
> +    DwcSsiState *s = DWC_SSI(dev);
> +
> +    if (!dwc_ssi_validate_config(s, errp)) {
> +        return;
> +    }
> +
> +    s->cs_lines = g_new0(qemu_irq, s->cfg.num_cs);
> +    qdev_init_gpio_out_named(dev, s->cs_lines, "cs", s->cfg.num_cs);
> +
> +    fifo32_create(&s->tx_fifo, s->cfg.fifo_depth);
> +    fifo32_create(&s->rx_fifo, s->cfg.fifo_depth);
> +}
> +
> +static void dwc_ssi_finalize(Object *obj)
> +{
> +    DwcSsiState *s = DWC_SSI(obj);
> +
> +    fifo32_destroy(&s->tx_fifo);
> +    fifo32_destroy(&s->rx_fifo);
> +    g_free(s->cs_lines);
> +}
> +
> +static const Property dwc_ssi_properties[] = {
> +    DEFINE_PROP_UINT32("num-cs", DwcSsiState, cfg.num_cs, 1),
> +    DEFINE_PROP_UINT32("fifo-depth", DwcSsiState, cfg.fifo_depth, 256),
> +    DEFINE_PROP_UINT32("imr-reset", DwcSsiState,
> +                       cfg.imr_reset, 0x0000003f),
> +};
> +
> +static void dwc_ssi_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = dwc_ssi_realize;
> +    dc->vmsd = &vmstate_dwc_ssi;
> +    device_class_set_props(dc, dwc_ssi_properties);
> +    rc->phases.enter = dwc_ssi_enter_reset;
> +    rc->phases.hold = dwc_ssi_hold_reset;
> +}
> +
> +static const TypeInfo dwc_ssi_info = {
> +    .name = TYPE_DWC_SSI,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DwcSsiState),
> +    .instance_init = dwc_ssi_init,
> +    .instance_finalize = dwc_ssi_finalize,
> +    .class_init = dwc_ssi_class_init,
> +};
> +
> +static void dwc_ssi_register_types(void)
> +{
> +    type_register_static(&dwc_ssi_info);
> +}
> +
> +type_init(dwc_ssi_register_types)
> diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
> index 6afb1ea200..e3776325ce 100644
> --- a/hw/ssi/meson.build
> +++ b/hw/ssi/meson.build
> @@ -1,6 +1,7 @@
>   system_ss.add(when: 'CONFIG_ALLWINNER_A10_SPI', if_true: files('allwinner-a10-spi.c'))
>   system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
>   system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
> +system_ss.add(when: 'CONFIG_DWC_SSI', if_true: files('dwc_ssi.c'))
>   system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_fiu.c', 'npcm_pspi.c'))
>   system_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_SPI', if_true: files('sifive_spi.c'))
> diff --git a/include/hw/ssi/dwc_ssi.h b/include/hw/ssi/dwc_ssi.h
> new file mode 100644
> index 0000000000..6e4f8ea7bb
> --- /dev/null
> +++ b/include/hw/ssi/dwc_ssi.h
> @@ -0,0 +1,63 @@
> +/*
> + * Synopsys DesignWare SSI
> + *
> + * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Emulates the DesignWare SSI controller in Standard SPI mode,
> + * covering the PIO/FIFO data path and chip selects.
> + */
> +
> +#ifndef HW_SSI_DWC_SSI_H
> +#define HW_SSI_DWC_SSI_H
> +
> +#include "hw/core/sysbus.h"
> +#include "hw/ssi/ssi.h"
> +#include "qemu/fifo32.h"
> +#include "qom/object.h"
> +
> +#define TYPE_DWC_SSI "dwc-ssi"
> +OBJECT_DECLARE_SIMPLE_TYPE(DwcSsiState, DWC_SSI)
> +
> +#define DWC_SSI_MMIO_SIZE 0x1000
> +#define DWC_SSI_REGS_SIZE 0x14c
> +#define DWC_SSI_NUM_REGS \
> +    (DWC_SSI_REGS_SIZE / sizeof(uint32_t))
> +
> +typedef enum DwcSsiPhase {
> +    DWC_SSI_PHASE_IDLE,
> +    DWC_SSI_PHASE_STANDARD_TX_ONLY,
> +    DWC_SSI_PHASE_RX_ONLY,
> +    DWC_SSI_PHASE_EEPROM_COMMAND,
> +    DWC_SSI_PHASE_EEPROM_DATA,
> +    DWC_SSI_PHASE_STANDARD_TR,
> +} DwcSsiPhase;
> +
> +typedef struct DwcSsiConfig {
> +    uint32_t num_cs;
> +    uint32_t fifo_depth;
> +    uint32_t imr_reset;
> +} DwcSsiConfig;
> +
> +struct DwcSsiState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    SSIBus *spi;
> +
> +    qemu_irq *cs_lines;
> +
> +    Fifo32 tx_fifo;
> +    Fifo32 rx_fifo;
> +    uint32_t regs[DWC_SSI_NUM_REGS];
> +
> +    DwcSsiConfig cfg;
> +
> +    uint32_t phase;
> +    uint32_t remaining_frames;
> +    uint32_t dummy_frame;
> +
> +    int active_cs;
> +};
> +#endif /* HW_SSI_DWC_SSI_H */


