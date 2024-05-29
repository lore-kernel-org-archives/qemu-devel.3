Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB798C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 04:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBIh-000231-58; Wed, 29 May 2024 00:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBIb-0001wj-Sp
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:52:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBIZ-0001ed-Kr
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:52:29 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5238b5c07efso1838484e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 21:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716958344; x=1717563144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ttD9JcPHEi0saWEidrIvE6SiGSP0+pQ/uWKx0BiEiXY=;
 b=d3efm5exuPi7/t0aHz0ul9CqArXUO7OPkGcayFXyTS0y1hzjZAVtp8oVLXpTmF5BA0
 yV9JakAnH2/oYtN1IhwUmvJ0rU6Ra8DfRGQwXimfoOqDtzZODzA755lHg7LgICCy73JJ
 t0UjjMKVRUxr/Dj4ir1rD8QDniGUOvqZy8S0gcFMINLZSDJI+R5B2mUzIALcAMOOnExe
 E8oHXGYpnS/e3sygY1dGYUoTpzMxsYWdJvDiUe1MH9P+UJXIC0GfPDcvjSb010wAknqa
 dcEHpgX2Z0uDLzb3jCBb4XXgSll1BqX/8J3vMpna1v00JkSDyNHPmpHMsQdnyjLgZJg4
 2Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716958344; x=1717563144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ttD9JcPHEi0saWEidrIvE6SiGSP0+pQ/uWKx0BiEiXY=;
 b=tFlwLMU+/8fPWYHSsxh3mUi9lOorQXdjZVmQruQrBqrki5Qn9KIfhdcQinmXKYKdX3
 17y9U5xN6Up81aDtC82mMEZr/AIrU77uFuk5pmbC1Zs1pG2y2Q4Xvzl0C1hhaqyhjgMl
 Gr2HiYgD1c7eXtCiHPBdSDKyQVvxwREJndIUtWWP8LEqFSCKzOixtT9fFQeASKvNrqdG
 xj+hgCLP9O7XKP8W+k0KSCHL065W88ESdIX323uliXYIUMVqZeLPmk4xQ4bVJ8VPE2dA
 pJBhOgwHw7IRZvyrDEyFksWL9nffkpsxzj7Wlf/dvMPLJEApaRDM2+nN7WASlBFZV6hp
 RjjQ==
X-Gm-Message-State: AOJu0YyXFAZGauuzDGfyST7Kz8siRFf3JLDW5m0e+IfI7JFQkK8Tn3G6
 WUZCglK35VMIjr/vJTf0EL4jhA1S5AB/E2EbwgR3K7Zd2pkqZOz+nLPu2IG3sDM=
X-Google-Smtp-Source: AGHT+IFL1lqRpJDtYeh9SPV6OdldksILmgvc8Femh3uqPBCCsV8ouo3X3Vh9dmt6loRfXCO7nm2xJQ==
X-Received: by 2002:a19:7406:0:b0:523:90df:a9ce with SMTP id
 2adb3069b0e04-529667cfa1amr7917970e87.49.1716958344329; 
 Tue, 28 May 2024 21:52:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bb5ddsm7880225a12.93.2024.05.28.21.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 21:52:23 -0700 (PDT)
Message-ID: <7d746f7d-60b3-4513-bd95-5bec7e799b67@linaro.org>
Date: Wed, 29 May 2024 06:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240508143513.44996-1-philmd@linaro.org>
 <CAFEAcA-apsUZeNdpC9QfJm+Xqr8Z-LhfZXiv6YxcSXo2bKsocQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-apsUZeNdpC9QfJm+Xqr8Z-LhfZXiv6YxcSXo2bKsocQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/5/24 14:49, Peter Maydell wrote:
> On Wed, 8 May 2024 at 15:35, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Check the function index is in range and use an unsigned
>> variable to avoid the following warning with GCC 13.2.0:
>>
>>    [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
>>    hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
>>    hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-Wchar-subscripts]
>>      416 |     s->dav |= mode_regs[s->function];
>>          |                         ~^~~~~~~~~~
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v2: Use Peter suggestion
>> ---
>>   hw/input/tsc2005.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
>> index 941f163d36..8d35892c09 100644
>> --- a/hw/input/tsc2005.c
>> +++ b/hw/input/tsc2005.c
>> @@ -406,6 +406,9 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len)
>>   static void tsc2005_timer_tick(void *opaque)
>>   {
>>       TSC2005State *s = opaque;
>> +    unsigned int function = s->function;
>> +
>> +    assert(function < ARRAY_SIZE(mode_regs);
> 
> Missing ')' -- this doesn't compile ;-)

Oops I apologize for not even build-testing :/

> Applied to target-arm.next with the typo fixed, thanks.

Thanks!


