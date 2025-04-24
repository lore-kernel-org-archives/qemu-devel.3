Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EC3C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 12:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7vTN-0002rd-LJ; Thu, 24 Apr 2025 08:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7vTL-0002qR-1Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7vTF-0002Ap-P6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 08:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745496861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=obtNsUcsu7qfmWlh/Zhi6fGwTx+JgN6wGRwdm+wnWqA=;
 b=RH0UOJKXWUPlqqM9M3dmujvz3XFBnnaMUJX59YbMM6uRs//zLbZcosnqGpx+TTHEAAKMhc
 W6I/ZB9rrcZPwklRmk/hFY87D/rIa1BdVlrVGJsbQDG2VSn9Idc/x2NjMHW/5Ni7VDGicq
 zyVi93Sa9F1MO0H5xY62L66moMxPJag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-2MM4zv8ZPdSkwG1bmE6ezg-1; Thu, 24 Apr 2025 08:14:20 -0400
X-MC-Unique: 2MM4zv8ZPdSkwG1bmE6ezg-1
X-Mimecast-MFC-AGG-ID: 2MM4zv8ZPdSkwG1bmE6ezg_1745496859
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391492acb59so449162f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 05:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496859; x=1746101659;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obtNsUcsu7qfmWlh/Zhi6fGwTx+JgN6wGRwdm+wnWqA=;
 b=kf5aSFuXDGqecjxvfy2P8YpzVssuyEY5WIQ5m14ROVf+mM1kL+nikLKXnm7kaYWEh7
 oW+yR4bd+k/75gJ3NkBGIZJ7USGMG0b2s0eZkf3yyvpQtndEAJHjKJ5yb9sXZmAtOdYz
 HInpFpRlICjhFu43WoRBY/WhmrsLEqnnVtrD0+5H4GLz81ANhtHdS94FzA+ct3MXVOLA
 b+QeyZVwDRNRfzocdgDAqtd/GdOx/aslhGu5ejG2fce9/VIzfasqsAsPWp0bGjHm/AG5
 p2B7hgZRQWeV5pIG8z8vI4JczuH3ES6DNL4f8VmgL27UW2bfeeo6Qah3tugHA2oLz54N
 vrgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXntyLtsu4TBBnUFcvkhFQgHF6aFiXPoy6ffsrPFjPMDxOiXSzYuKm3U+Ql8RpSgayq6YqVmXmCRyfX@nongnu.org
X-Gm-Message-State: AOJu0Ywbt4vUd9ZFMpr5xn9HuEuy0StU/cFujDmlBmlRig+JFNalAzlc
 zlPxlO7Lw61EiyMKgyHwuhxpL/pBfRTCkidpOmcmQsFQLwKRBPNr+S65fUuON3OaV2CN1wDtKdV
 4100sn594fcq7yNkFgB6phpmWzTHVYk+WdlYZXIS9A+7IYGk5gGCj
X-Gm-Gg: ASbGnctPGZeCRs/be91T/yzpTZrPfUJicnFNovY56QquGBvJcxKHutT/jCXwhvba1Zm
 c5FC8DYuVY783WFGfoaCw1T1b7rkqnAQfUvhGSSwUfNSk2dRUXvDJpaQK8nAQBN5PbhU1rjtC2V
 CElZWfC7wVQT2a+FXC8FXqLmhtOz5Gn+c7vjy+nS8wMrcb7n5kJGC9lTBXCPCqnNH7xWCbBmiG6
 /i5dmLQ3qazLwgelmgEB+t9dG/6OTvBwuUIAkBfhOJH2GWCVM4e1Bfo2az7eULV7IGFjDE4Z4Gc
 yljmiBcFn1LMqRpvrQrotSAW8aLu09BtXh0FjSgs24pgKjs=
X-Received: by 2002:a05:6000:186c:b0:39a:ca05:54a9 with SMTP id
 ffacd0b85a97d-3a06cf61cefmr1587022f8f.29.1745496858868; 
 Thu, 24 Apr 2025 05:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5ixIbwiqdDw7uQ7ZIfrfaiq5fpmF0Qp2TkzwMtIuiszJ6xUgZS8kqvolmVErVgVaMf1XPTg==
X-Received: by 2002:a05:6000:186c:b0:39a:ca05:54a9 with SMTP id
 ffacd0b85a97d-3a06cf61cefmr1587002f8f.29.1745496858503; 
 Thu, 24 Apr 2025 05:14:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a7febsm1978036f8f.15.2025.04.24.05.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 05:14:17 -0700 (PDT)
Message-ID: <81a55290-4c9f-4c3f-85b9-ddba53360aa8@redhat.com>
Date: Thu, 24 Apr 2025 14:14:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Register/unregister container for CPR only once for
 each container
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, steven.sistare@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250424063355.3855174-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250424063355.3855174-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/24/25 08:33, Zhenzhong Duan wrote:
> vfio_cpr_register_container and vfio_cpr_unregister_container are container
> scoped function. Calling them for each device attaching/detaching would
> corrupt CPR reboot notifier list, i.e., when two VFIO devices are attached
> to same container and have same notifier registered twice.
> 
> Fixes: d9fa4223b30a ("vfio: register container for cpr")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Looks OK to me, so

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Some feedback from Steve would be good to have.

> ---
> btw: untested as I have no env with two migration capable devices,
>       appreciate if someone have env to help test, thanks

I did.

Thanks,

C.




> 
>   hw/vfio/iommufd.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index f24054a6a5..b2f72dc8c3 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -416,6 +416,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>       if (!QLIST_EMPTY(&bcontainer->device_list)) {
>           return;
>       }
> +    vfio_cpr_unregister_container(bcontainer);
>       vfio_listener_unregister(bcontainer);
>       iommufd_backend_free_id(container->be, container->ioas_id);
>       object_unref(container);
> @@ -561,6 +562,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_listener_register;
>       }
>   
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +        goto err_listener_register;
> +    }
> +
>       bcontainer->initialized = true;
>   
>   found_container:
> @@ -570,13 +575,9 @@ found_container:
>           goto err_listener_register;
>       }
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> -        goto err_listener_register;
> -    }
> -
>       if (!vfio_device_hiod_create_and_realize(vbasedev,
>                        TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
> -        goto err_hiod_realize;
> +        goto err_listener_register;
>       }
>   
>       /*
> @@ -600,8 +601,6 @@ found_container:
>                                      vbasedev->num_regions, vbasedev->flags);
>       return true;
>   
> -err_hiod_realize:
> -    vfio_cpr_unregister_container(bcontainer);
>   err_listener_register:
>       iommufd_cdev_ram_block_discard_disable(false);
>   err_discard_disable:
> @@ -632,7 +631,6 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>       }
>   
>       object_unref(vbasedev->hiod);
> -    vfio_cpr_unregister_container(bcontainer);
>       iommufd_cdev_detach_container(vbasedev, container);
>       iommufd_cdev_container_destroy(container);
>       vfio_address_space_put(space);


