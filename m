Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A77E83858
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcn-0002b9-Bv; Tue, 17 Feb 2026 00:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcl-0002aF-F0
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:51 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDci-0006cC-L3
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:51 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2126688505;
 Tue, 17 Feb 2026 08:27:42 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-mxoRocsh; 
 Tue, 17 Feb 2026 08:27:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306061;
 bh=v9Syk4zj4wcdl+ZNwx/nIowjhuOH5MoDvbDbNK2LC+U=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=QYoQh+4MJpusJbAj16vP3n4hUF7pGBkad84tbK4uAPBfqDnoFKeuanXKQbQ3W9Ba6
 TaGeRJW5XkDKtvpnFG1+bLuF1VvSisPC/li8l0G5r7n+JiAlJsY2+L7z7EGh/Gh7cq
 +5Ij/WOoL45H83JLepaP6vJFlzk9r+1gSiQvwr1Q=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/8] add build option to disable audio subsystem
Date: Tue, 17 Feb 2026 10:27:32 +0500
Message-Id: <20260217052740.114117-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds a compile-time option to disable building
audio-related sources (mostly, files under `audio/` and `hw/audio/`).
It adds `--disable-audio` and `--enable-audio` options to the
`configure` script. Audio remains enabled by default, and the changes are
harmless in that case.

When audio is disabled, it may not be possible to build a number of
devices and machines. This is expected, and can be addressed on a
case-by-case basis if needed.

This feature may be useful in production environments which only use a
specific subset of QEMU’s functionality and, in particular, do not need
the audio subsystem. In such environments it is generally beneficial to
avoid building unused code, for both security and maintenance reasons.

Sergei Heifetz (8):
  audio: add `audio` build option for meson and Kconfig
  ui/vnc: disable audio feature when configured with --disable-audio
  tests/qtest: remove -audio none when configured with --disable-audio
  hw/audio/pcspk: change PCSPK behaviour with --disable-audio
  Kconfig: add AUDIO dependency to audio-related devices
  system/vl: remove audio and audiodev options when audio is disabled
  audio: do not build audio-related sources with --disable-audio
  meson.build: ignore audio drivers when configured with --disable-audio

 Kconfig.host                |  3 ++
 audio/audio-hmp-cmds-stub.c | 28 +++++++++++++
 audio/audio-stub.c          | 35 ++++++++++++++++
 audio/meson.build           |  5 +++
 configure                   |  4 ++
 hw/audio/Kconfig            | 21 ++++++----
 hw/audio/pcspk.c            | 14 +++++++
 hw/usb/Kconfig              |  2 +-
 meson.build                 | 83 +++++++++++++++++++++----------------
 meson_options.txt           |  3 ++
 qapi/audio.json             |  3 +-
 replay/meson.build          |  9 +++-
 replay/replay-audio-stub.c  | 16 +++++++
 replay/stubs-system.c       |  6 ---
 system/vl.c                 |  6 +++
 tests/qtest/libqtest.c      |  2 +
 ui/vnc.c                    | 31 ++++++++++++--
 17 files changed, 215 insertions(+), 56 deletions(-)
 create mode 100644 audio/audio-hmp-cmds-stub.c
 create mode 100644 audio/audio-stub.c
 create mode 100644 replay/replay-audio-stub.c

-- 
2.34.1


