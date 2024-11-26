Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1987D3B993
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwQW-0001at-Fh; Tue, 26 Nov 2024 09:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFwQU-0001a9-8d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:20:26 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFwQS-0000pv-6A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:20:25 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724d57a9f7cso4614946b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732630823; x=1733235623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8Xsp/wgILfFCWsl1NR3Sc8ZsxXOoqphZL9JaNT7FFE=;
 b=O/tOdMcSJyOEMXbu0g0J/7lhQXV67LnSJ//t4Y0KXkUFn9WNr5EV4JK1sLQvG+LCDE
 EpXxZZrI6RzY7GODZa7mpPhW5utefez8xeKQQj98vhK0H5ym0+G1oqZjAN/YlEvPcndR
 Rge/AY1l1ntj2k2c4+U78rYhes4su4vSUsmUKXPc951oYkZKd0G49mqgzMjkE4ucw/Kw
 1v7ZDSC5KkI0L9OUtz9DVjW0QAItvPaWzupEUSGkfwUZcZHaO7wsYQeI91bdgSWeq4T6
 bmLdpN7Jfq/HP5qEXFfKpZ/j2qbqUrxzNqIwpuSiEYAmNn6vrwu7WxTLosD+v9y48gwi
 u3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630823; x=1733235623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r8Xsp/wgILfFCWsl1NR3Sc8ZsxXOoqphZL9JaNT7FFE=;
 b=uFnTxCkMXGqE0oykJ2JaIlbupiRXkIAhHobILExFu6z9/HxNcljU8YTzgvBseGj7Ki
 98f81v8xf+iVhXRrRg8UsJ68cRkOnD6pKqcSH80EwfzgKiYwYLemVzz0HmJjIGMi6Vg2
 MB0s3+2sGftKfRlFD+ApCOQXmiBoI684o0Nw+nmun+lEE1LhTFun3PwjlFQ9YrsZyvv0
 zh4VBah79TJcyFcM79PHdFUBCibWbfkpg6rdZUBvNzdknjVb76OM5y6v8iG82Q79vFgA
 IEr3k3bcoVVLmghVkYnDALLoVzZstedd+qs2jbDG8DMfB7mf/Cyf1rcdwP3uVPfIqjJq
 3Z2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbD0Ea8fkO085Oat1L/kF/J8t2D13oVucRY8ngaYdVLFcDfVczy1HIh+XIUF5g40Kt1lzXJhEboHyl@nongnu.org
X-Gm-Message-State: AOJu0YzBVSNfrLDPXP9Ftmsi94Vgv/c3ZuDfXWFPeQtRevlBO2AhEaGB
 25TUuuZgzSOS+NTSKQFybOZFXLaMpjpAtEq2RpGH2AdTqQZIByRr
X-Gm-Gg: ASbGncuQhQzNsuCmMK/+M8m5CdxtgjE2y2fDPmJpbfxod8Flu3oXef81f+TprIp8ZgV
 WXLjPFlZiPtshKlgnV6xo7y9aomwwzgAE/0w/+K6HULstarQlgPHwNkjqWXeu/UjSx87Np7v1fj
 LliLH1WRF682Acodh1IyX1LdkcNJRRtox9rIVb4RAugn79u3gxGIwpEor53hEdMazqJ6f1bxetc
 BycOidKCUnkfvQ8lmomnznctEhF6XWgW8pQ1o86ih3W5NFezgDeDJ87qwG63D7GzERW00EfQHLI
 c4uAV/NfdaKJFwCo+toZRpJ2ig==
X-Google-Smtp-Source: AGHT+IHlQQaF3I1t0IcvKQhNrMXVz6urZkkUxEzomaqH37ySkL6ceCoHtLQopIIkjssW4po7D8bjHw==
X-Received: by 2002:a17:902:f68e:b0:20e:71ee:568e with SMTP id
 d9443c01a7336-2129f2246f0mr207343065ad.13.1732630822512; 
 Tue, 26 Nov 2024 06:20:22 -0800 (PST)
Received: from ?IPV6:240e:360:7d01:c00:3df6:d95:4ef4:2f85? ([212.107.30.68])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dba6782sm84523455ad.102.2024.11.26.06.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:20:21 -0800 (PST)
Message-ID: <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
Date: Tue, 26 Nov 2024 22:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
From: Wei Chen <weichenforschung@gmail.com>
In-Reply-To: <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=weichenforschung@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

 > Please provide more information how this is supposed to work

We initially discovered that virtio-mem could be used by a malicious
agent to trigger the Rowhammer vulnerability and further achieve a VM
escape.

Simply speaking, Rowhammer is a DRAM vulnerability where frequent access
to a memory location might cause voltage leakage to adjacent locations,
effectively flipping bits in these locations. In other words, with
Rowhammer, an adversary can modify the data stored in the memory.

For a complete attack, an adversary needs to: a) determine which parts
of the memory are prone to bit flips, b) trick the system to store
important data on those parts of memory and c) trigger bit flips to
tamper important data.

Now, for an attacker who only has access to their VM but not to the
hypervisor, one important challenge among the three is b), i.e., to give
back the memory they determine as vulnerable to the hypervisor. This is
where the pitfall for virtio-mem lies: the attacker can modify the
virtio-mem driver in the VM's kernel and unplug memory proactively.

The current impl of virtio-mem in qemu does not check if it is valid for
the VM to unplug memory. Therefore, as is proved by our experiments,
this method works in practice.

 > whether this is a purely theoretical case, and how relevant this is in
 > practice.

In our design, on a host machine equipped with certain Intel processors
and inside a VM that a) has a passed-through PCI device, b) has a vIOMMU
and c) has a virtio-mem device, an attacker can force the EPT to use
pages that are prone to Rowhammer bit flips and thus modify the EPT to
gain read and write privileges to an arbitrary memory location.

Our efforts involved conducting end-to-end attacks on two separate
machines with the Core i3-10100 and the Xeon E2124 processors
respectively, and has achieved successful VM escapes.

 > Further, what about virtio-balloon, which does not even support
 > rejecting requests?

virtio-balloon does not work with device passthrough currently, so we
have yet to produce a feasible attack with it.

 > I recall that that behavior was desired once the driver would support
 > de-fragmenting unplugged memory blocks.

By "that behavior" do you mean to unplug memory when size <=
requested_size? I am not sure how that is to be implemented.

 > Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be allowed

That is true, but the attacker will want the capability to release a
specific sub-block.

In fact, a sub-block is still somewhat coarse, because most likely there
is only one page in a sub-block that contains potential bit flips. When
the attacker spawns EPTEs, they have to spawn enough to make sure the
target page is used to store the EPTEs.

A 2MB sub-block can store 2MB/4KB*512=262,144 EPTEs, equating to at
least 1GB of memory. In other words, the attack program exhausts 1GB of
memory just for the possibility that KVM uses the target page to store
EPTEs.


Best regards,
Wei Chen

On 2024/11/26 20:29, David Hildenbrand wrote:
> On 26.11.24 09:02, Wei Chen wrote:
>> A malicious guest can exploit virtio-mem to release memory back to the
>> hypervisor and attempt Rowhammer attacks.
>
> Please provide more information how this is supposed to work, whether 
> this is a purely theoretical case, and how relevant this is in practice.
>
> Because I am not sure how relevant and accurate this statement is, and 
> if any action is needed at all.
>
> Further, what about virtio-balloon, which does not even support 
> rejecting requests?
>
> The only case reasonable for
>> unplugging is when the size > requested_size.
>
> I recall that that behavior was desired once the driver would support 
> de-fragmenting unplugged memory blocks. I don't think drivers do that 
> today (would have to double-check the Windows one). The spec does not 
> document what is to happen in that case.
>
> Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be allowed, so 
> this change would not cover all cases. VIRTIO_MEM_REQ_UNPLUG_ALL could 
> be ratelimited -- if there is a real issue here.
>
>
>>
>> Signed-off-by: Wei Chen <weichenforschung@gmail.com>
>> Signed-off-by: Zhi Zhang <zzhangphd@gmail.com>
>> ---
>>   hw/virtio/virtio-mem.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index 80ada89551..4ef67082a2 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -671,6 +671,10 @@ static int 
>> virtio_mem_state_change_request(VirtIOMEM *vmem, uint64_t gpa,
>>           return VIRTIO_MEM_RESP_NACK;
>>       }
>>   +    if (!plug && vmem->size <= vmem->requested_size) {
>> +        return VIRTIO_MEM_RESP_NACK;
>> +    }
>> +
>>       /* test if really all blocks are in the opposite state */
>>       if ((plug && !virtio_mem_is_range_unplugged(vmem, gpa, size)) ||
>>           (!plug && !virtio_mem_is_range_plugged(vmem, gpa, size))) {
>
>

