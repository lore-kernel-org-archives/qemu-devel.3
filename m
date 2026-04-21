Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D270AF327BF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF6Lr-0002sj-V0; Tue, 21 Apr 2026 04:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF6Lq-0002sb-J7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wF6Lo-0006JY-IF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776759654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IdtxoJBKEeqBPrAjHxjAM6FM9fwct2mtiU1n3ybRpzU=;
 b=HzAX4h7fKlipELtk2iqb/RAQ9g2vcSs500gCXzvFjbHLfLSxhfr3IMo05Tkg5zTl5yq5F9
 S0aFcxCM1E2uzLEsN+3mIipYQStC+FSA21MFmHQfySlJMP6kupn5EEOipAxSgGpBq9I9ws
 h/NshtQ4mak8mhNtDiUvpfPIbAlMy7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-dlJfBJsWMc-FgZv_sttCmw-1; Tue, 21 Apr 2026 04:20:52 -0400
X-MC-Unique: dlJfBJsWMc-FgZv_sttCmw-1
X-Mimecast-MFC-AGG-ID: dlJfBJsWMc-FgZv_sttCmw_1776759651
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d744128b9so3239192f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776759651; x=1777364451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IdtxoJBKEeqBPrAjHxjAM6FM9fwct2mtiU1n3ybRpzU=;
 b=L5nVmplu/L+PBaixdmL26i/SufkpjvfaeY79RqaQ93E+UFfSOtRmH1uAE4xTiRpmpn
 9gSMiXKKVp9vVikVFjS/whpC2GqHwupM2YGTnk9Fv4zqJoo5c8D3osBgTMOyWzLA7Y/T
 oetzaHgMglume7xDSdvO/ZehJV6LjgKw6adgLxyEDXvoW4zMNndtUd+hOddOGB1OpC4V
 tGi/QYehrGKLoGMtDSYPhZ04BjGs/dBV+NmM9GUc+NnXVsXNTfN/dhrmMorW2fZ82rJd
 CkWplWriGY7vJukD4CjM0x4V42LZPq3Pu9NFd/9kufZpFgIlZemGCJNFOnVwJ2y+uT6s
 JqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776759651; x=1777364451;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdtxoJBKEeqBPrAjHxjAM6FM9fwct2mtiU1n3ybRpzU=;
 b=Zs6P77o31uakEutPZNNIGze6FaOjYk0B+LxLUbIDTShYU5CYlww+3lzq1DT30WzKFk
 N/G6BQ4PwRgmY/jyn+N0wEE0Yf/AXjDi3Y3wD3eMnk/ZlKrwODI4hWPsV2+fYE2T6s8Z
 UpTri3EREHQm/An1jxSh0Tedoezb26PmI5xHTCL8FH9+b+O1BiJPk9/DbK19+7ke8Y0S
 j3g6TVFQPvvP0G296+6lzfqV3gJc+wCSTfnmGHcN5BcBUHH3ZkGsUrS2BS7t8HRGatGo
 fbBauyxzNwiZhnYbFUHnFBQx8J3Udfr9V9nlpUEmgFCuFddWB51vlljgc2XwkU5ao+Rl
 K/1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bVqhDZDrb0eztOADgznnubRsqK61JXn841rhxwX03suceHrs6/jAR4FQ5OGPn7bCyrIClQuonX97F@nongnu.org
X-Gm-Message-State: AOJu0YxRcvspXV0W+AtZUffFOYc3mYHrIBTQMuhH5B809aCNGA7ZRb1N
 Gh/p4wLU9GZrUJCMr7DEGf/QWZ1Bk2q69XEzZXhcro6zOCP1LpHHF5qffx0msFlSURVHbKDdgaa
 q9LVFpyaUYlj0PvCNLFShDDpxM8UzDRLCVYoMaqNHKkNCEmzEMIgH6PQi
X-Gm-Gg: AeBDiesoq1tgU8fGG6SnFyoHQPxjzOacZia6fq+VyyrqRvmE7/Dwa/1whdhbeGWSOl7
 /Ud7DvJ+cdzgehZimKgyHon17CxRfYgt9DhQ9VGoKs9myu9vdkMH9J/qEFwvssC99rZquROaIFP
 Jdp2PnWQI1QDGD/hVL/VoIXDnbR9bziDiMtvqWdKALx7QSpPh0gWGxpuQVDdsk3OeJH2M2avp6B
 rzI+NyAKBjl0dCDiHQuSIQy+YtmKr7hvyjVEejbqN5SVXBGP4vV6EikzoRVSyj3I9vWKD78RIOd
 xRnQpJfJHkHTT9LHi33zrKYrcU+V9e3rp1j1q0goZihshdxermbI34tEcmztXWuvuBNoY0zRTQQ
 zbYnSYHHbuLdd8INayO7cF9DzGdxiPA==
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr47553075e9.21.1776759651297; 
 Tue, 21 Apr 2026 01:20:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5299:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a54514646mr47552585e9.21.1776759650762; 
 Tue, 21 Apr 2026 01:20:50 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891df9e50asm113205585e9.0.2026.04.21.01.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 01:20:50 -0700 (PDT)
Message-ID: <e12933ef-5fb1-419c-b4c3-a1a9fc89fb44@redhat.com>
Date: Tue, 21 Apr 2026 10:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Don't call MR handlers for bytes beyond
 the MR's size
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260420075159.106615-1-thuth@redhat.com>
 <CAFEAcA9=oLSEv89Y62kaVDjsdHXg00=yTnSt7W42aosm0B092w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9=oLSEv89Y62kaVDjsdHXg00=yTnSt7W42aosm0B092w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/04/2026 11.51, Peter Maydell wrote:
> On Mon, 20 Apr 2026 at 08:52, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> If a guest triggers a multi-byte read/write at the very end of a memory
>> region, the code access_with_adjusted_size() still tries to access
>> all bytes of the transfer, even if the final bytes are already beyond
>> the memory region's size. If the device handler cannot cope with those
>> accesses, bad things can happen, for example:
>>
>>   $ echo "writew 0x800064 0x4142" | \
>>     ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
>>   [I 0.000001] OPENED
>>   [R +0.001750] writew 0x800064 0x4142
>>   qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58:
>>    avr_mask_write: Assertion `offset == 0' failed.
>>   Aborted                    (core dumped)
>>
>> We really should not call MR handlers for bytes that are beyond the
>> MR's size, so let's add a check to limit the size in such cases.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> The MR in question sets .impl.max_access_size to 1 but leaves
> .valid.max_access_size at its default (which we treat as 4),
> and is then registered with an MR size of 1. Perhaps we should
> also assert on MR registration that
>    .valid.max_access_size <= the MR size ?

Sounds like a good idea, but after a doing a quick check, it seems to me 
that we've got this pattern all over the place (see e.g. the "pcspk" or 
"kvmvapic" devices), so this would require a lot of clean-up patches first...

> Though there might I suppose be cases where the MR window can be
> guest-configured to various sizes so it might in some silly setups
> be smaller than the largest permitted access size on startup.
> 
> We should also set .valid.max_access_size on this specific
> device to 1, though the fix to the core memory system is
> definitely something we should have (and that I was under
> the impression we already enforced...)

Agreed, it makes sense to fix the .valid.max_access_size in that avr device. 
I'll send a separate patch for it.

>> ---
>>   system/memory.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 56f3225b21a..2ff74c42e3f 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -531,6 +531,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>>       uint64_t access_mask;
>>       unsigned access_size;
>>       unsigned i;
>> +    unsigned int checked_size;
>>       MemTxResult r = MEMTX_OK;
>>       bool reentrancy_guard_applied = false;
>>
>> @@ -557,13 +558,21 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>>       /* FIXME: support unaligned access? */
>>       access_size = MAX(MIN(size, access_size_max), access_size_min);
>>       access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>> +
>> +    if (addr + size > mr->size) {
> 
> mr->size is an Int128 -- you can't portably do direct
> arithmetic on it like this. (We still support configs where
> there is no working __int128_t and Int128 is a struct.
> I think --enable-tcg-interpreter is one way to get that.)
> 
> There are also I think cases where addr + size might overflow.
> (addr is the within-MR offset, but we permit MR sizes up to
> and including 2^64.)

Ah, right ... I'll ponder about how to do this best (and your comment below) 
and will try to come up with a better solution.

  Thanks,
   Thomas


>> +        assert(addr < mr->size);
>> +        checked_size = mr->size - addr;
>> +    } else {
>> +        checked_size = size;
>> +    }
> 
> I wonder if this is the right place to enforce this.
> Another option would be to have memory_region_access_valid()
> do the check and return false for accesses off the end.
> The splitting of writes that we do here is only supposed to be
> handling the case of "the implementation allows smaller chunks
> than the device permits", not the "access overlaps between two
> different MRs" case (which would need to be handled much further
> up the callstack before we have identified the specific MR we
> are accessing).
> 
>> +
>>       if (devend_big_endian(mr->ops->endianness)) {
>> -        for (i = 0; i < size; i += access_size) {
>> +        for (i = 0; i < checked_size; i += access_size) {
>>               r |= access_fn(mr, addr + i, value, access_size,
>>                           (size - access_size - i) * 8, access_mask, attrs);
>>           }
>>       } else {
>> -        for (i = 0; i < size; i += access_size) {
>> +        for (i = 0; i < checked_size; i += access_size) {
>>               r |= access_fn(mr, addr + i, value, access_size, i * 8,
>>                           access_mask, attrs);
>>           }
> 
> thanks
> -- PMM
> 


