Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C1CF30282
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruN-0006OY-1W; Sun, 15 Mar 2026 16:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru0-0006LA-BB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:33 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtT-0002L0-CD
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6617F8074F;
 Sun, 15 Mar 2026 23:16:49 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lGR1j41AsiE0-skcWXy4z; Sun, 15 Mar 2026 23:16:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605808;
 bh=hOQ916UHgmMPhf+QLNmT9AcnW8L2iX0aS9+HCrcvIqI=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=y19+dViasAlCMXzi7V2dyIF4OdbQJCQYyz876h5WPOqskbVjqgOK8QZ5UmJESqEtL
 ldu47S85ELo4fkZRqWP0WcNSdH0iDnZjY1qdGjSZ6fx32IRS2fI95YUGMDCxbza1mt
 IivKOS8tKnEMw2smtvNXfEqTmlFg2wHeBHBfoKYA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 00/11] add build option to disable audio subsystem
Date: Mon, 16 Mar 2026 01:16:35 +0500
Message-Id: <20260315201646.96862-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
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

Changes in v3:
* ui/vnc:
  - Included some useful information in the commit message.
  - Added a note in qemu-options.hx about using VNC with `--disable-audio`.
  - Made a few stylistic changes.
* system/vl:
  - Updated qemu-options.hx so the `audiodev` and `audio` options are
    omitted if audio is disabled.
* ui/dbus:
  - Updated ui/dbus.c so the code related to the `audiodev` property
    is not compiled if audio is disabled.
  - In qapi/ui.json, made the `*audiodev` field of the DisplayDBus struct
    conditional so it's not present if audio is disabled.
  - Added a brief note about disabling audio in the D-Bus section of
    qemu-options.hx.
* The `audio: do not build..` patch:
  - audio/audio-stub.c is removed. Instead, new ifdefs are added in a few
    places.
* Added a patch that removes the `audiodevs` root container in qom/object.c
  if audio is disabled.
* Rebased onto the master branch.

Changes in v2:
* Rebased onto the master branch (in particular, onto the changes from the
  large series submitted by Marc-André Lureau).
* D-Bus is now handled differently when audio is disabled: instead of
  interrupting initialisation, we simply don’t initialise the audio
  interface.
* Incorporated a few changes suggested by Paolo Bonzini and Thomas Huth.
  The main ones are:
  - Cleaned up the PCSPK changes (removed redundant ifdefs and the
    `audio_be` field).
  - Removed the HMP commands rather than stubbing them out.
  - Replaced the `configure` change with a change in
    `scripts/meson-buildoptions.sh`.
  - Removed `qdev_prop_audiodev` in `hw/core/qdev-properties-system.c`
    rather than stubbing out `audio_be_get_id`.
  (Here "removed" means adding an appropriate ifdef.)

Sergei Heifetz (11):
  audio: add `audio` build option for meson and Kconfig
  ui/vnc: disable audio feature when configured with --disable-audio
  tests/qtest: remove -audio none when configured with --disable-audio
  hw/audio/pcspk: change PCSPK behaviour with --disable-audio
  Kconfig: add AUDIO dependency to audio-related devices
  system/vl: remove audio and audiodev options when audio is disabled
  ui/dbus: run without Audio interface when audio is disabled
  tests/audio: do not compile if audio is disabled
  audio: do not build audio-related sources with --disable-audio
  qom: remove audiodevs root container if audio is disabled
  meson.build: ignore audio drivers when configured with --disable-audio

 Kconfig.host                     |  3 ++
 audio/meson.build                |  4 ++
 hmp-commands-info.hx             |  2 +
 hmp-commands.hx                  |  2 +
 hw/audio/Kconfig                 | 21 ++++----
 hw/audio/pcspk.c                 | 12 ++++-
 hw/core/machine.c                |  6 +++
 hw/core/qdev-properties-system.c |  2 +
 hw/i386/pc.c                     |  2 +
 hw/usb/Kconfig                   |  2 +-
 meson.build                      | 83 ++++++++++++++++++--------------
 meson_options.txt                |  3 ++
 qapi/audio.json                  |  3 +-
 qapi/ui.json                     |  2 +-
 qemu-options.hx                  |  9 ++++
 qom/object.c                     |  2 +
 replay/meson.build               |  9 +++-
 replay/replay-audio-stub.c       | 21 ++++++++
 replay/stubs-system.c            | 12 -----
 scripts/meson-buildoptions.sh    |  3 ++
 system/runstate.c                |  2 +
 system/vl.c                      |  8 +++
 tests/audio/meson.build          |  2 +-
 tests/qtest/libqtest.c           |  2 +
 ui/dbus.c                        |  8 +++
 ui/vnc.c                         | 27 +++++++++++
 26 files changed, 190 insertions(+), 62 deletions(-)
 create mode 100644 replay/replay-audio-stub.c

-- 
2.34.1


