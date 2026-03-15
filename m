Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CBEF3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruL-0006ON-84; Sun, 15 Mar 2026 16:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru8-0006Lp-Ab
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:43 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1ru1-0002MI-Fo
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 19263C015E;
 Sun, 15 Mar 2026 23:17:08 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6HRU4I1AiW20-yuy6ChCo; Sun, 15 Mar 2026 23:17:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605827;
 bh=OtOi++Rdlpxpjg6Ayel0tUplois5GcilUO3H0jXdAjs=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=huuZ+LQvIvRoJf0WZ3+3oXHA/ft6/TgW7eqVgOi2Zme9TwY+dkejGUMwpgGsaQ59H
 Bjf/ZRlGRqH3O/pJfmpr6UP4CFHX8Z1QX6noHw3WpDApmgRY8BDxitViK7cRFfHfu0
 2Y6mZCgOGj4K3dpwxYFIn9wWkKs2WKoyGWKYXwbs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
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
Subject: [PATCH v3 09/11] audio: do not build audio-related sources with
 --disable-audio
Date: Mon, 16 Mar 2026 01:16:44 +0500
Message-Id: <20260315201646.96862-10-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

- replay/replay-audio-stub.c:
  Move the existing stubs from replay/stubs-system.c into a separate
  file.

- qapi/audio.json:
  Remove the QMP `query-audiodevs` command.

- hmp-commands*.hx:
  Remove the HMP `info capture`, `stopcapture` and `wavcapture`
  commands.

- Other source files:
  Wrap audio-related code in ifdefs.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 audio/meson.build                |  4 ++++
 hmp-commands-info.hx             |  2 ++
 hmp-commands.hx                  |  2 ++
 hw/core/machine.c                |  6 ++++++
 hw/core/qdev-properties-system.c |  2 ++
 qapi/audio.json                  |  3 ++-
 replay/meson.build               |  9 ++++++++-
 replay/replay-audio-stub.c       | 21 +++++++++++++++++++++
 replay/stubs-system.c            | 12 ------------
 system/runstate.c                |  2 ++
 system/vl.c                      |  2 ++
 11 files changed, 51 insertions(+), 14 deletions(-)
 create mode 100644 replay/replay-audio-stub.c

diff --git a/audio/meson.build b/audio/meson.build
index 0e33b6f9836..4cd855d2b9a 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,4 +1,8 @@
 audio_ss = ss.source_set()
+if not have_audio
+  subdir_done()
+endif
+
 audio_ss.add(files(
   'audio.c',
   'audio-be.c',
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e2..a959479024a 100644
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
index 5cc4788f12d..e8b8175bb94 100644
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
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a14ad05b9a6..920a74b3aef 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -678,6 +678,7 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
     return allowed;
 }
 
+#ifdef CONFIG_AUDIO
 static char *machine_get_audiodev(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -697,6 +698,7 @@ static void machine_set_audiodev(Object *obj, const char *value,
     g_free(ms->audiodev);
     ms->audiodev = g_strdup(value);
 }
+#endif
 
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 {
@@ -990,6 +992,7 @@ out_free:
     qapi_free_BootConfiguration(config);
 }
 
+#ifdef CONFIG_AUDIO
 void machine_add_audiodev_property(MachineClass *mc)
 {
     ObjectClass *oc = OBJECT_CLASS(mc);
@@ -1000,6 +1003,7 @@ void machine_add_audiodev_property(MachineClass *mc)
     object_class_property_set_description(oc, "audiodev",
                                           "Audiodev to use for default machine devices");
 }
+#endif
 
 static bool create_default_memdev(MachineState *ms, const char *path,
                                   Error **errp)
@@ -1286,7 +1290,9 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+#ifdef CONFIG_AUDIO
     g_free(ms->audiodev);
+#endif
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a402321f42c..8679a71b538 100644
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
index 2df87b97101..28fda7c8ac3 100644
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
index 4b4175e8dd4..dc2e94e8975 100644
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
index 00000000000..b3da8e15583
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
index b2c52bc4043..454415ae8e4 100644
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
diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c6..7fb104f6515 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -1035,7 +1035,9 @@ void qemu_cleanup(int status)
     /* vhost-user must be cleaned up before chardevs.  */
     tpm_cleanup();
     net_cleanup();
+#ifdef CONFIG_AUDIO
     audio_cleanup();
+#endif
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
diff --git a/system/vl.c b/system/vl.c
index 9ed0285c47a..bd2b6439f00 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2069,10 +2069,12 @@ static void qemu_create_early_backends(void)
      * setting machine properties, so they can be referred to.
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
+#ifdef CONFIG_AUDIO
     audio_init_audiodevs();
     if (default_audio) {
         audio_create_default_audiodevs();
     }
+#endif
 }
 
 
-- 
2.34.1


