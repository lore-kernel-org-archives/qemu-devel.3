Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A46D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 18:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ8WS-0002Zs-HM; Mon, 01 Dec 2025 13:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ8WQ-0002WT-7o
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vQ8WL-0002kW-T8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764613267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkXMthRTiTM5GHYrVj7Rm7EfEyNWge36/c1MBPatmJU=;
 b=hZyjzZoqomDKaMSNe5y6NtEdbc7jy/gwUPekqn+wNaCKMVbgJDIaCwMQAFh/4kNkLS/Pgz
 GNbfkCowClhY+elXNLsUvySTElLYCTSbMWnTTTQTLGVGbqYOfyPEVgRK8TtS4nBuRqYy+N
 70ETp4GFXRqoHVRyZ1X6MhE+E82D/WI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-frd-thlQNoCIod4xwq2e4A-1; Mon, 01 Dec 2025 13:21:02 -0500
X-MC-Unique: frd-thlQNoCIod4xwq2e4A-1
X-Mimecast-MFC-AGG-ID: frd-thlQNoCIod4xwq2e4A_1764613262
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34566e62f16so4556907a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764613262; x=1765218062; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkXMthRTiTM5GHYrVj7Rm7EfEyNWge36/c1MBPatmJU=;
 b=QenLwBfP9PRvIvaVdEk599U1NF1jQJdZCXDa5HhbXtl5SOCpi+/aGKl1n1wKEta1VL
 46sfBoMtTu/TAe20xTv//x/kf3ws49Pn4E/I2q+oGl7G9Z9SGanoyXPrbXZZEC4kQqQZ
 aIT9/038AIopM1k8OwZHp5fgsitVWvbYtUOR5prpN2mHIQQpxVeDB3k9Vjxc6B3fmJUv
 blxEYfz904maRUOV8GpGucz1dxszzAPfhMN8fMyMIKxyBkoJad6MI0puI9xR0zB66pqU
 F44jJ7VYIuzaGyR4x5jCr1c4K+C74NbSU5KnWNC4wVsb6FokuOj64p4wFDNLrfer1y8F
 FbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764613262; x=1765218062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkXMthRTiTM5GHYrVj7Rm7EfEyNWge36/c1MBPatmJU=;
 b=ZIlg09qNkEiM+dezBLIsM6EhCjQxrXmzIQ35YMNGOryX/Q8BuUwcml9nf3+9/eHjqi
 EIWT1FYIEKQfJ0zewmk3AqCu96QlRrDAJggL7xJU0HdpJRnxMs30RAZgmBWbQt6vaWSn
 V0R7xOP+V1KKpSuRbaXBaQs15Ud8bcNnN9WL9Tjns37/zgirvWU6WtZLThW9dbBI08SO
 jBVrdGj4lYVMLvn8BfHPzbCIJlrK1oZqyXomQEjpSOGgoQ2Mla5sbOc2xvgAa5LBnHN/
 LXaxaD2vYT3se+2QmiXda6Gia1UVDc1ywSel2mm2ngeAfS2Mgmnp1MGW2xWSeyiCYF26
 2gDg==
X-Gm-Message-State: AOJu0Yw8bVJJ6MZ9KW7il5iYnGew/6H0F9KRPQIJeui70U/c3aKm7KNd
 OSdtCfVm+p6ITISla+4Jm0peKknX95RTL9xDdqO6hT8b0116RtYMWBWTOq4RGhYIi+lkISdiICq
 lXXx5QaHlraWNsFNwWev4BIC+LcSH1J8oDRAq/S2YtxRglm/A4gLRrg69AXGAll7wIE402+8IBh
 utjdPih6OhTK5rDNi1yEI4PtX3a/o6JoA=
X-Gm-Gg: ASbGnctoQcTMgm0VL5/PMfdLgPwlSpbEvopYYCOZRw8GcMHWRLm/S4uah5tsTDsLcxE
 xo8nTC2BifkD2VM8+74Aq5vYOUYKcCfUMoJkylaO2WGIfJ3a1RhrwpG5RzO14HUUeC0Jq2oTgZO
 wNRZZSAcrsMCbllvf9WpQnGevim4QSVb0LeDi/VKmikkeGsnKw8wueV5yKmwNyIay93CPrZeim7
 bpg0AxBxZ2vUUKPMhbVhIsCng==
X-Received: by 2002:a17:90b:4a51:b0:32a:34d8:33d3 with SMTP id
 98e67ed59e1d1-34733d6eb30mr36114473a91.0.1764613261657; 
 Mon, 01 Dec 2025 10:21:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhIqsfGP+s1D6GRXJmpIKNNiuIBS31KoSBjfG9dKu5pvjry0gQR8/PlOi9tz837H63V+8txb+SbWLut333DNE=
X-Received: by 2002:a17:90b:4a51:b0:32a:34d8:33d3 with SMTP id
 98e67ed59e1d1-34733d6eb30mr36114439a91.0.1764613260984; Mon, 01 Dec 2025
 10:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
In-Reply-To: <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 1 Dec 2025 22:20:49 +0400
X-Gm-Features: AWmQ_bn5VMcn35YBGKPUvxlPh4RRButlyyNw2aaIA0ErHJh27qrZ7K44MF_RFOM
Message-ID: <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, geoff@hostfission.com
Content-Type: multipart/alternative; boundary="0000000000009658340644e80a2c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000009658340644e80a2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Dec 1, 2025 at 5:03=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:

> On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > The following patch series provides a GStreamer-based audio backend,
> which could
> > ultimately allow QEMU to leverage the framework to support the various
> audio
> > subsystems and simplify the audio handling logic (timing, resampling,
> mixing
> > etc), as well as allow greater pipeline flexibility and customization.
>
> While it's good to have a GStreamer backend to integrate well into system=
s
> already using that, this should not replace existing audio backends in
> QEMU. The reason is that GStreamer has extensive dependencies that I woul=
d
>

GStreamer itself is not so big and doesn't have that many dependencies that
qemu doesn't already have.


> like to avoid and still be able to use QEMU with just an ALSA or SDL audi=
o
> backend that are much leaner and provide the needed functionality for mos=
t
>

SDL audio is itself a wrapper for various audio backends, much like
GStreamer in the end, but with arguably less flexibility.


> cases. Also when using jack you'd want to have a QEMU backend for it not
> going through multiple layers. So adding a GStreamer backend has its use
>

I wonder what are the advantages of using JACK compared to ALSA, or
pulse/pipewire, tbh.


> as another audio backend but not as a replacement for QEMU's audio
> handling logic and backends.
>

It would be great if people with very specific or constrained requirements
on qemu audio could check if the GStreamer backend fits their need.


>
> Regards,
> BALATON Zoltan
>
> > The preliminary patches consist of additional cleanups started in QEMU
> 10.2, in
> > order to make the code more modular and use QOM.
> >
> > Finally, the last patch introduces the "audio" rust crate that
> implements the
> > GStreamer backend. See the TODO list in the commit message for the
> remaining or
> > related work items.
> >
> > Please review and test!
> >
> > Based-on: https://gitlab.com/bonzini/qemu.git rust-cargo
> > Requires meson from https://github.com/bonzini/meson.git
> cargo-object-full
> >
> > Marc-Andr=C3=A9 Lureau (24):
> >  rust: patch thiserror to work with meson
> >  audio: remove obsolete/obscure functions
> >  audio/dbus: make "dbus" the default backend when using -display dbus
> >  qemu-options.hx: clarify default audio backend selection
> >  audio: introduce AudioDriver
> >  audio: simplify audio_init()
> >  audio: move object creation to audio_driver_init()
> >  audio: add QOM module-objects for each backend
> >  audio: remove set_dbus_server from audio_driver
> >  audio: lookup "audio-" object types, and realize them
> >  audio: switch to module-object, drop audio driver registration
> >  module: remove audio module support
> >  audio: keep a strong reference on the backend
> >  audio: make list type declaration private
> >  audio: make create_pdos() private
> >  replay: remove dependency on audio/
> >  audio: make all the backend-specific APIs take the be
> >  audio: make AudioBackend truely abstract
> >  audio: split AudioBackend
> >  audio: AUD_ -> audio_be_
> >  audio-be: add common pre-conditions
> >  audio-be: add some state trace
> >  audio: split AudioDriver code in audio-driver.c
> >  WIP: rust/audio: add GStreamer backend
> >
> > qapi/audio.json                               |   29 +
> > ...dio_template.h =3D> audio-driver_template.h} |   76 +-
> > audio/audio_int.h                             |   50 +-
> > include/qemu/audio-capture.h                  |   24 +-
> > include/qemu/audio.h                          |  129 +-
> > include/qemu/module.h                         |    3 +-
> > include/system/replay.h                       |    8 +-
> > replay/replay-internal.h                      |    2 +
> > rust/audio/wrapper.h                          |   27 +
> > audio/alsaaudio.c                             |   42 +-
> > audio/audio-be.c                              |  276 ++
> > audio/audio-driver.c                          | 1988 +++++++++++++++
> > audio/audio.c                                 | 2248 ++---------------
> > audio/dbusaudio.c                             |   57 +-
> > audio/dsoundaudio.c                           |   37 +-
> > audio/jackaudio.c                             |   37 +-
> > audio/noaudio.c                               |   37 +-
> > audio/ossaudio.c                              |   41 +-
> > audio/paaudio.c                               |   37 +-
> > audio/pwaudio.c                               |   37 +-
> > audio/sdlaudio.c                              |   37 +-
> > audio/sndioaudio.c                            |   37 +-
> > audio/spiceaudio.c                            |   37 +-
> > audio/wavaudio.c                              |   37 +-
> > audio/wavcapture.c                            |    7 +-
> > hw/audio/ac97.c                               |   42 +-
> > hw/audio/adlib.c                              |   29 +-
> > hw/audio/asc.c                                |   20 +-
> > hw/audio/cs4231a.c                            |   18 +-
> > hw/audio/es1370.c                             |   26 +-
> > hw/audio/gus.c                                |   11 +-
> > hw/audio/hda-codec.c                          |   26 +-
> > hw/audio/lm4549.c                             |   20 +-
> > hw/audio/pcspk.c                              |    8 +-
> > hw/audio/sb16.c                               |   22 +-
> > hw/audio/via-ac97.c                           |   20 +-
> > hw/audio/virtio-snd.c                         |   36 +-
> > hw/audio/wm8750.c                             |   42 +-
> > hw/display/xlnx_dp.c                          |   14 +-
> > hw/usb/dev-audio.c                            |   18 +-
> > replay/replay-audio.c                         |   51 +-
> > replay/replay.c                               |    2 +-
> > replay/stubs-system.c                         |    8 +-
> > ui/dbus.c                                     |   16 +-
> > ui/vnc.c                                      |    4 +-
> > Cargo.lock                                    |  572 ++++-
> > Cargo.toml                                    |    6 +
> > audio/coreaudio.m                             |   37 +-
> > audio/meson.build                             |    2 +
> > audio/trace-events                            |    9 +
> > qemu-options.hx                               |   20 +-
> > rust/audio/Cargo.toml                         |   29 +
> > rust/audio/build.rs                           |   49 +
> > rust/audio/meson.build                        |   75 +
> > rust/audio/src/audio.rs                       |  516 ++++
> > rust/audio/src/bindings.rs                    |   32 +
> > rust/audio/src/gstreamer.rs                   | 1070 ++++++++
> > rust/audio/src/lib.rs                         |   99 +
> > rust/meson.build                              |    6 +
> > .../packagefiles/syn-2-rs/meson/meson.build   |    3 +
> > .../thiserror-2.0.17-include.patch            |   14 +
> > .../thiserror-impl-2.0.17-include.patch       |   13 +
> > subprojects/syn-2-rs.wrap                     |   11 +-
> > subprojects/thiserror-2-rs.wrap               |   10 +
> > subprojects/thiserror-impl-2-rs.wrap          |   10 +
> > 65 files changed, 5862 insertions(+), 2494 deletions(-)
> > rename audio/{audio_template.h =3D> audio-driver_template.h} (90%)
> > create mode 100644 rust/audio/wrapper.h
> > create mode 100644 audio/audio-be.c
> > create mode 100644 audio/audio-driver.c
> > create mode 100644 rust/audio/Cargo.toml
> > create mode 100644 rust/audio/build.rs
> > create mode 100644 rust/audio/meson.build
> > create mode 100644 rust/audio/src/audio.rs
> > create mode 100644 rust/audio/src/bindings.rs
> > create mode 100644 rust/audio/src/gstreamer.rs
> > create mode 100644 rust/audio/src/lib.rs
> > create mode 100644 subprojects/packagefiles/syn-2-rs/meson/meson.build
> > create mode 100644
> subprojects/packagefiles/thiserror-2.0.17-include.patch
> > create mode 100644
> subprojects/packagefiles/thiserror-impl-2.0.17-include.patch
> > create mode 100644 subprojects/thiserror-2-rs.wrap
> > create mode 100644 subprojects/thiserror-impl-2-rs.wrap
> >
> >

--0000000000009658340644e80a2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 1, 20=
25 at 5:03=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.=
hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Mon, 1 Dec 2025, <a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; The following patch series provides a GStreamer-based audio backend, w=
hich could<br>
&gt; ultimately allow QEMU to leverage the framework to support the various=
 audio<br>
&gt; subsystems and simplify the audio handling logic (timing, resampling, =
mixing<br>
&gt; etc), as well as allow greater pipeline flexibility and customization.=
<br>
<br>
While it&#39;s good to have a GStreamer backend to integrate well into syst=
ems <br>
already using that, this should not replace existing audio backends in <br>
QEMU. The reason is that GStreamer has extensive dependencies that I would =
<br></blockquote><div><br></div><div>GStreamer itself is not so big and doe=
sn&#39;t have that many dependencies that qemu doesn&#39;t already have.</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
like to avoid and still be able to use QEMU with just an ALSA or SDL audio =
<br>
backend that are much leaner and provide the needed functionality for most =
<br></blockquote><div><br></div><div>SDL audio is itself a wrapper for vari=
ous audio backends,=C2=A0much like GStreamer in the end,=C2=A0but with argu=
ably less flexibility.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
cases. Also when using jack you&#39;d want to have a QEMU backend for it no=
t <br>
going through multiple layers. So adding a GStreamer backend has its use <b=
r></blockquote><div><br></div><div>I wonder what are the advantages of usin=
g JACK compared to ALSA, or pulse/pipewire, tbh.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
as another audio backend but not as a replacement for QEMU&#39;s audio <br>
handling logic and backends.<br></blockquote><div><br></div><div>It would b=
e great if people with very specific or constrained requirements on qemu au=
dio could check if the GStreamer backend fits their need.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; The preliminary patches consist of additional cleanups started in QEMU=
 10.2, in<br>
&gt; order to make the code more modular and use QOM.<br>
&gt;<br>
&gt; Finally, the last patch introduces the &quot;audio&quot; rust crate th=
at implements the<br>
&gt; GStreamer backend. See the TODO list in the commit message for the rem=
aining or<br>
&gt; related work items.<br>
&gt;<br>
&gt; Please review and test!<br>
&gt;<br>
&gt; Based-on: <a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git</a> rust-cargo=
<br>
&gt; Requires meson from <a href=3D"https://github.com/bonzini/meson.git" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/bonzini/meson.git</a=
> cargo-object-full<br>
&gt;<br>
&gt; Marc-Andr=C3=A9 Lureau (24):<br>
&gt;=C2=A0 rust: patch thiserror to work with meson<br>
&gt;=C2=A0 audio: remove obsolete/obscure functions<br>
&gt;=C2=A0 audio/dbus: make &quot;dbus&quot; the default backend when using=
 -display dbus<br>
&gt;=C2=A0 qemu-options.hx: clarify default audio backend selection<br>
&gt;=C2=A0 audio: introduce AudioDriver<br>
&gt;=C2=A0 audio: simplify audio_init()<br>
&gt;=C2=A0 audio: move object creation to audio_driver_init()<br>
&gt;=C2=A0 audio: add QOM module-objects for each backend<br>
&gt;=C2=A0 audio: remove set_dbus_server from audio_driver<br>
&gt;=C2=A0 audio: lookup &quot;audio-&quot; object types, and realize them<=
br>
&gt;=C2=A0 audio: switch to module-object, drop audio driver registration<b=
r>
&gt;=C2=A0 module: remove audio module support<br>
&gt;=C2=A0 audio: keep a strong reference on the backend<br>
&gt;=C2=A0 audio: make list type declaration private<br>
&gt;=C2=A0 audio: make create_pdos() private<br>
&gt;=C2=A0 replay: remove dependency on audio/<br>
&gt;=C2=A0 audio: make all the backend-specific APIs take the be<br>
&gt;=C2=A0 audio: make AudioBackend truely abstract<br>
&gt;=C2=A0 audio: split AudioBackend<br>
&gt;=C2=A0 audio: AUD_ -&gt; audio_be_<br>
&gt;=C2=A0 audio-be: add common pre-conditions<br>
&gt;=C2=A0 audio-be: add some state trace<br>
&gt;=C2=A0 audio: split AudioDriver code in audio-driver.c<br>
&gt;=C2=A0 WIP: rust/audio: add GStreamer backend<br>
&gt;<br>
&gt; qapi/audio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A029 +<=
br>
&gt; ...dio_template.h =3D&gt; audio-driver_template.h} |=C2=A0 =C2=A076 +-=
<br>
&gt; audio/audio_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A050 +-<br>
&gt; include/qemu/audio-capture.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A024 +-<br>
&gt; include/qemu/audio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 129 +-<br>
&gt; include/qemu/module.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +-<br>
&gt; include/system/replay.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +-<br>
&gt; replay/replay-internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt; rust/audio/wrapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A027 +<br>
&gt; audio/alsaaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A042 +-<br>
&gt; audio/audio-be.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 276 ++<br>
&gt; audio/audio-driver.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1988 +++++++++++++++<br>
&gt; audio/audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2248 ++----=
-----------<br>
&gt; audio/dbusaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A057 +-<br>
&gt; audio/dsoundaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-<br>
&gt; audio/jackaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-<br>
&gt; audio/noaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-=
<br>
&gt; audio/ossaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A041 +-<br=
>
&gt; audio/paaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-=
<br>
&gt; audio/pwaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-=
<br>
&gt; audio/sdlaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A037 +-<br=
>
&gt; audio/sndioaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A037 +-<br>
&gt; audio/spiceaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A037 +-<br>
&gt; audio/wavaudio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A037 +-<br=
>
&gt; audio/wavcapture.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +-<br>
&gt; hw/audio/ac97.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A042 +-=
<br>
&gt; hw/audio/adlib.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A029 +-<br=
>
&gt; hw/audio/asc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A020 +-=
<br>
&gt; hw/audio/cs4231a.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A018 +-<br>
&gt; hw/audio/es1370.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A026 +-<br>
&gt; hw/audio/gus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +-=
<br>
&gt; hw/audio/hda-codec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A026 +-<br>
&gt; hw/audio/lm4549.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A020 +-<br>
&gt; hw/audio/pcspk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 8 +-<br=
>
&gt; hw/audio/sb16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A022 +-=
<br>
&gt; hw/audio/via-ac97.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A020 +-<br>
&gt; hw/audio/virtio-snd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A036 +-<br>
&gt; hw/audio/wm8750.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A042 +-<br>
&gt; hw/display/xlnx_dp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A014 +-<br>
&gt; hw/usb/dev-audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A018 +-<br>
&gt; replay/replay-audio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A051 +-<br>
&gt; replay/replay.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-=
<br>
&gt; replay/stubs-system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +-<br>
&gt; ui/dbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A016 +-<br>
&gt; ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 4 +-<br>
&gt; Cargo.lock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
572 ++++-<br>
&gt; Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 6 +<br>
&gt; audio/coreaudio.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A037 +-<br>
&gt; audio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br>
&gt; audio/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 9 +<br>
&gt; qemu-options.hx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A020 +-=
<br>
&gt; rust/audio/Cargo.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A029 +<br>
&gt; rust/audio/<a href=3D"http://build.rs" rel=3D"noreferrer" target=3D"_b=
lank">build.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A049 +<br>
&gt; rust/audio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A075 +<br>
&gt; rust/audio/src/<a href=3D"http://audio.rs" rel=3D"noreferrer" target=
=3D"_blank">audio.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 516 ++++<br>
&gt; rust/audio/src/<a href=3D"http://bindings.rs" rel=3D"noreferrer" targe=
t=3D"_blank">bindings.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A032 +<br>
&gt; rust/audio/src/<a href=3D"http://gstreamer.rs" rel=3D"noreferrer" targ=
et=3D"_blank">gstreamer.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 1070 ++++++++<br>
&gt; rust/audio/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=3D"=
_blank">lib.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A099 +<br>
&gt; rust/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
&gt; .../packagefiles/syn-2-rs/meson/meson.build=C2=A0 =C2=A0|=C2=A0 =C2=A0=
 3 +<br>
&gt; .../thiserror-2.0.17-include.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A014 +<br>
&gt; .../thiserror-impl-2.0.17-include.patch=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A013 +<br>
&gt; subprojects/syn-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A011 +-<br>
&gt; subprojects/thiserror-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 +<br>
&gt; subprojects/thiserror-impl-2-rs.wrap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A010 +<br>
&gt; 65 files changed, 5862 insertions(+), 2494 deletions(-)<br>
&gt; rename audio/{audio_template.h =3D&gt; audio-driver_template.h} (90%)<=
br>
&gt; create mode 100644 rust/audio/wrapper.h<br>
&gt; create mode 100644 audio/audio-be.c<br>
&gt; create mode 100644 audio/audio-driver.c<br>
&gt; create mode 100644 rust/audio/Cargo.toml<br>
&gt; create mode 100644 rust/audio/<a href=3D"http://build.rs" rel=3D"noref=
errer" target=3D"_blank">build.rs</a><br>
&gt; create mode 100644 rust/audio/meson.build<br>
&gt; create mode 100644 rust/audio/src/<a href=3D"http://audio.rs" rel=3D"n=
oreferrer" target=3D"_blank">audio.rs</a><br>
&gt; create mode 100644 rust/audio/src/<a href=3D"http://bindings.rs" rel=
=3D"noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; create mode 100644 rust/audio/src/<a href=3D"http://gstreamer.rs" rel=
=3D"noreferrer" target=3D"_blank">gstreamer.rs</a><br>
&gt; create mode 100644 rust/audio/src/<a href=3D"http://lib.rs" rel=3D"nor=
eferrer" target=3D"_blank">lib.rs</a><br>
&gt; create mode 100644 subprojects/packagefiles/syn-2-rs/meson/meson.build=
<br>
&gt; create mode 100644 subprojects/packagefiles/thiserror-2.0.17-include.p=
atch<br>
&gt; create mode 100644 subprojects/packagefiles/thiserror-impl-2.0.17-incl=
ude.patch<br>
&gt; create mode 100644 subprojects/thiserror-2-rs.wrap<br>
&gt; create mode 100644 subprojects/thiserror-impl-2-rs.wrap<br>
&gt;<br>
&gt;</blockquote></div></div>

--0000000000009658340644e80a2c--


