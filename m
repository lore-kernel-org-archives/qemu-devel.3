Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82EAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLj5F-0004Bl-Ph; Thu, 12 Dec 2024 08:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLj5E-0004BW-VP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:18:24 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLj5D-0003qc-4y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:18:24 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29fc424237bso228178fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734009501; x=1734614301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCXl0g1MTWOOBaXCerB8p7dUsPRdsWdQ0/5Ls6SQap0=;
 b=aOyzihrV8m2BtW2GklZQwaWwhkdAAIFpJ4caqfWYB1jvSQzHTxQ/hHAcb+heM1Dt0d
 ov5iAXieXyhdHal7tAjR4L2mRhzpzV7h5F9PSRZ9sygeiTb92YK9ddBntboCAHmhrdeo
 93yAa3/guTa5zlHbkOxvfN80CATcDOxt0gkKLSn9UcaePPg0rynW8avrETX3u2MdHliu
 zExQrC4/WKe/65UWth/n9MQZZaUqlfMCwJeCe1ekFkeDvIImutArlcT9Q+QZqlC9NwUt
 /tDH31nBCkojYKLW+ZDP3A7jtSnIeljynjhKcAQsKf841YhXqCkEjnQfdXZ3mFLWtLsK
 1gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734009501; x=1734614301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aCXl0g1MTWOOBaXCerB8p7dUsPRdsWdQ0/5Ls6SQap0=;
 b=Qqjrp1db3PtXDuWSQBVzmCz/2AS4h7xeNyNnfHIlr9DmToHC5GWdj+oMXKhMJ9wvYD
 JMXG/9MTccFqeEr0F5qINjJZTyAm7JhUELYHo30AdC3UqK8OZBshOyhX2UPKGB/2u03V
 dWnq+V00+j1IkjaMIzb3LdcA8btIjAN4LbKHL8zcwP88e4makPJ40QMxFfv/RHJRqvci
 BBXQmqYzw3mVm5vvVeO38uHS6pJMRuj+rMt+PFTh+QTQYnuiEFg3IulsddTiEw4xDfX0
 dce9E7xwP5YioL1bNs5PfK4SdxuXIEWIO2qBnnUV+xRqyV+UMf3WgcUknWCV2grU9Rb8
 kigw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMPWyeX7h/9swftxomqhJeU+yYTSpEn0iMFqMQ+UiKbOBl4B64qmNceWfwMRIEAuzRudqMdUYQjSoT@nongnu.org
X-Gm-Message-State: AOJu0YwM340QEPNQsp+kTGxICSkSFEEZjD6hVAo7GPI51QSHjHKrLfHR
 aqp5SikEzv9xFRTwQQurBh2jUjZuxynHklt2XpRsCPD9fr9MENiNyhVp2OD9WVA=
X-Gm-Gg: ASbGnct6+OUu9P+tgA/l1CymI9Tnh7ahVVpmpkdyF9fS/Mhd9Se7EXpiJVQqtXRJcXH
 VICIBvfE8Je6H9DPjRJ5xgwnlazzDoop8wWnd1rmveiG30qxU5Wo7Ch71qen+cjh4AB8pWczbCB
 QSGdJ1sZgWq+Etehu6jcFN6XvEr2LTfrV9+lcL5W9FfRjVXhmNrZRJxkOTSApU00GX3aprpZrNA
 dNbIuoFvQs2PXSuMQwnrgsmvcuDKWJ390VZTIW1iuG7B9CuwRVfunoI+NxuHXKw5MZQ7yfpJaoW
 JDfRuqM7GV6RcpUHQUOVE/jpVqYTZwzkwaQ=
X-Google-Smtp-Source: AGHT+IH3qe4owxnkodKiARuWRIt2SDUOQU5nmITOYP1p5K6YyeM7groPqMEP98Gfij2Ob7Y7riVDvg==
X-Received: by 2002:a05:6870:3b89:b0:29e:1a45:599 with SMTP id
 586e51a60fabf-2a38234d756mr1828471fac.8.1734009501310; 
 Thu, 12 Dec 2024 05:18:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fb38c2309sm2960117fac.9.2024.12.12.05.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 05:18:20 -0800 (PST)
Message-ID: <88d424da-a876-43b1-b0fe-4c0ff084d2a1@linaro.org>
Date: Thu, 12 Dec 2024 07:18:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system: Restrict libSDL CPPFLAGS to vl.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>
References: <20241212092632.18538-1-philmd@linaro.org>
 <20241212092632.18538-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212092632.18538-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 12/12/24 03:26, Philippe Mathieu-Daudé wrote:
> Only vl.c includes libSDL headers.
> No need to pass them to all system_ss[] files.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/system/meson.build b/system/meson.build
> index 4952f4b2c7d..f7e2c8b826f 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -23,8 +23,11 @@ system_ss.add(files(
>     'runstate-hmp-cmds.c',
>     'runstate.c',
>     'tpm-hmp-cmds.c',
> +), libpmem, libdaxctl)
> +
> +system_ss.add(files(
>     'vl.c',
> -), sdl, libpmem, libdaxctl)
> +), sdl)
>   
>   if have_tpm
>     system_ss.add(files('tpm.c'))

I'm sure Paolo will correct me, but I don't think this does what you think it does.  I 
believe this has no change at all.

The presence of sdl within a *particular* source_set.add() call is immaterial.  If the 
condition is true (and here, because the condition is missing it is true), all of the 
files and dependencies get lumped together.  In the end, everything gets copied into 
common_ss.

Both of these patches only alters the order of the items in the link ordering.


r~



