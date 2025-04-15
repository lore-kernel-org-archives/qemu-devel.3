Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D682C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aW5-00076F-3C; Tue, 15 Apr 2025 03:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aVw-00074X-Jb
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:15:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4aVt-0002vf-PO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:15:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso34548855e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744701319; x=1745306119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZL0XsFAjJStMlS2GESi+b2JFXXnWD2/r3K+/HTN1YHM=;
 b=LAjp16GCA7OvhSatFIsHXOiYvyhXpzyl5fUTtSL6qCTOAAKqdL1tdMgCvxSYrU+9K5
 J5xL3exvX2Smx62ZV3IaaaBGEPnaQY6s0CgL0ahSSqh2y10T1FNDlDUFj3pwWl9BffSx
 omff2A+XUrPQlRMZzC+PLxNpBxmRycpzjaqlJmW8+KpSnxfdr7hy+La5zTjR7UdeZyIU
 W9xo9RSa1TtNpCa2hp73Pzh741jrGYUdgR3CeBJmcHFralzg4ryST3nmZI01xTVnEd5Y
 r5yZXm47CbLbjrbv32ETm7HS6MaLV2ChszhM1PPRQmcKDltt6OzEjwFbIkoth7BS+fPV
 pHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701319; x=1745306119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZL0XsFAjJStMlS2GESi+b2JFXXnWD2/r3K+/HTN1YHM=;
 b=bTNFoZi7trke0fXyt7Eroh3oK4Ms18R5GH5zqDVSPB2/gwoXh+VzZaEFDVfTNQUwnc
 ERH8T4MgReh6kFgzTr0C+/6h3/tnbX0UPlpOKnz92lp79+aAfMUxAO3J/kscXnS3IMHs
 qImEdeVqwZqzqt8+79Irf5vXEO5W9529AZmpvvnDOoh4WLbGSrgyexFnG1S+BucJw2cv
 nmHs6W7DV/05Fk7QmGXp1JDjzVfkZ0whjptWjRHMwx5Ir5iFwAsVPLxHCGisVdnIdWwa
 vRTE2/kEb+m/2jajU+h+/l96BH2qeoihcxIdQjLLrHKgW7WXea/GV2QTkkEU5AlBSuDy
 u+OQ==
X-Gm-Message-State: AOJu0Yz3cOOPWoitTvE6AP1BVTsHl0j2Hi37npy0Z+nz2OpNkdu0vVPK
 OLfhNNIuZjz9Qsg0+jBGYE/rwfFlSDcTnOx70SHDhE5qratHMkE22YuNEMBr4MA=
X-Gm-Gg: ASbGncudQ9tSZaKLT/lXhzCXCx3AE+8oYrjJchRSjIqA93bhLN+g9RlFNU2D5wllHYL
 E83CX5bHfZr2LO709razxK6vm0dY9lUwqLUu0Hec7wEPAZB9PcAw3zY8yhByH6X6r1QdlT/hXew
 e5Mb7OJgUdOeiSNcjGbMWVJOwhtvbgg5sSR2xHDI/KCr4g68BYb3vrjumJyWlk18+EXE7rMDJCp
 mxJtAVUfmeVz95s0NJ3fLgkVO+fepCrkQMmbjNH1y/KSY+Xf6tHF3FFPFHJY2dQUw01eVbVjcSH
 wRfz3b/KLBbhwbI0t76w3Rvrn0WPW20cK+4ycsmyrQqz+Fdh2uJd63GUwppomhkLrMC/eQWHPZk
 6d1FvGUcY
X-Google-Smtp-Source: AGHT+IFoWSpWm5oZvNzp0OMAe1rqwb9fvwh5nUqBsOhSIVIWuyV3G6A2qBdJtFWMQ7aMYyiPxt1XEQ==
X-Received: by 2002:a05:600c:5122:b0:43b:baf7:76e4 with SMTP id
 5b1f17b1804b1-43f99874f7emr15036655e9.1.1744701318910; 
 Tue, 15 Apr 2025 00:15:18 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625eeesm200949345e9.11.2025.04.15.00.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:15:18 -0700 (PDT)
Message-ID: <7d2e61de-17da-4a6b-b9c8-2ff14fdce15f@linaro.org>
Date: Tue, 15 Apr 2025 09:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: Ziqiao Kong <ziqiaokong@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org,
 alistair.francis@wdc.com, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
 <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
 <CAM0BWND3dr=_nZHXSoV2jzkXPXd=hViX6vM0cUMZ2Uru+TD6GQ@mail.gmail.com>
 <c566eed5-605f-4aeb-8841-dae4e591fcb3@linaro.org>
 <CAM0BWNBNrjJ6UuF+TRtkuEesLatnY1pzSjyaiPVDeKSMF8no-A@mail.gmail.com>
 <CAM0BWNBGAJ-scbhXAQ2s2Y=w3WhJ5pR72xSA5Xf+bsbk73cL6w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAM0BWNBGAJ-scbhXAQ2s2Y=w3WhJ5pR72xSA5Xf+bsbk73cL6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 15/4/25 09:04, Ziqiao Kong wrote:
> Accidentally not cc all recipients. Sorry for the confusion. Below is
> the duplicated message:
> 
> Hello Philippe,
> 
> On Tue, Apr 15, 2025 at 1:38 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 14/4/25 18:59, Ziqiao Kong wrote:
>>> Hello Philippe,
>>>
>>> Any further concern regarding this series? I certainly would like to investigate
>>> and help =).
>>
>> Short term I can't keep looking because I'm busy with other stuffs and
>> tagged this patch for another review, because there is some endianness
>> code smell in get_physical_address(). I understand your change fixes
>> your issue, but I'm skeptical about it, in part because there are no
>> such use in the whole code base. My change suggestion is just a starting
>> point, more is needed.
> 
> Thanks for responding.
> 
> Actually, the pattern of this usage is actually very common in the code base and
> that's why I fixed in this way. Sorry I should have put this in the
> cover letter to
> justify my fix. Below is an incomplete list of the code using this pattern:
> 
> - target/i386/tcg/system/excp_helper.c:129
> 
> if (likely(in->haddr)) {
> old = cpu_to_le32(old);
> new = cpu_to_le32(new);
> return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) == old;
> }
> 
> - target/arm/ptw.c: 840
> 
> if (ptw->out_be) {
> old_val = cpu_to_be64(old_val);
> new_val = cpu_to_be64(new_val);
> cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
> cur_val = be64_to_cpu(cur_val);
> } else {
> old_val = cpu_to_le64(old_val);
> new_val = cpu_to_le64(new_val);
> cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
> cur_val = le64_to_cpu(cur_val);
> }

Doh OK...

> 
> You might want to do a `grep -rn "qatomic_cmpxchg" .` to see all matches.
> 
> 
>>
>>>
>>> Bests,
>>> Ziqiao
>>>
>>> On Mon, Apr 14, 2025 at 7:17 PM Ziqiao Kong <ziqiaokong@gmail.com> wrote:
>>>>
>>>> On Mon, Apr 14, 2025 at 6:41 PM Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 14/4/25 05:46, Ziqiao Kong wrote:
>>>>>> On big endian systems, pte and updated_pte hold big endian host data
>>>>>> while pte_pa points to little endian target data. This means the branch
>>>>>> at cpu_helper.c:1669 will be always satisfied and restart translation,
>>>>>> causing an endless translation loop.
>>>>>>
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
>>>>>
>>>>>> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
>>>>>> ---
>>>>>>     target/riscv/cpu_helper.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>>>> index 6c4391d96b..bc146771c8 100644
>>>>>> --- a/target/riscv/cpu_helper.c
>>>>>> +++ b/target/riscv/cpu_helper.c
>>>>>> @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>>>>>                 target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
>>>>>>                 target_ulong old_pte;
>>>>>>                 if (riscv_cpu_sxl(env) == MXL_RV32) {
>>>>>> -                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
>>>>>> +                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));

Then don't we need:

     old_pte = le32_to_cpu(old_pte);

>>>>>>                 } else {
>>>>>> -                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
>>>>>> +                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));

     old_pte = le64_to_cpu(old_pte);

?

>>>>>>                 }
>>>>>>                 if (old_pte != pte) {
>>>>>>                     goto restart;
>>>>>
>>>>> If PTEs are always stored in LE order, maybe what we want is earlier:
>>>>>
>>>>> -- >8 --
>>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>>> index 619c76cc001..b6ac2800240 100644
>>>>> --- a/target/riscv/cpu_helper.c
>>>>> +++ b/target/riscv/cpu_helper.c
>>>>> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
>>>>> *env, hwaddr *physical,
>>>>>             if (riscv_cpu_mxl(env) == MXL_RV32) {
>>>>> -            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
>>>>> +            pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>>>>>             } else {
>>>>> -            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
>>>>> +            pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>>>>
>>>> Unfortunately, this doesn't work in two ways:
>>>>
>>>> 1. Note pte is used in the following code and that means pte must hold
>>>> a correct value from the
>>>> view of host endian (in my case, big endian not little endian).
>>>> 2. address_space_ldq_le will dispatch to ldq_le_p, while
>>>> address_space_leq will dispatch to ldq_p.
>>>> However, on little endian targets, ldq_p is an alias of ldq_le_p so
>>>> making no effects.
>>>>
>>>> Per my testing, this patch doesn't have any effect indeed. To have a
>>>> brief view what is happening,
>>>> see the logs just before atomic_cmpxchg:
>>>>
>>>> pte_pa 0xf14000000000000 == pte 0x140f ? updated_pte 0x144f
>>>>
>>>>>             }
>>>>> ---
>>


