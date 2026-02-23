Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B173DEA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWIy-00012j-L3; Mon, 23 Feb 2026 08:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIW-0000Sq-Ax
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIT-00072Y-Fx
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJuk4ChSh9AVrJiSUKyWmdUAakOuqgTvT75kzXiLvwc=;
 b=afneGewLnQbpbPx2pAJyEEuwpdKzrOPqql0m86uVhF5iu6ArxpeOJJMiY7qvszA0hNK8Y6
 IayrMxQexR7JbeKrGHgzP7GaItwOy/qSusPs5PbcKlMO34nrrB3QFYreP56VW8Z4fJcOj6
 Dtxao1M2xO45yR9TxgMXpZxjsg+2JcA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-EKIjB6CbPwqerZqSmtwkbw-1; Mon,
 23 Feb 2026 08:48:23 -0500
X-MC-Unique: EKIjB6CbPwqerZqSmtwkbw-1
X-Mimecast-MFC-AGG-ID: EKIjB6CbPwqerZqSmtwkbw_1771854502
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46B201800265; Mon, 23 Feb 2026 13:48:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 206E71955F22; Mon, 23 Feb 2026 13:48:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 18/85] tests: start manual audio backend test
Date: Mon, 23 Feb 2026 14:46:19 +0100
Message-ID: <20260223134731.2377432-19-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

Start a simple test program that will exercise the QEMU audio APIs.

It is meant to run manually for now, as it accesses the sound system and
produces sound by default, and also runs for a few seconds. We may want
to make it silent or use the "none" (noaudio) backend by default though,
so it can run as part of the automated test suite.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS               |   1 +
 meson.build               |  17 +-
 tests/audio/audio-stubs.c |  62 ++++
 tests/audio/test-audio.c  | 599 ++++++++++++++++++++++++++++++++++++++
 audio/meson.build         |   2 +-
 tests/audio/meson.build   |  23 ++
 tests/meson.build         |   1 +
 ui/meson.build            |   3 +
 8 files changed, 702 insertions(+), 6 deletions(-)
 create mode 100644 tests/audio/audio-stubs.c
 create mode 100644 tests/audio/test-audio.c
 create mode 100644 tests/audio/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 4918f41ec45..233d2a5e71f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3036,6 +3036,7 @@ X: audio/sndioaudio.c
 X: audio/spiceaudio.c
 F: include/qemu/audio*.h
 F: qapi/audio.json
+F: tests/audio/
 
 ALSA Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/meson.build b/meson.build
index 17c4afdd45e..414c8ea7e28 100644
--- a/meson.build
+++ b/meson.build
@@ -3879,6 +3879,7 @@ target_modules += { 'accel' : { 'qtest': qtest_module_ss }}
 modinfo_collect = find_program('scripts/modinfo-collect.py')
 modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
+audio_modinfo_files = []
 
 block_mods = []
 system_mods = []
@@ -3906,15 +3907,21 @@ foreach d, list : modules
                     install: true,
                     install_dir: qemu_moddir)
       if module_ss.sources() != []
-        modinfo_files += custom_target(d + '-' + m + '.modinfo',
-                                       output: d + '-' + m + '.modinfo',
-                                       input: sl.extract_all_objects(recursive: true),
-                                       capture: true,
-                                       command: [modinfo_collect, '@INPUT@'])
+        modinfo = custom_target(d + '-' + m + '.modinfo',
+                                output: d + '-' + m + '.modinfo',
+                                input: sl.extract_all_objects(recursive: true),
+                                capture: true,
+                                command: [modinfo_collect, '@INPUT@'])
+        modinfo_files += modinfo
+        if d == 'audio'
+          audio_modinfo_files += modinfo
+        endif
       endif
     else
       if d == 'block'
         block_ss.add_all(module_ss)
+      elif d == 'audio'
+        audio_ss.add_all(module_ss)
       else
         system_ss.add_all(module_ss)
       endif
diff --git a/tests/audio/audio-stubs.c b/tests/audio/audio-stubs.c
new file mode 100644
index 00000000000..dd7f635d460
--- /dev/null
+++ b/tests/audio/audio-stubs.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * Stubs for audio test - provides missing functions for standalone audio test
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/dbus.h"
+#include "ui/qemu-spice-module.h"
+#include "ui/dbus-module.h"
+#include "system/replay.h"
+#include "system/runstate.h"
+
+int using_spice;
+int using_dbus_display;
+
+struct QemuSpiceOps qemu_spice;
+
+GQuark dbus_display_error_quark(void)
+{
+    return g_quark_from_static_string("dbus-display-error-quark");
+}
+
+#ifdef WIN32
+/* from ui/dbus.h */
+bool
+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
+                         GVariant *arg_listener, int *socket);
+
+bool
+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
+                         GVariant *arg_listener, int *socket)
+{
+    return true;
+}
+#endif
+
+void replay_audio_in(size_t *recorded, st_sample *samples,
+                     size_t *wpos, size_t size)
+{
+}
+
+void replay_audio_out(size_t *played)
+{
+}
+
+static int dummy_vmse;
+
+VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
+                                                     void *opaque)
+{
+    return (VMChangeStateEntry *)&dummy_vmse;
+}
+
+void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
+{
+}
+
+bool runstate_is_running(void)
+{
+    return true;
+}
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
new file mode 100644
index 00000000000..edb4971972c
--- /dev/null
+++ b/tests/audio/test-audio.c
@@ -0,0 +1,599 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/config-file.h"
+#include "qemu/cutils.h"
+#include "qemu/help_option.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "qemu/audio.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "trace/control.h"
+#include "glib.h"
+
+#include "audio/audio_int.h"
+
+#include <math.h>
+#ifdef CONFIG_SDL
+/*
+ * SDL insists on wrapping the main() function with its own implementation on
+ * some platforms; it does so via a macro that renames our main function, so
+ * <SDL.h> must be #included here even with no SDL code called from this file.
+ */
+#include <SDL.h>
+#endif
+
+#define SAMPLE_RATE     44100
+#define CHANNELS        2
+#define DURATION_SECS   2
+#define FREQUENCY       440.0
+#define BUFFER_FRAMES   1024
+#define TIMEOUT_SECS    (DURATION_SECS + 1)
+
+/* Command-line options */
+static gchar *opt_audiodev;
+static gchar *opt_trace;
+
+static GOptionEntry test_options[] = {
+    { "audiodev", 'a', 0, G_OPTION_ARG_STRING, &opt_audiodev,
+      "Audio device spec (e.g., none or pa,out.buffer-length=50000)", "DEV" },
+    { "trace", 'T', 0, G_OPTION_ARG_STRING, &opt_trace,
+      "Trace options (e.g., 'pw_*')", "TRACE" },
+    { NULL }
+};
+
+#define TEST_AUDIODEV_ID "test"
+
+typedef struct TestSineState {
+    AudioBackend *be;
+    SWVoiceOut *voice;
+    int64_t total_frames;
+    int64_t frames_written;
+} TestSineState;
+
+/* Default audio settings for tests */
+static const struct audsettings default_test_settings = {
+    .freq = SAMPLE_RATE,
+    .nchannels = CHANNELS,
+    .fmt = AUDIO_FORMAT_S16,
+    .endianness = 0,
+};
+
+static void dummy_audio_callback(void *opaque, int avail)
+{
+}
+
+static AudioBackend *get_test_audio_backend(void)
+{
+    AudioBackend *be;
+    Error *err = NULL;
+
+    if (opt_audiodev) {
+        be = audio_be_by_name(TEST_AUDIODEV_ID, &err);
+    } else {
+        be = audio_get_default_audio_be(&err);
+    }
+
+    if (err) {
+        g_error("%s", error_get_pretty(err));
+        error_free(err);
+        exit(1);
+    }
+    g_assert_nonnull(be);
+    return be;
+}
+
+/*
+ * Helper functions for opening test voices with default settings.
+ * These reduce boilerplate in test functions.
+ */
+static SWVoiceOut *open_test_voice_out(AudioBackend *be, const char *name,
+                                       void *opaque, audio_callback_fn cb)
+{
+    struct audsettings as = default_test_settings;
+    SWVoiceOut *voice;
+
+    voice = AUD_open_out(be, NULL, name, opaque, cb, &as);
+    g_assert_nonnull(voice);
+    return voice;
+}
+
+static SWVoiceIn *open_test_voice_in(AudioBackend *be, const char *name,
+                                     void *opaque, audio_callback_fn cb)
+{
+    struct audsettings as = default_test_settings;
+
+    return AUD_open_in(be, NULL, name, opaque, cb, &as);
+}
+
+/*
+ * Generate 440Hz sine wave samples into buffer.
+ */
+static void generate_sine_samples(int16_t *buffer, int frames,
+                                  int64_t start_frame)
+{
+    for (int i = 0; i < frames; i++) {
+        double t = (double)(start_frame + i) / SAMPLE_RATE;
+        double sample = sin(2.0 * M_PI * FREQUENCY * t);
+        int16_t s = (int16_t)(sample * 32767.0);
+
+        buffer[i * 2] = s;       /* left channel */
+        buffer[i * 2 + 1] = s;   /* right channel */
+    }
+}
+
+static void test_sine_callback(void *opaque, int avail)
+{
+    TestSineState *s = opaque;
+    int16_t buffer[BUFFER_FRAMES * CHANNELS];
+    int frames_remaining;
+    int frames_to_write;
+    size_t bytes_written;
+
+    frames_remaining = s->total_frames - s->frames_written;
+    if (frames_remaining <= 0) {
+        return;
+    }
+
+    frames_to_write = avail / (sizeof(int16_t) * CHANNELS);
+    frames_to_write = MIN(frames_to_write, BUFFER_FRAMES);
+    frames_to_write = MIN(frames_to_write, frames_remaining);
+
+    generate_sine_samples(buffer, frames_to_write, s->frames_written);
+
+    bytes_written = AUD_write(s->voice, buffer,
+                              frames_to_write * sizeof(int16_t) * CHANNELS);
+    s->frames_written += bytes_written / (sizeof(int16_t) * CHANNELS);
+}
+
+
+static void test_audio_out_sine_wave(void)
+{
+    TestSineState state = {0};
+    int64_t start_time;
+    int64_t elapsed_ms;
+
+    state.be = get_test_audio_backend();
+    state.total_frames = SAMPLE_RATE * DURATION_SECS;
+    state.frames_written = 0;
+
+    g_test_message("Opening audio output...");
+    state.voice = open_test_voice_out(state.be, "test-sine",
+                                      &state, test_sine_callback);
+
+    g_test_message("Playing 440Hz sine wave for %d seconds...", DURATION_SECS);
+    AUD_set_active_out(state.voice, true);
+
+    /*
+     * Run the audio subsystem until all frames are written or timeout.
+     */
+    start_time = g_get_monotonic_time();
+    while (state.frames_written < state.total_frames) {
+        audio_run(state.be, "test");
+        main_loop_wait(true);
+
+        elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
+        if (elapsed_ms > TIMEOUT_SECS * 1000) {
+            g_test_message("Timeout waiting for audio to complete");
+            break;
+        }
+
+        g_usleep(G_USEC_PER_SEC / 100);  /* 10ms */
+    }
+
+    g_test_message("Wrote %" PRId64 " frames (%.2f seconds)",
+                   state.frames_written,
+                   (double)state.frames_written / SAMPLE_RATE);
+
+    g_assert_cmpint(state.frames_written, ==, state.total_frames);
+
+    AUD_set_active_out(state.voice, false);
+    AUD_close_out(state.be, state.voice);
+}
+
+static void test_audio_prio_list(void)
+{
+    g_autofree gchar *backends = NULL;
+    GString *str = g_string_new(NULL);
+    bool has_none = false;
+
+    for (int i = 0; audio_prio_list[i]; i++) {
+        if (i > 0) {
+            g_string_append_c(str, ' ');
+        }
+        g_string_append(str, audio_prio_list[i]);
+
+        if (g_strcmp0(audio_prio_list[i], "none") == 0) {
+            has_none = true;
+        }
+    }
+
+    backends = g_string_free(str, FALSE);
+    g_test_message("Available backends: %s", backends);
+
+    /* The 'none' backend should always be available */
+    g_assert_true(has_none);
+}
+
+static void test_audio_out_active_state(void)
+{
+    AudioBackend *be;
+    SWVoiceOut *voice;
+
+    be = get_test_audio_backend();
+    voice = open_test_voice_out(be, "test-active", NULL, dummy_audio_callback);
+
+    g_assert_false(AUD_is_active_out(voice));
+
+    AUD_set_active_out(voice, true);
+    g_assert_true(AUD_is_active_out(voice));
+
+    AUD_set_active_out(voice, false);
+    g_assert_false(AUD_is_active_out(voice));
+
+    AUD_close_out(be, voice);
+}
+
+static void test_audio_out_buffer_size(void)
+{
+    AudioBackend *be;
+    SWVoiceOut *voice;
+    int buffer_size;
+
+    be = get_test_audio_backend();
+    voice = open_test_voice_out(be, "test-buffer", NULL, dummy_audio_callback);
+
+    buffer_size = AUD_get_buffer_size_out(voice);
+    g_test_message("Buffer size: %d bytes", buffer_size);
+    g_assert_cmpint(buffer_size, >, 0);
+
+    AUD_close_out(be, voice);
+
+    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
+}
+
+static void test_audio_out_volume(void)
+{
+    AudioBackend *be;
+    SWVoiceOut *voice;
+    Volume vol;
+
+    be = get_test_audio_backend();
+    voice = open_test_voice_out(be, "test-volume", NULL, dummy_audio_callback);
+
+    vol = (Volume){ .mute = false, .channels = 2, .vol = {255, 255} };
+    AUD_set_volume_out(voice, &vol);
+
+    vol = (Volume){ .mute = true, .channels = 2, .vol = {255, 255} };
+    AUD_set_volume_out(voice, &vol);
+
+    vol = (Volume){ .mute = false, .channels = 2, .vol = {128, 128} };
+    AUD_set_volume_out(voice, &vol);
+
+    AUD_close_out(be, voice);
+}
+
+static void test_audio_in_active_state(void)
+{
+    AudioBackend *be;
+    SWVoiceIn *voice;
+
+    be = get_test_audio_backend();
+    voice = open_test_voice_in(be, "test-in-active", NULL, dummy_audio_callback);
+    if (!voice) {
+        g_test_skip("The backend may not support input");
+        return;
+    }
+
+    g_assert_false(AUD_is_active_in(voice));
+
+    AUD_set_active_in(voice, true);
+    g_assert_true(AUD_is_active_in(voice));
+
+    AUD_set_active_in(voice, false);
+    g_assert_false(AUD_is_active_in(voice));
+
+    AUD_close_in(be, voice);
+}
+
+static void test_audio_in_volume(void)
+{
+    AudioBackend *be;
+    SWVoiceIn *voice;
+    Volume vol;
+
+    be = get_test_audio_backend();
+    voice = open_test_voice_in(be, "test-in-volume", NULL, dummy_audio_callback);
+    if (!voice) {
+        g_test_skip("The backend may not support input");
+        return;
+    }
+
+    vol = (Volume){ .mute = false, .channels = 2, .vol = {255, 255} };
+    AUD_set_volume_in(voice, &vol);
+
+    vol = (Volume){ .mute = true, .channels = 2, .vol = {255, 255} };
+    AUD_set_volume_in(voice, &vol);
+
+    AUD_close_in(be, voice);
+}
+
+
+/* Capture test state */
+#define CAPTURE_BUFFER_FRAMES (SAMPLE_RATE / 10)  /* 100ms of audio */
+#define CAPTURE_BUFFER_SIZE   (CAPTURE_BUFFER_FRAMES * CHANNELS * sizeof(int16_t))
+
+typedef struct TestCaptureState {
+    bool notify_called;
+    bool capture_called;
+    bool destroy_called;
+    audcnotification_e last_notify;
+    int16_t *captured_samples;
+    size_t captured_bytes;
+    size_t capture_buffer_size;
+} TestCaptureState;
+
+static void test_capture_notify(void *opaque, audcnotification_e cmd)
+{
+    TestCaptureState *s = opaque;
+    s->notify_called = true;
+    s->last_notify = cmd;
+}
+
+static void test_capture_capture(void *opaque, const void *buf, int size)
+{
+    TestCaptureState *s = opaque;
+    size_t bytes_to_copy;
+
+    s->capture_called = true;
+
+    if (!s->captured_samples || s->captured_bytes >= s->capture_buffer_size) {
+        return;
+    }
+
+    bytes_to_copy = MIN(size, s->capture_buffer_size - s->captured_bytes);
+    memcpy((uint8_t *)s->captured_samples + s->captured_bytes, buf, bytes_to_copy);
+    s->captured_bytes += bytes_to_copy;
+}
+
+static void test_capture_destroy(void *opaque)
+{
+    TestCaptureState *s = opaque;
+    s->destroy_called = true;
+}
+
+/*
+ * Compare captured audio with expected sine wave.
+ * Returns the number of matching samples (within tolerance).
+ */
+static int compare_sine_samples(const int16_t *captured, int frames,
+                                int64_t start_frame, int tolerance)
+{
+    int matching = 0;
+
+    for (int i = 0; i < frames; i++) {
+        double t = (double)(start_frame + i) / SAMPLE_RATE;
+        double sample = sin(2.0 * M_PI * FREQUENCY * t);
+        int16_t expected = (int16_t)(sample * 32767.0);
+
+        /* Check left channel */
+        if (abs(captured[i * 2] - expected) <= tolerance) {
+            matching++;
+        }
+        /* Check right channel */
+        if (abs(captured[i * 2 + 1] - expected) <= tolerance) {
+            matching++;
+        }
+    }
+
+    return matching;
+}
+
+static void test_audio_capture(void)
+{
+    AudioBackend *be;
+    CaptureVoiceOut *cap;
+    SWVoiceOut *voice;
+    TestCaptureState state = {0};
+    TestSineState sine_state = {0};
+    struct audsettings as = default_test_settings;
+    struct audio_capture_ops ops = {
+        .notify = test_capture_notify,
+        .capture = test_capture_capture,
+        .destroy = test_capture_destroy,
+    };
+    int64_t start_time;
+    int64_t elapsed_ms;
+    int captured_frames;
+    int matching_samples;
+    int total_samples;
+    double match_ratio;
+
+    be = get_test_audio_backend();
+
+    state.captured_samples = g_malloc0(CAPTURE_BUFFER_SIZE);
+    state.captured_bytes = 0;
+    state.capture_buffer_size = CAPTURE_BUFFER_SIZE;
+
+    cap = AUD_add_capture(be, &as, &ops, &state);
+    g_assert_nonnull(cap);
+
+    sine_state.be = be;
+    sine_state.total_frames = CAPTURE_BUFFER_FRAMES;
+    sine_state.frames_written = 0;
+
+    voice = open_test_voice_out(be, "test-capture-sine",
+                                &sine_state, test_sine_callback);
+    sine_state.voice = voice;
+
+    AUD_set_active_out(voice, true);
+
+    start_time = g_get_monotonic_time();
+    while (sine_state.frames_written < sine_state.total_frames ||
+           state.captured_bytes < CAPTURE_BUFFER_SIZE) {
+        audio_run(be, "test-capture");
+        main_loop_wait(true);
+
+        elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
+        if (elapsed_ms > 1000) {  /* 1 second timeout */
+            break;
+        }
+
+        g_usleep(G_USEC_PER_SEC / 1000);  /* 1ms */
+    }
+
+    g_test_message("Wrote %" PRId64 " frames, captured %zu bytes",
+                   sine_state.frames_written, state.captured_bytes);
+
+    g_assert_true(state.capture_called);
+    g_assert_cmpuint(state.captured_bytes, >, 0);
+
+    /* Compare captured data with expected sine wave */
+    captured_frames = state.captured_bytes / (CHANNELS * sizeof(int16_t));
+    if (captured_frames > 0) {
+        /*
+         * Allow some tolerance due to mixing/conversion.
+         * The tolerance accounts for potential rounding differences.
+         */
+        matching_samples = compare_sine_samples(state.captured_samples,
+                                                captured_frames, 0, 100);
+        total_samples = captured_frames * CHANNELS;
+        match_ratio = (double)matching_samples / total_samples;
+
+        g_test_message("Captured %d frames, %d/%d samples match (%.1f%%)",
+                       captured_frames, matching_samples, total_samples,
+                       match_ratio * 100.0);
+
+        /*
+         * Expect at least 90% of samples to match within tolerance.
+         * Some variation is expected due to mixing engine processing.
+         */
+        g_assert_cmpfloat(match_ratio, >=, 0.9);
+    }
+
+    AUD_set_active_out(voice, false);
+    AUD_close_out(be, voice);
+
+    AUD_del_capture(cap, &state);
+    g_assert_true(state.destroy_called);
+
+    g_free(state.captured_samples);
+}
+
+static void test_audio_null_handling(void)
+{
+    uint8_t buffer[64];
+
+    /* AUD_is_active_out/in(NULL) should return false */
+    g_assert_false(AUD_is_active_out(NULL));
+    g_assert_false(AUD_is_active_in(NULL));
+
+    /* AUD_get_buffer_size_out(NULL) should return 0 */
+    g_assert_cmpint(AUD_get_buffer_size_out(NULL), ==, 0);
+
+    /* AUD_write/read(NULL, ...) should return size (no-op) */
+    g_assert_cmpuint(AUD_write(NULL, buffer, sizeof(buffer)), ==,
+                     sizeof(buffer));
+    g_assert_cmpuint(AUD_read(NULL, buffer, sizeof(buffer)), ==,
+                     sizeof(buffer));
+
+    /* These should not crash */
+    AUD_set_active_out(NULL, true);
+    AUD_set_active_out(NULL, false);
+    AUD_set_active_in(NULL, true);
+    AUD_set_active_in(NULL, false);
+}
+
+static void test_audio_multiple_voices(void)
+{
+    AudioBackend *be;
+    SWVoiceOut *out1, *out2;
+    SWVoiceIn *in1;
+
+    be = get_test_audio_backend();
+    out1 = open_test_voice_out(be, "test-multi-out1", NULL, dummy_audio_callback);
+    out2 = open_test_voice_out(be, "test-multi-out2", NULL, dummy_audio_callback);
+    in1 = open_test_voice_in(be, "test-multi-in1", NULL, dummy_audio_callback);
+
+    AUD_set_active_out(out1, true);
+    AUD_set_active_out(out2, true);
+    AUD_set_active_in(in1, true);
+
+    g_assert_true(AUD_is_active_out(out1));
+    g_assert_true(AUD_is_active_out(out2));
+    if (in1) {
+        g_assert_true(AUD_is_active_in(in1));
+    }
+
+    AUD_set_active_out(out1, false);
+    AUD_set_active_out(out2, false);
+    AUD_set_active_in(in1, false);
+
+    AUD_close_in(be, in1);
+    AUD_close_out(be, out2);
+    AUD_close_out(be, out1);
+}
+
+int main(int argc, char **argv)
+{
+    GOptionContext *context;
+    g_autoptr(GError) error = NULL;
+    g_autofree gchar *dir = NULL;
+    int ret;
+
+    context = g_option_context_new("- QEMU audio test");
+    g_option_context_add_main_entries(context, test_options, NULL);
+
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        return 1;
+    }
+    g_option_context_free(context);
+
+    g_test_init(&argc, &argv, NULL);
+
+    module_call_init(MODULE_INIT_TRACE);
+    qemu_add_opts(&qemu_trace_opts);
+    if (opt_trace) {
+        trace_opt_parse(opt_trace);
+        qemu_set_log(LOG_TRACE, &error_fatal);
+    }
+    trace_init_backends();
+    trace_init_file();
+
+    dir = g_test_build_filename(G_TEST_BUILT, "..", "..", NULL);
+    g_setenv("QEMU_MODULE_DIR", dir, true);
+    qemu_init_exec_dir(argv[0]);
+    module_call_init(MODULE_INIT_QOM);
+    module_init_info(qemu_modinfo);
+
+    qemu_init_main_loop(&error_abort);
+    if (opt_audiodev) {
+        g_autofree gchar *spec = is_help_option(opt_audiodev) ?
+            opt_audiodev : g_strdup_printf("%s,id=%s", opt_audiodev, TEST_AUDIODEV_ID);
+        audio_parse_option(spec);
+    }
+    audio_create_default_audiodevs();
+    audio_init_audiodevs();
+
+    g_test_add_func("/audio/prio-list", test_audio_prio_list);
+
+    g_test_add_func("/audio/out/active-state", test_audio_out_active_state);
+    g_test_add_func("/audio/out/sine-wave", test_audio_out_sine_wave);
+    g_test_add_func("/audio/out/buffer-size", test_audio_out_buffer_size);
+    g_test_add_func("/audio/out/volume", test_audio_out_volume);
+    g_test_add_func("/audio/out/capture", test_audio_capture);
+
+    g_test_add_func("/audio/in/active-state", test_audio_in_active_state);
+    g_test_add_func("/audio/in/volume", test_audio_in_volume);
+
+    g_test_add_func("/audio/null-handling", test_audio_null_handling);
+    g_test_add_func("/audio/multiple-voices", test_audio_multiple_voices);
+
+    ret = g_test_run();
+
+    audio_cleanup();
+
+    return ret;
+}
diff --git a/audio/meson.build b/audio/meson.build
index a5fec14fb3a..55ee0bfc865 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -32,7 +32,7 @@ endforeach
 if dbus_display
     module_ss = ss.source_set()
     module_ss.add(when: [gio, pixman],
-                  if_true: [dbus_display1, files('dbusaudio.c')])
+                  if_true: [dbus_display1_h, files('dbusaudio.c')])
     audio_modules += {'dbus': module_ss}
 endif
 
diff --git a/tests/audio/meson.build b/tests/audio/meson.build
new file mode 100644
index 00000000000..84754bde221
--- /dev/null
+++ b/tests/audio/meson.build
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+if not have_system
+  subdir_done()
+endif
+
+modinfo_dep = not_found
+if enable_modules
+    modinfo_src = custom_target('modinfo.c',
+                                output: 'modinfo.c',
+                                input: audio_modinfo_files,
+                                command: [modinfo_generate, '--skip-missing-deps', '@INPUT@'],
+                                capture: true)
+
+    modinfo_lib = static_library('modinfo.c', modinfo_src)
+    modinfo_dep = declare_dependency(link_with: modinfo_lib)
+endif
+
+# manual audio test - not part of automated test suite
+# as it relies on audio system
+executable('test-audio',
+    sources: [files('test-audio.c', 'audio-stubs.c'), dbus_display1],
+    dependencies: [audio, qemuutil, modinfo_dep, gio, spice, sdl])
diff --git a/tests/meson.build b/tests/meson.build
index 87861b28575..9ba04bbedd3 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -77,6 +77,7 @@ if 'CONFIG_TCG' in config_all_accel
   subdir('tcg/plugins')
 endif
 
+subdir('audio')
 subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
diff --git a/ui/meson.build b/ui/meson.build
index 6371422c460..69404bca71a 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -70,6 +70,7 @@ if opengl.found()
   ui_modules += {'egl-headless' : egl_headless_ss}
 endif
 
+dbus_display1 = files()
 if dbus_display
   dbus_ss = ss.source_set()
   env = environment()
@@ -88,6 +89,8 @@ if dbus_display
                                           '--interface-prefix', 'org.qemu.',
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
+  dbus_display1_h = declare_dependency(dependencies: [gio],
+                                       sources: dbus_display1[0])
   dbus_ss.add(when: gio,
               if_true: [files(
                 'dbus-chardev.c',
-- 
2.53.0


