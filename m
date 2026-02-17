Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75860E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcs-0002ce-97; Tue, 17 Feb 2026 00:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcn-0002bH-UI
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:54 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcl-0006cf-0K
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:53 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C194B88512;
 Tue, 17 Feb 2026 08:27:49 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-vRBzQ9c3; 
 Tue, 17 Feb 2026 08:27:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306069;
 bh=KOIC+LeyRr+/hCkiVzFTFc9lUuFTGE4xjJnMyvrIrZo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fihEtUMMqawgP7lWr3b396EpVGug+Amj1lArchR8/HsUdhChFTXEnt+qnpiOYMks8
 +ht0xYUWppwA0Y5aKoUdXVKyri0gdtKfTKQkS/kKv0iZ7AN1O1W3HRHR4lVy6bE+rG
 uZQBbb3aMmkATLo4r6z5lpa3KXb8y3qZcY5t+ROY=
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
Subject: [PATCH 7/8] audio: do not build audio-related sources with
 --disable-audio
Date: Tue, 17 Feb 2026 10:27:39 +0500
Message-Id: <20260217052740.114117-8-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
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

When QEMU is configured with `--disable-audio`, do not build any
audio-related sources.

- audio/meson.build and replay/meson.build:
  Exclude audio-related sources when audio is disabled.

- audio/audio-stub.c:
  Provide a minimal set of straightforward stubs.

- replay/replay-audio-stub.c:
  Move the existing stubs from replay/stubs-system.c into a separate
  file.

- qapi/audio.json:
  Remove the QMP `query-audiodevs` command.

- audio/audio-hmp-cmds-stub.c:
  Provide meaningful messages for audio-related HMP commands:
  stopcapture, wavcapture, info capture.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 audio/audio-hmp-cmds-stub.c | 28 ++++++++++++++++++++++++++++
 audio/audio-stub.c          | 35 +++++++++++++++++++++++++++++++++++
 audio/meson.build           |  5 +++++
 qapi/audio.json             |  3 ++-
 replay/meson.build          |  9 ++++++++-
 replay/replay-audio-stub.c  | 16 ++++++++++++++++
 replay/stubs-system.c       |  6 ------
 7 files changed, 94 insertions(+), 8 deletions(-)
 create mode 100644 audio/audio-hmp-cmds-stub.c
 create mode 100644 audio/audio-stub.c
 create mode 100644 replay/replay-audio-stub.c

diff --git a/audio/audio-hmp-cmds-stub.c b/audio/audio-hmp-cmds-stub.c
new file mode 100644
index 0000000000..2f94f1c8dd
--- /dev/null
+++ b/audio/audio-hmp-cmds-stub.c
@@ -0,0 +1,28 @@
+/*
+ * Stub for audio-hmp-cmds.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "audio_int.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qemu/error-report.h"
+
+void hmp_info_capture(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon, "audio subsystem is disabled at compile time");
+}
+
+void hmp_stopcapture(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon, "audio subsystem is disabled at compile time");
+}
+
+void hmp_wavcapture(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon, "audio subsystem is disabled at compile time");
+}
diff --git a/audio/audio-stub.c b/audio/audio-stub.c
new file mode 100644
index 0000000000..0c9e2446e0
--- /dev/null
+++ b/audio/audio-stub.c
@@ -0,0 +1,35 @@
+/*
+ * Stub for audio.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-commands-audio.h"
+#include "qemu/audio.h"
+#include "qapi/error.h"
+
+void audio_cleanup(void) {}
+
+AudioBackend *audio_be_by_name(const char *name, Error **errp)
+{
+  error_setg(
+      errp,
+      "trying to find audiodev '%s' by name with audio component disabled",
+      name);
+  return NULL;
+}
+
+const char *audio_be_get_id(AudioBackend *be) { return ""; }
+
+bool audio_be_set_dbus_server(AudioBackend *be,
+                              GDBusObjectManagerServer *server, bool p2p,
+                              Error **errp)
+{
+  error_setg(errp, "trying to set dbus server with audio component disabled");
+  return false;
+}
+
+void audio_init_audiodevs(void) {}
+
+void audio_create_default_audiodevs(void) {}
diff --git a/audio/meson.build b/audio/meson.build
index b2dca2c640..ea1f88fb6f 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,3 +1,8 @@
+if not audio_enabled
+  system_ss.add(files('audio-stub.c', 'audio-hmp-cmds-stub.c'))
+  subdir_done()
+endif
+
 system_ss.add(files(
   'audio.c',
   'mixeng.c',
diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b9710..28fda7c8ac 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -540,4 +540,5 @@
 # Since: 8.0
 ##
 { 'command': 'query-audiodevs',
-  'returns': ['Audiodev'] }
+  'returns': ['Audiodev'],
+  'if': 'CONFIG_AUDIO' }
diff --git a/replay/meson.build b/replay/meson.build
index 4b4175e8dd..7f8b5dca61 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -7,7 +7,14 @@ system_ss.add(when: 'CONFIG_TCG', if_true: files(
   'replay-char.c',
   'replay-snapshot.c',
   'replay-net.c',
-  'replay-audio.c',
   'replay-random.c',
   'replay-debugging.c',
 ), if_false: files('stubs-system.c'))
+
+if audio_enabled
+  system_ss.add(when: 'CONFIG_TCG',
+  if_true: files('replay-audio.c'),
+  if_false: files('replay-audio-stub.c'))
+else
+  system_ss.add(files('replay-audio-stub.c'))
+endif
diff --git a/replay/replay-audio-stub.c b/replay/replay-audio-stub.c
new file mode 100644
index 0000000000..303e5075f4
--- /dev/null
+++ b/replay/replay-audio-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Stub for replay-audio.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/replay.h"
+
+void replay_audio_in(size_t *recorded, st_sample *samples,
+                     size_t *wpos, size_t size)
+{
+}
+void replay_audio_out(size_t *played)
+{
+}
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 7f85764936..454415ae8e 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -15,12 +15,6 @@ void replay_input_sync_event(void)
 void replay_add_blocker(const char *feature)
 {
 }
-void replay_audio_in(size_t *recorded, st_sample *samples, size_t *wpos, size_t size)
-{
-}
-void replay_audio_out(size_t *played)
-{
-}
 void replay_breakpoint(void)
 {
 }
-- 
2.34.1


