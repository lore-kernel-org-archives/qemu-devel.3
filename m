Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA48CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSwE-0002Iy-Ij; Mon, 25 Aug 2025 04:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqSwB-0002IN-Nm
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:52:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uqSw4-0003lh-Ap
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:52:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61c325a4d18so2972497a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756111931; x=1756716731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DEWMotYYmuQk801sO2UKS+L2PAlvCSgTfbE6N8UY/I=;
 b=qMN/oggZ5Cbx2/Wc5C3kfNm1rlZKfHxFXdBK83GKGTIs/Ib8N06nH2KR0lLF1SHIzr
 L8OZl66rE29O/toxdxqR5hIIbgyOplcCcr10fDm3Cn8VSUlVi0MImK5iMx2S/dU4GCg9
 7YtxtRCOHV+n7sVo4wL7o9o32gFgOt6MVw5fDb0UUl9SS/u2zAbOJ6UFYM3Z62ryKXN2
 YtUodiK0GFZXxd6wBpB0wpDAiBiMxPbWqlZzJYOQq8MV7qWPupJtHYWKuWzRKLt3PstT
 rc0Uh4Eh1rE6ehbct36JohioZrfFv8UdrQQ9/z084rwXFgi0kbLsvQObA5bv06o1SdAC
 xEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756111931; x=1756716731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DEWMotYYmuQk801sO2UKS+L2PAlvCSgTfbE6N8UY/I=;
 b=kJU6GwYnSqIYVftHNeew6Xy4/MM26zZVDTm96/+/1kmeUfa72V+zWODGRe9cxhTxth
 0zwi/LthY35AwXUA83xhHonmXQZQw+JdaXjdU3nKbqBcFsNgyryV1KeVgx6nshhu3mWH
 +Ei7lna+5J5RpjoOdt9hBWbbIAQVxWjK5ox86fJ+J8Le/bzu6qfIcehZsvrtMMLpY38F
 Gs69+rCiH77gfxROXoKKqpZTc9NqcsbtEnUJ7aEJb4krDn4pvB+6NMcWNR4XyRpQkYWD
 N4heb9YxhRMefQH44BkVb3A+9a7/Z3AQ3Gn5hW5siqTQS5Y4p7zkHaifcrW6toh2jJeW
 OtdQ==
X-Gm-Message-State: AOJu0Yzea0dEUzWXxQsVmv+Q8RJvsym2G2jr4MHm5jWgTfnkWiL1L/Mw
 UmHUZcgjX2XRvgwjxyvvrs0lKYU4QcTJxf6ANU7EnwIir6p/VZgHTmTKO11684T5SsFTilyoZRC
 gFmgDmCw13fK9wvMzE33FT+LhiUab0p6GPMEQuyv3aA==
X-Gm-Gg: ASbGncvDOp+lOZiUhbSUys/QozUrYbRY49QD/+4SWja6ncqR+9zHNvPl3EjPLicuvpr
 Gz/jVM7Aje1ouMSPm8yZP/ouqRZl8JJyaHKq90szQkLK5kz3Afydud/wklG60LW12jMrmXhNyrV
 VJ1sdqjytiybeMwfiCUBE42GdMR7MJA+//aAx1YnDINK93KnHekyRCmJM/juu27YdZ55QJQWT7L
 PqG+2mQ
X-Google-Smtp-Source: AGHT+IHSzAVXFemsQm2A7rR+pA9FGZDc6P8bqRtujRHksdKLDbUm7kCDNf4yD8OE7GA9Cf5DCf4UqSMjMCqRZIXgtJk=
X-Received: by 2002:a05:6402:848:b0:618:1e1:c204 with SMTP id
 4fb4d7f45d1cf-61c1b3ec069mr8505022a12.12.1756111930440; Mon, 25 Aug 2025
 01:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250821094735.804210-1-thuth@redhat.com>
 <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
 <b60a9e7e-6f79-442d-8a4c-2acfbbf0688b@redhat.com>
In-Reply-To: <b60a9e7e-6f79-442d-8a4c-2acfbbf0688b@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 25 Aug 2025 11:51:44 +0300
X-Gm-Features: Ac12FXxxf8IR7QeqTL_RrYBPeQVGH8wk-k9CEGC-Xf_-wFUZSMRyv3l4FqWRkbw
Message-ID: <CAAjaMXY1fcTZ517dmrd+nAt4WUEcR3U2bbmM3ZytDkXREEX6TA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Use more fine-grained locking when
 looking for free ports
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, Aug 25, 2025 at 11:47=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 25/08/2025 09.30, Manos Pitsidianakis wrote:
> > On Thu, Aug 21, 2025 at 12:49=E2=80=AFPM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> Currently, we have one lock that is held while a test is looking for
> >> free ports. However, we are also using different ranges for looking
> >> for free ports nowadays (PORTS_START is based on the PID of the proces=
s),
> >> so instead of using only one lock, we should rather use a lock per
> >> range instead. This should help to allow running more tests in paralle=
l.
> >>
> >> While we're at it, also create the lock files without executable bit
> >> (mode is 0o777 by default).
> >>
> >
> > (Unrelated to this patch but the file itself)
> >
> > Hm. AF_INET supports binding to port 0 to connect to any available
> > port (see man 7 ip). Is this not portable?
>
> No clue ... but in that case, we'd need to go back to only use one lock f=
or
> all tests that are running in parallel, so it might cause some more conte=
ntion?

IIUC there would be no need for locking, since the kernel would return
a free port for each process.

I can submit a patch btw, but thought I could ask first.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

