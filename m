Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0819D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iPy-0000rd-21; Tue, 15 Oct 2024 10:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0iPv-0000TJ-Iy
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:20:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0iPt-0003k8-Rl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:20:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9850ae22eso2281865a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729002052; x=1729606852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdpUI49LyWqdj8Rnto7CJrV3mF8S6CujfvlBzRZHUyw=;
 b=N1SRcCOEvy4T7zT6/5clFFG4w3Vn/DbRV4Quw4ut4ECKKEOxSd1TSL8k4RRbfLJUUq
 1BM4BRiqdaEnKipqYfGBLQ5YdFlljFg+e7LcepSEytcDKz1qo3rt4AEeOan7OxNTkPOM
 dqAPkK9GD+kWfQXqbKwaSL05bBHCzpUJk3YVuIaCnB1fGX9/LHeHuDBtvE8CoSZCMKq2
 IhmjMrxxFJHwQ2FM4AxVBCu79J20Za4iUHlTIv72vFHSrDLNU+Qiz4HeJxWU+RbzflGP
 xifpHGmD4MoVBfptGm5aG4h/QLOSraAgkmCPWnpnA36j+YJS+WQ7bty/clWcigJJ10xr
 08/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729002052; x=1729606852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdpUI49LyWqdj8Rnto7CJrV3mF8S6CujfvlBzRZHUyw=;
 b=KSD2oHl3HrF76Mo4GRk6julOaOooRSH0H4jFkayeyMQpf9TNJhREcmf1s9n2J0bNqd
 38OPfmri+8TUDYG3JMkGcKfjL993l6m0lbTkqBPIm33ddsH1gfA1RCD4PqqQ+1DeCMZj
 r1zkhbpgP9/U0DBdGGrhr0yKrzPW1/tYs4jPqH3XW4vxC4ETAmkxdlvh9LtitlyEjZ6S
 ugs2o3Tkr8x4oC8D8L73C6oOy5rnuw6Cy4fZPvCYwQL3AB94fri25rzo9RIABcaHsbIV
 pS+nPFs6SZOii89yvpKIHZJIE5DIo7NZ/n0tfHrVFJNtoINiP2E7okesyCL2mtj6fYFR
 jnIQ==
X-Gm-Message-State: AOJu0YwEjo2Kw3QAY1AQ6NmVKBNVx9X9c8qOIMHZXYG80y0uPk1Nzpns
 Kn++YHPfAbWZLM06pVQ7RKb7p5TFzxYnx2HU5MPMio8VuYzMHJKNqxwW9WbzShjUETVanv+qz/G
 u5sxvgzwkFPQcotTbTXsmnWv0oPqaXt9HjPO8Ug==
X-Google-Smtp-Source: AGHT+IF56niG6ZLowC0TcE8HvuT9ltROqMrixIhKFcHFy9/IGCwErgTBt1Ng92EQEnq4wneN1N3hAbxw1aP4kgGgWy0=
X-Received: by 2002:a05:6402:908:b0:5c7:2131:5d3 with SMTP id
 4fb4d7f45d1cf-5c9950e1343mr339583a12.12.1729002051747; Tue, 15 Oct 2024
 07:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
 <20241003081105.40836-4-ines.varhol@telecom-paris.fr>
In-Reply-To: <20241003081105.40836-4-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 15:20:39 +0100
Message-ID: <CAFEAcA_0eyAa=XjDnobYqkinEnW1wOetKDBqus7k1BTWTyLLpQ@mail.gmail.com>
Subject: Re: [PING PATCH v5 3/3] tests/qtest: Check STM32L4x5 clock connections
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>,
 qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 3 Oct 2024 at 09:11, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> For USART, GPIO and SYSCFG devices, check that clock frequency before
> and after enabling the peripheral clock in RCC is correct.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Luc Michel <luc@lmichel.fr>


> +static void test_clock_enable(void)
> +{
> +    /*
> +     * For each USART device, enable its clock in RCC
> +     * and check that its clock frequency is SYSCLK_PERIOD
> +     */
> +    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
> +
> +    check_clock(qts, "machine/soc/usart[0]/clk", RCC_APB2ENR, 14);
> +    check_clock(qts, "machine/soc/usart[1]/clk", RCC_APB1ENR1, 17);
> +    check_clock(qts, "machine/soc/usart[2]/clk", RCC_APB1ENR1, 18);
> +    check_clock(qts, "machine/soc/uart[0]/clk", RCC_APB1ENR1, 19);
> +    check_clock(qts, "machine/soc/uart[1]/clk", RCC_APB1ENR1, 20);
> +    check_clock(qts, "machine/soc/lpuart1/clk", RCC_APB1ENR2, 0);
> +}

This new test is missing the qtest_quit(qts) call at the
end, which makes it hang when run on OpenBSD. (I fixed
this up in the pullrequest.)

thanks
-- PMM

