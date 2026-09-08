Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE818C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wLz-00039d-Vc; Tue, 08 Sep 2026 09:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wLy-000390-Bi
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:59:14 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wLv-0005k6-PE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:59:13 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-866e57f63a3so49787707b3.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788875950; cv=none;
 d=google.com; s=arc-20260327;
 b=lqn+jrcNOLgqDSX1Byd+ZqgOfrov1+Hfxj9ncscWHMxnYKXg3eCpLC3275IIDxeccL
 23fUGVMWXfbS/CIyfRHbT+IoJWjxwT2++3fmGg1S/glWtfgaZ+B7SBvCG+f8/y54vgEE
 AgXcOCi8E9DDRsLuuqJ4GLOfgT+FnCWtQIPfqWBKb3WIvMbEqVTJJLIgDAEikJR7I7If
 +hfZg1pnmN9GRtN0e9+pjKjmU2Fy7dGzt4uHY4eT0yEiLueXWwDL+mqKPtjmicsM49dR
 07c4ngxMR70NOR34DBro0rnGW7GVj+cgZh7xG+KvmrHU0UrlKgezLs1xLevG65rUA9yT
 4PGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2N6NqqngonEXamfr3w4MfigzZ2G88US0B0zFtJdlYuo=;
 fh=gicmf1zLCz5mLo37/slHRwiGNwG9FuwwhzHTeCt9t94=;
 b=b4XjjI2LIUQxkqhBGOlcIYA91VfiXcOP1o8gQa3Gil5ah3qmqNSxGyXhhjbHncUgAX
 AyFq0lUG7iyszsnbiNRbazKbBhybwzbknFla3NEtRHENH8pfH9MBIYRAWjaTBK6NzrID
 kv0vmV4zabnN38dKwsD/SiRD3zWKBZgRISLn/8iNGO1j9jR3Qf2Iw+80OAI/7A1Cj34x
 vtvbJEuSrdaCbrtO7s5ffi0YK+0uliU24PzzvD/Y1PKaMgoFNminklqbTq0l+Ith2GrY
 meSmCMqRWBMFgNHA/lzzrxWYi7I/hO2bTkhLTX1jkcwuqLD+NwGRBBDP9k+29XrcnLTJ
 U4Xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788875950; x=1789480750; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2N6NqqngonEXamfr3w4MfigzZ2G88US0B0zFtJdlYuo=;
 b=sr5DB6PRn4PhCh4bJ5U/28h1SWfDNgKCW1OKdJc3GdMOU5Fxoi6PyLkmWEixOUwCnR
 KGQI0NLWTt04aaSd8cwC1ZiVmdbfFvg/Bax5sqvq/W89aR9moRfeFbV58fwHua+nnF26
 VZ9cehKxV84PL9LYUC+0sB6sKhmTKzFWf8ZaafzD1R0s8/vAfH73NSLA7MiKKhUqmOpi
 Ji31HrRuHWS8psryfXxJlzPPaSMLy3Zz/y5xjWMRu9UHkVeuw8CPJ6FWFsHR7B+k2Dn8
 j6jys2igcevS76K3Gy8Got1ALeug7boMDVR8M3+KdNCv9+B/dHYQEafbeAfrdd/3TuNx
 MkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788875950; x=1789480750;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2N6NqqngonEXamfr3w4MfigzZ2G88US0B0zFtJdlYuo=;
 b=VlhyuFvlVtOguEDHKNhbzq7LKNf3f3CkXfl9nolBaqTKo6DdfP/jIwiv65J5jbkmNd
 04yTCOC2SwFYzZX14QWE5Vf8lfdrf2+mGkVHm+/UBHYlmq8Cky0mKUVkaLpctychf9L5
 v+bRVNWjmNFwJwT9EYCi4LE6AQTtPjEmvxYwpXg6rK92BXAykeqmuEHE/8XnCQURfto7
 ENgT8VoeUHbJDal9L3NpVLv0cdDCwmp8J3mNaPY1WWZrUWgMIZsg1ga9/T5/RtEve0dZ
 DK8HCgPvKvTkGCkQgcQZus7wUv4iKlg90c69hAkNwx85nzr+0xsvtw0SdzLfNVHqxXmN
 0BVA==
X-Gm-Message-State: AFuF++mzTON6w+oEvA7e0Va3aJuUG8gyKj4Na5x6gJvK4kg9R8JD4w0M
 g7YccRYuH8pWIV402rxzmIJdTQA7xx9rR4rwEnAN2JxYeN+3KZCI7yPeZsyv65W2T/Gk7PbYqms
 PY+l78RsQniZoKJKBOu0j+7/oFOR/D5TUwxh4FSe4WA==
X-Gm-Gg: AYBFou1eAsStIy+/QqNtZJcMndO3106/WRi4Wf2sprHGLOsoJbZqWr7tArFZNDn3d8Q
 soe3XxxXLqvDGkgxa0EEnvR+r74YSl/WiE/u59PhnsCeFFJIxPc3TNNLVb8z2NjxwYMUX+vqQko
 jgKlSfz9DkypWZ87ikpZtC3aH2+R0p4PE7XQ9K5dbZ9vtutIr4qGjbYSphrIo91jn1AucQquP1R
 MWkh4DJa9b3TStu5pLLz/k9VQoZNZi8SyjNnH5RB1MO0bpUW0QJRzmKlF7A8TdwVn5HRiAOGFRL
 N8n40fkuN0+dMRkbtkz9O64sW45Hsc6rB1uR40VfgWP0AhUiYx0PxXAevIn9Vw150W1xyh8Q7tW
 YWHgdar5ZtLJ8WbmAL/g6DLvxtnuj
X-Received: by 2002:a05:690c:e64e:b0:870:7983:948a with SMTP id
 00721157ae682-8712259c772mr69096467b3.4.1788875949883; Tue, 08 Sep 2026
 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-allwinner-gpio-v2-0-f0ebcb07302e@gmail.com>
 <20260829-allwinner-gpio-v2-1-f0ebcb07302e@gmail.com>
In-Reply-To: <20260829-allwinner-gpio-v2-1-f0ebcb07302e@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 14:58:58 +0100
X-Gm-Features: AcwNN1V98cHjmjewk7THNFBvtH7D1nCcsqNnVxtLoVpTR6hkTe9s8WU90NzWFxw
Message-ID: <CAFEAcA-hGo_3wfve0bt2wq=00hYpLjgCN0oyQTaR3WGmFhoBBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/gpio: Allwinner A10 GPIO emulation
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jack wang <163wangjack@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
> This patch implements Allwinner A10 GPIO peripheral emulation.
>
> The emulation focuses on input/output and interrupt functionality,
> whereas the drive and pull up/down functionality is not emulated.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

Thanks for this patch; my comments below are generally minor ones.

> +static bool gpio_is_input(AWPortMap *port, uint32_t pin);
> +static int int_ctl_cfg(AWGPIOState *s, int irq_line);

I think you could just move the definitions of these functions
to here rather than having forward declarations.

> +
> +static inline void allwinner_gpio_update_int(AWGPIOState *s)
> +{
> +    qemu_set_irq(
> +        s->irq,
> +        !!(s->regs[REG_INDEX(GPIO_INT_CTL)] & s->regs[REG_INDEX(GPIO_INT_STA)])
> +    );
> +}
> +
> +static void allwinner_gpio_set_int_line(AWGPIOState *s, int port,
> +                                        int line, AWGPIOLevel level)
> +{
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    int irq_line = irq_nr(port, line);
> +    bool raise_irq = false;
> +    unsigned input_val;
> +    int int_cfg;
> +
> +    /* Check if pin can actually trigger an interrupt */
> +    if (irq_line == -1) {
> +        return;
> +    }
> +
> +    /* if this signal isn't configured as an input signal, nothing to do */
> +    if (!gpio_is_input(&o->ports[port], line)) {
> +        return;
> +    }
> +
> +    /* Get current input value */
> +    input_val = extract32(o->ports[port].dat, line, 1);
> +    int_cfg = int_ctl_cfg(s, irq_line);

I was tempted to suggest that maybe we could work on more than
one pin at a time (compare cc57a945feb090), but the way the config
is stored in registers for this device makes that too awkward,
unfortunately.

> +
> +    switch (int_cfg) {
> +    case AW_GPIO_IRQ_CFG_RISING_EDGE:
> +        if (!input_val && level) {
> +            raise_irq = true;
> +        }
> +        break;
> +    case AW_GPIO_IRQ_CFG_FALLING_EDGE:
> +        if (input_val && !level) {
> +            raise_irq = true;
> +        }
> +        break;
> +    case AW_GPIO_IRQ_CFG_HIGH_LEVEL:
> +        if (level) {
> +            raise_irq = true;
> +        }
> +        break;
> +    case AW_GPIO_IRQ_CFG_LOW_LEVEL:
> +        if (!level) {
> +            raise_irq = true;
> +        }
> +        break;
> +    case AW_GPIO_IRQ_CFG_BOTH_EDGE:
> +        if (input_val != level) {
> +            raise_irq = true;
> +        }
> +        break;
> +    default:
> +        /* Unexpected */
> +        break;
> +    }
> +
> +    if (raise_irq) {
> +        s->regs[REG_INDEX(GPIO_INT_STA)] |= 1u << irq_line;
> +    }
> +}
> +
> +static void port_set_all_int_lines(AWGPIOState *s, int port)
> +{
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    int i;
> +
> +    for (i = 0; i < AW_PINS_PER_PORT[port]; i++) {

Our coding style these days prefers "for (int i = ... )"
where the variable is only used as a loop iterator.

> +        AWGPIOLevel aw_level = extract32(o->ports[port].dat, i, 1);
> +        allwinner_gpio_set_int_line(s, port, i, aw_level);
> +    }
> +
> +    allwinner_gpio_update_int(s);
> +}
> +
> +static void allwinner_set_all_int_lines(AWGPIOState *s)
> +{
> +    int i;
> +
> +    for (i = 0; i < AW_GPIO_PORTS_NUM; i++) {
> +        port_set_all_int_lines(s, i);
> +    }
> +}
> +
> +static void allwinner_gpio_set(void *opaque, int port, int line, int level)
> +{
> +    AWGPIOState *s = AW_GPIO(opaque);
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    AWGPIOLevel aw_level = level ? AW_GPIO_LEVEL_HIGH : AW_GPIO_LEVEL_LOW;
> +
> +    if (gpio_is_input(&o->ports[port], line)) {
> +
> +        trace_allwinner_gpio_set(portname(port), line, aw_level);
> +
> +        allwinner_gpio_set_int_line(s, port, line, aw_level);
> +
> +        o->ports[port].dat = (o->ports[port].dat & ~(1u << line)) |
> +                             (aw_level << line);

This is better written with deposit32(), I think.

> +    }
> +    allwinner_gpio_update_int(s);
> +}
> +
> +
> +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
> +{
> +    uint32_t cfg_n = pin / CFG_PINS_PER_REG;
> +    uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
> +        CFG_OUTPUT_MASK);
> +}
> +
> +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
> +{
> +    uint32_t cfg_n = pin / CFG_PINS_PER_REG;
> +    uint32_t pin_shift = (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - 1) ==
> +        CFG_INPUT_MASK);
> +}
> +
> +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
> +{
> +    unsigned int_cfg_n = s->regs[REG_INDEX(GPIO_INT_CFG0) + irq_line / 8];
> +    return extract32(int_cfg_n,
> +                     (irq_line % INT_CFG_IRQ_PER_REG) * INT_CFG_IRQ_STRIDE,
> +                     INT_CFG_IRQ_STRIDE - 1);

The datasheet says these fields are 4 bits, so shouldn't the
third argument here be INT_CFG_IRQ_STRIDE, not ... - 1 ?
This is different fromthe port config registers, which are
documented as 3 bit fields separated by a reserved bit.

> +}
> +
> +static inline void port_update_output_lines(AWGPIOState *s, uint32_t port)
> +{
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    int pin;
> +
> +    for (pin = 0; pin < AW_PINS_PER_PORT[port]; pin++) {
> +        if (gpio_is_output(&o->ports[port], pin)) {
> +            qemu_set_irq(s->output[port][pin],
> +                         !!(o->ports[port].dat & BIT_MASK(pin)));
> +            trace_allwinner_gpio_out_pin(
> +                portname(port), pin,
> +                !!(o->ports[port].dat & BIT_MASK(pin)));
> +         }
> +        else if (gpio_is_input(&o->ports[port], pin)) {
> +            qemu_irq_lower(s->output[port][pin]);

Shouldn't the way we handle the output GPIO line be the same
for both "this is configured as an input" and "this is configured
as neither an input or an output" ?

> +        }
> +    }
> +}
> +
> +static inline void allwinner_gpio_update_all_output_lines(AWGPIOState *s)
> +{
> +    for (int port = 0; port < AW_GPIO_PORTS_NUM; port++) {
> +        port_update_output_lines(s, port);
> +    }
> +}
> +
> +
> +static uint64_t allwinner_gpio_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AWGPIOState *s = AW_GPIO(opaque);
> +    uint32_t reg_value = 0;
> +    g_autofree char *regname = allwinner_gpio_get_regname(offset);
> +
> +    switch (offset) {
> +    case 0 ... GPIO_Pn_PUL1(GPIO_PI):
> +    case GPIO_INT_CFG0:
> +    case GPIO_INT_CFG1:
> +    case GPIO_INT_CFG2:
> +    case GPIO_INT_CFG3:
> +    case GPIO_INT_CTL:
> +    case GPIO_INT_STA:
> +    case GPIO_INT_DEB:
> +        reg_value = s->regs[REG_INDEX(offset)];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
> +                      HWADDR_PRIx "\n", TYPE_AW_GPIO, __func__, offset);
> +        break;
> +    }
> +
> +    trace_allwinner_gpio_read(regname, reg_value);
> +
> +    return reg_value;
> +}
> +
> +/* update output values */
> +/* update interrupts */

These comments seem like they're in the wrong place ?

> +static void allwinner_port_write(AWGPIOState *s, hwaddr offset, uint64_t value)
> +{
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    uint32_t port = offset / PORT_STRIDE;
> +    uint32_t reg = offset % PORT_STRIDE;
> +
> +    switch (reg) {
> +    case CFG0:
> +        o->ports[port].cfg[0] =
> +            value & GPIO_CFG0_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case CFG1:
> +        o->ports[port].cfg[1] =
> +            value & GPIO_CFG1_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case CFG2:
> +        o->ports[port].cfg[2] =
> +            value & GPIO_CFG2_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case CFG3:
> +        o->ports[port].cfg[3] =
> +            value & GPIO_CFG3_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case DAT:
> +        o->ports[port].dat =
> +            value & GPIO_DAT_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case DRV0:
> +        o->ports[port].drv[0] =
> +            value & GPIO_DRV0_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case DRV1:
> +        o->ports[port].drv[1] =
> +            value & GPIO_DRV1_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case PUL0:
> +        o->ports[port].pul[0] =
> +            value & GPIO_PUL0_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    case PUL1:
> +        o->ports[port].pul[1] =
> +            value & GPIO_PUL1_PINS_MASK(AW_PINS_PER_PORT[port]);
> +        break;
> +    }
> +    port_update_output_lines(s, port);
> +    port_set_all_int_lines(s, port);
> +}

> +static void allwinner_gpio_reset(DeviceState *dev)
> +{
> +    AWGPIOState *s = AW_GPIO(dev);
> +    AWPortsOverlay *o = (AWPortsOverlay *)s->regs;
> +    int port = 0;
> +
> +    memset(s->regs, 0, AW_GPIO_IOSIZE);
> +
> +    for (port = 0; port < AW_GPIO_PORTS_NUM; port++) {
> +        o->ports[port].drv[0] = aw_gpio_port_reset[port].drv[0];
> +        o->ports[port].drv[1] = aw_gpio_port_reset[port].drv[1];
> +        o->ports[port].pul[0] = aw_gpio_port_reset[port].pul[0];
> +        o->ports[port].pul[1] = aw_gpio_port_reset[port].pul[1];
> +    }
> +
> +    allwinner_gpio_update_all_output_lines(s);
> +    allwinner_gpio_update_int(s);

Generally we say you shouldn't update gpio lines outbound
in a reset function.

> +}

> +typedef enum AWGPIOLevel {
> +    AW_GPIO_LEVEL_LOW = 0,
> +    AW_GPIO_LEVEL_HIGH = 1,
> +} AWGPIOLevel;
> +
> +typedef enum AWGPIOCfg {
> +    AW_GPIO_CFG_IN = 0,
> +    AW_GPIO_CFG_OUT = 1,
> +    AW_GPIO_CFG_FUN = 2,
> +    /* Use only fun for testing */

What does this comment mean ?

> +} AWGPIOCfg;

> diff --git a/include/hw/gpio/allwinner-gpio.h b/include/hw/gpio/allwinner-gpio.h
> new file mode 100644
> index 0000000000..f6778d1893
> --- /dev/null
> +++ b/include/hw/gpio/allwinner-gpio.h
> @@ -0,0 +1,41 @@
> +/*
> + *  Allwinner GPIO registers definition
> + *
> + *  Copyright (C) 2026 Strahinja Jankovic. <strahinja.p.jankovic@gmail.com>
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ALLWINNER_GPIO_H
> +#define ALLWINNER_GPIO_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +/** Size of register I/O address space used by GPIO device */
> +#define AW_GPIO_IOSIZE (0x400)

You don't need brackets around single values.

> +
> +/** Total number of known registers */
> +#define AW_GPIO_REGS_NUM    (AW_GPIO_IOSIZE / sizeof(uint32_t))
> +
> +/** Max number of ports */
> +#define AW_GPIO_PORTS_NUM   9
> +/** Max number of pins per ports */
> +#define AW_GPIO_PIN_COUNT 32
> +
> +#define TYPE_AW_GPIO        "allwinner.gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(AWGPIOState, AW_GPIO)
> +
> +struct AWGPIOState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    qemu_irq output[AW_GPIO_PORTS_NUM][AW_GPIO_PIN_COUNT];
> +
> +    uint32_t regs[AW_GPIO_REGS_NUM];
> +};
> +
> +#endif /* ALLWINNER_GPIO_H */

thanks
-- PMM

