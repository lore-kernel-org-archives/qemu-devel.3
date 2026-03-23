Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4458DF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4g0U-0007Tb-R0; Mon, 23 Mar 2026 10:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4g0S-0007T5-Gr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:11:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4g0Q-0000MR-St
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:11:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so23300685e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774275097; x=1774879897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUcC3J3ZOs1pt5gkvbq2vlc7ZX3oEjQOG2uhCYRzSWA=;
 b=uw8CXk8AHheib6TQLf0mro2eMYlMsnf7dWNOM5/gSxmH2nF8Q4Z5ZZqnnNtnKvvx0I
 C2f/ArHbJAPGOdZP+zA3jqlUbZR6eoHbz8yVdYpCwDyYUr7S5tUSHXYZoXnSx4xbWTTb
 YgXNCyUWIt4T5Qk6YXc3YnfX1IyGabQM0syU4QueQSXMBKjWBTMUww3iTqr5TUipYXzg
 k4ypo2BGEJDMCesujMj0hYOl9uyd4upb187Wse8jjRC0e9vMyMkyB5xGbqXkErbJaUpo
 fEgJPEu0KVjWyJgvcEO5G/ywxa96z53aT+BXGqy8/kEDoLEgKr/kRBUHhZq/CraKr0mF
 RDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774275097; x=1774879897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUcC3J3ZOs1pt5gkvbq2vlc7ZX3oEjQOG2uhCYRzSWA=;
 b=qFxNtPy6Te1e1ERFPf5yl/t6pyC0QbCamvNUnzAT9qLArSz/CaqtUcdst8We24yLqo
 B31JXy7xOtphpLzMcRZG3mN8AMwaj7X7G3LI/H6OxlzN6Stj15mYH012lUdm79NL+aus
 FcWCP4Oun4tYSh8QtUuP83LMZn5AoQjmiZCIYD/ph6EVcaPMEeLDRHww83j04i2s/lMG
 4rbmbesk2GW+O8fIN4j9pbbu/8SjbD1m3qiL8Fkx3Kvg6vIyQE9pgFoPhJjfqUf6v0VV
 QODAy/ZK80KJEHNLN9y5dKzt2EVlE1EdzEGw8+bRJp/bgji1lYBUxMxm2Sxlpn19UbPU
 ONNg==
X-Gm-Message-State: AOJu0Yx66otULswfVshNiJrr0wE1EbWPoguxGIb8TplzsZQA5M5AxTBP
 JDavibm6W1h0/2dVN/m8Cszlv2QClLEpZb1H58E3t7g+CrYQxkw3cr7nlloVnyuZOwM=
X-Gm-Gg: ATEYQzyYSBQOCy+2Io6KIiDmXQf2cSB5UiqZRuqbiXBxgiikgj6fGgxNGlURQYR6BnO
 DBHUf4k7Rw/KWcfT5Jt9dFeFSDpkmfC0qFxYZ0ZE/C3msSs1Oq35q6Tn7p4p3wvEiNhEwW2yUEH
 XHujvYciwi5RYsQbldx2XVEWuLgVIh47j6UemjfCo7vJXVyE8na1cfpKD2xyDpfageqagbovgyK
 KxJvDbrT5DSvVZAdy0CM2Pk2NGMkWceGJ+uLE1DiKErESkG/xIamj9olQ1avQ5+3CpQ6fvQRM6t
 M3qGp6d+dsYRQ13f6baahH9XmzkYVbCSZyUO+wdEEqq6hLXeNs1qccgXc3BbUJ35rU6fBBV7gEP
 zxJPq1I1h2HJLWhuXFvw7+wUH6Q4ao9q9CPtXpBzjc1hctOkq8pGlj2a5+iPd0jxkXxlarW0e8n
 1npMBxreYyHRU8rERD3g0fsdHnIIHPAFGvT89zeM8LiElK1mGk1TVOV8ISY4tJBaMymA==
X-Received: by 2002:a05:600c:1d15:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-486fedf9061mr174511365e9.10.1774275096888; 
 Mon, 23 Mar 2026 07:11:36 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe89b781sm80923415e9.12.2026.03.23.07.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 07:11:36 -0700 (PDT)
Message-ID: <ebb58786-57c2-458f-b4bd-4a1520fdb9f4@linaro.org>
Date: Mon, 23 Mar 2026 15:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/hyperv: add QEMU_PACKED to uapi structs
To: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Anirudh Rayabharam <anirudh@anirudhrb.com>,
 Wei Liu <wei.liu@kernel.org>, Aastha Rawat <aastharawat@linux.microsoft.com>
References: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
 <CAFEAcA-EfRkCXWu061c1uZsW4BC4qKut_uju6U4NyiNuYbf5EQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-EfRkCXWu061c1uZsW4BC4qKut_uju6U4NyiNuYbf5EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 23/3/26 13:39, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 12:06, Magnus Kulke
> <magnuskulke@linux.microsoft.com> wrote:
>>
>> The uapi definitions are marked with __packed hints in the kernel
>> headers, since we want to keep the contract of the Microsoft Hypervisor
>> ABI explicit, we should also added them in our vendored files, with a
>> few notable exceptions where the attribute is a noop.
>>
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> ---
>>   include/hw/hyperv/hvgdk_mini.h | 37 ++++++++++++++++++++++------------
>>   include/hw/hyperv/hvhdk.h      | 14 +++++++------
>>   2 files changed, 32 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
>> index cb52cc9de2..7d7b2e9b36 100644
>> --- a/include/hw/hyperv/hvgdk_mini.h
>> +++ b/include/hw/hyperv/hvgdk_mini.h
>> @@ -7,6 +7,8 @@
>>   #ifndef HW_HYPERV_HVGDK_MINI_H
>>   #define HW_HYPERV_HVGDK_MINI_H
>>
>> +#include "qemu/compiler.h"
> 
> osdep.h includes compiler.h, so it is always present for all C
> files; you don't need to explicitly include it.

Taken care of while queuing, thanks.

