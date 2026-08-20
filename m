Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A8C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4MJ-0002R6-Fc; Thu, 20 Aug 2026 11:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4MH-0002Ql-CK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:07:09 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx4MF-0000DM-PE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:07:09 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6b14a370dc5so857969eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787238426; x=1787843226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F0LkW4n6k6gFhdjph7Yimqrb83nBqdzl2uuNTxhvXCA=;
 b=dCNsWAuix+xr6ET2bnH/5245Rn25Ic6Y31ljetquEBFZrwcOSWQZRaPR58DVv9tSpQ
 UBg9tavD5UWjVnX1Bmvxwuqv5YBWDd/SRnsag9Q/v9wm8OrDRk1huhv5O24S1lleGI1P
 EDQMwVUzlsM/M1XLHtoeAtgtBaZMbuLj76Fvj2tlqQRaDno05egQk3VobX9nICZCft9w
 hpuVHOyLR7ihbCHzKYd4pg314JRsu2fUGgSD+vPZdvTffwRu9pdQioMOjL5c0R0rBlTN
 wJuxP1QNzSBJmKpmZmZ19WCwa5iwQj0Vx3IgkEHRwlSlE9RuWXTYBbJ+bBMLgdr/uDvt
 wKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787238426; x=1787843226;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0LkW4n6k6gFhdjph7Yimqrb83nBqdzl2uuNTxhvXCA=;
 b=LHLIV627wA39Baoc5NCXacux2Ic1hM+HLWhNvPWZv/2y2HEfUm531T/d3hH5qkuQCw
 I7UzqVf4N7ehW8xSC5igfcEpkJy+l3WnXKZm8r/QV9WlRTFq4VxKIyHzM2RQgOxrjwNk
 pf3/GdtF+/YPf4lLS5bdT222WDPOgen+p9vNFGn1dKauZ5503xVm92d6dMYm9/arwijD
 38mkJJUI4HG100yyRwBvpVQyq6IG4uXXgjzvJwhIGYbyjPqHDNfhIUhj8pGunk8SkuAm
 J+iNQ5NOPgzVoJ/JX/MI/N5xz1sZoIJnUl3fBZmsbgHeYmTjmxkg/OjyqqQhxDwzDqA6
 NT8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqO8E3n5HhOt6GeyDs51DjIbUd4K+L6blCCnhr5nhuCUtBiFM7mK/5SFkuZVs21m1KqhsysREEkQEq@nongnu.org
X-Gm-Message-State: AOJu0Yz69fMfHQliowYe38B5Plx8tT/k45pf0WcnF2/nWlM55C7SyvwC
 yukfzbdImcbMc+nmOb597PLIYzT/FIZBzrTGtjKsirNmCtvrQ3J3OxHpbDdp3dQOHTY=
X-Gm-Gg: AR+sD13b83EuIfBwbE2vpw7WI88bLxt1PK6UUqEFIgBXTnGRJvRv7XznxsDyYj4ixPq
 Z2yg9z2z4+1n/LpHsc7SUfCSUj3R8FaJSQMFytarl5dTbrw2NKXjT6AfiwaoSfwbVZ4EUkFoqs5
 V/WC3N0hZgGz9j5bFj9HP1uKL7X3TZ8uVm6lmyYcNYQ3spZxm6PzMzXEFoFPWXhZQHbCJdwOEuW
 +QTCXZHFGsVUmWzeuERx9VHTR/3wxB9GRIgnRNpUaOtGkXrN40w5RWZUftv4TY/PFgOzBe8mt3o
 4CR/pGhc/LnSGxJHgVPHOK4uyTmKFoxlNS2zoJPJsKwuoqQT66HJd0MdHKYhncoTgo+BurRLf1p
 jU+xAAYM7m4Kgm+hq85oG9sAeAPojpUnnWtg96KtmC29WeOAeI3yUNIJcpCePd5EEAuO1GXlcZ7
 cXvH4jSljwhqeNQrWaTzarOQukkNj8aZQrcENg29c64vqOCpLSql0jF20WQtPwCajKQzSc5Q+MP
 A6E759na6yY5RbHKuhI4cKlFagibPzglj25uy1bGDjHpRBCYpqKAoWDoD3k
X-Received: by 2002:a05:6820:c2ce:20b0:6ae:4403:1c13 with SMTP id
 006d021491bc7-6b149278f88mr4698536eaf.18.1787238426135; 
 Thu, 20 Aug 2026 08:07:06 -0700 (PDT)
Received: from ?IPV6:2607:fb90:331d:db6f:e6eb:39ca:2251:a26f?
 ([2607:fb90:331d:db6f:e6eb:39ca:2251:a26f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb557c1sm5623414eaf.2.2026.08.20.08.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 08:07:05 -0700 (PDT)
Message-ID: <5f31ce64-1ee6-4b2b-bac5-0f3607f32bad@linaro.org>
Date: Thu, 20 Aug 2026 08:07:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/tcg/riscv64: Add vector load and store tests
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260820130223.2762-1-joel@jms.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820130223.2762-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 8/20/26 06:02, Joel Stanley wrote:
> Hi Richard, I was testing your riscv vector load/store series and
> noticed there were some regressions with page crossing loads and stores.
> We don't have any tests for that in the tree, so I wrote some.
> 
> The tests trigger assertions in linux-user for me:
> 
>    $ make -C build/tests/tcg/riscv64-linux-user run-test-rvv-ldst
>    make: Entering directory 'build/tests/tcg/riscv64-linux-user'
>      TEST    test-rvv-ldst on riscv64
>    **
>    ERROR:../accel/tcg/user-exec.c:810:probe_access: assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)
>    timeout: the monitored command dumped core
>    Aborted
>    make: *** [Makefile:223: run-test-rvv-ldst] Error 134
>    make: Leaving directory 'build/tests/tcg/riscv64-linux-user'
> 
> I wrote the assembly one first before realising a C version would be
> easy enough to do too. I'm not sure about using memcmp to check (in case
> it's vectorised) so perhaps that's where the asm wins. I can tidy them
> up and send the preferred version if we decide to put it in the tree.

Thanks!  I'll take a look at these failures.


r~

