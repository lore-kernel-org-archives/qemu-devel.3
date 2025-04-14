Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ED3C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NlM-0002jh-IB; Mon, 14 Apr 2025 13:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4Nl6-0002iZ-KT
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:38:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4Nl1-0000N6-Vh
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:38:12 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so4000046f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744652285; x=1745257085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUvpMz/wZkmDjLL+SoPmJyVaKdotCY03nMuxDIhiDKE=;
 b=IWfYiiOFXTTOwOL8HyocoAXrfFqYQbafykwcWiQXqX7VqI2twgO5bed7IF+cOWBTdp
 7jawF8+QkQduwrkvoa5UUVxj6KBS1OFnwYo7i493zCykIe54ff2RQDasv7goPfF3TR5t
 8iMJWnbJUAiSo7aewlwt6H1caSv2GvUWDzJVElkXTovqlHr+E9wqSj6hZCD6cDu0v1BG
 Tlw43ALzYM1o3IBb+a6nD5dunwNJNasRiTPN5StQUki8BwHY2UHgx0X9EJz59nbHeVl1
 MIZsxLTpjL0+IuHgJSWxifcO8mjJrJEsa3QlNgojdPiOMBKbe34rVi0ufcS77ASjROBP
 kL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744652285; x=1745257085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUvpMz/wZkmDjLL+SoPmJyVaKdotCY03nMuxDIhiDKE=;
 b=uhLVtjWJzTVwYic7s5Xor8njR/4TAoAnaYwioU+Ap0KTsmYnvi7D4TFa1X7+TZnvYu
 WvuzoBVUhImRq7MBKbFcOfboor7Calq3lCGy6uUf6evO3sU6uxIbezaynZeLcgKo3HWE
 yjNA68jS0xrTPF+2D3uQxP32McoUK5OZk05qijejOhZ6I41zwPI2H3sgJaoJLdjVHhjy
 qDY0OUijS9eubgZQea7fTBLvyTSMxPFQ4OqBvcOj7bcy70QhwcOoc4mbwPFsXADYdYbN
 qVAfOrGaKBf+/IsmsRk0IYjDX+b+KQVrAdLtHW4Nv/EJe+CWosdMN1/9nEQKfBwEyppU
 6zww==
X-Gm-Message-State: AOJu0YwA4YmeG21Za/gt2JnO+H3b2y11LN4YoYr4mEo5juBJH5JInCYQ
 IUviA//syBTgL38fQ5pd5FJXWni5PW6R+p1V9bvhfIt14ZUxhwz8i4quV4o9CNQ=
X-Gm-Gg: ASbGncsZe2enG7RF5EmaZ5/GceLTC4d2/7w8/7gRjk+7aQSaFJEI5BniTr4V20pOWbA
 kLede8w7QEQA3iuZPA11ELnkzSWb5lgEJf9vC2xG1sm3Ay89XTCwcenKyO3NZf2mWs50jxG1cUu
 PDOjJmBieiaSWnhoe0oMM+fg9k+E8CcqsPPxcMlev9Vh7SPf3PdQmKokOVE5XLZMVG/DsV5yIAN
 q6vKCbzgM36D26pQa8flYCgVSUwmIiAZXOxsgoOludFoCttMqNHN/HK8HTOznMlCrI4Xlnso3in
 /GthXhYag9WQ3CUSsrmdjYX8bLyX4Gb7xbxwuduHgfeVhym/upYikrEPjvYa8fdtFfN6XRgOf/c
 Z4tlaYJ0Y
X-Google-Smtp-Source: AGHT+IFRmTNwVO4CDBFt8mh63rPkqOxlP/YoS43YSpCGdbBBfbWqeIrHwxjpqmtRpaTXhNP+2+OIqw==
X-Received: by 2002:a5d:59a3:0:b0:390:e1e0:1300 with SMTP id
 ffacd0b85a97d-39eaaea4548mr10454339f8f.33.1744652284995; 
 Mon, 14 Apr 2025 10:38:04 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cd17sm11672174f8f.78.2025.04.14.10.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 10:38:04 -0700 (PDT)
Message-ID: <c566eed5-605f-4aeb-8841-dae4e591fcb3@linaro.org>
Date: Mon, 14 Apr 2025 19:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: Ziqiao Kong <ziqiaokong@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair.francis@wdc.com, 
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
 <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi,

On 14/4/25 18:59, Ziqiao Kong wrote:
> Hello Philippe,
> 
> Any further concern regarding this series? I certainly would like to investigate
> and help =).

Short term I can't keep looking because I'm busy with other stuffs and
tagged this patch for another review, because there is some endianness
code smell in get_physical_address(). I understand your change fixes
your issue, but I'm skeptical about it, in part because there are no
such use in the whole code base. My change suggestion is just a starting
point, more is needed.

> 
> Bests,
> Ziqiao
> 
> On Mon, Apr 14, 2025 at 7:17 PM Ziqiao Kong <ziqiaokong@gmail.com> wrote:
>>
>> On Mon, Apr 14, 2025 at 6:41 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> On 14/4/25 05:46, Ziqiao Kong wrote:
>>>> On big endian systems, pte and updated_pte hold big endian host data
>>>> while pte_pa points to little endian target data. This means the branch
>>>> at cpu_helper.c:1669 will be always satisfied and restart translation,
>>>> causing an endless translation loop.
>>>>
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
>>>
>>>> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
>>>> ---
>>>>    target/riscv/cpu_helper.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>> index 6c4391d96b..bc146771c8 100644
>>>> --- a/target/riscv/cpu_helper.c
>>>> +++ b/target/riscv/cpu_helper.c
>>>> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>>>                target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
>>>>                target_ulong old_pte;
>>>>                if (riscv_cpu_sxl(env) == MXL_RV32) {
>>>> -                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
>>>> +                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
>>>>                } else {
>>>> -                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
>>>> +                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
>>>>                }
>>>>                if (old_pte != pte) {
>>>>                    goto restart;
>>>
>>> If PTEs are always stored in LE order, maybe what we want is earlier:
>>>
>>> -- >8 --
>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index 619c76cc001..b6ac2800240 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
>>> *env, hwaddr *physical,
>>>            if (riscv_cpu_mxl(env) == MXL_RV32) {
>>> -            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
>>> +            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>>>            } else {
>>> -            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
>>> +            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>>
>> Unfortunately, this doesn't work in two ways:
>>
>> 1. Note pte is used in the following code and that means pte must hold
>> a correct value from the
>> view of host endian (in my case, big endian not little endian).
>> 2. address_space_ldq_le will dispatch to ldq_le_p, while
>> address_space_leq will dispatch to ldq_p.
>> However, on little endian targets, ldq_p is an alias of ldq_le_p so
>> making no effects.
>>
>> Per my testing, this patch doesn't have any effect indeed. To have a
>> brief view what is happening,
>> see the logs just before atomic_cmpxchg:
>>
>> pte_pa 0xf14000000000000 == pte 0x140f ? updated_pte 0x144f
>>
>>>            }
>>> ---


