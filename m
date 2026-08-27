Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA0C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzari-0002hT-7f; Thu, 27 Aug 2026 10:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarg-0002gc-MQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarX-0005kl-So
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99cZ5tVTjyBymgcP53o3x4GZb3D8a2MNktH0qYZ5XM0=;
 b=AXsvn192E/bT5tGA5A+rZRri6wZeb7iRWn1HRd6hIYUyG13xT92Cvh37snuGRINbI9N9Mm
 NPiH5Lr18NVrJCTNyRWHesMZwWyevCyCQ35f6oCFoFppTcxW/5d3Za2Ydth/0rBTsMmOWz
 TgLk9RnVB+yZmvlyiP0IdYVtfk/NmmE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-qRHxTCSEMi221xF6ZzTN7g-1; Thu, 27 Aug 2026 10:13:49 -0400
X-MC-Unique: qRHxTCSEMi221xF6ZzTN7g-1
X-Mimecast-MFC-AGG-ID: qRHxTCSEMi221xF6ZzTN7g_1787840027
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso19557175e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840027; x=1788444827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=99cZ5tVTjyBymgcP53o3x4GZb3D8a2MNktH0qYZ5XM0=;
 b=YQxnuiDuv9lnTKMV7fB9PAiSbQQHkfwV0WY7tzaqe8mULZyk6JZ+1K13llu89gsLhv
 6Wt3yFpH/N96ZaE8FOH4jPxKybW1WdDw7kIgchD9Q3KCwd+xdoGttzE3zMH1W7GlbX7e
 WZzGcjYmZhCfIRs++jxBYrmNNyH5ymH7YXzz18vbeGI0Rfb/sXUM3PuVQ5YUqRA3eNux
 MOkm6aVx5s99s/pqB+qkovgpRR6TIJN+OClXKi5oNpsxQ0OrMCVZk1rbFgljv6S7n0to
 PYQugSZoinaJfaWn8YmWABQyDSyBZly1GL8AMyuNWTsZd2v7vCbNz87ydiDQ2AkW8BUR
 goNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840027; x=1788444827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=99cZ5tVTjyBymgcP53o3x4GZb3D8a2MNktH0qYZ5XM0=;
 b=VKXpjjn0P3JPjBOmacO90WSIw+3WeirjWZ3GkVVGIaMX22ZIMmP42BBgU/MTyuvrew
 rsCUcjNZWvU+SfpSm9YkgVKhwOjqsEqr8y3c1qisr1lgivAL/gZQHur7/jz9R/c4/svZ
 9rJqWkZ3xO1PI3lMPoNRTMKoQmHLNk7ylu9eBmwhZFMxogs6Z5yTGQXR159tkrKJ/Mc/
 Vpj7jR8VVAh4hHkkDGtOLLPZipDGjNpfeZBkfDb/UUHBe+mTW7HkV+osnherIk9LctvT
 AcdmrIcGcfdn/Zphydd9n6K7QyHTu5v/dmhC1sgVPsjvvHFcckpvgfzd1Lkd4tT/mSYA
 f+yQ==
X-Gm-Message-State: AFuF++lOO40RWOplyw7uuRb6clts0s41izFfui4KMiPaQHYnhoB3bUDo
 eQQPzJqa2MQbAPoCy0k8u9Rkrp1+MXbN3cYGTbUI+BY+OrSBGSyRq5heRjTI451q8+0z4MBrVyf
 9DOUPszxobIUD2U3rLY84E2wmRepF11GzCxaSvrxWgDvE9cpS9eoOrDUUptmqHyhSasSnPxznsl
 9e+QVF0LTZOk8fsOioncDVAnLVD9Caoyu4tneKBtdQ
X-Gm-Gg: AR+sD12d/jt+rFg00r5V19AL17ptWYukJzYaLAxIGEz4a/y31csD/Tr1Zz2hyJLkXQq
 iyCSx7GdwnaGC754F5AywG79VsW8dYGN81cogxTbYWiFqrWS+hduGtVhlToiFO6Xnl38K4lzTeI
 oeqBLz9pZHmxRBGM+h9EO8l4WwC7ikLuJ+41yJAHY72egWkX7OQIeQuSOfa0Zk4peAoCErUykkp
 u+WQcxMt5H7lK5RlxyyYvw6Tcjh8D4fmiPqLtn+SHRMUBvD3krYusw59og6gXlKyb/+ZyKk82UL
 G+0jsK55yJohjgfWFJSm5sfJDsJ5pOVjuJZCgJFQg66Fu9pGX+pHjBgprxxPeeXn7V4A7jkczJq
 mczbThL3J2cppmA1uTxUqoKcSqxNjVmMpWvu5PjFWgSDerD77MfACSi51HuObVmKsC8LMD1ODft
 Y9tY4=
X-Received: by 2002:a05:600c:4f55:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499dc720beamr196258995e9.11.1787840026754; 
 Thu, 27 Aug 2026 07:13:46 -0700 (PDT)
X-Received: by 2002:a05:600c:4f55:b0:499:78b3:7b36 with SMTP id
 5b1f17b1804b1-499dc720beamr196257485e9.11.1787840026056; 
 Thu, 27 Aug 2026 07:13:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm74417595e9.4.2026.08.27.07.13.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/23] rust: update crates
Date: Thu, 27 Aug 2026 16:12:58 +0200
Message-ID: <20260827141314.1099352-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Until a new version of bitfield-struct is released,
skip the ones that introduce a new dependency on syn 3.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Cargo.lock                                    | 60 ++++++++++++-------
 Cargo.toml                                    |  2 +-
 subprojects/attrs-0.2-rs.wrap                 |  9 +--
 subprojects/foreign-0.3-rs.wrap               |  6 --
 subprojects/foreign-0.4-rs.wrap               |  7 +++
 subprojects/libc-0.2-rs.wrap                  | 10 ++--
 .../foreign-0.4-rs/meson/meson.build          |  3 +
 .../libc-0.2-rs/meson/meson.build             | 20 ++-----
 subprojects/quote-1-rs.wrap                   | 10 ++--
 subprojects/unicode-ident-1-rs.wrap           | 10 ++--
 10 files changed, 70 insertions(+), 67 deletions(-)
 delete mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/foreign-0.4-rs.wrap
 create mode 100644 subprojects/packagefiles/foreign-0.4-rs/meson/meson.build

diff --git a/Cargo.lock b/Cargo.lock
index ad664a812d2..0dd16cdb68a 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -10,9 +10,9 @@ checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
 
 [[package]]
 name = "attrs"
-version = "0.2.9"
+version = "0.2.10"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f"
+checksum = "60e397c905850173fdc02285fe7f94f1b0c3ff55ff6e103efbe98074d80601c4"
 dependencies = [
  "proc-macro2",
  "syn",
@@ -46,9 +46,9 @@ dependencies = [
 
 [[package]]
 name = "cfg-expr"
-version = "0.20.3"
+version = "0.20.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "1a2c5f3bf25ec225351aa1c8e230d04d880d3bd89dea133537dafad4ae291e5c"
+checksum = "fb693542bcafa528e198be0ebd9d3632ca5b7c93dbe7237460e199910835997c"
 dependencies = [
  "smallvec",
  "target-lexicon",
@@ -93,11 +93,12 @@ checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 
 [[package]]
 name = "foreign"
-version = "0.3.1"
+version = "0.4.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+checksum = "2292704c239c26962ac5c32d53057c442ca5a2bf017fca5c95c342271058e4c2"
 dependencies = [
  "libc",
+ "rustc_version",
 ]
 
 [[package]]
@@ -175,9 +176,9 @@ dependencies = [
 
 [[package]]
 name = "libc"
-version = "0.2.162"
+version = "0.2.189"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+checksum = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
 
 [[package]]
 name = "migration"
@@ -202,9 +203,9 @@ dependencies = [
 
 [[package]]
 name = "pkg-config"
-version = "0.3.32"
+version = "0.3.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+checksum = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
 
 [[package]]
 name = "pl011"
@@ -272,13 +273,28 @@ dependencies = [
 
 [[package]]
 name = "quote"
-version = "1.0.36"
+version = "1.0.47"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+checksum = "1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001"
 dependencies = [
  "proc-macro2",
 ]
 
+[[package]]
+name = "rustc_version"
+version = "0.4.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "cfcb3a22ef46e85b45de6ee7e79d063319ebb6594faafcf1c225ea92ab6e9b92"
+dependencies = [
+ "semver",
+]
+
+[[package]]
+name = "semver"
+version = "1.0.28"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
+
 [[package]]
 name = "serde_core"
 version = "1.0.228"
@@ -366,9 +382,9 @@ dependencies = [
 
 [[package]]
 name = "target-lexicon"
-version = "0.13.2"
+version = "0.13.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e502f78cdbb8ba4718f566c418c52bc729126ffd16baee5baa718cf25dd5a69a"
+checksum = "adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
 
 [[package]]
 name = "tests"
@@ -386,9 +402,9 @@ dependencies = [
 
 [[package]]
 name = "toml"
-version = "1.1.3+spec-1.1.0"
+version = "1.1.4+spec-1.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "53c96ecdfa941c8fc4fcaed14f99ada8ebed502eef533015095a07e3301d4c3c"
+checksum = "3aace63f4bbcdfc2c965b059de67119c89c4017a70d633be6c104910f67056f5"
 dependencies = [
  "indexmap",
  "serde_core",
@@ -410,9 +426,9 @@ dependencies = [
 
 [[package]]
 name = "toml_parser"
-version = "1.1.2+spec-1.1.0"
+version = "1.1.3+spec-1.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "a2abe9b86193656635d2411dc43050282ca48aa31c2451210f4202550afb7526"
+checksum = "1d38ac1cf9b95face32296c0a3ede1fdc270627c9d9c02a7274dd6d960dc4d56"
 dependencies = [
  "winnow",
 ]
@@ -433,9 +449,9 @@ dependencies = [
 
 [[package]]
 name = "unicode-ident"
-version = "1.0.12"
+version = "1.0.24"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+checksum = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
 
 [[package]]
 name = "util"
@@ -458,9 +474,9 @@ dependencies = [
 
 [[package]]
 name = "version-compare"
-version = "0.2.0"
+version = "0.2.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "852e951cb7832cb45cb1169900d19760cfa39b82bc0ea9c0e5a14ae88411c98b"
+checksum = "03c2856837ef78f57382f06b2b8563a2f512f7185d732608fd9176cb3b8edf0e"
 
 [[package]]
 name = "winnow"
diff --git a/Cargo.toml b/Cargo.toml
index b35704faabe..397a64ea99b 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -17,7 +17,7 @@ authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 
 [workspace.dependencies]
 anyhow = "~1.0"
-foreign = "~0.3.1"
+foreign = "~0.4.0"
 libc = "0.2.162"
 glib-sys = { version = "0.21.2", features = ["v2_66"] }
 
diff --git a/subprojects/attrs-0.2-rs.wrap b/subprojects/attrs-0.2-rs.wrap
index fef89ea9368..fdab9646207 100644
--- a/subprojects/attrs-0.2-rs.wrap
+++ b/subprojects/attrs-0.2-rs.wrap
@@ -1,6 +1,7 @@
 [wrap-file]
-directory = attrs-0.2.9
-source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
-source_filename = attrs-0.2.9.tar.gz
-source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
+directory = attrs-0.2.10
+source_url = https://crates.io/api/v1/crates/attrs/0.2.10/download
+source_filename = attrs-0.2.10.tar.gz
+source_hash = 60e397c905850173fdc02285fe7f94f1b0c3ff55ff6e103efbe98074d80601c4
 method = cargo
+
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
deleted file mode 100644
index 95d450397ee..00000000000
--- a/subprojects/foreign-0.3-rs.wrap
+++ /dev/null
@@ -1,6 +0,0 @@
-[wrap-file]
-directory = foreign-0.3.1
-source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
-source_filename = foreign-0.3.1.tar.gz
-source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
-method = cargo
diff --git a/subprojects/foreign-0.4-rs.wrap b/subprojects/foreign-0.4-rs.wrap
new file mode 100644
index 00000000000..9aa70acd6ad
--- /dev/null
+++ b/subprojects/foreign-0.4-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = foreign-0.4.0
+source_url = https://crates.io/api/v1/crates/foreign/0.4.0/download
+source_filename = foreign-0.4.0.tar.gz
+source_hash = 2292704c239c26962ac5c32d53057c442ca5a2bf017fca5c95c342271058e4c2
+method = cargo
+
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
index 6e225579795..2bdb7c1750b 100644
--- a/subprojects/libc-0.2-rs.wrap
+++ b/subprojects/libc-0.2-rs.wrap
@@ -1,10 +1,8 @@
 [wrap-file]
-directory = libc-0.2.162
-source_url = https://crates.io/api/v1/crates/libc/0.2.162/download
-source_filename = libc-0.2.162.tar.gz
-source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
+directory = libc-0.2.189
+source_url = https://crates.io/api/v1/crates/libc/0.2.189/download
+source_filename = libc-0.2.189.tar.gz
+source_hash = 3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2
 method = cargo
 patch_directory = libc-0.2-rs
 
-# bump this version number on every change to meson.build or the patches:
-# v1
diff --git a/subprojects/packagefiles/foreign-0.4-rs/meson/meson.build b/subprojects/packagefiles/foreign-0.4-rs/meson/meson.build
new file mode 100644
index 00000000000..fc048fd32c2
--- /dev/null
+++ b/subprojects/packagefiles/foreign-0.4-rs/meson/meson.build
@@ -0,0 +1,3 @@
+if rustc.version().version_compare('>=1.78.0')
+  extra_args += [ '--cfg', 'has_diagnostic_namespace' ]
+endif
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson/meson.build
index db9480ada1c..ba770a697f8 100644
--- a/subprojects/packagefiles/libc-0.2-rs/meson/meson.build
+++ b/subprojects/packagefiles/libc-0.2-rs/meson/meson.build
@@ -1,16 +1,4 @@
-extra_args += [
-    '--cfg', 'freebsd11',
-    '--cfg', 'libc_priv_mod_use',
-    '--cfg', 'libc_union',
-    '--cfg', 'libc_const_size_of',
-    '--cfg', 'libc_align',
-    '--cfg', 'libc_int128',
-    '--cfg', 'libc_core_cvoid',
-    '--cfg', 'libc_packedN',
-    '--cfg', 'libc_cfg_target_vendor',
-    '--cfg', 'libc_non_exhaustive',
-    '--cfg', 'libc_long_array',
-    '--cfg', 'libc_ptr_addr_of',
-    '--cfg', 'libc_underscore_const_names',
-    '--cfg', 'libc_const_extern_fn',
-]
+extra_args += ['--cfg', 'freebsd12']
+
+# TODO: linux_time_bits64, file_offset_bits64, gnu_time_bits64 are still unstable for glibc
+# as of libc 0.2.189
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
index 5f38f56499e..c6360ceab43 100644
--- a/subprojects/quote-1-rs.wrap
+++ b/subprojects/quote-1-rs.wrap
@@ -1,9 +1,7 @@
 [wrap-file]
-directory = quote-1.0.36
-source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
-source_filename = quote-1.0.36.0.tar.gz
-source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
+directory = quote-1.0.47
+source_url = https://crates.io/api/v1/crates/quote/1.0.47/download
+source_filename = quote-1.0.47.tar.gz
+source_hash = 1fbf4db142a473a8d80c26bbf18454ed458bf8d26c8219c331daecfdbd079001
 method = cargo
 
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
index 90aae02ba0a..2563f101d40 100644
--- a/subprojects/unicode-ident-1-rs.wrap
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -1,9 +1,7 @@
 [wrap-file]
-directory = unicode-ident-1.0.12
-source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
-source_filename = unicode-ident-1.0.12.tar.gz
-source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
+directory = unicode-ident-1.0.24
+source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.24/download
+source_filename = unicode-ident-1.0.24.tar.gz
+source_hash = e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75
 method = cargo
 
-# bump this version number on every change to meson.build or the patches:
-# v2
-- 
2.55.0


