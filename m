Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A98D111A8
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Nov 2025 20:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPo1D-00053G-KC; Sun, 30 Nov 2025 15:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vPo19-0004yH-BJ
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 15:27:36 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vPo15-0000C1-FZ
 for qemu-devel@nongnu.org; Sun, 30 Nov 2025 15:27:34 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so2299058a34.1
 for <qemu-devel@nongnu.org>; Sun, 30 Nov 2025 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764534449; x=1765139249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMJZBwVs9gqBBzOJ8S7troW6yyy+51EYmLqB1/LUuhA=;
 b=L7gRl7lAUFwP7LhTwiB6A4BLTxaRl0Lqcs7mqcIKhqVER9H9NHyw/uH9iJz8mRpplE
 6CmnJ5zONdEYXlLuaRG2Ysatg+Mxvxm3/XabG4s2YzLg9nG0QDuCGYMbgXsnhllnOuhx
 MC6+3/KPhiYHR4I1/2bBit+cpgn8/Teej6hRNmgOS8edBjnf2GCFZXa2QO4AK9IaEn4Y
 HxQVMxnsCPjBstWSawWuxfhNOff9aOud6fmC5d672xKB3RLmmDgFfEMSIK1699+a5Z1D
 hW9+kHK9zR+iPfP7O00AAysV1VLXnX4tvbHursYuwjU9UiwHG1255g5ixyHK4ROByhtY
 ZPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764534449; x=1765139249;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OMJZBwVs9gqBBzOJ8S7troW6yyy+51EYmLqB1/LUuhA=;
 b=Z5MGiaQrmCgFKbGyfpeEsz7tS6V6KWmGNP5lpOlXZJOPLRt+4gYordjgpLynr4XudA
 KsG5GUdqsdnv9h1qedWs5Bpvwgrk8HY5+GkTON+gnfNpyAMA8/icM+b6EacujjlJA0UM
 KCgmNVNe0YvLEbAOnKo3EkK0OsnKeE05F2HUkKKivdQ5OfjzxhdtXrHjUtGLHuZJ+xyp
 aTkRKR8twoWWRvU6eNIX02RGNd7My/Rf/429rrb7MLoxbwvl1ZT93bZlFv9nXeSd30bo
 u465bEIKoDYnhlTlTYnYK5UcIMy4TqLSSC11r5JTlqf9eE8LKYI8+HNcrxqHYvbRDYU1
 A25g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbguK9w7H2rgb68e78Ct3icAufJCz0DGg2zj6cPW8S/lWVJumswt4XF+JAAHdfc4SpQCKr5P1MvC5D@nongnu.org
X-Gm-Message-State: AOJu0YyFXvPlhHvRyucXtdKOhUwl54HQjM9TpaUWFtHsH7eAnapl+Tb0
 8KXpXjSvwQ+VBa8O86pdW2t/AK0S5c5YM9PZ8ThZ/knZajtz4SOVAJjbP+LiB2tLRU33YqHaAO2
 WKZ9MPBE=
X-Gm-Gg: ASbGncuvKQIgxRRn8DI/qMFGrK95D8BS9rskTcME4TGd+fDCIoV3+6Gomenfdi4U1bL
 O9HQDL6CLOpolanfTg5VEmrSshN/jnTSG2VvdG+HL7kiaogTdBfKojisjj3GSOfl9WgWlYV9reu
 X5Lckt+SQD7aLrDF/DZAMj+jXuzg57wSf5NarQuaXnlyTuVfiEjDj9E1Y7K+QZ9NbkqfuyI9rne
 FOnmNvyfOh+aqtXLwHwM/r9JmmE7DIAUeOs1SydlGXKrHKJS5HTYGoOAhmJ/j7v+rjXN/9WDsnF
 ol7wUAmxJlYQKhmxHF340BCotFI8fhkJPYZGc8I2G7Ao/H3QCSWcEjo0wv7aMD8QNbH+vpccZVn
 Y0LQ29dTWr/LSds4kokqECVOqUI0gxfO95eI9JAulVtmH0RlEB/0dKEdiULlwEnRSTbHwh2IG3j
 HbqwI4sgJTZKVLqC9sNrUDfFe9t1TJUvF9u9k=
X-Google-Smtp-Source: AGHT+IFI1nyHscDYsCFzFlx94E+85RdS+jmJezjvE7Rjl77IlKtkDE6pFroy8X4c5S+Fv8iMamXK4A==
X-Received: by 2002:a05:6830:44a1:b0:7c7:67be:8ea with SMTP id
 46e09a7af769-7c798ccd71amr18569193a34.18.1764534449094; 
 Sun, 30 Nov 2025 12:27:29 -0800 (PST)
Received: from [172.16.93.54] ([201.144.25.11])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5fe927sm3927238a34.9.2025.11.30.12.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Nov 2025 12:27:28 -0800 (PST)
Message-ID: <1706a491-f76a-45e1-9653-f3ba730690ec@linaro.org>
Date: Sun, 30 Nov 2025 12:27:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix assert on BRA.
To: Peter Maydell <peter.maydell@linaro.org>,
 Harald van Dijk <hdijk@accesssoftek.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com>
 <CAFEAcA8j6sAmm-uT9LdDt1VP2fWmui9ETXn90bDWbCh4aEMG4A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8j6sAmm-uT9LdDt1VP2fWmui9ETXn90bDWbCh4aEMG4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 11/28/25 01:31, Peter Maydell wrote:
> On Fri, 28 Nov 2025 at 04:38, Harald van Dijk <hdijk@accesssoftek.com> wrote:
>>
>> trans_BRA does
>>
>>      gen_a64_set_pc(s, dst);
>>      set_btype_for_br(s, a->rn);
>>
>> gen_a64_set_pc does
>>
>>      s->pc_save = -1;
>>
>> set_btype_for_br (if aa64_bti is enabled and the register is not x16 or
>> x17) does
>>
>>      gen_pc_plus_diff(s, pc, 0);
>>
>> gen_pc_plus_diff does
>>
>>      assert(s->pc_save != -1);
>>
>> Hence, this assert is getting hit. We need to call set_btype_for_br
>> before gen_a64_set_pc, and there is nothing in set_btype_for_br that
>> depends on gen_a64_set_pc having already been called, so this commit
>> simply swaps the calls.
>>
>> Signed-off-by: Harald van Dijk <hdijk@accesssoftek.com>
>> ---
>>   target/arm/tcg/translate-a64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index 08b21d7dbf..cde22a5cca 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -1916,8 +1916,8 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
>>           return false;
>>       }
>>       dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
>> -    gen_a64_set_pc(s, dst);
>>       set_btype_for_br(s, a->rn);
>> +    gen_a64_set_pc(s, dst);
>>       s->base.is_jmp = DISAS_JUMP;
>>       return true;
>>   }
> 
> The commit message on commit 64678fc45d8f6 says
>      The set_btype_for_br call must be moved after the gen_a64_set_pc
>      call to ensure the current pc can still be computed.
> 
> but I think that is incorrect and it meant to say "moved before",
> because the actual code changes it makes to trans_BR() and
> trans_BRAZ() are
> 
> @@ -1521,8 +1528,8 @@ static void set_btype_for_blr(DisasContext *s)
> 
>   static bool trans_BR(DisasContext *s, arg_r *a)
>   {
> -    gen_a64_set_pc(s, cpu_reg(s, a->rn));
>       set_btype_for_br(s, a->rn);
> +    gen_a64_set_pc(s, cpu_reg(s, a->rn));
>       s->base.is_jmp = DISAS_JUMP;
>       return true;
>   }
> @@ -1581,8 +1588,8 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
>       }
> 
>       dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
> -    gen_a64_set_pc(s, dst);
>       set_btype_for_br(s, a->rn);
> +    gen_a64_set_pc(s, dst);
>       s->base.is_jmp = DISAS_JUMP;
>       return true;
>   }
> 
> which move the set_btype_for_br() call to before gen_a64_set_pc().
> 
> So I think that we just forgot to also include trans_BRA() in
> that change, and your patch here fixes that.
> 
> Richard,  does that sound right?

Yep.

> 
> If so, this should be:
> Cc: qemu-stable@nongnu.org
> Fixes: 64678fc45d8f6 ("target/arm: Fix BTI versus CF_PCREL")
> 
> and you can have
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

