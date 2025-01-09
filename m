Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFB8E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVuBv-0003Vu-Us; Thu, 09 Jan 2025 10:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVuBu-0003VG-6t; Thu, 09 Jan 2025 10:11:22 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tVuBs-0003mb-2C; Thu, 09 Jan 2025 10:11:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEB801F453;
 Thu,  9 Jan 2025 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736435477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6UgPtE26aeisqzYug7JbgLjE/TGY7sBW4j6jlkYaAY=;
 b=qES5gMSTf2ZD3SGBuC3x977i2bF4/y/PN8dZJ242o85R3CbX6/cGgsVAV8vJjOtkHFgapb
 o+VkMpTp9IqHubbTqctzX3qX3vX0sMj1lJzCuRNqlKYYMYDJEvYJ6SNTuzrZIw8Ck7/+s4
 F5Dmz8Yy9eJxtROeE+cDoVidVdGK7ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736435477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6UgPtE26aeisqzYug7JbgLjE/TGY7sBW4j6jlkYaAY=;
 b=NEHUQnEd53wYQlactAhmJpO6yQwVUQEDo6/9xSVY7REz+PjmE/UFWlWNMwyFZFLGcctZKT
 LXtEmCE4tQIa4/Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qES5gMST;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NEHUQnEd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736435477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6UgPtE26aeisqzYug7JbgLjE/TGY7sBW4j6jlkYaAY=;
 b=qES5gMSTf2ZD3SGBuC3x977i2bF4/y/PN8dZJ242o85R3CbX6/cGgsVAV8vJjOtkHFgapb
 o+VkMpTp9IqHubbTqctzX3qX3vX0sMj1lJzCuRNqlKYYMYDJEvYJ6SNTuzrZIw8Ck7/+s4
 F5Dmz8Yy9eJxtROeE+cDoVidVdGK7ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736435477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6UgPtE26aeisqzYug7JbgLjE/TGY7sBW4j6jlkYaAY=;
 b=NEHUQnEd53wYQlactAhmJpO6yQwVUQEDo6/9xSVY7REz+PjmE/UFWlWNMwyFZFLGcctZKT
 LXtEmCE4tQIa4/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 355FD139AB;
 Thu,  9 Jan 2025 15:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /uLsOhTnf2e7bQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 15:11:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-arm@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth
 <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] tests/qtest/stm32l4x5_usart: Avoid accessing NVIC
 via MMIO
In-Reply-To: <20250107192637.67683-1-philmd@linaro.org>
References: <20250107192637.67683-1-philmd@linaro.org>
Date: Thu, 09 Jan 2025 12:11:13 -0300
Message-ID: <87wmf42fam.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AEB801F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The STM32L4x5 SoC family use a ARM Cortex-M core. Such
> core is architecturally tied with a NVIC (interrupt controller),
> having the NVIC MMIO mapped in the core address space.
>
> When using the QTest accelerator, we don't emulate vCPU, only
> a dummy is created. For now, QTest is only supposed to access
> MMIO devices mapped on the main 'SysBus'. Thus it shouldn't
> be able to access a NVIC MMIO region, because such region is
> specific to a vCPU address space, which isn't available under
> QTest.
>
> In order to avoid NVIC MMIO accesses, rather than checking
> UART IRQs on the NVIC, intercept the UART IRQ and check for
> raised/lowered events.
>
> The sysbus USART1 IRQ output is wired to EXTI #26 input.
> Use qtest_irq_intercept_out_named() to intercept it, count
> the events with qtest_get_irq_lowered_counter() and
> qtest_get_irq_raised_counter().
>
> Remove the then unused check/clear_nvic_pending() methods.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20241216141818.111255-7-gustavo.romero@linaro.org>
> "tests/qtest: Add API functions to capture IRQ toggling"
>
> This patch is to fix the problem reported by Fabiano when
> removing the &first_cpu global in qtest, see analysis in:
> https://lore.kernel.org/qemu-devel/05820c9b-a683-4eb4-a836-e97aa708d5e5@l=
inaro.org/
>
> Note, while writing that patch I noticed a problem with the
> b-l475e-iot01a machine. In bl475e_init() somes output GPIOs
> are wired twice. The EXTI outputs are passed to the SoC with
> qdev_pass_gpios(), and few are re-wired to the various output
> IRQ splitters. I'll open a GitLab issue so it can be cleared
> later.
> ---
>  tests/qtest/stm32l4x5_usart-test.c | 33 +++++++-----------------------

What about these other ones?
stm32l4x5_exti-test.c
stm32l4x5_rcc-test.c

>  1 file changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_u=
sart-test.c
> index 927bab63614..35622e9434d 100644
> --- a/tests/qtest/stm32l4x5_usart-test.c
> +++ b/tests/qtest/stm32l4x5_usart-test.c
> @@ -46,26 +46,7 @@ REG32(ICR, 0x20)
>  REG32(RDR, 0x24)
>  REG32(TDR, 0x28)
>=20=20
> -#define NVIC_ISPR1 0XE000E204
> -#define NVIC_ICPR1 0xE000E284
> -#define USART1_IRQ 37
> -
> -static bool check_nvic_pending(QTestState *qts, unsigned int n)
> -{
> -    /* No USART interrupts are less than 32 */
> -    assert(n > 32);
> -    n -=3D 32;
> -    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
> -}
> -
> -static bool clear_nvic_pending(QTestState *qts, unsigned int n)
> -{
> -    /* No USART interrupts are less than 32 */
> -    assert(n > 32);
> -    n -=3D 32;
> -    qtest_writel(qts, NVIC_ICPR1, (1 << n));
> -    return true;
> -}
> +#define USART1_EXTI_IRQ 26
>=20=20
>  /*
>   * Wait indefinitely for the flag to be updated.
> @@ -195,6 +176,8 @@ static void init_uart(QTestState *qts)
>      /* Enable the transmitter, the receiver and the USART. */
>      qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
>          cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
> +
> +    qtest_irq_intercept_out_named(qts, "machine/soc/exti", "sysbus-irq");
>  }
>=20=20
>  static void test_write_read(void)
> @@ -221,7 +204,7 @@ static void test_receive_char(void)
>      g_assert_true(send(sock_fd, "a", 1, 0) =3D=3D 1);
>      usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
>      g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'a');
> -    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
> +    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ)=
, =3D=3D, 0);
>=20=20
>      /* Now with the IRQ */
>      cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
> @@ -230,8 +213,7 @@ static void test_receive_char(void)
>      g_assert_true(send(sock_fd, "b", 1, 0) =3D=3D 1);
>      usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
>      g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'b');
> -    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
> -    clear_nvic_pending(qts, USART1_IRQ);
> +    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ)=
, >, 0);
>=20=20
>      close(sock_fd);
>=20=20
> @@ -251,7 +233,7 @@ static void test_send_char(void)
>      qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'c');
>      g_assert_true(recv(sock_fd, s, 1, 0) =3D=3D 1);
>      g_assert_cmphex(s[0], =3D=3D, 'c');
> -    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
> +    g_assert_cmpuint(qtest_get_irq_lowered_counter(qts, USART1_EXTI_IRQ)=
, =3D=3D, 0);
>=20=20
>      /* Now with the IRQ */
>      cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
> @@ -260,8 +242,7 @@ static void test_send_char(void)
>      qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'd');
>      g_assert_true(recv(sock_fd, s, 1, 0) =3D=3D 1);
>      g_assert_cmphex(s[0], =3D=3D, 'd');
> -    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
> -    clear_nvic_pending(qts, USART1_IRQ);
> +    g_assert_cmpuint(qtest_get_irq_raised_counter(qts, USART1_EXTI_IRQ),=
 >, 0);
>=20=20
>      close(sock_fd);

