Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD9DEC1126
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucVB-0003fd-3a; Mon, 23 Feb 2026 15:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucV0-0003Fz-Ut
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:47 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUq-0002Q5-FH
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E079982FAE;
 Mon, 23 Feb 2026 23:25:33 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-iKaPnRDF; 
 Mon, 23 Feb 2026 23:25:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878333;
 bh=HUFhgKVNj/LZH5vB4eAuPYv3xept63cXyT7ucevHwAg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0t0ZBXH4W/jCZ6G2A+P7koli0PUsLHu7uDBqL4LnwF2askcCq+7p2W/BcszVAois7
 OyxtnJ0tQZ3m8flTdFAzG2ZAQXB945nK7br/9fiXix9LNrbfVL0neI/fAeHBzSzTCH
 bz99vtAFzEYCPNlSU6W/+V6K7MSY0Cp9gW/Hny1o=
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
Subject: [PATCH v2 09/10] audio: do not build audio-related sources with
 --disable-audio
Date: Tue, 24 Feb 2026 01:25:11 +0500
Message-Id: <20260223202512.1308205-10-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223202512.1308205-1-heifetz@yandex-team.com>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
MIME-Version: 1.0
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

- hmp-commands*.hx:
  Remove the HMP `info capture`, `stopcapture` and `wavcapture`
  commands.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 audio/audio-stub.c               | 22 ++++++++++++++++++++++
 audio/meson.build                |  5 +++++
 hmp-commands-info.hx             |  2 ++
 hmp-commands.hx                  |  2 ++
 hw/core/qdev-properties-system.c |  2 ++
 qapi/audio.json                  |  3 ++-
 replay/meson.build               |  9 ++++++++-
 replay/replay-audio-stub.c       | 21 +++++++++++++++++++++
 replay/stubs-system.c            | 12 ------------
 9 files changed, 64 insertions(+), 14 deletions(-)
 create mode 100644 audio/audio-stub.c
 create mode 100644 replay/replay-audio-stub.c

diff --git a/audio/audio-stub.c b/audio/audio-stub.c
new file mode 100644
index 0000000000..f58f88cd83
--- /dev/null
+++ b/audio/audio-stub.c
@@ -0,0 +1,22 @@
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
+  error_setg(errp, "audio disabled");
+  return NULL;
+}
+
+void audio_init_audiodevs(void) {}
+
+void audio_create_default_audiodevs(void) {}
diff --git a/audio/meson.build b/audio/meson.build
index 0e33b6f983..19d43dc315 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,4 +1,9 @@
 audio_ss = ss.source_set()
+if not have_audio
+  audio_ss.add(files('audio-stub.c'))
+  subdir_done()
+endif
+
 audio_ss.add(files(
   'audio.c',
   'audio-be.c',
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e..a959479024 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -364,6 +364,7 @@ SRST
 ERST
 
 /* BEGIN deprecated */
+#ifdef CONFIG_AUDIO
     {
         .name       = "capture",
         .args_type  = "",
@@ -376,6 +377,7 @@ SRST
   ``info capture``
     Show capture information (deprecated).
 ERST
+#endif
 /* END deprecated */
 
     {
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..e8b8175bb9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -765,6 +765,7 @@ SRST
 ERST
 
 /* BEGIN deprecated */
+#ifdef CONFIG_AUDIO
     {
         .name       = "wavcapture",
         .args_type  = "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?",
@@ -802,6 +803,7 @@ SRST
 
   Deprecated.
 ERST
+#endif
 /* END deprecated */
 
     {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a402321f42..8679a71b53 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -483,6 +483,7 @@ const PropertyInfo qdev_prop_netdev = {
 };
 
 
+#ifdef CONFIG_AUDIO
 /* --- audiodev --- */
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
@@ -519,6 +520,7 @@ const PropertyInfo qdev_prop_audiodev = {
     .get = get_audiodev,
     .set = set_audiodev,
 };
+#endif
 
 bool qdev_prop_set_drive_err(DeviceState *dev, const char *name,
                              BlockBackend *value, Error **errp)
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
index 4b4175e8dd..dc2e94e897 100644
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
+if have_audio
+  system_ss.add(when: 'CONFIG_TCG',
+  if_true: files('replay-audio.c'),
+  if_false: files('replay-audio-stub.c'))
+else
+  system_ss.add(files('replay-audio-stub.c'))
+endif
diff --git a/replay/replay-audio-stub.c b/replay/replay-audio-stub.c
new file mode 100644
index 0000000000..b3da8e1558
--- /dev/null
+++ b/replay/replay-audio-stub.c
@@ -0,0 +1,21 @@
+/*
+ * Stub for replay-audio.c
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/replay.h"
+
+void replay_audio_in_start(size_t *nsamples)
+{
+}
+void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
+{
+}
+void replay_audio_in_finish(void)
+{
+}
+void replay_audio_out(size_t *played)
+{
+}
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index b2c52bc404..454415ae8e 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -15,18 +15,6 @@ void replay_input_sync_event(void)
 void replay_add_blocker(const char *feature)
 {
 }
-void replay_audio_in_start(size_t *nsamples)
-{
-}
-void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
-{
-}
-void replay_audio_in_finish(void)
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


