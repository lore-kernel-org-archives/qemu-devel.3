Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D80D72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBvz-0002m8-2D; Fri, 23 Jan 2026 02:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBvh-0002es-PF
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBvc-0001ro-N4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3S6DzrpcaKJ29PdN6IlOZrbE2vLYFEyKjBKcgLFz9VA=;
 b=XvYSvARYALEDOWoaosPGKXR879Qd6Wmu4fyEU1yyBiGWuw3dYY4Zzpn29zLOrN9dB5owuZ
 XBSl7xQ1MSosF7CzQQpHGLmle200LGKfuww40GmtlVjQKlFM5h2WrqW+8tT9h6C+SCqy5T
 HjkEoFb7VQiYhagiWo1Ix1+GO8gwF3Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-EM2v4SXfMv-fNo-qIVdw1Q-1; Fri,
 23 Jan 2026 02:49:53 -0500
X-MC-Unique: EM2v4SXfMv-fNo-qIVdw1Q-1
X-Mimecast-MFC-AGG-ID: EM2v4SXfMv-fNo-qIVdw1Q_1769154592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61EBA1956054; Fri, 23 Jan 2026 07:49:52 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8E9430002D1; Fri, 23 Jan 2026 07:49:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/37] audio: cleanups & add a manual test
Date: Fri, 23 Jan 2026 11:49:03 +0400
Message-ID: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi

This patch series is part of an ongoing effort to clean up audio/, initiated in
QEMU 10.2. Some of the patches were previously posted as part of the "[RFC
00/24] audio: add GStreamer backend" series.

The complete series finalizes the migration to QOM and improves error handling
and logging.

Marc-André Lureau (37):
  audio: remove obsolete/obscure functions
  adlib: remove dead code
  audio/adlib: drop ts_helper HWVoice field
  audio/dbus: make "dbus" the default backend when using -display dbus
  qemu-options.hx: clarify default audio backend selection
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
  tests: start manual audio backend test
  audio: constify audsettings argument
  audio: introduce AudioMixengBackend
  audio: simplify audio_init()
  audio: move object creation to audio_driver_init()
  audio: add QOM module-objects for each backend
  audio: remove set_dbus_server from audio_driver
  audio: lookup "audio-" object types, and realize them
  audio: drop audio driver registration
  module: remove audio module support
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

 meson.build                                   |   25 +-
 audio/audio_int.h                             |   59 +-
 audio/audio_template.h                        |   78 +-
 include/qemu/audio-capture.h                  |   24 +-
 include/qemu/audio.h                          |  132 +-
 include/qemu/module.h                         |    3 +-
 include/system/replay.h                       |   11 +-
 replay/replay-internal.h                      |    2 +
 audio/alsaaudio.c                             |   30 +-
 audio/audio-be.c                              |  276 ++
 audio/audio-mixeng-be.c                       | 1983 +++++++++++++++
 audio/audio.c                                 | 2245 ++---------------
 audio/dbusaudio.c                             |   46 +-
 audio/dsoundaudio.c                           |   27 +-
 audio/jackaudio.c                             |   27 +-
 audio/noaudio.c                               |   27 +-
 audio/ossaudio.c                              |   31 +-
 audio/paaudio.c                               |   27 +-
 audio/pwaudio.c                               |   27 +-
 audio/sdlaudio.c                              |   27 +-
 audio/sndioaudio.c                            |   27 +-
 audio/spiceaudio.c                            |   27 +-
 audio/wavaudio.c                              |   27 +-
 audio/wavcapture.c                            |    7 +-
 hw/audio/ac97.c                               |   42 +-
 hw/audio/adlib.c                              |   31 +-
 hw/audio/asc.c                                |   20 +-
 hw/audio/cs4231a.c                            |   18 +-
 hw/audio/es1370.c                             |   26 +-
 hw/audio/gus.c                                |   11 +-
 hw/audio/hda-codec.c                          |   36 +-
 hw/audio/lm4549.c                             |   20 +-
 hw/audio/pcspk.c                              |    8 +-
 hw/audio/sb16.c                               |   22 +-
 hw/audio/via-ac97.c                           |   20 +-
 hw/audio/virtio-snd.c                         |   36 +-
 hw/audio/wm8750.c                             |   43 +-
 hw/display/xlnx_dp.c                          |   16 +-
 hw/usb/dev-audio.c                            |   18 +-
 replay/replay-audio.c                         |   51 +-
 replay/replay.c                               |    2 +-
 replay/stubs-system.c                         |    8 +-
 tests/audio/audio-stubs.c                     |   53 +
 tests/audio/test-audio.c                      |  582 +++++
 ui/dbus.c                                     |   20 +-
 ui/vnc.c                                      |    4 +-
 audio/coreaudio.m                             |   27 +-
 audio/meson.build                             |   10 +-
 audio/trace-events                            |    4 +
 qemu-options.hx                               |   22 +-
 .../codeconverter/test_regexps.py             |    1 -
 scripts/modinfo-generate.py                   |  146 +-
 tests/audio/meson.build                       |   18 +
 tests/meson.build                             |    1 +
 54 files changed, 3999 insertions(+), 2512 deletions(-)
 create mode 100644 audio/audio-be.c
 create mode 100644 audio/audio-mixeng-be.c
 create mode 100644 tests/audio/audio-stubs.c
 create mode 100644 tests/audio/test-audio.c
 create mode 100644 tests/audio/meson.build

-- 
2.52.0


