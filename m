Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8049FE64AB7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUPl-0007k1-Ae; Tue, 03 Dec 2024 10:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tIUPj-0007iY-F9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tIUPg-0003Xv-A5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733238125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6J2Y4dfnIHsQ9ZpXC/tv6YlmpgFNyGD4pllzESmZSFQ=;
 b=i01qamaQPM/8rZQoaXa/5veWGSbL1xX2GZEQbryusq9gp1iHTMzsvxUFKNaS4Azo4booP2
 4/hCrJyo7X0KQffp0zm0ShGgFgOS7U2XJNSlAWLkStIUi8pANQUQsNLcL6wuk9y0pbbslj
 z0SvWbifGup0A/r2LRHsnyPTBwBk4YY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-1QTddoFINoC6HlQEbBZCTA-1; Tue, 03 Dec 2024 10:00:27 -0500
X-MC-Unique: 1QTddoFINoC6HlQEbBZCTA-1
X-Mimecast-MFC-AGG-ID: 1QTddoFINoC6HlQEbBZCTA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e5e3bf60so2232770f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733238026; x=1733842826;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6J2Y4dfnIHsQ9ZpXC/tv6YlmpgFNyGD4pllzESmZSFQ=;
 b=klItZAHvHsCOwVYjpc3ljuA7TQ78znJ7IQ4gb391+4vy49ECEQGGx+MIhW1/lGDg1c
 Jtel42Y0OAw8dnBId434DFkg2SggiS7dSuv1ZGHYwHR+CKIOKjZ4oRwbzMaCc5eGYKNy
 c0t/xL41wOVtfVe3QRmGNE2xR4HRaepVsTZJo40sRaQ9UoR6fdKSeGmS/DSvvFN99OmA
 9gGQs63XuQJtDiP1XgeA7NN30BnfK8Y+hu88cFbCbwPVQHJoBudB6B699Ib0GhU21vGh
 WZsaGJJjRjkQweMZvKCjP39aVI2IBjivISoWVjnKyiDvrcPhqyfb4PIMNhz+19PWiakJ
 xh3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJVxQ4eunt5hVWSkzCufpnBqFI1hvR6VCmMQV1aSJoMFz38i7VjUq8Eo3HZ/+PDPlO9lyMLjkhizt/@nongnu.org
X-Gm-Message-State: AOJu0YzrxflGv169PO1XH25oIlXCpxQJH9m+1Jag0ZRDh9WHfVcpjglW
 UzUyBmYYN2D6dsp9YzDHHzYT38b9eTj0Lg3h+qDqhq3aw1QUZDvL4Ozu/oMaVvfHlToreNWaFJH
 W1YQYZSpkGVpsE9h93rPees1KmPxJ/pGuVVnJ2uSbYXgs9ubuJ+/e
X-Gm-Gg: ASbGncvLwY6abPMGb2lHKssd2g9rb9c8cJLYBqUaHUbwIP5gEdJVAUQ/Dnc1CgAjkgl
 NVuqqk3kvmz55jEqVKxeGlc+yAXw1rgxTtFou0k5RcY5URsmkIioLhBJb9DtJn5gGtZj9PsjuKd
 7/GX6j/sRr9tIsq7To3HX8gsiFeZERiQ7rrW/BLlqzjVtBcSu94EFzBdCDo9XyCAausmxrHnTs2
 fWG9Ksu6vkz9Y2c3DdEAzSQufOhTWEmd+LNdDIzbXWS4M0H6exZJ5Uyo4XTqLbEpm/8SgXGGQKq
 fgPGuN2OMZ5+dGnmdDgtzX4scxp1ptRptf44Xnk0oVpQ5Hgyu936tqRkHtn6MJjimXQXz7+8U+1
 z1A==
X-Received: by 2002:a05:6000:1faa:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-385fd433612mr2335769f8f.51.1733238026157; 
 Tue, 03 Dec 2024 07:00:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuEQvGQMVCQt/J8QnyNAqGFRkKQfjN2qMmstq5DnB/J7AunOYn0PqGlZOiAJU6j9oxImeqWw==
X-Received: by 2002:a05:6000:1faa:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-385fd433612mr2335711f8f.51.1733238025584; 
 Tue, 03 Dec 2024 07:00:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7?
 (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de.
 [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74fec9sm222965495e9.6.2024.12.03.07.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:00:24 -0800 (PST)
Message-ID: <fcf373b2-cb33-4764-a2bc-c95a0d76710b@redhat.com>
Date: Tue, 3 Dec 2024 16:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hugetlbfs memory HW error fixes
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241125142718.3373203-1-william.roche@oracle.com>
 <48b09647-d2ba-43e5-8e73-16fb4ace6da5@oracle.com>
 <874e2625-b5e7-4247-994a-9b341abbdceb@redhat.com>
 <e09204a4-1570-4d39-afc7-e839a0a492d8@oracle.com>
 <753a033c-7341-4a3a-8546-c31a50d35aff@redhat.com>
 <31693f78-dbef-4465-9c8e-a68a25cb4af2@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <31693f78-dbef-4465-9c8e-a68a25cb4af2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 03.12.24 15:39, William Roche wrote:
> On 12/3/24 15:08, David Hildenbrand wrote:
>> [...]
>>
>> Let me take a look at your tool below if I can find an explanation of
>> what is happening, because it's weird :)
>>
>> [...]
>>
>>>
>>> At the end of this email, I included the source code of a simplistic
>>> test case that shows that the page is replaced in the case of standard
>>> page size.
>>>
>>> The idea of this test is simple:
>>>
>>> 1/ Create a local FILE with:
>>> # dd if=/dev/zero of=./FILE bs=4k count=2
>>> 2+0 records in
>>> 2+0 records out
>>> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.000337674 s, 24.3 MB/s
>>>
>>> 2/ As root run:
>>> # ./poisonedShared4k
>>> Mapping 8192 bytes from file FILE
>>> Reading and writing the first 2 pages content:
>>> Read: Read: Wrote: Initial mem page 0
>>> Wrote: Initial mem page 1
>>> Data pages at 0x7f71a19d6000  physically 0x124fb0000
>>> Data pages at 0x7f71a19d7000  physically 0x128ce4000
>>> Poisoning 4k at 0x7f71a19d6000
>>> Signal 7 received
>>>      code 4        Signal code
>>>      addr 0x7f71a19d6000    Memory location
>>>      si_addr_lsb 12
>>> siglongjmp used
>>> Remapping the poisoned page
>>> Reading and writing the first 2 pages content:
>>> Read: Read: Initial mem page 1
>>> Wrote: Rewrite mem page 0
>>> Wrote: Rewrite mem page 1
>>> Data pages at 0x7f71a19d6000  physically 0x10c367000
>>> Data pages at 0x7f71a19d7000  physically 0x128ce4000
>>>
>>>
>>>     ---
>>>
>>> As we can see, this process:
>>> - maps the FILE,
>>> - tries to read and write the beginning of the first 2 pages
>>> - gives their physical addresses
>>> - poison the first page with a madvise(MADV_HWPOISON) call
>>> - shows the SIGBUS signal received and recovers from it
>>> - simply remaps the same page from the file
>>> - tries again to read and write the beginning of the first 2 pages
>>> - gives their physical addresses
>>>
>>
>>
>> Turns out the code will try to truncate the pagecache page using
>> mapping->a_ops->error_remove_folio().
>>
>> That, however, is only implemented on *some* filesystems.
>>
>> Most prominently, it is not implemented on shmem as well.
>>
>>
>> So if you run your test with shmem (e.g., /tmp/FILE), it doesn't work.
> 
> Correct, on tmpfs the test case fails to continue to use the memory area
> and gets a SIGBUS.  And it works with xfs.
> 
> 
> 
>>
>> Using fallocate+MADV_DONTNEED seems to work on shmem.
>>
> 
> Our new Qemu code is testing first the fallocate+MADV_DONTNEED procedure
> for standard sized pages (in ram_block_discard_range()) and only folds
> back to the mmap() use if it fails. So maybe my proposal to implement:
> 
> +                    /*
> +                     * Fold back to using mmap(), but it should not
> repair a
> +                     * shared file memory region. In this case we fail.
> +                     */
> +                    if (block->fd >= 0 && qemu_ram_is_shared(block)) {
> +                        error_report("Shared memory poison recovery
> failure addr: "
> +                                     RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
> +                                     length, addr);
> +                        exit(1);
> +                    }
> 
> Could be the right choice.

Right. But then, what about a mmap(MAP_PRIVATE, shmem), where the 
pagecache page is poisoned and needs an explicit fallocate? :)

It's all tricky. I wonder if we should just say "if it's backed by a 
file, and we cannot discard, then mmap() can't fix it reliably".

if (block->fd >= 0) {
	...
}

After all, we don't even expect the fallocate/MADV_DONTNEED to ever fail 
:) So I was also wondering if we could get rid of the mmap(MAP_FIXED) 
completely ... but who knows what older Linux kernels do.

-- 
Cheers,

David / dhildenb


