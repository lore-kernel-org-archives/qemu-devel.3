Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C240FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 12:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlo8-0006cl-4n; Mon, 06 Jan 2025 07:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlo4-0006cU-86
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 07:02:04 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUlo2-0007I7-EU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 07:02:04 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e3983426f80so19516853276.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 04:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736164921; x=1736769721; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wClEy6oQJGJVxO3/L61pzgT77oOaf4rskn1e2euO2I=;
 b=BN9QmOx8kbdK9n+td5ppwos2Oemzk6mGXKn8qskfjMUHzcoyZ1bmp+MruU+nDkjuBC
 ++SQN7M9oEmZn/7V6wiglELOef5pyKgmO+Gao3L2Wb3c3wYMby8xgszo3OSQiNeDRzKY
 KYvaErwop+f6jX64qHhCjyvWoF+lIPo5EIH71y6PHS8C9vcHQdkY9ZenAGzuE238pa/R
 1yve6FfYhWhWekrjEhcTDLo/C6vEaMtxzP0NlPB4iroyGK+2DMHSQ3ovoI2SBX7UX12u
 0Mn4Kcku1Im82Mdl+x4cdGMLUruasbXN971XKyRS+mIWyZDgogxTRU+8PQBXFFyDoy+s
 VG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736164921; x=1736769721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wClEy6oQJGJVxO3/L61pzgT77oOaf4rskn1e2euO2I=;
 b=erIeBg6TF0w8qOwkAsuFoGfrnA6ToJL1Z2hRw9Ftwl2VSE/qWZpvgcCTidDY4sOBeC
 Fp72PQ4i0DkOMjICmqBbD6MsCqDgV+2gIDMlq8RK1CzrUluDYqJiQd9/GC0J8Y86odZK
 AnRXj+piZoraRcay81dYWcUJh6aJLWUHb01FhAq4R15x2oA1GDeJUzwD8yN7RmKEkf+u
 wOaR5eBDcYlnUOEggsNH6yAHLhgZLYHo092WbbKUxCQe5O7Xjq3BIw8aco7yRDN4WOs8
 WvsEJLHK9NmrCfiDshv2D8y5qPl6eO+Nvh2wJzSVpqDPAh1USNNtGqw/hPoddPXJbinG
 DgJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe8smjHAGXVBycyZBMIJu4XPLFh3eTM2l5fXGnr8xwTkdWG2xxC4g0BJqYNLLetSOLo1mHOI2dMSKR@nongnu.org
X-Gm-Message-State: AOJu0YxAQ/YBsusWDABB4taDvF3TocEKE4EDUCNHisPSFrn3GhM+l/R7
 DQcMzGWBC5HDwLn0AismYYehn2VXxVJNF5TK3gRQd4xXQW/r8XexrT4XBllZ+joAFkqWFLLuNYS
 dNaA2XuK7TnnNuQCVIemlIA9S5XSid9OixEJ0gQ==
X-Gm-Gg: ASbGncuBWWgTArEvs3CaRa9d7KSvmli6wOvymNSZLqrnZ5hR6f40Dh4X6UhHWtiSyEH
 ovyNdcGgKwd/OmTbe0YBZd6MxUbiMbmb0RlFKtgA=
X-Google-Smtp-Source: AGHT+IEokjpdRRpaXrHqNz5gM3Ve1o9lNvJR59Zc4g0JS4bzGQ6TJfB3+CSHEHZBtvry60xKTSMxBc+TL7sk7CeG9Q4=
X-Received: by 2002:a05:6902:704:b0:e39:8d87:f146 with SMTP id
 3f1490d57ef6-e538c22410dmr48433562276.22.1736164921002; Mon, 06 Jan 2025
 04:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
 <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
 <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
 <Z3vFRrkjIEa-LaqU@redhat.com>
In-Reply-To: <Z3vFRrkjIEa-LaqU@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 12:01:49 +0000
Message-ID: <CAFEAcA9sVKtnkr3uaxVySx7E-RZM5qNbTpavgsUZ56M3m5gb7A@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Mon, 6 Jan 2025 at 11:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Jan 06, 2025 at 11:47:00AM +0000, Peter Maydell wrote:
> > On Mon, 6 Jan 2025 at 01:29, Alistair Francis <alistair23@gmail.com> wr=
ote:
> > >
> > > On Fri, Jan 3, 2025 at 2:04=E2=80=AFAM Andrea Bolognani <abologna@red=
hat.com> wrote:
> > > >
> > > > On Tue, Dec 03, 2024 at 10:47:02AM +0100, Andrea Bolognani wrote:
> > > > > Currently the script won't generate a configuration file that
> > > > > sets up qemu-user-riscv32 on riscv64, likely under the
> > > > > assumption that 64-bit RISC-V machines can natively run 32-bit
> > > > > RISC-V code.
> > > > >
> > > > > However this functionality, while theoretically possible, in
> > > > > practice is missing from most commonly available RISC-V hardware
> > > > > and not enabled at the distro level. So qemu-user-riscv32 really
> > > > > is the only option to run riscv32 binaries on riscv64.
> > > > >
> > > > > Make riscv32 and riscv64 each its own family, so that the
> > > > > configuration file we need to make 32-on-64 userspace emulation
> > > > > work gets generated.
> > > > >
> > > > > Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> > > > > Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> > > > > Thanks: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > > > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> > > > > ---
> > > > >  scripts/qemu-binfmt-conf.sh | 7 ++-----
> > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > ping
> > > >
> > > > There are already two ACKs so I think we just need a maintainer to
> > > > pick this up.
> > >
> > > We didn't get an answer to the issue of a CPU supporting RV32 and yet
> > > the kernel still calls QEMU.
> > >
> > > I understand this allows things to work out of the box, but seems lik=
e
> > > a disservice to any hardware that does support RV32
> >
> > There's the same thing on Arm too -- we don't set up qemu-user
> > aarch32 binfmt-misc on an aarch64 system because the host might
> > be able to natively execute the aarch32 binary. This is becoming
> > less true, but we still don't want to silently downgrade
> > native execution to emulation on the hosts where native execution
> > used to work.
>
> Arm is a bigger problem as historically there genuinely was a
> non-trivial set of CPUs with 32-on-64 support in HW.
>
> IIUC, the riscv situation is much less likely to be a real problem
>
> > I'm not sure the best approach here -- ideally we would want to
> > be able to register a binfmt-misc to the host kernel with "only use
> > this if you could not already natively execute it", but AFAIK that's
> > not possible.
>
> The other thing is that qemu-binfmt-conf.sh is not really the right
> place to decide this, as we can't assume it is being run on the machine
> that QEMU will be deployed on. eg in distro case, qemu-binfmt-conf.sh
> may be run in a build farm to statically generate files.
>
> Any conditional loading of binfmt rules would required extra magic to be
> implemented by systemd, or would have to be done by the user selectively
> installing different packages to omit the binfmt rules they don't want.

If the kernel supported this via a binfmt flag, it wouldn't need
systemd-specific magic, user intervention, or for qemu-binfmt-conf.sh
to be running on the target machine. (But of course there's the "does
anybody care enough to implement that" problem plus the long delay of
actually deploying kernels that know about the flag...)

thanks
-- PMM

