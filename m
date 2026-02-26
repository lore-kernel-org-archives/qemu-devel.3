Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE396FD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkof-0000LX-Gd; Thu, 26 Feb 2026 18:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkoQ-0000Ke-MF
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:30:30 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkoO-00081C-Di
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:30:30 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso2056877a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 15:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148627; cv=none;
 d=google.com; s=arc-20240605;
 b=OcnpO69QfuyfQdJ+vxrbecyJm442c7w/P+B1O4wiKo56pKxwJFPtIkSCGmBqOJIkXd
 ybUKMQQd3vKDnroK+GbJ6XzKyFH8CpbOdfKIvnHB0zZC3FIVcN3HjPeiWD2GzuaGF5Bv
 MfxUJTzA1f3EgdJfczPi1QmBi/tT5couFURPAORQAVl9zE9p4T46lFNXWf+UT24FjYfk
 cmkn9ZCBq/o4vEM9haHNIuzvSmdQxZe3OzlMK7BDbLKwni9SijVssGTadziYYSbvVb82
 NKW73GZV0sz2kVaKkfEEC3/bhS/IcwyiESQYUy4w0fGmgjHgHAR3a7Eq8zVdjSBPwA1c
 if4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Gl956GU9vtTgDHI735C3PJU5IFAdthrkMFyf9VEdxnc=;
 fh=6v8jo8vqcOvg90uRAPe+xGKCBKWCBssDw2Rjh0853fw=;
 b=cT7v54zW6+PXD0f8hj2IjGMEHlRstjK7MexwPfY/F1C7IsuvB+Hnf3U11ePaMALB6B
 TyeOZNGgbYeBehlbsK3xgCHGq+2AgjJeUk3lW733IonOz2E5qq4oqS/40+eu02C4QBOj
 Rzqb3Gb8Trd4uk0TmSKPQivXp44aumb7KRN+5tCUK5dsohX0a3WI7hZxw8LQSmIHV+Hz
 bdwkdV+/SJRcxNjahCkY0ggWH1YA3EjV+FaedjEU92yGowYuT8jC17hitSNosOcBnSG/
 HutXdE6Cm4Yzr2MLjSOc0aRIzmL/0MncNlisGSxQthraXT3I9CbiGe9o74w41zus/bSx
 sgeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772148627; x=1772753427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gl956GU9vtTgDHI735C3PJU5IFAdthrkMFyf9VEdxnc=;
 b=itwRxwmfbqCxT0IOLYVkdWC0w0YxtPl/vf5NYzigH7j+MiH3rIh3nw3iIQgZdYYnFS
 +b6RVT4xuIM5b/kIqdnsEOJAMxHADFwimsNnDWAyTbGYAXK5muAXI1kPDAm1RH0oc1tm
 1kGJ/wjPul125zG1r9eqPv/sCho83LmUUnblR1qiSauYI+wlLq6My0aBIo0Oo2KRvW4c
 Fk0xI+iwPkX2OKmfQlSvGDBMHaZ2jHDydj8zfTdXsr8sjThw8f3Ab3ZyHzpCS57CB9QE
 X+6lkYjLBn/5aI5Mk+SnRUrH7TFOdbh+Ag3xZUy4iSq+IDEqw1dBOcIXQDofBU4hU6LJ
 X4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772148627; x=1772753427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gl956GU9vtTgDHI735C3PJU5IFAdthrkMFyf9VEdxnc=;
 b=qFd/2ca3CR934lCQz8C8gC4ZjsGCYihDbluJ8PYRJe+YFA+2S7zsgK9Re4ZOvJeZ6E
 g2SiuFm7spuHVAzAqmiYQdhGGNWvwuVFEXf8qz+kXo3OXVIfCWfhB/NvQ3YleUnBIZJT
 tDVc8YVtxU0be7ifJW460J3xqjkdzdOvbOyhAV21GjmeXh57kgnwLTeXu4jt2HEgqqt4
 Q9rQJRnpoXHqwTQZBc4w0oCzTGoAzPLcj3dviaO7DQMx/Z8EaqDgaAMJlHNZ8e/7NVbd
 3GbWvlk55+M0v6V0Ej94Gm3A4sIE0HHn8yM9g1Ql1WrMfhvvoMSCnrmSmx6OGLrSg7gh
 54hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXedg2zxZqdnz1xvMegV3j1I7wcuXspR/sOsHLqZddv8M4Ygm8CaKr+km/JMaT68puDr0T/Evv0Z+ZK@nongnu.org
X-Gm-Message-State: AOJu0Yw+dLCL/jSIWJGWgp4zJxHYApkHMuINFIMpKvdyXxzbq72WMUyz
 2IGeEISRbiKaegGukXyxWVspiiWkfBRI3qp1kczB7ESdK/awU3/OOvIzLcyaLZx7L3/wf46mghG
 H2tEavxA7Bt0Qymo5lqOLb+VtftZDwK4=
X-Gm-Gg: ATEYQzxqzhCaqo+FauNZNeaLCroeVjGOcs7avKHl4Hv+1sZep497u+qYSxu5HMaMMvc
 TyFgWMSzACAANG1kwApUf7SF/CfPFOTWmxJzvM0Fdu5pNTkI+RpnuQHNqyhfTHyMM4tECqvEj4Y
 t5fDAMhMZVI9hnpE36xJ74M2DwDWk4mypykS1d8E9bQT4JXSvsodENiRObIF/HE0F4B3N2MUnSF
 vQ/yj6KFtgbUdWNMqCzTWKviLxwbY8WlEiK+1i9qY/KYEwg5wCADgoCAO2DNFAzo6+Bpc8L0WNj
 knHY3U+I6Xfl9d5LjAnWmcWinQf+jkHUlFpqsw==
X-Received: by 2002:a05:6402:1443:b0:65f:71ed:7abd with SMTP id
 4fb4d7f45d1cf-65fddee8e65mr526517a12.23.1772148626655; Thu, 26 Feb 2026
 15:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
In-Reply-To: <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 09:30:00 +1000
X-Gm-Features: AaiRm50eKCaKUZ-_EfpaWMFYN44iAl1xaEEGTrArAFT8h9i_VN7NUKO_iap7-D8
Message-ID: <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Feb 25, 2026 at 9:39=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
>
> > On 25. Feb 2026, at 11:20, Djordje Todorovic <Djordje.Todorovic@htecgro=
up.com> wrote:
> >
> > This series adds big-endian (BE) RISC-V target support to QEMU,
> > covering both softmmu and linux-user emulation for riscv32be and
> > riscv64be.
> Hello,
>
> There=E2=80=99s no Linux RISC-V big endian. Maybe the right thing to do i=
s to not
> support it unless we=E2=80=99re sure that it can get to Linux upstream (f=
or the linux-user mode)?

Agreed. We really need upstream Linux support before user mode

>
> Thank you,
> -Mohamed
> >
> > The RISC-V ISA supports big-endian operation via the mstatus SBE/MBE/UB=
E
> > bits. While instructions are always little-endian, data accesses follow
> > the configured endianness. This series implements the necessary QEMU
> > infrastructure.

How are you testing this?

Alistair

> >
> > Furthermore, MIPS announced cores with BE configuration:
> >  https://mips.com/products/hardware/i8500/
> >
> > Patches 01-03: Build system and config for new BE targets
> > Patches 04-07: Core emulation fixes (instruction fetch, boot ROM, ELF
> >               loading, fw_dynamic endianness)
> > Patches 08-11: Linux-user BE targets and vDSO handling
> > Patch  12:     Set SBE/MBE mstatus bits at CPU reset
> > Patch  13:     Fix PTE A/D atomic update endianness in page table walke=
r
> > Patch  14:     Clean up instruction fetch to use MO_LE directly
> > Patch  15:     Fix virtio-mmio legacy device register endianness
> > Patch  16:     Add riscv32be and riscv64be to SysEmuTarget
> >
> > Djordje Todorovic (9):
> >  meson: Add BE RISCV targets
> >  config/targets: Add BE RISCV softmmu targets
> >  config/devices: Add BE riscv configs
> >  target/riscv: Ensure LE instruction fetching
> >  hw/riscv: Ensure bootrom has correct endianess
> >  hw/riscv: Ensure proper ELF endian expectation
> >  hw/riscv: Check endianness for fw_dynamic fields
> >  config/targets: Add RISC-V userspace targets
> >  arch/riscv: Set UBE bit on BE target
> >
> > djtodoro (7):
> >  config/targets: Add missing fields to BE linux-user targets
> >  linux-user/riscv: Disable vDSO for big-endian targets
> >  target/riscv: Set SBE and MBE bits at CPU reset for BE targets
> >  target/riscv: Fix PTE A/D atomic update endianness
> >  target/riscv: Use MO_LE for instruction fetch
> >  hw/virtio: Use DEVICE_LITTLE_ENDIAN for virtio-mmio legacy ops
> >  qapi: Add riscv32be and riscv64be to SysEmuTarget
> >
> > configs/devices/riscv32be-softmmu/default.mak | 15 +++++++
> > configs/devices/riscv64be-softmmu/default.mak | 16 ++++++++
> > configs/targets/riscv32be-linux-user.mak      | 11 +++++
> > configs/targets/riscv32be-softmmu.mak         |  8 ++++
> > configs/targets/riscv64be-linux-user.mak      | 11 +++++
> > configs/targets/riscv64be-softmmu.mak         |  8 ++++
> > hw/riscv/boot.c                               | 41 ++++++++++++++++---
> > hw/virtio/virtio-mmio.c                       |  2 +-
> > include/hw/riscv/boot.h                       |  5 +++
> > linux-user/riscv/target_elf.h                 | 10 ++++-
> > meson.build                                   |  7 +++-
> > qapi/machine.json                             |  3 +-
> > target/riscv/cpu.c                            |  3 ++
> > target/riscv/cpu_bits.h                       |  2 +
> > target/riscv/cpu_helper.c                     |  9 ++--
> > target/riscv/translate.c                      | 16 ++++----
> > 16 files changed, 145 insertions(+), 22 deletions(-)
> > create mode 100644 configs/devices/riscv32be-softmmu/default.mak
> > create mode 100644 configs/devices/riscv64be-softmmu/default.mak
> > create mode 100644 configs/targets/riscv32be-linux-user.mak
> > create mode 100644 configs/targets/riscv32be-softmmu.mak
> > create mode 100644 configs/targets/riscv64be-linux-user.mak
> > create mode 100644 configs/targets/riscv64be-softmmu.mak
> >
> > --
> > 2.34.1
> >
>

