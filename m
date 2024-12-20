Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A18E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkZL-0003jf-F6; Fri, 20 Dec 2024 16:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkZJ-0003jP-Vd
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:29:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkZI-0006lZ-8K
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:29:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so16357985e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730194; x=1735334994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a816XY1aQnnjdwclZoRGm4db833zAcoCR2MTrlmwlmo=;
 b=KoqSDlB/lsQULqnxtvNYztHMA3G/kFTcvYgo7+2XwQ9tZPLEhiAu3sOv/r2diVjMPx
 8GGRZycWzs6+qAMca/j+IY29s07iH63jWzGSWILkVSaJ64X/lEvehJc6y4kvsRg7F7X/
 M2FFB8Jo8ZDGfg1w/LnaLxE7ANuvQNqQ7okmDlJdHqA+HfVCAS8D7zfhmDWEFgIeBhOg
 7zsg95yxSLxsV8tRjfuwYYbbe2afFzzjhQlqFT2GMRhthkpWcs4FU9hWryhkrK1l7kz3
 eJvPfVrIsWhs9FGN5tTyZile8f36C9W6IuPjCfJce2DNFhi8fCn0mQ/oIQ1NnFEM26jg
 kC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730194; x=1735334994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a816XY1aQnnjdwclZoRGm4db833zAcoCR2MTrlmwlmo=;
 b=n+mMZZskr26Xgqvws6zUAffGQAp7tn5M/lHiWNCUvC5HsQEzMQls5e1oahNt77+McU
 QIZ5EiKdARzHr4vW8352zJnqoqznRToCgPDbjBnGqOLclxy/sTVJ3UPS5wdfqRZZFIxf
 rC2UYoEP0sie2vTDX5GTfFT9juWnDnN6RGCJ9itmKOVMd9FyGk1klVuYRo1yXmxAaS8T
 9uJzIel0ylg9/juX0JIhWoQS5BkKxVSP2bqDNsXVHCS6a0N0o9FyjVdJ5VZqnrNR9K4l
 hEJ72TsNnsULhefaWwpf21+yQ0cMH8y2jhEsLG5Ws3laVGesTd2/nlbT1dBd0A0CQDEb
 X+kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRn5zKj7pRaC5aWpPb404qJ9Wn2NcE9H0crL06P8GeSILD9HzLbLkx98PMG0tZKb7CeLV3ZBOmKk7w@nongnu.org
X-Gm-Message-State: AOJu0YxLVaffhA9LtEF7YyMqdqsPGZaub5V2OheDEme6lWas29TDRoqP
 mxf4Ex6E9NKqQWxhjwrIa6rAm0m+Qq71d3OjLVCirhBgriLY2HYpPsPp3j6e1xQ=
X-Gm-Gg: ASbGncs27IqBJQXc7rJUTNGAbgItX5rIORTznzR7u7KJe5GZIXtZipNoVjLzO7ui8Bh
 5jPNvjn+jxJ4nrNnuC7xUixIn7P98J3hYorZK3Pr1E9JpofEQuDu+EiJjRm7xCkRKrtpZR2ba4k
 eNoR4tAasoXdnq+enWGkP82xIANEQXLsHpzU3m/JDgZJ0Nqvqu/beOJhdGxSl3OE/iNQyU3bzvM
 BNyi4DQGMEmCxcphHr+FERLEoGHAKy/RQB2dfAvPfC90vP2OztuIGlamd+/y9YCcA==
X-Google-Smtp-Source: AGHT+IELbH1rpIrpfIZXcYWMAT1Z4Xyh1HNmtNBGo3N3VuT+NX+mWB5f+k44E56WnAqIdLtCYFPrcw==
X-Received: by 2002:a5d:47cf:0:b0:385:ee59:44eb with SMTP id
 ffacd0b85a97d-38a221fa9ffmr4683026f8f.33.1734730194555; 
 Fri, 20 Dec 2024 13:29:54 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366e210cecsm20081175e9.2.2024.12.20.13.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 13:29:54 -0800 (PST)
Message-ID: <dcb0e8da-5a97-4929-a80c-49341c05fe42@linaro.org>
Date: Fri, 20 Dec 2024 22:29:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/ppc/spapr: Convert HPTE() macro as hpte_get()
 method
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-3-philmd@linaro.org>
 <0c036e5c-beed-429b-aea1-628fa9d52b65@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c036e5c-beed-429b-aea1-628fa9d52b65@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 19/12/24 07:31, Harsh Prateek Bora wrote:
> Hi Philippe,
> 
> On 12/18/24 23:51, Philippe Mathieu-Daudé wrote:
>> Convert HPTE() macro as hpte_get() method.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3b022e8da9e..4845bf3244b 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1399,7 +1399,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor 
>> *vhyp, PowerPCCPU *cpu,
>>       }
>>   }
>> -#define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
>> +static uint64_t *hpte_get(SpaprMachineState *s, unsigned index)
>> +{
>> +    uint64_t *table = s->htab;
>> +
>> +    return &table[2 * index];
>> +}
>> +
>>   #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & 
>> HPTE64_V_VALID)
>>   #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & 
>> HPTE64_V_HPTE_DIRTY)
>>   #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= 
>> tswap64(~HPTE64_V_HPTE_DIRTY))
>> @@ -1614,7 +1620,7 @@ int spapr_reallocate_hpt(SpaprMachineState 
>> *spapr, int shift, Error **errp)
>>           spapr->htab_shift = shift;
>>           for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
>> -            DIRTY_HPTE(HPTE(spapr->htab, i));
>> +            DIRTY_HPTE(hpte_get(spapr->htab, i));
> 
> Prev HPTE expected _table i.e. spapr->htab as arg, but this new hpte_get
> expects SpaprMachineState* i.e. spapr as arg. Shouldn't the arg be
> updated accordingly?

Good catch!

> Wondering it didnt complain during build.

Because the macros blindly cast, dropping the type checks.

> 
> As Nick suggested, hpte_get_ptr or get_hpte_ptr may be better renaming.

Sure. Thanks!

> 
> regards,
> Harsh


