Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F3D597B0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 22:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAz25-0003nT-Az; Tue, 12 Nov 2024 17:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAz21-0003n2-4F
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAz1z-00089S-Bt
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 17:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731449198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ahnn79TADEjKAzoyWfeCGkoaSmp2qpuLj1GWLCV4zsc=;
 b=VsFXtKpbMTF4yo4Gt6K3xlPFuitbwlVMbdl8jflCtu4/PZvRv1BvvTRsDY1oPrdo2dFeOx
 GWof7kRJz39Qt195OIKkaNB//e2UX5RTw2EiQKVS+hFJdgmnesNo+fsgK4xT9Nr1308QDw
 fmJF+QCvxD44VDixe0fRylB4xJmOf9M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-LIc5RA2SNY28Frl7ATBO7g-1; Tue, 12 Nov 2024 17:06:36 -0500
X-MC-Unique: LIc5RA2SNY28Frl7ATBO7g-1
X-Mimecast-MFC-AGG-ID: LIc5RA2SNY28Frl7ATBO7g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d52ca258eso3165714f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 14:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731449195; x=1732053995;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ahnn79TADEjKAzoyWfeCGkoaSmp2qpuLj1GWLCV4zsc=;
 b=RrN6HJjIW5KHrdZJ8UqUHQYb4xy7ngy3AoaiiEZqqUJoZqZ+Dtex7YCdsvDIyRKY3M
 ex9nthonkFD8sv7iYRRixkAGVCawc7G6Cc0emFfQ/DrPRQWEzhwx9Lm8iuMpdnOJQoNJ
 2zemKFsamKwTfC74SqGKXUvlwxqGCYcCsNgXhET/N0z+sdmxok/yLy2AfBVaFzt17XM+
 hGuFYhAGEnfwsRQz/9OoHWzWKHSh82CTvNqTTJb7b4bsrGiVGshwQm3iiT/MDiS7MS+i
 SwAuchlL2/IXdctePoNqaUjt5Jvtlb0xmEBHf7UKChu1kjAwJqi1FlW4Z+JI3krQq6Op
 mzgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrZbYEOnRCARFLhVYAIhsoehgNfecEi2jM2QhBnaSqUPsrDM9z2HLbY7vBlWc9rAdAAsegBYVxgYsQ@nongnu.org
X-Gm-Message-State: AOJu0Ywlh+idkAZHcVmaqn4v6MbTnLmEiNv1zlpAZMV/U0CYGB+QPwee
 QMK8/lOE0jpuiA/1/FNPjmFKEcZCdGlRRtUZPVln/B+QJyHWoBhbwyEjmTHufUtHAsdysBhktT9
 XEOPeDlGuPwm6rEJu/irPRfOFcA8NRAsD26HXC5MtI2WyhD3wO41q
X-Received: by 2002:a5d:6d8e:0:b0:37c:d12c:17e5 with SMTP id
 ffacd0b85a97d-3820811217emr3588744f8f.23.1731449195602; 
 Tue, 12 Nov 2024 14:06:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcbBebpMtner29jbOwvoyZcdoK71kVKtklpF2i0Z+c9Kj4VQT14/d0Qj2MnJAVQiKajPTQIQ==
X-Received: by 2002:a5d:6d8e:0:b0:37c:d12c:17e5 with SMTP id
 ffacd0b85a97d-3820811217emr3588720f8f.23.1731449195206; 
 Tue, 12 Nov 2024 14:06:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d?
 (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de.
 [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432d55417f3sm793925e9.34.2024.11.12.14.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 14:06:33 -0800 (PST)
Message-ID: <fb1529d9-4c92-4bdd-8dae-404a49cfd7b3@redhat.com>
Date: Tue, 12 Nov 2024 23:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] system/physmem: poisoned memory discard on reboot
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <e2ac7ad0-aa26-4af2-8bb3-825cba4ffca0@redhat.com>
 <20241107102126.2183152-1-william.roche@oracle.com>
 <20241107102126.2183152-3-william.roche@oracle.com>
 <b0e80857-b9cb-4e93-81bd-93e8dc4b1d51@redhat.com>
 <a79a2639-a6f1-4ca1-9b12-d4e125d894d4@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a79a2639-a6f1-4ca1-9b12-d4e125d894d4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

>> For shared memory we really need it.
>>
>> Private file-backed is weird ... because we don't know if the shared or
>> the private page is problematic ... :(
> 
> 
> I agree with you, and we have to decide when should we bail out if
> ram_block_discard_range() doesn't work.
> According to me, if discard doesn't work and we are dealing with
> file-backed largepages (shared or not) we have to exit, because the
> fallocate is mandatory. It is the case with hugetlbfs.
 > > In the non-file-backed case, or the file-backed non-largepage private
> case, according to me we can trust the mmap() method to put everything
> back in place for the VM reset to work as expected.
> Are there aspects I don't see, and for which mmap + the remap handler is
> not sufficient and we should also bail out here ?

mmap() will only zap anonymous pages, no pagecache pages. See below.

>>
>> Maybe we should just do:
>>
>> if (block->fd >= 0) {
>>       /* mmap(MAP_FIXED) cannot reliably zap our problematic page. */
>>       error_report(...);
>>       exit(-1);
>> }
>>
>> Or alternatively
>>
>> if (block->fd >= 0 && qemu_ram_is_shared(block)) {
>>       /* mmap() cannot possibly zap our problematic page. */
>>       error_report(...);
>>       exit(-1);
>> } else if (block->fd >= 0) {
>>       /*
>>        * MAP_PRIVATE file-backed ... mmap() can only zap the private
>>        * page, not the shared one ... we don't know which one is
>>        * problematic.
>>        */
>>       warn_report(...);
>> }
> 
> I also agree that any file-backed/shared case should bail out if discard
> (fallocate) fails, no mater large or standard pages are used.
> 
> In the case of file-backed private standard pages, I think that a poison
> on the private page can be fixed with a new mmap.
> According to me, there are 2 cases to consider: at the moment the poison
> is seen, the page was dirty (so it means that it was a pure private
> page), or the page was not dirty, and in this case the poison could
> replace this non-dirty page with a new copy of the file content.
> In both cases, I'd say that the remap should clean up the poison.

Let's assume we have mmap(MAP_RIVATE, fd). The following scenarios are 
possible:

(a) We only have a pagecache page (never written) that is poisoned
	-> mmap(MAP_FIXED) cannot resolve that

(b) We only have an anonymous page (e.g., pagecache truncated, or if the
     hugetlb file was empty) that is poisoned
	-> mmap(MAP_FIXED) can resolve that

(c) We have an anonymous and a pagecache page (written -> COW).
(c1) Anonymous page is poisoned -> mmap(MAP_FIXED) can resolve that
(c2) Pagecache page is poisoned -> mmap(MAP_FIXED) cannot resolve that


So mmap(MAP_FIXED) cannot sort out all cases. In practice, (a) and (c2) 
are uncommon, but possible.

(b) is common with hugetlb. (a) and (c) are uncommon with hugetlb, just 
because of the nature of hugetlb pages being a scarce resource.

And IIRC, (b) with hugetlb should should be sorted out with 
mmap(MAP_FIXED). Please double-check.

> 
> So the conditions when discard fails, could be something like:
> 
>      if (block->fd >= 0 && (qemu_ram_is_shared(block) ||
>          (length > TARGET_PAGE_SIZE))) {
>          /* punch hole is mandatory, mmap() cannot possibly zap our page*/
>           error_report("%spage recovery failure addr: "
>                        RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
>                        (length > TARGET_PAGE_SIZE) ? "large " : "",
>                        length, addr);

I'm not sure if we should be special-casing hugetlb.

If we want to be 100% sure, we will do

if (block->fd >= 0) {
	error_report();
	exit(1);
}

But we could decide to be "nice" to hugetlb and assume (b) for them 
above: that is, we would do

/*
  * mmap() cannot zap pagecache pages, only anonymous pages. As soon as
  * we might have pagecache pages involved (either private or shared
  * mapping), we must be careful. However, MAP_PRIVATE on empty hugetlb
  * files is common, and extremely uncommon on non-empty hugetlb files,
  * so we'll special-case them here.
  */
if (block->fd >= 0 && (qemu_ram_is_shared(block) ||
     length == TARGET_PAGE_SIZE))) {
	...
}

[in practice, we could use /proc/self/pagemap to see if we map an 
anonymous page ... but I'd rather not go down that path just yet]

But, in the end the expectation is that madvise()+fallocate() will 
usually not fail.

-- 
Cheers,

David / dhildenb


