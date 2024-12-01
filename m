Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C3D7360C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 06:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHdtq-0002o9-UY; Sun, 01 Dec 2024 01:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHdtp-0002o1-0A
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 01:57:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHdtm-0006qY-5u
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 01:57:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a736518eso38758545e9.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 22:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733036260; x=1733641060; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UPuQTf5dnMShzdIKy5WxgOpnMyFRPOJEPWaRTg9qBSk=;
 b=Bqy966JfIBzp5lHHSIZuONbmClqDKe0wDBgshdmHfRWqxwA3PDLU+lcb4JM4Mla2xc
 3aDTQe/svfwFvJKTir7ORrV4BdBh4bHLq9c4mUZ6HzqYQZdtCwWJL6BlsoZGfv+Yohtu
 MDHD6Y7aH6h/f8KLR5Enq4KWO/HRICHH4O15PJtRxvdRBKqxMBdFpGqx5Ry7GxUh517G
 ozNlmTCyl1Fzux6YXDs8HoQt1ykLSYs1okXuLgF+voVsGJpJm4hMqbt6bOlVuUlm+X3t
 1FTogob83rDNjHIqsmNr/mPt4piFrzHLwtRUC1v2zbDBlbEZpy+xPyAAbeQg4TnRxcA7
 INwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733036260; x=1733641060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPuQTf5dnMShzdIKy5WxgOpnMyFRPOJEPWaRTg9qBSk=;
 b=aMz8vLTDPmN+C7LqlBgcOBz9W2ue9i6mE11CBmYwn27EBlBl/VkXl1PTcfHzeGaDnj
 nprnzEFJS5sTcYb0vWMRrM7s8P1IFK9CYPZAyiLYqJG0oqtrBqr8TojW3hM2YQJ3IViO
 HCEQHGd3t5U39ihKEn3P0SmOh3JPnJIOzZGqAah/PjsfryWoeR0CNjAOvDcbF9TlVGNx
 pmQ4/pwhb7TIr5TbtGDAJ7gMODbCGPzDprHCGk33Yv3V+zoKb13qH14IZtgsqu5jsQsf
 wOHAdgUzl1/8t72AkOfhSXBJYfxebrCMl+jVoMVaQ+bO9+AVr1l4D/sfM57NBls1lOMM
 uIZg==
X-Gm-Message-State: AOJu0YxfScp/5wAoGivRQOIcP0AmqzPgyfKDvK9QPWWMdKmCD4vkdUfp
 BB9gNm5hD3RClwZfRR7v+WZW8aSmomIXYR2yFOE8yEQw5t3goCQD
X-Gm-Gg: ASbGncvf9niX8IZ4J87BNq60iMNUh74156QSZkhn9GdQMZ8NnNp7TPK8KQZvfgXHD9n
 CE0tihtpFnlFFpaT/1djPbKArZjSLfphuvLBgP6rbiWih5hY2eiU6j78hsCk/gsvpJJ2e3IxYvj
 Tu/SFycVBoZiQF3r+VbQ1p+QLQFYXYv02R/EuoxGKIE9Y0PwIgmmkOfXJg+nA25EvUUpv/p7Y6g
 oYjiCuVqfqce05zof+fES3/7wVOqpTJhmmugUmhAhGMO3RAx31MlfvF+3BYhcfbt70YUCg7G+yr
 oWwQk4fvn24TKQ==
X-Google-Smtp-Source: AGHT+IFt3nKCfx6kLuNvtuXDcshuhAkmNGUyDN0Jq4Ma3dajk9K21K9MY+7dMj8t/MIi9TSbGie3EQ==
X-Received: by 2002:a05:600c:c86:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-434a9dbb6a7mr162254875e9.1.1733036259945; 
 Sat, 30 Nov 2024 22:57:39 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa76b52bsm138375975e9.18.2024.11.30.22.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 22:57:38 -0800 (PST)
Date: Sun, 1 Dec 2024 06:57:36 +0000
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Jia Liu <proljc@gmail.com>
Subject: Re: [PATCH 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <Z0wI4O1woOmkgZrK@antec>
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-2-shorne@gmail.com>
 <CAFEAcA8SS6oBrNJzByghx8qc3QiZXQs2aM3xnqk0dtswij3i1A@mail.gmail.com>
 <Z0wF1xH1NYDDdxY4@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0wF1xH1NYDDdxY4@antec>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Dec 01, 2024 at 06:44:39AM +0000, Stafford Horne wrote:
> On Mon, Nov 25, 2024 at 02:02:35PM +0000, Peter Maydell wrote:
> > On Sat, 23 Nov 2024 at 10:39, Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > >
> > > We used to only have a single UART on the platform and it was located at
> > > address 0x90000000. When the number of UARTs was increased to 4, the
> > > first UART remained at it's location, but instead of being the first one
> > > to be registered, it became the last.
> > >
> > > This caused QEMU to pick 0x90000300 as the default UART, which broke
> > > software that hardcoded the address of 0x90000000 and expected it's
> > > output to be visible when the user configured only a single console.
> > >
> > > This caused regressions[1] in the barebox test suite when updating to a
> > > newer QEMU. As there seems to be no good reason to register the UARTs in
> > > inverse order, let's register them by ascending address, so existing
> > > software can remain oblivious to the additional UART ports.
> > >
> > > Changing the order of uart registration alone breaks Linux which
> > > was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
> > > Linux we fix two things in the device tree:
> > >
> > >  1. Define stdout-path only one time for the first registerd UART
> > 
> > "registered"
> 
> OK
> 
> > >     instead of incorrectly defining for each UART.
> > >  2. Change the UART alias name from 'uart0' to 'serial0' as almost all
> > >     Linux tty drivers look for an alias starting with "serial".
> > 
> > I would recommend for maximum backwards compatibility also changing
> > one other thing. With this patch, the UARTs are listed in the
> > device tree starting with the one with the highest address and
> > working down. You can see this if you run
> >  qemu-system-or1k -M or1k-sim -machine dumpdtb=or1k.dtb -kernel /dev/null
> > and then
> >  dtc -I dtb -O dts /or1k.dtb |less
> > -- the output shows that "serial@90000300" is first.
> > 
> > This happens because (due to an implementation quirk that I forget
> > the details of) nodes we add to the DTB in QEMU end up being listed
> > in reverse order of creation. I would recommend making the
> > UART-creation loop in openrisc_sim_init() run backwards rather
> > than forwards, so that the nodes end up in the DTB in ascending order.
> >
> > This should not affect any guests that do the "right thing" for
> > finding their UART, i.e. look at stdout-path or at the UART alias
> > nodes; but for Arm we found that at least some guest code had been
> > written to just find the first UART node in the dtb and use that.
> > 
> > (I suspect, incidentally, that this is the reason why 777784bda468
> > was using "serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1)" -- it was
> > trying to fix this but didn't quite put the change in the right place.)
> > 
> > That would correspond to squashing in this change on top of your patch:
> > 
> > --- a/hw/openrisc/openrisc_sim.c
> > +++ b/hw/openrisc/openrisc_sim.c
> > @@ -329,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
> >                                  smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
> >      }
> > 
> > -    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
> > +    /*
> > +     * We create the UART nodes starting with the highest address and
> > +     * working downwards, because in QEMU the DTB nodes end up in the
> > +     * DTB in reverse order of creation. Correctly-written guest software
> > +     * will not care about the node order (it will look at stdout-path
> > +     * or the alias nodes), but for the benefit of guest software which
> > +     * just looks for the first UART node in the DTB, make sure the
> > +     * lowest-address UART (which is QEMU's first serial port) appears
> > +     * first in the DTB.
> > +     */
> > +    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
> >          openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
> >                                          or1ksim_memmap[OR1KSIM_UART].size * n,
> >                                   or1ksim_memmap[OR1KSIM_UART].size,
> >                                   smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
> > +    }
> > 
> >      load_addr = openrisc_load_kernel(ram_size, kernel_filename,
> >                                       &boot_info.bootstrap_pc);
> 
> OK it makes sense, I will add this as well.

Hi Peter,

One comment on this, in the commit message from Ahmad he says.  The registration
order... ''This caused QEMU to pick 0x90000300 as the default UART,''

But you mentioned the lowest address will be used by QEMU.  I was not able to
find the code so easily that confirmed either of these statements.

It seems there is some contradiction to the original commit message from Ahamad,
but I will leave the commit message as is now.

Perhaps it's the value of serial_hd(x) that need to be the lowest.

-Stafford

> > 
> > > [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
> > >
> > > Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
> > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > [stafford: Change to serial0 alias and update change message]
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > >  hw/openrisc/openrisc_sim.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> > > index 9fb63515ef..5ec9172ccf 100644
> > > --- a/hw/openrisc/openrisc_sim.c
> > > +++ b/hw/openrisc/openrisc_sim.c
> > > @@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
> > >      void *fdt = state->fdt;
> > >      char *nodename;
> > >      qemu_irq serial_irq;
> > > -    char alias[sizeof("uart0")];
> > > +    char alias[sizeof("serial0")];
> > 
> > Using g_strdup_printf() (and a g_autofree pointer) is better than
> > a fixed-size array; but I guess we don't really need to clean
> > that up in this patch.
> 
> I will leave this as is.
> 
> > >      int i;
> > >
> > >      if (num_cpus > 1) {
> > > @@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
> > >          serial_irq = get_cpu_irq(cpus, 0, irq_pin);
> > >      }
> > >      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
> > > -                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
> > > +                   serial_hd(uart_idx),
> > >                     DEVICE_NATIVE_ENDIAN);
> > >
> > >      /* Add device tree node for serial. */
> > > @@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
> > >      qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
> > >      qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
> > >
> > > -    /* The /chosen node is created during fdt creation. */
> > > -    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> > > -    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
> > > +    if (uart_idx == 0) {
> > > +        /* The /chosen node is created during fdt creation. */
> > > +        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
> > > +    }
> > > +    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
> > >      qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
> > > +
> > >      g_free(nodename);
> > >  }
> > 
> > thanks
> 
> Thanks,
> 
> -Stafford

