Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FBE73179
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzl5-0006Qm-Pl; Mon, 02 Feb 2026 14:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmzl3-0006Pz-Mv
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:38:49 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmzl1-0001pm-Go
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 14:38:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20C7F3E6C5;
 Mon,  2 Feb 2026 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770061125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbDODjFwLWFWO47DZT7UMCgJtfvMFsqKPhpNYOK/M20=;
 b=a8c5fpn5sVL1bxEtmtojjjhXpg3TR3Wnz0ZJVd5lZyPQfWRYfzLqfkVEQATH5ZioPRozu3
 3filrp84AUI3CbiZck3s9guqU+k0MxJHWEhcvuUYh+wRagX+f+8ZOMo82muQx4cXIdR5oN
 YL+4iJLpb+m6F6O62Hq8MMujofBbcO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770061125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbDODjFwLWFWO47DZT7UMCgJtfvMFsqKPhpNYOK/M20=;
 b=wcov17AjHqClfd6cA6h8wl6lKCXrrSM6B+9geGsgm57nOlNDLs8US5S79lyBcY4E0E3xRX
 UNpEFgK0BcYUBYBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dkMgLO/b";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lRTeI+Vs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770061124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbDODjFwLWFWO47DZT7UMCgJtfvMFsqKPhpNYOK/M20=;
 b=dkMgLO/b6YTEpXpzhOi3QOB9Pe6Mnn53yrGzVXGFi2vmmVsx+xYmgpBfEui/p/ogzWR9eo
 F2DIT209eZCicK7zfWD14c2kZZkB3FyMkMdPr3HlAtd5dbyBnRk7GSja1KyLg8sLwJ/F6m
 /UZg9sFcjPNxwhZ1hMldP1bVDv/MtFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770061124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbDODjFwLWFWO47DZT7UMCgJtfvMFsqKPhpNYOK/M20=;
 b=lRTeI+Vs0JQQrJlpTD/aSd7wCuyjk//s/Vo02TU5AGTo//o0t58raedAIPoWReRnPjQJeW
 2H0q7i0yjlUOodCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF903EA62;
 Mon,  2 Feb 2026 19:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K79SD0L9gGmHUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 19:38:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Chao Liu <chao.liu.zevorn@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao
 Liu <chao.liu.zevorn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, Laurent Vivier
 <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, Chao Liu <chao.liu@zevorn.cn>,
 Mig Yang <temashking@foxmail.com>
Subject: Re: [PATCH v5 4/5] tests/qtest: add test for K230 watchdog
In-Reply-To: <a8ae9e811d66201397b064e8573dac9f7e379823.1769757064.git.chao.liu.zevorn@gmail.com>
References: <cover.1769757064.git.chao.liu.zevorn@gmail.com>
 <a8ae9e811d66201397b064e8573dac9f7e379823.1769757064.git.chao.liu.zevorn@gmail.com>
Date: Mon, 02 Feb 2026 16:38:39 -0300
Message-ID: <87pl6nq6kg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,wdc.com,ventanamicro.com,dabbelt.com,linux.alibaba.com,redhat.com,vrull.eu];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[foxmail.com,gmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,googlegroups.com,zevorn.cn,foxmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 20C7F3E6C5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Chao Liu <chao.liu.zevorn@gmail.com> writes:

> From: Chao Liu <chao.liu@zevorn.cn>
>
> Testing the Basic Functions of K230 WDT:
> 1. Reset Function
> 2. Timeout Check
> 3. Interrupt Function
>
> Signed-off-by: Mig Yang <temashking@foxmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  MAINTAINERS                 |   1 +
>  tests/qtest/k230-wdt-test.c | 199 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build     |   3 +-
>  3 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/k230-wdt-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64a5f3b986..84c980d252 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1765,6 +1765,7 @@ F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: tests/qtest/k230-wdt-test.c
>  
>  RX Machines
>  -----------
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
> index 0f053fb56d..54c3ba5dea 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -283,7 +283,8 @@ qtests_riscv32 = \
>    (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>  
>  qtests_riscv64 = ['riscv-csr-test'] + \
> -  (unpack_edk2_blobs ? ['bios-tables-test'] : [])
> +  (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
>  
>  qos_test_ss = ss.source_set()
>  qos_test_ss.add(

Acked-by: Fabiano Rosas <farosas@suse.de>

