Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DDD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRRu-0002xh-QR; Tue, 02 Dec 2025 09:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1vQRRt-0002xU-Qh
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:33:49 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1vQRRs-0008Kl-6C
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:33:49 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c7660192b0so4066633a34.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764686026; x=1765290826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAiklG2POP4MLoEgbaua2Y8q01vf/PH/bKgZWM11NPc=;
 b=N4vMEZKueeOIo6uo+vJg/p5GvR/r/K/MyLSehwuABRVvXwDKUb4yz4fgqo7FbcoiTn
 7R7ZNH/S0ImHjXxQ8byjWSakurlLLbX11W4EV3zptbuRsAFLRpGGDcGWXa88I82LgSZO
 ckw4ToQ2tgQrktYWZHKjh+SnkxIb+H3gTYOYQ2LBag2Q9vkYrB/1vN0W+2eBICs/GADB
 +Wy0Ydz3CITpipGjzvGyBdsdxAKHqqEp/2JqaJPw+gUsKz/xE4IFcWV0P8VxmcxAn0dQ
 GxvyBqWdGWoGBbsHhcXeT8yA0O45pBMMafsMoy/roUy3gZhnzmGTKlu8Kg6XVJkn+f4U
 dz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764686026; x=1765290826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nAiklG2POP4MLoEgbaua2Y8q01vf/PH/bKgZWM11NPc=;
 b=Ns1NN/zvZYMuZf23d1No/eOdg3B5+Ma33OxvtLmxICKI21PlJxRdzehIpd2siyNtro
 NwO8v8s9TNTxzhSlG6wypvn2aWZBsdttxvxyvs1EXrHXhxg7DTWR4fPIdpNAD8vkPhS/
 qqozm/0iG+VHlFnH7Dl1rhR2cqcDcUJiK7o+ypsDgZG53eOzX35S2btKBQsnfs9jJC4w
 QEuFWv4Fr/IObSBl/AoEdYPyY/EfvONTaHf2ojUFMvk3+HDwx/mzxTUoyonVJ03SvDgz
 0t5GBSyCttBUQfWuYKaDCGFdiAXp0qlZa2k8r+MUkIL4mBfasXyDPwZOB+aQFK9keFRl
 DlfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnFk0OouatJ40G1apVz1FoxwxRgY804Y+tpaFrP4E1swz0Xnde4P4o3Ejxfyxwq/fpEcxiAFO26/V3@nongnu.org
X-Gm-Message-State: AOJu0YzAOaNSPGE6V2QTJvYvPxnJHal3S+U94AbS97FP+2aGErEo4AeD
 q6Q590wP9x6+r3dAQgQhlbsDjnEPohE39t9M7dIdNHHsmI92MZIqwisxxih+2MIOjmEkj1ZXdtK
 0fI/9YKQ46Vp5LFfurnTZJmrvBVog3vA=
X-Gm-Gg: ASbGncuw4ue4cPCziPgXC9cB1iIjD6WNCvS4qSxbANj+mBTWSnWlA/lKkklgn3UnRzc
 rRAUJjqUEkQryvxYKwfzmO7CRD+DQMTJcnmNhlX/8MsJT+rVXCMlHT1Jpc/e59DSWSJ/Jt/gZer
 2+Kh5gj34XksfrEbskxV1Ci5KmimyE7l9+BMS9XTGv06F2b3v2ljMmQgsIQ7zZ99r3fmBXmxAt5
 YXk8yrQ7iyyaErhYOL+5/8Gv4COcxZVtIq9b6w/TL1XaTqwO7dFYCj4spsmtn3/o2PABdITzohS
 nsVEmwVleU5Cg7nD23HQJcUhQL84YgPostCdGw==
X-Google-Smtp-Source: AGHT+IEPSAdIPR5qu+JlPwUX1BccCLg3nvsfEBFmH46Vnmx4KAE8Pi/4qz891ElzCnbAFwXP+Cu4GTrsLTHtJCpOiig=
X-Received: by 2002:a05:6830:915:b0:7c7:266:392d with SMTP id
 46e09a7af769-7c798fa32b1mr21365768a34.13.1764686026384; Tue, 02 Dec 2025
 06:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
 <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
 <CAMxuvayp1WiqWe40Ox69DQ+R0X3VrJ_ai001Z04KbEouFGwCjg@mail.gmail.com>
 <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
 <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Tue, 2 Dec 2025 09:33:09 -0500
X-Gm-Features: AWmQ_bnrtCdcHWvlfuUKv0y0PxlS6uUzAUrlYllu42WYlvbnzxDKQkAP2eZLzS4
Message-ID: <CAEg-Je-dwCPrF0sX4gxLGDM5mVCjurUaFvbb6RZRxxCFoheV0g@mail.gmail.com>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Ratchov <alex@caoua.org>,
 qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=ngompa13@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Dec 2, 2025 at 9:15=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Dec 2, 2025 at 5:26=E2=80=AFPM Geoffrey McRae <geoff@hostfission.=
com> wrote:
> >
> >
> >
> > On 2025-12-02 23:44, Marc-Andr=C3=A9 Lureau wrote:
> > > Hi Geoffrey
> > >
> > > On Tue, Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae
> > > <geoff@hostfission.com> wrote:
> > >
> > >> The PipeWire and PulseAudio backends are used by a large number of
> > >> users
> > >> in the VFIO community. Removing these would be an enormous determent
> > >> to
> > >> QEMU.
> > >
> > > They come with GStreamer pulse/pipe elements.
> >
> > Yes, but through another layer of abstraction/complexity with no real
> > benefit.
>
> The benefit is that QEMU would not have to maintain 10 backends and
> all the audio mixing/resampling. The QEMU code would be simpler and
> more maintainable overall. GStreamer has a clear pipeline design,
> better suited (optimized code etc) and you can easily modify the
> pipeline settings.
>
> >
> > >
> > >> Audio output from QEMU has always been problematic, but with the
> > >> PulseAudio and later, the PipeWire interface, it became much more
> > >> user
> > >> friendly for those that wanted to configure the VM to output native
> > >> audio into their sound plumbing.
> > >
> > > Could you be more specific?
> >
> > There are clock sync/drift issues with the emulated hardware device's
> > audio clock and the real hardware audio clock. GStreamer won't solve
> > this, it requires a tuned PID loop that resamples the audio to
> > compensate for the continual drift between the emulated and hardware
> > clocks. Without this, over time, the audio can and does get wildly out
> > of sync eventually resulting in xruns.
>
> That's indeed a complicated subject and hard to test & measure. Adding
> some testing to our audio infra should help identify this better. Not
> sure when time permits though.
>
> It seems to me that the current QEMU audio code is using the
> virtual/system clock timer to pull the data at a regular pace, which
> is not in sync with the actual audio sink clock. The GStreamer
> pipeline, otoh, uses the audio sink clock. But there are other
> emulated devices related issues (like hda not sending data when asked,
> or later, it has to be pulled regularly etc). I need to study this in
> more detail, this GStreamer implementation is a bit naive there.
>
>
> >
> > All you have to do is google for "QEMU Crackling Sound". JACK, PipeWire
> > and PulseAudio manage to mostly hide (not sovle) this issue from the
> > user, but it still occurs. It's worse for SPICE clients as the audio
> > gets buffered in the network stack rather then dropped and can lead to
> > many seconds of audio latency.
>
> Yes, I think synchronization of audio/video playback for remoting is
> another issue, if QEMU has the audio & video frames in sync which can
> provide correct timestamps.
>
> >
> > As for applications, we have a large number of people using QEMU/KVM
> > with full GPU pass-through for gaming workloads, many of which route th=
e
> > QEMU audio into PipeWire/JACK directly which enables the host's sound
> > server to perform DSP and mixing, etc.
> >
> > Others are streaming the guest via Looking Glass for the video feed, an=
d
> > using PipeWire from QEMU to feed into OBS for live streaming setups.
> >
> > The flexibility that JACK & PipeWire bring to the table can not be
> > overstated. From a maintenance point of view, JACK and PipeWire are onl=
y
> > ~800 lines of code each, fully self contained and very easy to debug.
> >
> > All the audio processing/mixing/resampling/routing (and any user
> > configured DSP) is fully offloaded to the host's audio server, where it
> > should be.
>
> (by default QEMU is still doing resampling & mixing, and adds extra buffe=
ring)
>
> A GStreamer backend should not be incompatible with those use cases.
>

Have you tried to do this with VFIO and do semi-realtime audio (e.g.
AV work, gaming) with this backend?

In my experience, gapless and "crackle-less" semi-realtime audio is
unnecessarily difficult to do well with GStreamer right now.

Don't get me wrong, I *like* GStreamer, but I don't think it's as good
in this case as it is being positioned.

> [..]
> > deprecated, I really think that effort should be put into implementing =
a
> > WASAPI backend for QEMU.
> >
> > I really do not think that adding all the complexity of GStreamer to
> > QEMU is the right way forward. We should just hand off the audio
> > processing to the host system's sound server (as we do already),
> > whatever it might be, and let it do the heavy lifting.
>
> I agree with the goal that we should leave most of the work to the
> host, and not have to do audio mixing resampling ourself whenever
> possible. Imho, GStreamer allows us to do that in less and cleaner
> code.
>

GStreamer is a painful dependency on non-POSIX platforms, so I don't
think that our non-POSIX consumers would be happy about this.

Personally, I'd keep around at least the SDL Audio and PipeWire
backends too. That gives decent coverage and lets people avoid
problematic build and runtime dependencies.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

