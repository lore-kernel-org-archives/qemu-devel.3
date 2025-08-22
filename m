Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5E5CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQre-0004s2-UL; Fri, 22 Aug 2025 08:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrd-0004r9-79
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrZ-0002Pr-4V
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMnLffocBY7PHzrcHweiZicabkSK14EqZ+PBp8wGPA8=;
 b=B/wVJf7JMRv5xEbkgR/im75r2v/NV2gn+UPNPZ/1mwV+4WnLAM0GmLF7rTMDofhQK/piz2
 7yvyS7Ca85UsKQW6Zi9q5msdivAmJ9N+jbu0acnBrg0zRbpnkONMX6dfdHmpU9HINOmV/I
 9h6OfE/TPCwcFNIoBhRHnESNWWXwszs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-EAPyysZ1Oq2s-tqYlR1qsw-1; Fri, 22 Aug 2025 08:27:17 -0400
X-MC-Unique: EAPyysZ1Oq2s-tqYlR1qsw-1
X-Mimecast-MFC-AGG-ID: EAPyysZ1Oq2s-tqYlR1qsw_1755865636
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e19dso117713f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865636; x=1756470436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMnLffocBY7PHzrcHweiZicabkSK14EqZ+PBp8wGPA8=;
 b=lN94Qw77ZsIlEpD3AD4Auq2Z2HQp9ArPC20EKsgis+brOGEcByhfHKUbtUIXXeVxxq
 OUUFlPAwZJgjA9V1BPyO2pZbUVUsfASQkRNtEsw6HWuOLCxWzXFAZQjChVZgZTJ6E6GN
 defpWwdV4p7Tn+/0To5j1uF2HcIjfsQuiAjvfWnn/RVHfnno8BjmRB49TXSTx4n3Pwtl
 fHym5NEUoiiYRdqpTV3BpiAhiFBoJjnvcpGefX8aEIbIdTfAhAanx+OXK3MPduWVhtX1
 29tsAVSNwO3i1LhoEFwnKdSKf1vRvem+/BHuNYMTqgkEH1g8AfoSpiWbE4XslN6r83DJ
 fMHw==
X-Gm-Message-State: AOJu0Ywm+TDwPnOs7NKMOzTonuh6eOg/Xb7JY42P3n6dLbZVXFzEJBM4
 +xZ/T3SgobkxztioEIYmJZvusPNeMM0dX7oCGn20KF9UGLyrGicdOcDGblNlmz5Kic2XCE/q9L4
 UbU/8S+9587rY5YBU/AjsCkQKoplmdEBf8hsEccqqGUBNSiRDaFO+zCnzG6hmamCEC+84d806Su
 VYvp2Q9/enS9jUTuMm0tquOz+SJMiiXJaRBosowb84
X-Gm-Gg: ASbGncui1I7pV9LRFtEqs92NFzt1Mwcxp779WEd2oMkD8/GqCc9dro+1vsRQsMlTeXG
 i3qZ5Mgb0hNlQnk3GNWAfgi95EvuN8RBL3AN6n0NCwR+sVfWgvu79xtd5i69Wnr4XIboMBDqBmV
 ovmOF7gR+uD+uW/aSLhiJRZXLyijkNqVpdT0wSalq7N3WJIUUavOBDKSqBJ2F+LQ/dFPJUcjkgz
 MjKAtOBP2c/PF6nwmyEpfvZJgnrUf5pQrJCoLKEGYIf+iel1SwEIgRs8Z+rhSn/tfio3OFTWQAg
 CMCQS+i2IbABPXzlih6E4y82owZNa6szjsgVCD5xGIogV1ZAvvhAeBlSylgVzSOqv93UjT8pWAd
 ug4MkKTXg8X7ydrTqO9eYab8dz4LGhnNhhDr0VdmG9g==
X-Received: by 2002:a05:6000:26d2:b0:3b7:99cb:16f6 with SMTP id
 ffacd0b85a97d-3c5dcdfc4d2mr2174920f8f.53.1755865635615; 
 Fri, 22 Aug 2025 05:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgGJQwDL8jaqwULb8PQqDOorxezE4HpdzhqV0BkZlWUcROuYsz7BycSzFatMjutPWYYkZnrg==
X-Received: by 2002:a05:6000:26d2:b0:3b7:99cb:16f6 with SMTP id
 ffacd0b85a97d-3c5dcdfc4d2mr2174886f8f.53.1755865635046; 
 Fri, 22 Aug 2025 05:27:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074e38d7dsm15165739f8f.26.2025.08.22.05.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 07/14] rust: add trace crate
Date: Fri, 22 Aug 2025 14:26:48 +0200
Message-ID: <20250822122655.1353197-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
[Write commit message. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock        |  4 ++++
 rust/Cargo.toml        |  1 +
 rust/meson.build       |  2 +-
 rust/trace/Cargo.toml  | 16 ++++++++++++++++
 rust/trace/meson.build | 19 +++++++++++++++++++
 rust/trace/src/lib.rs  | 23 +++++++++++++++++++++++
 trace/meson.build      |  8 +++++++-
 7 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b785c718f31..aa13ab2a99a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -164,6 +164,10 @@ dependencies = [
  "unicode-ident",
 ]
 
+[[package]]
+name = "trace"
+version = "0.1.0"
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 99c275f2d9f..2be9f886113 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -4,6 +4,7 @@ members = [
     "bits",
     "qemu-api-macros",
     "qemu-api",
+    "trace",
     "hw/char/pl011",
     "hw/timer/hpet",
 ]
diff --git a/rust/meson.build b/rust/meson.build
index 45936a0a731..2878bd8bc8d 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -23,7 +23,7 @@ genrs = []
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('qemu-api')
-
+subdir('trace')
 subdir('hw')
 
 cargo = find_program('cargo', required: false)
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
new file mode 100644
index 00000000000..913010e9787
--- /dev/null
+++ b/rust/trace/Cargo.toml
@@ -0,0 +1,16 @@
+[package]
+name = "trace"
+version = "0.1.0"
+authors = ["Tanish Desai<tanishdesai37@gmail.com>"]
+description = "rust trace library"
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
index 00000000000..9b931ddf1de
--- /dev/null
+++ b/rust/trace/src/lib.rs
@@ -0,0 +1,23 @@
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
+        mod trace {
+            #[cfg(not(MESON))]
+            include!(concat!(env!("MESON_BUILD_ROOT"), "/trace/", $name, ".rs"));
+
+            #[cfg(MESON)]
+            include!(concat!("@MESON_BUILD_ROOT@/trace/", $name, ".rs"));
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
2.50.1


