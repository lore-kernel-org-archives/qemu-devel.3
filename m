Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6C1CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHsl-0002in-T8; Tue, 04 Nov 2025 09:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vGHsj-0002fN-VZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:19:34 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1vGHsi-0005hq-5U
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:19:33 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c53908e8b5so3278410a34.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762265970; x=1762870770; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ikCHD3Tg1zx5QGXUH3vch8LsyelkzwIcQsX+rDl8vs=;
 b=BzX09ihAqxCBsvNZx9G8Eb2Nog1nsY0X5g1WFKrGyZH3hO/QGQA90diTYXgzLf607T
 W5Yenck5a5IAI2VtfOOuqHeP+4BAcdPlVoeuPZ7/gPXPd8A2Op4LC+HOMMHHyk/47BQe
 QLSETh7twsANg1Wln9GrOSDt6rFLJkSUB0DRnNQd762B1MY4kvIiouwmDGMCaEystz78
 U03mhWA5JZ1o4ahUhvY4TdcV4exJzc/Vu30uEEdNPThtYfj4RxdGr2MEkVoca3ax+uEf
 eZIyM4nHH35cj1gLcKYiFGxDNk3ZQ6Cj5gd+aTPcwp2rlhKCbx0MN6XCzIkb1H32+EnD
 KQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762265970; x=1762870770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ikCHD3Tg1zx5QGXUH3vch8LsyelkzwIcQsX+rDl8vs=;
 b=ZKFSbysK80IXAktepkN85yOdi8u9SCuDUbsw/0hJtXnUprVv/MG+iVT5X+Lv9Rsssw
 jN8WMXF/sU/Xdg8x7kJZrIefh6Ue6/WlUWRsnKpQo5SOySQ/jG8t+ijw8mPLSfkJGyNC
 JaQDrHpKcMCDYnToK0dz0Lgi2cKJ5iWHzQdAb9QucYW6R5Vjf42b5/ucQA5kyHqnLJXQ
 GFX0UpSIFko5LxZGgFuX1Q2iB5PZkDxnMroVhsXRRgxp9aCZyJWuPjGYBP7jeAGnCu0q
 e1L7K6Z0Q5HmkA3yU25+GASHWP7p3gL78+wthwTG8TpVHhw5uRLHSUlci4yTprl7cJgL
 u+fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUe2fUCHtAlHbgvvelUQDoNN8kGV0CxNB6Ah9/as+4YkGr8B/vTGA5AcwxKLWFGnHeeiTGXF0E/C2g@nongnu.org
X-Gm-Message-State: AOJu0Yw+IGJ/ZWlVdDrqG9S2IEoDbsMmPUKz8N6PoumnQ0TPP6S77viz
 Xt2kZfbwsIkXHccUtv8Kd+fLEX2B85Y4m4DHN/reKf2dK7on3ZOJb6GO7RxDgmAgP24=
X-Gm-Gg: ASbGncsrAtodrKy++Sj5xU/rc2uyJRX/OoMA+0XB3sCx0CbXW/q1ZembZUHs17HHohu
 Y0kqQ9eZxt6+KBab0i3SzqPcupD8Vr7KWlrXBG7wQdF8CpmO8c9LYQM4MrzOpMJp+eOeOqruN+6
 hnR6PsFePaTP9e3CqKSmjAKJyToA0qJPpHSOvVmdUi/PJz6+20unRvXeKXd/s997gs1cl/HSMFg
 OJmLnhFDA4XY30CExsuwoBDeCB0rHZH7DrVJ4L7QaMntwp/RA1j5BWbq/RkjJAHXs4F7h4V1Wfl
 yQ9auoC7mDthgIh9lJiGIb8PdAzPo+fYGUnJxL1bIfwqiCVKs7T6sG+e3xm/3qquIPDoXtxVwbf
 Stc/oUwIY+tl3X3gs7NbWx04ZV0XxpqLky9/mIzoJQ9Hk7ID/CIP/tvNXrLGvUTL/wg3z4sy9/i
 cejA==
X-Google-Smtp-Source: AGHT+IFNlJESBqpqlXHlNZDbbp6q+9ga5s5K5T+a1Vuk4uN0MMNzFhrQlh3Depb4pjW8FW37W3yDbQ==
X-Received: by 2002:a05:6808:1b0d:b0:43f:2cb1:aff2 with SMTP id
 5614622812f47-44f95e5e308mr7174011b6e.16.1762265970209; 
 Tue, 04 Nov 2025 06:19:30 -0800 (PST)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd849533fsm758712b6e.3.2025.11.04.06.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 06:19:29 -0800 (PST)
Date: Tue, 4 Nov 2025 08:19:28 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [RFC v1 1/1] hw/riscv/server_platform_ref.c: add virtio bus
Message-ID: <20251104-7b7ec269da2412cc24e99234@orel>
References: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
 <38a180e7ed4014ba7d401dc9b8de755fadf33bea.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
 <4e825697-e57c-4f77-8920-9f18b787e425@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e825697-e57c-4f77-8920-9f18b787e425@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=ajones@ventanamicro.com; helo=mail-ot1-x331.google.com
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

On Tue, Nov 04, 2025 at 09:55:40AM -0300, Daniel Henrique Barboza wrote:
> CCing Drew since he's the TG chair for this spec
> 
> On 11/3/25 9:39 AM, Chao Liu wrote:
> > Add an always present virtio bus for the rvsp-ref board.
> > 
> > The IRQs being used are similar to what the 'virt' board is using: IRQs
> > 40 to 47, one IRQ for queue.
> > 
> > Signed-off-by: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
> > ---
> >   hw/riscv/server_platform_ref.c | 42 ++++++++++++++++++++++++++++++++--
> >   1 file changed, 40 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> > index 975f07ddfb..24c3fc2e41 100644
> > --- a/hw/riscv/server_platform_ref.c
> > +++ b/hw/riscv/server_platform_ref.c
> > @@ -46,6 +46,7 @@
> >   #include "target/riscv/cpu.h"
> >   #include "target/riscv/pmu.h"
> >   #include "net/net.h"
> > +#include "hw/virtio/virtio-mmio.h"
> >   #define RVSP_CPUS_MAX_BITS             9
> >   #define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
> > @@ -108,16 +109,20 @@ enum {
> >       RVSP_PCIE_MMIO,
> >       RVSP_PCIE_PIO,
> >       RVSP_PCIE_ECAM,
> > -    RVSP_PCIE_MMIO_HIGH
> > +    RVSP_PCIE_MMIO_HIGH,
> > +    RVSP_VIRTIO
> >   };
> >   enum {
> >       RVSP_UART0_IRQ = 10,
> >       RVSP_RTC_IRQ = 11,
> >       RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
> > -    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
> > +    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
> > +    RVSP_VIRTIO_IRQ = 0x28 /* 40 to 47 */
> >   };
> > +#define RVSP_VIRTIO_COUNT 8
> > +
> >   /*
> >    * The server soc reference machine physical address space used by some of the
> >    * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
> > @@ -151,6 +156,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
> >       [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> >       [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> >       [RVSP_UART0] =          { 0x10000000,         0x100 },
> > +    [RVSP_VIRTIO] =         { 0x10001000,        0x1000 },
> >       [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
> >       [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
> >       [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
> > @@ -816,6 +822,29 @@ static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *memmap)
> >       qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> >   }
> > +static void create_fdt_virtio(RVSPMachineState *s, uint32_t irq_virtio_phandle)
> > +{
> > +    int i;
> > +    MachineState *ms = MACHINE(s);
> > +    hwaddr virtio_base = rvsp_ref_memmap[RVSP_VIRTIO].base;
> > +
> > +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
> > +        g_autofree char *name = NULL;
> > +        uint64_t size = rvsp_ref_memmap[RVSP_VIRTIO].size;
> > +        hwaddr addr = virtio_base + i * size;
> > +
> > +        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
> > +
> > +        qemu_fdt_add_subnode(ms->fdt, name);
> > +        qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
> > +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
> > +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> > +            irq_virtio_phandle);
> > +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> > +                            RVSP_VIRTIO_IRQ + i, 0x4);
> > +    }
> > +}
> > +
> >   static void finalize_fdt(RVSPMachineState *s)
> >   {
> >       uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> > @@ -835,6 +864,8 @@ static void finalize_fdt(RVSPMachineState *s)
> >       create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
> >       create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);
> > +
> > +    create_fdt_virtio(s, irq_mmio_phandle);
> >   }
> >   static void create_fdt(RVSPMachineState *s, const MemMapEntry *memmap)
> > @@ -1205,6 +1236,13 @@ static void rvsp_ref_machine_init(MachineState *machine)
> >           }
> >       }
> > +    /* VirtIO MMIO devices */
> > +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
> > +        sysbus_create_simple("virtio-mmio",
> > +            memmap[RVSP_VIRTIO].base + i * memmap[RVSP_VIRTIO].size,
> > +            qdev_get_gpio_in(mmio_irqchip, RVSP_VIRTIO_IRQ + i));
> > +    }
> > +
> 
> When you said virtio support I thought about virtio-pci and virtio-net-pci. I'm not sure if
> we need a virtio-mmio for that.
> 
> Also, I can't say if adding a device like virtio-mmio might conflict with something else from
> the server plat specification. Drew, care to comment?

I'd rather we don't add virtio-mmio to the reference platform. In
hindsight, I guess the only reason virtio was brought up was for
virtio-mmio, since virtio-pci devices could already have been used.
So I apologize for misleading by saying adding virtio support was
fine.

Let's discuss the motivation. Which virtio devices were intended to
be added to these virtio-mmio transports?

Thanks,
drew

