Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A1DCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lqT-0004EJ-Pp; Thu, 09 Oct 2025 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lqP-0004Dj-B2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:17:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lqM-0007zh-SX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:17:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4473d7f6so3907725e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997863; x=1760602663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFWv0PuADQhmr15c8o1HG2yf8I0oEumVWydsaLQz/Sc=;
 b=baSg+bRx15DadCKnjwedQHNy4P3yl1YCo8Bsw5zoVejXNw8loJzSkIBj4cC5+f1SzO
 yYtxW0/fRnA1HX/vnTBKhJfRy8KaCd5BqK4IYlglkI//oKDExWjWNikARFEheAyVzfar
 ZlOWE0w5hyh6NKwS0tbmRIVoqV1n3I/X6Ce/5PF15z/Rk2IHdL11ySgf5J1cuJVZa8Z8
 5muMBgtnqhpB6qcHRsL+3agImZ/fcsFD4JvQrs0GFpJox/y5cmzf1GQ307uLg+41ZuJl
 g1JhHu2SoWrwueFI9AHjyYk5OnRX5NcoVU3SwcaGyuygfbLQnV8kxi/6lRF6A9TAYH9D
 AJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997863; x=1760602663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFWv0PuADQhmr15c8o1HG2yf8I0oEumVWydsaLQz/Sc=;
 b=OuhRmUmm6mwTPi7hAAMqhHZK2ahgVNecOyooJGvW1trAJI6RW3OblpdwA2nB61VRD6
 pP6186L62XNaQwzcRcxPWatndCKvsnAEzaB6iKXcRGgUS7/xS1Q2AwQESDokSTK50Df5
 VpVFA2btAddk54iJCsMaXNDEetbqEfpEWBy7BaOu7dtE1s+YBubtJauPTS3WAQuA2Zvt
 oCGfFS71y0RFdo1B8k6aPjh7Ff7NojfQO/VouMg7zvv/cd+Gml1WcfNqWPksZ8gSmZp/
 e2ZKsrlHsByDPniruEge4wGd3q1bJfLeqUdy6M8Su+9jzC06z1VgRC8G4NjTbmBwQWpd
 d08w==
X-Gm-Message-State: AOJu0YyMSkUTqAaJprT+bG1tgwQ2SG2H/XnytjMprRsQ+76l352D2V8B
 /iuliqH/epAKagCg6a8kKLp7nyk7fJp0cQftVEiQDRtqU8WAxihFPMaDrfByKnXYMIQ=
X-Gm-Gg: ASbGncuPGX+Ins+DY0a4lYMWPk8Baa9Pv8UcKoWRpX8BE5816dvWcZB5xWrFlkgX2dp
 wl1Tc0bWE3dgwUYHalDUbGn3wwGzlnudovhnxidr6+orIb2LXuGuWn3mNQzeH4AXqPzKUpJCabo
 vBzO9An8+YOdMP6P0du4M5/83ZXpVMZ+460vgPjjawTYqDjQ71E4x4UWh3b7ra5WBIyodEphqAV
 ojr83r6VTvvFJnmtKTOn4fiQXsqNhjQwH63W1iPlsqueJA/MWp2zNUi4OKqZdpilE6iLAeFl3Gn
 Fj5aF4XkhLAUoMYg2VZKDLNudqvZk+7kQIuDCVDh85QO75CfXvQBG6xe5FLDD3o0q6bBpT1kMTY
 f5rlMCTqeBwoOe5g+wH9ZXBkgFGg/rjD7itZNz9JQp+0NGAEBQZOG6I+x+kiEErz3+lDUHsYsPA
 JNUZhGDCDplDSWT1HSCg==
X-Google-Smtp-Source: AGHT+IFrgdsbkfNsVTV3ab1HqvzYDZlvGa60CQ+ZHjv07WKU2I7QT/Kb85ffDwZv/tI3cFbuMLrHdA==
X-Received: by 2002:a05:6000:3105:b0:3fc:54ff:edb6 with SMTP id
 ffacd0b85a97d-4266e7dfdb3mr4503585f8f.35.1759997862537; 
 Thu, 09 Oct 2025 01:17:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01absm33249849f8f.44.2025.10.09.01.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 01:17:42 -0700 (PDT)
Message-ID: <1b81d317-6c1a-42ca-8aba-7e71cfece3a5@linaro.org>
Date: Thu, 9 Oct 2025 10:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] target/openrisc: Replace target_ulong -> uint32_t
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
 <20251008075612.94193-8-philmd@linaro.org>
 <fowsbt2ovqpl5mzizniyqx6xhlnvu7lc2po3jbi2cslwrpu5ew@dkcvbphrov6u>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fowsbt2ovqpl5mzizniyqx6xhlnvu7lc2po3jbi2cslwrpu5ew@dkcvbphrov6u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/10/25 14:16, Anton Johansson wrote:
> On 08/10/25, Philippe Mathieu-Daudé wrote:
>> The OpenRISC targets are only built as 32-bit, therefore
>> target_ulong always expands to uint32_t. Replace and adapt
>> the API uses mechanically:
>>
>>    target_ulong -> uint32_t
>>    target_long -> int32_t
>>    tl -> i32
>>    TCGv -> TCGv_i32
>>    tcg_global_mem_new -> tcg_global_mem_new_i32
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: not sure how to split to ease review :|
>> ---
>>   target/openrisc/cpu.h        |  22 +--
>>   target/openrisc/helper.h     |   8 +-
>>   target/openrisc/fpu_helper.c |   8 +-
>>   target/openrisc/machine.c    |  16 +-
>>   target/openrisc/sys_helper.c |   5 +-
>>   target/openrisc/translate.c  | 374 +++++++++++++++++------------------
>>   6 files changed, 216 insertions(+), 217 deletions(-)
> 
> [...]
> 
>> -static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
>> +static void gen_add(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
>>   {
>> -    TCGv t0 = tcg_temp_new();
>> -    TCGv res = tcg_temp_new();
>> +    TCGv_i32 t0 = tcg_temp_new();
>> +    TCGv_i32 res = tcg_temp_new();
> 
> I think you missed transforming tcg_temp_new -> tcg_temp_new_i32.
> 
>>   static bool trans_l_lwa(DisasContext *dc, arg_load *a)
>>   {
>> -    TCGv ea;
>> +    TCGv_i32 ea;
>>   
>>       check_r0_write(dc, a->d);
>>       ea = tcg_temp_new();
>> -    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
>> -    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
>> -    tcg_gen_mov_tl(cpu_lock_addr, ea);
>> -    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
>> +    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
>> +    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
>> +    tcg_gen_mov_i32(cpu_lock_addr, ea);
>> +    tcg_gen_mov_i32(cpu_lock_value, cpu_R(dc, a->d));
>>       return true;
>>   }
> 
> What about MO_TE -> MO_BE to handle MO_TE[SU][WL]?

I thought we already had that merged...

> I think this is fine to review as is.  if you're looking to split it
> more, maybe moving helper signature changes to a separate patch makes
> sense (helper.h, fpu_helper.c, sys_helper.c, do_fp*() from translate.c).

These sum 11 lines, not worth it.

> 
> Also, might be worth reiterating that the migration stream is unaffected
> in the commit message.
> 
> With the tcg_temp_new transformation:
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>

Thanks!


