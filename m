Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C14C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMOh-0003PJ-6O; Thu, 03 Jul 2025 12:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMOf-0003P0-RP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:50 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXMOd-0004D1-Sv
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:02:49 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735ac221670so47952a34.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558566; x=1752163366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zkcWfcK1/lUpJ0AU3XY947MWeB16OWAJDTb+wu4sJL8=;
 b=Ha2xjGV0TGcTVVRbfjpl2V0ZioNaLNVxc8WIysRgT5kIQh67UiYqv3OJbDP9Rm7iD/
 92W/FoYF57f3U3jwwZKiO9Pmr5WS/U78tj858KaGWTE/l2jrUFDxOQzDgKF8UyvGMBxu
 mdegW8suTmUt4EE0KdixJQ4ELzlFcJO4iUGhZ90rQt+xIarU+I7ousNPN2BGsl+VIdRo
 vMZE6DTn4L3J+W31Ev+I/e/y8h6kDbtpffremZNBM7Cky1RqTOppLzw09VQjRpC6mAHY
 d4G0ekESWc0/wQJmJC7cae7bvAqeb6SvqqU7xYdnHlOOqz15fMuBeKwQr6MFNmCTdql6
 C7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558566; x=1752163366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zkcWfcK1/lUpJ0AU3XY947MWeB16OWAJDTb+wu4sJL8=;
 b=lnY4GlU3emsZAP42P4SQl5B0OKojHkloBqD52ovClu8X4/x6xJhegKCto1kBLoXcjv
 M4u2D0+Z7FH09jN0M8T/me8Am2DHl79g0lk/poTjWHoFM4W9e/SgfLPYrvv3wMMaVT4P
 qpHyAbw2PklZvMkJONFlxE1AwXMjveai1UymbRYouSGd6SvOT+UqzhzOnyIOONG4ILkG
 QRcdLmVUm6MeRDFvByYp5Ew/CaoIVwTG2ziHKvPSVEcECyKyi0nwpOKUcQcIZPFU1jG0
 DUO3uPV/92V3eEuAg+gcolB8CEVOJVwQTNGETFKBTKLk82JSBFyHtFJSwwQWrXevuDPD
 e9jg==
X-Gm-Message-State: AOJu0YxZdK71F3N0nnV5It2sUc7QZ8XlmCcVXIRUFspggfqIUwRYi7dc
 fUil/G2IrI0aHx1pn1zmknCvHOS1G3GjWArtBmYyzNyol9WMw0T4lpzFva/S3cSI2hk=
X-Gm-Gg: ASbGnctpyVyiSBglFQ6uShyhyhjRVPA32qDt57c99B1uoMdPOLnfsR4dKIPqG6yAcwB
 0/z7cNtpHNnvN2SkgI6NjaOHcZpNCCqh2oLAz2AdMG26DAjmzqqedm8U5TLlaQ50j1m1rVqPL90
 ygG36RJQ4e9DZPz0x9ptYgPQL2WTeKfG4kf7rckDWf3qX1F8tZVQt5YEw0ow4QuGmVNlSTsJRCb
 0tcXV/+FUdTzrpCB+RtkkmULWwmo4SXADUuj6lH/MelLI5Izhx3J4IcPHRoxT/KtpQ1FAOe0tjN
 XTj1n4EMRsrpExH35dCVHVrPWsU3oLd0Fbu7OcwrSAPspJ3CP/6rSKxvxJ36lQUe8ZXrP/dIraT
 wXJPOeznO2Mc=
X-Google-Smtp-Source: AGHT+IG41p339VSfVoeorwfHR4vXRf00cTM9J2IRLNz5VlonWleQEGq62mdiL5b7qrgqWW+9y/SanA==
X-Received: by 2002:a05:6830:6f46:b0:735:27:34de with SMTP id
 46e09a7af769-73c92c47045mr1903523a34.6.1751558565500; 
 Thu, 03 Jul 2025 09:02:45 -0700 (PDT)
Received: from [10.25.6.71] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f73564bsm11802a34.5.2025.07.03.09.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:02:45 -0700 (PDT)
Message-ID: <82b08086-d26c-4e8f-9859-cc70280abc44@linaro.org>
Date: Thu, 3 Jul 2025 10:02:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 62/97] target/arm: Split out do_whilel from
 helper_sve_whilel
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-63-richard.henderson@linaro.org>
 <CAFEAcA8=25c3yADyE0nD7N6SmZnrTE+Km5YC9-pDZWKT962uNg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8=25c3yADyE0nD7N6SmZnrTE+Km5YC9-pDZWKT962uNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 7/3/25 04:38, Peter Maydell wrote:
> On Wed, 2 Jul 2025 at 13:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/sve_helper.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
>> index 5014fd135d..4497e9107b 100644
>> --- a/target/arm/tcg/sve_helper.c
>> +++ b/target/arm/tcg/sve_helper.c
>> @@ -4113,26 +4113,30 @@ static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
>>       return flags;
>>   }
>>
>> -uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
>> +static void do_whilel(uint64_t *d, uint64_t esz_mask,
>> +                      uint32_t count, uint32_t oprbits)
> 
> Does the compiler generate worse code if we give the right
> typed argument for d here (ArmPredicateReg *d) vs uint64_t * ?

It'll almost certainly be identical.

I believe my original split for this was written with the idea that I'd be expanding 
CounterToPredicate for LD1 et al exactly like the pseudocode does.  If I had done that, I 
would have needed to pass an array of uint64_t with 4x the elements in ARMPredicateReg. 
Thus uint64_t* instead of ARMPredicateReg*.

But in the end, decode_counter does not expand all of the predicate bits explicitly.


r~

