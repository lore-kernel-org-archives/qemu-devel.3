Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DFCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utObS-0003cG-5P; Tue, 02 Sep 2025 06:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utObQ-0003bj-9j
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:51:04 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utObN-0003ST-IN
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:51:03 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d5fe46572so49443667b3.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756810259; x=1757415059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWf0PyX1yLfBUdOi0cNMKDawR4Yo6fv6FeCmUNSK+hI=;
 b=KqMLfcym52saMaNAJgImnxVjmCh61owm9gNke1YLcrOc197HFmZk+Xw9IykbVKx0yG
 ASlbD0ekzK1fR2FtSRsYRoNmHFdjs+v/U3XjrkcAUN8l6iFxwTUMenqVfx5iqREzK/zk
 BAwlqhQbkjkrFT3PsAdW3zXkEgqRG3smMSd0yIjBgabnXA89db6GdARNXBMh9p6v8SIO
 S3MtwDq60BAMZlLaxD/Z31/XrUO5Q7l6XIKU90rzZIqkKPjYHxN9qVoIxdYXtnzRsigr
 v4BiTyzZx75oS2GIeLOUGM63FLODl4beHcG9CtEPFdiqn+l5s4lrq3gLcW/Iq7oK2Yd5
 Si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756810259; x=1757415059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWf0PyX1yLfBUdOi0cNMKDawR4Yo6fv6FeCmUNSK+hI=;
 b=QdU9wpCfwGigZW9qrjAqzDHJW87X7EcWQvpIqQnZ4p9grPPydvEFKmQPzyNbByGYZs
 iZ6BugJ8XYk+Y5+N3OJngJUK5frNIvJBf3J3dgdfU1fyOyuBt/DDmP2N8oQs7P0vP1i3
 YYO/Lw8bp0mqjMb7NcD6LzQ1ELZjgD9obWpUaG+5OvooAxr/BEUbnbtXQr8PP59Xg7fL
 Zw9lfPLFFshcgDiNb+ewLsSwThQG5J7ySSRU+5xPjpT4cqH4HurCnSsWFbjurDnoQ6ic
 weg4lwMwI/bGZdypOwwCxJ5D/vKb84ngRIeC2pfqWVb6WqxmimeQKRzMJi5Iwg2Q/LoK
 29+w==
X-Gm-Message-State: AOJu0YwDXpL1AAixmELazLVTwB7nUJJjYexKybN6aIbesU5ujTk1fy1C
 9jXSNgBGcktaweOO2WtxJSzUx8iQhehlGABJlHr24WnV0vCZSxVvcLI8M8aHiRKFzj+kBJOyN22
 Bl20mGVafgoF6x0hiDQ+2ZtUgO8C6fyBCHZ1QvrDfEA==
X-Gm-Gg: ASbGncsB/xdtVcUpVyBH/+P5Isb4Y/zmH6CAugOMJsaSlh1sdE/m3DuHnJZByZ9Helz
 s1bQoidv6pd5BqwhV30806TEL9VgLMSGBPswWqK5sW1g4fVJOfZlsdHtdzDay8m1dpClrCG7wK+
 8JqMoNulslC3flctKOGn0NEECl8ut+wLh9ukAhxUqP77rSukXucKVlXS0D4ODAsEJvDcAP4kDcJ
 DERYbqA
X-Google-Smtp-Source: AGHT+IHQve153I/D4VgDoyC8xcLPklOBWvAk+Lqf9wvNZ+kWKy7cDAoWoeA9G2TgOWjvhhB48MwEbiXSh3fG4Oe171g=
X-Received: by 2002:a05:690c:7093:b0:71f:9a36:d330 with SMTP id
 00721157ae682-722765464a5mr127081717b3.25.1756810259362; Tue, 02 Sep 2025
 03:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
 <20250821154053.2417090-3-peter.maydell@linaro.org>
 <2c2f25a6-4f11-4404-8298-60b43fb28052@linaro.org>
In-Reply-To: <2c2f25a6-4f11-4404-8298-60b43fb28052@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 11:50:47 +0100
X-Gm-Features: Ac12FXzAF63pvDnchlx8dwaoRwFUpZM8ZYKdCBr_79crSz4SmW5fYrC1xsf6YHU
Message-ID: <CAFEAcA8XCFFEB6B=YbDiqnfB9iuJHB++Ut_eMEyP5PtO8vCJzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/char/serial-pci-multi: Use qemu_init_irq_child()
 to avoid leak
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 2 Sept 2025 at 11:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 21/8/25 17:40, Peter Maydell wrote:
> > The serial-pci-multi device initializes an IRQ with qemu_init_irq()
> > in its instance_init function; however it never calls qemu_free_irq(),
> > so the init/deinit cycle has a memory leak, which ASAN catches
> > in the device-introspect-test:
> >
> > Direct leak of 576 byte(s) in 6 object(s) allocated from:
> >      #0 0x626306ddade3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop=
/qemu/build/arm-asan/qem
> > u-system-arm+0x21f1de3) (BuildId: 52ece17287eba2d68e5be980e1856cd1f6be9=
32f)
> >      #1 0x7756ade79b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.s=
o.0+0x62b09) (BuildId: 1
> > eb6131419edb83b2178b682829a6913cf682d75)
> >      #2 0x7756ade5b45a in g_hash_table_new_full (/lib/x86_64-linux-gnu/=
libglib-2.0.so.0+0x4445a
> > ) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
> >      #3 0x62630965da37 in object_initialize_with_type /mnt/nvmedisk/lin=
aro/qemu-from-laptop/qem
> > u/build/arm-asan/../../qom/object.c:568:23
> >      #4 0x62630965d440 in object_initialize /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/ar
> > m-asan/../../qom/object.c:578:5
> >      #5 0x626309653eeb in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-=
laptop/qemu/build/arm-as
> > an/../../hw/core/irq.c:48:5
> >      #6 0x6263072370bb in multi_serial_init /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/arm-asan/../../hw/char/serial-pci-multi.c:183:9
> >
> > Use the new qemu_init_irq_child() function instead, so that the
> > IRQ object is automatically unreffed when the serial-pci
> > device is deinited.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/char/serial-pci-multi.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> > index 13df272691a..9410428ba90 100644
> > --- a/hw/char/serial-pci-multi.c
> > +++ b/hw/char/serial-pci-multi.c
> > @@ -180,7 +180,9 @@ static void multi_serial_init(Object *o)
> >       size_t i, nports =3D multi_serial_get_port_count(PCI_DEVICE_GET_C=
LASS(dev));
> >
> >       for (i =3D 0; i < nports; i++) {
> > -        qemu_init_irq(&pms->irqs[i], multi_serial_irq_mux, pms, i);
> > +        g_autofree char *irqpropname =3D g_strdup_printf("irq[%zu]", i=
);
> > +        qemu_init_irq_child(o, irqpropname, &pms->irqs[i],
> > +                            multi_serial_irq_mux, pms, i);
>
> We could also pass "irq[*]".

Oh yes, this was something that confused me: I'd forgotten
that we special case [*] in object_property_try_add().
Using "[*]" seems better here, then.

Incidentally, the code in object_property_try_add() is
quadratic in the number of properties with that name:
if you have irq[*] for N irqs then it will recursively
call object_property_try_add() once for irq 0, twice for
irq 1, 3 times for irq 2, and so up to N times for irq N-1,
for a total of N(N+1)/2 calls...

-- PMM

