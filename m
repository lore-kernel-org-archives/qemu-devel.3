Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04075EC1130
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucV4-0003Kb-GS; Mon, 23 Feb 2026 15:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUl-000388-0R
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:33 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUh-0002Ny-0I
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 04E938E410;
 Mon, 23 Feb 2026 23:25:16 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-f5FUH7Xe; 
 Mon, 23 Feb 2026 23:25:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878315;
 bh=VPml7AaDRpzOtpkQ0HhxWkUVk5Hf3ytuAQbBABOWWks=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=ljajALOKy8BUuL8ZMewFZ2i3aSZa4/HvlHULdc8f8tVu31vXF7Nr8EXFpeKtjiL9q
 Pxrlb73Qf+vGbJ7jaW7MYB9wWc4YI5YyVyhEcRFHQwL7b2iLg2cy5pk5Srr4B2E8Rs
 0qELGGOUEJDV+gpf8XyCOZr3gTsNlS22T/88O7g4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 00/10] add build option to disable audio subsystem
Date: Tue, 24 Feb 2026 01:25:02 +0500
Message-Id: <20260223202512.1308205-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds a compile-time option to disable building
audio-related sources (mostly, files under `audio/` and `hw/audio/`).
It adds `--disable-audio` and `--enable-audio` options to the
`configure` script. Audio remains enabled by default, and the changes are
harmless in that case.

When audio is disabled, it may not be possible to build a number of
devices and machines. This is expected, and can be addressed on a
case-by-case basis if needed. For now, this is done only for the
PC Speaker (PCSPK).

This feature may be useful in production environments which only use a
specific subset of QEMU’s functionality and, in particular, do not need
the audio subsystem. In such environments it is generally beneficial to
avoid building unused code, for both security and maintenance reasons
(for example, to satisfy various static code analysers).

Changes since v1:
- Rebased onto the master branch (in particular, onto the changes from the
  large series submitted by Marc-André Lureau).
- D-Bus is now handled differently when audio is disabled: instead of
  interrupting initialisation, we simply don’t initialise the audio
  interface.
- Incorporated a few changes suggested by Paolo Bonzini and Thomas Huth.
  The main ones are:
  - Cleaned up the PCSPK changes (removed redundant ifdefs and the
    `audio_be` field).
  - Removed the HMP commands rather than stubbing them out.
  - Replaced the `configure` change with a change in
    `scripts/meson-buildoptions.sh`.
  - Removed `qdev_prop_audiodev` in `hw/core/qdev-properties-system.c`
    rather than stubbing out `audio_be_get_id`.
  (Here "removed" means adding an appropriate ifdef.)

Sergei Heifetz (10):
  audio: add `audio` build option for meson and Kconfig
  ui/vnc: disable audio feature when configured with --disable-audio
  tests/qtest: remove -audio none when configured with --disable-audio
  hw/audio/pcspk: change PCSPK behaviour with --disable-audio
  Kconfig: add AUDIO dependency to audio-related devices
  system/vl: remove audio and audiodev options when audio is disabled
  ui/dbus: run without Audio interface when audio is disabled
  tests/audio: do not compile if audio is disabled
  audio: do not build audio-related sources with --disable-audio
  meson.build: ignore audio drivers when configured with --disable-audio

 Kconfig.host                     |  3 ++
 audio/audio-stub.c               | 22 +++++++++
 audio/meson.build                |  5 ++
 hmp-commands-info.hx             |  2 +
 hmp-commands.hx                  |  2 +
 hw/audio/Kconfig                 | 21 ++++----
 hw/audio/pcspk.c                 | 12 ++++-
 hw/core/qdev-properties-system.c |  2 +
 hw/i386/pc.c                     |  2 +
 hw/usb/Kconfig                   |  2 +-
 meson.build                      | 83 ++++++++++++++++++--------------
 meson_options.txt                |  3 ++
 qapi/audio.json                  |  3 +-
 replay/meson.build               |  9 +++-
 replay/replay-audio-stub.c       | 21 ++++++++
 replay/stubs-system.c            | 12 -----
 scripts/meson-buildoptions.sh    |  3 ++
 system/vl.c                      |  6 +++
 tests/audio/meson.build          |  2 +-
 tests/qtest/libqtest.c           |  2 +
 ui/dbus.c                        |  2 +
 ui/vnc.c                         | 31 ++++++++++--
 22 files changed, 186 insertions(+), 64 deletions(-)
 create mode 100644 audio/audio-stub.c
 create mode 100644 replay/replay-audio-stub.c

-- 
2.34.1


