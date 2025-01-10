Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A2E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAMI-0002OO-MH; Fri, 10 Jan 2025 03:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAME-0002NM-Oy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:27:07 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tWAMB-0000n9-MM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:27:05 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21634338cfdso40403955ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736497622; x=1737102422;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgZGVh+ycwDsOSKFa9SNlTClj0dfHISpgNjgoYAIZi0=;
 b=YdqTO5B0NvRI6NfQyEtivWXf9zQDn+yuJ+DJ5zctpBJABDS30fHf4JR3Hqe/Vb7Z4k
 58a/CR9rt8suW2VhH+EHxhpHV14GyhvoamaFOUc2gLoxdVr6KQ+FLLzBnWclAbrwAy8G
 WTm0M2FQRXh2m6atDOKbLxhW6S8XuCH6yEi3exs1hkMEJ3QZvl1PSXe055ez14/x8dFc
 lCVVGns3Oh6noioK9K18RMw1U1hWVcBU8KJ2f6HDjwe84tIa6LuXhjeH8DFUdv5gOEgP
 llen85i/1haoecg/GtE376iFu+OC+NBU49LaWOOrho5IrijBSWBwdcadoGONH6yzkTCU
 tuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497622; x=1737102422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgZGVh+ycwDsOSKFa9SNlTClj0dfHISpgNjgoYAIZi0=;
 b=F9VHRxgOzgsX7pKm7Uh8Buh/mWxiQE6H1TZ9E+bCYoePgo4vrKUEGac/Gb86WSRVNw
 V8QLgyWrl+o1fbBjkx+Xx/8iY/B6RPX14npFR+5/MNcmBpkZfWhThfeU2Z5suOcYLGfG
 1xQurHXqfDn1oSNM/gU5N5Z0bEtfy6/jO0QlfrVQ163SuSpEo4JjujFy1oDroWFqLf80
 6nHDypEJ/tonHUqupN98inzHRPY5J6OiuqGiN+t5Xzk1XzvsxMCrvJIF7YPb+Fuaam6u
 4myq9hJhALbFU2UVkteha5Zlp5scHYVRL4qaNEz5Dd15PAUQ4UirFq926Z7ag5ES8KA5
 CNWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt1noCpS6ZUBdmrYujSKp9/uMrN6Rayb9gsHLXPJ9xVfTpsAO6mMm7v8fb4nkJBlp6Mh9kbfCE+3/D@nongnu.org
X-Gm-Message-State: AOJu0YwU+fClUdB6Qu+AYs6DMkzajxZzrJ6kkyZYzAwRaiJLDwfRWOka
 16fhzbnBnezxEYvXwKWv0g5qwaInJzBsSsnDoX1QANkJCpa5HrBjPzXVwSFv15tydRqgqtaXpjR
 CLpTbqsLl6uxwzn8EWq8oloQ2ApgaNS7uPSJCCvrZzmPRogrb3GU=
X-Gm-Gg: ASbGnctj3PlKwWdQ4QgPbaqkMON3jVTCK7eIFxZnqpTrYZ5SWoXCG6JE5wxZw6Cmn0K
 mJcMK+E7SXITuG6+j0ZA8CyxLLj+Wn11YeMSF
X-Google-Smtp-Source: AGHT+IEFGXYiV13vbFHUp6WfPA0AZfjtwKsgdsSpmDsaRdTSrlOZLRUUEosGt6blRoRQYeVA1Wu37GNN3cHM59O8dbk=
X-Received: by 2002:a05:6a00:2388:b0:72a:a7a4:9c6d with SMTP id
 d2e1a72fcca58-72d21ff97b1mr16598428b3a.24.1736497622020; Fri, 10 Jan 2025
 00:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <CAKmqyKMBSoTR7-UexAu2qrur5bOgWBGOOQOPXgrh+k6LC3vG-A@mail.gmail.com>
In-Reply-To: <CAKmqyKMBSoTR7-UexAu2qrur5bOgWBGOOQOPXgrh+k6LC3vG-A@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 00:26:51 -0800
X-Gm-Features: AbW1kva0Xq4do8qvoR3sf3egip_uGkUSfHOHMZ22R2msBeLH7EfuifmknEVew0M
Message-ID: <CAHBxVyE7vd1TjgnV5Cd_yDKwnNuEORz2O5gU9qS0SVqK+t95WQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Add RISC-V Counter delegation ISA extension
 support
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x62d.google.com
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

On Thu, Jan 9, 2025 at 6:10=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Dec 4, 2024 at 9:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
> >
> > This series adds the counter delegation extension support. The counter
> > delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple =
ISA
> > extensions.
> >
> > 1. S[m|s]csrind : The indirect CSR extension[1] which defines additiona=
l
> >    5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation =
of
> >    RISC-V CSR address space.
> > 2. Smstateen: The stateen bit[60] controls the access to the registers
> >    indirectly via the above indirect registers.
> > 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
> >
> > The counter delegation extension allows Supervisor mode to program the
> > hpmevent and hpmcounters directly without needing the assistance from t=
he
> > M-mode via SBI calls. This results in a faster perf profiling and very
> > few traps. This extension also introduces a scountinhibit CSR which all=
ows
> > to stop/start any counter directly from the S-mode. As the counter
> > delegation extension potentially can have more than 100 CSRs, the speci=
ficaiton
> > leverages the indirect CSR extension to save the precious CSR address r=
ange.
> >
> > Due to the dependancy of these extensions, the following extensions mus=
t be
> > enabled to use the counter delegation feature in S-mode.
> >
> > "smstateen=3Dtrue,sscofpmf=3Dtrue,ssccfg=3Dtrue,smcdeleg=3Dtrue,smcsrin=
d=3Dtrue,sscsrind=3Dtrue"
> >
> > This makes the qemu command line quite tedious. The previous version, I=
 tried
> > to introduce a preferred rule to enable all but it was decided that an =
user
> > should opt to use max cpu if they don't want to enable all the dependan=
t ISA
> > extensions by hand. This series got rid of the preferred rule and added=
 2
> > patches for specifiying the mandatory ISA extensions via implied rule.
> >
> > The first 2 patches decouple the indirect CSR usage from AIA implementa=
tion
> > while patch3 adds stateen bits validation for AIA.
> > The PATCH4 implements indirect CSR extensions while remaining patches
> > implement the counter delegation extensions.
> >
> > The Qemu patches can be found here:
> > https://github.com/atishp04/qemu/tree/b4/counter_delegation_v4
> > The Linux kernel patches can be found here (WIP version due to onging u=
pstream
> > dependant patches):
> > https://github.com/atishp04/linux/tree/b4/counter_delegation_v2
> >
> > [1] https://github.com/riscv/riscv-indirect-csr-access
> > [2] https://github.com/riscv/riscv-smcdeleg-ssccfg
> >
> > Cc: kaiwenxue1@gmail.com
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> > Changes in v4:
> > - Fixed the comments recieved on v3.
> > - code style comments and removed 1 redundant if else block.
> > - Link to v3: https://lore.kernel.org/r/20241117-counter_delegation-v3-=
0-476d6f36e3c8@rivosinc.com
> >
> > Changes in v3:
> > 1. Updated the priv version in extensions
> > 2. Fixed minor issues pointed out in v2.
> > 3. Dropped preferred rule and added an implied rule for AIA and counter
> >    delegation.
> > - Link to v2: https://lore.kernel.org/r/20240723-counter_delegation-v2-=
0-c4170a5348ca@rivosinc.com
> >
> > Changes from previous RFC version:
> >
> > 1. Renamed sxcsrind to csrind to align with other function names.
> > 2. Enable sscofpmf by default for virt machine.
> > 3. Introduced a preferred extension enabling rule strategy for generic
> > mult-extension dependencies.
> > 4. Enables all PMU related extensions if ssccfg extension is set.
> >
> > RFC Link:
> > https://lore.kernel.org/all/35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventan=
amicro.com/T/
> >
> > ---
> > Atish Patra (5):
> >       target/riscv: Enable S*stateen bits for AIA
> >       target/riscv: Add properties for counter delegation ISA extension=
s
> >       target/riscv: Invoke pmu init after feature enable
> >       target/riscv: Add implied rule for counter delegation extensions
> >       target/riscv: Add configuration for S[m|s]csrind, Smcdeleg/Ssccfg
> >
> > Kaiwen Xue (6):
> >       target/riscv: Add properties for Indirect CSR Access extension
> >       target/riscv: Decouple AIA processing from xiselect and xireg
> >       target/riscv: Support generic CSR indirect access
> >       target/riscv: Add counter delegation definitions
> >       target/riscv: Add select value range check for counter delegation
> >       target/riscv: Add counter delegation/configuration support
> >
> >  target/riscv/cpu.c         |  20 +-
> >  target/riscv/cpu.h         |   1 +
> >  target/riscv/cpu_bits.h    |  34 ++-
> >  target/riscv/cpu_cfg.h     |   4 +
> >  target/riscv/csr.c         | 718 +++++++++++++++++++++++++++++++++++++=
+++++---
> >  target/riscv/machine.c     |   1 +
> >  target/riscv/tcg/tcg-cpu.c |  28 +-
> >  7 files changed, 753 insertions(+), 53 deletions(-)
>
> This has all been Acked now, do you mind rebasing on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?
>

Done. I have coordinated with clement as well in case his Ssdbltrp
rebase has some conflicts due to this.

> Alistair
>
> > ---
> > base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0
> > change-id: 20240715-counter_delegation-10ab44c7d2c0
> > --
> > Regards,
> > Atish patra
> >
> >

