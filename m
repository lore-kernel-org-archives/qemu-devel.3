Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB87C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OJ-0002ko-4f; Tue, 12 Mar 2024 15:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OH-0002jy-3F
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OF-0005I0-Hv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtHopwqj2zSve6yzyGJpkD7D5xz3ETDg+5TwNbJVrqw=;
 b=TKJRAzY3uZgkNZRojF4kzpbE9naK+Dy3Rd2LQ+e2LH3b6DzncjB2QVl20CfLjBjszH958S
 XfiM0iA6KVtGu9RXXEt/P4hlWLrvEVfHIvQRPFd7lIWq5JawgeuHV44BC0tlOmmwHycgq3
 TKpDBWaYuPvV+yIg2gx9Za6D3xw3+1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-BF7NpRT_O-SUrbwFUleAPQ-1; Tue, 12 Mar 2024 15:02:17 -0400
X-MC-Unique: BF7NpRT_O-SUrbwFUleAPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C023C87A38C;
 Tue, 12 Mar 2024 19:02:16 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC7B2492BC6;
 Tue, 12 Mar 2024 19:02:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 2/2] meson: generate .stp files for tools too
Date: Tue, 12 Mar 2024 15:01:44 -0400
Message-ID: <20240312190144.433336-3-stefanha@redhat.com>
In-Reply-To: <20240312190144.433336-1-stefanha@redhat.com>
References: <20240312190144.433336-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qemu-img, qemu-io, qemu-nbd, qemu-storage-daemon tools all have
support for systemtap tracing built-in, so should be given corresponding
.stp files to define their probes.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20240108171356.1037059-3-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build | 61 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index b8d40d7c0a..520f862d7b 100644
--- a/meson.build
+++ b/meson.build
@@ -3808,6 +3808,7 @@ if host_os == 'darwin'
   entitlement = find_program('scripts/entitlement.sh')
 endif
 
+traceable = []
 emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
@@ -3976,27 +3977,11 @@ foreach target : target_dirs
       emulators += {exe['name']: emulator}
     endif
 
-    if stap.found()
-      foreach stp: [
-        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / exe['name'], 'install': false},
-        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / exe['name'], 'install': true},
-        {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
-        {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
-      ]
-        custom_target(exe['name'] + stp['ext'],
-                      input: trace_events_all,
-                      output: exe['name'] + stp['ext'],
-                      install: stp['install'],
-                      install_dir: get_option('datadir') / 'systemtap/tapset',
-                      command: [
-                        tracetool, '--group=all', '--format=' + stp['fmt'],
-                        '--binary=' + stp['bin'],
-                        '--probe-prefix=qemu.' + target_type + '.' + target_name,
-                        '@INPUT@', '@OUTPUT@'
-                      ],
-                      depend_files: tracetool_depends)
-      endforeach
-    endif
+    traceable += [{
+      'exe': exe['name'],
+      'probe-prefix': 'qemu.' + target_type + '.' + target_name,
+    }]
+
   endforeach
 endforeach
 
@@ -4031,6 +4016,14 @@ if have_tools
                install: true)
 
   subdir('storage-daemon')
+
+  foreach exe: [ 'qemu-img', 'qemu-io', 'qemu-nbd', 'qemu-storage-daemon']
+    traceable += [{
+      'exe': exe,
+      'probe-prefix': 'qemu.' + exe.substring(5).replace('-', '_')
+    }]
+  endforeach
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
@@ -4063,6 +4056,32 @@ if have_tools
   endif
 endif
 
+if stap.found()
+  foreach t: traceable
+    foreach stp: [
+      {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / t['exe'], 'install': false},
+      {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / t['exe'], 'install': true},
+      {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
+      {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
+    ]
+      cmd = [
+        tracetool, '--group=all', '--format=' + stp['fmt'],
+        '--binary=' + stp['bin'],
+        '--probe-prefix=' + t['probe-prefix'],
+        '@INPUT@', '@OUTPUT@'
+      ]
+
+      custom_target(t['exe'] + stp['ext'],
+                    input: trace_events_all,
+                    output: t['exe'] + stp['ext'],
+                    install: stp['install'],
+                    install_dir: get_option('datadir') / 'systemtap/tapset',
+                    command: cmd,
+                    depend_files: tracetool_depends)
+    endforeach
+  endforeach
+endif
+
 subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
-- 
2.44.0


