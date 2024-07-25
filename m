Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39559C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWz55-0006os-DU; Thu, 25 Jul 2024 10:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sWz52-0006nd-Vk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sWz4x-0003oN-OO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721916258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=saCgkOZn0HdWWcQvpvi9Ls19Rjizl57+Xq/J8ZaLQ4s=;
 b=LZ1XX2sBGTQAO2HEtxjgKRkSYvWBGegQLv7xqrQ+TEIw8bOMNk/UeSEVO9Bqq/9sJR24YB
 JxGigyt8rNKGgTR7O96uyZA9qlpZveIar+PyR+SsRZDa6CkWudaiOX86pKp9PTTChIwp/f
 Ex8aaDRVniXqcZFAaVEoyYW5WRZCO80=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-8RMK9JS1OfyewVTYZbcyTA-1; Thu, 25 Jul 2024 10:04:17 -0400
X-MC-Unique: 8RMK9JS1OfyewVTYZbcyTA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36865706f5eso584264f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916256; x=1722521056;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=saCgkOZn0HdWWcQvpvi9Ls19Rjizl57+Xq/J8ZaLQ4s=;
 b=XfpvaSRX5mPdWqKzeKVYpExYwTuVNGF4BwVyf3MsyH4ETOh7EpoxXf4uxK6wuJc9oz
 fqHU858E82pI+6YPR9os05jwO20XIw0xjfiolNL+Ux3qKc4+MfOpiNhog2Ga9Qa5tgo9
 JEr57UUY2pwg8BEdHe+4cOAToVs7dFhVhL9sWSG7Ua7TGF6u7smDxaJ+OxSYoGujxsPQ
 4xD88t+iVIk0woSk27hDapzS/g0Xsaj+HeTOg3itX77NuUy8VC0lgEkrFtgyhsNwISjW
 inaipeZsdKDc2NRb/yeDXYk8bYRV7k/HAk1lKMyAznDF/gd3k1mF434s5D6iyS1lRcOg
 rYCg==
X-Gm-Message-State: AOJu0Yy7j8s45aokaB095YSjBQQjKRzrOMMUPzwG9NS5mXRO/7dc7tVg
 btkqudt+NZEPtrhlXy7WYG8hJnvSLoZMl9JNyQrWHFdHywAEbDBZV0W99x+BZs18wGYx2shlDeg
 9vswUVrWr11futbhk7NrxG6ndRh0hjiAmtdITu6AB1CtnLb7BWHaQ
X-Received: by 2002:a5d:45cf:0:b0:367:2945:4093 with SMTP id
 ffacd0b85a97d-36b36404e69mr1510675f8f.40.1721916255791; 
 Thu, 25 Jul 2024 07:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwL6wrZtpBw6QykADbooPfXaToyq8nHUEXSGuRQ7THzhdQbwNo8165LXTsYIxsVMkYgkaBuA==
X-Received: by 2002:a5d:45cf:0:b0:367:2945:4093 with SMTP id
 ffacd0b85a97d-36b36404e69mr1510624f8f.40.1721916255277; 
 Thu, 25 Jul 2024 07:04:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2c00:5f6:3120:375a:3e4?
 (p200300cbc7062c0005f63120375a03e4.dip0.t-ipconnect.de.
 [2003:cb:c706:2c00:5f6:3120:375a:3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b6dbbsm38355795e9.44.2024.07.25.07.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 07:04:14 -0700 (PDT)
Message-ID: <ace9bb98-1415-460f-b8f5-e50607fbce20@redhat.com>
Date: Thu, 25 Jul 2024 16:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Enable shared device assignment
To: Chenyi Qiang <chenyi.qiang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240725072118.358923-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Open
> ====
> Implementing a RamDiscardManager to notify VFIO of page conversions
> causes changes in semantics: private memory is treated as discarded (or
> hot-removed) memory. This isn't aligned with the expectation of current
> RamDiscardManager users (e.g. VFIO or live migration) who really
> expect that discarded memory is hot-removed and thus can be skipped when
> the users are processing guest memory. Treating private memory as
> discarded won't work in future if VFIO or live migration needs to handle
> private memory. e.g. VFIO may need to map private memory to support
> Trusted IO and live migration for confidential VMs need to migrate
> private memory.

"VFIO may need to map private memory to support Trusted IO"

I've been told that the way we handle shared memory won't be the way 
this is going to work with guest_memfd. KVM will coordinate directly 
with VFIO or $whatever and update the IOMMU tables itself right in the 
kernel; the pages are pinned/owned by guest_memfd, so that will just 
work. So I don't consider that currently a concern. guest_memfd private 
memory is not mapped into user page tables and as it currently seems it 
never will be.

Similarly: live migration. We cannot simply migrate that memory the 
traditional way. We even have to track the dirty state differently.

So IMHO, treating both memory as discarded == don't touch it the usual 
way might actually be a feature not a bug ;)

> 
> There are two possible ways to mitigate the semantics changes.
> 1. Develop a new mechanism to notify the page conversions between
> private and shared. For example, utilize the notifier_list in QEMU. VFIO
> registers its own handler and gets notified upon page conversions. This
> is a clean approach which only touches the notifier workflow. A
> challenge is that for device hotplug, existing shared memory should be
> mapped in IOMMU. This will need additional changes.
> 
> 2. Extend the existing RamDiscardManager interface to manage not only
> the discarded/populated status of guest memory but also the
> shared/private status. RamDiscardManager users like VFIO will be
> notified with one more argument indicating what change is happening and
> can take action accordingly. It also has challenges e.g. QEMU allows
> only one RamDiscardManager, how to support virtio-mem for confidential
> VMs would be a problem. And some APIs like .is_populated() exposed by
> RamDiscardManager are meaningless to shared/private memory. So they may
> need some adjustments.

Think of all of that in terms of "shared memory is populated, private 
memory is some inaccessible stuff that needs very special way and other 
means for device assignment, live migration, etc.". Then it actually 
quite makes sense to use of RamDiscardManager (AFAIKS :) ).

> 
> Testing
> =======
> This patch series is tested based on the internal TDX KVM/QEMU tree.
> 
> To facilitate shared device assignment with the NIC, employ the legacy
> type1 VFIO with the QEMU command:
> 
> qemu-system-x86_64 [...]
>      -device vfio-pci,host=XX:XX.X
> 
> The parameter of dma_entry_limit needs to be adjusted. For example, a
> 16GB guest needs to adjust the parameter like
> vfio_iommu_type1.dma_entry_limit=4194304.

But here you note the biggest real issue I see (not related to 
RAMDiscardManager, but that we have to prepare for conversion of each 
possible private page to shared and back): we need a single IOMMU 
mapping for each 4 KiB page.

Doesn't that mean that we limit shared memory to 4194304*4096 == 16 GiB. 
Does it even scale then?


There is the alternative of having in-place private/shared conversion 
when we also let guest_memfd manage some shared memory. It has plenty of 
downsides, but for the problem at hand it would mean that we don't 
discard on shared/private conversion.

But whenever we want to convert memory shared->private we would 
similarly have to from IOMMU page tables via VFIO. (the in-place 
conversion will only be allowed if any additional references on a page 
are gone -- when it is inaccessible by userspace/kernel).

Again, if IOMMU page tables would be managed by KVM in the kernel 
without user space intervention/vfio this would work with device 
assignment just fine. But I guess it will take a while until we actually 
have that option.

-- 
Cheers,

David / dhildenb


