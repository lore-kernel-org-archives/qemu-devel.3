Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE14CE6ADFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqNn-0002ap-Jl; Sat, 23 Nov 2024 08:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqNl-0002VM-RE
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:41:06 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqNk-0000zj-7A
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:41:05 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3e604425aa0so1604262b6e.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732369263; x=1732974063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajVVDMKLl84ooZxNQirE5Xz/cDdebqgHZuJnIPm71Ns=;
 b=lSRqObjW0OMlNGw0L2AZwTPc4XC0Rj0rEEbLfwBhWOF2spK/8jPDNz2vWZc9vwtHHA
 5G6crRf5ljplXmNX0ZFOaunOcx/uLQq8XRJ8XyppzGlkJ7sAxiTpMc7FpSu9ZF24Azd2
 xjLn7WvWEHNf/fiSf0srVOYyv7Rf9zmx933kSJFo5+E+IuXXPnL0GaD3UmAa0yq6GN3k
 0zSGGi0O0ttNUUfbWDXO0i3pwcYn9mhJ2ZcaCXru4IS6o8WI95+L5Z86F8v5qQo60cTz
 4r2SAV/BS/DfYSuvRirise37in+Q++/W67pR2kISyKxdNT8Po2ngo7Th08pRb9+63yf1
 Zl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732369263; x=1732974063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajVVDMKLl84ooZxNQirE5Xz/cDdebqgHZuJnIPm71Ns=;
 b=Vb5rrXb+EIZkIXShFzeIM4F9LThzxE1jOutFS1nmd4+EcVF28KBC4e1x2uUN69e051
 m8lZLGOfJKSyiqGFRZxOiH92Nho1jipHM3D3qHmRfYIIHjAX14NYxSb6YJQaWk77aVvI
 Ht2wDL4oUYi/BCSR2idOeJBKTvL09eI7VsR5oRQzxzP+8X1KCvaRRVmmSfn/h2sPZkLh
 uDtVzaxafXQEYHP9/BhBE7WVy+Z/MRCXm+eS7U3hNAjJWZqXvgehEFJubAy94xh4BKbv
 Ol3zZHJoTi+sbaUpRhCFwOVOuRX8VJ8hXdZ6g2HieLmmNaaxnwrqZfOc/AFoDfVA05Hq
 SByw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURfckWwu/Hw1wnUCy3IzTRBh8E7Sj/wIcahYXfcjhfOD0sbJ74RmyaiercNPGpAMxA3+/0F2Xo14QK@nongnu.org
X-Gm-Message-State: AOJu0YzqV8bxZ6Oe12NJS9rVOQLvxC2aswe4JNTp+3CT2ZbvCte0QbsP
 7ecbG8y0zg6m58jJVkoG80gMEwnqueDDVmhkOCQy+wevhfHZdiq0bMV6D921D98=
X-Gm-Gg: ASbGnct0+pjZ/VZduqHt/kj8QvGYE46/5lxLH4/zYrIUfW7GSrJ7/02+HvEf2nQc7YX
 RA7veGe1K5lpPl6jSOq5f/LKuY1fJiHy83VhFi/0jv0d2dgfkAyXRVGRSyaSxvwxb2KUQwOoYdQ
 H9BwdsvYYbexSCkwUlSZfw5lN9W9YXn8iFWl5lWFya48FAKjETA3vL9NiDBV/1B+pf3sI20xiyK
 L1IIOwIIAhSsax+6cQxmpiOjGzTt+o43DRP1dPrkggsjEs1ZQj0UlM5JruT2/H0/Q==
X-Google-Smtp-Source: AGHT+IGIm/L3XNc3sAMeICx6PrEctY1kvWaNAr3OdMN97sfUntvzfdZiBBMrZkB21qWN58SyiInD4Q==
X-Received: by 2002:a05:6808:308b:b0:3e6:35da:8f2b with SMTP id
 5614622812f47-3e91580a83fmr6608865b6e.4.1732369262814; 
 Sat, 23 Nov 2024 05:41:02 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e914e54f8esm978552b6e.10.2024.11.23.05.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:41:02 -0800 (PST)
Message-ID: <cb560faf-a6d2-4188-93ef-b1bd84422a42@linaro.org>
Date: Sat, 23 Nov 2024 07:41:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] docs/system/arm/emulation: mention armv9
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index a2a388f0919..2956c22a1b7 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -3,8 +3,8 @@
>   A-profile CPU architecture support
>   ==================================
>   
> -QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7 and
> -Armv8 versions of the A-profile architecture. It also has support for
> +QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
> +Armv8 and Armv9 versions of the A-profile architecture. It also has support for
>   the following architecture extensions:
>   
>   - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
> @@ -153,7 +153,7 @@ the following architecture extensions:
>   - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
>   
>   For information on the specifics of these extensions, please refer
> -to the `Armv8-A Arm Architecture Reference Manual
> +to the `Arm Architecture Reference Manual for A-profile architecture
>   <https://developer.arm.com/documentation/ddi0487/latest>`_.
>   
>   When a specific named CPU is being emulated, only those features which


