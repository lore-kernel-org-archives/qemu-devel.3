Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B916BCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMGk-0004uW-MZ; Mon, 27 Oct 2025 08:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMGg-0004s9-0J
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:24:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMGa-0003pn-I3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:24:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475dd559a83so11151235e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761567838; x=1762172638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jaSHidttI0vHXv8RqYKLh9B/C3pMZ4HA5pGrJakqtFU=;
 b=cBqgGNROkZSaPh46jdcNc9udZjKM+gwFYG+vAWi0wt3ocMv6XnHeYHBTMcI6p25c5G
 jkaPVzClgCEdokwEI+9rYk4/vhKdWLmbenJYlNrE/qVQikQejgxj+xG+lG/OL5q6lt8G
 1yKeqifIjiyFjPcAoZReEV1ppGsEfi45P0hK6CCRPqnf1/kTJzpF1g6nAwaZsr1afkGD
 7CxUUiOxn6+P5UKTOL64HPF2vuUmLbYT9Y0BYrZHqh7vDQZsZCPOfEBhjw6jyuzMRBod
 x6bMwbm6XjqohQatoLvVxDkmnKym6kG2yYUxKnSNdzNeezb1jsVLNl1qhIr8ay9JQ8QS
 DkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761567838; x=1762172638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaSHidttI0vHXv8RqYKLh9B/C3pMZ4HA5pGrJakqtFU=;
 b=tt2u8ay0pMF4NGrZygPg8UHJT0OAIBWmFJr9OGwtAc91m7C86qIFz6sv+bKj+4Vt52
 IfwxRJ2zcv+mHvSv00+LxLEEDILQhh/ytJRVe/pPU1KBhT+6U/yePhLvgED/ju8A37oh
 daxJawAfgqtauG7PVwrjYwf5ixC/4+AiGko+XiO4UWUXydmwZBkkf4icgp18PftaGprq
 ulxAHz5CIQhJZ/JMyc/n1EB6xufYRK6R+MyT+m8bHj5Hsq8bgYnYo3uYsRzPoofy8rW1
 p3TYArPORjxeF/Y8GDgB8W9oR+RJ3UzV+pANsfhvTIQXz/ahruy3kyi1/TZKmxQcAO0M
 n7jQ==
X-Gm-Message-State: AOJu0Yza9ty8uRPZYNAZy7to64BIZodskIu7NuEcbqZSmPysX3HSAVS8
 MmulHvAFiTH639iT0GhVC90v6YrT5Xa2evCsn+xDUpVWZ4ixVYUE1+1ozkJZK7NzEwo=
X-Gm-Gg: ASbGncsJrv1j5FogSgqNm1P8QIDHw4dbksA6xF0fdSUonW073MYgxBJUocRC7nxlIV0
 J1sCaIxhxB25v3hG0j3cZgGKEEIOL8vG5DQU2ZnBUbZLSxXN9/Y+2I74OWNYV1JWCwEag2aLcLz
 J6K7Byg+pCa1/+wauQzWOaxF+bhTXm9uwg0tE9oynPJqRQ5poqRZZUTAiwWtMPDCTlXQheKUvrP
 J2V4oM4kH0fbgZ2S9eZrae7d/8afi5QmsSpdq/1wk6FN49osTAL2TOTJxFcWjeBpoD5MMwbTWDq
 EjEs6Mmj0PycK90TSZTL0I1Tp5+6LdW3Rem5i+m+pZQ9J7LsUhltxcGkpyoTAYCEHxFos+mKGT3
 C+vQNSRDp3y2OYyUXwX0fW3j7j6MOXYLqFZk4Y6yYLYlQFgch9Y9XE4Ns82uorULM5EfO69/zZg
 jtvB0VtNPLeJXzOFIPoWQEIxznBEj5YkAd1cake6W4YyQ1fJzzPQBmrg==
X-Google-Smtp-Source: AGHT+IFIdFjX0WJzlaqPZUIiiz7dam0X2s8zep/alMLo1JZLrnzTZomq36IM7Q8isx6gDKV+DHCgiw==
X-Received: by 2002:a05:600c:4f89:b0:477:c71:1fd3 with SMTP id
 5b1f17b1804b1-4770c71219fmr48851915e9.28.1761567838544; 
 Mon, 27 Oct 2025 05:23:58 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd16dda5sm64566485e9.6.2025.10.27.05.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:23:57 -0700 (PDT)
Message-ID: <9d287284-1cb2-4126-b7d7-9c57b32ce408@linaro.org>
Date: Mon, 27 Oct 2025 13:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] hw/sd/sdcard: Allow user-instantiated eMMC
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <90fc6201696fcf0e5fd0493365bc32b217aa9d6e.1760702638.git.jan.kiszka@siemens.com>
 <aP9dvF1unTtLrSdQ@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aP9dvF1unTtLrSdQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/10/25 12:55, Daniel P. Berrangé wrote:
> On Fri, Oct 17, 2025 at 02:03:54PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Enable user-instantiation so that PCI-attached eMMCs can be created for
>> virt machines, for QA purposes for the eMMC model itself and for complex
>> firmware/OS integrations using the upcoming RPMB partition support.
> 
> IIUC, the 'emmc' device wants an 'sd-bus' but this commit talks about
> it being PCI-attached ?

Sigh, it should not, but it got introduced this way and we didn't
have time / energy / good reason to rework the code, which currently
just works.

SD / MMC cards -> plugged over external SD bus

embedded MMC cards -> no SD bus, directly mmio-mapped.

> 
> Can you elaborate on / illustrate the usage example for an end user ?

Saving time by testing virtual hardware, without having to implement a
real model.

Personally I'm not in favor of modelling unspecified devices (IOW not
following a spec). But I can understand QEMU usefulness with fast
HW prototyping.

> 
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   hw/sd/sd.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index d1e1bb4f0e..305ea251cb 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2928,8 +2928,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
>>       dc->desc = "eMMC";
>>       dc->realize = emmc_realize;
>>       device_class_set_props(dc, emmc_properties);
>> -    /* Reason: Soldered on board */
>> -    dc->user_creatable = false;
>>   
>>       sc->proto = &sd_proto_emmc;
>>   
>> -- 
>> 2.51.0
>>
>>
> 
> With regards,
> Daniel

