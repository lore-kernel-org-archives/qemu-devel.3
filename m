Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B624C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6tO-0002yX-5p; Tue, 09 Jul 2024 05:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR6tL-0002s9-V4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR6tJ-0000Pp-Fd
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720516322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4fMyV9ACQGNSgQFmnS/ZcEPttYfp+M7vsy7ITSsO2c=;
 b=OM7eWm3lWJtu+JSGKgtDep2hN2mUFpWde2jNljwYMZOmyjgZJiU1OJ040Nspy6gn2QVux4
 iZT8bm/iIE8doQm+sxeSpE19kgUbil5AW5SsmyktGHr6S8V/3+Umj5UsOkKYiE5KmhY0YD
 3jyH2PMfUXgs0NKmTFaimHxwTutkslk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ZI7ougG_Mr-aFX5cwf7lJQ-1; Tue, 09 Jul 2024 05:12:00 -0400
X-MC-Unique: ZI7ougG_Mr-aFX5cwf7lJQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42660bca669so16177675e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 02:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720516319; x=1721121119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4fMyV9ACQGNSgQFmnS/ZcEPttYfp+M7vsy7ITSsO2c=;
 b=Vk0At39G2DxGtT/N4AK1P+Rrwec8UsJivW1ZNdU2VOXb5xbQTsX0ULjpgdQzNqUsda
 EOzRHd63ta6+6qituTsJdhnm/TCSV2+JV/Cz2Be3hWakUGQXMPFVuTAuExhIYMfZaMVc
 NynRh/EDkhWJhg0WJQwbBmSq4YOKmft8KIW+4oMJuTMIZEH/2w8kToOCMhmnvd7A1DV/
 zqXCDYvOslpO3Up0ozfVAgVKFYtWjGWOTlZSd7At/O1g9QEC4E9CddDDFOBaljCwPAqX
 MTWn7yblu7yNq7kYzE/KondpzbJSJuwtUjB+hBo3aYGi+VfoyUNFRat2qWB93oXOC1SH
 +sSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpDJFnXH5Yagg9bPQgJarAKeW8xyMbU/xCHt3zpoMZRXYoYi/jjRXqrUkKZRkfwTjLunrGwB3UZ/eAzXd99kNGaneMY2k=
X-Gm-Message-State: AOJu0YxxIxsRCc1xaff8lojFfmdjwGTFuRStFsjZv+xvhFhH87glfK7a
 fLoDD83u8MxIfjtnjPTClDi9eE5kg3nso8KZ4yUrhkKn+EyRakK6lMCWaqnkBIcIsfhHJJ+JT8x
 BiICKZ+Z6Eb8MA0K4CqBQn4tpLBNk9gOGA9jaBYD3dbLYLZkS6gGy
X-Received: by 2002:a05:600c:6dc5:b0:426:5b84:86d2 with SMTP id
 5b1f17b1804b1-426707e32a0mr14183575e9.20.1720516319174; 
 Tue, 09 Jul 2024 02:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJuvClmFAaVqjNEN2QhRbdMYvt27rJ6hL95gSUfZu/wtbFxyky0A97EOELOJaLKRFL+8gIew==
X-Received: by 2002:a05:600c:6dc5:b0:426:5b84:86d2 with SMTP id
 5b1f17b1804b1-426707e32a0mr14183475e9.20.1720516318807; 
 Tue, 09 Jul 2024 02:11:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6e0b19sm30907835e9.2.2024.07.09.02.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 02:11:58 -0700 (PDT)
Message-ID: <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
Date: Tue, 9 Jul 2024 11:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peterx@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 6/26/24 02:28, Nicolin Chen wrote:
> A nested SMMU must use iommufd ioctls to communicate with the host-level
> SMMU instance for 2-stage translation support. Add an iommufd link to the
> ARM virt-machine, allowing QEMU command to pass in an iommufd object.
If I am not wrong vfio devices are allowed to use different iommufd's
(although there is no real benefice). So this command line wouldn't
match with that option.
Also while reading the commit msg it is not clear with the iommufd is
needed in the machine whereas the vfio iommufd BE generally calls those
ioctls.

Thanks

Eric
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/virt.c         | 14 ++++++++++++++
>  include/hw/arm/virt.h |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 78af2d2195..71093d7c60 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1404,6 +1404,13 @@ static void create_smmu(const VirtMachineState *vms,
>  
>      object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                               &error_abort);
> +
> +    if (vms->iommu == VIRT_IOMMU_NESTED_SMMUV3) {
> +        g_assert(vms->iommufd);
> +        object_property_set_link(OBJECT(dev), "iommufd", OBJECT(vms->iommufd),
> +                                 &error_abort);
> +        object_property_set_bool(OBJECT(dev), "nested", true, &error_abort);

> +    }
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -3114,6 +3121,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>                                            "Set GIC version. "
>                                            "Valid values are 2, 3, 4, host and max");
>  
> +    object_class_property_add_link(oc, "iommufd", TYPE_IOMMUFD_BACKEND,
> +                                   offsetof(VirtMachineState, iommufd),
> +                                   object_property_allow_set_link,
> +                                   OBJ_PROP_LINK_STRONG);
> +    object_class_property_set_description(oc, "iommufd",
> +                                          "Set the IOMMUFD handler from \"-iommufd\"");
> +
>      object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
>      object_class_property_set_description(oc, "iommu",
>                                            "Set the IOMMU type. "
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 7df0813e28..d5cbce1a30 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -36,6 +36,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/arm/bsa.h"
>  #include "hw/block/flash.h"
> +#include "sysemu/iommufd.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "qom/object.h"
> @@ -154,6 +155,7 @@ struct VirtMachineState {
>      bool dtb_randomness;
>      OnOffAuto acpi;
>      VirtGICType gic_version;
> +    IOMMUFDBackend *iommufd;
>      VirtIOMMUType iommu;
>      bool default_bus_bypass_iommu;
>      VirtMSIControllerType msi_controller;


