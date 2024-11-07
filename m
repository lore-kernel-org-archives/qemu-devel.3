Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E388D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zME-0002UQ-Lz; Thu, 07 Nov 2024 05:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zMD-0002U7-0K
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:03:17 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zMA-00061B-JI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:03:16 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso705786e87.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973793; x=1731578593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RObcayAO6GriURmt2Ani1X1HyfnW2UtnuKCuSD00Ors=;
 b=ZF22PNv6+KpTIbERcH3DQVSovu895o66GpJi3xSolBPZ7xU6n/RpduK22J3dPiVasA
 miUSJm/CWO/cy1PDRA9N0Co79vFEt3tugH0WEwqRZm4/IbtB15Ww+B+rp7WqQLfRpPID
 Lh5tsTh+9iepv7j/t/q27yQ7tzbopfjLMWVr77znWOfRo0ZJIhGVXGUTpu8LHe42NlVb
 GX7JGIYT93+oyyoDh34v3TsEXBWehqrygkoyyJxbtC87I0l52L0BkHpj+r9HQ5jYN0wQ
 mACZ6nfA2EHeBCbzBt5Fvhg3th69PCI+NMKLXTc1wDNt61NVbHxZrIU8OWB8xI7Iygto
 xi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973793; x=1731578593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RObcayAO6GriURmt2Ani1X1HyfnW2UtnuKCuSD00Ors=;
 b=UnwvWtroJ56RYIbTRu8wGpMHBYc+FTafPQRFHptbY0nXcGz5biC6Q5tNY6WlnrGJNI
 NuefvGdAkfsddgCSnwuV8cf0MVkZonOialhwBb2/HIFljBMGGsT2eK4HzvfADDKHnskh
 L6B8V+FVjxwGneJQ+HL1X6rIZZg//h8orixqh6NtH8wSsTEb4pHAm0Z7uM3nBXG0WXKJ
 apdrC4rsAJT1P8JO2AOhytg4k4fBInLIEUnn9DAuUreFZIftzWMI69dIJrxdmOfQk2jP
 AfCtCiaIZ4FITwGFIWB0dn6n+Bxj6dAAVM/f6t/yuOA11Wr2+3pFIBDujukvp2KFcvK7
 1xEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIRYwo0Ef4YHE9Wszh6v91MDfamLl9jOnoeXxXe5v7iTLWuPvF6kMfm+F25w5Y71fuj1DddDK82zX7@nongnu.org
X-Gm-Message-State: AOJu0YyV3hR6+qxkiFKSjVWLhhnyFbHzIIO6CWgjF6hz8P78OwQkbTPp
 gB0ZDh8UjrtMrh/UhFPVxBKjOBPekIMh2sqnrf/L2LqiADLenT8HAUTtNg8Zul1r/DTKpGyPCw8
 D6sg=
X-Google-Smtp-Source: AGHT+IEYNdGd90tKSqdqRjDTo0KM5ZhcmUi2KdHuL99fq2owyarwH36TBmRazwJzkIz04BHJtKUnnA==
X-Received: by 2002:a05:6512:687:b0:536:581c:9d9f with SMTP id
 2adb3069b0e04-53b348d6ademr21785152e87.24.1730973792640; 
 Thu, 07 Nov 2024 02:03:12 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35c0sm56267085e9.16.2024.11.07.02.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:03:12 -0800 (PST)
Message-ID: <0dfd5a7b-9713-4989-82be-7f84d4841b74@linaro.org>
Date: Thu, 7 Nov 2024 10:03:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241106184612.71897-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

On 11/6/24 18:46, Philippe Mathieu-Daudé wrote:
> These devices are only used by the OpenRISC target, which is
> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_BIG_ENDIAN (besides, the
> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
> using DEVICE_BIG_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/openrisc/openrisc_sim.c | 2 +-
>   hw/openrisc/virt.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

