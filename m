Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A96BC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF8-0005u2-1G; Mon, 05 May 2025 13:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBzE4-0005Ip-AX
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uBzE0-0003XZ-8K
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55B111F391;
 Mon,  5 May 2025 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746464604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYy7nDoT5sxxQ83eJAlyB74xj4XKkLyMqwm2XUZ8rUo=;
 b=mySM2br8dS9732Bze/jHGq0hEGT2hoNOHoc8p7Py8I+fxWhi1ZJTtPs1+loYW9iIqcmO3f
 NjDMX6Ab64z7tmZFSoAFsF6Oj6Jz2lf+6Rpw/8AGiP2NFyGcv7ySw24/iBTvTQ2C5HXNJ7
 ZCSj1Xzp3zjU86TjDVMXguOXSuPmFQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746464604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYy7nDoT5sxxQ83eJAlyB74xj4XKkLyMqwm2XUZ8rUo=;
 b=L8bBvKaAQkqNNZeYjU4oLx7KGObhqOhZ+/Hbh9bwPxOXScE65fOWVHMUyCnPJ3ot3nezi/
 d7E5JOw62hmz7eCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746464604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYy7nDoT5sxxQ83eJAlyB74xj4XKkLyMqwm2XUZ8rUo=;
 b=mySM2br8dS9732Bze/jHGq0hEGT2hoNOHoc8p7Py8I+fxWhi1ZJTtPs1+loYW9iIqcmO3f
 NjDMX6Ab64z7tmZFSoAFsF6Oj6Jz2lf+6Rpw/8AGiP2NFyGcv7ySw24/iBTvTQ2C5HXNJ7
 ZCSj1Xzp3zjU86TjDVMXguOXSuPmFQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746464604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYy7nDoT5sxxQ83eJAlyB74xj4XKkLyMqwm2XUZ8rUo=;
 b=L8bBvKaAQkqNNZeYjU4oLx7KGObhqOhZ+/Hbh9bwPxOXScE65fOWVHMUyCnPJ3ot3nezi/
 d7E5JOw62hmz7eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68501372E;
 Mon,  5 May 2025 17:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uhq0IVvvGGiceAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 May 2025 17:03:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Tim Lee <timlee660101@gmail.com>, lvivier@redhat.com,
 pbonzini@redhat.com, wuhaotsh@google.com, kfting@nuvoton.com,
 chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Tim Lee
 <timlee660101@gmail.com>
Subject: Re: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
In-Reply-To: <20250418091208.1888768-1-timlee660101@gmail.com>
References: <20250418091208.1888768-1-timlee660101@gmail.com>
Date: Mon, 05 May 2025 14:03:20 -0300
Message-ID: <874ixzgfc7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,google.com,nuvoton.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[nongnu.org,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[9]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Tim Lee <timlee660101@gmail.com> writes:

> - Created qtest to check initialization of registers in PSPI Module
> - Implemented test into Build File
>
> Tested:
> ./build/tests/qtest/npcm8xx-pspi_test
>
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
>  MAINTAINERS                     |   1 +
>  tests/qtest/meson.build         |   3 +
>  tests/qtest/npcm8xx_pspi-test.c | 104 ++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 tests/qtest/npcm8xx_pspi-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..0162f59bf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -892,6 +892,7 @@ F: hw/sensor/adm1266.c
>  F: include/hw/*/npcm*
>  F: tests/qtest/npcm*
>  F: tests/qtest/adm1266-test.c
> +F: tests/qtest/npcm8xx_pspi-test.c
>  F: pc-bios/npcm7xx_bootrom.bin
>  F: pc-bios/npcm8xx_bootrom.bin
>  F: roms/vbootrom
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 3136d15e0f..88672a8b00 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -210,6 +210,8 @@ qtests_npcm7xx = \
>     'npcm7xx_watchdog_timer-test',
>     'npcm_gmac-test'] + \
>     (slirp.found() ? ['npcm7xx_emc-test'] : [])
> +qtests_npcm8xx = \
> +  ['npcm8xx_pspi-test']
>  qtests_aspeed = \
>    ['aspeed_hace-test',
>     'aspeed_smc-test',
> @@ -257,6 +259,7 @@ qtests_aarch64 = \
>    (config_all_accel.has_key('CONFIG_TCG') and                                            \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
> +  (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',
> diff --git a/tests/qtest/npcm8xx_pspi-test.c b/tests/qtest/npcm8xx_pspi-test.c
> new file mode 100644
> index 0000000000..107bce681f
> --- /dev/null
> +++ b/tests/qtest/npcm8xx_pspi-test.c
> @@ -0,0 +1,104 @@
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/module.h"
> +
> +#define DATA_OFFSET 0x00
> +#define CTL_SPIEN   0x01
> +#define CTL_OFFSET  0x02
> +#define CTL_MOD     0x04
> +
> +typedef struct PSPI {
> +    uint64_t base_addr;
> +} PSPI;
> +
> +PSPI pspi_defs = {
> +    .base_addr  = 0xf0201000
> +};
> +
> +static uint16_t pspi_read_data(QTestState *qts, const PSPI *pspi)
> +{
> +    return qtest_readw(qts, pspi->base_addr + DATA_OFFSET);
> +}
> +
> +static void pspi_write_data(QTestState *qts, const PSPI *pspi, uint16_t value)
> +{
> +    qtest_writew(qts, pspi->base_addr + DATA_OFFSET, value);
> +}
> +
> +static uint32_t pspi_read_ctl(QTestState *qts, const PSPI *pspi)
> +{
> +    return qtest_readl(qts, pspi->base_addr + CTL_OFFSET);
> +}
> +
> +static void pspi_write_ctl(QTestState *qts, const PSPI *pspi, uint32_t value)
> +{
> +    qtest_writel(qts, pspi->base_addr + CTL_OFFSET, value);
> +}
> +
> +/* Check PSPI can be reset to default value */
> +static void test_init(gconstpointer pspi_p)
> +{
> +    const PSPI *pspi = pspi_p;
> +
> +    QTestState *qts = qtest_init("-machine npcm845-evb");
> +    pspi_write_ctl(qts, pspi, CTL_SPIEN);
> +    g_assert_cmphex(pspi_read_ctl(qts, pspi), ==, CTL_SPIEN);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Check PSPI can be r/w data register */
> +static void test_data(gconstpointer pspi_p)
> +{
> +    const PSPI *pspi = pspi_p;
> +    uint16_t test = 0x1234;
> +    uint16_t output;
> +
> +    QTestState *qts = qtest_init("-machine npcm845-evb");
> +
> +    /* Write to data register */
> +    pspi_write_data(qts, pspi, test);
> +    printf("Wrote 0x%x to data register\n", test);
> +
> +    /* Read from data register */
> +    output = pspi_read_data(qts, pspi);
> +    printf("Read 0x%x from data register\n", output);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Check PSPI can be r/w control register */
> +static void test_ctl(gconstpointer pspi_p)
> +{
> +    const PSPI *pspi = pspi_p;
> +    uint8_t control = CTL_MOD;
> +
> +    QTestState *qts = qtest_init("-machine npcm845-evb");
> +
> +    /* Write CTL_MOD value to control register for 16-bit interface mode */
> +    qtest_memwrite(qts, pspi->base_addr + CTL_OFFSET,
> +                   &control, sizeof(control));
> +    g_assert_cmphex(pspi_read_ctl(qts, pspi), ==, control);
> +    printf("Wrote CTL_MOD to control register\n");
> +
> +    qtest_quit(qts);
> +}
> +
> +static void pspi_add_test(const char *name, const PSPI* wd,
> +        GTestDataFunc fn)
> +{
> +    g_autofree char *full_name = g_strdup_printf("npcm8xx_pspi/%s",  name);
> +    qtest_add_data_func(full_name, wd, fn);
> +}
> +
> +#define add_test(name, td) pspi_add_test(#name, td, test_##name)
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    add_test(init, &pspi_defs);
> +    add_test(ctl, &pspi_defs);
> +    add_test(data, &pspi_defs);
> +    return g_test_run();
> +}

This fails on top of current master, please take a look:

$ QTEST_LOG=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/npcm8xx_pspi-test
# random seed: R02S03f79fc48ba73b76c881f93f90b015e9
1..3
# Start of aarch64 tests
# Start of npcm8xx_pspi tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest
  unix:/tmp/qtest-32530.sock -qtest-log /dev/fd/2 -chardev
  socket,path=/tmp/qtest-32530.qmp,id=char0 -mon
  chardev=char0,mode=control -display none -audio none -machine
  npcm845-evb -accel qtest
[I 0.000000] OPENED
[R +0.034918] endianness
[S +0.034944] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 10},
"package": "v10.0.0-530-g88d6459dae"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}
{"return": {}}
[R +0.037373] writel 0xf0201002 0x1
[S +0.037396] OK
[R +0.037417] readl 0xf0201002
[S +0.037426] OK 0x0000000000000000
**
ERROR:../tests/qtest/npcm8xx_pspi-test.c:45:test_init: assertion failed
(pspi_read_ctl(qts, pspi) == CTL_SPIEN): (0x00000000 == 0x00000001)
Bail out!
[I +0.037909] CLOSED
Aborted (core dumped)

