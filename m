Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF9CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzW8C-00058f-PT; Fri, 19 Sep 2025 04:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW89-00056I-Bb
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW87-0006ze-7J
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758269166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dstga8pnvd10QnYFSJMTWUIwELxiahrLrZw8FqyVVtU=;
 b=Vo5fFwSAxarm6v1zr5+y6p9BGrI9VZ5GSY31fNL6INqwbx5X036726p3bMtvhle6zY2Gzb
 sJIVnPOSGvSezdhzo2fUdlsZx6d3PkFo/sp0/dwEz8G3+pxC9w1cHTf9eaAtP8Rkgf0S4Y
 Udd0vpv9gQxq+kiq6WhqUs+g+CqCLdk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-PZVF3B5QMTC72GReTF8lMQ-1; Fri, 19 Sep 2025 04:05:58 -0400
X-MC-Unique: PZVF3B5QMTC72GReTF8lMQ-1
X-Mimecast-MFC-AGG-ID: PZVF3B5QMTC72GReTF8lMQ_1758269157
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2f15003aso11472095e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269156; x=1758873956;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dstga8pnvd10QnYFSJMTWUIwELxiahrLrZw8FqyVVtU=;
 b=ARWgN7vfw+xhWMuuoo14d5ACCjXWoYitG2ojHtB546HTgvVSenabdIdVxl+N5DCFyQ
 ovTZvOJLJiqCBPeiBeagA3OjDAt8L1WFMtEDmT28driU+Kb8Cug7wTnwbfqT2YYfzx3u
 KrE3Ngu4RRKn8x6JU4RlBMYnmwRRFZ/AeBQreo1N7nI8V2aXmMUk0QYMqGZIgEK1Lgjf
 77yxbGUdiCOTd3WM2kbdMOwzb9upJIZYET3PjPG/zX7YDv2xtJS7ztVWnknIiZMFaLil
 2UWylTExqsBL5NsJRkKaKvkLoA5rtNUezs6JWqbHVmgIRyG4+U4dwNvMUOXNMmQSGOLk
 pvDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcaFclSb1rITSQku2RhL2zFUIn5OyvUmV6JXyadYLNE6YsGc+fqCp6XApcFBAvgM2MK3crUKEw9Sr2@nongnu.org
X-Gm-Message-State: AOJu0Yyga30vSpi1Bjps6HBl/OGVrulDP+ykugDCk3GXupMuwsR2Yjxb
 WYgesP630gmjhUws4i0xotqnIwdTR3cs4Ke26kJIIKZlymF4UHM/Ja1VmzA6NHvp8CTjo8ztPgY
 A3bxLbU8bk3YibfGdEiYLATOBqGOAsVgx4ga0GO8NzaWqGgHOpG6C8DrwrOCBoLnS
X-Gm-Gg: ASbGncscFQhZJ5Fg28jrZAb7V/4XAgpAqRabForuC2/A2HC+dI6+Hxdx8xBKtsV6xoZ
 5DRlzk1BwzkQ8cQflcR+QYRrOnlBuILKH7RYCMZL2K8aW4bDuQl5YSQpoDgPyY5rZcwU7gRCM1V
 G38sY2kI/LOFUL7RiP1HY5SBENgwyKKAnxe86nq+hT6qUeKfZa3qzCczb9u4MkWUPjYo9QGPzF9
 OJqm6BQ1ja05qrq95kiCgCQbOfqKw+APPykuQ9RPQKIRFpi+GgtBdKanobQ0lYWUcffhHWshQHf
 8hrk9Q31K4Qv3ktzRr4Wvki+BMKH4XSlGQJWOxwFTNXWFlqvlQ84BjAjBD01MPg3Z47OMGwVwQQ
 Ph/E=
X-Received: by 2002:a05:6000:2f83:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3ee8481fe2amr1342478f8f.37.1758269156270; 
 Fri, 19 Sep 2025 01:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdX/VFUFW7Xrpi5NTzgCXtSiyKsCkG1EPem9THd8GStWhx73kif0M6QsD3A7dcS5oQi+ayHQ==
X-Received: by 2002:a05:6000:2f83:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3ee8481fe2amr1342463f8f.37.1758269155794; 
 Fri, 19 Sep 2025 01:05:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7284sm6790274f8f.33.2025.09.19.01.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:05:55 -0700 (PDT)
Message-ID: <0f9020d4-9209-433b-9228-63747172f0f5@redhat.com>
Date: Fri, 19 Sep 2025 10:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 05/14] hw/pci-host/aspeed: Add AST2600 PCIe Root
 Port and make address configurable
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
 <20250919032431.3316764-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/19/25 05:24, Jamin Lin wrote:
> Introduce an ASPEED PCIe Root Port and wire it under the RC. The root port
> is modeled as TYPE_ASPEED_PCIE_ROOT_PORT (subclass of TYPE_PCIE_ROOT_PORT).
> 
> Key changes:
> - Add TYPE_ASPEED_PCIE_ROOT_PORT (PCIESlot-based) with vendor/device IDs
>    and AER capability offset.
> - Extend AspeedPCIERcState to embed a root_port instance and a
>    configurable rp_addr.
> - Add "rp-addr" property to the RC to place the root port at a specific
>    devfn on the root bus.
> - Set the root port's "chassis" property to ensure a unique chassis per RC.
> - Extend AspeedPCIECfgClass with rc_rp_addr defaulting to PCI_DEVFN(8,0).
> 
> Rationale:
> - AST2600 places the root port at 80:08.0 (bus 0x80, dev 8, fn 0).
> - AST2700 must place the root port at 00:00.0, and it supports three RCs.
>    Each root port must therefore be uniquely identifiable; uses the
>    PCIe "chassis" ID for that.
> - Providing a configurable "rp-addr" lets platforms select the correct
>    devfn per SoC family, while the "chassis" property ensures uniqueness
>    across multiple RC instances on AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/aspeed_pcie.h | 11 +++++++
>   hw/pci-host/aspeed_pcie.c         | 50 +++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index fe30ac02ae..5346c15c81 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -20,6 +20,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pcie_host.h"
> +#include "hw/pci/pcie_port.h"
>   #include "qom/object.h"
>   
>   typedef struct AspeedPCIECfgTxDesc {
> @@ -40,6 +41,13 @@ typedef struct AspeedPCIERegMap {
>       AspeedPCIERcRegs rc;
>   } AspeedPCIERegMap;
>   
> +#define TYPE_ASPEED_PCIE_ROOT_PORT "aspeed.pcie-root-port"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootPortState, ASPEED_PCIE_ROOT_PORT)
> +
> +typedef struct AspeedPCIERootPortState {
> +    PCIESlot parent_obj;
> +} AspeedPCIERootPortState;
> +
>   #define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
>   
> @@ -58,12 +66,14 @@ struct AspeedPCIERcState {
>       MemoryRegion mmio;
>       MemoryRegion io;
>   
> +    uint32_t rp_addr;
>       uint32_t bus_nr;
>       char name[16];
>       bool has_rd;
>       qemu_irq irq;
>   
>       AspeedPCIERootDeviceState root_device;
> +    AspeedPCIERootPortState root_port;
>   };
>   
>   /* Bridge between AHB bus and PCIe RC. */
> @@ -87,6 +97,7 @@ struct AspeedPCIECfgClass {
>       const AspeedPCIERegMap *reg_map;
>       const MemoryRegionOps *reg_ops;
>   
> +    uint32_t rc_rp_addr;
>       uint64_t rc_bus_nr;
>       uint64_t nr_regs;
>       bool rc_has_rd;
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index 6e563a07a3..dafffbde61 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -21,6 +21,7 @@
>   #include "hw/registerfields.h"
>   #include "hw/irq.h"
>   #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
>   #include "hw/pci-host/aspeed_pcie.h"
>   #include "hw/pci/msi.h"
>   #include "trace.h"
> @@ -63,6 +64,32 @@ static const TypeInfo aspeed_pcie_root_device_info = {
>       },
>   };
>   
> +/*
> + * PCIe Root Port
> + */
> +
> +static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
> +                                             const void *data)
> +{
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
> +
> +    dc->desc = "ASPEED PCIe Root Port";
> +    k->vendor_id = PCI_VENDOR_ID_ASPEED;
> +    k->device_id = 0x1150;
> +    dc->user_creatable = true;
> +
> +    rpc->aer_offset = 0x100;
> +}
> +
> +static const TypeInfo aspeed_pcie_root_port_info = {
> +    .name = TYPE_ASPEED_PCIE_ROOT_PORT,
> +    .parent = TYPE_PCIE_ROOT_PORT,
> +    .instance_size = sizeof(AspeedPCIERootPortState),
> +    .class_init = aspeed_pcie_root_port_class_init,
> +};
> +
>   /*
>    * PCIe Root Complex (RC)
>    */
> @@ -144,6 +171,13 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>       }
> +
> +    /* setup root port */
> +    qdev_prop_set_int32(DEVICE(&rc->root_port), "addr", rc->rp_addr);
> +    qdev_prop_set_uint16(DEVICE(&rc->root_port), "chassis", cfg->id);
> +    if (!qdev_realize(DEVICE(&rc->root_port), BUS(pci->bus), errp)) {
> +        return;
> +    }
>   }
>   
>   static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
> @@ -158,9 +192,19 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
>       return rc->name;
>   }
>   
> +static void aspeed_pcie_rc_instance_init(Object *obj)
> +{
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(obj);
> +    AspeedPCIERootPortState *root_port = &rc->root_port;
> +
> +    object_initialize_child(obj, "root_port", root_port,
> +                            TYPE_ASPEED_PCIE_ROOT_PORT);
> +}
> +
>   static const Property aspeed_pcie_rc_props[] = {
>       DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
>       DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
> +    DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
>   };
>   
>   static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
> @@ -183,6 +227,7 @@ static const TypeInfo aspeed_pcie_rc_info = {
>       .name = TYPE_ASPEED_PCIE_RC,
>       .parent = TYPE_PCIE_HOST_BRIDGE,
>       .instance_size = sizeof(AspeedPCIERcState),
> +    .instance_init = aspeed_pcie_rc_instance_init,
>       .class_init = aspeed_pcie_rc_class_init,
>   };
>   
> @@ -455,6 +500,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
>       object_property_set_bool(OBJECT(&s->rc), "has-rd",
>                               apc->rc_has_rd,
>                               &error_abort);
> +    object_property_set_int(OBJECT(&s->rc), "rp-addr",
> +                            apc->rc_rp_addr,
> +                            &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
>           return;
>       }
> @@ -488,6 +536,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
>       apc->nr_regs = 0x100 >> 2;
>       apc->rc_bus_nr = 0x80;
>       apc->rc_has_rd = true;
> +    apc->rc_rp_addr = PCI_DEVFN(8, 0);
>   }
>   
>   static const TypeInfo aspeed_pcie_cfg_info = {
> @@ -626,6 +675,7 @@ static void aspeed_pcie_register_types(void)
>   {
>       type_register_static(&aspeed_pcie_rc_info);
>       type_register_static(&aspeed_pcie_root_device_info);
> +    type_register_static(&aspeed_pcie_root_port_info);
>       type_register_static(&aspeed_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>   }


