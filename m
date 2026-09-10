Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A088CC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kLH-0001Fl-OD; Thu, 10 Sep 2026 15:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x4kKq-0001DY-AK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:21:27 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1x4kKV-0003Fl-He
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:21:21 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-871c8a36fe3so728817b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789068037; cv=none;
 d=google.com; s=arc-20260327;
 b=SmQ9D4gXbGP4Aozo0Mix2popP4TxFDksCZYO/KEvZMrMMj2cC9BL9aGUNF1BFE4YHs
 k20eqlwzltsp2ml+3D+ZR2wwyHFj46/A66PDsUr1g+Q7Kn9J7CQlefWP58so44iYJsoE
 TmG67juxjeecK2GQMyiVA/VhYqJTzwA7ZGWKFOhvopRtCo5PV3BFyjKFgoS0hrEPi/MK
 SWGssUgITmmZrZMauhSUDwknle0ho5QRSyDJTRN5tLC+Zycqb31n24Iy55sv2XTud8f9
 SQkScAjjxp2b4S6DmdUiQiku86oqZd1GD+pUv/AjarHhLg7BbrYeHHASJ7BkYD70kk8/
 wkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lJl5IRGQswOml7qfIDcRGo2PQgJdvMfIem3vUvwPfmY=;
 fh=jp+jdRHA2Nbu3KHyIigzCCPHDCHDJKtZ5yhVkhWOgJM=;
 b=o4q/ArmAqkPbSgESBOcpO6yosFgsTc5C9RutZxAkVLVAsSzDowE7FqEOZrSfKYzf+q
 9RAGjl4CVbd4q/uMpmPMNvwqM1BKogymrXtAmJc1Hxpgzb3Kv5+QxtoVuqrEjzj1FTfX
 2qFKzAi68kdvw1TnXqVQJ0VZoSGMAby+cLKsHa6P8Se7WXIsl739HwtcHGi0FPBQweLh
 LVy76tKZOrB9sZrLZYWHpB8JFwRxhsjyS9x2HIrdeEBEymNT+UqwepDcSUCVsZch9lEG
 bR3sJUl38zvK563XMD96B6B8QiffeMzy0/AXXAUnYLKNoBKkAC8knTAp+rq1a/e6NQ5y
 5avg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789068037; x=1789672837; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lJl5IRGQswOml7qfIDcRGo2PQgJdvMfIem3vUvwPfmY=;
 b=n4n9kdm2GWnunTeoLNKuElA21XgPwDJULARH7s3t9xyikAr4abGe2iU4cef6GAkrGY
 U5uu2V+5XwzLNZwuANxUNUd/cwDPhnSU/2RfHoDMXHPDg3a4jr4Q4IFepQSG72QHdjxv
 Y0pTbauR9wxh+b1CSv7UGWdACHdJlOcBjsScCldylP6Pbwy0+KNslyKiOjqeNzaIbuJA
 0/O06UPh4qgHifkz1eVcb5zMospXtBuQXhzxkwbYYI0Pv9p/R0nE3LHoSVfgKWjjEL24
 DggRNVLgOB43u0UUnxV9InjBTXOTGL1Q0+FxDWWPz5UpAnVWS9BohBUjVvj77cuR+CeH
 Uc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068037; x=1789672837;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lJl5IRGQswOml7qfIDcRGo2PQgJdvMfIem3vUvwPfmY=;
 b=r1ig9aVSlXtBwma8A1+XStVGoHGhUInnIDi+H7zW131xhWG8GaIoOO8ZS6jRM9JwMu
 EuTxFnlfhGf9+DWJA3p2mk3wqm+zs/RoxQhDCFKMjHQjipaS21jXESHChSkqxo75OXLm
 PqYxzJ+iwX8TWT+0L95ww6qZyUvvEOF356c9FNIUq/j9V+ZK4eviAie9OoaZwVfo5Fif
 kkBjbOuqfu9KrxsU+YfHMZgM11wSMe4YC4o6IxitQuKyALlY9F8Qo3+GmW/7wP3J4zwr
 KNB+c3UcFnzKJgX7SeS9BYqIRWFPB1yiv04YXxU6vwBwjTV84EGi4SOJAIrIuFlIry2h
 dDug==
X-Gm-Message-State: AFuF++l4fNBoKAC6/8FGFQQhnlB7ZqpN2njs1pn9g1Ism0pHWRXChN1l
 iBw3KqnhO60S6eB3r/FJ60/g31XVnBvP3SYo9zdPUDNqRa6ypu6cdMtxF5a/tub8RYl7BBwHsz5
 nNTg+K2eikXxu96C/NusYWghaTpMWRxU=
X-Gm-Gg: AYBFou3sMMggDt+XFYkWGeP4x51injh6NcmhnMVFqP4XWDuZP3TKgJRdVq5Pzds2+TC
 COO3W2bQfQp2zdKuX7WSfM7bcBE0O6G2JIMzjHxTWK9yjTyHBw2QIy9Mn9h2eUSQ/nuOAxAYhMb
 sGrZvFFREG0aey70v7396GzXZ4LaLYhcpI7GQPu9h6kIUTtJg3Vb6zEBT03yomNinxFHUevH5i7
 5PYC3FCxk1c84+H5gS0m5aauhIzI1CrxbK8/KxFdoUTgi5krdhAZNzILc7aZZyHGeIXL/DM8Tjh
 z/kA+RmuF2KSJDYOag9kW3k5L6iks/imLiH7lkitJNF85KxbDXiYKsHLGgd4SnTTKts=
X-Received: by 2002:a05:690c:e0d4:20b0:873:5bb2:6c33 with SMTP id
 00721157ae682-884b3a69b0bmr4121887b3.58.1789068036947; Thu, 10 Sep 2026
 12:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
 <20260829-allwinner-gpio-v2-1-f0ebcb07302e@gmail.com>
 <CAFEAcA-hGo_3wfve0bt2wq=00hYpLjgCN0oyQTaR3WGmFhoBBA@mail.gmail.com>
In-Reply-To: <CAFEAcA-hGo_3wfve0bt2wq=00hYpLjgCN0oyQTaR3WGmFhoBBA@mail.gmail.com>
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Thu, 10 Sep 2026 21:20:23 +0200
X-Gm-Features: AcwNN1XaxcVE54ejxKekdSLne9nfDFHdn4TpVuH4a3fSCQObOc3B9xexh1rJK7Q
Message-ID: <CABtshVSnpcu90+s2EncfahMUesAcwJ8rBRE2DSfZb7eKgVA5BA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/gpio: Allwinner A10 GPIO emulation
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d2430f065b25dc69"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yw1-x112b.google.com
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

--000000000000d2430f065b25dc69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for taking time to review these patches.

On Tue, Sep 8, 2026 at 3:59=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Sat, 29 Aug 2026 at 13:56, Strahinja Jankovic
> <strahinja.p.jankovic@gmail.com> wrote:
> >
> > This patch implements Allwinner A10 GPIO peripheral emulation.
> >
> > The emulation focuses on input/output and interrupt functionality,
> > whereas the drive and pull up/down functionality is not emulated.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
>
> Thanks for this patch; my comments below are generally minor ones.
>
> > +static bool gpio_is_input(AWPortMap *port, uint32_t pin);
> > +static int int_ctl_cfg(AWGPIOState *s, int irq_line);
>
> I think you could just move the definitions of these functions
> to here rather than having forward declarations.
>
>
I will move definitions here.


> > +
> > +static inline void allwinner_gpio_update_int(AWGPIOState *s)
> > +{
> > +    qemu_set_irq(
> > +        s->irq,
> > +        !!(s->regs[REG_INDEX(GPIO_INT_CTL)] &
> s->regs[REG_INDEX(GPIO_INT_STA)])
> > +    );
> > +}
> > +
> > +static void allwinner_gpio_set_int_line(AWGPIOState *s, int port,
> > +                                        int line, AWGPIOLevel level)
> > +{
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    int irq_line =3D irq_nr(port, line);
> > +    bool raise_irq =3D false;
> > +    unsigned input_val;
> > +    int int_cfg;
> > +
> > +    /* Check if pin can actually trigger an interrupt */
> > +    if (irq_line =3D=3D -1) {
> > +        return;
> > +    }
> > +
> > +    /* if this signal isn't configured as an input signal, nothing to
> do */
> > +    if (!gpio_is_input(&o->ports[port], line)) {
> > +        return;
> > +    }
> > +
> > +    /* Get current input value */
> > +    input_val =3D extract32(o->ports[port].dat, line, 1);
> > +    int_cfg =3D int_ctl_cfg(s, irq_line);
>
> I was tempted to suggest that maybe we could work on more than
> one pin at a time (compare cc57a945feb090), but the way the config
> is stored in registers for this device makes that too awkward,
> unfortunately.
>
> > +
> > +    switch (int_cfg) {
> > +    case AW_GPIO_IRQ_CFG_RISING_EDGE:
> > +        if (!input_val && level) {
> > +            raise_irq =3D true;
> > +        }
> > +        break;
> > +    case AW_GPIO_IRQ_CFG_FALLING_EDGE:
> > +        if (input_val && !level) {
> > +            raise_irq =3D true;
> > +        }
> > +        break;
> > +    case AW_GPIO_IRQ_CFG_HIGH_LEVEL:
> > +        if (level) {
> > +            raise_irq =3D true;
> > +        }
> > +        break;
> > +    case AW_GPIO_IRQ_CFG_LOW_LEVEL:
> > +        if (!level) {
> > +            raise_irq =3D true;
> > +        }
> > +        break;
> > +    case AW_GPIO_IRQ_CFG_BOTH_EDGE:
> > +        if (input_val !=3D level) {
> > +            raise_irq =3D true;
> > +        }
> > +        break;
> > +    default:
> > +        /* Unexpected */
> > +        break;
> > +    }
> > +
> > +    if (raise_irq) {
> > +        s->regs[REG_INDEX(GPIO_INT_STA)] |=3D 1u << irq_line;
> > +    }
> > +}
> > +
> > +static void port_set_all_int_lines(AWGPIOState *s, int port)
> > +{
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    int i;
> > +
> > +    for (i =3D 0; i < AW_PINS_PER_PORT[port]; i++) {
>
> Our coding style these days prefers "for (int i =3D ... )"
> where the variable is only used as a loop iterator.
>

Ok!


>
> > +        AWGPIOLevel aw_level =3D extract32(o->ports[port].dat, i, 1);
> > +        allwinner_gpio_set_int_line(s, port, i, aw_level);
> > +    }
> > +
> > +    allwinner_gpio_update_int(s);
> > +}
> > +
> > +static void allwinner_set_all_int_lines(AWGPIOState *s)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < AW_GPIO_PORTS_NUM; i++) {
> > +        port_set_all_int_lines(s, i);
> > +    }
> > +}
> > +
> > +static void allwinner_gpio_set(void *opaque, int port, int line, int
> level)
> > +{
> > +    AWGPIOState *s =3D AW_GPIO(opaque);
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    AWGPIOLevel aw_level =3D level ? AW_GPIO_LEVEL_HIGH :
> AW_GPIO_LEVEL_LOW;
> > +
> > +    if (gpio_is_input(&o->ports[port], line)) {
> > +
> > +        trace_allwinner_gpio_set(portname(port), line, aw_level);
> > +
> > +        allwinner_gpio_set_int_line(s, port, line, aw_level);
> > +
> > +        o->ports[port].dat =3D (o->ports[port].dat & ~(1u << line)) |
> > +                             (aw_level << line);
>
> This is better written with deposit32(), I think.
>

I will try with deposit32().


>
> > +    }
> > +    allwinner_gpio_update_int(s);
> > +}
> > +
> > +
> > +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
> > +{
> > +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> > +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> > +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1)
> =3D=3D
> > +        CFG_OUTPUT_MASK);
> > +}
> > +
> > +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
> > +{
> > +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> > +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> > +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1)
> =3D=3D
> > +        CFG_INPUT_MASK);
> > +}
> > +
> > +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
> > +{
> > +    unsigned int_cfg_n =3D s->regs[REG_INDEX(GPIO_INT_CFG0) + irq_line=
 /
> 8];
> > +    return extract32(int_cfg_n,
> > +                     (irq_line % INT_CFG_IRQ_PER_REG) *
> INT_CFG_IRQ_STRIDE,
> > +                     INT_CFG_IRQ_STRIDE - 1);
>
> The datasheet says these fields are 4 bits, so shouldn't the
> third argument here be INT_CFG_IRQ_STRIDE, not ... - 1 ?
> This is different fromthe port config registers, which are
> documented as 3 bit fields separated by a reserved bit.
>

The fields are 4 bits only, but the maximum non-reserved value is 4, so
nothing is lost if only 3 bits are used.
However, in order to keep the code more readable, I will change to
INT_CFG_IRQ_STRIDE and add a check
when writing that only non-reserved values are written.


>
> > +}
> > +
> > +static inline void port_update_output_lines(AWGPIOState *s, uint32_t
> port)
> > +{
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    int pin;
> > +
> > +    for (pin =3D 0; pin < AW_PINS_PER_PORT[port]; pin++) {
> > +        if (gpio_is_output(&o->ports[port], pin)) {
> > +            qemu_set_irq(s->output[port][pin],
> > +                         !!(o->ports[port].dat & BIT_MASK(pin)));
> > +            trace_allwinner_gpio_out_pin(
> > +                portname(port), pin,
> > +                !!(o->ports[port].dat & BIT_MASK(pin)));
> > +         }
> > +        else if (gpio_is_input(&o->ports[port], pin)) {
> > +            qemu_irq_lower(s->output[port][pin]);
>
> Shouldn't the way we handle the output GPIO line be the same
> for both "this is configured as an input" and "this is configured
> as neither an input or an output" ?
>

My idea was that the output pins should not be changed by the GPIO
controller if
they are assigned to an alternate function/another peripheral, since they
should
change values according to that function. However, since the alternate
function
connection to other peripherals is not modeled, then these pins might as
well be
fixed to low value if the pin is not configured as output.

I will change this.


>
> > +        }
> > +    }
> > +}
> > +
> > +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState
> *s)
> > +{
> > +    for (int port =3D 0; port < AW_GPIO_PORTS_NUM; port++) {
> > +        port_update_output_lines(s, port);
> > +    }
> > +}
> > +
> > +
> > +static uint64_t allwinner_gpio_read(void *opaque, hwaddr offset,
> unsigned size)
> > +{
> > +    AWGPIOState *s =3D AW_GPIO(opaque);
> > +    uint32_t reg_value =3D 0;
> > +    g_autofree char *regname =3D allwinner_gpio_get_regname(offset);
> > +
> > +    switch (offset) {
> > +    case 0 ... GPIO_Pn_PUL1(GPIO_PI):
> > +    case GPIO_INT_CFG0:
> > +    case GPIO_INT_CFG1:
> > +    case GPIO_INT_CFG2:
> > +    case GPIO_INT_CFG3:
> > +    case GPIO_INT_CTL:
> > +    case GPIO_INT_STA:
> > +    case GPIO_INT_DEB:
> > +        reg_value =3D s->regs[REG_INDEX(offset)];
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset
> 0x%"
> > +                      HWADDR_PRIx "\n", TYPE_AW_GPIO, __func__, offset=
);
> > +        break;
> > +    }
> > +
> > +    trace_allwinner_gpio_read(regname, reg_value);
> > +
> > +    return reg_value;
> > +}
> > +
> > +/* update output values */
> > +/* update interrupts */
>
> These comments seem like they're in the wrong place ?
>

Correct, I will remove them.


>
> > +static void allwinner_port_write(AWGPIOState *s, hwaddr offset,
> uint64_t value)
> > +{
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    uint32_t port =3D offset / PORT_STRIDE;
> > +    uint32_t reg =3D offset % PORT_STRIDE;
> > +
> > +    switch (reg) {
> > +    case CFG0:
> > +        o->ports[port].cfg[0] =3D
> > +            value & GPIO_CFG0_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case CFG1:
> > +        o->ports[port].cfg[1] =3D
> > +            value & GPIO_CFG1_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case CFG2:
> > +        o->ports[port].cfg[2] =3D
> > +            value & GPIO_CFG2_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case CFG3:
> > +        o->ports[port].cfg[3] =3D
> > +            value & GPIO_CFG3_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case DAT:
> > +        o->ports[port].dat =3D
> > +            value & GPIO_DAT_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case DRV0:
> > +        o->ports[port].drv[0] =3D
> > +            value & GPIO_DRV0_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case DRV1:
> > +        o->ports[port].drv[1] =3D
> > +            value & GPIO_DRV1_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case PUL0:
> > +        o->ports[port].pul[0] =3D
> > +            value & GPIO_PUL0_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    case PUL1:
> > +        o->ports[port].pul[1] =3D
> > +            value & GPIO_PUL1_PINS_MASK(AW_PINS_PER_PORT[port]);
> > +        break;
> > +    }
> > +    port_update_output_lines(s, port);
> > +    port_set_all_int_lines(s, port);
> > +}
>
> > +static void allwinner_gpio_reset(DeviceState *dev)
> > +{
> > +    AWGPIOState *s =3D AW_GPIO(dev);
> > +    AWPortsOverlay *o =3D (AWPortsOverlay *)s->regs;
> > +    int port =3D 0;
> > +
> > +    memset(s->regs, 0, AW_GPIO_IOSIZE);
> > +
> > +    for (port =3D 0; port < AW_GPIO_PORTS_NUM; port++) {
> > +        o->ports[port].drv[0] =3D aw_gpio_port_reset[port].drv[0];
> > +        o->ports[port].drv[1] =3D aw_gpio_port_reset[port].drv[1];
> > +        o->ports[port].pul[0] =3D aw_gpio_port_reset[port].pul[0];
> > +        o->ports[port].pul[1] =3D aw_gpio_port_reset[port].pul[1];
> > +    }
> > +
> > +    allwinner_gpio_update_all_output_lines(s);
> > +    allwinner_gpio_update_int(s);
>
> Generally we say you shouldn't update gpio lines outbound
> in a reset function.
>

My idea was to make certain that all pins are low and interrupt is not set
after reset,
but I can remove the update of outbound gpio lines in the reset function.


>
> > +}
>
> > +typedef enum AWGPIOLevel {
> > +    AW_GPIO_LEVEL_LOW =3D 0,
> > +    AW_GPIO_LEVEL_HIGH =3D 1,
> > +} AWGPIOLevel;
> > +
> > +typedef enum AWGPIOCfg {
> > +    AW_GPIO_CFG_IN =3D 0,
> > +    AW_GPIO_CFG_OUT =3D 1,
> > +    AW_GPIO_CFG_FUN =3D 2,
> > +    /* Use only fun for testing */
>
> What does this comment mean ?
>

Another note to myself that I forgot to remove; it was an indicator that th=
e
FUN setting (alternate function) is not used in the code, and in the end,
not in testing.

It will be removed.


>
> > +} AWGPIOCfg;
>
> > diff --git a/include/hw/gpio/allwinner-gpio.h
> b/include/hw/gpio/allwinner-gpio.h
> > new file mode 100644
> > index 0000000000..f6778d1893
> > --- /dev/null
> > +++ b/include/hw/gpio/allwinner-gpio.h
> > @@ -0,0 +1,41 @@
> > +/*
> > + *  Allwinner GPIO registers definition
> > + *
> > + *  Copyright (C) 2026 Strahinja Jankovic. <
> strahinja.p.jankovic@gmail.com>
> > + *
> > + *  SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef ALLWINNER_GPIO_H
> > +#define ALLWINNER_GPIO_H
> > +
> > +#include "hw/core/sysbus.h"
> > +#include "qom/object.h"
> > +
> > +/** Size of register I/O address space used by GPIO device */
> > +#define AW_GPIO_IOSIZE (0x400)
>
> You don't need brackets around single values.
>

Ok.

Best regards,
Strahinja Jankovic


>
> > +
> > +/** Total number of known registers */
> > +#define AW_GPIO_REGS_NUM    (AW_GPIO_IOSIZE / sizeof(uint32_t))
> > +
> > +/** Max number of ports */
> > +#define AW_GPIO_PORTS_NUM   9
> > +/** Max number of pins per ports */
> > +#define AW_GPIO_PIN_COUNT 32
> > +
> > +#define TYPE_AW_GPIO        "allwinner.gpio"
> > +OBJECT_DECLARE_SIMPLE_TYPE(AWGPIOState, AW_GPIO)
> > +
> > +struct AWGPIOState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    MemoryRegion iomem;
> > +    qemu_irq irq;
> > +    qemu_irq output[AW_GPIO_PORTS_NUM][AW_GPIO_PIN_COUNT];
> > +
> > +    uint32_t regs[AW_GPIO_REGS_NUM];
> > +};
> > +
> > +#endif /* ALLWINNER_GPIO_H */
>
> thanks
> -- PMM
>

--000000000000d2430f065b25dc69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Peter,<div><br></div><div>Thanks for t=
aking time to review these patches.</div></div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep =
8, 2026 at 3:59=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydel=
l@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Sat, 29 Aug 2026 at 13:56, Strahin=
ja Jankovic<br>
&lt;<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank">str=
ahinja.p.jankovic@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch implements Allwinner A10 GPIO peripheral emulation.<br>
&gt;<br>
&gt; The emulation focuses on input/output and interrupt functionality,<br>
&gt; whereas the drive and pull up/down functionality is not emulated.<br>
&gt;<br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
<br>
Thanks for this patch; my comments below are generally minor ones.<br>
<br>
&gt; +static bool gpio_is_input(AWPortMap *port, uint32_t pin);<br>
&gt; +static int int_ctl_cfg(AWGPIOState *s, int irq_line);<br>
<br>
I think you could just move the definitions of these functions<br>
to here rather than having forward declarations.<br>
<br></blockquote><div><br></div><div>I will move definitions here.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +static inline void allwinner_gpio_update_int(AWGPIOState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(s-&gt;regs[REG_INDEX(GPIO_INT_CTL)] &a=
mp; s-&gt;regs[REG_INDEX(GPIO_INT_STA)])<br>
&gt; +=C2=A0 =C2=A0 );<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_gpio_set_int_line(AWGPIOState *s, int port,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
line, AWGPIOLevel level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 int irq_line =3D irq_nr(port, line);<br>
&gt; +=C2=A0 =C2=A0 bool raise_irq =3D false;<br>
&gt; +=C2=A0 =C2=A0 unsigned input_val;<br>
&gt; +=C2=A0 =C2=A0 int int_cfg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Check if pin can actually trigger an interrupt */<br=
>
&gt; +=C2=A0 =C2=A0 if (irq_line =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* if this signal isn&#39;t configured as an input sign=
al, nothing to do */<br>
&gt; +=C2=A0 =C2=A0 if (!gpio_is_input(&amp;o-&gt;ports[port], line)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Get current input value */<br>
&gt; +=C2=A0 =C2=A0 input_val =3D extract32(o-&gt;ports[port].dat, line, 1)=
;<br>
&gt; +=C2=A0 =C2=A0 int_cfg =3D int_ctl_cfg(s, irq_line);<br>
<br>
I was tempted to suggest that maybe we could work on more than<br>
one pin at a time (compare cc57a945feb090), but the way the config<br>
is stored in registers for this device makes that too awkward,<br>
unfortunately.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (int_cfg) {<br>
&gt; +=C2=A0 =C2=A0 case AW_GPIO_IRQ_CFG_RISING_EDGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!input_val &amp;&amp; level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case AW_GPIO_IRQ_CFG_FALLING_EDGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (input_val &amp;&amp; !level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case AW_GPIO_IRQ_CFG_HIGH_LEVEL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case AW_GPIO_IRQ_CFG_LOW_LEVEL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case AW_GPIO_IRQ_CFG_BOTH_EDGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (input_val !=3D level) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise_irq =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Unexpected */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (raise_irq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(GPIO_INT_STA)] |=3D =
1u &lt;&lt; irq_line;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void port_set_all_int_lines(AWGPIOState *s, int port)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_PINS_PER_PORT[port]; i++) {<br>
<br>
Our coding style these days prefers &quot;for (int i =3D ... )&quot;<br>
where the variable is only used as a loop iterator.<br></blockquote><div><b=
r></div><div>Ok!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AWGPIOLevel aw_level =3D extract32(o-&gt;=
ports[port].dat, i, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_gpio_set_int_line(s, port, i, a=
w_level);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 allwinner_gpio_update_int(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_set_all_int_lines(AWGPIOState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; AW_GPIO_PORTS_NUM; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_set_all_int_lines(s, i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_gpio_set(void *opaque, int port, int line, int =
level)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWGPIOState *s =3D AW_GPIO(opaque);<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 AWGPIOLevel aw_level =3D level ? AW_GPIO_LEVEL_HIGH : A=
W_GPIO_LEVEL_LOW;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (gpio_is_input(&amp;o-&gt;ports[port], line)) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_allwinner_gpio_set(portname(port), =
line, aw_level);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_gpio_set_int_line(s, port, line=
, aw_level);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].dat =3D (o-&gt;ports[po=
rt].dat &amp; ~(1u &lt;&lt; line)) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(aw_level &lt;&lt; line);<br>
<br>
This is better written with deposit32(), I think.<br></blockquote><div><br>=
</div><div>I will try with deposit32().</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 allwinner_gpio_update_int(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_P=
IN_STRIDE;<br>
&gt; +=C2=A0 =C2=A0 return (extract32(port-&gt;cfg[cfg_n], pin_shift, CFG_P=
IN_STRIDE - 1) =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CFG_OUTPUT_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;<br>
&gt; +=C2=A0 =C2=A0 uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_P=
IN_STRIDE;<br>
&gt; +=C2=A0 =C2=A0 return (extract32(port-&gt;cfg[cfg_n], pin_shift, CFG_P=
IN_STRIDE - 1) =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CFG_INPUT_MASK);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned int_cfg_n =3D s-&gt;regs[REG_INDEX(GPIO_INT_CF=
G0) + irq_line / 8];<br>
&gt; +=C2=A0 =C2=A0 return extract32(int_cfg_n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(irq_line % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0INT_CFG_IRQ_STRIDE - 1);<br>
<br>
The datasheet says these fields are 4 bits, so shouldn&#39;t the<br>
third argument here be INT_CFG_IRQ_STRIDE, not ... - 1 ?<br>
This is different fromthe port config registers, which are<br>
documented as 3 bit fields separated by a reserved bit.<br></blockquote><di=
v><br></div><div>The fields are 4 bits only, but the maximum non-reserved v=
alue is 4, so nothing is lost if only 3 bits are used.</div><div>However, i=
n order to keep the code more readable, I will change to INT_CFG_IRQ_STRIDE=
 and add a check</div><div>when writing that only non-reserved values are w=
ritten.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void port_update_output_lines(AWGPIOState *s, uint32_t =
port)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 int pin;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (pin =3D 0; pin &lt; AW_PINS_PER_PORT[port]; pin++)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpio_is_output(&amp;o-&gt;ports[port]=
, pin)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;output[p=
ort][pin],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!!(o-&gt;ports[port].dat &amp; BIT_MASK(pin)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_allwinner_gpio_out_pi=
n(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 portname(port=
), pin,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(o-&gt;port=
s[port].dat &amp; BIT_MASK(pin)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (gpio_is_input(&amp;o-&gt;ports[p=
ort], pin)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_lower(s-&gt;output=
[port][pin]);<br>
<br>
Shouldn&#39;t the way we handle the output GPIO line be the same<br>
for both &quot;this is configured as an input&quot; and &quot;this is confi=
gured<br>
as neither an input or an output&quot; ?<br></blockquote><div><br></div><di=
v>My idea was that the output pins should not be changed by the GPIO contro=
ller if</div><div>they are assigned to an alternate function/another periph=
eral, since they should</div><div>change values according=C2=A0<span style=
=3D"background-color:transparent">to that function. However, since the alte=
rnate function</span></div><div><span style=3D"background-color:transparent=
">connection to other peripherals is not modeled, then these pins might as =
well be</span></div><div>fixed to low value if the pin is not configured as=
 output.</div><div><br></div><div>I will change this.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState=
 *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 for (int port =3D 0; port &lt; AW_GPIO_PORTS_NUM; port+=
+) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_update_output_lines(s, port);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static uint64_t allwinner_gpio_read(void *opaque, hwaddr offset, unsi=
gned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWGPIOState *s =3D AW_GPIO(opaque);<br>
&gt; +=C2=A0 =C2=A0 uint32_t reg_value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *regname =3D allwinner_gpio_get_regname=
(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case 0 ... GPIO_Pn_PUL1(GPIO_PI):<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_CFG0:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_CFG1:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_CFG2:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_CFG3:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_CTL:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_STA:<br>
&gt; +=C2=A0 =C2=A0 case GPIO_INT_DEB:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_value =3D s-&gt;regs[REG_INDEX(offset=
)];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;[%s]=
%s: Bad register at offset 0x%&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 HWADDR_PRIx &quot;\n&quot;, TYPE_AW_GPIO, __func__, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_gpio_read(regname, reg_value);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return reg_value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* update output values */<br>
&gt; +/* update interrupts */<br>
<br>
These comments seem like they&#39;re in the wrong place ?<br></blockquote><=
div><br></div><div>Correct, I will remove them.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +static void allwinner_port_write(AWGPIOState *s, hwaddr offset, uint6=
4_t value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 uint32_t port =3D offset / PORT_STRIDE;<br>
&gt; +=C2=A0 =C2=A0 uint32_t reg =3D offset % PORT_STRIDE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case CFG0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].cfg[0] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_CFG0_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CFG1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].cfg[1] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_CFG1_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CFG2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].cfg[2] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_CFG2_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case CFG3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].cfg[3] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_CFG3_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case DAT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].dat =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_DAT_PINS_M=
ASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case DRV0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].drv[0] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_DRV0_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case DRV1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].drv[1] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_DRV1_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case PUL0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].pul[0] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_PUL0_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case PUL1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].pul[1] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp; GPIO_PUL1_PINS_=
MASK(AW_PINS_PER_PORT[port]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 port_update_output_lines(s, port);<br>
&gt; +=C2=A0 =C2=A0 port_set_all_int_lines(s, port);<br>
&gt; +}<br>
<br>
&gt; +static void allwinner_gpio_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AWGPIOState *s =3D AW_GPIO(dev);<br>
&gt; +=C2=A0 =C2=A0 AWPortsOverlay *o =3D (AWPortsOverlay *)s-&gt;regs;<br>
&gt; +=C2=A0 =C2=A0 int port =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(s-&gt;regs, 0, AW_GPIO_IOSIZE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (port =3D 0; port &lt; AW_GPIO_PORTS_NUM; port++) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].drv[0] =3D aw_gpio_port=
_reset[port].drv[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].drv[1] =3D aw_gpio_port=
_reset[port].drv[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].pul[0] =3D aw_gpio_port=
_reset[port].pul[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ports[port].pul[1] =3D aw_gpio_port=
_reset[port].pul[1];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 allwinner_gpio_update_all_output_lines(s);<br>
&gt; +=C2=A0 =C2=A0 allwinner_gpio_update_int(s);<br>
<br>
Generally we say you shouldn&#39;t update gpio lines outbound<br>
in a reset function.<br></blockquote><div><br></div><div>My idea was to mak=
e certain that all pins are low and interrupt is not set after reset,</div>=
<div>but I can remove the update of outbound gpio lines in the reset functi=
on.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; +}<br>
<br>
&gt; +typedef enum AWGPIOLevel {<br>
&gt; +=C2=A0 =C2=A0 AW_GPIO_LEVEL_LOW =3D 0,<br>
&gt; +=C2=A0 =C2=A0 AW_GPIO_LEVEL_HIGH =3D 1,<br>
&gt; +} AWGPIOLevel;<br>
&gt; +<br>
&gt; +typedef enum AWGPIOCfg {<br>
&gt; +=C2=A0 =C2=A0 AW_GPIO_CFG_IN =3D 0,<br>
&gt; +=C2=A0 =C2=A0 AW_GPIO_CFG_OUT =3D 1,<br>
&gt; +=C2=A0 =C2=A0 AW_GPIO_CFG_FUN =3D 2,<br>
&gt; +=C2=A0 =C2=A0 /* Use only fun for testing */<br>
<br>
What does this comment mean ?<br></blockquote><div><br></div><div>Another n=
ote to myself that I forgot to remove; it was an indicator that the</div><d=
iv>FUN setting (alternate function) is not used in the code, and in the end=
, not in testing.</div><div><br></div><div>It will be removed.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +} AWGPIOCfg;<br>
<br>
&gt; diff --git a/include/hw/gpio/allwinner-gpio.h b/include/hw/gpio/allwin=
ner-gpio.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..f6778d1893<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/gpio/allwinner-gpio.h<br>
&gt; @@ -0,0 +1,41 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 Allwinner GPIO registers definition<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (C) 2026 Strahinja Jankovic. &lt;<a href=3D"mailto=
:strahinja.p.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gma=
il.com</a>&gt;<br>
&gt; + *<br>
&gt; + *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef ALLWINNER_GPIO_H<br>
&gt; +#define ALLWINNER_GPIO_H<br>
&gt; +<br>
&gt; +#include &quot;hw/core/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +/** Size of register I/O address space used by GPIO device */<br>
&gt; +#define AW_GPIO_IOSIZE (0x400)<br>
<br>
You don&#39;t need brackets around single values.<br></blockquote><div><br>=
</div><div>Ok.</div><div><br></div><div>Best regards,</div><div>Strahinja J=
ankovic</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; +<br>
&gt; +/** Total number of known registers */<br>
&gt; +#define AW_GPIO_REGS_NUM=C2=A0 =C2=A0 (AW_GPIO_IOSIZE / sizeof(uint32=
_t))<br>
&gt; +<br>
&gt; +/** Max number of ports */<br>
&gt; +#define AW_GPIO_PORTS_NUM=C2=A0 =C2=A09<br>
&gt; +/** Max number of pins per ports */<br>
&gt; +#define AW_GPIO_PIN_COUNT 32<br>
&gt; +<br>
&gt; +#define TYPE_AW_GPIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;allwinner.gpio&=
quot;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AWGPIOState, AW_GPIO)<br>
&gt; +<br>
&gt; +struct AWGPIOState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq output[AW_GPIO_PORTS_NUM][AW_GPIO_PIN_COUNT];<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[AW_GPIO_REGS_NUM];<br>
&gt; +};<br>
&gt; +<br>
&gt; +#endif /* ALLWINNER_GPIO_H */<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000d2430f065b25dc69--

