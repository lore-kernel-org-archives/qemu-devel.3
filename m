Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34054C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpDE-0002mv-Qn; Thu, 09 Jul 2026 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1whpDD-0002lp-7z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:54:47 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1whpDA-0000Q7-K0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:54:46 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1989476a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783605283; cv=none;
 d=google.com; s=arc-20260327;
 b=pVeWX3dWh8gzxz5l+7TeMMA0/LrvOZpNhdjjWsWJXh1TXXDJZe5ATo33Xem4oIBved
 94SuZSGgbnSczY/orsTg31OMXBoknVqPQbLwQywzyPnChjKJe7wsJVuqoKlREtyBjy7+
 AaXP8Lnza5aE2KhMktzFy7fITTs7O9Wfx2v5MMBK7fRtqqz3ZhIT27RJKSvi+S+6sAH1
 LXnF7BF097lxuB1apG+wnEWidkR5RQU8dLf6YlJnPmyw6prI3oChhqXCrM8bM9LNF7kP
 R/g6DayAE5lS5RmRsG00XAEAEETTr4sbEqQDeccmDoMKItWITPvG2PKQYEdrTqGm3Iyd
 8Veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N/SxFcNMNZJt4Ldv8rYYoLqhtuevn48hV5E6n1GgtSc=;
 fh=wTuVNhPC2811iDA4b03vqzSoA6l+KOt1p2lpSzAKEho=;
 b=W4bNhg6Np7SQI1e+kSwAu7Yt7PQoAP2VViL/q3PSoF2lgadYE0cxuejzQu6L19jIYx
 Jt1amH8YiyoakwyGh8O3dStocCpX5L5am/ZTLDsGQwqH6xbvuJLgHoifOPD7NJbyAzZn
 sUQhnPvbctNrPqpNUz6aH/drsRTv0j2886FsIKwj3o1QHNxxOXKcmjW2Yw55au+wmrFM
 bZsOn5IZMcJJUEWZcCQwME+KF6vWMNi9zxz1+ZeuvGCQSbhT4ZptZm/gw/nuM22NX7g2
 oEYMnr7FEjxxgRqe1KgGD3iXhIBcW3yOZ2ywSfMc8UHBwL0MxPtMaa3HtroMXgmMTnnL
 RvOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783605283; x=1784210083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N/SxFcNMNZJt4Ldv8rYYoLqhtuevn48hV5E6n1GgtSc=;
 b=Awq5c0bPgE2/WGRgyjHgRKyZunL6sgOiSqMAN+YkYDwN3Gug5CQsSYRxpWOtkXInQh
 Ytk+A+Q4crw/nfJrUIoYWHBpx1k7m7yrf3VJaJ39H0McFPAj3w8uOWGnOvB1ddbyRdqI
 c7P8dkPPtMyUWphHbcoSiXzUJd45Jbn6LKHijbkbMEapbPD2+8+zXsAXZa47CDdKNDZT
 5rLzgmG+8eqebqjDuxClEM5P8mzyLp2cPcRULgoRDXYg//tWByvFN91RjU9R+3OeeoOv
 lfmXTEh2SXjLiuWvOsdwM15pDj1JREywkKBmYvNiwdk3vhszBs++n8HuARwfsOdKWch/
 mxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783605283; x=1784210083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N/SxFcNMNZJt4Ldv8rYYoLqhtuevn48hV5E6n1GgtSc=;
 b=fnZFWh8d/StKRDQ+l4SsymclDBFO1vWolFaoPJy+WC3Sm18OD1zUBdFcXSUMmYxH6m
 1ubkvI+Rne9nXiqEMGZRG9p3qOBdvHHbOiZJT5zxe4vGwMHRV8Tu9NzbHYtfEj5kJj74
 OVDBRo4aM1iHq8LOI0KSKcSL23IyLdZEKqB51P/9f94iAEN73STuWXorpBB7F9tnif4f
 h6CLoN9F46s2B0gDM1AZm+7+XX+67WN03J2I1ZSzMoRoWb4JCcbeYMC/18N+q84ZpuaE
 oBszrTdNIfHueE2xq9YM6YHZFsmNDZsTWeuYaL2huP6lHvXmO6hfzbeOIFC2MDwa8NaK
 LdBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJoUCnAfr2UtNYE95jihk5CppfLZ1vjzJjbb0/MmbVC0I/5zKsbScjlPXD+M5p2dUxT3Xss/TC0xO9@nongnu.org
X-Gm-Message-State: AOJu0YyE1x0pfYwTYY8LQIUVP4EgOK3Fy4VfEOlMzGDwW71sZ2zwy56b
 uL6Cp+zAs3qSNI0oShkCZBHrjYbEKoYtjhRob2dBI6g+juW9urziQr0xJcwii2x9jxah5cP5W1+
 Hpp6vueM9hv68+zbCSzNyJP++pEZLbnc=
X-Gm-Gg: AfdE7cnE/JEJjroE3Sqb383PE78mYjy+LO9dIxgQUVPWGuyBDjIq0Coe2sTBKu7wFx6
 ccVg4nUUW/JkmHIxq6T0fAGhXovPAksbr/LzVu9lZ9TNZLQwjlCw0lrIK1nrKeVRuWO9XSGENVs
 xeCogac50AAU12An1LF1BWUKIYw0mf+YFf7lsp6KS69gSlhW02vzJ8kEQa06wHsEjiLVLVS8CqD
 EKtprdly9/Y1mzrgoEEi+DA3WF6wnrwbu0IQZKKnvDiMRemvTYODiOMm0jN4Ho8NTDj1raBvYO5
 imZRJkaS9BhIiNnxc5+59vKP5j/S
X-Received: by 2002:a17:90b:33c8:b0:37f:9ce1:cdb3 with SMTP id
 98e67ed59e1d1-3894279ba33mr7328995a91.33.1783605282473; Thu, 09 Jul 2026
 06:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
 <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 Jul 2026 17:54:30 +0400
X-Gm-Features: AUfX_mxCpgQ9_NwafLskUA2MzJqouf8Rog06wvsTXmTy-VGH8G1_GSGXtS0d00Y
Message-ID: <CAJ+F1C+BiqriKhDO-vY15z5iQECVarJN-NoemiaW3w93c3EpNg@mail.gmail.com>
Subject: Re: A few Machines crash when "no default audio driver available"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Jul 9, 2026 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 9 Jul 2026 at 14:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
> > > Cc: mainainters for "Overall Audio backends"
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >
> > > > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> =
wrote:
> > > >>
> > > >> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegas=
os2,
> > > >> and MIPS machine fuloong2e crashes.
> > > >>
> > > >> I run them like this:
> > > >>
> > > >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -mo=
nitor stdio
> > > >
> > > >> Died when device_set_realized() tried to propagate a "no default a=
udio
> > > >> driver available" error to &error_abort.
> > > >
> > > > Is this something we want to have be a possibility the devices
> > > > have to cope with? Can we have the "ignores all audio data"
> > > > backend be always available instead?
> > >
> > > There's plenty of precedence for /dev/null-like backends.
> > >
> > > > Otherwise every audio device needs to cope with "there is no
> > > > audio backend available" and implement "do nothing with the
> > > > audio data" itself.
> > >
> > > Yes.
> >
> > We've got a bit of tension between "no defaults" and "builtin audio
> > devices" here.
> >
> > Cnosider if I had instead done
> >
> >   qemu-system-x86_64 -M pc -device ac97 -nodefaults
> >
> > It is not unreasonable to expect to see an error because you asked
> > explicitly for 'ac97'  and forgot to wire up the required audio
> > backend, and asked to NOT have any defaults.
> >
> > But with your 'musicpal' machine example, you never asked for the
> > frontend device, so you should be forgiven for also not asking
> > for a audio backend.
>
> Ah, so this is because of -nodefaults, not because QEMU was
> somehow built with no audio backends in it.
>
> > If we guarantee a /dev/null audio backend always exists, we help
> > the second case but degrade the first case
>
> As a possible analogy, for network devices we just warn in
> the analogous "device created but no backend wired up":
>
>  ./build/x86/qemu-system-x86_64 -nodefaults -device e1000 -display none
> qemu-system-x86_64: warning: nic e1000.0 has no peer
>
> and the effective behaviour is that output packets are dropped.
>
> We could make audio devices do that (which would be basically
> equivalent to "if we need an audio backend and we don't have
> one, warn and create the null backend").
>

Note that we don't have a real "null" backend. The "none" backend does
mixing/resampling/volume before dropping the audio (its parent is
MIXENG_BACKEND). I think it would be worth to add (so one day we can
compile qemu without the whole audio/ engine)

