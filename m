Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C7D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3hX-0007eW-8R; Mon, 01 Dec 2025 08:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQ3hT-0007bQ-Gl
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:12:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQ3hP-0006m4-5L
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764594732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdZCcNebu58rRAcq7dcItAh2rzu+RqOqYxDStj16jN4=;
 b=h8oRY7u6hbHHsbhtXSeqz3k+4TeAiHbl576/0/cJ2WIjTBp7jCUZhI8Sim2k87Uyh4SsT4
 WJ9hxns199pLpGaDmvTHN2iJs0TI1pJvM31THZbLdgbeBMkmMIZe4JZcDDZdxdo8AXlMoo
 PJoIlQtGQoU1yt3fYmWqHWtx+UKn86E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-d-IW7-W9PxW01VVmKDNetg-1; Mon,
 01 Dec 2025 08:12:11 -0500
X-MC-Unique: d-IW7-W9PxW01VVmKDNetg-1
X-Mimecast-MFC-AGG-ID: d-IW7-W9PxW01VVmKDNetg_1764594729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3C65195608D; Mon,  1 Dec 2025 13:12:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7573180047F; Mon,  1 Dec 2025 13:12:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0139D21E6A27; Mon, 01 Dec 2025 14:12:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Thomas Huth
 <huth@tuxfamily.org>,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>,  dirty.ice.hu@gmail.com,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>,  Eric Blake
 <eblake@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-rust@nongnu.org (open
 list:Rust-related patc...)
Subject: Re: [RFC 24/24] WIP: rust/audio: add GStreamer backend
In-Reply-To: <20251201112309.4163921-25-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Mon, 1 Dec 2025 15:23:05 +0400")
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-25-marcandre.lureau@redhat.com>
Date: Mon, 01 Dec 2025 14:12:05 +0100
Message-ID: <87pl8y1h3u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> This patch introduce a rust/audio crate that replaces QEMU audio/
> mixing/resampling code with GStreamer and Rust. It could potentially
> remove the need for all the system-specific audio API implementation,
> since GStreamer has audio elements for
> ALSA/Pipewire/PulseAudio/jack/OSX/WASAPI etc (removing ~10k loc).
>
> TODO:
> - test on various system, with various configuration to see if this
>   backend can replace the other QEMU audio backends
> - add a spicesink/spicesrc to handle spice, or rewrite spice to use
>   the capture approach used by VNC code. Or drop capture support, and
>   use custom qemusrc/qemusink for both Spice and VNC, lowering the feature
>   and behaviour disparity.
> - build-sys: make gstreamer optional
> - build-sys: loadable module support
> - investigate dropping get_buffer_size_out()
> - investigate improving emulated devices to not require regular
>   timers (appsrc need-data is called once)
> - add generic audio backend tests
> - more tests for the mixing/liveadder behaviour (synchronization)
> - other: replace audio/dbus with a rust implementation (not using gstream=
er)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/audio.json               |   29 +
>  audio/audio-driver_template.h |    2 +
>  rust/audio/wrapper.h          |   27 +
>  audio/audio.c                 |    5 +
>  Cargo.lock                    |  572 ++++++++++++++++--
>  Cargo.toml                    |    6 +
>  audio/trace-events            |    5 +
>  rust/audio/Cargo.toml         |   29 +
>  rust/audio/build.rs           |   49 ++
>  rust/audio/meson.build        |   75 +++
>  rust/audio/src/audio.rs       |  516 ++++++++++++++++
>  rust/audio/src/bindings.rs    |   32 +
>  rust/audio/src/gstreamer.rs   | 1070 +++++++++++++++++++++++++++++++++
>  rust/audio/src/lib.rs         |   99 +++
>  rust/meson.build              |    6 +
>  15 files changed, 2467 insertions(+), 55 deletions(-)
>  create mode 100644 rust/audio/wrapper.h
>  create mode 100644 rust/audio/Cargo.toml
>  create mode 100644 rust/audio/build.rs
>  create mode 100644 rust/audio/meson.build
>  create mode 100644 rust/audio/src/audio.rs
>  create mode 100644 rust/audio/src/bindings.rs
>  create mode 100644 rust/audio/src/gstreamer.rs
>  create mode 100644 rust/audio/src/lib.rs
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 2df87b9710..76dc7cbfa6 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -128,6 +128,33 @@
>      '*out':       'AudiodevAlsaPerDirectionOptions',
>      '*threshold': 'uint32' } }
>=20=20
> +    ##
> +    # @AudiodevGStreamerOptions:
> +    #
> +    # Options of the GStreamer audio backend.
> +    #
> +    # @in: options of the capture stream
> +    #
> +    # @out: options of the playback stream
> +    #
> +    # @sink: the name of the GStreamer sink element to use
> +    #        (default 'autoaudiosink')
> +    #
> +    # @source: the name of the GStreamer source element to use
> +    #        (default 'autoaudiosrc')

Are 'autoaudiosink' and 'autoaudiosrc' well-known GStreamer names, or
arbitrary?

> +    #
> +    # Since: 11.0
> +    ##
> +    { 'struct': 'AudiodevGStreamerOptions',
> +      'data': {
> +        '*in':        'AudiodevPerDirectionOptions',
> +        '*out':       'AudiodevPerDirectionOptions',
> +        '*sink':      'str',
> +        '*source':    'str'
> +      }
> +    }

Unindent by four, and format the doc comment like this:

##
# @AudiodevGStreamerOptions:
#
# Options of the GStreamer audio backend.
#
# @in: options of the capture stream
#
# @out: options of the playback stream
#
# @sink: the name of the GStreamer sink element to use
#     (default 'autoaudiosink')
#
# @source: the name of the GStreamer source element to use
#     (default 'autoaudiosrc')
#
# Since: 11.0
##


> +
> +
>  ##
>  # @AudiodevSndioOptions:
>  #
> @@ -484,6 +511,7 @@
>              { 'name': 'sdl', 'if': 'CONFIG_AUDIO_SDL' },
>              { 'name': 'sndio', 'if': 'CONFIG_AUDIO_SNDIO' },
>              { 'name': 'spice', 'if': 'CONFIG_SPICE' },
> +            { 'name': 'gstreamer' },

Short form suffices:

               'gstreamer',

>              'wav' ] }
>=20=20
>  ##
> @@ -530,6 +558,7 @@
>                     'if': 'CONFIG_AUDIO_SNDIO' },
>      'spice':     { 'type': 'AudiodevGenericOptions',
>                     'if': 'CONFIG_SPICE' },
> +    'gstreamer': { 'type': 'AudiodevGStreamerOptions' },

Short form suffices:

       'gstreamer': 'AudiodevGStreamerOptions',

>      'wav':       'AudiodevWavOptions' } }
>=20=20
>  ##

[...]


