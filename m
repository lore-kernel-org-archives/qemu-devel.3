Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD78EA4FBB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWHq-0008Jy-HU; Mon, 23 Feb 2026 08:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWHl-0008FR-Mb
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWHj-0006ww-T1
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hd/N6goZnj4Q395Z+d/oS+Fm68fBI3v6tZuS5K3ZU2A=;
 b=QYkXOsT/LHcLTTyBtorwAn7gGeHbXLGxz04c/NrfkQjny9TzZm9/+Yns+ju5PpD2sEG0Wg
 RtUngA+GpVedpbFxshIqnmR9O1L5njuE1EqWK+kMUI/Pb7UUn20284OJ470JwaLWAZlnQg
 YmAaxQy0hwnzUiWe4flp8gURFnH8tLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163--a4R15HGNPOqELDjudJTaw-1; Mon,
 23 Feb 2026 08:47:35 -0500
X-MC-Unique: -a4R15HGNPOqELDjudJTaw-1
X-Mimecast-MFC-AGG-ID: -a4R15HGNPOqELDjudJTaw_1771854454
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6109F1956053; Mon, 23 Feb 2026 13:47:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98A0B30001BE; Mon, 23 Feb 2026 13:47:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 00/85] Audio patches
Date: Mon, 23 Feb 2026 14:46:01 +0100
Message-ID: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit a6ec632dca8c7d10743aff29345e5e9e5324228b:

  Merge tag 'hw-misc-20260223' of https://github.com/philmd/qemu into staging (2026-02-23 09:56:00 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request

for you to fetch changes up to d256efe6edab8129efb4d68a603ad1032bbe96fa:

  audio: fix leak of audio capture name (2026-02-23 14:38:22 +0100)

----------------------------------------------------------------
audio cleanups

----------------------------------------------------------------

Marc-André Lureau (85):
  audio: remove obsolete/obscure functions
  adlib: remove dead code
  audio/adlib: drop ts_helper HWVoice field
  audio/dbus: make "dbus" the default backend when using -display dbus
  qemu-options.hx: clarify default audio backend selection
  qemu-options.hx: document -audiodev dbus
  audio: replace vm_running with runstate_is_running()
  audio: list backends as modules
  build-sys: create a libaudio
  scripts/modinfo: add type annotations
  scripts/modinfo: remove trailing ;
  scripts/modinfo: use in instead of find()
  scripts/modinfo: use f-strings
  scripts/modinfo: use argparse
  scripts/modinfo: make --devices optional
  scripts/modinfo: add --skip-missing-deps
  util: add some extra stubs for qemu modules initialization
  tests: start manual audio backend test
  audio: constify audsettings argument
  audio: introduce AudioMixengBackend
  audio: use DEFINE_TYPES
  audio: simplify audio_init()
  audio: move object creation to audio_driver_init()
  audio: add QOM module-objects for each backend
  audio: remove set_dbus_server from audio_driver
  audio: lookup "audio-" object types, and realize them
  audio: drop audio driver registration
  module: remove audio module support
  audio: replace type_init() with DEFINE_TYPES
  audio: keep a strong reference on the backend
  audio: make list type declaration private
  audio: make create_pdos() private
  replay: remove dependency on audio/
  audio: make all the backend-specific APIs take the be
  audio: make AudioBackend truly abstract
  audio: split AudioBackend
  audio: AUD_ -> audio_be_
  audio-be: add common pre-conditions
  audio-be: add some state trace for debugging
  audio: split AudioMixengBackend code in audio-mixeng-be.c
  audio: make audio_driver init() & fini() optional
  audio/dbus: convert to QOM lifecycle methods
  audio/spice: convert to QOM lifecycle methods
  audio/wav: convert to QOM lifecycle methods
  audio/noaudio: convert to QOM lifecycle methods
  audio/alsa: convert to QOM lifecycle methods
  audio/oss: convert to QOM lifecycle methods
  audio/pa: convert to QOM lifecycle methods
  audio/sdl: convert to QOM lifecycle methods
  audio/pw: convert to QOM lifecycle methods
  audio/jack: convert to QOM lifecycle methods
  audio/sndio: convert to QOM lifecycle methods
  audio/coreaudio: convert to QOM lifecycle methods
  audio/dsound: convert to QOM lifecycle methods
  audio: remove audio_driver init/fini/next
  audio: remove audio_driver
  audio: move pcm_ops into AudioMixengBackendClass
  audio: constify some add_capture() arguments
  audio/alsa: replace custom logging with error_report and trace events
  audio/coreaudio: replace custom logging with error_report
  audio/dbus: remove unused AUDIO_CAP macro
  audio/dsound: replace custom logging with error_report & trace
  audio/jack: replace custom logging with report & trace
  audio/noaudio: remove unused AUDIO_CAP macro
  audio/oss: replace custom logging with report & trace
  audio/pa: replace custom logging with report & trace
  audio/pw: replace custom logging with error_report
  audio/sdl: replace custom logging with error_report
  audio/sndio: replace custom logging with error_report
  audio/spice: remove unused AUDIO_CAP macro
  audio/wav: replace custom logging with error_report
  audio/mixeng: replace redundant pcm_info fields with AudioFormat
  audio: replace int endianness with bool big_endian in audsettings
  audio: replace ldebug with trace events
  audio: rework DEBUG_POLL
  audio: replace DEBUG_CAPTURE with traces
  audio: replace DEBUG_OUT with traces
  audio: replace DEBUG_AUDIO with trace
  tests/audio: add an invalid settings test
  audio: rework invalid audsettings error
  audio: rework audio_bug()
  audio: replace remaining dolog() and AUD_log
  audio: remove AUD_log/ldebug
  audio: remove AudioMixengBackendClass.name
  audio: fix leak of audio capture name

 MAINTAINERS                                   |    1 +
 meson.build                                   |   27 +-
 audio/audio_int.h                             |  168 +-
 audio/audio_template.h                        |  212 +-
 audio/dsound_template.h                       |   89 +-
 include/qemu/audio-capture.h                  |   28 +-
 include/qemu/audio.h                          |  183 +-
 include/qemu/module.h                         |    3 +-
 include/qemu/timer.h                          |    1 +
 include/system/replay.h                       |   11 +-
 replay/replay-internal.h                      |    2 +
 audio/alsaaudio.c                             |  273 +-
 audio/audio-be.c                              |  274 ++
 audio/audio-mixeng-be.c                       | 1770 +++++++++++++
 audio/audio.c                                 | 2246 ++---------------
 audio/audio_win_int.c                         |   31 +-
 audio/dbusaudio.c                             |  168 +-
 audio/dsoundaudio.c                           |  265 +-
 audio/jackaudio.c                             |  127 +-
 audio/mixeng.c                                |    1 -
 audio/noaudio.c                               |   78 +-
 audio/ossaudio.c                              |  300 ++-
 audio/paaudio.c                               |  261 +-
 audio/pwaudio.c                               |  214 +-
 audio/sdlaudio.c                              |  176 +-
 audio/sndioaudio.c                            |  108 +-
 audio/spiceaudio.c                            |  113 +-
 audio/wavaudio.c                              |  101 +-
 audio/wavcapture.c                            |    9 +-
 hw/audio/ac97.c                               |   44 +-
 hw/audio/adlib.c                              |   33 +-
 hw/audio/asc.c                                |   22 +-
 hw/audio/cs4231a.c                            |   24 +-
 hw/audio/es1370.c                             |   28 +-
 hw/audio/gus.c                                |   13 +-
 hw/audio/hda-codec.c                          |   36 +-
 hw/audio/lm4549.c                             |   26 +-
 hw/audio/pcspk.c                              |    8 +-
 hw/audio/sb16.c                               |   30 +-
 hw/audio/via-ac97.c                           |   22 +-
 hw/audio/virtio-snd.c                         |   42 +-
 hw/audio/wm8750.c                             |   47 +-
 hw/display/xlnx_dp.c                          |   18 +-
 hw/usb/dev-audio.c                            |   20 +-
 replay/replay-audio.c                         |   51 +-
 replay/replay.c                               |    2 +-
 replay/stubs-system.c                         |    8 +-
 system/vl.c                                   |    2 -
 tests/audio/audio-stubs.c                     |   69 +
 tests/audio/test-audio.c                      |  619 +++++
 ui/dbus.c                                     |   20 +-
 ui/vnc.c                                      |    6 +-
 util/module.c                                 |    3 +
 audio/coreaudio.m                             |  201 +-
 audio/meson.build                             |   12 +-
 audio/trace-events                            |   46 +
 qemu-options.hx                               |   35 +-
 .../codeconverter/test_regexps.py             |    1 -
 scripts/modinfo-generate.py                   |  146 +-
 scripts/replay-dump.py                        |    8 +-
 tests/audio/meson.build                       |   23 +
 tests/meson.build                             |    1 +
 ui/meson.build                                |    3 +
 63 files changed, 4992 insertions(+), 3917 deletions(-)
 create mode 100644 audio/audio-be.c
 create mode 100644 audio/audio-mixeng-be.c
 create mode 100644 tests/audio/audio-stubs.c
 create mode 100644 tests/audio/test-audio.c
 create mode 100644 tests/audio/meson.build

-- 
2.53.0


