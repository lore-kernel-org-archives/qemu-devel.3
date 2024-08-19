Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D604C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftzP-0002pU-VG; Mon, 19 Aug 2024 00:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvw-0002k2-60
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:56 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvu-0004ja-1O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20202df1c2fso17497115ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041433; x=1724646233; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOy4FBOY+w4yjrjdybUBQRfN32zP+ViihPCMJnkV6PY=;
 b=u/g2YP6JhuxoL2X6Cd4gj8qXcpbt0lr95Ej55MIJe8q4XKhwSVAgRilifmYw3WBRuo
 xu49NF4OiJ7IHGeBG2QfaRgzQZjVrl8T0NSzw8PyR0obWk45yl71vFCjC+O2ngj4xbFi
 /G48N/NWKLsDHEtj/cNO6VdMExQGoINLgatkgAnU8Rmm0GPVmQKGLDZOznjE1/pJ9qyA
 mkypqy9fRPjlTXwUYf0zDIPWuZpgIy7nKS3br0RMsyZdLhZ97xEqB1XNX4QMNAlHQfeq
 IS5UuqH47jPx2QgfjXszow4+L6ciHu3f7SI/U2hW05TLq7mRGHcyhMhO4dlYhj0C2Lbu
 WyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041433; x=1724646233;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOy4FBOY+w4yjrjdybUBQRfN32zP+ViihPCMJnkV6PY=;
 b=bLoU3w8Lla0Ry7YajmaM9h/zFbA7vr6gmwyuPwhz/luoAQJZNhuh6xp4gc/iWRCU88
 /5DT+djLw8cLiY3rkYOsN5amOex5pBdC5hGSzAKkBDFf0gna8KTGDa7aHiOtnzGCkFHo
 RSq9ZZNILLjO4rSI0YUGRdgOY2hFIGSmHJWsLySohf8kEfWDLrwE37M05QtvZezTp45U
 dNeU3hQThaFNwwxIui8kbyrl7NJGZhlsrHX7y2+obDz25WtbjnVlRFS28SRXm7lCW/iJ
 ZVSDRnDZeNF/ZHebO0+CSHZ6AN+ppWKm/R5Y+ofltJ91d2tYehzktmDMaAR6cpAPYT3D
 blHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPPBTqImDYjcQ5byKw8GU6Dtf+SmRHszmAFqvd+zIz5d/CMBv2LnvLi56I42iBDG1WZROlkqsahAzd@nongnu.org
X-Gm-Message-State: AOJu0Yyu7EO1KltN6GP96Tjn/O7xZuLkTX2RtLbm47lnBsknXKNZqj4B
 PEIirey5cLpUjB/fSkPnuBYUPg2MpYCIO2OmgD0ryN6Ep86Gh769wAnGkJUH4uQ=
X-Google-Smtp-Source: AGHT+IGdybo0m9uhUSM4jzlw9tJnEGCX3c4CZ3yJwXqIyQW+ASxZqta1M7bC6VE9mSY/TIfyXtljPA==
X-Received: by 2002:a17:903:2309:b0:1fb:2ebc:d16b with SMTP id
 d9443c01a7336-201ee49e74emr208796915ad.7.1724041432643; 
 Sun, 18 Aug 2024 21:23:52 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03b0e0bsm56169755ad.300.2024.08.18.21.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:23:52 -0700 (PDT)
Subject: Re: [PATCH 8/8] hw/pci-host/designware: Create ViewPorts during host
 bridge realization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-9-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <9ce96a75-ad19-2d3e-50a3-640aae63dc4e@linaro.org>
Date: Mon, 19 Aug 2024 01:23:49 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-9-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.588,
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

Hi Phil,

On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> ViewPorts are managed by the host bridge part, so create them
> when the host bridge is realized. The host bridge become the

nit: becomes


> owner of the memory regions.
> 
> The PCI root function realize() method now only contains PCI
> specific code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> ---
>   hw/pci-host/designware.c | 207 +++++++++++++++++++--------------------
>   1 file changed, 102 insertions(+), 105 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 6cb8655a75..e5dc9b4b8d 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -384,22 +384,10 @@ static char *designware_pcie_viewport_name(const char *direction,
>   static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
> -    DesignwarePCIEHost *host = DESIGNWARE_PCIE_HOST(
> -                                    qdev_get_parent_bus(DEVICE(dev))->parent);
> -    MemoryRegion *host_mem = get_system_memory();
> -    MemoryRegion *address_space = &host->pci.memory;
>       PCIBridge *br = PCI_BRIDGE(dev);
> -    DesignwarePCIEViewport *viewport;
> -    /*
> -     * Dummy values used for initial configuration of MemoryRegions
> -     * that belong to a given viewport
> -     */
> -    const hwaddr dummy_offset = 0;
> -    const uint64_t dummy_size = 4;
> -    size_t i;
>   
>       br->bus_name  = "dw-pcie";
> -    root->host = host;
> +    root->host = DESIGNWARE_PCIE_HOST(qdev_get_parent_bus(DEVICE(dev))->parent);
>   
>       pci_set_word(dev->config + PCI_COMMAND,
>                    PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> @@ -414,97 +402,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>   
>       msi_nonbroken = true;
>       msi_init(dev, 0x50, 32, true, true, &error_fatal);
> -
> -    for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
> -        MemoryRegion *source, *destination, *mem;
> -        const char *direction;
> -        char *name;
> -
> -        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
> -        viewport->inbound = true;
> -        viewport->base    = 0x0000000000000000ULL;
> -        viewport->target  = 0x0000000000000000ULL;
> -        viewport->limit   = UINT32_MAX;
> -        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
> -
> -        source      = &host->pci.address_space_root;
> -        destination = host_mem;
> -        direction   = "Inbound";
> -
> -        /*
> -         * Configure MemoryRegion implementing PCI -> CPU memory
> -         * access
> -         */
> -        mem  = &viewport->mem;
> -        name = designware_pcie_viewport_name(direction, i, "MEM");
> -        memory_region_init_alias(mem, OBJECT(root), name, destination,
> -                                 dummy_offset, dummy_size);
> -        memory_region_add_subregion_overlap(source, dummy_offset, mem, -1);
> -        memory_region_set_enabled(mem, false);
> -        g_free(name);
> -
> -        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
> -        viewport->host    = host;
> -        viewport->inbound = false;
> -        viewport->base    = 0x0000000000000000ULL;
> -        viewport->target  = 0x0000000000000000ULL;
> -        viewport->limit   = UINT32_MAX;
> -        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
> -
> -        destination = &host->pci.memory;
> -        direction   = "Outbound";
> -        source      = host_mem;
> -
> -        /*
> -         * Configure MemoryRegion implementing CPU -> PCI memory
> -         * access
> -         */
> -        mem  = &viewport->mem;
> -        name = designware_pcie_viewport_name(direction, i, "MEM");
> -        memory_region_init_alias(mem, OBJECT(root), name, destination,
> -                                 dummy_offset, dummy_size);
> -        memory_region_add_subregion(source, dummy_offset, mem);
> -        memory_region_set_enabled(mem, false);
> -        g_free(name);
> -
> -        /*
> -         * Configure MemoryRegion implementing access to configuration
> -         * space
> -         */
> -        mem  = &viewport->cfg;
> -        name = designware_pcie_viewport_name(direction, i, "CFG");
> -        memory_region_init_io(&viewport->cfg, OBJECT(root),
> -                              &designware_pci_host_conf_ops,
> -                              viewport, name, dummy_size);
> -        memory_region_add_subregion(source, dummy_offset, mem);
> -        memory_region_set_enabled(mem, false);
> -        g_free(name);
> -    }
> -
> -    /*
> -     * If no inbound iATU windows are configured, HW defaults to
> -     * letting inbound TLPs to pass in. We emulate that by explicitly
> -     * configuring first inbound window to cover all of target's
> -     * address space.
> -     *
> -     * NOTE: This will not work correctly for the case when first
> -     * configured inbound window is window 0
> -     */
> -    viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
> -    viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
> -    designware_pcie_update_viewport(root, viewport);
> -
> -    memory_region_init_io(&host->msi.iomem, OBJECT(root),
> -                          &designware_pci_host_msi_ops,
> -                          root, "pcie-msi", 0x4);
> -    /*
> -     * We initially place MSI interrupt I/O region at address 0 and
> -     * disable it. It'll be later moved to correct offset and enabled
> -     * in designware_pcie_root_update_msi_mapping() as a part of
> -     * initialization done by guest OS
> -     */
> -    memory_region_add_subregion(address_space, dummy_offset, &host->msi.iomem);
> -    memory_region_set_enabled(&host->msi.iomem, false);
>   }
>   
>   static void designware_pcie_set_irq(void *opaque, int irq_num, int level)
> @@ -590,7 +487,7 @@ static void designware_pcie_root_class_init(ObjectClass *klass, void *data)
>       dc->reset = pci_bridge_reset;
>       /*
>        * PCI-facing part of the host bridge, not usable without the
> -     * host-facing part, which can't be device_add'ed, yet.
> +     * host-facing part.
>        */
>       dc->user_creatable = false;
>       dc->vmsd = &vmstate_designware_pcie_root;
> @@ -650,8 +547,17 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>       PCIHostState *pci = PCI_HOST_BRIDGE(dev);
>       DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    MemoryRegion *host_mem = get_system_memory();
> +    DesignwarePCIEViewport *viewport;
>       size_t i;
>   
> +    /*
> +     * Dummy values used for initial configuration of MemoryRegions
> +     * that belong to a given viewport
> +     */
> +    const hwaddr dummy_offset = 0;
> +    const uint64_t dummy_size = 4;
> +
>       for (i = 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
>           sysbus_init_irq(sbd, &s->pci.irqs[i]);
>       }
> @@ -694,6 +600,97 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>       qdev_prop_set_int32(DEVICE(&s->root), "addr", PCI_DEVFN(0, 0));
>       qdev_prop_set_bit(DEVICE(&s->root), "multifunction", false);
>       qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
> +
> +    memory_region_init_io(&s->msi.iomem, OBJECT(s),
> +                          &designware_pci_host_msi_ops,
> +                          s, "pcie-msi", 0x4);
> +    /*
> +     * We initially place MSI interrupt I/O region at address 0 and
> +     * disable it. It'll be later moved to correct offset and enabled
> +     * in designware_pcie_host_update_msi_mapping() as a part of
> +     * initialization done by guest OS
> +     */
> +    memory_region_add_subregion(&s->pci.memory, dummy_offset, &s->msi.iomem);
> +    memory_region_set_enabled(&s->msi.iomem, false);
> +
> +    for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
> +        MemoryRegion *source, *destination, *mem;
> +        const char *direction;
> +        char *name;
> +
> +        viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
> +        viewport->inbound = true;
> +        viewport->base    = 0x0000000000000000ULL;
> +        viewport->target  = 0x0000000000000000ULL;
> +        viewport->limit   = UINT32_MAX;
> +        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
> +
> +        source      = &s->pci.address_space_root;
> +        destination = host_mem;
> +        direction   = "Inbound";
> +
> +        /*
> +         * Configure MemoryRegion implementing PCI -> CPU memory
> +         * access
> +         */
> +        mem  = &viewport->mem;
> +        name = designware_pcie_viewport_name(direction, i, "MEM");
> +        memory_region_init_alias(mem, OBJECT(s), name, destination,
> +                                 dummy_offset, dummy_size);
> +        memory_region_add_subregion_overlap(source, dummy_offset, mem, -1);
> +        memory_region_set_enabled(mem, false);
> +        g_free(name);
> +
> +        viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
> +        viewport->host    = s;
> +        viewport->inbound = false;
> +        viewport->base    = 0x0000000000000000ULL;
> +        viewport->target  = 0x0000000000000000ULL;
> +        viewport->limit   = UINT32_MAX;
> +        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
> +
> +        destination = &s->pci.memory;
> +        direction   = "Outbound";
> +        source      = host_mem;
> +
> +        /*
> +         * Configure MemoryRegion implementing CPU -> PCI memory
> +         * access
> +         */
> +        mem  = &viewport->mem;
> +        name = designware_pcie_viewport_name(direction, i, "MEM");
> +        memory_region_init_alias(mem, OBJECT(s), name, destination,
> +                                 dummy_offset, dummy_size);
> +        memory_region_add_subregion(source, dummy_offset, mem);
> +        memory_region_set_enabled(mem, false);
> +        g_free(name);
> +
> +        /*
> +         * Configure MemoryRegion implementing access to configuration
> +         * space
> +         */
> +        mem  = &viewport->cfg;
> +        name = designware_pcie_viewport_name(direction, i, "CFG");
> +        memory_region_init_io(&viewport->cfg, OBJECT(s),
> +                              &designware_pci_host_conf_ops,
> +                              viewport, name, dummy_size);
> +        memory_region_add_subregion(source, dummy_offset, mem);
> +        memory_region_set_enabled(mem, false);
> +        g_free(name);
> +    }
> +
> +    /*
> +     * If no inbound iATU windows are configured, HW defaults to
> +     * letting inbound TLPs to pass in. We emulate that by explicitly
> +     * configuring first inbound window to cover all of target's
> +     * address space.
> +     *
> +     * NOTE: This will not work correctly for the case when first
> +     * configured inbound window is window 0
> +     */
> +    viewport = &s->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
> +    viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
> +    designware_pcie_update_viewport(&s->root, viewport);
>   }
>   
>   static const VMStateDescription vmstate_designware_pcie_host = {
> 

