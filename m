Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D48E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwZu-0004ik-Jy; Mon, 16 Feb 2026 06:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwZs-0004iA-Gc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwZp-0007HB-Gz
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1vYfoJPrFAmJeUN4HEj0QtM6SSeEBhKeVZad4gaM/Q=;
 b=P1ypT0Vdk+XwQ/9+YIW7tsGuSazq28hnjOriPl/VMsOKm/cMpoq9gwsGkyiT+6itkGPQ7/
 epfKFmaR8dzvGuNpJTcgjQ0xLAF3KMgG3UQSgHrGs8t+7JFGu1kaJRotLGNVdJuFTzCxD7
 ahVXQJy27MlGYTnnh0Vtcold7wS1xH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-12se4Fe9M4ylnLUf4-whcQ-1; Mon,
 16 Feb 2026 06:15:37 -0500
X-MC-Unique: 12se4Fe9M4ylnLUf4-whcQ-1
X-Mimecast-MFC-AGG-ID: 12se4Fe9M4ylnLUf4-whcQ_1771240535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F8CF180025A; Mon, 16 Feb 2026 11:15:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43D851800464; Mon, 16 Feb 2026 11:15:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/85] audio: cleanups & add a manual test
Date: Mon, 16 Feb 2026 12:14:49 +0100
Message-Id: <20260216-audio-v1-0-e676662e4514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Mz3cTSlMx8XQtLM1OjFCNzA8s0QyWg2oKi1LTMCrA50bG1tQCJWwA
 wVwAAAA==
X-Change-ID: 20260216-audio-89652d2709f1
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9182;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ipLKNbFpIgOE5TpXI30zO48gLrUWKd0xSMrSqlPA0o4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxNs99ozLxWrUL5k5lykOW3mjXdci2TDYwUC
 GZeOZPDGHmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TQAKCRDa6OEJdZac
 5XPID/9Y9e7xbprgGAvdluatgPUeV3MvJjL3XO6WGDwZL5Wt3tmPCiZSYqQZS8Xqjt78Jp4UZtz
 JBm5aVg2BlVSNE/Tu5FKxQ0Hi6VPtlUgeZdGwYyfJ6Ooyo4mpZFyWnhd5DIeJSOozHjMeO0xL3G
 P22ATAgwUAI1c0wJ4JL4lK+fPGvEdf8w7h1T5T+TgauXeRUMaLoelgcRsz4nh0gIhHdWytcweCW
 DG6zbjnWE3hzdp6eQ9y7WPrBjI71bZv8Jn2zHUWH5XuVBW6H6ZvSKI5PoBMs52AGGdqCVA/YkF9
 Gnx2yQIBLm3hCie3IhERucJ7DoqaWkWVvf+6bJQZc7t1Il/S+LvL3LEDvY2W7HLI9cFIDfHDO8E
 TbjGp7YKitiAlmVaCNSJ01J0oGfAogpNzOI8Zv1hFip2RnnAEaptQ/fPytXfOGKDOCloVJqowK5
 qiOug/dX/6sZODvM747KgitBv946UkyJBrrck/IqSW0fFyZQbKrGtrIsImuwhSp6bwaT16V2X8m
 WtbHFE60QrofZoPaDI8OEWUb3IoPKL5hYDg/kChyaSsB69ViaI1pjj96b47leexJAD+bd1diGjk
 A6aj9nCwdvQuAEFl59FYncEXePAInal6+CWFWElkUgfxxAkbUzXuVYnwipQX+wKCiR77ptTSnnV
 o4LkJE2xdhPLGJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is the combination of the two earlier series:
[PATCH 00/37] audio: cleanups & add a manual test
[PATCH 00/43] audio: more cleanups (2/2 for 11.0)

Patches missing r-b trailers:
- scripts/modinfo: use argparse
- scripts/modinfo: make --devices optional
- scripts/modinfo: add --skip-missing-deps
- util: add some extra stubs for qemu modules initialization
- tests: start manual audio backend test
- audio: use DEFINE_TYPES
- audio: replace type_init() with DEFINE_TYPES
- audio: keep a strong reference on the backend
- replay: remove dependency on audio/
- audio: fix leak of audio capture name

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
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

 MAINTAINERS                                        |    1 +
 meson.build                                        |   27 +-
 audio/audio_int.h                                  |  168 +-
 audio/audio_template.h                             |  212 +-
 audio/dsound_template.h                            |   89 +-
 include/qemu/audio-capture.h                       |   28 +-
 include/qemu/audio.h                               |  183 +-
 include/qemu/module.h                              |    3 +-
 include/qemu/timer.h                               |    1 +
 include/system/replay.h                            |   11 +-
 replay/replay-internal.h                           |    2 +
 audio/alsaaudio.c                                  |  273 ++-
 audio/audio-be.c                                   |  274 +++
 audio/audio-mixeng-be.c                            | 1770 +++++++++++++++
 audio/audio.c                                      | 2246 ++------------------
 audio/audio_win_int.c                              |   31 +-
 audio/dbusaudio.c                                  |  168 +-
 audio/dsoundaudio.c                                |  265 ++-
 audio/jackaudio.c                                  |  127 +-
 audio/mixeng.c                                     |    1 -
 audio/noaudio.c                                    |   78 +-
 audio/ossaudio.c                                   |  300 ++-
 audio/paaudio.c                                    |  261 +--
 audio/pwaudio.c                                    |  214 +-
 audio/sdlaudio.c                                   |  176 +-
 audio/sndioaudio.c                                 |  108 +-
 audio/spiceaudio.c                                 |  113 +-
 audio/wavaudio.c                                   |  101 +-
 audio/wavcapture.c                                 |    9 +-
 hw/audio/ac97.c                                    |   44 +-
 hw/audio/adlib.c                                   |   33 +-
 hw/audio/asc.c                                     |   22 +-
 hw/audio/cs4231a.c                                 |   24 +-
 hw/audio/es1370.c                                  |   28 +-
 hw/audio/gus.c                                     |   13 +-
 hw/audio/hda-codec.c                               |   36 +-
 hw/audio/lm4549.c                                  |   26 +-
 hw/audio/pcspk.c                                   |    8 +-
 hw/audio/sb16.c                                    |   30 +-
 hw/audio/via-ac97.c                                |   22 +-
 hw/audio/virtio-snd.c                              |   38 +-
 hw/audio/wm8750.c                                  |   47 +-
 hw/display/xlnx_dp.c                               |   18 +-
 hw/usb/dev-audio.c                                 |   20 +-
 replay/replay-audio.c                              |   51 +-
 replay/replay.c                                    |    2 +-
 replay/stubs-system.c                              |    8 +-
 system/vl.c                                        |    2 -
 tests/audio/audio-stubs.c                          |   69 +
 tests/audio/test-audio.c                           |  619 ++++++
 ui/dbus.c                                          |   20 +-
 ui/vnc.c                                           |    6 +-
 util/module.c                                      |    3 +
 audio/coreaudio.m                                  |  201 +-
 audio/meson.build                                  |   12 +-
 audio/trace-events                                 |   46 +
 qemu-options.hx                                    |   35 +-
 .../codeconverter/codeconverter/test_regexps.py    |    1 -
 scripts/modinfo-generate.py                        |  146 +-
 tests/audio/meson.build                            |   23 +
 tests/meson.build                                  |    1 +
 ui/meson.build                                     |    3 +
 62 files changed, 4983 insertions(+), 3914 deletions(-)
---
base-commit: ece408818d27f745ef1b05fb3cc99a1e7a5bf580
change-id: 20260216-audio-89652d2709f1

Best regards,
-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


