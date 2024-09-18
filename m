Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D91CDD560
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4TF-0002HT-9R; Wed, 18 Sep 2024 19:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sr4TE-0002GX-GE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:52:28 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sr4TC-0002LJ-5O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:52:28 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e037b80140so135296b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1726703545; x=1727308345;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=evL+cL1zIXxUOEc73t8qN29EBvw/0BYeyTuo8tg+3zM=;
 b=n6WRp1RfoGNImpWiwTBnXIsuC9WoBIA23jocwgDJE+aEobdU87Y3KNgysOSJBB7wo0
 i0XoTk6o/LO6r54FcKYwkWAIDSDLnuHRcCbeE/AlrFAFuz/WAxhTuRo/2BoQ+buN89op
 q4RpfTw5NVi4TrBnWz708lJ9z8ZEb94fE5iOLVB7vXWlkAkuCww9a9uQn6VAZFqrtjuC
 yQd5QNmUT3GHNc8Hs9emY17+qHkHRJFKbalZc4H4L3n3cbih3P5Sd7wNwGg8MxT6niC1
 NEEz4SFthVA3HdNfGDyI8JlnZe+63/rlYjG/kdMro8s3yYFeq5MdDe9YSzM9RQBM8gL9
 taRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726703545; x=1727308345;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evL+cL1zIXxUOEc73t8qN29EBvw/0BYeyTuo8tg+3zM=;
 b=JYiknG9rxHz6MG7b0mPFTq/x6c/MEYcsjtVpxboOVu2gAaB57CVJSL/0mTQ4zqN4vv
 osLsNvdSdNFPmBE6Q/m0a4oGbmAz8kprU8SO1V/g0S0RnGctfrUTAzSBLp9I67z2HUv/
 47rcQo9WBXL/CE2eYz3ox787FgkRrgERLDcJuzjPBoGhURNLhepe2R0kzz6P7W70CRjv
 s7zYwq9z7cVr/ZM04cv6Fr2vo1uohskFJ7e8N8eIz49WZVJdbkmV/Ccn8ln/D9He3G8j
 t26sJ1aX+89YDC3vK66qvxqWZyQQMXGu14ASXvLd8ZAfTB+Pxhuwuc2ffNb+Zst5AzID
 ToTA==
X-Gm-Message-State: AOJu0YzrS0EWd/vH+bLJdmcevVeTTTQlGCWN3Grz9qWLHvD4MhRmMei9
 ktgonCBeJ7l/Z7251ZyfcpXE542ojw7ef5ibRnExiUSmhfdDGDUufMc5qGdw6MA=
X-Google-Smtp-Source: AGHT+IGsc0wArWtfBK4WNLquyMeBV85s2SYrnjYNc1tfjQ4J/vj3eXQkQN0zhpvjeBGsVPPU7buGTQ==
X-Received: by 2002:a05:6808:1405:b0:3d9:35df:8f2 with SMTP id
 5614622812f47-3e071ac5783mr12814631b6e.28.1726703544699; 
 Wed, 18 Sep 2024 16:52:24 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:bfe4:2aee:929f:be5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e26b73c931sm120451b6e.44.2024.09.18.16.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 16:52:23 -0700 (PDT)
Date: Wed, 18 Sep 2024 18:52:17 -0500
From: Corey Minyard <corey@minyard.net>
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr,
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org,
 jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
Subject: Re: [PATCH 19/25] hw/misc: add i2c-tester
Message-ID: <ZutnsQIEQNo9icnX@mail.minyard.net>
References: <20240918192254.3136903-1-tavip@google.com>
 <20240918192254.3136903-20-tavip@google.com>
 <Zusypeay8cjjPTn0@mail.minyard.net>
 <CAGWr4cQapNbGZteQYAFYrgDnh3cY0xHnEtAiDW0zuURwZr_V3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWr4cQapNbGZteQYAFYrgDnh3cY0xHnEtAiDW0zuURwZr_V3g@mail.gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=corey@minyard.net; helo=mail-oi1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 18, 2024 at 04:03:12PM -0700, Octavian Purdila wrote:
> On Wed, Sep 18, 2024 at 1:06 PM Corey Minyard <corey@minyard.net> wrote:
> >
> > On Wed, Sep 18, 2024 at 12:22:47PM -0700, Octavian Purdila wrote:
> > > Add a simple i2c peripheral to be used for testing I2C device
> > > models. The peripheral has a fixed number of registers that can be
> > > read and written.
> >
> > Why is this better than just using the eeprom device?
> >
> 
> The main reason for adding it is that, AFAICT, there is no i2c slave
> device that responds with I2C_NACK during a transaction.
> 
> Also, having a dedicated device for testing purposes makes it easier
> to add new features than adding it to a real device where it might not
> always be possible. I tried to add the NACK functionality but I did
> not find one where the datasheet would confirm the behaviour I was
> looking for.

SMBUS devices (like the eeprom) use NACKs as part of the protocol, to
mark the end of a transfer, but that's probably not what you are looking
for.  You are using it to signal an error, which I don't think any
existing device will do.  Real devices, in general, don't NACK anything
for errors, but the protocol allows it.

Somehow in my previous look I completely missed i2c_tester_event(), so
this works like a normal I2C device, except that most of them
auto-increment the index register.  But some don't, so it's fine.

If you could document the rationale for this, it would help a lot, for
others that might want to use it.  Also, I would expect people might
add their own test code to this.  I'm not sure what you can do at the
moment about that, but just a heads up that people will probably hack on
this in the future.

So this is good.

-corey

> 
> > This has some uncommon attributes compared to most i2c devices.  For
> > instance, most i2c devices take their address as the first bytes of a
> > write operation, then auto-increment after that for reads and writes.
> > This seems to take one address on a write after a system reset, then use
> > that forever.
> >
> > Anyway, unless there is a compelling reason to use this over the eeprom
> > device, I'm going to recommend against it.
> >
> 
> 
> > -corey
> >
> > >
> > > Signed-off-by: Octavian Purdila <tavip@google.com>
> > > ---
> > >  include/hw/misc/i2c_tester.h |  30 ++++++++++
> > >  hw/misc/i2c_tester.c         | 109 +++++++++++++++++++++++++++++++++++
> > >  hw/misc/Kconfig              |   5 ++
> > >  hw/misc/meson.build          |   2 +
> > >  4 files changed, 146 insertions(+)
> > >  create mode 100644 include/hw/misc/i2c_tester.h
> > >  create mode 100644 hw/misc/i2c_tester.c
> > >
> > > diff --git a/include/hw/misc/i2c_tester.h b/include/hw/misc/i2c_tester.h
> > > new file mode 100644
> > > index 0000000000..f6b6491008
> > > --- /dev/null
> > > +++ b/include/hw/misc/i2c_tester.h
> > > @@ -0,0 +1,30 @@
> > > +/*
> > > + *
> > > + * Copyright (c) 2024 Google LLC
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#ifndef HW_I2C_TESTER_H
> > > +#define HW_I2C_TESTER_H
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/i2c/i2c.h"
> > > +#include "hw/irq.h"
> > > +
> > > +#define I2C_TESTER_NUM_REGS    0x31
> > > +
> > > +#define TYPE_I2C_TESTER "i2c-tester"
> > > +#define I2C_TESTER(obj) OBJECT_CHECK(I2cTesterState, (obj), TYPE_I2C_TESTER)
> > > +
> > > +typedef struct {
> > > +    I2CSlave i2c;
> > > +    bool set_reg_idx;
> > > +    uint8_t reg_idx;
> > > +    uint8_t regs[I2C_TESTER_NUM_REGS];
> > > +} I2cTesterState;
> > > +
> > > +#endif /* HW_I2C_TESTER_H */
> > > diff --git a/hw/misc/i2c_tester.c b/hw/misc/i2c_tester.c
> > > new file mode 100644
> > > index 0000000000..77ce8bf91a
> > > --- /dev/null
> > > +++ b/hw/misc/i2c_tester.c
> > > @@ -0,0 +1,109 @@
> > > +/*
> > > + * Simple I2C peripheral for testing I2C device models.
> > > + *
> > > + * Copyright (c) 2024 Google LLC
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "hw/misc/i2c_tester.h"
> > > +
> > > +#include "qemu/log.h"
> > > +#include "qemu/module.h"
> > > +#include "migration/vmstate.h"
> > > +
> > > +static void i2c_tester_reset_enter(Object *o, ResetType type)
> > > +{
> > > +    I2cTesterState *s = I2C_TESTER(o);
> > > +
> > > +    s->set_reg_idx = false;
> > > +    s->reg_idx     = 0;
> > > +    memset(s->regs, 0, I2C_TESTER_NUM_REGS);
> > > +}
> > > +
> > > +static int i2c_tester_event(I2CSlave *i2c, enum i2c_event event)
> > > +{
> > > +    I2cTesterState *s = I2C_TESTER(i2c);
> > > +
> > > +    if (event == I2C_START_SEND) {
> > > +        s->set_reg_idx = true;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static uint8_t i2c_tester_rx(I2CSlave *i2c)
> > > +{
> > > +    I2cTesterState *s = I2C_TESTER(i2c);
> > > +
> > > +    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
> > > +                      s->reg_idx);
> > > +        return I2C_NACK;
> > > +    }
> > > +
> > > +    return s->regs[s->reg_idx];
> > > +}
> > > +
> > > +static int i2c_tester_tx(I2CSlave *i2c, uint8_t data)
> > > +{
> > > +    I2cTesterState *s = I2C_TESTER(i2c);
> > > +
> > > +    if (s->set_reg_idx) {
> > > +        /* Setting the register in which the operation will be done. */
> > > +        s->reg_idx = data;
> > > +        s->set_reg_idx = false;
> > > +        return 0;
> > > +    }
> > > +
> > > +    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
> > > +                      s->reg_idx);
> > > +        return I2C_NACK;
> > > +    }
> > > +
> > > +    /* Write reg data. */
> > > +    s->regs[s->reg_idx] = data;
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_i2c_tester = {
> > > +    .name = "i2c-tester",
> > > +    .version_id = 1,
> > > +    .minimum_version_id = 1,
> > > +    .fields = (const VMStateField[]) {
> > > +        VMSTATE_I2C_SLAVE(i2c, I2cTesterState),
> > > +        VMSTATE_BOOL(set_reg_idx, I2cTesterState),
> > > +        VMSTATE_UINT8(reg_idx, I2cTesterState),
> > > +        VMSTATE_UINT8_ARRAY(regs, I2cTesterState, I2C_TESTER_NUM_REGS),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static void i2c_tester_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> > > +    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
> > > +
> > > +    rc->phases.enter = i2c_tester_reset_enter;
> > > +    dc->vmsd = &vmstate_i2c_tester;
> > > +    isc->event = i2c_tester_event;
> > > +    isc->recv = i2c_tester_rx;
> > > +    isc->send = i2c_tester_tx;
> > > +}
> > > +
> > > +static const TypeInfo i2c_tester_types[] = {
> > > +    {
> > > +        .name = TYPE_I2C_TESTER,
> > > +        .parent = TYPE_I2C_SLAVE,
> > > +        .instance_size = sizeof(I2cTesterState),
> > > +        .class_init = i2c_tester_class_init
> > > +    },
> > > +};
> > > +
> > > +DEFINE_TYPES(i2c_tester_types);
> > > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > > index 4b688aead2..3e93c12c8e 100644
> > > --- a/hw/misc/Kconfig
> > > +++ b/hw/misc/Kconfig
> > > @@ -213,6 +213,11 @@ config IOSB
> > >  config XLNX_VERSAL_TRNG
> > >      bool
> > >
> > > +config I2C_TESTER
> > > +    bool
> > > +    default y if TEST_DEVICES
> > > +    depends on I2C
> > > +
> > >  config FLEXCOMM
> > >      bool
> > >      select I2C
> > > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > > index faaf2671ba..4f22231fa3 100644
> > > --- a/hw/misc/meson.build
> > > +++ b/hw/misc/meson.build
> > > @@ -158,6 +158,8 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
> > >  # HPPA devices
> > >  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> > >
> > > +system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
> > > +
> > >  system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
> > >  system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
> > >  system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
> > > --
> > > 2.46.0.662.g92d0881bb0-goog
> > >
> > >

