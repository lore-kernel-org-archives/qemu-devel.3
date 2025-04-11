Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C53C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 18:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Iyt-0004t3-2m; Fri, 11 Apr 2025 14:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u3Iy7-0004ha-T8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 14:19:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u3Iy5-0005ci-DL
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 14:19:11 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e673822f76so4181385a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744395547; x=1745000347; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RiRVvRuigeI7FsM6fxS2pSdp41Bim05EmIYn1S8Kr8=;
 b=FVz6/IeTrBVms4b3TxEJoRV2m36Paq7SQnobMOzf/UY7zYykV2LFfroymcVlMJkpgV
 jC7N4KnakKDGPPoCBwvda68/SL6OM2zXRoRtrFuY6rdaHUWtwKdMsx7Nyz4ZnJ6/ioYR
 qvAfEZh3t3N35kbToyahBdkNWrNxppspIc7uKL2gnFZxh5SVIArx8sniaOO5hDjJ1zLB
 qt0zLLGLeNxCctCsk8aHa+r8Qsqbckzg2UBAuP6lFrAAY0qGawAHv8bxkqFiSCT0D6xR
 qXCUB4QnM2BJE3Z83jTR3ZgoG0Tw7efTE8tJ5EDpFhjg/92wQDH3Qi46RXWBFvq0ciF/
 zSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395547; x=1745000347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RiRVvRuigeI7FsM6fxS2pSdp41Bim05EmIYn1S8Kr8=;
 b=iE+iFfrMykcokwlCe/F6ydZad1B2/f8u5VsH2ttYDtgv5omYT2hl5ZrZIeVdBDg3W0
 kHWnvO3z6qkrn06LmNrD7DTIS39CnwgdDxQ01zqUogx5o4PITY48DEk2dzpCJsB3aMuP
 dF3xGA8iujItqmQHacQyvlBh0rq9996RNC56zXj76UDXMIzNEAQvflud59WMyRYxK8Cb
 oEXp1MKs34nHeerrium/9xjoftQxdQTdrjivNeoAZFGv96jv1eCdZeh1KLtvTOHywIJY
 0xFj158XU7VVQw7fshCJ15yDLGW6MvRJazE/VmvP+z3NhHuzmqeOEVO9PvACpNfoDSPw
 BLwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqv4dhp6VKNggxcRcd0rnV/btpEf+fARjOVGPSATJkYmm3kv1ccsgS5KT1b6qqaEqfaR098+oYcRmN@nongnu.org
X-Gm-Message-State: AOJu0YwVVA/s3YjaOZG5Abb0bvt7nL855bbJgdVVuX2AIqBOXoRjGbf1
 Qr1a1MdqCd4HIhKcvQkac62VoTtRaIUSJhb6cUVhLG15l5iTEHslWBqoOOMWkQiPpjQDv3nXm8q
 /wk/nmc17wFzFqOGWjR5VIPSv+kM=
X-Gm-Gg: ASbGncuLzvwpZ0O8q2tuwBEN9ay5lILaMnMMy9psjlPzah8dmT95K+g1QVSQ8RADaa6
 psMLpFHjP1udpzAfhE4rAl+WMdfdcd49LYv+etN6oLLIaA5DrUXXRmpjdKm13EFVKUvLMSApUPF
 pAXaA4A619bpl6UjHYpWpc
X-Google-Smtp-Source: AGHT+IFLUq+1jf7fWbkx5cRUL8NNmgXbLTtg/BM1M1CxXb+WDulod5OYPdWvhhQm3oK200FJJ10GA97KECG+Pajty8Q=
X-Received: by 2002:a05:6402:4287:b0:5ee:497:91f0 with SMTP id
 4fb4d7f45d1cf-5f3700195famr3142562a12.34.1744395547306; Fri, 11 Apr 2025
 11:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-9-richard.henderson@linaro.org>
 <Z_kcXeS8qSDa0I8_@redhat.com>
 <cfc8254d-6b15-4d9b-af28-7129b76363e4@linaro.org>
 <Z_kwcYoQOoTWv9Ev@redhat.com>
In-Reply-To: <Z_kwcYoQOoTWv9Ev@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 11 Apr 2025 14:18:55 -0400
X-Gm-Features: ATxdqUGvA6-J34dCbobD5Yb_hRxdouNeZDF2QeFa536N_XKhsnd3TSdf489zS84
Message-ID: <CAJSP0QXy+vzfKuJs6gO_SxqiO7NGnTWKXAf-KCK4itgoW++y-Q@mail.gmail.com>
Subject: Re: [PULL 8/9] meson: Disallow 64-bit on 32-bit emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Fri, Apr 11, 2025 at 11:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Fri, Apr 11, 2025 at 05:05:20PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 11/4/25 15:42, Daniel P. Berrang=C3=A9 wrote:
> > > On Sat, Feb 08, 2025 at 12:57:23PM -0800, Richard Henderson wrote:
> > > > For system mode, we can rarely support the amount of RAM that
> > > > the guest requires. TCG emulation is restricted to round-robin
> > > > mode, which solves many of the atomicity issues, but not those
> > > > associated with virtio.  In any case, round-robin does nothing
> > > > to help the speed of emulation.
> > > >
> > > > For user mode, most emulation does not succeed at all.  Most
> > > > of the time we cannot even load 64-bit non-PIE binaries due
> > > > to lack of a 64-bit address space.  Threads are run in
> > > > parallel, not round-robin, which means that atomicity
> > > > is not handled.
> > > >
> > > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > > ---
> > > >   meson.build | 13 ++++++++++---
> > > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > Shouldn't  this patch and the earlier ones in this series have
> > > added something to removed-features.rst, as this is a significant
> > > feature removal which is impacting downstream users, and distros
> > > in particular.
> >
> > IIRC the rationale for not deprecating was the feature is largely
> > broken already. Skipping the deprecation process we indeed forgot
> > to document in removed-features.rst.
> >
> > Do you expect the doc update for the 10.0 release?
>
> The issue is that
>
>   https://wiki.qemu.org/ChangeLog/10.0
>
> delegates to removed-features.rst, so if we don't have time to
> update the rst file, then we at least need to edit ChangeLog/10.0
> to mention this removal of binaries as a fallback

-rc4 will be tagged on Tuesday. There is still time to add something
to removed-features.rst.

Please make sure to CC me and put "for-10.0" in the patch prefix if
it's not part of a pull request.

Stefan

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>

