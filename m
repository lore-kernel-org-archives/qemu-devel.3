Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ACDF30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5YH-00039N-Sk; Thu, 05 Mar 2026 05:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5YG-000372-3N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:03:28 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy5YD-000756-JP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:03:26 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so7117940d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772705004; cv=none;
 d=google.com; s=arc-20240605;
 b=EYUroOzeAgf9q6F0FpxCKxRL0n3BeaKmAEV6UboYCl/zd4BYOrncqn5xQK/z0Au11J
 NrksDaKZ2JbbSadT2T3MGQRNE39941q9cRwhshKWbFoAQNIhVGFDW6uOTMHiML9n8+NE
 cosDk89Vpl2+HoGXwpRF39d9Ny2BbKbNs4oH/bzHYeA/OI7Ib18P/0Q4KzPSbgITdxyC
 eBNfhHgdvVQv3q+FAgExOQ7fzHIJFMdqAVBLJwo7rlYxnm+VVzjFrkM5g1Wz3NunUPda
 ywRUhKxTOg2WzD/bMUD1oeSiwy9/epj4sMJ3Ay8CyQaVpfztlXWs3eJKxhIuu69oaKYj
 bprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KHd7yIKGZb17pMwIRnOnZZ5BJusJ15j8VZsmgrfEs80=;
 fh=jIzvWV6lmISWZTXv3M0Np2HMsoZAsMa3LTC/2QEOYEg=;
 b=bXBIdO/PU5zC/NdapQ6Ben/M8AiYXX6cByyx9Yb0v2TsBVo/dqNYZQlKa/88JvHKKA
 LYGWnSQRfhDjBQwjpfFVWcYYkTsdtrcFo7i/s6OkfJahJs1GmomrJryEMCz3MBS0Krxq
 Hfs4wREM28/0odUr1/3H1bZJfgIi+dcQ7YXoCJoHfsMdU3q3fAV/ilUL7molNZMH7YVD
 5F4EM0gGpWakuFxvil5vpNjKqpNXyJIGrSwAiWorZPTDD7q2MJtwSER1cpTJGLpKzIJY
 wxGjKoBICN+npyOC6npXm+o0QqH1UOwJ+TzUhW0PpDYFdzgsrl0Kve6jpR5/vjjYJUGI
 6oRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772705004; x=1773309804; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KHd7yIKGZb17pMwIRnOnZZ5BJusJ15j8VZsmgrfEs80=;
 b=HnOdswRORyvfUuIo5p3iTYYldtjTeT4t9YiHGi6LX092+ZHSbLRDmvrd/JaFzt8CGj
 urs/kVztnmuwIzy3cDtoANbZCJt2+ng+WrkK6oGnAQ+cHNuAI0gUaJcNoMM/c1QYWBf6
 PYkEDZE4qYUgs/0KUS6FStpg8M9/Hi0qZad919dXYd+PkTnVPxBqB4RVAiBGTTLsnBUe
 MZ/lwHRQlQghZezoUHkUiniDrAxOLHHVPmvdeqc7iOnLaoUq2vl4osJzZuYkPZqzp7HF
 YImTU9H7xTyBa2LLFUCcvLDQULAvJ3ZFt+s6HofvsWQ/3Wl6peNBRnNH8UHOJIQSmMtz
 AqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772705004; x=1773309804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHd7yIKGZb17pMwIRnOnZZ5BJusJ15j8VZsmgrfEs80=;
 b=sTe3HivAPllHW5F45rfjoIjrHWoqbjXdfR2z2RVGjPKafLjDRX1KZ4VLecCs7//uZQ
 aVcMP6sO+k/qqCJk7VKj2usDwEe+urF7+PsF09fHhK1stLX9WZRWJRSwqUjMWLQxn4Cs
 IG57+vGNX07oFXnCJ2BYISMgx5HzWQuy4DNtZ4Tdg3JZAWgPX4FHHAgZnaypq9SX+H8b
 UwQX+uGRaxpgRYrttuv7alM2UlaxfZRCsTU6eskjsD1Zm4/8CYj0raZ0t/HHHaD8fr72
 zwsdHgGslnSDP43zur/E1wgQ5s+olKE/ZlQtgOYXNhuNMzEuA9E+76jd+TOwyKme6Slz
 52lQ==
X-Gm-Message-State: AOJu0Yx6uAI8YMmlvJLcr6lnJQ4pUb6HlNpMazAS4ooLylFlejEU9P9U
 k12+ANPVz7gqjBucc+L7HyZ9SNwDDaXLr4dNE9VJATswdIw6zNyDKnv3QJqgZePOUFcoh1LoWPV
 fm99xuUwRkw6egUaKFfBN3WVtLzXP9YQiJX1wVmBpXQ==
X-Gm-Gg: ATEYQzyagl4Jhe7uNIBc06s/AP7X62qBYL92vvle4NNsD4Q2jXlZMZsl0tmO0EQiZ5T
 8IT1EusnB8xUlj6X67+mg+InUqGVgHz0PEr5VgWddqiVbiU1XDxN1RI8C4nr58+FJdV2UfaQEM8
 1kFUNpr1OGu4QyuJVZ/BYq1/HtqAvnEZgghBZl0sPqbnMvFAXcu59LsBsrSx/pH4naKeiLK4lFK
 dAqNE6lkRKzFkawpCPO29BWpBGemgmbbxdqvNrW+Q/AfiO9amzhPpP0vYjhXibtIAnp44lRIsur
 CtLnjTc84pD8XUJYO/QSSNMPpa/7EhZ8zAEx6Cfn9ePGRaVderv9oExgGjpuP3yEl6U=
X-Received: by 2002:a05:690e:1248:b0:64a:ea66:bb53 with SMTP id
 956f58d0204a3-64cf9b488d8mr4701146d50.23.1772705004047; Thu, 05 Mar 2026
 02:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
In-Reply-To: <20260303222143.142741-12-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:03:12 +0000
X-Gm-Features: AaiRm52UNATOSx0iu2hbcolabT6dSuIWqmHWdFy47gJ-CZBrSuQLKhYZHynJSTc
Message-ID: <CAFEAcA-bOjd7vRKpnzU18aNUFuMb4eJYcDAH0Xcbf4SDr6ZO5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 3 Mar 2026 at 22:22, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Rather than requiring users of TYPE_SERIAL to initialize the MMIO region
> themselves, make it generic enough to be configured via properties. This
> makes TYPE_SERIAL more self-contained and prepares it for being turned
> into a SysBusDevice.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/char/serial-mm.h |  3 --
>  include/hw/char/serial.h    |  4 +-
>  hw/char/diva-gsp.c          |  5 ---
>  hw/char/serial-isa.c        |  1 -
>  hw/char/serial-mm.c         | 51 -------------------------
>  hw/char/serial-pci-multi.c  |  5 ---
>  hw/char/serial-pci.c        |  1 -
>  hw/char/serial.c            | 76 ++++++++++++++++++++++++++++++-------
>  8 files changed, 66 insertions(+), 80 deletions(-)



This does leave TYPE_SERIAL_MM a bit of a do-nothing
extra wrapper, as Balaton says. However I don't think
it's being used by any versioned machine types, so we
could maybe look after this at the possibility of dropping
the wrapper (by having serial_mm_init() create a TYPE_SERIAL
directly, and dropping TYPE_SERIAL_MM entirely). I don't
think we strictly need to do that, though -- being able
to clean up the reset handling here is worthwhile in
itself.

I do have one question:

> +    memory_region_init_io(&s->io, OBJECT(s),
> +                          s->regshift ? &serial_mm_ops[s->endianness]
> +                                      : &serial_io_ops,
> +                          s, "serial", 8 << s->regshift);

This means that users of serial_mm_init() which pass 0 for
regshift now get serial_io_ops rather than serial_mm_ops.
That affects a handful of machines. I'm not sure if
this makes a guest-visible difference (very possibly not),
but for a "refactoring" type patch like this I'd rather
err on the safe side and keep the same MemoryRegionOps
if we can. This could be awkward, though, because we
definitely have users of TYPE_SERIAL_MM which rely on
the default regshift property value being 0. Maybe we
can have the handful of places that want the serial_io_ops
do an explicit setting of some property to request that?

The other approach is to analyse the code and satisfy
ourselves that serial_io_ops and serial_mm_ops with
regshift == 0 really do have exactly identical behaviour,
and note that in the commit message.

thanks
-- PMM

