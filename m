Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1530DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAc4-0004H3-Dk; Fri, 10 Jan 2025 03:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWAc2-0004Gc-CX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:43:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWAc0-0002pM-4M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:43:26 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso29963785ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736498602; x=1737103402;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsFee2pvDLQPSF441aniBpLlIAUW/iPTyfoJH4KqGSs=;
 b=LYpIdPptycUERyfqq9YBkVOtFB7f4R9gjNBO2Ze1WNUzHs+/nfjNQVprydcKdRzTZJ
 Z0j2y7I0khIoFNipi8vZVMM1MjcoP9+XuTYFOK/Qt3oCTe9pnheo3u52FPRI0S/s1j5T
 /WSS6od5eKaUHcVrQIhLroQIWGUhQQJUdk7ZffZVAUj6pn0ypUNtosGXWbaOK+dgPBnD
 9oiw2EHIdaoqr8ensJvz6obkj4w/2dVVAMxz7BA4dE+0eyj+ssj246mQ73KsktInWKeK
 pEaEKHkUHMT6DdkvW4cY876T7hFmaOGUmZNZqTBQvmL4XlbQ0rWmH2PdPUsy/yUjV5Ql
 iB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736498602; x=1737103402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsFee2pvDLQPSF441aniBpLlIAUW/iPTyfoJH4KqGSs=;
 b=v5UFzrxm2grvJxBKRzPsWvm4Fc2V6uvJPrse7dIBR/4iB94agL6qmB8EgptO+feahV
 HhU1C1knDjCSoL9EnYQt+1KR9F7msaMB6wR5LNNJnOhSAj3CnN0Je1Hf146LdzUmTeNx
 P8GyAYi/7g3+CXeDJrdD2M3IH/vsZ01+7iBvVowRuwTDEvTknP/ZBzSeY7DfOzH47IB3
 gy+kEND69VNaQi/VKZCtTCIjxp9Spg2NCKFe/hDdwh0VF6jm9pEiX4iWhfY3oaPpAzV8
 O8a2YRpGdF3mebK91MbTCVL9MaTim1SgyraLAyCbwTb82K5EwrQ7iiyRwIGUTbUJSFyk
 Fk0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPsNOCPzhbeP3NR8OQ+LEaxMKSAe8TlNb0etZX22cE0/YUWz20WIA8icN8TtREjWaoJYiZ9HDlNfv@nongnu.org
X-Gm-Message-State: AOJu0Ywk6ekbG6oosLT2PZOIBJtRHP8hleqdJRuzUhkd7ssiq2OvSuAn
 jYeVwYzH1qg4a3hWglrq3130g7xieNZ61z64WeLIGmYYE6JOGJqjQRZQyhxbdFg=
X-Gm-Gg: ASbGncsctqAn/SyD+S15THtURLJxGbVOR1lXGFmR7ZzrH/88zb4KioC3kZcft7NsBHi
 TqJF7v+5fdDfD/hCQM/Jzvpthv5hTE9uU8FJQvUXrbIaDXNT5l/jAshUyQnr+oFz0+ETT88Igve
 KPr292iyPfkwRp1YG1DYApIxUop2mU/XT01lwzI31eXcnGao8KbYMiS805Y2RbZ25FuhQOYWXzL
 AZjcV5LfNYMUvMbyKNGdA96ylxk910rLuJiN4FEV7JTo1GAqhT1xlcUA5XpvUKMpYY=
X-Google-Smtp-Source: AGHT+IGlF7kM9rgt4370qBI2fma4lkpbWmfWuyEC4GiIAK7oUv3Tru12EkV4b1mkAIfSqeY5dkNAYg==
X-Received: by 2002:a05:6a20:1595:b0:1e1:ab63:c5e8 with SMTP id
 adf61e73a8af0-1e88d132eedmr12889834637.26.1736498602360; 
 Fri, 10 Jan 2025 00:43:22 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d405942b0sm1101747b3a.74.2025.01.10.00.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 00:43:21 -0800 (PST)
Message-ID: <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
Date: Fri, 10 Jan 2025 17:43:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu> <Z4AjkXbZeu3T94Y1@x1n>
 <Z4AldAcucTyqZ0HJ@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4AldAcucTyqZ0HJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/10 4:37, Peter Xu wrote:
> On Thu, Jan 09, 2025 at 02:29:21PM -0500, Peter Xu wrote:
>> On Thu, Jan 09, 2025 at 01:30:35PM +0100, BALATON Zoltan wrote:
>>> On Thu, 9 Jan 2025, Akihiko Odaki wrote:
>>>> Do not refer to "memory region's reference count"
>>>> -------------------------------------------------
>>>>
>>>> Now MemoryRegions do have their own reference counts, but they will not
>>>> be used when their owners are not themselves. However, the documentation
>>>> of memory_region_ref() says it adds "1 to a memory region's reference
>>>> count", which is confusing. Avoid referring to "memory region's
>>>> reference count" and just say: "Add a reference to a memory region".
>>>> Make a similar change to memory_region_unref() too.
>>>>
>>>> Refer to docs/devel/memory.rst for "owner"
>>>> ------------------------------------------
>>>>
>>>> memory_region_ref() and memory_region_unref() used to have their own
>>>> descriptions of "owner", but they are somewhat out-of-date and
>>>> misleading.
>>>>
>>>> In particular, they say "whenever memory regions are accessed outside
>>>> the BQL, they need to be preserved against hot-unplug", but protecting
>>>> against hot-unplug is not mandatory if it is known that they will never
>>>> be hot-unplugged. They also say "MemoryRegions actually do not have
>>>> their own reference count", but they actually do. They just will not be
>>>> used unless their owners are not themselves.
>>>>
>>>> Refer to docs/devel/memory.rst as the single source of truth instead of
>>>> maintaining duplicate descriptions of "owner".
>>>>
>>>> Clarify that owner may be missing
>>>>
>>>> ---------------------------------
>>>> A memory region may not have an owner, and memory_region_ref() and
>>>> memory_region_unref() do nothing for such.
>>>>
>>>> memory: Clarify owner must not call memory_region_ref()
>>>> --------------------------------------------------------
>>>>
>>>> The owner must not call this function as it results in a circular
>>>> reference.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>> include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
>>>> 1 file changed, 28 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>> index 9458e2801d50..ca247343f433 100644
>>>> --- a/include/exec/memory.h
>>>> +++ b/include/exec/memory.h
>>>> @@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
>>>>   * memory_region_add_subregion() to add subregions.
>>>>   *
>>>>   * @mr: the #MemoryRegion to be initialized
>>>> - * @owner: the object that tracks the region's reference count
>>>> + * @owner: the object that keeps the region alive
>>>>   * @name: used for debugging; not visible to the user or ABI
>>>>   * @size: size of the region; any subregions beyond this size will be clipped
>>>>   */
>>>> @@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
>>>>                          uint64_t size);
>>>>
>>>> /**
>>>> - * memory_region_ref: Add 1 to a memory region's reference count
>>>> + * memory_region_ref: Add a reference to the owner of a memory region
>>>>   *
>>>> - * Whenever memory regions are accessed outside the BQL, they need to be
>>>> - * preserved against hot-unplug.  MemoryRegions actually do not have their
>>>> - * own reference count; they piggyback on a QOM object, their "owner".
>>>> - * This function adds a reference to the owner.
>>>> - *
>>>> - * All MemoryRegions must have an owner if they can disappear, even if the
>>>> - * device they belong to operates exclusively under the BQL.  This is because
>>>> - * the region could be returned at any time by memory_region_find, and this
>>>> - * is usually under guest control.
>>>> + * This function adds a reference to the owner of a memory region to keep the
>>>> + * memory region alive. It does nothing if the owner is not present as a memory
>>>> + * region without owner will never die.
>>>> + * For references internal to the owner, use object_ref() instead to avoid a
>>>> + * circular reference.
>>>
>>> Reading this again I'm still confused by this last sentence. Do you mean
>>> references internal to the memory region should use object_ref on the memory
>>> region or that other references to the owner should use object_ref on the
>>> owner? This sentence is still not clear about that.
>>
>> Having two refcounts are definitely confusing.. especially IIRC all MRs'
>> obj->free==NULL, so the MR's refcount isn't working.  Dynamic MR's needs
>> its g_free() on its own.

We still have instance_finalize that will fire when the MR's refcount 
gets zero so it has its own use cases.

>>
>> I acked both patches, but maybe it could indeed be slightly better we drop
>> this sentence, meanwhile in patch 2 we can drop the object_ref() too: it
>> means for parent/child MRs that share the same owner, QEMU does nothing on
>> the child MRs when add subregion, because it assumes the child MR will
>> never go away when the parent is there who shares the owner.
>>
>> So maybe we try not to touch MR's refcount manually, but fix what can be
>> problematic for owner->ref only.
> 
> As an attached comment: I may have forgot some context on this issue, but I
> still remember I used to have a patch that simply detach either parent or
> child MR links when finalize().  It's here:
> 
> https://lore.kernel.org/all/ZsenKpu1czQGYz7m@x1n/
> 
> I see this issue was there for a long time so maybe we want to fix it one
> way or another.  I don't strongly feel which way to go, but personally I
> still prefer that way (I assume that can fix the same issue), and it
> doesn't have MR's refcount involved at all, meanwhile I don't see an issue
> yet with it..
> 

For this particular topic I have somewhat a strong opinion that we 
should care the two reference counters.

Indeed, dealing with two reference counters is not fun, but sometimes it 
is necessary to do reference counting correctly. Your patch is to avoid 
reference counting for tracking dependencies among regions with the same 
owner, and it does so by ignoring the reference from container to subregion.

I prefer to keep reference counting correct instead of having an 
additional ad-hoc measure that breaks reference relationships.

