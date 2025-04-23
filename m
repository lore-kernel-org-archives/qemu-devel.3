Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29977C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 13:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7aPk-0007mb-Ow; Wed, 23 Apr 2025 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7aPh-0007jR-Co
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7aPd-00053z-H2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 09:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745415915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a0ldmO296WI9vbVPtueDfaNzO+ZlPS1+gAkV98M01DI=;
 b=I3FqdFkXDX6ZIiRatwTB+ce+ifFwiqnlXuixqvv7y9a/eL4eKoKkbOg7BWOUZt+GYtdkN+
 1sFwtMamT19wGMCxApXD7fMOcDsfYh3GBJuN+GG/elvUheZS9TBThpLamPKFSVQqb58o4J
 A+Bxkv8WHnBO9dCf52yY1kaRDhVJr3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-WaBvVOsXPe6VE-1wijCtPw-1; Wed, 23 Apr 2025 09:45:14 -0400
X-MC-Unique: WaBvVOsXPe6VE-1wijCtPw-1
X-Mimecast-MFC-AGG-ID: WaBvVOsXPe6VE-1wijCtPw_1745415913
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso4447775e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 06:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745415913; x=1746020713;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0ldmO296WI9vbVPtueDfaNzO+ZlPS1+gAkV98M01DI=;
 b=egrAYyEZU0wM+BfwF/+wwEuwnE1CSL4N5Aza2fOc32S0ZdBb1W1dQCXnBH0evuSPNb
 f6NAf5zNjYXyalcH8kXsDiKbjkZZWd1UwgtBH3Hwn8AmuLm+d4MjrNIbWmxDCUyAhXqF
 F7r/pJxP5lwQ4xzGfTYDe+dTkLJ6Yo9cmd5KAd8ZWLt5zwgUhuwYMzivguIII1Gi9GyQ
 3k6IBNBunx36wL1/LCn1gNj6HnoYazeB3sVIkiBx/JF2GVSOLdyAnWq0x1ab+xmXkPjZ
 P8Xs/j6SylaAX77pdVGDAvcQSe5Cdx3e+rFa9NGoFukvXKMDMUbXPsMEx1b12fMIulKK
 7VYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdCD+sbdPfjtg7NDBiHlKoSA3YaGeMtT8VzNLpM5iC6d+7SdUrMI9eF/bEHoCdCo7ZKBUrHZpaMtwy@nongnu.org
X-Gm-Message-State: AOJu0YzmamRou0xb9YPDX/qFcl5Rj1yg0/UWl57V3Z0IBt7a/yEJl6p1
 YaT5LOLc/vNNgAMdMJoVCYbYktLvF0qTpv+0GqiBP462LUn2vDTZIUDyRunj+CfpR4mL4tQ8/hI
 5Qvwj4y7BHlI6tFFLYIzy86WGRQ2FErWSfETukQK6oLxoUi4ebAUh
X-Gm-Gg: ASbGncv1YDkE10vGG6whNR60Lvp7nkXFs3b2T9DMF8Dj0cwUrqhc5DA7W+eDLcgrHL7
 eyFGCVXeiY8AaJmJL6PN3JfZZQHxYk+3xlzqL1AJBgyhoQmJBI8EbFGgnWo3XYNZTiZg9m+xy3X
 hk47iE1/QmOfvWraS/nDmWYxAmag8WhoW/lSt3/5CgOBSMEI4RPGLI6bo0tJ39By1lnLPmRKTR8
 yh9OqUwMrB/26moMosmSCrcUh8u+zOQ1P5Ju+mWw3dt/OSqEr5PX2pUfsNco9X1DpG9Em9oppV6
 iGgmTeL/dD7fnPQDfeaco4DkcRE9q0jl/N7GVo2YepCfqkE=
X-Received: by 2002:a05:600c:5808:b0:43d:fa5f:7d04 with SMTP id
 5b1f17b1804b1-44092022deemr22834505e9.16.1745415912915; 
 Wed, 23 Apr 2025 06:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExdSblzlpdg1aAH0Z1Uugvm47t+4VQgQfXkcsJimYCH1kl+ZONNCRk3oAZ5cAWp1gNHkQgMA==
X-Received: by 2002:a05:600c:5808:b0:43d:fa5f:7d04 with SMTP id
 5b1f17b1804b1-44092022deemr22834265e9.16.1745415912471; 
 Wed, 23 Apr 2025 06:45:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43c079sm19176147f8f.50.2025.04.23.06.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 06:45:11 -0700 (PDT)
Message-ID: <5d87f16c-6e67-42f3-864c-e4e134816d70@redhat.com>
Date: Wed, 23 Apr 2025 15:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] vfio/container: pass listener_begin/commit callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 4/9/25 15:48, John Levon wrote:
> The vfio-user container will later need to hook into these callbacks;
> set up vfio to use them, and optionally pass them through to the
> container.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 285ca97a8c..9ffc2deb2d 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -412,6 +412,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
>       return true;
>   }
>   
> +static void vfio_listener_begin(MemoryListener *listener)
> +{
> +    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
> +                                                 listener);
> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
> +
> +    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
> +
> +    if (listener_begin) {
> +        listener_begin(bcontainer);
> +    }
> +}
> +
> +static void vfio_listener_commit(MemoryListener *listener)
> +{
> +    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
> +                                                 listener);
> +    void (*listener_commit)(VFIOContainerBase *bcontainer);
> +
> +    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
> +
> +    if (listener_commit) {
> +        listener_commit(bcontainer);
> +    }
> +}
> +
>   static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
>   {
>       /*
> @@ -1166,6 +1192,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>   
>   static const MemoryListener vfio_memory_listener = {
>       .name = "vfio",
> +    .begin = vfio_listener_begin,
> +    .commit = vfio_listener_commit,
>       .region_add = vfio_listener_region_add,
>       .region_del = vfio_listener_region_del,
>       .log_global_start = vfio_listener_log_global_start,
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index a441932be7..67373e8db0 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -120,6 +120,8 @@ struct VFIOIOMMUClass {
>   
>       /* basic feature */
>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
> +    void (*listener_commit)(VFIOContainerBase *bcontainer);

Please add documentation for the new callbacks.

Thanks,

C.


>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);


