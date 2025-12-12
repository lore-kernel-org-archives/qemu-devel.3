Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462E3D49235
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 14:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4Zn-0005xn-VH; Fri, 12 Dec 2025 09:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU4Zh-0005wx-MJ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:56:55 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU4Zb-0002n9-Mv
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:56:52 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e7f68df436so948995fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765551404; x=1766156204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C84oN1mOsr9iVWmQkyopN5rp6NKdG6qYiLoANha6GYI=;
 b=ACiNQbv84qUCKtJNv0Wtjwf/d0KTeb1HM4oodkfeRtIS6s2vlNBPuwSKS8MYCFzneB
 /f/v9iKSXKR5ksVyk4J7ZENSN3tWUjDV+LDNhUXdI3AdUeHdoFKSMDqWAWX+Vn1m85RV
 fmXSw7BByk5k+qK0oE0qxtizUS0x6Ap0aHDcgCcTcmYHaWsVjmCwRSmvcOu2RhiNZzAY
 HgDGAWrVXX1Wx01k7Kg7kIaO/aYfW6mQjhgh+d0q411Hp9Zp5K6IGnWnzkBiruI6pbFp
 92WZzlEG2LG+r70ZvGcDhkFksU1CewsA7V4PLKlADN0pAEGxaZzQBFZSmVwjBK6293VE
 qh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551404; x=1766156204;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C84oN1mOsr9iVWmQkyopN5rp6NKdG6qYiLoANha6GYI=;
 b=FoIAJBQCCH4lnl0jSA4R8U6+gPKJiwNRZ2PKiRSZzqwGrN6F+b1W59ZcEHtqanOiyb
 UsBenoyXE0lyLksa5pe3jp5KfMLparhaPWkubyTNZ1KcAVr5DTYiinyCdvXRmOUoWCW8
 NNuCTchat+vlAWlOudZsZRIdAja3/gMKDLTGS1IG/44MPxU/pcoxCoxj3IBmMvx8T301
 GULY/7XEhlbD2t5ewWlHX2WPJl6BiK3u0bvhu6qtK38+62aBIfKVN8QwbMbUWRE5+srb
 M1Q7vWsypeNrs9ephgFNP7ILkSQZRV2NmDXoO3V7LT7B0OEzGtpp8ysD6kHq+N7gIKjr
 qIyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqidwdChGY9EG6igoEagT88sV1MMgiy9hobMvMcVMw/T7s/eq0Mx6MmRCtB6AcngYtwiYqX7mI/Bsl@nongnu.org
X-Gm-Message-State: AOJu0YxgIPac1zPzul2I19bQzW+wJqTaM/YtWee7SC/qhNYdNw6lpFoU
 carOEcyG48lEZQ7lp9qMvMJvy292jr9KmwbgpVy6REE6jPLAX9WusXYaDnARqmpNJHk=
X-Gm-Gg: AY/fxX56jXNG+qlqDwXyNVhe2CcBDJ4yCJGfwl42NYCS54251aljlrzxqx/qVocgox8
 uCKbWEcNIVqVZtDE6Xmj00HjDcN13UOdDxH75cne9q5XLFyM1WwOdTKpKRF/lKwpXLZbS3OLGsx
 hL1XKBQk49lt1Ul4SRYyLYPrgeFhNQUvX76xqjuvxTEQY+MBG5fuozhrWYvgROaSS0AzS+9Tskb
 /vh4bAUOZ4X1MzE2dLEUQ082rBojwM215sZZC+RjjHE42bX3ueh5QAetA+1gKxLVuOajv1L66qr
 BTEHjVbLHKvYzSzV1TywTyXwpCAmgRery7DFk9I87tieOmX4qfXg88pmORg6dIBJ9bUwW1lSf2/
 QyqnbRco4Azwd3lfIJcLBsj4zlX+JQVtehxJT4vMV4Fi4sxBBsrjAG5vafC+z3j9a7fAvL5qFe5
 cVMvRNBO3dpW2gC2YoffUnpsDncVzBjKkaywybejXyUU2KBxfkmKiJLveqXV55kNuZoIj4Kfn6Z
 gU=
X-Google-Smtp-Source: AGHT+IGmDxXtNG6i7M3hedvRmYmDIrAChwVlNiCEPzqpaM9qAcdeV5GZRH7lqxJ/eM6ubYTwDFFWEg==
X-Received: by 2002:a05:6870:9709:b0:3f5:b761:5234 with SMTP id
 586e51a60fabf-3f5dfc8a30amr2871894fac.28.1765551404279; 
 Fri, 12 Dec 2025 06:56:44 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe59c583sm1104777fac.22.2025.12.12.06.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 06:56:43 -0800 (PST)
Message-ID: <a40ca4c4-b34b-4315-8e6e-46812dfd5432@linaro.org>
Date: Fri, 12 Dec 2025 08:56:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Move ARMSecuritySpace to a common header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20251211234426.2403792-1-pierrick.bouvier@linaro.org>
 <20251211234426.2403792-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251211234426.2403792-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 12/11/25 17:44, Pierrick Bouvier wrote:
> From: Tao Tang <tangtao1634@phytium.com.cn>
> 
> The ARMSecuritySpace enum and its related helpers were defined in the
> target-specific header target/arm/cpu.h. This prevented common,
> target-agnostic code like the SMMU model from using these definitions
> without triggering "cpu.h included from common code" errors.
> 
> To resolve this, this commit introduces a new, lightweight header,
> include/hw/arm/arm-security.h, which is safe for inclusion by common
> code.
> 
> The following change was made:
> 
> - The ARMSecuritySpace enum and the arm_space_is_secure() and
> arm_secure_to_space() helpers have been moved from target/arm/cpu.h
> to the new hw/arm/arm-security.h header.
> 
> This refactoring decouples the security state definitions from the core
> CPU implementation, allowing common hardware models to correctly handle
> security states without pulling in heavyweight, target-specific headers.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01288.html
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/arm-security.h | 54 +++++++++++++++++++++++++++++++++++
>   target/arm/cpu.h              | 25 +---------------
>   2 files changed, 55 insertions(+), 24 deletions(-)
>   create mode 100644 include/hw/arm/arm-security.h
> 
> diff --git a/include/hw/arm/arm-security.h b/include/hw/arm/arm-security.h
> new file mode 100644
> index 00000000000..9664c0f95e9
> --- /dev/null
> +++ b/include/hw/arm/arm-security.h
> @@ -0,0 +1,54 @@
> +/*
> + * ARM security space helpers
> + *
> + * Provide ARMSecuritySpace and helpers for code that is not tied to CPU.
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */

Don't add the boilerplate to new files, just SPDX-License-Identifier.
This should have tripped a checkpatch error.

> +
> +#ifndef HW_ARM_ARM_SECURITY_H
> +#define HW_ARM_ARM_SECURITY_H
> +
> +#include <stdbool.h>

Already included by osdep.h.

> +#endif /* HW_ARM_ARM_SECURITY_H */
> +
> +

Watch the extra newlines.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

