Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6FFE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPYv-0000aY-UE; Wed, 11 Dec 2024 11:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYo-0008TQ-Kf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYm-0000Dz-Kr
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kc+3yZr1fEE4Vxs7y1Ixn7frgKT0doT0bC1xM2Vun5Y=;
 b=aj7vBrSy2Y/12++YY9pDuNBoN7gOuNCCFyOAgHrm4GpzMCJXtUmXwJRsIq/Q4kYtge0NRy
 6LWD4PvPi9zVATBlnAIDiH87xLYVLLDjznYRo9bD9voZfMSZbOEwcpCyLbgihE5XPbp4Gl
 iJpPXaqi5FwNH+vPMOinyXEHx9tZ//Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-mO4S-atpOYa4CJgOsniUDQ-1; Wed, 11 Dec 2024 11:27:34 -0500
X-MC-Unique: mO4S-atpOYa4CJgOsniUDQ-1
X-Mimecast-MFC-AGG-ID: mO4S-atpOYa4CJgOsniUDQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3861cd03a89so3250138f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934452; x=1734539252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kc+3yZr1fEE4Vxs7y1Ixn7frgKT0doT0bC1xM2Vun5Y=;
 b=Znpg+DK1CfiC/v+OfuG4D+tMf2OOZcPewq2neeJd6T4NGOnSAoELrF7QpqA7bQYdZY
 l+gPgZ9BpJqEtvTeCz6UNwwyypLmaLLqBCRjnHlTB988tx18LEyGMrbhSgQtX/PYyX3Y
 eXlE/s75Q8wBw/KD9bLiXE/sy2OuopYeA4MoRo5afW9xbYmuYibdt8pQXn2/J5piBaU+
 BhY67SVMdsv5RPETv+GOIl1EyisTLflSF1pB1TEC6RW2LqjdcSf3ehxYuHWm2JcNsryZ
 zc/FOYBxtV0cNmWFhsUIv8GZYfAJmp1SoIMnP6eFiugJEssy4ELMLRfjE6XPRDnHxjCy
 tCkQ==
X-Gm-Message-State: AOJu0Yzr5JcvXwV9DE3pl3vEq8YlAhhnVCSaXSkL7Z0XbhH1biNZSMZr
 uLTgJ23hzoXi6ofXl03DGjaA1OwSoofGdgDgBCaUBhOIYGnhqa3dutg62u1hR1R1V3xibzOoZqU
 s4WcTDq1oh+UD0hYIu3D/WPsjfBYR+5GtgNxIVVaWlRbpIVN1R0f6wRFlQP10WLKaYZmkNHDPMB
 1mGHXvshC3iefO2LM459ghQrBAU4O2mKAAvA33
X-Gm-Gg: ASbGncuhylw7mEcumP6Ttom50Rlau/qWVgC7WrptRPUkrEDRWdq8ORVNAurzUsqolTG
 I1gzvM/Y8syy2IucI3bNu32JLw8z/S5vHK47sn6D8gIEBL7TnYhzUZuyrdpK9ZmErdjCEECNbtr
 eIUaS3lm0lTZNnqm7EEfzwDY9ZjQRN/sd/uHERLBA7po4FrIFNE++0SW2izFqILYi/iZtCj+/OK
 N2/+Ojhw6Q0qdd0RH4JuPUDMk3bMGdKu+VjVIzO/5WgAvyY3IU+ZBDx
X-Received: by 2002:a05:6000:1fad:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-387876af7demr219735f8f.36.1733934452536; 
 Wed, 11 Dec 2024 08:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWVPZ0dEUNvTFXm4EY7w2EG3OqTg1SYd3ymQqxQ8jtlB+dr9UMyOrLBDJ6eed81aoOuVak/Q==
X-Received: by 2002:a05:6000:1fad:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-387876af7demr219710f8f.36.1733934452069; 
 Wed, 11 Dec 2024 08:27:32 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436178bd62dsm48509675e9.36.2024.12.11.08.27.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/49] rust: build: move rustc_args.py invocation to qemu-api
 crate
Date: Wed, 11 Dec 2024 17:26:34 +0100
Message-ID: <20241211162720.320070-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Only qemu-api needs access to the symbols in config-host.h.  Remove
the temptation to use them elsewhere by limiting the --cfg arguments to
the qemu-api crate.

Per-crate invocation of the script will also be needed to add --check-cfg
options for each crate's features (when more complex, build-time
configurable devices are added in the future).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 56 +++++++++++++++++----------------------
 rust/qemu-api/meson.build |  5 +++-
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/meson.build b/meson.build
index ea211c2dbb4..2f1f2aece4d 100644
--- a/meson.build
+++ b/meson.build
@@ -120,7 +120,30 @@ if have_rust
 endif
 
 if have_rust
+  rustc_args = find_program('scripts/rust/rustc_args.py')
   rustfmt = find_program('rustfmt', required: false)
+
+  # Prohibit code that is forbidden in Rust 2024
+  rustc_lint_args = ['-D', 'unsafe_op_in_unsafe_fn']
+
+  # Occasionally, we may need to silence warnings and clippy lints that
+  # were only introduced in newer Rust compiler versions.  Do not croak
+  # in that case; a CI job with rust_strict_lints == true ensures that
+  # we do not have misspelled allow() attributes.
+  if not get_option('strict_rust_lints')
+    rustc_lint_args += ['-A', 'unknown_lints']
+  endif
+
+  # Apart from procedural macros, our Rust executables will often link
+  # with C code, so include all the libraries that C code needs.  This
+  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
+  # passing -nodefaultlibs to the linker "was more ideological to
+  # start with than anything".
+  add_project_arguments(rustc_lint_args +
+      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
+      native: false, language: 'rust')
+  add_project_arguments(rustc_lint_args + ['--cfg', 'MESON'],
+      native: true, language: 'rust')
 endif
 
 dtrace = not_found
@@ -3399,37 +3422,8 @@ endif
 # Generated sources #
 #####################
 
-genh += configure_file(output: 'config-host.h', configuration: config_host_data)
-
-if have_rust
-  rustc_args = run_command(
-    find_program('scripts/rust/rustc_args.py'),
-    '--config-headers', meson.project_build_root() / 'config-host.h',
-    capture : true,
-    check: true).stdout().strip().split()
-
-  # Prohibit code that is forbidden in Rust 2024
-  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
-
-  # Occasionally, we may need to silence warnings and clippy lints that
-  # were only introduced in newer Rust compiler versions.  Do not croak
-  # in that case; a CI job with rust_strict_lints == true ensures that
-  # we do not have misspelled allow() attributes.
-  if not get_option('strict_rust_lints')
-    rustc_args += ['-A', 'unknown_lints']
-  endif
-
-  # Apart from procedural macros, our Rust executables will often link
-  # with C code, so include all the libraries that C code needs.  This
-  # is safe; https://github.com/rust-lang/rust/pull/54675 says that
-  # passing -nodefaultlibs to the linker "was more ideological to
-  # start with than anything".
-  add_project_arguments(rustc_args +
-      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
-      native: false, language: 'rust')
-  add_project_arguments(rustc_args + ['--cfg', 'MESON'],
-      native: true, language: 'rust')
-endif
+config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
+genh += config_host_h
 
 hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 3be7b7e5ced..5df6b35bf88 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,4 +1,7 @@
-_qemu_api_cfg = []
+_qemu_api_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h,
+  capture: true, check: true).stdout().strip().split()
+
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
-- 
2.47.1


