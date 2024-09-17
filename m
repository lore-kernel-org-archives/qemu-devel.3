Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72733C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVmq-0000lW-Fs; Tue, 17 Sep 2024 06:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqVml-0000XF-6b
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqVmj-0001cA-NP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726570215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KJZ0dbb4/J8DcASF6EMvDqsfXYBlRGsfjBEpOs025G4=;
 b=ap3yRqYKCK8+swvTj4zYdvQGFDbf0tjXUQqq1taQn3ShdSw82DBoCnEqNXYGqujCjPGeGv
 EyrSQ4gPGwM9O0y+KOptUIwUpTkC2X2iE8+T/fJxPIpF/SyxZsWW/3aeP7w8G5rMcRxBeB
 teqi8ASh/keBhhdH4NZ2FmRNkHd7oAM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-cecotbV3OLqZe0muSAu9Sw-1; Tue, 17 Sep 2024 06:50:14 -0400
X-MC-Unique: cecotbV3OLqZe0muSAu9Sw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8d2e6a69b6so426238466b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 03:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726570213; x=1727175013;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KJZ0dbb4/J8DcASF6EMvDqsfXYBlRGsfjBEpOs025G4=;
 b=bGJnMzGmodklrpph3JoxvL7YRuR2eFb8/Gsohu/2ydv3+WPcnPRPKqHMHnJf+o9dNW
 BUfD+uzhRQwhy/aWOfaF72/sRFjjFpgx1lLkow+qFVZlAdfnGmVgW9BYvH8mavB2yFI6
 gqpVpA5utRqfbAelfDGayveAOIlUi0tJCunOzHcz4TX1qkCW8LqThLCJnTpJbEjXAGy9
 7FUgxnQgLBPqbO3IVHBe4LmBxOet5tlFXW2KuyzT8FTleP7D6mGTIhBWOIupVsN8oDx6
 U5nU8/Wb4e6/bMr9/6KwJhHGRTuuasNAWJiafe+w6bVSmIISE/zbQKr7+VzwF+yka4W8
 tJ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4d/cZJpwr77YFjUOcaVkIY9iXQ1dQ7BfXL22LXYLr+F+bEzVuwGagYgxirFcNkp9SlMTy/baOeD8N@nongnu.org
X-Gm-Message-State: AOJu0Yy5g8GHy7WLS3SYGQ9yA64+3e2yDMFV//YndKOWVPurlAxhOhWK
 ZWQofaWyEVUnE9vKiv9uedgl4s4zYqFXNPMNUm1v3oFYQS4F0q2AA/JHRYlMfnMzYhGSLCJpzfs
 vMdFDln2HS6/TU8xunWLc2L6uXE+Egiv2e+8f9Qrfje4X+VsFpL+8
X-Received: by 2002:a17:907:1c8c:b0:a8d:483f:5199 with SMTP id
 a640c23a62f3a-a902966a981mr1917742066b.58.1726570213216; 
 Tue, 17 Sep 2024 03:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzlkZbJdK+ynKZpUu3uavBYO6PgRgDD4hBVmtUUj7agHWvGZb4qrXAjUvIi+Wc7y4cx5pKqA==
X-Received: by 2002:a17:907:1c8c:b0:a8d:483f:5199 with SMTP id
 a640c23a62f3a-a902966a981mr1917738966b.58.1726570212757; 
 Tue, 17 Sep 2024 03:50:12 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com.
 [80.187.67.108]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061116388sm433524366b.92.2024.09.17.03.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 03:50:12 -0700 (PDT)
Message-ID: <32ed2987-6243-4137-9526-d1ce059eb5aa@redhat.com>
Date: Tue, 17 Sep 2024 12:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/14] s390x/s390-virtio-hcall: prepare for more
 diag500 hypercalls
From: David Hildenbrand <david@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-4-david@redhat.com>
 <98b3faa73073829bbe964bec21803657f7f19846.camel@linux.ibm.com>
 <9a4fedc5-d142-4b3d-90c3-2f03d628003e@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9a4fedc5-d142-4b3d-90c3-2f03d628003e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17.09.24 12:45, David Hildenbrand wrote:
> On 12.09.24 15:22, Nina Schoetterl-Glausch wrote:
>> On Tue, 2024-09-10 at 19:57 +0200, David Hildenbrand wrote:
>>> Let's generalize, abstracting the virtio bits. diag500 is now a generic
>>> hypercall to handle QEMU/KVM specific things. Explicitly specify all
>>> already defined subcodes, including legacy ones (so we know what we can
>>> use for new hypercalls).
>>>
>>> We'll rename the files separately, so git properly detects the rename.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    hw/s390x/s390-virtio-hcall.c   |  8 ++++----
>>>    hw/s390x/s390-virtio-hcall.h   | 11 ++++++-----
>>>    target/s390x/kvm/kvm.c         | 10 ++--------
>>>    target/s390x/tcg/misc_helper.c |  4 ++--
>>>    4 files changed, 14 insertions(+), 19 deletions(-)
>>>
>> [...]
>>>
>>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>>> index 94181d9281..ac292b184a 100644
>>> --- a/target/s390x/kvm/kvm.c
>>> +++ b/target/s390x/kvm/kvm.c
>>> @@ -1493,16 +1493,10 @@ static int handle_e3(S390CPU *cpu, struct kvm_run *run, uint8_t ipbl)
>>>    
>>>    static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>>
>> Might as well make the return type void then.
> 
> Agreed.
> 
>> More importantly, are you changing the behavior?
>> If I'm reading the code right, previously handle_instruction would inject an
>> additional PGM_OPERATION due to the negative return value, which does seem off to me.
>> If so, IMO this change should go into a separate patch.
> 
> You are right, agreed.

Ah, reading again, we have a "return 0;" after the 
"kvm_s390_program_interrupt", so it should work as expected.

-- 
Cheers,

David / dhildenb


