Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81E5D2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknl4-0004c1-Tl; Tue, 27 Jan 2026 13:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknkr-0004ZB-DH
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknkn-0002qb-Hl
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c9/GUjBmm77aMBWgvEDy9I9ob4EzqsrK31ZsHugVO8Y=;
 b=dP6nDbMtwuiy6MvcGF7H0ZoS1P5alNQVZGOUGrZrrLhQjnvINEOZD7SC7Rh9rHZv2XRUoZ
 sPKVHyu0zJYV+ptTpGxBMP5PO7Ln1GuN215K9zKTfsGaofRLNoYvjBPMQVbDSuC9wITXMF
 VWxCz5w6BtssGZ1pwzrROud8ZCatzpU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-UtSj5eBoN7WI2V43jzRI_Q-1; Tue,
 27 Jan 2026 13:25:22 -0500
X-MC-Unique: UtSj5eBoN7WI2V43jzRI_Q-1
X-Mimecast-MFC-AGG-ID: UtSj5eBoN7WI2V43jzRI_Q_1769538322
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CD2B1944DF2; Tue, 27 Jan 2026 18:25:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AABE30002D2; Tue, 27 Jan 2026 18:25:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/43] audio: more cleanups (2/2 for 11.0)
Date: Tue, 27 Jan 2026 22:24:27 +0400
Message-ID: <20260127182516.289834-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

This patch series is part of an ongoing effort to clean up audio/,
it should be the remaining cleanups for QEMU 11.0.

Based-on: <20260123074945.2563196-1-marcandre.lureau@redhat.com>

Marc-André Lureau (43):
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

 audio/audio_int.h            | 111 +++---
 audio/audio_template.h       | 134 ++++----
 audio/dsound_template.h      |  89 +++--
 include/qemu/audio-capture.h |   4 +-
 include/qemu/audio.h         |  55 ++-
 audio/alsaaudio.c            | 260 ++++++--------
 audio/audio-be.c             |   4 +-
 audio/audio-mixeng-be.c      | 636 ++++++++++++-----------------------
 audio/audio_win_int.c        |  31 +-
 audio/dbusaudio.c            | 138 ++++----
 audio/dsoundaudio.c          | 256 ++++++--------
 audio/jackaudio.c            | 106 +++---
 audio/mixeng.c               |   1 -
 audio/noaudio.c              |  65 ++--
 audio/ossaudio.c             | 281 +++++++---------
 audio/paaudio.c              | 254 +++++++-------
 audio/pwaudio.c              | 203 ++++++-----
 audio/sdlaudio.c             | 156 ++++-----
 audio/sndioaudio.c           |  92 ++---
 audio/spiceaudio.c           |  94 +++---
 audio/wavaudio.c             |  88 ++---
 audio/wavcapture.c           |   2 +-
 hw/audio/ac97.c              |   2 +-
 hw/audio/adlib.c             |   2 +-
 hw/audio/asc.c               |   2 +-
 hw/audio/cs4231a.c           |   6 +-
 hw/audio/es1370.c            |   2 +-
 hw/audio/gus.c               |   2 +-
 hw/audio/lm4549.c            |   6 +-
 hw/audio/sb16.c              |   8 +-
 hw/audio/via-ac97.c          |   2 +-
 hw/audio/virtio-snd.c        |   2 +-
 hw/audio/wm8750.c            |   4 +-
 hw/display/xlnx_dp.c         |   2 +-
 hw/usb/dev-audio.c           |   2 +-
 tests/audio/test-audio.c     |  23 +-
 ui/vnc.c                     |   2 +-
 audio/coreaudio.m            | 188 +++++------
 audio/trace-events           |  42 +++
 39 files changed, 1461 insertions(+), 1896 deletions(-)

-- 
2.52.0


