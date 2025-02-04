Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08103C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQkd-0008Oe-Vo; Tue, 04 Feb 2025 16:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQkc-0008O5-Lx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:46:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQkZ-0005Nl-Kg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:46:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38db104d35eso704853f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738705590; x=1739310390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6zix+2XzlAWB3iAZ7J6dqnst6Y/RLxo8jGubN17CA0I=;
 b=Lza/yNQQN1cT0EuqDyveidlbE4Ep/Ek1FzSlMe3+cPoe764Th0o9hQvf5gTW1y4/8s
 qrvs0YndgOiIUi9e9ts6I3F/qbwBQCP10g4KZy1EWZc+mukSBrFyOJwEPVMj7fclo3up
 oY79w4s8RM917bhiZurHBYXmZkn2vlUZaa48trnQ8hg5f1x0ba4sFvqpQ9LnSAZEajKM
 sIAGgyQRjkKSKPLdWqYtot7VzbXhGL4N+Hpv+KNXHreuP4oZyiNuHaM0aA58cfmuN+fF
 U22xMH9G/KRMzx1fN1wMqMuuwp6li3/nHiEqocRFiZBQwq/8uCiFg+HCX2oxalSXVlNp
 txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738705590; x=1739310390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zix+2XzlAWB3iAZ7J6dqnst6Y/RLxo8jGubN17CA0I=;
 b=aYu8Ymb2vzWlWkr+f+JHxocDYbzGZGL2yfVGDRwirKapKceYBbjpm5GIbRxq0HfqXG
 uosiZxtJr9kUHvmjI0aoufhVrDh2xBvnRTcQxCw/g0pICO40iniIePsWRiCDJH2FNYQ+
 jfSfBZA4cbb0RO9jYDUwn0knwYJiT0m4SXyoWzo1rcHYg6EHXK3eYbdAi9hWmNHXAGZd
 va0dd8Yt845d0TncFMhzuqmYyvyA1px8wLpBycvgnb8YB9Oguwbzr3BQk2cydLxUBetU
 L1Mcl2TUuUdIAJ0rNlZYThgTzbH3lUXou932QuS4N6nmBMFYa+KUA+HZUe/zzOmMrsp+
 U90g==
X-Gm-Message-State: AOJu0YwdsXTX3OJZuzQbK0rD0++eN+9ixm1dHgan9dYVMcXayJiY+kGl
 8WGSEndF1d5gIV/VltcZXAmUZX9wE+cqiJuM9eFmlzDy+SfzzZmmAmHlTZYsDQg=
X-Gm-Gg: ASbGncuXWnAa7hVZSECzOTfmAnU0MxyS0XOsTS9uGSOIBMuRKKzFWJxtskaIBkxT39Q
 hZaUp+63lo6stuh9fSWCDPall0PjIHT0k2zk+wjcUlaCchtDZgtOqvPpi2OU5TK6dcrrQFLkZUl
 ulS2lxRuqKoJqoB69xUispFMT8+biPmY0dlHKjaIIDFWMMcFxjDMBVXxP7zkfdgBPBGfJuaJh3t
 9lrOommAm+yLLxq9HYvCy4duUrZ4j6CcU3qPAtDWyUcJ5e/ucOrRSYs1F1cihLpC+eAy0zwNK6P
 1OnWZblJfqohETk480ql36wX6D95jO7NT2bADAtAV+5RlzrVngL37bdrP1Q=
X-Google-Smtp-Source: AGHT+IG9fYVcNjd4KrepiyxYV/XOclbCs7/Tu4PydlvgnG441JpTbvLsm3f67QBRBdAo40c76+lx6Q==
X-Received: by 2002:adf:ef89:0:b0:38d:a883:b95b with SMTP id
 ffacd0b85a97d-38db48a42f8mr273456f8f.28.1738705589709; 
 Tue, 04 Feb 2025 13:46:29 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf560sm16648489f8f.89.2025.02.04.13.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:46:29 -0800 (PST)
Message-ID: <e6d14f33-94ec-47ba-9fec-64ce94da2ad0@linaro.org>
Date: Tue, 4 Feb 2025 22:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: make memory device size configurable per Machine
To: Igor Mammedov <imammedo@redhat.com>, qemu-riscv <qemu-riscv@nongnu.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 wangyanan55@huawei.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 anisinha@redhat.com, qemu-arm@nongnu.org
References: <20240711074822.3384344-1-imammedo@redhat.com>
 <d921c3d3-71a9-49e4-9f28-1ff3f19b9c48@linaro.org>
 <20240711104230.1582fba0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711104230.1582fba0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/7/24 10:42, Igor Mammedov wrote:
> On Thu, 11 Jul 2024 10:19:27 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi Igor,
>>
>> On 11/7/24 09:48, Igor Mammedov wrote:
>>> Currently SMBIOS maximum memory device chunk is capped at 16Gb,
>>> which is fine for the most cases (QEMU uses it to describe initial
>>> RAM (type 17 SMBIOS table entries)).
>>> However when starting guest with terabytes of RAM this leads to
>>> too many memory device structures, which eventually upsets linux
>>> kernel as it reserves only 64K for these entries and when that
>>> border is crossed out it runs out of reserved memory.
>>>
>>> Instead of partitioning initial RAM on 16Gb chunks, use maximum
>>> possible chunk size that SMBIOS spec allows[1]. Which lets
>>> encode RAM in Mb units in uint32_t-1 field (upto 2047Tb).
>>> As result initial RAM will generate only one type 17 structure
>>> until host/guest reach ability to use more RAM in the future.
>>>
>>> Compat changes:
>>> We can't unconditionally change chunk size as it will break
>>> QEMU<->guest ABI (and migration). Thus introduce a new machine class
>>> field that would let older versioned machines to use 16Gb chunks
>>> while new machine type could use maximum possible chunk size.
>>>
>>> While it might seem to be risky to rise max entry size this much
>>> (much beyond of what current physical RAM modules support),
>>> I'd not expect it causing much issues, modulo uncovering bugs
>>> in software running within guest. And those should be fixed
>>> on guest side to handle SMBIOS spec properly, especially if
>>> guest is expected to support so huge RAM configs.
>>> In worst case, QEMU can reduce chunk size later if we would
>>> care enough about introducing a workaround for some 'unfixable'
>>> guest OS, either by fixing up the next machine type or
>>> giving users a CLI option to customize it.
>>>
>>> 1) SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
>>>
>>> PS:
>>> * tested on 8Tb host with RHEL6 guest, which seems to parse
>>>     type 17 SMBIOS table entries correctly (according to 'dmidecode').
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>    include/hw/boards.h |  4 ++++
>>>    hw/arm/virt.c       |  1 +
>>>    hw/core/machine.c   |  1 +
>>>    hw/i386/pc_piix.c   |  1 +
>>>    hw/i386/pc_q35.c    |  1 +
>>>    hw/smbios/smbios.c  | 11 ++++++-----
>>>    6 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>> index ef6f18f2c1..48ff6d8b93 100644
>>> --- a/include/hw/boards.h
>>> +++ b/include/hw/boards.h
>>> @@ -237,6 +237,9 @@ typedef struct {
>>>     *    purposes only.
>>>     *    Applies only to default memory backend, i.e., explicit memory backend
>>>     *    wasn't used.
>>> + * @smbios_memory_device_size:
>>> + *    Default size of memory device,
>>> + *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
>>>     */
>>>    struct MachineClass {
>>>        /*< private >*/
>>> @@ -304,6 +307,7 @@ struct MachineClass {
>>>        const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>>>        int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>>>        ram_addr_t (*fixup_ram_size)(ram_addr_t size);
>>> +    uint64_t smbios_memory_device_size;
>>
>> Quick notes since I'm on holidays (not meant to block this patch):
>>
>> - How will evolve this machine class property in the context of
>>     a heterogeneous machine (i.e. x86_64 cores and 1 riscv32 one)?
> 
> I'm not aware of a SMBIOS spec (3.x) that cares about that heterogeneous
> setup yet. Are there anything in that area exists yet?

Not yet.

> 
>> - Should this become a SmbiosProviderInterface later?
> if/when SMBIOS does get there (heterogeneous machines), introducing
> an interface might make a sense.

OK.


