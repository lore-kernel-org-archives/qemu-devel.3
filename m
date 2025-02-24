Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606AC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmV5m-0000nD-Vb; Mon, 24 Feb 2025 04:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmV5l-0000mk-0V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmV5i-0001Xf-Tb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740390573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TVji2KW2hEKAdcgXwmIRpcxHqPnOvkm8pbDt7o4mu98=;
 b=cn1WIkPpQa33QFcfdym0Wu8Nk0AI9Vlr0Gq0UWkq+axpdSTTlMEFr/5ZVKI7v3WElH8H1D
 um8MjUuFrx/8b/wAUevzQ06c+9dqxxufj5JKToK6amBrX/Zv/cS59KfJjjwp/DqK2bdwN9
 fzKTAPBO1Xp4Qiex3TTQGyMmZeMSPGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-AKQ6-3ujM2CauHHmhi1WUQ-1; Mon, 24 Feb 2025 04:49:30 -0500
X-MC-Unique: AKQ6-3ujM2CauHHmhi1WUQ-1
X-Mimecast-MFC-AGG-ID: AKQ6-3ujM2CauHHmhi1WUQ_1740390570
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso23078575e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740390569; x=1740995369;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TVji2KW2hEKAdcgXwmIRpcxHqPnOvkm8pbDt7o4mu98=;
 b=ZLP+r54lvfxfhKkhch1jCyhoQoBlV2ZwoaS8BXicM3OcBDODbWxcwq4NAOCBN04Wd3
 opbVIn/n8hujf9QQkRmguINuG4XLms4SK30kZYowlpkwhF2a1JaH4cl+APS+OJ5bhaf9
 R6KwBBSY8O/UtEPlZBIaov3BAjrEwm2fuD0rIGM1drUOvzZgZVQ01NhEwcIxAe8ySaDv
 SlS3HdxIUGbP1zKK11trca6hmpAYTiRvWvxajpyclth1pZkYXQ/aqwjXkAsdH6PHaZtR
 W/DwAIs3v3BnuZj5Ic5SBul0sRwv5D4TgPg77P2Rhb43jEKnxUn4pCCCbGTodgBl/zRC
 OJlA==
X-Gm-Message-State: AOJu0Yxdmm3/NALODK1ho2L+WZUAEnxKuowoWtWTICv6lybg+MXAhTW1
 5UhbWgKmCIDyFnVd20mDr3aHlETamVQyDVr5/ScKO6EUkVYHkqmvUFMvLloqrh9kMFDYCVk1AOf
 hRU/B5cK4nf/Xmd8y2uc/b4TVIuHNf5uddXF4JO8rZDDR409fwV4VJhiwu1Q7MUU=
X-Gm-Gg: ASbGncvLjt5GOz7VggCLYlIUySVgMz1qNdi9xU+PcsOyzKKjW22aOQjIamDOsBBoH0R
 +oqcP8KSZN+DXuKHV9tT5yqMZ9nxblniBRO2+UjvvcKSt9Uu5Mp09n23hSPYJBIF10qkK2pbiAp
 F+nTwJtRqt+lHBqliFt1EhJi1x0om1cvFOtSp2t2StGoIXP+3TXocdSUl9zu3e3c7dmjiHf0Wth
 whPADPPZIVbc4mUNffNT+zsK4f9Kf0s2KTDEDAjJSUNxId8rTFK8jk3c1H7Pb3L0mngT9Jc42fo
 1LmV4dIQYpTFS9uvlP0Xemzw/pGrtJ+Lx1CMmq0U4tn8DOaL2NPwUhnezBpGcVJMRZ3zk48xjis
 sMMxKIg8pdDxRCkbtnLVOQ+u1LO8W8nSymL65DDNJpxk=
X-Received: by 2002:a5d:5989:0:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-38f6eb6f403mr9198478f8f.29.1740390569523; 
 Mon, 24 Feb 2025 01:49:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWs+m+j9/k7ylXsQKsNizmJL8e3eB87w8CvGNd1FMEd4tGTmH3jBvleMIc3Holx38ZN6hYpg==
X-Received: by 2002:a5d:5989:0:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-38f6eb6f403mr9198446f8f.29.1740390569096; 
 Mon, 24 Feb 2025 01:49:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc?
 (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de.
 [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b43c9sm31401784f8f.10.2025.02.24.01.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:49:28 -0800 (PST)
Message-ID: <b320f128-3604-40c8-961c-ceb431f82f6d@redhat.com>
Date: Mon, 24 Feb 2025 10:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
 <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
 <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
 <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 24.02.25 10:35, Albert Esteve wrote:
> On Mon, Feb 24, 2025 at 10:16 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 24.02.25 09:54, Albert Esteve wrote:
>>> On Mon, Feb 17, 2025 at 9:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 17.02.25 17:40, Albert Esteve wrote:
>>>>> Hi all,
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> looks like our debugging session was successfu :)
>>>>
>>>> One question below.
>>>>
>>>>> v3->v4
>>>>> - Change mmap strategy to use RAM blocks
>>>>>      and subregions.
>>>>> - Add new bitfield to qmp feature map
>>>>> - Followed most review comments from
>>>>>      last iteration.
>>>>> - Merged documentation patch again with
>>>>>      this one. Makes more sense to
>>>>>      review them together after all.
>>>>> - Add documentation for MEM_READ/WRITE
>>>>>      messages.
>>>>>
>>>>> The goal of this patch is to support
>>>>> dynamic fd-backed memory maps initiated
>>>>> from vhost-user backends.
>>>>> There are many devices that could already
>>>>> benefit of this feature, e.g.,
>>>>> virtiofs or virtio-gpu.
>>>>>
>>>>> After receiving the SHMEM_MAP/UNMAP request,
>>>>> the frontend creates the RAMBlock form the
>>>>> fd and maps it by adding it as a subregion
>>>>> of the shared memory region container.
>>>>>
>>>>> The VIRTIO Shared Memory Region list is
>>>>> declared in the `VirtIODevice` struct
>>>>> to make it generic.
>>>>>
>>>>> TODO: There was a conversation on the
>>>>> previous version around adding tests
>>>>> to the patch (which I have acknowledged).
>>>>> However, given the numerous changes
>>>>> that the patch already has, I have
>>>>> decided to send it early and collect
>>>>> some feedback while I work on the
>>>>> tests for the next iteration.
>>>>> Given that I have been able to
>>>>> test the implementation with
>>>>> my local setup, I am more or less
>>>>> confident that, at least, the code
>>>>> is in a relatively sane state
>>>>> so that no reviewing time is
>>>>> wasted on broken patches.
>>>>>
>>>>> This patch also includes:
>>>>> - SHMEM_CONFIG frontend request that is
>>>>> specifically meant to allow generic
>>>>> vhost-user-device frontend to be able to
>>>>> query VIRTIO Shared Memory settings from the
>>>>> backend (as this device is generic and agnostic
>>>>> of the actual backend configuration).
>>>>>
>>>>> - MEM_READ/WRITE backend requests are
>>>>> added to deal with a potential issue when having
>>>>> multiple backends sharing a file descriptor.
>>>>> When a backend calls SHMEM_MAP it makes
>>>>> accessing to the region fail for other
>>>>> backend as it is missing from their translation
>>>>> table. So these requests are a fallback
>>>>> for vhost-user memory translation fails.
>>>>
>>>> Can you elaborate what the issue here is?
>>>>
>>>> Why would SHMEM_MAP make accessing the region fail for other backends --
>>>> what makes this missing from their translation?
>>>
>>> This issue was raised by Stefan Hajnoczi in one of the first
>>> iterations of this patchset, based upon previous David Gilbert's work
>>> on the virtiofs DAX Window.
>>>
>>> Let me paste here some of his remarks:
>>>
>>> """
>>> Other backends don't see these mappings. If the guest submits a vring
>>> descriptor referencing a mapping to another backend, then that backend
>>> won't be able to access this memory.
>>> """
>>> [...]
>>> """
>>> A bit more detail:
>>>
>>> Device A has a VIRTIO Shared Memory Region. An application mmaps that
>>> memory (examples: guest userspace driver using Linux VFIO, a guest
>>> kernel driver that exposes the memory to userspace via mmap, or guest
>>> kernel DAX). The application passes that memory as an I/O buffer to
>>> device B (e.g. O_DIRECT disk I/O).
>>>
>>> The result is that device B's vhost-user backend receives a vring
>>> descriptor that points to a guest memory address in device A's VIRTIO
>>> Shared Memory Region. Since device B does not have this memory in its
>>> table, it cannot translate the address and the device breaks.
>>> """
>>>
>>> I have not triggered the issue myself. So the idea is that the next
>>> patch will *definitively* include some testing for the commits that I
>>> cannot verify with my local setup.
>>
>> Hah! But isn't that exact problem which is now solved by our rework?
>>
>> Whatever is mapped in the VIRTIO Shared Memory Region will be
>> communicated to all other vhost-user devices. So they should have that
>> memory in their map and should be able to access it.
> 
> You mean the SET_MEM_TABLE message after the vhost_commit is sent to
> all vhost-user devices? I was not sure, as I was testing with a single
> device, that would be great, and simplify the patch a lot.

Yes, all vhost-user devices should be updated.

-- 
Cheers,

David / dhildenb


