Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57C0D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22m-0007ON-QY; Mon, 01 Dec 2025 06:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22h-00072P-3c
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22c-00076g-0L
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/t94+ihrSNyoZccvd70585Z+HE8PEbdes0oy6oQQBlQ=;
 b=WGNoLikT0QPSZE1GoJnkJmUGfAsidqGTTlrlOCUeuvqTj24dLkP+DcfxjMNAzgmmlnXkkm
 JGec4PWP1kMqub2n5oCDglwGlH9d2d7rUVRxev+JCypFLCL7w1AGONk/3ThOV1tKNGF72X
 hm8yfj/mDIbOm0w2kRTS2/Wnkk7mYfM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-xLao2i6sOkq6G3hS9rF4xw-1; Mon,
 01 Dec 2025 06:25:59 -0500
X-MC-Unique: xLao2i6sOkq6G3hS9rF4xw-1
X-Mimecast-MFC-AGG-ID: xLao2i6sOkq6G3hS9rF4xw_1764588357
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF2B718002CD; Mon,  1 Dec 2025 11:25:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00409195608E; Mon,  1 Dec 2025 11:25:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org (open list:Rust-related patc...)
Subject: [RFC 24/24] WIP: rust/audio: add GStreamer backend
Date: Mon,  1 Dec 2025 15:23:05 +0400
Message-ID: <20251201112309.4163921-25-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

This patch introduce a rust/audio crate that replaces QEMU audio/
mixing/resampling code with GStreamer and Rust. It could potentially
remove the need for all the system-specific audio API implementation,
since GStreamer has audio elements for
ALSA/Pipewire/PulseAudio/jack/OSX/WASAPI etc (removing ~10k loc).

TODO:
- test on various system, with various configuration to see if this
  backend can replace the other QEMU audio backends
- add a spicesink/spicesrc to handle spice, or rewrite spice to use
  the capture approach used by VNC code. Or drop capture support, and
  use custom qemusrc/qemusink for both Spice and VNC, lowering the feature
  and behaviour disparity.
- build-sys: make gstreamer optional
- build-sys: loadable module support
- investigate dropping get_buffer_size_out()
- investigate improving emulated devices to not require regular
  timers (appsrc need-data is called once)
- add generic audio backend tests
- more tests for the mixing/liveadder behaviour (synchronization)
- other: replace audio/dbus with a rust implementation (not using gstreamer)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/audio.json               |   29 +
 audio/audio-driver_template.h |    2 +
 rust/audio/wrapper.h          |   27 +
 audio/audio.c                 |    5 +
 Cargo.lock                    |  572 ++++++++++++++++--
 Cargo.toml                    |    6 +
 audio/trace-events            |    5 +
 rust/audio/Cargo.toml         |   29 +
 rust/audio/build.rs           |   49 ++
 rust/audio/meson.build        |   75 +++
 rust/audio/src/audio.rs       |  516 ++++++++++++++++
 rust/audio/src/bindings.rs    |   32 +
 rust/audio/src/gstreamer.rs   | 1070 +++++++++++++++++++++++++++++++++
 rust/audio/src/lib.rs         |   99 +++
 rust/meson.build              |    6 +
 15 files changed, 2467 insertions(+), 55 deletions(-)
 create mode 100644 rust/audio/wrapper.h
 create mode 100644 rust/audio/Cargo.toml
 create mode 100644 rust/audio/build.rs
 create mode 100644 rust/audio/meson.build
 create mode 100644 rust/audio/src/audio.rs
 create mode 100644 rust/audio/src/bindings.rs
 create mode 100644 rust/audio/src/gstreamer.rs
 create mode 100644 rust/audio/src/lib.rs

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b9710..76dc7cbfa6 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -128,6 +128,33 @@
     '*out':       'AudiodevAlsaPerDirectionOptions',
     '*threshold': 'uint32' } }
 
+    ##
+    # @AudiodevGStreamerOptions:
+    #
+    # Options of the GStreamer audio backend.
+    #
+    # @in: options of the capture stream
+    #
+    # @out: options of the playback stream
+    #
+    # @sink: the name of the GStreamer sink element to use
+    #        (default 'autoaudiosink')
+    #
+    # @source: the name of the GStreamer source element to use
+    #        (default 'autoaudiosrc')
+    #
+    # Since: 11.0
+    ##
+    { 'struct': 'AudiodevGStreamerOptions',
+      'data': {
+        '*in':        'AudiodevPerDirectionOptions',
+        '*out':       'AudiodevPerDirectionOptions',
+        '*sink':      'str',
+        '*source':    'str'
+      }
+    }
+
+
 ##
 # @AudiodevSndioOptions:
 #
@@ -484,6 +511,7 @@
             { 'name': 'sdl', 'if': 'CONFIG_AUDIO_SDL' },
             { 'name': 'sndio', 'if': 'CONFIG_AUDIO_SNDIO' },
             { 'name': 'spice', 'if': 'CONFIG_SPICE' },
+            { 'name': 'gstreamer' },
             'wav' ] }
 
 ##
@@ -530,6 +558,7 @@
                    'if': 'CONFIG_AUDIO_SNDIO' },
     'spice':     { 'type': 'AudiodevGenericOptions',
                    'if': 'CONFIG_SPICE' },
+    'gstreamer': { 'type': 'AudiodevGStreamerOptions' },
     'wav':       'AudiodevWavOptions' } }
 
 ##
diff --git a/audio/audio-driver_template.h b/audio/audio-driver_template.h
index 40d1ad9dea..aa2451ac7f 100644
--- a/audio/audio-driver_template.h
+++ b/audio/audio-driver_template.h
@@ -391,6 +391,8 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
     case AUDIODEV_DRIVER_SPICE:
         return dev->u.spice.TYPE;
 #endif
+    case AUDIODEV_DRIVER_GSTREAMER:
+        abort();
     case AUDIODEV_DRIVER_WAV:
         return dev->u.wav.TYPE;
 
diff --git a/rust/audio/wrapper.h b/rust/audio/wrapper.h
new file mode 100644
index 0000000000..a7960d0acc
--- /dev/null
+++ b/rust/audio/wrapper.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
+#include "qemu/osdep.h"
+
+#include "qemu/audio.h"
diff --git a/audio/audio.c b/audio/audio.c
index ccb16ae3b2..5a11fe60db 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -219,6 +219,7 @@ static void audio_create_pdos(Audiodev *dev)
 #ifdef CONFIG_SPICE
         CASE(SPICE, spice, );
 #endif
+        CASE(GSTREAMER, gstreamer, );
         CASE(WAV, wav, );
 
     case AUDIODEV_DRIVER__MAX:
@@ -316,6 +317,8 @@ static AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev)
     case AUDIODEV_DRIVER_SPICE:
         return dev->u.spice.out;
 #endif
+    case AUDIODEV_DRIVER_GSTREAMER:
+        return dev->u.gstreamer.out;
     case AUDIODEV_DRIVER_WAV:
         return dev->u.wav.out;
 
@@ -375,6 +378,8 @@ static AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev)
     case AUDIODEV_DRIVER_SPICE:
         return dev->u.spice.in;
 #endif
+    case AUDIODEV_DRIVER_GSTREAMER:
+        return dev->u.gstreamer.in;
     case AUDIODEV_DRIVER_WAV:
         return dev->u.wav.in;
 
diff --git a/Cargo.lock b/Cargo.lock
index e6102b258b..274dd1be4a 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -4,15 +4,21 @@ version = 4
 
 [[package]]
 name = "anyhow"
-version = "1.0.98"
+version = "1.0.100"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
+checksum = "a23eb6b1614318a8071c9b2521f36b424b2c83db5eb3a0fead4a6c0809af6e61"
 
 [[package]]
 name = "arbitrary-int"
-version = "1.2.7"
+version = "1.3.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
+checksum = "825297538d77367557b912770ca3083f778a196054b3ee63b22673c4a3cae0a5"
+
+[[package]]
+name = "atomic_refcell"
+version = "0.1.13"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41e67cd8309bbd06cd603a9e693a784ac2e5d1e955f11286e355089fcab3047c"
 
 [[package]]
 name = "attrs"
@@ -24,6 +30,29 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "audio"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "common",
+ "futures",
+ "gio-sys",
+ "glib-sys",
+ "gstreamer-app",
+ "gstreamer-audio",
+ "qom",
+ "system",
+ "trace",
+ "util",
+]
+
+[[package]]
+name = "autocfg"
+version = "1.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8"
+
 [[package]]
 name = "bilge"
 version = "0.2.0"
@@ -40,13 +69,19 @@ version = "0.2.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
 dependencies = [
- "itertools",
+ "itertools 0.11.0",
  "proc-macro-error",
  "proc-macro2",
  "quote",
  "syn",
 ]
 
+[[package]]
+name = "bitflags"
+version = "2.10.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "812e12b5285cc515a9c72a5c1d3b6d46a19dac5acfef5265968c166106e31dd3"
+
 [[package]]
 name = "bits"
 version = "0.1.0"
@@ -63,14 +98,20 @@ dependencies = [
 
 [[package]]
 name = "cfg-expr"
-version = "0.20.3"
+version = "0.20.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "1a2c5f3bf25ec225351aa1c8e230d04d880d3bd89dea133537dafad4ae291e5c"
+checksum = "9acd0bdbbf4b2612d09f52ba61da432140cb10930354079d0d53fafc12968726"
 dependencies = [
  "smallvec",
  "target-lexicon",
 ]
 
+[[package]]
+name = "cfg-if"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+
 [[package]]
 name = "chardev"
 version = "0.1.0"
@@ -93,9 +134,9 @@ dependencies = [
 
 [[package]]
 name = "either"
-version = "1.12.0"
+version = "1.15.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
+checksum = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
 
 [[package]]
 name = "equivalent"
@@ -105,13 +146,149 @@ checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 
 [[package]]
 name = "foreign"
-version = "0.3.1"
+version = "0.3.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+checksum = "bec05eb9c07a3f66653535e5e50eb5eb935eb00d3bb7e06ea26a9d3a1d016182"
 dependencies = [
  "libc",
 ]
 
+[[package]]
+name = "futures"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "65bc07b1a8bc7c85c5f2e110c476c7389b4554ba72af57d8445ea63a576b0876"
+dependencies = [
+ "futures-channel",
+ "futures-core",
+ "futures-executor",
+ "futures-io",
+ "futures-sink",
+ "futures-task",
+ "futures-util",
+]
+
+[[package]]
+name = "futures-channel"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2dff15bf788c671c1934e366d07e30c1814a8ef514e1af724a602e8a2fbe1b10"
+dependencies = [
+ "futures-core",
+ "futures-sink",
+]
+
+[[package]]
+name = "futures-core"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "05f29059c0c2090612e8d742178b0580d2dc940c837851ad723096f87af6663e"
+
+[[package]]
+name = "futures-executor"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1e28d1d997f585e54aebc3f97d39e72338912123a67330d723fdbb564d646c9f"
+dependencies = [
+ "futures-core",
+ "futures-task",
+ "futures-util",
+]
+
+[[package]]
+name = "futures-io"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9e5c1b78ca4aae1ac06c48a526a655760685149f0d465d21f37abfe57ce075c6"
+
+[[package]]
+name = "futures-macro"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "162ee34ebcb7c64a8abebc059ce0fee27c2262618d7b60ed8faf72fef13c3650"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "futures-sink"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e575fab7d1e0dcb8d0c7bcf9a63ee213816ab51902e6d244a95819acacf1d4f7"
+
+[[package]]
+name = "futures-task"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f90f7dce0722e95104fcb095585910c0977252f286e354b5e3bd38902cd99988"
+
+[[package]]
+name = "futures-util"
+version = "0.3.31"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9fa08315bb612088cc391249efdc3bc77536f16c91f6cf495e6fbe85b20a4a81"
+dependencies = [
+ "futures-channel",
+ "futures-core",
+ "futures-io",
+ "futures-macro",
+ "futures-sink",
+ "futures-task",
+ "memchr",
+ "pin-project-lite",
+ "pin-utils",
+ "slab",
+]
+
+[[package]]
+name = "gio-sys"
+version = "0.21.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "171ed2f6dd927abbe108cfd9eebff2052c335013f5879d55bab0dc1dee19b706"
+dependencies = [
+ "glib-sys",
+ "gobject-sys",
+ "libc",
+ "system-deps",
+ "windows-sys",
+]
+
+[[package]]
+name = "glib"
+version = "0.21.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5b9dbecb1c33e483a98be4acfea2ab369e1c28f517c6eadb674537409c25c4b2"
+dependencies = [
+ "bitflags",
+ "futures-channel",
+ "futures-core",
+ "futures-executor",
+ "futures-task",
+ "futures-util",
+ "gio-sys",
+ "glib-macros",
+ "glib-sys",
+ "gobject-sys",
+ "libc",
+ "memchr",
+ "smallvec",
+]
+
+[[package]]
+name = "glib-macros"
+version = "0.21.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "880e524e0085f3546cfb38532b2c202c0d64741d9977a6e4aa24704bfc9f19fb"
+dependencies = [
+ "heck",
+ "proc-macro-crate",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
 [[package]]
 name = "glib-sys"
 version = "0.21.2"
@@ -122,11 +299,144 @@ dependencies = [
  "system-deps",
 ]
 
+[[package]]
+name = "gobject-sys"
+version = "0.21.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "538e41d8776173ec107e7b0f2aceced60abc368d7e1d81c1f0e2ecd35f59080d"
+dependencies = [
+ "glib-sys",
+ "libc",
+ "system-deps",
+]
+
+[[package]]
+name = "gstreamer"
+version = "0.24.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "69ac2f12970a2f85a681d2ceaa40c32fe86cc202ead315e0dfa2223a1217cd24"
+dependencies = [
+ "cfg-if",
+ "futures-channel",
+ "futures-core",
+ "futures-util",
+ "glib",
+ "gstreamer-sys",
+ "itertools 0.14.0",
+ "kstring",
+ "libc",
+ "muldiv",
+ "num-integer",
+ "num-rational",
+ "option-operations",
+ "pastey",
+ "pin-project-lite",
+ "smallvec",
+ "thiserror",
+]
+
+[[package]]
+name = "gstreamer-app"
+version = "0.24.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0af5d403738faf03494dfd502d223444b4b44feb997ba28ab3f118ee6d40a0b2"
+dependencies = [
+ "futures-core",
+ "futures-sink",
+ "glib",
+ "gstreamer",
+ "gstreamer-app-sys",
+ "gstreamer-base",
+ "libc",
+]
+
+[[package]]
+name = "gstreamer-app-sys"
+version = "0.24.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "aaf1a3af017f9493c34ccc8439cbce5c48f6ddff6ec0514c23996b374ff25f9a"
+dependencies = [
+ "glib-sys",
+ "gstreamer-base-sys",
+ "gstreamer-sys",
+ "libc",
+ "system-deps",
+]
+
+[[package]]
+name = "gstreamer-audio"
+version = "0.24.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "68e540174d060cd0d7ee2c2356f152f05d8262bf102b40a5869ff799377269d8"
+dependencies = [
+ "cfg-if",
+ "glib",
+ "gstreamer",
+ "gstreamer-audio-sys",
+ "gstreamer-base",
+ "libc",
+ "smallvec",
+]
+
+[[package]]
+name = "gstreamer-audio-sys"
+version = "0.24.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "626cd3130bc155a8b6d4ac48cfddc15774b5a6cc76fcb191aab09a2655bad8f5"
+dependencies = [
+ "glib-sys",
+ "gobject-sys",
+ "gstreamer-base-sys",
+ "gstreamer-sys",
+ "libc",
+ "system-deps",
+]
+
+[[package]]
+name = "gstreamer-base"
+version = "0.24.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "71ff9b0bbc8041f0c6c8a53b206a6542f86c7d9fa8a7dff3f27d9c374d9f39b4"
+dependencies = [
+ "atomic_refcell",
+ "cfg-if",
+ "glib",
+ "gstreamer",
+ "gstreamer-base-sys",
+ "libc",
+]
+
+[[package]]
+name = "gstreamer-base-sys"
+version = "0.24.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "fed78852b92db1459b8f4288f86e6530274073c20be2f94ba642cddaca08b00e"
+dependencies = [
+ "glib-sys",
+ "gobject-sys",
+ "gstreamer-sys",
+ "libc",
+ "system-deps",
+]
+
+[[package]]
+name = "gstreamer-sys"
+version = "0.24.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a24ae2930e683665832a19ef02466094b09d1f2da5673f001515ed5486aa9377"
+dependencies = [
+ "cfg-if",
+ "glib-sys",
+ "gobject-sys",
+ "libc",
+ "system-deps",
+]
+
 [[package]]
 name = "hashbrown"
-version = "0.16.0"
+version = "0.16.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
+checksum = "841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
 
 [[package]]
 name = "heck"
@@ -165,9 +475,9 @@ dependencies = [
 
 [[package]]
 name = "indexmap"
-version = "2.11.4"
+version = "2.12.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "4b0f83760fb341a774ed326568e19f5a863af4a952def8c39f9ab92fd95b88e5"
+checksum = "0ad4bb2b565bca0645f4d68c5c9af97fba094e9791da685bf83cb5f3ce74acf2"
 dependencies = [
  "equivalent",
  "hashbrown",
@@ -182,11 +492,29 @@ dependencies = [
  "either",
 ]
 
+[[package]]
+name = "itertools"
+version = "0.14.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2b192c782037fadd9cfa75548310488aabdbf3d2da73885b31bd0abd03351285"
+dependencies = [
+ "either",
+]
+
+[[package]]
+name = "kstring"
+version = "2.0.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "558bf9508a558512042d3095138b1f7b8fe90c5467d94f9f1da28b3731c5dbd1"
+dependencies = [
+ "static_assertions",
+]
+
 [[package]]
 name = "libc"
-version = "0.2.162"
+version = "0.2.177"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+checksum = "2874a2af47a2325c2001a6e6fad9b16a53b802102b528163885171cf92b15976"
 
 [[package]]
 name = "memchr"
@@ -205,6 +533,67 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "muldiv"
+version = "1.0.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "956787520e75e9bd233246045d19f42fb73242759cc57fba9611d940ae96d4b0"
+
+[[package]]
+name = "num-integer"
+version = "0.1.46"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
+dependencies = [
+ "num-traits",
+]
+
+[[package]]
+name = "num-rational"
+version = "0.4.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f83d14da390562dca69fc84082e73e548e1ad308d24accdedd2720017cb37824"
+dependencies = [
+ "num-integer",
+ "num-traits",
+]
+
+[[package]]
+name = "num-traits"
+version = "0.2.19"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+dependencies = [
+ "autocfg",
+]
+
+[[package]]
+name = "option-operations"
+version = "0.6.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b31ce827892359f23d3cd1cc4c75a6c241772bbd2db17a92dcf27cbefdf52689"
+dependencies = [
+ "pastey",
+]
+
+[[package]]
+name = "pastey"
+version = "0.1.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "35fb2e5f958ec131621fdd531e9fc186ed768cbe395337403ae56c17a74c68ec"
+
+[[package]]
+name = "pin-project-lite"
+version = "0.2.16"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
+
+[[package]]
+name = "pin-utils"
+version = "0.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
+
 [[package]]
 name = "pkg-config"
 version = "0.3.32"
@@ -236,6 +625,15 @@ version = "0.5.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e"
 
+[[package]]
+name = "proc-macro-crate"
+version = "3.4.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "219cb19e96be00ab2e37d6e299658a0cfa83e52429179969b0f0121b4ac46983"
+dependencies = [
+ "toml_edit",
+]
+
 [[package]]
 name = "proc-macro-error"
 version = "1.0.4"
@@ -261,9 +659,9 @@ dependencies = [
 
 [[package]]
 name = "proc-macro2"
-version = "1.0.95"
+version = "1.0.103"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
+checksum = "5ee95bc4ef87b8d5ba32e8b7714ccc834865276eab0aed5c9958d00ec45f49e8"
 dependencies = [
  "unicode-ident",
 ]
@@ -292,18 +690,18 @@ dependencies = [
 
 [[package]]
 name = "quote"
-version = "1.0.36"
+version = "1.0.42"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+checksum = "a338cc41d27e6cc6dce6cefc13a0729dfbb81c262b1f519331575dd80ef3067f"
 dependencies = [
  "proc-macro2",
 ]
 
 [[package]]
 name = "serde"
-version = "1.0.226"
+version = "1.0.228"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd"
+checksum = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
 dependencies = [
  "serde_core",
  "serde_derive",
@@ -311,18 +709,18 @@ dependencies = [
 
 [[package]]
 name = "serde_core"
-version = "1.0.226"
+version = "1.0.228"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4"
+checksum = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
 dependencies = [
  "serde_derive",
 ]
 
 [[package]]
 name = "serde_derive"
-version = "1.0.226"
+version = "1.0.228"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33"
+checksum = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
 dependencies = [
  "proc-macro2",
  "quote",
@@ -331,24 +729,36 @@ dependencies = [
 
 [[package]]
 name = "serde_spanned"
-version = "0.6.9"
+version = "1.0.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
+checksum = "e24345aa0fe688594e73770a5f6d1b216508b4f93484c0026d521acd30134392"
 dependencies = [
- "serde",
+ "serde_core",
 ]
 
+[[package]]
+name = "slab"
+version = "0.4.11"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7a2ae44ef20feb57a68b23d846850f861394c2e02dc425a50098ae8c90267589"
+
 [[package]]
 name = "smallvec"
 version = "1.15.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
 
+[[package]]
+name = "static_assertions"
+version = "1.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
+
 [[package]]
 name = "syn"
-version = "2.0.104"
+version = "2.0.111"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40"
+checksum = "390cc9a294ab71bdb1aa2e99d13be9c753cd2d7bd6560c77118597410c4d2e87"
 dependencies = [
  "proc-macro2",
  "quote",
@@ -367,9 +777,9 @@ dependencies = [
 
 [[package]]
 name = "system-deps"
-version = "7.0.5"
+version = "7.0.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e4be53aa0cba896d2dc615bd42bbc130acdcffa239e0a2d965ea5b3b2a86ffdb"
+checksum = "48c8f33736f986f16d69b6cb8b03f55ddcad5c41acc4ccc39dd88e84aa805e7f"
 dependencies = [
  "cfg-expr",
  "heck",
@@ -380,9 +790,9 @@ dependencies = [
 
 [[package]]
 name = "target-lexicon"
-version = "0.13.2"
+version = "0.13.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e502f78cdbb8ba4718f566c418c52bc729126ffd16baee5baa718cf25dd5a69a"
+checksum = "df7f62577c25e07834649fc3b39fafdc597c0a3527dc1c60129201ccfcbaa50c"
 
 [[package]]
 name = "tests"
@@ -398,40 +808,77 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "thiserror"
+version = "2.0.17"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f63587ca0f12b72a0600bcba1d40081f830876000bb46dd2337a3051618f4fc8"
+dependencies = [
+ "thiserror-impl",
+]
+
+[[package]]
+name = "thiserror-impl"
+version = "2.0.17"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3ff15c8ecd7de3849db632e14d18d2571fa09dfc5ed93479bc4485c7a517c913"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
 [[package]]
 name = "toml"
-version = "0.8.23"
+version = "0.9.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc1beb996b9d83529a9e75c17a1686767d148d70663143c7854d8b4a09ced362"
+checksum = "f0dc8b1fb61449e27716ec0e1bdf0f6b8f3e8f6b05391e8497b8b6d7804ea6d8"
 dependencies = [
- "serde",
+ "indexmap",
+ "serde_core",
  "serde_spanned",
  "toml_datetime",
- "toml_edit",
+ "toml_parser",
+ "toml_writer",
+ "winnow",
 ]
 
 [[package]]
 name = "toml_datetime"
-version = "0.6.11"
+version = "0.7.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "22cddaf88f4fbc13c51aebbf5f8eceb5c7c5a9da2ac40a13519eb5b0a0e8f11c"
+checksum = "f2cdb639ebbc97961c51720f858597f7f24c4fc295327923af55b74c3c724533"
 dependencies = [
- "serde",
+ "serde_core",
 ]
 
 [[package]]
 name = "toml_edit"
-version = "0.22.27"
+version = "0.23.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "41fe8c660ae4257887cf66394862d21dbca4a6ddd26f04a3560410406a2f819a"
+checksum = "6485ef6d0d9b5d0ec17244ff7eb05310113c3f316f2d14200d4de56b3cb98f8d"
 dependencies = [
  "indexmap",
- "serde",
- "serde_spanned",
  "toml_datetime",
+ "toml_parser",
+ "winnow",
+]
+
+[[package]]
+name = "toml_parser"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c0cbe268d35bdb4bb5a56a2de88d0ad0eb70af5384a99d648cd4b3d04039800e"
+dependencies = [
  "winnow",
 ]
 
+[[package]]
+name = "toml_writer"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "df8b2b54733674ad286d16267dcfc7a71ed5c776e4ac7aa3c3e2561f7c637bf2"
+
 [[package]]
 name = "trace"
 version = "0.1.0"
@@ -442,9 +889,9 @@ dependencies = [
 
 [[package]]
 name = "unicode-ident"
-version = "1.0.12"
+version = "1.0.22"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+checksum = "9312f7c4f6ff9069b165498234ce8be658059c6728633667c526e27dc2cf1df5"
 
 [[package]]
 name = "util"
@@ -461,21 +908,36 @@ dependencies = [
 
 [[package]]
 name = "version-compare"
-version = "0.2.0"
+version = "0.2.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "852e951cb7832cb45cb1169900d19760cfa39b82bc0ea9c0e5a14ae88411c98b"
+checksum = "03c2856837ef78f57382f06b2b8563a2f512f7185d732608fd9176cb3b8edf0e"
 
 [[package]]
 name = "version_check"
-version = "0.9.4"
+version = "0.9.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+checksum = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+
+[[package]]
+name = "windows-link"
+version = "0.2.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
+
+[[package]]
+name = "windows-sys"
+version = "0.61.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
+dependencies = [
+ "windows-link",
+]
 
 [[package]]
 name = "winnow"
-version = "0.7.13"
+version = "0.7.14"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
+checksum = "5a5364e9d77fcdeeaa6062ced926ee3381faa2ee02d3eb83a5c27a8825540829"
 dependencies = [
  "memchr",
 ]
diff --git a/Cargo.toml b/Cargo.toml
index 8e0fbab290..0ced3297e1 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -1,6 +1,7 @@
 [workspace]
 resolver = "2"
 members = [
+    "rust/audio",
     "rust/hw/char/pl011",
     "rust/hw/timer/hpet",
     "rust/tests",
@@ -18,8 +19,13 @@ authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 [workspace.dependencies]
 anyhow = "~1.0"
 foreign = "~0.3.1"
+futures = "0.3"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
+gio-sys = { version = "0.21.2", features = ["v2_66"] }
+gobect-sys = { version = "0.21.2", features = ["v2_66"] }
+gst_app = { package = "gstreamer-app", version = "0.24.2", features = ["v1_24"] }
+gst_audio = { package = "gstreamer-audio", version = "0.24.2" }
 serde = { version = "1.0.226", features = ["derive"] }
 serde_derive = "1.0.226"
 
diff --git a/audio/trace-events b/audio/trace-events
index f7f639d960..d71d85fe01 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -34,3 +34,8 @@ audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
 audio_timer_start(int interval) "interval %d ms"
 audio_timer_stop(void) ""
 audio_timer_delayed(int interval) "interval %d ms"
+
+# gstreamer.rs
+gst_write(size_t bytes_written, uint64_t elapsed_ms, size_t bytes_per_second) "bytes_written=%zu, elapsed_ms=%" PRIu64 ", bytes_per_second=%zu"
+gst_need_data(const char *name, size_t len) "name=%s, len=%zu"
+gst_new_sample(const char *name, size_t len) "name=%s, len=%zu"
diff --git a/rust/audio/Cargo.toml b/rust/audio/Cargo.toml
new file mode 100644
index 0000000000..ceeb1a5b14
--- /dev/null
+++ b/rust/audio/Cargo.toml
@@ -0,0 +1,29 @@
+[package]
+name = "audio"
+version = "0.1.0"
+description = "Rust bindings for QEMU/audio"
+resolver = "2"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+bql = { path = "../bql" }
+futures = { workspace = true }
+glib-sys = { workspace = true }
+gio-sys = { workspace = true }
+gst_app = { workspace = true }
+gst_audio = { workspace = true }
+common = { path = "../common" }
+qom = { path = "../qom" }
+util = { path = "../util" }
+system = { path = "../system" }
+trace = { path = "../trace" }
+
+[lints]
+workspace = true
diff --git a/rust/audio/build.rs b/rust/audio/build.rs
new file mode 100644
index 0000000000..5654d1d562
--- /dev/null
+++ b/rust/audio/build.rs
@@ -0,0 +1,49 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[cfg(unix)]
+use std::os::unix::fs::symlink as symlink_file;
+#[cfg(windows)]
+use std::os::windows::fs::symlink_file;
+use std::{env, fs::remove_file, io::Result, path::Path};
+
+fn main() -> Result<()> {
+    let manifest_dir = env!("CARGO_MANIFEST_DIR");
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        let sub = get_rust_subdir(manifest_dir).unwrap();
+        format!("{root}/{sub}/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{manifest_dir}/src/bindings.inc.rs")
+    };
+
+    let file = Path::new(&file);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "\n",
+            "    No generated C bindings found! Maybe you wanted one of\n",
+            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with\n",
+            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+            "    the top of the build tree."
+        ));
+    }
+
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{out_dir}/bindings.inc.rs");
+    let dest_path = Path::new(&dest_path);
+    if dest_path.symlink_metadata().is_ok() {
+        remove_file(dest_path)?;
+    }
+    symlink_file(file, dest_path)?;
+
+    println!("cargo:rerun-if-changed=build.rs");
+    Ok(())
+}
+
+fn get_rust_subdir(path: &str) -> Option<&str> {
+    path.find("/rust").map(|index| &path[index + 1..])
+}
diff --git a/rust/audio/meson.build b/rust/audio/meson.build
new file mode 100644
index 0000000000..27519a3e3f
--- /dev/null
+++ b/rust/audio/meson.build
@@ -0,0 +1,75 @@
+c_enums = [
+  'audcnotification_e',
+  'AudioFormat',
+]
+_audio_bindgen_args = []
+foreach enum : c_enums
+  _audio_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+blocked_type = [
+  'Error',
+  'ObjectClass',
+]
+foreach type: blocked_type
+  _audio_bindgen_args += ['--blocklist-type', type]
+endforeach
+
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_audio_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _audio_bindgen_args,
+  c_args: bindgen_c_args,
+)
+
+_audio_rs = static_library(
+  'audio',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/audio.rs',
+      'src/gstreamer.rs',
+    ],
+    {'.': _audio_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  link_with: [
+    _util_rs,
+    _bql_rs,
+    _qom_rs,
+    _trace_rs,
+    _system_rs,
+  ],
+  dependencies: [
+    gio_sys_rs,
+    glib_sys_rs,
+    gst_app_rs,
+    gst_audio_rs,
+    common_rs,
+    futures_rs,
+  ],
+  rust_dependency_map: {
+    'gstreamer_app': 'gst_app',
+    'gstreamer_audio': 'gst_audio',
+  }
+)
+
+audio_rs = declare_dependency(link_with: [_audio_rs])
+
+rust_devices_ss.add(declare_dependency(
+  link_whole: [_audio_rs],
+  variables: {'crate': 'audio'},
+))
diff --git a/rust/audio/src/audio.rs b/rust/audio/src/audio.rs
new file mode 100644
index 0000000000..436298ea17
--- /dev/null
+++ b/rust/audio/src/audio.rs
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{
+    ffi::{CStr, CString},
+    ptr::NonNull,
+};
+
+use common::Opaque;
+use qom::{prelude::*, ObjectImpl};
+use util::{Error, Result};
+
+use crate::bindings;
+
+/// Called when audio data needs to be processed. The callback receives:
+/// - `available`: Number of bytes/frames available for processing
+pub type AudioCallback = Box<dyn Fn(i32) + Send>;
+
+pub type CaptureNotification = bindings::audcnotification_e;
+
+pub trait AudioCaptureOps {
+    fn notify(&mut self, cmd: CaptureNotification);
+
+    fn capture(&mut self, buf: &[u8]);
+
+    fn destroy(&mut self);
+}
+
+/// A safe wrapper around [`bindings::AudioBackend`].
+#[repr(transparent)]
+#[derive(common::Wrapper)]
+pub struct AudioBackend(Opaque<bindings::AudioBackend>);
+
+pub type AudioBackendClass = bindings::AudioBackendClass;
+
+pub trait AudioBackendImpl: ObjectImpl {
+    type VoiceOut;
+    type VoiceIn;
+    type Capture;
+
+    fn realize(&self, dev: &bindings::Audiodev) -> Result<()>;
+
+    fn id(&self) -> &CString;
+
+    fn open_out(
+        &self,
+        sw: Option<Self::VoiceOut>,
+        name: &CStr,
+        callback_fn: AudioCallback,
+        settings: &bindings::audsettings,
+    ) -> Option<Self::VoiceOut>;
+
+    fn open_in(
+        &self,
+        sw: Option<Self::VoiceIn>,
+        name: &CStr,
+        callback_fn: AudioCallback,
+        settings: &bindings::audsettings,
+    ) -> Option<Self::VoiceIn>;
+
+    fn close_out(&self, sw: Self::VoiceOut);
+
+    fn close_in(&self, sw: Self::VoiceIn);
+
+    fn is_active_out(&self, sw: &Self::VoiceOut) -> bool;
+
+    fn is_active_in(&self, sw: &Self::VoiceIn) -> bool;
+
+    fn set_active_out(&self, sw: &mut Self::VoiceOut, on: bool);
+
+    fn set_active_in(&self, sw: &mut Self::VoiceIn, on: bool);
+
+    fn set_volume_out(&self, sw: &mut Self::VoiceOut, vol: &bindings::Volume);
+
+    fn set_volume_in(&self, sw: &mut Self::VoiceIn, vol: &bindings::Volume);
+
+    fn write(&self, sw: &mut Self::VoiceOut, buf: &[u8]) -> usize;
+
+    fn read(&self, sw: &mut Self::VoiceIn, buf: &mut [u8]) -> usize;
+
+    fn get_buffer_size_out(&self, sw: &mut Self::VoiceOut) -> i32;
+
+    fn add_capture(
+        &self,
+        settings: &bindings::audsettings,
+        ops: Box<dyn AudioCaptureOps + Send>,
+    ) -> Option<Self::Capture>;
+
+    fn del_capture(&self, cap: Self::Capture);
+
+    fn set_dbus_server(
+        &self,
+        manager: *mut gio_sys::GDBusObjectManagerServer,
+        p2p: bool,
+    ) -> Result<()>;
+
+    /// Convert from opaque `SWVoiceOut` pointer to `VoiceOut` using Box
+    ///
+    /// # Safety
+    /// The pointer must be a valid pointer that was previously created by
+    /// `voice_out_to_ptr`
+    unsafe fn ptr_to_voice_out(&self, ptr: NonNull<bindings::SWVoiceOut>) -> Box<Self::VoiceOut> {
+        unsafe { Box::from_raw(ptr.as_ptr().cast::<Self::VoiceOut>()) }
+    }
+
+    /// Convert from `VoiceOut` to opaque `SWVoiceOut` pointer using Box
+    fn voice_out_to_ptr(&self, voice: Box<Self::VoiceOut>) -> NonNull<bindings::SWVoiceOut> {
+        NonNull::new(Box::into_raw(voice).cast::<bindings::SWVoiceOut>()).unwrap()
+    }
+
+    /// Convert from opaque `SWVoiceIn` pointer to `VoiceIn` using Box
+    ///
+    /// # Safety
+    /// The pointer must be a valid pointer that was previously created by
+    /// `voice_in_to_ptr`
+    unsafe fn ptr_to_voice_in(&self, ptr: NonNull<bindings::SWVoiceIn>) -> Box<Self::VoiceIn> {
+        unsafe { Box::from_raw(ptr.as_ptr().cast::<Self::VoiceIn>()) }
+    }
+
+    /// Convert from `VoiceIn` to opaque `SWVoiceIn` pointer using Box
+    fn voice_in_to_ptr(&self, voice: Box<Self::VoiceIn>) -> NonNull<bindings::SWVoiceIn> {
+        NonNull::new(Box::into_raw(voice).cast::<bindings::SWVoiceIn>()).unwrap()
+    }
+
+    /// Convert from opaque `CaptureVoiceOut` pointer to Capture using Box
+    ///
+    /// # Safety
+    /// The pointer must be a valid pointer that was previously created by
+    /// `capture_to_ptr`
+    unsafe fn ptr_to_capture(&self, ptr: NonNull<bindings::CaptureVoiceOut>) -> Box<Self::Capture> {
+        unsafe { Box::from_raw(ptr.as_ptr().cast::<Self::Capture>()) }
+    }
+
+    /// Convert from Capture to opaque `CaptureVoiceOut` pointer using Box
+    fn capture_to_ptr(&self, capture: Self::Capture) -> NonNull<bindings::CaptureVoiceOut> {
+        NonNull::new(Box::into_raw(Box::new(capture)).cast::<bindings::CaptureVoiceOut>()).unwrap()
+    }
+}
+
+unsafe extern "C" fn rust_realize_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    dev: *mut bindings::Audiodev,
+    errp: *mut *mut util::bindings::Error,
+) -> bool {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let dev = NonNull::new(dev).unwrap().cast();
+    let result = unsafe { be.as_ref() }.realize(unsafe { dev.as_ref() });
+    unsafe { Error::bool_or_propagate(result, errp) }
+}
+
+unsafe extern "C" fn rust_get_id_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+) -> *const std::os::raw::c_char {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let id = unsafe { be.as_ref() }.id();
+    id.as_ptr()
+}
+
+unsafe extern "C" fn rust_open_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+    name: *const std::os::raw::c_char,
+    callback_opaque: *mut std::os::raw::c_void,
+    callback_fn: Option<unsafe extern "C" fn(*mut std::os::raw::c_void, std::os::raw::c_int)>,
+    settings: *mut bindings::audsettings,
+) -> *mut bindings::SWVoiceOut {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let name = unsafe { CStr::from_ptr(name) };
+    let settings = unsafe { settings.as_ref().unwrap() };
+
+    let sw_voice = NonNull::new(sw).map(|ptr| unsafe { be_ref.ptr_to_voice_out(ptr) });
+
+    let rust_callback = c_callback_to_rust(callback_fn, callback_opaque);
+
+    let result = be_ref.open_out(
+        sw_voice.map(|boxed| *boxed),
+        name,
+        rust_callback.unwrap(),
+        settings,
+    );
+
+    result.map_or(std::ptr::null_mut(), |voice| {
+        be_ref.voice_out_to_ptr(Box::new(voice)).as_ptr()
+    })
+}
+
+unsafe extern "C" fn rust_open_in_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+    name: *const std::os::raw::c_char,
+    callback_opaque: *mut std::os::raw::c_void,
+    callback_fn: Option<unsafe extern "C" fn(*mut std::os::raw::c_void, std::os::raw::c_int)>,
+    settings: *mut bindings::audsettings,
+) -> *mut bindings::SWVoiceIn {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let name = unsafe { CStr::from_ptr(name) };
+    let settings = unsafe { settings.as_ref().unwrap() };
+
+    let sw_voice = NonNull::new(sw).map(|ptr| unsafe { be_ref.ptr_to_voice_in(ptr) });
+
+    let rust_callback = c_callback_to_rust(callback_fn, callback_opaque);
+
+    let result = be_ref.open_in(
+        sw_voice.map(|boxed| *boxed),
+        name,
+        rust_callback.unwrap(),
+        settings,
+    );
+
+    result.map_or(std::ptr::null_mut(), |voice| {
+        be_ref.voice_in_to_ptr(Box::new(voice)).as_ptr()
+    })
+}
+
+unsafe extern "C" fn rust_close_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    be_ref.close_out(*voice);
+}
+
+unsafe extern "C" fn rust_close_in_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let voice = unsafe { be_ref.ptr_to_voice_in(sw) };
+    be_ref.close_in(*voice);
+}
+
+unsafe extern "C" fn rust_is_active_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+) -> bool {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    let result = be_ref.is_active_out(&voice);
+    std::mem::forget(voice);
+    result
+}
+
+unsafe extern "C" fn rust_is_active_in_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+) -> bool {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let voice = unsafe { be_ref.ptr_to_voice_in(sw) };
+    let result = be_ref.is_active_in(&voice);
+    std::mem::forget(voice);
+    result
+}
+
+unsafe extern "C" fn rust_set_active_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+    on: bool,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let mut voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    be_ref.set_active_out(&mut voice, on);
+    std::mem::forget(voice);
+}
+
+unsafe extern "C" fn rust_set_active_in_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+    on: bool,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let mut voice = unsafe { be_ref.ptr_to_voice_in(sw) };
+    be_ref.set_active_in(&mut voice, on);
+    std::mem::forget(voice);
+}
+
+unsafe extern "C" fn rust_set_volume_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+    vol: *mut bindings::Volume,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let vol = unsafe { vol.as_ref().unwrap() };
+    let mut voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    be_ref.set_volume_out(&mut voice, vol);
+    std::mem::forget(voice);
+}
+
+unsafe extern "C" fn rust_set_volume_in_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+    vol: *mut bindings::Volume,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let vol = unsafe { vol.as_ref().unwrap() };
+    let mut voice = unsafe { be_ref.ptr_to_voice_in(sw) };
+    be_ref.set_volume_in(&mut voice, vol);
+    std::mem::forget(voice);
+}
+
+unsafe extern "C" fn rust_write_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+    buf: *mut std::os::raw::c_void,
+    size: usize,
+) -> usize {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let mut voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    let buf_slice = unsafe { std::slice::from_raw_parts(buf as *const u8, size) };
+    let result = be_ref.write(&mut voice, buf_slice);
+    // Put the voice back - we need to leak it since we only borrowed it
+    std::mem::forget(voice);
+    result
+}
+
+unsafe extern "C" fn rust_read_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceIn,
+    buf: *mut std::os::raw::c_void,
+    size: usize,
+) -> usize {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let mut voice = unsafe { be_ref.ptr_to_voice_in(sw) };
+    let buf_slice = unsafe { std::slice::from_raw_parts_mut(buf.cast::<u8>(), size) };
+    let result = be_ref.read(&mut voice, buf_slice);
+    std::mem::forget(voice);
+    result
+}
+
+unsafe extern "C" fn rust_get_buffer_size_out_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    sw: *mut bindings::SWVoiceOut,
+) -> std::os::raw::c_int {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let sw = NonNull::new(sw).unwrap();
+    let mut voice = unsafe { be_ref.ptr_to_voice_out(sw) };
+    let result = be_ref.get_buffer_size_out(&mut voice);
+    std::mem::forget(voice);
+    result
+}
+
+struct CToRustCaptureOpsBridge {
+    notify_fn:
+        Option<unsafe extern "C" fn(*mut std::os::raw::c_void, bindings::audcnotification_e)>,
+    capture_fn: Option<
+        unsafe extern "C" fn(
+            *mut std::os::raw::c_void,
+            *const std::os::raw::c_void,
+            std::os::raw::c_int,
+        ),
+    >,
+    destroy_fn: Option<unsafe extern "C" fn(*mut std::os::raw::c_void)>,
+    opaque: *mut std::os::raw::c_void,
+}
+
+// SAFETY: The bridge is Send because it only contains function pointers and raw
+// pointers. The caller must ensure thread safety when using the opaque pointer.
+unsafe impl Send for CToRustCaptureOpsBridge {}
+
+impl CToRustCaptureOpsBridge {
+    fn new(c_ops: &bindings::audio_capture_ops, opaque: *mut std::os::raw::c_void) -> Self {
+        Self {
+            notify_fn: c_ops.notify,
+            capture_fn: c_ops.capture,
+            destroy_fn: c_ops.destroy,
+            opaque,
+        }
+    }
+}
+
+impl AudioCaptureOps for CToRustCaptureOpsBridge {
+    fn notify(&mut self, cmd: CaptureNotification) {
+        if let Some(notify_fn) = self.notify_fn {
+            unsafe {
+                notify_fn(self.opaque, cmd);
+            }
+        }
+    }
+
+    fn capture(&mut self, buf: &[u8]) {
+        if let Some(capture_fn) = self.capture_fn {
+            unsafe {
+                capture_fn(
+                    self.opaque,
+                    buf.as_ptr().cast::<std::os::raw::c_void>(),
+                    buf.len() as std::os::raw::c_int,
+                );
+            }
+        }
+    }
+
+    fn destroy(&mut self) {
+        if let Some(destroy_fn) = self.destroy_fn {
+            unsafe {
+                destroy_fn(self.opaque);
+            }
+        }
+    }
+}
+
+unsafe extern "C" fn rust_add_capture_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    settings: *mut bindings::audsettings,
+    ops: *mut bindings::audio_capture_ops,
+    cb_opaque: *mut std::os::raw::c_void,
+) -> *mut bindings::CaptureVoiceOut {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let settings = unsafe { settings.as_ref().unwrap() };
+    let ops = unsafe { ops.as_ref().unwrap() };
+
+    let bridge = CToRustCaptureOpsBridge::new(ops, cb_opaque);
+    let rust_ops = Box::new(bridge) as Box<dyn AudioCaptureOps + Send>;
+
+    let result = unsafe { be.as_ref() }.add_capture(settings, rust_ops);
+    result.map_or(std::ptr::null_mut(), |capture| {
+        unsafe { be.as_ref() }.capture_to_ptr(capture).as_ptr()
+    })
+}
+
+unsafe extern "C" fn rust_del_capture_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    cap: *mut bindings::CaptureVoiceOut,
+    _cb_opaque: *mut std::os::raw::c_void,
+) {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let be_ref = unsafe { be.as_ref() };
+    let cap_ptr = NonNull::new(cap).unwrap();
+    let capture = *unsafe { be_ref.ptr_to_capture(cap_ptr) };
+    be_ref.del_capture(capture);
+}
+
+unsafe extern "C" fn rust_set_dbus_server_fn<T: AudioBackendImpl>(
+    be: *mut bindings::AudioBackend,
+    manager: *mut gio_sys::GDBusObjectManagerServer,
+    p2p: bool,
+    errp: *mut *mut util::bindings::Error,
+) -> bool {
+    let be = NonNull::new(be).unwrap().cast::<T>();
+    let result = unsafe { be.as_ref() }.set_dbus_server(manager, p2p);
+    unsafe { Error::bool_or_propagate(result, errp) }
+}
+
+// SAFETY: The C audio callback is expected to handle its own thread safety.
+struct SendCb(
+    unsafe extern "C" fn(*mut std::os::raw::c_void, std::os::raw::c_int),
+    *mut std::os::raw::c_void,
+);
+unsafe impl Send for SendCb {}
+
+impl SendCb {
+    fn call(&self, available: i32) {
+        unsafe { (self.0)(self.1, available) }
+    }
+}
+
+fn c_callback_to_rust(
+    c_fn: Option<unsafe extern "C" fn(*mut std::os::raw::c_void, std::os::raw::c_int)>,
+    opaque: *mut std::os::raw::c_void,
+) -> Option<AudioCallback> {
+    c_fn.map(|f| -> AudioCallback {
+        let cb = SendCb(f, opaque);
+        Box::new(move |available| cb.call(available))
+    })
+}
+
+impl AudioBackendClass {
+    pub(crate) fn class_init<T: AudioBackendImpl>(&mut self) {
+        self.realize = Some(rust_realize_fn::<T>);
+        self.get_id = Some(rust_get_id_fn::<T>);
+        self.open_out = Some(rust_open_out_fn::<T>);
+        self.open_in = Some(rust_open_in_fn::<T>);
+        self.close_out = Some(rust_close_out_fn::<T>);
+        self.close_in = Some(rust_close_in_fn::<T>);
+        self.is_active_out = Some(rust_is_active_out_fn::<T>);
+        self.is_active_in = Some(rust_is_active_in_fn::<T>);
+        self.set_active_out = Some(rust_set_active_out_fn::<T>);
+        self.set_active_in = Some(rust_set_active_in_fn::<T>);
+        self.set_volume_out = Some(rust_set_volume_out_fn::<T>);
+        self.set_volume_in = Some(rust_set_volume_in_fn::<T>);
+        self.write = Some(rust_write_fn::<T>);
+        self.read = Some(rust_read_fn::<T>);
+        self.get_buffer_size_out = Some(rust_get_buffer_size_out_fn::<T>);
+        self.add_capture = Some(rust_add_capture_fn::<T>);
+        self.del_capture = Some(rust_del_capture_fn::<T>);
+        self.set_dbus_server = Some(rust_set_dbus_server_fn::<T>);
+    }
+}
+
+unsafe impl ObjectType for AudioBackend {
+    type Class = AudioBackendClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_AUDIO_BACKEND) };
+}
+qom_isa!(AudioBackend: Object);
diff --git a/rust/audio/src/bindings.rs b/rust/audio/src/bindings.rs
new file mode 100644
index 0000000000..aee53473a8
--- /dev/null
+++ b/rust/audio/src/bindings.rs
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+use gio_sys::GDBusObjectManagerServer;
+use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
+use qom::bindings::ObjectClass;
+use util::bindings::Error;
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for audio_capture_ops {}
diff --git a/rust/audio/src/gstreamer.rs b/rust/audio/src/gstreamer.rs
new file mode 100644
index 0000000000..8b99944c9a
--- /dev/null
+++ b/rust/audio/src/gstreamer.rs
@@ -0,0 +1,1070 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{
+    ffi::{CStr, CString},
+    sync::{
+        atomic::{AtomicBool, Ordering},
+        Arc, Mutex,
+    },
+    time::Instant,
+};
+
+use bql::{BqlCell, BqlRefCell};
+use common::uninit_field_mut;
+use futures::StreamExt;
+use gst::prelude::*;
+use gst_app::{glib, gst};
+use gst_audio::{self, prelude::StreamVolumeExt, StreamVolume};
+use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
+// Import qom traits explicitly to avoid ambiguity with gst traits
+use qom::{IsA as QomIsA, ObjectType as QomObjectType};
+use util::{log::Log, log_mask_ln, Error, Result};
+
+use crate::{
+    bindings::{self},
+    AudioBackend, AudioBackendImpl, AudioCallback, AudiodevGStreamerOptions,
+    AudiodevPerDirectionOptions, CaptureNotification,
+};
+
+::trace::include_trace!("audio");
+
+#[repr(C)]
+#[derive(qom::Object)]
+pub struct AudioGStreamer {
+    parent_obj: ParentField<AudioBackend>,
+
+    id: BqlCell<CString>,
+    opt: BqlRefCell<Option<AudiodevGStreamerOptions>>,
+    mixer_pipeline: BqlRefCell<Option<MixerPipeline>>,
+}
+
+qom_isa!(AudioGStreamer : AudioBackend, Object);
+
+#[repr(C)]
+pub struct AudioGStreamerClass {
+    parent_class: <AudioBackend as QomObjectType>::Class,
+}
+
+// Shared mixer pipeline for mixing multiple audio voices
+struct MixerPipeline {
+    pipeline: gst::Pipeline,
+    mixer: gst::Element,
+    tee: gst::Element,
+    #[allow(dead_code)] // For RAII reasons
+    bus_watch: gst::bus::BusWatchGuard,
+}
+
+trait AudioGStreamerImpl: AudioBackendImpl + QomIsA<AudioGStreamer> {}
+
+impl AudioGStreamerClass {
+    fn class_init<T: AudioGStreamerImpl>(&mut self) {
+        self.parent_class.class_init::<T>();
+    }
+}
+
+impl AudioGStreamerImpl for AudioGStreamer {}
+
+unsafe impl QomObjectType for AudioGStreamer {
+    type Class = AudioGStreamerClass;
+
+    const TYPE_NAME: &'static CStr = crate::TYPE_AUDIO_GSTREAMER;
+}
+
+impl ObjectImpl for AudioGStreamer {
+    type ParentType = AudioBackend;
+
+    const INSTANCE_INIT: Option<unsafe fn(ParentInit<Self>)> = Some(Self::init);
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
+}
+
+enum VoiceOutKind {
+    Mixed,
+    Standalone(gst::bus::BusWatchGuard),
+}
+
+pub struct VoiceOut {
+    kind: VoiceOutKind,
+    pipeline: gst::Pipeline,
+    stream_volume: Option<StreamVolume>,
+    appsrc: gst_app::AppSrc,
+    active: Arc<AtomicBool>,
+    active_time: Option<Instant>,
+    bytes_written: usize,
+    bytes_per_second: usize,
+    offset_time: Option<gst::ClockTime>,
+}
+
+pub struct VoiceIn {
+    pipeline: gst::Pipeline,
+    appsink: gst_app::AppSink,
+    active: bool,
+    pending_data: Arc<Mutex<Vec<u8>>>,
+}
+
+pub struct Capture {
+    bin: gst::Bin,
+    tee_pad: gst::Pad,
+    ops: Arc<Mutex<Box<dyn crate::audio::AudioCaptureOps + Send>>>,
+}
+
+impl AudioBackendImpl for AudioGStreamer {
+    type VoiceOut = VoiceOut;
+    type VoiceIn = VoiceIn;
+    type Capture = Capture;
+
+    fn realize(&self, dev: &bindings::Audiodev) -> Result<()> {
+        if dev.id.is_null() {
+            return Err(Error::msg("dev.id is null"));
+        }
+
+        gst::init()?;
+        let id_cstr = unsafe { CStr::from_ptr(dev.id) };
+        let id = CString::new(id_cstr.to_bytes())?;
+        self.id.set(id);
+
+        // ideally using qapi-rs instead
+        let gst = unsafe { &dev.u.gstreamer };
+        let opt: AudiodevGStreamerOptions = gst.into();
+
+        if opt
+            .out
+            .as_ref()
+            .and_then(|o| o.mixing_engine)
+            .unwrap_or(false)
+        {
+            let mixer_pipeline = create_mixer_pipeline(&opt)?;
+            *self.mixer_pipeline.borrow_mut() = Some(mixer_pipeline);
+        } else {
+            if opt
+                .out
+                .as_ref()
+                .and_then(|o| o.fixed_settings)
+                .unwrap_or(false)
+            {
+                log_mask_ln!(
+                    Log::Unimp,
+                    "Fixed settings aren't supported in non-mixer mode"
+                );
+            }
+            if opt.out.as_ref().and_then(|o| o.buffer_length).is_some() {
+                log_mask_ln!(
+                    Log::Unimp,
+                    "Buffer length isn't supported in non-mixer mode"
+                );
+            }
+        }
+
+        if opt.in_ != Default::default() {
+            log_mask_ln!(Log::Unimp, "Input configuration isn't supported yet");
+        }
+
+        *self.opt.borrow_mut() = Some(opt);
+
+        Ok(())
+    }
+
+    fn id(&self) -> &CString {
+        unsafe { &*self.id.as_ptr() }
+    }
+
+    fn open_out(
+        &self,
+        sw: Option<Self::VoiceOut>,
+        name: &CStr,
+        callback_fn: AudioCallback,
+        settings: &bindings::audsettings,
+    ) -> Option<Self::VoiceOut> {
+        let mut active = false;
+        if let Some(voice) = sw {
+            active = voice.active.load(Ordering::Relaxed);
+            self.close_out(voice);
+        }
+
+        let mixer_pipeline_ref = self.mixer_pipeline.borrow();
+        let mut result = if let Some(mixer_pipeline) = mixer_pipeline_ref.as_ref() {
+            create_mixed_voice(mixer_pipeline, settings, name)
+        } else {
+            create_standalone_voice(settings, name, self.opt.borrow().as_ref().unwrap())
+        };
+
+        if let Ok(voice) = &mut result {
+            let (mut tx, mut rx) = futures::channel::mpsc::channel(1);
+
+            let appsrc_clone = voice.appsrc.clone();
+            let active_clone = voice.active.clone();
+            glib::MainContext::default().spawn(async move {
+                loop {
+                    // TODO: some emulated devices don't call write() after callback (ex: hda)
+                    // we need to call them regularly. Ideally, they should call write() when data is available.
+                    let timeout = glib::timeout_future(std::time::Duration::from_millis(10));
+
+                    match futures::future::select(rx.next(), timeout).await {
+                        futures::future::Either::Left((Some(size), _)) => {
+                            let size = i32::try_from(size).unwrap_or(i32::MAX);
+                            callback_fn(size);
+                        }
+                        futures::future::Either::Left((None, _)) => break,
+                        futures::future::Either::Right(_) => {
+                            if active_clone.load(Ordering::Relaxed)
+                                && appsrc_clone.current_level_bytes() == 0
+                            {
+                                callback_fn(4096);
+                            }
+                        }
+                    }
+                }
+            });
+
+            let name = CString::new(name.to_bytes()).unwrap();
+            #[allow(clippy::shadow_unrelated)]
+            let active_clone = voice.active.clone();
+            voice.appsrc.set_callbacks(
+                gst_app::AppSrcCallbacks::builder()
+                    .need_data(move |_src, size| {
+                        let size = size as usize;
+                        trace::trace_gst_need_data(name.as_c_str(), size);
+
+                        if active_clone.load(Ordering::Relaxed) {
+                            if let Err(err) = tx.try_send(size) {
+                                eprintln!("Failed to send need-data to main loop: {err}");
+                            }
+                        }
+                    })
+                    .build(),
+            );
+
+            self.set_active_out(voice, active);
+        };
+
+        result
+            .inspect_err(|e| eprintln!("Failed to create voice output: {e}"))
+            .ok()
+    }
+
+    fn open_in(
+        &self,
+        sw: Option<Self::VoiceIn>,
+        name: &CStr,
+        callback_fn: AudioCallback,
+        settings: &bindings::audsettings,
+    ) -> Option<Self::VoiceIn> {
+        let mut active = false;
+        if let Some(voice) = sw {
+            active = voice.active;
+            self.close_in(voice);
+        }
+
+        let mut result = create_input_voice(self.opt.borrow().as_ref().unwrap(), settings);
+
+        if let Ok(voice) = &mut result {
+            let (mut tx, mut rx) = futures::channel::mpsc::channel::<gst::Sample>(1);
+            let pending_data = voice.pending_data.clone();
+
+            let name = CString::new(name.to_bytes()).unwrap();
+            glib::MainContext::default().spawn(async move {
+                while let Some(sample) = rx.next().await {
+                    let Some(buffer) = sample.buffer() else {
+                        continue;
+                    };
+                    let size = buffer.size();
+                    trace::trace_gst_new_sample(name.as_c_str(), size);
+                    match buffer.map_readable() {
+                        Ok(buffer) => {
+                            if let Ok(mut data) = pending_data.lock() {
+                                data.extend_from_slice(buffer.as_slice());
+                            }
+                            callback_fn(size.try_into().unwrap());
+                        }
+                        Err(err) => {
+                            eprintln!("Failed to map buffer: {err}");
+                            continue;
+                        }
+                    };
+                }
+            });
+
+            voice.appsink.set_callbacks(
+                gst_app::AppSinkCallbacks::builder()
+                    .new_sample(move |sink| {
+                        // FIXME: with 1.28, we could get "current-level-bytes" instead, and let read() pull
+                        let sample = sink.pull_sample().map_err(|_| gst::FlowError::Eos)?;
+                        tx.try_send(sample).map_err(|_| gst::FlowError::Eos)?;
+                        Ok(gst::FlowSuccess::Ok)
+                    })
+                    .build(),
+            );
+
+            self.set_active_in(voice, active);
+        }
+
+        if let Err(e) = &result {
+            eprintln!("Failed to create voice input: {e}");
+        }
+        result.ok()
+    }
+
+    fn close_out(&self, mut sw: Self::VoiceOut) {
+        match sw.kind {
+            VoiceOutKind::Mixed => {
+                self.set_active_out(&mut sw, false);
+                if let Some(bin) = sw
+                    .appsrc
+                    .parent()
+                    .and_then(|p| p.downcast::<gst::Bin>().ok())
+                {
+                    let _ = bin.set_state(gst::State::Null);
+                    let mp = self.mixer_pipeline.borrow();
+                    if let Some(pad) = bin.sink_pads().first() {
+                        if let Some(peer) = pad.peer() {
+                            let _ = pad.unlink(&peer);
+                            mp.as_ref().unwrap().mixer.release_request_pad(&peer);
+                        }
+                    }
+                    if let Err(err) = mp.as_ref().unwrap().pipeline.remove(&bin) {
+                        eprintln!("Failed to remove voice from pipeline: {err}");
+                    }
+                }
+            }
+            VoiceOutKind::Standalone(_bus_watch_guard) => {
+                if let Err(e) = sw.pipeline.set_state(gst::State::Null) {
+                    eprintln!("Warning: Failed to set to null state: {e}");
+                }
+            }
+        }
+    }
+
+    fn close_in(&self, mut sw: Self::VoiceIn) {
+        self.set_active_in(&mut sw, false);
+        if let Err(e) = sw.pipeline.set_state(gst::State::Null) {
+            eprintln!("Warning: Failed to set to null state: {e}");
+        }
+    }
+
+    fn is_active_out(&self, sw: &Self::VoiceOut) -> bool {
+        sw.active.load(Ordering::Relaxed)
+    }
+
+    fn is_active_in(&self, sw: &Self::VoiceIn) -> bool {
+        sw.active
+    }
+
+    fn set_active_out(&self, sw: &mut Self::VoiceOut, on: bool) {
+        if sw.active.load(Ordering::Relaxed) == on {
+            return;
+        }
+
+        sw.active.store(on, Ordering::Relaxed);
+        sw.bytes_written = 0;
+        sw.active_time = if on { Some(Instant::now()) } else { None };
+        sw.offset_time = None;
+
+        match &sw.kind {
+            VoiceOutKind::Mixed => {
+                let Some(bin) = sw
+                    .appsrc
+                    .parent()
+                    .and_then(|p| p.downcast::<gst::Bin>().ok())
+                else {
+                    eprintln!("Failed to get parent bin for voice");
+                    return;
+                };
+
+                set_playing(bin.upcast_ref(), on);
+            }
+            VoiceOutKind::Standalone(_bus_watch_guard) => {
+                set_playing(sw.pipeline.upcast_ref(), on);
+            }
+        }
+    }
+
+    fn set_active_in(&self, sw: &mut Self::VoiceIn, on: bool) {
+        sw.active = on;
+        set_playing(sw.pipeline.upcast_ref(), on);
+    }
+
+    fn set_volume_out(&self, sw: &mut Self::VoiceOut, vol: &bindings::Volume) {
+        let volume = qemu_volume_to_gst(vol);
+
+        if let Some(ref stream_volume) = sw.stream_volume {
+            stream_volume.set_volume(gst_audio::StreamVolumeFormat::Linear, volume);
+            stream_volume.set_mute(vol.mute);
+        } else if let Some(sink) = find_sink_element(&sw.pipeline) {
+            set_element_volume(sink, volume, vol.mute);
+        } else {
+            eprintln!("Failed to find volume control in pipeline");
+        }
+    }
+
+    fn set_volume_in(&self, sw: &mut Self::VoiceIn, vol: &bindings::Volume) {
+        let volume = qemu_volume_to_gst(vol);
+
+        if let Some(stream_volume) = sw
+            .pipeline
+            .upcast_ref::<gst::Bin>()
+            .by_interface(gst_audio::StreamVolume::static_type())
+            .and_then(|elem| elem.dynamic_cast::<gst_audio::StreamVolume>().ok())
+        {
+            stream_volume.set_volume(gst_audio::StreamVolumeFormat::Linear, volume);
+            stream_volume.set_mute(vol.mute);
+        } else if let Some(source) = find_source_element(&sw.pipeline) {
+            set_element_volume(source, volume, vol.mute)
+        } else {
+            eprintln!("Failed to find volume control in input pipeline");
+        }
+    }
+
+    fn write(&self, sw: &mut Self::VoiceOut, buf: &[u8]) -> usize {
+        if buf.is_empty() || !sw.active.load(Ordering::Relaxed) {
+            return 0;
+        }
+
+        if let Some(timer) = sw.active_time {
+            trace::trace_gst_write(
+                sw.bytes_written,
+                timer.elapsed().as_millis() as u64,
+                sw.bytes_per_second,
+            )
+        }
+
+        let offset_time = sw
+            .offset_time
+            .get_or_insert_with(|| sw.pipeline.current_running_time().unwrap_or_default());
+
+        assert!(sw.bytes_per_second > 0);
+        let pts = gst::ClockTime::from_nseconds(
+            sw.bytes_written as u64 * gst::ClockTime::SECOND.nseconds()
+                / sw.bytes_per_second as u64
+                + offset_time.nseconds(),
+        );
+
+        let mut gst_buffer = match gst::Buffer::with_size(buf.len()) {
+            Ok(buffer) => buffer,
+            Err(e) => {
+                eprintln!("Failed to create GStreamer buffer: {e}");
+                return 0;
+            }
+        };
+
+        {
+            let Some(buffer_ref) = gst_buffer.get_mut() else {
+                eprintln!("Failed to get mutable reference to GStreamer buffer");
+                return 0;
+            };
+
+            let duration = gst::ClockTime::from_nseconds(
+                buf.len() as u64 * gst::ClockTime::SECOND.nseconds() / sw.bytes_per_second as u64,
+            );
+
+            buffer_ref.set_pts(pts);
+            buffer_ref.set_duration(duration);
+
+            let mut mapped_buffer = match buffer_ref.map_writable() {
+                Ok(mapped) => mapped,
+                Err(e) => {
+                    eprintln!("Failed to map GStreamer buffer for writing: {e}");
+                    return 0;
+                }
+            };
+            mapped_buffer.copy_from_slice(buf);
+        }
+
+        sw.bytes_written += buf.len();
+
+        match sw.appsrc.push_buffer(gst_buffer) {
+            Ok(_) => buf.len(),
+            Err(e) => {
+                eprintln!("Failed to push buffer to appsrc: {e}");
+                0
+            }
+        }
+    }
+
+    fn read(&self, sw: &mut Self::VoiceIn, buf: &mut [u8]) -> usize {
+        if buf.is_empty() || !sw.active {
+            return 0;
+        }
+
+        let mut total_read = 0;
+
+        while total_read < buf.len() {
+            // First, try to consume pending data from previous read
+            if let Ok(mut pending) = sw.pending_data.lock() {
+                if !pending.is_empty() {
+                    let bytes_to_copy = pending.len().min(buf.len() - total_read);
+                    buf[total_read..total_read + bytes_to_copy]
+                        .copy_from_slice(&pending[..bytes_to_copy]);
+                    pending.drain(..bytes_to_copy);
+                    total_read += bytes_to_copy;
+                    if total_read >= buf.len() {
+                        break;
+                    }
+                }
+            }
+
+            // Try to pull a new sample from the appsink
+            let sample = match sw.appsink.try_pull_sample(gst::ClockTime::ZERO) {
+                Some(sample) => sample,
+                None => break,
+            };
+
+            let buffer = match sample.buffer() {
+                Some(buffer) => buffer,
+                None => break,
+            };
+
+            let map = match buffer.map_readable() {
+                Ok(map) => map,
+                Err(e) => {
+                    eprintln!("Failed to map input buffer for reading: {e}");
+                    break;
+                }
+            };
+
+            let data = map.as_slice();
+            let needed = buf.len() - total_read;
+            let bytes_to_copy = data.len().min(needed);
+
+            buf[total_read..total_read + bytes_to_copy].copy_from_slice(&data[..bytes_to_copy]);
+            total_read += bytes_to_copy;
+
+            // If there's remaining data, save it for next read
+            if bytes_to_copy < data.len() {
+                if let Ok(mut pending) = sw.pending_data.lock() {
+                    pending.extend_from_slice(&data[bytes_to_copy..]);
+                }
+                break;
+            }
+        }
+
+        total_read
+    }
+
+    fn get_buffer_size_out(&self, sw: &mut Self::VoiceOut) -> i32 {
+        // Maybe it should query the pipeline for latency instead
+        // Tbh, it looks like this API is not very useful in QEMU
+        sw.appsrc.current_level_bytes() as i32
+    }
+
+    fn add_capture(
+        &self,
+        settings: &bindings::audsettings,
+        ops: Box<dyn crate::audio::AudioCaptureOps + Send>,
+    ) -> Option<Self::Capture> {
+        match self.try_add_capture(settings, ops) {
+            Ok(capture) => Some(capture),
+            Err(e) => {
+                eprintln!("Failed to add capture: {e}");
+                None
+            }
+        }
+    }
+
+    fn del_capture(&self, cap: Self::Capture) {
+        if let Ok(mut ops_guard) = cap.ops.lock() {
+            ops_guard.destroy();
+        }
+
+        if let Some(ghost_pad) = cap.bin.static_pad("sink") {
+            let _ = cap.tee_pad.unlink(&ghost_pad);
+        }
+
+        if let Some(tee) = cap.tee_pad.parent_element() {
+            tee.release_request_pad(&cap.tee_pad);
+        }
+
+        if let Err(e) = cap.bin.set_state(gst::State::Null) {
+            eprintln!("Warning: Failed to set capture bin to null state: {e}");
+        }
+
+        if let Some(pipeline) = cap
+            .bin
+            .parent()
+            .and_then(|p| p.downcast::<gst::Pipeline>().ok())
+        {
+            if let Err(e) = pipeline.remove(&cap.bin) {
+                eprintln!("Warning: Failed to remove capture bin from pipeline: {e}");
+            }
+        }
+    }
+
+    fn set_dbus_server(
+        &self,
+        _manager: *mut gio_sys::GDBusObjectManagerServer,
+        _p2p: bool,
+    ) -> Result<()> {
+        Err(Error::msg("DBus not supported by this backend"))
+    }
+}
+
+impl AudioGStreamer {
+    fn try_add_capture(
+        &self,
+        settings: &bindings::audsettings,
+        ops: Box<dyn crate::audio::AudioCaptureOps + Send>,
+    ) -> Result<Capture> {
+        let mixer_pipeline_ref = self.mixer_pipeline.borrow();
+        let mixer_pipeline = mixer_pipeline_ref
+            .as_ref()
+            .ok_or_else(|| Error::msg("Capture is only supported when mixing-engine is enabled"))?;
+
+        let caps = build_audio_caps(settings)?;
+        let appsink = gst_app::AppSink::builder().caps(&caps).sync(false).build();
+
+        let ops = Arc::new(Mutex::new(ops));
+        let ops_clone = ops.clone();
+        // Set up callback to pull samples from appsink
+        appsink.set_callbacks(
+            gst_app::AppSinkCallbacks::builder()
+                .new_sample(move |sink| {
+                    let sample = sink.pull_sample().map_err(|_| gst::FlowError::Eos)?;
+                    let buffer = sample.buffer().ok_or(gst::FlowError::Error)?;
+
+                    let map = buffer.map_readable().map_err(|_| gst::FlowError::Error)?;
+                    let data = map.as_slice();
+
+                    trace::trace_gst_new_sample(c"capture", data.len());
+                    // Forward captured audio to ops
+                    if let Ok(mut ops_guard) = ops_clone.lock() {
+                        ops_guard.notify(CaptureNotification::AUD_CNOTIFY_ENABLE);
+                        ops_guard.capture(data);
+                    }
+
+                    Ok(gst::FlowSuccess::Ok)
+                })
+                .build(),
+        );
+
+        let bin = gst::Bin::new();
+
+        let queue = create_element("queue")?;
+        let audioconvert = create_element("audioconvert")?;
+        let audioresample = create_element("audioresample")?;
+
+        bin.add_many([&queue, &audioconvert, &audioresample, appsink.upcast_ref()])?;
+
+        gst::Element::link_many([&queue, &audioconvert, &audioresample, appsink.upcast_ref()])?;
+
+        let queue_sink_pad = queue
+            .static_pad("sink")
+            .ok_or_else(|| Error::msg("Failed to get queue sink pad"))?;
+        let ghost_pad = gst::GhostPad::with_target(&queue_sink_pad)?;
+        ghost_pad.set_active(true)?;
+        bin.add_pad(&ghost_pad)?;
+
+        mixer_pipeline.pipeline.add(&bin)?;
+
+        let tee_pad = mixer_pipeline
+            .tee
+            .request_pad_simple("src_%u")
+            .ok_or_else(|| Error::msg("Failed to request pad from tee"))?;
+
+        // Link tee → bin (ghost pad)
+        tee_pad.link(&ghost_pad)?;
+
+        bin.sync_state_with_parent()?;
+
+        Ok(Capture { bin, tee_pad, ops })
+    }
+
+    unsafe fn init(mut this: ParentInit<Self>) {
+        uninit_field_mut!(*this, id).write(BqlCell::new(CString::new("invalid-id").unwrap()));
+        uninit_field_mut!(*this, opt).write(BqlRefCell::new(None));
+        uninit_field_mut!(*this, mixer_pipeline).write(BqlRefCell::new(None));
+    }
+}
+
+fn set_playing(elem: &gst::Element, on: bool) {
+    let target_state = if on {
+        gst::State::Playing
+    } else {
+        gst::State::Null
+    };
+
+    if let Err(e) = elem.set_state(target_state) {
+        eprintln!("Failed to set element state to {target_state:?}: {e}");
+    }
+}
+
+/// Build `GStreamer` caps for the given audio settings
+fn build_audio_caps(settings: &bindings::audsettings) -> Result<gst::Caps> {
+    let format = audio_format_to_gst_format(settings.fmt)?;
+
+    Ok(gst_audio::AudioCapsBuilder::new_interleaved()
+        .format(format)
+        .rate(settings.freq)
+        .channels(settings.nchannels)
+        .build())
+}
+
+/// Find the sink element in the pipeline
+fn find_sink_element(pipeline: &gst::Pipeline) -> Option<gst::Element> {
+    pipeline.iterate_sinks().into_iter().flatten().next()
+}
+
+/// Find the source element in the pipeline
+fn find_source_element(pipeline: &gst::Pipeline) -> Option<gst::Element> {
+    pipeline.iterate_sources().into_iter().flatten().next()
+}
+
+fn set_element_volume(elem: gst::Element, volume: f64, mute: bool) {
+    if elem.find_property("volume").is_some() {
+        elem.set_property("volume", volume);
+    }
+    if elem.find_property("mute").is_some() {
+        elem.set_property("mute", mute);
+    }
+}
+
+/// Convert QEMU volume (0-255 per channel) to `GStreamer` volume (0.0-1.0)
+/// Returns the average volume across all channels
+fn qemu_volume_to_gst(vol: &bindings::Volume) -> f64 {
+    let channels = vol.channels.min(bindings::AUDIO_MAX_CHANNELS as i32) as usize;
+
+    if channels == 0 {
+        return 0.0;
+    }
+
+    let total: u32 = vol.vol[..channels].iter().map(|&v| u32::from(v)).sum();
+
+    f64::from(total) / (channels as f64 * 255.0)
+}
+
+/// Build caps from `AudiodevPerDirectionOptions` for fixed settings
+fn build_caps_from_options(opt: &AudiodevPerDirectionOptions) -> Result<gst::Caps> {
+    let format = opt.format.map(audio_format_to_gst_format).transpose()?;
+    let rate = opt.frequency.map(|f| f as i32);
+    let channels = opt.channels.map(|c| c as i32);
+
+    Ok(gst_audio::AudioCapsBuilder::new_interleaved()
+        .format_if_some(format)
+        .rate_if_some(rate)
+        .channels_if_some(channels)
+        .build())
+}
+
+/// Create a shared mixer pipeline for mixing multiple audio voices
+fn create_mixer_pipeline(opt: &AudiodevGStreamerOptions) -> Result<MixerPipeline> {
+    let pipeline = gst::Pipeline::new();
+
+    let mixer = gst::ElementFactory::make("liveadder")
+        .property("ignore-inactive-pads", true)
+        .property("force-live", true)
+        .build()?;
+
+    let audioconvert = create_element("audioconvert")?;
+    let audioresample = create_element("audioresample")?;
+    let tee = create_element("tee")?;
+    let queue = create_element("queue")?;
+    let buffer_time_us = opt.out.as_ref().and_then(|o| o.buffer_length);
+    let audiosink = create_audiosink(&opt.sink, buffer_time_us)?;
+
+    let capsfilter = if opt
+        .out
+        .as_ref()
+        .and_then(|o| o.fixed_settings)
+        .unwrap_or(false)
+    {
+        let cf = create_element("capsfilter")?;
+        let caps = build_caps_from_options(opt.out.as_ref().unwrap())?;
+        cf.set_property("caps", &caps);
+        Some(cf)
+    } else {
+        None
+    };
+
+    let mut elements: Vec<&gst::Element> =
+        vec![&mixer, &audioconvert, &audioresample, &tee, &queue];
+    if let Some(ref cf) = capsfilter {
+        elements.push(cf);
+    }
+    elements.push(&audiosink);
+
+    pipeline.add_many(&elements)?;
+
+    gst::Element::link_many([&mixer, &audioconvert, &audioresample, &tee])?;
+
+    if let Some(ref cf) = capsfilter {
+        gst::Element::link_many([&tee, &queue, cf, &audiosink])?;
+    } else {
+        gst::Element::link_many([&tee, &queue, &audiosink])?;
+    }
+
+    let bus_watch = add_bus_watch(&pipeline)?;
+    set_playing(pipeline.upcast_ref(), true);
+
+    Ok(MixerPipeline {
+        pipeline,
+        mixer,
+        tee,
+        bus_watch,
+    })
+}
+
+/// Create a voice output connected to the shared mixer
+fn create_mixed_voice(
+    mixer_pipeline: &MixerPipeline,
+    settings: &bindings::audsettings,
+    name: &CStr,
+) -> Result<VoiceOut> {
+    // Create a separate bin for this voice
+    let bin = gst::Bin::new();
+
+    let appsrc = create_appsrc(settings, name)?;
+    let volume = create_element("volume")?;
+    let stream_volume = volume
+        .clone()
+        .dynamic_cast::<gst_audio::StreamVolume>()
+        .ok();
+    let identity = create_element("identity")?;
+    identity.set_property("sync", true);
+    let audioconvert = create_element("audioconvert")?;
+    let audioresample = create_element("audioresample")?;
+
+    bin.add_many([
+        appsrc.upcast_ref(),
+        &identity,
+        &volume,
+        &audioconvert,
+        &audioresample,
+    ])?;
+    gst::Element::link_many([
+        appsrc.upcast_ref(),
+        &identity,
+        &volume,
+        &audioconvert,
+        &audioresample,
+    ])?;
+
+    let src_pad = audioresample
+        .static_pad("src")
+        .ok_or_else(|| Error::msg("Failed to get source pad"))?;
+
+    let ghost_pad = gst::GhostPad::with_target(&src_pad)?;
+
+    ghost_pad.set_active(true)?;
+    bin.add_pad(&ghost_pad)?;
+
+    mixer_pipeline
+        .pipeline
+        .add(bin.upcast_ref::<gst::Element>())?;
+
+    bin.link(&mixer_pipeline.mixer)?;
+
+    Ok(VoiceOut {
+        kind: VoiceOutKind::Mixed,
+        pipeline: mixer_pipeline.pipeline.clone(),
+        stream_volume,
+        appsrc,
+        active: Arc::new(AtomicBool::new(false)),
+        active_time: None,
+        bytes_per_second: get_bytes_per_second(settings)?,
+        bytes_written: 0,
+        offset_time: None,
+    })
+}
+
+/// Create a standalone voice output without mixer or capture
+fn create_standalone_voice(
+    settings: &bindings::audsettings,
+    name: &CStr,
+    opt: &AudiodevGStreamerOptions,
+) -> Result<VoiceOut> {
+    let pipeline = gst::Pipeline::new();
+
+    let appsrc = create_appsrc(settings, name)?;
+    let identity = create_element("identity")?;
+    identity.set_property("sync", true);
+    let audioconvert = create_element("audioconvert")?;
+    let audioresample = create_element("audioresample")?;
+    let queue = create_element("queue")?;
+
+    let buffer_time_us = opt.out.as_ref().and_then(|o| o.buffer_length);
+    let audiosink = create_audiosink(&opt.sink, buffer_time_us)?;
+    let stream_volume = audiosink
+        .clone()
+        .dynamic_cast::<gst_audio::StreamVolume>()
+        .ok();
+
+    pipeline.add_many([
+        appsrc.upcast_ref(),
+        &identity,
+        &audioconvert,
+        &audioresample,
+        &queue,
+        &audiosink,
+    ])?;
+
+    gst::Element::link_many([
+        appsrc.upcast_ref(),
+        &identity,
+        &audioconvert,
+        &audioresample,
+        &queue,
+        &audiosink,
+    ])?;
+
+    let bus_watch = add_bus_watch(&pipeline)?;
+
+    Ok(VoiceOut {
+        kind: VoiceOutKind::Standalone(bus_watch),
+        pipeline,
+        stream_volume,
+        appsrc,
+        active: Arc::new(AtomicBool::new(false)),
+        active_time: None,
+        bytes_per_second: get_bytes_per_second(settings)?,
+        bytes_written: 0,
+        offset_time: None,
+    })
+}
+
+fn add_bus_watch(pipeline: &gst::Pipeline) -> Result<gst::bus::BusWatchGuard> {
+    // Add bus message handler to prevent queue overflow
+    let bus = pipeline
+        .bus()
+        .ok_or_else(|| Error::msg("Failed to get pipeline bus"))?;
+    let bus_watch = bus.add_watch(|_bus, msg| {
+        use gst::MessageView;
+        match msg.view() {
+            MessageView::Error(err) => {
+                eprintln!(
+                    "GStreamer error from {:?}: {} ({:?})",
+                    err.src().map(gst::prelude::GstObjectExt::path_string),
+                    err.error(),
+                    err.debug()
+                );
+            }
+            MessageView::Warning(warning) => {
+                eprintln!(
+                    "GStreamer warning from {:?}: {} ({:?})",
+                    warning.src().map(gst::prelude::GstObjectExt::path_string),
+                    warning.error(),
+                    warning.debug()
+                );
+            }
+            _ => {}
+        }
+        glib::ControlFlow::Continue
+    })?;
+
+    Ok(bus_watch)
+}
+
+/// Create an input voice for audio recording
+fn create_input_voice(
+    opt: &AudiodevGStreamerOptions,
+    settings: &bindings::audsettings,
+) -> Result<VoiceIn> {
+    let source_name = opt.source.as_deref().unwrap_or("autoaudiosrc");
+    let pipeline = gst::Pipeline::new();
+
+    let audiosrc = create_element(source_name)?;
+    let audioconvert = create_element("audioconvert")?;
+    let audioresample = create_element("audioresample")?;
+    let caps = build_audio_caps(settings)?;
+    let appsink = gst_app::AppSink::builder()
+        .caps(&caps)
+        .sync(false)
+        .max_time(Some(gst::ClockTime::from_mseconds(10)))
+        .build();
+
+    pipeline.add_many([
+        &audiosrc,
+        &audioconvert,
+        &audioresample,
+        appsink.upcast_ref(),
+    ])?;
+
+    gst::Element::link_many([
+        &audiosrc,
+        &audioconvert,
+        &audioresample,
+        appsink.upcast_ref(),
+    ])?;
+
+    Ok(VoiceIn {
+        pipeline,
+        appsink,
+        active: false,
+        pending_data: Arc::new(Mutex::new(Vec::new())),
+    })
+}
+
+fn create_audiosink(
+    elem_name: &Option<String>,
+    buffer_time_us: Option<u32>,
+) -> Result<gst::Element> {
+    const DEFAULT_BUFFER_TIME_US: u32 = 40_000;
+
+    let elem_name = elem_name.as_deref().unwrap_or("autoaudiosink");
+    let audiosink = create_element(elem_name)?;
+    let buffer_time_us: i64 = buffer_time_us.unwrap_or(DEFAULT_BUFFER_TIME_US).into();
+
+    if let Some(child_proxy) = audiosink.dynamic_cast_ref::<gst::ChildProxy>() {
+        child_proxy.connect_child_added(move |_proxy, child, _child_name| {
+            if let Some(elem) = child.downcast_ref::<gst::Element>() {
+                if elem.has_property("buffer-time") {
+                    elem.set_property("buffer-time", buffer_time_us);
+                } else {
+                    eprintln!("no buffer-time property on the sink");
+                }
+            }
+        });
+    }
+
+    Ok(audiosink)
+}
+
+fn create_appsrc(settings: &bindings::audsettings, name: &CStr) -> Result<gst_app::AppSrc> {
+    let caps = build_audio_caps(settings)?;
+
+    let appsrc = gst_app::AppSrc::builder()
+        .caps(&caps)
+        .is_live(true)
+        .format(gst::Format::Time)
+        // we don't want to block QEMU
+        .block(false)
+        .build();
+    // create a stream-id
+    appsrc.set_uri(&format!("appsrc://{}", name.to_string_lossy()))?;
+    Ok(appsrc)
+}
+
+/// Create a `GStreamer` element with error reporting
+fn create_element(factory_name: &str) -> Result<gst::Element> {
+    gst::ElementFactory::make(factory_name)
+        .build()
+        .map_err(|e| Error::msg(format!("Failed to create element '{factory_name}': {e}")))
+}
+
+fn get_bytes_per_second(settings: &bindings::audsettings) -> Result<usize> {
+    let bytes_per_sample = get_bytes_per_sample(settings.fmt)?;
+
+    Ok(settings.freq as usize * settings.nchannels as usize * bytes_per_sample as usize)
+}
+
+fn get_bytes_per_sample(fmt: bindings::AudioFormat) -> Result<usize> {
+    use bindings::AudioFormat::*;
+    match fmt {
+        AUDIO_FORMAT_U8 | AUDIO_FORMAT_S8 => Ok(1),
+        AUDIO_FORMAT_U16 | AUDIO_FORMAT_S16 => Ok(2),
+        AUDIO_FORMAT_U32 | AUDIO_FORMAT_S32 | AUDIO_FORMAT_F32 => Ok(4),
+        _ => Err(Error::msg(format!("Unsupported audio format: {fmt:?}"))),
+    }
+}
+
+fn audio_format_to_gst_format(fmt: bindings::AudioFormat) -> Result<gst_audio::AudioFormat> {
+    use bindings::AudioFormat::*;
+    use gst_audio::AudioFormat as GAF;
+
+    match fmt {
+        AUDIO_FORMAT_U8 => Ok(GAF::U8),
+        AUDIO_FORMAT_S8 => Ok(GAF::S8),
+        AUDIO_FORMAT_U16 => Ok(GAF::U16le),
+        AUDIO_FORMAT_S16 => Ok(GAF::S16le),
+        AUDIO_FORMAT_U32 => Ok(GAF::U32le),
+        AUDIO_FORMAT_S32 => Ok(GAF::S32le),
+        AUDIO_FORMAT_F32 => Ok(GAF::F32le),
+        _ => Err(Error::msg(format!("Unsupported audio format: {fmt:?}"))),
+    }
+}
diff --git a/rust/audio/src/lib.rs b/rust/audio/src/lib.rs
new file mode 100644
index 0000000000..3e899e2439
--- /dev/null
+++ b/rust/audio/src/lib.rs
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+
+mod audio;
+use std::ffi::CStr;
+
+pub use audio::*;
+
+mod gstreamer;
+
+pub const TYPE_AUDIO_GSTREAMER: &std::ffi::CStr = c"audio-gstreamer";
+
+#[derive(Default, Debug, PartialEq, Eq)]
+pub struct AudiodevGStreamerOptions {
+    pub in_: Option<AudiodevPerDirectionOptions>,
+    pub out: Option<AudiodevPerDirectionOptions>,
+    pub sink: Option<String>,
+    pub source: Option<String>,
+}
+
+#[derive(Default, Debug, PartialEq, Eq)]
+pub struct AudiodevPerDirectionOptions {
+    pub mixing_engine: Option<bool>,
+    pub fixed_settings: Option<bool>,
+    pub frequency: Option<u32>,
+    pub channels: Option<u32>,
+    pub voices: Option<u32>,
+    pub format: Option<bindings::AudioFormat>,
+    pub buffer_length: Option<u32>,
+}
+
+impl From<&bindings::AudiodevGStreamerOptions> for AudiodevGStreamerOptions {
+    fn from(value: &bindings::AudiodevGStreamerOptions) -> Self {
+        let in_ = (!value.in_.is_null())
+            .then(|| AudiodevPerDirectionOptions::from(unsafe { &*value.in_ }));
+        let out = (!value.out.is_null())
+            .then(|| AudiodevPerDirectionOptions::from(unsafe { &*value.out }));
+        let sink = (!value.sink.is_null()).then(|| {
+            unsafe { CStr::from_ptr(value.sink) }
+                .to_string_lossy()
+                .into_owned()
+        });
+        let source = (!value.source.is_null()).then(|| {
+            unsafe { CStr::from_ptr(value.source) }
+                .to_string_lossy()
+                .into_owned()
+        });
+
+        Self {
+            in_,
+            out,
+            sink,
+            source,
+        }
+    }
+}
+
+impl From<&bindings::AudiodevPerDirectionOptions> for AudiodevPerDirectionOptions {
+    fn from(value: &bindings::AudiodevPerDirectionOptions) -> Self {
+        Self {
+            mixing_engine: if value.has_mixing_engine {
+                Some(value.mixing_engine)
+            } else {
+                None
+            },
+            fixed_settings: if value.has_fixed_settings {
+                Some(value.fixed_settings)
+            } else {
+                None
+            },
+            frequency: if value.has_frequency {
+                Some(value.frequency)
+            } else {
+                None
+            },
+            channels: if value.has_channels {
+                Some(value.channels)
+            } else {
+                None
+            },
+            voices: if value.has_voices {
+                Some(value.voices)
+            } else {
+                None
+            },
+            format: if value.has_format {
+                Some(value.format)
+            } else {
+                None
+            },
+            buffer_length: if value.has_buffer_length {
+                Some(value.buffer_length)
+            } else {
+                None
+            },
+        }
+    }
+}
diff --git a/rust/meson.build b/rust/meson.build
index 9f0ed48481..8c2905a7f0 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -13,6 +13,11 @@ syn_rs_native = cargo_ws.subproject('syn').dependency()
 proc_macro2_rs_native = cargo_ws.subproject('proc-macro2').dependency()
 attrs_rs_native = cargo_ws.subproject('attrs').dependency()
 
+futures_rs = cargo_ws.subproject('futures').dependency()
+gio_sys_rs = cargo_ws.subproject('gio-sys').dependency()
+gst_app_rs = cargo_ws.subproject('gstreamer-app').dependency()
+gst_audio_rs = cargo_ws.subproject('gstreamer-audio').dependency()
+
 genrs = []
 
 subdir('qemu-macros')
@@ -29,6 +34,7 @@ subdir('hw/core')
 subdir('tests')
 subdir('trace')
 subdir('hw')
+subdir('audio')
 
 cargo = find_program('cargo', required: false)
 
-- 
2.51.1


