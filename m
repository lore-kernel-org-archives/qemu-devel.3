Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C3FC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kQU-0002Gf-So; Thu, 10 Sep 2026 15:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x4kOc-0001sw-W5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:25:25 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x4kOM-00040l-DG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:25:11 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab201ecso60451d50.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789068278; cv=none;
 d=google.com; s=arc-20260327;
 b=Pkz8NoM5Qw3BEZzOW66DHsEmkVX6szZSXk6y25cSFOkouk0ssejc1lTqHaLXSgA/7l
 TSOucZk/J14hSpA2tiVZ3xqpN4dAdeDteJ4ckFsDMJLlZ9WQtmSYFkV9F8O81cBoXlYk
 LikPQD2SKeKrNu5+pWawwZ6x0KA3iBakl9DM14wePuxfuwt3wujYVd3uFIlnM9bjO2iK
 8RonJIqtpvZ83PmHQ7ULVnhlcL/rZNnu5U1l/oXjFrZqG+9LdPF71oCgpPoWpeG+pZwd
 WuXJBjZbMkP6NZZ3qTNXFJURDfF28/kXSWmkAFaxg517UmLvCD9TE3yV3j/jXVhuRsnr
 R9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VvJ1UBFUKvnTBhIyZla9iLs2QLT54AA6xcxxyWX5wyk=;
 fh=jp+jdRHA2Nbu3KHyIigzCCPHDCHDJKtZ5yhVkhWOgJM=;
 b=aHXowbb0Evzok4s0lgoL7BcTYruf1ZlmU2ps9QYRbZ4OmWJMvx16VEULnbL56YTlUv
 gE89VwBTgElqF72BwTjNHoecgXa7HQqyY4n2euauMJxgahFjgy7AZ42DxOpcw4lZdB4k
 JPpAuUnifxK/ZUQHNK8N5kV1Amj9QS/G9gtkQkBD9Bbzh3yGE1CpV7iUjPLaRpM9YcPy
 HsoYR7A9xRJ7lDgXTjJDR4dbTN0+/Gx96+EuYwIjaSDL7zIhyFLpTxzgPdhI9puSXMSa
 MFpTDpLTGS2xBDOzxj8e+jDZrkODqh0sLbNQAiEky33lMxiuli7GeqBbzTjAreZ9r8gK
 rvhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789068278; x=1789673078; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VvJ1UBFUKvnTBhIyZla9iLs2QLT54AA6xcxxyWX5wyk=;
 b=hjp7IvZA23DOxzgtXrNFTa99ylg06pk352rwKaucRXCxn0ervjXl8eLIBDo9ceT7w/
 B5AqQKQI4mjBrjFG+rLxqDacgqo1lnGRMgpJiBN+QVBaW5OqYlcAakGrH1MTl0TQZFGS
 MO5u0RfR/inETszYwcGx8asjwNXAKMISol/7qE+NN2yhTl/wD2nsX4lgYw+InWvic6n2
 kDPh+nYbmSfRXgf3TH+HBz7e1Ue3PoIOSZZDk7POHXnsTXz4t3dEXFBbfArCBVBgrWSV
 2rc55ogkm8Kkc81Y9y78SuxVTy6ZIOC42A1FAWQljjLb2oZkAS1uF+Q2DdV/e7bfZ2xT
 MnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068278; x=1789673078;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VvJ1UBFUKvnTBhIyZla9iLs2QLT54AA6xcxxyWX5wyk=;
 b=ZC/LTtNI1Kli7iLfW4L2UWQ7DVNciGhOO7bzB87keWL6G0BsqIF1RS10MnTmNxkj6k
 /sAgP2r2dFGvxfqxwlXBDc2djvHdeShYdzVUrkZyASn0x0ZveBztGrjxuAQSDiN8R4cW
 u2qAvnZ5y7jhNMjTqf1oGP3kHigztBRi59T+hmvMjvhvhHo2dpxY7npL9dyF2ytIVgm2
 rd+CMmXML2ia2n30T6IsUaYAwkJx5X65DFVwMNOseCRpTVuFIg72mqJcQaMTPqKmjohZ
 MDzbv1RQaA57wsvVdMhuFLLIEPx/P2qsjiLqXavByhmsyZ6bvjjAI+Ydg2BJ9ludlDWW
 F9yA==
X-Gm-Message-State: AFuF++miJb7Bq4fRV3mSTF3beQ7qxHWK7hV9Q554s6hMvISR0JI2cVMb
 jKlTWyvJnevgI0rI8SwhiutRnSW9dWIe/E5k8ugHZbTl6K7VkKDYFl++FAqod99YsqsPGT9tG4M
 AEuWKOfbi1LFrwow8kpGJWGuhdmP+umY=
X-Gm-Gg: AYBFou3f3rtlkhena391gbhRFZe2BBpgrZDK6If1pd1OSf/0wAFqk1BIL4w0dsf+Etd
 xym5MJ8oWjLvKs0Agl9uTt0QFAgctCWCmlS/P8PpmoiJMZvLzrXb1ZP48PHtwaL02rh6A1rH6l0
 HkoGM8c85k6zx8KTIeAkehIhBntkiaeUlPBHcxgkRotgKqjYaXbXdrdUBJIuZW6BbgfHn3XAcmP
 Zb2UMFamSwpUq9BjQ2s5PLYmEg1RwRv4JIyHK8+04D46mal35LOk6fM+/goyilCcesZZjwH7nUg
 0rS2o7pprFWJWCHI1PUWMEV6MRooArJAVtskwifpGB1XwF1DofWmLO1Q
X-Received: by 2002:a05:690e:138a:b0:66d:1849:93cb with SMTP id
 956f58d0204a3-6712488cfa1mr434848d50.29.1789068278060; Thu, 10 Sep 2026
 12:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
 <20260829-allwinner-gpio-v2-3-f0ebcb07302e@gmail.com>
 <CAFEAcA9+H-RQbpf2Fdv-C0Z5zxncBCAccYTNUBfJHzRHfVc+3Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9+H-RQbpf2Fdv-C0Z5zxncBCAccYTNUBfJHzRHfVc+3Q@mail.gmail.com>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Thu, 10 Sep 2026 21:24:25 +0200
X-Gm-Features: AcwNN1WYSGUjYdwY9Z8FMRmgAM-EbAsv03typ59v-YmltkHp_mCxX5JeYuSX0XQ
Message-ID: <CABtshVT-Wux7jqX2SNnmOT=kjUTtuHHw8wFJm1dDtZO70xkJ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: Allwinner GPIO tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000315a8f065b25eb07"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000315a8f065b25eb07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, Sep 8, 2026 at 4:18=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Sat, 29 Aug 2026 at 13:56, Strahinja Jankovic
> <strahinja.p.jankovic@gmail.com> wrote:
> >
> > Add Allwinner GPIO set of qtests to validate functionality.
> > Tests cover input and output port setting, as well as interrupt
> > functionality.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> > ---
>
>
> > +static void test_irq_pin_rising(const void *data)
> > +{
> > +    PortPinTestParam *param =3D (PortPinTestParam *)data;
> > +    QTestState *s =3D qtest_init("-machine cubieboard");
> > +    const int gpio_port =3D param->port;
> > +    const int port_pin =3D param->pin;
> > +    g_autofree char *in_name =3D portname_in(gpio_port);
> > +    int irq_pin =3D irq_nr(gpio_port, port_pin);
> > +    unsigned int irq_mask =3D 1u << irq_pin;
> > +
> > +    qtest_irq_intercept_in(s, "/machine/soc");
> > +
> > +    /* Configure as input and set pin low */
> > +    update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
> > +    assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_IN);
> > +    qtest_set_irq_in(
> > +        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_LOW);
>
> Breaking the line immediately after the opening "(" looks odd;
> generally put the first parameter there and break the line
> after that where it makes sense.
>

I will change this, had a lot of issues with the line width, so I will
update all the places where I did a break like this.


>
> > +
> > +    /* Enable interrupt */
> > +    update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
> > +    assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_EDGE);
> > +    qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);
> > +
> > +    /* Raise interrupt */
> > +    qtest_set_irq_in(
> > +        s, "/machine/soc/gpio", in_name, port_pin, AW_GPIO_LEVEL_HIGH)=
;
> > +    /* Check that value is written */
> > +    assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_HIGH);
> > +    /* Check interrupt status */
> > +    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), =3D=3D, irq_mas=
k);
> > +    g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));
> > +
> > +    /* Clear interrupt */
> > +    qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);
> > +
> > +    /* Check that IRQ line is low */
> > +    g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) & irq_mask, =3D=
=3D,
> 0);
> > +    g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));
> > +
> > +    qtest_quit(s);
> > +}
>
>
>
> > +int main(int argc, char **argv)
> > +{
> > +  int r;
> > +
> > +  g_test_init(&argc, &argv, NULL);
> > +
> > +  for (int i =3D 0; i < G_N_ELEMENTS(in_out_test_parameters); i++) {
>
> Prefer ARRAY_SIZE() over G_N_ELEMENTS().
>

Ok!


>
> > +    g_autofree char *out_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/set_output_pins/%s%d",
> > +    portname(in_out_test_parameters[i].port),
> in_out_test_parameters[i].pin);
> > +    g_autofree char *in_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/set_input_pins/%s%d",
> > +    portname(in_out_test_parameters[i].port),
> in_out_test_parameters[i].pin);
>
> This has turned into an unreadable lump especially given the
> lack of indentation. I suggest factoring out the creation of the
> test:


> static char *add_test(const char *type, const PortPinTestParam *p,
>                       void (*testfn)(const void *))
> {
>     g_autofree char *name =3D
>          g_strdup_printf("/allwinner-cubieboard/gpio/%s/%s%d",
>                          type, portname(p->port), p->pin);
>
>     qtest_add_data_func(name, p, testfn);
> }
>
> Then you in your loop you can do:
>
>     PortPinTestParam *p =3D &in_out_test_parameters[i];
>
>     add_test("set_output_pins", p, test_set_output_pins);
>     add_test("set_input_pins", p, test_set_input_pins);
>
>
Now that you point it out, it has. I was adding line after line just to add
all tests,
but I forgot to take another look to prettify it.
Thanks for the suggestion, I will use it!


>
> > +    qtest_add_data_func(out_name, &in_out_test_parameters[i],
> > +                        test_set_output_pins);
> > +    qtest_add_data_func(in_name, &in_out_test_parameters[i],
> > +                        test_set_input_pins);
> > +  }
> > +  qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
> > +                      test_reset_values);
> > +  for (int i =3D 0; i < G_N_ELEMENTS(irq_test_parameters); i++) {
> > +    g_autofree char *rising_edge_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/irq_pin_rising/%s%d",
> > +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin)=
;
> > +    qtest_add_data_func(
> > +            rising_edge_name, &irq_test_parameters[i],
> test_irq_pin_rising);
> > +    g_autofree char *falling_edge_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/irq_pin_falling/%s%d",
> > +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin)=
;
>
> add_test() should make this loop more readable too.
>

Ok!

Thank you very much for your thorough review and help, I will make the
changes and send a new version.

Best regards,
Strahinja Jankovic



>
> > +    qtest_add_data_func(
> > +            falling_edge_name, &irq_test_parameters[i],
> test_irq_pin_falling);
> > +    g_autofree char *high_level_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/irq_pin_high_level/%s%d",
> > +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin)=
;
> > +    qtest_add_data_func(
> > +            high_level_name, &irq_test_parameters[i],
> test_irq_pin_high_level);
> > +    g_autofree char *low_level_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/irq_pin_low_level/%s%d",
> > +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin)=
;
> > +    qtest_add_data_func(
> > +            low_level_name, &irq_test_parameters[i],
> test_irq_pin_low_level);
> > +    g_autofree char *both_edge_name =3D g_strdup_printf(
> > +    "/allwinner-cubieboard/gpio/irq_pin_both_edge/%s%d",
> > +    portname(irq_test_parameters[i].port), irq_test_parameters[i].pin)=
;
> > +    qtest_add_data_func(
> > +            both_edge_name, &irq_test_parameters[i],
> test_irq_pin_both_edge);
> > +
> > +  }
> > +  r =3D g_test_run();
> > +
> > +  return r;
> > +}
>
> thanks
> -- PMM
>

--000000000000315a8f065b25eb07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 8, 2026 at=
 4:18=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.o=
rg">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Sat, 29 Aug 2026 at 13:56, Strahinja Jankovi=
c<br>
&lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank">str=
ahinja.p.jankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Add Allwinner GPIO set of qtests to validate functionality.<br>
&gt; Tests cover input and output port setting, as well as interrupt<br>
&gt; functionality.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
&gt; ---<br>
<br>
<br>
&gt; +static void test_irq_pin_rising(const void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PortPinTestParam *param =3D (PortPinTestParam *)data;<b=
r>
&gt; +=C2=A0 =C2=A0 QTestState *s =3D qtest_init(&quot;-machine cubieboard&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 const int gpio_port =3D param-&gt;port;<br>
&gt; +=C2=A0 =C2=A0 const int port_pin =3D param-&gt;pin;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *in_name =3D portname_in(gpio_port);<br=
>
&gt; +=C2=A0 =C2=A0 int irq_pin =3D irq_nr(gpio_port, port_pin);<br>
&gt; +=C2=A0 =C2=A0 unsigned int irq_mask =3D 1u &lt;&lt; irq_pin;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_irq_intercept_in(s, &quot;/machine/soc&quot;);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Configure as input and set pin low */<br>
&gt; +=C2=A0 =C2=A0 update_cfg_reg(s, gpio_port, port_pin, AW_GPIO_CFG_IN);=
<br>
&gt; +=C2=A0 =C2=A0 assert_cfg_regval(s, gpio_port, port_pin, AW_GPIO_CFG_I=
N);<br>
&gt; +=C2=A0 =C2=A0 qtest_set_irq_in(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, &quot;/machine/soc/gpio&quot;, in_name=
, port_pin, AW_GPIO_LEVEL_LOW);<br>
<br>
Breaking the line immediately after the opening &quot;(&quot; looks odd;<br=
>
generally put the first parameter there and break the line<br>
after that where it makes sense.<br></blockquote><div><br></div><div>I will=
 change this, had a lot of issues with the line width, so I will update all=
 the places where I did a break like this.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Enable interrupt */<br>
&gt; +=C2=A0 =C2=A0 update_int_cfg_reg(s, irq_pin, AW_GPIO_IRQ_CFG_RISING_E=
DGE);<br>
&gt; +=C2=A0 =C2=A0 assert_int_cfg_regval(s, irq_pin, AW_GPIO_IRQ_CFG_RISIN=
G_EDGE);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(s, GPIO_INT_CTL_ADDR, irq_mask);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Raise interrupt */<br>
&gt; +=C2=A0 =C2=A0 qtest_set_irq_in(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s, &quot;/machine/soc/gpio&quot;, in_name=
, port_pin, AW_GPIO_LEVEL_HIGH);<br>
&gt; +=C2=A0 =C2=A0 /* Check that value is written */<br>
&gt; +=C2=A0 =C2=A0 assert_data_reg(s, gpio_port, port_pin, AW_GPIO_LEVEL_H=
IGH);<br>
&gt; +=C2=A0 =C2=A0 /* Check interrupt status */<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR), =3D=
=3D, irq_mask);<br>
&gt; +=C2=A0 =C2=A0 g_assert_true(qtest_get_irq(s, AW_A10_IRQ_LINE));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Clear interrupt */<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(s, GPIO_INT_STA_ADDR, irq_mask);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Check that IRQ line is low */<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(s, GPIO_INT_STA_ADDR) &amp;=
 irq_mask, =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_false(qtest_get_irq(s, AW_A10_IRQ_LINE));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(s);<br>
&gt; +}<br>
<br>
<br>
<br>
&gt; +int main(int argc, char **argv)<br>
&gt; +{<br>
&gt; +=C2=A0 int r;<br>
&gt; +<br>
&gt; +=C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 for (int i =3D 0; i &lt; G_N_ELEMENTS(in_out_test_parameters);=
 i++) {<br>
<br>
Prefer ARRAY_SIZE() over G_N_ELEMENTS().<br></blockquote><div><br></div><di=
v>Ok!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *out_name =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/set_output_pins/%s%d&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 portname(in_out_test_parameters[i].port), in_out_test_p=
arameters[i].pin);<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *in_name =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/set_input_pins/%s%d&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 portname(in_out_test_parameters[i].port), in_out_test_p=
arameters[i].pin);<br>
<br>
This has turned into an unreadable lump especially given the<br>
lack of indentation. I suggest factoring out the creation of the<br>
test:<span style=3D"background-color:transparent">=C2=A0</span></blockquote=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
static char *add_test(const char *type, const PortPinTestParam *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void (*testfn)(const void *))<br>
{<br>
=C2=A0 =C2=A0 g_autofree char *name =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_strdup_printf(&quot;/allwinner-cubieboa=
rd/gpio/%s/%s%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0type, portname(p-&gt;port), p-&gt;pin);<br>
<br>
=C2=A0 =C2=A0 qtest_add_data_func(name, p, testfn);<br>
}<br>
<br>
Then you in your loop you can do:<br>
<br>
=C2=A0 =C2=A0 PortPinTestParam *p =3D &amp;in_out_test_parameters[i];<br>
<br>
=C2=A0 =C2=A0 add_test(&quot;set_output_pins&quot;, p, test_set_output_pins=
);<br>
=C2=A0 =C2=A0 add_test(&quot;set_input_pins&quot;, p, test_set_input_pins);=
<br>
<br></blockquote><div><br></div><div><div>Now that you point it out, it has=
. I was adding line after line just to add all tests,</div><div>but I forgo=
t to take another look to prettify it.</div></div><div>Thanks for the sugge=
stion, I will use it!</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(out_name, &amp;in_out_test_paramete=
rs[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 test_set_output_pins);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(in_name, &amp;in_out_test_parameter=
s[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 test_set_input_pins);<br>
&gt; +=C2=A0 }<br>
&gt; +=C2=A0 qtest_add_func(&quot;/allwinner-cubieboard/gpio/reset_values&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 test_reset_values);<br>
&gt; +=C2=A0 for (int i =3D 0; i &lt; G_N_ELEMENTS(irq_test_parameters); i+=
+) {<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *rising_edge_name =3D g_strdup_printf(<=
br>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/irq_pin_rising/%s%d&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 portname(irq_test_parameters[i].port), irq_test_paramet=
ers[i].pin);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rising_edge_name, &amp;irq_=
test_parameters[i], test_irq_pin_rising);<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *falling_edge_name =3D g_strdup_printf(=
<br>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/irq_pin_falling/%s%d&q=
uot;,<br>
&gt; +=C2=A0 =C2=A0 portname(irq_test_parameters[i].port), irq_test_paramet=
ers[i].pin);<br>
<br>
add_test() should make this loop more readable too.<br></blockquote><div><b=
r></div><div>Ok!</div><div><br></div><div>Thank you very much for your thor=
ough review and help, I will make the changes and send a new version.</div>=
<div><span style=3D"background-color:transparent"><br></span></div><div><sp=
an style=3D"background-color:transparent">Best regards,</span></div><div><s=
pan style=3D"background-color:transparent">Strahinja Jankovic</span></div><=
div><span style=3D"background-color:transparent"><br></span></div><div><spa=
n style=3D"background-color:transparent">=C2=A0</span></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 falling_edge_name, &amp;irq=
_test_parameters[i], test_irq_pin_falling);<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *high_level_name =3D g_strdup_printf(<b=
r>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/irq_pin_high_level/%s%=
d&quot;,<br>
&gt; +=C2=A0 =C2=A0 portname(irq_test_parameters[i].port), irq_test_paramet=
ers[i].pin);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 high_level_name, &amp;irq_t=
est_parameters[i], test_irq_pin_high_level);<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *low_level_name =3D g_strdup_printf(<br=
>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/irq_pin_low_level/%s%d=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 portname(irq_test_parameters[i].port), irq_test_paramet=
ers[i].pin);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 low_level_name, &amp;irq_te=
st_parameters[i], test_irq_pin_low_level);<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *both_edge_name =3D g_strdup_printf(<br=
>
&gt; +=C2=A0 =C2=A0 &quot;/allwinner-cubieboard/gpio/irq_pin_both_edge/%s%d=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 portname(irq_test_parameters[i].port), irq_test_paramet=
ers[i].pin);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 both_edge_name, &amp;irq_te=
st_parameters[i], test_irq_pin_both_edge);<br>
&gt; +<br>
&gt; +=C2=A0 }<br>
&gt; +=C2=A0 r =3D g_test_run();<br>
&gt; +<br>
&gt; +=C2=A0 return r;<br>
&gt; +}<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000315a8f065b25eb07--

