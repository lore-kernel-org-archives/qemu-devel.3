Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE4CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8HM-0001D7-IK; Tue, 21 Oct 2025 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HI-0001Cs-Hr
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8HF-0003sn-Ti
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hlTg2LXatGiENy28wgiDO1kIYlSGmc+TUtFKjfH/6/4=;
 b=VgnJutQdJU54RhheyuEvsdkzongvib9Kbuf/in+ikxVI8p6Go7G6OwS9jX+P+W4aD7107d
 DUuvyCuwcEqcIWtoa/wG/oRs9ifKS84pzO6NgudhHVLxtxeYfYIZavXdDwJ1t040KCrkFf
 pMq4U4BHI1ve9RnJAfk7TI1GEagGras=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-F9v-5sKyNgGyuODA8awIgg-1; Tue,
 21 Oct 2025 05:03:23 -0400
X-MC-Unique: F9v-5sKyNgGyuODA8awIgg-1
X-Mimecast-MFC-AGG-ID: F9v-5sKyNgGyuODA8awIgg_1761037403
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC4811956094; Tue, 21 Oct 2025 09:03:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C7FB3000218; Tue, 21 Oct 2025 09:03:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/43] Audio clean-ups
Date: Tue, 21 Oct 2025 13:02:31 +0400
Message-ID: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

This is part of continuous and overdue clean up / modernization effort for the
audio subsystem. (there is more in the pipeline)

thanks

Marc-André Lureau (43):
  hw/audio: improve error reports
  hw/audio: rename model list function
  hw/audio: remove global pcspk
  hw/pcspk: use explicitly the required PIT types
  hw/pcspk: make 'pit' a class property
  hw/pcspk: check the "pit" is set
  docs: update -soundhw -> -device list
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
  audio: use /audiodevs qom container
  audio/paaudio: remove needless return value
  audio/dsound: simplify init()
  audio/dsound: report init error via **errp
  audio: simplify audio_driver_init()
  audio: move period tick initialization
  audio: drop needless error message
  audio: clean-up vmstate change handler on finalize
  audio: unregister vmstate description
  audio: initialize card_head during object init
  audio: remove some needless headers
  audio: remove AUDIO_HOST_ENDIANNESS
  audio: introduce AUD_set_volume_{in,out}_lr()
  hw/audio: replace AUD_log() usage
  audio/replay: fix type punning
  audio: move internal APIs to audio_int.h
  audio: rename AudioState -> AudioBE
  audio: rename QEMUSoundCard -> AudioFE
  audio: rename audio_get_id()
  audio/dbus: use a helper function to set the backend dbus server
  audio: move audio.h under include/qemu/
  audio: remove dependency on spice header
  audio: cleanup, use bool for booleans
  audio: drop needless list of FE
  audio: move capture API to own header
  audio: drop needless audio_driver "descr" field

 docs/qdev-device-use.txt                      |   6 +-
 audio/audio_int.h                             |  64 ++--
 audio/audio_template.h                        |  30 +-
 audio/mixeng.h                                |   1 -
 hw/audio/lm4549.h                             |   4 +-
 include/hw/audio/asc.h                        |   4 +-
 include/hw/audio/model.h                      |  13 +
 include/hw/audio/soundhw.h                    |  13 -
 include/hw/audio/virtio-snd.h                 |   4 +-
 include/hw/display/xlnx_dp.h                  |   4 +-
 include/hw/isa/vt82c686.h                     |   4 +-
 include/hw/qdev-properties-system.h           |   2 +-
 include/hw/timer/i8254.h                      |   4 +-
 include/monitor/qdev.h                        |   3 +
 include/qemu/audio-capture.h                  |  43 +++
 {audio => include/qemu}/audio.h               | 125 +++-----
 include/system/replay.h                       |   3 +-
 ui/vnc.h                                      |   4 +-
 audio/alsaaudio.c                             |   5 +-
 audio/audio-hmp-cmds.c                        |   4 +-
 audio/audio.c                                 | 303 +++++++++---------
 audio/audio_win_int.c                         |   2 +-
 audio/dbusaudio.c                             |  17 +-
 audio/dsoundaudio.c                           | 213 ++++++------
 audio/jackaudio.c                             |   3 +-
 audio/mixeng.c                                |  12 +-
 audio/noaudio.c                               |   5 +-
 audio/ossaudio.c                              |   7 +-
 audio/paaudio.c                               |  16 +-
 audio/pwaudio.c                               |   3 +-
 audio/sdlaudio.c                              |   3 +-
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
 hw/audio/ac97.c                               | 137 ++++----
 hw/audio/adlib.c                              |  34 +-
 hw/audio/asc.c                                |  12 +-
 hw/audio/cs4231a.c                            |  52 ++-
 hw/audio/es1370.c                             |  37 ++-
 hw/audio/gus.c                                |  35 +-
 hw/audio/hda-codec.c                          |  12 +-
 hw/audio/intel-hda.c                          |  20 +-
 hw/audio/lm4549.c                             |   6 +-
 hw/audio/marvell_88w8618.c                    |   2 +-
 hw/audio/model.c                              | 121 +++++++
 hw/audio/pcspk.c                              |  27 +-
 hw/audio/sb16.c                               | 104 +++---
 hw/audio/soundhw.c                            | 143 ---------
 hw/audio/via-ac97.c                           |   6 +-
 hw/audio/virtio-snd-pci.c                     |  18 +-
 hw/audio/virtio-snd.c                         |   8 +-
 hw/audio/wm8750.c                             |  20 +-
 hw/core/machine.c                             |   4 +-
 hw/core/qdev-properties-system.c              |  14 +-
 hw/display/xlnx_dp.c                          |   4 +-
 hw/ppc/prep.c                                 |   2 +-
 hw/timer/i8254_common.c                       |   6 +-
 hw/usb/dev-audio.c                            |  12 +-
 qom/object.c                                  |   1 +
 replay/replay-audio.c                         |   4 +-
 replay/stubs-system.c                         |   2 +-
 system/qdev-monitor.c                         |  21 +-
 system/runstate.c                             |   2 +-
 system/vl.c                                   |  16 +-
 ui/dbus.c                                     |  13 +-
 ui/vnc.c                                      |  10 +-
 audio/coreaudio.m                             |   3 +-
 audio/meson.build                             |   2 +-
 hw/audio/meson.build                          |   2 +-
 .../codeconverter/test_regexps.py             |   4 +-
 77 files changed, 903 insertions(+), 970 deletions(-)
 create mode 100644 include/hw/audio/model.h
 delete mode 100644 include/hw/audio/soundhw.h
 create mode 100644 include/qemu/audio-capture.h
 rename {audio => include/qemu}/audio.h (50%)
 create mode 100644 hw/audio/model.c
 delete mode 100644 hw/audio/soundhw.c

-- 
2.51.0


