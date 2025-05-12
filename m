Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A0C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTG-0005Ta-Se; Mon, 12 May 2025 15:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT8-0005Rx-EX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT5-0007UN-8l
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ehf2YgaMXoxb+fwp0uJKFVwZBOJsson/HPg8rmycXI=;
 b=dT8r8fHY+mvQOV83yyBjiB3470tnlkjsGriS1lNMSm8QtsEhWG5af/uPy1y8Pok1/hnV4/
 AXtqCY2B2KEVTYlcl9iLmsFpVNWlE28N+imHB6OvTrblVljugaVfEg11VHL6LJQcsJ8WnZ
 H5Me3sT3p2xIs4bE31UcYHQdI4yz2zc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-9m9jfK4dNpC5eJphH3B6RQ-1; Mon, 12 May 2025 15:05:36 -0400
X-MC-Unique: 9m9jfK4dNpC5eJphH3B6RQ-1
X-Mimecast-MFC-AGG-ID: 9m9jfK4dNpC5eJphH3B6RQ_1747076736
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7ceaa20so1569796f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076735; x=1747681535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ehf2YgaMXoxb+fwp0uJKFVwZBOJsson/HPg8rmycXI=;
 b=TnGegcU5vox6UALmToVL++IdcCw84DWge1Mz76BrmoLaigMQiRrUfJ30lHh39RUoD0
 /dY+QBVyndZji+N5zTNUy6pjryEGwn0uRfh4WJzbB+CZS8yvrKDB7YraqGL3v6QCcmHw
 4n0TBhF1wGsiW/ScCzXKKIP5+089RKPO/ZaVj58wr0s0IzhzUcFBMI4VI9zjGn4u9K87
 sLwFsSyTLtduCpI+mbY0cBzKh16ersNL1RNXt9OngrO9Q30D93gY6bNXsnZChEd9K2aj
 NAwqwfpnLZ8KaqPFk78yDauxqvPj82Ls0MRuXZb7yLFG8Yr2VxYFEvkw03YODTTZXrYL
 NJPQ==
X-Gm-Message-State: AOJu0YxpTr35QizE/neoSUXle9O5uigS0rNOPOKFkWiFq9JW9vU0mgnC
 D/7YE0B8goLpAMRXyyLCMSUFGQhZlCKUQfUeUqSqxS6MjZ2yWiJssIOl8OaszbUH1VrBXEGQJZI
 AiY5o0yzEkexhFus49E0TMuxvi91NyoHI64asdjAxIhY1Hex1GgwxIm3gtBoKahRjbiErCuvPv/
 5ekUBa3H/FNWimodFQZ60PXWAgmz8b8GKOhRDQ
X-Gm-Gg: ASbGncsyh6nEyII5x3tTRsqXqj/V2wv7KNAbaVhgIvsiSWWZyZ6GXNUURjFYagDKviv
 QGtz4ANhJlMaQJfV1LnXCQL3FHVsbl6An6CUHSTgfLemLyJpWVIGiRYlYS2ccrzfLjy2+O/YtpY
 woPxk5iMeoGYXZ9b26BWnddP2naic9bh/8S3Elvxo/u9ijNq+TsLMCo6jpKramBLFPB4DkxXUbs
 WPPwnj/DtsW91hAbV7XMQKUKZZ0VE6gGWA6HHm2Hzu7MhF0310cFz8lgC+K7Xs6kFr2S3gIxMRz
 NG8OOrfDpehHIlY=
X-Received: by 2002:a5d:64c3:0:b0:3a0:b84c:7dab with SMTP id
 ffacd0b85a97d-3a1f6421db3mr11717083f8f.4.1747076735246; 
 Mon, 12 May 2025 12:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW8Liwga4/tnsWeFSOBmclzDh3G/rvAefR3Es7wI0TZLg5k88r2e7qnWyCOrphUuQ+XwIRyw==
X-Received: by 2002:a5d:64c3:0:b0:3a0:b84c:7dab with SMTP id
 ffacd0b85a97d-3a1f6421db3mr11717060f8f.4.1747076734867; 
 Mon, 12 May 2025 12:05:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4cc39sm13200196f8f.100.2025.05.12.12.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/16] modinfo: lookup compile_commands.json by object
Date: Mon, 12 May 2025 21:05:12 +0200
Message-ID: <20250512190524.179419-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since modinfo support was added, Meson fixed several issues with
extract_objects and compile_commands.json lookups can be simplified.
If the lookup uses the object file as key, there is no need to use the
command line to distinguish among all entries for a given source.

Ninja 1.9 is required in order to produce the 'output' key in
compile_commands.json; it is available in CentOS Stream 9, Debian 11, SLES
15.2, Ubuntu 20.04 and in all recent BSD distros.  Samurai also has it.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                | 14 ++++----------
 scripts/modinfo-collect.py | 23 +++++++++++------------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/meson.build b/meson.build
index a2cebd44656..7f91500bb73 100644
--- a/meson.build
+++ b/meson.build
@@ -3903,16 +3903,11 @@ foreach d, list : modules
                     install: true,
                     install_dir: qemu_moddir)
       if module_ss.sources() != []
-        # FIXME: Should use sl.extract_all_objects(recursive: true) as
-        # input. Sources can be used multiple times but objects are
-        # unique when it comes to lookup in compile_commands.json.
-        # Depnds on a mesion version with
-        # https://github.com/mesonbuild/meson/pull/8900
         modinfo_files += custom_target(d + '-' + m + '.modinfo',
                                        output: d + '-' + m + '.modinfo',
-                                       input: module_ss.sources() + genh,
+                                       input: sl.extract_all_objects(recursive: true),
                                        capture: true,
-                                       command: [modinfo_collect, module_ss.sources()])
+                                       command: [modinfo_collect, '@INPUT@'])
       endif
     else
       if d == 'block'
@@ -3951,12 +3946,11 @@ foreach d, list : target_modules
                     dependencies: target_module_ss.dependencies(),
                     install: true,
                     install_dir: qemu_moddir)
-            # FIXME: Should use sl.extract_all_objects(recursive: true) too.
             modinfo_files += custom_target(module_name + '.modinfo',
                                            output: module_name + '.modinfo',
-                                           input: target_module_ss.sources() + genh,
+                                           input: sl.extract_all_objects(recursive: true),
                                            capture: true,
-                                           command: [modinfo_collect, '--target', target, target_module_ss.sources()])
+                                           command: [modinfo_collect, '--target', target, '@INPUT@'])
           endif
         endif
       endforeach
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 4e7584df667..48bd92bd618 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -7,15 +7,6 @@
 import shlex
 import subprocess
 
-def find_command(src, target, compile_commands):
-    for command in compile_commands:
-        if command['file'] != src:
-            continue
-        if target != '' and command['command'].find(target) == -1:
-            continue
-        return command['command']
-    return 'false'
-
 def process_command(src, command):
     skip = False
     out = []
@@ -43,14 +34,22 @@ def main(args):
         print("MODINFO_DEBUG target %s" % target)
         arch = target[:-8] # cut '-softmmu'
         print("MODINFO_START arch \"%s\" MODINFO_END" % arch)
+
     with open('compile_commands.json') as f:
-        compile_commands = json.load(f)
-    for src in args:
+        compile_commands_json = json.load(f)
+    compile_commands = { x['output']: x for x in compile_commands_json }
+
+    for obj in args:
+        entry = compile_commands.get(obj, None)
+        if not entry:
+            sys.stderr.print('modinfo: Could not find object file', obj)
+            sys.exit(1)
+        src = entry['file']
         if not src.endswith('.c'):
             print("MODINFO_DEBUG skip %s" % src)
             continue
+        command = entry['command']
         print("MODINFO_DEBUG src %s" % src)
-        command = find_command(src, target, compile_commands)
         cmdline = process_command(src, command)
         print("MODINFO_DEBUG cmd", cmdline)
         result = subprocess.run(cmdline, stdout = subprocess.PIPE,
-- 
2.49.0


