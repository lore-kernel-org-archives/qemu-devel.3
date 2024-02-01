Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD81BC47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 00:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKn9-0002Tw-JP; Wed, 31 Jan 2024 19:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKn7-0002Tj-Pl; Wed, 31 Jan 2024 19:18:53 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKn4-0005ii-U7; Wed, 31 Jan 2024 19:18:52 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so198299241.1; 
 Wed, 31 Jan 2024 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706746729; x=1707351529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwNByqXgrK7/lW/UM9Bpm94Q44TU+acq5dBwX/301Cw=;
 b=XH+cfHh+HFn/xed1hfKNU0XynWePycdOu0ykP3jHD1r/axN9g7VKudrBnxff1De/mg
 vZX/duu4bkUn+52C7e/I0S04WWtT8svacv6tzam4djWgAaZORhyxKHmd9dBM9FmNWTYc
 7VT1vrqEH552PqMUd2MGktjxJdzouwNsE7cFHA++3mmvXa8+bfGerPAVrCs14lWjeFRP
 8VM9PIjsemTR4V59ZwoHD7n0L0uzFcNZ1l6uR4Bdh5dl7tsWt3tnwbmCrsDnrVZDee8h
 6mfTWQ7maAE6hoQR6jRWW2+NgQZMEvvUqt7DNzltUpYd8ryGzjBxiCDqxg5LGV/zXcD3
 QAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706746729; x=1707351529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwNByqXgrK7/lW/UM9Bpm94Q44TU+acq5dBwX/301Cw=;
 b=IMDnLyIzIfAMORVyA1+ZMwPkSLy579xegfKfbWa4HSe8147m3y6cFVxlAsI8HXz4e7
 7EkIhenPeMgEP5EEI2tK9udmp3uqEFWyQflbSKztGg/nvKr5JlbjB+PmyRQlFKh4vLoU
 9TT8gz60tiWELww/t83gtQLD2srf5V4uvmr5Egio9EBJdAVd1R9hCttCOmHHnF6faqjN
 OloKPXkqNw2wwd0JqnZpVs2UHB+H4WqtCcm/uSfGuXJJBs9bYlOIR6XnLu2cDkBqRiaE
 c4umWqaOiYFZCFv0JbLrn6fmgUfWiiC7QNHz7kgXXWJoQ6g4q7ojAy6N3J1h1dH+z2rV
 +hBQ==
X-Gm-Message-State: AOJu0Yyjyyhz+lDDNYjuktKbKtHnugrd5eHXhBQjNCUvhrphVXoUuLf3
 teunxvQT82IWKA/gRxQ9mFyF2FriApBVANLbFZTMh7DNv2bNWsSI/TLIyLK9JVADhP/mQvqVpCo
 k8RvSLkMLFXB2KvMKA8j8MqgBATY=
X-Google-Smtp-Source: AGHT+IFI3ens+pbG3AvYOSCKvDl/xegUupY8TAEwAxauvHOH5RbKFaiywez2VFpiPgadd4TSKe2VRen0r5EqjzfNbxI=
X-Received: by 2002:a67:f844:0:b0:46b:1dd:8b36 with SMTP id
 b4-20020a67f844000000b0046b01dd8b36mr3376630vsp.12.1706746729043; Wed, 31 Jan
 2024 16:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20240130160656.113112-1-arnaud.minier@telecom-paris.fr>
 <20240130160656.113112-4-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240130160656.113112-4-arnaud.minier@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 10:18:22 +1000
Message-ID: <CAKmqyKNy7+7JN6CFEqOuXHYFENL6geaS5H6sweXhcDLnLpJC7w@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] Add an internal PLL Clock object
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 2:09=E2=80=AFAM Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> This object represents the PLLs and their channels. The PLLs allow for a
> more fine-grained control of the clocks frequency.
>
> Wasn't sure about how to handle the reset and the migration so used the
> same appproach as the BCM2835 CPRMAN.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>  hw/misc/stm32l4x5_rcc.c                   | 175 ++++++++++++++++++++++
>  hw/misc/trace-events                      |   5 +
>  include/hw/misc/stm32l4x5_rcc.h           |  40 +++++
>  include/hw/misc/stm32l4x5_rcc_internals.h |  22 +++
>  4 files changed, 242 insertions(+)
>
> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> index ed10832f88..fb0233c3e9 100644
> --- a/hw/misc/stm32l4x5_rcc.c
> +++ b/hw/misc/stm32l4x5_rcc.c
> @@ -162,6 +162,156 @@ static void clock_mux_set_source(RccClockMuxState *=
mux, RccClockMuxSource src)
>      clock_mux_update(mux);
>  }
>
> +static void pll_update(RccPllState *pll)
> +{
> +    uint64_t vco_freq, old_channel_freq, channel_freq;
> +    int i;
> +
> +    /* The common PLLM factor is handled by the PLL mux */
> +    vco_freq =3D muldiv64(clock_get_hz(pll->in), pll->vco_multiplier, 1)=
;
> +
> +    for (i =3D 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
> +        if (!pll->channel_exists[i]) {
> +            continue;
> +        }
> +
> +        old_channel_freq =3D clock_get_hz(pll->channels[i]);
> +        if (!pll->enabled ||
> +            !pll->channel_enabled[i] ||
> +            !pll->channel_divider[i]) {
> +            channel_freq =3D 0;
> +        } else {
> +            channel_freq =3D muldiv64(vco_freq,
> +                                    1,
> +                                    pll->channel_divider[i]);
> +        }
> +
> +        /* No change, early continue to avoid log spam and useless propa=
gation */
> +        if (old_channel_freq =3D=3D channel_freq) {
> +            continue;
> +        }
> +
> +        clock_update_hz(pll->channels[i], channel_freq);
> +        trace_stm32l4x5_rcc_pll_update(pll->id, i, vco_freq,
> +            old_channel_freq, channel_freq);
> +    }
> +}
> +
> +static void pll_src_update(void *opaque, ClockEvent event)
> +{
> +    RccPllState *s =3D opaque;
> +    pll_update(s);
> +}
> +
> +static void pll_init(Object *obj)
> +{
> +    RccPllState *s =3D RCC_PLL(obj);
> +    size_t i;
> +
> +    s->in =3D qdev_init_clock_in(DEVICE(s), "in",
> +                               pll_src_update, s, ClockUpdate);
> +
> +    const char *names[] =3D {
> +        "out-p", "out-q", "out-r",
> +    };
> +
> +    for (i =3D 0; i < RCC_NUM_CHANNEL_PLL_OUT; i++) {
> +        s->channels[i] =3D qdev_init_clock_out(DEVICE(s), names[i]);
> +    }
> +}
> +
> +static void pll_reset_hold(Object *obj)
> +{ }
> +
> +static const VMStateDescription pll_vmstate =3D {
> +    .name =3D TYPE_RCC_PLL,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(id, RccPllState),
> +        VMSTATE_CLOCK(in, RccPllState),
> +        VMSTATE_ARRAY_CLOCK(channels, RccPllState,
> +                            RCC_NUM_CHANNEL_PLL_OUT),
> +        VMSTATE_BOOL(enabled, RccPllState),
> +        VMSTATE_UINT32(vco_multiplier, RccPllState),
> +        VMSTATE_BOOL_ARRAY(channel_enabled, RccPllState, RCC_NUM_CHANNEL=
_PLL_OUT),
> +        VMSTATE_BOOL_ARRAY(channel_exists, RccPllState, RCC_NUM_CHANNEL_=
PLL_OUT),
> +        VMSTATE_UINT32_ARRAY(channel_divider, RccPllState, RCC_NUM_CHANN=
EL_PLL_OUT),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void pll_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold =3D pll_reset_hold;
> +    dc->vmsd =3D &pll_vmstate;
> +}
> +
> +static void pll_set_vco_multiplier(RccPllState *pll, uint32_t vco_multip=
lier)
> +{
> +    if (pll->vco_multiplier =3D=3D vco_multiplier) {
> +        return;
> +    }
> +
> +    if (vco_multiplier < 8 || vco_multiplier > 86) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: VCO multiplier is out of bound (%u) for PLL %u\n",
> +            __func__, vco_multiplier, pll->id);

Should we bail out with an invalid value?

Alistair

> +    }
> +
> +    trace_stm32l4x5_rcc_pll_set_vco_multiplier(pll->id,
> +        pll->vco_multiplier, vco_multiplier);
> +
> +    pll->vco_multiplier =3D vco_multiplier;
> +    pll_update(pll);
> +}
> +
> +static void pll_set_enable(RccPllState *pll, bool enabled)
> +{
> +    if (pll->enabled =3D=3D enabled) {
> +        return;
> +    }
> +
> +    pll->enabled =3D enabled;
> +    pll_update(pll);
> +}
> +
> +static void pll_set_channel_enable(RccPllState *pll,
> +                                   PllCommonChannels channel,
> +                                   bool enabled)
> +{
> +    if (pll->channel_enabled[channel] =3D=3D enabled) {
> +        return;
> +    }
> +
> +    if (enabled) {
> +        trace_stm32l4x5_rcc_pll_channel_enable(pll->id, channel);
> +    } else {
> +        trace_stm32l4x5_rcc_pll_channel_disable(pll->id, channel);
> +    }
> +
> +    pll->channel_enabled[channel] =3D enabled;
> +    pll_update(pll);
> +}
> +
> +static void pll_set_channel_divider(RccPllState *pll,
> +                                    PllCommonChannels channel,
> +                                    uint32_t divider)
> +{
> +    if (pll->channel_divider[channel] =3D=3D divider) {
> +        return;
> +    }
> +
> +    trace_stm32l4x5_rcc_pll_set_channel_divider(pll->id,
> +        channel, pll->channel_divider[channel], divider);
> +
> +    pll->channel_divider[channel] =3D divider;
> +    pll_update(pll);
> +}
> +
>  static void rcc_update_irq(Stm32l4x5RccState *s)
>  {
>      if (s->cifr & CIFR_IRQ_MASK) {
> @@ -465,6 +615,11 @@ static void stm32l4x5_rcc_init(Object *obj)
>
>      qdev_init_clocks(DEVICE(s), stm32l4x5_rcc_clocks);
>
> +    for (i =3D 0; i < RCC_NUM_PLL; i++) {
> +        object_initialize_child(obj, "pll[*]",
> +                                &s->plls[i], TYPE_RCC_PLL);
> +    }
> +
>      for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
>
>          object_initialize_child(obj, "clock[*]",
> @@ -528,6 +683,16 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, =
Error **errp)
>              return;
>          }
>
> +    for (i =3D 0; i < RCC_NUM_PLL; i++) {
> +        RccPllState *pll =3D &s->plls[i];
> +
> +        clock_set_source(pll->in, s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT=
].out);
> +
> +        if (!qdev_realize(DEVICE(pll), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
>      for (i =3D 0; i < RCC_NUM_CLOCK_MUX; i++) {
>          RccClockMuxState *clock_mux =3D &s->clock_muxes[i];
>
> @@ -548,6 +713,10 @@ static void stm32l4x5_rcc_realize(DeviceState *dev, =
Error **errp)
>      clock_mux_set_source(&s->clock_muxes[0], RCC_CLOCK_MUX_SRC_GND);
>      clock_mux_set_enable(&s->clock_muxes[0], true);
>      clock_mux_set_factor(&s->clock_muxes[0], 1, 1);
> +    pll_set_channel_divider(&s->plls[0], 0, 1);
> +    pll_set_enable(&s->plls[0], true);
> +    pll_set_channel_enable(&s->plls[0], 0, true);
> +    pll_set_vco_multiplier(&s->plls[0], 1);
>  }
>
>  static Property stm32l4x5_rcc_properties[] =3D {
> @@ -585,6 +754,12 @@ static const TypeInfo stm32l4x5_rcc_types[] =3D {
>          .instance_size =3D sizeof(RccClockMuxState),
>          .instance_init =3D clock_mux_init,
>          .class_init =3D clock_mux_class_init,
> +    }, {
> +        .name =3D TYPE_RCC_PLL,
> +        .parent =3D TYPE_DEVICE,
> +        .instance_size =3D sizeof(RccPllState),
> +        .instance_init =3D pll_init,
> +        .class_init =3D pll_class_init,
>      }
>  };
>
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index d5e471811c..1b6054d88a 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -182,6 +182,11 @@ stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux=
 %d disabled"
>  stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, u=
int32_t new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC: M=
ux %d factor changed: multiplier (%u -> %u), divider (%u -> %u)"
>  stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t ne=
w_src) "RCC: Mux %d source changed: from %u to %u"
>  stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_fre=
q, uint64_t new_freq) "RCC: Mux %d src %d update: src_freq %" PRIu64 " new_=
freq %" PRIu64 ""
> +stm32l4x5_rcc_pll_set_vco_multiplier(uint32_t pll_id, uint32_t old_multi=
plier, uint32_t new_multiplier) "RCC: PLL %u: vco_multiplier changed (%u ->=
 %u)"
> +stm32l4x5_rcc_pll_channel_enable(uint32_t pll_id, uint32_t channel_id) "=
RCC: PLL %u, channel %u enabled"
> +stm32l4x5_rcc_pll_channel_disable(uint32_t pll_id, uint32_t channel_id) =
"RCC: PLL %u, channel %u disabled"
> +stm32l4x5_rcc_pll_set_channel_divider(uint32_t pll_id, uint32_t channel_=
id, uint32_t old_divider, uint32_t new_divider) "RCC: PLL %u, channel %u: d=
ivider changed (%u -> %u)"
> +stm32l4x5_rcc_pll_update(uint32_t pll_id, uint32_t channel_id, uint64_t =
vco_freq, uint64_t old_freq, uint64_t new_freq) "RCC: PLL %d channel %d upd=
ate: vco_freq %" PRIu64 " old_freq %" PRIu64 " new_freq %" PRIu64 ""
>
>  # tz-mpc.c
>  tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC r=
egs read: offset 0x%x data 0x%" PRIx64 " size %u"
> diff --git a/include/hw/misc/stm32l4x5_rcc.h b/include/hw/misc/stm32l4x5_=
rcc.h
> index 6719be9fbe..0fbfba5c40 100644
> --- a/include/hw/misc/stm32l4x5_rcc.h
> +++ b/include/hw/misc/stm32l4x5_rcc.h
> @@ -26,6 +26,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5RccState, STM32L4X=
5_RCC)
>
>  /* In the Stm32l4x5 clock tree, mux have at most 7 sources */
>  #define RCC_NUM_CLOCK_MUX_SRC 7
> +
> +typedef enum PllCommonChannels {
> +    RCC_PLL_COMMON_CHANNEL_P =3D 0,
> +    RCC_PLL_COMMON_CHANNEL_Q =3D 1,
> +    RCC_PLL_COMMON_CHANNEL_R =3D 2,
> +
> +    RCC_NUM_CHANNEL_PLL_OUT =3D 3
> +} PllCommonChannels;
> +
>  /* NB: Prescaler are assimilated to mux with one source and one output *=
/
>  typedef enum RccClockMux {
>      /* Internal muxes that arent't exposed publicly to other peripherals=
 */
> @@ -124,6 +133,14 @@ typedef enum RccClockMux {
>      RCC_NUM_CLOCK_MUX
>  } RccClockMux;
>
> +typedef enum RccPll {
> +    RCC_PLL_PLL,
> +    RCC_PLL_PLLSAI1,
> +    RCC_PLL_PLLSAI2,
> +
> +    RCC_NUM_PLL
> +} RccPll;
> +
>  typedef struct RccClockMuxState {
>      DeviceState parent_obj;
>
> @@ -142,6 +159,26 @@ typedef struct RccClockMuxState {
>      struct RccClockMuxState *backref[RCC_NUM_CLOCK_MUX_SRC];
>  } RccClockMuxState;
>
> +typedef struct RccPllState {
> +    DeviceState parent_obj;
> +
> +    RccPll id;
> +    Clock *in;
> +    uint32_t vco_multiplier;
> +    Clock *channels[RCC_NUM_CHANNEL_PLL_OUT];
> +    /* Global pll enabled flag */
> +    bool enabled;
> +    /* 'enabled' refers to the runtime configuration */
> +    bool channel_enabled[RCC_NUM_CHANNEL_PLL_OUT];
> +    /*
> +     * 'exists' refers to the physical configuration
> +     * It should only be set at pll initialization.
> +     * e.g. pllsai2 doesn't have a Q output.
> +     */
> +    bool channel_exists[RCC_NUM_CHANNEL_PLL_OUT];
> +    uint32_t channel_divider[RCC_NUM_CHANNEL_PLL_OUT];
> +} RccPllState;
> +
>  struct Stm32l4x5RccState {
>      SysBusDevice parent_obj;
>
> @@ -187,6 +224,9 @@ struct Stm32l4x5RccState {
>      Clock *sai1_extclk;
>      Clock *sai2_extclk;
>
> +    /* PLLs */
> +    RccPllState plls[RCC_NUM_PLL];
> +
>      /* Muxes ~=3D outputs */
>      RccClockMuxState clock_muxes[RCC_NUM_CLOCK_MUX];
>
> diff --git a/include/hw/misc/stm32l4x5_rcc_internals.h b/include/hw/misc/=
stm32l4x5_rcc_internals.h
> index 4aa836848b..a9da5e3be7 100644
> --- a/include/hw/misc/stm32l4x5_rcc_internals.h
> +++ b/include/hw/misc/stm32l4x5_rcc_internals.h
> @@ -22,7 +22,10 @@
>  #include "hw/misc/stm32l4x5_rcc.h"
>
>  #define TYPE_RCC_CLOCK_MUX "stm32l4x5-rcc-clock-mux"
> +#define TYPE_RCC_PLL "stm32l4x5-rcc-pll"
> +
>  OBJECT_DECLARE_SIMPLE_TYPE(RccClockMuxState, RCC_CLOCK_MUX)
> +OBJECT_DECLARE_SIMPLE_TYPE(RccPllState, RCC_PLL)
>
>  /* Register map */
>  REG32(CR, 0x00)
> @@ -285,6 +288,25 @@ REG32(CSR, 0x94)
>                              R_CSR_FWRSTF_MASK   | \
>                              R_CSR_LSIRDY_MASK)
>
> +/* Pll Channels */
> +enum PllChannels {
> +    RCC_PLL_CHANNEL_PLLSAI3CLK =3D 0,
> +    RCC_PLL_CHANNEL_PLL48M1CLK =3D 1,
> +    RCC_PLL_CHANNEL_PLLCLK =3D 2,
> +};
> +
> +enum PllSai1Channels {
> +    RCC_PLLSAI1_CHANNEL_PLLSAI1CLK =3D 0,
> +    RCC_PLLSAI1_CHANNEL_PLL48M2CLK =3D 1,
> +    RCC_PLLSAI1_CHANNEL_PLLADC1CLK =3D 2,
> +};
> +
> +enum PllSai2Channels {
> +    RCC_PLLSAI2_CHANNEL_PLLSAI2CLK =3D 0,
> +    /* No Q channel */
> +    RCC_PLLSAI2_CHANNEL_PLLADC2CLK =3D 2,
> +};
> +
>  typedef enum RccClockMuxSource {
>      RCC_CLOCK_MUX_SRC_GND =3D 0,
>      RCC_CLOCK_MUX_SRC_HSI,
> --
> 2.34.1
>
>

