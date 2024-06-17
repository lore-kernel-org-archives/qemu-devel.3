Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCBC2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCyo-0008Cg-Ju; Mon, 17 Jun 2024 10:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCym-0008CO-VE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJCyl-0008JO-6S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718633102;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7NJhHLitF4ZZ+57UEl7YMCxyyigxpnHrAntf/wUHYk=;
 b=Q0Ye+USEAkt/p/lD+l9dHUjmNTUgJDGdsJJeoj63+tzAcCXVehMoOYJjWF099Q+kDH1kUk
 GPy+vMdQVuS1m26anPB1tZvRiUYB3YiMa0fovMUSiCniYEVebHt24qxgADz/Ac1zT6ZP8k
 3iSU8r3IvpXRxav/qu2vT/P7BhMUFMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-TsUI8-moNwiKHSdXzk0JYw-1; Mon, 17 Jun 2024 10:05:00 -0400
X-MC-Unique: TsUI8-moNwiKHSdXzk0JYw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso31756285e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718633098; x=1719237898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7NJhHLitF4ZZ+57UEl7YMCxyyigxpnHrAntf/wUHYk=;
 b=iJE5X5nlJ+m3/PDb3JSmOsmVltbi7zPS4Z/cDH0/2vKCMJNNyctO6H71Shw86Tu1Pr
 v1RaFN5C5hIpzhAAMC2FX6XuL/WhadoGG8+8lDfvFOUXtvjUTpmqXtvBBQHSg5GqlGSw
 Xk2u8IFUHssebo/U9/2g33ribFi4MowYbUEnzOjklCPvozylkPoOZpOpDMdD8TpqyFi+
 QZCcmGebCzI9Ca6vGuZSQfDY3DGHmf+VavXpkv4wjU7ka9MLGyxFXxy69C35jxX0UWFb
 rWitFVt/quUs3qddwyv828FMqvN2xvH2PnHCKE8IM5vn6V2hUzZtgh57YYCl+qzK+eAV
 /UeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZAG1CnXWG7mP0S4MVpE+dyAo4QU0YNlC2dhy0p0EoG4/HuYJRslPNUCQ4L9Y+YOor/eDBENGPWG56lT5u6pE+pteDVQc=
X-Gm-Message-State: AOJu0YzNLIR5hh4gTaMezDDvQp1mYuragka93YC6nlC+xCwFW9mwSO4x
 I5uC5c4C0Ac2cGuakZSGTCNH4D6WptR0+dW2HnhwquoyfFNFwVJpyavmDRM+ChVPTCdWMXR9Uk9
 n7rERt6TvAv8jT6yxjA6LgAfWeTpVH9v+4s22GBLK7QJkByXQjnuER6Wk/DmB
X-Received: by 2002:a05:600c:1912:b0:423:499:a1e6 with SMTP id
 5b1f17b1804b1-4230499a43cmr66615385e9.29.1718633098268; 
 Mon, 17 Jun 2024 07:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyiEopd0wmbsOPKeoMA7ovV54vDvN0/m5QLIZ5FSSmQ6oWZjgikKXzFzCtcNqtDq968On2Hw==
X-Received: by 2002:a05:600c:1912:b0:423:499:a1e6 with SMTP id
 5b1f17b1804b1-4230499a43cmr66615195e9.29.1718633097867; 
 Mon, 17 Jun 2024 07:04:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a6c1sm160679465e9.40.2024.06.17.07.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:04:57 -0700 (PDT)
Message-ID: <4dd2cb75-c6dc-426e-bb0c-87e25ea057b7@redhat.com>
Date: Mon, 17 Jun 2024 16:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] vfio/container: Introduce
 vfio_address_space_insert()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-6-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/17/24 08:33, Cédric Le Goater wrote:
> It will ease future changes.
Does it, really?

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h | 2 ++
>  hw/vfio/common.c              | 6 ++++++
>  hw/vfio/container.c           | 2 +-
>  hw/vfio/iommufd.c             | 2 +-
>  4 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c19572f90b277193491020af28e8b5587f15bfd1..825d80130bd435fe50830c8ae5b7905d18104dd6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -206,6 +206,8 @@ typedef struct VFIODisplay {
>  
>  VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>  void vfio_put_address_space(VFIOAddressSpace *space);
> +void vfio_address_space_insert(VFIOAddressSpace *space,
> +                               VFIOContainerBase *bcontainer);
>  
>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f28641bad5cf4b71fcdc0a6c9d42b24c8d786248..8cdf26c6f5a490cfa02bdf1087a91948709aaa33 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1508,6 +1508,12 @@ void vfio_put_address_space(VFIOAddressSpace *space)
>      }
>  }
>  
> +void vfio_address_space_insert(VFIOAddressSpace *space,
> +                               VFIOContainerBase *bcontainer)
> +{
> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
> +}
> +
>  struct vfio_device_info *vfio_get_device_info(int fd)
>  {
>      struct vfio_device_info *info;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c48749c089a67ee4d0e6b8dd975562e2938500cd..0237c216987ff64a6d11bef8688bb000d93a7f09 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -637,7 +637,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      vfio_kvm_device_add_group(group);
>  
>      QLIST_INIT(&container->group_list);
> -    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
> +    vfio_address_space_insert(space, bcontainer);
>  
>      group->container = container;
>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e502081c2ad9eda31769176f875fef60a77e2b43..9f8f33e383a38827ceca0f73cb77f5ca6b123198 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -358,7 +358,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      bcontainer = &container->bcontainer;
>      vfio_container_init(bcontainer, space, iommufd_vioc);
> -    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
> +    vfio_address_space_insert(space, bcontainer);
>  
>      if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>          goto err_attach_container;


