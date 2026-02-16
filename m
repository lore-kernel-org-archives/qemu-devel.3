Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BA9E7BD8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw44-0001qB-Q1; Mon, 16 Feb 2026 05:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw3x-0001ox-UB
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw3w-0000xi-0W
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1vYfoJPrFAmJeUN4HEj0QtM6SSeEBhKeVZad4gaM/Q=;
 b=g602fthxC687LDAYyGLdTdkm71BG3VsIAESmphtrv3yseJspHMDvzkb/hgZ/lg6lrZSudI
 NFQ99MYYOKiUoE9443l8kcWCv4GgntQRnNwsZu3LE2pCqdFIHB4qpqpnPRzlHsjCqGkVhQ
 fWL35VBbqahF7qkH/j537Mo08dp49P8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Tl-lnhQWMoyZ9feP4pCupA-1; Mon,
 16 Feb 2026 05:42:39 -0500
X-MC-Unique: Tl-lnhQWMoyZ9feP4pCupA-1
X-Mimecast-MFC-AGG-ID: Tl-lnhQWMoyZ9feP4pCupA_1771238556
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1FFC18002C2; Mon, 16 Feb 2026 10:42:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CD181955F43; Mon, 16 Feb 2026 10:42:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/85] audio: cleanups & add a manual test
Date: Mon, 16 Feb 2026 11:42:12 +0100
Message-Id: <20260216-audio-v1-0-edcb25699381@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvSS8se9U+HzH8iLxyuaIG30zT/guHqa40uiN
 vYkERX3d7iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kgAKCRDa6OEJdZac
 5UA9D/0bkNVf+yJ2pQwk2FWPaU99TElTLg3AvEuKwJz+EolQTTAoZIB0JtInpjmLL+KQhviQH8Z
 +1A6N7phPCUMJI4J2WAeqTWgE19+LtwrafWAmEIi/WDdYCzaFDV8gBNUGyin6Vtxut6XPSP62VY
 /QQgJu4GJGpsarNmmzdthHeAdm4H9F+decWFFNpyZrOj/O3xVjVOe87g4sj2RwYdjjr4ogUqo9B
 CbkgoASkOHRv8/qJpEfDCGGL8n1oe/Ni3FjcxKMtAT1xcvNsLP1JFINSi+CDporv1EEOmNXne13
 7qxRhGaP4QZ6+j6tmvSOPHDolLbQ74zZ0ziC7kJfYGFIbegpUVr9bHr24MQ+JbNpq2r8Qx+6Ken
 DQvuh0MBYZojQ7nPrpikMuBt+J23fTAa0SZjhrTPUlnXvZRXdNwUf2onl6qnlSUuBROuBFufr+b
 DIUcq1OMH3idmnmIusOGd6OaN0dzJ9sjX0VzCFd9LdyQpyZrYoB4Bqr9/ZV/Ot9riw7TloFDRow
 zE4AZEQHmsoKcG/8HbPV0aG89DGHt++aW8tHE7GKvaEhqo3zG3rPOCBj4o0fV/taGG/jHcTm0hO
 uEwsnK3rM6/7uDbC+gCqewLxjmBzikO8WhxV55SjXeTG3T0u27vXQk2j9lfeUCG38Z8ajnZxGy/
 +Jb8Whfg/NKnWGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


