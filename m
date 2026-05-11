Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149F2CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRF6-0006fK-FD; Mon, 11 May 2026 10:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMREo-0006O3-TQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:15 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMREm-0006m4-3I
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:02 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbec19732eso3991571a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778508239; x=1779113039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VeGJsjiNVxO7DhTHX782RZJEWGOGkzvUnAkwYm4KfFI=;
 b=TwkuSkim5/cRrcxXfd1ho8+BGaoPAvFx61G7AWPN0LbksOdauUKNFMhmUUc1YVPXhN
 U6U5nK3yaJmOBKhXOm0elzc3ZBOjUKJ9WHedwqNk+XnDFHAnYULVmE+UO4n2zyT1Tdqk
 tfcl0OKwHHuj1EewgHVOY48wakZPX9OeF5LWZxYFbyWoyknqw9TB5V/0AFSg9BIiiIPK
 x15EKSiTepq/XvNh2iTCXl/PNFpzM2xy78sHVE9DPMZWTymzLIvf1agEjK2QDT7grOXh
 iHrKs8pARi30hZ1k2EKkC3qnM3/8kPH+p6BFojxMQ/KAVPpep6/X9+WODDD0/Eo+tGF5
 gO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508239; x=1779113039;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VeGJsjiNVxO7DhTHX782RZJEWGOGkzvUnAkwYm4KfFI=;
 b=Tcqfr5PgQgx/JtLacDCW8kjqpM3NbvSvVfNkO69ak2SCdhEL6FNunFqFRpEetc1qLH
 xp8W0mwAdqwTjzTUWHJuRtevQ9VhatEO83mj3PT1kjiCT59t/MVGJnwrGS5qr2zliKos
 8KHvQCkC0nvOSWG7lqGRjeIq+Mw85wF/smEp0o/4Bo24Uz5LwJSr/JI3QQCevEWgbBRO
 uPPZBLnH7AmsgTk+tmp6/VbLYsM3rBz6myrlMyDI8yqEPUOEJEqPDj4nkjEs9YikeVNT
 6DqVY/7yyUrU9A/O5cSZbdl/HDvdJLwIM6pSoqt9R/JUvk0Nupn1Q324Ejh3umVpxPmc
 CfZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wVSZjpXAq1isfjpio7djP9d7BDolhNoMIF3gxePu+uAz0+sEdcrj4gGxMr1q6W66Q2auI4RGCds5H@nongnu.org
X-Gm-Message-State: AOJu0Yx24Psp/Fvc5nLHdAjGXl5iI46dD8h67xFiFHAWKMLSlQXVIO7d
 ZddtYIo+bEgytBz4Ltb86R8CofRzwXt+zO7zPrL8CZb8xG3divDZOSjTlhc6W4SVPMQ=
X-Gm-Gg: Acq92OG3h7YKXgAPO3UkcXzIQ0xLCAxEO4aVBQDStoKGFS6Si970Mf7w6JzssUe16xf
 EmBee3/0a3qiUArBPnNsFAiXmxKhDqVjSmXMbyhvsuqdjSYAeWQFZ4dzKX+tNTjxund9jyLWBkZ
 qFFK6X0a8MYTdXA916HxQxGcXVcmgzDon6/tUksG4ngek8z9YpOF3qPNDMnYAxQNmMMGF32t+6O
 noMbcTneILVWKtUiKah1Swh5K4HI21kMENbspcRNK8LzOkTdOh/0vylrFhNqmgfJYU2D8iqOSxZ
 oBbLSY5wPMcQJ8mEAYyv3hDFjwOW/8leFFwGNSoAmdqlqmFerdpb1dFa7ojlVOxT1Q6zmgLyyYs
 g9kMphS4cLfvm9OrnX8XdheiMaEorpkB7kxDEaM4rnlgdYNXOWIdCjCjTjJvZVgbKh6AdvCEat7
 r7oEeG8ngXt+YtxFRdDGlsYvmpe0ol+LyuSqJjTUQeRGgSffMeEOq3svlVy6/vgOFRN9jN2UQM0
 YkT1dyXlQ==
X-Received: by 2002:a05:6830:378e:b0:7d7:f638:7a03 with SMTP id
 46e09a7af769-7e1deef8085mr15646278a34.10.1778508238479; 
 Mon, 11 May 2026 07:03:58 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4fde9sm6835684a34.13.2026.05.11.07.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:03:58 -0700 (PDT)
Message-ID: <222fe848-a46b-43db-9494-8a7d773c3716@linaro.org>
Date: Mon, 11 May 2026 09:03:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] buildsys: Remove MIPS TCG backend
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511135312.38705-1-philmd@linaro.org>
 <20260511135312.38705-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511135312.38705-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 5/11/26 08:53, Philippe Mathieu-Daudé wrote:
> We removed support for MIPS host. Remove the now unreachable
> TCG host code.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                  |    9 -
>   include/user/thunk.h                         |    2 +-
>   linux-user/include/host/mips64/host-signal.h |   75 -
>   tcg/mips64/tcg-target-con-set.h              |   30 -
>   tcg/mips64/tcg-target-con-str.h              |   20 -
>   tcg/mips64/tcg-target-has.h                  |   69 -
>   tcg/mips64/tcg-target-mo.h                   |   13 -
>   tcg/mips64/tcg-target.h                      |   75 -
>   tcg/mips64/tcg-target-opc.h.inc              |    1 -
>   linux-user/mmap.c                            |    2 +-
>   tcg/mips64/tcg-target.c.inc                  | 2605 ------------------
>   11 files changed, 2 insertions(+), 2899 deletions(-)
>   delete mode 100644 linux-user/include/host/mips64/host-signal.h
>   delete mode 100644 tcg/mips64/tcg-target-con-set.h
>   delete mode 100644 tcg/mips64/tcg-target-con-str.h
>   delete mode 100644 tcg/mips64/tcg-target-has.h
>   delete mode 100644 tcg/mips64/tcg-target-mo.h
>   delete mode 100644 tcg/mips64/tcg-target.h
>   delete mode 100644 tcg/mips64/tcg-target-opc.h.inc
>   delete mode 100644 tcg/mips64/tcg-target.c.inc

Missed ./common-user/host/mips64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

