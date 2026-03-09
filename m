Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F358CFCA16E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfLR-0004ys-5L; Mon, 09 Mar 2026 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzfLL-0004yY-AV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:28:40 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzfLJ-0001lz-IC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:28:39 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so10828493d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080916; cv=none;
 d=google.com; s=arc-20240605;
 b=Im9QqT3k7XigeXc4wPweHUsyyAjA0Z2Izh31W0MfMPujKNTYZlT6CjWVeCLGaXyRaf
 A8Juryw6dQb0pyyT63omWWpgXuNlBD790wQxrVX4I5oqGPY83c86e4Zi/TwmSdltezB0
 YZ9zkz1wigCDwt5iwG8yRq/EGKLcrV3VC5XHSf1/YiufU7QmUuYGpXhp8cv4iCSm0w+a
 +9MwM9KD4/Aoa8catNQzB3IH4R2pfTk2z8L5cwk01D9SczmpRmeGAcyLH/fA8g+9uIIY
 NR7gi7CUoYuLDURUnincq+Qifv7s6pgRqpEfU4n4gm5pdgcHg62DvxkXKvm81J6n4FZ7
 vbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PvesBgWB1I4/GmoPHWspukPhsJAjBgn1CnjVPXmePGc=;
 fh=BL9oHhasQ6lbq2piGBix5DXgXmbihZRdCU3U4Uvb328=;
 b=UY1PNGw+bAWLC6/+Gm6hOm1481tFFVYGEHMUrR5hFZydNvPLoPu0TN4OKKLYwofKQ1
 LMqcNWHthFiZNegDmwJ7L0jtmTOys0pkuyXgnZ1uDprLLNrOLdXrUWXZi8287NR+dJfX
 g3QSgC3X/OWcHFbr7q5sJAXHGtX41Gz2GEIWtwZ3tzTSZx2uz9JBH2gybv7EH7xWcpgy
 P7/z4QPnPVkAjWXIZBJH6z+Ug2Ou+i9rSSq6RiZ1++ydMPBQs6kyONruJbRqO8gmmc9s
 OkTIlPvlpIZc1fxJfHx0LIn6NAnoh2XYWybtfJZJ4liJRFO5cW9snHS4uMALAjEOMK71
 88rQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773080916; x=1773685716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PvesBgWB1I4/GmoPHWspukPhsJAjBgn1CnjVPXmePGc=;
 b=rttrDDSNgddRDqobdYPvwNH50cu5HVu7ucCqrJjvQapOAXXu4RU9Z8i1KrWRwuCb5x
 ZYjGMT0hUyT5v74ASaDrJLPNVQY/FXUl7jukkjSI7zkJ+NDcU9/ck0sOtpsqDxB9YqGI
 5mdw1PtM2xLbAK5pA008v3L6INfpA6RyrZsyOOfVR1hGcqSasgYzt4S43TM5pHCyGPqL
 zTP+5ifkbh9XnWaC7ilpC0ow/hpgG6ql0pLsmhGBozOB5ERqavv0kcr2tOsGX+0uu6Ry
 UhGL7oeaXi+Xi87ShAueTmnpNi4Kiqel4/VNr8ab8I2TyoadYBqEJcB0BgXbszvDB6jw
 99gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773080916; x=1773685716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvesBgWB1I4/GmoPHWspukPhsJAjBgn1CnjVPXmePGc=;
 b=HDCHVyLvS+aQ6JqN2oXm4z02o3q4ZxAXXdxbREircwPq+Z3eitsNU2Yo2dTScmhfA3
 OsLc7EFF9DbwAWiMXOLS0bzrGddUVQa5Kh6KZZJm0tjOg7XEcwxxy81MOceQQbanhmxh
 QSP98ePlQ6wUDNsvskutRPwRRTrMDDq+gf+DAS68IuhyMDOn3xzUcDYCnZ7Lk5PbpRWK
 9jooWRsiCstLhqLB1JwFuwvYZAxzQkN0rG6lkZwdg9ry2iVmVNXwJKr/zHCpZ2zJ4aNt
 i0wvDD/vrSM40ruZNda28yoyH+kHdBAB7HlyyAwxBns+MS94svHXFXN6XnZp7bEgYLmW
 qUNA==
X-Gm-Message-State: AOJu0YzR5mfziH+VcgWYNqFKCXEtMYLQsC/ovTQz9iatI2DUSYEtKTvy
 Oh8LKpihNPgiZ+jvrSlvAHanBCQJqLTzxJ83Ox+T9Ec5J+hxPk48rH9Tm50Pg6YYbMR9vEJ2To8
 9Vn4ivESH+oLk6lP+AzCEOsOk9z4J44P7kxEEUKf0Rg==
X-Gm-Gg: ATEYQzxT9KviQzOXC5dqwkrmRHvH/LngvnTEowt+25CdhrGLYGnmVWJtvsnjKots0lw
 d7+V0QEt8VbgL9xbVwNaqg0RdsQuhFEJxtahUL94dnTriCR7Xt1CmxBXp3D9MAZ250Glfveed9D
 sAu/TTd9vjzfRuhXc1QhT9GQaBp5EACxGrYR1lB0lh1a3gc8B+1+wzlj6jzLwpgYn/H+AyjvqWu
 yeR4zklCdB0H142MDDjEJEz8zWOT5Y4XmWNPR9Hsmfp4vwSAfD7kmpu8odgq1hOi4lJs1F/6DjB
 fJ8T7N3JU+L78VdWt9m9Y8STDsTX/Lw8uiRPB712BORSztV3zVJWTpTxzASXheTSXT4=
X-Received: by 2002:a05:690e:d56:b0:64c:f2f5:a283 with SMTP id
 956f58d0204a3-64d14129cbfmr10240808d50.26.1773080915996; Mon, 09 Mar 2026
 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260309171258.1905205-1-peter.maydell@linaro.org>
 <947b79c6-cd6a-945d-be07-415647c14142@eik.bme.hu>
In-Reply-To: <947b79c6-cd6a-945d-be07-415647c14142@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 18:28:24 +0000
X-Gm-Features: AaiRm51EzzYZ1JmR9sTACY66e09U599xsgbdhHKTjJz7Cz6OhhDVudyzAlJMFsY
Message-ID: <CAFEAcA_-BYH7pSPKdjAq8-wNj6kopkaQTPznDESurmshBSzegg@mail.gmail.com>
Subject: Re: [PATCH] hw/isa/piix: Embed i8259 irq in device state instead of
 allocating
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 9 Mar 2026 at 18:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 9 Mar 2026, Peter Maydell wrote:
> > The pci_piix_realize() function's use of qemu_allocate_irqs()
> > results in a memory leak:
> >
> > Direct leak of 8 byte(s) in 1 object(s) allocated from:
> >    #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-mips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
> >    #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
> >    #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
> >    #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/../../hw/isa/piix.c:318:35
> >    #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/../../hw/pci/pci.c:2308:9
> >    #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
> >    #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
> >    #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
> >    #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
> >    #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:1520:15
> >    #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/san/../../hw/core/qdev.c:283:11
> >    #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/../../hw/mips/malta.c:1239:5
> >
> > (The i386 PC sets the has-pic property to 'false', so this only
> > affects the MIPS Malta board.)
> >
> > Fix this by embedding the i8259 irq in the device state instead of
> > allocating it.  This is a similar fix to the one we used for vt82c686
> > in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
> > instead of qemu_init_irq().  The behaviour is identical except that
> > the _child() version avoids what would be a leak if we ever
> > unrealized the device.
>
> How could it leak if it's embedded? This should be freed with PIIXState so
> I think the _child probably only affects where it shows up in qom-tree or
> I may be missing something.

The leak is not of the memory of the IRQState struct itself,
but of the QOM stuff that object_initialize() sets up and that
object_finalize() tears down. (object_finalize() will not attempt
to free() the IRQState struct itself because the Object will have
its 'free' function pointer NULL. Only objects created via
object_new(), the "allocate memory and initialize the object"
function, will have a 'free' method set up so that the finalize then
frees that allocated memory.) You can see an example backtrace
of this kind of leak in the commit message of commit f905be62379aab:
we leak a hash table that's part of QOM's internals.

Using the _child version means we set up the irq object as a child
of the PIIX device, so that in the (theoretical) case where the PIIX
refcount goes to 0 and we unrealize/deinit it we will also finalize
the IRQ object. Otherwise we would have to have the PIIX device
explicitly unref the IRQ object in its unrealize method.

> > The handling of IRQs in i8259_init() is rather convoluted and forces
> > its callers into having an IRQ that just forwards the set operation
> > outwards. It could in theory be cleaned up, but it's used in too
> > many places for that to seem worthwhile just now.
>
> I think we've tried that before and found that the forwarder is needed to
> avoid problems with creating and connecting interrupts that need to be in
> specific order which would lead to hard to follow rules that's easy to get
> wrong so it's easier to have a forwarder that works without further
> thought. I can't find the discussion about this now but was probably
> around commit 3820001131. Or maybe it's a different issue.

Yes, there's definitely an ordering thing involved so you can't just
pass the target qemu_irq in to i8259_init(), but maybe something
using qdev_pass_gpios() or something similar so that we end up
directly connecting the i8259 outbound GPIO to where it needs to go
would work. But it all felt too complicated to try to dig into.

-- PMM

