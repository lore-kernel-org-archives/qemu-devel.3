Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531D5F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QFS-000267-Kg; Tue, 17 Mar 2026 04:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDh-0004IH-Ct
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QDf-00079s-Ck
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJ/S1HD4zJEJT7auFJflqd01X5wN+0xFE93QSqun8/c=;
 b=TAlnRqht6kPwkWbcfyRrANds/JCZzP4z7mFDvZa8Ia+rpFwdbPNZ5CcOC+5cW2SnCWX2vC
 DfcbCU3uKnOCEQdGzbCg7itCOeP6fp63Yy0Yfs1q5eNtb2zEJNXSqX9jPrEGP3464JzxDJ
 LCmBXFwXLURbO54tYEnNsjb7aRZLYK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-MCt2B6RUNviKUWzL_62vhQ-1; Tue,
 17 Mar 2026 04:56:05 -0400
X-MC-Unique: MCt2B6RUNviKUWzL_62vhQ-1
X-Mimecast-MFC-AGG-ID: MCt2B6RUNviKUWzL_62vhQ_1773737764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DB51955F6A
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A04E630002DA
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:10 +0400
Subject: [PATCH 56/60] ui: extract common sources into a static library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-56-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=4370;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fbSBEB8CYPoQe44hyU9awPms6P1r5vnWodUEwJ1Ikco=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXck3xralkWCW7/FH3H+JdutEgTiWsu1GJqA
 8lV3NKSI0+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5VyFD/4xjK+37w5T31muISb3FNDp0nrPgjhDJOE8aksJBFdMf3OlV5eTV6g3UR/dRjg8nj6cNN5
 RytZmO2kiHM7BaNH8XyIMiXKqpvQL98NVKbg55qeoltkuLCLR72AggmNMByCk3OZu2p14f7IRts
 E0XHKzeUyHNgeg9vNZHOEN3IeEwhtIo6eNBWxWMKCEAGgH+sYCeUvDNaftXQARakp3MxoxLIXsJ
 wo4kNLcpAn5vMtPbSeQkaEKIP2QffPuWgoUdtUAtmFcbngwJ4eQhk3gmTtSAIjGSp1lR38X0IoH
 axMPszEbcTC1PP8p89wn4+Wbyr9EJl5+DfnsMO7sjB0kDapN6EB6DWvQIKW7qdIeFD6RkYIi8q0
 a4oUyL2t7ulqOMY3yxTJqJt4rQnAqJvZXLD/64iTPiZEFVn8WQwH6ebsD+l/AIJ1wSaW27Xa3Ko
 pg1YQdq3MROHVx+dQQh2d2L/7CzEycts2kkYjOFs3f6z7hJk8sTryQConvVRATUakpzs0qUDohC
 TS8c2bZBkEv0h66qd/tUyl7A9yq+9aRRWbTDVbopsF+SkSXbzrPQgpDQ44XbvEZFkI5BoABKuY/
 W/7Jm4oBPm/QaM1MRBqHmZBambz7e6jpTTilWaKSxO7TFa4cZarCZdkVv8lXyE1bHGSPKGTzffC
 P/b9ZuwCMJl+sNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move clipboard, cursor, display-surface, input-keymap, kbd-state,
keymaps, vt100, and qemu-pixman into a separate static library 'qemuui'.
This allows these common UI sources to be linked by targets outside of
the system emulator build, such as standalone VNC or D-Bus display
binaries.

keymaps generation has to be moved earlier, so that header dependency
are resolved first.

The library objects are re-exported via a dependency so existing
system_ss consumers are unaffected.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/meson.build | 103 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 48 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index f959f8972b5..c3f4d03eaf8 100644
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
@@ -151,41 +193,6 @@ if spice.found()
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
2.53.0


