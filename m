Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7OH-0002kP-St; Tue, 12 Mar 2024 15:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OG-0002jV-7P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk7OE-0005Ht-KF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710270138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4iRu6lQv+QNbYf+gPPgoTuDCHvhZOlOXKTSWrZLOITw=;
 b=Gb6Z27aI+rrzYHl0Ji8XU75JIz7Vhvo5D7+/3eqypyjdZig0xd221J//DLOlTaZH/0nPje
 UJ/TIqYwsihVVjQSDS1eD22kt7qy0oLdt2PlZDJRn47gQGS4M2Qla6Ude58qlQMkrewQIx
 9DQw5Pom2pXbWSDpe21l4GZ/orzEJzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-P75w82q7NcqyUJw0CFATrQ-1; Tue, 12 Mar 2024 15:02:14 -0400
X-MC-Unique: P75w82q7NcqyUJw0CFATrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E217800262;
 Tue, 12 Mar 2024 19:02:14 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7300B1121337;
 Tue, 12 Mar 2024 19:02:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 1/2] tracetool: remove redundant --target-type / --target-name
 args
Date: Tue, 12 Mar 2024 15:01:43 -0400
Message-ID: <20240312190144.433336-2-stefanha@redhat.com>
In-Reply-To: <20240312190144.433336-1-stefanha@redhat.com>
References: <20240312190144.433336-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

The --target-type and --target-name args are used to construct
the default probe prefix if '--probe-prefix' is not given. The
meson.build will always pass '--probe-prefix', so the other args
are effectively redundant.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20240108171356.1037059-2-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.rst |  3 +--
 meson.build            |  2 --
 scripts/tracetool.py   | 24 +++++-------------------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
index d288480db1..043bed7fd0 100644
--- a/docs/devel/tracing.rst
+++ b/docs/devel/tracing.rst
@@ -357,8 +357,7 @@ probes::
 
     scripts/tracetool.py --backends=dtrace --format=stap \
                          --binary path/to/qemu-binary \
-                         --target-type system \
-                         --target-name x86_64 \
+                         --probe-prefix qemu.system.x86_64 \
                          --group=all \
                          trace-events-all \
                          qemu.stp
diff --git a/meson.build b/meson.build
index f9dbe7634e..b8d40d7c0a 100644
--- a/meson.build
+++ b/meson.build
@@ -3991,8 +3991,6 @@ foreach target : target_dirs
                       command: [
                         tracetool, '--group=all', '--format=' + stp['fmt'],
                         '--binary=' + stp['bin'],
-                        '--target-name=' + target_name,
-                        '--target-type=' + target_type,
                         '--probe-prefix=qemu.' + target_type + '.' + target_name,
                         '@INPUT@', '@OUTPUT@'
                       ],
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index ab7653a5ce..5de9ce96d3 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -44,12 +44,9 @@ def error_opt(msg = None):
     --help                   This help message.
     --list-backends          Print list of available backends.
     --check-backends         Check if the given backend is valid.
-    --binary <path>          Full path to QEMU binary.
-    --target-type <type>     QEMU emulator target type ('system' or 'user').
-    --target-name <name>     QEMU emulator target name.
-    --group <name>           Name of the event group
-    --probe-prefix <prefix>  Prefix for dtrace probe names
-                             (default: qemu-<target-type>-<target-name>).\
+    --binary <path>          Full path to QEMU binary (required for 'stap' backend).
+    --group <name>           Name of the event group.
+    --probe-prefix <prefix>  Prefix for dtrace probe names (required for 'stap' backend).
 """ % {
             "script" : _SCRIPT,
             "backends" : backend_descr,
@@ -67,7 +64,7 @@ def main(args):
 
     long_opts = ["backends=", "format=", "help", "list-backends",
                  "check-backends", "group="]
-    long_opts += ["binary=", "target-type=", "target-name=", "probe-prefix="]
+    long_opts += ["binary=", "probe-prefix="]
 
     try:
         opts, args = getopt.getopt(args[1:], "", long_opts)
@@ -79,8 +76,6 @@ def main(args):
     arg_format = ""
     arg_group = None
     binary = None
-    target_type = None
-    target_name = None
     probe_prefix = None
     for opt, arg in opts:
         if opt == "--help":
@@ -102,10 +97,6 @@ def main(args):
 
         elif opt == "--binary":
             binary = arg
-        elif opt == '--target-type':
-            target_type = arg
-        elif opt == '--target-name':
-            target_name = arg
         elif opt == '--probe-prefix':
             probe_prefix = arg
 
@@ -127,13 +118,8 @@ def main(args):
     if arg_format == "stap":
         if binary is None:
             error_opt("--binary is required for SystemTAP tapset generator")
-        if probe_prefix is None and target_type is None:
-            error_opt("--target-type is required for SystemTAP tapset generator")
-        if probe_prefix is None and target_name is None:
-            error_opt("--target-name is required for SystemTAP tapset generator")
-
         if probe_prefix is None:
-            probe_prefix = ".".join(["qemu", target_type, target_name])
+            error_opt("--probe-prefix is required for SystemTAP tapset generator")
 
     if len(args) < 2:
         error_opt("missing trace-events and output filepaths")
-- 
2.44.0


