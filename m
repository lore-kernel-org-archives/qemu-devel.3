Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA19FD7833E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAee-0003jo-Dc; Mon, 02 Dec 2024 12:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAeb-0003jU-RQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:56:13 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAeY-0008Uu-NM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:56:13 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e397269c68fso3602842276.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733162169; x=1733766969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RnQY+VXTgzU1N4LJf3TPk5wngPXdj30nDDGBwg7Zms=;
 b=BkWjouSjqCga1ahEUv72BD+gCbS/1p6diVemr2odezJQvlpwge1CCaz1QGTmFyrHUn
 BPP/LNbFKc2aLOn5mQjWzQCyFmL2rWH5QfSnBbdfEv0aN9myCUIW1+duwhVVD8P6xGL3
 FpdgXJAKa7vVq+ob2LdzaaFesdpT2oWhAOIGMBl8S+w4ScNLwvr9JsHWOsgAheu57YLq
 k4+wNW4Tq7tXYWEUxnX7kqxU4wPx86xp/fkAF7mq1sknBLkQw0WAsaod54ajjTh0rmJq
 Hw9rwvylbrynHn97SUnjbeRkqpbsCnmjxvxkZvSykQrZOT/mcX2WvbZHFp+g4AXgJDr9
 529Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733162169; x=1733766969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1RnQY+VXTgzU1N4LJf3TPk5wngPXdj30nDDGBwg7Zms=;
 b=V+kltKGZv/BiRUJLa0waZH4PvyMxWeVLeTnEKlnMx6dg+9q5KVDcvhRrRn51edRg5Q
 DaSR0ZpyeHSbVklv5oP9pfprDcWjTDmkswJkNInvGTCrHJYCoarc6RFuT/hhKrcMHc/6
 96nMPB/hWVHAHMxVaVTPr6xDXX6ykFhxPaoDU318yCREI8tr/aebWGjz6poTsYQcVOkE
 IGmM0ICu++6DjPQEXEKEs5QW9qQ+wiuTRt8Hr7R9YMKsNYwxzN+MlFg2QNjujpaeyBXz
 /dRHGl19LCWR5UTsFPo8grNiKaKc7/x/YTVJmTTWxJ8jaYvP6T03kvGput1eKzTfX53Z
 WVIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWN27W3GuMpCIZZqXvcoEHeb4tWhVms8XqhN/zWYUWVZ96srNLteX5B1nCGw/hZydlLze46W41kuN@nongnu.org
X-Gm-Message-State: AOJu0Yz86/a6XwraLjvjG+Ij0NeR4huXNPXTsXzIfBEdUkPHlGWe4Ef/
 0kosCMKXJswX8FCCw79yg5W+YKecjI/rJV5T9etCOntL9tI+bAjbBG9WEHGU8h4=
X-Gm-Gg: ASbGncupru3fGCWkRHwk9rP6sUvO0D593Tgthx18nlIUtzbzWlWNoxJini9ie0UbjtD
 /BuHgYdhamPST4+rvv/YGEgDG6pBUoyGJZUNdAWOky0S0KVZ4DbpgnqVfMqEJfP97BTI6EeyONO
 8IvRthYadriQpb0Q+Xeadofr7zKzm2bVdTrt2f3+W2D4fA9r3pwY85pMio6J6+E0RbyA/ZH4U2k
 csNTonqEVDMaX98CBKM5u5L6Ka6XcCFxcnNd4l40Bt89csky85VeGidL/fpGBmWpRsOwew=
X-Google-Smtp-Source: AGHT+IGzw/EDxT44tpOQWp5F5thRj6e6aYrSMYC/eizCgeWcEaFKqJQ6rytcm7GCY/fQ0f3pOhNL2A==
X-Received: by 2002:a05:6902:2b07:b0:e33:13ab:52c1 with SMTP id
 3f1490d57ef6-e395b9364famr24753840276.35.1733162169019; 
 Mon, 02 Dec 2024 09:56:09 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8903b3a65sm32059646d6.18.2024.12.02.09.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:56:08 -0800 (PST)
Message-ID: <b89bb087-58f2-4039-8c11-59f373fb2b6d@linaro.org>
Date: Mon, 2 Dec 2024 11:56:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/67] target/arm: Introduce gen_gvec_cls, gen_gvec_clz
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-37-richard.henderson@linaro.org>
 <c0aa6a8b-59f4-4d3a-83c5-aff885a2eaf8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c0aa6a8b-59f4-4d3a-83c5-aff885a2eaf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb30.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 10:29, Philippe Mathieu-Daudé wrote:
> On 1/12/24 16:05, Richard Henderson wrote:
>> Add gvec interfaces for CLS and CLZ operations.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate.h      |  5 +++++
>>   target/arm/tcg/gengvec.c        | 35 +++++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate-a64.c  | 29 +++++++--------------------
>>   target/arm/tcg/translate-neon.c | 29 ++-------------------------
>>   4 files changed, 49 insertions(+), 49 deletions(-)
> 
> 
>> +void gen_gvec_cls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>> +                  uint32_t opr_sz, uint32_t max_sz)
>> +{
>> +    static const GVecGen2 g[] = {
>> +        { .fni4 = gen_helper_neon_cls_s8,
>> +          .vece = MO_8 },
>> +        { .fni4 = gen_helper_neon_cls_s16,
>> +          .vece = MO_16 },
>> +        { .fni4 = tcg_gen_clrsb_i32,
> 
> Why do we have tcg_gen_clrsb_i32(), ...
> 
>> +          .vece = MO_32 },
>> +    };
>> +    assert(vece <= MO_32);
>> +    tcg_gen_gvec_2(rd_ofs, rn_ofs, opr_sz, max_sz, &g[vece]);
>> +}
>> +
>> +static void gen_clz32_i32(TCGv_i32 d, TCGv_i32 n)
> 
> ... but not tcg_gen_clz32_i32()?

The tcg_gen_clz_i32 primitive has a third argument to specify the result for n == 0. 
Passing that third argument is exactly what gen_clz32_i32 is doing.


r~

