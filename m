Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC23AC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 12:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxFM-0008UD-Qd; Wed, 02 Apr 2025 08:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzxFD-0008Sc-NZ
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzxFB-0003Vt-Ui
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743597056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mw3/AY5ZxhbFeGLoyI6pELvUKNCQonaEY6IbqJP+mGE=;
 b=glZ+xOvi4fzw9yP2OT2n/svyx0uD1b4UuchK+xILi7oGNlGVCr6JGQEB8sAiW3+rUiTGaD
 z/r6lYXIqr088swb4sCs6Cwb/yJgIOIXA6nYYSV4nAtf3BS+MQFLHi0nIbJdYnUtGjLn4O
 OAwYSGO9d6WGHdSegnPgtZdQmU4udi8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-uxuAOPS2MSKGm-T0lKvYmQ-1; Wed, 02 Apr 2025 08:30:55 -0400
X-MC-Unique: uxuAOPS2MSKGm-T0lKvYmQ-1
X-Mimecast-MFC-AGG-ID: uxuAOPS2MSKGm-T0lKvYmQ_1743597054
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so497251f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 05:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743597054; x=1744201854;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mw3/AY5ZxhbFeGLoyI6pELvUKNCQonaEY6IbqJP+mGE=;
 b=PilIdDvafAVNcKcSljsZzBB6qV0M3MTJ0LSqtyqEt1/KzWxQMe2xnrJhXQ2NDDlM6y
 7xciMPBGHA4uaXL176rgHEiLZJLg9qdK6RvHKH4AgnJSwa/3aN7WjVcVnstmEcqb3pZY
 U0WnkofdMnAjTKLmmnv4dnG06sjXxEWKlFxMzByxsVLNFaG1tSYCaZG+wWz8jO5nEoev
 Lbl1ejoQCJS3j7SL8+SfVsI1r/LB6LnQEM8nTTZKng9FzgLuCv/L0x5GMuqo2x4C/TTY
 1phgNXbHd/NPwbsX3VsiU0g3BwUrg+XRatcYjqECJzqdzvq5EWtFAgvX6PmFh1MOYOW6
 kNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSHI0p1mUleyyZMJby9MeLJa96CJYUGrULTluUTN2IpgvOzO9Uzpky3jbOqkVUcsTsfpTBk2g+oUYz@nongnu.org
X-Gm-Message-State: AOJu0YwrDqupOFVubFO9KtNc55jNm/1eYqG8JBQ7l5a2kqZvwxDp8EgH
 D+pOAvlvvHHuaLAMen7UQeDO3p1SPVR9S1qit7eES/hcm5Bx54hv++CludMxK6ShwgXWoa474s/
 gzHnWvDucM7hrn/arr9BS0EXOaPOwiQvs/G7gus5o60uKtM/P1Ews
X-Gm-Gg: ASbGncsx89gSyUQ2EU44Twf7wteLFAl23mLAKfeQVTlEuEjELcxBISsSoubIzYvXBE5
 0hFJ8QkfhsUV1bfG3YYfxZqbiMk9SR8xBH8L8F/hX7i+PJYTcm420OqhP0QmvEeSTDhtFrm1Of4
 PTfn+QZ6b8zgiZDgpuuhjBqfHOS99s0hlMzBwFg8KdrObdSgB47CB+zd7aY1NZeUsVM5QUBi50Y
 t1+LPgunE0vHJwgB6qGX9K6nzqvHwDnmlJ/egfvgjsQM1xRSZiAmEsjAPanAFGz3oE+j9QS+EZO
 SlR/linH9VMqrtrk0zcAa3fXzeTkHFVDvSounVNv8/twb/a0dhtRtg==
X-Received: by 2002:a5d:47ad:0:b0:391:98b:e5b3 with SMTP id
 ffacd0b85a97d-39c2a67725fmr1731679f8f.14.1743597054367; 
 Wed, 02 Apr 2025 05:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJJ75HYTfyYd0flaZ7UOKHJx1HuK1tNbZekW6tYWwJYzFWHsroZ2m3/tTX7A3OCopNHR8Wvg==
X-Received: by 2002:a5d:47ad:0:b0:391:98b:e5b3 with SMTP id
 ffacd0b85a97d-39c2a67725fmr1731638f8f.14.1743597054013; 
 Wed, 02 Apr 2025 05:30:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm16653997f8f.3.2025.04.02.05.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 05:30:53 -0700 (PDT)
Message-ID: <f1087fc2-61a5-45cc-83be-74b00b42cc87@redhat.com>
Date: Wed, 2 Apr 2025 14:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/28] vfio/container: pass listener_begin/commit
 callbacks
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Levon <levon@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-3-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On 2/19/25 15:48, John Levon wrote:
> From: John Levon <levon@movementarian.org>
> 
> The vfio-user container will later need to hook into these callbacks;
> set up vfio to use them, and optionally pass them through to the
> container.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>

Looks ok. The future respin of this series will need to add routines
to register the begin and commit callbacks.

> ---
>   hw/vfio/common.c                      | 28 +++++++++++++++++++++++++++
>   include/hw/vfio/vfio-container-base.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8d3d425c63..6f106167fd 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -557,6 +557,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
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
> @@ -1396,6 +1422,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>   
>   const MemoryListener vfio_memory_listener = {
>       .name = "vfio",
> +    .begin = vfio_listener_begin,
> +    .commit = vfio_listener_commit,
>       .region_add = vfio_listener_region_add,
>       .region_del = vfio_listener_region_del,
>       .log_global_start = vfio_listener_log_global_start,
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index c9d339383e..0a863df0dc 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -111,6 +111,8 @@ struct VFIOIOMMUClass {
>   
>       /* basic feature */
>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
> +    void (*listener_commit)(VFIOContainerBase *bcontainer);
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly, MemoryRegion *mrp);

VFIOIOMMUClass needs more documentation. Please add some for
these new callbacks. Adding a comment saying that these callbacks
are for vfio-user would be appreciated.

Thanks,

C.



