Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663B6CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQROd-00028j-GN; Tue, 02 Dec 2025 09:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQROW-00028B-3Y
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:30:25 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQROT-0006uL-SE
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:30:19 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c75fd8067fso3254385a34.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764685816; x=1765290616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4PqquLXdo3jufqbkyPueSgqD6EFznbidNRyyubl3yWY=;
 b=RXHbkVX9Sy+ulePnFbLi2iMlanqBswJ0pStsO7uxqSwcCsZK4rTs74rTdU7z4Bmacb
 OEwfTgpCUndN4jZQCLrr7O0EsgHdZ7P+yIHfmwL0w7vHEewaAZn3kCHrNRi4DTKXHzko
 MFXN/QM/aLfDGCFjX83Ek/JUPZOGiv4epQx+icJBtp97pD5djb+ITu/Rw1gGutmIXE/E
 ugjQ1e7xIRoyz6LF+ZKNVIUH3H40t3ptG/2hYBD/BCZHFupO1WR9yf86IARCl8xzwip9
 bLQnlm+LOgsPspnqjtvcwmsEgeT8td9oIW2SqsEFzNRZOwAQHOoCKMe2jt+95lkh4E9u
 GLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764685816; x=1765290616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4PqquLXdo3jufqbkyPueSgqD6EFznbidNRyyubl3yWY=;
 b=vAwez0XQueOEiNwLTEa/r6VonbDUcENaGHy6S0xGLB5t+EtQJfJX/0JkG3IlOLwCdb
 J+iM9mYNQohGn4wrrMzrPZGx7i/Fyo9JGkr9giHHaWIggi8SBOj4q1Pc2mhSt+NcmWBU
 QQ/Y2RNro6Zyhgf8RFq6LA8db5Nyxfv+Lhp9qT2VWDMKUnCwUA3JT9gMmcsouBFVij9D
 HseHRlThzG+eO+P7eAp2lz3RDtWcZCwLbuYbpmNFyfZNGwpkVeVuCsxOdZf+1kS8vlBy
 Thl4zvhIJqiJwkHlUDPgcS6uxqKY7slAX9Eq+KeS+wSuUGZv2+LHRpnfB2MZNBJpoykI
 fyIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFrr+WlgSJqGOxt92gIuF8/vl8hN/Z/TAuLICgh17mTLckkAu3YoghMC4AgLP4KBoL9KcuOqWUfmIN@nongnu.org
X-Gm-Message-State: AOJu0YzfCFR5P2TuC5YZnIistYroK6bsDxz0hD8V6+TYlrflSJwgl5rp
 xEQg7YrfTkZD7y87fh6KZLfBO2uHRLvydHg0w9yf1aifBVKdB066zWWJYj5ZWUGa0iE=
X-Gm-Gg: ASbGncvoMUo468MYTVcL5fsSi+Ni2en/lc4XOxRoVdlw9HFz5VX+RhX19uoYm/2utEI
 /53CzPvpViKadxJmdiNdK20kxTQ9ZaG+lXJHt2axvpOSAQKcBl5gNCwseBz81B5QCz+NXVxxLm4
 3IRZyNDguo0byvzSbBNyZFMcgih4dBWv5tiryozwTK/JrsurFjM2nG4sK2Vy8CuKTeWxi2IQRbj
 wLF2GnIB8wC+eU+w+Rvoqm0J3l4gVHDSsCxy2guoPo6DunZitMkQ6bz9OyI5olwbaNaMU6RK7Bq
 ZTejXdCykjAssh54e37BlIaWP+Tcltg8F8dqKeI4bvuERtjhKX5141IHDAAETvnWDyfdGMJxHXF
 x6cdiBI7ZBzc7+nU86OnCfGuY3WOEVeHMlHItYLOO3XuCu+gIL1k4R+RhOJDfluF9VRF5joqIDn
 A0YENbV3fq+cFAhVx7DKDJCg==
X-Google-Smtp-Source: AGHT+IEL7I9/hT+0N0PPFBFqS2SoxFCcApjlEuoXHEocjmd5S8qoS/qx1EJamH6qwjoRebu7QeMzNw==
X-Received: by 2002:a05:6830:6a12:b0:799:bdea:34ba with SMTP id
 46e09a7af769-7c7c4301917mr15661049a34.9.1764685815592; 
 Tue, 02 Dec 2025 06:30:15 -0800 (PST)
Received: from [192.168.0.102] ([177.139.2.175])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f49esm6561255a34.22.2025.12.02.06.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:30:15 -0800 (PST)
Message-ID: <6e513a88-eb63-4b83-9298-417e41f788ed@linaro.org>
Date: Tue, 2 Dec 2025 11:30:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] tests: Add test for ASID2 and write/read of
 feature bits
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
 <20251202120250.763150-5-jim.macarthur@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251202120250.763150-5-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x32a.google.com
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

Hi Jim,

On 12/2/25 09:00, Jim MacArthur wrote:
> Test for presence of ASID2; if it is, check FNG1, FNG0, and A2 are
> writable, and read value shows the update. If not present, check these
> read as RES0.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   tests/tcg/aarch64/system/asid2.c | 75 ++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 tests/tcg/aarch64/system/asid2.c
> 
> diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
> new file mode 100644
> index 0000000000..a4887e4ce2
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/asid2.c
> @@ -0,0 +1,75 @@
> +/*
> + * ASID2 Feature presence and enabled TCR2_EL1 bits test
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later

The SPDX tag must go in the first line, except in script sources, where it goes
after the shebang line.


+ */
> +
> +#include <stdint.h>
> +#include <minilib.h>
> +
> +#define ID_AA64MMFR3_EL1 "S3_0_C0_C7_3"
> +#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
> +#define TCR2_EL1 "S3_0_C2_C0_3"
> +
> +int main()
> +{
> +    /*
> +     * Test for presence of ASID2 and three feature bits enabled by it:
> +     * https://developer.arm.com/documentation/109697/2025_09/Feature-descriptions/The-Armv9-5-architecture-extension
> +     * Bits added are FNG1, FNG0, and A2. These should be RES0 if A2 is
> +     * not enabled and read as the written value if A2 is enabled.
> +     */
> +
> +    uint64_t out;
> +    uint64_t idreg3;
> +    uint64_t idreg4;
> +    int tcr2_present;
> +    int asid2_present;
> +
> +    /* Mask is FNG1, FNG0, and A2 */
> +    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
> +    const uint64_t in = feature_mask;
> +
> +    asm("mrs %[x1], " ID_AA64MMFR3_EL1 "\n\t"
> +        : [x1] "=r" (idreg3));

You can use the same name for the asm label as the one used for the C variable to
ease even further reading the code, so it's ok to do:

asm("mrs %[idreg3], " ID_AA64MMFR3_EL1 "\n\t"
      : [idreg3] "=r" (idreg3));


Likewise for all the other uses of asm() below.

Otherwise the test LGTM.


Cheers,
Gustavo

> +    tcr2_present = ((idreg3 & 0xF) != 0);
> +
> +    if (!tcr2_present) {
> +        ml_printf("TCR2 is not present, cannot perform test");
> +        return 0;
> +    }
> +
> +    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
> +        : [x1] "=r" (idreg4));
> +
> +    asid2_present = ((idreg4 & 0xF00) != 0);
> +
> +    asm("msr " TCR2_EL1 ", %[x0]\n\t"
> +        "mrs %[x1], " TCR2_EL1 "\n\t"
> +        : [x1] "=r" (out)
> +        : [x0] "r" (in));
> +
> +    if (asid2_present) {
> +        if ((out & feature_mask) == in) {
> +            ml_printf("OK\n");
> +            return 0;
> +        } else {
> +            ml_printf("FAIL: ASID2 present, but read value %lx != "
> +                      "written value %lx\n",
> +                      out & feature_mask, in);
> +            return 1;
> +        }
> +    } else {
> +        if (out == 0) {
> +            ml_printf("TCR2_EL1 reads as RES0 as expected\n");
> +            return 0;
> +        } else {
> +            ml_printf("FAIL: ASID2, missing but read value %lx != 0\n",
> +                      out & feature_mask, in);
> +            return 1;
> +        }
> +    }
> +}


