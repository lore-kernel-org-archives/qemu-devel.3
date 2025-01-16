Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C57C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYX8W-00048J-1i; Thu, 16 Jan 2025 16:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX8H-00042X-C6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:10:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX8E-0000AY-Eu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:10:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so9360245e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737061824; x=1737666624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UeWTUDAjdB2la8FOuUHdBVzsufOW9d0sYoZ9YhEhY9Q=;
 b=JWC0Kgue2zXZp4uqa+jJYXXPVubanHAqHPwh9EF7xo8Y6/wXOlPIG15gB32A1P8YI2
 wItc7ZtAGiDa69ysIv7F1HIWWgVESRo5dU0lipF2pEjBaut2ahJnVBVSNAyrj/qCYlyn
 5Mp3N75w46xD9lg5UEtL9TL4J5H1mER/WbEl2Oqt11HqRn+u5u/Ggy6pSeXJRs7uapKl
 /7tC0+wvP1eCjq7B0KC20qNDedKilrUzWws+JUeO6ZmVJ8FDF6KLbtlVrsGspDuz1mcn
 09sdkwnNDJGfiqrMGJ5PqA79IPQESD2r0NIZdBaAga+V8r8DlS/V1VucPl2hXENwqpZ2
 6c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737061824; x=1737666624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UeWTUDAjdB2la8FOuUHdBVzsufOW9d0sYoZ9YhEhY9Q=;
 b=mr1KUi5BkSYBD6fXJCh3rtfyQblQvrTqyLtTMH/SGCTdajSJeq7HoOqhYHsfUyMNct
 Rdbvw1UyU9qVPofE/uSrzmXNETVi/Drn/pNomfQAnBHkZK21KEXkXxc5VmucDaieFtQe
 UqyvEp3IpOVBfjaQ8j3J+mfD6uZ5XBSbjbwd0OG3nXW6+qpYjSOq3YkktF5y9sueXMQg
 NV1+vZqAQuu27b86kwA7UbfwNaQyYqgHk4zZvzDM/ysM9t1MLulENmARr5nhpOrU6V8X
 GvUdeXwwgT5dL6vKDbU42lkIyHw6C64GF0mZtD7b0HTwCyhNeqdgBfY5555mQ2pFJmaQ
 zAJg==
X-Gm-Message-State: AOJu0YxL7b/b+zLOo3z92ykVtf0snJy0Z6pTbHRTCYfXG8JfilEc5f+5
 K3GI5T34AgghIIs+801FpQDCWnwE8tcFshHp1l9G8WDEhUYxiG6+SuKwp8ByWdy2+BWTqQchgjW
 Dgro=
X-Gm-Gg: ASbGncuCae9bv9nhPguQRu7SIDtc9ZP40XkAeH4n0jPQqIBGBWAs3n5YnbOqDs97kQu
 tXtiEoiha26hlvVMyKL2RT2cxQwdL0nJd76QtUFvuW3BMxkF8GF1KFnLxOFPfnbTEO0AmUr1oSq
 ULRtEKkMym3f4sEQCH4cH7bs2dpjEeFEZ3u6VkplMB1uqQ6TKE3a0bIvEi7ZF6yXx74mVlLDmDI
 b8IfEzvwZlFCnJNer0PrdHjDMketw6FE16BoqfmsRVTlUGLjXbHIJC45VLK9inLpUUf8enY+5f5
 KZE2fKi/tCPORnKIwrhlT2kH
X-Google-Smtp-Source: AGHT+IFFqiosEpdOpPNplZdnaCckDHgK4gxdvC86+XnL4Kc9bzm2qkOVMA19aFv2Lw8TgNwfK7BnaQ==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-438913ef6d0mr1896825e9.18.1737061823888; 
 Thu, 16 Jan 2025 13:10:23 -0800 (PST)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm72078475e9.20.2025.01.16.13.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 13:10:23 -0800 (PST)
Message-ID: <1aaa90d5-ccbe-4aea-bcfd-5e376df8e3dd@linaro.org>
Date: Thu, 16 Jan 2025 22:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/compiler: Absorb 'clang-tsa.h'
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250116210913.53782-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116210913.53782-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 16/1/25 22:09, Philippe Mathieu-Daudé wrote:
> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity,
> let the common "qemu/compiler.h" deal with that by having it
> include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
> Add a check to not include "qemu/clang-tsa.h.inc" directly,
> remove previous "qemu/clang-tsa.h" inclusions.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/qemu.h                               |   1 -
>   include/block/block_int-common.h              |   1 -
>   include/block/graph-lock.h                    |   2 -
>   include/exec/exec-all.h                       | 516 ------------------

Oops, weird thing happened while rebasing!

>   include/exec/page-protection.h                |   2 -
>   include/qemu/compiler.h                       |   2 +
>   include/qemu/thread.h                         |   1 -
>   include/qemu/{clang-tsa.h => clang-tsa.h.inc} |   8 +-
>   block/create.c                                |   1 -
>   tests/unit/test-bdrv-drain.c                  |   1 -
>   tests/unit/test-block-iothread.c              |   1 -
>   util/qemu-thread-posix.c                      |   1 -
>   12 files changed, 8 insertions(+), 529 deletions(-)
>   delete mode 100644 include/exec/exec-all.h
>   rename include/qemu/{clang-tsa.h => clang-tsa.h.inc} (97%)


