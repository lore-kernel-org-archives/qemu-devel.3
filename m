Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4463DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrQa-0005ZG-Pv; Wed, 18 Dec 2024 05:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNrQZ-0005Ym-3E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNrQX-0003NQ-Ew
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734518231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sKKPgTjRcGvk56IqWB4DN4yHEDy71/GjfP/u9Tn1ers=;
 b=OVqMzA/EonEm+PCfLh4jm525mPN1Pp1rLNbAXXkmfWoH8C0EHdoSqmFYxp2WDj29+9CgRf
 apWdllmKUGeMLRAROX69fjpTOxIkIKgf7A824ZJpOGY5EQcl0QgSAQNmB0XJ3PjDFEjs0U
 94wip3+0iGQJmVl3rb+vv0LKP54AYok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-XM1DquGDNpebv4usN_hTDA-1; Wed, 18 Dec 2024 05:37:10 -0500
X-MC-Unique: XM1DquGDNpebv4usN_hTDA-1
X-Mimecast-MFC-AGG-ID: XM1DquGDNpebv4usN_hTDA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso50606795e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734518229; x=1735123029;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sKKPgTjRcGvk56IqWB4DN4yHEDy71/GjfP/u9Tn1ers=;
 b=SIHg/HQqS0nTijPSuwSBLWCBwkBzGr/z+pbjoaw2fBgX7XkdiJL/796IVOPNORKwF8
 om3tyhQkeO0coGzPFAfqnzF+4QNYzkXO6/PlhzY2Y0twH4l5ACI9X/zDkp2nJAmi7oMK
 EHb7H9X2rnZrHW06bhKoADHTaA4KjYAbZVH1P/6WcUNXyPB9Y42e0MZMUU7Lic+WvkHr
 FA26jedgzXNcIfmWZPHlYwrE/7iFZAW/mPgFupiFp//8xPeR9EM377gL29NwYKT01Qk2
 ThYWPI0rOUqDddUXhhLRdDwWbtw9pLvo8EJOvtmtrsljQj437Kg1Js8rPdSIUNOZ9dFE
 E9aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYR9FncuzySvkpJCRFuQwiGj5r+/bOpVuAkDRn//qbrMDlVjt5YP8+qWo7qAfXf8M8W678sW3jVjfz@nongnu.org
X-Gm-Message-State: AOJu0YzeaLcHOPTYSFJKIphTGNJXP1ONKDN3oEa2tZhYE9Cau1u1yg+E
 NWCp/FVVAMLbPsJTg6Iz3WESiVpCJYhF2t5h3mG0ss0rdcOjZ5VixgDoUO1tCnOXeGZrSaH4vjQ
 GrDiI0iHDZbunvHqQIMxhhjEQfFzFswBADdZC7MXX5TFlZ1RzN9bx
X-Gm-Gg: ASbGncuGVcR2pC0qJ3hF521WApplMxlL9t8a6sID6Z+LDwQElkr2clHnWvWDxmky1M9
 o92DvNkynZEJELKMt2oN/kVXFHiVx/6v5qSe1z6bIUrqg+0/XwniALpk9ipSANWBRxvnIiRewJB
 MVq1qutPRJrLEf/S6u5T4PDuULCqRx5INMubmSiFBWrcBcCQu4Axgv+Kc5J9TFWy9Z/cOyXIzz1
 LMy+73pTo2RtAIUofQ/KdO+f0MvfzEGEZSevea3r4Dv/siMLsviOEJvR/7zZKZekeluc+mlvD07
 NQA9EuumNoVBWVGh4jic+2tOQAxSU31RWde8rXXz4rbrWwE4cYeNpNzM4ySE1Ijsp8VUDgKwziT
 jTNcGWGiO
X-Received: by 2002:a05:600c:548b:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-4365540ce51mr16758015e9.33.1734518228927; 
 Wed, 18 Dec 2024 02:37:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4vrgui+7Ns3DntwZo3hD9Pn5K+7L93BUCD3nlM5FUclj1MSl+dpk7ZBcHDkwE/ARg4mc9tw==
X-Received: by 2002:a05:600c:548b:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-4365540ce51mr16757745e9.33.1734518228514; 
 Wed, 18 Dec 2024 02:37:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c73f:8300:a5d5:c21b:add3:cf50?
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b442dasm15840745e9.42.2024.12.18.02.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:37:07 -0800 (PST)
Message-ID: <cf465326-1eaf-4ad1-99ae-1e0d5a562a84@redhat.com>
Date: Wed, 18 Dec 2024 11:37:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can use
 MSI-X
To: Reza Arbab <arbab@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241216163125.438156-1-arbab@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16.12.24 17:31, Reza Arbab wrote:
> Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
> only enable it in new machine types, so we don't break migration of
> existing machine types between different qemu versions.
> 
> This copies what was done for virtio-rng-pci in:
> 9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-X")
> bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
> 62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vectors")
> 
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
>   hw/core/machine.c              |  6 +++++-
>   hw/virtio/virtio-balloon-pci.c | 13 +++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e6900b43efa2..db59c7771ec4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,11 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> -GlobalProperty hw_compat_9_2[] = {};
> +GlobalProperty hw_compat_9_2[] = {
> +    { "virtio-balloon-pci", "vectors", "0" },
> +    { "virtio-balloon-pci-transitional", "vectors", "0" },
> +    { "virtio-balloon-pci-non-transitional", "vectors", "0" },
> +};
>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>   
>   GlobalProperty hw_compat_9_1[] = {
> diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
> index ce2645ba7187..1c2b071eff0c 100644
> --- a/hw/virtio/virtio-balloon-pci.c
> +++ b/hw/virtio/virtio-balloon-pci.c
> @@ -35,11 +35,23 @@ struct VirtIOBalloonPCI {
>       VirtIOBalloon vdev;
>   };
>   
> +static Property virtio_balloon_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>   {
>       VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
>       DeviceState *vdev = DEVICE(&dev->vdev);
>   
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = 2;
> +    }
> +
>       vpci_dev->class_code = PCI_CLASS_OTHERS;
>       qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>   }
> @@ -55,6 +67,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
>       pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
>       pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>       pcidev_k->class_id = PCI_CLASS_OTHERS;
> +    device_class_set_props(dc, virtio_balloon_properties);
>   }
>   
>   static void virtio_balloon_pci_instance_init(Object *obj)
> 
> base-commit: ca80a5d026a280762e0772615f1988db542b3ade

No expert on any of that MSi-X / PCI magic, but LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


