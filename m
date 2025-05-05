Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1556FC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvAS-00055h-Ok; Mon, 05 May 2025 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvAR-00055O-9c
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBvAJ-0005A7-0t
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746449002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VjP4tUT4PfJwUjaJ+EZRKTuBQemtptzeAbP/jC59jXE=;
 b=aYCqX352r25/sRfwDvD5KPSsW7IsOs4o1peJ47BySNRImO+q/xFPosqg2JtuJq4tB3vka1
 +DF//WUaD4O1Ay/q1sKleose6KGTX6GpOnqW+PNh2FIKpQSSSv4Ivwmrmz/z7ZGjlVZwZX
 4dWTBCzks44XWax5buLtIvU5WWIc5W4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-4Hsl-NvKODymyTg7XAsu8Q-1; Mon, 05 May 2025 08:43:20 -0400
X-MC-Unique: 4Hsl-NvKODymyTg7XAsu8Q-1
X-Mimecast-MFC-AGG-ID: 4Hsl-NvKODymyTg7XAsu8Q_1746449000
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so2600374f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746449000; x=1747053800;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjP4tUT4PfJwUjaJ+EZRKTuBQemtptzeAbP/jC59jXE=;
 b=UEhxoHRYR8Fr460tTRdy3LqDq5ocwRzZS93ymbTVj17RajEQeDbaoBFQMGzuKMtPbZ
 64C1b3AyFAAgp9N9DdQAjtQvWhvyHJDghADCH9+x4BTw0RshUNBEDN1bg0Ump7n2ehos
 3xap3fKT+EGVQJpnXStgKqnBprOH+4M2PQZEI+7iU4fJQhcZKwEljYT7/djjXlKZkT7H
 BCzoOcV4WZyuK23RELs/SI4bZRSqrPjfCkpu9Ku3F0aDjH8YEvr8H0IuQ6c5Vts+KPuq
 GDfBiRcCBXc9pdHoau5YSPqK2Bflv0qoOBWBjRwzPqHXUCWu9btMoPLPRW2AVoips8IK
 wi4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOjZxEDp+2AdVpAH1Imd+oOzIcUuUqlPMGb/dpCtfAzjpubrftsrugim6SjzE9kMOCgC5WRSi8gVST@nongnu.org
X-Gm-Message-State: AOJu0YxwU3CbnXqfDnq+yCJiNkSmkT6vn6Zy7P7cSq8VfVXWdMt316hZ
 88Uotf78+Z/insRxVz3lL8flgxafoPkWZjrAopDnvtDjHz1/h8Cg+h0ftqLx0N644tLotLsn7dW
 kiPBwQQzwCzN1N9kDhSjdN33pTYZNgIZrx8TvnKsALJ9cmGPyIjaA
X-Gm-Gg: ASbGncsAQdCfy1tQWBmAiYppsGEqVWRt5oSpcLbhfH9wImeuURCKI4CYskPIro/S5rC
 wX/t9+onhzsrIUfD/ba5sTMEThgsUz6lJbkpdjLLS+u8kkU44VSFi9dHsSNmy0fnu19l46wKVJh
 dDRjvnBC846DiyVh61iGu8nY8/5hjyseR1YnwCaX74QDAYYecJDY4TWNfGJYp2LLCrU+cY+J+8h
 J2Ljm0frQDa5mZK1RNlyEwICyRb+GF5pX2ut6c8AcadmOstrUqhqezepR+YNZxm2JzIr5+B7Zow
 VvI3JYMI5+n9s7xG2T/mm+eFa00/qp5gxaoSnimc3uhQ+DIpkg==
X-Received: by 2002:a05:6000:4027:b0:3a0:8098:b6c with SMTP id
 ffacd0b85a97d-3a09fd76869mr5920628f8f.14.1746448999752; 
 Mon, 05 May 2025 05:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7jkNW5yeGq0j1a6sAfGVloP4a4/CvKDdT3Gj9QUBagLECgpYOgv5WXZHsJPDIRnL3Hz3qIQ==
X-Received: by 2002:a05:6000:4027:b0:3a0:8098:b6c with SMTP id
 ffacd0b85a97d-3a09fd76869mr5920596f8f.14.1746448999407; 
 Mon, 05 May 2025 05:43:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c25sm10431683f8f.17.2025.05.05.05.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:43:18 -0700 (PDT)
Message-ID: <dccc76e4-afcd-4007-8356-9549bde50371@redhat.com>
Date: Mon, 5 May 2025 14:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] vfio/container: pass listener_begin/commit
 callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-15-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-15-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 21:40, John Levon wrote:
> The vfio-user container will later need to hook into these callbacks;
> set up vfio to use them, and optionally pass them through to the
> container.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 2b93ca55b6..bfacb3d8d9 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -411,6 +411,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
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
> @@ -1161,6 +1187,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>   
>   static const MemoryListener vfio_memory_listener = {
>       .name = "vfio",
> +    .begin = vfio_listener_begin,
> +    .commit = vfio_listener_commit,
>       .region_add = vfio_listener_region_add,
>       .region_del = vfio_listener_region_del,
>       .log_global_start = vfio_listener_log_global_start,
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 92cee54d11..e29f7126c5 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -117,6 +117,8 @@ struct VFIOIOMMUClass {
>   
>       /* basic feature */
>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
> +    void (*listener_commit)(VFIOContainerBase *bcontainer);
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);


