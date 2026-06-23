Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF916CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbtZc-0002Xa-J8; Tue, 23 Jun 2026 01:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbtZa-0002XG-QO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 01:21:22 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbtZZ-0002fy-1u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 01:21:22 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-660e9fe3c3aso3025897d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782192080; cv=none;
 d=google.com; s=arc-20240605;
 b=OfGJsq3tfRtdbZTJbyvT78vADg2g/xfQj6rYfh317Ppd/4/9eG5t896USGhOYkbMFq
 mguqUoj/A0uwacWWCWovhMyI5naeMosC/SgfLp9Z2Xjh/XoWfX9evbcUwGpnLjzZsidM
 q+1qM1nTDPGFYdfS+Ys2FjcMSLULFSW/XkIdmYN5rMea9+ueUbUYZnfNHE1vZvJbQc6V
 5q5cG5iSkNHMwpSL7ep23/LLedOYu1YIyl1w60cXVr+HqDDZje/q/EDi3lp2vKBr8ngm
 yHuf4qnrLGTlCuMZwycGmS9tULj4ZGjCOUnFtFtJvkTf+0T3J53NaN6W3gdqMlVFj+gQ
 SeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=49QqKjxrpAwe34azbOO0MO9qkqvZzA1id03+9nvlMj0=;
 fh=FHbiIuJvD3MZAWmI9ehiuYVeUP0X49yuZw1SnPqreTU=;
 b=WdhTTypHz4yIqJZ4lNSNXCSm5Pg49aCD3F2qMhSqiia0DfnnZkGosexRzQ8fvv9AZ7
 heZEBC8wlycbCeQdZUmI6OukkrqpyfWvPL4gsc8Im82ansL+ukZ+hbx6NLzXG9NDG7A6
 sukCYmb1xAChYXVlNBO7MdWkVAroRJzuVsJkLZ8rMM728JJwjuGH5RzTHbKeuAac4RGY
 9QMEtXN1W4mh/8XKayeSpJJVqRFoMBS189nitnOxnYTf+iwH4uU+lDldgwBwaOMTTtOq
 fIMXQ5L3s/lciGpS3SBUIpDjtwwCh4kGm2VnM6PuEbPs08LVix+MEz4LmQHO4x6fBo2N
 bGKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782192080; x=1782796880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49QqKjxrpAwe34azbOO0MO9qkqvZzA1id03+9nvlMj0=;
 b=rxrVFIa5SstYu8/eZvnHF4iyD9A1xGOr+7ksf7+l9lhjot+H+OP31A3Ra6im8b2cOG
 pokfA0lARM6uLY5uTMuo+Pq1S40fjWXDFH6EgINxTELZVGWqIVn6OpTy2su5zPpUKh+Y
 n9NOiU/62kiT9gwgIvz8l1NnfuRXhxrqQD7AeFjqXUFogSafOTGc+672KG8q+53c2m6N
 Sx8PlLwYj9YXaLmMHeHqzvxb0JBaCXytHc6kMOeEyG4G14NfiS3BpdSa8/uGVXHIFIt6
 KP5ELPK2T0p9mcB8CgxTPlK6tvKqXpdUwq08cFsdXn9zuk3wdctfWvB/wn6dnGxYSABl
 mc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782192080; x=1782796880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=49QqKjxrpAwe34azbOO0MO9qkqvZzA1id03+9nvlMj0=;
 b=AUE1G/Vd5dpEfn5dhQfeQ66marEuQ2D1jgpNknqI9EcHWHhABPyJaWZfJaeWWyvkEG
 Id01eajHoIwzUcY20W3MaeAjBsb0GLx8DrmbzfMFEhABVPnmQFcvYyvVAMI87+Oz/rVL
 xnAAQ3bdskQowQjKnZv0Ybsx2fAgVOn8Z9UmUWhEFP/Dofyn7ea3SBmpkiy6lINxFvkw
 tgFVpyTfeUhy4l4r3gib55NmgcGGg9m3OZY40uuYlmZ6jVGzV8I+cqZ/N2K6jYGuSftd
 /Fd3AncobXaO2IT+ZNQ/fF2zk1gAHC4//Z2L3YnKQcDe7o879Kr9P9Z2pMBUgJhNYBtj
 cyJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr13FD4IocfNN4px53lQJHsvB68vypJifjtcoA/BvpmSBhml+VtREaYIhT1wDS9jMKMO+kd87PI8oXb@nongnu.org
X-Gm-Message-State: AOJu0YwasYXV/VB66wBglzVbqAdQMbOlQfZQk9FTbNGsJ3A9ykzn1/gS
 9oxfA5Y8ukCi4X4hRxyW7OfbcqB7ZI5zmNj9yFrJoNq6nP+CmxiCOxBNDRkCTX0NdtzPRei+rRo
 4sKctFDn1z9d1L/u0O2q9UwmJHSsuVM8=
X-Gm-Gg: AfdE7clRp5ahIU6AFVbehx19QtXHwpC/lRaJK4VEq0Pk2z3AEs0OcHTHWGBT3pR810b
 lYYPB8CVLZt4vXjOiig2ZehEJYH4srQu70KgIiE04K2EK5f7ITj43KUWdD19egpHOWWd0nPufLA
 igBTIdLxHPV0EGEGuuiLrktB0pvsHtmuDQ9gfrUuq2S2dNB+6tv8OFzHpU99Lt1f5n8OMQhMI4s
 HzgVDYoqjN2XcSXWySVqCGAG0YZmbD+WoSDWxh+3J/1Az/3c2lH1jobxlyzNMhB836K8sKsJ8lQ
 uAqZY+wguT5mEu7iJR/9g56rC/s=
X-Received: by 2002:a05:690e:d4d:b0:662:bb5d:35a5 with SMTP id
 956f58d0204a3-66312f270ebmr12414355d50.31.1782192079687; Mon, 22 Jun 2026
 22:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260619044838.1054677-1-joel@jms.id.au>
 <20260619044838.1054677-9-joel@jms.id.au>
 <CAKmqyKML0szhhJv_pb=+oNZJwZhurn9k1La+FgiAHmBCYYFW+w@mail.gmail.com>
 <CACPK8XccZpBwwGQKs+CN_QGz19OMCiSnh1or8+aPewz8HRNK2g@mail.gmail.com>
In-Reply-To: <CACPK8XccZpBwwGQKs+CN_QGz19OMCiSnh1or8+aPewz8HRNK2g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jun 2026 15:20:51 +1000
X-Gm-Features: AVVi8Cdce5J_ReizeA4qz1EMBky1fMvDvgiwOKSHsRXGfpYUC-HU0N1b09VTNGM
Message-ID: <CAKmqyKPkyRPkfdnGJevMVu8qvLbaUmGfzRqMapRqLBhU5WzUSg@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] hw/riscv/atlantis: Provide a simple halting
 payload
To: Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb135.google.com
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

On Tue, Jun 23, 2026 at 2:38=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Tue, 23 Jun 2026 at 12:11, Alistair Francis <alistair23@gmail.com> wro=
te:
> >
> > On Fri, Jun 19, 2026 at 2:52=E2=80=AFPM Joel Stanley <joel@jms.id.au> w=
rote:
> > >
> > > From: Nicholas Piggin <npiggin@gmail.com>
> > >
> > > OpenSBI hangs before any console output if the domain init code sees =
the
> > > next stage is not in an executable region.
> > >
> > > If no kernel payload is provided to QEMU, the next stage address is
> > > NULL, and the riscv virt machine memory map ends up covering the 0
> > > address with the catch all S-mode RWX region and so OpenSBI prints
> > > console messages and does not hang until the next stage boot.
> > >
> > > The Tenstorrent Atlantis machine address map has RAM starting at 0 an=
d
> > > it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
> > > tripping the early check and hang.
> >
> > Ok, so I looked at this today and I think this commit message and
> > approach aren't the way to go.
> >
> > I do think the commit message is a bit confusing and not entirely
> > accurate. What about something like this (might need a tidy up, but
> > you should get the point):
> >
> > commit aac25688634d1afe6735cb71d8dd1ea652fa90d4 (HEAD -> riscv-to-apply=
.next)
> > Author: Alistair Francis <alistair.francis@wdc.com>
> > Date:   Tue Jun 23 12:37:47 2026 +1000
> >
> >    hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
> >
> >    When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
> >    to print any output, as it hits an error early on
> >    in the boot process and gets stuck in `sbi_hart_hang()`.
> >
> >    The error occurs in the `sanitize_domain()` function inside OpenSBI.
> >    `sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a =
generic
> >    coverall S-Mode RWX memory region are created. `sanitize_domain()` i=
s
> >    checking that the next address is executable.
> >
> >    If no next address is provided (which occurs on QEMU with an empty p=
ayload),
> >    then `dom->next_addr` will be 0. On most RISC-V boards address 0 wil=
l fall
> >    inside the coverall S-Mode RWX memory region and pass this check. On
> >    Atlantis the OpenSBI firmware is running at address 0, so this addre=
ss
> >    falls inside the M-Mode only OpenSBI firmware region and fails the c=
heck.
> >
> >    Once the check has failed OpenSBI aborts and the user doesn't see an=
y
> >    messages. This can be fixed by either supplying a payload, or just
> >    manually forcing a non-zero address (actually just any address that
> >    isn't the OpenSBI firmware) for next_addr.
> >
> >    This patch ensures that if no kernel is loaded we still specify a
> >    default kernel_entry so that OpenSBI happily boots and jumps to
> >    the first address in memory.
> >
> >    Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> This reads fine by me. Nick?
>
> >
> > diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> > index b40a893a37..dba56ad6e1 100644
> > --- a/hw/riscv/tt_atlantis.c
> > +++ b/hw/riscv/tt_atlantis.c
> > @@ -444,8 +444,15 @@ static void tt_atlantis_machine_done(Notifier
> > *notifier, void *data)
> >     if (machine->kernel_filename) {
> >         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
> >                           true, NULL);
> > +        kernel_entry =3D boot_info.image_low_addr;
> > +    } else {
> > +        /* If we aren't loading a payload, OpenSBI thinks we are tryin=
g to boot
> > +         * address 0, which fails `sbi_domain_check_addr()` as that is=
 where
> > +         * OpenSBI is running. Let's tell OpenSBI to start running at =
the start
> > +         * of memory so we at least let OpenSBI complete.
>
> This isn't quite true, we're pointing to just after opensbi. The start
> of the rest of memory.

Ah yep, good point.

>
> Perhaps:
>
>  Instead point OpenSBI to jump to the end of the region where it
>  was loaded, which avoids the early hang in OpenSBI, allowing
>  the system to proceed with the OpenSBI boot output.

Sounds good.

Alistair

>
> Thanks for taking a look.
>
> Cheers,
>
> Joel
>
> > +         */
> > +        kernel_entry =3D kernel_start_addr;
> >     }
> > -    kernel_entry =3D boot_info.image_low_addr;
> >
> >     fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].b=
ase,
> >                                            s->memmap[TT_ATL_DDR_LO].siz=
e,

