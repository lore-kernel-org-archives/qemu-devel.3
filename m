Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E06CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 21:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upCYb-0002dp-AL; Thu, 21 Aug 2025 17:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upCYU-0002am-U3
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:10:44 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upCYP-0003IA-IZ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:10:41 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-70ba7aa13dcso12912926d6.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755810634; x=1756415434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OzvOe9MvQYgv78cUB+OdVfOiMlVT61FQHsWfUyJcPjg=;
 b=v3pfvAuMoVg6oazd6UiLyN1noiZnF5ETPB51rbwu7S4sayUxpdrshMP4YiK5tmbjWx
 K1niC7r6RazdTpm0vW5ngePjjSy/G3EHfMxfikl+ikL2iyfkuE3MP4yMQRBnnLX6/Z8E
 KC8TqRs7Rvmy6IwaRs9gk59lPmWkkKbMAnQ1vFSclhobzV0dwb2/i3FFrWvUrdT1dyIO
 34cjeDmuvUsWINFHCzNMA6ui+uK2JNW81JzjnBArk4gg7bKid/XXLnj82FqzWc04+2Qk
 tg3KWNLwPnJrgvDdJ9FHlX4ZioMh78Um8eL1sYCl5frRQQbL9sKm25DrhCb7O7UOYZvG
 DDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755810634; x=1756415434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzvOe9MvQYgv78cUB+OdVfOiMlVT61FQHsWfUyJcPjg=;
 b=vyerAn8A5MpFJgsBcxbsnBpLYtS2LtuJuuub4FxlXMVV/3knvnIQ+pxDijt1Ksv7WO
 +wUftdlDczVjiXxQ8VRyIR0jgCLY1Q0So2mlVju+Orx0qWca+0u7GW7dP1dyEL0Jr7BX
 aHGAKwtrTiYahuqZjXbWfxbtl9Lsnpzkn/71/qpuGt8rDDhSH05gCfZ6c+oI1OS2Q5fd
 CyvIT9FlarLyPi86OpI6XtNlLRQJLQ5gs95uTvBiXoa0nxBeu9hRp6dnEz7+7rSc5qPR
 kV9Wk6k239H/Ia1QHOzr6qXpe6u6hfeiKsd0NWaGHLf8o5Ji71fm93VEbIeUpxhuvPYS
 lEsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9M6RWBNRyJJrz1xIWPrSfS3OmlEj1M/88XwLnE0IuIs/L75ftt2BT2aaTp4+FxRHweInx76qRc5gB@nongnu.org
X-Gm-Message-State: AOJu0YxddvHYugtgkmJKdMbm9tJsVBhYDd6OUYtv86UBhG4T+lDhgr3s
 xN/7Q/KvLBdkb/ZsPIXWvMpugGuk+h4OsxLh3+uNrkf4l+WcMdjXjVH+h0clyKQAMCs=
X-Gm-Gg: ASbGncvnYmHFEk/wPhjzLMWjmhZ/FSJbfbU5xA+Pfd2NOPWs8WXdqUa99aIuQ57En2y
 quZM0He9vNonSOwDb9UToUcYF5WJAXV7WtTLsOK5Nz41D/haJ9BzXugbchAZxOtuDOHABbBijOQ
 SyMFMrJKsUjiETB3yTKw9BnQYZfi4Df3xMkMjRJHuoLjK1uTH3m4kniUflyyJioIpBeOGGXMUuV
 IzK4ecMNT5bBf22XJukwvAfGmGjFyMdXJdorM76YajKQFXHiATb5ySC4VbS8SOCxsdFjdSQIiJy
 jQKBxcorjh5Q7OEfGewtW220oGnJYgFH+mLjhp66I/XgmIwe8/FmyQrr0Q7zEYupjgphjV0vp1S
 hV94jDtELLktGHoPps0XTqno45oJjxk/RJNuj0xLcpGSivg==
X-Google-Smtp-Source: AGHT+IE71RXRoITYnGqy28pMyOpgBwlTlqah3grJs51DhIZo+g2c6X6Cq6VcCLaiYgFG0mmlk7J6+w==
X-Received: by 2002:a05:6214:dc3:b0:6fb:25f:ac8c with SMTP id
 6a1803df08f44-70d972f93ccmr11531736d6.31.1755810634341; 
 Thu, 21 Aug 2025 14:10:34 -0700 (PDT)
Received: from [10.48.39.227] ([172.56.181.150])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba9077520sm111368266d6.21.2025.08.21.14.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 14:10:33 -0700 (PDT)
Message-ID: <861610db-6bc7-4e5d-b54a-a86c5818e9ca@linaro.org>
Date: Fri, 22 Aug 2025 07:09:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tcg/mips: Check O32/N32/64 ABI definitions actually
 exist
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250820142108.46639-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

On 8/21/25 00:21, Philippe Mathieu-Daudé wrote:
> Similarly noted in libunwind: https://reviews.llvm.org/D38110#895887,
> when _ABIO32 / _ABIN32 / _ABI64 are not defined (like on OpenBSD) we
> get:
> 
>    [666/1234] Compiling C object libsystem.a.p/tcg_tcg-common.c.o
>    In file included from ../tcg/tcg-common.c:26:
>    In file included from include/tcg/tcg.h:34:
>    tcg/mips/tcg-target-reg-bits.h:10:18: warning: '_ABIO32' is not defined, evaluates to 0 [-Wundef]
>    #if _MIPS_SIM == _ABIO32
>                     ^
>    tcg/mips/tcg-target-reg-bits.h:12:20: warning: '_ABIN32' is not defined, evaluates to 0 [-Wundef]
>    #elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
>                       ^
>    2 warnings generated.



> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/mips/tcg-target-reg-bits.h           | 5 +++--
>   tcg/mips/tcg-target.c.inc                | 5 +++--
>   common-user/host/mips/safe-syscall.inc.S | 4 ++--
>   3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
> index 56fe0a725e9..a957d2312f3 100644
> --- a/tcg/mips/tcg-target-reg-bits.h
> +++ b/tcg/mips/tcg-target-reg-bits.h
> @@ -7,9 +7,10 @@
>   #ifndef TCG_TARGET_REG_BITS_H
>   #define TCG_TARGET_REG_BITS_H
>   
> -#if _MIPS_SIM == _ABIO32
> +#if defined(_ABIO32) && _MIPS_SIM == _ABIO32
>   # define TCG_TARGET_REG_BITS 32
> -#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
> +#elif (defined(_ABIN32) && _MIPS_SIM == _ABIN32) \
> +       || (defined(_ABI64) && _MIPS_SIM == _ABI64)
>   # define TCG_TARGET_REG_BITS 64
>   #else
>   # error "Unknown ABI"


Alternately, remove all of this.  If we're removing 32-bit hosts, _ABI64 is the only valid 
answer (N32 has 64-bit registers but 32-bit pointers).


r~

