Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B456D49203
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 09:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyKh-0007SA-Fc; Mon, 18 Nov 2024 04:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tCyK8-0007Mr-49
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 04:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tCyK4-0004Rc-SZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 04:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731923130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cwJ8uSoV1kHu/a8TCuNxsNaBsx3fE7CkO6alNVgX5X0=;
 b=HzkCECuiY8a4y14RafilFUAZ6NRxmbjzzWLqJfqP29IR4gKf/Hudg8ktYiFrQfvYUPL9i5
 UwffyLvsWP3NXdcksB/cWmiEohR499DJgsDOj5yM4yBr70Jk0ETEzkC0JZooX7C/0lGMvx
 4Vs1J0JPgA1YcSdNklH5eMJ6eLYloR4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-2oDxCKcoPYimdPJIdNCPyw-1; Mon, 18 Nov 2024 04:45:29 -0500
X-MC-Unique: 2oDxCKcoPYimdPJIdNCPyw-1
X-Mimecast-MFC-AGG-ID: 2oDxCKcoPYimdPJIdNCPyw
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fcda6c1906so21587991fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 01:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731923127; x=1732527927;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cwJ8uSoV1kHu/a8TCuNxsNaBsx3fE7CkO6alNVgX5X0=;
 b=J7HrObm8NNX2HctxOlR8z4ATyYXOL1TklLwyZA2Jyy9cgU7+hK0WhX62k+JXhXh2hw
 ZzjYN99bf/MGUnmXAMTGeaL3QEN1XnTnp6jyX9xrhJYbHS1ePS61ODI3uRpYcYqNsm4u
 pvtMRlaSfmA4Mb5gWUBLHU6Qwx/MLTBaTi8gUMj4WzoXtjnJ4q2y/spSOugFlQelCDCi
 s/uJt1Yd3DIEQIOgkMRc1XW1uEop6UjXoY+LeKn4IxXABuHsHHdZzwlSODicW1i/1DEi
 +Bq56+uVkOHJjoMVumVQZw/FzN3XX9y+geOhwN/eCOCTm6eZsHlz59El1YzmDazTkbUP
 jH5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+4lC8zdfMqjkf994pN4KSsbbGL7EEQHNKuy8bPooyUfFNmNczNmRu8vLLQGcoOgmdhaSn21bWgMp9@nongnu.org
X-Gm-Message-State: AOJu0Yw5bgFu+89rdXaCcIbPndZqrbCGw2G0iq63UmcbLdkExNbIYOY5
 KyGyx/bejkqMYcN55YxgzYtyfVjIgMbbZ0+QncDtQSxQIpUipLcScbcMxKPjkM63lEcOmlWyBt1
 oD4bBQwviuISYX69n47jbQ4m5p8B56ZJ9AIwUiUk+sbyc1XItpMrt
X-Received: by 2002:ac2:4e14:0:b0:539:e58a:9704 with SMTP id
 2adb3069b0e04-53dab2a9517mr4701760e87.33.1731923127379; 
 Mon, 18 Nov 2024 01:45:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA8FS7rY5tWZSAezskr6Y4KTNRqCPcgI2GRmvTYZlxH68ufQY2j7mWrLw82jHfzpD1wa7R7Q==
X-Received: by 2002:ac2:4e14:0:b0:539:e58a:9704 with SMTP id
 2adb3069b0e04-53dab2a9517mr4701734e87.33.1731923126973; 
 Mon, 18 Nov 2024 01:45:26 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38243e09ff9sm3702928f8f.68.2024.11.18.01.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 01:45:26 -0800 (PST)
Message-ID: <439e280e-bc82-4a79-b325-d18fcf65feec@redhat.com>
Date: Mon, 18 Nov 2024 10:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] accel/kvm: Report the loss of a large memory page
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
 <20241107102126.2183152-4-william.roche@oracle.com>
 <f5b43126-acbd-4e3f-8ec4-3a5c20957445@redhat.com>
 <08e03987-3c9a-49b2-adf5-fd40e7ede0c0@oracle.com>
 <e5d6bae8-a3bd-4225-b38f-65de6b1a2b54@redhat.com>
 <386af93d-5a61-4a90-9af0-1f33fa04b0bd@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <386af93d-5a61-4a90-9af0-1f33fa04b0bd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

>> Hm, I think we should definitely be including the size in the existing
>> one. That code was written without huge pages in mind.
> 
> Yes we can do that, and get the page size at this level to pass as a
> 'page_sise' argument to kvm_hwpoison_page_add().
> 
> It would make the message longer as we will have the extra information
> about the large page on all messages when an error impacts a large page.
> We could change the messages only when we are dealing with a large page,
> so that the standard (4k) case isn't modified.

Right. And likely we should call it "huge page" instead, which is the 
Linux term for anything larger than a single page.

[...]

>>
>> With the "large page" hint you can highlight that this is special.
> 
> Right, we can do it that way. It also gives the impression that we
> somehow inject errors on a large range of the memory. Which is not the
> case. I'll send a proposal with a different formulation, so that you can
> choose.
> 

Make sense.

> 
> 
>> On a related note ...I think we have a problem. Assume we got a SIGBUS
>> on a huge page (e.g., somewhere in a 1 GiB page).
>>
>> We will call kvm_mce_inject(cpu, paddr, code) /
>> acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)
>>
>> But where is the size information? :// Won't the VM simply assume that
>> there was a MCE on a single 4k page starting at paddr?
> 
> This is absolutely right !
> It's exactly what happens: The VM kernel received the information and
> considers that only the impacted page has to be poisoned.
 > > That's also the reason why Qemu repeats the error injections every time
> the poisoned large page is accessed (for all other touched 4k pages
> located on this "memory hole").

:/

So we always get from Linux the full 1Gig range and always report the 
first 4k page essentially, on any such access, right?


BTW, should we handle duplicates in our poison list?

> 
>>
>> I'm not sure if we can inject ranges, or if we would have to issue one
>> MCE per page ... hm, what's your take on this?
> 
> I don't know of any size information about a memory error reported by
> the hardware. The kernel doesn't seem to expect any such information.
> It explains why there is no impact/blast size information provided when
> an error is relayed to the VM.
> 
> We could take the "memory hole" size into account in Qemu, but repeating
> error injections is not going to help a lot either: We'd need to give
> the VM some time to deal with an error injection before producing a new
> error for the next page etc... in the case (x86 only) where an

I had the same thoughts.

> asynchronous error is relayed with BUS_MCEERR_AO, we would also have to
> repeat the error for all the 4k pages located on the lost large page too.
> 
> We can see that the Linux kernel has some mechanisms to deal with a
> seldom 4k page loss, but a larger blast is very likely to crash the VM
> (which is fine).

Right, and that will inevitably happen when we get a MVE on a 1GiG 
hugetlb page, correct? The whole thing will be inaccessible.

> And as a significant part of the memory is no longer
> accessible, dealing with the error itself can be impaired and we
> increase the risk of loosing data, even though most of the memory on the
> large page could still be used.
> 
> Now if we can recover the 'still valid' memory of the impacted large
> page, we can significantly reduce this blast and give a much better
> chance to the VM to survive the incident or crash more gracefully.

Right. That cannot be sorted out in user space alone, unfortunately.

> 
> I've looked at the project you indicated me, which is not ready to be
> adopted:
> https://lore.kernel.org/linux-mm/20240924043924.3562257-2-jiaqiyan@google.com/T/
> 

Yes, that goes into a better direction, though.

> But we see that, this large page enhancement is needed, sometimes just
> to give a chance to the VM to survive a little longer before being
> terminated or moved.
> Injecting multiple MCEs or ACPI error records doesn't help, according to me.

I suspect that in most cases, when we get an MCE on a 1Gig page in the 
hypervisor, our running Linux guest will soon crash, because it really 
lost 1 Gig of contiguous memory. :(

-- 
Cheers,

David / dhildenb


