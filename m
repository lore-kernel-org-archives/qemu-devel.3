Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BD8CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnUo-0002LC-8O; Sun, 31 May 2026 17:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUm-0002Ko-V5
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnUl-00054S-Db
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:14:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490a762db7aso4487685e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262094; x=1780866894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqTXH1ay+tXsfAhmUW46JipuJudzLkGyr855uaDFxVY=;
 b=y9qQPV+P4YkUjwSDcTN3Zm3le3xCXlQTjxDQO8IfGtJ1L4C1ybQDLWiv5r/aW4ztJU
 ORO21MPp8uV6nI3RRVlGgRiNQoPyi4x3eeGt19JHxD8JE+tSZ2EaZ/xJuSqQGvoXZZw6
 yKXq/DBlGbpnFoInh27hluNat4zFfiueKIU738B6WSNtjm2WmmDv8NTmDFC5S8YGwH8I
 QM2YiHydVF78kxvnWBF/d4Fg87hOBOWCpWTZlghR9jQWERfugvBT/33uKnwZaw+QKZvc
 wnlRW4vMT2t5l7JDsx9rjjzx64evGmsL8ow0taKqoa3nNM9S05TV7+azBxtYJPqw62DT
 lZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262094; x=1780866894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqTXH1ay+tXsfAhmUW46JipuJudzLkGyr855uaDFxVY=;
 b=PJ2DwIeUhq3lcCmXuPbZEe5/wlux3LdSp8cb9uO87HH/Hd2eh+4gHnDzDtEqWgjNVP
 FIgJH8gJsNyczJdv0rlyVyhAAMYhAQPumKtI4mHn4F57XtP/DeVvXYaFNoY6FiM9uEpf
 M+WFhKD9CrhAcZiyNjxHxWGu2Umzgfdrxakblev+I1V9WI0kdzjFlY0ioAkPuA/HBFgP
 cmsE73dtqx2h9FBBfecQZJsjk2yD0LPGRsmGir11gYtSkpj+fg7njqqEt67lWo58pAm2
 hg/o9Nhc02Grqn7JfgzMWdCS59eOc4SwUqaGqjr5tuD6zgiVj3nWSQ13GZqmwGFjS+6n
 8eBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KEFsdA8xHo0zIYsc9y+JDM3XMm9lXztW2OdENAMJjH0Zs8FtWEOpCY202THOFIFVKx83JzKz4+7/+@nongnu.org
X-Gm-Message-State: AOJu0Yzn7F398B53dNkld4hYHm3qBphtof14BE/6A7QQDMuC2n/9Ojs2
 v2gfxyUwN/UB1iV+fwtJxYlQ3nP46GV3pYnVHzPlnBPSlOGFeXFUJFLdcXggRwz8yANegKjQ6Y7
 uXUvN3fcLDw==
X-Gm-Gg: Acq92OG/kVV2BIrBKgT5ZnWaMLFhLF5AQx+mgwQGzwAKC1NkzYE/RWeFoEEzQy/pvGO
 xJj9w/sE/h8rMaXPt1yDugjCb784FDpSNR+popfUF5lcsZu91beGBinSn4D31neo48hVKhhKn/O
 v6RQ2r4qlG0r4ASQpHw9pPxPi50mxNBDF2CNrPR79c0Ed6fUACkk6U5IUDxPF3htEEadnVM4fjt
 2nM7830NWWwz6YQ7fst1VApkAQt3jp/D+ZY1mcB5CIuna3AjcrX0LpUYcGrNrjxnB3xK3nmZJME
 A2PFwqfDPfygPkqm5kBv8/BboQyrBy4uiptN1o5kD6OMaCxfQZanYDgOuYYN8GuPVYU+amjGOFo
 hlY0LX9aT9H/vYBX/vFwR0wcNTaNXc1nm65ad3Rzg82yBKpWGHdsWqNo0sbStJk+UxKU9PfSw1V
 NgooFhLA12a47WFvQPxB0B4uaLnSP7UFimNORbJCwUQ0hNkwDTFyka4ZtpSPOKBnws5ejJ9EU+a
 aPW
X-Received: by 2002:a05:600c:1988:b0:490:9d1b:201f with SMTP id
 5b1f17b1804b1-490a294d4b0mr143131435e9.32.1780262093761; 
 Sun, 31 May 2026 14:14:53 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0f74fasm87954635e9.4.2026.05.31.14.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:14:52 -0700 (PDT)
Message-ID: <e287f18b-757d-4fbf-a680-7d66f962eb11@linaro.org>
Date: Sun, 25 May 2025 18:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] semihosting/uaccess: Compile once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
 <20250502220524.81548-3-philmd@linaro.org>
 <5ebb1a1c-efdd-4dcd-8027-aa3dc031b755@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5ebb1a1c-efdd-4dcd-8027-aa3dc031b755@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/5/25 22:04, Pierrick Bouvier wrote:
> On 5/2/25 3:05 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   semihosting/meson.build | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/semihosting/meson.build b/semihosting/meson.build
>> index f3d38dda91d..a0a1c081f43 100644
>> --- a/semihosting/meson.build
>> +++ b/semihosting/meson.build
>> @@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: 
>> files(
>>     'syscalls.c',
>>   ))
>> -specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], 
>> if_true: files(
>> -  'uaccess.c',
>> -))
>> +libsystem_ss.add(files('uaccess.c'))
>>   common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs- 
>> all.c'))
>>   user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
> 
> Fails to build with:
> ./configure --disable-tcg && ninja -C build
> FAILED: libsystem.a.p/semihosting_uaccess.c.o
> ../semihosting/uaccess.c
> ../semihosting/uaccess.c: In function ‘uaccess_strlen_user’:
> ../semihosting/uaccess.c:43:17: error: implicit declaration of function 
> ‘probe_access_flags’ [-Wimplicit-function-declaration]
>      43 |         flags = probe_access_flags(env, addr, 0, MMU_DATA_LOAD,
>         |                 ^~~~~~~~~~~~~~~~~~
> ../semihosting/uaccess.c:43:17: error: nested extern declaration of 
> ‘probe_access_flags’ [-Werror=nested-externs]
> 
> CONFIG_SEMIHOSTING conditional must be kept.
> -libsystem_ss.add(files('uaccess.c'))
> +libsystem_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('uaccess.c'))

This produces:

../../meson.build:4119:28: ERROR: Entry CONFIG_SEMIHOSTING not in 
configuration dictionary.


