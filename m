Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC03BD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 11:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV6R1-00027M-HT; Mon, 15 Dec 2025 06:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vV6Qz-000271-Ny
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 06:08:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vV6Qy-0002PI-37
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 06:08:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477632b0621so23842535e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765796886; x=1766401686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJltbxOt/9TZ2eA4uwws1CJXvgUotzsegufjxsGu3Zs=;
 b=Wd71w8MGel+asSmRv55a6BFFw+74w35ZFIGRs1OcMJwSFj1HcPtefdebBqXKeuUfzc
 bvi+bL7rxhqq9+yrsjWZA3bvkIEGKeEV7P+EfriYqjuCLjl9XZlX1FnEwkwZfm4Ezncw
 aWi3/5SBHmhDavUPAD/yzHkdGCGc8e0EbIHRbp1y9XgycbKlFmMfbK6nb020LQpY+XCq
 WWQNwdEGZ8UkVZQ9o3RPtNqz4h3olyjNVLr4oi+gblUzK5VzFFGwU1i+8m4bvWjol9v4
 6vMtEf8UDO4IT/pIw+U1F6DPamHkWmbJZl4ZiY6GCCtvG+yZZUu1WL16ZpObI9kng7yS
 5cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765796886; x=1766401686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJltbxOt/9TZ2eA4uwws1CJXvgUotzsegufjxsGu3Zs=;
 b=ZBuYkymxXk098JkxnnJOMvOptl3n817QN+5IEBOQGj4RK+nRH0enov9gexNo7kHNtm
 B+ArkZQOqi6V+1iG+L/mxQBiw+lqeyReb8Vo76QuuQZP2WZTfWDsu+IZ+/WfIRZ9U3W4
 26hXUzJLazrpg3Gw2YH1mNvX/LYnXbJ/SqpYiFlFSDw+oCCvrTMvREjsTC29XVtHVkLE
 /ivUn7Zn5PL7IUf4GLsOmkfb85ob8c8iIHTNKk3Vn3laBx2tDzv2Y334ZZ2kggTgcWtn
 QLUFN7oH2Q3+U4JUCkYbQ5fUx0tCHBDwm0ELf9ZYQU3MC+q/YV3YP2zGOvwyxAznPafn
 OHpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx3vhitSNvVazxA1VIHlXlWJMx6U8BBhnfkpSkDgXjJlUAacjhwuiRnXNeyY8Fm1QHEDEka1RaZTck@nongnu.org
X-Gm-Message-State: AOJu0Yzu2m0JkolZKpWgth+wDYaItD7sadeK60k0fIY75Py0z6rh73Q1
 4KFN5AuRo7gJVDUyCnRiNrje8FvNlFmTBiQXpQmU5k3MBpjoZHLA3z2YMCrU/C73EWpnCBAw4rM
 /zVLRvBc=
X-Gm-Gg: AY/fxX5ZvjT2sRupfftujiSDOxMnRbnrgZ0HAev7glnyXctCKZ7L+pEd/Di9GUPF8j8
 q810t7IjC0aMjFKsSzH+6rOjcj1QY7yR2K5rsfCQD7tBtflRKz1L4Azb8BvwBruURzkbeMm08A2
 jK7D+wTUvLmZpdPUQ6OS8ZSxSMxdRNMS0FiwiC0gixLuMKKz4GxZh0uV4+pLC3uwwthF7Mid2hS
 +S1rBMh7TCK538btMF03uOz0wHJ4uP4sTkUzMj+tsH9suKIDh84PEMYZKYcV/3QMhUqmZkQ/eXr
 9o07m/JTTpFKNblgA1rMh0zmqDrSPbndkAOCKZTsEuNQESQnO1W0VCdfZaI1uf1A/M+FY6Kn2wf
 MskpufkB+YPuHPSwWbGdyW6Z/JkeKOnyC7iai+T8oFYeUCPNQ4kwhZO1a3qAI4tezxeZsicw92p
 Io/RACZ70RfXS9xVnTRPfLThCC8mUYl2xkJoarkSOP3EGWH56VswqoWQ==
X-Google-Smtp-Source: AGHT+IFXFVLIOPbULUIscGyydd3pNRcTh1hsVLe0ylh6hJbh2sVqnM/aqnd/OKsX6V9XTS1JZSWC2Q==
X-Received: by 2002:a05:600c:529b:b0:477:ae31:1311 with SMTP id
 5b1f17b1804b1-47a8f8c0edfmr103759245e9.13.1765796885521; 
 Mon, 15 Dec 2025 03:08:05 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4b4d5fsm66043895e9.7.2025.12.15.03.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 03:08:04 -0800 (PST)
Message-ID: <f88e6e39-1732-4635-bb92-16ac15ee98ac@linaro.org>
Date: Mon, 15 Dec 2025 12:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] gdbstub: Fix const qualifier build errors with
 recent glibc
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251215101937.281722-1-clg@redhat.com>
 <20251215101937.281722-5-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251215101937.281722-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 15/12/25 11:19, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../gdbstub/user.c:322:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    322 |     pid_placeholder = strstr(path, "%d");
>        |                     ^
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   gdbstub/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


