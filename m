Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18079FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGuc-0006pk-8F; Mon, 27 Apr 2026 04:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHGuL-0006kg-69
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:01:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHGuE-0007OT-NV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:01:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so49102625e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276885; x=1777881685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OOZp+qVST+oddpKdNGd/iFhxZ6N6EqOJ9KnRdSfWROY=;
 b=r1KzWVSft/taDbM81D6yy1vflT5rpLF/z1SqRUJ9JlYKXoY1o4YFJ9ufCXLkf9Jmjm
 qpq2cIXgSZqqiHjLVlqtOJAM61VGzmuEOV0+3/qKpdmQ2ZOaAOiRdIU9fga0xXruHoWZ
 CyLRKKltdJZMvw7bxb0bmOHQS280Yidd3QpHV/Dm+ZGebuaYhMX+8HvMmWelBY8tihMU
 OpGjhe1tmS7FeiMW+vatr6s3jujAziY1/TFPGhwqxqYLWZa3lv0Lavhxu9l2C++Z5ZtN
 BCaU1+u+q5nw+cTWh0E0OKwSvfwJ9EqG0fnfSnAOU+Z+5fRpGBakIZkWqffMTOxVTu4Y
 H8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276885; x=1777881685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOZp+qVST+oddpKdNGd/iFhxZ6N6EqOJ9KnRdSfWROY=;
 b=lV7tDZdZ4BDoCyHGmDYiL0W5HVytBWeWX4lm1YQNtWv0XAKpsF4YYIj+M7TcJLQlEU
 om6PPSGO+S0nKLHZo5EEx6iVkMwzfhiA4VQwcfb0unGTlCahCLXoC97c8AxstHVM5Ma3
 L/ZZSuRsuhnebcXaJn9LvFDoC8C53tkh/ruNNxz6vWaoD5L8sXzmSG4BHP7R1zJVFcIl
 unNEkXJ0Z4pHz/tQZrMPWkSC9XR0NRIgvK4FmXSnsnuyHL3miph6/wGbLQsaXV+ATdzd
 YEpdBHu910qN5yC6Bv+GqJg7HkslKRYHABxEjdiqF++9AakcdpMo5keduIrRzrhmlfH/
 hurg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+slppF7ELzp4E2S3VEt69tmRZwwTQ+8DVfT4YnpfoCLnobCP3fqI5p9lRnNmqyGlgaRkMNUOz5Jp4A@nongnu.org
X-Gm-Message-State: AOJu0Yx5uf+QrWWUbvjw11ZVzPWzQWyXBlqf8iOX3VQjyneFP4zXym6h
 ixKMwROM7taempFXZDf5NXuC+myB8p8L+NaETLmZDXelbp42K3sKWAl+bvNsP0HNA+I=
X-Gm-Gg: AeBDiesiMtFBfRO08fMUu1YsZJ87SvyC65ODqOs+Lod/Ekp/5aIWo2lmZEZsy0vRDt0
 aTkIT3pVqzWWS0e2AUkNqvpJZhArThPUW/hpDjO6d8ZC5dp+Ca3Xxe9+2kCI+hNKGxD8pG5erSQ
 Sf5oupsbueRVEilSD49AuG9DO+2ql9Cpg4+Gpiq0uRFtnXLCtz61B08t3ULEy9fUr/foha1qyRG
 9WcrHfcia8Hdc0tMmOKxqHbZpkPDHLaiTaDm+vx2mEfWGusIsOgDhLAjTwfOVgNlC8XGROwF3kp
 Lzz849lAx7HvCofFOEf/9VIJrNUov5Sf7WhtZN+co96/x2PhCzs4AfmaZR3RWSUaZq5PTwS/8X8
 oENEMJ1vZv/kduEITT9vXuCG0OJqS9d4b5X0fu6m85Q2dVHQ6l7xOQXBFVOwCNdRAsFrvi7zdtz
 /Q3J12ePFF0YxabWaMW9gk4LP5Tosl6w6f5zOCvxpJyuRs+NtqPOMXYimzxt8MLNsMQdjgD3ORM
 xxVMbQqQL/c4T0=
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48a07615b87mr394245625e9.8.1777276884805; 
 Mon, 27 Apr 2026 01:01:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm327339275e9.0.2026.04.27.01.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:01:24 -0700 (PDT)
Message-ID: <2ad1fdab-8531-4dad-8cd4-d2b1f04b183c@linaro.org>
Date: Mon, 27 Apr 2026 10:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 2/6] monitor: Remove MonitorDef::type field
 and MD_TLONG / MD_I32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-3-philmd@linaro.org>
 <a700c7c2-9d70-4237-9ddd-dc09b75dbc1c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a700c7c2-9d70-4237-9ddd-dc09b75dbc1c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 29/3/26 23:30, Richard Henderson wrote:
> On 3/20/26 19:10, Philippe Mathieu-Daudé wrote:
>> None of the few targets still using MonitorDef use MD_TLONG,
>> they either use MD_I32 or the %get_value handler. Remove the
>> MonitorDef::type and its definitions altogether: simply check
>> for the %get_value handler, if NULL then consider 32-bit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/monitor/hmp-target.h |  4 ----
>>   monitor/hmp-target.c         | 12 +-----------
>>   target/i386/monitor.c        |  2 +-
>>   target/m68k/monitor.c        | 24 ++++++++++++------------
>>   target/sparc/monitor.c       | 14 +++++++-------
>>   5 files changed, 21 insertions(+), 35 deletions(-)


>> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
>> index e9300ded4ad..a60671a60a4 100644
>> --- a/target/sparc/monitor.c
>> +++ b/target/sparc/monitor.c
>> @@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>>   const MonitorDef monitor_defs[] = {
>>   #ifdef TARGET_SPARC64
>> -    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
>> -    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
>> -    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
>> -    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
>> -    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
>> -    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
>> -    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
>> +    { "asi", offsetof(CPUSPARCState, asi) },
>> +    { "pstate", offsetof(CPUSPARCState, pstate) },
>> +    { "cansave", offsetof(CPUSPARCState, cansave) },
>> +    { "canrestore", offsetof(CPUSPARCState, canrestore) },
>> +    { "otherwin", offsetof(CPUSPARCState, otherwin) },
>> +    { "wstate", offsetof(CPUSPARCState, wstate) },
>> +    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
>>   #endif
>>       { NULL },
>>   };
> 
> Doesn't this completely revert patch 1?

Indeed. While being a revert, the previous patch makes this
removal trivial (no need to justify the 64-bit path).


