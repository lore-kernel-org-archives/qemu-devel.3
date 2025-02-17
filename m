Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661F3C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk769-0008R1-3J; Mon, 17 Feb 2025 14:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk766-0008QV-9S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:48:06 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk764-0002Hp-Fc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:48:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220bff984a0so83142175ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739821683; x=1740426483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J6Cus3vP9ou6L46hFc7b1ht3OxTyAOM+KphqUd3oF5U=;
 b=QDDfzDwDGhvusmqRxvhxztHndAl/bmOzsIV96N3pu6p8EH/SIE5mSNZ7HmXrTRmYQ0
 UNidt4KPOct6cn2257L307OZsEXIonQ1QR5nFAiQn2PyA8G0fDg6uHHi52t8CYNX5QDh
 GUijgywdJxzDFWklypHn64o6RT5fAXR+4fAiop0FNwFz5YN8MGLgVROp2s8pnQF33oYi
 vAvXQGXCWirHRUOt93wH/W2EJh9oCm8vAaWiK+crW5exsElSwNylhfY88ULzGd80mO8a
 giUNjPQW0hKZax9BbTTYJg0rELVzIutkYgqtMYhF0DO7jiN+TeWsIlMV5XHa18Gov/ug
 MMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739821683; x=1740426483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6Cus3vP9ou6L46hFc7b1ht3OxTyAOM+KphqUd3oF5U=;
 b=ilCtgdq5RpKrtIcwzTaTQEdY/frp/38A/xnQ5v0cBiFOfFJKfMKGj3iKczbaiXi5fq
 DmUsYtMbXYmEd5/4aTCZxhSwiW4ZYms2AfgiC8raFbaHVeKqdLUpluDdO0jba8gjGy5z
 2aOw2Bd2vYm9JGuIOCxkPjwKJvcMUz/rU2z8/V8u/vE5KLY6XpDcgJYL8CliUfbc8GJd
 58Pl6IhNZ1ApfECnV1Cj2n8ABI/bGvT6mO5R/pvXdz+PWRV1e3J8DPz8GiiQqdCJ9Ndr
 11Xi2fHCG5huBpSdZKPS3znBe11HXfCNUek3zajScq6+PkAQxdcgZFxCkRmoEYuvFOmo
 CuUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmqW3/NzY4wVDxHsNdUTPWWSuzL+63He6hsDWl50GaFxjJUEspjA808XmF79NFctgV647bgI7YfG3J@nongnu.org
X-Gm-Message-State: AOJu0Yxc1X5uxuIY0CEpDp9zdebL+qlvbgnKFTFnWhJJbNlg4IdgcbSG
 QRw3l6Pi6cvEUamRIwoJMTYeqB5gVvu/cSF+ZjFi8GHEs9XurmpKboPV5gWQNzc=
X-Gm-Gg: ASbGncuOE8fzgNBf+4cnS3YIaeEF1SL+RzQytNnlzMy5TWTS6vSCC7/ywgqvvLor2Ft
 DDfMY8bQtNVz8sOX3jDE6VI1F2KknLFwOIpjvt3b1VDev8LJcnQ8OB/S+ksw/5bLzzwmb/QB1Jl
 9DYc3WlhPlKOVx8v0ziAffGpmm6ubeodyothzOT23hKYFU56LoSNZk/EDWIsMkbJvCwjU31YW9b
 PM5/wmKZHhnptTVuvYbC/dQYles6PFjBjKfOQ8CIyedQJuYimbmq7ThgE2i2KdmoFTNIn32VKAQ
 Jo0KysWB9dwOZvtdgVEY4ik4WceDWVgxrQfWxCa9f5A7urDJeCR0KNc=
X-Google-Smtp-Source: AGHT+IFzxe7QQVk6eFXwjv4xYYsN2LzlNvIxgRRi/pftgTQxnp5/3m43ytiwcrPO/7gSOzvHq+Zd3A==
X-Received: by 2002:a05:6a00:1488:b0:731:771:38f2 with SMTP id
 d2e1a72fcca58-732617999fdmr20872866b3a.8.1739821682677; 
 Mon, 17 Feb 2025 11:48:02 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326bff59f1sm4111882b3a.116.2025.02.17.11.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:48:02 -0800 (PST)
Message-ID: <eccd50dd-24cf-4099-940b-390ceadd37b2@linaro.org>
Date: Mon, 17 Feb 2025 11:48:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 051/162] tcg: Merge INDEX_op_remu_{i32,i64}
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-52-richard.henderson@linaro.org>
 <3ae1f844-b318-4503-b5e8-4cd6ab82ea86@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3ae1f844-b318-4503-b5e8-4cd6ab82ea86@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/17/25 00:29, Philippe Mathieu-Daudé wrote:
> On 17/2/25 00:08, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h    | 5 +----
>>   tcg/optimize.c           | 9 +++++----
>>   tcg/tcg-op.c             | 8 ++++----
>>   tcg/tcg.c                | 6 ++----
>>   tcg/tci.c                | 4 ++--
>>   docs/devel/tcg-ops.rst   | 2 +-
>>   tcg/tci/tcg-target.c.inc | 2 +-
>>   7 files changed, 16 insertions(+), 20 deletions(-)
> 
> 
>> diff --git a/tcg/optimize.c b/tcg/optimize.c
>> index 55663ff4c3..6f0887f808 100644
>> --- a/tcg/optimize.c
>> +++ b/tcg/optimize.c
>> @@ -563,9 +563,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
>>           }
>>           return (int64_t)x % ((int64_t)y ? : 1);
>> -    case INDEX_op_remu_i32:
>> -        return (uint32_t)x % ((uint32_t)y ? : 1);
>> -    case INDEX_op_remu_i64:
>> +    case INDEX_op_remu:
>> +        if (type == TCG_TYPE_I32) {
>> +            return (uint32_t)x % ((uint32_t)y ? : 1);
>> +        }
>>           return (uint64_t)x % ((uint64_t)y ? : 1);
> 
> Or directly:
> 
>      return (tcg_target_ulong)x % ((tcg_target_ulong)y ? : 1);

64-bit hosts need both expressions.

r~

