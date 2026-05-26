Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB815CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo2x-0007K7-A8; Tue, 26 May 2026 05:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2w-0007JZ-9b
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2t-0006wW-FD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEGdCbUofPtIcGQH3KB5wa2VZQM5oIMJXiQ94dNbrTU=;
 b=hkF7EPcoRTwNc3tKcLxHa3yUs5MOkVWwpECH8c17evZaLxMNqZjnuVJTfpO6GsHDRwLbIm
 Nh0XOlvbMhO0UHSUoSaNlhs6YODHQTSqbOUiurgjMJ7tlql7tjqsrn3W/pW1m717wbPYiw
 id4IcST3UfKfSLgLJG9hPWZBW5DT7tY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Bbd-OPdHOy6TFU6wlsAGDg-1; Tue, 26 May 2026 05:25:52 -0400
X-MC-Unique: Bbd-OPdHOy6TFU6wlsAGDg-1
X-Mimecast-MFC-AGG-ID: Bbd-OPdHOy6TFU6wlsAGDg_1779787552
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49045243094so57297975e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787552; x=1780392352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MEGdCbUofPtIcGQH3KB5wa2VZQM5oIMJXiQ94dNbrTU=;
 b=iBhMdb9O/eKlx+J37/VL0228ISvvSm44XkMrIvk1M+1lm2Df/uz0h7cCgSH7xRRfsg
 UlVnYYV5SR24+r6YbY/R4qM5JjndHoqRMY3lWzAeW5NQxgyb0GDJzHdGCNEh42tZN2rS
 9NQJBw5WqtZRkFWiBleXiolv6V3q1fePwphQ+T5Yma8NWqI1pOCOE8VNF7Yr69SUipv7
 etFd9QKkDdScR9sFl54fLz251aXz8D9wV+ELSwgS8oeKEZkbHnD3Tiaz4tPu7uZcfuh6
 SZ66Lex7s/RFf3J6PTh6MiII2Gfj9AKNyHz1O6wq9p4eQ9AgyO0q5BTSJUr3+zAhLIH9
 uk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787552; x=1780392352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MEGdCbUofPtIcGQH3KB5wa2VZQM5oIMJXiQ94dNbrTU=;
 b=aC/UYmP3I5i5MtBfJ/Df53ML8rAHum2sjLLyV9sOhszkWAyU41vydyuR0RM22miTZj
 DL6oO1mb5biDF6Es4U+SbbrO+IOWG2I34IX+S4Cpg/IP75G4DcFWkv4fRUwMH6XDvroB
 7ohtdo0Jmf7n1h70kUOEc6aFNeLyd5o/6Z57HJj2khWrjt0MFjIjV5Q0N0w5oc5h+fX9
 Mcqb4Vr6aojowS4BpIPxFDu5hQeUsdpVnHWWZjoSgdL6uAzuj+oyHLkOe/usS9/bfGV4
 +tjotX1M7EzohHLpSxmbgUZ+HP4UQk+KX4p9iL99dED/kH4+2bU3SpitzAd5idx9Jlmb
 1YnA==
X-Gm-Message-State: AOJu0YwWScRuhwIBw+F7BAejgCD/h08nV7HUpcjYdwRWbpOJCDjtTqW7
 JkqNkqLcD+o4HJ6G5WYQ0icUoRjLNIM7hMZDNhyz/QXU4sg6NH45b+LNV27tE86L8GvN8pODTOJ
 m+CYQldlLVYiYFEGwPUUYn0pJzx3U4tHCzSqeP20hN7m0N2tzre74o9SZcVhbWqZkXHUjy5iU9z
 tiuRLLu37e5Ah4BuI+jXEXGnFqtrakWB3pnbEWS09J
X-Gm-Gg: Acq92OG4+TlTTwmki/wbCKu8kNH+hhZhMq8wi6fFS0e4I114Rg+lpTyIGFEaSVbarc3
 FPqKz6eRsxWl1fTY8mQJJ05PnLC9/6f1z+iZ5xPzzmPfjn61z0qoJY5wylfxXgtGwEj6bvVt0hx
 b8rw171SyLMMuv1BD6/mujSiblPxSN5hUiSzqBEsjGh2xYHVjMvVCYmAFaVQe2J5Q//gPNAZV0g
 cOgz710U1c7OiXMJNPtVE5ITXGi5DJ1lz02n9CoToYLpG/FsuwEAafJOAjM5meZpt0CMjAVWekF
 e8L9rEYCbzf4FUxOAo4OgJImFadgXLUo3YRDmfzmEimUVzqW/Eq3E6WYVGtla5wmfNymAyrdrz/
 xWE054Bgyb7VyGq4insKc1yt6Alu88beBkzjT7YyE95MO9G4ZSouRq/LBvGKQAuIZafnXpV4OUj
 aE3sQvlab53yFAmJCoExhUfCvZoMo=
X-Received: by 2002:a05:600c:5288:b0:490:50e8:45c3 with SMTP id
 5b1f17b1804b1-49050e846f9mr226346705e9.0.1779787551469; 
 Tue, 26 May 2026 02:25:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:490:50e8:45c3 with SMTP id
 5b1f17b1804b1-49050e846f9mr226345545e9.0.1779787550562; 
 Tue, 26 May 2026 02:25:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b7d57sm307668755e9.15.2026.05.26.02.25.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] rust: switch to cargo subprojects
Date: Tue, 26 May 2026 11:25:41 +0200
Message-ID: <20260526092546.149241-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let Meson parse Cargo.lock and Cargo.toml and figure out the set
of Rust build dependencies.  For now, the only change is that
subprojects are retrieved with "cargo_ws.subproject('NAME')"
instead of "subproject('NAME-API-rs')".  However, just calling
"import('rust').workspace()" enables extra functionality that
operates by parsing Cargo.toml; it will be introduced a step
at a time in subsequent commits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                                 |  3 +-
 rust/Cargo.lock => Cargo.lock               |  0
 rust/Cargo.toml => Cargo.toml               |  6 +--
 rust/meson.build                            | 43 +++++++--------------
 subprojects/anyhow-1-rs.wrap                |  5 ++-
 subprojects/arbitrary-int-1-rs.wrap         |  2 +-
 subprojects/attrs-0.2-rs.wrap               |  5 ++-
 subprojects/bilge-0.2-rs.wrap               |  2 +-
 subprojects/bilge-impl-0.2-rs.wrap          |  4 +-
 subprojects/either-1-rs.wrap                |  4 +-
 subprojects/foreign-0.3-rs.wrap             |  5 ++-
 subprojects/glib-sys-0.21-rs.wrap           |  5 ++-
 subprojects/itertools-0.11-rs.wrap          |  4 +-
 subprojects/libc-0.2-rs.wrap                |  2 +-
 subprojects/probe-0.5-rs.wrap               |  5 ++-
 subprojects/proc-macro-error-1-rs.wrap      |  4 +-
 subprojects/proc-macro-error-attr-1-rs.wrap |  4 +-
 subprojects/proc-macro2-1-rs.wrap           |  4 +-
 subprojects/quote-1-rs.wrap                 |  4 +-
 subprojects/serde-1-rs.wrap                 |  4 +-
 subprojects/serde_core-1-rs.wrap            |  4 +-
 subprojects/serde_derive-1-rs.wrap          |  4 +-
 subprojects/syn-2-rs.wrap                   |  4 +-
 subprojects/unicode-ident-1-rs.wrap         |  4 +-
 24 files changed, 66 insertions(+), 65 deletions(-)
 rename rust/Cargo.lock => Cargo.lock (100%)
 rename rust/Cargo.toml => Cargo.toml (97%)

diff --git a/meson.build b/meson.build
index c265a00aed6..91d74fa198c 100644
--- a/meson.build
+++ b/meson.build
@@ -130,7 +130,8 @@ endif
 if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
     '--rustc-version', rustc.version(),
-    '--workspace', meson.project_source_root() / 'rust']
+    '--workspace', meson.project_source_root()]
+
   rustfmt = find_program('rustfmt', required: false)
 
   rustc_lint_args = run_command(rustc_args, '--lints',
diff --git a/rust/Cargo.lock b/Cargo.lock
similarity index 100%
rename from rust/Cargo.lock
rename to Cargo.lock
diff --git a/rust/Cargo.toml b/Cargo.toml
similarity index 97%
rename from rust/Cargo.toml
rename to Cargo.toml
index 15296ac8636..6bd38e2d8e1 100644
--- a/rust/Cargo.toml
+++ b/Cargo.toml
@@ -1,9 +1,9 @@
 [workspace]
 resolver = "2"
 members = [
-    "hw/char/pl011",
-    "hw/timer/hpet",
-    "tests",
+    "rust/hw/char/pl011",
+    "rust/hw/timer/hpet",
+    "rust/tests",
 ]
 
 [workspace.package]
diff --git a/rust/meson.build b/rust/meson.build
index 96e93f56e22..d580c7cbeef 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -4,35 +4,20 @@ else
   message('Rust enabled but it is only used by system emulators.')
 endif
 
-subproject('anyhow-1-rs', required: true)
-subproject('bilge-0.2-rs', required: true)
-subproject('bilge-impl-0.2-rs', required: true)
-subproject('foreign-0.3-rs', required: true)
-subproject('glib-sys-0.21-rs', required: true)
-subproject('libc-0.2-rs', required: true)
-subproject('probe-0.5-rs', required: true)
-subproject('serde-1-rs', required: true)
-subproject('serde_derive-1-rs', required: true)
-
-anyhow_rs = dependency('anyhow-1-rs')
-bilge_rs = dependency('bilge-0.2-rs')
-bilge_impl_rs = dependency('bilge-impl-0.2-rs')
-foreign_rs = dependency('foreign-0.3-rs')
-glib_sys_rs = dependency('glib-sys-0.21-rs')
-libc_rs = dependency('libc-0.2-rs')
-probe_rs = dependency('probe-0.5-rs')
-serde_rs = dependency('serde-1-rs')
-serde_derive_rs = dependency('serde_derive-1-rs', native: true)
-
-subproject('proc-macro2-1-rs', required: true)
-subproject('quote-1-rs', required: true)
-subproject('syn-2-rs', required: true)
-subproject('attrs-0.2-rs', required: true)
-
-quote_rs_native = dependency('quote-1-rs', native: true)
-syn_rs_native = dependency('syn-2-rs', native: true)
-proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
-attrs_rs_native = dependency('attrs-0.2-rs', native: true)
+cargo_ws = import('rust').workspace()
+anyhow_rs = cargo_ws.subproject('anyhow').dependency()
+bilge_rs = cargo_ws.subproject('bilge').dependency()
+bilge_impl_rs = cargo_ws.subproject('bilge-impl').dependency()
+foreign_rs = cargo_ws.subproject('foreign').dependency()
+glib_sys_rs = cargo_ws.subproject('glib-sys').dependency()
+libc_rs = cargo_ws.subproject('libc').dependency()
+probe_rs = cargo_ws.subproject('probe').dependency()
+serde_rs = cargo_ws.subproject('serde').dependency()
+serde_derive_rs = cargo_ws.subproject('serde_derive').dependency()
+quote_rs_native = cargo_ws.subproject('quote').dependency()
+syn_rs_native = cargo_ws.subproject('syn').dependency()
+proc_macro2_rs_native = cargo_ws.subproject('proc-macro2').dependency()
+attrs_rs_native = cargo_ws.subproject('attrs').dependency()
 
 genrs = []
 
diff --git a/subprojects/anyhow-1-rs.wrap b/subprojects/anyhow-1-rs.wrap
index a69a3645b49..132c70c467e 100644
--- a/subprojects/anyhow-1-rs.wrap
+++ b/subprojects/anyhow-1-rs.wrap
@@ -3,5 +3,8 @@ directory = anyhow-1.0.98
 source_url = https://crates.io/api/v1/crates/anyhow/1.0.98/download
 source_filename = anyhow-1.0.98.tar.gz
 source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
-#method = cargo
+method = cargo
 patch_directory = anyhow-1-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
index a1838b20b0f..f8d7c68da64 100644
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ b/subprojects/arbitrary-int-1-rs.wrap
@@ -3,7 +3,7 @@ directory = arbitrary-int-1.2.7
 source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
 source_filename = arbitrary-int-1.2.7.tar.gz
 source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
-#method = cargo
+method = cargo
 patch_directory = arbitrary-int-1-rs
 
 # bump this version number on every change to meson.build or the patches:
diff --git a/subprojects/attrs-0.2-rs.wrap b/subprojects/attrs-0.2-rs.wrap
index cd43c91d63e..99d2e43fb3b 100644
--- a/subprojects/attrs-0.2-rs.wrap
+++ b/subprojects/attrs-0.2-rs.wrap
@@ -3,5 +3,8 @@ directory = attrs-0.2.9
 source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
 source_filename = attrs-0.2.9.tar.gz
 source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
-#method = cargo
+method = cargo
 patch_directory = attrs-0.2-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
index 900bb1497b9..cb202cfd9fe 100644
--- a/subprojects/bilge-0.2-rs.wrap
+++ b/subprojects/bilge-0.2-rs.wrap
@@ -3,7 +3,7 @@ directory = bilge-0.2.0
 source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
 source_filename = bilge-0.2.0.tar.gz
 source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
-#method = cargo
+method = cargo
 patch_directory = bilge-0.2-rs
 
 # bump this version number on every change to meson.build or the patches:
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index 4f84eca1ccd..e423b6cec66 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -3,8 +3,8 @@ directory = bilge-impl-0.2.0
 source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
 source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
-#method = cargo
+method = cargo
 patch_directory = bilge-impl-0.2-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
index 352e11cfee6..b70787d882e 100644
--- a/subprojects/either-1-rs.wrap
+++ b/subprojects/either-1-rs.wrap
@@ -3,8 +3,8 @@ directory = either-1.12.0
 source_url = https://crates.io/api/v1/crates/either/1.12.0/download
 source_filename = either-1.12.0.tar.gz
 source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
-#method = cargo
+method = cargo
 patch_directory = either-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
index 0d218ec2c25..bae22b1f2a3 100644
--- a/subprojects/foreign-0.3-rs.wrap
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -3,5 +3,8 @@ directory = foreign-0.3.1
 source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
 source_filename = foreign-0.3.1.tar.gz
 source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
-#method = cargo
+method = cargo
 patch_directory = foreign-0.3-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
index 313ced731ac..af849352a38 100644
--- a/subprojects/glib-sys-0.21-rs.wrap
+++ b/subprojects/glib-sys-0.21-rs.wrap
@@ -3,5 +3,8 @@ directory = glib-sys-0.21.2
 source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
 source_filename = glib-sys-0.21.2.tar.gz
 source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
-#method = cargo
+method = cargo
 patch_directory = glib-sys-0.21-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
index ee12d0053bc..b52a2314340 100644
--- a/subprojects/itertools-0.11-rs.wrap
+++ b/subprojects/itertools-0.11-rs.wrap
@@ -3,8 +3,8 @@ directory = itertools-0.11.0
 source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
 source_filename = itertools-0.11.0.tar.gz
 source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
-#method = cargo
+method = cargo
 patch_directory = itertools-0.11-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
index bbe08f87883..488330178ed 100644
--- a/subprojects/libc-0.2-rs.wrap
+++ b/subprojects/libc-0.2-rs.wrap
@@ -3,5 +3,5 @@ directory = libc-0.2.162
 source_url = https://crates.io/api/v1/crates/libc/0.2.162/download
 source_filename = libc-0.2.162.tar.gz
 source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
-#method = cargo
+method = cargo
 patch_directory = libc-0.2-rs
diff --git a/subprojects/probe-0.5-rs.wrap b/subprojects/probe-0.5-rs.wrap
index 73229ee1c29..bd23c0ea789 100644
--- a/subprojects/probe-0.5-rs.wrap
+++ b/subprojects/probe-0.5-rs.wrap
@@ -3,5 +3,8 @@ directory = probe-0.5.2
 source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
 source_filename = probe-0.5.2.tar.gz
 source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
-#method = cargo
+method = cargo
 patch_directory = probe-0.5-rs
+
+# bump this version number on every change to meson.build or the patches:
+# v1
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
index 59f892f7825..e57921bfadc 100644
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ b/subprojects/proc-macro-error-1-rs.wrap
@@ -3,8 +3,8 @@ directory = proc-macro-error-1.0.4
 source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
 source_filename = proc-macro-error-1.0.4.tar.gz
 source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
-#method = cargo
+method = cargo
 patch_directory = proc-macro-error-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
index 5aeb224a103..02d18f3393d 100644
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ b/subprojects/proc-macro-error-attr-1-rs.wrap
@@ -3,8 +3,8 @@ directory = proc-macro-error-attr-1.0.4
 source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
 source_filename = proc-macro-error-attr-1.0.4.tar.gz
 source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
-#method = cargo
+method = cargo
 patch_directory = proc-macro-error-attr-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 0f06cd8e111..676d1a3a8ca 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -3,8 +3,8 @@ directory = proc-macro2-1.0.95
 source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.95/download
 source_filename = proc-macro2-1.0.95.0.tar.gz
 source_hash = 02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778
-#method = cargo
+method = cargo
 patch_directory = proc-macro2-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
index 8b721dfa00b..dab58490a4f 100644
--- a/subprojects/quote-1-rs.wrap
+++ b/subprojects/quote-1-rs.wrap
@@ -3,8 +3,8 @@ directory = quote-1.0.36
 source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
 source_filename = quote-1.0.36.0.tar.gz
 source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
-#method = cargo
+method = cargo
 patch_directory = quote-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/serde-1-rs.wrap b/subprojects/serde-1-rs.wrap
index 56746dd0f43..9792592d480 100644
--- a/subprojects/serde-1-rs.wrap
+++ b/subprojects/serde-1-rs.wrap
@@ -3,9 +3,9 @@ directory = serde-1.0.226
 source_url = https://crates.io/api/v1/crates/serde/1.0.226/download
 source_filename = serde-1.0.226.0.tar.gz
 source_hash = 0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd
-#method = cargo
+method = cargo
 diff_files = serde-1.0.226-include.patch
 patch_directory = serde-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v1
+# v2
diff --git a/subprojects/serde_core-1-rs.wrap b/subprojects/serde_core-1-rs.wrap
index 3692e754935..ff2e59430b1 100644
--- a/subprojects/serde_core-1-rs.wrap
+++ b/subprojects/serde_core-1-rs.wrap
@@ -3,9 +3,9 @@ directory = serde_core-1.0.226
 source_url = https://crates.io/api/v1/crates/serde_core/1.0.226/download
 source_filename = serde_core-1.0.226.0.tar.gz
 source_hash = ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4
-#method = cargo
+method = cargo
 diff_files = serde_core-1.0.226-include.patch
 patch_directory = serde_core-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v1
+# v2
diff --git a/subprojects/serde_derive-1-rs.wrap b/subprojects/serde_derive-1-rs.wrap
index 00c92dc79cf..ed345a7f840 100644
--- a/subprojects/serde_derive-1-rs.wrap
+++ b/subprojects/serde_derive-1-rs.wrap
@@ -3,9 +3,9 @@ directory = serde_derive-1.0.226
 source_url = https://crates.io/api/v1/crates/serde_derive/1.0.226/download
 source_filename = serde_derive-1.0.226.0.tar.gz
 source_hash = 8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33
-#method = cargo
+method = cargo
 diff_files = serde_derive-1.0.226-include.patch
 patch_directory = serde_derive-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v1
+# v2
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index 1e5e9d9fb6e..4b545c7980c 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -3,8 +3,8 @@ directory = syn-2.0.104
 source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
 source_filename = syn-2.0.104.0.tar.gz
 source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
-#method = cargo
+method = cargo
 patch_directory = syn-2-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
index 50988f612e2..0a5e097953e 100644
--- a/subprojects/unicode-ident-1-rs.wrap
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -3,8 +3,8 @@ directory = unicode-ident-1.0.12
 source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
 source_filename = unicode-ident-1.0.12.tar.gz
 source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
-#method = cargo
+method = cargo
 patch_directory = unicode-ident-1-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v2
+# v3
-- 
2.54.0


