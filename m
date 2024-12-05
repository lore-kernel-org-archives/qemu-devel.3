Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC7E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDhk-0003Ac-5O; Thu, 05 Dec 2024 10:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDhj-0003AD-6C
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:23:47 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJDhg-0007aC-Id
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:23:46 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf80972dso1247962a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733412221; x=1734017021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2o0BOwxkDSCufIXkZ4f5R0oc042vUvihYxGeEHkXCng=;
 b=SLjDUFNTeuiUMQfO17UtxwSMqKI6GuLAwcwB10tT6T7Tg1eVziAR36cae9gC1UgsD0
 BmFR1vJqEJMhh583YsJ3Rq3PRkQa57le7UL22aNy0veaL+LVO25UeAvJX+lZMlA1QaP9
 XdGzS5/IQLrCcgGob3JiqsU++TgxVmzDDJPU3hVUM/Tyk080bqS8ReVZZW7NvI86HzVc
 6c0IrEZVjfbiWVV1vIkkAP5NqYFWl/tezmXKPcrpTc1diOYBlu91VUc9GGddmEnOfOrC
 jCFR2Y7T+WNJMErcmZaCByRIGf5hghFTCI9Sfu+ybIHy0j+7vQLE6I9hR3befaP9aN0E
 7PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412221; x=1734017021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o0BOwxkDSCufIXkZ4f5R0oc042vUvihYxGeEHkXCng=;
 b=Y+VvtjR8uZqehs7zbloDYqouZ908brW56b0lSeIbiw6V9Pv04R64pkpNNdgdcPIZXR
 L1NRu6froguqOHQa4GkL9QFoFZIKqv8eWIsTo+tpJA+6XWWoamejq6kZqThJKLGkQcOM
 bwkmNLmdY0aNfdh57+WkzBMJfBtOxoHC727EORyzi8DRUvpw9BRioCgY9v7hsbf4DAJH
 p1M5Ah8x74kB/NNP3F5KtlWQbcJtcV6jxl7FqkEyqXlG38N4jn599lGbuYFnBGkoLNUg
 MbHff2DZ4SSp1dv8DaEtRNjEeE7VnO8TNvYnh/D1Iqq8cV1kHFvl8x6nRWno9YgEqX25
 pJjg==
X-Gm-Message-State: AOJu0Yx5wV9U+2JUbyDBLNbD9QdrDI28mLKHbsu9+kjkRfwTNsPjWbwK
 Frt6YbH3IesR0D1lvbIwX0S0g71fClyk89q1RpotFDeLeM/JLz4icHsGZm5ia1TAl0V33Nw+1uX
 79LD6pzM3VscBn8DyGGIWrALCvT3RZ25iPvvYOQ==
X-Gm-Gg: ASbGnctGF5w5XlVZMYsUsI3PIoJkCLy4LdYJuSJ5Qc9jJFhvWy8zNTbf8pyMroFm1hb
 6qKkn3HVwfbB9uQTBZ0t8gnpExMgp4+II
X-Google-Smtp-Source: AGHT+IG8NJmTbbacd/8LR2gPy/2hPCKBTxHEX7mIRpnGShOO2RWc+Mzj7/NaGoNqlqSw6es86YRBj//ckoHRuBboDg0=
X-Received: by 2002:a05:6402:3506:b0:5d0:9054:b119 with SMTP id
 4fb4d7f45d1cf-5d10cb80133mr13614218a12.21.1733412221125; Thu, 05 Dec 2024
 07:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-7-pierrick.bouvier@linaro.org>
 <CAFEAcA9JdLxi5cr-Z2-YX6Q8nv=j0O3k=f9u6gS-CzSf5BH7Ug@mail.gmail.com>
 <bdefc0ac-311b-4820-913f-e21d753890fa@linaro.org>
In-Reply-To: <bdefc0ac-311b-4820-913f-e21d753890fa@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 15:23:30 +0000
Message-ID: <CAFEAcA-go4GccLwNvdrL0iMpDSmCcrD5J9R3=3BnT5t7tf=Fiw@mail.gmail.com>
Subject: Re: [PATCH 6/7] docs: add a glossary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 3 Dec 2024 at 20:32, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 12/3/24 09:37, Peter Maydell wrote:
> > On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >>   docs/devel/control-flow-integrity.rst |   2 +
> >>   docs/devel/multi-thread-tcg.rst       |   2 +
> >>   docs/glossary/index.rst               | 238 ++++++++++++++++++++++++=
++
> >>   docs/index.rst                        |   1 +
> >>   docs/system/arm/virt.rst              |   2 +
> >>   docs/system/images.rst                |   2 +
> >>   docs/tools/qemu-nbd.rst               |   2 +
> >>   7 files changed, 249 insertions(+)
> >>   create mode 100644 docs/glossary/index.rst
> >
> > I think this is a good idea; we've had at least one bug
> > report from a user pointing out that we had a term in
> > our docs which we didn't define ("block driver"):
> > https://gitlab.com/qemu-project/qemu/-/issues/2611
> > I have some comments on specific entries below.
> >
>
> And people can be free to add new entries later. However, we should
> resist the temptation to add too many details. It should stay simple and
> understandable, even if not all technical nuances are not represented.
>
> >> diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/contro=
l-flow-integrity.rst
> >> index e6b73a4fe1a..3d5702fa4cc 100644
> >> --- a/docs/devel/control-flow-integrity.rst
> >> +++ b/docs/devel/control-flow-integrity.rst
> >> @@ -1,3 +1,5 @@
> >> +.. _cfi:
> >> +
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>   Control-Flow Integrity (CFI)
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread=
-tcg.rst
> >> index d706c27ea74..7fd0a07633d 100644
> >> --- a/docs/devel/multi-thread-tcg.rst
> >> +++ b/docs/devel/multi-thread-tcg.rst
> >> @@ -4,6 +4,8 @@
> >>     This work is licensed under the terms of the GNU GPL, version 2 or
> >>     later. See the COPYING file in the top-level directory.
> >>
> >> +.. _mttcg:
> >> +
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>   Multi-threaded TCG
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> diff --git a/docs/glossary/index.rst b/docs/glossary/index.rst
> >> new file mode 100644
> >> index 00000000000..a2d4f3eae16
> >> --- /dev/null
> >> +++ b/docs/glossary/index.rst
> >
> > I guess it makes sense to give this its own subdir, since we want
> > it to come at the end of the manual. The other option would be
> > to put it directly into docs/.
> >
>
>  From your comment, it's not clear for me if it's ok as it is, or if you
> want a change.
> Can you elaborate on that?

It means I'm not sure. We end up with a subdirectory with only
one file in it and where there's no expectation we'd ever want
to add any more files to it. On the other hand it does keep it
out of the docs/ top level directory, which currently has a
fair amount of cruft awaiting cleanup.

I guess on balance I would make this docs/glossary.rst,
unless you anticipate wanting to split this into multiple
files or have something else in docs/glossary/ later.

> >> @@ -0,0 +1,238 @@
> >> +.. _Glossary:
> >> +
> >> +--------
> >> +Glossary
> >> +--------
> >> +
> >> +This section of the manual presents *simply* acronyms and terms QEMU =
developers
> >> +use.
> >
> > What's "simply" intended to mean here?
> >
>
> "in a straightforward or plain manner".
> I can remove this word if you think it does not serve any purpose.

You could phrase it as "presents brief definitions of acronyms
and terms", I think.

> >> +QEMU system defines board models for various architectures. It's a de=
scription
> >> +of a SoC (system-on-chip) with various devices pre-configured, and ca=
n be
> >> +selected with the option ``-machine`` of qemu-system.
> >
> > SoCs are not the same as boards.
> >
> > We could say something like:
> >
> > QEMU's system emulation models many different types of hardware.
> > A machine model (sometimes called a board model) is the model
> > of a complete virtual system with RAM, one or more CPUs, and
> > various devices.
> >
> > We could also put in a link to
> > https://www.qemu.org/docs/master/system/targets.html
> > which is where we document what our machine types are.
> >
>
> How do you distinguish a SoC and cpu? Is a SoC cpu + devices?
> Isn't a board/machine a set of SoC + devices attached?

An SoC is a "system on chip". To quote wikipedia's definition:

"A system on a chip or system-on-chip is an integrated circuit that
integrates most or all components of a computer or electronic system.
These components usually include an on-chip central processing unit
(CPU), memory interfaces, input/output devices and interfaces, and
secondary storage interfaces, often alongside other components such
as radio modems and a graphics processing unit (GPU) =E2=80=93 all on a
single substrate or microchip."

An SoC always contains a CPU, but it will have a lot more
than that built into it too. And the SoC only has "most"
of the system components, so the whole machine will be
an SoC plus some other things.

Generally a board/machine that uses an SoC will have on it:
 * an SoC
 * the actual memory
 * perhaps one or two extra devices external to the SoC
 * connectors for things like serial ports, SD cards, etc
   (which generally wire up to SoC pins)
 * a crystal or similar to act as the main clock source

So if you look at a photo of a development board that uses
an SoC, there will be one large chip which is the SoC,
some RAM chips, a bunch of connectors and one or two smaller
chips. Not every device will be inside the SoC, but
generally almost all of them are.

QEMU's machine models for this kind of board match the
organization of the hardware; looking at hw/arm/sabrelite.c
which is a machine model you can see that it has:
 * an instance of the fsl-imx6 SoC device object
 * the main memory
 * some NOR flash memory
 * some configuration and wiring up of things

And the SoC itself is in hw/arm/fsl-imx6.c, and is a
QOM device object that creates and wires up the CPUs,
UARTs, USB controller, and various other devices that
this particular SoC includes. In this case we only have
one board model using this SoC, but for some SoCs we
have several board models that all use the same SoC
but wire up different external devices to it.

Some of our machine models are models of systems that
don't use an SoC at all. This is rare in the Arm world,
but for instance the SPARC machines like the SS-5 are
like that -- the real hardware had a discrete CPU chip
and a bunch of devices in their own chips on the
motherboard, and QEMU's model of that hardware has
a machine model which directly creates the CPU and
the various devices. (And some of our older machine
models are models of hardware that *does* have an SoC
but where we didn't model that level of abstraction,
so they directly create devices in the machine model
that really ought to be inside an SoC object.
hw/arm/stellaris.c is one example of that.)

> >> +
> >> +Block
> >> +-----
> >> +
> >> +Block drivers are the available `disk formats <block-drivers>` availa=
ble, and
> >> +block devices `(see Block device section on options page)<sec_005finv=
ocation>`
> >> +are using them to implement disks for a virtual machine.
> >
> > Block drivers aren't just disk formats; there are some filter
> > drivers too. Somebody on the block side could probably
> > provide a better definition here.
> >
>
> I'm open to a more exact definition. The two terms (drivers and devices)
> seem to overlap on some parts, so I came up with this trivial definition.

Yeah, the driver vs device split is a good one (basically
the device is the front-end visible to the guest, and the
driver is the back-end that provides it with storage
via an abstracted API). The nit I'm picking here is that
not every block driver is there to provide support for
an on-host disk format.

> >> +
> >> +CFI
> >> +---
> >> +
> >> +Control Flow Integrity is a hardening technique used to prevent explo=
its
> >> +targeting QEMU by detecting unexpected branches during execution. QEM=
U `actively
> >> +supports<cfi>` being compiled with CFI enabled.
> >> +
> >> +Device
> >> +------
> >> +
> >> +QEMU is able to emulate a CPU, and all the hardware interacting with =
it,
> >> +including many devices. When QEMU runs a virtual machine using a hard=
ware-based
> >> +accelerator, it is responsible for emulating, using software, all dev=
ices.
> >
> > This definition doesn't actually define what a device is :-)
> >
>
> Indeed :)
> Should we explain what is a computer device?
> The goal was just to say that QEMU can emulate hardware interacting with
> the cpu, which could be a possible definition. So people can associate
> that QEMU devices are nothing else than a "normal" computer device.

We could say, perhaps:

In QEMU, a device is a piece of hardware visible to the guest.
Examples include UARTs, PCI controllers, PCI cards, VGA controllers,
and many more.



> >> +
> >> +Hypervisor
> >> +----------
> >> +
> >> +The formal definition of an hypervisor is a program than can be used =
to manage a
> >> +virtual machine. QEMU itself is an hypervisor.
> >
> > "a hypervisor". QEMU isn't really a hypervisor, though...
> >
>
> It's a shortcut, and I'm open to change it. It brings an interesting
> question though.
>
> Technically, QEMU interacts with hypervisor APIs built in various OSes.
> On the other hand, when we use TCG, it's an emulator instead.
>
> But as you can't use KVM/hvf/whpx by itself, how do you name the program
> interacting with it, and emulating the rest of the VM?
>
> The correct word is probably "virtualizer", but from searching on
> Internet, it seems that "vmm" and "virtualizer" are considered the same
> as an "hypervisor". The difference is subtle, and maybe we have an
> opportunity here to clarify it.


> >> +Patchwork
> >> +---------
> >> +
> >> +`Patchwork <https://patchew.org/QEMU/>`_ is a website that tracks
> >> +patches on the Mailing List.
> >
> > Patchwork and patchew are different systems. Patchew's URL is
> > https://patchew.org/QEMU/
> >
> > (There is a patchwork instance that tracks qemu-devel patches,
> > at https://patchwork.kernel.org/project/qemu-devel/list/ , but
> > I'm not aware of any developers that are actively using it, so
> > I don't think it merits being mentioned in the glossary.)
> >
>
> I've been confused by that, and just thought it was two different
> instances (fork me if you can) of the "same" thing.
> How would you define patchew?
> When we say patchwork, do we implicitely mean patchew?

No. patchwork is patchwork, and patchew is patchew -- these
are entirely different pieces of software that happen to do
similar jobs.

> if I understand currently, patchew is what we want to mention in our
> doc? (and mention it's not associated to patchwork).

We don't use patchwork, so we don't need to mention it anywhere.

> >> +Once a series is reviewed and accepted by a subsystem maintainer, it =
will be
> >> +included in a PR (Pull Request) that the project maintainer will merg=
e into QEMU
> >> +main branch, after running tests.
> >
> > I think we could probably also usefully say
> >
> > "The QEMU project doesn't currently expect most developers to
> > directly submit pull requests."
> >
> > just to flag up that our development model isn't like the
> > currently-popular github/gitlab one where a PR is how you
> > send contributions.
> >
>
> This is interesting.
>
> For the majority of developers nowadays, a PR is a GitHub/GitLab PR.
> Despite the fact we use the original PR meaning (in git terms), it's
> probably confusing when new comers hear pull request.
>
> >> +
> >> +QCOW
> >> +----
> >> +
> >> +QEMU Copy On Write is a disk format developed by QEMU. It provides tr=
ansparent
> >> +compression, automatic extension, and many other advantages over a ra=
w image.
> >
> > We want to be a bit careful here, because the "qcow" format
> > is not something we recommend for new use -- "qcow2" is what
> > you actually want.
> >
> > https://www.qemu.org/docs/master/system/qemu-block-drivers.html#cmdopti=
on-image-formats-arg-qcow2
> >
>
> Sounds good.
>
> For my personal knowledge: during this work I discovered that we had
> qcow3. From what I understood, it seems to be included in what we called
> qcow2 today. Is that correct?

I have no idea -- you'd need to ask somebody who works on the
block layer

thanks
-- PMM

