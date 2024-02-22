Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDD9C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAhV-0003cM-Qp; Thu, 22 Feb 2024 10:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdAhU-0003bn-5s
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:09:28 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdAhS-00053V-F5
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:09:27 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-512cba0f953so3114445e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708614563; x=1709219363; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1f7PihdvzC749X3ukZxJaCxCkQyD49sC6eocxx1JwJ0=;
 b=yldMRkQDjnFfImGiRTkRK/YSrNmRRaLSh+B3yzUy9Cqgdz4bJY2X30RqcLkYFh/HCd
 1jNj6+x7d5BrOZjTRBvCriExs5TJhCWAY5ktzl9P8CggW2WiwcwXm+IxTcJ0R2fZYYiG
 wyUoKZxSmMiHrwkTPEJyNeOiHo6w4bmhQRnmiL+7zxKyAzwTvohD2/RxD29rtU92nmox
 TXDjRbhi9hfw3d/06nLgcaVOkuNuQzmVu/8Y0GmGEXDFQGi5cj+iSN9wyfwoJqGcWou0
 cKlLrJ+gMHRUJoMw3YeqV6ivsTCIAC04Z6VrxriWZFTcl8sCb8CSfBn1DFfD+xzh34sC
 lz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708614563; x=1709219363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1f7PihdvzC749X3ukZxJaCxCkQyD49sC6eocxx1JwJ0=;
 b=AaPMUSKCkJLGMGWUidqLpuJIDQBG1Oi+nbm9bzAiVRGK1UnuQo2sDvYgCEekSJJ90J
 AOAmPDKLT8smFJB6PlbBSeN+RDn+zu5ugJkJVxZFZlCiUy5YTbx8btbQ9mrmj802K1zG
 PhNlcgv8+/inNS9mRF6Frh1kMJHsULbBmsF6hIl+1wvWczb8kIOyWyV8BrHLnb1esU53
 tLOTxR7aSsFqwagg7ZNdG/QeV99Ozeer+msAmMyiATtRS3B25GglZEjbRGt8oCpfqGHc
 jJ4g+u4PCYHc6SEfKJxJUyc7TycpPQq1qbSS7RlCgAb9iKH0JFWBwndJb4r2sgX/wIkE
 YYyA==
X-Gm-Message-State: AOJu0YxMjIHHUd6v1q9lsS2UdpY7mdMcmXoIkiIFiGnDVPYpquIDtUU6
 eooS5KIfoGmVN68XwB4+pFzD6c+BP2grOw8vpgr3BCuwJONlPrpKj601HbGnBadCpVL/SICXL4d
 X6Z1s8JXoNmJ7KZYqGUT9XTjoAV0/k39No+tt6Q==
X-Google-Smtp-Source: AGHT+IFqFE7vop9gRwFstbR79kC4MMQ28ruunjfhdVgAPpEspvetlriZ7GLdQPM8A/wcLrDktockynoEKA31e5+DZuY=
X-Received: by 2002:ac2:46c3:0:b0:512:c363:fda1 with SMTP id
 p3-20020ac246c3000000b00512c363fda1mr5376105lfo.12.1708614563184; Thu, 22 Feb
 2024 07:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20240220184145.106107-1-ines.varhol@telecom-paris.fr>
 <20240220184145.106107-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240220184145.106107-3-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 15:09:11 +0000
Message-ID: <CAFEAcA-Vq+r2ivjttHMhZyyFBcPpNst2CQNQN9TRbCZ9WfiSAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests/qtest: Check that EXTI fan-in irqs are
 correctly connected
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 18:41, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> This commit adds a QTest that verifies each input line of a specific
> EXTI OR gate can influence the output line.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>
> Hello,
>
> I expected this test to fail after switching the two patch commits,
> but it didn't.
> I'm mentionning it in case it reveals a problem with the test I didn't no=
tice.

The specific thing that goes wrong if you don't have the OR
gate handling is that the NVIC input will see every up
and down transition from each input separately. (This happens
because a GPIO/irq 'input' in QEMU is basically a function,
and wiring up an 'output' to an 'input' is setting "this
is the function pointer you should call when the output
changes". Nothing syntactically stops you passing the
same function pointer to multiple outputs.)

So if you have for instance
 raise A; raise B; drop B; drop A
where A and B are ORed together into an NVIC input,
the NVIC input is supposed to see the line go high
at "raise A" and only drop at the last "drop B". Without
the OR gate, it will see it go high at "raise A", and then
drop at "drop B". (Well, it sees "level is 1", "level is 1",
"level is 0", "level is 0", but inputs expect to sometimes see
calls for "level happens to be the same thing it was
previously", so it doesn't cause the NVIC to change state.)

Your test case doesn't as far as I can see check this situation,
because it's (a) testing every input in order, not checking
what happens when multiple inputs are raised and lowered
in overlapping ways and (b) using rising-edge interrupts.
So that's why it doesn't fail even without the bug fix in
the previous patch.

>  #define EXTI0_IRQ 6
>  #define EXTI1_IRQ 7
> +#define EXTI5_9_IRQ 23
>  #define EXTI35_IRQ 1
>
>  static void enable_nvic_irq(unsigned int n)
> @@ -499,6 +500,40 @@ static void test_interrupt(void)
>      g_assert_false(check_nvic_pending(EXTI1_IRQ));
>  }
>
> +static void test_orred_interrupts(void)
> +{
> +    /*
> +     * For lines EXTI5..9 (fanned-in to NVIC irq 23),
> +     * test that raising the line pends interrupt
> +     * 23 in NVIC.
> +     */
> +    enable_nvic_irq(EXTI5_9_IRQ);
> +    /* Check that there are no interrupts already pending in PR */
> +    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
> +    /* Check that this specific interrupt isn't pending in NVIC */
> +    g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
> +
> +    /* Enable interrupt lines EXTI[5..9] */
> +    exti_writel(EXTI_IMR1, (0x1F << 5));
> +
> +    /* Configure interrupt on rising edge */
> +    exti_writel(EXTI_RTSR1, (0x1F << 5));
> +
> +    /* Raise GPIO line i, check that the interrupt is pending */
> +    for (unsigned i =3D 5; i < 10; i++) {
> +        exti_set_irq(i, 1);
> +        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
> +        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
> +
> +        exti_writel(EXTI_PR1, 1 << i);
> +        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
> +        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
> +
> +        unpend_nvic_irq(EXTI5_9_IRQ);
> +        g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
> +    }
> +}
> +
>  int main(int argc, char **argv)
>  {
>      int ret;
> @@ -515,6 +550,8 @@ int main(int argc, char **argv)
>      qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interr=
upt);
>      qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
>      qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_select=
or);
> +    qtest_add_func("stm32l4x5/exti/test_orred_interrupts",
> +                   test_orred_interrupts);
>
>      qtest_start("-machine b-l475e-iot01a");
>      ret =3D g_test_run();
> --
> 2.43.2

thanks
-- PMM

