Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37814F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6ez-0005Bf-Ng; Tue, 24 Feb 2026 23:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6ex-0005BF-QW
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:38:03 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6ew-0007NB-2M
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:38:03 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4638fe85a7eso2499829b6e.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994280; x=1772599080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTQuxhSdNba2fbIn6UdSTflKT8cjtGXoYdwrZGwsWDc=;
 b=ryBc9b7+zChPsSiDN9n1tFZyDUlhB54b4Ti7glxqvt8mLvLXSGVEUVzGG2MgLJMNig
 PBowulPpP765ZZT1UB72/d4xWcLvS6ZENVDWyEkyvl/vc76FQOMfPNHOdeetyWJKa6gR
 iihTGsW08Mfy/A44qUSLFhKgvMuCT4TAvMZ262FAWfKHL6UszFJZT0QOXU7fUUhdBBEG
 fQg+tltbwShESnVPj5KCyQ9T+GW1hqG+oauR6cCUT5esM+1HucyXEnWjvXFVxTk4Pwgo
 02I7k6LdnLhLGZcdYgnpK7x8mtKPsvYiPtblzmLrWMrlDUS/U1McqradKPGaVFq3o6wv
 kuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994280; x=1772599080;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTQuxhSdNba2fbIn6UdSTflKT8cjtGXoYdwrZGwsWDc=;
 b=OZuvTA06inNKHbWJznEcgws0SJL23xZMVaZxzL3MDPwsYdXGIzwXsquqi3Nx2xDEzn
 YKOsoxS69iOLC+QndsrOVb6TynVQfTOphB/Xv95QQBtCUQEUQ3nMa2bk9S0ep5SYza2a
 IciDdTTakXgV5YG2YVJqMXUv6+aZYfi+rfEh8EoCxw0cDdyUmK8Pss/pzYrj19ckzZCE
 bATaxYzKc96PL7b+DbWH16Yi9z59ucEIAEv8e6z25dvh0U2qB3qP1TBrFlh7mGvhzSgH
 rz9g6+ij7h5zSDUUGgbku64gnCInKQFvk8PkTcS/oWbeFlICl6eJjWeDzIQkXyqwWy0g
 XLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyqnT76jnSwape59IrkX5TKNvSaeZFs+cYEvpFVxyemaVSnHdo23NCfB+0jnDJlKIJSzlIH+Jp3i3g@nongnu.org
X-Gm-Message-State: AOJu0Yz/dZrqyPZxfw42+iU7W/85jKs+GlKgrGOaEEF73z16uW1QX1N9
 W4ZX9DRyRqDZYlrx9+AO2cIwcEVaD2QsVON/uLIXK4KnKSVGS0p70oeJ4FCiGWnWrSQ=
X-Gm-Gg: ATEYQzwpKN/sdh0wtAUXWay+mlnFYkr73VkdqXUQz2AC7pzkVfXgod3jipmBoUQgq7t
 dxP1BxUENV5i5odR4IUu3BYFI94a6jFUtTJgpwN0ehYnoqWH82nhUOgLJL6AMhw7StAvQ/cPOcT
 vghX+bu+A4TDbk2oGnsfM/hDqJfZcFtJos4Gdjqv++1FcYbG6H/td1sB5cWMakVceG95nSpsPG6
 k7fW/ODyQE+4Ec/jqCQ7pxO8yeuAEkP5bIqjj8UuB7BH23E2H8551Umb232JQrJD0/NUaTnWVPl
 CahDZcydyUn3XGyRWuLtFtA9HSR37KQ8LIbRj3euqYXE9fWPqWWO9wyDkBleNq6l70f0yKvpyKj
 DNvYgOw1T6NLXIVY+YpFuhBa0Tt0+tpvseiZtmBTamIY8pLNXBukKiS2Wmbm2lwQODBhzTIIbO4
 zuRAvx0LsqUV/lson6xIxxlaaqyMPMw04VQ1EBtdBBNHBfm7NTJx93tLi1u4G/t7I/mshfK3j1A
 Gq2O7B05azl4+eNmJc=
X-Received: by 2002:a05:6870:d8cf:b0:3eb:b2db:8db5 with SMTP id
 586e51a60fabf-4157b19ca45mr7375161fac.51.1771994280116; 
 Tue, 24 Feb 2026 20:38:00 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d77e3sm12461808fac.13.2026.02.24.20.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:37:59 -0800 (PST)
Message-ID: <9dd691d2-57d4-425c-98d6-1eb0ce12c767@linaro.org>
Date: Wed, 25 Feb 2026 15:37:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] buildsys: Build most stubs once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 2/25/26 05:20, Philippe Mathieu-Daudé wrote:
> Use meson magical machinery to build stubs once,
> instead of one time per qemu-system-FOO binary.
> 
> Philippe Mathieu-Daudé (10):
>    meson: Include various directories providing stubs before libqemuutil
>    hw/acpi: Move acpi_send_event() function out of acpi_interface.c
>    hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
>    hw/acpi: Always link QOM interfaces with system binaries
>    hw/acpi: Build stubs once
>    hw/display: Build stubs once
>    hw/net: Build stubs once
>    hw/*: Build stubs once
>    fsdev: Build stubs once
>    semihosting: Build stubs once

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

