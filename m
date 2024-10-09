Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA1CF043C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNk7-0006Jb-Tw; Tue, 08 Oct 2024 23:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syNk6-0006Io-FF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:52:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syNk4-0007sN-Df
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:52:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e038f3835so2467160b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728445922; x=1729050722;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm5uKMZ1YJ4NZYBCBWN5xcaqHfKmlW82HIGsBN15l98=;
 b=Xs2BXeILOXrLmocOUadM6kVhWrk7ZpalCGmq/1oiS2+KK1a+LKifNj5xoWtef63g0G
 oPuGwAuK+IHVY6J2Z+tYJnmZeLHp/QkXLCV5nt9f/j7osG9PyecYRT2gPHPsNwbufkjA
 xZn7CgR3Y9ZTBSKjo87+GwWfB3D+7mLD5z9vipurWk1boDqDVq5FcDertqtN/BiLKxqL
 45NU4E1U6V3myNlv4eBeRf9bqgEvNAATry/tn3wIBvDEYbRGwtJVhAIaJ6OzTzg/scVT
 bf6YxWh10wB6qr0tyIAz35pp4oVcgancijhYZ1AxW8nFDJQ9IryFw1g5Pmrbc2Dzy5N9
 nzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728445922; x=1729050722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zm5uKMZ1YJ4NZYBCBWN5xcaqHfKmlW82HIGsBN15l98=;
 b=mUAN81uqymOCq30/AdHIOns5NV87DBkRPWOPyUjE/Fi6hgHV3EcH1VRntoHqdnZ5Ud
 TEERKl6pyrNXhlXcdtCx/MLfqF9yG2oImjLlczg2rAJSggJQZ83IDFYkZMnuM5uGPeb5
 Y8vNufAoPD5rvY7RXJ/PpugG+8/hxwAeaqGT5ujn5CHcjl0h5P5ebDkhM6S/PGl2yU8q
 /OFWuDF1otQweDSluQRTnRwPQlY06AS/gwmrGtpFtfmLhbtgCRAw2+J0Ee6H1uQM3ra8
 i9lzwVFT0B6hinjE8mdk1+IivORTpywLKZVqOuZW09cQNoFNhzEPDQUt4E/yQf1pwx1R
 c5cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY42IwBgNET5xZBhj9iy9kkV/eebdKfD9drFMnzMLX9hztC38ESTAp60uZBZoUSzk6qvxeJbZrHGSm@nongnu.org
X-Gm-Message-State: AOJu0YwdfFonajsgrcryg5Oq72/Ar0P63oXSd292i0VBcG6AhKz+8x8p
 CVzxbD0Gnt7HvzPULjuW8RlcBh63qFsW1ogGktkoTVi7zDhBiYkzYGWDwddbRZsnzlWPORfkI5P
 b2W4J8RbATRltBOwUCPOBpiUeAWXejElOPJ23Bg==
X-Google-Smtp-Source: AGHT+IE2jCukXJi9D80kULoWxmIOMwLrJzRvAB2QGMGRL1sw30K8fLn572MWLmNpIFlVWxkdU2h1+hkpT23efOmc5xg=
X-Received: by 2002:a05:6a20:d497:b0:1cf:2d52:415e with SMTP id
 adf61e73a8af0-1d8a3c3a48amr1338673637.36.1728445922477; Tue, 08 Oct 2024
 20:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
 <CAKmqyKPH33Lf5YdNrdHEQ9K0ZLrnJmvcGi9DjsP6gKNQZYAxaA@mail.gmail.com>
In-Reply-To: <CAKmqyKPH33Lf5YdNrdHEQ9K0ZLrnJmvcGi9DjsP6gKNQZYAxaA@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 8 Oct 2024 20:51:51 -0700
Message-ID: <CAHBxVyEFDkDm5Tiytiemxohj1YdqdBiKk2YSiFdQ83dqN5zvyw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] target/riscv: Add support for machine specific
 pmu's events
To: Alistair Francis <alistair23@gmail.com>
Cc: Alexei Filippov <alexei.filippov@syntacore.com>, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 7, 2024 at 7:52=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Sep 11, 2024 at 3:49=E2=80=AFAM Alexei Filippov
> <alexei.filippov@syntacore.com> wrote:
> >
> > Following original patch [1] here's a patch with support of machine
> > specific pmu events and PoC with initial support for sifive_u's HPM.
>
> Thanks for the patch.
>
> I'm hesitate to support these callback functions as I feel they
> (callbacks in the CPU to the machine in general) are clunky.
>
> I think the cover letter, code and commit messages need more details here=
.
>
> First can you link to the exact spec you are trying to implement
> (RISC-V has a habit of creating multiple "ratified" specs that are all
> incompatible). It's really handy to point to the exact PDF in the
> cover letter or commit message to just be really clear what you are
> supporting.
>

This patch is trying to implement SiFive specific event encodings.
There is no standard
RISC-V ISA involved here.

> Secondly, can you describe why this is useful? What is the point of
> machine specific PMU events? Why do we want to support this in QEMU?
>

I happen to work on a similar implementation as well. Apologies for
not seeing this patch earlier.
Here is the link to the series that I have been working on to
implement a similar feature.
https://github.com/atishp04/qemu/tree/b4/pmu_event_machine
I will send it to the mailing list tomorrow after some checkpatch fixes.

Regarding the motivation, RISC-V ISA doesn't  define any standard
event encodings.
The virt machine implemented event encodings defined in the SBI PMU
extension because
there was nothing else available. There is an active performance
events TG who is working on defining
the standard events for RISC-V but not the encodings. The goal is
provide flexibility for the platforms while
allowing a minimum set of events that would work across platforms.

However, any platform would define their own event encodings and want
to support those in their Qemu
machine implementation. That's why, we should disassociate the event
encodings in the pmu.c to make it
more generic and usable across machines.

> The callbacks should also have some documentation in the code base so
> others can implement the functionality.
>
> It might also be helpful to split this patch up a little bit more. A
> quick read through and it seems like the patches could be a little
> smaller, making it easier to review.
>
> Finally, for the next version CC @Atish Patra  who has ended up being
> the PMU person :)
>

Thanks for Ccing me. I completely missed this patch earlier. Few
thoughts by looking at this series.

@Alexei:
1. Event encoding needs to be widened to 64 bits. That's what I tried
to achieve with my implementation
along with a bunch of other cleanups.

2. Why do we need machine specific counter write/read functions ? If
we really need it, we should definitely have that
as a separate patch as my implementation only focussed on
disassociating the events and pmu implementation.

Please take a look at the patches shared above or the mailing list
(should land tomorrow) and let me know your thoughts.
I am happy to collaborate on your patches so that we have more than
just a virt machine that we can test with this series.

> Alistair
>
> >
> > =3D=3D Test scenarios =3D=3D
> >
> > So, I tested this patches on current Linux master with perf.
> > something like `perf stat -e branch-misses perf bench mem memcpy` works
> > just fine, also 'perf record -e branch-misses perf bench mem memcpy'
> > collect samples just fine and `perf report` works.
> >
> > =3D=3D ToDos / Limitations =3D=3D
> >
> > Second patch is only inital sifive_u's HPM support, without any
> > filtering, events combining features or differrent counting
> > algorithm for different events. There are also no tests, but if you
> > have any suggestions about where I need to look to implement them, plea=
se
> > point me to.
> >
> > =3D=3D Changes since original patch =3D=3D
> >
> > - Rebased to current master
> >
> > [1] https://lore.kernel.org/all/20240625144643.34733-1-alexei.filippov@=
syntacore.com/
> >
> > Alexei Filippov (2):
> >   target/riscv: Add support for machine specific pmu's events
> >   hw/riscv/sifive_u.c: Add initial HPM support
> >
> >  hw/misc/meson.build            |   1 +
> >  hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
> >  hw/riscv/sifive_u.c            |  14 ++
> >  include/hw/misc/sifive_u_pmu.h |  24 +++
> >  target/riscv/cpu.c             |  20 +-
> >  target/riscv/cpu.h             |   9 +
> >  target/riscv/csr.c             |  93 +++++---
> >  target/riscv/pmu.c             | 138 ++++++------
> >  target/riscv/pmu.h             |  19 +-
> >  9 files changed, 599 insertions(+), 103 deletions(-)
> >  create mode 100644 hw/misc/sifive_u_pmu.c
> >  create mode 100644 include/hw/misc/sifive_u_pmu.h
> >
> > --
> > 2.34.1
> >
> >

