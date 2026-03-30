Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A85FFF495E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DTF-0004sD-Pt; Mon, 30 Mar 2026 10:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DTA-0004rv-Vo
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:19:58 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DT8-00016Q-C0
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:19:56 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6501e465a8eso2213173d50.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774880393; cv=none;
 d=google.com; s=arc-20240605;
 b=c1FQSWYp/JCkI94GRJiO0ihu1GQN+iUh7NhtwZE1u5fnOEe/7SkAPdyj7SDLp4LVoY
 GwgxQmOQAzNU9FziPZyIXaV/iZFbBVCKpoo7H2NGIw7ZDPJ7oOATFvMb5PwXPmOm+dtr
 1PI7wmvmrRcnH7lvPYf2QvJjn7nPQ/rBTmXOcCSpc1wGkOYpjvEMFSTPh3DSirhcH+0j
 HJfAmqBWHJVlGYOG4KJCUx1hVPiAi67FGiELLeJ+E6Tl/BOSNEqd2dsyTyvURrFXhNsA
 g5Xw7hT3jv4Gd81iBXATAFHoIQv8loyiaZx1UuiRW/rhaK1JPOLuGM0+5bxXDvYSyIgR
 EV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tR5FOJz+5DQHmqc+c6AJWccDv1GR0BrIFths8oMTH6o=;
 fh=Je9naKQ53aBoHQbud5n3Gez/U2h3YW5ODMZfHm9wdH4=;
 b=QtDSnH2ddaPR9eFmfT9iXM3/ygKw4KhyHfW5jQUkBevmTkQHHbxnkrtH8MRIyRb/52
 Xl8T7FHIF+KQ0WBoHzuPRsKAvKrde1FCvtS11DzMJ/j1VsLiNjPQaD68PrUeOYcz+BSV
 2pba6wQvFQAkGbErWkjcFqMzk5XO6xFZsEijcKDTw4k5nc/dkF556XVyVTmnSsa2uhWw
 Rqt5hF+VsNWn0cZmHhhvhIMihuZ/2pRdamSfD8aolizERra367phvrzy2TSTAbzLXf1f
 u7w1uOjzksPuzdS5PMk0cIfLoDo7AeTNe+Cc/e7PwcPnvRpTurir6v8gNL0QRrNsw8Mr
 Ao+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774880393; x=1775485193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tR5FOJz+5DQHmqc+c6AJWccDv1GR0BrIFths8oMTH6o=;
 b=BBoJ+5YbXIxiJG5xh7CVKMB6XI4CQvkYe2OPvaTdls+74GIZ/tA+mwMzGjc4zIQ6Zh
 jyK63UaTbjSesr4pxMvEvvs+xo10h4XYBN1oiLiZbTGa9E2xfsSDQ1zSI68eU0Gpg1U3
 pNso2vWh9I5hqqE6ERefToIjrTxmoubdHNy3ryrmn/n1wX8z6jLKZrigtsinK97jfTQe
 cbWoOZO9YyLZyLjODzsQH3KHLs/pPzr+copTGi7hGHwJKEJz/Ac9X8R62j5G3ZQyCr4R
 ToIhaKTr/Uo7pYcteXBtyox0i3f+YtvcPnbtzHrfQHdABhyOBDEPq1ghFfwdREm1qz/C
 XDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880393; x=1775485193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tR5FOJz+5DQHmqc+c6AJWccDv1GR0BrIFths8oMTH6o=;
 b=NRBcraGJjUkyoBrnaVgYSqZZtE/3bFMz7sox/8LET0BNhLiRSDkJ+QwfJEecz72weH
 FgsncGOj9Cxzr18fpHZI1asGQ+5yfoMAYZy0Ts9IWvpWjjVvvP21r3wCSqN5tZC6lHcC
 PrR3G51CEJIvMN6ChM/GMaYaJTiDaE6eyENh5Had4js4wgRyNiPooYLG4pAZIVhd/Yyq
 dAFbwGlowYlDln9XgfH8d3BDaN5vVyB8rG3gKjAK+JSnHHv8RWDcKT6crwxqOmnROAmk
 W6VpBqoRbLoubEayfpo+kGFwarFuFMkuI7ACWhYyCKq2CYJl75bHGj5Zv8lDjTznLA4D
 ERWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsI2jfplxSVeZUvTRlzMNqlPYQ/OXMQiGl7avJzhDycLo0AHu6rcjxLAdyVLRG5QKSOInH8i0rqGZz@nongnu.org
X-Gm-Message-State: AOJu0YyYI+eqRBl7VdlMDqCCQU5CDobs5mDY+gPjVz2bepqnJr+v9znv
 6auC79O31siKjThK5zi7INSd/SHSMWxo7Y+Ed2/AWCsYthnFI2bX0NssmO2vWWLAfWoVyXX8b5G
 lVVBADBZpFJuikcugxu/4DgjMPTZ9su48zY5O7tJZvu3Ykr4n7cqSwS4=
X-Gm-Gg: ATEYQzw5/teU0SPJsYasGc2hpmO9d0QoDvyn6sN2IwsjaH5AksW1Thc79uMophybCEA
 hWiQ2u4IQCQc5AaLIhtzC/XeN1zjQDg5sMjyR/XDshvMBeQETk2MejxZ6R3ItTC3JzO5osl5JaJ
 gIe406ICtpe3Ttz1C74dzOcNWjMtdTH4TMNdNlV+yXGX1f+XX5+ALlln9caTDZtDF+2N3iBpcVF
 1A/V3bAHO9DtX2nh4obTYnc+zsxFEAhgf2Fl30pKZK+Njg/Nx8Sul+dsARHXm2OsVLvNGUz7toG
 tL1gWDw70cYZjDM2OwGdgSiCIYjUfcPilgkC0K+gV2L0tgBH75KY+XauvVBiyIYA747/GQa8LKG
 asw==
X-Received: by 2002:a05:690e:4388:b0:650:68b:de67 with SMTP id
 956f58d0204a3-650068bdfbbmr5604337d50.32.1774880392886; Mon, 30 Mar 2026
 07:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
 <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
 <acp8VmIN1cwNAxE-@redhat.com>
In-Reply-To: <acp8VmIN1cwNAxE-@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 15:19:40 +0100
X-Gm-Features: AQROBzCMH-S0NhdpCM1c5lsnY2Qp9GM5NIoYfeiVVy8Ri5DqhZAl9OSE7ghyh8w
Message-ID: <CAFEAcA8Rt6VwDksVHjEAWKsYc15JGjry=kozHsx8PrwW6sEH2A@mail.gmail.com>
Subject: Re: [PATCH] meson: add missing semicolon in pthread_condattr_setclock
 test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stepan Popov <Stepan.Popov@kaspersky.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 30 Mar 2026 at 14:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 30, 2026 at 05:32:33PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Mar 30, 2026 at 5:21=E2=80=AFPM Stepan Popov <Stepan.Popov@kasp=
ersky.com> wrote:
> > >
> > > The test code was missing a semicolon after the pthread_condattr_t
> > > variable declaration.
> > >
> > > Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
> >
> > Fixes: 657ac98b58 ("thread-posix: use monotonic clock for QemuCond and
> > QemuSemaphore")
>
> IOW, that commit has been dead code since it was first added years ago,
> we've never used the monotonic clock

Yes. So are we confident enough in that never-tested feature to want to
enable it at this point in the release cycle, or should we hold off on
this bugfix until 11.1 ?

-- PMM

