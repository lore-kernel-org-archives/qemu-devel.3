Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8344ACFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 15:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNY3z-0006jC-64; Mon, 24 Nov 2025 10:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNY3y-0006iz-85
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 10:01:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNY3w-0001Ce-FZ
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 10:01:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477632d9326so26961205e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763996467; x=1764601267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEDDK6IXuw8hJEmM0iRHF5cbHpHneFq0dVKNU1MtQQI=;
 b=nyeYYSWzmMvYIOmKw46TcJe7GeH7zRqNQeD/yYVSLmkbMOCaOrdN7Hf+0DqP9qUmpW
 /0gGqE6Z+aQg8R8vCZvcPmc3rV5DQ8kGhutx4GdReph1rWrDH+hj7liQ4AqZdRJkRSsI
 cZeDYKi37GeAIqqf+ej+gbdZxweSxVlTNtzS3Wj4CfcI+eNOGRgML03fWqhtHIm+1HMn
 F2yvwtLv8QABC6ghWbiNw+7v8gGEndSsAYXChp7/MMyJngvpIg2JUW80jkNStWZb5f8k
 lY1IibDp3e5My01+u4bz8IzNu2zaXE/yqookqOfUTLXZevUCj80KlVsmEbUm2wXgZlqB
 8c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763996467; x=1764601267;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEDDK6IXuw8hJEmM0iRHF5cbHpHneFq0dVKNU1MtQQI=;
 b=QwuHyS7Suu9bZ0iJ/ZFk5paCR2Y1iJvFgGrua+W6yaMZQwA8A2699Akrcnx1CQovVj
 jkKfV+EjaQp5WVHLcBmWtJqq8lixmqn1b5xlfJYnzjvSQ6JqGlKFnYv/Qszx6aZRg/fa
 JaIxcs3yuOx2Xjtc3J+1rZWx5zyiD21+c1V3zcDD8XR4LCLQ05UbH9x5LkdFsDKjaphN
 wSACYpb81a0YZFpbGixPBj9rsAZKjcq1LqUylMlBwQkWjxvnGB4Dj9jZ9+SnL7+hI6GE
 9d1qaDiVr6+ooxvzhlIhrVxw97Bl8s3oTb2pBam4fNGUknIJgfwepa1yAZEXV9PkOBzp
 cusA==
X-Gm-Message-State: AOJu0YzJsIFPGmb6TUcvQhFOEDqQ6YM7ZovIdeUMFYT7VZ+fg0ZXPwWh
 ngHrjxA6XirCDD9Ak9I4yK0AxpB99+OGovmXX5luTcSQ5TKq9aZ+Gd0hQ+jvptEy7bv28kRcUti
 ZlDnI
X-Gm-Gg: ASbGncvc7+7L+EnbyZmMsztT+/tEOXUdPyTnKdmUgtVBn+qFmLGvrQuW6wXNmEzNy2r
 rCH2YR1WRFCzHz578s4PwHzIOxMHKB+FZXQ8gmbGL0D9T9dRftY9vxXv4PQMnhF6IfMYz9bPT35
 mkJ8z7CuzgU/jUhTOfzow6CqhaTWUTSUkcXTuJ0pArgV8UelbmcJmIvk4+aZLnLK7WyejYEF/47
 7dBmlSQwBLzLEdkfuysdvxHR/r5O+wVijYqbPoL9mYPN8Xn26D1uMIXmwnnAHrXKji/f9pKdC1W
 GEQ9OS7JNWQ0A7/PjPgqddjI9N2hC3BmINZM9Z3HRhx679R7fiAJ1Qb/w7PZAL22x68zpYDNds5
 BDuQn7QjyswH665PeKR5BRQP5oS5xj74YzDLT7ZI5mtaI1vCO12FqBwWo3FcxAnA665FefDOquz
 KUply0GedVyrQ=
X-Google-Smtp-Source: AGHT+IHMGxqCRMQ4qLE6l1mFcoyL2oYb+r2Wkpn7CewgjaLja7JZm+FogcjJZOdLZJ5DdBAQQLiDnQ==
X-Received: by 2002:a05:600c:474b:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-477c01ee377mr119128345e9.27.1763996464920; 
 Mon, 24 Nov 2025 07:01:04 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3af0ecsm202300355e9.9.2025.11.24.07.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:01:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C04A5F83A;
 Mon, 24 Nov 2025 15:01:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature
 bits
In-Reply-To: <20251120125833.123813-4-jim.macarthur@linaro.org> (Jim
 MacArthur's message of "Thu, 20 Nov 2025 12:54:16 +0000")
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-4-jim.macarthur@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 15:01:03 +0000
Message-ID: <87fra38ogg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Tests ASID2 is present and FNG1, FNG0, and A2 are writable, and read
> value shows the update.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  tests/tcg/aarch64/system/asid2.c | 53 ++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tests/tcg/aarch64/system/asid2.c
>
> diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/=
asid2.c
> new file mode 100644
> index 0000000000..cfe69db2ae
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/asid2.c
> @@ -0,0 +1,53 @@
> +/*
> + * ASID2 Feature presence and enabled TCR2_EL1 bits test
> + *
> + * Copyright (c) 2025 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdint.h>
> +#include <minilib.h>
> +
> +#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
> +#define TCR2_EL1 "S3_0_C2_C0_3"
> +
> +int main()
> +{
> +    /*
> +     * Test for presence of ASID2 and three feature bits enabled by it:
> +     * https://developer.arm.com/documentation/109697/2025_09/Feature-de=
scriptions/The-Armv9-5-architecture-extension
> +     * Bits added are FNG1, FNG0, and A2. These should be RES0 if A2 is
> +     * not enabled and read as the written value if A2 is enabled.
> +     */
> +
> +    uint64_t out;
> +    uint64_t idreg;
> +
> +    /* Mask is FNG1, FNG0, and A2 */
> +    const uint64_t feature_mask =3D (1ULL << 18 | 1ULL << 17 | 1ULL << 1=
6);
> +    const uint64_t in =3D feature_mask;
> +
> +    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
> +        : [x1] "=3Dr" (idreg));
> +    if ((idreg & 0xF00) !=3D 0) {
> +        /* ASID2 is enabled */
> +    } else {
> +        ml_printf("FAIL: ASID2 not present in ID_AA64MMFR4 (%lx)\n", idr=
eg);
> +        return 1;
> +    }

If we instead use this to test for the presence of the feature and then...

> +
> +    asm("msr " TCR2_EL1 ", %[x0]\n\t"
> +        "mrs %[x1], " TCR2_EL1 "\n\t"
> +        : [x1] "=3Dr" (out)
> +        : [x0] "r" (in));
> +
> +    if ((out & feature_mask) =3D=3D in) {
> +        ml_printf("OK\n");
> +        return 0;
> +    } else {
> +        ml_printf("FAIL: read value %lx !=3D written value %lx\n",
> +                  out & feature_mask, in);
> +        return 1;
> +    }

extend this part to check the bits are behaving as the feature dictates
then we can add a second test like this (Makefile.softmmu-target):

  run-asid2-oldcpu: asid2
          $(call run-test, $<, \
            $(QEMU) -monitor none -display none \
                    -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
                    $(QEMU_OPTS) $<)

  run-asid2-oldcpu: QEMU_OPTS=3D-M virt -cpu cortex-a72 -display none $(QEM=
U_BASE_ARGS) -kernel

  EXTRA_RUNS +=3D run-asid2-oldcpu

Although its a bit clunky - one day I'll get around to converting this
lot to meson.

> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

