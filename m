Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAE2CD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlIc-0000oJ-P7; Sat, 09 May 2026 13:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIZ-0000ec-4q
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlIX-0005Pr-HF
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778347024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYXmbRstOh2+gnsYlCTibS3Jum51nlAnN9XXssfmugs=;
 b=XhNgKojOQo8Vrr6tjHA69nFpQdl98bjiMcwtrouw3rUcj5yrzWhQBU7Y33oECDAnq+0ORo
 46WRU/kOY3YNuUjHQvH3KK3sisfD+DmQ0z3NsZJYzHu/Sy09chruegvtxUWwo8jeuX00J2
 zGtnYPBgtEgSCBkSZ5fd5cOCiB0gLyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-5n4BRUEZNKi3oNDpkZkRBg-1; Sat,
 09 May 2026 13:17:03 -0400
X-MC-Unique: 5n4BRUEZNKi3oNDpkZkRBg-1
X-Mimecast-MFC-AGG-ID: 5n4BRUEZNKi3oNDpkZkRBg_1778347022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A091956088; Sat,  9 May 2026 17:17:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E7C93002D30; Sat,  9 May 2026 17:17:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 30/33] ui: extract common sources into a static library
Date: Sat,  9 May 2026 21:13:51 +0400
Message-ID: <20260509171356.1157879-31-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move clipboard, cursor, display-surface, input-keymap, kbd-state,
keymaps, vt100, and qemu-pixman into a separate static library 'qemuui'.
This allows these common UI sources to be linked by targets outside of
the system emulator build, such as standalone VNC or D-Bus display
binaries.

keymaps generation has to be moved earlier, so that header dependency
are resolved first.

The library objects are re-exported via a dependency so existing
system_ss consumers are unaffected.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 103 ++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index 74151b05033..1b8f71796e4 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,25 +1,67 @@
-system_ss.add(pixman)
+keymaps = [
+  ['atset1', 'qcode'],
+  ['linux', 'qcode'],
+  ['qcode', 'atset1'],
+  ['qcode', 'atset2'],
+  ['qcode', 'atset3'],
+  ['qcode', 'linux'],
+  ['qcode', 'qnum'],
+  ['qcode', 'sun'],
+  ['qnum', 'qcode'],
+  ['usb', 'qcode'],
+  ['win32', 'qcode'],
+  ['x11', 'qcode'],
+  ['xorgevdev', 'qcode'],
+  ['xorgkbd', 'qcode'],
+  ['xorgxquartz', 'qcode'],
+  ['xorgxwin', 'qcode'],
+  ['osx', 'qcode'],
+]
+
+if have_system or xkbcommon.found()
+  keycodemapdb_proj = subproject('keycodemapdb', required: true)
+  foreach e : keymaps
+    output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
+    genh += custom_target(output,
+                  output: output,
+                  capture: true,
+                  input: keycodemapdb_proj.get_variable('keymaps_csv'),
+                  command: [python, keycodemapdb_proj.get_variable('keymap_gen').full_path(),
+                            'code-map', '--lang', 'glib2',
+                            '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
+                            '@INPUT0@', e[0], e[1]])
+  endforeach
+endif
+
+libui_sources = files(
+    'clipboard.c',
+    'console.c',
+    'cursor.c',
+    'dmabuf.c',
+    'display-surface.c',
+    'input-keymap.c',
+    'kbd-state.c',
+    'keymaps.c',
+    'qemu-pixman.c',
+    'vgafont.c',
+  )
+if pixman.found()
+  libui_sources += files('cp437.c', 'vt100.c')
+endif
+libui = static_library('qemuui', libui_sources + genh,
+  dependencies: [pixman],
+  build_by_default: false)
+ui = declare_dependency(objects: libui.extract_all_objects(recursive: false), dependencies: [pixman])
 system_ss.add(png)
 system_ss.add(files(
-  'clipboard.c',
-  'console.c',
-  'cp437.c',
-  'cursor.c',
-  'display-surface.c',
-  'dmabuf.c',
-  'input-keymap.c',
   'input-legacy.c',
   'input-barrier.c',
   'input.c',
-  'kbd-state.c',
-  'keymaps.c',
-  'qemu-pixman.c',
   'ui-hmp-cmds.c',
   'ui-qmp-cmds.c',
   'util.c',
-  'vgafont.c',
-  'vt100.c',
 ))
+system_ss.add(ui)
 system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
 if dbus_display
   system_ss.add(files('dbus-module.c'))
@@ -149,41 +191,6 @@ if spice.found()
   endif
 endif
 
-keymaps = [
-  ['atset1', 'qcode'],
-  ['linux', 'qcode'],
-  ['qcode', 'atset1'],
-  ['qcode', 'atset2'],
-  ['qcode', 'atset3'],
-  ['qcode', 'linux'],
-  ['qcode', 'qnum'],
-  ['qcode', 'sun'],
-  ['qnum', 'qcode'],
-  ['usb', 'qcode'],
-  ['win32', 'qcode'],
-  ['x11', 'qcode'],
-  ['xorgevdev', 'qcode'],
-  ['xorgkbd', 'qcode'],
-  ['xorgxquartz', 'qcode'],
-  ['xorgxwin', 'qcode'],
-  ['osx', 'qcode'],
-]
-
-if have_system or xkbcommon.found()
-  keycodemapdb_proj = subproject('keycodemapdb', required: true)
-  foreach e : keymaps
-    output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
-    genh += custom_target(output,
-                  output: output,
-                  capture: true,
-                  input: keycodemapdb_proj.get_variable('keymaps_csv'),
-                  command: [python, keycodemapdb_proj.get_variable('keymap_gen').full_path(),
-                            'code-map', '--lang', 'glib2',
-                            '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
-                            '@INPUT0@', e[0], e[1]])
-  endforeach
-endif
-
 subdir('shader')
 
 if have_system
-- 
2.54.0


