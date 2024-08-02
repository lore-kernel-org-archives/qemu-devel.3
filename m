Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA1C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnr6-0002ea-7W; Fri, 02 Aug 2024 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZnr4-0002WX-9A
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:41:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZnr2-0003NU-L4
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:41:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fdd6d81812so67429525ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722588099; x=1723192899;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W57WmDN0c2WGdtAZEgwsaMruOco2u8cBVnrabTw2Xco=;
 b=zE9TT4Y6pF1IYJ5ynY9OScAKcuW2IAUr10IDdc+TEjTFtWkwSIUZrue+/vcRX6UWoH
 gyQn7MiP4WWbLQABH2UlZHV8415OHP1dWAwWoI+5C7zDwcbSByiDRgUdtAbBJAF4s04V
 nhs6U07uGZVuw9BGucWyNOuLKiRrEl0cHpPwvtxwZnZNjRrVO99HxANCSBiDFLnUr2AB
 mpbfcgN6c9UdYis+cBA+e/n3iMMneS7+6OuiVpUD9apunKJOfJ5Md9r2eZg+Alc3CwLt
 JaVc34YXgD6un5tq6amYEKhqXEcuwV9gfaIbp8Jf6yT3a9a0PqbYUlis+heNAU1tlRso
 cnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722588099; x=1723192899;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W57WmDN0c2WGdtAZEgwsaMruOco2u8cBVnrabTw2Xco=;
 b=kiRqUPpDIh+9uAcPxRIWrKgADvcDZI26qv46Xzm5J5CUdFCSbzeHPekuiusGAqn4zQ
 EsxGTDFRKkapZeAy2TEjJwvLEHwEqqaKNQyTuQamPbEGEfABZaNV5vtm4rr2C5lvoqVH
 696ML+KSK7tyhE3SGpwMSyDC4hVKeswsl5tBfqBlxiYyFZ6qNnX/exkF8dGC2aeaRrDJ
 9dQITDOxkDIagfQgC44spSVhQb0chAddkWesOvZB/3/0VSlkVbkl6fd2IdiinJLSwATN
 SP/hJyXLsfMrHfpW93ZB/tciTA+MBpQ+iYcRXc8JF70sybkHxCiFQGHQmMwsmbkL0lXH
 /3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNewmvXDOq3/u7XOhDAS8mIt5unyG5FHJVch/3zvG3GRGK39c4udJGQoOeeAjlEwCvqXjbptMC96w0ENMhWezC8e3BM4c=
X-Gm-Message-State: AOJu0YxktEOgJ4Mh76WAW3udZj7RsQRDFq6QHQA9+p4VjD1WX4GkFfp3
 /hKIJbzsfxvLDGQ4c7EkIfKWaWXX6zQxVuq7cgdRzATq8zhn5jmyNMF+yRm9mpJIGAxq9FLDy27
 q6gs=
X-Google-Smtp-Source: AGHT+IHcX0vQjEObvkujZ7NTsbQXPSalYUxW5nB16nhPUhrB68qbYHaDvXNA4Lmg8OMamZixqcGEww==
X-Received: by 2002:a17:902:c943:b0:1fd:9e88:e4c3 with SMTP id
 d9443c01a7336-1ff572587afmr33770115ad.17.1722588099164; 
 Fri, 02 Aug 2024 01:41:39 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f6desm11788575ad.225.2024.08.02.01.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 01:41:38 -0700 (PDT)
Message-ID: <b8e653d6-986d-44c1-871d-6fbc9b369069@daynix.com>
Date: Fri, 2 Aug 2024 17:41:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/21] hvf: arm: Raise an exception for sysreg by default
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
 <20240730094020.2758637-6-peter.maydell@linaro.org>
 <f8ccb6da-e3d5-4717-8b7b-b20249cf5290@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f8ccb6da-e3d5-4717-8b7b-b20249cf5290@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/02 16:51, Richard Henderson wrote:
> On 7/30/24 19:40, Peter Maydell wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Any sysreg access results in an exception unless defined otherwise so
>> we should raise an exception by default.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 174 +++++++++++++++++++++----------------------
>>   1 file changed, 85 insertions(+), 89 deletions(-)
> 
> 
> This patch fails to compile:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7489527235
> 
> ../target/arm/hvf/hvf.c:1283:42: error: incompatible pointer types 
> passing 'uint64_t **' (aka 'unsigned long long **') to parameter of type 
> 'uint64_t *' (aka 'unsigned long long *'); remove & 
> [-Werror,-Wincompatible-pointer-types]
>          if (hvf_sysreg_read_cp(cpu, reg, &val)) {
>                                           ^~~~
> ../target/arm/hvf/hvf.c:1175:71: note: passing argument to parameter 
> 'val' here
> static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
>                                                                        ^
> 1 error generated.
> 
> This snuck in while our Cirrus build minutes were exhausted, but it 
> suggests that the patch was never tested at all.

I have just submitted a fix. I'm sorry for causing a mess.

This is a problem in my workflow. I wrote the code on Linux, tested and 
fixed it on macOS. However I forgot to synchronize the code between 
macOS and Linux before sending it on Linux.

Regards,
Akihiko Odaki

