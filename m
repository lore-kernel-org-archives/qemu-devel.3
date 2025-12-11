Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB53D41D4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThqF-0000QL-DN; Thu, 11 Dec 2025 09:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vThqD-0000Pz-2z
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vThqA-0002qH-S8
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765464021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yk0EbJh7giZ+Zn3ZlE7ZS6nanArJ6sdnO3ufeu17V2g=;
 b=HIfcIskJSKn7gRiDApdnynBQLKuzxegD/QabuUjbJSU4DTjskUOw6ClD1uTCDjJXVrj5i1
 iU8wIWUwdBsHLO9EuRdGFSyRuxS6J6MIUIofMMXcxb8F5ikoOdvJXXZjl8JdhboU+JtGh8
 Arb8W69N0YumI4XoOGP/i8Fx6zgomHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-KFd8eXRgOFCYMATyRXt5kw-1; Thu, 11 Dec 2025 09:40:18 -0500
X-MC-Unique: KFd8eXRgOFCYMATyRXt5kw-1
X-Mimecast-MFC-AGG-ID: KFd8eXRgOFCYMATyRXt5kw_1765464018
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779393221aso1005245e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 06:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765464017; x=1766068817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yk0EbJh7giZ+Zn3ZlE7ZS6nanArJ6sdnO3ufeu17V2g=;
 b=o6vWjUZD+sRUL9Ivene4kkYnUGS7WaT06jYn7FwfNHPSjhmCPVPZIeGDd2GORRwNEz
 4uNCOFFxgGfGorF8cWOvngXygw86urV6YOKkSKyki49Vcoe4FMO3xoWycFyF23+PKpxk
 YFMrt/UYG5xBI7iWbA4I3jIqd3r1xV+UGBf8yg324u2BP6cDZ0loF4d186sZS7Dy+cfg
 xcySjgtMBwA+mSlzdkU1BnktFDwxdkv0BVNL227in0DS0tBT4/GfpEBzGzhC7OslBj+9
 2J3lYiS3NNb5ou9f/ETdrmzEFNtxP+6g4s6IfdIAqpOHFENj/WDEKHwj82Sp9E/aN6yl
 PIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765464017; x=1766068817;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk0EbJh7giZ+Zn3ZlE7ZS6nanArJ6sdnO3ufeu17V2g=;
 b=EvHLXjaoMiazbRM0g9i0C0sYA31rhzUJoJDegRD4ag9bHqF7QM8BeF2/MuebeOcPIT
 lb8oEpt5J+5b9N0FsjGkZDEtF5H5bjSEh/K6uAiQ/x8PpDDSUYLuJ7V5clTIfUwxS+7s
 d/rssMnRKbkqFHyk4Okw83GDtgYnR0Ik4CMr7wNPKjC+wSS5oivAXLiMDqykOwd5XqJ0
 DrSbtrQJtdsJHhkMzEbr18LH+HuYJV8TWo/6G4Ca59MKPzPbOw2UgRn+1Y9Yc2+H69mq
 Z4jcPGnWw6DB/Q/UKJDkb2aNtEGaNEALO0jQC6PIyg/1jEbe2+mvohCzl9+/8LEjQ3TV
 tTIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5Um1KsyabMiw4J6e5jfzbj6eckZ2daGSZE0EiRmInfMCD03a3JgRFQD6Ci6Ja7AEBEMND+mc1HS8@nongnu.org
X-Gm-Message-State: AOJu0YxqbRp7p0DF66gSNaeLCO67QceVRjHCTlb7i+zmYhTkebqHUnDD
 gN6qYrHXbTKTsmDCncx24DBRGHi9uqxeH+MHfQ0j5ecDuIomLxZ3QCH49aU0r6+TPjPfZws1Ya4
 GxN9bGBpfpl36KEjM9cUFPR3/lA3oFryK8rtyvYtNA/ySW4/DrUF5FsZE
X-Gm-Gg: AY/fxX7qytCaEs7/cE3Y/eCaJG9FgFJoXZ3S79GChGJOfqf7w/Ie7OtoJL4qgF4sFER
 yud0AdEsXXss9KOn5Y0xSIvQ2RdJED4HrExDZ1k09SoYgjDV02cw35ZpylrvzC25iPWp8uiJTH7
 zIRZaGZnkVFNEwnbZ88nlWkSdzPfu7NM3qK5vbeviaWUR1ocxG7AwFt0SImYvVL1SO+t/UdflF8
 lnZ79XVd3rjhzrc6Q8BOE1gs6hdS4RzaiKNTJrDtN21bA0pjpdS/SCPtAz+huVPWslgDEZfi+Zb
 jbajQyQd5IM2j7LWrTGk6a1P1o70TjqeXj2828z594oJ80rv2XeYHVjiDku14h8Ra/JBFSKUaoZ
 XkzePrk7pT4Mbnl8PCQB7yHVDsYpswB5fok7z19Qo/ezBSm72
X-Received: by 2002:a05:600c:3587:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47a85ea3ff7mr46845045e9.21.1765464016108; 
 Thu, 11 Dec 2025 06:40:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAq8M34+PTexgS8pKqKaMMkqUlAWpC2LgS6eCqxYcdLPcwRUZM5o7N8Hp5d5vnq387P/fo8A==
X-Received: by 2002:a05:600c:3587:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47a85ea3ff7mr46844625e9.21.1765464015631; 
 Thu, 11 Dec 2025 06:40:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f0eabcsm36720165e9.15.2025.12.11.06.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 06:40:14 -0800 (PST)
Message-ID: <52ad0c7a-29a3-4222-ae94-05400ad38796@redhat.com>
Date: Thu, 11 Dec 2025 15:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 11/20/25 14:21, Shameer Kolothum wrote:
> Introduce an optional supports_address_space() callback in PCIIOMMUOps to
> allow a vIOMMU implementation to reject devices that should not be attached
> to it.

Why can't we use the existing .set_iommu_device() op instead ?

C.

> 
> Currently, get_address_space() is the first and mandatory callback into the
> vIOMMU layer, which always returns an address space. For certain setups, such
> as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
> emulated endpoint devices is undesirable as it may impact the behavior or
> performance of VFIO passthrough devices, for example, by triggering
> unnecessary invalidations on the host IOMMU.
> 
> The new callback allows a vIOMMU to check and reject unsupported devices
> early during PCI device registration.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci/pci.c         | 20 ++++++++++++++++++++
>   include/hw/pci/pci.h | 17 +++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index af32ab4adb..55647a6928 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -135,6 +135,21 @@ static void pci_set_master(PCIDevice *d, bool enable)
>       d->is_master = enable; /* cache the status */
>   }
>   
> +static bool
> +pci_device_supports_iommu_address_space(PCIDevice *dev, Error **errp)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus && iommu_bus->iommu_ops->supports_address_space) {
> +        return iommu_bus->iommu_ops->supports_address_space(bus,
> +                                iommu_bus->iommu_opaque, devfn, errp);
> +    }
> +    return true;
> +}
> +
>   static void pci_init_bus_master(PCIDevice *pci_dev)
>   {
>       AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
> @@ -1424,6 +1439,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pci_dev->config_write = config_write;
>       bus->devices[devfn] = pci_dev;
>       pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (!pci_device_supports_iommu_address_space(pci_dev, errp)) {
> +        do_pci_unregister_device(pci_dev);
> +        bus->devices[devfn] = NULL;
> +        return NULL;
> +    }
>       if (phase_check(PHASE_MACHINE_READY)) {
>           pci_init_bus_master(pci_dev);
>       }
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a3ca54859c..dd1c4483a2 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -417,6 +417,23 @@ typedef struct IOMMUPRINotifier {
>    * framework for a set of devices on a PCI bus.
>    */
>   typedef struct PCIIOMMUOps {
> +    /**
> +     * @supports_address_space: Optional pre-check to determine if a PCI
> +     * device can have an IOMMU address space.
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number.
> +     *
> +     * @errp: pass an Error out only when return false
> +     *
> +     * Returns: true if the device can be associated with an IOMMU address
> +     * space, false otherwise with errp set.
> +     */
> +    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
> +                                   Error **errp);
>       /**
>        * @get_address_space: get the address space for a set of devices
>        * on a PCI bus.


