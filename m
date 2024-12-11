Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FAAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPGD-000300-9N; Wed, 11 Dec 2024 11:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPG7-0002u0-Qh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:08:21 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPG4-0005c5-0v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:08:18 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-46753242ef1so55249341cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933295; x=1734538095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRqje1xMFeGF7r0mhyZ6Ulp/V9B4AQtSo5FO4+ulxWA=;
 b=Kl1cfWLEyEx98FowhjFHfGNB9VNbxjRnAtDoygMmNAWTIS3DzsoxqZOY9YK+dzbHZG
 8jfc1pO1F3DR3YMzYtksIqZAaYrzyTn0p48c5FWzA7JcVXRp0ozpCRiJS++X3QW+/TA/
 NUghMSSRcsWWJNCFJ2Xmvbq/Oom2KQShoAb9gpQQEuruL4hd5lNk5T1Nh13I6Q57TsL3
 gkPT6Q82xlmGlzcEB8WYXE0sGQshuQ5idczO0zQ4I3rS95mWn4qIWCFSoe1a9Z1reoKU
 WhDAHomq2rm46Xxsb7wV2e4An7A/yaLnWzn1KdQJ/or+FT/1y2EgpFVB6rQ3KmNXNntk
 TUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933295; x=1734538095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRqje1xMFeGF7r0mhyZ6Ulp/V9B4AQtSo5FO4+ulxWA=;
 b=lxi0dVT/ehLAUO1314jU9MqeS2mlJkDNwvOK2byeo8ak+ORJ3mGsMEnjV3kpayK9KN
 XCAGnHdiEnXEHD27MFjc2jzeZuyCVRiSP9I+2QglcUITDLPhULqaZRs7p3ujmVZimtFL
 VNgdRR85Ritu5yrwHdVH/WLzo8/8Jsf72gMTJal4UTNYVYc1JWd5dBevbqX8FofjtWBR
 bXjr5b41+djjjadtFglRU0itTdXIWLD5QPpXMs01Tmp/XiwhnEsY8/ZjFIsF8Q4vMXbR
 UPNmOrB6cxcGV9UXgsOd1Izh4GbiSk0mgYVO/MyOngjZQx7UBg7aDo1FLExzE8kw7WFe
 +q2A==
X-Gm-Message-State: AOJu0Yz3xCNzCrnz9fwk17Z6JvXflYXN51+jkTbDnaiyaPnPlSU0RRUg
 kAnMX4SuNlAMXoOpVF7UE93DoY/mx9X/u6MJZXPCk3XotWMVA61zzym26hiKM28=
X-Gm-Gg: ASbGncuFQTTqBOoxPPnSF3JXQ/zVACHQrvKF0Zu8co7HMliNXogPZGNcCkUIHETYy0j
 6vE7SiQrySgTOvg80y/2qQh6bbANRkjQSmt3fNI5Zz8Q+JEUTQ8C1DeYzPkmfRDLNA4bfxwPMLc
 E/mmRSeE1zeG7YCbKFgfC2NPXkZ/nemqXdobZczWQl4DiNTX+3VtZz9RoKjSe/nQRuIO4aC6nu+
 6oApokHEUreNadP17OCGpITfTKEzwygmzGHSoLA97Jd+irWm/QJoOHHO8ASq3LbHtA5S6Q=
X-Google-Smtp-Source: AGHT+IEZPRNH7zF+2VRxrnu6/SnvJyunvqRk9bVtyudbNXhAq7fKNyv8J1XTbm9sADVghPxC3U16UQ==
X-Received: by 2002:a05:622a:1186:b0:466:886f:377a with SMTP id
 d75a77b69052e-46789292fedmr70039531cf.3.1733933294851; 
 Wed, 11 Dec 2024 08:08:14 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4677b66db85sm17764271cf.86.2024.12.11.08.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 08:08:14 -0800 (PST)
Message-ID: <c208516b-d2a4-4b3f-920f-a4595aaa3e69@linaro.org>
Date: Wed, 11 Dec 2024 10:08:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/69] target/arm: Fix decode of fp16 vector fabs, fneg
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-24-richard.henderson@linaro.org>
 <CAFEAcA-9nUy0g0f0t7ais-Ygy1=2cDz2==-St8fU_tZ1GF8xtg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-9nUy0g0f0t7ais-Ygy1=2cDz2==-St8fU_tZ1GF8xtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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

On 12/11/24 09:44, Peter Maydell wrote:
> On Tue, 10 Dec 2024 at 16:19, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> These opcodes are only supported as vector operations,
>> not as advsimd scalar.  Set only_in_vector, and remove
>> the unreachable implementation of scalar fneg.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index a99f3d0d13..f67360c4c5 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -10816,6 +10816,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
>>           break;
>>       case 0x2f: /* FABS */
>>       case 0x6f: /* FNEG */
>> +        only_in_vector = true;
>>           need_fpst = false;
>>           break;
>>       case 0x7d: /* FRSQRTE */
> 
> Also case 0x7f FRSQRT I think, which will currently fall into
> a g_assert_not_reached() for the scalar case.
0x7f FSQRT (vector), yes.  I'll fix this case too.


r~

