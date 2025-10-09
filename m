Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73861CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQP-0008DA-Jn; Thu, 09 Oct 2025 03:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQN-0008Bq-4B
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQG-0004K3-4s
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPWy9bRouIhDhdR+H4atS/CyKCnP4sSU4Jekx5brY74=;
 b=Dwl0lSyqQYEojCwC+Ks+KQa22jMHIBdHqyRBqR87wnZ+NNOtvEexJsyIEef7G049E1YoC9
 ipi5PtR/yU5Obi+yXVxC80nEaAQtKzQDvzf2njSk2a5cKSEosWO+oT8/B+Q+8BJQS19EcD
 kC5i9hAaezQgVlvzKSEQTNFuD2AKFGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-I3NftokhOXuXmbQ7RC6hXw-1; Thu, 09 Oct 2025 03:50:36 -0400
X-MC-Unique: I3NftokhOXuXmbQ7RC6hXw-1
X-Mimecast-MFC-AGG-ID: I3NftokhOXuXmbQ7RC6hXw_1759996235
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e377d8c80so2540885e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996234; x=1760601034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPWy9bRouIhDhdR+H4atS/CyKCnP4sSU4Jekx5brY74=;
 b=PQfRVjmqF6dHcdmEKL82xHy29kVKi5JX3xnobwBVqaHjFivk+lhj5ZUfdcjDqryzmE
 i8PUzHMZUCcRhP32+1BlWUpw6xpFw0cRDDkR6mGYMGrOHowDSUrLB2Ypw2pOg0JHw6PL
 G6UJNKrRwG5qS1SJJwXbjp0iaOo2anz4sBZcb/FLtGpI3ovYQp8k2CgNuO+rWKWJ8fRE
 7g28GT6YqQ9aIdvhxiEUntXO+QabGkd93LKTiqtx+DuoFCG5H90Im5Lm3HREAmLj2DMX
 TrWQ5ldq4r6W0tvFrUUCgwA9DmXl7Vl34fG4jhLZieDZhSgfmOuGlHePXMwlxdKizJvl
 UNQw==
X-Gm-Message-State: AOJu0YydHUvE7llG2lfC0q8w043ZCnCTjytV3FxKJWInxUhg7aBWKzMB
 cLRWYYNGmQr8/SNUF1v4U2S/OLwUjZ77MxYMNByTxm21IUlBqpP9QvN+b9M1PsoBjpZbAmkFZ9I
 7FiTJ4HHRlwK64KTOmLXEVn5S0r+23fuVTDMZcQST7MTSWgWyuuWC2bbGZfJkLR9DxdKFiO+0lA
 B58136W3irJlZANev8aaMfpEYWCG/2GkmcJ017Kn2kz4s=
X-Gm-Gg: ASbGncuCTHKsRJnNv5Zp6DWSwjcohavWnYSHYxj3zxANte62tJWby+29K9B8G5P+KKr
 yVwbw+U3/Qo+DNQ93o8FDo5qcgmdf5d7pTTbuuvNa3iRHm98bppp+hMOjh5ujgPmzFi8g+SrxqX
 JakI2YuCHxKRZXiIU4W9O4URkXocdredAXSKU6BG4ACsP0rbzDLp5b5wBWyu2rUuq33N3g9v/6s
 XCyTfHSHuzPRTKGg/ftDycc1UjQfE9vwFxzk2LiQc3m01Hy40w4o1GujygMfG66Mrd7evD/FZRH
 cFrSoX1Tw123Ozu0TX8kG5bAy+JV/Xci3BeiMHDk3mK4DnB6ZjqpHNVU0pokns1fNesX1z02BjV
 3frOwD8X1M5CvYKZ3RxWR2U+pMnOi9B5jDUDljVvQ51x2MBpS
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr41433755e9.23.1759996233888; 
 Thu, 09 Oct 2025 00:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo51EeFREj2ziGMhNzdELyPB/pTtwXzQ807Q0o7m8VNO4pyoCJbb+X9/d962WbDmEOLjJYRg==
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr41433535e9.23.1759996233265; 
 Thu, 09 Oct 2025 00:50:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01absm33145877f8f.44.2025.10.09.00.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/35] rust: use glib-sys
Date: Thu,  9 Oct 2025 09:49:53 +0200
Message-ID: <20251009075026.505715-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Don't generate FFI for glib, rely on glib-sys crate.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                        |   1 +
 include/hw/core/cpu.h              |   2 +-
 rust/Cargo.lock                    | 180 +++++++++++++++++++++++++++++
 rust/Cargo.toml                    |   1 +
 rust/bql/Cargo.toml                |   1 +
 rust/bql/meson.build               |   1 +
 rust/bql/src/bindings.rs           |   4 +
 rust/chardev/Cargo.toml            |   1 +
 rust/chardev/meson.build           |   2 +-
 rust/chardev/src/bindings.rs       |   4 +
 rust/hw/char/pl011/Cargo.toml      |   1 +
 rust/hw/char/pl011/meson.build     |   1 +
 rust/hw/char/pl011/src/bindings.rs |   5 +
 rust/hw/core/Cargo.toml            |   1 +
 rust/hw/core/meson.build           |   2 +-
 rust/hw/core/src/bindings.rs       |   3 +
 rust/migration/Cargo.toml          |   1 +
 rust/migration/meson.build         |   2 +-
 rust/migration/src/bindings.rs     |   1 +
 rust/qom/Cargo.toml                |   1 +
 rust/qom/meson.build               |   2 +-
 rust/qom/src/bindings.rs           |   2 +
 rust/system/Cargo.toml             |   1 +
 rust/system/meson.build            |   2 +-
 rust/system/src/bindings.rs        |   4 +
 rust/util/Cargo.toml               |   1 +
 rust/util/meson.build              |   2 +-
 rust/util/src/bindings.rs          |   2 +
 28 files changed, 224 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 55c8202a4d8..62766c0f19c 100644
--- a/meson.build
+++ b/meson.build
@@ -4239,6 +4239,7 @@ if have_rust
     '--no-prepend-enum-name',
     '--allowlist-file', meson.project_source_root() + '/include/.*',
     '--allowlist-file', meson.project_build_root() + '/.*',
+    '--blocklist-file', glib_pc.get_variable('includedir') + '/glib-2.0/.*',
     ]
   if not rustfmt.found()
     if bindgen.version().version_compare('<0.65.0')
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9f40c25392..4196293ba1c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -169,7 +169,7 @@ struct CPUClass {
     vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
 
     const char *gdb_core_xml_file;
-    const gchar * (*gdb_arch_name)(CPUState *cpu);
+    const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 444ef516a70..11085133490 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -58,15 +58,27 @@ dependencies = [
 name = "bql"
 version = "0.1.0"
 dependencies = [
+ "glib-sys",
  "migration",
 ]
 
+[[package]]
+name = "cfg-expr"
+version = "0.20.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1a2c5f3bf25ec225351aa1c8e230d04d880d3bd89dea133537dafad4ae291e5c"
+dependencies = [
+ "smallvec",
+ "target-lexicon",
+]
+
 [[package]]
 name = "chardev"
 version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "glib-sys",
  "migration",
  "qom",
  "util",
@@ -86,6 +98,12 @@ version = "1.12.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
 
+[[package]]
+name = "equivalent"
+version = "1.0.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+
 [[package]]
 name = "foreign"
 version = "0.3.1"
@@ -95,6 +113,28 @@ dependencies = [
  "libc",
 ]
 
+[[package]]
+name = "glib-sys"
+version = "0.21.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1"
+dependencies = [
+ "libc",
+ "system-deps",
+]
+
+[[package]]
+name = "hashbrown"
+version = "0.16.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
+
+[[package]]
+name = "heck"
+version = "0.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+
 [[package]]
 name = "hpet"
 version = "0.1.0"
@@ -115,6 +155,7 @@ dependencies = [
  "bql",
  "chardev",
  "common",
+ "glib-sys",
  "migration",
  "qemu_macros",
  "qom",
@@ -122,6 +163,16 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "indexmap"
+version = "2.11.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4b0f83760fb341a774ed326568e19f5a863af4a952def8c39f9ab92fd95b88e5"
+dependencies = [
+ "equivalent",
+ "hashbrown",
+]
+
 [[package]]
 name = "itertools"
 version = "0.11.0"
@@ -137,14 +188,27 @@ version = "0.2.162"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 
+[[package]]
+name = "memchr"
+version = "2.7.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f52b00d39961fc5b2736ea853c9cc86238e165017a493d1d5c8eac6bdc4cc273"
+
 [[package]]
 name = "migration"
 version = "0.1.0"
 dependencies = [
  "common",
+ "glib-sys",
  "util",
 ]
 
+[[package]]
+name = "pkg-config"
+version = "0.3.32"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+
 [[package]]
 name = "pl011"
 version = "0.1.0"
@@ -155,6 +219,7 @@ dependencies = [
  "bql",
  "chardev",
  "common",
+ "glib-sys",
  "hwcore",
  "migration",
  "qom",
@@ -211,6 +276,7 @@ version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "glib-sys",
  "migration",
  "qemu_macros",
  "util",
@@ -225,6 +291,50 @@ dependencies = [
  "proc-macro2",
 ]
 
+[[package]]
+name = "serde"
+version = "1.0.226"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd"
+dependencies = [
+ "serde_core",
+]
+
+[[package]]
+name = "serde_core"
+version = "1.0.226"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4"
+dependencies = [
+ "serde_derive",
+]
+
+[[package]]
+name = "serde_derive"
+version = "1.0.226"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "serde_spanned"
+version = "0.6.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
+dependencies = [
+ "serde",
+]
+
+[[package]]
+name = "smallvec"
+version = "1.15.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
+
 [[package]]
 name = "syn"
 version = "2.0.104"
@@ -241,10 +351,30 @@ name = "system"
 version = "0.1.0"
 dependencies = [
  "common",
+ "glib-sys",
  "qom",
  "util",
 ]
 
+[[package]]
+name = "system-deps"
+version = "7.0.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e4be53aa0cba896d2dc615bd42bbc130acdcffa239e0a2d965ea5b3b2a86ffdb"
+dependencies = [
+ "cfg-expr",
+ "heck",
+ "pkg-config",
+ "toml",
+ "version-compare",
+]
+
+[[package]]
+name = "target-lexicon"
+version = "0.13.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e502f78cdbb8ba4718f566c418c52bc729126ffd16baee5baa718cf25dd5a69a"
+
 [[package]]
 name = "tests"
 version = "0.1.0"
@@ -259,6 +389,40 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "toml"
+version = "0.8.23"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc1beb996b9d83529a9e75c17a1686767d148d70663143c7854d8b4a09ced362"
+dependencies = [
+ "serde",
+ "serde_spanned",
+ "toml_datetime",
+ "toml_edit",
+]
+
+[[package]]
+name = "toml_datetime"
+version = "0.6.11"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "22cddaf88f4fbc13c51aebbf5f8eceb5c7c5a9da2ac40a13519eb5b0a0e8f11c"
+dependencies = [
+ "serde",
+]
+
+[[package]]
+name = "toml_edit"
+version = "0.22.27"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41fe8c660ae4257887cf66394862d21dbca4a6ddd26f04a3560410406a2f819a"
+dependencies = [
+ "indexmap",
+ "serde",
+ "serde_spanned",
+ "toml_datetime",
+ "winnow",
+]
+
 [[package]]
 name = "trace"
 version = "0.1.0"
@@ -279,11 +443,27 @@ dependencies = [
  "anyhow",
  "common",
  "foreign",
+ "glib-sys",
  "libc",
 ]
 
+[[package]]
+name = "version-compare"
+version = "0.2.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "852e951cb7832cb45cb1169900d19760cfa39b82bc0ea9c0e5a14ae88411c98b"
+
 [[package]]
 name = "version_check"
 version = "0.9.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+
+[[package]]
+name = "winnow"
+version = "0.7.13"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
+dependencies = [
+ "memchr",
+]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index f372d7dbf70..783e626802c 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -29,6 +29,7 @@ authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
+glib-sys = { version = "0.21.2", features = ["v2_66"] }
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
index 1041bd4ea93..d5177e5f8e2 100644
--- a/rust/bql/Cargo.toml
+++ b/rust/bql/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 migration = { path = "../migration" }
+glib-sys.workspace = true
 
 [features]
 default = ["debug_cell"]
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index bc51c7f160b..22d7c9b8776 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -38,6 +38,7 @@ _bql_rs = static_library(
   rust_abi: 'rust',
   rust_args: _bql_cfg,
   link_with: [_migration_rs],
+  dependencies: [glib_sys_rs],
 )
 
 bql_rs = declare_dependency(link_with: [_bql_rs],
diff --git a/rust/bql/src/bindings.rs b/rust/bql/src/bindings.rs
index 9ffff12cded..8c70f3a87ce 100644
--- a/rust/bql/src/bindings.rs
+++ b/rust/bql/src/bindings.rs
@@ -18,6 +18,10 @@
     clippy::too_many_arguments
 )]
 
+use glib_sys::{
+    guint, GArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue, GSList, GSource,
+};
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index 3e77972546e..f105189dccb 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+glib-sys = { workspace = true }
 common = { path = "../common" }
 bql = { path = "../bql" }
 migration = { path = "../migration" }
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index e7ce02b3bc2..d365d8dd0f4 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -36,7 +36,7 @@ _chardev_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [common_rs, qemu_macros],
+  dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
 chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev, qemuutil])
diff --git a/rust/chardev/src/bindings.rs b/rust/chardev/src/bindings.rs
index 2d98026d627..c95dc89c56d 100644
--- a/rust/chardev/src/bindings.rs
+++ b/rust/chardev/src/bindings.rs
@@ -19,6 +19,10 @@
 )]
 
 use common::Zeroable;
+use glib_sys::{
+    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GList, GMainContext,
+    GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc,
+};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index dc41d0e499e..5b319455ee3 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+glib-sys.workspace = true
 bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 07b3da17e83..33b91f21911 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -33,6 +33,7 @@ _libpl011_rs = static_library(
     bilge_impl_rs,
     bits_rs,
     common_rs,
+    glib_sys_rs,
     util_rs,
     migration_rs,
     bql_rs,
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
index bd5ea840cb2..52a76d0de5c 100644
--- a/rust/hw/char/pl011/src/bindings.rs
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -20,6 +20,11 @@
 
 //! `bindgen`-generated declarations.
 
+use glib_sys::{
+    gboolean, guint, GArray, GByteArray, GHashTable, GHashTableIter, GIOCondition, GList,
+    GMainContext, GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc, GString,
+};
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 9a9aa517082..ecfb5647184 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+glib-sys.workspace = true
 qemu_macros = { path = "../../qemu-macros" }
 common = { path = "../../common" }
 bql = { path = "../../bql" }
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index e1ae95ed61e..1560dd20c6b 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -59,7 +59,7 @@ _hwcore_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _system_rs, _util_rs],
-  dependencies: [qemu_macros, common_rs],
+  dependencies: [glib_sys_rs, qemu_macros, common_rs],
 )
 
 hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
diff --git a/rust/hw/core/src/bindings.rs b/rust/hw/core/src/bindings.rs
index 919c02b56ae..65b9aae7536 100644
--- a/rust/hw/core/src/bindings.rs
+++ b/rust/hw/core/src/bindings.rs
@@ -20,6 +20,9 @@
 
 use chardev::bindings::Chardev;
 use common::Zeroable;
+use glib_sys::{
+    GArray, GByteArray, GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList, GString,
+};
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
 use system::bindings::MemoryRegion;
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 708bfaaa682..94504f3625c 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 util = { path = "../util" }
+glib-sys.workspace = true
 
 [lints]
 workspace = true
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index ddf5c2f51d5..18be65c92cf 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -38,7 +38,7 @@ _migration_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_util_rs],
-  dependencies: [common_rs],
+  dependencies: [common_rs, glib_sys_rs],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
diff --git a/rust/migration/src/bindings.rs b/rust/migration/src/bindings.rs
index 8ce13a9000e..24503eb69bd 100644
--- a/rust/migration/src/bindings.rs
+++ b/rust/migration/src/bindings.rs
@@ -19,6 +19,7 @@
 )]
 
 use common::Zeroable;
+use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
index 060ad2ec349..4be3c2541b6 100644
--- a/rust/qom/Cargo.toml
+++ b/rust/qom/Cargo.toml
@@ -18,6 +18,7 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
+glib-sys.workspace = true
 
 [lints]
 workspace = true
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 71fdac696c3..e50f41858d6 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -29,7 +29,7 @@ _qom_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs],
-  dependencies: [common_rs, qemu_macros],
+  dependencies: [common_rs, glib_sys_rs, qemu_macros],
 )
 
 qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_macros, qom])
diff --git a/rust/qom/src/bindings.rs b/rust/qom/src/bindings.rs
index 9ffff12cded..91de42f2426 100644
--- a/rust/qom/src/bindings.rs
+++ b/rust/qom/src/bindings.rs
@@ -18,6 +18,8 @@
     clippy::too_many_arguments
 )]
 
+use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index 7fd369b9e32..186ea00bfff 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 qom = { path = "../qom" }
 util = { path = "../util" }
+glib-sys.workspace = true
 
 [lints]
 workspace = true
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 0859f397453..73d61991146 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -36,7 +36,7 @@ _system_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
-  dependencies: [common_rs, qemu_macros],
+  dependencies: [glib_sys_rs, common_rs, qemu_macros],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
diff --git a/rust/system/src/bindings.rs b/rust/system/src/bindings.rs
index 43edd98807a..6cbb588de3d 100644
--- a/rust/system/src/bindings.rs
+++ b/rust/system/src/bindings.rs
@@ -19,6 +19,10 @@
 )]
 
 use common::Zeroable;
+use glib_sys::{
+    guint, GArray, GByteArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue,
+    GSList, GString,
+};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 1f6767ed9d1..85f91436545 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 [dependencies]
 anyhow = { workspace = true }
 foreign = { workspace = true }
+glib-sys = { workspace = true }
 libc = { workspace = true }
 common = { path = "../common" }
 
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 094b43355aa..b0b75e93ff6 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -40,7 +40,7 @@ _util_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, common_rs, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/bindings.rs b/rust/util/src/bindings.rs
index 9ffff12cded..c277a295add 100644
--- a/rust/util/src/bindings.rs
+++ b/rust/util/src/bindings.rs
@@ -18,6 +18,8 @@
     clippy::too_many_arguments
 )]
 
+use glib_sys::{guint, GList, GPollFD, GQueue, GSList, GString};
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
-- 
2.51.0


