Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3E2-0005uh-FZ; Tue, 25 Jun 2024 06:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM3E1-0005uG-7V
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:16:33 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM3Dz-00089l-1p
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:16:32 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d1012e52fso6109054a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719310589; x=1719915389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TFBV7VJ4lu1LXMNwrKphOIHTpLVi8BAGYevKpMDebM=;
 b=U9B5FKyNNkCqvKDi1BGWv493rKq1Xuq4V8igQy8pjlRogLs3EhX1pnRAcnNwG1UVPE
 KdkZeWKWylyfsGMKFf9pZsGj3mdK/gFjOxZ02hH4JX8rpvQMzj4DF8kA70mrtX3feHsJ
 /gIkJ9NAk/vgFFmB9MgjyJAJUt1/Bd7rTI8q8Dbp5yAynEBfLdfUq3fngeUfYh8plGZv
 zT6q2yxhyBF6fQi2SOrZ6sbc0OMiFKAWp15fLk+pioIFX5Rd5q4+T71KP1MP0cMXVIUr
 NlBiAyffiaXrWrnn/KRayA7jgquNNPFeCfv+XHahJNJtnwFNQ2um+rsQ0tTEvVwFobat
 IIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719310589; x=1719915389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TFBV7VJ4lu1LXMNwrKphOIHTpLVi8BAGYevKpMDebM=;
 b=NLR2/gO5kaYMFYcYxczehD3IaATzlfBxVobu75zTEzQDwq4GerMWPQBvlIUmFIbgsE
 wIAALmrxtfo6V1HOqiT5476jm37pRUuLEpJGYWnx8NjnQnonDDhPN3KV/FdWQSOjeK1Y
 dB05awMJUOqDHB3559AgdvVtMD8fuWsqExiz0jTIPaWG2C5b7ZDTH/uLxSzVuWQEUxqb
 TIIJzHIf1ssFF0G/YVWoKaiTbetnXgXixl9EXz5CYQ4gLEYD1PCoICS1r63r+Llj7QG1
 ZCtcuvQikh3E4srZHOU8QbpwIrOUQaz9hdOzjoYMgA4fMqJmSwEBeImVqnWwxLkoC0vD
 qH3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyO6kbtAdJTscXg2snsstwgE1OWqsxwevG9a06Hpmfnnu77tciwDs8J1u8MLGhRTl56XDF+8VFbQUHeW3xCPvzODKj8hs=
X-Gm-Message-State: AOJu0Yw4DxopSZ9Yb06foffg/iWDMFhrQ2x/E819KA6pMsdM/2OGrvP7
 irEW1KEcDwtQLSMYLzyjcKRcyQGiN1dNQ6V7MaIy06JFDfanfpfCp8gdjlhj6xmo9a8YWiitz65
 /wOx10ljKuvINYNO9wIQI18I0HarSRHCgm2SP5Q==
X-Google-Smtp-Source: AGHT+IFkCMP6hPb7EyUKj4pGTQTknmTVD2j+YVJNvjS+iF57AklYxOY/ZSO4vsBnElWNjDVw4l1CnQCBkJk13NkXCzE=
X-Received: by 2002:a50:ab1d:0:b0:57d:4d12:61bd with SMTP id
 4fb4d7f45d1cf-57d4d1264b8mr4335624a12.37.1719310587960; Tue, 25 Jun 2024
 03:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
 <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
 <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
 <0b5ff0ab-9b58-4463-8aeb-d464b3b085dd@linaro.org>
 <CAFEAcA-5RPETso7Z56SUhgDkSekLDWu8hPXmKEo_dhh1kPYpfg@mail.gmail.com>
In-Reply-To: <CAFEAcA-5RPETso7Z56SUhgDkSekLDWu8hPXmKEo_dhh1kPYpfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 11:16:16 +0100
Message-ID: <CAFEAcA8pQ_XtitN-Zy63xxGT=6mBEuha7PCeJc-=OJWcvuw=vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Felix Wu <flwu@google.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 25 Jun 2024 at 10:27, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 25 Jun 2024 at 07:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > On 25/6/24 08:05, Paolo Bonzini wrote:
> > >
> > >
> > > Il mar 25 giu 2024, 04:32 Roman Kiryanov <rkir@google.com
> > > <mailto:rkir@google.com>> ha scritto:
> > >
> > >     Hi Philippe, thank you for looking.
> > >
> > >     On Mon, Jun 24, 2024 at 7:27=E2=80=AFPM Philippe Mathieu-Daud=C3=
=A9
> > >     <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> > >      > In particular this patch seems contained well enough
> > >      > to be carried in forks were C++ _is_ used.
> > >
> > >     Will you agree to take #ifdef __cplusplus  and #error to the QEMU=
 side
> > >     in atomic.h and
> > >     we will keep atomic.hpp on our side? The error message looks bett=
er
> > >     when atomic.hpp
> > >     is somewhere near.
> > >
> > >
> > > I think we should also move typeof_strip_qual elsewhere; I will take =
a
> > > look. I think there are a couple headers that already have #ifdef
> > > __cplusplus, but I need to check (no source code around right now).
> >
> > $ git grep -l __cplusplus
> > ebpf/rss.bpf.skeleton.h
> > include/hw/xtensa/xtensa-isa.h
> > include/qemu/compiler.h
> > include/qemu/osdep.h
> > include/standard-headers/drm/drm_fourcc.h
> > include/sysemu/os-posix.h
> > include/sysemu/os-win32.h
> > linux-headers/linux/stddef.h
> > qga/vss-win32/requester.h
>
> We should delete all of those, they're dead code for us now.
> We dropped some of the extern-C-block handling in
> commit d76aa73fad1f6 but that didn't get all of them.

I was wrong about this -- I had forgotten about the Windows
Guest Agent code that has to be built with the Windows C++
compiler -- some of the cpp files in qga/vss-win32/ include
osdep.h. So the files above break down into:

 * files imported from third-party projects, or generated
   by third-party tools:
    + ebpf/rss.bpf.skeleton.h
    + include/hw/xtensa/xtensa-isa.h
    + include/standard-headers/drm/drm_fourcc.h
    + linux-headers/linux/stddef.h

 * QEMU include files that we need to include directly
   or indirectly from the vss-win32 files:
    + include/qemu/compiler.h
    + include/qemu/osdep.h
    + include/sysemu/os-win32.h
    + include/sysemu/os-posix.h
    + qga/vss-win32/requester.h

Maybe we could drop the cplusplus handling from os-posix.h,
but I guess we're keeping it in parallel with os-win32.h.

-- PMM

