Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4089ED63938
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 13:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDkWx-0007p9-UJ; Wed, 20 Nov 2024 08:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDkWu-0007om-TA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:14:01 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDkWt-000623-5E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:14:00 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-382296631f1so1439705f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732108436; x=1732713236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eC9lggUC6qfyEGbLNEAp7diuvO0tVr8dq7kz+aSp/xU=;
 b=HUnf5J8uXNMKZiZNS31G3DnqC+58I9HuxhdsfSniRWjYIw/lNeg9pM8nQ3oVYLFWsT
 7xbUZ0mAX1DtFGPmLTOfYvBm3DRevoRo6yn8YsIEJ6hEr6f3dpXhm5yXMY+JamL8kYhu
 vi4a4s4DvZ5IKmTtgSVkReyd1wt7z9i0s9xUzrcxH3Ts11Mg4EiDw5SMLsFy3rPBcrr3
 1jmwv6BoDAUROmSKG1RI9J4nD2IYfMYMClJN0gXwV+prFR9Ts8CIVHHs6YrA9jgA7Rk9
 K+PCL5H8uGMxjcJNMVRUgjvVRCChr4RUHWQ8Se6U9sjWsOiHz3+/uOxHZ0kb+U3phcvE
 fuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732108436; x=1732713236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eC9lggUC6qfyEGbLNEAp7diuvO0tVr8dq7kz+aSp/xU=;
 b=XB90DfDeRE0n/93DzHa0RdYkLFfUWB0n5Z9p1R6IWv0wgrBmpyTBXFBrzQnocYWF3B
 1w9UUzlkX2mzPY/3dhRF22dENvUdyaLks3Ro3fbenUf2aLWsHp4hCuzamPSPwNzXOTYk
 /6VCuB9FB6yG0Ce0b9dHpgIuzIg+VzOZpS5jwvALnQISsqL4/ZFSxPi5cqZy6E08YjQ1
 EGEghoW+D5xxB4rf5fz2lC679Ef2IAOLsnCXvqiEiaEME8nEwU+IXJObQoS6gH1oII/Y
 WjsPE2/Kqo0k4aVX1ENHBbrmLp4tKQL0mfgyivjxDjTuy178v5y1xsKVM1k4kYvomvig
 EB7A==
X-Gm-Message-State: AOJu0YxTahGaAvq9rOq68xkq28AmEoYEwycrEsW3YQzZ5c2pZI9yk387
 F4yDP2PHqJmwITiC+oQiVZ0af+vh6yIa7GvjXdzzWKg8f22LcBwvlQqPURCxLbE=
X-Gm-Gg: ASbGncvvkNBK3wjlQycoxFXgn8v+zRXZvmsT8GbXo3E7ituO+hQkqUkmTpQmOezHSLp
 Jnt8azgc9yaIGZfWrd2RXDAI5YvSSMCGqbM0o3NL1Ai8Wn3KHFJ6ISnhIxNsVOziTTD4FrcI5SS
 JL1BW4S6fE1ysRY91/cf/NOikighnwVcxRLvyjaS/6rv6WveQe5jbd9L9l4xTLwgs8+EB41I9FU
 Y3NVkX1N6eJIjapReom5MiL2z2jKUnQMYoznw3JRg6J5UyiJzK4/9Ka7sFwE4Me
X-Google-Smtp-Source: AGHT+IF+LsiIL9+814Fjimjv6vvsKT3JRcjW6GA/FeFj3GlHrizD/5p6Bc6b4Bysv50oR4MRoWZaSA==
X-Received: by 2002:a5d:6c63:0:b0:382:2492:3218 with SMTP id
 ffacd0b85a97d-38254b17467mr2036678f8f.47.1732108436476; 
 Wed, 20 Nov 2024 05:13:56 -0800 (PST)
Received: from [192.168.69.197] ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825493ea20sm2039709f8f.93.2024.11.20.05.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 05:13:55 -0800 (PST)
Message-ID: <bcf9176b-b1c3-4b31-ba09-c1be7900c79d@linaro.org>
Date: Wed, 20 Nov 2024 14:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm/armv7m: Expose and access System Control Space
 as little endian
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Tony Nguyen <tony.nguyen@bt.com>
References: <20240924191932.49386-1-philmd@linaro.org>
 <CAFEAcA-X+BUGcq0EGOC05DWqjNd+WSs_Ufqv8=gpRfF0uAmUYg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-X+BUGcq0EGOC05DWqjNd+WSs_Ufqv8=gpRfF0uAmUYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 25/9/24 13:04, Peter Maydell wrote:
> On Tue, 24 Sept 2024 at 20:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Per the Armv7-M Architecture Reference Manual (ARM DDI 0403E):
>>
>>    The System Control Space (SCS, address range 0xE000E000 to
>>    0xE000EFFF) is a memory-mapped 4KB address space that provides
>>    32-bit registers for configuration, status reporting and control.
>>    All accesses to the SCS are little endian.
>>
>> Expose the region as a little-endian one and force dispatched
>> accesses to also be in little endianness.
>>
>> Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> What's the rationale for this change? All Arm system emulator
> builds are TARGET_LITTLE_ENDIAN, so MO_TE and MO_LE have
> identical behaviour, as do DEVICE_LITTLE_ENDIAN and
> DEVICE_TARGET_ENDIAN.

When building a single heterogeneous binary, all device
models can be built. We want to remove MO_TE, either
using the proper endianness (like in this case) or use
both, one MemoryRegionOps per endianness, letting the
machine picking up the proper one.

I'll reword the description to be clearer.

Regards,

Phil.


