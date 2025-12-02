Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372A8D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQR9k-0005pX-SZ; Tue, 02 Dec 2025 09:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQR9j-0005nF-J4
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:15:03 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQR9h-0002LI-Qp
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:15:03 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4edb7c8232aso71406111cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764684900; x=1765289700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3+7RzlB0kIfusHTnPjH8Ef/+bH1N3NdVlZvo4wX9ag=;
 b=eisNbMtoMqS6aQzZoI5+5HvqTKMs6d5MvGGaG5CP/LICfCxUEmGFUgx7FKPoTJ90kL
 rvjyvlGyWeMtt0lsNJjqVvTt3MwDQqwU/HNHElUMuJMZTgPIkg5SXgD1LRs0l4GsbAIB
 LtchwYl+eWBQSPMQvvCWzLWRWQ2IuudsiGPS+jhe/8FggspkXDEhKMDaaS2swJFAHOQM
 2QaHWwRp7QHTfC1znygGQll2VpETkXBnju/UJ3+Yg9+6pGsvyuS4okexEKDxNZ1QUAH0
 C+yCVcS0bhZIHH0YYU9W6otazehV3v5PT6gFUmS9tykAC37ErzJr4qe9DxinqkVimt8F
 Dsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764684900; x=1765289700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z3+7RzlB0kIfusHTnPjH8Ef/+bH1N3NdVlZvo4wX9ag=;
 b=eT3FoSr4Khp5SNm7dI+ECLarUijXlct8+1kXSwiqBASTFs6jlt2tXf5bugw582WSgp
 7oYm6XYoICl61GthhOU1bzQWRe5lOnJXG1UWAu/5Rebei7ZcuHj5c7GF/7oaiIPXcsBn
 lcSFOVp3CWxqYK0hGlz5pFJ4lxc3DlHnEVYQrmtJuQyhBrgah0hbXcCO53IDWNSSn3YD
 MKVub9zmo792KseXd/WjkBL92mbjN6mZ7Jj5Mb7kkwo0hYfX2wuRwtGs9cj9Sc6CiYFr
 30ZssY8Ju8663v37lemSalCYAftYcf1Txoorvjwx1kShnQ90wpmivrsbF/qJPegs0/xR
 rrIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf8bqZw8T8fE6VybtqtbzDToE14kf2aMrMlIvtJvRfHCAQeX4q+e0BwEQGRYZHTmcD6h/0F1jgky4a@nongnu.org
X-Gm-Message-State: AOJu0Yxqy7/UHXa+CTuhuwexKgV2nGvn3aSh1lTOjIdM4tD/CMEavXNU
 8jHAWbUKuEmfz3j6HgVORCkIvarrWsNVMfY5RjtkNwQvVP+TPcol4qtTnL++Oq8kKrfJ83ftdyU
 YMlD9BpcngrLXrLqzvH5PLY9hMcEIZkM=
X-Gm-Gg: ASbGncuUsSn7Uqq3O1uMmB7khYR8qBo50h3aq/k4OiTkedQjuw0Z2d3U8RIHUuvxyI7
 rvWsAieEwTgaMrjgu/NHLet+rgR3b7PwUfSfkLI6f51xHK60Ra1wFdbUCSumxZTxLsZ7Hntgvsh
 DFcgvO/bGYMbUw4BLBW9OO4FgQJy0C4/9KfbBelkZkQ7jqGCxPe94ABLCcyyPlZiU6FVdtXTQjH
 9ZlWkZfnIjWBq8nMoWNYmqcH4FEjV9E9Rj8COdkbr7bDyreahbV9jrs6bJ0hPxE28Y/JOYSro3K
 9MwUtYf4wDYmyctEGLNi/tblOPI=
X-Google-Smtp-Source: AGHT+IH9Xa21gnFRoMPTm2XKUJADYeAXr7m4liqem925EseDQKwDlh2xrmir44XrY97M+8Z2mqwexEDSmVC/Oi2R9LQ=
X-Received: by 2002:a05:622a:4d:b0:4ed:68b:c73b with SMTP id
 d75a77b69052e-4ee58a7f137mr620446771cf.20.1764684900383; Tue, 02 Dec 2025
 06:15:00 -0800 (PST)
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
In-Reply-To: <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Dec 2025 18:14:48 +0400
X-Gm-Features: AWmQ_bnOXFoX7WX2O9C_Xd-3u1ZQk6YEwBvTClBXTfU5b18JMT8SjBmpPsti6l8
Message-ID: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: Geoffrey McRae <geoff@hostfission.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexandre Ratchov <alex@caoua.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dirty.ice.hu@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

Hi

On Tue, Dec 2, 2025 at 5:26=E2=80=AFPM Geoffrey McRae <geoff@hostfission.co=
m> wrote:
>
>
>
> On 2025-12-02 23:44, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Geoffrey
> >
> > On Tue, Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae
> > <geoff@hostfission.com> wrote:
> >
> >> The PipeWire and PulseAudio backends are used by a large number of
> >> users
> >> in the VFIO community. Removing these would be an enormous determent
> >> to
> >> QEMU.
> >
> > They come with GStreamer pulse/pipe elements.
>
> Yes, but through another layer of abstraction/complexity with no real
> benefit.

The benefit is that QEMU would not have to maintain 10 backends and
all the audio mixing/resampling. The QEMU code would be simpler and
more maintainable overall. GStreamer has a clear pipeline design,
better suited (optimized code etc) and you can easily modify the
pipeline settings.

>
> >
> >> Audio output from QEMU has always been problematic, but with the
> >> PulseAudio and later, the PipeWire interface, it became much more
> >> user
> >> friendly for those that wanted to configure the VM to output native
> >> audio into their sound plumbing.
> >
> > Could you be more specific?
>
> There are clock sync/drift issues with the emulated hardware device's
> audio clock and the real hardware audio clock. GStreamer won't solve
> this, it requires a tuned PID loop that resamples the audio to
> compensate for the continual drift between the emulated and hardware
> clocks. Without this, over time, the audio can and does get wildly out
> of sync eventually resulting in xruns.

That's indeed a complicated subject and hard to test & measure. Adding
some testing to our audio infra should help identify this better. Not
sure when time permits though.

It seems to me that the current QEMU audio code is using the
virtual/system clock timer to pull the data at a regular pace, which
is not in sync with the actual audio sink clock. The GStreamer
pipeline, otoh, uses the audio sink clock. But there are other
emulated devices related issues (like hda not sending data when asked,
or later, it has to be pulled regularly etc). I need to study this in
more detail, this GStreamer implementation is a bit naive there.


>
> All you have to do is google for "QEMU Crackling Sound". JACK, PipeWire
> and PulseAudio manage to mostly hide (not sovle) this issue from the
> user, but it still occurs. It's worse for SPICE clients as the audio
> gets buffered in the network stack rather then dropped and can lead to
> many seconds of audio latency.

Yes, I think synchronization of audio/video playback for remoting is
another issue, if QEMU has the audio & video frames in sync which can
provide correct timestamps.

>
> As for applications, we have a large number of people using QEMU/KVM
> with full GPU pass-through for gaming workloads, many of which route the
> QEMU audio into PipeWire/JACK directly which enables the host's sound
> server to perform DSP and mixing, etc.
>
> Others are streaming the guest via Looking Glass for the video feed, and
> using PipeWire from QEMU to feed into OBS for live streaming setups.
>
> The flexibility that JACK & PipeWire bring to the table can not be
> overstated. From a maintenance point of view, JACK and PipeWire are only
> ~800 lines of code each, fully self contained and very easy to debug.
>
> All the audio processing/mixing/resampling/routing (and any user
> configured DSP) is fully offloaded to the host's audio server, where it
> should be.

(by default QEMU is still doing resampling & mixing, and adds extra bufferi=
ng)

A GStreamer backend should not be incompatible with those use cases.

[..]
> deprecated, I really think that effort should be put into implementing a
> WASAPI backend for QEMU.
>
> I really do not think that adding all the complexity of GStreamer to
> QEMU is the right way forward. We should just hand off the audio
> processing to the host system's sound server (as we do already),
> whatever it might be, and let it do the heavy lifting.

I agree with the goal that we should leave most of the work to the
host, and not have to do audio mixing resampling ourself whenever
possible. Imho, GStreamer allows us to do that in less and cleaner
code.

--=20
Marc-Andr=C3=A9 Lureau

