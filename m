Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488AE77197
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2025 08:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUMSh-0002ft-Iu; Sun, 05 Jan 2025 03:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMSP-0002PF-B3
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:58:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tUMSM-00035a-DB
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 03:58:01 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165cb60719so193136705ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 00:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736067476; x=1736672276;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1CwLrbOi6jSo6J8Gyt9hPnTU2jtzVE/xu30B3J+QyDk=;
 b=LvnXNZ+TCgRMtksCevW9jhPYKT5cmeu3Clf1DcoT57fqo1eaZ06LVLqXgDaUEKslzc
 Lw9QJTPguYc8hWQre51jWU7Gg98ZeMvcD0cNP2if/y+4Y3F1vS9MgcOl3WEqkfXPuI3y
 zjv2YU1yUS+2HE94saFirhMwGPlJ9JaHrcu1Y1rKzkp61K9FNGZ4WB1KkiTUnGtA3rNp
 M0xqFqHRP5x9vplOreUv3pJtk1mnU1PacRnDqrzG3Oll8QI78gPAOe+d1Wr+4cRm0dT7
 WC4BVfBKGV2oT/fmSm5MaCyHEn13Trav9Q0IeCjLl4GuNPivMejpr7ulO3icaLjYOZJc
 mGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736067476; x=1736672276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1CwLrbOi6jSo6J8Gyt9hPnTU2jtzVE/xu30B3J+QyDk=;
 b=nbvBJL8JVpsSfXybIonrwC5oDVuSIpdq22NWHyMQNJOQ+oSgQ29Hg0MHM8Gv1CHYCe
 J5BXKRCWdZzn5eBuIXuQnetFYJmtcOcO2VHgVBJtyXNmzQGEz8jy0lKGnl1TfdyVqVkJ
 gWB0xdBRHzPGDzYb0xd/yPL25k7Tlwiea5sDndJVJyEKFHMpdlbj1ceT1QnxeaQw+gXh
 RzjvRgBBA+nsy20QZp4qa8VWS0IKtBB6izw9OQmleB+/oUbfSM8J5ykBPjbue+UVbEc/
 9PAzoPX3SU4rcUISjVXEPNoh3wAA7CKkyEDFvprcVffzKVj+glX8c6QLUZn2w/I7dHE6
 ln1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsOA6swLDwjN6OAavfSkkjswM35pgcEl42qn5ArLMi0XYVG5omQMu3xN9OJLVtUGBBa0V94LHpRpIb@nongnu.org
X-Gm-Message-State: AOJu0Yx0lpyPItk0sypb/Evp6/Yjd2UIQ31J+iZ1rIUjLER2u8IZ5f7c
 mTRoWYHPf8W7pxlC0JskUeMXOo+XFv+VdQlUFuU6BBHIn+GAoSm+GfjsV/LEPjI=
X-Gm-Gg: ASbGncvW8XgsN7IqQLr/Ij7b2Ex15x13flFQyfpJ19mxRK4Tw4gr7l6c6RFblGpUCiQ
 8j/gqwwL4niLvp1GQGGXMyjEdztyUUa0xQYLV2GaPwHrw1I84o8PF/T86tTSMRU6bi8rxj23UOJ
 W372FggBDMTvaBXNwAt63dgLsBocgZb+hQRTTGGcr8OLhWZa8HrR2+MmsUJk4IerB/SbKchWJ6t
 kVsdXIwtKRLOyMF/hdgtVgtE0o0/l8zHUL0aiZ1WfDDFiFiYJ2P03Tj0ybov4rBT6oMbQ==
X-Google-Smtp-Source: AGHT+IHiqZUW5zwXDKJGUfGkIOYJ22J8S/RGBmIEkjAJ9bMZxX3TOmbrm1UKWUAYUkJQHl0Z0OReDw==
X-Received: by 2002:a05:6a21:3989:b0:1db:e3a2:ea47 with SMTP id
 adf61e73a8af0-1e5e0461d58mr89920965637.14.1736067476199; 
 Sun, 05 Jan 2025 00:57:56 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842abd59351sm26509097a12.12.2025.01.05.00.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 00:57:55 -0800 (PST)
Message-ID: <cff2dfef-4f61-4a48-94e3-78949c67a1e4@daynix.com>
Date: Sun, 5 Jan 2025 17:57:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] memory: Update inline documentation
To: BALATON Zoltan <balaton@eik.bme.hu>
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
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
References: <20250104-san-v5-0-8b430457b09d@daynix.com>
 <20250104-san-v5-1-8b430457b09d@daynix.com>
 <alpine.LMD.2.03.2501041339480.29930@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <alpine.LMD.2.03.2501041339480.29930@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2025/01/04 21:51, BALATON Zoltan wrote:
> On Sat, 4 Jan 2025, Akihiko Odaki wrote:
>> Do not refer to "memory region's reference count"
>> -------------------------------------------------
>>
>> Now MemoryRegions do have their own reference counts, but they will not
>> be used when their owners are not themselves. However, the documentation
>> of memory_region_ref() says it adds "1 to a memory region's reference
>> count", which is confusing. Avoid referring to "memory region's
>> reference count" and just say: "Add a reference to a memory region".
>> Make a similar change to memory_region_unref() too.
>>
>> Refer to docs/devel/memory.rst for "owner"
>> ------------------------------------------
>>
>> memory_region_ref() and memory_region_unref() used to have their own
>> descriptions of "owner", but they are somewhat out-of-date and
>> misleading.
>>
>> In particular, they say "whenever memory regions are accessed outside
>> the BQL, they need to be preserved against hot-unplug", but protecting
>> against hot-unplug is not mandatory if it is known that they will never
>> be hot-unplugged. They also say "MemoryRegions actually do not have
>> their own reference count", but they actually do. They just will not be
>> used unless their owners are not themselves.
>>
>> Refer to docs/devel/memory.rst as the single source of truth instead of
>> maintaining duplicate descriptions of "owner".
>>
>> Clarify that owner may be missing
>>
>> ---------------------------------
>> A memory region may not have an owner, and memory_region_ref() and
>> memory_region_unref() do nothing for such.
> 
> The commit message is longer than the documentation it changes :-) That 
> probably means the docs could be more detailed. For example this 
> relation to the owner may be mentioned unless it's something to be 
> changed in the future to clean this up.

It's odd that the commit message is longer but there are a few reasons:
1. It describes why the old documentation is wrong. Some of such 
statements are replaced with the reference to docs/devel/memory.rst to 
make them shorter.

2. It contains information that is already described in the existing 
documentation for context.

In this particular case, the owner is already described in 
docs/devel/memory.rst extensively.

> 
>> memory: Clarify owner must not call memory_region_ref()
>> --------------------------------------------------------
>>
>> The owner must not call this function as it results in a circular
>> reference.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> include/exec/memory.h | 22 +++++++---------------
>> 1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 9458e2801d50..cd91fe0c51cf 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -1220,29 +1220,21 @@ void memory_region_init(MemoryRegion *mr,
>>                         uint64_t size);
>>
>> /**
>> - * memory_region_ref: Add 1 to a memory region's reference count
>> + * memory_region_ref: Add a reference to a memory region
>>  *
>> - * Whenever memory regions are accessed outside the BQL, they need to be
>> - * preserved against hot-unplug.  MemoryRegions actually do not have 
>> their
>> - * own reference count; they piggyback on a QOM object, their "owner".
>> - * This function adds a reference to the owner.
>> - *
>> - * All MemoryRegions must have an owner if they can disappear, even 
>> if the
>> - * device they belong to operates exclusively under the BQL.  This is 
>> because
>> - * the region could be returned at any time by memory_region_find, 
>> and this
>> - * is usually under guest control.
>> + * This function adds a reference to the owner if present.
> 
> Maybe it's just not clear to me but the title says "Add a reference to a 
> memory region" then here it says "adds a reference to the owner" and 
> does not say what happens if there's no owner present. Maybe it's better 
> to be explicit and say add 1 to the owner's ref count or do nothing if 
> owner is not present.

I wrote the title looking at other comments that describes the owner as 
"the object that tracks the region's reference count", which implies the 
region's reference count is part of the owner.

But it is confusing to to describe the owner as "the object that tracks 
the region's reference count" in the first place. A memory region has 
its own reference count that can be used to express references internal 
to the owner (and actually used in the following patch).

With v6 I have just sent, I changed to describe the owner as "the object 
that keeps the region alive". The title of this function now says "add a 
reference to the owner of a memory region".

I replaced "add 1 to ~'s reference count" with "add a reference to" to 
make in concise (to fit into 80 columns in particular). I think it's 
fine not to mention the use of counter as it is an implementation detail 
users don't have to care.

With v6, I also noted that this function does nothing when the owner is 
not present in the comment body as suggested.

> 
>> + * The owner must not call this function as it results in a circular 
>> reference.
>> + * See docs/devel/memory.rst to know about owner.
>>  *
>>  * @mr: the #MemoryRegion
>>  */
>> void memory_region_ref(MemoryRegion *mr);
>>
>> /**
>> - * memory_region_unref: Remove 1 to a memory region's reference count
>> + * memory_region_unref: Remove a reference to a memory region
>>  *
>> - * Whenever memory regions are accessed outside the BQL, they need to be
>> - * preserved against hot-unplug.  MemoryRegions actually do not have 
>> their
>> - * own reference count; they piggyback on a QOM object, their "owner".
>> - * This function removes a reference to the owner and possibly 
>> destroys it.
>> + * This function removes a reference to the owner and possibly 
>> destroys it if
>> + * present. See docs/devel/memory.rst to know about owner.
> 
> In "destroys it if present" it's not clear what "it" refers to as it can 
> either be the memory region or the owner. I guess it's the owner but 
> better state that to avoid confusion.

I modified the comment to tell that this function may destroy the owner 
along with the memory region in v6.

Regards,
Akihiko Odaki

