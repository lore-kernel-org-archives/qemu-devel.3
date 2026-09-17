Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FDC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7C2l-0005rR-JR; Thu, 17 Sep 2026 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x7C2j-0005qU-QQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x7C2f-0000vg-Qw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789651243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FXeF9QO8P5r2rG6ZTH1DuOvCEfHtOL4VAoVqn+et7fo=;
 b=WhXrg6P1+9ViAGmVz9svbXex4uD9sl7yZqayGk3SmrLOnpy93fTWr9B04t31qrKlJIO0NE
 WB7VZ6c5OEvxyjfgcr+YYvd9TKTEw5hG69GcJNSPd3Z0AJkt64PMR7hTHgMARO2lhZ7S0o
 GfJJkb+xJpURb2MnNKmVsf/4ARATaRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-2Mt5oL-jORKBel06w-uBuQ-1; Thu, 17 Sep 2026 09:20:41 -0400
X-MC-Unique: 2Mt5oL-jORKBel06w-uBuQ-1
X-Mimecast-MFC-AGG-ID: 2Mt5oL-jORKBel06w-uBuQ_1789651240
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e65f2f1baso10250335e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789651240; x=1790256040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FXeF9QO8P5r2rG6ZTH1DuOvCEfHtOL4VAoVqn+et7fo=;
 b=ogVJJVVy/HUtNEy7U3gusLFoaV7pcrxgFf/ePXOoAPYKZZjRbMYb8GjgbnU5zZIZqG
 qEzCK3f5mHzJ3jwyKP2+Z/rwm0Aoo8qXlZJTltnRF0u8KOreHEakfJ36iERR5W3CXbtv
 fBAyjVXrvth3CtBB9QPPkdfGFEOFQHnxsrjtloJRB+HWqkSK5bIMmS6q53AeSYjd1Iiu
 OWDAkxM1TJCMHoz4zoto2bItjS5nu3qrcg4gXo3uXd2AXPpX7Pj2FNCDcacl5U2erge1
 lbRtI9KrxJyKeLtkYPulPv3TodLDUMLzv2ZZPOI/2XMJoKMKv8WkZzu7YVVUHJiWyH1W
 F5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651240; x=1790256040;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FXeF9QO8P5r2rG6ZTH1DuOvCEfHtOL4VAoVqn+et7fo=;
 b=vNgqIwX+oD0mgIrkW6ZuxI9UHXzTR+WbesuVRLu1Vx1gkd/Owxf2EabZbOJOKLUAR4
 IARtv9YsmZwR352X5k47ogCdcJxto9KNvAgm33HvQbugtQpvrBDOT106DkvoETqiauDL
 0cKF3OKa4x8qVlDVYrsWMNzk3AM/LKxXF72i7ycZ6hd/XxX+48gE80OW6g4TF+6MkfjL
 fPYCIO7/rmRkVu0tTWkXGrhjXStBBj1XFpBKS4RjoDibS/XT2HxCOagsey9tqZz3KFax
 +ybrR9c+0J9vyyEW5W08Rpvs8493cYRMvc/oIR17vNv5CIDYO44HLrd4+X6GrOm8jcje
 HFkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDwEt5s2NB+leBGUKhRLICy/fny+XurKRIut4gTYN2slMMYp2mAYqb6KRTyvb3tdGkkbVrxfhwg7iN@nongnu.org
X-Gm-Message-State: AFuF++k9jtJXzssKlTWJS+tu5dxmVtWzS0AuBwDd22iPjk+BoF4kofmp
 9aS9nfEjdHeJ47EaiF/guWikqhqYZTSBizAdXn4peRylSor/EiLiJTigaWjopdn2T3cJ4IJzNqT
 q+iEL9T06IsiijcfCDqPouQmbZatctckzu9nZcjNecG5TqZiSpJwhkwLL
X-Gm-Gg: AYBFou3DlYnyS7xQa/TvS6P3EIXETQYh0f3WNEsVGscdZv38AVmqljkNYrLhYd8+wGY
 0LIdml9u2bw0h1f7XKZEO6YA8iwGRg3d/0dLtzGkX8IMRr/5d8y3B11puT9m7mBVGM5ogUs1EBh
 8C0BS6kumv8j2L7Qir8tSlMzZMhp4+ftZgosKxOWaE2LvJHD4LY1dt/zGTFTqnBFhIBzg40513H
 9pj7kO+UYJADmA1QdCHy90PatM7cR1DEc9yeRBtubiY6/MpeoISmAGRDLVqAMEpixRGFz/i0Emq
 B47uUXEs4lqa26uSHv4rfw6J6A4SxCG8LKom+Is44zZpJKpQtwO6Y9F1NSbBg40nwj5swkHmEET
 BrTIMiiQkxWrmULW4nzvrBK4iXLrTxz3AsWqTWN4+UA==
X-Received: by 2002:a05:600c:1f96:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49eb72f24camr77305295e9.9.1789651239726; 
 Thu, 17 Sep 2026 06:20:39 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49eb72f24camr77304775e9.9.1789651239185; 
 Thu, 17 Sep 2026 06:20:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd17051fsm78318555e9.0.2026.09.17.06.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 06:20:38 -0700 (PDT)
Message-ID: <401f2150-fee9-4f9d-981e-f6bdde37a234@redhat.com>
Date: Thu, 17 Sep 2026 15:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/vfio/pci: Enforce the passthrough topology
 for a CXL device
To: mhonap@nvidia.com, alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org, 
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, cohuck@redhat.com
Cc: kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org
References: <20260916184412.3825713-1-mhonap@nvidia.com>
 <20260916184412.3825713-5-mhonap@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260916184412.3825713-5-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/16/26 20:44, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Only the guest's endpoint HDM decoder is programmed by the guest; the
> decoders above it are covered only while the pxb-cxl host bridge stays in
> passthrough mode. Reject a switch in the path, or a host bridge taken out
> of passthrough, at realize before any mapping exists.
> 
> AI-used-for: code (prototype)
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>   hw/vfio/pci.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2f84af5cf8..10b13f200d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -27,6 +27,7 @@
>   #include "hw/pci/msi.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/pci_bridge.h"
> +#include "hw/cxl/cxl.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-properties-system.h"
>   #include "hw/vfio/vfio-cpr.h"
> @@ -3570,6 +3571,73 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> +/*
> + * Walk the endpoint's ancestor bridges up to its pxb-cxl host bridge. A CXL
> + * switch in the path is rejected: the guest would then have to program switch
> + * decoders, which the passthrough model does not yet cover. This is the single
> + * place the supported-topology assumption lives, so switch support later
> + * relaxes it here.
> + */
> +static PXBCXLDev *vfio_cxl_find_pxb(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    PCIBus *bus = pci_get_bus(&vdev->parent_obj);

Could this routine be moved to the CXL subsytem component ?
> +
> +    if (!object_dynamic_cast(OBJECT(bus), TYPE_CXL_BUS)) {
> +        error_setg(errp,
> +                   "vfio-cxl: %s: endpoint is not on a CXL root port (cxl-rp)",
> +                   vdev->vbasedev.name);
> +        return NULL;
> +    }
> +
> +    for (; bus; ) {

Why walk, since this is looking for the case "no-switch in between the
bus and the ep" ? the no-switch case is just two hops in the topology.


> +        PCIDevice *bridge = bus->parent_dev;
> +
> +        if (!bridge) {
> +            break;
> +        }
> +        if (object_dynamic_cast(OBJECT(bridge), TYPE_CXL_USP) ||
> +            object_dynamic_cast(OBJECT(bridge), TYPE_CXL_DSP)) {
> +            error_setg(errp,
> +                       "vfio-cxl: %s: switch-attached topology not supported",
> +                       vdev->vbasedev.name);
> +            return NULL;
> +        }
> +        if (object_dynamic_cast(OBJECT(bridge), TYPE_PXB_CXL_DEV)) {
> +            return PXB_CXL_DEV(bridge);
> +        }
> +        if (pci_bus_is_root(bus)) {
> +            break;
> +        }
> +        bus = pci_get_bus(bridge);
> +    }
> +
> +    error_setg(errp, "vfio-cxl: %s: not attached below a pxb-cxl host bridge",
> +               vdev->vbasedev.name);
> +    return NULL;
> +}
> +
> +/*
> + * Only guest's endpoint decoder is programmed, so the host bridge must stay in
> + * HDM passthrough mode. Reject anything else at realize, before a mapping is
> + * built. cxl_get_hb_passthrough() reflects reset state and is not
> + * settled yet here, so gate on the static hdm_for_passthrough property.
> + */
> +static bool vfio_cxl_check_topology(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    PXBCXLDev *pxb = vfio_cxl_find_pxb(vdev, errp);
> +
> +    if (!pxb) {
> +        return false;
> +    }
> +    if (pxb->hdm_for_passthrough) {

This naming is a bit confusing:

   hdm_for_passthrough=false means "use HDM passthrough mode" (no decoders), while
   hdm_for_passthrough=true means "keep HDM decoders even in passthrough topology.

I will get used to it.

Thanks,

C.



> +        error_setg(errp,
> +                   "vfio-cxl: %s: the pxb-cxl must be in HDM passthrough mode "
> +                   "(do not set hdm_for_passthrough)", vdev->vbasedev.name);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   /*
>    * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
>    * and the trapped HDM decoder block (which BAR carries it and at what offset).
> @@ -3623,6 +3691,11 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>       cxl->dpa_size = mem_info->size;
>       cxl->comp_bar = cap->bar;
>       cxl->hdm_offset = cap->offset;
> +
> +    if (!vfio_cxl_check_topology(vdev, errp)) {
> +        return false;
> +    }
> +
>       cxl->enabled = true;
>   
>       return true;


