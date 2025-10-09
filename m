Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBBACCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nSX-000116-V0; Thu, 09 Oct 2025 06:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nSO-0000tY-4F
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:01:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nSI-0005fu-5f
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:01:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so10333355e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004059; x=1760608859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RG89XrDFBbwVSS1mzn7nIux6+M1k+HOgEdjwqshi6E=;
 b=wyfJyTU+dltzDJy3XYQYl7HvcH6wPs2MYaJjF3gFQSiujlfipY6WvsraxAIs8AE1jZ
 rnD7jKimyjnoCaKmgLF1Bx/eaUd0+Dh1KrVob7p0BP0cpLJhxaVqzIZXYXUPkSdyrs/D
 622s/ENKfly+cDSNqnGVB0a3TCT2OC9HKcL8MrSmoisibupGS8r62cuL2NTKrFAg7+Eb
 5O0Dy24ihNZNnr62CqjEoc9h+9Z/bjMM2yupL6XbLwawciCaehjWW8gWLxk749jFRkds
 P+FDRCyy9sQRJh3wEj7+u1496bvp56wEozLNJNLDPtJ+EDrPMVY7WbIG8BJ3FtnbLNi3
 y+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004059; x=1760608859;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RG89XrDFBbwVSS1mzn7nIux6+M1k+HOgEdjwqshi6E=;
 b=FHHwRgtoVUdAQ0mEJHKGguFXjDAP4zduieLuJE/U/Qglm/8hKzLlrdbadGwcHX0HLp
 E5jhWNkOMGkXz9Rwna6CdbiNal21LSEs+bXt8hFsR7RM81fAdLvTJE+2lcwgeG5WK43P
 mG5ZlkLxqmow8Qrv/5TzM1C3OonqQoMJAtY4ZhupjVbh5N+82uLssR2GBBZxMjbWqV3k
 B1G1J6wb0EerfE1OLU6gMaCDsDhCAMjhJNLXm1ssMgYewxItLtCf5xoI4HuI+ZtIfJ8T
 Q+oKmPGIHQ1ABSbCJXGrO8gfrxeIL8AgHjJrQhevtRTXplWPdhL2/CJ3udP0N6OzIpf4
 VBGg==
X-Gm-Message-State: AOJu0YxmvccZxI+4t9me5JC+koHZ2q3nPFFuYuSwRaxubQspBTPZW419
 lcSgs0xE8n+/Huurr9aaxYSPN2CO8xeAHuMENw+vXzrm5UmmBRtJDNeXrd1zJTlOqq0=
X-Gm-Gg: ASbGncv5/bEV6AoOHKoOpAaT8Itx0f5jFRDny4XoI380+GFJrB8srKlRu5M8Eu/IDeS
 Dp+PiGsiNuMAMw7QeWzXqB/t+aFlcLpIMECvDZ7eBNVvCNG3jllzW+7DBmgFfIjlGsq3JviuNOG
 SlT2WmNestnuAqDTDSI1uBGPIDeBzQh6B6ZjN5Ecoo47bLzXFmqpBWoz0Blo7K91tZ+2IAkw9bw
 8HV/BKYMCGFsrBtH+nOtReUy7U64/VswRwvruikrJLma6ZSwl7CC8+fWR+4p54VltfxWBui4qqk
 c2988jZnZ6cz4weS9k0FhWDcRdXcOf9oJHr+Ygro/B1dtqo4QXcnHwhI9Rrk8c5mtAK+5YprASh
 Fyt72PHbPH5qxw0NQJ415bVoW/gpWX5a+P+B/c0GigOfrLWDjxrAvkUOvrEM/RQOpw/sh1qnMSa
 Wu8pExdB/UPk7ShTUHxQ==
X-Google-Smtp-Source: AGHT+IFqkYnn1gSK8NqNOMLy1N/yJEooJgYKi9U6nNwDgyjYjQIGtHr0Px8W4LKWJjvUgTMK+7y0Yg==
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id
 ffacd0b85a97d-42666aa6354mr5077430f8f.7.1760004059479; 
 Thu, 09 Oct 2025 03:00:59 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4cc3sm33893324f8f.55.2025.10.09.03.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 03:00:58 -0700 (PDT)
Message-ID: <a843f99c-f5d7-43d5-beae-1ac17261cd3c@linaro.org>
Date: Thu, 9 Oct 2025 12:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] target/openrisc: Replace target_ulong -> uint32_t
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
 <20251008075612.94193-8-philmd@linaro.org>
 <fowsbt2ovqpl5mzizniyqx6xhlnvu7lc2po3jbi2cslwrpu5ew@dkcvbphrov6u>
 <1b81d317-6c1a-42ca-8aba-7e71cfece3a5@linaro.org>
In-Reply-To: <1b81d317-6c1a-42ca-8aba-7e71cfece3a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/10/25 10:17, Philippe Mathieu-Daudé wrote:
> On 8/10/25 14:16, Anton Johansson wrote:
>> On 08/10/25, Philippe Mathieu-Daudé wrote:
>>> The OpenRISC targets are only built as 32-bit, therefore
>>> target_ulong always expands to uint32_t. Replace and adapt
>>> the API uses mechanically:
>>>
>>>    target_ulong -> uint32_t
>>>    target_long -> int32_t
>>>    tl -> i32
>>>    TCGv -> TCGv_i32
>>>    tcg_global_mem_new -> tcg_global_mem_new_i32
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> RFC: not sure how to split to ease review :|
>>> ---
>>>   target/openrisc/cpu.h        |  22 +--
>>>   target/openrisc/helper.h     |   8 +-
>>>   target/openrisc/fpu_helper.c |   8 +-
>>>   target/openrisc/machine.c    |  16 +-
>>>   target/openrisc/sys_helper.c |   5 +-
>>>   target/openrisc/translate.c  | 374 +++++++++++++++++------------------
>>>   6 files changed, 216 insertions(+), 217 deletions(-)
>>
>> [...]
>>
>>> -static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
>>> +static void gen_add(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, 
>>> TCGv_i32 srcb)
>>>   {
>>> -    TCGv t0 = tcg_temp_new();
>>> -    TCGv res = tcg_temp_new();
>>> +    TCGv_i32 t0 = tcg_temp_new();
>>> +    TCGv_i32 res = tcg_temp_new();
>>
>> I think you missed transforming tcg_temp_new -> tcg_temp_new_i32.
>>
>>>   static bool trans_l_lwa(DisasContext *dc, arg_load *a)
>>>   {
>>> -    TCGv ea;
>>> +    TCGv_i32 ea;
>>>       check_r0_write(dc, a->d);
>>>       ea = tcg_temp_new();
>>> -    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
>>> -    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
>>> -    tcg_gen_mov_tl(cpu_lock_addr, ea);
>>> -    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
>>> +    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
>>> +    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
>>> +    tcg_gen_mov_i32(cpu_lock_addr, ea);
>>> +    tcg_gen_mov_i32(cpu_lock_value, cpu_R(dc, a->d));
>>>       return true;
>>>   }
>>
>> What about MO_TE -> MO_BE to handle MO_TE[SU][WL]?
> 
> I thought we already had that merged...

Found it in a branch from March 17 of this year, but forgot to post,
thanks for the reminder!

