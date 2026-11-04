Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C93606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Dzi3eFtq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOSiK-0000HQ-1E; Tue, 03 Nov 2026 23:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xOSiG-0000HB-Iq; Tue, 03 Nov 2026 23:35:05 -0500
Received: from smtp6-g21.free.fr ([2a01:e0c:1:1599::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xOSiD-00081Z-Me; Tue, 03 Nov 2026 23:35:04 -0500
Received: from [10.1.83.104] (unknown [31.38.191.99])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 2934A780331;
 Wed,  4 Nov 2026 05:34:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793766897;
 bh=JlReWFN0DKbvdfz+b/E5D5/IqVRZQ4Sz9XAljerclbA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dzi3eFtqrKsH94BPzvcNgw37m7dZgvRRUN0KMPUeKerm7CCxiHqqpxz2EptSJxHta
 HE9aKo1xmvinOPOvi4s/4QW21W2ZT84EgUKSpkeQfLTuFOVNDGYTyrPKKUrUfZyCUO
 34f9nZiQM8F84dqDIRlbLeScgJuO88cmg4DOHC+6T5rYzP4qfzb01ktPVfPAn6Nyra
 beuee4CUTnzUaUyuyix6Vh1tQrfwLLFJoqcugt/5a0uZ26dXTgzHI/IxYlxixwDkCQ
 wx5MBhnIXXNtIYMfUBnJb68WHDulrp1amKARNqxDWHWe1Qf/KuJmOs7ETr5vDqffNM
 OUNHSndjwUmNg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: alexander.hansen@9elements.com
Cc: qemu-devel@nongnu.org, eblot@meta.com, titusr@google.com, clg@kaod.org,
 Patrick Leis <venture@google.com>, qemu-arm@nongnu.org, eblot.ml@gmail.com
Subject: Re: [PATCH v8 1/5] hw/i2c: support PCA9544
Date: Wed, 04 Nov 2026 12:34:42 +0800
X-Mailer: MailMate (2.0r6272)
Message-ID: <87D10FD1-D205-466A-A428-8964EE99B142@free.fr>
In-Reply-To: <20261013124649.194808-2-alexander.hansen@9elements.com>
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
 <20261013124649.194808-2-alexander.hansen@9elements.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:e0c:1:1599::15;
 envelope-from=emmanuel.blot@free.fr; helo=smtp6-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 13 Oct 2026, at 20:46, alexander.hansen@9elements.com wrote:

> From: Alexander Hansen <alexander.hansen@9elements.com>
>
> Who to explain it better than the manufacturer:
>
> ```
> The PCA9544A is a 1-of-4 bidirectional translating multiplexer,
> controlled via the I2C-bus. The SCL/SDA upstream pair fans out to four
> SCx/SDx downstream pairs, or channels. Only one SCx/SDx channel is
> selected at a time, determined by the contents of the programmable
> control register.
> ```

Might be worth to add a note on how this device differs from the previous=
ly supported ones, to spot the channel selection behavior?

> The device updates the selected channel after STOP condition, not on
> the last byte written [1].

See below: I think this is the case for all supported devices, and that e=
xisting emulation is not fully valid on this point.

> For this reason the parent event handler has to be hooked to prevent
> write-read sequence from updating channel selection before STOP
> condition.
>
> Reset also had to be modified since a write would not apply the channel=

> selection by itself.
>
> This emulation is done to support yosemite4 machine emulation.

Maybe part of the cover letter rather than this specific commit?

>
> Interrupt forwarding is currently UNSUPPORTED.
>
> References:
> [1] https://www.nxp.com/docs/en/data-sheet/PCA9544A.pdf
>
> Cc: Patrick Leis <venture@google.com> (maintainer:pca954x)
> Cc: Emmanuel Blot <eblot@meta.com>
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
>
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>  hw/i2c/i2c_mux_pca954x.c         | 88 ++++++++++++++++++++++++++++----=

>  include/hw/i2c/i2c_mux_pca954x.h |  1 +
>  2 files changed, 78 insertions(+), 11 deletions(-)
>
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index c603446028..19212dfa34 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -30,6 +30,10 @@
>  #define PCA9548_CHANNEL_COUNT 8
>  #define PCA9546_CHANNEL_COUNT 4
> +#define PCA9544_CHANNEL_COUNT 4
> +
> +/* enable bit */
> +#define PCA9544_ENABLE 0x4

It seems PCA9544_ENABLE is used both as a flag and to compute the channel=
 mask.
It might be easier to read using a boolean for the flag, and (PCA9544_CHA=
NNEL_COUNT - 1) or (mc->nchans - 1) for the mask?

>  /*
>   * struct Pca954xState - The pca954x state object.
> @@ -56,6 +60,11 @@ typedef struct Pca954xClass {
>      SMBusDeviceClass parent;
>
>      uint8_t nchans;
> +
> +    /* channel enable bit for mux devices, zero for switches */
> +    uint8_t mux_enable;

Exiting document style (@mux_enable =E2=80=A6) in struct Pca954xClass com=
ment block should be preferred.

> +
> +    int (*parent_event)(I2CSlave *s, enum i2c_event event);
>  } Pca954xClass;
>
>  #define TYPE_PCA954X "pca954x"
> @@ -99,28 +108,43 @@ static bool pca954x_match(I2CSlave *candidate, uin=
t8_t address,
>      return broadcast;
>  }
>
> -static void pca954x_enable_channel(Pca954xState *s, uint8_t enable_mas=
k)
> +static void pca954x_enable_channel(Pca954xState *s, uint8_t control)
>  {
>      Pca954xClass *mc =3D PCA954X_GET_CLASS(s);
>      int i;
>
> +    if (mc->mux_enable) {
> +        uint8_t selected =3D control & (mc->mux_enable - 1);
> +        bool enabled =3D control & mc->mux_enable;
> +
> +        for (i =3D 0; i < mc->nchans; i++) {
> +            s->enabled[i] =3D enabled && i =3D=3D selected;
> +        }
> +        return;
> +    }
> +
>      /*
> -     * For each channel, check if their bit is set in enable_mask and =
if yes,
> +     * For each channel, check if their bit is set in control and if y=
es,
>       * enable it, otherwise disable, hide it.
>       */
>      for (i =3D 0; i < mc->nchans; i++) {
> -        if (enable_mask & (1 << i)) {
> -            s->enabled[i] =3D true;
> -        } else {
> -            s->enabled[i] =3D false;
> -        }
> +        s->enabled[i] =3D control & (1 << i);
>      }
>  }
>
>  static void pca954x_write(Pca954xState *s, uint8_t data)
>  {
> -    s->control =3D data;
> -    pca954x_enable_channel(s, data);
> +    Pca954xClass *mc =3D PCA954X_GET_CLASS(s);
> +    uint8_t data_writable =3D data;
> +
> +    if (mc->mux_enable) {
> +        data_writable =3D data & 0x0f;

Maybe use a named constant here

> +    }
> +
> +    s->control =3D data_writable;
> +    if (!mc->mux_enable) {
> +        pca954x_enable_channel(s, data_writable);
> +    }

Maybe simplify this whole function:
  - channel enablement occurs on STOP condition for all devices, not only=
 PCA9544; channel enablement should be deferred to this event.
  - I think pca954x_enable_channel always ignore non-channel bits, whatev=
er the device

Could be as simple as:
s->control =3D mc->mux_enable ? data & 0x0f : data;

>
>      trace_pca954x_write_bytes(data);
>  }
> @@ -128,6 +152,7 @@ static void pca954x_write(Pca954xState *s, uint8_t =
data)
>  static int pca954x_write_data(SMBusDevice *d, uint8_t *buf, uint8_t le=
n)
>  {
>      Pca954xState *s =3D PCA954X(d);
> +    Pca954xClass *mc =3D PCA954X_GET_CLASS(s);
>
>      if (len =3D=3D 0) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: writing empty data\n", __f=
unc__);
> @@ -136,15 +161,17 @@ static int pca954x_write_data(SMBusDevice *d, uin=
t8_t *buf, uint8_t len)
>
>      /*
>       * len should be 1, because they write one byte to enable/disable =
channels.
> +     * In case of PCA9544A, multiple bytes can be written but only the=
 last one
> +     * will be used.
>       */

I think for all devices, last byte is always considered, there is no spec=
ial case for PCA9544.
The error log call / return error could then be removed.

> -    if (len > 1) {
> +    if (len > 1 && !mc->mux_enable) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>              "%s: extra data after channel selection mask\n",
>              __func__);
>          return -1;
>      }
>
> -    pca954x_write(s, buf[0]);
> +    pca954x_write(s, buf[len - 1]);
>      return 0;
>  }
>
> @@ -156,11 +183,33 @@ static uint8_t pca954x_read_byte(SMBusDevice *d)
>      return data;
>  }
>
> +static int pca954x_event(I2CSlave *s, enum i2c_event event)
> +{
> +    Pca954xState *state =3D PCA954X(s);
> +    Pca954xClass *mc =3D PCA954X_GET_CLASS(state);
> +
> +    int res =3D mc->parent_event(s, event);
> +
> +    /*
> +     * When a channel is selected, it will become active after
> +     * a STOP condition has been placed on the I2C-bus.
> +     */
> +    if (mc->mux_enable && event =3D=3D I2C_FINISH) {
> +        pca954x_enable_channel(state, state->control);
> +    }
> +    return res;
> +}
> +
>  static void pca954x_enter_reset(Object *obj, ResetType type)
>  {
>      Pca954xState *s =3D PCA954X(obj);
> +    Pca954xClass *mc =3D PCA954X_GET_CLASS(s);
>      /* Reset will disable all channels. */
>      pca954x_write(s, 0);

I would favor a call to pca954x_enable_channel rather than pca954x_write =
here whatever the device kind, it would be cleaner as pca954x_write does =
masking then call pca954x_enable_channel and it=E2=80=99s not a write cal=
l per se.

> +
> +    if (mc->mux_enable) {
> +        pca954x_enable_channel(s, s->control);
> +    }
>  }
>
>  I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
> @@ -172,6 +221,13 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t=
 channel)
>      return pca954x->bus[channel];
>  }
>
> +static void pca9544_class_init(ObjectClass *klass, const void *data)
> +{
> +    Pca954xClass *s =3D PCA954X_CLASS(klass);

Prefer c or k, as s is usually used with *State structures.

> +    s->nchans =3D PCA9544_CHANNEL_COUNT;
> +    s->mux_enable =3D PCA9544_ENABLE;
> +}
> +
>  static void pca9546_class_init(ObjectClass *klass, const void *data)
>  {
>      Pca954xClass *s =3D PCA954X_CLASS(klass);
> @@ -221,8 +277,13 @@ static void pca954x_class_init(ObjectClass *klass,=
 const void *data)
>      ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      SMBusDeviceClass *k =3D SMBUS_DEVICE_CLASS(klass);
> +    Pca954xClass *s =3D PCA954X_CLASS(klass);
> +
> +    /* hook our parent event handler */
> +    s->parent_event =3D sc->event;
>
>      sc->match_and_add =3D pca954x_match;
> +    sc->event =3D pca954x_event;
>
>      rc->phases.enter =3D pca954x_enter_reset;
>
> @@ -245,6 +306,11 @@ static const TypeInfo pca954x_info[] =3D {
>          .class_init    =3D pca954x_class_init,
>          .abstract      =3D true,
>      },
> +    {
> +        .name          =3D TYPE_PCA9544,
> +        .parent        =3D TYPE_PCA954X,
> +        .class_init    =3D pca9544_class_init,
> +    },
>      {
>          .name          =3D TYPE_PCA9546,
>          .parent        =3D TYPE_PCA954X,
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_=
pca954x.h
> index 3dd25ec983..6449a6dfae 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -3,6 +3,7 @@
>
>  #include "hw/i2c/i2c.h"
>
> +#define TYPE_PCA9544 "pca9544"
>  #define TYPE_PCA9546 "pca9546"
>  #define TYPE_PCA9548 "pca9548"
>
> -- =

> 2.56.0

Note: it might be worth splitting this commit into:
1. existing PCA954x fixes:
  - update channel enablement on STOP bit
  - last-byte-wins
  - enable_channel loop simplification
  - reset calls =E2=80=A6enable_channel rather than =E2=80=A6write
  - header inclusion removal (sys bus.h at least)
  - =E2=80=A6
2. adding support for PCA9544

Emmanuel.


