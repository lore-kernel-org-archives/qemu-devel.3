Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BFAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGoEp-0001OM-6V; Sun, 18 May 2025 20:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoEn-0001Nm-Md; Sun, 18 May 2025 20:20:13 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoEm-00080G-7q; Sun, 18 May 2025 20:20:13 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4dfa0f38fcdso1282108137.3; 
 Sun, 18 May 2025 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747614009; x=1748218809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vAy0hIWb4ZH8MSEhStHpo6dwYutcN6I7/pyOHklXGI=;
 b=hkmn6vQIgt3tnhXO48iR5mq0No8L/wcML7txgXAZW4UeQeWWAFyTk6ZioPgAacXDAA
 8mzu9LjLXikf7MHiGC39iwQp6DGHr1Dr2HtoNftiTafgInxKKd/cmVl1P7cPc9fcgSat
 zB5W7ItWQPl+q4eMgndAxrX/GORqqf/6rUXAHcssZ4j8GUnRmDwnUGINkiRCscT1Cpr2
 XqT7yM9FMzPMeNJHbW3nNEjPtAO8Sgct4jWn+Lp89KylVk8374lUw9CQbY06YJi74wT3
 63YvLZVY3z6r7rnXZEqk1epCGpqRO7can2jYr0xbMd35P6aXZ4lNGGXFNgPD1/yLKuhE
 cOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747614009; x=1748218809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vAy0hIWb4ZH8MSEhStHpo6dwYutcN6I7/pyOHklXGI=;
 b=rxQuN2VBThH7ypHTHWMVDaLsJfvzkiFTAmZ2VLAC+f0R1XaeP3+0oYRL5iGSDVG1Fk
 PodEVBJvpOO9Do7JzHbVjMju3s1r+TCQAikjoFgZZC+fpBhVrzDtB5uM6z07r6DFLqP3
 pM9x7vKg2OIRepao4RSg4khhJW8HMw6+V6HtbtRqNSXbHYSBNFwy+0zeg8A9lwSFsf8M
 c8Ru6H9VRRUIRsI/HCfek2MAI/SBga/i0a2gnyrxz/fJXQwS6R5xVWuibjAtn9WUNjwa
 lmJ5+tx/KXD3coZU1x1QZxrmpodP2joDFNW8SxLRCdVFfU+24dycTgMbmG4SC/hEihgs
 Qr8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2WAt0leQILK3gmV/PA8VGPZAfKE6bT8vQP7ZexYErNI2IGSxOlV3f6g/1kShQYMfvoKGBWUk5Yhxv@nongnu.org
X-Gm-Message-State: AOJu0YzpQHbHl+Y7Obo8uMzRf2tDwRQPfxIAGsLhWuzqa3eSe6PiaA92
 AR9rDcoLBipeedAWYaeSy6zMkeNtwC8+The2Uft4fMBCVriJDWrDk7dlmSfOLhUMJg36rXpxarG
 LAzZDZfewzeZKZ3RQUbPhSrSb6RN8qdE=
X-Gm-Gg: ASbGncv7jE5nJMm4wY0u+wKczJQ/7jJFOFQdL8aKTMs/AO8UpZwokmSlIJsNHZ8n9zz
 VhAOTWmttd2vnR+aplPn+zNX5uPGtzwpoVsAV55wDCDncEHyKodqJpx/iJ7aHGiz+BWb+dFKEM+
 38q5h09uwP7N7YIl5q1TjZ20cAlB75xcHt/ULdTTVqwM08/inAND2+ZfGGSzWHZuo=
X-Google-Smtp-Source: AGHT+IFcuyCaywi/QoCQHHVwtsaofgUnBbCRTCtHU5pSZRc/vzsGdQR23lWzV0LuEP7v+9AYE41PTkST+URiy0qVthc=
X-Received: by 2002:a05:6102:54a2:b0:4dd:b75f:2e82 with SMTP id
 ada2fe7eead31-4e049ea35b3mr8700770137.15.1747614009632; Sun, 18 May 2025
 17:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <c969d9ce-626a-4928-b050-7b7fbd8f7981@ventanamicro.com>
In-Reply-To: <c969d9ce-626a-4928-b050-7b7fbd8f7981@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:19:43 +1000
X-Gm-Features: AX0GCFtIgL5mQkvemgEFu3NV10M9QEyi9ydvGbSpiB_hJkbOSuK0PYQdvYOB1Do
Message-ID: <CAKmqyKPXoA3Lwq+zxP=v=YutxXXWyMz2rk6LDiW2_bMyhRmgfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv/virt.c: change default CPU to 'max'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Tue, May 6, 2025 at 8:47=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi Alistair,
>
>
> I think we should push this upstream and see what happens. We'll have a
> full release cycle to undo the change in case we find unintended side
> effects. I'm fairly optimistic that this change will be a no-op for most
> users and will benefit us when we'll have to deal with RVA23 specific
> software.

I worry it will cause us grief in the future. I think if we are
changing it we should just drop any default.

With profiles now becoming popular it's easy for users to just pick a
profile CPU when starting the machine.

Alistair

>
>
> Thanks,
>
> Daniel
>
> On 4/4/25 12:27 PM, Daniel Henrique Barboza wrote:
> > Hi,
> >
> > The 'rv64' CPU, the default CPU for the 'virt' machine, is a strange
> > CPU. It is a collection of extensions that were enabled/disabled as
> > extensions were being added in TCG, and in the end we ended up with a
> > CPU that we can't say exactly what it does.
> >
> > This is further aggravated by the distros move to support the RVA23
> > profile. Patch 2 has more details, but long story short: distros uses
> > the 'virt' machine, and they'll start building on top of RVA23, and rv6=
4
> > does not have RVA23 support. In short, distros will start to break in
> > the default 'virt' CPU.
> >
> > Changing the default CPU to 'max' will not cause (intentional) user
> > regressions: if the software runs in rv64 it will run in 'max' too give=
n
> > that we're adding more extensions as default instead of removing them.
> > In my opinion this might be enough to avoid a deprecation cycle and we
> > can do the change for 10.1.
> >
> > And yeah, patch 2 mentions the already old trope "and ARM does the
> > same". This is intentional: I want RISC-V code and usability to be as
> > close as possible to ARM and other archs to promote a more homogeneous
> > experience when developing and using QEMU.
> >
> >
> > Daniel Henrique Barboza (2):
> >    target/riscv/tcg: make 'max' cpu rva23s64 compliant
> >    hw/riscv/virt.c: change default CPU to 'max'
> >
> >   hw/riscv/virt.c            | 2 +-
> >   target/riscv/tcg/tcg-cpu.c | 2 ++
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >
>
>

