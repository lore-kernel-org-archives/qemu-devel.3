Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96CC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujksS-0001tK-BF; Wed, 06 Aug 2025 16:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ujksO-0001sk-Kw
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ujksM-0002Mz-LJ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754512598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=htE1v45noS4uguRMboaRhzxYrbF432bL+pmmCco1OC4=;
 b=QyMUuV2Bi/xIHcvFGWLfAwnZgbWNeQB65mVxEuoQvwCz5PnXfOAgGvBuwMeC9wWqUI62Vr
 2vwjqXurOqEDvZ1d5hEOb7GTB+2BlUH4gvQMHjlUEGy01NQ9Mr4VvCHGNERJgoBAyAXuPC
 IZfnZFeiTjXDDa3MLDIW6RlW26IRXPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-P8pcHCZnPaesSV5RlBZlmw-1; Wed, 06 Aug 2025 16:36:37 -0400
X-MC-Unique: P8pcHCZnPaesSV5RlBZlmw-1
X-Mimecast-MFC-AGG-ID: P8pcHCZnPaesSV5RlBZlmw_1754512596
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-459dbbf43c0so7093205e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754512596; x=1755117396;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=htE1v45noS4uguRMboaRhzxYrbF432bL+pmmCco1OC4=;
 b=Hca/nxejomYYsQU/JGWNeU/lfwn+Do3uWStka1iMPx9njYwZFvxOWo+hpMTLyOxKi5
 6qg5MeOJJ7Yc1mOIO5ZfmQn9ZlGbYWNy2fU0bgm7EkAVWf3sVRP8J/zSIOFYSeAnsyTf
 bpTBfQq9LOJdXECwdwPUaQw8XWPA69eE52OlUi8tlhC2zlREu2CCGzX8Ofyivpe/5g6T
 GpfP7fqYdS3Z82F3U+snSD95Lf1GnatWm7Mcrrg7Ktrz+MZk9Ynsz290/5xzkcYQVHi6
 agbRMCn2WLTmGdHHWzWwDj3sJwqCQbeXlwiXe5qbZIa5j7+rSDF31ATX5i0/KAFTysKL
 6xmA==
X-Gm-Message-State: AOJu0YxEq1O3GNFT37h82MgHZ3pLfxdTFZrx+RHpvJrkg0clQrqOAwbR
 GMnELlobXxzX45LqIj4eZ/9jpNfjg8Zdcu785kHI0aRTkicHKhpyuTj2DUYsZn1TpSjSWEQ45a/
 QvOkYyx2qoroRuv/m5KATAZpMjuw0kenjqDm2I5bRZOYbbzOZwLMtWWzP
X-Gm-Gg: ASbGncssNPLXBqlWDHZm/nqsz/tFJbGwoq3M9rOhcb7239KqSGgsfy9ZcHSnGM7I06U
 /KgOPGA1E68/Ry3DIGrrBfG2ZFePANTtOkxGZyC3RTW00DpNgLGKX4K18wnfQIh5themOwvaoTl
 Hdm9c0auU2zoJx17VZzHvwVDX4e8vNMyBCrgGzBhFoLWr5w3hDFLJi7WAuv6c5C/RBzJd9j9++d
 PUMZBxJr5y233lOpklxivFd1NLv+Koe6yG/c7MZDe8GBlcFeBor5Xrzb2Yi2N+GP99LVzaJLcGv
 jQM6GDT2nfRTaCYdAamssYJCIlbzde/K73ZqtOxyjR9QabLa+8vC6E2v/+hzwUW3UfztKc9vdhC
 gSXRthalxdvVT2kNybrzZWe0fywz+seje03oRzBFOTM4bJFd0ygi9qIxvG/Ojd7y8Jxs=
X-Received: by 2002:a05:600c:5295:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-459edf95661mr9645095e9.7.1754512595909; 
 Wed, 06 Aug 2025 13:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq030US9ySfZzsR8pHCPXEDsJYPtVzNE1RuEXy+U2gV+7kxw+jkwDJoFU0gDrk2IBoQd85uQ==
X-Received: by 2002:a05:600c:5295:b0:456:1157:59ac with SMTP id
 5b1f17b1804b1-459edf95661mr9644875e9.7.1754512595491; 
 Wed, 06 Aug 2025 13:36:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:da00:badf:cc55:23d5:1679?
 (p200300d82f42da00badfcc5523d51679.dip0.t-ipconnect.de.
 [2003:d8:2f42:da00:badf:cc55:23d5:1679])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de91ea4csm117129745e9.10.2025.08.06.13.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 13:36:34 -0700 (PDT)
Message-ID: <6c254144-a5ee-4536-b0a1-844fb5281b7d@redhat.com>
Date: Wed, 6 Aug 2025 22:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2] memory.c: improve refcounting for RAM vs MMIO regions
To: Peter Xu <peterx@redhat.com>, Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 pbonzini@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250805081123.137064-1-aesteve@redhat.com>
 <aJO3ywz2Ej_kToU_@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJO3ywz2Ej_kToU_@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.08.25 22:15, Peter Xu wrote:
> On Tue, Aug 05, 2025 at 10:11:23AM +0200, Albert Esteve wrote:
>> v1->v2:
>> - Added documentation
>> - Explained the reasoning in the commit message
>>
>> In the last version of the SHMEM MAP/UNMAP [1] Stefan
>> raised a concern [2] about dynamically creating and
>> destroying memory regions and their lifecycle [3].
>>
>> After some discussion, David Hildenbrand proposed
>> to detect RAM regions and handle refcounting differently.
>> I tried to extend the reasoning in the commit message
>> below. If I wrote any innacuracies, please keep me
>> honest. I hope we can gather some feedback with
>> this RFC patch before sending it for inclusion.
> 
> This seems working.  Looks like so far all RAM MRs are fine with it, but
> I'm not strongly confident it's true or it'll trivially keep true in the
> future too.
> 
> Besides, this still adds some trivial complexity to memory_region_ref() on
> treating RAM/MMIO MRs differently.
 > > It also sounds like a pure "accident" that the shmem objects to be 
mapped
> from the vhost-user devices are RAMs.  I wonder what happens if we want to
> also support dynmaic MMIO regions.

Is this use case realistic?

If there is a reasonable way to prepare for such hypothetical use cases 
them while solving Albert's immediate use case, I'm all for it.

> 
> Would this work even without changing QEMU memory core?
> 
> For example, have you thought about creating a VhostUserShmemObject for
> each of the VHOST_USER_BACKEND_SHMEM_MAP request?

You mean, adding an intermediate object that remains the parent of these 
MemoryRegion?

Could work. To free a MemoryRegion, I guess we would unparent that 
intermediate object, and that object would then free the memory region 
-- unless something still references that intermediate object. Not sure 
if the memory region might keep the intermediate object still alive (no 
idea).

Certainly something to explore, Albert, can you look into that?

-- 
Cheers,

David / dhildenb


