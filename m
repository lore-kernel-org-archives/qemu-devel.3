Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449AFCF9C5B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 01:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssu5x-0002Rm-3d; Mon, 23 Sep 2024 21:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1ssu5t-0002Oi-D9; Mon, 23 Sep 2024 21:11:57 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1ssu5q-0000NU-2W; Mon, 23 Sep 2024 21:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1727140303;
 bh=KE9sww++CJx+C8i++dIcQH/HJSLKgCHP5xKW+iDAyEs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=LbKD6AU20TkJU5ElNlG2iX05RDIGsumy0nMMH4PcyIadOtbkDd1ZBjmHfoW+flJMk
 w7u2JqiA5LNqGkllY1wiCfWtwdcUrf1ZcCU9xaz+w5v5ewyFRslAj1mWdiF2PvgBDz
 UHApn0VgQZBC0VJr2JdX9HtCQFPScrA7akrb35x6P3pOb/qOpSIKinCHdIOCkHzmD+
 rs2LpUjB7XOUSj+uW6rRJWfoAPhZeQHQc+kd3LjxPlV6oLFVVWmUkeumQyDEfPPqFe
 lhI4ZXycNFpnFT6Kaxir+pSJ26eMooUkBe4L4Qvpaz6DqmvCmfNqnsetk321YSYUSA
 cZX3/HM/Yf4sA==
Received: from [192.168.68.112]
 (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DBC3365013;
 Tue, 24 Sep 2024 09:11:40 +0800 (AWST)
Message-ID: <e5d149765b338d4754054691cb83eacdf3e2642f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Tue, 24 Sep 2024 10:41:39 +0930
In-Reply-To: <20240923094206.1455783-5-jamin_lin@aspeedtech.com>
References: <20240923094206.1455783-1-jamin_lin@aspeedtech.com>
 <20240923094206.1455783-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jamin,

On Mon, 2024-09-23 at 17:42 +0800, Jamin Lin wrote:
> AST2700 integrates two set of Parallel GPIO Controller
> with maximum 212 control pins, which are 27 groups.
> (H, exclude pin: H7 H6 H5 H4)
>=20
> In the previous design of ASPEED SOCs,
> one register is used for setting one function for one set which are 32 pi=
ns
> and 4 groups.
> ex: GPIO000 is used for setting data value for GPIO A, B, C and D in AST2=
600.
> ex: GPIO004 is used for setting direction for GPIO A, B, C and D in AST26=
00.
>=20
> However, the register set have a significant change since AST2700.
> Each GPIO pin has their own individual control register. In other words, =
users are able to
> set one GPIO pin=E2=80=99s direction, interrupt enable, input mask and so=
 on
> in the same one register.
>=20
> Currently, aspeed_gpio_read/aspeed_gpio_write callback functions
> are not compatible AST2700.
> Introduce new aspeed_gpio_2700_read/aspeed_gpio_2700_write callback funct=
ions
> and aspeed_gpio_2700_ops memory region operation for AST2700.
> Introduce a new ast2700 class to support AST2700.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/gpio/aspeed_gpio.c | 373 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 373 insertions(+)
>=20
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index f23ffae34d..e3d5556dc1 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -227,6 +227,38 @@ REG32(GPIO_INDEX_REG, 0x2AC)
>      FIELD(GPIO_INDEX_REG, COMMAND_SRC_1, 21, 1)
>      FIELD(GPIO_INDEX_REG, INPUT_MASK, 20, 1)
> =20
> +/* AST2700 GPIO Register Address Offsets */
> +REG32(GPIO_2700_DEBOUNCE_TIME_1, 0x000)
> +REG32(GPIO_2700_DEBOUNCE_TIME_2, 0x004)
> +REG32(GPIO_2700_DEBOUNCE_TIME_3, 0x008)
> +REG32(GPIO_2700_INT_STATUS_1, 0x100)
> +REG32(GPIO_2700_INT_STATUS_2, 0x104)
> +REG32(GPIO_2700_INT_STATUS_3, 0x108)
> +REG32(GPIO_2700_INT_STATUS_4, 0x10C)
> +REG32(GPIO_2700_INT_STATUS_5, 0x110)
> +REG32(GPIO_2700_INT_STATUS_6, 0x114)
> +REG32(GPIO_2700_INT_STATUS_7, 0x118)
> +/* GPIOA0 - GPIOAA7 Control Register*/
> +REG32(GPIO_A0_CONTROL, 0x180)
> +    SHARED_FIELD(GPIO_CONTROL_OUT_DATA, 0, 1)
> +    SHARED_FIELD(GPIO_CONTROL_DIRECTION, 1, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INT_ENABLE, 2, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INT_SENS_0, 3, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INT_SENS_1, 4, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INT_SENS_2, 5, 1)
> +    SHARED_FIELD(GPIO_CONTROL_RESET_TOLERANCE, 6, 1)
> +    SHARED_FIELD(GPIO_CONTROL_DEBOUNCE_1, 7, 1)
> +    SHARED_FIELD(GPIO_CONTROL_DEBOUNCE_2, 8, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INPUT_MASK, 9, 1)
> +    SHARED_FIELD(GPIO_CONTROL_BLINK_COUNTER_1, 10, 1)
> +    SHARED_FIELD(GPIO_CONTROL_BLINK_COUNTER_2, 11, 1)
> +    SHARED_FIELD(GPIO_CONTROL_INT_STATUS, 12, 1)
> +    SHARED_FIELD(GPIO_CONTROL_IN_DATA, 13, 1)
> +    SHARED_FIELD(GPIO_CONTROL_RESERVED, 14, 18)
> +REG32(GPIO_AA7_CONTROL, 0x4DC)
> +#define GPIO_2700_MEM_SIZE 0x4E0
> +#define GPIO_2700_REG_ARRAY_SIZE (GPIO_2700_MEM_SIZE >> 2)
> +
>  static int aspeed_evaluate_irq(GPIOSets *regs, int gpio_prev_high, int g=
pio)
>  {
>      uint32_t falling_edge =3D 0, rising_edge =3D 0;
> @@ -964,6 +996,309 @@ static void aspeed_gpio_set_pin(Object *obj, Visito=
r *v, const char *name,
>      aspeed_gpio_set_pin_level(s, set_idx, pin, level);
>  }
> =20
> +static uint64_t aspeed_gpio_read_control_reg(AspeedGPIOState *s, uint32_=
t pin)

This function is specific to the AST2700 and I think the name should
reflect that.

> +{
> +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> +    GPIOSets *set;
> +    uint64_t value =3D 0;
> +    uint32_t set_idx;
> +    uint32_t pin_idx;
> +
> +    set_idx =3D pin / ASPEED_GPIOS_PER_SET;
> +    pin_idx =3D pin % ASPEED_GPIOS_PER_SET;
> +
> +    if (set_idx >=3D agc->nr_gpio_sets) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: set index: %d, out of bounds=
\n",
> +                      __func__, set_idx);
> +        return 0;
> +    }
> +
> +    set =3D &s->sets[set_idx];
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_OUT_DATA,
> +                              extract32(set->data_read, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_DIRECTION,
> +                              extract32(set->direction, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_ENABLE,
> +                              extract32(set->int_enable, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_0,
> +                              extract32(set->int_sens_0, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_1,
> +                              extract32(set->int_sens_1, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_SENS_2,
> +                              extract32(set->int_sens_2, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_RESET_TOLERANCE,
> +                              extract32(set->reset_tol, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_DEBOUNCE_1,
> +                              extract32(set->debounce_1, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_DEBOUNCE_2,
> +                              extract32(set->debounce_2, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INPUT_MASK,
> +                              extract32(set->input_mask, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_INT_STATUS,
> +                              extract32(set->int_status, pin_idx, 1));
> +    value =3D SHARED_FIELD_DP32(value, GPIO_CONTROL_IN_DATA,
> +                              extract32(set->data_value, pin_idx, 1));
> +    return value;
> +}
> +
> +static void aspeed_gpio_write_control_reg(AspeedGPIOState *s,

Also should reflect it's specific to the AST2700?

> +                    uint32_t pin, uint32_t type, uint64_t data)
> +{
> +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> +    const GPIOSetProperties *props;
> +    GPIOSets *set;
> +    uint32_t cleared;
> +    uint32_t set_idx;
> +    uint32_t pin_idx;
> +    uint32_t group_value =3D 0;
> +
> +    set_idx =3D pin / ASPEED_GPIOS_PER_SET;
> +    pin_idx =3D pin % ASPEED_GPIOS_PER_SET;
> +
> +    if (set_idx >=3D agc->nr_gpio_sets) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: set index: %d, out of bounds=
\n",
> +                      __func__, set_idx);
> +        return;
> +    }
> +
> +    set =3D &s->sets[set_idx];
> +    props =3D &agc->props[set_idx];
> +
> +    /* direction */
> +    group_value =3D set->direction;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DIRECTI=
ON));
> +    /*
> +     *   where data is the value attempted to be written to the pin:
> +     *    pin type      | input mask | output mask | expected value
> +     *    ------------------------------------------------------------
> +     *   bidirectional  |   1       |   1        |  data
> +     *   input only     |   1       |   0        |   0
> +     *   output only    |   0       |   1        |   1
> +     *   no pin         |   0       |   0        |   0
> +     *
> +     *  which is captured by:
> +     *  data =3D ( data | ~input) & output;
> +     */
> +    group_value =3D (group_value | ~props->input) & props->output;
> +    set->direction =3D update_value_control_source(set, set->direction,
> +                                                 group_value);
> +
> +    /* out data */
> +    group_value =3D set->data_read;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_OUT_DAT=
A));
> +    group_value &=3D props->output;
> +    group_value =3D update_value_control_source(set, set->data_read,
> +                                                  group_value);
> +    set->data_read =3D group_value;
> +
> +    /* interrupt enable */
> +    group_value =3D set->int_enable;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_ENA=
BLE));
> +    set->int_enable =3D update_value_control_source(set, set->int_enable=
,
> +                                                  group_value);
> +
> +    /* interrupt sensitivity type 0 */
> +    group_value =3D set->int_sens_0;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SEN=
S_0));
> +    set->int_sens_0 =3D update_value_control_source(set, set->int_sens_0=
,
> +                                                  group_value);
> +
> +    /* interrupt sensitivity type 1 */
> +    group_value =3D set->int_sens_1;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SEN=
S_1));
> +    set->int_sens_1 =3D update_value_control_source(set, set->int_sens_1=
,
> +                                                  group_value);
> +
> +    /* interrupt sensitivity type 2 */
> +    group_value =3D set->int_sens_2;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_SEN=
S_2));
> +    set->int_sens_2 =3D update_value_control_source(set, set->int_sens_2=
,
> +                                                  group_value);
> +
> +    /* reset tolerance enable */
> +    group_value =3D set->reset_tol;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                        SHARED_FIELD_EX32(data, GPIO_CONTROL_RESET_TOLER=
ANCE));
> +    set->reset_tol =3D update_value_control_source(set, set->reset_tol,
> +                                                 group_value);
> +
> +    /* debounce 1 */
> +    group_value =3D set->debounce_1;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DEBOUNC=
E_1));
> +    set->debounce_1 =3D update_value_control_source(set, set->debounce_1=
,
> +                                                  group_value);
> +
> +    /* debounce 2 */
> +    group_value =3D set->debounce_2;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_DEBOUNC=
E_2));
> +    set->debounce_2 =3D update_value_control_source(set, set->debounce_2=
,
> +                                                  group_value);
> +
> +    /* input mask */
> +    group_value =3D set->input_mask;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INPUT_M=
ASK));
> +    /*
> +     * feeds into interrupt generation
> +     * 0: read from data value reg will be updated
> +     * 1: read from data value reg will not be updated
> +     */
> +    set->input_mask =3D group_value & props->input;
> +
> +    /* blink counter 1 */
> +    /* blink counter 2 */
> +    /* unimplement */
> +
> +    /* interrupt status */
> +    group_value =3D set->int_status;
> +    group_value =3D deposit32(group_value, pin_idx, 1,
> +                            SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_STA=
TUS));

This makes me a bit wary.

The interrupt status field is W1C, where a set bit on read indicates an
interrupt is pending. If the bit extracted from data is set it should
clear the corresponding bit in group_value. However, if the extracted
bit is clear then the value of the corresponding bit in group_value
should be unchanged.

SHARED_FIELD_EX32() extracts the interrupt status bit from the write
(data). group_value is set to the set's interrupt status, which means
that for any pin with an interrupt pending, the corresponding bit is
set. The deposit32() call updates the bit at pin_idx in the group,
using the value extracted from the write (data).

However, the result is that if the interrupt was pending and the write
was acknowledging it, then the update has no effect. Alternatively, if
the interrupt was pending but the write was acknowledging it, then the
update will mark the interrupt as pending. Or, if the interrupt was
pending but the write was _not_ acknowledging it, then the interrupt
will _no longer_ be marked pending. If this is intentional it feels a
bit hard to follow.

> +    cleared =3D ctpop32(group_value & set->int_status);

Can this rather be expressed as

```
cleared =3D SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_STATUS);
```

> +    if (s->pending && cleared) {
> +        assert(s->pending >=3D cleared);
> +        s->pending -=3D cleared;

We're only ever going to be subtracting 1, as each GPIO has its own
register. This feels overly abstract.

> +    }
> +    set->int_status &=3D ~group_value;

This feels like it misbehaves in the face of multiple pending
interrupts.

For example, say we have an interrupt pending for GPIOA0, where the
following statements are true:

   set->int_status =3D=3D 0b01
   s->pending =3D=3D 1

Before it is acknowledged, an interrupt becomes pending for GPIOA1:

   set->int_status =3D=3D 0b11
   s->pending =3D=3D 2

A write is issued to acknowledge the interrupt for GPIOA0. This causes
the following sequence:

   group_value =3D=3D 0b11
   cleared =3D=3D 2
   s->pending =3D 0
   set->int_status =3D=3D 0b00

It seems the pending interrupt for GPIOA1 is lost?

> +
> +    aspeed_gpio_update(s, set, set->data_value, UINT32_MAX);
> +    return;
> +}
> +
> +static uint64_t aspeed_gpio_2700_read(void *opaque, hwaddr offset,
> +                                uint32_t size)
> +{
> +    AspeedGPIOState *s =3D ASPEED_GPIO(opaque);
> +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> +    GPIOSets *set;
> +    uint64_t value;
> +    uint64_t reg;
> +    uint32_t pin;
> +    uint32_t idx;
> +
> +    reg =3D offset >> 2;
> +
> +    if (reg >=3D agc->reg_table_count) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: offset 0x%" PRIx64 " out of bounds\n",
> +                      __func__, offset);
> +        return 0;
> +    }
> +
> +    switch (reg) {
> +    case R_GPIO_2700_DEBOUNCE_TIME_1 ... R_GPIO_2700_DEBOUNCE_TIME_3:
> +        idx =3D reg - R_GPIO_2700_DEBOUNCE_TIME_1;
> +
> +        if (idx >=3D ASPEED_GPIO_NR_DEBOUNCE_REGS) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: debounce index: %d, out of bounds\n",
> +                          __func__, idx);
> +            return 0;
> +        }
> +
> +        value =3D (uint64_t) s->debounce_regs[idx];
> +        break;
> +    case R_GPIO_2700_INT_STATUS_1 ... R_GPIO_2700_INT_STATUS_7:
> +        idx =3D reg - R_GPIO_2700_INT_STATUS_1;
> +
> +        if (idx >=3D agc->nr_gpio_sets) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: interrupt status index: %d, out of bounds=
\n",
> +                          __func__, idx);
> +            return 0;
> +        }
> +
> +        set =3D &s->sets[idx];
> +        value =3D (uint64_t) set->int_status;
> +        break;
> +    case R_GPIO_A0_CONTROL ... R_GPIO_AA7_CONTROL:
> +        pin =3D reg - R_GPIO_A0_CONTROL;
> +
> +        if (pin >=3D agc->nr_gpio_pins) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid pin number: %d\n=
",
> +                          __func__, pin);
> +               return 0;
> +        }
> +
> +        value =3D aspeed_gpio_read_control_reg(s, pin);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        return 0;
> +    }
> +
> +    trace_aspeed_gpio_read(offset, value);
> +    return value;
> +}
> +
> +static void aspeed_gpio_2700_write(void *opaque, hwaddr offset,
> +                                uint64_t data, uint32_t size)
> +{
> +    AspeedGPIOState *s =3D ASPEED_GPIO(opaque);
> +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> +    uint64_t reg;
> +    uint32_t pin;
> +    uint32_t type;
> +    uint32_t idx;
> +
> +    trace_aspeed_gpio_write(offset, data);
> +
> +    reg =3D offset >> 2;
> +
> +    if (reg >=3D agc->reg_table_count) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: offset 0x%" PRIx64 " out of bounds\n",
> +                      __func__, offset);
> +        return;
> +    }
> +
> +    switch (reg) {
> +    case R_GPIO_2700_DEBOUNCE_TIME_1 ... R_GPIO_2700_DEBOUNCE_TIME_3:
> +        idx =3D reg - R_GPIO_2700_DEBOUNCE_TIME_1;
> +
> +        if (idx >=3D ASPEED_GPIO_NR_DEBOUNCE_REGS) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: debounce index: %d out of bounds\n",
> +                          __func__, idx);
> +            return;
> +        }
> +
> +        s->debounce_regs[idx] =3D (uint32_t) data;
> +        break;
> +    case R_GPIO_A0_CONTROL ... R_GPIO_AA7_CONTROL:
> +        pin =3D reg - R_GPIO_A0_CONTROL;
> +
> +        if (pin >=3D agc->nr_gpio_pins) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid pin number: %d\n=
",
> +                          __func__, pin);
> +            return;
> +        }
> +
> +        if (SHARED_FIELD_EX32(data, GPIO_CONTROL_RESERVED)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reserved data: 0=
x%"
> +                          PRIx64"\n", __func__, data);
> +            return;
> +        }
> +
> +        aspeed_gpio_write_control_reg(s, pin, type, data);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
> +                      PRIx64"\n", __func__, offset);
> +        break;
> +    }
> +
> +    return;
> +}
> +
>  /****************** Setup functions ******************/

Bit of a nitpick, but I'm not personally a fan of banner comments like
this.

Andrew

