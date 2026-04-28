Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF586FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdBs-0007b7-5l; Tue, 28 Apr 2026 03:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHdBo-0007aL-Tv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:49:04 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHdBn-00080s-2S
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:49:04 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6501725d888so8991614d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777362542; cv=none;
 d=google.com; s=arc-20240605;
 b=BbcR8zSM93Arm2RdxNXkWa+9NzONTGdboB/uIJ7b2CjhVS8JsHZpTxs9WXCDxXCEw7
 Zx13Ej4k21Y9v+BnNTv9BrY1aZYzalPUUKJi7AGoysdTuCbOhurxOriNJ0gMjyFmpAc5
 q/4GZk69wgOcMXNOBzlLmdwOF2SpCpuuOrFncflxCDUOCiEsH2ECWrDBQrw1tq349gfu
 X+420QcVNPdOasMkjD4W5Ry62dA4v6boT27nYyetHcc4B8A36gT8wGqSJFa+WvAFVabP
 K67Hz8MHg0srMd7eALvb1djSN8DmYZ5EwunlcyM2BZd1b0T0W5VcaIFAakm//SifGPwx
 eTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sD+CQsBvunLSQ8PKk34tXwXQ0myL91q/9Qi4cA3HYMU=;
 fh=1Xd7Wzgni5O6OiQrUAllr3/n2A2vZ24jpGmDtX3IXEk=;
 b=AE22V+CQ6IX+sgvxsJP27VV8K69QTccxdBT/66VlJLRZOqPVMXNlzkdfMlMx6rbqTN
 MpHUBu2fQbhQPtyLYE1DJ5kVw2UzDBY+6GdIAk1rH0iDpK+1xdy3yp9Qb4BW/9xuRQ5x
 uFBRKNyg4SNY6wYEvug1Uw2DMMbe44Vf24G2d3o3DIfvhEHjRj+Y3l7a6Y4gxoa6GJ+O
 rhQhobHz4QZPu+wWuJOn1ZVdNakMNaLE5YYATSv1yZ+8ajc7rXsH6PqVVs3jvCB+AbaL
 JA9GJstW8HrOs/PDr1mLhCGT15JgvoIaU0I60f39nXtM9+0GXUXlFf3KTDNH6BlNo/oI
 Z6uA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777362542; x=1777967342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD+CQsBvunLSQ8PKk34tXwXQ0myL91q/9Qi4cA3HYMU=;
 b=ogPYf5aaBJU4BUHLlzFk9ghT9WFeWDwObk5+GHl2ewR7veUO2defVtCsJjpGmkKIDn
 T55JEJRUo+lYl0vb+hmxqN6+sGBqCCRiMM03Op5c8kDWcvQc84FbkpTxnp46CENtwID1
 oIg/PNLo1+YbGACvULHcDuzdMhTI2HpDcpWf9Btjz87OLr65wLAo18Fkqp1ausssagEh
 nBC6rTY7rADhYy9qTpWZfGY/nzjmQx1Y1Msx6YkRLX28W0MWOVMRbqIBFbCOwYWjiF2a
 lcuBCvoTlQ4rlALEl1MifLQ6uy8K/Mf0//TwF2pHMPkFSbk4XGyliz/XuEnAFnv7Cv9L
 tzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362542; x=1777967342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sD+CQsBvunLSQ8PKk34tXwXQ0myL91q/9Qi4cA3HYMU=;
 b=cK7QQ1V4/kMn+tP6OfFG4nLAbqOd8j0wCvgsm0XU1iLAjOUqIxR0Dc2X19XPA3Ia9Y
 nMMeXvhCyWdwk9tO6XkU7GXdpp3Oxw6X4w+MSpxgaNcWskxIqXjrfda8ZkKwyUryCguo
 JAXxFv73fnXIB6C773j0nqMzHIoQsUp5r5ICEAnYO1mHl5jP/dy+nRVttEo6gEGhxqE7
 boRhz5U15WJFVs/HAbcVOKXFolQjXd0ni+Gell4PPGlAyppfjJ9xYb+r2f9BpZA9tyAq
 cr7EnFt+AqxGfSLMkiwvGCmRPP66ZAZNYcznXQndjmz/pWQhP4emGIqNwQrD+A3HwaFP
 X7fw==
X-Gm-Message-State: AOJu0Yx6hr/TArjlXCqXU9MyivA6d+KMMEhUjpJZ7XZwyKvjk+MZ7HEk
 nqPkmnyC1qWsf4MFbl2uwiRoCt3eBRK5beQ2S+YPHqF/+qnEaUqlBPabvVPL4FCZt9Dauu7AYuH
 wY2S0N6pBCuiD3G/vxcy5j3kVz4SvgJiqmBb4/F0e1w==
X-Gm-Gg: AeBDieukFxCtstQJ4ex6mYEgQuL29gF3VghXaMHfl1O/+VeFM/Fo+CgqoRwsbd8HsTC
 /KTfC8AK/8EbGkAppVoD7ahJlmOXDkrIbO1J5eVQGPHqtquy0TnKsgQA3Uq1TT6K72hQrWVKuwx
 XFrF2gzmkZ4TAnKZUdZXZlPMBfyLdRLpS/Rn6h/Sct64e1ldk46GaARlOnl2jcXZxv0W/9uXupE
 g4XELjMBtBEbmcJ9siIcZkQj4oAT6J4SzVaYlUvjJ4bmiA7kPWYRDCAHNau0LAomQ7PsYPG/+8x
 vrryyXacMlkCgsKAQA/Djf9LQP1unMd1vkKdjmonW64k69kA6kn7uy3dlhNehSHkwdFg9Vr2XWs
 PtQ==
X-Received: by 2002:a05:690e:4388:b0:651:cc5e:b8d7 with SMTP id
 956f58d0204a3-65beed7c474mr1184929d50.22.1777362541744; Tue, 28 Apr 2026
 00:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-41-c413f3605311@redhat.com>
 <CAFEAcA_7LT-gpArvYpabe9UiFPDGDMEsGOTMeivw90SVDjabeg@mail.gmail.com>
 <CAJ+F1CJ1u16q+KBqsO3ofYTVERSvLC-w2MhA_oUF_tvd-mPZWQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ1u16q+KBqsO3ofYTVERSvLC-w2MhA_oUF_tvd-mPZWQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 08:48:50 +0100
X-Gm-Features: AVHnY4LvJiWccyq5d0OGsdVumABKk42v_LpOoFO2S8aI4CaZNnh6i5EoUE0oAKQ
Message-ID: <CAFEAcA-mkx-pymWq7nUOsNEBPr__RJZAV-h2YXSe=+_aGUZy8Q@mail.gmail.com>
Subject: Re: [PATCH 41/41] qtest: add "qom-tests" command
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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

On Tue, 28 Apr 2026 at 07:37, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Peter
>
> On Tue, Apr 28, 2026 at 12:08=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Mon, 27 Apr 2026 at 20:50, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Add a new "qom-tests" to exercise basic object lifecycle. Instantiate
> > > all non-abstract objects, get and set properties and unref.
> > >
> > > This should quickly find leaks and other related issues that are
> > > eventually triggerable at run-time with QMP qom commands.
> >
> > Can we have a comment please that says what you think the
> > basic object lifecycle is?
>
> Hmm, what is not clear about the comment above and its list?

It's quite brief and it's not in the actual source file.
More generally, there is a lifecycle for the basic QOM types,
and a more complicated one for QOM types that happen to be
qdev devices, some of which we are testing already. I think
we are not very good with documentation of what we expect
from QOM objects lifecycle-wise, so I think it's helpful to
be more explicit and detailed rather than less.

> > Also, the qom-test already has coverage of "init the object,
> > introspect its properties, unref it" -- how does this differ?
>
> It does introspect on already living and reachable objects, over QMP.
> It doesn't instantiate, set, or unref.

Ah, sorry; I was getting this confused with device-introspect-test,
which uses QMP and does a 'qom-list-types' to get all the
QOM types QEMU knows about, and then does a 'device-list-properties',
which implicitly will create the object with instance_init and then
finalize it afterwards.

thanks
-- PMM

