Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AA2CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEiub-0004iW-BX; Fri, 31 Oct 2025 02:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEiuQ-0004cD-Eo
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEiuM-0003lF-Su
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=biWnbob2Rk+2l+2jG/MMVoc7QNlQwvW+lvCysHWHKpA=;
 b=DE8VGSgrZ5bMpL4WM2rpnpEYCNP3w+keUqaYuE1xyQmr0+gPw+bZwhspkMdldz1y5Awmkx
 Ig2MrHyzIq5sxn2wT9wuABt37lRZvmTQzAr5YH6YUrng6k8Ze3JlJTfTSyT9THpWbdtUTB
 S0Z/5fPAB/hZPdKMcstWLaSpKP7yqYI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-AtpExMIhN1-KLRspNJgvBw-1; Fri,
 31 Oct 2025 02:46:38 -0400
X-MC-Unique: AtpExMIhN1-KLRspNJgvBw-1
X-Mimecast-MFC-AGG-ID: AtpExMIhN1-KLRspNJgvBw_1761893197
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E5251953977; Fri, 31 Oct 2025 06:46:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F035919560A2; Fri, 31 Oct 2025 06:46:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/36] Audio test patches
Date: Fri, 31 Oct 2025 10:45:53 +0400
Message-ID: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/audio-test-pull-request

for you to fetch changes up to 05404916bf89867e613da271ebff1a556c206965:

  audio: deprecate HMP audio commands (2025-10-30 22:59:30 +0400)

----------------------------------------------------------------
Audio clean-ups

----------------------------------------------------------------

Marc-André Lureau (34):
  qdev: add qdev_find_default_bus()
  hw/audio: look up the default bus from the device class
  audio: rename audio_define->audio_add_audiodev()
  hw/audio: use better naming for -audio model handling code
  hw/audio/virtio-snd-pci: remove custom model callback
  hw/audio: simplify 'hda' audio init code
  hw/audio: generalize audio_model.init()
  hw/audio: drop audio_model.isa
  audio: start making AudioState a QOM Object
  audio: register backends in /audiodevs container
  audio: use /audiodevs QOM container
  audio/paaudio: remove needless return value
  audio/dsound: simplify init()
  audio/dsound: report init error via **errp
  audio: simplify audio_driver_init()
  audio: move period tick initialization
  audio: drop needless error message
  audio: keep vmstate handle with AudioState
  audio: register and unregister vmstate with AudioState
  audio: initialize card_head during object init
  audio: remove some needless headers
  audio: remove AUDIO_HOST_ENDIANNESS
  audio: introduce AUD_set_volume_{in,out}_lr()
  audio/replay: fix type punning
  audio: move internal APIs to audio_int.h
  audio: rename AudioState -> AudioBackend
  audio: remove QEMUSoundCard
  audio/dbus: use a helper function to set the backend dbus server
  audio: move audio.h under include/qemu/
  audio: remove dependency on spice header
  audio: cleanup, use bool for booleans
  audio: move capture API to own header
  audio: drop needless audio_driver "descr" field
  audio: deprecate HMP audio commands

Philippe Mathieu-Daudé (2):
  audio: Remove pointless local variables
  audio: Rename @endianness argument as @big_endian for clarity

 MAINTAINERS                                   |   1 +
 docs/about/deprecated.rst                     |  20 ++
 audio/audio.h                                 | 185 -----------
 audio/audio_int.h                             |  67 ++--
 audio/audio_template.h                        |  44 ++-
 audio/mixeng.h                                |   1 -
 hw/audio/lm4549.h                             |   4 +-
 include/hw/audio/asc.h                        |   4 +-
 include/hw/audio/model.h                      |  14 +
 include/hw/audio/soundhw.h                    |  13 -
 include/hw/audio/virtio-snd.h                 |   4 +-
 include/hw/display/xlnx_dp.h                  |   4 +-
 include/hw/isa/vt82c686.h                     |   4 +-
 include/hw/qdev-properties-system.h           |   2 +-
 include/monitor/qdev.h                        |   3 +
 include/qemu/audio-capture.h                  |  43 +++
 include/qemu/audio.h                          | 150 +++++++++
 include/system/replay.h                       |   3 +-
 ui/vnc.h                                      |   4 +-
 audio/alsaaudio.c                             |  37 +--
 audio/audio-hmp-cmds.c                        |  11 +-
 audio/audio.c                                 | 313 +++++++++---------
 audio/audio_win_int.c                         |   2 +-
 audio/dbusaudio.c                             |  20 +-
 audio/dsoundaudio.c                           | 213 +++++-------
 audio/jackaudio.c                             |   3 +-
 audio/mixeng.c                                |  12 +-
 audio/noaudio.c                               |   5 +-
 audio/ossaudio.c                              |  33 +-
 audio/paaudio.c                               |  24 +-
 audio/pwaudio.c                               |  15 +-
 audio/sdlaudio.c                              |  15 +-
 audio/sndioaudio.c                            |   3 +-
 audio/spiceaudio.c                            |   7 +-
 audio/wavaudio.c                              |   6 +-
 audio/wavcapture.c                            |   5 +-
 hw/arm/integratorcp.c                         |   2 +-
 hw/arm/musicpal.c                             |   2 +-
 hw/arm/realview.c                             |   2 +-
 hw/arm/versatilepb.c                          |   2 +-
 hw/arm/vexpress.c                             |   2 +-
 hw/arm/xlnx-zcu102.c                          |   2 +-
 hw/audio/ac97.c                               |  36 +-
 hw/audio/adlib.c                              |  17 +-
 hw/audio/asc.c                                |  15 +-
 hw/audio/cs4231a.c                            |  16 +-
 hw/audio/es1370.c                             |  30 +-
 hw/audio/gus.c                                |  17 +-
 hw/audio/hda-codec.c                          |  21 +-
 hw/audio/intel-hda.c                          |  22 +-
 hw/audio/lm4549.c                             |  12 +-
 hw/audio/marvell_88w8618.c                    |   2 +-
 hw/audio/{soundhw.c => model.c}               |  86 ++---
 hw/audio/pcspk.c                              |  13 +-
 hw/audio/pl041.c                              |   2 +-
 hw/audio/sb16.c                               |  23 +-
 hw/audio/via-ac97.c                           |  11 +-
 hw/audio/virtio-snd-pci.c                     |  18 +-
 hw/audio/virtio-snd.c                         |  17 +-
 hw/audio/wm8750.c                             |  37 +--
 hw/core/machine.c                             |   4 +-
 hw/core/qdev-properties-system.c              |  17 +-
 hw/display/xlnx_dp.c                          |   8 +-
 hw/ppc/prep.c                                 |   2 +-
 hw/usb/dev-audio.c                            |  17 +-
 qom/object.c                                  |   1 +
 replay/replay-audio.c                         |   4 +-
 replay/stubs-system.c                         |   2 +-
 system/qdev-monitor.c                         |  25 +-
 system/runstate.c                             |   2 +-
 system/vl.c                                   |  14 +-
 ui/dbus.c                                     |  13 +-
 ui/vnc.c                                      |  10 +-
 audio/coreaudio.m                             |   3 +-
 audio/meson.build                             |   7 +-
 hmp-commands-info.hx                          |   6 +-
 hmp-commands.hx                               |   9 +-
 hw/audio/meson.build                          |   2 +-
 .../codeconverter/test_regexps.py             |   4 +-
 79 files changed, 898 insertions(+), 953 deletions(-)
 delete mode 100644 audio/audio.h
 create mode 100644 include/hw/audio/model.h
 delete mode 100644 include/hw/audio/soundhw.h
 create mode 100644 include/qemu/audio-capture.h
 create mode 100644 include/qemu/audio.h
 rename hw/audio/{soundhw.c => model.c} (54%)

-- 
2.51.1


