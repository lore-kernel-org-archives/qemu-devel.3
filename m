Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6CBCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvyU-000353-Aj; Mon, 20 Oct 2025 15:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvyQ-000345-Nu
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:55:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvyO-0000XT-7d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:55:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so37697465e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760990114; x=1761594914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OU4CICU0NUh6ewxIQgxcqxa3YurCrksic1Q10ihqsVw=;
 b=tz87zqK0Bd04O7gStUejhHVfIVeKTvZKuKsqmv3vqQpL9Ilz/BnMPyUE/GVKObGNC2
 AkJ/WqniJNOlcKBHk2xedDeZkykHBk0sCHRkBazhuLcs9IBXOJWL7HXF6AdrjY+t48U1
 +9c852sUrCx5p+pJNxxesV/Hejvji0WBQbBdZFKfCzMAEwkCYcLNF9T0GbXGp4mBeMip
 Qs7E8UNXCUcRx6wNOFvr+QR5khiua08cQfL7f+kmwAA1l6i2aEi7KYuHLXtUw3F8pMCw
 Yl0Z+qoSgtjMqvB36+ZdoLLlP47czoD2uR10Ps35NecD9alaTuOtw0uK6wu8hkuxWaXV
 YchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760990114; x=1761594914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OU4CICU0NUh6ewxIQgxcqxa3YurCrksic1Q10ihqsVw=;
 b=acq5tJD0w04X3yAb27e7f5nX1FpJZ2HWXzgp8Nzm474wXY/gIOgwmw2TPv6BXunrzm
 /cSqijQcXplGYp9l4vwWwbt8uCJ9DLLg/1nF2efo2zuQ2JOmuQX/Rp+rzQvA0To24X01
 y05N7GKC6SP3vhdfUjBDWudHQO67MEjIbJHpFaN6BtHnRHoWvnuvn21HjYzIyhx61t/s
 Ry0qZYyuoOsopW6R8yVQ/RxGJuVSWA7nvealpXbQQ4bxI4R/7skb4Nbjpsekse5o9zxH
 27lHqea6O+edYjdOGz/pxzDTJOQJ+f1JUkQl3lQAddjAaXIWYlDj4gmJxSYDSwUsp+02
 8MsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhWjQ5oFRFYSi8iJ9Qtu83UNVfRibqb3+WOajZTCdASILvWXrE42i0PVUy5n8ZgTG/RsSC9DuRUu5u@nongnu.org
X-Gm-Message-State: AOJu0Yw7v2p+Fh09kkO9lmFJIWwZxwKyl+cOb/fIK4pV/eiTDIQ8gn1X
 UWIZQIsYbtesQlx1xRy2iXFJsslQq9msDBQyNvPLhSUWmjq7IbD3gbfkrztkiRNlzGg=
X-Gm-Gg: ASbGncsh3yQbtY3ADVOSNEXBrLoY2N90Q9zUC76cAt9dL5uQBkGe0k3lRWXBFkhOXBI
 NFIKhAGcrh3Gy/vcIFzYs5/bzzOEXDHg5kCaGWHBdnsnA5p5ZPuOZueRRk4JcQgn14HdFIuJhKG
 1LO0k/I99GuchcY+4mN28fjIKO7EVDYcfNCKvspBxv25TC3g+J2Uv+vzRDYAMoMH8S+X/nP+RU6
 K/5byzGV2Njo1a6zf2LuZ5K6SrJaKl4E/XyVg4Af97gkoIyRCqD47F9a6z0ePaMVgWr+riF2LxU
 1hEPLXILtxyT4fewVey/hJwvKDXJXljY+C+lFq4M5+Yzt3yr4UWKjNnFDJUHBBQCYekA+219KI+
 OyucKcymvnriEWwJNxIZDDRCPe58t5MiIZI/fe//iuSoCerkmsKTbVfzJUAHPdCJj4lbR7j21Bk
 wWwwFozKj/kRzCT10pJ0hpfuihheZW14nwBel0/MudWyPyar37R2TpyCCSL+skPIC8
X-Google-Smtp-Source: AGHT+IEEmRMF74M3A5uiHoQTzdKg6oddrhvfMYxgwqCUyM22MJjhhlNB02Gu1ViTj5oo6SETORwKdA==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-47117931edcmr105820565e9.40.1760990113869; 
 Mon, 20 Oct 2025 12:55:13 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d477d2sm664485e9.13.2025.10.20.12.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:55:13 -0700 (PDT)
Message-ID: <56bb063e-696c-49fb-943a-7ef9f28c4826@linaro.org>
Date: Mon, 20 Oct 2025 21:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] hw/pci-host/raven: Simplify PCI facing part
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <9f0e1a8860f6a8f00c15e212ba5c46ae6a7fe39a.1760795082.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9f0e1a8860f6a8f00c15e212ba5c46ae6a7fe39a.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/10/25 16:04, BALATON Zoltan wrote:
> The raven PCI device does not need a state struct as it has no data to
> store there any more, so we can remove that to simplify code.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 30 +-----------------------------
>   1 file changed, 1 insertion(+), 29 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index f8c0be5d21..172f01694c 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -31,7 +31,6 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "hw/or-irq.h"
> @@ -40,12 +39,6 @@
>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
> -
> -struct RavenPCIState {
> -    PCIDevice dev;
> -};
> -
>   typedef struct PRePPCIState PREPPCIState;
>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
> @@ -65,7 +58,6 @@ struct PRePPCIState {
>       MemoryRegion bm_ram_alias;
>       MemoryRegion bm_pci_memory_alias;
>       AddressSpace bm_as;
> -    RavenPCIState pci_dev;
>   
>       int contiguous_map;
>   };
> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-intack", 1);
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
> -    /* TODO Remove once realize propagates to child devices. */
> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
>   }
>   
>   static void raven_pcihost_initfn(Object *obj)
> @@ -277,7 +268,6 @@ static void raven_pcihost_initfn(Object *obj)
>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>       MemoryRegion *address_space_mem = get_system_memory();
> -    DeviceState *pci_dev;
>   
>       memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>       memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
> @@ -314,12 +304,6 @@ static void raven_pcihost_initfn(Object *obj)
>       pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
>   
>       h->bus = &s->pci_bus;
> -
> -    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
> -    pci_dev = DEVICE(&s->pci_dev);
> -    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
> -                            NULL);
> -    qdev_prop_set_bit(pci_dev, "multifunction", false);
>   }
>   
>   static void raven_realize(PCIDevice *d, Error **errp)
> @@ -329,16 +313,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
>       d->config[PCI_CAPABILITY_LIST] = 0x00;
>   }
>   
> -static const VMStateDescription vmstate_raven = {
> -    .name = "raven",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, RavenPCIState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>   static void raven_class_init(ObjectClass *klass, const void *data)
>   {
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> @@ -350,7 +324,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
>       k->revision = 0x00;
>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>       dc->desc = "PReP Host Bridge - Motorola Raven";
> -    dc->vmsd = &vmstate_raven;
>       /*
>        * Reason: PCI-facing part of the host bridge, not usable without
>        * the host-facing part, which can't be device_add'ed, yet.
> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo raven_info = {
>       .name = TYPE_RAVEN_PCI_DEVICE,
>       .parent = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(RavenPCIState),
>       .class_init = raven_class_init,
>       .interfaces = (const InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },

I'd rather this patch split in 2: remove vmstate, mentioning this breaks
migration, then use pci_create_simple().

