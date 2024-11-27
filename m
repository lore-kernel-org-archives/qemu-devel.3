Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F4CD6ACF4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLAS-0002eJ-Aa; Wed, 27 Nov 2024 11:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLAQ-0002e3-D2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:45:30 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLAO-0002fT-P7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:45:30 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53de101525eso1002709e87.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732725926; x=1733330726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kj4oaub8dtswE3oVfD7HEYkh7PxA+wB1DJIER4Qhu6U=;
 b=grjioZdGsqA1yMrmza2htNVU7enjWcQAApCwDjU+omz4e+BdxhDQa42c10177xlkMu
 NUeFg6F01+0FbJ5YgjhbaBpV75O29c+hvS3K1iBQbCKHZInNBWMlWwQfwxaq44KOYPAE
 ITKXo4WsPJ9okx2ix41SD5fYnq8vYurteISRSjhKJx5c8M4YNQVsDqLe5XcbLUk3b9ph
 VgHjesMs+8yYVGLJd2bVpcF8h+OnsiwaOi/T6br6TSQtg0+EFrU+5SqxKF26u93dRyGx
 skT6rm3wS5pNLhbaXc+B0GFgNu1BOVL59eljWrgL9BtWDFWWCTQl1jLkI3p80DKuJcU4
 FynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732725926; x=1733330726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kj4oaub8dtswE3oVfD7HEYkh7PxA+wB1DJIER4Qhu6U=;
 b=LELMhQEIFkp/lctvSR09pAAITPvUoeRvkHpJWb4oJHapyqwEQKNkmKUkpD6SaqJGgE
 RCYNThwTBQatbkjFmDluHpVzPwgi+mykuliGNQMGE/BVXtorQwOuuRV7/syDd0EWiS07
 GJbfoyNFowfWRaty1NuKw2kM5IYX0m2XFn8QQ7SQwRJ/kyupvLqYDbwI2u9IPrEA1qcF
 JWJkxRm1NaEJ8QHfqAQbU6q3GPGgTewZXHIH01C2alxRdIwyaiIvNlHleL2CoS/uWdyF
 SVyUMZLDGrfCvzxe9UNk3Esss3wLkMmBhBxM2zaUZYXJfAIbi1RNq9tHIrvTmQAqb5Qd
 KuGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvU0rc0Lfz+KR6OsCs+DgqoOD4O6JRNbnFPy/NLL5oe4hmmOAxL6UXspuLesg3ur4JyK58nUDUfPtq@nongnu.org
X-Gm-Message-State: AOJu0YySYqt7VKa+pRZKIRXkZJlZhosfP+ZzlYK1zoJwAqM42GZ1/N3v
 kbWiiKEccnfy5D6xkXR7YVxjBp1ffW5z9Gn0zdMR/im8eb8Ok4v3hrT1WnNiPAQ=
X-Gm-Gg: ASbGncuALqm5BaTT4GxjrUSepLYCeRKwezTy88GSiSo2Xc44RgSsd6vU2Zxo1huXeg1
 tWFfgM4z5LGc0ZFOyI22FLniZSMqolONxPhK7WjvzFd0t4CUpLfR5tixLxBvsjZLDkfujXhZV+F
 x1dGSb3M0/0zlCSC/ZM3hqPCUQUURSNUBG5P82Ra3z+7q6tdX/185bff5DbFqtLzdQVXRrsYPxP
 nQRIKwCU3Uq99FWqe0nts6DY8iVtollZ/G+73obyKGzKv05QLJot0G3+mT1axBFcmKA
X-Google-Smtp-Source: AGHT+IHU8JptaL1Y+cv7PHaOZdixH5I6cUiNJyNAmbpLCyRJRBwMT9Z+s3LKXrDwi4lSPSgF47TrYw==
X-Received: by 2002:a05:6512:2209:b0:53d:e5fd:a431 with SMTP id
 2adb3069b0e04-53df508f7a8mr1273e87.19.1732725926205; 
 Wed, 27 Nov 2024 08:45:26 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd24456bdsm2337040e87.11.2024.11.27.08.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:45:24 -0800 (PST)
Message-ID: <95888b4b-df7b-4331-ad24-245ace641d87@linaro.org>
Date: Wed, 27 Nov 2024 10:45:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 4/6] include: Expose QemuArch in 'qemu/arch_id.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
> While QEMU architecture bitmask values are only used by
> system emulation code, they can be used in generic code
> like TCG accelerator.
> 
> Move the declarations to "qemu/arch_id.h" and add the
> QemuArch type definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/arch_id.h     | 28 ++++++++++++++++++++++++++++
>   include/sysemu/arch_init.h | 28 +++-------------------------
>   2 files changed, 31 insertions(+), 25 deletions(-)
>   create mode 100644 include/qemu/arch_id.h
> 
> diff --git a/include/qemu/arch_id.h b/include/qemu/arch_id.h
> new file mode 100644
> index 00000000000..e3e8cf5e724
> --- /dev/null
> +++ b/include/qemu/arch_id.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef QEMU_ARCH_ID_H
> +#define QEMU_ARCH_ID_H
> +
> +typedef enum QemuArch { /* FIXME this is not an enum */

The comment is not useful.

C enums are backed by an implementation type that can hold all values.

> +    QEMU_ARCH_ALL = -1,
...
> +    QEMU_ARCH_LOONGARCH = (1 << 23),

... which in this case means int32_t or int64_t, at the compiler's discretion.  If you 
change QEMU_ARCH_ALL to (1 << 24) - 1, then uint32_t and uint64_t become possible 
implementation types.

Are you perhaps being confused by C++ enums, which are more semantically restrictive?

Anyway, the code movement is fine.


r~


