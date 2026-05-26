Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1090FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRreh-00033X-HQ; Tue, 26 May 2026 09:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRreW-00032m-Pu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:17:02 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRreU-00031K-PK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:17:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso13085505a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801415; cv=none;
 d=google.com; s=arc-20240605;
 b=PtPVcN70a4fhVaQrLfZMvIXIoQ/eTMqncsLeKdzWbf4bfcTeCjuk+WP/tLBbxyqN6B
 Ji3vnxNZUuBf8oRKgPy3ej0aUtH/ST1buWoJgGWLhon4fv0rA1uLo4iPOMrrDR5Ks5jK
 HmXDM83e2MoKsLhb998ft4exHA3Xhk78yh3cuGd4t/N2W96RuF3gMuOG9E4mV+ceeZmo
 EyfYPxlr5Ge/yjex2yKwuBsK7GZL25SsNcX92nwJnrc3H3T4PyllAXPUog0OwZuDU38X
 rEX417faRR83naSl97ZEc3QSaDlFMDiZ7mG7yueqvMuVcebofVAB7mtlklP3a3hNxzoQ
 T0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E2kJo/KHyODckPncaHJT1f9N6WdfpHq1W/Soz1Ov6K8=;
 fh=dYKKz+mO9UOlH2bf61vXt9zRZgdMqGWZQNYQftMPock=;
 b=ezcOWOh6wo9Je6CeMxr0dk8MTfwfZ0RtQGCb6JxoQb7wdxjxqx7cBQmXJjRK7qpaag
 57kJ/gL5dh38WuLFU8vmbhJdLk5WmVIeuzCaVX//7+MLe/7QKLmLChHwzpf1nCDgEW8U
 nYbNA8xzLC0+xd9otwPnCC+GylPzcuY/iR39EjMk+8gvgicWP+uIVzayC4puC/WSx8V/
 rwcPuEwuqbBlOHYwAda2dXI/+MGcBATdB/Umjd9OittsG9d7srdF6HAtgF90C8igLaqd
 w9xVvqVCZH6qy/SxUwaEsvNCG61H3SUkgfh9lr4BuzqQUd5IpU0qbrbiqHRA5pJ6nLsD
 XeMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779801415; x=1780406215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2kJo/KHyODckPncaHJT1f9N6WdfpHq1W/Soz1Ov6K8=;
 b=eJEnf/iqtSKQDSnXp9K7ocqkBMCsbSxRG1frGPachgQYb8MV0K8UxwCIpf9Inoc4YM
 539wce7tZES3TliXyjOALcq9wtF5ucwzeHByuyl82QyBzoDDXmixlr4VhRYlcQDSKRVa
 XhKzTl3YmfTBqDyobmlC3EHW4fLjct74XV3oTcPYcY1IBxEL0kebJ19PtsbJxkSKaIi2
 Ax5WLK7sQnU0g3/hJqkXiU2aTVeYaMohCR68BDUqGn2gM9S4LSC0jltJJhIwxnTBSrPz
 xYOZ7XW0dlsatrqp847fNnUGcwF0eHM2xpz6IXyE7P8LySuwJIwFfZg7ggfpc/8+bGWc
 n2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801415; x=1780406215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2kJo/KHyODckPncaHJT1f9N6WdfpHq1W/Soz1Ov6K8=;
 b=Z7xwBtVJg7DpRq3jHR2RszaOMI5BY/FQsjxiLetTT/JCaVeaIGxGFycv53Q0MtWTER
 4Wku2SN2VjRSIXhXt0FUtF8ObC7K0Q3Cr07KzhonJjrjn03pfjeuZKnkZFk/Y2hCZQ0b
 Y8s2kWueVFgEUKlXRn2P63aZV0qUg2KWc/LtEqVsDytmFyrq+oDtkCOjbExk398QxLvd
 WkOMo8JVWcYJd7b9TcCoYXFl1WSzuegSO65R0OXtdptWXUA3D3IxxdcMNswxDTwHTcC3
 1fGVsj6L9VAb61N89wcHSI1eSCMxdgVH1Z9M/OiebkVgJx2nDrAB1AuSmF8qvg/7QlBq
 Bc7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ907aTFt0wb32pwYGLe4qd+iWkhLpbp9tR1Q97uGqrS65uuB9CauK6JgkCA2J6lTFiboPcyqnIcUny7@nongnu.org
X-Gm-Message-State: AOJu0Yw6FFt3OGNwj7RoWmwxErB3I3F25jsNcqo6zuThxIxPe1ERcJFZ
 ulv8W6lj0as+uE5zCymhkFd3Rf08cPou/mCMU8yXBUl18I6LphdKSdbH6WxGYCO/eDlhXnANC9g
 X1m96h5M1tfMqxd6xjy0fy3gQuftfbFefCUis
X-Gm-Gg: Acq92OGVEN0FF0YSwUqe70bkZMpgOb9pRKj1TqbSnd6V5jQJ17PatAogmCe1JXQuMIq
 xQqZX+7KPuWoAAxDbu1Yl9VJmCJ5Na4EFpJaTmXpjP3SIpmqav3R4UtQG17O1GDnqXZx7J/NFNH
 3e8HKZ1AtD4wYTLj4DLZNmTd0e3g4XLuzoyLDHXS9l6xeT/ZaKN82NpM+8xJ9qOwm2uacmhx76o
 h9BZrR9prl2HpJCguhINoPWjTsx7GX0pa2qQlrsFC3fJIiWHbJ4g2bAJFHpQ3ulyAPjD8jn5clk
 TO2cZ9td73iHxuCfLOHFxog5fBVzJiX0SED+zAqVzg==
X-Received: by 2002:a05:6402:3805:b0:684:95a:4d05 with SMTP id
 4fb4d7f45d1cf-6889c42bf53mr9044501a12.8.1779801413094; Tue, 26 May 2026
 06:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
 <CAJSP0QUmh4RLFUg9-5Uky36Tjhr_cLkrE2VAC8K_MdSY9p0WZw@mail.gmail.com>
 <20260525183441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260525183441-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 May 2026 09:16:40 -0400
X-Gm-Features: AVHnY4Lw0E72hpa4IJPEh8F5WTklUtgeqtxKYyXk-WOJzGYpeMupOr11GWOeWgM
Message-ID: <CAJSP0QU9SwLG+REPJz6vrWgCuh+BZ32N2+jVXUr_=di7k_h=9w@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 25, 2026 at 6:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> On Mon, May 25, 2026 at 03:44:02PM -0400, Stefan Hajnoczi wrote:
> > On Mon, May 25, 2026 at 1:17=E2=80=AFPM Warner Losh <imp@bsdimp.com> wr=
ote:
> > > On Mon, May 25, 2026 at 10:34=E2=80=AFAM Paolo Bonzini <pbonzini@redh=
at.com> wrote:
> > >> On 5/24/26 14:42, Michael S. Tsirkin wrote:
> > >> >       How contributors could comply with DCO terms (b) or (c) for =
the output of AI
> > >> >       content generators commonly available today is unclear.  The=
 QEMU project is
> > >> >       not willing or able to accept the legal risks of non-complia=
nce.
> > >> >
> > >> > But, since this was written, Red Hat's Richard Fontana and Chris W=
right
> > >> > published this piece:
> > >> > https://www.redhat.com/en/blog/ai-assisted-development-and-open-so=
urce-navigating-legal-issues
> > >> >
> > >> > Saying, in particular
> > >> >       We understand this concern, but the DCO has never
> > >> >       been interpreted to require that every line of a contributio=
n must be
> > >> >       the personal creative expression of the contributor or anoth=
er human
> > >> >       developer.
> > >> This is not the objection or the worry; rather the question is, what=
 if
> > >> the contribution is a creative expression of someone that could clai=
m
> > >> copyright in it.  In fact, looking at the Linux policy...
> > >>
> > >>    Signed-off-by and Developer Certificate of Origin
> > >>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >>
> > >>    AI agents MUST NOT add Signed-off-by tags. Only humans can legall=
y
> > >>    certify the Developer Certificate of Origin (DCO). The human subm=
itter
> > >>    is responsible for:
> > >>
> > >>    * Reviewing all AI-generated code
> > >>    * Ensuring compliance with licensing requirements
> > >>    * Adding their own Signed-off-by tag to certify the DCO
> > >>    * Taking full responsibility for the contribution
> > >>
> > >> ... the question is how humans can actually do the second step.  The
> > >> piece you posted above says: "with disclosure and human attentivenes=
s =E2=80=93
> > >> and oversight =E2=80=93 aided where possible by tools that check for=
 code
> > >> similarity, AI-assisted contributions can be entirely compatible wit=
h
> > >> the spirit of the DCO".
> > >
> > >
> > > The code produced by AI agents has no copyright. You can incorporate
> > > public domain code into your work and have the absolute right to lice=
nse
> > > it (see all the Diseny movies). The notion that LLMs wholesale copy o=
riginates
> > > from the earliest days of Copilot and turned out were contrived. No r=
ecent
> > > evidence shows that plagiarism is a concern. To the extent that I mod=
ify
> > > public domain code, I have a copyright that I can choose to license
> > > however I want (and the SOB says it's compatible).
> >
> > There is an active field of research on memorization and the status is
> > that LLMs do memorize. A paper from 2026
> > (https://arxiv.org/pdf/2601.02671) shows that production models can
> > output significant chunks of Harry Potter, although the research
> > deliberately extracts training inputs rather than doing so
> > accidentally. I am sharing this because I don't think it's correct to
> > say that concerns about models outputting copyrighted code are
> > outdated.
>
> But the concern is with them doing it *accidentally*.
> Because willful infringement was always possible.
> And that does not seem to be happening.

I agree. The chance of accidental copyright violations is too small to
ban AI usage in my opinion...

> > I do think that the risk for coding use cases is low as long as LLMs
> > are used sensibly. If not, legal cases would have popped up by now.
> >
> > The example of ext4 for OpenBSD (https://lwn.net/Articles/1064541/)
> > comes to mind as a case where LLMs were used in a risky way and
> > maintainers decided to reject the code. Even though the output of AI
> > has no copyright, when there is no suitably-licensed information to
> > generate the code from, then it is risky to assume AI generated code
> > is free from copyright, license, patent, etc effects.

...but here is a realistic example of where it might make sense to
reject an AI-generated contribution.

My point is that maintainers still need to consider whether
contributions are risky and in some cases it's easier to do something
reckless with AI because it may not feel like you are exposing
yourself to licensing issues when the AI generates the code for you.

Stefan

