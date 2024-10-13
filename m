Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73417CF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 17:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t01xt-0002uD-Or; Sun, 13 Oct 2024 13:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01xT-0002pE-FO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:00:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01xR-0000W3-2B
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:00:42 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e483c83dbso1778841b3a.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728838833; x=1729443633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rdG6jEqkKBlP3mZVF7pSuRS3LMHOuqbpa9FcqxZi/wk=;
 b=ZwUocWyiFFj74vZlxovU6OwUhUZWG/JDXgIlpTMN38DMrRTOiqAVQ510Bc6l5hMYjH
 dHWmcLpFtzk94FqvZ0PzEIPgzXRbAKPMU4XlCPCmWTi8IBVHi+46+vTGIWfKm/D1nz9+
 nv+oLItG9mSdH7lkZR1zCFYWJqNKf4Qb0HjBB9+CDYYj2MmG13F3M1MoP1bRWkthVb0s
 zHjGDQccH9g9rngUR7sd/iCg2smDklhbu8tnLPeUt5Ugk+12GgjqPD4rvCnTFy3NOO1Q
 em2n7FJ/cl8FimOxKKlwN1rxFQ9u5ZIi/E4UcFnb6B1GfGMPWiaxABaBe4eOyfYYgi8j
 SvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728838833; x=1729443633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdG6jEqkKBlP3mZVF7pSuRS3LMHOuqbpa9FcqxZi/wk=;
 b=hp48ekdI7VhM8qM+/fkvkuuTAmKH4Hs3WI7d4exAIDfLqYH8Ht4t3Sw9IMxUsZRiO1
 Qkf2wtN0tLMhI4qXiaMdH0U2xDpjeYve4Rko4WDcmT5eRWoB+loUKvfdDOMgEEv5O5go
 re4UmX2FQSX0ZeFC41nC2pdyjujF5qLGdl11Wd3f9jkHPbXZMhrAtVfYKzktVsI5dK2N
 mc30bwVW1SulYBpvRERbQe08X6FPWlGdXY26zCLkvhi2X/MPR9gHGw0DCeCF80l/+d/A
 787r+9t4pghC9CTVQvX+lGCUcyRNOOCj+yIxIYiyzq6ZTPSsTFRCDqZ0+Voi2Q+Z2lg0
 aBpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3i2HmwoiNx+MXpERXe69wKgcCc5cG7rKBqEOxXzDKgLLm47cy2Y2K8lmJVSepwpLkS1WLTw15pdwi@nongnu.org
X-Gm-Message-State: AOJu0YxYtEfuJQBEETMX44f5+HBy3GMNTe5J5onIvgzNT9qOLND58xhz
 AoV9EqVvQHIX0eLbCPSOztRTi2NvOWoy/UV3ev4KW3XS6w7Hj9U0F3aFWKfIpUM=
X-Google-Smtp-Source: AGHT+IECJ9/5Vk8Ccf/ZyVloZtkL+Fsj1o9hKMuWJXGzdgXSxQe+0NgqNHNBdtUsIPhEltR5AwZhtA==
X-Received: by 2002:a05:6a00:1307:b0:71d:fea7:60c5 with SMTP id
 d2e1a72fcca58-71e37f4f00fmr17142051b3a.19.1728838833141; 
 Sun, 13 Oct 2024 10:00:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e60bbec80sm1092806b3a.95.2024.10.13.10.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 10:00:32 -0700 (PDT)
Message-ID: <b52add32-9ce5-4a41-b2fb-4903144a7433@linaro.org>
Date: Sun, 13 Oct 2024 10:00:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] hw/mips: Have mips_cpu_create_with_clock() take
 an endianness argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> mips_cpu_create_with_clock() creates a vCPU. Pass it the vCPU
> endianness requested by argument. Update the board call sites.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/mips/cpu.h        | 4 +++-
>   hw/mips/fuloong2e.c      | 2 +-
>   hw/mips/jazz.c           | 2 +-
>   hw/mips/loongson3_virt.c | 2 +-
>   hw/mips/malta.c          | 3 ++-
>   hw/mips/mipssim.c        | 2 +-
>   target/mips/cpu.c        | 5 ++++-
>   7 files changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

