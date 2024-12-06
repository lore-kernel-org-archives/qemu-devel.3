Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB2E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTkc-00060u-MN; Fri, 06 Dec 2024 03:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tJTkX-0005yp-Kx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:31:45 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tJTkU-0006Xz-Fm
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:31:45 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd10cd5b10so1631197a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1733473899; x=1734078699;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qNdvYgbp/5gpmqvTOmudQf+FCHtryNnfVJm30dxXbcI=;
 b=kPFTjPXKkrYgLgmq/OzbayvGMwHLb/Nb9FAEWKPFgvUXTY0SIV47ElwlQa4a9jDnI5
 SX0mY8YgAZSlnmpI0H2CBub6lRMJpVPKgmy3EGqA2PUETcP1XaYpgBSUTlPq8D1oc7Ix
 54QISZAeLB/sR2kdSQnCz+0xw9xtEGmCY4OLxbSDH2B9FNooVKqlhwHbwEBjJIurP9mP
 XTZRRdTbZVu6j2L7LhZrsokyUkN0JtWrwXOlwfSuBcK2eL51GUFnfnlzX4Kj7Ce2zd3n
 tzl/PqtjpbPNyoWl3rbBpiKVtk0XgGFfCAbdry/oW/mshS2M1he/g8qwKeS6t/13Kgt+
 NDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733473899; x=1734078699;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNdvYgbp/5gpmqvTOmudQf+FCHtryNnfVJm30dxXbcI=;
 b=vx1W8ctQwGFN+qUcMk0BocNJ0z8uP9y1bgB/h7YZvacRR0xwaYAYHXSrIH/aCy3BIm
 8f/ChhNWVASxrPlYbNh/b671bAWrY4S0HaA1bU7jyyrSzHXlw40M6PATdSHAI6miegGC
 URw7GvlOo5dwbay2WwqjIcgjkudrzyJxcY9CkUEGgJinR880OAEl+pShW+OBWFcy7bHP
 Qhw0WWWcDnFNYLiH0I/HfAEUPwOe0DSsGjd5BSmMIhYj87QzO684iDl8dZiYkdes+GG3
 zaZ4La9qiYrrMerYQUUV4XF2fjCDplAAIZ/KCHP1RkubKRMmZyp+UaqHMCYTZ4os+uZb
 N6yw==
X-Gm-Message-State: AOJu0Ywc+CECDeOgI5pbGpOpb/Pqsvv6VDTc7ViA3xKmvlfBnAvdkzC9
 /RCKT7e19h6ekrItKfcMvq/2hQ3z/kzrrZgURrlERcePVMozjGKsY2Aqd8ztwF0=
X-Gm-Gg: ASbGncsNShqgm+8C97/nh89nx/6aDehSnB1NgF02CeKz8XZ5KV3owcJOzc0Y9C/XPLa
 yrn7+7OxIZLC1zNVC+090QhmTFti/CqvrGkhVeLgW6ekATOdFVV2QubRnnZWa3gjt0OxYFdPNDi
 uKGVX/09/h5Vy4V06QdN7YSue2JjxKGy8MtmVn3KEJ8ZKddGmHfzsh2Zp7BuoVmxmtuR2cT9BFJ
 1UGqyAqyL2I4vZKfJPT4/rGEcGWrZlIYA1ZOsSLeeDu1S/Ce615lpYmMpzi/mNwIvEEXuvR6f8l
 rQ==
X-Google-Smtp-Source: AGHT+IEF35h6dPhIPza4YOQO+P1hV8UEGz5UJFtUz80myC6mlhcWTYJQyVAi5Kgp0YeRZyfAiCA/2A==
X-Received: by 2002:a05:6a21:99a4:b0:1e0:d867:c875 with SMTP id
 adf61e73a8af0-1e18716dfedmr3413395637.36.1733473898768; 
 Fri, 06 Dec 2024 00:31:38 -0800 (PST)
Received: from [10.16.129.170] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd156ebc0fsm2542582a12.35.2024.12.06.00.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:31:38 -0800 (PST)
Message-ID: <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
Date: Fri, 6 Dec 2024 17:31:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp> <Z04lW_CdYBPJRah3@x1n>
Content-Language: en-US
In-Reply-To: <Z04lW_CdYBPJRah3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pg1-x529.google.com
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

In this email, I explain what this patch set will resolve and an
overview of this patch set. I will respond to your specific code
review comments in a separate email.

On 2024/12/03 6:23, Peter Xu wrote:
> On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
>> The previous code ignored 'impl.unaligned' and handled unaligned
>> accesses as is. But this implementation could not emulate specific
>> registers of some devices that allow unaligned access such as xHCI
>> Host Controller Capability Registers.
> I have some comment that can be naive, please bare with me..
>
> Firstly, could you provide an example in the commit message, of what would
> start working after this patch?
Sorry, I'll describe what will start working in the next version of
this patch set. I'll also provide an example here.  After applying
this patch set, a read(addr=0x2, size=2) in the xHCI Host Controller
Capability Registers region will work correctly. For example, the read
result will return 0x0110 (version 1.1.0). Previously, a
read(addr=0x2, size=2) in the Capability Register region would return
0, which is incorrect. According to the xHCI specification, the
Capability Register region does not prohibit accesses of any size or
unaligned accesses.
> IIUC things like read(addr=0x2, size=8) should already working before but
> it'll be cut into 4 times read() over 2 bytes for unaligned=false, am I
> right?
Yes, I also think so. I think the operation read(addr=0x2, size=8) in
a MemoryRegion with impl.unaligned==false should be split into
multiple aligned read() operations. The access size should depends on
the region's 'impl.max_access_size' and 'impl.min_access_size'
. Actually, the comments in 'include/exec/memory.h' seem to confirm
this behavior:

```
     /* If true, unaligned accesses are supported.  Otherwise all accesses
      * are converted to (possibly multiple) naturally aligned accesses.
      */
     bool unaligned;
```

MemoryRegionOps struct in the MemoryRegion has two members, 'valid'
and 'impl' . I think 'valid' determines the behavior of the
MemoryRegion exposed to the guest, and 'impl' determines the behavior
of the MemoryRegion exposed to the QEMU memory region manager.

Consider the situation where we have a MemoryRegion with the following
parameters:

```
MemoryRegion mr = (MemoryRegion){
     //...
     .ops = (MemoryRegionOps){
         //...
     .read = ops_read_function;
     .write = ops_write_function;
     .valid.min_access_size = 4;
     .valid.max_access_size = 4;
     .valid.unaligned = true;
     .impl.min_access_size = 2;
     .impl.max_access_size = 2;
     .impl.unaligned = false;
     };
};
```

With this MemoryRegion 'mr', the guest can read(addr=0x1, size=4)
because 'valid.unaligned' is true.  But 'impl.unaligned' is false, so
'mr.ops->read()' function does not support addr=0x1, which is
unaligned. In this situation, we need to convert the unaligned access
to multiple aligned accesses, such as:

- mr.ops->read(addr=0x0, size=2)
- mr.ops->read(addr=0x2, size=2)
- mr.ops->read(addr=0x4, size=2)

After that, we should return a result of read(addr=0x1, size=4) from
above mr.ops->read() results, I think.

I will respond to the remaining points in a separate email.

Thanks,
Tomoyuki HIROSE
>> This commit emulates an unaligned access with multiple aligned
>> accesses. Additionally, the overwriting of the max access size is
>> removed to retrive the actual max access size.
>>
>> Signed-off-by: Tomoyuki HIROSE<tomoyuki.hirose@igel.co.jp>
>> ---
>>   system/memory.c  | 147 ++++++++++++++++++++++++++++++++++++++---------
>>   system/physmem.c |   8 ---
>>   2 files changed, 119 insertions(+), 36 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 85f6834cb3..c2164e6478 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -518,27 +518,118 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
>>       return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
>>   }
>>   
>> +typedef MemTxResult (*MemoryRegionAccessFn)(MemoryRegion *mr,
>> +                                            hwaddr addr,
>> +                                            uint64_t *value,
>> +                                            unsigned size,
>> +                                            signed shift,
>> +                                            uint64_t mask,
>> +                                            MemTxAttrs attrs);
>> +
>> +static MemTxResult access_emulation(hwaddr addr,
>> +                                    uint64_t *value,
>> +                                    unsigned int size,
>> +                                    unsigned int access_size_min,
>> +                                    unsigned int access_size_max,
>> +                                    MemoryRegion *mr,
>> +                                    MemTxAttrs attrs,
>> +                                    MemoryRegionAccessFn access_fn_read,
>> +                                    MemoryRegionAccessFn access_fn_write,
>> +                                    bool is_write)
>> +{
>> +    hwaddr a;
>> +    uint8_t *d;
>> +    uint64_t v;
>> +    MemTxResult r = MEMTX_OK;
>> +    bool is_big_endian = memory_region_big_endian(mr);
>> +    void (*store)(void *, int, uint64_t) = is_big_endian ? stn_be_p : stn_le_p;
>> +    uint64_t (*load)(const void *, int) = is_big_endian ? ldn_be_p : ldn_le_p;
>> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
>> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
>> +        0 : addr % access_size;
>> +    hwaddr start = addr - round_down;
>> +    hwaddr tail = addr + size <= mr->size ? addr + size : mr->size;
> There're plenty of special considerations on addr+size over mr->size.  It
> was confusing to me at the 1st glance, because after we have MR pointer
> logically we should have clamped the size to make sure it won't get more
> than the mr->size, e.g. for address space accesses it should have happened
> in address_space_translate_internal(), translating IOs in flatviews.
>
> Then I noticed b242e0e0e2 ("exec: skip MMIO regions correctly in
> cpu_physical_memory_write_rom_internal"), also the special handling of MMIO
> in access sizes where it won't be clamped.  Is this relevant to why
> mr->size needs to be checked here, and is it intended to allow it to have
> addr+size > mr->size?
>
> If it's intended, IMHO it would be nice to add some comment explicitly or
> mention it in the commit message.  It might not be very straightforward to
> see..
>
>> +    uint8_t data[16] = {0};
>> +    g_assert(size <= 8);
>> +
>> +    for (a = start, d = data, v = 0; a < tail;
>> +         a += access_size, d += access_size, v = 0) {
>> +        r |= access_fn_read(mr, a, &v, access_size, 0, access_mask,
>> +                            attrs);
>> +        store(d, access_size, v);
> I'm slightly confused on what is the endianess of data[].  It uses store(),
> so I think it means it follows the MR's endianess.  But then..
>
>> +    }
>> +    if (is_write) {
>> +        stn_he_p(&data[round_down], size, load(value, size));
> ... here stn_he_p() should imply that data[] is using host endianess...
> Meanwhile I wonder why value should be loaded by load() - value should
> points to a u64 which is, IIUC, host-endian, while load() is using MR's
> endianess..
>
> I wonder if we could have data[] using host endianess always, then here:
>
>             stn_he_p(&data[round_down], size, *value);
>
>> +        for (a = start, d = data; a < tail;
>> +             a += access_size, d += access_size) {
>> +            v = load(d, access_size);
>> +            r |= access_fn_write(mr, a, &v, access_size, 0, access_mask,
>> +                                 attrs);
>> +        }
>> +    } else {
>> +        store(value, size, ldn_he_p(&data[round_down], size));
>> +    }
>> +
>> +    return r;
> Now when unaligned write, it'll read at most 16 byte out in data[], apply
> the changes, and write back all 16 bytes down even if only 8 bytes are new.
>
> Is this the intended behavior?  When I was thinking impl.unaligned=true, I
> thought the device should be able to process unaligned address in the MR
> ops directly.  But I could be totally wrong here, hence more of a pure
> question..
>
>> +}
>> +
>> +static bool is_access_fastpath(hwaddr addr,
>> +                               unsigned int size,
>> +                               unsigned int access_size_min,
>> +                               unsigned int access_size_max,
>> +                               MemoryRegion *mr)
>> +{
>> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
>> +    hwaddr round_down = mr->ops->impl.unaligned && addr + size <= mr->size ?
>> +        0 : addr % access_size;
>> +
>> +    return round_down == 0 && access_size <= size;
> Would it be more readable to rewrite this with some if clauses?  Something
> like:
>
> is_access_fastpath()
> {
>    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
>
>    if (access_size < access_size_min) {
>      return false;
>    }
>      
>    if (mr->ops->impl.unaligned && (addr + size <= mr->size)) {
>      return true;
>    }
>
>    return addr % access_size;
> }
>
>> +}
>> +
>> +static MemTxResult access_fastpath(hwaddr addr,
>> +                                   uint64_t *value,
>> +                                   unsigned int size,
>> +                                   unsigned int access_size_min,
>> +                                   unsigned int access_size_max,
>> +                                   MemoryRegion *mr,
>> +                                   MemTxAttrs attrs,
>> +                                   MemoryRegionAccessFn fastpath)
>> +{
>> +    MemTxResult r = MEMTX_OK;
>> +    size_t access_size = MAX(MIN(size, access_size_max), access_size_min);
>> +    uint64_t access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>> +
>> +    if (memory_region_big_endian(mr)) {
>> +        for (size_t i = 0; i < size; i += access_size) {
>> +            r |= fastpath(mr, addr + i, value, access_size,
>> +                          (size - access_size - i) * 8, access_mask, attrs);
>> +        }
>> +    } else {
>> +        for (size_t i = 0; i < size; i += access_size) {
>> +            r |= fastpath(mr, addr + i, value, access_size,
>> +                          i * 8, access_mask, attrs);
>> +        }
>> +    }
>> +
>> +    return r;
>> +}
>> +
>>   static MemTxResult access_with_adjusted_size(hwaddr addr,
>>                                         uint64_t *value,
>>                                         unsigned size,
>>                                         unsigned access_size_min,
>>                                         unsigned access_size_max,
>> -                                      MemTxResult (*access_fn)
>> -                                                  (MemoryRegion *mr,
>> -                                                   hwaddr addr,
>> -                                                   uint64_t *value,
>> -                                                   unsigned size,
>> -                                                   signed shift,
>> -                                                   uint64_t mask,
>> -                                                   MemTxAttrs attrs),
>> +                                      MemoryRegionAccessFn access_fn_read,
>> +                                      MemoryRegionAccessFn access_fn_write,
>> +                                      bool is_write,
>>                                         MemoryRegion *mr,
>>                                         MemTxAttrs attrs)
>>   {
>> -    uint64_t access_mask;
>> -    unsigned access_size;
>> -    unsigned i;
>>       MemTxResult r = MEMTX_OK;
>>       bool reentrancy_guard_applied = false;
>> +    MemoryRegionAccessFn access_fn_fastpath =
>> +        is_write ? access_fn_write : access_fn_read;
>>   
>>       if (!access_size_min) {
>>           access_size_min = 1;
>> @@ -560,20 +651,16 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>>           reentrancy_guard_applied = true;
>>       }
>>   
>> -    /* FIXME: support unaligned access? */
>> -    access_size = MAX(MIN(size, access_size_max), access_size_min);
>> -    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>> -    if (memory_region_big_endian(mr)) {
>> -        for (i = 0; i < size; i += access_size) {
>> -            r |= access_fn(mr, addr + i, value, access_size,
>> -                        (size - access_size - i) * 8, access_mask, attrs);
>> -        }
>> +    if (is_access_fastpath(addr, size, access_size_min, access_size_max, mr)) {
>> +        r |= access_fastpath(addr, value, size,
>> +                             access_size_min, access_size_max, mr, attrs,
>> +                             access_fn_fastpath);
>>       } else {
>> -        for (i = 0; i < size; i += access_size) {
>> -            r |= access_fn(mr, addr + i, value, access_size, i * 8,
>> -                        access_mask, attrs);
>> -        }
>> +        r |= access_emulation(addr, value, size,
>> +                              access_size_min, access_size_max, mr, attrs,
>> +                              access_fn_read, access_fn_write, is_write);
>>       }
>> +
>>       if (mr->dev && reentrancy_guard_applied) {
>>           mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>>       }
>> @@ -1459,13 +1546,15 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
>>                                            mr->ops->impl.min_access_size,
>>                                            mr->ops->impl.max_access_size,
>>                                            memory_region_read_accessor,
>> -                                         mr, attrs);
>> +                                         memory_region_write_accessor,
>> +                                         false, mr, attrs);
>>       } else {
>>           return access_with_adjusted_size(addr, pval, size,
>>                                            mr->ops->impl.min_access_size,
>>                                            mr->ops->impl.max_access_size,
>>                                            memory_region_read_with_attrs_accessor,
>> -                                         mr, attrs);
>> +                                         memory_region_write_with_attrs_accessor,
>> +                                         false, mr, attrs);
>>       }
>>   }
>>   
>> @@ -1553,15 +1642,17 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>>           return access_with_adjusted_size(addr, &data, size,
>>                                            mr->ops->impl.min_access_size,
>>                                            mr->ops->impl.max_access_size,
>> -                                         memory_region_write_accessor, mr,
>> -                                         attrs);
>> +                                         memory_region_read_accessor,
>> +                                         memory_region_write_accessor,
>> +                                         true, mr, attrs);
>>       } else {
>>           return
>>               access_with_adjusted_size(addr, &data, size,
>>                                         mr->ops->impl.min_access_size,
>>                                         mr->ops->impl.max_access_size,
>> +                                      memory_region_read_with_attrs_accessor,
>>                                         memory_region_write_with_attrs_accessor,
>> -                                      mr, attrs);
>> +                                      true, mr, attrs);
>>       }
>>   }
>>   
>> diff --git a/system/physmem.c b/system/physmem.c
>> index dc1db3a384..ff444140a8 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2693,14 +2693,6 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>>           access_size_max = 4;
>>       }
>>   
>> -    /* Bound the maximum access by the alignment of the address.  */
>> -    if (!mr->ops->impl.unaligned) {
>> -        unsigned align_size_max = addr & -addr;
>> -        if (align_size_max != 0 && align_size_max < access_size_max) {
>> -            access_size_max = align_size_max;
>> -        }
>> -    }
> Could you explain why this needs to be removed?
>
> Again, I was expecting the change was for a device that will have
> unaligned==true first, so this shouldn't matter.  Then I wonder why this
> behavior needs change.  But I could miss something.
>
> Thanks,
>
>> -
>>       /* Don't attempt accesses larger than the maximum.  */
>>       if (l > access_size_max) {
>>           l = access_size_max;
>> -- 
>> 2.43.0
>>

