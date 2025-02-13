Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1291C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tia9B-0003cv-Cp; Thu, 13 Feb 2025 09:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tia8p-0003bq-HB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:24:35 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tia8n-0006QF-0d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:24:35 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso743078f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456671; x=1740061471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdcRnIDri58EWnsM3G/mJv98CRyFGaRm8Bh0qFanUAc=;
 b=Fktp+PkrAax+edpPfp/uDjGo8QXoKNnKXwiLDgnE4eeqTCzrT3gqjdegJC1yfxTyH0
 RdcXlxfqsCQ5PLGjgf6qwBVsynTFb9CqDhcdvCC4eIJvfqaXQJ7hdcIJqHuV2ZkAHfXT
 YiE6Saa+X7Wgul8Wlrn2xbJmUHp25yx+im/VqVQ5UDjLzerTp21H70i+eCZ+lUpREEad
 oXCYpSX5qur2TirfQ/4WetuO2CA9nR3neXPGi/Y8Gl8bgl8qbY813oo8l0O8dDw4CdNZ
 OwBPVlPMRxYK86WvDcszNR0EkDBQzkwPqpY5VdMSV2lO4N6qou0AuwtLiENtVXgn9QqH
 KL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456671; x=1740061471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdcRnIDri58EWnsM3G/mJv98CRyFGaRm8Bh0qFanUAc=;
 b=k91SUBhnDiGzU2F/o/2auh1v7zKXZCJ1apwHORQAbkG9CmYGXf7Wk9CnRaiixwNYHn
 jYvo1eimRPDQKTooAtpnixYkgD6NP3YJcI5kmyibbO2JByxp/AVshMwTnaqj4tHli9OI
 B6/GPUZsd/VP2WDrd1VVMhT10HDeFc5xk1BhJhpFOGQc13GRwwzs1gv6Ol4nvn5ajTMY
 jIJ+qEp2X2/5KTKOHb9d5VeLtYNG1nKzo91XnqyGzbol84U22yjwpX+u9Er3FWAmDX2K
 2c0A8B+VIXGajsiLqKlRXXyr4I1n6Vs9ypbwzL/MhFZZYYTVSi3W6zdLcaUs+OSnm/Gx
 BN3g==
X-Gm-Message-State: AOJu0Yy15CdSF0NPNyYLWUGzsxaF1z0Sd4l505x8x4xbBNqslGrCYXxg
 TVkQPFMg22O7u79YVvmP6dcf8GzHXc+ZGxu7CBjx6oa3lYAB+ZAuid/qg0sxV84=
X-Gm-Gg: ASbGncuyz6EH3md/ht91ch6r7QWD/c9TOvQ0mXFfTFDkm+EVOJqEfvNTjM6+lZOueC0
 8Uls2XGtSIlf97SWf7TvkaFYpkzSDI/U/iJV0huk3VW+aa8xY0ySihJmijPxHsgvW1d6A66eO/T
 Byfd0ApOZiNhzKyK8nxX7JUeICJTsGrXrfXpiVd/XRak91qTy2ufiw7v8ZiQ8fOx9Q9cvYJNzfy
 Wl0BdK8GKvAz0UIshU8qfWl9Y3whBAr1KpkDECaz3ZlJVxDqEUcI34m9lRI0HebKAmh8QrgfTFj
 ISSB9yUznSQprlTRZhhiIFjS/0WVCSUvdrGkpUnhmw2M6/3VWyfT17+w74P5oJBVwJhEUycuzA=
 =
X-Google-Smtp-Source: AGHT+IHoYKJCQE7bGCLgYGTHMxnFimMImAwgk0PhNQ83oKQmaGQ/CmfZTlI6ieduUnCg0Dj7RVC39w==
X-Received: by 2002:a05:6000:1f8b:b0:38d:dd43:8be5 with SMTP id
 ffacd0b85a97d-38f244e4a6cmr3957796f8f.15.1739456671185; 
 Thu, 13 Feb 2025 06:24:31 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b41b5sm2076545f8f.14.2025.02.13.06.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:24:30 -0800 (PST)
Message-ID: <cc18c5c6-1a93-4a42-b6b4-ca5f13718906@linaro.org>
Date: Thu, 13 Feb 2025 15:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <3b3baed4-0d79-3a28-40cd-e1835e078863@eik.bme.hu>
 <6e707c7f-b94c-47ef-83ab-795605e27963@linaro.org>
 <a3608e43-79ce-403d-8ba7-6735fde66759@linaro.org>
 <e1436061-a840-0942-2c2c-4f49bfb932b8@eik.bme.hu>
 <672045c1-9b09-4b7b-9bed-fa990129ce2c@linaro.org>
 <fb7045a4-20f6-a52d-5531-2410fc803bb4@eik.bme.hu>
 <0f7ea6d6-8476-4ba6-9d4f-eeb76aed04fa@redhat.com>
 <9e121e62-8e6e-61d6-dbfb-4dfda469acc5@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9e121e62-8e6e-61d6-dbfb-4dfda469acc5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 13/2/25 14:59, BALATON Zoltan wrote:
> On Thu, 13 Feb 2025, Thomas Huth wrote:
>> On 12/02/2025 23.34, BALATON Zoltan wrote:
>>> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>> On 12/2/25 17:23, BALATON Zoltan wrote:
>>>>> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>>>> On 12/2/25 14:53, Philippe Mathieu-Daudé wrote:
>>>>>>> On 12/2/25 13:56, BALATON Zoltan wrote:
>>>>>>>> On Wed, 12 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>>> On 12/2/25 12:37, Thomas Huth wrote:
>>>>>>>>>> On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
>>>>>>>>>>> Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() 
>>>>>>>>>>> macros.
>>>>>>>>>>> Endianness can be BIG, LITTLE or unspecified (default).
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>>   qapi/common.json                    | 16 ++++++++++++++++
>>>>>>>>>>>   include/hw/qdev-properties-system.h |  7 +++++++
>>>>>>>>>>>   hw/core/qdev-properties-system.c    | 11 +++++++++++
>>>>>>>>>>>   3 files changed, 34 insertions(+)
>>>>
>>>>
>>>>>>>>>>> +{ 'enum': 'EndianMode',
>>>>>>>>>>> +  'data': [ 'little', 'big', 'unspecified' ] }
>>>>>>>>>>
>>>>>>>>>> Should 'unspecified' come first? ... so that it gets the value 
>>>>>>>>>> 0, i.e. when someone forgets to properly initialize a related 
>>>>>>>>>> variable, the chances are higher that it ends up as 
>>>>>>>>>> "unspecified" than as "little" ?
>>>>>>>>>
>>>>>>>>> Hmm but then in this series the dual-endianness regions are 
>>>>>>>>> defined as:
>>>>>>>>>
>>>>>>>>> +static const MemoryRegionOps pic_ops[2] = {
>>>>>>>>> +    [0 ... 1] = {
>>>>>>>>
>>>>>>>> This is already confusing as you'd have to know that 0 and 1 
>>>>>>>> here means ENDIAN_MODE_LITTLE and ENDIAN_MODE_BIG (using those 
>>>>>>>> constants here as well might be clearer). It's easy to miss what 
>>>>>>>> this does so 
>>>>>>
>>>>>> At this point 0 / 1 only mean "from the index #0 included to the 
>>>>>> index
>>>>>> #1 included", 0 being the first one and 1 the last one.
>>>>>>
>>>>>>>> maybe repeating the definitions for each case would be longer 
>>>>>>>> but less confusing and then it does not matter what the values are.
>>>>>>
>>>>>> This is what I tried to do with:
>>>>>>
>>>>>> +    [ENDIAN_MODE_BIG].endianness = DEVICE_BIG_ENDIAN,
>>>>>> +    [ENDIAN_MODE_LITTLE].endianness = DEVICE_LITTLE_ENDIAN,
>>>>>> };
>>>>>>
>>>>>> but in v7 we are back of picking an arbitrary value.
>>>>>>
>>>>>>>> Or what uses the ops.endianness now should look at the property 
>>>>>>>> introduced by this patch to avoid having to propagate it like 
>>>>>>>> below and drop the ops.endianness? Or it should move to the 
>>>>>>>> memory region and set when the ops are assigned?
>>>>>>>
>>>>>>> I'm not understanding well what you ask, but maybe the answer is 
>>>>>>> in v7 :)
>>>>>
>>>>> I'm not sure I understand it well either. I think what I was asking 
>>>>> about is the same as what Thomas asked if this could be avoided to 
>>>>> make it necessary to allocate two separate ops for this. Looks like 
>>>>> from now on this ops struct should really loose the endianness 
>>>>> value and this should be assigned when the ops is added to the io 
>>>>> region because that's where it decides which endianness is it based 
>>>>> on the property added in this series. But I don't know if that 
>>>>> could be done or would need deeper changes as what later uses this 
>>>>> ops struct might not have access to the property and if we have a 
>>>>> single ops struct it may need to be copied to set different 
>>>>> endianness intstead of just referencing it. So I'm not sure there's 
>>>>> a better way but I think this change makes an already cryptic 
>>>>> boiler plate even more confusing for people less knowledgeable 
>>>>> about QEMU and C programming so it makes even harder to write 
>>>>> devices. But as long as it's just a few devices that need to work 
>>>>> with different endianness then it might be OK. But wasn't that what 
>>>>> NATIVE_ENDIAN was meant for? What can't that be kept then?
>>>>
>>>> Moving toward a single binary able to run heterogeneous machines, we
>>>> can't rely on a particular target endianness, so we need to remove
>>>> DEVICE_NATIVE_ENDIAN. The endianness is a property a device / machine,
>>>> not of the binary.
>>>
>>> So then can the behaviour of NATIVE_ENDIAN be changed to look at the 
>>> machine endianness instead of replacing it with a constant?
>>
>> No, that does not work. First, the machine knows about its devices, 
>> but a device should not know about the wiring of the global machine 
>> (just like in real life).
> 
> That means all devices should be either big or little endian and there 
> should be no native endian ones. Why do we have those then? That's why 
> this endianness property should either be removed from ops and only 
> attached to it when added to a machine if needed or kept to show which 
> machines it can be attached to: only big, little or both endian which is 
> what it seems to be doing now.

Well, devices don't have endianness, endianness is more a property of
the bus [*] between cpu <-> devices, how the bytes are serialized.

QEMU devices have an endianness property so the core memory can access
them using the proper ordering, see:

$ git grep -wW memory_region_big_endian
system/memory.c:356:static bool memory_region_big_endian(MemoryRegion *mr)
system/memory.c-357-{
system/memory.c-358-#if TARGET_BIG_ENDIAN
system/memory.c-359-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
system/memory.c-360-#else
system/memory.c-361-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
system/memory.c-362-#endif
system/memory.c-363-}
--
system/memory.c=521=static MemTxResult access_with_adjusted_size(hwaddr 
addr,
system/memory.c-522-                                      uint64_t *value,
system/memory.c-523-                                      unsigned size,
system/memory.c-524-                                      unsigned 
access_size_min,
system/memory.c-525-                                      unsigned 
access_size_max,
system/memory.c-526-                                      MemTxResult 
(*access_fn)
system/memory.c-527- 
(MemoryRegion *mr,
system/memory.c-528- 
hwaddr addr,
system/memory.c-529- 
uint64_t *value,
system/memory.c-530- 
unsigned size,
system/memory.c-531- 
signed shift,
system/memory.c-532- 
uint64_t mask,
system/memory.c-533- 
MemTxAttrs attrs),
system/memory.c-534-                                      MemoryRegion *mr,
system/memory.c-535-                                      MemTxAttrs attrs)
system/memory.c-536-{
system/memory.c-537-    uint64_t access_mask;
system/memory.c-538-    unsigned access_size;
system/memory.c-539-    unsigned i;
system/memory.c-540-    MemTxResult r = MEMTX_OK;
system/memory.c-541-    bool reentrancy_guard_applied = false;
system/memory.c-542-
system/memory.c-543-    if (!access_size_min) {
system/memory.c-544-        access_size_min = 1;
system/memory.c-545-    }
system/memory.c-546-    if (!access_size_max) {
system/memory.c-547-        access_size_max = 4;
system/memory.c-548-    }
system/memory.c-549-
system/memory.c-550-    /* Do not allow more than one simultaneous 
access to a device's IO Regions */
system/memory.c-551-    if (mr->dev && !mr->disable_reentrancy_guard &&
system/memory.c-552-        !mr->ram_device && !mr->ram && 
!mr->rom_device && !mr->readonly) {
system/memory.c-553-        if 
(mr->dev->mem_reentrancy_guard.engaged_in_io) {
system/memory.c-554-            warn_report_once("Blocked re-entrant IO 
on MemoryRegion: "
system/memory.c-555-                             "%s at addr: 0x%" 
HWADDR_PRIX,
system/memory.c-556-                             memory_region_name(mr), 
addr);
system/memory.c-557-            return MEMTX_ACCESS_ERROR;
system/memory.c-558-        }
system/memory.c-559-        mr->dev->mem_reentrancy_guard.engaged_in_io 
= true;
system/memory.c-560-        reentrancy_guard_applied = true;
system/memory.c-561-    }
system/memory.c-562-
system/memory.c-563-    /* FIXME: support unaligned access? */
system/memory.c-564-    access_size = MAX(MIN(size, access_size_max), 
access_size_min);
system/memory.c-565-    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
system/memory.c:566:    if (memory_region_big_endian(mr)) {
system/memory.c-567-        for (i = 0; i < size; i += access_size) {
system/memory.c-568-            r |= access_fn(mr, addr + i, value, 
access_size,
system/memory.c-569-                        (size - access_size - i) * 
8, access_mask, attrs);
system/memory.c-570-        }
system/memory.c-571-    } else {
system/memory.c-572-        for (i = 0; i < size; i += access_size) {
system/memory.c-573-            r |= access_fn(mr, addr + i, value, 
access_size, i * 8,
system/memory.c-574-                        access_mask, attrs);
system/memory.c-575-        }
system/memory.c-576-    }
system/memory.c-577-    if (mr->dev && reentrancy_guard_applied) {
system/memory.c-578-        mr->dev->mem_reentrancy_guard.engaged_in_io 
= false;
system/memory.c-579-    }
system/memory.c-580-    return r;
system/memory.c-581-}

[*] See chapter 2 "The Basics of Endianness", in particular section
2.2 'Endianness Definition by Bus Specification':
https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/ixp4xx-ixc1100-big-endian-little-endian-modes-note.pdf

>> Second, imagine a board with e.g. a big endian main CPU and a little 
>> endian service processor - how should a device know the right 
>> endianness here?
> 
> How would that work with this series? So the proposed solution is to 
> double the devices now marked as NATIVE_ENDIAN to have a big and a 
> little endian variant for them so the board can choose? That does not 
> exist in real as you wrote, there's only one device so then this is 
> probably not the right way to model it.
> 
>>> Or would that be too much overhead? If always looking up the 
>>> endianness is not wanted could the ops declaration keep NATIVE_ENDIAN 
>>
>> IMHO we should get rid of NATIVE_ENDIAN completely since there is no 
>> "native" endian in multi-CPU boards.
> 
> If we say NATIVE_ENDIAN means that the device can be attached to either 
> big or little endian machine then we can keep this constant but when 
> adding the ops to a memory region the board has to then decide which 
> endianness it is and replace it with either big or little. Then we don't 
> need two versions of the same device and NATIVE_ENDIAN means that the 
> device can be used in both machines.
> 
> In real life probably all devices can be used with either CPU and if 
> they are accessed in little or big endian is only determinded by how 
> they are wired on the board. So the device endianness only means what 
> endianness the device expects for something (what exactly? e.g. a video 
> chip may have a frame buffer and a registers area with different 
> endianness). So this should be the board that decides this not the 
> device. Therefore it may not need to be defined when MemoryRegionOps is 
> defined at all (or only as a hint to show what the device expects 
> normally) and then memory_region_init_io which takes the MemoryRegionOps 
> should also take an endianness corresponding the board and set it at 
> that point. It can warn if the device endianness does not match what the 
> board sets but you can still connect a big endian device to a little 
> endian CPU as long as the drivers write the right values or the data 
> lines are connected the right way, the latter of which corresponds to 
> NATIVE_ENDIAN now as the conversion is done by the wiring so drivers 
> don't need to care.
> 
> But if it's simpler to just double the few devices that need to be used 
> this way then it's a possible solution but if there's a cleaner one with 
> not much more complexity then maybe that should be considered, because 
> the way to define these doubled devices is a bit confusing for new 
> people (on top of that defining devices is already confusing with the 
> lot of boiler plate code needed). So if this could be kept simpler that 
> would be a good thing IMO.
> 
> Regards,
> BALATON Zoltan


