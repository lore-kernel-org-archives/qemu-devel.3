Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB59CDD55C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 20:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1ew-0000zD-HK; Wed, 18 Sep 2024 16:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sr0wF-0002ZF-4q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 16:06:12 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1sr0wA-0003p7-FP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 16:06:10 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2689e7a941fso114211fac.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1726689964; x=1727294764;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eQ84GLGDR8VU+I3r83ozipAc0ivr1a9GP3kSXWROf0=;
 b=yRq7xu0k8k9H7/8lQ8ATXbHBZepcavUZ5cGXh4ta8SZ43BeDVfhYJwVaSpYf35LFVj
 au8mKlsS08j22XEzd7gh0mSmhq1qX3fD9Rfzo5kcuXp2KS8fVj7C0I01jyYvCVIX7SvG
 FT83FbnbN4OJFeONoM22Plt7Si8cI/KzNR0jxUdoX/tXl2xvW5If8kO3t6JNprAx+V11
 Nvb956vBVqwUvaPgj4GAeeOUM/dMl5qWfsBU0/7Nfg3m3Ew8mATivufQhsWMudzQThjr
 jFEiYyfPkzpCES5oiz6f9L7VlBZ4YKJBO1N1vGl3noXyEHjAFQS1GB1Gyj9d350lVrnt
 QYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726689964; x=1727294764;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eQ84GLGDR8VU+I3r83ozipAc0ivr1a9GP3kSXWROf0=;
 b=Ltj+nPZLec0tRbAMB9BZsvyM2JMySFVZ87UVihLbFwRUrIbEZ1qyAuFSEHmLjcG7pI
 isJrqOt9yjCjokWjnyXQ2j3jVBrv/BYP2KjSAKhs5uVJeSDC5MxUh23eG+qfYDKEd3G8
 Bmeqa9PKN1fvt5THSGTaWn7Si49rhxoUQFAqUS34TGj47q756jm7uUS/udwHZZCLzKQo
 h07XxNNm88/8FoUE0aRzvS7A5EDlbW8IQIWS2KUick5Hh4J9pWsVeUYLYDVIPYU7mGnS
 tXLo+4fysH6iNRD2l1IxwGYJhg0cJYQI7cji1hCMcyilIsJbA3o19MrHL277lQI1MsfT
 +aLw==
X-Gm-Message-State: AOJu0Yyfnj954wtdz9BeZHr6v/NDb1uCAVyIWHum3PZWB/oL+I0wvKoY
 hx91iaWg28S2PXXtPhLctPVgSUjmf0uJEJm8/9qxpbFZaHx+kFvedAjGmKfOATw=
X-Google-Smtp-Source: AGHT+IEa2ktCz9bcmguCGg6Ns8Il8ZXvaVvyR7jhwL5W5CT9ATde67YuuCueh9ipoO1j/4VHfrMXqQ==
X-Received: by 2002:a05:6871:b22:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-27c3f6c1025mr14408600fac.42.1726689964074; 
 Wed, 18 Sep 2024 13:06:04 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:bfe4:2aee:929f:be5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27d0b59bdcfsm49278fac.51.2024.09.18.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 13:06:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:05:57 -0500
From: Corey Minyard <corey@minyard.net>
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr,
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org,
 jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
Subject: Re: [PATCH 19/25] hw/misc: add i2c-tester
Message-ID: <Zusypeay8cjjPTn0@mail.minyard.net>
References: <20240918192254.3136903-1-tavip@google.com>
 <20240918192254.3136903-20-tavip@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918192254.3136903-20-tavip@google.com>
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=corey@minyard.net; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Sep 2024 16:52:16 -0400
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

On Wed, Sep 18, 2024 at 12:22:47PM -0700, Octavian Purdila wrote:
> Add a simple i2c peripheral to be used for testing I2C device
> models. The peripheral has a fixed number of registers that can be
> read and written.

Why is this better than just using the eeprom device?

This has some uncommon attributes compared to most i2c devices.  For
instance, most i2c devices take their address as the first bytes of a
write operation, then auto-increment after that for reads and writes.
This seems to take one address on a write after a system reset, then use
that forever.

Anyway, unless there is a compelling reason to use this over the eeprom
device, I'm going to recommend against it.

-corey

> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  include/hw/misc/i2c_tester.h |  30 ++++++++++
>  hw/misc/i2c_tester.c         | 109 +++++++++++++++++++++++++++++++++++
>  hw/misc/Kconfig              |   5 ++
>  hw/misc/meson.build          |   2 +
>  4 files changed, 146 insertions(+)
>  create mode 100644 include/hw/misc/i2c_tester.h
>  create mode 100644 hw/misc/i2c_tester.c
> 
> diff --git a/include/hw/misc/i2c_tester.h b/include/hw/misc/i2c_tester.h
> new file mode 100644
> index 0000000000..f6b6491008
> --- /dev/null
> +++ b/include/hw/misc/i2c_tester.h
> @@ -0,0 +1,30 @@
> +/*
> + *
> + * Copyright (c) 2024 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_I2C_TESTER_H
> +#define HW_I2C_TESTER_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/irq.h"
> +
> +#define I2C_TESTER_NUM_REGS    0x31
> +
> +#define TYPE_I2C_TESTER "i2c-tester"
> +#define I2C_TESTER(obj) OBJECT_CHECK(I2cTesterState, (obj), TYPE_I2C_TESTER)
> +
> +typedef struct {
> +    I2CSlave i2c;
> +    bool set_reg_idx;
> +    uint8_t reg_idx;
> +    uint8_t regs[I2C_TESTER_NUM_REGS];
> +} I2cTesterState;
> +
> +#endif /* HW_I2C_TESTER_H */
> diff --git a/hw/misc/i2c_tester.c b/hw/misc/i2c_tester.c
> new file mode 100644
> index 0000000000..77ce8bf91a
> --- /dev/null
> +++ b/hw/misc/i2c_tester.c
> @@ -0,0 +1,109 @@
> +/*
> + * Simple I2C peripheral for testing I2C device models.
> + *
> + * Copyright (c) 2024 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "hw/misc/i2c_tester.h"
> +
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +
> +static void i2c_tester_reset_enter(Object *o, ResetType type)
> +{
> +    I2cTesterState *s = I2C_TESTER(o);
> +
> +    s->set_reg_idx = false;
> +    s->reg_idx     = 0;
> +    memset(s->regs, 0, I2C_TESTER_NUM_REGS);
> +}
> +
> +static int i2c_tester_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    I2cTesterState *s = I2C_TESTER(i2c);
> +
> +    if (event == I2C_START_SEND) {
> +        s->set_reg_idx = true;
> +    }
> +
> +    return 0;
> +}
> +
> +static uint8_t i2c_tester_rx(I2CSlave *i2c)
> +{
> +    I2cTesterState *s = I2C_TESTER(i2c);
> +
> +    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
> +                      s->reg_idx);
> +        return I2C_NACK;
> +    }
> +
> +    return s->regs[s->reg_idx];
> +}
> +
> +static int i2c_tester_tx(I2CSlave *i2c, uint8_t data)
> +{
> +    I2cTesterState *s = I2C_TESTER(i2c);
> +
> +    if (s->set_reg_idx) {
> +        /* Setting the register in which the operation will be done. */
> +        s->reg_idx = data;
> +        s->set_reg_idx = false;
> +        return 0;
> +    }
> +
> +    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
> +                      s->reg_idx);
> +        return I2C_NACK;
> +    }
> +
> +    /* Write reg data. */
> +    s->regs[s->reg_idx] = data;
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_i2c_tester = {
> +    .name = "i2c-tester",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(i2c, I2cTesterState),
> +        VMSTATE_BOOL(set_reg_idx, I2cTesterState),
> +        VMSTATE_UINT8(reg_idx, I2cTesterState),
> +        VMSTATE_UINT8_ARRAY(regs, I2cTesterState, I2C_TESTER_NUM_REGS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void i2c_tester_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
> +    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
> +
> +    rc->phases.enter = i2c_tester_reset_enter;
> +    dc->vmsd = &vmstate_i2c_tester;
> +    isc->event = i2c_tester_event;
> +    isc->recv = i2c_tester_rx;
> +    isc->send = i2c_tester_tx;
> +}
> +
> +static const TypeInfo i2c_tester_types[] = {
> +    {
> +        .name = TYPE_I2C_TESTER,
> +        .parent = TYPE_I2C_SLAVE,
> +        .instance_size = sizeof(I2cTesterState),
> +        .class_init = i2c_tester_class_init
> +    },
> +};
> +
> +DEFINE_TYPES(i2c_tester_types);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4b688aead2..3e93c12c8e 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -213,6 +213,11 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>  
> +config I2C_TESTER
> +    bool
> +    default y if TEST_DEVICES
> +    depends on I2C
> +
>  config FLEXCOMM
>      bool
>      select I2C
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index faaf2671ba..4f22231fa3 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -158,6 +158,8 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>  # HPPA devices
>  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
>  
> +system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
> +
>  system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
>  system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
>  system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
> -- 
> 2.46.0.662.g92d0881bb0-goog
> 
> 

