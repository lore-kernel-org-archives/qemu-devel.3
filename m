Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4666AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 13:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmYxQ-0002w4-M4; Mon, 24 Feb 2025 08:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmYxP-0002vV-Du
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tmYxN-0001EJ-KZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740405432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0ZIuLN+7PSXZBWwrTzNYlWv2V8sBz8L4IqVX98xZK/A=;
 b=Tv1wg4vkBHNRvDA4TUxbhzr7qxHMIGpThq/NQFxVNuav7495QONbJvkxStJ+NDc+24E5Gc
 VxMzzsRLLbCvoy+HmUk/yYBdtKEsWQv6+k5Tl+WMw1//xanjK78nZwdsw83mAAEgic9HOv
 5kpSOWkfXkH89/vFpf9Ih0VY47ZYPGs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-Ne655b5oODuZ64zTSAuspQ-1; Mon, 24 Feb 2025 08:57:10 -0500
X-MC-Unique: Ne655b5oODuZ64zTSAuspQ-1
X-Mimecast-MFC-AGG-ID: Ne655b5oODuZ64zTSAuspQ_1740405429
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f45a86efdso2275128f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 05:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740405429; x=1741010229;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0ZIuLN+7PSXZBWwrTzNYlWv2V8sBz8L4IqVX98xZK/A=;
 b=CAFxBrw093+UEW/A8yiBQEmgZQKqUb+rZazw9+6gvuEkmartrav+r1He3YXsChYoMY
 IISaXNC6fAAlRw/jdAr3VOj2lmdjiaMlBALzHL0FVKXuWJYI+X6ZpBodZa4yCs5VmsNe
 FpjOe9CmJZmx/8jOepG9B7/N8ACMGDWC4Ndx3o9U3eii7aNMW00H2nu0rPF2ULlYxoUy
 gsGsuyVFuBpA3nhudQg0+1mflzPPlgvrpEfAKyMuvb4e5iPtUUfGn85m5HnlMn882Idb
 xRoF1L88WXWkbGUaQnH7MMnxsqd18jihva2SXSgdCncOX26aYR+5f3GlZSOng8yPQOZk
 VpDQ==
X-Gm-Message-State: AOJu0YxPRjbxwHN5nr6qqzFH2T/sX5RIab0m2SLL/umOcPa6XPirAGEU
 FI3lJL0LTelphJAmQd3/Up2dQTK0WRgc+A7yisi3wtPnUASfbw/Lc7xvBnQdZ4andfAGzImT8gJ
 p+F15aI4YT9IwcyE9FNM67MdC0u2k0PRDeeDHC54p3z/++hSdMmnG
X-Gm-Gg: ASbGncs79n+oDrjiDgMvgjPlu+veTzDswmGulIbWSw3Hex6CzSCGtpYTZioNWUW24Rd
 OSqHlej2LBZ8Xp487fFcxMV7tEgco0Z+/KOuj5NhNCHkVzAqo8kx+nm84bq1RK7OVipuQXZbTss
 tqfC5EiuiI76X9NRvT/vlsKqcF0ZeBPB4bHnOOcpigofgPv4aeH9TN7nUU0agRkrJE6qrcD/iVB
 v2MpryRvofRDU3MciPkU2XX2vobBwiMBjIOdGbQfGDLyuXAef+SJyBx+kmboHMiILBcLI7ny5NW
 CJxPyxVoUh3BCxYrK51UgOWEPukZ4EY9M12O4bRqDmie/e0UbMOW+ZE+XtjMa2Nj74CbFZAOTdx
 neHOMGT6+zpy3PfaILGlyGhW7mA7imVDAunfYwUF3p3g=
X-Received: by 2002:a5d:5645:0:b0:38f:31fe:6d37 with SMTP id
 ffacd0b85a97d-38f6f08d252mr9828047f8f.44.1740405429351; 
 Mon, 24 Feb 2025 05:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw8ufPoOrOG+l7me8ADgduIUcvfzsOTf8etNt4sobBwBSl8po08VqBrnh9kz+tFMCEXrnzHw==
X-Received: by 2002:a5d:5645:0:b0:38f:31fe:6d37 with SMTP id
 ffacd0b85a97d-38f6f08d252mr9828029f8f.44.1740405428921; 
 Mon, 24 Feb 2025 05:57:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc?
 (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de.
 [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8e62sm31754310f8f.71.2025.02.24.05.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 05:57:08 -0800 (PST)
Message-ID: <933cf843-e845-45e0-8c48-a34541ad0afb@redhat.com>
Date: Mon, 24 Feb 2025 14:57:07 +0100
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
 <b320f128-3604-40c8-961c-ceb431f82f6d@redhat.com>
 <CADSE00LvNbCR6cn-FuDCVF-vvXULrx7=5SyceMtdgxwpUa3NMw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADSE00LvNbCR6cn-FuDCVF-vvXULrx7=5SyceMtdgxwpUa3NMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 24.02.25 14:41, Albert Esteve wrote:
> On Mon, Feb 24, 2025 at 10:49 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 24.02.25 10:35, Albert Esteve wrote:
>>> On Mon, Feb 24, 2025 at 10:16 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 24.02.25 09:54, Albert Esteve wrote:
>>>>> On Mon, Feb 17, 2025 at 9:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 17.02.25 17:40, Albert Esteve wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> looks like our debugging session was successfu :)
>>>>>>
>>>>>> One question below.
>>>>>>
>>>>>>> v3->v4
>>>>>>> - Change mmap strategy to use RAM blocks
>>>>>>>       and subregions.
>>>>>>> - Add new bitfield to qmp feature map
>>>>>>> - Followed most review comments from
>>>>>>>       last iteration.
>>>>>>> - Merged documentation patch again with
>>>>>>>       this one. Makes more sense to
>>>>>>>       review them together after all.
>>>>>>> - Add documentation for MEM_READ/WRITE
>>>>>>>       messages.
>>>>>>>
>>>>>>> The goal of this patch is to support
>>>>>>> dynamic fd-backed memory maps initiated
>>>>>>> from vhost-user backends.
>>>>>>> There are many devices that could already
>>>>>>> benefit of this feature, e.g.,
>>>>>>> virtiofs or virtio-gpu.
>>>>>>>
>>>>>>> After receiving the SHMEM_MAP/UNMAP request,
>>>>>>> the frontend creates the RAMBlock form the
>>>>>>> fd and maps it by adding it as a subregion
>>>>>>> of the shared memory region container.
>>>>>>>
>>>>>>> The VIRTIO Shared Memory Region list is
>>>>>>> declared in the `VirtIODevice` struct
>>>>>>> to make it generic.
>>>>>>>
>>>>>>> TODO: There was a conversation on the
>>>>>>> previous version around adding tests
>>>>>>> to the patch (which I have acknowledged).
>>>>>>> However, given the numerous changes
>>>>>>> that the patch already has, I have
>>>>>>> decided to send it early and collect
>>>>>>> some feedback while I work on the
>>>>>>> tests for the next iteration.
>>>>>>> Given that I have been able to
>>>>>>> test the implementation with
>>>>>>> my local setup, I am more or less
>>>>>>> confident that, at least, the code
>>>>>>> is in a relatively sane state
>>>>>>> so that no reviewing time is
>>>>>>> wasted on broken patches.
>>>>>>>
>>>>>>> This patch also includes:
>>>>>>> - SHMEM_CONFIG frontend request that is
>>>>>>> specifically meant to allow generic
>>>>>>> vhost-user-device frontend to be able to
>>>>>>> query VIRTIO Shared Memory settings from the
>>>>>>> backend (as this device is generic and agnostic
>>>>>>> of the actual backend configuration).
>>>>>>>
>>>>>>> - MEM_READ/WRITE backend requests are
>>>>>>> added to deal with a potential issue when having
>>>>>>> multiple backends sharing a file descriptor.
>>>>>>> When a backend calls SHMEM_MAP it makes
>>>>>>> accessing to the region fail for other
>>>>>>> backend as it is missing from their translation
>>>>>>> table. So these requests are a fallback
>>>>>>> for vhost-user memory translation fails.
>>>>>>
>>>>>> Can you elaborate what the issue here is?
>>>>>>
>>>>>> Why would SHMEM_MAP make accessing the region fail for other backends --
>>>>>> what makes this missing from their translation?
>>>>>
>>>>> This issue was raised by Stefan Hajnoczi in one of the first
>>>>> iterations of this patchset, based upon previous David Gilbert's work
>>>>> on the virtiofs DAX Window.
>>>>>
>>>>> Let me paste here some of his remarks:
>>>>>
>>>>> """
>>>>> Other backends don't see these mappings. If the guest submits a vring
>>>>> descriptor referencing a mapping to another backend, then that backend
>>>>> won't be able to access this memory.
>>>>> """
>>>>> [...]
>>>>> """
>>>>> A bit more detail:
>>>>>
>>>>> Device A has a VIRTIO Shared Memory Region. An application mmaps that
>>>>> memory (examples: guest userspace driver using Linux VFIO, a guest
>>>>> kernel driver that exposes the memory to userspace via mmap, or guest
>>>>> kernel DAX). The application passes that memory as an I/O buffer to
>>>>> device B (e.g. O_DIRECT disk I/O).
>>>>>
>>>>> The result is that device B's vhost-user backend receives a vring
>>>>> descriptor that points to a guest memory address in device A's VIRTIO
>>>>> Shared Memory Region. Since device B does not have this memory in its
>>>>> table, it cannot translate the address and the device breaks.
>>>>> """
>>>>>
>>>>> I have not triggered the issue myself. So the idea is that the next
>>>>> patch will *definitively* include some testing for the commits that I
>>>>> cannot verify with my local setup.
>>>>
>>>> Hah! But isn't that exact problem which is now solved by our rework?
>>>>
>>>> Whatever is mapped in the VIRTIO Shared Memory Region will be
>>>> communicated to all other vhost-user devices. So they should have that
>>>> memory in their map and should be able to access it.
>>>
>>> You mean the SET_MEM_TABLE message after the vhost_commit is sent to
>>> all vhost-user devices? I was not sure, as I was testing with a single
>>> device, that would be great, and simplify the patch a lot.
>>
>> Yes, all vhost-user devices should be updated.
> 
> Then, I think I agree with you, it would seem that this approach
> naturally solved the issue with address translation among different
> devices, as they all get the most up-to-date memory table after each
> mmap.
> 
> WDYT, @Stefan Hajnoczi ?
> If we are unsure, maybe we can leave the MEM_READ/WRITE support as a
> later extension, and try to integrate the rest of this patch first.

As commented offline, maybe one would want the option to enable the 
alternative mode, where such updates (in the SHM region) are not sent to 
vhost-user devices. In such a configuration, the MEM_READ / MEM_WRITE 
would be unavoidable.

What comes to mind are vhost-user devices with limited number of 
supported memslots.

No idea how relevant that really is, and how many SHM regions we will 
see in practice.

I recently increased the number of supported memslots for rust-vmm and 
libvhost-user, but not sure about other devices (in particular, dpdk, 
spdk, and whether we really care about that here).

-- 
Cheers,

David / dhildenb


