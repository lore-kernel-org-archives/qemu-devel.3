Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CACA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVCn-0001et-NC; Mon, 25 Aug 2025 07:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqVC2-0000T1-F1
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:16:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqVBt-0003ot-4z
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:16:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so25514115e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756120601; x=1756725401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzZrCAQ1CklasD9rsjQqAqU3awwYN4QZSv30XQ4x1UY=;
 b=HsO14OFDMnXooihVYRpdFlqy5NmOAj8IGELBWuZa7sVrFNvi0KOOILpTpR4RXQxNA0
 6tGtrSP+qqSEy8Jl84N7jhVPLjL0z3yTTWnYJLtgHXvpek+F+5fmEKDHynbhRTtfBCOh
 bQpi/9yd1ZCW6Ae6QNSDSsStt8JCf2RidLwTVUOp5EH/Gl2fqaChgVTrq69gJi5Fg2D4
 Y2P9Xt/uf9V2jD+D4mycqSArUsEAxPUD5jfftd/U1RDBPfGfh+MjJgyT0Mxzb0nzSZAW
 6Kzdsr4pP9WYnFgyTT+UyhDdZZWE5wRJEOxxClXLsKFYgnov/8SCLKJOeU6ONGnj5M4Z
 Qfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756120601; x=1756725401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzZrCAQ1CklasD9rsjQqAqU3awwYN4QZSv30XQ4x1UY=;
 b=f6aNvPNshx5hoRNrsPF2qzMUVi1dS2vYnGnSFQ3fyqNdYSjMOtuoq7rUYwlrzS9C2p
 AlakKPIKlB2m4jM4Z26gwv33xLoc4PytTngRXUd1ZM0bJRjmDnfwYTXYMv4NIxVF5+xN
 tXgp9/p28UL6HvcN9WH/gLDGm9pok5AZM4r7QcQ0HGtg0VzTlQyDeugedQkAIYJd2B8/
 4BEJzulTZxmqGwI3F5svUUpYS/A73f5341WLvwuUIhb53PloUYl9kI2C1hPcCnTggzg5
 VbdeiSfrpOP+gBj1ju9XlSP1bDhAA9wH8gGJpAauelUz5fsD4hcZIanxHw6oESosd2R6
 D4+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9HQyCr55VtFi3mIBQTg9TMYfBWjuFtivmzooehG2PBKJRiZi54YZE8OkKfWddrfz7URpc/TfoSjSc@nongnu.org
X-Gm-Message-State: AOJu0YxNTitqoESoe3YdLMWNkuU6obGBleA56+6VX1/Vif5xvj1AEbPu
 3eT+UDZj5CxKKekxw1uftNI19XWIFutZeSJr2fGmJVDHymkekPHQ2M3zyNrThLmWpFQ=
X-Gm-Gg: ASbGncs7UpXLc5YW561y2jiG1B90/DOOAsw5CAjQHoz0dBO232tqROrSb/mQzNU6xus
 zRroQHWEk0foVm+ZlKUA2GF9HwHpHOA5YvuNN2s2OqwEzu4w6F1FiXqqa8dN+y3VbFo/R5vqrbf
 YvzaJOPj0Zk3Op83xNSF2YC6J+qDBMGy2i7iCHfKcZ+GDP5qW0zEy2ya3F5RLKlognbwUUX0kPn
 bqGMmZpS9/AJ1AU4RU5R+VIgyPzCoCBmNYDRMABydJZFIwhLoobt22ls9pOuZSEVAE0i0xnzgaw
 /9+ltEurQFSBTykwJPuv5OLAoaiL7FoiNZbofGq0rWzW2tstw5k14euYVUbr5qLCSn1V/8crEpX
 GM+QiShsvxQBerpH9pmMzLy/ILMg4XUER1xNLDTrKoVEdqJfY0+kuPH2uFuTHrP+c6g==
X-Google-Smtp-Source: AGHT+IF3ehKOKE3RkQilSCjSofFJwxU/NVNShvqtzx6GdoGdVvu6YVl0U7nIk45xli5HvohRaZUrVQ==
X-Received: by 2002:a05:600c:3149:b0:45b:47e1:ef79 with SMTP id
 5b1f17b1804b1-45b517ddbedmr93577415e9.36.1756120600581; 
 Mon, 25 Aug 2025 04:16:40 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57499143sm103926495e9.26.2025.08.25.04.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 04:16:40 -0700 (PDT)
Message-ID: <e755b413-b983-4c98-bda8-e0c7ec6e29b5@linaro.org>
Date: Mon, 25 Aug 2025 13:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 9/9] tests/qtest: add test for memory region access
To: CJ Chen <cjchen@igel.co.jp>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-10-cjchen@igel.co.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822092410.25833-10-cjchen@igel.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 22/8/25 11:24, CJ Chen wrote:
> From: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> 
> This commit adds a qtest for accessing various memory regions. The
> qtest checks the correctness of handling the access to memory regions
> by using 'memaccess-testdev'.
> 
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Co-developed-by: CJ Chen <cjchen@igel.co.jp>
> Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> ---
>   tests/qtest/memaccess-test.c | 597 +++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build      |   9 +
>   2 files changed, 606 insertions(+)
>   create mode 100644 tests/qtest/memaccess-test.c
> 
> diff --git a/tests/qtest/memaccess-test.c b/tests/qtest/memaccess-test.c
> new file mode 100644
> index 0000000000..7e90028ea0
> --- /dev/null
> +++ b/tests/qtest/memaccess-test.c
> @@ -0,0 +1,597 @@
> +/*
> + * QEMU memory region access test
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Author: Tomoyuki HIROSE <hrstmyk811m@gmail.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#include "hw/misc/memaccess-testdev.h"
> +
> +static const char *arch = "";
> +static const hwaddr base = 0x200000000;
> +
> +struct arch2cpu {
> +    const char *arch;
> +    const char *cpu_model;
> +};
> +
> +static struct arch2cpu cpus_map[] = {
> +    /* tested targets list */
> +    { "arm", "cortex-a15" },
> +    { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
> +    { "x86_64", "qemu64,apic-id=0" },
> +    { "i386", "qemu32,apic-id=0" },
> +    { "alpha", "ev67" },
> +    { "cris", "crisv32" },
> +    { "m68k", "m5206" },
> +    { "microblaze", "any" },
> +    { "microblazeel", "any" },
> +    { "mips", "4Kc" },
> +    { "mipsel", "I7200" },
> +    { "mips64", "20Kc" },
> +    { "mips64el", "I6500" },
> +    { "or1k", "or1200" },
> +    { "ppc", "604" },
> +    { "ppc64", "power8e_v2.1" },
> +    { "s390x", "qemu" },
> +    { "sh4", "sh7750r" },
> +    { "sh4eb", "sh7751r" },
> +    { "sparc", "LEON2" },
> +    { "sparc64", "Fujitsu Sparc64" },
> +    { "tricore", "tc1796" },
> +    { "xtensa", "dc233c" },
> +    { "xtensaeb", "fsf" },
> +    { "hppa", "hppa" },
> +    { "riscv64", "rv64" },
> +    { "riscv32", "rv32" },
> +    { "rx", "rx62n" },
> +    { "loongarch64", "la464" },

IIUC CPUs are not involved in the test path. The only difference
is the binary endianness. So we are testing 2 distinct code path
duplicated as ARRAY_SIZE(cpus_map) = 31 times.

Let's run the tests with a pair of common targets and save 29
pointless tests:

... cpus_map[] = {
       /* One little endian and one big endian target */
       { "x86_64", "qemu64,apic-id=0" },
       { "s390x", "qemu" }
}

> +};
> +
> +static const char *get_cpu_model_by_arch(const char *arch)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(cpus_map); i++) {
> +        if (!strcmp(arch, cpus_map[i].arch)) {
> +            return cpus_map[i].cpu_model;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static QTestState *create_memaccess_qtest(void)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_initf("-machine none -cpu \"%s\" "
> +                      "-device memaccess-testdev,address=0x%" PRIx64,
> +                      get_cpu_model_by_arch(arch), base);
> +    return qts;
> +}


> +DEFINE_test_memaccess(little, LITTLE, b, B, valid, VALID)
> +DEFINE_test_memaccess(little, LITTLE, w, W, valid, VALID)
> +DEFINE_test_memaccess(little, LITTLE, l, L, valid, VALID)
> +DEFINE_test_memaccess(little, LITTLE, q, Q, valid, VALID)
> +DEFINE_test_memaccess(little, LITTLE, b, B, invalid, INVALID)
> +DEFINE_test_memaccess(little, LITTLE, w, W, invalid, INVALID)
> +DEFINE_test_memaccess(little, LITTLE, l, L, invalid, INVALID)
> +DEFINE_test_memaccess(little, LITTLE, q, Q, invalid, INVALID)
> +DEFINE_test_memaccess(big, BIG, b, B, valid, VALID)
> +DEFINE_test_memaccess(big, BIG, w, W, valid, VALID)
> +DEFINE_test_memaccess(big, BIG, l, L, valid, VALID)
> +DEFINE_test_memaccess(big, BIG, q, Q, valid, VALID)
> +DEFINE_test_memaccess(big, BIG, b, B, invalid, INVALID)
> +DEFINE_test_memaccess(big, BIG, w, W, invalid, INVALID)
> +DEFINE_test_memaccess(big, BIG, l, L, invalid, INVALID)
> +DEFINE_test_memaccess(big, BIG, q, Q, invalid, INVALID)
> +
> +#undef DEFINE_test_memaccess
> +
> +static struct {
> +    const char *name;
> +    void (*test)(void);
> +} tests[] = {
> +    {"little_b_valid", test_memaccess_little_b_valid},
> +    {"little_w_valid", test_memaccess_little_w_valid},
> +    {"little_l_valid", test_memaccess_little_l_valid},
> +    {"little_q_valid", test_memaccess_little_q_valid},
> +    {"little_b_invalid", test_memaccess_little_b_invalid},
> +    {"little_w_invalid", test_memaccess_little_w_invalid},
> +    {"little_l_invalid", test_memaccess_little_l_invalid},
> +    {"little_q_invalid", test_memaccess_little_q_invalid},
> +    {"big_b_valid", test_memaccess_big_b_valid},
> +    {"big_w_valid", test_memaccess_big_w_valid},
> +    {"big_l_valid", test_memaccess_big_l_valid},
> +    {"big_q_valid", test_memaccess_big_q_valid},
> +    {"big_b_invalid", test_memaccess_big_b_invalid},
> +    {"big_w_invalid", test_memaccess_big_w_invalid},
> +    {"big_l_invalid", test_memaccess_big_l_invalid},
> +    {"big_q_invalid", test_memaccess_big_q_invalid},
> +};
BTW this reminds me of 
https://lore.kernel.org/qemu-devel/20200817161853.593247-8-f4bug@amsat.org/ 
;)

