Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D7F36BA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2B0-0005BC-Pg; Thu, 09 Apr 2026 23:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2Az-0005Ac-95
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:04:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2Aw-0008NG-Cd
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:04:57 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso2899184a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775790293; cv=none;
 d=google.com; s=arc-20240605;
 b=hG479K7DeG9FHTCfAY5xaV9oCk7e8puBwcHZS6/uZf8OQb1/0gSncd2yb/8WqjTDEa
 mcyMGonngi/lS/O0O/6DMeEZUBnvnzUaBNJ9nlIOF1AJTxdCfGv+vxlB+gH/bW9VnNEb
 u/Rnxoru8IkhJTj56mkYs7uz8mBTic8eV+nP2BV29oUp0d5IfzXwbQvW3mN8xt84IORH
 2qKDEa1YFRm3JQ6LfiZXP/RkWseUVcsS/vGCTYAVPYs2hyHYtiQEq+h0f84WskaeOLUC
 miPPtjDPl2g93KkSA1wPO0X5DD8X6AOnRLwP+5N0OC3dJzsEu8bS32UuP+57afDHX0dm
 cbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/bbgEJfaIkIowVYcS0htMfGzYrz1l9lMq7r4KDKlQ3w=;
 fh=qF9ugW4szhnyS0qe8D5bFnruRtXcqvkgvX/fNNkd/yw=;
 b=ThEDQFld+dJHAirz8g2nX6UFzvdQ2hdpH5YpkSgvifW84Ywc9nl72YkS1JHcJm55Cz
 8Y/NmvavFavmDag7rESo6zazkp2xbg91CgocLVDhv0DVUMsF2/wTQWc+ECPCtHad3jch
 UJouwH887LucOrH0Rm6mdep5GWgbHSPdEKjPhjvTLl2QeL9tidAb4RL6lqsJKNRk3dSI
 gulO9o0EAuZWd3zqp45T2r7wKkiiBsHcnQBvlNsy2knUwGOMmmbk1WqcGobQJeMCzqDP
 DgpC2ZECnFpoYmn9LjGzYlJPSq6wHjZyDnPzCNydv8Ge945z3anR3rWQZPdsJXhbtk62
 EB8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775790293; x=1776395093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bbgEJfaIkIowVYcS0htMfGzYrz1l9lMq7r4KDKlQ3w=;
 b=dVkNzbqSHPeIqUjaYmw9anNQ4jz7Os2hfltIWonHu3bElvCzRZ3xngsvwxsSZ9NdOC
 7pOGhaURc3lhb8neF7jNSV1lWhLrhvBaAV248MxxRBVo4AiMIp0kr/2EUfmk61TvXZkd
 c38r6zFX9vBRRbe1aSAzFcxfhloOsymRorVU3pauEGA3OzVYDTcxBMW1ZHVkXXQkJrxl
 hUIoqpS4gLGASWcB6yHVgmJrOqJuB6Gx9Mueq+rtuD582/ApC2Ok6/Xx71QVQA2c57jI
 RPJQSOdtVRY96Gc8MVO20gSmfFyseNtYSc+WnIuJz/AtvAH9sZ/sQtkENFJKbzcrvV0n
 D+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775790293; x=1776395093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bbgEJfaIkIowVYcS0htMfGzYrz1l9lMq7r4KDKlQ3w=;
 b=BzRBTvmMctcatCcCdzKXSvNgG6XQrMn2fHsrNSEW29UWLg5MOsPMhvqyOD1SBz+p8c
 AxO1h61CytSHqlBpiG3Vq/tnjALNSSyJIHA0bJqXRbGLeJH4+LTMTLUsYoR2r6D+pZRX
 kPQSKRhg/2w7N+05/fqZgjZ/sUVa9Htgbh44jj4WrWpv5VxFyirwnUxbpm6Au7p9UHH+
 xXI0l1Rh1megskIB/e3rix0Wawykw55KBbzALRrt/LvSGwnF+YUnEL+CaWk8dTbT6LBp
 vQKymLJd7U34vGa0qZHdRqOxOYmTAaTTeUUDvCBYYNUNnK/B681wzQFsI8WGDT2iRQ1P
 /0zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSvBi8TQ6hIYTZhbKofKuJOQELGhcRmjMmWuUyd89ByyJbyF7PCpx/eNKHRoDNmwdKfsoEBwdWTaX@nongnu.org
X-Gm-Message-State: AOJu0Ywnl+7QUGH6fBGrbPKPCVH5t9YHE6lvEwwoq4feKWKdEDoZC/lx
 bkLLPwWOqsbFj1JBSjiAuke4yMLfraq1Ymx7KphJ9cdCc4MMnzGspq3MFjnXThQBhOUVgfP7zP9
 LSjQ442dNLhWBfqXMxSeg2WTA54INLTI=
X-Gm-Gg: AeBDiesCRFprhZOHbPenwID71BMYyqTMC6Zq7r+0OPaDSekfPEd7HFLSLAoH9rAElo7
 STMX175x/Og4pxONUorXyMfdLbGfXHaZvPRX5eRJYqTulVf/Zxd4mSKPiZ5bAT8V0fLyyC8i3wD
 SSvCEszoNY0yaZe4/jSmmSP4Jfrw9r68LTAtVDfhuqafDYWLQ4aGTu7v03LOd5Ro/IXIP4UD1ra
 GuzTYDICSC5kUeq9Em16PV110CCmxGN9CyuuDQG3a6q0YWo4vGuvOWcykgQ7Fc+ptobGBeatbdY
 z1NXNbHjCe5RHa90xGmG9zIQgMpoqUIpi3IxeA==
X-Received: by 2002:a17:907:1c24:b0:b9d:30b1:66ff with SMTP id
 a640c23a62f3a-b9d728229dcmr89700466b.43.1775790292364; Thu, 09 Apr 2026
 20:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <177564643888.23414.7922925369077631439-0@git.sr.ht>
 <177564643888.23414.7922925369077631439-5@git.sr.ht>
In-Reply-To: <177564643888.23414.7922925369077631439-5@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:04:25 +1000
X-Gm-Features: AQROBzDuNSwmvU5QzCGJ3HeDsrM75uHKYnn5L5PYwDsZHX40MrkHeB37S31lJpw
Message-ID: <CAKmqyKPdmjaXEZ_7cZ0sNqcNFCKhJssOyRLpYFFV03wkZivZ_Q@mail.gmail.com>
Subject: Re: [PATCH qemu v2 5/7] ot_uart: implement missing features
To: "~lexbaileylowrisc" <lex.bailey@lowrisc.org>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org, 
 Amit Kumar-Hermosillo <amitkh@google.com>, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 9, 2026 at 5:49=E2=80=AFAM ~lexbaileylowrisc
<lexbaileylowrisc@git.sr.ht> wrote:
>
> From: Lex Bailey <lex.bailey@lowrisc.org>
>
> Adds in the missing features:
>  - oversampling
>  - loopback
>  - TX override
>  - RX Fifo control
>  - Alert handler test (will only be usable once the alert handler block i=
s also added)

These should be split up a bit more, this is still a huge patch

Alistair

>
> Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
> ---
>  hw/char/ot_uart.c         | 491 +++++++++++++++++++++++---------------
>  include/hw/char/ot_uart.h |  19 +-
>  2 files changed, 307 insertions(+), 203 deletions(-)
>
> diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
> index 923aab12af..37f2ca06ba 100644
> --- a/hw/char/ot_uart.c
> +++ b/hw/char/ot_uart.c
> @@ -28,8 +28,10 @@
>  #include "qemu/osdep.h"
>  #include "hw/char/ot_uart.h"
>  #include "qemu/fifo8.h"
> +#include "qapi/error.h"
> +#include "chardev/char-fe.h"
> +#include "hw/core/cpu.h"
>  #include "hw/core/irq.h"
> -#include "hw/core/qdev-clock.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-properties-system.h"
>  #include "hw/core/registerfields.h"
> @@ -114,6 +116,28 @@ REG32(TIMEOUT_CTRL, 0x30)
>  #define R_LAST_REG (R_TIMEOUT_CTRL)
>  #define REGS_COUNT (R_LAST_REG + 1u)
>  #define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
> +#define REG_NAME(_reg_) \
> +    ((((_reg_) < REGS_COUNT) && REG_NAMES[_reg_]) ? REG_NAMES[_reg_] : "=
?")
> +
> +#define REG_NAME_ENTRY(_reg_) [R_##_reg_] =3D stringify(_reg_)
> +static const char *REG_NAMES[REGS_COUNT] =3D {
> +    /* clang-format off */
> +    REG_NAME_ENTRY(INTR_STATE),
> +    REG_NAME_ENTRY(INTR_ENABLE),
> +    REG_NAME_ENTRY(INTR_TEST),
> +    REG_NAME_ENTRY(ALERT_TEST),
> +    REG_NAME_ENTRY(CTRL),
> +    REG_NAME_ENTRY(STATUS),
> +    REG_NAME_ENTRY(RDATA),
> +    REG_NAME_ENTRY(WDATA),
> +    REG_NAME_ENTRY(FIFO_CTRL),
> +    REG_NAME_ENTRY(FIFO_STATUS),
> +    REG_NAME_ENTRY(OVRD),
> +    REG_NAME_ENTRY(VAL),
> +    REG_NAME_ENTRY(TIMEOUT_CTRL),
> +    /* clang-format on */
> +};
> +#undef REG_NAME_ENTRY
>
>  static void ot_uart_update_irqs(OtUARTState *s)
>  {
> @@ -125,6 +149,21 @@ static void ot_uart_update_irqs(OtUARTState *s)
>      }
>  }
>
> +static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, SLPBK);
> +}
> +
> +static bool ot_uart_is_tx_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, TX);
> +}
> +
> +static bool ot_uart_is_rx_enabled(const OtUARTState *s)
> +{
> +    return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
> +}
> +
>  static int ot_uart_can_receive(void *opaque)
>  {
>      OtUARTState *s =3D opaque;
> @@ -149,6 +188,11 @@ static void ot_uart_receive(void *opaque, const uint=
8_t *buf, int size)
>      uint32_t rx_watermark_level;
>      size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
>
> +    if (size && !s->toggle_break) {
> +        /* no longer breaking, so emulate idle in oversampled VAL regist=
er */
> +        s->in_break =3D false;
> +    }
> +
>      for (int index =3D 0; index < size; index++) {
>          fifo8_push(&s->rx_fifo, buf[index]);
>      }
> @@ -203,21 +247,37 @@ static void ot_uart_xmit(OtUARTState *s)
>          return;
>      }
>
> -    /* instant drain the fifo when there's no back-end */
> -    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> -        ot_uart_reset_tx_fifo(s);
> -        ot_uart_update_irqs(s);
> -        return;
> -    }
> +    if (ot_uart_is_sys_loopack_enabled(s)) {
> +        /* system loopback mode, just forward to RX FIFO */
> +        uint32_t count =3D fifo8_num_used(&s->tx_fifo);
> +        buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> +        ot_uart_receive(s, buf, (int)size);
> +        count -=3D size;
> +        /*
> +         * there may be more data to send if data wraps around the end o=
f TX
> +         * FIFO
> +         */
> +        if (count) {
> +            buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
> +            ot_uart_receive(s, buf, (int)size);
> +        }
> +    } else {
> +        /* instant drain the fifo when there's no back-end */
> +        if (!qemu_chr_fe_backend_connected(&s->chr)) {
> +            ot_uart_reset_tx_fifo(s);
> +            ot_uart_update_irqs(s);
> +            return;
> +        }
>
> -    /* get a continuous buffer from the FIFO */
> -    buf =3D
> -        fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &siz=
e);
> -    /* send as much as possible */
> -    ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> -    /* if some characters where sent, remove them from the FIFO */
> -    if (ret >=3D 0) {
> -        fifo8_drop(&s->tx_fifo, ret);
> +        /* get a continuous buffer from the FIFO */
> +        buf =3D
> +            fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), =
&size);
> +        /* send as much as possible */
> +        ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
> +        /* if some characters where sent, remove them from the FIFO */
> +        if (ret >=3D 0) {
> +            fifo8_drop(&s->tx_fifo, ret);
> +        }
>      }
>
>      /* update INTR_STATE */
> @@ -253,7 +313,7 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_=
t val)
>          s->tx_watermark_level =3D 0;
>      }
>
> -    if (FIELD_EX32(s->regs[R_CTRL], CTRL, TX)) {
> +    if (ot_uart_is_tx_enabled(s)) {
>          ot_uart_xmit(s);
>      }
>  }
> @@ -269,8 +329,6 @@ static void ot_uart_reset_enter(Object *obj, ResetTyp=
e type)
>
>      memset(&s->regs[0], 0, sizeof(s->regs));
>
> -    s->regs[R_STATUS] =3D 0x0000003c;
> -
>      s->tx_watermark_level =3D 0;
>      for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
>          qemu_set_irq(s->irqs[index], 0);
> @@ -278,226 +336,265 @@ static void ot_uart_reset_enter(Object *obj, Rese=
tType type)
>      ot_uart_reset_tx_fifo(s);
>      ot_uart_reset_rx_fifo(s);
>
> -    s->tx_level =3D 0;
> -    s->rx_level =3D 0;
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
> +    /*
> +     * do not reset `s->in_break`, as that tracks whether we are current=
ly
> +     * receiving a break condition over UART RX from some device talking
> +     * to OpenTitan, which should survive resets. The QEMU CharDev only
> +     * supports transient break events and not the notion of holding the
> +     * UART in break, so remembering breaks like this is required to
> +     * support mocking of break conditions in the oversampled `VAL` reg.
> +     */
> +    if (s->in_break) {
> +        /* ignore CTRL.RXBLVL as we have no notion of break "time" */
> +        s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +    }
>
>      ot_uart_update_irqs(s);
>  }
>
> -static uint64_t ot_uart_get_baud(OtUARTState *s)
> +static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    if (event =3D=3D CHR_EVENT_BREAK) {
> +        if (!s->in_break || !s->oversample_break) {
> +            /* ignore CTRL.RXBLVL as we have no notion of break "time" *=
/
> +            s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
> +            ot_uart_update_irqs(s);
> +            /* emulate break in the oversampled VAL register */
> +            s->in_break =3D true;
> +        } else if (s->toggle_break) {
> +            /* emulate toggling break off in the oversampled VAL registe=
r */
> +            s->in_break =3D false;
> +        }
> +    }
> +}
> +
> +static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
> +{
> +    uint8_t val;
> +
> +    if (!(s->regs[R_CTRL] & R_CTRL_RX_MASK)) {
> +        return 0;
> +    }
> +
> +    if (fifo8_is_empty(&s->rx_fifo)) {
> +        return 0;
> +    }
> +
> +    val =3D fifo8_pop(&s->rx_fifo);
> +
> +    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)) =
{
> +        qemu_chr_fe_accept_input(&s->chr);
> +    }
> +
> +    return val;
> +}
> +
> +static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,
> +                                 void *opaque)
>  {
> -    uint64_t baud;
> +    OtUARTState *s =3D opaque;
>
> -    baud =3D ((s->regs[R_CTRL] & R_CTRL_NCO_MASK) >> 16);
> -    baud *=3D clock_get_hz(s->f_clk);
> -    baud >>=3D 20;
> +    s->watch_tag =3D 0;
> +    ot_uart_xmit(s);
>
> -    return baud;
> +    return FALSE;
> +}
> +
> +static void ot_uart_clock_input(void *opaque, int irq, int level)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    g_assert(irq =3D=3D 0);
> +
> +    s->pclk =3D (unsigned)level;
> +
> +    /* TODO: disable UART transfer when PCLK is 0 */
>  }
>
>  static uint64_t ot_uart_read(void *opaque, hwaddr addr, unsigned int siz=
e)
>  {
>      OtUARTState *s =3D opaque;
> -    uint64_t retvalue =3D 0;
> +    uint32_t val32;
>
> -    switch (addr >> 2) {
> +    hwaddr reg =3D R32_OFF(addr);
> +    switch (reg) {
>      case R_INTR_STATE:
> -        retvalue =3D s->regs[R_INTR_STATE];
> -        break;
>      case R_INTR_ENABLE:
> -        retvalue =3D s->regs[R_INTR_ENABLE];
> -        break;
> -    case R_INTR_TEST:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
>      case R_CTRL:
> -        retvalue =3D s->regs[R_CTRL];
> +    case R_FIFO_CTRL:
> +        val32 =3D s->regs[reg];
>          break;
>      case R_STATUS:
> -        retvalue =3D s->regs[R_STATUS];
> -        break;
> -
> -    case R_RDATA:
> -        retvalue =3D s->regs[R_RDATA];
> -        if ((s->regs[R_CTRL] & R_CTRL_RX_MASK) && (s->rx_level > 0)) {
> -            qemu_chr_fe_accept_input(&s->chr);
> -
> -            s->rx_level -=3D 1;
> -            s->regs[R_STATUS] &=3D ~R_STATUS_RXFULL_MASK;
> -            if (s->rx_level =3D=3D 0) {
> -                s->regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
> -                s->regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
> -            }
> +        /* assume that UART always report RXIDLE */
> +        val32 =3D R_STATUS_RXIDLE_MASK;
> +        /* report RXEMPTY or RXFULL */
> +        switch (fifo8_num_used(&s->rx_fifo)) {
> +        case 0:
> +            val32 |=3D R_STATUS_RXEMPTY_MASK;
> +            break;
> +        case OT_UART_RX_FIFO_SIZE:
> +            val32 |=3D R_STATUS_RXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        /* report TXEMPTY+TXIDLE or TXFULL */
> +        switch (fifo8_num_used(&s->tx_fifo)) {
> +        case 0:
> +            val32 |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
> +            break;
> +        case OT_UART_TX_FIFO_SIZE:
> +            val32 |=3D R_STATUS_TXFULL_MASK;
> +            break;
> +        default:
> +            break;
> +        }
> +        if (!ot_uart_is_tx_enabled(s)) {
> +            val32 |=3D R_STATUS_TXIDLE_MASK;
> +        }
> +        if (!ot_uart_is_rx_enabled(s)) {
> +            val32 |=3D R_STATUS_RXIDLE_MASK;
>          }
>          break;
> -    case R_WDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: wdata is write only\n", __func__);
> -        break;
> -
> -    case R_FIFO_CTRL:
> -        retvalue =3D s->regs[R_FIFO_CTRL];
> +    case R_RDATA:
> +        val32 =3D (uint32_t)ot_uart_read_rx_fifo(s);
>          break;
>      case R_FIFO_STATUS:
> -        retvalue =3D s->regs[R_FIFO_STATUS];
> -
> -        retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
> -        retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
> -
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: RX fifos are not supported\n", __func__);
> -        break;
> -
> -    case R_OVRD:
> -        retvalue =3D s->regs[R_OVRD];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> +        val32 =3D
> +            (fifo8_num_used(&s->rx_fifo) & 0xffu) << R_FIFO_STATUS_RXLVL=
_SHIFT;
> +        val32 |=3D
> +            (fifo8_num_used(&s->tx_fifo) & 0xffu) << R_FIFO_STATUS_TXLVL=
_SHIFT;
>          break;
>      case R_VAL:
> -        retvalue =3D s->regs[R_VAL];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: val is not supported\n", __func__);
> +        /*
> +         * This is not trivially implemented due to the QEMU UART
> +         * interface. There is no way to reliably sample or oversample
> +         * given our emulated interface, but some software might poll th=
e
> +         * value of this register to determine break conditions.
> +         *
> +         * As such, default to reporting 16 of the last sample received
> +         * instead. This defaults to 16 idle high samples (as a stop bit=
 is
> +         * always the last received), except for when the `oversample-br=
eak`
> +         * property is set and a break condition is received over UART R=
X,
> +         * where we then show 16 low samples until the next valid UART
> +         * transmission is received (or break is toggled off with the
> +         * `toggle-break` property enabled). This will not be accurate, =
but
> +         * should be sufficient to support basic software flows that
> +         * essentially use UART break as a strapping mechanism.
> +         */
> +        val32 =3D (s->in_break && s->oversample_break) ? 0u : UINT16_MAX=
;
> +        qemu_log_mask(LOG_UNIMP, "%s: VAL only shows idle%s\n", __func__=
,
> +                      (s->oversample_break ? "/break" : ""));
>          break;
> +    case R_OVRD:
>      case R_TIMEOUT_CTRL:
> -        retvalue =3D s->regs[R_TIMEOUT_CTRL];
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> +        val32 =3D s->regs[reg];
> +        qemu_log_mask(LOG_UNIMP, "%s: %s is not supported\n", __func__,
> +                      REG_NAME(reg));
> +        break;
> +    case R_ALERT_TEST:
> +    case R_INTR_TEST:
> +    case R_WDATA:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: W/O register 0x%02x (%s)\n",
> +                      __func__, (uint32_t)addr, REG_NAME(reg));
> +        val32 =3D 0;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> -        return 0;
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n", __func=
__,
> +                      (uint32_t)addr);
> +        val32 =3D 0;
> +        break;
>      }
>
> -    return retvalue;
> +    return (uint64_t)val32;
>  }
>
>  static void ot_uart_write(void *opaque, hwaddr addr, uint64_t val64,
>                            unsigned int size)
>  {
>      OtUARTState *s =3D opaque;
> -    uint32_t value =3D val64;
> +    uint32_t val32 =3D val64;
> +
> +    hwaddr reg =3D R32_OFF(addr);
>
> -    switch (addr >> 2) {
> +    switch (reg) {
>      case R_INTR_STATE:
> -        /* Write 1 clear */
> -        s->regs[R_INTR_STATE] &=3D ~value;
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_STATE] &=3D ~val32; /* RW1C */
>          ot_uart_update_irqs(s);
>          break;
>      case R_INTR_ENABLE:
> -        s->regs[R_INTR_ENABLE] =3D value;
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_ENABLE] =3D val32;
>          ot_uart_update_irqs(s);
>          break;
>      case R_INTR_TEST:
> -        s->regs[R_INTR_STATE] |=3D value;
> +        val32 &=3D INTR_MASK;
> +        s->regs[R_INTR_STATE] |=3D val32;
>          ot_uart_update_irqs(s);
>          break;
> -
> +    case R_ALERT_TEST:
> +        val32 &=3D R_ALERT_TEST_FATAL_FAULT_MASK;
> +        s->regs[reg] =3D val32;
> +        /* This will also set an IRQ once the alert handler is added */
> +        break;
>      case R_CTRL:
> -        s->regs[R_CTRL] =3D value;
> -
> -        if (value & R_CTRL_NF_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_NF is not supported\n", __func_=
_);
> -        }
> -        if (value & R_CTRL_SLPBK_MASK) {
> +        if (val32 & ~CTRL_SUP_MASK) {
>              qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_SLPBK is not supported\n", __fu=
nc__);
> +                          "%s: UART_CTRL feature not supported: 0x%08x\n=
",
> +                          __func__, val32 & ~CTRL_SUP_MASK);
>          }
> -        if (value & R_CTRL_LLPBK_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_LLPBK is not supported\n", __fu=
nc__);
> -        }
> -        if (value & R_CTRL_PARITY_EN_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_PARITY_EN is not supported\n",
> -                          __func__);
> -        }
> -        if (value & R_CTRL_PARITY_ODD_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_PARITY_ODD is not supported\n",
> -                          __func__);
> -        }
> -        if (value & R_CTRL_RXBLVL_MASK) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: UART_CTRL_RXBLVL is not supported\n", __f=
unc__);
> +        uint32_t prev =3D s->regs[R_CTRL];
> +        s->regs[R_CTRL] =3D val32 & CTRL_MASK;
> +        uint32_t change =3D prev ^ s->regs[R_CTRL];
> +        if ((change & R_CTRL_RX_MASK) && ot_uart_is_rx_enabled(s) &&
> +            !ot_uart_is_sys_loopack_enabled(s)) {
> +            qemu_chr_fe_accept_input(&s->chr);
>          }
> -        if (value & R_CTRL_NCO_MASK) {
> -            uint64_t baud =3D ot_uart_get_baud(s);
> -
> -            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> +        if ((change & R_CTRL_TX_MASK) && ot_uart_is_tx_enabled(s)) {
> +            /* try sending pending data from TX FIFO if any */
> +            ot_uart_xmit(s);
>          }
>          break;
> -    case R_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: status is read only\n", __func__);
> -        break;
> -
> -    case R_RDATA:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: rdata is read only\n", __func__);
> -        break;
>      case R_WDATA:
> -        uart_write_tx_fifo(s, value);
> +        uart_write_tx_fifo(s, (uint8_t)(val32 & R_WDATA_WDATA_MASK));
>          break;
> -
>      case R_FIFO_CTRL:
> -        s->regs[R_FIFO_CTRL] =3D value;
> -
> -        if (value & R_FIFO_CTRL_RXRST_MASK) {
> -            s->rx_level =3D 0;
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: RX fifos are not supported\n", __func__);
> +        s->regs[R_FIFO_CTRL] =3D
> +            val32 & (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MASK);
> +        if (val32 & R_FIFO_CTRL_RXRST_MASK) {
> +            ot_uart_reset_rx_fifo(s);
> +            ot_uart_update_irqs(s);
>          }
> -        if (value & R_FIFO_CTRL_TXRST_MASK) {
> -            s->tx_level =3D 0;
> +        if (val32 & R_FIFO_CTRL_TXRST_MASK) {
> +            ot_uart_reset_tx_fifo(s);
> +            ot_uart_update_irqs(s);
>          }
>          break;
> -    case R_FIFO_STATUS:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: fifo_status is read only\n", __func__);
> -        break;
> -
>      case R_OVRD:
> -        s->regs[R_OVRD] =3D value;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: ovrd is not supported\n", __func__);
> -        break;
> -    case R_VAL:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: val is read only\n", __func__);
> +        if (val32 & R_OVRD_TXEN_MASK) {
> +            qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
> +                          __func__);
> +        }
> +        s->regs[R_OVRD] =3D val32 & R_OVRD_TXVAL_MASK;
>          break;
>      case R_TIMEOUT_CTRL:
> -        s->regs[R_TIMEOUT_CTRL] =3D value;
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: timeout_ctrl is not supported\n", __func__);
> +        s->regs[R_TIMEOUT_CTRL] =3D
> +            val32 & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
> +        break;
> +    case R_STATUS:
> +    case R_RDATA:
> +    case R_FIFO_STATUS:
> +    case R_VAL:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: R/O register 0x%02x (%s)\n",
> +                      __func__, (uint32_t)addr, REG_NAME(reg));
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, add=
r);
> -    }
> -}
> -
> -static void ot_uart_clk_update(void *opaque, ClockEvent event)
> -{
> -    OtUARTState *s =3D opaque;
> -
> -    /* recompute uart's speed on clock change */
> -    uint64_t baud =3D ot_uart_get_baud(s);
> -
> -    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> -}
> -
> -static void fifo_trigger_update(void *opaque)
> -{
> -    OtUARTState *s =3D opaque;
> -
> -    if (s->regs[R_CTRL] & R_CTRL_TX_MASK) {
> -        ot_uart_xmit(s);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n", __func=
__,
> +                      (uint32_t)addr);
> +        break;
>      }
>  }
>
> @@ -519,15 +616,12 @@ static int ot_uart_post_load(void *opaque, int vers=
ion_id)
>
>  static const VMStateDescription vmstate_ot_uart =3D {
>      .name =3D TYPE_OT_UART,
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .post_load =3D ot_uart_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
>          VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
> -        VMSTATE_UINT32(tx_level, OtUARTState),
> -        VMSTATE_UINT64(char_tx_time, OtUARTState),
> -        VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
>          VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uin=
t32,
>                        uint32_t),
>          VMSTATE_END_OF_LIST()
> @@ -536,22 +630,38 @@ static const VMStateDescription vmstate_ot_uart =3D=
 {
>
>  static const Property ot_uart_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", OtUARTState, chr),
> +    DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, =
false),
> +    DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
>  };
>
> +static int ot_uart_fe_change(void *opaque)
> +{
> +    OtUARTState *s =3D opaque;
> +
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_fe_change, s=
, NULL,
> +                             true);
> +
> +    if (s->watch_tag > 0) {
> +        g_source_remove(s->watch_tag);
> +        /* NOLINTNEXTLINE(clang-analyzer-optin.core.EnumCastOutOfRange) =
*/
> +        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_=
HUP,
> +                                             ot_uart_watch_cb, s);
> +    }
> +
> +    return 0;
> +}
> +
>  static void ot_uart_init(Object *obj)
>  {
>      OtUARTState *s =3D OT_UART(obj);
>
> -    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> -                                  ot_uart_clk_update, s, ClockUpdate);
> -    clock_set_hz(s->f_clk, OT_UART_CLOCK);
> -
>      for (unsigned index =3D 0; index < OT_UART_IRQ_NUM; index++) {
>          sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[index]);
>      }
>
> -    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
> -                          TYPE_OT_UART, 0x400);
> +    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s, TYPE_OT_UART,
> +                          REGS_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
>      /*
> @@ -567,15 +677,14 @@ static void ot_uart_realize(DeviceState *dev, Error=
 **errp)
>  {
>      OtUARTState *s =3D OT_UART(dev);
>
> -    s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                          fifo_trigger_update, s);
> +    qdev_init_gpio_in_named(DEVICE(s), &ot_uart_clock_input, "clock-in",=
 1);
>
>      fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
>      fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
>
> -    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
> -                             ot_uart_receive, NULL, NULL,
> -                             s, NULL, true);
> +    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_recei=
ve,
> +                             ot_uart_event_handler, ot_uart_fe_change, s=
, NULL,
> +                             true);
>  }
>
>  static void ot_uart_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
> index a2c5ff8b33..512684afd6 100644
> --- a/include/hw/char/ot_uart.h
> +++ b/include/hw/char/ot_uart.h
> @@ -28,11 +28,8 @@
>  #include "hw/core/sysbus.h"
>  #include "qemu/fifo8.h"
>  #include "chardev/char-fe.h"
> -#include "qemu/timer.h"
>  #include "qom/object.h"
>
> -#define OT_UART_CLOCK 50000000 /* 50MHz clock */
> -
>  #define TYPE_OT_UART "ot-uart"
>  OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)
>
> @@ -44,22 +41,20 @@ struct OtUARTState {
>      MemoryRegion mmio;
>      qemu_irq irqs[9];
>
> -    uint32_t tx_level;
> -
> -    uint32_t rx_level;
> -
> -    QEMUTimer *fifo_trigger_handle;
> -    uint64_t char_tx_time;
> -
>      uint32_t regs[13]; /* Length must be updated if regs added or remove=
d */
>
>      Fifo8 tx_fifo;
>      Fifo8 rx_fifo;
>      uint32_t tx_watermark_level;
> +    bool in_break;
> +    guint watch_tag;
> +    unsigned pclk; /* Current input clock */
> +    const char *clock_src_name; /* IRQ name once connected */
>
> -    Clock *f_clk;
> -
> +    DeviceState *clock_src;
>      CharFrontend chr;
> +    bool oversample_break; /* Should mock break in the oversampled VAL r=
eg? */
> +    bool toggle_break; /* Are incoming breaks temporary or toggled? */
>  };
>
>  struct OtUARTClass {
> --
> 2.49.1
>
>

