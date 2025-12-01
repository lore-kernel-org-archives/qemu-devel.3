Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C45FD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 18:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ8bX-0004oB-PS; Mon, 01 Dec 2025 13:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQ8bQ-0004nk-S5
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:26:24 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vQ8bN-0003de-6p
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 13:26:24 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4ed82ee9e57so58001511cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 10:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764613579; x=1765218379; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN01+63+EeTohwdDreZ2DzDX4iyn1BgZN3+b0Y3x1b0=;
 b=FGJMiyZqqmV6ALJ1kLyJzER437WvW5jdmTkNGiq2beFi/FLQv5EEEv1LK2CMODj58P
 UnHO0TA3CXwpKxJMK3F4e1B59Z4dENApY+HHTEd1mujtm1q0bQUhFRyr2/BP1Qs+PMW4
 5cAPpDfnTQx4SbpcQL3LgDFGvr7NYFAXx0N+vKxu02dn2PmwT8lRjhk1lDeAC+BfS+Xi
 FJRsYvdcXHMSk3th/210G2qeCEVwQ4po/pE9799N6MXDPHIAIzhF5hX/IDc/3SXBbxxo
 910yt51qh3YeYzWecRUjNjsDOEj4SaaLy/yW2+HIyghhg43EPfmWTMBjvm0MWrlZmGkX
 mD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764613579; x=1765218379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JN01+63+EeTohwdDreZ2DzDX4iyn1BgZN3+b0Y3x1b0=;
 b=oiagBu8Gr1RV5+DjLNtAHg/J3H5dMIXDD3tHeHIOmAd+12Skx8KmdelnUdaP6Vvbyd
 6DbhgUadFFyp/mhJX3++tr7GkRnywnDwfgUDwvxQ/ZoEVpfhkwUCsgGqIZIo3ZTcaKZo
 es7QCo9bnjtC9aNeh2+6Jz1gq/qip8llQKrlTmqkYhC1ynymMRqoELKgndXuGUt4f0LI
 09dL0xWtpW/bHBzk4MhwuXShRiQqyB93YHT8RuebAvA98GDGQzp3R2esaBpKqjtE6ZbL
 Xb+QQ8YkkGbRn4Jz9Kp2kjPejf6Jk6x6W1mzXlPqmgm+sPlDNO8M99bnAtPtc+YU4jqi
 vNgQ==
X-Gm-Message-State: AOJu0YyRddYckvXP34RmgWmcks8u8GBMsEZVmuKf7QR9esnX6/IgGWhi
 M4fB2GYbebYXZ0njL0F9aiYec6TDRHFrUn+VWVLCEVE4orha6eiYY91gQC+YwHfr0ImFywwEBym
 05aWfE1JjZ3vfDQyn5zpg6T77wCTjfOw=
X-Gm-Gg: ASbGncs3LdkpCknilZhXDeGGJ/rFiys9lVbfXP/qLQvsDZqh+e9C8sRAhZNDNVRvVfe
 X5Q427Sp5agmCh/fYhLHJME3g1M3csJPPCaeHFeLVOFVXo2hXBne9CeU5/KRbsyONrXJHmdIQAf
 L8BuLcn6VTntjI6y23seUy2jRYET0j8F0MqoUR3ZoQ5HtRRRIejVAzTKj5abEJjpkK6AF7TrOEi
 H+NZTf8e4qM9qdZjr8XoFuwX6+LVRbpNVoncmb0HgP8x8sVBrqQtQln5dmi2jKdeSNh0FouuvK1
 8JTZP6wSVqoFhQpz/7WgRc2IxC4=
X-Google-Smtp-Source: AGHT+IHqvg+pQ5RNToGbvd2Mcg68+D2n/p+B9o2jWnTn4/o1aEfTseoylYxlumqFd89zPO5CZxhqrI52J9RfQT1XsWo=
X-Received: by 2002:a05:622a:409:b0:4ee:296c:c7cf with SMTP id
 d75a77b69052e-4ee58af74dbmr570189691cf.71.1764613578438; Mon, 01 Dec 2025
 10:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-25-marcandre.lureau@redhat.com>
 <87pl8y1h3u.fsf@pond.sub.org>
In-Reply-To: <87pl8y1h3u.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 1 Dec 2025 22:26:06 +0400
X-Gm-Features: AWmQ_blgNSDHhT49ceRMHDXcMYNnXObve2BdY3atX99zcSMn5CAIVNKBXYaoLmE
Message-ID: <CAJ+F1C+w+eGs+1YNCL1ZxsFxu29zz_Ef+Fr=7SzUEpjdoONpSQ@mail.gmail.com>
Subject: Re: [RFC 24/24] WIP: rust/audio: add GStreamer backend
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi Markus

On Mon, Dec 1, 2025 at 5:13=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This patch introduce a rust/audio crate that replaces QEMU audio/
> > mixing/resampling code with GStreamer and Rust. It could potentially
> > remove the need for all the system-specific audio API implementation,
> > since GStreamer has audio elements for
> > ALSA/Pipewire/PulseAudio/jack/OSX/WASAPI etc (removing ~10k loc).
> >
> > TODO:
> > - test on various system, with various configuration to see if this
> >   backend can replace the other QEMU audio backends
> > - add a spicesink/spicesrc to handle spice, or rewrite spice to use
> >   the capture approach used by VNC code. Or drop capture support, and
> >   use custom qemusrc/qemusink for both Spice and VNC, lowering the feat=
ure
> >   and behaviour disparity.
> > - build-sys: make gstreamer optional
> > - build-sys: loadable module support
> > - investigate dropping get_buffer_size_out()
> > - investigate improving emulated devices to not require regular
> >   timers (appsrc need-data is called once)
> > - add generic audio backend tests
> > - more tests for the mixing/liveadder behaviour (synchronization)
> > - other: replace audio/dbus with a rust implementation (not using gstre=
amer)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/audio.json               |   29 +
> >  audio/audio-driver_template.h |    2 +
> >  rust/audio/wrapper.h          |   27 +
> >  audio/audio.c                 |    5 +
> >  Cargo.lock                    |  572 ++++++++++++++++--
> >  Cargo.toml                    |    6 +
> >  audio/trace-events            |    5 +
> >  rust/audio/Cargo.toml         |   29 +
> >  rust/audio/build.rs           |   49 ++
> >  rust/audio/meson.build        |   75 +++
> >  rust/audio/src/audio.rs       |  516 ++++++++++++++++
> >  rust/audio/src/bindings.rs    |   32 +
> >  rust/audio/src/gstreamer.rs   | 1070 +++++++++++++++++++++++++++++++++
> >  rust/audio/src/lib.rs         |   99 +++
> >  rust/meson.build              |    6 +
> >  15 files changed, 2467 insertions(+), 55 deletions(-)
> >  create mode 100644 rust/audio/wrapper.h
> >  create mode 100644 rust/audio/Cargo.toml
> >  create mode 100644 rust/audio/build.rs
> >  create mode 100644 rust/audio/meson.build
> >  create mode 100644 rust/audio/src/audio.rs
> >  create mode 100644 rust/audio/src/bindings.rs
> >  create mode 100644 rust/audio/src/gstreamer.rs
> >  create mode 100644 rust/audio/src/lib.rs
> >
> > diff --git a/qapi/audio.json b/qapi/audio.json
> > index 2df87b9710..76dc7cbfa6 100644
> > --- a/qapi/audio.json
> > +++ b/qapi/audio.json
> > @@ -128,6 +128,33 @@
> >      '*out':       'AudiodevAlsaPerDirectionOptions',
> >      '*threshold': 'uint32' } }
> >
> > +    ##
> > +    # @AudiodevGStreamerOptions:
> > +    #
> > +    # Options of the GStreamer audio backend.
> > +    #
> > +    # @in: options of the capture stream
> > +    #
> > +    # @out: options of the playback stream
> > +    #
> > +    # @sink: the name of the GStreamer sink element to use
> > +    #        (default 'autoaudiosink')
> > +    #
> > +    # @source: the name of the GStreamer source element to use
> > +    #        (default 'autoaudiosrc')
>
> Are 'autoaudiosink' and 'autoaudiosrc' well-known GStreamer names, or
> arbitrary?

Yes, they are well-known elements from the base plugins.

>
> > +    #
> > +    # Since: 11.0
> > +    ##
> > +    { 'struct': 'AudiodevGStreamerOptions',
> > +      'data': {
> > +        '*in':        'AudiodevPerDirectionOptions',
> > +        '*out':       'AudiodevPerDirectionOptions',
> > +        '*sink':      'str',
> > +        '*source':    'str'
> > +      }
> > +    }
>
> Unindent by four, and format the doc comment like this:
>
> ##
> # @AudiodevGStreamerOptions:
> #
> # Options of the GStreamer audio backend.
> #
> # @in: options of the capture stream
> #
> # @out: options of the playback stream
> #
> # @sink: the name of the GStreamer sink element to use
> #     (default 'autoaudiosink')
> #
> # @source: the name of the GStreamer source element to use
> #     (default 'autoaudiosrc')
> #
> # Since: 11.0
> ##
>
>
> > +
> > +
> >  ##
> >  # @AudiodevSndioOptions:
> >  #
> > @@ -484,6 +511,7 @@
> >              { 'name': 'sdl', 'if': 'CONFIG_AUDIO_SDL' },
> >              { 'name': 'sndio', 'if': 'CONFIG_AUDIO_SNDIO' },
> >              { 'name': 'spice', 'if': 'CONFIG_SPICE' },
> > +            { 'name': 'gstreamer' },
>
> Short form suffices:
>
>                'gstreamer',
>
> >              'wav' ] }
> >
> >  ##
> > @@ -530,6 +558,7 @@
> >                     'if': 'CONFIG_AUDIO_SNDIO' },
> >      'spice':     { 'type': 'AudiodevGenericOptions',
> >                     'if': 'CONFIG_SPICE' },
> > +    'gstreamer': { 'type': 'AudiodevGStreamerOptions' },
>
> Short form suffices:
>
>        'gstreamer': 'AudiodevGStreamerOptions',
>
> >      'wav':       'AudiodevWavOptions' } }
> >
> >  ##
>
> [...]
>
>

Thanks for the early check, I will likely have to update the schema in
future revision, for making GStreamer optional & module to the very
least.

--=20
Marc-Andr=C3=A9 Lureau

