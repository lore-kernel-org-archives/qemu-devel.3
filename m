Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E5CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqiq-0004La-Cg; Wed, 17 Sep 2025 07:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uyqgD-0000ac-PO
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:50:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1uyqg9-0003Q8-Go
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:50:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso6056252b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758109827; x=1758714627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpwhE7jRg4coWjaMPA08iD2QiyKjWjx/VaPdq69/beU=;
 b=Vs72eNGKGMGDA6om5FdMXxHE+H5k/pO7j08N8kv7mbR8ChOdUcE+SaI9znheYvT/9w
 BcUElSeWgMRuEx+49QYb66JSGCOpbsKkEr8V4uD7iyHnUez1FQC3i0F79Uik5qmo8DC4
 ZA48Y3Zoqp0MZceDOU+cE1pDn5EAGi1cECEGLrdBNoMlF6wyxiSlkWKNXyAp3K4a2jVs
 MGTO7GEPDeh3VLzy3g1vv3P+RSK8mSq//W+fCFNGIR8xBRZZEw3yQICFNssoKgE6qx5X
 2nsGqkffjwNLY4H1+sUhCuOZ9IlmwpSMcdqP41lRYomK8c075YJ3sNo3d3Hv/WZ8Sf8G
 CXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758109827; x=1758714627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpwhE7jRg4coWjaMPA08iD2QiyKjWjx/VaPdq69/beU=;
 b=LeqoJ2ZQ8UmqnlobAKLPKOxK3qPZMCncBdxITKtaaBv/8xKutTEywKnEtpBDEhIfcH
 gw+Im2l50UiQNfoD3987sGn0MFtE9CEK0QjD0TbduvmtTYrggbRdppd2IMxOESzTh9yn
 plG2cLKOsx80faadVuQtxqMxds8MzbUfja6q4qQnDHB/YL+hIMhVOhZjd6kSsTnRTwEu
 jG+9g2BWJC80syp0TTBhrDYaEQyWXRH8Wz7pKBVNwA488h1OFIV7XKUHO41oRYjAb7aB
 msN2I0YGzZoJ0ydJ/Hqq1XuOMz77Hf05Ga2t98kzS1kmne32nXtzj+Ud38coMZc0RsSM
 Q5fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJuTDS4l0yolbclPLLhzy8un2R17nIIaZFavCGasnSDQ/r0C6p/H/cndEkznYxEpHtndtgCCOZNyp0@nongnu.org
X-Gm-Message-State: AOJu0YxWVDnanTFFZzmHIptm+8KVh3EiIleF184QqLOhr+dSxcldIyzT
 GELoFrXRdJAvEOs6vrPF2llGqvPq8Xg+/KwK2cZxiu7lyfd+C45w3ody
X-Gm-Gg: ASbGncvNxmIynYmqzDq30abTF7XgKGg32r5UWqUGjD6hp+vwy/eQRocxKDBASZ7i2mm
 rOsgqtZFomXJ/XzWA4ePlOQ8bKGVQ1yCWcwKdPi6k/2ZIlrK0Lv1ouSYhoAb7NBciQdbTeVqUfq
 kxio5gYtX790AVd0yeXiidPcDN1rhe6j5Nh3GFEB2eQ3XwUP3gKnVxKijaxTA7yK/8PKbto8MFe
 fvKN5UX8+jo3ftHoGxl83aKgpIOwOWdhbJxiINDD84BBmp9Hzs9doBFF8vQqIBaD56kN4roW8u1
 LhCy4yXLmIqTiqkiHIbjtamduYQ7ZOdp9L+bvNFUdaTi4av7qk6BTYSfzjLSLKkxe05ueT7pT0w
 1PJQ4c5gbiF76YpcdniwdIIGUkyZjnVUgSPIwdxdCWPpyCfkFMT3+F2VA8IG2bwOkUBGfpXQ=
X-Google-Smtp-Source: AGHT+IFYW8r1fAY8ZdKCCFr1+fwJ8EQXqehkAOtK5t9H4R8PqSJ4CGJYFKUnNCdsIBONL50v3rTz1w==
X-Received: by 2002:a05:6a21:999e:b0:252:2bfe:b65d with SMTP id
 adf61e73a8af0-27a9119477emr2763901637.2.1758109827231; 
 Wed, 17 Sep 2025 04:50:27 -0700 (PDT)
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp. [133.11.54.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54d4a62a00sm6984361a12.41.2025.09.17.04.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:50:26 -0700 (PDT)
Message-ID: <a2f70717-0c5f-43d9-9dee-0a0a9f03b71c@gmail.com>
Date: Wed, 17 Sep 2025 20:50:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] hw/ppc/prep: Fix non-contiguous IO control bit
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1751493467.git.balaton@eik.bme.hu>
 <ba88969cb3363972a1ad44959f863a4d6510e048.1751493467.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <ba88969cb3363972a1ad44959f863a4d6510e048.1751493467.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/07/03 7:09, BALATON Zoltan wrote:
> The bit that is supposed to control if ISA IO ports are accessed with
> discontiguous addresses was not connected so it did nothing. We can
> now directly enable or disable the discontiguous region so allow the
> bit to function. This did not cause a problem so far as nothing seems
> to use this bit or discontiguous IO addresses.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c    |  9 ---------
>   hw/ppc/prep.c          |  3 +++
>   hw/ppc/prep_systemio.c | 14 ++++++++------
>   3 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 0c4eca04bb..fd45acb7eb 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -161,13 +161,6 @@ static const PCIIOMMUOps raven_iommu_ops = {
>       .get_address_space = raven_pcihost_set_iommu,
>   };
>   
> -static void raven_change_gpio(void *opaque, int n, int level)
> -{
> -    PREPPCIState *s = opaque;
> -
> -    memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
> -}
> -
>   static void raven_pcihost_realize(DeviceState *d, Error **errp)
>   {
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
> @@ -176,8 +169,6 @@ static void raven_pcihost_realize(DeviceState *d, Error **errp)
>       Object *o = OBJECT(d);
>       MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
>   
> -    qdev_init_gpio_in(d, raven_change_gpio, 1);
> -
>       memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
>       memory_region_init_io(&s->pci_discontiguous_io, o,
>                             &raven_io_ops, &s->pci_io,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 23d0e1eeaa..678682fdd2 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -358,6 +358,9 @@ static void ibm_40p_init(MachineState *machine)
>           dev = DEVICE(isa_dev);
>           qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
>           qdev_prop_set_uint32(dev, "equipment", 0xc0);
> +        object_property_set_link(OBJECT(dev), "discontiguous-io",
> +                                 OBJECT(sysbus_mmio_get_region(pcihost, 1)),
> +                                 &error_fatal);
>           isa_realize_and_unref(isa_dev, isa_bus, &error_fatal);
>   
>           dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index 41cd923b94..fe767cc4ac 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -44,9 +44,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(PrepSystemIoState, PREP_SYSTEMIO)
>   
>   struct PrepSystemIoState {
>       ISADevice parent_obj;
> +
>       MemoryRegion ppc_parity_mem;
> +    MemoryRegion *discontiguous_io;
>   
> -    qemu_irq non_contiguous_io_map_irq;
>       uint8_t sreset; /* 0x0092 */
>       uint8_t equipment; /* 0x080c */
>       uint8_t system_control; /* 0x081c */
> @@ -206,8 +207,8 @@ static void prep_port0850_write(void *opaque, uint32_t addr, uint32_t val)
>       PrepSystemIoState *s = opaque;
>   
>       trace_prep_systemio_write(addr, val);
> -    qemu_set_irq(s->non_contiguous_io_map_irq,
> -                 val & PORT0850_IOMAP_NONCONTIGUOUS);
> +    memory_region_set_enabled(s->discontiguous_io,
> +                              !(val & PORT0850_IOMAP_NONCONTIGUOUS));
>       s->iomap_type = val & PORT0850_IOMAP_NONCONTIGUOUS;
>   }
>   
> @@ -257,10 +258,9 @@ static void prep_systemio_realize(DeviceState *dev, Error **errp)
>       PrepSystemIoState *s = PREP_SYSTEMIO(dev);
>       PowerPCCPU *cpu;
>   
> -    qdev_init_gpio_out(dev, &s->non_contiguous_io_map_irq, 1);
>       s->iomap_type = PORT0850_IOMAP_NONCONTIGUOUS;
> -    qemu_set_irq(s->non_contiguous_io_map_irq,
> -                 s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS);
> +    memory_region_set_enabled(s->discontiguous_io,
> +                              !(s->iomap_type & PORT0850_IOMAP_NONCONTIGUOUS));

I got an error when running device-crash-test:
https://gitlab.com/akihiko.odaki/qemu/-/jobs/11385415195

Apparently it is necessary to check if s->discontiguous_io is set.

>       cpu = POWERPC_CPU(first_cpu);
>       s->softreset_irq = qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_HRESET);
>   
> @@ -288,6 +288,8 @@ static const VMStateDescription vmstate_prep_systemio = {
>   static const Property prep_systemio_properties[] = {
>       DEFINE_PROP_UINT8("ibm-planar-id", PrepSystemIoState, ibm_planar_id, 0),
>       DEFINE_PROP_UINT8("equipment", PrepSystemIoState, equipment, 0),
> +    DEFINE_PROP_LINK("discontiguous-io", PrepSystemIoState, discontiguous_io,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>   };
>   
>   static void prep_systemio_class_initfn(ObjectClass *klass, const void *data)


