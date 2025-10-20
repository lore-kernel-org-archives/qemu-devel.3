Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E12CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAo7R-0000ae-Aq; Mon, 20 Oct 2025 07:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAo7J-0000ZD-Q4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAo7C-0000Me-Te
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760959907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KN7n70MrxioYS4cu0mELxibPwL+asK4raqLtOJt+QMc=;
 b=fNB5uON862punyHGLDlUJgIqj3lxwR3S4QbAd/VMdYLYw0cnZ3UQODe1atuZIOBdhnSVYY
 zFOxO3tbT5cVWW76x9BS7xtO18A64FjS6WAbn5o7A0IpTmioqVyLHlmQN6A+lfnhUw0QLl
 VfMLYTkphTMyb9W0OWb7VrW0ce8Ylg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-dTa9zAXJN8WbbAYTsoroTA-1; Mon, 20 Oct 2025 07:31:46 -0400
X-MC-Unique: dTa9zAXJN8WbbAYTsoroTA-1
X-Mimecast-MFC-AGG-ID: dTa9zAXJN8WbbAYTsoroTA_1760959905
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso25078055e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760959905; x=1761564705;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KN7n70MrxioYS4cu0mELxibPwL+asK4raqLtOJt+QMc=;
 b=XaplIP5XgZTlL8sa12ofvfFS7imoTzA+F1EH4Jv/VO1Qsp13Av3py02X8lt0mA4B3I
 tHNzZ0L4Kik109b42fgLIPHlvsfRCnx1FVKxf/r+j6KwOAyRgP2Lvthi6qr1hItJ1gHt
 sBctZbtadLnQcQ8kR8pvCZ25ny8jvvsFlQWvNVZsRaNA9uz4ppNvbaUgmPKBi3SKOHYm
 +QGCw4h9A/X6TXDEqqxcBEDF6FEzgnppZEAwAlB4HPf+J9SyJO4uqvqTYlWWbV49Xfnm
 R5/TKkRjP9PoUEPNBCIWLgVEYVtiXEklwZ19BQesx0ts8hP/U0xI1vRoqOH8gkiJ9MJH
 v9vw==
X-Gm-Message-State: AOJu0Yx2l/jchH/STyq0Tzi64fJk0xrQXvE8AAKjpxt4OkzOE9EqeQgL
 mAvEDEDEM8oWclqqklv+aMFm/xlJctQySMP5GDIGUmPKf+qYOvAB/F2wY3w78MEiR9aPAYvDOdc
 xgVDsocWM6LuSqihb8daDWA0MKJklftFoZKPslL4J4G/umIdbgWNcl5ru
X-Gm-Gg: ASbGncu2/cKItfFASwZfAjGKODYWgSAEQMfT6SNo2EoEhUEx2AWFPbqv1ofwXGFPe6g
 mJYREd4SYGHHhLXH2EgGf3hSxN7UcD39ms45uju7WBaOyD2+gR0eO1auBsBNHSRnhly0HhVLmHK
 dhSr6MIavs/pFfgi5RSfxEsi1+xpmIyLNq5XHwY0l6zfcOUGe4q1QepBbBy8/HVyb4EL8kcz6pM
 7G8Dq6UT0HEe2nC5NSb9jCIVDdOepohXw5l0hLDFzmyIn//PKcHIRApyOH69zrBHfbsXFM2ilSA
 Nqc2VtL0Z7ZOJDAyJcLYNsg6MxwUgrWnSf9PCbjk5skvk0wJPuNeWc0gVi4MljpHhCmLHBzn99K
 kWaywlKoPMyuSg+QNASH5xifLf1tyukfregn63y/CGpdBl8A5rEEAAxaCm83sF04E7CP9aRnbQt
 Gnq4veWr2UbTV3JrYG40KV5kkI8sQ=
X-Received: by 2002:a05:600c:444d:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-471178ada32mr82342975e9.16.1760959904705; 
 Mon, 20 Oct 2025 04:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdA4SCA0ov0HwZqZtOA9hLZ0r2hXt+CChLrxLdGZtjAdoMk1LVF5MFx4TXn4SJQmlrm3J5tg==
X-Received: by 2002:a05:600c:444d:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-471178ada32mr82342745e9.16.1760959904224; 
 Mon, 20 Oct 2025 04:31:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce?
 (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de.
 [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a75bsm15124643f8f.23.2025.10.20.04.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 04:31:43 -0700 (PDT)
Message-ID: <944cfa69-c7ed-4e18-aab9-db23f38da1a7@redhat.com>
Date: Mon, 20 Oct 2025 13:31:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram-block-attributes: Avoid the overkill of shared memory
 with hugetlbfs backend
To: Chenyi Qiang <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
References: <20251017081445.175342-1-chenyi.qiang@intel.com>
 <bc7c734d-28c4-4abf-8049-a93e2e5e0b1f@redhat.com>
 <08e0ea1a-34dd-4700-917c-157996586c73@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <08e0ea1a-34dd-4700-917c-157996586c73@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.10.25 12:32, Chenyi Qiang wrote:
> 
> 
> On 10/17/2025 11:13 PM, David Hildenbrand wrote:
>> On 17.10.25 10:14, Chenyi Qiang wrote:
>>> Currently, private memory and shared memory have different backend in
>>> CoCo VMs. It is possible for users to specify the shared memory with
>>> hugetlbfs backend while private memory with guest_memfd backend only
>>> supports 4K page size. In this case, ram_block->page_size is different
>>> from the host page size which will trigger the assertion when getting
>>> block size. Relax the restriction to allow shared memory to use
>>> hugetlbfs backend.
>>>
>>> Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> ---
>>>    system/ram-block-attributes.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
>>> index 68e8a027032..0f39ccf9090 100644
>>> --- a/system/ram-block-attributes.c
>>> +++ b/system/ram-block-attributes.c
>>> @@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
>>>         * Because page conversion could be manipulated in the size of at least 4K
>>>         * or 4K aligned, Use the host page size as the granularity to track the
>>>         * memory attribute.
>>> +     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
>>> +     * is different from host page size. So it is not appropriate to use
>>> +     * ram_block->page_size here.
>>
>> But are we sure everything else is working as expected and that this is not a check that prevents other code from doing the wrong thing?
> 
> I think so. The block size must be 4K due to the page conversion could be in the size of 4K and we use "bitmap" to track the status.

Indeed.

> I originally missed the case of hugetlb so added an assert() here. But it is allowed to use hugetlb as shared memory backend
> before shared device assignment patches were introduced.
> 
>>
>> I recall that punching holes was problematic as the VM shares/unshared 4k chunks.
> 
> I can see the kvm_convert_memory() will skip ram_block_discard_range() if using hugetlb backend.
> It will cause the double-memory consumption (*). Any other problem?

Right.


What we should be doing is unifying the retrieval of the block size in 
ram_block_attributes_create() as well. That's where we allocate it.

So either

a) Use qemu_real_host_page_size() everywhere.

b) Use ram_block_attributes_get_block_size() everywhere.

Could be done in a separate patch.

-- 
Cheers

David / dhildenb


