Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A349D132D1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xnU-0007uo-5D; Mon, 04 Nov 2024 09:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7xnS-0007uE-UC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1t7xnP-0006UH-Jp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730729465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c3ySH2c7oIEaGe5Q+E1DUr1Zf8qHKPqGtL8d6u82utQ=;
 b=FaPu6p+QJkq+MgwJp+RtjN2jCobY8q1uNqQSi+b8YyST/W5WIrmeQrWFLqe02bgf6ruLw9
 6Nhxxpc3jyyz/FaXeMmhvqe/pv8FUBMdqCF+xUdnPs949fmAXZ+EdcwB9rt171lVYupdK2
 WgBKtk0vyv6dNzXhk+HM+naFMvCYekQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-FUgdbMVsPomQaSY9rZnShg-1; Mon, 04 Nov 2024 09:11:03 -0500
X-MC-Unique: FUgdbMVsPomQaSY9rZnShg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5ca192b8so2436050f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730729462; x=1731334262;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c3ySH2c7oIEaGe5Q+E1DUr1Zf8qHKPqGtL8d6u82utQ=;
 b=oqvwwtL5YbmixfSv8ar1GVRcJNcEhwkwMDivqunwyI4KHKP75zxzzXXZokCdwF2Hmy
 /eIYBdMDjSTa0zrgdbfYtnF21yJi+TmBRV+LQFEUQIaWfeHjf9+q/DeEdr1GSLSE4ZND
 Am9zHe8gtd4/JyupzlyeKEThIQfbnZLXOY9NN2Qnd9uv9t/pC+w1vM05PnQrnwP0c7i7
 dJororxZGYAUSpVYyB8QOeZfIBeJh94LbKTNQXu8H0vL4+iyyzg0OUgpDwgdG3n98Lk0
 xyCN1xXq7jQ0TmjbK2jNWO7zUPLwCTOA9EAQjnOVwBTH9wR6wELdI9RggMzYlzqnS4o3
 jA6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcSkj+KAOqkG0f313VjFAfd3FiLC6i5WfH8ZofDnnB2nj+3Vacy0dRFBeOYUq1dKSCgZzoAL9AUZK@nongnu.org
X-Gm-Message-State: AOJu0Yy+ije2WgCopq6KI67PpQ6AWTO2runrW/KZKwDOWxd5Aqbz2TO3
 tyviOxGNZn0ZS+I4LFpy1UU991WNEMxKjUpOAiWaXnpsezN2TBKB5Qpe6fMGYmsPhlQucmvH1RP
 JWHIQllE4K4o9/ZPgBWfCPVIJ4MygKS0oMvPAINQTcp7UohZwg7CM
X-Received: by 2002:a5d:47c5:0:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-381c130731fmr12505637f8f.3.1730729461949; 
 Mon, 04 Nov 2024 06:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6hFjDB0F0XJrdq0kgJv8qih3E08rMuuoVxRyUnFzLvVfF2/SPvSUKralawu4rx7ZUZeeuWw==
X-Received: by 2002:a5d:47c5:0:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-381c130731fmr12505605f8f.3.1730729461533; 
 Mon, 04 Nov 2024 06:11:01 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c1esm13257564f8f.12.2024.11.04.06.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:11:00 -0800 (PST)
Message-ID: <e9ffa8b7-0e2a-46fb-a2e7-af701024a7d2@redhat.com>
Date: Mon, 4 Nov 2024 15:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] accel/kvm: Keep track of the HWPoisonPage page_size
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 joao.m.martins@oracle.com
References: <ZwalK7Dq_cf-EA_0@x1n>
 <20241022213503.1189954-1-william.roche@oracle.com>
 <20241022213503.1189954-3-william.roche@oracle.com>
 <a0fda9e7-d55b-455b-aeaa-27162b6cdc65@redhat.com>
 <9b17600d-4473-4bb6-841f-00f93d86f720@oracle.com>
 <9a49fc5f-bf9e-4e72-bd3e-13975d4913bd@redhat.com>
 <ea82558c-eef1-4af6-bb90-5902f04ce06c@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ea82558c-eef1-4af6-bb90-5902f04ce06c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

> 
> Ok, I can remove the first patch that is created to track the kernel
> provided page size and pass it to the kvm_hwpoison_page_add() function,
> but we could deal with the page size at the kvm_hwpoison_page_add()
> function level as we don't rely on the kernel provided info, but just
> the RAMBlock page size.

Great!

>>> I see that ram_block_discard_range() adds more control before
>>> discarding the RAM region and can also call madvise() in addition to
>>> the fallocate punch hole for standard sized memory pages. Now as the
>>> range is supposed to be recreated, I'm not convinced that these
>>> madvise calls are necessary.
>>
>> They are the proper replacement for the mmap(MAP_FIXED) + fallocate.
>>
>> That function handles all cases of properly discarding guest RAM.
> 
> In the case of hugetlbfs pages, ram_block_discard_range() does the
> punch-hole fallocate call (and prints out the warning messages).
> The madvise call is only done when (rb->page_size ==
> qemu_real_host_page_size()) which isn't true for hugetlbfs.
> So need_madvise is false and neither QEMU_MADV_REMOVE nor
> QEMU_MADV_DONTNEED madvise calls is performed.

See my other mail regarding fallocte()+hugetlb oddities.

The warning is for MAP_PRIVATE mappings where we cannot be sure that we are
not doing harm to somebody else that is mapping the file :(

See

commit 1d44ff586f8a8e113379430750b5a0a2a3f64cf9
Author: David Hildenbrand <david@redhat.com>
Date:   Thu Jul 6 09:56:06 2023 +0200

     softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE file mapping
     
     ram_block_discard_range() cannot possibly do the right thing in
     MAP_PRIVATE file mappings in the general case.
     
     To achieve the documented semantics, we also have to punch a hole into
     the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
     of such a file.
     
     For example, using VM templating -- see commit b17fbbe55cba ("migration:
     allow private destination ram with x-ignore-shared") -- in combination with
     any mechanism that relies on discarding of RAM is problematic. This
     includes:
     * Postcopy live migration
     * virtio-balloon inflation/deflation or free-page-reporting
     * virtio-mem
     
     So at least warn that there is something possibly dangerous is going on
     when using ram_block_discard_range() in these cases.

So the warning is the best we can do to say "this is possibly very
problematic, and it might be undesirable".

For hugetlb, users should switch to using memory-backend-memfd or
memory-backend-file,share=on.

> 
> 
>>
>>>
>>> But we can also notice that this function will report the following
>>> warning in all cases of not shared file backends:
>>> "ram_block_discard_range: Discarding RAM in private file mappings is
>>> possibly dangerous, because it will modify the underlying file and
>>> will affect other users of the file"
>>
>> Yes, because it's a clear warning sign that something weird is
>> happening. You might be throwing away data that some other process might
>> be relying on.
>>
>> How are you making QEMU consume hugetlbs?
> 
> A classical way to consume (not shared) hugetlbfs pages is done with the
> creation of a file that is opened, mmapped by the Qemu instance but we
> also delete the file system entry so that if the Qemu instance dies, the
> resources are released. This file is usually not shared.

Right, see above. We should be using memory-backend-file,share=on with that,
just like we would with shmem/tmpfs :(

The ugly bit is that the legacy "-mem-path" option translates to
"memory-backend-file,share=off", and we cannot easily change that.

That option really should not be used anymore.

> 
> 
>>
>> We could suppress these warnings, but let's first see how you are able
>> to trigger it.
> 
> The warning is always displayed when such a hugetlbfs VM impacted by a
> memory error is rebooted.
> I understand the reason why we have this message, but in the case of
> hugetlbfs classical use this (new) message on reboot is probably too
> worrying...  But loosing memory is already very worrying ;)

See above; we cannot easily identify "we map this file MAP_PRIVATE
but we are guaranteed to be the single user", so punching a hole in that
file might just corrupt data for another user (e.g., VM templating) without
any warning.

Again, we could suppress the warning, but not using MAP_PRIVATE with
a hugetlb file would be even better.

(hugetlb contains other hacks that make sure that MAP_PRIVATE on a file
won't result in a double memory consumption -- with shmem/tmpfs it would
result in a double memory consumption!)

Are the users you are aware of using "-mem-path" or "-object memory-backend-file"?

We might be able to change the default for the latter with a new QEMU version,
maybe ...


-- 
Cheers,

David / dhildenb


