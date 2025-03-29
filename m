Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3609C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 11:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyUfw-0003WW-JV; Sat, 29 Mar 2025 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyUfp-0003PM-4l
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:48:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyUfm-0006wf-NW
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:48:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so1719982f8f.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743248901; x=1743853701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tK201a09kt8gcuRGeEc3FiwpFqkLC8ntCPTaYudy3LY=;
 b=JiiPD0D3b16GZo0/m79s8i7Je39qof9mFzygz3MzRpdUw+C2BPw5WgXEdw9+UFbog3
 ujTBBKNX+a7AvHZWf6acXZPvulp79UoBBG1WzwT0xQ5gHElEYCf8XpV/+hwyDZtDDz3I
 9Cu+I3qv/IrR2xfPeYwok4+uloRAdXBe0muIQH+vRet2z9Jm3Je2+RHaHOY0q20NBHdj
 0wcUwGUUsz3PZAp41V6UEs72o+LVgcyThbU7bSRy8u+bFnHn36n7tXddKF+mP1jO+Jh+
 ejRpwQtWzHdUbx+inocYFSNbnTukxal0WslegMI0dRPyD4z8Fhj7nj0KfWlE2EcjZ+Ud
 c3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743248901; x=1743853701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tK201a09kt8gcuRGeEc3FiwpFqkLC8ntCPTaYudy3LY=;
 b=RlmtMQDjqfgmG00crC2cERLJCPPvX8n58dkoXplt6Or6LI0f4dE/+lloG7LYFwzF+H
 sp6G6cn5PAyWu9dSV0Z1p7QDh5SCyLrKZf1rqXp4p9PC+SnX+VnXkvRXJ5EjbW4k74WR
 vmr4CgtNfWELQYJQHnGy17wV8vsmu0A/mqIpGdKMIZPC/+5hIrr8l3X6y2cGB2tmfFTG
 1jepzrdINzwoa56JjG5aq2UmIVyNPuwPxL4IJnxVmzrb9OhEDYo03MoI0NvAWTcyCJGf
 NswkdJPD/KcNWLXeLiAbenP4ItmfF22Qpo4ZzdiySH4oQB2E9YaO3WjJ7HmyWh1v1xWm
 tDuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEg14kQ2XV7o0w/kE+o1fAVXFGxPjToejFuXPcSztg3lnrW94HR9fBQv50SPnrmU0F3HW8+pOdRcT7@nongnu.org
X-Gm-Message-State: AOJu0Yy/zTP7+j1If98v5F5DFC13LaKhLVpJ0vhFd46kYJ6S+ev9D840
 fSPkaNEA5VpWj/6sOCC+33K/LH2XogsAB9IH+nJaEtxq9Kx+KciQIE0zYogbU9c=
X-Gm-Gg: ASbGnct0tj3Nx/o80IQcMjTJFpDsEDUhm0TK9c6JhbN1rFcM5vIMu+alue6O1EFJsNy
 12Ligf9k/3pg8gsw2OyahOcbP6QQ/uhvITmrLtCL3z0JIlZC+9Gg8BW3JCKeX3NxxzHZbBIAE5R
 LTRoGi8xWoWkK9OxNDLlIM8BxHtbMoeVS5Q2NwXsi251S/vTeyxFOdaXc4Nr62kpVDEhcUG+o1c
 pmmRTRcBQh5sAbzqjPDo2rMSm0m1Y5E/4e9GZDE+QicvU2r2bEI+/xjxtyT3EiSRHekZyoG8rUy
 9C+qrsVlhLgmo765TivbYbQaR1rlLnNbaxLXT2fD9nAeT9C26aOWPyb4umcZGXwEl3LJ6sNwIqN
 tMw1rE+rnHc4=
X-Google-Smtp-Source: AGHT+IFgmPwG2CzilSk9n3Jeh8h+N1ILYQYqf+R39RYrNGh61uBf2/oA8lpNnB84kfsQ3+ezJHSU+g==
X-Received: by 2002:a05:6000:40e0:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-39c12115db9mr1998239f8f.44.1743248900933; 
 Sat, 29 Mar 2025 04:48:20 -0700 (PDT)
Received: from [10.155.70.213] (189.171.88.92.rev.sfr.net. [92.88.171.189])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm5431095f8f.3.2025.03.29.04.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 04:48:20 -0700 (PDT)
Message-ID: <5cfc6e91-b50e-4541-b924-50306459a11b@linaro.org>
Date: Sat, 29 Mar 2025 12:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, thuth@redhat.com
Cc: balaton@eik.bme.hu, marcandre.lureau@redhat.com
References: <20250329004941.372000-1-rakeshjb010@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250329004941.372000-1-rakeshjb010@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Rakesh,

On 29/3/25 01:49, rakeshj wrote:
> The GT-64120 PCI controller requires special handling where:
> 1. Host bridge (device 0) must use native endianness
> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
> 
> Previous implementation accidentally swapped all accesses, breaking
> host bridge detection (lspci -d 11ab:4620).
> 
> This patch:
> - Adds custom read/write handlers to preserve native big-endian for the host
>    bridge (phb->config_reg & 0x00fff800 == 0).

Here you check for bus == 0 && device == 0, is that what you want? (I'm
confused because you only describe "for the host bridge").

If so I'd rather add a self-describing method:

  static bool is_phb_dev0(const PCIHostState *phb)
  {
      return extract32(phb->config_reg, 11, 5 /* dev */ + 8 /* bus) == 0;
  }

> - Swaps non-bridge devices when MByteSwap = 0, using size-appropriate swaps
>    (bswap16 for 2-byte, bswap32 for 4-byte) to convert PCI's little-endian data
>    to match the MIPS guest's big-endian expectation; no swap occurs for the host
>    bridge or when MByteSwap = 1 (little-endian mode).
> - Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initialization
>    to gt64120_realize()
> - Removes unused pci_host_data_be_ops and a misleading comment in dino.h.
> 
> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
> Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
> ---
>   hw/pci-host/gt64120.c      | 83 ++++++++++++++++++++++----------------
>   hw/pci/pci_host.c          |  6 ---
>   include/hw/pci-host/dino.h |  5 +--
>   include/hw/pci/pci_host.h  |  1 -
>   4 files changed, 50 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index d5c13a89b6..4e45d0aa53 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
>       memory_region_transaction_commit();
>   }
>   
> -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
> -{
> -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 0xc00 */
> -    static const MemoryRegionOps *pci_host_data_ops[] = {
> -        &pci_host_data_be_ops, &pci_host_data_le_ops
> -    };
> -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> -
> -    memory_region_transaction_begin();
> -
> -    /*
> -     * The setting of the MByteSwap bit and MWordSwap bit in the PCI Internal
> -     * Command Register determines how data transactions from the CPU to/from
> -     * PCI are handled along with the setting of the Endianness bit in the CPU
> -     * Configuration Register. See:
> -     * - Table 16: 32-bit PCI Transaction Endianness
> -     * - Table 158: PCI_0 Command, Offset: 0xc00
> -     */
> -
> -    if (memory_region_is_mapped(&phb->data_mem)) {
> -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
> -        object_unparent(OBJECT(&phb->data_mem));
> -    }
> -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
> -                          s, "pci-conf-data", 4);
> -    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
> -                                        &phb->data_mem, 1);
> -
> -    memory_region_transaction_commit();
> -}
> -
>   static void gt64120_pci_mapping(GT64120State *s)
>   {
>       memory_region_transaction_begin();
> @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
>       case GT_PCI0_CMD:
>       case GT_PCI1_CMD:
>           s->regs[saddr] = val & 0x0401fc0f;
> -        gt64120_update_pci_cfgdata_mapping(s);
>           break;
>       case GT_PCI0_TOR:
>       case GT_PCI0_BS_SCS10:
> @@ -1024,6 +991,49 @@ static const MemoryRegionOps isd_mem_ops = {
>       },
>   };
>   
> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    GT64120State *s = opaque;
> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);

You check the Enable bit in the write path but not here, any reason?
> +
> +    /* Only swap for non-bridge devices in big-endian mode */
> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {

Please use instead of (s->regs[GT_PCI0_CMD] & 1):

   bswap = FIELD_EX32(s->regs[GT_PCI0_CMD]m GT_PCI0_CMD, MByteSwap);

> +        if (size == 2) {
> +            val = bswap16(val);
> +        } else if (size == 4) {
> +            val = bswap32(val);
> +        }
> +    }
> +    return val;
> +}
> +
> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> +    uint64_t val, unsigned size)
> +{
> +    GT64120State *s = opaque;
> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
> +        if (size == 2) {
> +            val = bswap16(val);
> +        } else if (size == 4) {
> +            val = bswap32(val);
> +        }
> +    }
> +    if (phb->config_reg & (1u << 31))
> +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
> +}
> +
> +static const MemoryRegionOps gt64120_pci_data_ops = {
> +    .read = gt64120_pci_data_read,
> +    .write = gt64120_pci_data_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};

Per GT64120 rev 1.4, chapter "6.2.2 PCI Master CPU Byte Swapping":

   When the GT–64120 is configured for 64-bit PCI mode, byte
   swapping occurs across all 8 byte lanes when the ByteSwap
   bit is set for PCI_0.

>   static void gt64120_reset(DeviceState *dev)
>   {
>       GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
> @@ -1178,7 +1188,6 @@ static void gt64120_reset(DeviceState *dev)
>   
>       gt64120_isd_mapping(s);
>       gt64120_pci_mapping(s);
> -    gt64120_update_pci_cfgdata_mapping(s);
>   }
>   
>   static void gt64120_realize(DeviceState *dev, Error **errp)
> @@ -1202,6 +1211,12 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR << 2,
>                                           &phb->conf_mem, 1);
>   
> +    memory_region_init_io(&phb->data_mem, OBJECT(phb),
> +                          &gt64120_pci_data_ops,
> +                          s, "pci-conf-data", 4);
> +    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
> +                                        &phb->data_mem, 1);
> +
>   
>       /*
>        * The whole address space decoded by the GT-64120A doesn't generate

Please split the changes below in a distinct cleanup patch.

> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index 80f91f409f..56f7f28a1a 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -const MemoryRegionOps pci_host_data_be_ops = {
> -    .read = pci_host_data_read,
> -    .write = pci_host_data_write,
> -    .endianness = DEVICE_BIG_ENDIAN,
> -};
> -
>   static bool pci_host_needed(void *opaque)
>   {
>       PCIHostState *s = opaque;
> diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
> index fd7975c798..df509dbc18 100644
> --- a/include/hw/pci-host/dino.h
> +++ b/include/hw/pci-host/dino.h
> @@ -109,10 +109,7 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
>   struct DinoState {
>       PCIHostState parent_obj;
>   
> -    /*
> -     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
> -     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
> -     */
> +
>       uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
>   
>       uint32_t iar0;
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index e52d8ec2cd..954dd446fa 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
>   extern const MemoryRegionOps pci_host_conf_le_ops;
>   extern const MemoryRegionOps pci_host_conf_be_ops;
>   extern const MemoryRegionOps pci_host_data_le_ops;
> -extern const MemoryRegionOps pci_host_data_be_ops;
>   
>   #endif /* PCI_HOST_H */


