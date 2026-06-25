Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C73CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnuj-0002BB-M3; Thu, 25 Jun 2026 13:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcnug-0002Ap-0u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:30:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcnue-0008Rl-65
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 13:30:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c6be9cd89bso783995ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782408650; x=1783013450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=efIV4HiKqZhjnGt3wXoH+9AKlr90U3vrVx9XRDB36xM=;
 b=zj7geBOiKxpLyFmLwLzf2KgziXn868XY3zxkQCRYDuHWXt+czSRM8oe9v0beaWTkW6
 BIA5tEHGHTGuDfc44m9UPouhFCYfqH/aJUedF0BXcV3dD0DGGuOt2aXm7quGJsITS0se
 iUCPlbRME1L+3K8dfEf+1jzS2Ov/np+egiNijkc0cJCMEWzKBvcN8gv1ADJKHItJ6svk
 CqAGQwJ//mvEGo6JFuco/FkrdAtFokr8dxI2L/3hQ87MKWNvdasXTewPEZs3z0JRjC6B
 h/FTgTC4zLiJ6qpqOYw5QnyJk0jz5L0VSwFcW5pvaC6NS8dSosWehdnF39ZrTJPwO7hu
 UMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408650; x=1783013450;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efIV4HiKqZhjnGt3wXoH+9AKlr90U3vrVx9XRDB36xM=;
 b=p2PHARC+vyzH7a3UX6IyhxIzJdKnoqWueu+an37XHMMqHvQ+6UO9DX+sxnFFesnoFm
 hrYioaZVM13ITUstz8WKe8A9L6V7NsTM9LCo84Us1q8D66dEAMpEAD9E3lCLoUTxbncY
 ul+DBh+NQHEJE8rAzw6HifV1jz53AsCBav9JOnKmU4I6X7iP5buWKHuEPQrQhblcoF4c
 bx72EenJ57GZrnr9LQv6KpVRKGMe5AdDTRJ7sXSzEC7w1CHAz5bdKI4MPcXNuHc4IB1H
 c46wkwIqkoQkYYF+Y6GHGcayjTtFhQRhFD6b7hV3b6JtIO2d+oMlgIa3dCQ62XRmJwrW
 1ivA==
X-Gm-Message-State: AOJu0YyTA09TypLej7n8fN4BdPoX2CJJehMTa+ENQ041cSS0JAf/aNgC
 70w03W9EMuJ8rWzmyY6aIiyUM/gAJ0U4//859VXv30PiP9hWg4TleLfdB46kgy21sDs=
X-Gm-Gg: AfdE7ckdAnyRNCsw+86EMH0jjax/w+xmBA8TxlwznCDnIULmR8FjCab1+Vle8V5f5Ai
 E7AIq2ObiDJYUlvMA8u3G6WmjrYH02P2xOk2QxeamLiQV8zwgc13K8tx6kTGEhn7tb0HQWRM3RH
 k3S8jjJ9nyWFbE7gTdj3UhbdSkyKd5V+8zxyf9na5Q7blkijj9iytseSunjtCbjw9qHVMz1LuWf
 7qOZ/uPRF4FwtEp32taVkSjWinV3oFmQhFh/rhhnWJsaCBNEr1p6vdQ26YwvSKGL7xZsEdlNmmn
 MzgMbKAbidv0wvcOX3cdvgsKOOrWDxfBRi/MlhnUPYxgD/3cL1vFnJmYxVyOf4kC9+AR0Zy0npS
 0v5KuHS2thVI1joNYXz3seGqfq44Vp9PyTTVsiFkoc2EDzTnm+FEy7/wT/DWwdvYHYEyuERNdr7
 ZLkfwVX/cpiG9hQvGqMLED/Rmrx8wqmTRfaaljtv9Rim3I3TMXm7pKB8K0MHKgbzqNtIoA
X-Received: by 2002:a17:902:c410:b0:2c7:f464:79d0 with SMTP id
 d9443c01a7336-2c7fc797f76mr38778905ad.10.1782408649999; 
 Thu, 25 Jun 2026 10:30:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5afb1e0sm25325055ad.29.2026.06.25.10.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 10:30:49 -0700 (PDT)
Message-ID: <c8b5aef6-c4ee-40a8-b232-877b84595ea9@linaro.org>
Date: Thu, 25 Jun 2026 10:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/arm/tcg: Implement new instructions for
 FPRCVT
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-1-dc6cf8e512b6@linaro.org>
 <87y0g2h9sm.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87y0g2h9sm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/25/26 09:19, Alex Bennée wrote:
>> +/*
>> + * Floating point to int conversion, but puts the result
>> + * in a SIMD register.
>> + */
>> +static bool do_fcvt_simd(DisasContext *s, arg_fcvt *a,
>> +                      ARMFPRounding rmode, bool is_signed)
>> +{
>> +    TCGv_i64 tcg_int;
>> +    int check = fp_access_check_scalar_hsd(s, a->esz);
>> +
> 
> I did test with:
> 
>    g_assert(s->is_nonstreaming == false);
> 
> which shows trans_FAIL or aarch64_tr_translate_insn setting had done
> whatever it was supposed to.

By default -cpu max will never set is_nonstreaming, because FEAT_SME_FA64 is enabled.  We 
do have an sme_fa64=off property exactly for such testing.


r~

