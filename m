Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43467D15DAD
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqLb-0006mL-PG; Wed, 03 Dec 2025 12:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vQqLY-0006lD-Ii
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:08:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vQqLW-0007yW-Bv
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:08:56 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29845b06dd2so91837365ad.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764781731; x=1765386531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9g75o2MijnoK/m+lbeCPIq1Z7EdTggnypkg6g60zds=;
 b=ciuWDUxgRad+tH1kf6PiDyoaMb95LzCknNBJbYt8HWRGb6J/OS2tkuBru32fKYnrW5
 YRKsjH23MLi5EoIwTVoju017UAQXNMWH5YKGE4WnY5aOaaWi6ZHZhXOlYmaIjRgmIiVR
 odr/Uv51K5tbytXYqtfkJI8QA6gbXrTMrbxIsgcUEqd49vmfVkVs8LKsR1C1psq+px7t
 89OTE0qglugdxFSytAephACi5cbp+W7N/oBHNMeVgxZJC3HgDElUTVgDjgc2WvqV4fFT
 bLliZNi0ZVnf8LkS0UK1Z3BCKzMoDyXjCDIX2h6cTI6IMr6scVjInGVMa23ytUGXsvfT
 M5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764781731; x=1765386531;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9g75o2MijnoK/m+lbeCPIq1Z7EdTggnypkg6g60zds=;
 b=hyXe2GDG07z0X9z/Yaa5Iw9/tMo/F24Hi87QdX3q2hAFWv3ZN6//ttvB2EIJoFNdRl
 iNauJSJVp3rBXgMN2MKDkAUcYaBqdxvz72viikhlS0s++szP5Pbu5fAJbf6WoRg4GRfA
 dsGvj7FbBYLzj6BPkmRto5ZMvkuxNC26C0gX5k4zGgirOlDRtxqcxKXJ52qlN95eRt8X
 4FuiN9PNyy9/7pfpOMn9zYMmKxq/9uUYTJ8seNpnYF+shYcOdbaLBctvVIF7iTIWMBzo
 TG2F1I0WcMJ03tUWRguMzWJCHivz77swEak9y57lYHVNAgCjbIgRtU9GfvAryrY6PUNf
 t0Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXqM9Zd3z09iHCec5yVPPvEKXSi2NsUzqxugfs38Zqj7TaxUP00hjY02YaeMMce8cseSBbWmVWCVrY@nongnu.org
X-Gm-Message-State: AOJu0YwTTnB9TmuHnaFc1NYuaUSn/wjhn6PHxVX34dr1lrQHJnbMsMnF
 5sRqO0FWkUEmMZdn2d2ePQ2x7veOrHE7c49APMKSaQEhzio+LRvqz+/6t9aq/SE4q+E=
X-Gm-Gg: ASbGncuddoAc7xc7ssxTPyiBciKRL2OlafvbYr/TjihBddT++02PMZnbu67VGim3WCd
 qM6a+ZM/aJDhY2HPnFSYHkBiOczvARApnlOG0Ow16RR92BqsyQlkQ7JtO7PYqfkZwWFCjTeBsaF
 SY7zhQ8IvqK0pn3o4cJ4x2z3BUo11e9yI8JYd+/xvHxdjIW6DvgJOVTR/7NAFMjPsGlqp/CENhX
 NNQWtWoAmcZwFStqnGHN4+WDtXSSVmo3dytHWu3hX6U/92DApUXRJDIpVUE/1RlUR6yTAZtTk/b
 L4qoXMbBzz7Y8gMu3srjN7Wo+HF+woFx2zLrW6K2rT3flDfMYKrQIVqGcDja/O+hplKD5MHFBEC
 235sra8Kj3SbD4zePb/SDGzZU8x7ehF/oF98Y0NbLEEgxsfo7HrZ/prPzDAZuVLtAF2jbZryM0L
 DFhWxiv5SrPz/Qb3L+8OfKN17HjiQ=
X-Google-Smtp-Source: AGHT+IG1hDFDsZ6pTfEYc1eZePxElDPpb/omp/KJGdXaGGcF+evVKRnLH0cCvJ+BqI8Xw0X6IzMhjw==
X-Received: by 2002:a17:903:1aa5:b0:297:d741:d28a with SMTP id
 d9443c01a7336-29d684017bfmr34851955ad.31.1764781726762; 
 Wed, 03 Dec 2025 09:08:46 -0800 (PST)
Received: from [192.168.68.110] ([189.110.107.217])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bceb4026bsm191965395ad.71.2025.12.03.09.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:08:46 -0800 (PST)
Message-ID: <1c4ce7f9-1599-4b64-a9e1-153d1c17784c@ventanamicro.com>
Date: Wed, 3 Dec 2025 14:08:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] tests/qtest: add test for K230 watchdog
To: Chao Liu <chao.liu@zevorn.cn>, richard.henderson@linaro.org,
 paolo.savini@embecosm.com, npiggin@gmail.com, ebiggers@kernel.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, chao.liu@openatom.club,
 hust-os-kernel-patches@googlegroups.com, Mig Yang <temashking@foxmail.com>
References: <cover.1764493931.git.chao.liu@zevorn.cn>
 <1825d13812716393767703063b16d2bf862af047.1764493931.git.chao.liu@zevorn.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <1825d13812716393767703063b16d2bf862af047.1764493931.git.chao.liu@zevorn.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 11/30/25 6:21 AM, Chao Liu wrote:
> Testing the Basic Functions of K230 WDT:
> 1. Reset Function
> 2. Timeout Check
> 3. Interrupt Function
> 
> Signed-off-by: Mig Yang <temashking@foxmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   MAINTAINERS                 |   1 +
>   tests/qtest/k230-wdt-test.c | 199 ++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |   3 +-
>   3 files changed, 202 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-wdt-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 564c2af56d..bfa63f832e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1718,6 +1718,7 @@ F: hw/riscv/k230.c
>   F: hw/watchdog/k230_wdt.c
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
> +F: tests/qtest/k230-wdt-test.c
>   
>   RX Machines
>   -----------
> diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
> new file mode 100644
> index 0000000000..2550cebd10
> --- /dev/null
> +++ b/tests/qtest/k230-wdt-test.c
> @@ -0,0 +1,199 @@
> +/*
> + * QTest testcase for K230 Watchdog
> + *
> + * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the kendryte K230 SDK
> + *
> + * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "qemu/bitops.h"
> +#include "libqtest.h"
> +#include "hw/watchdog/k230_wdt.h"
> +
> +/* K230 WDT0 base address */
> +#define K230_WDT0_BASE 0x91106000
> +#define K230_WDT1_BASE 0x91106800
> +
> +/* Test WDT0 by default */
> +#define WDT_BASE K230_WDT0_BASE
> +
> +static void test_register_read_write(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test Control Register (CR) read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_CR), ==,
> +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +
> +    /* Test Timeout Range Register (TORR) read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_TORR), ==,
> +                    K230_WDT_TORR_TOP_MASK);
> +
> +    /* Test Protection Level Register read/write */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_PROT_LEVEL, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_PROT_LEVEL), ==, 0x7);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_counter_restart(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Enable watchdog and set timeout */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x5); /* TOP = 5 */
> +
> +    /* Read current counter value */
> +    uint32_t initial_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +    g_assert_cmpuint(initial_count, >, 0);
> +
> +    /* Restart counter with magic value */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
> +
> +    /* Wait for time */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> +
> +    /* Counter should be reset to timeout value */
> +    uint32_t new_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +    g_assert_cmpuint(new_count, >, 0);
> +    g_assert_cmpuint(new_count, !=, initial_count);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_interrupt_mode(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
> +
> +    /* Set interrupt mode and enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR,
> +                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> +
> +    /* Wait for timeout to trigger interrupt */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
> +
> +    /* Check interrupt status */
> +    uint32_t stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
> +
> +    /* Clear interrupt */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_EOI, 0x1);
> +    stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_reset_mode(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230 -no-reboot");
> +
> +    /* Set reset mode and enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> +
> +    /* Wait for timeout to trigger reset */
> +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> +
> +    /* In reset mode, the system should reset */
> +    /* This test verifies that reset mode is properly configured */
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_timeout_calculation(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test different timeout values */
> +    for (uint32_t top = 0; top <= 15; top++) {
> +        qtest_writel(qts, WDT_BASE + K230_WDT_TORR, top);
> +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +
> +        /* Read current counter value */
> +        uint32_t count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> +        g_assert_cmpuint(count, >, 0);
> +
> +        /* Disable watchdog for next iteration */
> +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_wdt1_registers(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Test WDT1 registers (second watchdog) */
> +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_CR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_CR), ==,
> +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> +
> +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_TORR), ==,
> +                    K230_WDT_TORR_TOP_MASK);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_enable_disable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    /* Initially disabled */
> +    uint32_t cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> +
> +    /* Enable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, K230_WDT_CR_WDT_EN);
> +
> +    /* Disable watchdog */
> +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-wdt/register_read_write", test_register_read_write);
> +    qtest_add_func("/k230-wdt/counter_restart", test_counter_restart);
> +    qtest_add_func("/k230-wdt/interrupt_mode", test_interrupt_mode);
> +    qtest_add_func("/k230-wdt/reset_mode", test_reset_mode);
> +    qtest_add_func("/k230-wdt/timeout_calculation", test_timeout_calculation);
> +    qtest_add_func("/k230-wdt/wdt1_registers", test_wdt1_registers);
> +    qtest_add_func("/k230-wdt/enable_disable", test_enable_disable);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..0d9339e938 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -282,7 +282,8 @@ qtests_riscv32 = \
>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>   
>   qtests_riscv64 = ['riscv-csr-test'] + \
> -  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
>   
>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(


