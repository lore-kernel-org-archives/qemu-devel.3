Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD7CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 05:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXuZ3-0008E0-0m; Fri, 12 Jun 2026 01:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wXuZ1-0008Dd-2L
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:36:19 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wXuYy-0001sK-Du
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 01:36:18 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-307263ad0cbso989682eec.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781242574; x=1781847374; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1lksxLlJXxD4Ja1JGJLQOQpQFhJ/myfx88cj4NaMbUM=;
 b=bO8I0IjYl0/FXfTnjR5GBeE5R8MtX8mjiLBRTldMvCvJPlKqk0PI7jgBTfaxEKzusv
 hKuty0ddcrKp8PjrdwdmJ2dhWC/V09XuZ7dvH+qau7SEYT6RAdgb3SX4Ku4AhRFRcv1y
 FeJWwuZGaSj1sB0c6Ioxg/lvhbiN4xSMrU5dawUuZJ61RjKXwXoGKHb2QqouV7ub8gYY
 ewMT3R4Kt0i0T3VVUZITuh43ZbPmJAWulBxCWUqzVcgfVxXs+RBXzp5U5MkprrvX26Fz
 dQ7uy2DRz6rgnHAj78qw8j9wn0oFmOfUpa+4ZJ7jmMEZg0DijR4qU1RtS+3P4Br+e4z9
 kPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781242574; x=1781847374;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lksxLlJXxD4Ja1JGJLQOQpQFhJ/myfx88cj4NaMbUM=;
 b=BOC+hN5go20s5Qz+2izre+FsxOyZNBa+gOTXU3gIQiN9tu8OxdYTiOyCnXpdmLI18x
 zwR87kQO6knl01EpCxeIwD/p0ijAERg5/AjUdbw+6u+vedPP4DXJKKVbpvQjG/s2Zo0s
 lk5N05o/75IbtRDLO8kaUXJZvAzNL1oI0Bw5bfLI7wM/t0IevEwErN8qwNFClUkADLPU
 UMS2tjOvttifB0oQqYrV3mcV6z50efyjkvEeo1DoasizvbCmdh5OanitpyqX6aDjLwQm
 I8TetlswqCYm02nqSUsdr3a9vc4kyrWl3rjlfjhS1zgeM4FEuTQqh1O9OR5QtCu92GQP
 JHpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ++mS1MKOKDnGgGaAkEMotIWudHZfIB3evTKgnVv45N2G5cW3byohrOZTguhG4SyHk6tEj4EV3ptVtz@nongnu.org
X-Gm-Message-State: AOJu0YxAiTmsKk6CAEG7CC6G0SoejI+dvZXAPjvUpIVHM/Q/VSJvLIVp
 YbtxZeyMfHfe4P4tAjJ+4Sitc6h7XmA6H+WRk96v6GX4pukW1IRaOfFc
X-Gm-Gg: Acq92OGaVr54KcGorXRVOZtw1fyPfHUlk2yyVmOrT6v9TFArBw+8ckbHW+lw6bKXPs2
 b9Z+LlJ1C6Cic9MTuM1LtduAoOIDfvLJNjXjv2zP7GFT8RUVxuQuQWglyQB3apj0UO09hOFC9eY
 h/8CDi/FnXuK1ZC26nSf5PBXFLYMIcbLFZGpxnVrVuy3gsu0E61tAn9VX059jYaoV0E/7a9NLC9
 zpPJK5aa0PZvqR3HWNe0tIc/wSSmyhBwVrZ5TGXxtYpEjX2RcTyARC9/8/cQrtacO4f646QoNIB
 LG3aRmcVYvE3u/knTTdNi8VT0ChVSrLpaGau1PRZmzdZYm0AHNZUoVeTiEVtCUer4EfJKXwHpl4
 1k5zgDi5UBcCnwriCYNJn7Cs5kl/dKGW+JCLJyMKWcBr1VafMXfxUDrXA3yPn4fTL9qIRNBGTb/
 jU1TKErxSD/NsrGuQYfgjJsbC4ZC7t75ohF9qaRJVULkdpSMFIVGGhwoFWyQA=
X-Received: by 2002:a05:7300:8cab:b0:304:ab8:f87c with SMTP id
 5a478bee46e88-3081ff7c07fmr856959eec.12.1781242574334; 
 Thu, 11 Jun 2026 22:36:14 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ddaf69asm2086363eec.0.2026.06.11.22.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 22:36:13 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:36:11 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@zevorn.cn>, Mig Yang <temashking@foxmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v7 4/5] tests/qtest: add test for K230 watchdog
Message-ID: <aiuYsOG0QFkMc4eO@ChaodeMacBook-Pro.local>
References: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
 <69be8c8a8b47f4b6283a4a89850fff8cde300137.1778516731.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKOF8KpDTtmtHpJvQ-uu6trSQZ3=NNs-R3AkW3RUMLP98g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOF8KpDTtmtHpJvQ-uu6trSQZ3=NNs-R3AkW3RUMLP98g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jun 12, 2026 at 12:37:03PM +0800, Alistair Francis wrote:
> On Tue, May 12, 2026 at 2:33 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > From: Chao Liu <chao.liu@zevorn.cn>
> >
> > Testing the Basic Functions of K230 WDT:
> > 1. Reset Function
> > 2. Timeout Check
> > 3. Interrupt Function
> >
> > Signed-off-by: Mig Yang <temashking@foxmail.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Acked-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> This fails `make check` for me. I guess the `k230` machine wasn't built?
>
I've tested the case on my local machine and it's running fine.

However, since the patch set is already a month old, maybe need rebase
next branch.

And I found an issue in the first patch while looking through the Milk-V
Duo patches.

https://lore.kernel.org/qemu-devel/agZFchak-jsc2moK@ZEVORN-PC.localdomain/

I'll fix it and send out a V8 version shortly. You can test it again
once that's out.

Thanks,
Chao
> 541/542 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
>                OK              91.02s   15 subtests passed
> ▶ 542/542 /riscv64/k230-wdt/register_read_write -
> ERROR:../tests/qtest/libqtest.c:558:qtest_connect: assertion failed:
> (s->fd >= 0 && s->qmp_fd >= 0) FAIL
> ▶ 542/542
>                ERROR
> 542/542 qemu:qtest+qtest-riscv64 / qtest-riscv64/k230-wdt-test
>                ERROR           51.60s   killed by signal 6 SIGABRT
> >>> PYTHON=/var/mnt/scratch/alistair/software/qemu/build/pyvenv/bin/python3 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_VNC_BINARY=./tools/qemu-vnc/qemu-vnc UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_TEST_ITERATION=1 QTEST_QEMU_IMG=./qemu-img RUST_BACKTRACE=1 G_TEST_DBUS_DAEMON=/var/mnt/scratch/alistair/software/qemu/tests/dbus-daemon.sh MALLOC_PERTURB_=94 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QTEST_QEMU_BINARY=./qemu-system-riscv64 /var/mnt/scratch/alistair/software/qemu/build/tests/qtest/k230-wdt-test --tap -k
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> ✀  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> qemu-system-riscv64: unsupported machine type: "k230"
> Use -machine help to list supported machines
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:../tests/qtest/libqtest.c:558:qtest_connect: assertion failed:
> (s->fd >= 0 && s->qmp_fd >= 0)
> ../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU
> process but encountered exit status 1 (expected 0)
> 
> (test program exited with status code -6)
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> 
> Summary of Failures:
> 
> 542/542 qemu:qtest+qtest-riscv64 / qtest-riscv64/k230-wdt-test
>       ERROR           51.60s   killed by signal 6 SIGABRT
> 
> Ok:                 510
> Expected Fail:      0
> Fail:               1
> Unexpected Pass:    0
> Skipped:            31
> Timeout:            0
> 
> Alistair
> 
> > ---
> >  MAINTAINERS                 |   1 +
> >  tests/qtest/k230-wdt-test.c | 189 ++++++++++++++++++++++++++++++++++++
> >  tests/qtest/meson.build     |   3 +-
> >  3 files changed, 192 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/qtest/k230-wdt-test.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e5ec6367ca..e7e3ed0c5c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1788,6 +1788,7 @@ F: hw/riscv/k230.c
> >  F: hw/watchdog/k230_wdt.c
> >  F: include/hw/riscv/k230.h
> >  F: include/hw/watchdog/k230_wdt.h
> > +F: tests/qtest/k230-wdt-test.c
> >
> >  RX Machines
> >  -----------
> > diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
> > new file mode 100644
> > index 0000000000..c8eaeaf1ae
> > --- /dev/null
> > +++ b/tests/qtest/k230-wdt-test.c
> > @@ -0,0 +1,189 @@
> > +/*
> > + * QTest testcase for K230 Watchdog
> > + *
> > + * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Provides a board compatible with the kendryte K230 SDK
> > + *
> > + * K230 Technical Reference Manual V0.3.1 (2024-11-18):
> > + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> > + *
> > + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/timer.h"
> > +#include "qemu/bitops.h"
> > +#include "libqtest.h"
> > +#include "hw/watchdog/k230_wdt.h"
> > +
> > +/* K230 WDT0 base address */
> > +#define K230_WDT0_BASE 0x91106000
> > +#define K230_WDT1_BASE 0x91106800
> > +
> > +/* Test WDT0 by default */
> > +#define WDT_BASE K230_WDT0_BASE
> > +
> > +static void test_register_read_write(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230");
> > +
> > +    /* Test Control Register (CR) read/write */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0xFFFFFFFF);
> > +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_CR), ==,
> > +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> > +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> > +
> > +    /* Test Timeout Range Register (TORR) read/write */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> > +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_TORR), ==,
> > +                    K230_WDT_TORR_TOP_MASK);
> > +
> > +    /* Test Protection Level Register read/write */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_PROT_LEVEL, 0xFFFFFFFF);
> > +    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_PROT_LEVEL), ==, 0x7);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_counter_restart(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230");
> > +
> > +    /* Enable watchdog and set timeout */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x5); /* TOP = 5 */
> > +
> > +    /* Read current counter value */
> > +    uint32_t initial_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> > +    g_assert_cmpuint(initial_count, >, 0);
> > +
> > +    /* Restart counter with magic value */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
> > +
> > +    /* Wait for time */
> > +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> > +
> > +    /* Counter should be reset to timeout value */
> > +    uint32_t new_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> > +    g_assert_cmpuint(new_count, >, 0);
> > +    g_assert_cmpuint(new_count, !=, initial_count);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_interrupt_mode(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
> > +
> > +    /* Set interrupt mode and enable watchdog */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR,
> > +                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> > +
> > +    /* Wait for timeout to trigger interrupt */
> > +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
> > +
> > +    /* Check interrupt status */
> > +    uint32_t stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> > +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
> > +
> > +    /* Clear interrupt */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_EOI, 0x1);
> > +    stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
> > +    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, 0);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_reset_mode(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230 -no-reboot");
> > +
> > +    /* Set reset mode and enable watchdog */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
> > +
> > +    /* Wait for timeout to trigger reset */
> > +    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
> > +
> > +    /* In reset mode, the system should reset */
> > +    /* This test verifies that reset mode is properly configured */
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_timeout_calculation(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230");
> > +
> > +    /* Test different timeout values */
> > +    for (uint32_t top = 0; top <= 15; top++) {
> > +        qtest_writel(qts, WDT_BASE + K230_WDT_TORR, top);
> > +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> > +
> > +        /* Read current counter value */
> > +        uint32_t count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
> > +        g_assert_cmpuint(count, >, 0);
> > +
> > +        /* Disable watchdog for next iteration */
> > +        qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> > +    }
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_wdt1_registers(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230");
> > +
> > +    /* Test WDT1 registers (second watchdog) */
> > +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_CR, 0xFFFFFFFF);
> > +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_CR), ==,
> > +                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
> > +                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
> > +
> > +    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_TORR, 0xFFFFFFFF);
> > +    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_TORR), ==,
> > +                    K230_WDT_TORR_TOP_MASK);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_enable_disable(void)
> > +{
> > +    QTestState *qts = qtest_init("-machine k230");
> > +
> > +    /* Initially disabled */
> > +    uint32_t cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> > +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> > +
> > +    /* Enable watchdog */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
> > +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> > +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, K230_WDT_CR_WDT_EN);
> > +
> > +    /* Disable watchdog */
> > +    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
> > +    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
> > +    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    qtest_add_func("/k230-wdt/register_read_write", test_register_read_write);
> > +    qtest_add_func("/k230-wdt/counter_restart", test_counter_restart);
> > +    qtest_add_func("/k230-wdt/interrupt_mode", test_interrupt_mode);
> > +    qtest_add_func("/k230-wdt/reset_mode", test_reset_mode);
> > +    qtest_add_func("/k230-wdt/timeout_calculation", test_timeout_calculation);
> > +    qtest_add_func("/k230-wdt/wdt1_registers", test_wdt1_registers);
> > +    qtest_add_func("/k230-wdt/enable_disable", test_enable_disable);
> > +
> > +    return g_test_run();
> > +}
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 43f83ffd3a..45c4898454 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -290,7 +290,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
> >    (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> >    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
> >     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> > -   ['iommu-riscv-test'] : [])
> > +   ['iommu-riscv-test'] : []) + \
> > +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> >
> >  qos_test_ss = ss.source_set()
> >  qos_test_ss.add(
> >

