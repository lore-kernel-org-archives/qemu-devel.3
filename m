Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5062E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 18:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVElN-00075a-75; Tue, 07 Jan 2025 13:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVElJ-000753-31
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:57:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVElH-0004Gx-FT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:57:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso106436705e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736276225; x=1736881025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3darVpZrv40gfMs7JtLycBDIF+yCQhL7QwhFFYlrrw=;
 b=ca7e4KqArN/mM57FeGIq3v2BXbAdMRQcrZ51YJ0waaDTr2cixTgebCYcHcUUfPLwQi
 PO7/nFSi3Z45x0iQcpTpjkkrieaoxjGcMmKdjdJqtZ0P65W9X86+zbleJqGZn6ElSnyN
 eaWsR7Bwt9Vqa59dfBVlehCAkdfQeqZ4GTyelo0pQvLZh/LR/EtrRLi96TXIsJVF/F33
 uuc6dnMzaqQocJea6bWOhNmKEvpOUvflvlIlWZWocfMsUJyjpPfZwSGzXrD2696fBoQS
 Ooxa27u1U6KMLzUI0kDA0vge3QzB8WR+az5eCOofr9CvwJaxnV/31+avY609UuO74nK3
 D7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736276225; x=1736881025;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c3darVpZrv40gfMs7JtLycBDIF+yCQhL7QwhFFYlrrw=;
 b=o/7UeF13bHnqHt0UDVQ582d80El2ZYBCaQVbxrQw19/EKbgmPdgkwiSfVCPEj4YaM+
 sE4um201Z0koc6q11+t8ZjYP6uVJ+t2bgIl0nKwcInEmw1gBVPSm0ScG30WdLNoqO6+O
 DrONCH9xK9T39JK+EdzwqrTnlFPH3WnEvf1Kwov9nUQTswQWpluLch8ESTSyv8WDUDsQ
 yOz7tI9X93uTvVPWekXjd0slZpA5989ecnMUEWsa+vT/1kVkdZ5N6jvZrPJ6dD2erp2P
 FHKLTjDFWzz7m7haFCLM7GPrU6UNkKfS/vytUOc7DnCRQLc813oQP/pdkPxvfUI/qvg9
 n/bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbqsl2W32ctv5we3b3hmo9DFJzkLxYRshJF8zDpjTYqYYHDm2R/Al2QpbjchSpv4/qSchbissTqGgY@nongnu.org
X-Gm-Message-State: AOJu0Yxpt8VKkMJ2T5kTlE4FpsRrAAvjM9xuTHYAH2+LAie6wPEua1/f
 X1kuIxdkN9CjCknUsj1/ut9HCJfI6/f3Co+M/l9ZprCSzT2g4kIRgasYHbzzHIE=
X-Gm-Gg: ASbGncuOh469dkX4bi+adgrN5iAInds2MgziFhbo7uiCb8/WbZaROj0IZjtAlW3Z2NP
 qWdspS35jo5Saxy6Gi9Vn0K1VcB2n1mvyqPJ1S68ejwpoXcHe8EWsq66hv4X62ZFq2FShOj+SiU
 G7+5o+NlCNg/Uc/egtTThmWcDrty4XBYWaJdb6rGtHpqq7ZaL63cvD38W5BSAxmTJQm9HOgTOvz
 M+puzgemoj32YTH8u10EwD0Vv6YhN/fFccEsHM0TEOFrnKGsjaj8N1iXA1u4Du7zHvB9+hKDRTu
 xsvs+tCP8RCyOnbjJj8pSuz9
X-Google-Smtp-Source: AGHT+IE+xFX0awFyDNf7ue4odLMiLyG5RNcDktK8Off4n0U35vuGUlXBUMwfnrUkHSUOGt/fSr0dWg==
X-Received: by 2002:a05:600c:3b24:b0:436:2923:d23a with SMTP id
 5b1f17b1804b1-43668b7a683mr430353145e9.33.1736276225648; 
 Tue, 07 Jan 2025 10:57:05 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm602097695e9.26.2025.01.07.10.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 10:57:05 -0800 (PST)
Message-ID: <d1674d1e-e6ac-441f-acbd-ad3a2dcd15aa@linaro.org>
Date: Tue, 7 Jan 2025 19:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] tests/qtest: Add API functions to capture IRQ
 toggling
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 armbru@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
 <20241216141818.111255-7-gustavo.romero@linaro.org>
 <77ee967d-00e6-45fa-a8b1-42192e61b553@linaro.org>
Content-Language: en-US
In-Reply-To: <77ee967d-00e6-45fa-a8b1-42192e61b553@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/1/25 19:35, Philippe Mathieu-Daudé wrote:
> Cc'ing maintainers:
> 
> $ ./scripts/get_maintainer.pl -f tests/qtest/libqtest.c
> Fabiano Rosas <farosas@suse.de> (maintainer:qtest)
> Laurent Vivier <lvivier@redhat.com> (maintainer:qtest)
> Paolo Bonzini <pbonzini@redhat.com> (reviewer:qtest)
> 
> On 16/12/24 15:18, Gustavo Romero wrote:
>> Currently, the QTest API does not provide a function to capture when an
>> IRQ line is raised or lowered, although the QTest Protocol already
>> reports such IRQ transitions. As a consequence, it is also not possible
>> to capture when an IRQ line is toggled. Functions like qtest_get_irq()
>> only read the current state of the intercepted IRQ lines, which is
>> already high (or low) when the function is called if the IRQ line is
>> toggled. Therefore, these functions miss the IRQ line state transitions.
>>
>> This commit introduces two new API functions:
>> qtest_get_irq_raised_counter() and qtest_get_irq_lowered_counter().
>> These functions allow capturing the number of times an observed IRQ line
>> transitioned from low to high state or from high to low state,
>> respectively.
>>
>> When used together, these new API functions then allow checking if one
>> or more pulses were generated (indicating if the IRQ line was toggled).
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
>>   tests/qtest/libqtest.h | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)


>> +uint64_t qtest_get_irq_raised_counter(QTestState *s, int num)
>> +{
>> +    /* dummy operation in order to make sure irq is up to date */
>> +    qtest_inb(s, 0);
> 
> Isn't it better to simply call:
> 
>         qtest_rsp(s);
> 
> ?

Sorry I misunderstood. You want to flush the qtest socket, right?
Could this be sufficient?

           s->ops.send(s, "\n");

Otherwise I'd rather add a "nop" command. Seeing "inb" in traces
is very confusing.

> 
>> +
>> +    return s->irq_raised_counter[num];
>> +}


