Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D6FE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdl2-0004po-0n; Wed, 08 Jan 2025 16:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdky-0004p2-P5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:38:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVdku-0000As-2g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:38:25 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so3350625ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736372302; x=1736977102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YKXIFVSTq47jYItTgeHyTlyDqixliJsgFkdWAYcjEqQ=;
 b=KEm3Wa6NSqaBznMldmS7WM9Fp8IcWYjxD+fNJ2a1ui8x2mvxH6ZBjcPk5gYDuMClyI
 9FWrfGentDtlFouQrclA8KnrDE828i2OLTUO2OPA9iskq3wMic6godIknipFx1Fv21SJ
 jP3eSSzeUjR4uB2dMsgD4qBMpoXGYh3/8b3YTcHS7b3oXpVqxAKK/7/jiTQktkJ5hMny
 Lo8uIXhIIa0YuLgMEHTgTMgzc9lIJoIu2PkcgRLUk6QtkRVRK3VTcc7EfWR68vVFRfSb
 P9jHrqDRNquTU/qVtRCgddFnyLGboB87pd5hK/f0awAjO8EWY+mtXVBBHDYFIO0ISgKn
 0xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736372302; x=1736977102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YKXIFVSTq47jYItTgeHyTlyDqixliJsgFkdWAYcjEqQ=;
 b=D1hEBwxUbtM8U53gK1r3AEd/P2udOKmdGqHsjwV0FABcnZ5lKlTi7fd55zqEZZqpJ7
 Sho2NlzKm3RcGE3eg9xvqxH5zgQJGDWUZL0xDN8pjbsqxKzImWGtuDMTvUQQv/moofTp
 ks9HLGHOeuwqEJwXk0sYd5eE0aPq2WAxilhiUD5T4JcVqdU2gAOH0LyEpJV26Qltlvvr
 /WpyaNmUYRgCq2aCbLS8Yhw3muO8YNp+cFOBwVqznEuo4XOmI5EM7RcQ/EbXJIdvUDVy
 RlJNISeKkdz66efA7vfMT4gKelvzTU5Pdi+XrqckwU4loX2SJyqVdpHRD76euUuObjln
 OOpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRT1p55t6gD0ZBWNOv/gHzzFdHajMTsVI3jhhbnbtQGWaiQbGO0dZBih/Auhepv+fwnb9sSQk/MLgR@nongnu.org
X-Gm-Message-State: AOJu0YxdQrkuzw3f7eNAxlKRcbZ88SW+1rG6a/ASetq63Q7d0+RlxJTm
 ScWMwVEEM81tYfRN9l34wAYknkQRXeNRV5seAYu3eKI6QaNHUsO6ANSY+XqlGLw=
X-Gm-Gg: ASbGnct8O5waoxer+PcGsRjjqofeO+JWH4KyU6DYQDfmkoSku/iKs9smR6JX80tvK+B
 SYwRBq+X5+lcnksSdy/Bax/nF9/xkfYhlee4SC/Za3puILCqmnaS9irywSYMQSP/QIJ9lO3EXod
 dT0aytN3Mi200BOUjiR3p3W2oYOZosHpwftB1TJKWQpihZQ1SXg4fK2DkaWAOrdIWS1xtNuzerN
 Qvcni5mhkEaklMhqCTjFmtxPI6LoxBfqwKZfxx3p29KlvT1xCfJFd0fEXH+RjoDHEPgiv76AzzB
 8t3dt9BAl+PAzXBhhDkkYcAO8MAL0I4=
X-Google-Smtp-Source: AGHT+IF1oyFg4D07uxiOtJpRDXtYZ2BR2thN+BMr17TKwxduUEDmPt+9ushU3xMib8so0Rru94HdUQ==
X-Received: by 2002:a17:902:f70f:b0:212:4c82:e3d4 with SMTP id
 d9443c01a7336-21a83fd90e6mr69479095ad.46.1736372302327; 
 Wed, 08 Jan 2025 13:38:22 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc964b54sm334191315ad.1.2025.01.08.13.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:38:21 -0800 (PST)
Message-ID: <393fb699-a360-416e-b1d1-df9372685c16@linaro.org>
Date: Wed, 8 Jan 2025 13:38:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/81] target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-8-richard.henderson@linaro.org>
 <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eed31d9e-7c0f-4a96-9442-48bb2c56337f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/8/25 09:46, Philippe Mathieu-Daudé wrote:
> On 7/1/25 08:59, Richard Henderson wrote:
>> Rely on tcg-op-vec.c to expand the opcode if missing.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-sve.c | 20 ++++----------------
>>   1 file changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
>> index 49d32fabc9..732453db6f 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -596,14 +596,8 @@ static void gen_bsl1n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, 
>> TCGv_i64 k)
>>   static void gen_bsl1n_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
>>                             TCGv_vec m, TCGv_vec k)
>>   {
>> -    if (TCG_TARGET_HAS_bitsel_vec) {
>> -        tcg_gen_not_vec(vece, n, n);
>> -        tcg_gen_bitsel_vec(vece, d, k, n, m);
>> -    } else {
> 
> Why aren't we doing the NOT n operation here?
> 
>> -        tcg_gen_andc_vec(vece, n, k, n);
>> -        tcg_gen_andc_vec(vece, m, m, k);
>> -        tcg_gen_or_vec(vece, d, n, m);
>> -    }
>> +    tcg_gen_not_vec(vece, n, n);
>> +    tcg_gen_bitsel_vec(vece, d, k, n, m);

Pardon?  It's right there, unindented.
Anyway, maybe I'll keep this, as it's still used on pre-avx512 x86 hosts.


r~

