Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE07CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZG7-0001jE-Db; Fri, 19 Sep 2025 07:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZG4-0001iV-UD
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZG1-0001Do-JW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpl9n8Cm6uiDk/tvFICEPI9dtwQ58svqfVF0oD/eUJ0=;
 b=LdO65v3i3eB/P9FBT3r/rSV04I3kgImv8EwLUPRbOl5KXnBKIYM62OZe1IvIVyGml/Cfnq
 Ym9UiX84yoc/2y5aF83kB1X22lKRzNdVdgkqEfF+sqe1sFsXHla0vYZIEuC1NZLQeHo7sM
 y8Jvxc/zHSKjAsOQRmF7u7wJVCGMIvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-UMWHPSC0MEi686jCyDHUWg-1; Fri,
 19 Sep 2025 07:26:24 -0400
X-MC-Unique: UMWHPSC0MEi686jCyDHUWg-1
X-Mimecast-MFC-AGG-ID: UMWHPSC0MEi686jCyDHUWg_1758281183
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FEBF1800365; Fri, 19 Sep 2025 11:26:23 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C66430002C5; Fri, 19 Sep 2025 11:26:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 09/16] rust: add trace crate
Date: Fri, 19 Sep 2025 13:25:29 +0200
Message-ID: <20250919112536.141782-10-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

The trace crate is a minimal container for dependencies of tracepoints
(so that they do not have to be imported in all the crates that use
tracepoints); it also contains a macro called "include_trace!" that is
able to find the right include file from the trace/ directory.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
[Write commit message, add #[allow()]. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock        |  4 ++++
 rust/Cargo.toml        |  1 +
 rust/meson.build       |  2 +-
 rust/trace/Cargo.toml  | 16 ++++++++++++++++
 rust/trace/meson.build | 19 +++++++++++++++++++
 rust/trace/src/lib.rs  | 35 +++++++++++++++++++++++++++++++++++
 trace/meson.build      |  8 +++++++-
 7 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 8315f98c46f..3428dbaf0b3 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -258,6 +258,10 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "trace"
+version = "0.1.0"
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d8183c614d4..f372d7dbf70 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -11,6 +11,7 @@ members = [
     "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
+    "trace",
     "util",
     "tests",
 ]
diff --git a/rust/meson.build b/rust/meson.build
index b3ac3a71970..695d5a62de9 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -34,7 +34,7 @@ subdir('system')
 subdir('chardev')
 subdir('hw/core')
 subdir('tests')
-
+subdir('trace')
 subdir('hw')
 
 cargo = find_program('cargo', required: false)
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
new file mode 100644
index 00000000000..13ac0b33d6f
--- /dev/null
+++ b/rust/trace/Cargo.toml
@@ -0,0 +1,16 @@
+[package]
+name = "trace"
+version = "0.1.0"
+authors = ["Tanish Desai <tanishdesai37@gmail.com>"]
+description = "QEMU tracing infrastructure support"
+resolver = "2"
+publish = false
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lints]
+workspace = true
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
new file mode 100644
index 00000000000..adca57e5507
--- /dev/null
+++ b/rust/trace/meson.build
@@ -0,0 +1,19 @@
+rust = import('rust')
+
+lib_rs = configure_file(
+  input: 'src/lib.rs',
+  output: 'lib.rs',
+  configuration: {
+    'MESON_BUILD_ROOT': meson.project_build_root(),
+  })
+
+_trace_rs = static_library(
+  'trace',             # Library name,
+  lib_rs,
+  trace_rs_targets,         # List of generated `.rs` custom targets
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  dependencies: [libc_rs],
+  rust_abi: 'rust',
+)
+
+trace_rs = declare_dependency(link_with: _trace_rs)
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
new file mode 100644
index 00000000000..0955461573d
--- /dev/null
+++ b/rust/trace/src/lib.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! This crate provides macros that aid in using QEMU's tracepoint
+//! functionality.
+
+#[macro_export]
+/// Define the trace-points from the named directory (which should have slashes
+/// replaced by underscore characters) as functions in a module called `trace`.
+///
+/// ```ignore
+/// ::trace::include_trace!("hw_char");
+/// // ...
+/// trace::trace_pl011_read_fifo_rx_full();
+/// ```
+macro_rules! include_trace {
+    ($name:literal) => {
+        #[allow(
+            clippy::ptr_as_ptr,
+            clippy::cast_lossless,
+            clippy::used_underscore_binding
+        )]
+        mod trace {
+            #[cfg(not(MESON))]
+            include!(concat!(
+                env!("MESON_BUILD_ROOT"),
+                "/trace/trace-",
+                $name,
+                ".rs"
+            ));
+
+            #[cfg(MESON)]
+            include!(concat!("@MESON_BUILD_ROOT@/trace/trace-", $name, ".rs"));
+        }
+    };
+}
diff --git a/trace/meson.build b/trace/meson.build
index 9c42a57a053..d89a0db82a1 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,5 +1,5 @@
 system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
-
+trace_rs_targets = []
 trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   if item in qapi_trace_events
@@ -24,6 +24,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
                           input: trace_events_file,
                           command: [ tracetool, group, '--format=c', '@INPUT@', '@OUTPUT@' ],
                           depend_files: tracetool_depends)
+  trace_rs = custom_target(fmt.format('trace', 'rs'),
+                          output: fmt.format('trace', 'rs'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=rs', '@INPUT@', '@OUTPUT@' ],
+                          depend_files: tracetool_depends)
   if 'ust' in get_option('trace_backends')
     trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
                                 output: fmt.format('trace-ust', 'h'),
@@ -34,6 +39,7 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
     genh += trace_ust_h
   endif
   trace_ss.add(trace_h, trace_c)
+  trace_rs_targets += trace_rs
   if 'dtrace' in get_option('trace_backends')
     trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
                                  output: fmt.format('trace-dtrace', 'dtrace'),
-- 
2.51.0



