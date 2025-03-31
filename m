Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495DC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEyl-0004TY-Lh; Mon, 31 Mar 2025 09:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzEyg-0004Oj-3M
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzEyb-00048O-CL
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743426889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ptIma1LhG7p846DH/W3/m9VWlk6mhp/J4x2K+JihM5o=;
 b=BuCR6QocWP1l04oq8HGT1tVGgqu7smGclTeCU/OOk2WVDBgOgRwwgfp/stVYRU4N1F6r2K
 hBY7u3abEvw+feJiIM986ncUZZ7NM5D11DrBGYi4osmYbYdCoarsiiAM2BwjpPTW6ObZW6
 SPPgndDwfuY6F5QESsXVG+52ztww+3g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564--4VJfJfcNlyGEgY9pizcGQ-1; Mon, 31 Mar 2025 09:14:47 -0400
X-MC-Unique: -4VJfJfcNlyGEgY9pizcGQ-1
X-Mimecast-MFC-AGG-ID: -4VJfJfcNlyGEgY9pizcGQ_1743426887
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso26449815e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426886; x=1744031686;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptIma1LhG7p846DH/W3/m9VWlk6mhp/J4x2K+JihM5o=;
 b=XYBn2YCDjXem2MoePTonYfQlciTjwOXPEU+14Rpgqlno6mRBpW8dSg0Ii0Nqtd/of2
 U93wm/7sgLIU183/U08gBlMn6H2FLF/jBZHD5BoiaIs2oXnrrqk3vc9XC6TlWrezALFT
 r7udLgcpwGTw1O+US5H4s13t/HJffm1UUxrrSk9lyXUx7BaQHUvsXyxWrC7p+joQzR2X
 ohUv7mtJJa29ev3w5xgvHFhaeBDYxjC9h+0tOF5Byp6L0bTuPSVBA7kUQncwOWp1edTr
 24MWhFugeTDB82KgM2XJEbDOPgEFzq05OrMf55x4CyZm1/WoYAdKSM/dFJbu/MsqQYDn
 RmDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4zkaCtDdd0aaAdgnah/t45ifsw9XOFX9gte7FybF+zkmMQk+CSxLSrMp+1DsPPCVlaMUyR5Ewg9rf@nongnu.org
X-Gm-Message-State: AOJu0YwqdkZdAmaybQLSYxaHtOOBj+aXtWOW57AkCGjBMhA3nX/JLIfx
 Nr6k274a1xMvoe0MrJorwg8D173ls/IG920jZkzEIxg2uBJS+i2a7e1pxROq4paWV4782pX2qdo
 lNMQiGkTKlg5Wb5LslntsS8w6jrAB4VD/fJ+d2kVl+JPHOsfGPLzs
X-Gm-Gg: ASbGncvUVcUI/YLuwO5iLeejKQeT3quAc0FnHSsEa7oCpseZh4v0z0E1JfbA8stXK+1
 b8hOT2GXyEdlA0tPNWnTa9ug7elb+yrne7lhOQWTJO0kaq8Exdkdon5SJmrszZCdtLXU55Pt3RH
 Mq3QfQfk0PxQdrMAKxTrlba/B3pzSUtAcCEObxRuoT9OTRg2uCg/sPrQcUBCiU5fFVqXK1MBOnH
 rVSS3LvImj5fNP5atITIOkNdfPZa3s1jbIYYUBH5PF9wEP90AIJlo0h/VLyDTbJNqZ57L9Km0SO
 nLHwGp46iJx7KJ2E44ngIQ/Z1L3Vu0T1XC4jTRt6hjHWpXOhqUMp0A==
X-Received: by 2002:a05:6000:1acd:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-39c11b9d025mr7236461f8f.23.1743426886566; 
 Mon, 31 Mar 2025 06:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbq4bBFQZYNQIEw7a1bY4xC8t9p++N8ZI6usIogIW4ENId1W7llYa/eZa0hfheyxvHM0kVQ==
X-Received: by 2002:a05:6000:1acd:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-39c11b9d025mr7236438f8f.23.1743426886180; 
 Mon, 31 Mar 2025 06:14:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656afsm11139921f8f.40.2025.03.31.06.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 06:14:45 -0700 (PDT)
Message-ID: <0513ad9a-99d6-4642-85aa-4a1a021ac0f3@redhat.com>
Date: Mon, 31 Mar 2025 15:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
 <3bf1ab06-4411-4d19-afad-3da2e62cbd9d@redhat.com>
 <34dbe4a3-7c4c-477b-a41d-98f0636d1f61@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <34dbe4a3-7c4c-477b-a41d-98f0636d1f61@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/25 14:49, Joao Martins wrote:
> On 21/03/2025 11:22, Cédric Le Goater wrote:
>> On 3/19/25 13:21, Joao Martins wrote:
>>> On 18/03/2025 09:54, Cédric Le Goater wrote:
>>>> Rename these routines :
>>>>
>>>>     vfio_devices_all_device_dirty_tracking_started ->
>>>> vfio_dirty_tracking_devices_is_started_all
>>>>     vfio_devices_all_dirty_tracking_started        ->
>>>> vfio_dirty_tracking_devices_is_started
>>>>     vfio_devices_all_device_dirty_tracking         ->
>>>> vfio_dirty_tracking_devices_is_supported
>>>>     vfio_devices_dma_logging_start                 ->
>>>> vfio_dirty_tracking_devices_dma_logging_start
>>>>     vfio_devices_dma_logging_stop                  ->
>>>> vfio_dirty_tracking_devices_dma_logging_stop
>>>>     vfio_devices_query_dirty_bitmap                ->
>>>> vfio_dirty_tracking_devices_query_dirty_bitmap
>>>>     vfio_get_dirty_bitmap                          ->
>>>> vfio_dirty_tracking_query_dirty_bitmap
>>>>
>>>> to better reflect the namespace they belong to.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>
>>> The change itself is fine.
>>>
>>> But on the other hand, it looks relatively long names, no?
>>
>> I agree.
>>
>>> I am bit at two minds
>>> (as I generally prefer shorter code), but I can't find any alternatives if you
>>> really wanna have one namespaces associated with the subsystem:file as a C
>>> namespace.
>>>
>>> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
>>> when talking about this stuff, but it seems a detour from the code style to
>>> abbreviate namespaces into acronyms.
>>
>> I am ok to use a TLA for Dirty Page Tracking. Would DPT statisfy everyone ?
>>
> 
> It would, but the new version looks shorter so maybe we don't need to go against
> style with TLAs.
> 
>>>
>>> Having said that:
>>>
>>>      Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
>>> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
>>> shorter.
>>
>> Could you please send your proposal as a list, like the commit log does
>> and let's discuss.
> 
> The idea was :
> 
> vfio_dirty_tracking_devices_dma_logging_start ->
> 	vfio_container_dma_logging_start
> vfio_dirty_tracking_devices_dma_logging_stop ->
> 	vfio_container_dma_logging_stop
> 
> But honestly, doesn't make that much of the difference.
> 
> I'll have a look at your v2 hopefully tomorrow or Wednesday on the device dirty
> tracking parts and iommufd dirty tracking.


Thanks, there should be progress in v2.

Patch 1~25 should be ready for vfio-next. I can just apply them and
we can continue working on the final part. Feel free to propose changes.

C.

  
> 


