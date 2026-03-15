Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7DEF30268
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 14:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1m7q-0005ES-F9; Sun, 15 Mar 2026 10:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1m7o-0005EG-JQ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 10:07:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1m7m-0003Je-OA
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 10:07:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439afc58ac7so4373796f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773583641; x=1774188441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fzXrcZCZLa6rv7xNb8zvCjjAyXnPUjUcbCGw+z58hvA=;
 b=RNfpuZCIZD0/lmDvpzi4IS0yEmbPrurSnQAVmXhzRvsTazPbEn/OxHhktJjUfppvuZ
 MpZkvrHEe9uBtk+2AvxN08mHo3P9/KlqHUPXqgTkb1HCBjvfOMHFsX77/Tnq2bO3xfBr
 QEe0EdJ7c1TlrXnrFpfiPMG7H0pC9fTNC5HmC3GjXMsp9iU0nyInZeswy6gYIK798mEX
 ABI8N453nndNog9qIAqBFHb5+EQdjolNCg8ccEaMNldi8W0jkLCxrqZnyrxnICkoiXi4
 NV+J80kscRcBam67ovM2OVHjJX+OqsUoYXFRWVug2+ncziiJjrUlxlhaXHbY3sUfgf60
 emQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773583641; x=1774188441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzXrcZCZLa6rv7xNb8zvCjjAyXnPUjUcbCGw+z58hvA=;
 b=gztg/pvQNdEwH4S6hYxGuqWN9NLym6nWAWMbC62eK+yXWLhi1BuCyjMU4YeFEPX6dX
 rQjG0CA2zM2c9phADhqP5gAPkLn2PU9PaGCbm4rX/h4x/TdHZibhtDBSTJ/XNVHez5yg
 VtZ0WkmagZo4hdkt1ptf0Nie659aVddYOoNM5Rhchx9lo73hnvRcRt+XtfbSNNUYrzrF
 cIsQ4wLQPMma7ncF/ceiNQNGwzv64eC+lKeabUA7StiCnf4vl70Vk7MZJz7nDxndpqBQ
 MSjXzAGutr79QXzgj2sNf81JXTw8xAO97RGWTF+rcX1xDlFCeqHqU5xXYN8EmT6UvMDS
 lnkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjQpjtuNcQWILQi/n9Loql9EDSDzdpj3gyNWT2k0OyJsbFwHmeHePbu9GfTquw/wHSg+mql7MjF6rd@nongnu.org
X-Gm-Message-State: AOJu0YxvcR/TXz+jZzOSpyyNqqodNzo5Zw4qVaUfplRWnhGd7qLtht3/
 ECQT1lbIrX4Ca09JHSNAeezFcSJBZTYooVApjrP+kppd+cRfPSM4/KvGYzfYCi8ifhM=
X-Gm-Gg: ATEYQzyjgfnLz3GZ3UhbTuKYXiRIwa22bH86pQe6w48JoBGTZfrmeq0l9Z9aL2Cp2mA
 4TivR9m0BnGGTBfvL2JGt97AOOcRhwKyWlNdxmhwHVpl0L6YHcEINwZumlFPfP7PlEAMN292lmk
 IpcFYNvtsa2zNxKZ91qd7M1xwAj1blxEbBSpkcOFvmKYzmhAEAEcxrmqFkIkCd6vgwDKShWgxrl
 8WYHOcPlsPmuh/ALGzXgPqwMrp0+91G3WBPY3y/9/JNDmfaLhgzJxBxy3R8KG5LlvfVBH1k5Fy2
 NTEbJibBpm+jYwyZZpfV8HaIpiXc9RE/UTiy3/BluU8v68Jvu/ourN69rHTz/MyBjf1qaaHoDf2
 /L7tTQWNmiZZOBR1vnUxDecOc8nKH9DUf2dNnC1p4wlBBsoryHvv/5sEa3n5fg4BJVc8gfEtFo3
 2tjld7s5fZvCk8L7w89jnciYtVLmzWAvVuWkUlE35zgJZgLK6F0kZdSDodT4YoFAmVFQ==
X-Received: by 2002:a05:6000:184f:b0:439:b6d6:71a with SMTP id
 ffacd0b85a97d-43a04dd4c37mr19769354f8f.51.1773583640836; 
 Sun, 15 Mar 2026 07:07:20 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c0b4sm36569450f8f.25.2026.03.15.07.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 07:07:19 -0700 (PDT)
Message-ID: <241781d8-667e-486d-bc01-b01c0620e6cd@linaro.org>
Date: Sun, 15 Mar 2026 15:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
 <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
 <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
 <CAFEAcA9-umnREmEpWLV5hhXkfXZWqmMqpt3DAL2kUe1spttyKg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9-umnREmEpWLV5hhXkfXZWqmMqpt3DAL2kUe1spttyKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 13/3/26 09:51, Peter Maydell wrote:
> On Thu, 12 Mar 2026 at 19:37, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 12/3/26 20:30, Peter Maydell wrote:
>>> On Thu, 12 Mar 2026 at 19:29, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> On 11/3/26 17:27, Martin Kröning wrote:
>>>>> These functions are needed to support semihosting on CPUs that support
>>>>> runtime-configurable endianness. They should not be used in other contexts.
>>>>
>>>> Another note is these function are not target-specific, which is great!
>>>>
>>>> These can also be used outside of semihosting.
>>>>
>>>> Matter of taste I'd have named them using this shorter pattern:
>>>>
>>>> cpu_internal_tswap16() -> tswap16_cpu()
>>>
>>> We specifically didn't want to use a name that might tempt
>>> people to use them -- these are only wanted for the very
>>> few niche use cases that are outside the CPU but need to
>>> know information about the CPU's internals, which is basically
>>> legacy-virtio and semihosting.
>>
>> This was the missing piece to make qtest target-agnostic:
>>
>> -- >8 --
>> diff --git a/system/qtest.c b/system/qtest.c
>> index cf90cd53adb..392c1394656 100644
>> --- a/system/qtest.c
>> +++ b/system/qtest.c
>> @@ -523,18 +523,15 @@ static void qtest_process_command(CharFrontend
>> *chr, gchar **words)
>>                address_space_write(first_cpu->as, addr,
>> MEMTXATTRS_UNSPECIFIED,
>>                                    &data, 1);
>>            } else if (words[0][5] == 'w') {
>> -            uint16_t data = value;
>> -            tswap16s(&data);
>> +            uint16_t data = cpu_internal_tswap16(first_cpu, value);
> 
> This is a behaviour change, and I don't think we want it.
> tswap16s() swaps per the system endianness. cpu_internal_tswap16()
> swaps based on the CPU's current configuration. With qtest
> that's a bit of a weird thing, because we can never run the
> CPU in a way that will make it switch endianness.
> 
> This is why we gave these functions the _internal_ bit in
> the name -- they really are a very very specific piece
> of functionality that you almost never want.
> 
>> And these endianness checks in QTest framework are only there to test
>> legacy virtio, so we are good, this isn't even another niche use case.
> 
> No, these ones are here so that when when a test does a read
> or write of non-byte width data (e.g. via "writel 0x8000 0x12345678")
> we send it into the memory system in the endianness that it
> expects, so that it arrives at the device as "write of width 4
> with value 0x12345678". That is, we want to match it to the
> system endianness, because that's what we want to cancel out
> the swapping done in adjust_endianness() in system/memory.c.

What do you mean by "system endianness"? The default endianness picked
for a particular qemu-system-foo binary?

