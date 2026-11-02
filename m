Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B623606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jf9WR4Eq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpQm-0006DV-UC; Mon, 02 Nov 2026 05:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpQl-0006Ct-Eo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:38:23 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpQk-0007hE-1c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:38:23 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8ab395abf79so23169867b3.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:38:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793615900; cv=none;
 d=google.com; s=arc-20260327;
 b=ihb7jyerA+AH+hI8uCrb4uYTHK2w7TYDa08IO39dh+2ZrT0gcqJjIpB+COS7s0G+ZZ
 G5rzKUDo4K+4S8+tVclcUGqn2IonWv8BA+N9xM6xfIJh0qKmYw/Z+IOtbNU3l3Vlz7Xu
 Q/WbHptJ3Z1xgMQc3HpOCwVkcx+4Ljiotsj1i0oMrPsy/d1SgsVqjL4A7EdXSmTqc083
 eoG93vS1nbFIwhgINjHHKHaBhkwMyYUvLeknjEPOiYeXrDoOQdwITYEgfSk9C929A96U
 w1DJ2reuBhagXXODMyENoYBFpPhMieMhJBCtx07fnnAcM1AtG+i+sMdONvT52eaOuJju
 ETNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s4V4JgH1sRadu7eDYq9bAfUCFNtlrsLwFoYkQoWEgF0=;
 fh=TYgLo6LSaCnSg4LxfB/cFu8QqHO9C1zPedgQPfry9ms=;
 b=WAiuHW9bLFhA6CGpJpHublihcpbrt2J3lpEchzrAXQptfsmyG3GhVA4NwPKaRT7/Wp
 1slIHaon9U5hzNrvS1KyNkoewApfKRosxdQNlbhx1YRd8BeB6hNj6dwODKYC6Afywtrt
 QbDdcKymLWkjvJ1IncBatMykL91ie+sEHoqxUPwiJJwR3MKyRIgYRjHzJ5EhU8A1ZoIz
 HX7oWQZdQd+YeqCnOoE4+Tjm9nzj8CQN+eADagLBbdNeRoF+gSkZmULUt4fc44cstSzh
 bVX8bX03jldxW2t5TgVxlGW+o0C5MPEr5Je1c5bPC0ocji654qVU4omxQDupCUlJMHHG
 cGmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793615900; x=1794220700; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s4V4JgH1sRadu7eDYq9bAfUCFNtlrsLwFoYkQoWEgF0=;
 b=Jf9WR4EqF5LtKjSC3c+4MqKW2kh0Eb3un9CjLigjQRsazUdoLHJh1ee6lJmgMzGsZq
 8GEDDzuOXekgKvvLsjORiL2/E7TwEvdXVX/4QTnbp3XfRZb+Vh9orG2+QiIYccbwP6Hi
 tisescC3TXftKXQPQtDALZ1DLZ1Uhj99OdxVxIm88lqxY/k2FyiHwlZqQ3WkLl8VixmO
 rLW/+C8SYP5jzq/jyWVIxDpecg01CKlkTFs3ecFibt9w/tMMSsIP4eSfpyfJM9CDAhZg
 spMPNZkGsP5fU+pO5pYvVVAln9avqNsNE1wwFPSJhD8GlQpWdT1tNRDMDLlmHPeAGmuL
 usOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615900; x=1794220700;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s4V4JgH1sRadu7eDYq9bAfUCFNtlrsLwFoYkQoWEgF0=;
 b=r4ouszZ9oGGUXRLX/+QMWKIYCfBZ0VGvXr9pe523YOBY577M1L6RvBGUhSRfnK46Q5
 Jjc9cwldtWfediUuKPZJGZt+jW1gLM47F++OSSL3rpfk0YhVLgfDmtf1zTX4sGJqRj9u
 ymtZjFQlpaV3AbrVh8uSg0J94FS/jmOaNCF2KLszoD3+8rr45GlAAosfF5Pp7hWF7JLL
 /guJGagLL6anNy6IEWLabtyrp4vBqkgEZ9awNCjyGGkh+6Pt+297Uq6GfiYMk2lwFTAX
 0Jm3L7yBydHZ9ay2WbLUWsDihhXkjTXQ/oRglsdwGCBCD7lx2S25FJkQMFvH5XoPCw9E
 SfSA==
X-Gm-Message-State: APuU4Z8lAgiQAibZGvKDTTnL6M/iLIXKYX4SOIFDtHvpRMxEN0HK27sN
 WHp508IuQoLZnPCcoE2OKv1TPC8gfFmP57Q0RXC5gE9ZlKK9oq4guNRqcb1RkMIxpwfjtul6hML
 G2s6DFgZDgWZAPDOwKpURdIIDJKqkIEk2/eX4hqfXXg==
X-Gm-Gg: AYBFou0PxkvTXVrng4pt5cR+pSU1R6KsDJeKZeXyF/ll+cXI3zugoFAm1Gz7BjLJAve
 x78DEBlQ+/VLdNq0xFagEeXX8ldw2vsEqb2PmbJ+SXaclNsUK6dH+8M6/GWTdi3uM/q5DPjZAwi
 rjYm6MyYbyE59b5aTZx7O4DmDYtr2C1m4CpOjTVa9xKQFmWfoL1VmSD++2Eam/2ic73+IglW3VI
 ae/cBVuBqafgTE0+6DxWKXGSM5nsNrmyjjPqb3LWxzVHodcXMqG55/cJtPK1Rnq4WUmPsFrnSei
 XQpjZxhMQO81I/UK76Xj/5dykr5NIAz/QN6Aj/UNGmYPSw9yr+Cz9P5aRYo+fUUEOH8+kcxMdha
 hai93R0IYQFaHT5CLP2JPwW/joGl8jdI5/X5gQ2ZmTWxfW3JHctx8TvUXl0/p3WnyGJdM3hB/+p
 ggYqDB1jW9UKrUaGz2d2AN
X-Received: by 2002:a05:690c:6e86:b0:8b0:d36c:14f6 with SMTP id
 00721157ae682-8b2b67d9dcbmr72015307b3.51.1793615900276; Mon, 02 Nov 2026
 02:38:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
 <c2ea822f9f49674173e5ae3089631838d034aef7.1793613972.git.lorandmarton.dev@gmail.com>
In-Reply-To: <c2ea822f9f49674173e5ae3089631838d034aef7.1793613972.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:38:08 +0000
X-Gm-Features: AclHuK_XqZtOsc8szfO9VHxdDkaxhsl6sW2hdRx0nz0Y1IhXdcnqNcnTAMDL66U
Message-ID: <CAFEAcA-p9oa=tAjDgWUHF7YfNq1SpvuWa4ta6uU0QAq1b6Np-w@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/timer/bcm2835_systmr: cancel the compares and
 lower the IRQs on reset
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:27, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> bcm2835_systmr_reset() cleared the match bits and the compare
> registers, but a channel whose match had raised its interrupt kept the
> line raised, and a compare armed before the reset still fired after
> it, setting its match bit and raising the interrupt in a guest that
> had not armed it. Both happen when a guest reboots with a system timer
> channel in use (the firmware or a bare-metal guest's tick).
>
> Delete the timers and lower the interrupts in the reset, as the
> register values now say.
>
> Test that a reset drops a raised channel and that a compare set before
> it does not fire.
>
> Fixes: be95dffa326a ("hw/timer/bcm2835: Support the timer COMPARE registers")
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---
>  hw/timer/bcm2835_systmr.c         |  4 +++
>  tests/qtest/bcm2835-systmr-test.c | 54 +++++++++++++++++++++++++++++++
>  tests/qtest/meson.build           |  2 +-
>  3 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/bcm2835-systmr-test.c
>
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> index 06a919b1f8..3c03c98193 100644
> --- a/hw/timer/bcm2835_systmr.c
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -123,6 +123,10 @@ static void bcm2835_systmr_reset(DeviceState *dev)
>      BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
>
>      memset(&s->reg, 0, sizeof(s->reg));
> +    for (size_t i = 0; i < ARRAY_SIZE(s->tmr); i++) {
> +        timer_del(&s->tmr[i].timer);
> +        qemu_set_irq(s->tmr[i].irq, 0);
> +    }
>  }

The timer_del() is correct, the qemu_set_irq() is not.

-- PMM

