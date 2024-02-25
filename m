Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E5C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 23:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reONu-0005Kw-T6; Sun, 25 Feb 2024 18:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reONr-0005JV-Mf
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 18:58:15 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reONp-0007KJ-LP
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 18:58:15 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d995bd557eso1444012241.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 15:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905492; x=1709510292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIC4DEYS5hzEzEbT+pav2kqR0ycPfRxsDtV0JUzEUfY=;
 b=HirvhBqLVvm3O9/AGKAa688Hyr0rv06ioRCFUDu0U6dzWOllQGCLIcHfbiZ0SPaYFo
 dFtCe/qrypD99diYf3AzXpZYQjLz/MH8mCnA1k1SGOac+xTvtETAyXfDyYP2ZES9WF/p
 9dweQoO3YVVPJK2t39qv+Vn5nIoAdyJAi3s6VvxC0qctvSQqebTQN6Rkss+UrRj5N4Ra
 l/+/gYJ3b7tTLByXOV+k6LcwbjiVKSF7Ugnl4dE7XPnOIJj2AoKTbjcvmCQf24n++snc
 NlJ8kz3PDLR1hg6vXqLZoLsaUoAn70cWYkkX+2mDXnqiLCLfJSL+Q9EiZGKVOvuWbbR1
 ogpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905492; x=1709510292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIC4DEYS5hzEzEbT+pav2kqR0ycPfRxsDtV0JUzEUfY=;
 b=kKmop+XbyDFlshuG3Aq5DPzYbIngqL1ADFGIWHBTrwgqodg4YknKbBsFFZtn/fQ+Yi
 Ijxiz1vTtm73d+fWzaT+/f2V1Fveto4Jmh8+nXJvXS1NaJA/epLjtCQ2GedwaGjPcw8X
 WPgClfoqMafIgvNe22Om8EM+HDXOqP00wnUoXtTyhIGL0if59KLD6b+UxGTOPd1CzUOx
 TuoWgq/hPK4D2Ycg4nRwGMkX+fgK7iUairYIm9Mxvlb+zt2pmfQLDAn80y63TnEyDe+m
 CrQc4o8GqGtLlECRevR7wXq68HsCh2rg5wd+SI1RQGgpxZUU8vxdEvErB3FMCCsBQO2h
 eN1w==
X-Gm-Message-State: AOJu0YxYNokpG+DXg7MpvZjhicvjrTs3fYgdD0hVrRrEWS5t27eYtrTU
 uQdpKoibBrEnYhWZiQwu0X7FFmxn2l+EkcXJzEp3ZnzxLtx5KygwQed7uPWFZgiWPjRoalUFJt/
 yI6nbQAXAoob8fpDg3EcCNb0tfUjkLLU6cqk=
X-Google-Smtp-Source: AGHT+IElTkgNFwSl3zJkYwphykcJSb4FpPIM96iMFTtlBXXVraWwL3O1kkYzi+u/SN650W2VfMpdZ2KggAAJdEBZmDQ=
X-Received: by 2002:a05:6102:6cb:b0:471:e3bc:a499 with SMTP id
 m11-20020a05610206cb00b00471e3bca499mr2243345vsg.9.1708905491792; Sun, 25 Feb
 2024 15:58:11 -0800 (PST)
MIME-Version: 1.0
References: <03553894ee4f79b3f63979a9e9ac87e635c75933.camel@blues-softwares.net>
In-Reply-To: <03553894ee4f79b3f63979a9e9ac87e635c75933.camel@blues-softwares.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 09:57:45 +1000
Message-ID: <CAKmqyKN3zWD7Pb5_u8MiJreRZnZ8J-e1E9m-L6vuZvhq_W9u3w@mail.gmail.com>
Subject: Re: support on risc-v 128bits
To: =?UTF-8?B?SmVhbi1DaHJpc3RvcGhlIMOJbsOpZQ==?=
 <jean-christophe@blues-softwares.net>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Mon, Feb 26, 2024 at 9:30=E2=80=AFAM Jean-Christophe =C3=89n=C3=A9e
<jean-christophe@blues-softwares.net> wrote:
>
> hi,
> i would like developpe my OS on risc-v 128 bits.
> after search the support isn=C2=B4t fully operational

We have some basic 128-bit support, but it isn't complete. The RISC-V
spec states:

```
The design of the RV128I base ISA is not yet complete, and while much
of the remainder of this specification is expected to apply to RV128,
this version of the document focuses only on RV32 and RV64
```

so the spec isn't finished either. AFAIK there is also no guest
software we can use for testing.

>
> how can i help, and in the same learn risc-v 128 bits

At this point there isn't really too much to do. There is some basic
support, so maybe you could try and port your OS to that? I'm not sure
how you would compile it for 128-bit support though, as I don't think
any compilers support 128-bits.

>
> my coding skill is beginner, but i motivate and i learn spead. i'm
> waiting the complete guide of C to delanoy

QEMU is probably not the best place to start as a beginner. Especially
the TCG side of things. It's complex code that is difficult to
understand.

On top of that, I don't think 128-bit RISC-V is a good place to start.
I don't think there is compiler support, which is going to make things
tricky.

A better bet is just to target 32-bit RISC-V micro-controllers. That
way you can test in QEMU and then think about running on actual
hardware in the future.

>
> can you give me simple task for begin ? peraps document

Your best bet is probably looking at the RISC-V issues on GitLab [1].
See if any of those are easy to fix and then submit patches

1: https://gitlab.com/qemu-project/qemu/-/issues/?sort=3Dcreated_date&state=
=3Dopened&label_name%5B%5D=3Dtarget%3A%20riscv&first_page_size=3D20

Alistair

> best regard,
> jean-christophe
>
> P.S. why your ndd is nongnu.org ?
>

