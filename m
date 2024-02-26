Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03953C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redqb-0001WF-06; Mon, 26 Feb 2024 11:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redqY-0001UF-SM
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:28:54 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1redqX-0002UU-0o
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:28:54 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so4377352a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964931; x=1709569731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oEkng3ZE/vlKyJr1xJbRI5B7Go9cYFsY9HcbjAsbMbY=;
 b=SjGj1qNs2ScTSqDbNlp4sIeHbrkSAui31wWSOSWwsPVtpb061l9jzSB7Y5m8HTcfdT
 iEr8Oau+wbtFtMdF050e8WPkTNJcc79a4CjuwGNTV7HFYSLytlXzCMP/Gm4yZXhfHaaI
 4vSq5SRwOXkBH9aJ8VGOBY8OPKpLnOZLOLRFyv7ksbKDrdx2UYQojV0yJqmNeYpOek0I
 Ly4Yf0oPAw50FEjmS0nL2HYhs3xBE3WtvF6blBWOEHfZSuyGtv395rtCOQpUqSFPmAEt
 6eBNgCfgY2DQBfpjc8QgRfevDBlWmUG8vFZl42BMm4Tzk0mNQdsuBA7PmTkQAIDoqyjG
 fRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964931; x=1709569731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEkng3ZE/vlKyJr1xJbRI5B7Go9cYFsY9HcbjAsbMbY=;
 b=LyQoh7rXl24+DSx9E/+BQHT51n0eMH0c8qyNCFkv8boedGLRCRz/trqWbbF7xyHVnf
 8ZxM+BFjKH8Ctz7B2ASwQxGwep4riA0xG2GKYRwjxC1zBKcvo3kQwOCZrj1PAMt1KVon
 1El4si2E1cfU6j/IM1h7ptbHmcsPLgN1mfNqCZ8O73JrWviqWYT3+/cy71SEgl0dV3Ei
 mg7neHwwVmU4il0ixlT+aEzMry2bbgkplg3aWNFCZ7sNjX54AaAhOEvI/N5AnjCpSexX
 6fKecm3+6bPMNuACHBX+8Fofia5WTSGCCh3U8yqNr8in0J5IbdmHVWhjplCn3/YGqvqB
 Wdcg==
X-Gm-Message-State: AOJu0Yx3oCEsgd7sNsVrJq2WXoqadZyttcFOGvCvXnvkkWAYu/0oMYLL
 5ZxCQzMxa1TTM0dUzNYmUs9t6XG0KKLAUfJla4sUt1zdXyYCrhTU3bUiiiSjNsA=
X-Google-Smtp-Source: AGHT+IGFnsz6gZIbQOWrfas0fCE+2J1tFVc+ulN8kK6UhPNP8zfEyU8iqdMcmB7TLR2QdsXskwGJhw==
X-Received: by 2002:aa7:d14e:0:b0:566:1683:6370 with SMTP id
 r14-20020aa7d14e000000b0056616836370mr1113277edo.19.1708964931349; 
 Mon, 26 Feb 2024 08:28:51 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 bo13-20020a0564020b2d00b005658186279csm2431258edb.18.2024.02.26.08.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 08:28:50 -0800 (PST)
Message-ID: <c1462a44-a5a0-46b6-8312-7cd1a7962718@linaro.org>
Date: Mon, 26 Feb 2024 17:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/41] Add BCM2838 PCIE host
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-15-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-15-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Sergey,

On 26/2/24 01:02, Sergey Kambalin wrote:
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>   hw/arm/bcm2838_pcie.c         | 217 +++++++++++++++++++++++++++++++++-
>   hw/arm/trace-events           |   4 +
>   include/hw/arm/bcm2838_pcie.h |  22 ++++
>   3 files changed, 241 insertions(+), 2 deletions(-)


> +static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    int i;
> +
> +    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
> +                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->cfg_regs);
> +
> +    /*
> +     * The MemoryRegions io_mmio and io_ioport that we pass to
> +     * pci_register_root_bus() are not the same as the MemoryRegions
> +     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
> +     * The difference is in the behavior of accesses to addresses where no PCI
> +     * device has been mapped.
> +     *
> +     * io_mmio and io_ioport are the underlying PCI view of the PCI address
> +     * space, and when a PCI device does a bus master access to a bad address
> +     * this is reported back to it as a transaction failure.
> +     *
> +     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
> +     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
> +     * not mandated properly by the PCI spec but expected by the majority of
> +     * PCI-using guest software, including Linux.
> +     *
> +     * We implement it in the PCIe host controller, by providing the *_window
> +     * MRs, which are containers with io ops that implement the 'background'
> +     * behavior and which hold the real PCI MRs as sub-regions.
> +     */
> +    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
> +    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
> +                       64 * 1024);
> +
> +    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_mmio_window", UINT64_MAX);
> +    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
> +    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
> +    sysbus_init_mmio(sbd, &s->io_mmio_window);
> +    sysbus_init_mmio(sbd, &s->io_ioport_window);
> +
> +    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +        s->irq_num[i] = -1;
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
> +                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
> +                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
> +                                     TYPE_PCIE_BUS);
> +    pci_bus_set_route_irq_fn(pci->bus, bcm2838_pcie_host_route_intx_pin_to_irq);
> +    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
> +}

Something is odd:

(qemu) info mtree
...
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
...
[DETECTED OVERFLOW!]     0000000600000000-00000005ffffffff (prio 0, 
i/o): bcm2838_pcie_mmio_window
[DETECTED OVERFLOW!]       0000000600000000-00000005ffffffff (prio 0, 
i/o): bcm2838_pcie_mmio
         0000000600000000-0000000600000000 (prio 1, i/o): alias 
pci_bridge_mem @pci_bridge_pci 0000000000000000-0000000000000000
         0000000600000000-0000000600000000 (prio 1, i/o): alias 
pci_bridge_pref_mem @pci_bridge_pci 0000000000000000-0000000000000000


