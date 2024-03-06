Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B4EC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 03:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhi33-0005NT-Al; Tue, 05 Mar 2024 22:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhi30-0005L6-VP; Tue, 05 Mar 2024 22:34:26 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhi2z-0007Oy-09; Tue, 05 Mar 2024 22:34:26 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7dadba3284cso2904827241.2; 
 Tue, 05 Mar 2024 19:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709696063; x=1710300863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tD80fAjaEDOBxbAuD5YES+SQm1yY9CWiZVdAsdaSr2A=;
 b=bdZVE6G0p6g/SjAIb7gKq/K8Mfg3SrZra/vpztbzk9gzS/h5VsiylyxckISb37YNTw
 4JwnfuzTIGNeaUNHMJ8qbekjwEuaAuuyWUNV5CdGclkaNWg1gEaqhXNdzCoLX4KzfKv8
 Ti9z4ik1bgS4Tv7Bq2fnntpm/quJiArVmvEW4POfK9my2V8s8tqfr1LsrILLrV61qYD5
 6Nab404okP7qFpVbwzacDyYPDzn5fxEi7Yk05hM4FVXJVBTgkHNDc1Cpc3lPWo4NVkHB
 YIyScezjujqJf8IXLzxeI/uXvs7T64oRKLx3trLuFreo9wbSBbsOwsyGCCefSNjt6cEZ
 PbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709696063; x=1710300863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tD80fAjaEDOBxbAuD5YES+SQm1yY9CWiZVdAsdaSr2A=;
 b=qgRwvEvXDN+XJpX3caS2+0du3FlIpB6VCtC4Iu3Orh+Budp8Augq5CBXTwYe9bQutA
 2oQCzgc3+P0VzZ6/mC6OpOXnYUSUtLlQbmutZnOGASp4Kt23PCio7RUaz1Fsxx29J2lL
 xtFkpgXdTSeVXaTdIhLxfyAw6mRUu2eFTcC/Ix3EhMKCB1FB7om7cPNfqo2ZzykdHV2j
 fOEW50Oi2xzsELpnVRBTVuzI/SIkqh45JYtNUd4c9FN/z9xVwKMeTUEpEVM59hmNCvNc
 6vzL98WXU26F3ofYi3Q2VHYpQDONhX7zt5xMs7J++F4pdN3QABB36hKnkO3AydwYZFg7
 MxwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSqBIf9Ue4vsUU4tmdCNbke3D6EhWFLKy/6i/as5akyZRTzHe5rjrkZmoR9zw7mgij8umdT09jVO7RwEZXPu51JRvoL6jFEuIKSctfeF3H/cxrscE6pQGqgBPuXw==
X-Gm-Message-State: AOJu0YxqwaQOEpmPK+w+sY9+iPNTV4N2z/KVgt+VG7Zyb6EFPQZz/hgm
 O7xknP2trOCQF5Y6X6OWGGuKrBhc5CUI90X05pwwne9wo8gnbx4BuTvdGOEHemmN3qYWfnbs2jM
 J7xaE5j8QUAXWawc19WWZl9G7C08=
X-Google-Smtp-Source: AGHT+IGGkr4GdWmmUxO5qub5kR8M2nFLZKeObq79bwG3tgS/nRN3Rf5DhCDHCnC7BFyACDU3MkcyPOCskTwXpzH84XE=
X-Received: by 2002:a67:f408:0:b0:471:b9ab:7bad with SMTP id
 p8-20020a67f408000000b00471b9ab7badmr3249456vsn.29.1709696063495; Tue, 05 Mar
 2024 19:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20240229133745.771154-1-hchauhan@ventanamicro.com>
 <20240229-92706c0ccb3d6a6e8b725815@orel>
 <CAAhSdy1SrsU4x1V5OPRzBKmfC02qHrC09QM66WK4nUqDpONGgw@mail.gmail.com>
In-Reply-To: <CAAhSdy1SrsU4x1V5OPRzBKmfC02qHrC09QM66WK4nUqDpONGgw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 13:33:57 +1000
Message-ID: <CAKmqyKMNKb0cUYdPYEhLzR7mf2d9h5B1Fv74u3jRCvWhLLokjA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Export debug triggers as an extension
To: Anup Patel <anup@brainfault.org>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 1, 2024 at 2:20=E2=80=AFAM Anup Patel <anup@brainfault.org> wro=
te:
>
> On Thu, Feb 29, 2024 at 8:42=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 07:07:43PM +0530, Himanshu Chauhan wrote:
> > > All the CPUs may or may not implement the debug triggers (sdtrig)
> > > extension. The presence of it should be dynamically detectable.
> > > This patch exports the debug triggers as an extension which
> > > can be turned on or off by sdtrig=3D<true/false> option. It is
> > > turned on by default.
> > >
> > > "sdtrig" is concatenated to ISA string when it is enabled.
> > > Like so:
> > >     rv64imafdch_zicbom_*_sdtrig_*_sstc_svadu
> > >
> > > Changes from v1:
> > >    - Replaced the debug property with ext_sdtrig
> > >    - Marked it experimenatal by naming it x-sdtrig
> > >    - x-sdtrig is added to ISA string
> > >    - Reversed the patch order
> > >
> > > Changes from v2:
> > >    - Mark debug property as deprecated and replace internally with sd=
trig extension
> >
> > I'm getting lost in our discussions, but I thought we needed both in ca=
se
> > a machine only implements debug 0.13, since sdtrig is at least 'more th=
an'
> > debug, even if backwards compatible (which I also wasn't sure was the
> > case). If, OTOH, QEMU's debug implementation exactly implements sdtrig'=
s
> > specification, then I'm in favor of deprecating the 'debug' extension.
>
> The QEMU's debug implementation aligns more with Sdtrig v1.0 specificatio=
n
> because we have mcontrol6 which was not present in debug 0.13

I'm not sure that's exactly the case. I think QEMU implements the
debug 0.13 specification and also the mcontrol6. That's really a bug
that we support mcontrol6, it snuck in.

We can just support both and wrap the mcontrol6 section behind a
sdtrig check. That seems to be the easiest option. That way we can
support the current ratified debug spec and the experimental soon to
be ratified sdtrig and friends spec.

Alistair

>
> IMO, we should definitely depricate debug 0.13
>
> Regards,
> Anup
>
> >
> > Thanks,
> > drew
> >
> >
> > >    - setting/unsetting debug property shows warning and sets/unsets e=
xt_sdtrig
> > >    - sdtrig is added to ISA string as RISC-V debug specification is f=
rozen
> > >
> > > Himanshu Chauhan (2):
> > >   target/riscv: Mark debug property as deprecated
> > >   target/riscv: Export sdtrig in ISA string
> > >
> > >  target/riscv/cpu.c        | 38 +++++++++++++++++++++++++++++++++++--=
-
> > >  target/riscv/cpu_cfg.h    |  2 +-
> > >  target/riscv/cpu_helper.c |  2 +-
> > >  target/riscv/csr.c        |  2 +-
> > >  target/riscv/machine.c    |  2 +-
> > >  5 files changed, 39 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > >
> >
>

