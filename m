Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD03CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbsub-0005cl-Vp; Tue, 23 Jun 2026 00:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wbsuZ-0005c5-QZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:38:59 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wbsuX-00059e-QO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:38:59 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662d484ff3bso5167293d50.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782189536; cv=none;
 d=google.com; s=arc-20240605;
 b=QYNZNZepmfuma3MjvjF0QoPh98V3cUCaK4LaEEVCuyM5IntmUqgzyoGtzPbl+35tvh
 btFRDTsaGdno/tD3uMZmd+oVLAcnLLpm0ON8bTfrhO3wbk8j+1sZIoNIz8IhS+jLRDiY
 JAZOQ9kiqi+MSzaDT4KtiRsFTLu0RvR7Fe/QUX92lvdK9qWJABJeU/QV/ybK4ahrz9BN
 edzdTxrVNb/HjWw8vpytuI5uu3ZhFEylqyyQYylP9UmITazWGOlfZcTO0k5gghWrWtbt
 G70YSi2FIZr8w/tl/VHPJwqDrAFkwvlKLJGuidS40xnjSQzAHO1j4Rmg6bYEg8BBJ02a
 Krsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xlWKN2+eT6XlZj1EQLxlWrO6lNCSSe/KQqe2uTfyKx0=;
 fh=kdkL9dHY41m0pvZMM++Lj87qt/WKBpo8sTsBHu6s7xI=;
 b=E6heLwua9ycZrWaVN01xMmCxFR/vGROzxWA694ypfgx3Rg6uP1LTt/qUzUjhie7Cm0
 fPxr8nRyJ6jT1/mfKNAxW1IU75IZDW61i9oT3Eh0Tb4VMHrzLXjIMYOMwhwS1ecCLLPf
 7m4OAnIAIqlUgADrH6fPzGDNu3PJjJmn+duaz+nmNFRtOrU9YotI+p1Sj2W6qn74WbuG
 oPsfJsVTF9Zm/w3OQQkzY2H9iIXxFZD+etnSEjx4sRvGqbKTch2e+MDzArcXcBIHuq1P
 pLDs4iLaAqd/oiJldXQ4dcVL/uxoFSvtGOR8/pRv6eEtMVHuteEB0sf97AvwfIRrsrR5
 tSPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782189536; x=1782794336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlWKN2+eT6XlZj1EQLxlWrO6lNCSSe/KQqe2uTfyKx0=;
 b=FGOmzKHRnb3G1NIHQcEmk0ffabFJxNqpfmf1mPGyup9o4jk1IlQxdetDMGZyAtM8uY
 gPeVQc+bbdlpY5ooVuFOoB3kcTUaQsp+bV1pBpZWHHaPkpmd2IPw0CZvL+RS7GMukqkw
 cwiA6vPbXx7ujJBMu7sQfmep7SNLZQ/Hl1U38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782189536; x=1782794336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlWKN2+eT6XlZj1EQLxlWrO6lNCSSe/KQqe2uTfyKx0=;
 b=RrpeCfShCCQfJTHICwb8d/rPlDrjdWLXPDGjRdGLFF8ivoW4QzA6gvu5zQak0GMSC2
 M4/DrplaZpjPUuXboedUqrOmnyj0rRM4oxnMvlKH2e8KKJAzPgjW5mEwgrCUXh7HZ+5b
 dcJHwO1siAO5XnpfEWAIUYGgwjIOMiKHBBf+CZoQqP9vhmLPn1MAglogPSu9DVyqyZ1Q
 JNsTBZwhkSqJAaeBOzmo/ANbEVYUmpT/XTn+WgMZYoj5wTGv58SyLqks25OQaB/l/F/z
 6p3f0dmyl0nDVUbxW/Gkxd+K0F6u+FN27KnuYvNm48B1A38zOEWjFIwRYygcAci47hcs
 hXog==
X-Forwarded-Encrypted: i=1;
 AHgh+RprCYEFDhYnUflDXF0rWPuBMxB1ty3YbEW4/HHyWHauuS0pUuYJnQNzsqoxmkG6ghyHeBvHUAFUzllx@nongnu.org
X-Gm-Message-State: AOJu0Ywy9grylPnnsCg3v116BQzc820mGNk9e0Eo9U7Eodq1w84ejr08
 zZo7pDNhPzeiO1wlZN5Y1iGA4ijeYEiisQPldNn7SgMs7KGqp1b2psm68PL3851Hobx/j6mj70I
 goDyEMWuO3rl4oWVPOobT8TIGya1QL/Q=
X-Gm-Gg: AfdE7clr8Uhh9XSw/q7F01jhYYJgGNZdQJttKPwcwUEidfhDH1i8/ExcsP6FH/S16lB
 Mt7oHTjUgP641aoTjWA73tIOsJyKkxgIbrPJ1T+Sv+vgwfyEfpQL9tRduMrIuKDFRaaQjB5DelY
 3ZfoFyZ3vW4X/B2KLJMI9TL74SJnYR3U5H4E32mijh6Vno+pGRQkEuisP/sC8/gN7NyHtMdzlof
 k2+6H7mNf+tR8woA9pi4ToxXLpnW1Rzc5/WAOUYZlVnP9TNfzUiqUd1gsHIvIdRV9QWCbn0T+Ef
 MuXrEKZr8E66xlTO2pl3kE0zvpY6op4Ve8ZYx+NaEStQiXXBL4SO6NQW1rIT8eldYV6zPWG7n5D
 HW4aN6j0K+N21qA==
X-Received: by 2002:a05:690e:b4c:b0:661:1307:3d40 with SMTP id
 956f58d0204a3-662ffdc4b2emr16102080d50.46.1782189536067; Mon, 22 Jun 2026
 21:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260619044838.1054677-1-joel@jms.id.au>
 <20260619044838.1054677-9-joel@jms.id.au>
 <CAKmqyKML0szhhJv_pb=+oNZJwZhurn9k1La+FgiAHmBCYYFW+w@mail.gmail.com>
In-Reply-To: <CAKmqyKML0szhhJv_pb=+oNZJwZhurn9k1La+FgiAHmBCYYFW+w@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 23 Jun 2026 14:08:44 +0930
X-Gm-Features: AVVi8CdwV6gbKdwIMPses6kh7NeNJvbKiUNl5yjtCQFAoVJAKow4DPe9DqM_9_k
Message-ID: <CACPK8XccZpBwwGQKs+CN_QGz19OMCiSnh1or8+aPewz8HRNK2g@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] hw/riscv/atlantis: Provide a simple halting
 payload
To: Alistair Francis <alistair23@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org, 
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
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 23 Jun 2026 at 12:11, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Fri, Jun 19, 2026 at 2:52=E2=80=AFPM Joel Stanley <joel@jms.id.au> wro=
te:
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > OpenSBI hangs before any console output if the domain init code sees th=
e
> > next stage is not in an executable region.
> >
> > If no kernel payload is provided to QEMU, the next stage address is
> > NULL, and the riscv virt machine memory map ends up covering the 0
> > address with the catch all S-mode RWX region and so OpenSBI prints
> > console messages and does not hang until the next stage boot.
> >
> > The Tenstorrent Atlantis machine address map has RAM starting at 0 and
> > it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
> > tripping the early check and hang.
>
> Ok, so I looked at this today and I think this commit message and
> approach aren't the way to go.
>
> I do think the commit message is a bit confusing and not entirely
> accurate. What about something like this (might need a tidy up, but
> you should get the point):
>
> commit aac25688634d1afe6735cb71d8dd1ea652fa90d4 (HEAD -> riscv-to-apply.n=
ext)
> Author: Alistair Francis <alistair.francis@wdc.com>
> Date:   Tue Jun 23 12:37:47 2026 +1000
>
>    hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
>
>    When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
>    to print any output, as it hits an error early on
>    in the boot process and gets stuck in `sbi_hart_hang()`.
>
>    The error occurs in the `sanitize_domain()` function inside OpenSBI.
>    `sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a ge=
neric
>    coverall S-Mode RWX memory region are created. `sanitize_domain()` is
>    checking that the next address is executable.
>
>    If no next address is provided (which occurs on QEMU with an empty pay=
load),
>    then `dom->next_addr` will be 0. On most RISC-V boards address 0 will =
fall
>    inside the coverall S-Mode RWX memory region and pass this check. On
>    Atlantis the OpenSBI firmware is running at address 0, so this address
>    falls inside the M-Mode only OpenSBI firmware region and fails the che=
ck.
>
>    Once the check has failed OpenSBI aborts and the user doesn't see any
>    messages. This can be fixed by either supplying a payload, or just
>    manually forcing a non-zero address (actually just any address that
>    isn't the OpenSBI firmware) for next_addr.
>
>    This patch ensures that if no kernel is loaded we still specify a
>    default kernel_entry so that OpenSBI happily boots and jumps to
>    the first address in memory.
>
>    Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

This reads fine by me. Nick?

>
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index b40a893a37..dba56ad6e1 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -444,8 +444,15 @@ static void tt_atlantis_machine_done(Notifier
> *notifier, void *data)
>     if (machine->kernel_filename) {
>         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
>                           true, NULL);
> +        kernel_entry =3D boot_info.image_low_addr;
> +    } else {
> +        /* If we aren't loading a payload, OpenSBI thinks we are trying =
to boot
> +         * address 0, which fails `sbi_domain_check_addr()` as that is w=
here
> +         * OpenSBI is running. Let's tell OpenSBI to start running at th=
e start
> +         * of memory so we at least let OpenSBI complete.

This isn't quite true, we're pointing to just after opensbi. The start
of the rest of memory.

Perhaps:

 Instead point OpenSBI to jump to the end of the region where it
 was loaded, which avoids the early hang in OpenSBI, allowing
 the system to proceed with the OpenSBI boot output.

Thanks for taking a look.

Cheers,

Joel

> +         */
> +        kernel_entry =3D kernel_start_addr;
>     }
> -    kernel_entry =3D boot_info.image_low_addr;
>
>     fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].bas=
e,
>                                            s->memmap[TT_ATL_DDR_LO].size,

