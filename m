Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B9BCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzW7v-0004xB-DC; Fri, 19 Sep 2025 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7p-0004u5-Bl
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7m-0006iB-VO
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758269144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8Ax1LpeoXo+pqGr7SQCEef56n1v1LfibcG9zvBfKnCY=;
 b=COra79ditUVIslY8kFhNrGGFZMH6dtb9Gp6wdJ3XwNOHW6o9eBBN63xQAmpF8J2cSIIokf
 SB1h2oS9xHsDwYsFgSQFaXztpaxjB+Eb/5qnzk2wXHbc/EL7z/k86ySU++ar5+IR0sI15r
 Lk//NxTC7t2tw20j789oCWfrvJX3j7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-MwoQzC-ZN_mW_MlIeM0E9w-1; Fri, 19 Sep 2025 04:05:42 -0400
X-MC-Unique: MwoQzC-ZN_mW_MlIeM0E9w-1
X-Mimecast-MFC-AGG-ID: MwoQzC-ZN_mW_MlIeM0E9w_1758269141
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3eae0de749dso1113587f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269141; x=1758873941;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Ax1LpeoXo+pqGr7SQCEef56n1v1LfibcG9zvBfKnCY=;
 b=bGQEvPgrTUXMzLf8Xy102qFU/+LjQwCImO0O3B5VpvSUeBAWXRdHOTI76mw0UU0xoK
 +iQFm0F7UmE31X9kvECHFeELmqtLEX3Bd/Y3JvfplRqDKYHXkdDUMJ5m1cVgJxoGJ9VG
 ExvbEGcFKkuvuGV30AXbGPTsLsspQv9O2Gjw7v1N0CXrxGKm01V2RvJJssvwoAhrs1JO
 hgUlj9abkIPpAo/nq4AIoj1h7XNHhri+mSBSTWXm0KUuD2Aaqk9NmsAhyNr5gRu9EEEJ
 1tXjtQsFSrbhGSCTK+iZfONI7Kcvn76dlo4P46KAlA4I/dho+ztH7mq0xPfUdK3MXwcB
 PubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMPsat45ZcvLSCMlvA5H3O0MSX6/VPMOTscUT9oArVix5SYRXUMeaqV3/stAlxNCrnEUSkirjBHpOu@nongnu.org
X-Gm-Message-State: AOJu0Ywfdyj4LrZRADyxiBpR07xfzKC0eSCdiYzqArR4DYJ9rkEa3kSa
 pccy36U5iQn6vOGhBfN/mRezD4TWgwflCSOw3VurpGo+7DWFErfAfxp/VfY6kaRI8xOogLzznVv
 fkdQN7GdRb5/vfvqg989NR5NDnqMgAbAh8jONcq/bjpAIyE6Y93VhgqZU6VZ8PaUI
X-Gm-Gg: ASbGncvbVgTE1hjGM4Oi9dmxUcGGSHn7AQubJOti/bz8n5r2oB2XFuJ/0aBtKMuZ3Os
 WgGv/3rcMq19yzds+zJ9UpR0irB59KisB7pjuZ97PqYCMEDwDqErig5nYhNZ2CFmCFHAHte1c0X
 yhA3ztrI+YH8SbalegHSRiNsflMxdWvlESIN2dEi/CnAlkF7RRZsA2JBY7s0BirTIu8gCH1gNjf
 H3XDiyBGAkHiA2o6PZ/TeyEG77hNEEEJC4mNkqcRQNX8h8+M+qVqqgylaD2QcnvS6W51PIBZxWY
 ZlHMpOuimUJMRlPHYM2GvvocPVZMtv4uP7uR6INs9626u1a8POOi5E7oLoWljUGYL7IUFxt1uzb
 ImpI=
X-Received: by 2002:a05:6000:2f83:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3ee8481fe2amr1341828f8f.37.1758269141032; 
 Fri, 19 Sep 2025 01:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEupdX4JENZklh5Z6OManF1tgJBuTzzqwj0kFE08wMKXhCQf4BSCqQ5XvNDeugg6kDwRpoOLw==
X-Received: by 2002:a05:6000:2f83:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3ee8481fe2amr1341800f8f.37.1758269140491; 
 Fri, 19 Sep 2025 01:05:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7284sm6790274f8f.33.2025.09.19.01.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:05:39 -0700 (PDT)
Message-ID: <dcfe7e79-a63c-4d48-be3c-e3f159e74dbf@redhat.com>
Date: Fri, 19 Sep 2025 10:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 04/14] hw/pci-host/aspeed: Add AST2600 PCIe Root
 Device support
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
 <20250919032431.3316764-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Introduce a PCIe Root Device for AST2600 platform.
> 
> The AST2600 root complex exposes a PCIe root device at bus 80, devfn 0.
> This root device is implemented as a child of the PCIe RC and modeled
> as a host bridge PCI function (class_id = PCI_CLASS_BRIDGE_HOST).
> 
> Key changes:
> - Add a new device type "aspeed.pcie-root-device".
> - Instantiate the root device as part of AspeedPCIERcState.
> - Initialize it during RC realize() and attach it to the root bus.
> - Mark the root device as non-user-creatable.
> - Add RC boolean property "has-rd" to control whether the Root Device is
>    created (platforms can enable/disable it as needed).
> 
> Note: Only AST2600 implements this PCIe root device. AST2700 does not
> provide one.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/pci-host/aspeed_pcie.h | 11 ++++++
>   hw/pci-host/aspeed_pcie.c         | 56 +++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index 850d579189..fe30ac02ae 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -40,6 +40,13 @@ typedef struct AspeedPCIERegMap {
>       AspeedPCIERcRegs rc;
>   } AspeedPCIERegMap;
>   
> +#define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
> +
> +struct AspeedPCIERootDeviceState {
> +    PCIBridge parent_obj;
> +};
> +
>   #define TYPE_ASPEED_PCIE_RC "aspeed.pcie-rc"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
>   
> @@ -53,7 +60,10 @@ struct AspeedPCIERcState {
>   
>       uint32_t bus_nr;
>       char name[16];
> +    bool has_rd;
>       qemu_irq irq;
> +
> +    AspeedPCIERootDeviceState root_device;
>   };
>   
>   /* Bridge between AHB bus and PCIe RC. */
> @@ -79,6 +89,7 @@ struct AspeedPCIECfgClass {
>   
>       uint64_t rc_bus_nr;
>       uint64_t nr_regs;
> +    bool rc_has_rd;
>   };
>   
>   #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index c3e92ee449..6e563a07a3 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -25,6 +25,44 @@
>   #include "hw/pci/msi.h"
>   #include "trace.h"
>   
> +/*
> + * PCIe Root Device
> + * This device exists only on AST2600.
> + */
> +
> +static void aspeed_pcie_root_device_class_init(ObjectClass *klass,
> +                                               const void *data)
> +{
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->desc = "ASPEED PCIe Root Device";
> +    k->vendor_id = PCI_VENDOR_ID_ASPEED;
> +    k->device_id = 0x2600;
> +    k->class_id = PCI_CLASS_BRIDGE_HOST;
> +    k->subsystem_vendor_id = k->vendor_id;
> +    k->subsystem_id = k->device_id;
> +    k->revision = 0;
> +
> +    /*
> +     * PCI-facing part of the host bridge,
> +     * not usable without the host-facing part
> +     */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo aspeed_pcie_root_device_info = {
> +    .name = TYPE_ASPEED_PCIE_ROOT_DEVICE,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(AspeedPCIERootDeviceState),
> +    .class_init = aspeed_pcie_root_device_class_init,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
>   /*
>    * PCIe Root Complex (RC)
>    */
> @@ -94,6 +132,18 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>                                        aspeed_pcie_rc_map_irq, rc, &rc->mmio,
>                                        &rc->io, 0, 4, TYPE_PCIE_BUS);
>       pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +
> +    /* setup root device */
> +    if (rc->has_rd) {
> +        object_initialize_child(OBJECT(rc), "root_device", &rc->root_device,
> +                                TYPE_ASPEED_PCIE_ROOT_DEVICE);
> +        qdev_prop_set_int32(DEVICE(&rc->root_device), "addr",
> +                            PCI_DEVFN(0, 0));
> +        qdev_prop_set_bit(DEVICE(&rc->root_device), "multifunction", false);
> +        if (!qdev_realize(DEVICE(&rc->root_device), BUS(pci->bus), errp)) {
> +            return;
> +        }
> +    }
>   }
>   
>   static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
> @@ -110,6 +160,7 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
>   
>   static const Property aspeed_pcie_rc_props[] = {
>       DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
> +    DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
>   };
>   
>   static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
> @@ -401,6 +452,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
>       object_property_set_int(OBJECT(&s->rc), "bus-nr",
>                               apc->rc_bus_nr,
>                               &error_abort);
> +    object_property_set_bool(OBJECT(&s->rc), "has-rd",
> +                            apc->rc_has_rd,
> +                            &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
>           return;
>       }
> @@ -433,6 +487,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
>       apc->reg_map = &aspeed_regmap;
>       apc->nr_regs = 0x100 >> 2;
>       apc->rc_bus_nr = 0x80;
> +    apc->rc_has_rd = true;
>   }
>   
>   static const TypeInfo aspeed_pcie_cfg_info = {
> @@ -570,6 +625,7 @@ static const TypeInfo aspeed_pcie_phy_info = {
>   static void aspeed_pcie_register_types(void)
>   {
>       type_register_static(&aspeed_pcie_rc_info);
> +    type_register_static(&aspeed_pcie_root_device_info);
>       type_register_static(&aspeed_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>   }


