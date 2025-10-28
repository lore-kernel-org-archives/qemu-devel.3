Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE826CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhET-0000Gi-Us; Tue, 28 Oct 2025 06:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhE5-0008EO-Gs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDhDy-0005u5-EQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761648401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqswuCohGI/O8Z9pOr54ZNHujtz9Cg9VUJQ0QE3M9/s=;
 b=BFZG75Fw+zx4jGaH5TQp6zF57ZSFDKky6GLIkf1OQbYzqXeaSKBjJ+ni8J5YqdPiAVOKTb
 +uwtLlx3eiJ9/QhyEkxf9dpiyLGjAOMU1cYDOWlN833DoHDdT9+kv1uZqe+S6VfibyOI1Y
 +tv+9OtITeSuzvagVDuDBJBWi6j9jiQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-nr_M7NC4PEegOlF3SmlH3A-1; Tue, 28 Oct 2025 06:46:40 -0400
X-MC-Unique: nr_M7NC4PEegOlF3SmlH3A-1
X-Mimecast-MFC-AGG-ID: nr_M7NC4PEegOlF3SmlH3A_1761648399
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42814749a6fso3005639f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761648399; x=1762253199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqswuCohGI/O8Z9pOr54ZNHujtz9Cg9VUJQ0QE3M9/s=;
 b=mDK0Z+GggpAwGkZ8I6H4l8BNRBlPQhFwftkxfW2VYsj9TnjE8a/BVQ4dULC0JBf3Ku
 xt7OG2OchGWojVbaOiNZ72UDDaVFqGYcXqPXEHMmNDvAIrKN0741uLzsQ2zOAuNRSRlE
 xTanhueqZmGlLFl6hlsdf44cEqSoKc8m44HSgYhd263+Xglm41BBVlqUMdiy5Q6bFmq4
 V1I/S9BkxGHrBjyUS5606MnqXaYUqYBe8IFfN81AhKSdj54CphshHlYr+XOU0U3ykhX3
 KkoJSaS5vfaaJ18GlDe2rXAnPqCKxkQ7hIlxkdriGgk0uBMf2WHYoQn6gw3yw4YSIzTj
 3m5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP49BjBOOE2IbEzBw/6fKXk6kTRyrP964niAcWGdn62Ahv4DqT3aoHIH/AoNhDDxtQt4PECdKtkKtn@nongnu.org
X-Gm-Message-State: AOJu0YysGslcNUbAzB4yhVXlH4twguhGKs5YynooV6pQJDo61cQXoQbB
 TsFhelUpYjmQa0OJxjW+Iv/MN8QejTTbs27tq8M87AJ9IyD93GGinUKk75XtP4L+YC+me4asoLl
 MWlazhoVFshpqcxXult5pIuxnW7naV5JuADtZEvT+YoPvyvHEpBuBE5eSFF2QvwEs9P5ax4Pyzd
 29fJPFU7yMSS+V8lv5TOX2CcKylQKbNbo=
X-Gm-Gg: ASbGncvugOFv1V+U4WPznJVXGkIaChkXJBUDuYq5HC35eic9Uyjw4YgSn7xZXj7qfWa
 Q1fn6UDMSTp3K77A19Ccd0C8W+43UjHKOHBn20B+aZVBCWg4eevbxufDeezD4lwGlPaNCamuxVR
 6UBUuQ5wPajJZWlVhJs7iXAGMimwrUuQH2RQ9GiBN0bgWNAvGDkgLjzUiJyNLMxnj8B9d/8siNY
 N7OU1dJNNQ0F+0/aHQ/k9deoVnzA3tv7QaJ2gQpZF7vRI/Omc2AWVcMciiS
X-Received: by 2002:a05:6000:290c:b0:427:7ad:466f with SMTP id
 ffacd0b85a97d-429a7e83a78mr2445393f8f.39.1761648398952; 
 Tue, 28 Oct 2025 03:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPWkS17TzLd/QE4SHuRoKCUtw0TrWEdmtuZ6c5g7w+i8DEOEeGCmi1GFQB+A9ScnDHNzxOp1Q8i+I/v0UfXOk=
X-Received: by 2002:a05:6000:290c:b0:427:7ad:466f with SMTP id
 ffacd0b85a97d-429a7e83a78mr2445365f8f.39.1761648398504; Tue, 28 Oct 2025
 03:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <90746cd6a57c0df971158f604c422a23d750e0b4.1761644606.git.chenmiao@openatom.club>
In-Reply-To: <90746cd6a57c0df971158f604c422a23d750e0b4.1761644606.git.chenmiao@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 11:46:26 +0100
X-Gm-Features: AWmQ_bnsVmMuJKLz4wLLnF7FNTgdlpPIZ7-XG8OEzdCH4xAw5wUwlTwvFMjUwjU
Message-ID: <CABgObfZEm7nu1gRPHQnYc-WJ2PHrBa40VX6Qv2bRTWBYt2BsOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] hw/gpio: Move the pcf8574 struct to header
To: chenmiao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 28, 2025 at 11:18=E2=80=AFAM chenmiao <chenmiao@openatom.club> =
wrote:
>
> To better implement the Rust PCF8574 bindings, move its struct definition=
 to
> the header file.

This should not be needed, the struct is entirely hidden within the C
implementation and the same should be true for the Rust one.

Paolo

> Signed-off-by: chenmiao <chenmiao@openatom.club>
> ---
>  hw/gpio/pcf8574.c         | 32 --------------------------------
>  include/hw/gpio/pcf8574.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
> index 274b44bb61..670fc006bb 100644
> --- a/hw/gpio/pcf8574.c
> +++ b/hw/gpio/pcf8574.c
> @@ -15,38 +15,6 @@
>  #include "qemu/module.h"
>  #include "qom/object.h"
>
> -/*
> - * PCF8574 and compatible chips incorporate quasi-bidirectional
> - * IO. Electrically it means that device sustain pull-up to line
> - * unless IO port is configured as output _and_ driven low.
> - *
> - * IO access is implemented as simple I2C single-byte read
> - * or write operation. So, to configure line to input user write 1
> - * to corresponding bit. To configure line to output and drive it low
> - * user write 0 to corresponding bit.
> - *
> - * In essence, user can think of quasi-bidirectional IO as
> - * open-drain line, except presence of builtin rising edge acceleration
> - * embedded in PCF8574 IC
> - *
> - * PCF8574 has interrupt request line, which is being pulled down when
> - * port line state differs from last read. Port read operation clears
> - * state and INT line returns to high state via pullup.
> - */
> -
> -OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
> -
> -#define PORTS_COUNT (8)
> -
> -struct PCF8574State {
> -    I2CSlave parent_obj;
> -    uint8_t  lastrq;     /* Last requested state. If changed - assert ir=
q */
> -    uint8_t  input;      /* external electrical line state */
> -    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
> -    qemu_irq handler[PORTS_COUNT];
> -    qemu_irq intrq;      /* External irq request */
> -};
> -
>  static void pcf8574_reset(DeviceState *dev)
>  {
>      PCF8574State *s =3D PCF8574(dev);
> diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
> index 3291d7dbbc..fe1ce891b7 100644
> --- a/include/hw/gpio/pcf8574.h
> +++ b/include/hw/gpio/pcf8574.h
> @@ -10,6 +10,42 @@
>  #ifndef _HW_GPIO_PCF8574
>  #define _HW_GPIO_PCF8574
>
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "qom/object.h"
> +
>  #define TYPE_PCF8574 "pcf8574"
>
> +/*
> + * PCF8574 and compatible chips incorporate quasi-bidirectional
> + * IO. Electrically it means that device sustain pull-up to line
> + * unless IO port is configured as output _and_ driven low.
> + *
> + * IO access is implemented as simple I2C single-byte read
> + * or write operation. So, to configure line to input user write 1
> + * to corresponding bit. To configure line to output and drive it low
> + * user write 0 to corresponding bit.
> + *
> + * In essence, user can think of quasi-bidirectional IO as
> + * open-drain line, except presence of builtin rising edge acceleration
> + * embedded in PCF8574 IC
> + *
> + * PCF8574 has interrupt request line, which is being pulled down when
> + * port line state differs from last read. Port read operation clears
> + * state and INT line returns to high state via pullup.
> + */
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PCF8574State, PCF8574)
> +
> +#define PORTS_COUNT (8)
> +
> +struct PCF8574State {
> +    I2CSlave parent_obj;
> +    uint8_t  lastrq;     /* Last requested state. If changed - assert ir=
q */
> +    uint8_t  input;      /* external electrical line state */
> +    uint8_t  output;     /* Pull-up (1) or drive low (0) on bit */
> +    qemu_irq handler[PORTS_COUNT];
> +    qemu_irq intrq;      /* External irq request */
> +};
> +
>  #endif /* _HW_GPIO_PCF8574 */
> --
> 2.43.0
>


