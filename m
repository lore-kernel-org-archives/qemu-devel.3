Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF38BC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wec-0005ej-PA; Tue, 08 Sep 2026 10:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wea-0005eM-Mk
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:18:28 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3weY-0000nT-Qk
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:18:28 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-871c8a36fe3so48431417b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877105; cv=none;
 d=google.com; s=arc-20260327;
 b=K8nunxcHeoS641KJL71PMPSr7ZRmbq4Sw9G8P+vrM3HHfqaxGUM+ZL37fiUhXi5Avg
 UNKPINWVh148xuYcuH9Eh5in1aV8HY07K5jbai5xN4c1ttREYAwCt4GySaVS0e8R13xc
 4SIHzItm2NgHfNpb0mtsXtiy0o/lsQ6q/dhAXatFTD6lvyzFmft20Csw306nT4b+VYz4
 9KdciTjtaNtt7T5WlmDDhHZChfKTbsXtnYOGkRLiJAq+EpagcM2TG0EmU2EfaJEj6mMh
 ZbISuVPm55IAMT11vTiJauzCbboy2vyAJHbqNuwQNlaS/ISfVeiSzF/ll2DC7X94sDZh
 tvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M0XGYthQivEpgQogQki5Glre8rRlGd/DcFDYqYqczLg=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=mFhtQI+IRDtUWIWkn82LE8LMFP2Gz+45bsaX4XxbL71uZi/BYdSulMXLs+FodAMds3
 YvBLXtI2rTa8/qaN1Dr69njiy+TcFpdu5yDE3zCUnZocshKlbFfTnzhWWzXKDxAzXGSe
 /7BwMR1AnGyiQKguiz24QyaNhQrCeB27uHF+1L93PyZ7y4q73BX3blo5dt6lKtudjiaQ
 vJg8MlGw6d9nHimITRqjO8hnBLjr1HDMKdeIzDbvLN37sCBJl/TBGO2UEfaTDKt60fxJ
 kvm7YE7QrZk0ka2hxGHKIIBm1mLu6bwOfHrN86E9AiAbJtZchFXMlme0icsa5i3fw+hd
 7ouQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788877105; x=1789481905; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M0XGYthQivEpgQogQki5Glre8rRlGd/DcFDYqYqczLg=;
 b=eG9he6J9RA/GoglyFEJjeiZCZWRnDvYLDnPE/VBZDqBAvbT/4C5YdFwPjxpd7uADbD
 3vP+DQ4v+ws23afQbXcdTtO8AFbztOxN7ZRQthH32cUjcB2BTtlFtwmQ1m1iIR2Onsya
 4m9XFTK2BV3zLi/4qYNhHyUGM4sYJjP8JNm4Bh445Y7wLCAvie2x5JWlrgGifRTnUOr8
 tkua0qRwcJcnkjl61a4Ocfn8MZF6W1O6NP+iaX/BIDiLkCXxPjgJb1Xk+6wQIXMknthd
 uadPKq/c5D2ePw/p284J1EHhK1C+g7Y+3YpFMh+XUOamcUxC3NfdyoAZynpHCaGN+gGE
 J12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877105; x=1789481905;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M0XGYthQivEpgQogQki5Glre8rRlGd/DcFDYqYqczLg=;
 b=cN/x/whnlaGTLSDLLnqSW81gK2DRZ+vvPCdgDjELltPQNb437KEi5eFY9xIr13hTdo
 k13wsIebGoPfJEumxTh+BZXDq0LlsE2T6Ef6yy41gONk1Qzw8kowAEoM2BFgOvnnYqqO
 qQ6G2OL4Y/IgXUBLl3Oi43NqyzWFD7Drw1xhG0WbTCnZL/XsdwVAWrptOrdW6aBa5qRw
 GYcl+91vMWJS5QtRYR0oWA2e3WA21G5SLp1+QUOnvJljafErty/VY6ijVV63ax86M7i7
 8GReUz0xoJFtdDrbyJha1uBnOtG6D70FhiyGmsxXTsZm1ok9cGJrG5b/NuKKEEIUwuS0
 q08w==
X-Gm-Message-State: AFuF++ka0H5+T9rIlwvzk2ZRPEv0vp6htJjpCr/3/pWe4qDECjK84Anq
 KjXXtQaYa8gdJwyXzkbzun5MfE01TLuxlY4RlyH480oojUuCYDaA3NGhLixTZ1O9uPrmKhiXgib
 Uo4r85JyT9krJ+Iq03lnObGyOu1UfcJuzKFHOVvp1hA==
X-Gm-Gg: AYBFou1WYBTseob9b3nxrdElu+6Bpa83f5Fr2KpMQPxksH0SmLAJuoZJgoO2HIQWROf
 EcTvcfB63bEeBrU0bk8CJNrRavWh61M4vZPzb/BSFqYGOnPN0ZDukVuAIiQXK+JdTJ7EdceMWrq
 RSMVGem+z9fN6fwDNdpgx2cBeN4sRa3NBjvEC5BMo+M2Fo4+cD9pAlE//nFRg9ApVB+r9Suewef
 7aJ8wUB4XMDNbRjTK2NnDAroBRbhIA92KCK/rJTLwYLsEIfvdQ89wcMoWQi9Fyc2wOh6iZsOQMl
 WIRN1E289zjVcMDWyFxwZ8uM05duI/SzoMPh3fuACWii70n45eRL+ceMKiItfeFKKE5XDZDlJFB
 xOtfALdSp2Xdw9wJ4j9WLW/sbcvoJ
X-Received: by 2002:a05:690c:6513:b0:873:5bb2:6c37 with SMTP id
 00721157ae682-8735bb26f91mr76983917b3.62.1788877104947; Tue, 08 Sep 2026
 07:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
 <20260829-allwinner-gpio-v2-3-f0ebcb07302e@gmail.com>
In-Reply-To: <20260829-allwinner-gpio-v2-3-f0ebcb07302e@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:18:13 +0100
X-Gm-Features: AcwNN1U8Z4stcX4eP1xQ_iBDv5dK5Wt2U_nsK73OTXadEMyB3P8MScdMjszRWCM
Message-ID: <CAFEAcA9+H-RQbpf2Fdv-C0Z5zxncBCAccYTNUBfJHzRHfVc+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: Allwinner GPIO tests
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sat, 29 Aug 2026 at 13:56, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> Add Allwinner GPIO set of qtests to validate functionality.
> Tests cover input and output port setting, as well as interrupt
> functionality.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> ---


> +static void test_irq_pin_rising(const void *data)
> +{
> +    PortPinTestParam *param = (PortPinTestParam *)data;
> +    QTestState *s = qtest_init("-machine cubieboard");
> +    const int gpio_port = param->port;
> +    const int port_pin = param->pin;
> +    g_autofree char *in_name = portname_in(gpio_port);
> +    int irq_pin = irq_nr(gpio_port, port_pin);
> +    unsigned int irq_mask = 1u << irq_pin;
> +
> +    qtest_irq_intercept_in(s, "/machine/soc");
> +
> +    /* Configure as input and set pin low */
> +    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
> +    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
> +    qtest_set_irq_in(
> +        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);

Breaking the line immediately after the opening "(" looks odd;
generally put the first parameter there and break the line
after that where it makes sense.

> +
> +    /* Enable interrupt */
> +    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
> +    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
> +    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
> +
> +    /* Raise interrupt */
> +    qtest_set_irq_in(
> +        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH);
> +    /* Check that value is written */
> +    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
> +    /* Check interrupt status */
> +    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), ==, irq_mask);
> +    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
> +
> +    /* Clear interrupt */
> +    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
> +
> +    /* Check that IRQ line is low */
> +    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, ==, 0);
> +    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
> +
> +    qtest_quit(s);
> +}



> +int main(int argc, char **argv)
> +{
> +  int r;
> +
> +  g_test_init(&argc, &argv, NULL);
> +
> +  for (int i = 0; i < G_N_ELEMENTS(in_out_test_parameters); i++) {

Prefer ARRAY_SIZE() over G_N_ELEMENTS().

> +    g_autofree char *out_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/set_output_pins/%s%d",
> +    portname(in_out_test_parameters[i].port), in_out_test_parameters[i].pin);
> +    g_autofree char *in_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/set_input_pins/%s%d",
> +    portname(in_out_test_parameters[i].port), in_out_test_parameters[i].pin);

This has turned into an unreadable lump especially given the
lack of indentation. I suggest factoring out the creation of the
test:

static char *add_test(const char *type, const PortPinTestParam *p,
                      void (*testfn)(const void *))
{
    g_autofree char *name =
         g_strdup_printf("/allwinner-cubieboard/gpio/%s/%s%d",
                         type, portname(p->port), p->pin);

    qtest_add_data_func(name, p, testfn);
}

Then you in your loop you can do:

    PortPinTestParam *p = &in_out_test_parameters[i];

    add_test("set_output_pins", p, test_set_output_pins);
    add_test("set_input_pins", p, test_set_input_pins);


> +    qtest_add_data_func(out_name, &in_out_test_parameters[i],
> +                        test_set_output_pins);
> +    qtest_add_data_func(in_name, &in_out_test_parameters[i],
> +                        test_set_input_pins);
> +  }
> +  qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
> +                      test_reset_values);
> +  for (int i = 0; i < G_N_ELEMENTS(irq_test_parameters); i++) {
> +    g_autofree char *rising_edge_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/irq_pin_rising/%s%d",
> +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
> +    qtest_add_data_func(
> +            rising_edge_name, &irq_test_parameters[i], test_irq_pin_rising);
> +    g_autofree char *falling_edge_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/irq_pin_falling/%s%d",
> +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);

add_test() should make this loop more readable too.

> +    qtest_add_data_func(
> +            falling_edge_name, &irq_test_parameters[i], test_irq_pin_falling);
> +    g_autofree char *high_level_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/irq_pin_high_level/%s%d",
> +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
> +    qtest_add_data_func(
> +            high_level_name, &irq_test_parameters[i], test_irq_pin_high_level);
> +    g_autofree char *low_level_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/irq_pin_low_level/%s%d",
> +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
> +    qtest_add_data_func(
> +            low_level_name, &irq_test_parameters[i], test_irq_pin_low_level);
> +    g_autofree char *both_edge_name = g_strdup_printf(
> +    "/allwinner-cubieboard/gpio/irq_pin_both_edge/%s%d",
> +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin);
> +    qtest_add_data_func(
> +            both_edge_name, &irq_test_parameters[i], test_irq_pin_both_edge);
> +
> +  }
> +  r = g_test_run();
> +
> +  return r;
> +}

thanks
-- PMM

