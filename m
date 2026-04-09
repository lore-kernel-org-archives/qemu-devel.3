Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D7F31E44
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wArgW-00081i-RL; Thu, 09 Apr 2026 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wArgU-000814-Lu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:52:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wArgT-0001Il-1H
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:52:46 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c757a9251faso430449a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775749963; x=1776354763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1N2uvWT/CSMMMV8QXoU6dZ/1lBvWncIFCClNpJHs7Ec=;
 b=ETNFJObvPsQDT6JhL2bvmkCBlHOoTJzYSEqUHaOrjOmhaEyjFhu+xO6v45qkh5EQXo
 bk9mSfHJ24Ib8I/2SDONSjGhYjdBBMwSmYXvSmLCO4zja9FN6Q8zVXsTsRqr6Lutpwo0
 zqcJCdYAY7pQshSb9NkQRDhWiuxaC3hc/EPQIQbT53MMcKXntzc21Uoad6V0WZq5FWJC
 Xsev79S1ctZpPJjWnhaecmgsNGjrMwTRLKuQd2B4OEAnps6EtCWl2F0AnMWIzuxnVFDx
 IduEjNbffvYk0s/mwwHeenIo3Z0oJw1L5PXSqL50EcUjdbxNdsin1IlTXlAX4HKtlkJP
 J+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749963; x=1776354763;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1N2uvWT/CSMMMV8QXoU6dZ/1lBvWncIFCClNpJHs7Ec=;
 b=lFL07t8bZqddhKSaxVeynk2/63jg1TurLJEByo4IyIuOX5T6c6LU3cw85We0NAv1WV
 vYwsg1/C1GOwNmBz/O45f3gmRMYwYvhZR0UrRBf/PygCtCI41xiNsvOz1zzxTzUOJNM+
 S+lMHZTk2/vKtFBrUJE+AMXDTQDvEtFakNuDZLbpWt70yU8omi2oWYHVCey2/0L02l88
 TvgIYHcBPLDeUUa+965Ln1b1cfd+0xSak6CC/76s2m9T1wCNxMGf263G/aa92EzD+q/b
 KFojG2+u3GDQbdkCpMuxBLV0OfUgNlQzQdzIS9iEF9nMg9kJ7GeFO4ToJHf2ln9Q5HYk
 Q+6w==
X-Gm-Message-State: AOJu0YwFtZZrlkZ/63/Wm4QaI4yVzYkQwj0iOJwdFO+CHLm/s0x7h9ws
 EZl+o/dISamTeSkVC35TfxITMev5QURPR7vQ93EFzqsN8OL1sNXM+B/COuv7GiOjXIQ=
X-Gm-Gg: AeBDiesWb8XtLMOTaSaUFfX+7ZcO0OznNkJOcfHMW7OdIF/q6HVUb1vabu198ZtAabp
 g0ROawBjGi/DCXcraJHzAAElNtW+/2h8KMvV48emRMI0SfimkT5jIvhrwplxuRgGI6Z6yCIYGC2
 mB0X5a3QRvqfsocfR/MDClr7lgsBW89RmT7LljXu0NFRU7/5fVP/PS1dhQ6TYbw098SgwcW2qQO
 EZdJCl6+R1/XPQEYkDq0uh1iPzqSFl8tJEe5qI7PX7EDzJ2KC9hh1ALDFaPlZvp7YHgD8KGtC3I
 FER+jSyppJlgi1u9B8xSK8DtNUgjdjjOb+2Olv6EYoCvOkcA7yLvO8SMLYb/ivWZPibZY28qUxJ
 oyw2w5QFjh8p87ANrvhdTXUqOyDD/x6cI6MsAI2DSLDiXDjUoM1RIhwBPHUkfwYxvMIvOUsIHTY
 JVSd0zjC1KYlNSpG3uqw45TVEz2Gao9oOG1cB7a5DoSSNE9aRayAS9wH11HieL7QrIM+tnhTx56
 2G5lzNN
X-Received: by 2002:a05:6a21:3286:b0:398:b499:44e0 with SMTP id
 adf61e73a8af0-39fc832f20dmr5168596637.41.1775749962682; 
 Thu, 09 Apr 2026 08:52:42 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6492097sm21756566a12.10.2026.04.09.08.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 08:52:42 -0700 (PDT)
Message-ID: <c425b6f4-0c63-43ba-a0c9-792f7feb07d8@linaro.org>
Date: Thu, 9 Apr 2026 08:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/21] target/arm: single-binary
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <CAFEAcA9rQez-BFVhpDBjFKZjKNXtCuK8ikPWRryN1Xed-MZ6=A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA9rQez-BFVhpDBjFKZjKNXtCuK8ikPWRryN1Xed-MZ6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 4/9/26 8:51 AM, Peter Maydell wrote:
> On Tue, 7 Apr 2026 at 23:22, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> This series tackles (most of) the rest of target/arm, especially tcg folder.
>>
>> We extract tcg memory operation in a new header, with a new type representing
>> virtual addresses.
>>
>> Initially, I went down the way to have a dynamic definition of TCGv, which
>> required much more boilerplate and runtime checks. After discussing with
>> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
>> properly in different files instead. This approach will not work with other
>> architectures, requiring something else, but it's enough for target/arm.
>>
>> Files left are:
>> - target/arm/tcg/mve_helper.c
>> - target/arm/tcg/m_helper.c
>> - target/arm/tcg/cpu32.c
>>
>> v11
>> ---
>>
>> - update comments
> 
> It looks like this is all fully reviewed, so I've applied it
> to what will become my target-arm queue once 11.1 reopens
> for development.
>

Excellent, thanks Peter!

> thanks
> -- PMM


