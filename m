Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC5AC02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKLd-0002Ku-8d; Tue, 04 Feb 2025 09:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfKLZ-0002Ij-IW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfKLX-0002Zm-Q1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738680973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QN0o7KsQQiFi/o4stlDltAQ5jkxkDJixBZ3fjuPPxAM=;
 b=FYB0mQ7GL6exhdYDwkqMBPcV2tDwL3/3vXpNWIvamBv7C+uT8iJYcsqKTaN/GIZ2PC8RY8
 OFExJcmSThn1NxrkSm1Wj4fB9WsQ7eo7khsngJpRIDdiSiKkZLnOa0dc50nQQI/cdjAvRe
 e9b1dlkTqy66GM727avmTrMmAX2r0eQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-xf2p7-ZSOiycuGv5-VTVNQ-1; Tue, 04 Feb 2025 09:56:12 -0500
X-MC-Unique: xf2p7-ZSOiycuGv5-VTVNQ-1
X-Mimecast-MFC-AGG-ID: xf2p7-ZSOiycuGv5-VTVNQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362b9c1641so29875205e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680971; x=1739285771;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QN0o7KsQQiFi/o4stlDltAQ5jkxkDJixBZ3fjuPPxAM=;
 b=qOsUOckARQXsEKlXIoffWptIMBnhtD17DP10zHcL/BzMvZlX3qgteHSdHDwhZ7XKkA
 Bq6wsGl/JKtD4GzmPnTKyPRRxlsKBnUagu+dhWK5TpSK/Ge6GAcv9RnKuLAyuxtOpGGb
 d8cDBI0uLwqIGh2mz7IPQncTq62bSNSUh50kPn2LhLi0xi+T6vjAYOlxfQ/T8j60S5zd
 azgcK+QQFEgzsAlOdT2PTE23TpgAclnaECydo4b1d/uT77/Y83i6HV9Bj8hgZk84eFXD
 dwA/VP9P/9OuSEVup/ZWcUHEOIp+d2izvS9UY2kur2q8jzOd2UKqQg8MnDbAETv3eEPn
 exYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBl6kTf4TqQXUx+PYloMoqijDUxzmzASUZKTAF8fc+b7Xx+COVvmPWmk1Q/boSeLvtaf4/OnR4oLbo@nongnu.org
X-Gm-Message-State: AOJu0YxeLlBlT91rQzCh21uHAPcuI1+SECJ3QD/a+qvZG7QuLhhtb8Oc
 iJZZ7hV4WBqnRANWjLM6PPxD9h60ZW1NKH1RGF6/prfN7yWuqNEVh28trEH8fvwH9XSpsmOgD5c
 d68w3KW4n8kcrSzhrhIOeZkcu0VVdynE5lM6gnZySSg68agK/Ia0W
X-Gm-Gg: ASbGncvvANpEmnf46cg77tFJqW+6Y8YlRwVOURKv4QcygPTNjRT+0RybxSz/FB7YRkI
 N8QuuPygiTPNlqGAp/b6vUp9iHdzmKqS/s5BtcH2FkUmCi+jzSNoZoVS7CzJvIMnE3+9wErmjlR
 RTjJEglCkt2RUZYfFdSjO5Mo4yBV+FBIYKOvawCJDG7G9ZucAhXP+KAN8T0iBplOYFCAxlafa9L
 nHFoNwaAs9p6C87s5KLS494ZrAq2w1jfpHN9TP51vGkLwmum6k+9M4jkQmIUyIMyKVvGdpEPJEk
 VTOr/Fv2QytpwPrErpkT+3oODZZZyVp8OlZiJ76M2AU=
X-Received: by 2002:a05:6000:1acc:b0:38a:418e:bee with SMTP id
 ffacd0b85a97d-38c51e919b6mr20453819f8f.42.1738680971114; 
 Tue, 04 Feb 2025 06:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4bZvcLipaQFB9xiUGjExAVS6Kt3B60cBvidiJUSDq4epW3RmmRl4BMNYubryaelhZ/UsOxw==
X-Received: by 2002:a05:6000:1acc:b0:38a:418e:bee with SMTP id
 ffacd0b85a97d-38c51e919b6mr20453806f8f.42.1738680970739; 
 Tue, 04 Feb 2025 06:56:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm197016585e9.3.2025.02.04.06.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 06:56:10 -0800 (PST)
Message-ID: <ae082d34-5c0c-449b-91dc-c8c3b147d6dc@redhat.com>
Date: Tue, 4 Feb 2025 15:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 11/26] vfio-pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-12-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-12-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR, and do not complain if the
> kernel's PCI config space changes for non-emulated bits between the
> vmstate save and load, which can happen due to ongoing interrupt activity.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 24ebd69..fa77c36 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -29,6 +29,8 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "migration/misc.h"
> +#include "migration/cpr.h"
>   #include "migration/vmstate.h"
>   #include "qapi/qmp/qdict.h"
>   #include "qemu/error-report.h"
> @@ -3324,6 +3326,11 @@ static void vfio_pci_reset(DeviceState *dev)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(dev);
>   
> +    /* Do not reset the device during qemu_system_reset prior to cpr load */
> +    if (vdev->vbasedev.reused) {
> +        return;
> +    }
> +

sometime we use :

     MigMode mode = migrate_mode();
     if (mode == MIG_MODE_CPR_TRANSFER) {
         return;
     }

Why is this different ? This is confusing.


Thanks,

C.



>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
>       vfio_pci_pre_reset(vdev);
> @@ -3447,6 +3454,35 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   }
>   #endif
>   
> +/*
> + * The kernel may change non-emulated config bits.  Exclude them from the
> + * changed-bits check in get_pci_config_device.
> + */
> +static int vfio_pci_pre_load(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int size = MIN(pci_config_size(pdev), vdev->config_size);
> +    int i;
> +
> +    for (i = 0; i < size; i++) {
> +        pdev->cmask[i] &= vdev->emulated_config_bits[i];
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vfio_pci_vmstate = {
> +    .name = "vfio-pci",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .pre_load = vfio_pci_pre_load,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3457,6 +3493,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>   #endif
> +    dc->vmsd = &vfio_pci_vmstate;
>       dc->desc = "VFIO-based PCI device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       pdc->realize = vfio_realize;


