Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995A9C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXnS-0006wz-MM; Wed, 22 Jan 2025 05:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXnN-0006wc-Dw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:17:15 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taXnL-0000Pz-Gq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:17:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so5544735f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737541028; x=1738145828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dHBWt9A30sIUPgrMEpHDuvd9z7FUzbFZQxWzhHTtVh0=;
 b=FYNZm9rA5q/jyTEJCfbJjuu3F5tkWUP8xEkOH8OeRa6lwoMn8/IQBi6Y7PyJ6gBa+k
 dnG7YgC+/kVPIcC/MCXqJPcNuuAEbr82QrVAKxAUu0Br3TT/2VzPr32q9jXK96Ran6YF
 HHNG4iy07/dYaN4dw0LHLKyioHTl7K/u+rwMCYJqjs5fxbeo7M7lBYmaMiumaNt7Zsml
 NezWLD9gPEBc5xtpuFxxT/T/Sq27/lTYcAoK06wSfTMhmL856GAcCdIYDNPwOUjdlHTi
 GpF67mVgOrtoLRv9XfP/MeX8rg0TwolixuOrUHcElNivxrhdoLZNYG8HCjQlgqKSwEV/
 1jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737541028; x=1738145828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHBWt9A30sIUPgrMEpHDuvd9z7FUzbFZQxWzhHTtVh0=;
 b=jjpnymNlzDthHU0m43b6P9yJJdyiLeydnq0eTP65L9AZBgJfLadU9LAI8Lc1nct2Ho
 5odH9UulJFSDJ/q8IeQBvYwlGBTMIb/MhRvMiGY665khAbI9Ae1yYHaxZjT+b6h5naY1
 1ex6C//pkJwGYiZZcRUzkHJW8KT6cmv/c/8ikYZGBu8JahKPKDyR+vZ/0oIpEcVmknVe
 Xox+HL49LeFGIbIS+I0PvgI2YxYwyQ/3xTvh0uF95sVGtXzdwS1w8XesQ6Ict4wECtbi
 hnLTH4chJs2+6MyY6ArohdeokzAi+IhNjqy+59KKKLW5txLwsFnIoL5yf/kHq7WG46fK
 /UDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLzkEfFVNmWQb0A5gi3Wg3pKi8pij+VCXB9cOJgPP8liUUc1cZbqhQJ5SC+joQqGpHlKYev9w+BrCO@nongnu.org
X-Gm-Message-State: AOJu0Yy4qL8HW9ojCl+Of199pQK/YCx4x06KCP5/CUcSmgC4y/oCHM4G
 oJqyPMARnMVwWQdyU+wNshBy+CpY+ZNXNZOCyYA6mNYLJEZApAL8Mate2Szsi/c=
X-Gm-Gg: ASbGncv9WbG1Pk6WDUtmOQAwIsKjbuc6ghqCTGSspjZTGRHnrjKaf9webH/paLOa18o
 9sfAG1HcA6xqWsUk3RFZ7pRrZL9Hbc+viqAfozQ7VRXPb01yeYskh/4V2NcNas7oTqTDv+BP3x1
 JRIA1CvDKiN0EfmyZxqb5sjmDZAtLtAfPflLAdckZl4wfqULYQgfIKbvO2RbxHRXJagA9xz22Tk
 tg5iHr33N7XbhnLeitNLaG7SrrG050T9zkCVIacJDW203aIfcReFcZ/vACDoNrVGJGwvpefiPd5
 xbTxkNUgiYl9o5GVA+AlD+j9gv/e+3oq/uOlVA==
X-Google-Smtp-Source: AGHT+IFz08w7SZWsvRK6PBENtjQNTTrIGJeQrvwEqnhB6TzgeSOcJVyJCoZ3zEQ9vkl6rlSvQQbE4A==
X-Received: by 2002:a5d:6dc5:0:b0:385:df5d:622c with SMTP id
 ffacd0b85a97d-38bf57a49a9mr11938014f8f.30.1737541027652; 
 Wed, 22 Jan 2025 02:17:07 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32222ebsm15657328f8f.40.2025.01.22.02.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 02:17:07 -0800 (PST)
Message-ID: <4df5272b-b1f6-4aec-a0ee-c3de324d8000@linaro.org>
Date: Wed, 22 Jan 2025 11:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250120111503.244994-1-david@redhat.com>
 <20250120111503.244994-2-david@redhat.com>
 <5267cc69-18ec-48b1-be60-90c972922806@linaro.org>
 <de04d28c-c729-4c84-b241-1eb312586c52@redhat.com>
 <f93b6689-678e-4fbc-8091-7c99e114152a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f93b6689-678e-4fbc-8091-7c99e114152a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 22/1/25 11:13, David Hildenbrand wrote:
> On 22.01.25 11:10, David Hildenbrand wrote:
>> On 22.01.25 11:07, Philippe Mathieu-Daudé wrote:
>>> Hi David,
>>>
>>> On 20/1/25 12:14, David Hildenbrand wrote:
>>>> As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
>>>> ram_device regions"), we disallow direct access to RAM DEVICE regions.
>>>>
>>>> Let's factor out the "supports direct access" check from
>>>> memory_access_is_direct() so we can reuse it, and make it a bit 
>>>> easier to
>>>> read.
>>>>
>>>> This change implies that address_space_write_rom() and
>>>> cpu_memory_rw_debug() won't be able to write to RAM DEVICE regions. It
>>>> will also affect cpu_flush_icache_range(), but it's only used by
>>>> hw/core/loader.c after writing to ROM, so it is expected to not apply
>>>> here with RAM DEVICE.
>>>>
>>>> This fixes direct access to these regions where we don't want direct
>>>> access. We'll extend cpu_memory_rw_debug() next to also be able to 
>>>> write to
>>>> these (and IO) regions.
>>>>
>>>> This is a preparation for further changes.
>>>>
>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>     include/exec/memory.h | 30 ++++++++++++++++++++++++------
>>>>     system/physmem.c      |  3 +--
>>>>     2 files changed, 25 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>> index 3ee1901b52..bd0ddb9cdf 100644
>>>> --- a/include/exec/memory.h
>>>> +++ b/include/exec/memory.h
>>>> @@ -2985,15 +2985,33 @@ MemTxResult 
>>>> address_space_write_cached_slow(MemoryRegionCache *cache,
>>>>     int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
>>>>     bool prepare_mmio_access(MemoryRegion *mr);
>>>> +static inline bool 
>>>> memory_region_supports_direct_access(MemoryRegion *mr)
>>>> +{
>>>> +    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
>>>> +    if (memory_region_is_romd(mr)) {
>>>> +        return true;
>>>> +    }
>>>> +    if (!memory_region_is_ram(mr)) {
>>>> +        return false;
>>>> +    }
>>>> +    /*
>>>> +     * RAM DEVICE regions can be accessed directly using memcpy, 
>>>> but it might
>>>> +     * be MMIO and access using mempy can be wrong (e.g., using 
>>>> instructions not
>>>> +     * intended for MMIO access). So we treat this as IO.
>>>> +     */
>>>> +    return !memory_region_is_ram_device(mr);
>>>> +
>>>> +}
>>>> +
>>>>     static inline bool memory_access_is_direct(MemoryRegion *mr, 
>>>> bool is_write)
>>>>     {
>>>> -    if (is_write) {
>>>> -        return memory_region_is_ram(mr) && !mr->readonly &&
>>>> -               !mr->rom_device && !memory_region_is_ram_device(mr);
>>>> -    } else {
>>>> -        return (memory_region_is_ram(mr) && ! 
>>>> memory_region_is_ram_device(mr)) ||
>>>
>>> This patch is doing multiple things at once, and I'm having hard time
>>> reviewing it.
>>
>> I appreciate the review, but ... really?! :)
>>
>> 25 insertions(+), 8 deletions(-)
> 
> FWIW, I'll try to split it up ... I thought the comments added to 
> memory_region_supports_direct_access() and friends are pretty clear.

No worry, I'll give it another try. (split still welcomed, but not
blocking).


