Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4947C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmja-000852-Js; Mon, 07 Jul 2025 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYma1-0002Ua-Oq
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:12:29 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYmZz-0001u3-Lx
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:12:25 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-712be7e034cso26072617b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751897541; x=1752502341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdGvfRRYtP80FugowsMZexIHI581IU/w8YqS9iXPG1k=;
 b=g+0NvmN/6maJ9hPGQVV5fx42oe1EI9ykFII7UsEU44YCPVs80U+7A33gtYkGIZkcPo
 4RMqLwHgfvgnXcEaYDe3p4O3yjvXlBWFXVCrFlz2vWkNBiPtY7lwBbZnij/k7CGpmGN1
 wUA1CCnMTMVUCaUCu+mHCYO/etR9l+R9pQgMYp5rB60ei9MZgntLkkwRMM5DGI910qZQ
 2EsA7DHiZrtPlQUhgYzJHDLfCAccMswZs8lTKjFunHrn7B/XcuZSJ7JKeTEweAfiY/qT
 RO11zw78TNMr+IuthOkv1JrwoKY0ftkO/sIGDKSDSnI9agWG9bCyRYjxfTPmuyficHLJ
 qh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751897541; x=1752502341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdGvfRRYtP80FugowsMZexIHI581IU/w8YqS9iXPG1k=;
 b=wD5zCjaf07nx+YaUjXtx6KZypxyKfRraE+Uqpnj4q3+9g6oDGtF7XY9XNScR7tiOOm
 Kt/rBGI3Ee7swAnpBswKNLQYUWSqFaE0f0ZKsy+JOPSbE3Zags6ukWLaNd2Tmos7Dk0N
 d0UrthumrOqtG2yk4BJkL9kIvjFSNWIg9OpdCeoOJkjRdPjsyjkMe0/KpRzBe59gH1TD
 03umg2o8ZxGL2myTFJPpwUSv7t/KcPOh4uSrdnQb4jwSyJhOGgy/uW+r0udaakMSsSle
 p0//8bza3ALuZvDi4JmQOy0DTtNwux62u0+rs/TWs5bO5w/TM8L1ZISNMs8CXhu0XvMV
 R4TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4m5mvQkU+Wc2m/ESHSs8jIL73TJKlSguIbBV+82VKWK5E25/E3sWrG+JVrSv5PjxtZMTaTosm6YZW@nongnu.org
X-Gm-Message-State: AOJu0Yxr6IJFD7XyQrTrGcMl2w4VU8/eAtwWoFqmLjBBaHUyhMCLMNvS
 4SKWX43IXz43cfH5a+xq5coK+UTN4zL4U2eyLzC+FOtCE4Y0TqBhGpLaLUoJH2FfC3+muHU4n/v
 mBRrjztTee/v/zyyQgW1GcN0jGC6bL53/DhkHSBAy2A==
X-Gm-Gg: ASbGncvn7VN+Lm7RYnrhPt2i8fUDUWveDkmHwDOnnJHVEQlEtpgSQZPCmE5eqUyBJVR
 QtkVIMGzR+zc2MMtImKQCXbTY7hIOCsu7iX9twdhK0/X6Vo9N54nDaxVOfOC3M+1gXAovRJldzG
 HvMIVoxTCBo+WihntfMoXeQMyHaVg1DiIOVC+KhB5TicX2
X-Google-Smtp-Source: AGHT+IHaSeKCLdO20opVqeTMaAeWzbjt8IrM+snkU1aQghIGtfyHTIzaBpZl97qhvk8QxV5051YFUWQ0rhYW3FAhspY=
X-Received: by 2002:a05:690c:640d:b0:715:96e:fcfc with SMTP id
 00721157ae682-71668e247dfmr158214977b3.29.1751897540848; Mon, 07 Jul 2025
 07:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-6-philmd@linaro.org>
 <e3e2f53a-33ad-49b0-99fc-c7af4b76a0d8@linaro.org>
 <CAFEAcA82LrhSz47_Q_FwbBmC-Nve-WR2bhfWoWyvYi_60MSBaw@mail.gmail.com>
 <20250707140253.GA113082@fedora>
In-Reply-To: <20250707140253.GA113082@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jul 2025 15:12:08 +0100
X-Gm-Features: Ac12FXzNcEhwZOU7i5nEElk0wHnut_hVmhxnpN1QUF-yq2lWS7TRu6Ec5E1TTb4
Message-ID: <CAFEAcA8uW=b3x3_9xMtxxXmf+NaEYjGjS2SEsmPs+z8fMrvjag@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/arm: Share ARM_PSCI_CALL trace event between
 TCG and HVF
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 7 Jul 2025 at 15:03, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Jul 04, 2025 at 02:14:35PM +0100, Peter Maydell wrote:
> > On Mon, 30 Jun 2025 at 17:53, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> > >
> > > On 6/30/25 6:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > It is useful to compare PSCI calls of the same guest running
> > > > under TCG or HVF.
> > > >
> > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > ---
> > > >   target/arm/hvf/hvf.c    | 3 ++-
> > > >   target/arm/tcg/psci.c   | 3 +++
> > > >   target/arm/trace-events | 3 +++
> > > >   3 files changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > > > index 7a99118c8c2..6309c5b872e 100644
> > > > --- a/target/arm/hvf/hvf.c
> > > > +++ b/target/arm/hvf/hvf.c
> > > > @@ -34,6 +34,7 @@
> > > >   #include "target/arm/multiprocessing.h"
> > > >   #include "target/arm/gtimer.h"
> > > >   #include "trace.h"
> > > > +#include "../trace.h"
> >
> >
> > > Just a nit, using 'target/arm/trace.h' might be more readable than
> > > '../trace.h'.
> >
> > Mmm. docs/devel/tracing.rst rather discourages this:
> >
> > # While it is possible to include a trace.h file from outside a source
> > file's own
> > # sub-directory, this is discouraged in general. It is strongly preferr=
ed that
> > # all events be declared directly in the sub-directory that uses them. =
The only
> > # exception is where there are some shared trace events defined in the =
top level
> > # directory trace-events file.
> >
> > I don't know if we want to loosen that to permit events
> > that are shared between multiple subdirs (cc'ing the
> > trace subsystem maintainers for their view).
>
> Code is generated from the trace-events files and my main concern is
> that the build dependencies on the generated code may not be obvious if
> a trace event from somewhere far away in the source tree hierarchy is
> used. You might hit linker errors because the .o files needed for the
> trace events are not being linked in.
>
> I would try to stick with what's described in tracing.rst to avoid
> difficulties now or in the future.

So how should we deal with "two different source files in
different subdirectories both want to emit trace event X" ?
Creating a utility function that can live in the parent dir
just to wrap the trace event seems a bit inefficient.

I agree that using a trace event from a long way away across
the source tree is probably a bad idea, but "immediate parent
directory" doesn't seem too likely to cause issues ?

-- PMM

