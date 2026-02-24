Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DB4EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 08:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vunNj-0007jm-9e; Tue, 24 Feb 2026 03:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vunNh-0007jd-Qs
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vunNe-0000At-O1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 03:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771920172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApJ/6fwNECocsPr0eCnFbEoW8TIlqBkpDVyOp+l/H+M=;
 b=JaX19LqNQfYE+nV2vnBWj+8lH+EZVb4yRm/aeShHcIwT5qdqlbUhYWnySAgX/CByAztzwb
 Sf/z3AP7X/Q/PRBggPxnESFqGSylx/kaYTxq8UKTFGwnTxboaHU37UROSdRh3lhf2YlY9N
 hAJkLfmNvchdfaw094CguVDHNW1Q8M0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-BwNm-wAUOSujOkEWbekMlA-1; Tue,
 24 Feb 2026 03:02:49 -0500
X-MC-Unique: BwNm-wAUOSujOkEWbekMlA-1
X-Mimecast-MFC-AGG-ID: BwNm-wAUOSujOkEWbekMlA_1771920167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FBCA195608A; Tue, 24 Feb 2026 08:02:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 672F51955F43; Tue, 24 Feb 2026 08:02:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0195321E692D; Tue, 24 Feb 2026 09:02:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Eric Blake
 <eblake@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 09/10] audio: do not build audio-related sources with
 --disable-audio
In-Reply-To: <20260223202512.1308205-10-heifetz@yandex-team.com> (Sergei
 Heifetz's message of "Tue, 24 Feb 2026 01:25:11 +0500")
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-10-heifetz@yandex-team.com>
Date: Tue, 24 Feb 2026 09:02:42 +0100
Message-ID: <87o6le602l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sergei Heifetz <heifetz@yandex-team.com> writes:

> When QEMU is configured with `--disable-audio`, do not build any
> audio-related sources.
>
> - audio/meson.build and replay/meson.build:
>   Exclude audio-related sources when audio is disabled.
>
> - audio/audio-stub.c:
>   Provide a minimal set of straightforward stubs.
>
> - replay/replay-audio-stub.c:
>   Move the existing stubs from replay/stubs-system.c into a separate
>   file.
>
> - qapi/audio.json:
>   Remove the QMP `query-audiodevs` command.
>
> - hmp-commands*.hx:
>   Remove the HMP `info capture`, `stopcapture` and `wavcapture`
>   commands.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

[...]

> diff --git a/qapi/audio.json b/qapi/audio.json
> index 2df87b9710..28fda7c8ac 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -540,4 +540,5 @@
>  # Since: 8.0
>  ##
>  { 'command': 'query-audiodevs',
> -  'returns': ['Audiodev'] }
> +  'returns': ['Audiodev'],
> +  'if': 'CONFIG_AUDIO' }

You compile out just the command, and keep all the audio types.

According to the cover letter: "In [certain] environments it is
generally beneficial to avoid building unused code, for both security
and maintenance reasons."  True.  But if we still need the audio types,
could there be more code we'd rather not build?

To find out, I emptied out qapi/audio.json completely, then fixed what
broke without regard for neatness.  Diff appended.

I'm not demanding anything here.  I merely want to show where audio
stuff is still used, so we can make an informed decision on where
exactly to make the cut.

[...]



diff --git a/qapi/audio.json b/qapi/audio.json
index 28fda7c8ac..e69de29bb2 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -1,544 +0,0 @@
-# -*- mode: python -*-
-# vim: filetype=3Dpython
-#
-# Copyright (C) 2015-2019 Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <DirtY.iCE.hu@=
gmail.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-
-##
-# *****
-# Audio
-# *****
-##
-
-##
-# @AudiodevPerDirectionOptions:
-#
-# General audio backend options that are used for both playback and
-# recording.
-#
-# @mixing-engine: use QEMU's mixing engine to mix all streams inside
-#     QEMU and convert audio formats when not supported by the
-#     backend.  When set to off, fixed-settings must be also off
-#     (default on, since 4.2)
-#
-# @fixed-settings: use fixed settings for host input/output.  When
-#     off, frequency, channels and format must not be specified
-#     (default true)
-#
-# @frequency: frequency to use when using fixed settings (default
-#     44100)
-#
-# @channels: number of channels when using fixed settings (default 2)
-#
-# @voices: number of voices to use (default 1)
-#
-# @format: sample format to use when using fixed settings (default
-#     s16)
-#
-# @buffer-length: the buffer length in microseconds
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*mixing-engine':  'bool',
-    '*fixed-settings': 'bool',
-    '*frequency':      'uint32',
-    '*channels':       'uint32',
-    '*voices':         'uint32',
-    '*format':         'AudioFormat',
-    '*buffer-length':  'uint32' } }
-
-##
-# @AudiodevGenericOptions:
-#
-# Generic driver-specific options.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevGenericOptions',
-  'data': {
-    '*in':  'AudiodevPerDirectionOptions',
-    '*out': 'AudiodevPerDirectionOptions' } }
-
-##
-# @AudiodevDBusOptions:
-#
-# Options of the D-Bus audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @nsamples: set the number of samples per read/write calls
-#     (default to 480, 10ms at 48kHz).
-#
-# Since: 10.0
-##
-{ 'struct': 'AudiodevDBusOptions',
-  'data': {
-    '*in':  'AudiodevPerDirectionOptions',
-    '*out': 'AudiodevPerDirectionOptions',
-    '*nsamples': 'uint32'} }
-
-##
-# @AudiodevAlsaPerDirectionOptions:
-#
-# Options of the ALSA backend that are used for both playback and
-# recording.
-#
-# @dev: the name of the ALSA device to use (default 'default')
-#
-# @period-length: the period length in microseconds
-#
-# @try-poll: attempt to use poll mode, falling back to non-polling
-#     access on failure (default false)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevAlsaPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*dev':           'str',
-    '*period-length': 'uint32',
-    '*try-poll':      'bool' } }
-
-##
-# @AudiodevAlsaOptions:
-#
-# Options of the ALSA audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @threshold: set the threshold (in microseconds) when playback starts
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevAlsaOptions',
-  'data': {
-    '*in':        'AudiodevAlsaPerDirectionOptions',
-    '*out':       'AudiodevAlsaPerDirectionOptions',
-    '*threshold': 'uint32' } }
-
-##
-# @AudiodevSndioOptions:
-#
-# Options of the sndio audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @dev: the name of the sndio device to use (default 'default')
-#
-# @latency: play buffer size (in microseconds)
-#
-# Since: 7.2
-##
-{ 'struct': 'AudiodevSndioOptions',
-  'data': {
-    '*in':        'AudiodevPerDirectionOptions',
-    '*out':       'AudiodevPerDirectionOptions',
-    '*dev':       'str',
-    '*latency':   'uint32'} }
-
-##
-# @AudiodevCoreaudioPerDirectionOptions:
-#
-# Options of the Core Audio backend that are used for both playback
-# and recording.
-#
-# @buffer-count: number of buffers
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevCoreaudioPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*buffer-count': 'uint32' } }
-
-##
-# @AudiodevCoreaudioOptions:
-#
-# Options of the coreaudio audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevCoreaudioOptions',
-  'data': {
-    '*in':  'AudiodevCoreaudioPerDirectionOptions',
-    '*out': 'AudiodevCoreaudioPerDirectionOptions' } }
-
-##
-# @AudiodevDsoundOptions:
-#
-# Options of the DirectSound audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @latency: add extra latency to playback in microseconds (default
-#     10000)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevDsoundOptions',
-  'data': {
-    '*in':      'AudiodevPerDirectionOptions',
-    '*out':     'AudiodevPerDirectionOptions',
-    '*latency': 'uint32' } }
-
-##
-# @AudiodevJackPerDirectionOptions:
-#
-# Options of the JACK backend that are used for both playback and
-# recording.
-#
-# @server-name: select from among several possible concurrent server
-#     instances (default: environment variable $JACK_DEFAULT_SERVER if
-#     set, else "default")
-#
-# @client-name: the client name to use.  The server will modify this
-#     name to create a unique variant, if needed unless @exact-name is
-#     true (default: the guest's name)
-#
-# @connect-ports: if set, a regular expression of JACK client port
-#     name(s) to monitor for and automatically connect to
-#
-# @start-server: start a jack server process if one is not already
-#     present (default: false)
-#
-# @exact-name: use the exact name requested otherwise JACK
-#     automatically generates a unique one, if needed (default: false)
-#
-# Since: 5.1
-##
-{ 'struct': 'AudiodevJackPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*server-name':   'str',
-    '*client-name':   'str',
-    '*connect-ports': 'str',
-    '*start-server':  'bool',
-    '*exact-name':    'bool' } }
-
-##
-# @AudiodevJackOptions:
-#
-# Options of the JACK audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# Since: 5.1
-##
-{ 'struct': 'AudiodevJackOptions',
-  'data': {
-    '*in':  'AudiodevJackPerDirectionOptions',
-    '*out': 'AudiodevJackPerDirectionOptions' } }
-
-##
-# @AudiodevOssPerDirectionOptions:
-#
-# Options of the OSS backend that are used for both playback and
-# recording.
-#
-# @dev: file name of the OSS device (default '/dev/dsp')
-#
-# @buffer-count: number of buffers
-#
-# @try-poll: attempt to use poll mode, falling back to non-polling
-#     access on failure (default true)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevOssPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*dev':          'str',
-    '*buffer-count': 'uint32',
-    '*try-poll':     'bool' } }
-
-##
-# @AudiodevOssOptions:
-#
-# Options of the OSS audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @try-mmap: try using memory-mapped access, falling back to
-#     non-memory-mapped access on failure (default true)
-#
-# @exclusive: open device in exclusive mode (vmix won't work) (default
-#     false)
-#
-# @dsp-policy: set the timing policy of the device (between 0 and 10,
-#     where smaller number means smaller latency but higher CPU usage)
-#     or -1 to use fragment mode (option ignored on some platforms)
-#     (default 5)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevOssOptions',
-  'data': {
-    '*in':         'AudiodevOssPerDirectionOptions',
-    '*out':        'AudiodevOssPerDirectionOptions',
-    '*try-mmap':   'bool',
-    '*exclusive':  'bool',
-    '*dsp-policy': 'uint32' } }
-
-##
-# @AudiodevPaPerDirectionOptions:
-#
-# Options of the Pulseaudio backend that are used for both playback
-# and recording.
-#
-# @name: name of the sink/source to use
-#
-# @stream-name: name of the PulseAudio stream created by QEMU.  Can be
-#     used to identify the stream in PulseAudio when you create
-#     multiple PulseAudio devices or run multiple QEMU instances
-#     (default: audiodev's id, since 4.2)
-#
-# @latency: latency you want PulseAudio to achieve in microseconds
-#     (default 15000)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevPaPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*name': 'str',
-    '*stream-name': 'str',
-    '*latency': 'uint32' } }
-
-##
-# @AudiodevPaOptions:
-#
-# Options of the PulseAudio audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @server: PulseAudio server address (default: let PulseAudio choose)
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevPaOptions',
-  'data': {
-    '*in':     'AudiodevPaPerDirectionOptions',
-    '*out':    'AudiodevPaPerDirectionOptions',
-    '*server': 'str' } }
-
-##
-# @AudiodevPipewirePerDirectionOptions:
-#
-# Options of the PipeWire backend that are used for both playback and
-# recording.
-#
-# @name: name of the sink/source to use
-#
-# @stream-name: name of the PipeWire stream created by QEMU.  Can be
-#     used to identify the stream in PipeWire when you create multiple
-#     PipeWire devices or run multiple QEMU instances (default:
-#     audiodev's id)
-#
-# @latency: latency you want PipeWire to achieve in microseconds
-#     (default 46000)
-#
-# Since: 8.1
-##
-{ 'struct': 'AudiodevPipewirePerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*name': 'str',
-    '*stream-name': 'str',
-    '*latency': 'uint32' } }
-
-##
-# @AudiodevPipewireOptions:
-#
-# Options of the PipeWire audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# Since: 8.1
-##
-{ 'struct': 'AudiodevPipewireOptions',
-  'data': {
-    '*in':     'AudiodevPipewirePerDirectionOptions',
-    '*out':    'AudiodevPipewirePerDirectionOptions' } }
-
-##
-# @AudiodevSdlPerDirectionOptions:
-#
-# Options of the SDL audio backend that are used for both playback and
-# recording.
-#
-# @buffer-count: number of buffers (default 4)
-#
-# Since: 6.0
-##
-{ 'struct': 'AudiodevSdlPerDirectionOptions',
-  'base': 'AudiodevPerDirectionOptions',
-  'data': {
-    '*buffer-count': 'uint32' } }
-
-##
-# @AudiodevSdlOptions:
-#
-# Options of the SDL audio backend.
-#
-# @in: options of the recording stream
-#
-# @out: options of the playback stream
-#
-# Since: 6.0
-##
-{ 'struct': 'AudiodevSdlOptions',
-  'data': {
-    '*in':  'AudiodevSdlPerDirectionOptions',
-    '*out': 'AudiodevSdlPerDirectionOptions' } }
-
-##
-# @AudiodevWavOptions:
-#
-# Options of the wav audio backend.
-#
-# @in: options of the capture stream
-#
-# @out: options of the playback stream
-#
-# @path: name of the wav file to record (default 'qemu.wav')
-#
-# Since: 4.0
-##
-{ 'struct': 'AudiodevWavOptions',
-  'data': {
-    '*in':   'AudiodevPerDirectionOptions',
-    '*out':  'AudiodevPerDirectionOptions',
-    '*path': 'str' } }
-
-##
-# @AudioFormat:
-#
-# An enumeration of possible audio formats.
-#
-# @u8: unsigned 8 bit integer
-#
-# @s8: signed 8 bit integer
-#
-# @u16: unsigned 16 bit integer
-#
-# @s16: signed 16 bit integer
-#
-# @u32: unsigned 32 bit integer
-#
-# @s32: signed 32 bit integer
-#
-# @f32: single precision floating-point (since 5.0)
-#
-# Since: 4.0
-##
-{ 'enum': 'AudioFormat',
-  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
-
-##
-# @AudiodevDriver:
-#
-# An enumeration of possible audio backend drivers.
-#
-# @jack: JACK audio backend (since 5.1)
-#
-# Since: 4.0
-##
-{ 'enum': 'AudiodevDriver',
-  'data': [ 'none',
-            { 'name': 'alsa', 'if': 'CONFIG_AUDIO_ALSA' },
-            { 'name': 'coreaudio', 'if': 'CONFIG_AUDIO_COREAUDIO' },
-            { 'name': 'dbus', 'if': 'CONFIG_DBUS_DISPLAY' },
-            { 'name': 'dsound', 'if': 'CONFIG_AUDIO_DSOUND' },
-            { 'name': 'jack', 'if': 'CONFIG_AUDIO_JACK' },
-            { 'name': 'oss', 'if': 'CONFIG_AUDIO_OSS' },
-            { 'name': 'pa', 'if': 'CONFIG_AUDIO_PA' },
-            { 'name': 'pipewire', 'if': 'CONFIG_AUDIO_PIPEWIRE' },
-            { 'name': 'sdl', 'if': 'CONFIG_AUDIO_SDL' },
-            { 'name': 'sndio', 'if': 'CONFIG_AUDIO_SNDIO' },
-            { 'name': 'spice', 'if': 'CONFIG_SPICE' },
-            'wav' ] }
-
-##
-# @Audiodev:
-#
-# Options of an audio backend.
-#
-# @id: identifier of the backend
-#
-# @driver: the backend driver to use
-#
-# @timer-period: timer period (in microseconds, 0: use lowest
-#     possible)
-#
-# Since: 4.0
-##
-{ 'union': 'Audiodev',
-  'base': {
-    'id':            'str',
-    'driver':        'AudiodevDriver',
-    '*timer-period': 'uint32' },
-  'discriminator': 'driver',
-  'data': {
-    'none':      'AudiodevGenericOptions',
-    'alsa':      { 'type': 'AudiodevAlsaOptions',
-                   'if': 'CONFIG_AUDIO_ALSA' },
-    'coreaudio': { 'type': 'AudiodevCoreaudioOptions',
-                   'if': 'CONFIG_AUDIO_COREAUDIO' },
-    'dbus':      { 'type': 'AudiodevDBusOptions',
-                   'if': 'CONFIG_DBUS_DISPLAY' },
-    'dsound':    { 'type': 'AudiodevDsoundOptions',
-                   'if': 'CONFIG_AUDIO_DSOUND' },
-    'jack':      { 'type': 'AudiodevJackOptions',
-                   'if': 'CONFIG_AUDIO_JACK' },
-    'oss':       { 'type': 'AudiodevOssOptions',
-                   'if': 'CONFIG_AUDIO_OSS' },
-    'pa':        { 'type': 'AudiodevPaOptions',
-                   'if': 'CONFIG_AUDIO_PA' },
-    'pipewire':  { 'type': 'AudiodevPipewireOptions',
-                   'if': 'CONFIG_AUDIO_PIPEWIRE' },
-    'sdl':       { 'type': 'AudiodevSdlOptions',
-                   'if': 'CONFIG_AUDIO_SDL' },
-    'sndio':     { 'type': 'AudiodevSndioOptions',
-                   'if': 'CONFIG_AUDIO_SNDIO' },
-    'spice':     { 'type': 'AudiodevGenericOptions',
-                   'if': 'CONFIG_SPICE' },
-    'wav':       'AudiodevWavOptions' } }
-
-##
-# @query-audiodevs:
-#
-# Return information about audiodev configuration
-#
-# Since: 8.0
-##
-{ 'command': 'query-audiodevs',
-  'returns': ['Audiodev'],
-  'if': 'CONFIG_AUDIO' }
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index f1319c9002..f80f6c98d4 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -8,6 +8,8 @@
=20
 #include "audio.h"
=20
+#ifdef CONFIG_AUDIO
+
 struct capture_ops {
     void (*info) (void *opaque);
     void (*destroy) (void *opaque);
@@ -30,4 +32,6 @@ void audio_be_del_capture(
     CaptureVoiceOut *cap,
     void *cb_opaque);
=20
+#endif
+
 #endif /* QEMU_AUDIO_CAPTURE_H */
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index cff8a334f3..552689116c 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -32,6 +32,8 @@
 #include "gio/gio.h"
 #endif
=20
+#ifdef CONFIG_AUDIO
+
 typedef void (*audio_callback_fn) (void *opaque, int avail);
=20
 typedef struct audsettings {
@@ -240,4 +242,7 @@ static inline bool audio_format_is_signed(AudioFormat f=
mt)
 #define TYPE_AUDIO_BACKEND "audio-backend"
 OBJECT_DECLARE_TYPE(AudioBackend, AudioBackendClass, AUDIO_BACKEND)
=20
+#else
+#define audio_cleanup() ((void)0)
+#endif
 #endif /* QEMU_AUDIO_H */
diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b5..89e0199be1 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -184,7 +184,9 @@ struct VncDisplay
     VncDisplaySASL sasl;
 #endif
=20
+#ifdef CONFIG_AUDIO
     AudioBackend *audio_be;
+#endif
=20
     VMChangeStateEntry *vmstate_handler_entry;
 };
@@ -325,8 +327,10 @@ struct VncState
     pixman_format_code_t client_format;
     int client_endian; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
=20
+#ifdef CONFIG_AUDIO
     CaptureVoiceOut *audio_cap;
     struct audsettings as;
+#endif
=20
     VncReadEvent *read_handler;
     size_t read_handler_expect;
diff --git a/audio/audio-stub.c b/audio/audio-stub.c
index f58f88cd83..e69de29bb2 100644
--- a/audio/audio-stub.c
+++ b/audio/audio-stub.c
@@ -1,22 +0,0 @@
-/*
- * Stub for audio.c
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qapi/qapi-commands-audio.h"
-#include "qemu/audio.h"
-#include "qapi/error.h"
-
-void audio_cleanup(void) {}
-
-AudioBackend *audio_be_by_name(const char *name, Error **errp)
-{
-  error_setg(errp, "audio disabled");
-  return NULL;
-}
-
-void audio_init_audiodevs(void) {}
-
-void audio_create_default_audiodevs(void) {}
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d4ef620c17..12fbe0b0a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -750,6 +750,7 @@ static char *machine_get_audiodev(Object *obj, Error **=
errp)
 static void machine_set_audiodev(Object *obj, const char *value,
                                  Error **errp)
 {
+#ifdef CONFIG_AUDIO
     MachineState *ms =3D MACHINE(obj);
=20
     if (!audio_be_by_name(value, errp)) {
@@ -758,6 +759,9 @@ static void machine_set_audiodev(Object *obj, const cha=
r *value,
=20
     g_free(ms->audiodev);
     ms->audiodev =3D g_strdup(value);
+#else
+    error_setg(errp, "audio disabled");
+#endif
 }
=20
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
diff --git a/system/vl.c b/system/vl.c
index 1034a4688f..6b2e7bc26e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2067,10 +2067,12 @@ static void qemu_create_early_backends(void)
      * setting machine properties, so they can be referred to.
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
+#ifdef CONFIG_AUDIO
     audio_init_audiodevs();
     if (default_audio) {
         audio_create_default_audiodevs();
     }
+#endif
 }
=20
=20
diff --git a/ui/dbus.c b/ui/dbus.c
index 60c8e0b473..2354e5d805 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -35,7 +35,9 @@
 #include "ui/egl-context.h"
 #endif
 #include "qemu/audio.h"
+#ifdef CONFIG_AUDIO
 #include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv=
->name */
+#endif
 #include "qapi/error.h"
 #include "trace.h"
=20


