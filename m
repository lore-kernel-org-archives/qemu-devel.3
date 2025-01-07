Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96794E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyQ7-00071q-6q; Mon, 06 Jan 2025 20:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyQ5-00071B-39
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:30:09 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyPy-0002SC-10
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:30:06 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afdf8520c2so4703757137.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 17:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736213400; x=1736818200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yg9EHk7cpi3rd32/TS8MrtNRhiJquplT3DHcLd9fKSI=;
 b=EA/ObgZGQMa+7bm0T/XGsXBcAOMmffhfuZsNWm/Xq4LZGn1/j4Tq8xC77xrTviDBf/
 Wuu6l7tbsN0PdkHxjPneatGnqdXbMkO++lFd7IJ/ambZdYk7Ep/Sf/5ow/xEVMA+N+/g
 /uyys9OHLZ8U8II6GzQuyfCm5Q6qKqE/gmLsnGxNWMx6lXer3gS+tVdSH+bcI/qHqZFL
 InWNV00xUh7VnhFMGF+lT0BOmj3l4QHamLHJet9LhJDiEj0DnSLqHK1yJcTOrPZqZnMM
 BqVF6OjGRtozi+dUSrrrdONJNC71JyM2MTG8Gj2YmcZaYgYR7kCpZKC8InvIKGbS4AqC
 utIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736213400; x=1736818200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yg9EHk7cpi3rd32/TS8MrtNRhiJquplT3DHcLd9fKSI=;
 b=QH+7LgtJjqCGlvUZvpj3lxifj+Ln85FDNwJtJ8XR/8I9MpE+MUC8q6+bCKifm4ieUX
 Iqn+9yDh1C+8vGVSyGM1tB1DxKCDSQhShxLG540JEi27bpC4CkV102lFtlbMT79z9zKn
 LGbWIqb3br1J0bsbOxDVEH+eTAwKIlnRYWCU6wWLMv/kilrPk0L0KdF+8iSGcrYfjKDn
 wiSikuQ9oWbcxZvVVPegRU+th47hlu7ogk121ffZXianIKrPgldoCMxdyyel85t48zh8
 RDhJFUUbPZdg5dgG0dWabeB6Txi4mfezHJGUZFtibkntdQwgAIqvHLyM/AT6m3vJ/yjJ
 lBnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu3xM4t1x9LLQlcuQqaNthfAAulSXrfS013FIUIpylKy6wPGQ7SBzjjVIp9KAwibWA9daKEgHYg2Fp@nongnu.org
X-Gm-Message-State: AOJu0Yyrc4xFb85mGoEQjW+aW3k/StsZ+0jUMA1T6EjBILgAu+weWStz
 GSrS+fpqjM4Cxjf1ClfmytmO4kP3vH5AJ86GWlU8SspS7adQIskc80C8HLaKnQybkg39AarpjuE
 LYgcS7AYpjTEsaSBvoCvvH3UZzwI=
X-Gm-Gg: ASbGncsHMTC+z6zZpUHyWjvXMFbB9TJHOO8Aa4J1JX5YDXmT74udD4CdJGhk9dtuHB6
 +yvcBrStYc/IcWnobWHm5pkEst45JXPzZxzmOb30=
X-Google-Smtp-Source: AGHT+IEIlAwR5InzARMAS/SWtR53qfbsCQawEKFqs72yCMDLYKEHe76rMdMLkuFZXa/SecMDLsc6Xx1F/4tJSms2dd4=
X-Received: by 2002:a05:6102:2ac6:b0:4b0:2542:d2d1 with SMTP id
 ada2fe7eead31-4b2cc378ae3mr50502973137.11.1736213400551; Mon, 06 Jan 2025
 17:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20241203094702.124748-1-abologna@redhat.com>
 <CABJz62PDz_LJdji-NC7LdmonjshG4w+OqGJPzkuStECzMcYSBg@mail.gmail.com>
 <CAKmqyKMkN7z51MoAeOK-buDZjKeEV7AjzviyVcZ_AyMEJPgg0w@mail.gmail.com>
 <CAFEAcA97_XJNs=oZP2OUTsGdaEU0YD9_PFzucQO214+Vmo1mmQ@mail.gmail.com>
 <Z3vFRrkjIEa-LaqU@redhat.com>
 <CABJz62Myvg==rTWpjHhB9MWufZ_AMoMJv6Jtmf4i3isQt=sV1w@mail.gmail.com>
In-Reply-To: <CABJz62Myvg==rTWpjHhB9MWufZ_AMoMJv6Jtmf4i3isQt=sV1w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jan 2025 11:29:34 +1000
X-Gm-Features: AbW1kvYD-mvUUsILG1NnexFtXKwM1VnMxeL6O4kHA99hiykbXuG32DubZ2aBFfc
Message-ID: <CAKmqyKMxB+tx0A-66oe4shROCg4VxfOidiz10Nu174NekZYdOg@mail.gmail.com>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,
 64} part of the same family
To: Andrea Bolognani <abologna@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Tue, Jan 7, 2025 at 3:54=E2=80=AFAM Andrea Bolognani <abologna@redhat.co=
m> wrote:
>
> On Mon, Jan 06, 2025 at 11:57:58AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jan 06, 2025 at 11:47:00AM +0000, Peter Maydell wrote:
> > > On Mon, 6 Jan 2025 at 01:29, Alistair Francis <alistair23@gmail.com> =
wrote:
> > > > We didn't get an answer to the issue of a CPU supporting RV32 and y=
et
> > > > the kernel still calls QEMU.
> > > >
> > > > I understand this allows things to work out of the box, but seems l=
ike
> > > > a disservice to any hardware that does support RV32
> > >
> > > There's the same thing on Arm too -- we don't set up qemu-user
> > > aarch32 binfmt-misc on an aarch64 system because the host might
> > > be able to natively execute the aarch32 binary. This is becoming
> > > less true, but we still don't want to silently downgrade
> > > native execution to emulation on the hosts where native execution
> > > used to work.
> >
> > Arm is a bigger problem as historically there genuinely was a
> > non-trivial set of CPUs with 32-on-64 support in HW.
> >
> > IIUC, the riscv situation is much less likely to be a real problem
>
> Exactly.
>
> My understanding is that, while 64-bit RISC-V CPUs that can natively
> run 32-bit applications are theoretically possible, no such CPU
> actually exists right now.

I do think T-HEAD are working on CPUs that do that though

>
> Even if it did exist, distros would have to set up things to support
> this scenario, which they don't.

Fair point

>
> So in the current situation we're effectively making it impossible to
> run riscv32 binaries on riscv64 for the benefit of a hypotetical
> scenario.

My worry is that in the future there is hardware that can do this and
we are stuck with this decision.

It does seem unlikely that lots of hardware will start supporting RV32

>
> > As a immediate bandaid, I'd suggest that qemu-binfmt-conf.sh could keep
> > its current logic as the default, and have a switch "--32-on-64" [1] to
> > tell it to generate the binfmt for 32-bit arch, even if 64-bit arch
> > could have 32-bit support.
> >
> > Distros/users could then choose whether to pass --32-on-64 when statica=
lly
> > generating the binfmt files.
>
> While I'm still convinced that this patch could be safely applied
> as-is, I'd be happy to go with your proposed approach if doing so
> would help move things forward.

That might be the best step, that way we allow distros to decide

Alistair

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>

