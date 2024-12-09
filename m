Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372FFE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKlFl-00043f-2k; Mon, 09 Dec 2024 16:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKlFh-0003wn-GC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKlFd-0008Av-Lh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733779508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j96UWfCWU3VnvpcsGtLXmdB5SzrLEIh69S7WhK/JWdw=;
 b=DalBFHOJ+w321R5MiHMJ1NKDELc7SN/h89TBAhcKExErTSvKrll5y1dxvCyInyII4vLZ8S
 MnVRy1JXm5meLfpOCH5ct8FxfxhS61rX+KKNk7QfPqkePWzNCpSmoToYQQAMXY8SY+J3T8
 BdDUXTL9Zcz+HjHu3lvKRXf/a5i47pI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-FeFKNJjNPZSdRRIKckRddg-1; Mon, 09 Dec 2024 16:25:06 -0500
X-MC-Unique: FeFKNJjNPZSdRRIKckRddg-1
X-Mimecast-MFC-AGG-ID: FeFKNJjNPZSdRRIKckRddg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f15b4b6fso11669185e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733779505; x=1734384305;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j96UWfCWU3VnvpcsGtLXmdB5SzrLEIh69S7WhK/JWdw=;
 b=gA8e7czIBCRc+l2//eNnjrL8F3zeKM3/vWP6pUhu0IiBwp3+6DpHizPuStRjaQn6pN
 oav4EWJwan2QxA5Ll1OssOyo2BTZmh6BhttnBs67zpA971l6SSaQAYi4P8XJW+3q0GFu
 aC5EMBQ91/R8hCDpw/mpg7LPF3amv4fKbg4OOr8bSx9BI9zJ+bhirQt6yyYr0NC9UpGH
 4vLJeuzHUGSJ/602nffR9c2LmocvmzeqZ57hbuCDS9xYQDj+bFUKrB4OmrAjHmTCS6sa
 ozcWmDrh3QRHkItt6MdKFok+aN/QbLFJETz13fkDMWFTKo8K0Qn0WvFWLBV2RsjvMzSP
 HXyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCRT6RQvPT7tesmnrFTlb60OvY99AOpdD/MVWF5CR9NTb/f8kiFcGI7teE0oTtO7D3fh/oI0959kqP@nongnu.org
X-Gm-Message-State: AOJu0YyPgTn8ZcuJlvCDwvaL7bsYrw3B8DsnHn2msR0F34hUX+XpWAyb
 QHiLWla6HlJGp9kvG9SdtxX3+DNZXw0SOzh2ah11Qzc+a1L9EnKvmADRbtgGT9PSBAkydwEviT/
 zIvRGHd876XvxAWef6iZNReIjv4f25p8+YY6leMc2wfIOgtONI4+D
X-Gm-Gg: ASbGncummqI6tG1k49RMzxfE/0PwNrTbinX5MHeX1kXgMLCmeffnDPv0Gfwgf3+askH
 VeVCOM01KZYrQB/XSmstc6EwqIYcOkXe52IWqonmrD6gytqHpUNDeQgz/DMJmz5pAj+7e9nUoUe
 logBclmD7SjTaWuNdgu450rsjqgUmmpsWZC9XHiQrtx2LoU1Qfpo9GP/ku4ucL+Dyc73E/EpE54
 3GiPq9BD8zK0XcEYBavFJO+idzlSrcAewqyA9ROFaIX2JdH6huUjp5Z4lsCebvqSKZNeo/jjAkL
 wr5aqkVA9ByBs6OY04ae2/sQkaF6FXI2XmUujDZNA+FsrIFaQilD3bqFJBjb6+eYuiRlfy3BPn4
 pnfy7kg==
X-Received: by 2002:a05:600c:3b95:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-434fffd049fmr16474405e9.22.1733779505491; 
 Mon, 09 Dec 2024 13:25:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsJ5vUkNjuH6KMQ2ioBSBfjp4gZ50qKr8en1g+0WGIvk0YGj3Lb0lFq1enwvnvBRgI8cfHzg==
X-Received: by 2002:a05:600c:3b95:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-434fffd049fmr16474165e9.22.1733779505136; 
 Mon, 09 Dec 2024 13:25:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65?
 (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de.
 [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219096adsm14438726f8f.85.2024.12.09.13.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:25:04 -0800 (PST)
Message-ID: <4825dc70-bca4-437f-a406-df0936aada85@redhat.com>
Date: Mon, 9 Dec 2024 22:25:02 +0100
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
 <fcf373b2-cb33-4764-a2bc-c95a0d76710b@redhat.com>
 <c5789e2c-e4e1-4203-8b0a-d7aba461497d@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c5789e2c-e4e1-4203-8b0a-d7aba461497d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 06.12.24 19:26, William Roche wrote:
> On 12/3/24 16:00, David Hildenbrand wrote:
>> On 03.12.24 15:39, William Roche wrote:
>>> [...]
>>> Our new Qemu code is testing first the fallocate+MADV_DONTNEED procedure
>>> for standard sized pages (in ram_block_discard_range()) and only folds
>>> back to the mmap() use if it fails. So maybe my proposal to implement:
>>>
>>> +                    /*
>>> +                     * Fold back to using mmap(), but it should not
>>> repair a
>>> +                     * shared file memory region. In this case we fail.
>>> +                     */
>>> +                    if (block->fd >= 0 && qemu_ram_is_shared(block)) {
>>> +                        error_report("Shared memory poison recovery
>>> failure addr: "
>>> +                                     RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
>>> +                                     length, addr);
>>> +                        exit(1);
>>> +                    }
>>>
>>> Could be the right choice.
>>
>> Right. But then, what about a mmap(MAP_PRIVATE, shmem), where the
>> pagecache page is poisoned and needs an explicit fallocate? :)
>>
>> It's all tricky. I wonder if we should just say "if it's backed by a
>> file, and we cannot discard, then mmap() can't fix it reliably".
>>
>> if (block->fd >= 0) {
>>       ...
>> }
>>
>> After all, we don't even expect the fallocate/MADV_DONTNEED to ever
>> fail :) So I was also wondering if we could get rid of the
>> mmap(MAP_FIXED) completely ... but who knows what older Linux kernels do.
> 

Hi,

> I agree that we expect the ram_block_discard_range() function to be
> working on recent kernels, and to do what's necessary to reuse the
> poisoned memory area.
> 
> The case where older kernels could be a problem is where fallocate()
> would not work on a given file

In that case we cannot possibly handle it correctly in all with 
mmap(MAP_FIXED), especially not with shmem/hugetlb :/

So failing is correct.

, or madvice(MADV_DONTNEED or MADV_REMOVE)
> would not work on standard sized pages. 

I assume both can be expected to work in any reasonable Linux setup 
today (-hugetlb) :)

> As ram_block_discard_range()
> currently avoids using madvise on huge pages.

Right, because support might not be around for hugetlb.

> 
> In this case, the generic/minimal way to make the memory usable again
> (in all cases) would be to:
> - fallocate/PUNCH_HOLE the given file (if any)
> - and remap the area
> even if it's not _mandatory_ in all cases.
> 
> Would you like me to add an fallocate(PUNCH_HOLE) call in the helper
> function qemu_ram_remap_mmap() when a file descriptor is provided
> (before remapping the area) ?
 > > This way, we don't need to know if ram_block_discard_range() failed on
> the fallocate() or the madvise(); in the worst case scenario, we would
> PUNCH twice. If fallocate fails or mmap fails, we exit.
> I haven't seen a problem punching a file twice - do you see any problem ?

Hm. I'd like to avoid another fallocate(). It would really only make 
sense if we expect fallocate() to work but madvise() to fail; and I 
don't think that's our expectation.

virtio-balloon has been using ram_block_discard_range() forever, and so 
far nobody really ever reported any of the errors from the function to 
the best of my knowledge ...


> 
> Do you find this possibility acceptable ? Or should I just go for the
> immediate failure when ram_block_discard_range() fails on a case with a
> file descriptor as you suggest ?
> 
> Please let me know if you find any problem with this approach, as it
> could help to have this poison recovery scenario to work on more kernels.

I'd say, let's keep it simple. Try ram_block_discard_range() if that 
fails (a) and we have a file, bail out, (b) we don't have a file, do the 
remap().

If we ever run into issues with that approach, we can investigate why it 
fails and what to do about it (e.g., fallocate).

My best guess it that the whole remap part can be avoided completely.

-- 
Cheers,

David / dhildenb


