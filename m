Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FC8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GU8-0002zf-L5; Fri, 25 Apr 2025 06:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GU2-0002xi-VP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:40:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GU1-0000FH-9B
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:40:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso11725575e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577634; x=1746182434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4LcOLggjilTTo1NDNreIIcEQrd2fJd9yxzKVgZ2BUk=;
 b=H0BmooJTQZsRSn8JORvT13K7qO4XmDzjQAVjcVPahw3XU5A+eljdU+Qq/yJ5/FNajh
 ryJMPzjelz05GOkkOZ6Hca51GdUEhbwm4kUioo700mqctarwWZOn/Qn6wJtKoHQEQnrS
 YQyuHKu4lADcOZP7I1Anwh/dtjEdY94HQ4g343OqnMu9xSlC/HJbzcTz1ShsOXIQPhIE
 j340OFWJQubUtgYWTlYA8Tkp7StZfwEUtXzAHT+6AtVJ3HzLfbUyzQ9VbY6tycA7J785
 AGmjojvmmVKsScs3tgqKGA36F2AVzSIgS4dy9HydygrqDwS4Nt6KU1vi1HcP494i81wH
 Katg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577634; x=1746182434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4LcOLggjilTTo1NDNreIIcEQrd2fJd9yxzKVgZ2BUk=;
 b=r4OEK1pS/zsxOwbX4NG/SImT0ZUoA2lok+9RBFD1LZtxg2Ll6ywOOfcbIbN65/sO6X
 dkVj3fUH/Y2mLOwX+mej2lYsdBox6JJSjbznHzKe18A9SASsYcCUWhlf0b9P/yrADDEg
 +eN5sFTlfTGJrZsZB4njo/FiWCIqyT85EX1XqKEK1dzmqCDkoFQh8SjmFGf5jvHxENJj
 zsQ90R/0F4kyLFwNq8d/JubiejD5nSK7aN3o2LzNky6AaxDp/ch9vE4pEdSDCmNG6CAg
 J+hDeo1+YsCSHvlRUa4/E0VDeed69pmpRThDSQOWgM7VAf/zBILi/MjlemsYMmHspgds
 wdXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbru4wfZrXYVR3HZ/HGSacFeFQi3NNN1/4HBzQBdGyGEOS3IQKQ9tSQn3h1sRRA9mLqWSBH9EI74bi@nongnu.org
X-Gm-Message-State: AOJu0YwgKHh6VkfKVxNs76Ozkp9Wo0cbRUQRBH7XTXJGQgyaa/eaJcbl
 wT6rFgHiu2QUMeo5H/QPnjHAFZL1NXojt0niMKZn+mkOG0eVGWEkEpRwbNJ2myg=
X-Gm-Gg: ASbGncuEUUJUx+d+h1ciPv/7onSmWKt2MgV5xC3d/Y271cOytr34uMfpRgRs/VVigS5
 pCjs/1d4Losfs+0Z3yCU6prPcNwAKY8jatdSQEbUEPiUdTUw9HJln63fb7TRe+q9I4E0U4iWeCF
 Hsy5ua15QBYpyTYnUxrUEJznbhPpCMyFKYvLMGxF6b0rTGyCi75UfJLthH8u9cM5Z/UF7mbVWqP
 TwUavdv78sXQ1049tdZ+lkr2Ol8a1aOGzukVjHQUEQWVuOAFTUtJSodb1MxYnHxDv/hTTIZ3hqV
 VLCxcBkJ5q+l7a7LppGR9ilRHRgCbS73r2eN3PEHWCgtSHzEyBlL5b6tLnou/LO4/TTgv/fAiAC
 Wn2RuDGoLly+zjTi24rc=
X-Google-Smtp-Source: AGHT+IHYWMwxtKWQXojda5IqVGBp7Rz8g2a2AF2bLemCHb3tupm6hQSEcXgWOAOMpo/8DfAocjOaJg==
X-Received: by 2002:a05:600c:3b23:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-440a66abcbemr13288875e9.22.1745577633654; 
 Fri, 25 Apr 2025 03:40:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e00d8sm51835125e9.35.2025.04.25.03.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:40:33 -0700 (PDT)
Message-ID: <6f16193c-8acf-4857-b08f-e8a5d8ca3945@linaro.org>
Date: Fri, 25 Apr 2025 12:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 4/9] target/arm: Handle gdb_core_xml_file in
 TYPE_ARM_CPU
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/3/25 15:28, Peter Maydell wrote:
> Instead of having the TYPE_AARCH64_CPU subclass set
> CPUClass:gdb_core_xml_file to a different value from that that
> TYPE_ARM_CPU uses, implement the gdb_get_core_xml_file method in the
> TYPE_ARM_CPU class to return either the AArch64 or AArch32 XML file
> name.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c         | 16 +++++++++++++++-
>   target/arm/cpu64.c       |  1 -
>   target/arm/tcg/cpu-v7m.c |  1 -
>   3 files changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


