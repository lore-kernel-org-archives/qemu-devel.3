Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE3AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKnE-0005mW-M9; Fri, 21 Aug 2026 04:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKnC-0005iD-Ky
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKn9-0008Pb-W3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yH5UkosYjM5QnJdd077iiA8YnDBeS9StdFSji5GO7W8=;
 b=KiqD1YzvUY0UBPVcehQHS3uoGtmAcacxJFWsVfgU6Xt5dH/YJEJwP175xVIkrMVkfwVUt9
 mrS4V/9C9YY8Z7VtPsvjEeoJHQf8LKEOTJTCJwU5MYKFGhgy5pvNNlb6uUOx8oikaFdaKL
 LzQorBcNVyCpJHOkF2Paiios4NBg3hQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-hjAY9yBjNq-fEtpBblXgXQ-1; Fri, 21 Aug 2026 04:39:51 -0400
X-MC-Unique: hjAY9yBjNq-fEtpBblXgXQ-1
X-Mimecast-MFC-AGG-ID: hjAY9yBjNq-fEtpBblXgXQ_1787301590
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c1630a90890so50769066b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301590; x=1787906390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yH5UkosYjM5QnJdd077iiA8YnDBeS9StdFSji5GO7W8=;
 b=k9vo/N6bAx/Mw72u73UhZRQErUUXjOArW+bNM8TRMYtZMrqup4dfWl7WYWAHGJOKa/
 WF1OgyTynvuwQYCvhWqyf5KEOF8hO1ogaWCbPjIf5L4bys5nhXuIIOTLAio97qTImoSz
 mGwRTxjgljF06LuL9BTvaXVapucqUOuWjc6IvDJRDHjtDTHuD/Ctre5mcd5ofrVYm37o
 eVO826EO3Xp+MwLp2coIMUK9oaAWN/A1LjHuvAGkaE4vIiJeM874DML3Ec5VvzrnO7vG
 doAgLdUIO+DvIc5WCVLz1tdlQv0urRWwdCrjFp7FtAAWbyhdIzktfs2SY4Q4LVsCtGDQ
 RTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301590; x=1787906390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yH5UkosYjM5QnJdd077iiA8YnDBeS9StdFSji5GO7W8=;
 b=F5ZZkrxokQn4I83eCYB361jvLJD1/jpVnKdVfZZsMze0IORlhXgx3aRsArnCJRjLrR
 lhvGAGB+pORC6QUC2Ik1Zm0EJ2Fsnj4fBsFSNQMe47G6XYGfSQu4tjwHBfRTwGchAmxT
 2weNNSeXbObn/pbfabP7w4ki2WyinM1guC9JpBsG/9t3NhOibzw7zkvDHdzbDqGtUiKV
 PTdaAVv4sSfhfGurZZ4bEpXXzaJCtm8wAMJ7SObjyNMveM0VUNSkuzt4n65MBZUm90Jb
 k3XABElWwZ3nd/fvWWN2i5/fiivBXRSB9CcIOW1rb2cncdEgLjfieFLctpHT3LIE8Zhx
 U8CA==
X-Gm-Message-State: AFuF++lpnDCEw1Vjo5d/NioLYgavDsiQj1s3zfpIwsWlXg1d8w3zFoTP
 kbAKW8SvgVzmBKo/S1xRZMGfFPjQNtZDxvPTlNlB8uLkcKh8r9CHzVfWUsW+J2o6pE78L58Ull4
 QPxySSHKsHmuEIqRdlwmRRZcMxsbuLmQr2mWWCEuvMNlDa2lYxZ1ynSEJ7KzKzufnX9vC/Wj8CY
 1FeiONKYJt/+qPXVxOZQ4QzZbPu5l290Ydy1MZxFNV
X-Gm-Gg: AR+sD10+8+pt4nUUIhU5HgMkSxJYi76DHfs4iyhLDbxYIIP26EDQm+/JScyTpGVLMTJ
 Fq0bwu+vBNWSNyOrnINsf9f3mSyY0/91BBnLHxxoDxf01OU+dR67aulKkXsaetpS8Xm3CcvHPOo
 bKgeANLNWW0ILqguNEtimmD8VUHrwkJQHb8QHlQBJDDOirDZTsJF7eKX+mba3UPkwaGvWK40fVy
 xOB4r5qLKC5onzGEDQ1SCHb501jpK5gafHlzkuSnzwPCkwpIuQQvRu67nocTzzokQM/ghLJycG0
 plFEsL+xvLy9M8xbqrNqxUpLnh+29J4dGXSxwoiNRyYupKLPqct53mX7RY5rSIdKvusBguyBxWh
 LkA2tJ5e4OTuwhxdi1b1ccdJe+pHgfx8BMsOI2ZwCm+NuJLbQrdH39z9opDGD+ilYCiGO0nGBTn
 8dKB0=
X-Received: by 2002:a17:906:81d8:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c246a6ca584mr419161166b.18.1787301589659; 
 Fri, 21 Aug 2026 01:39:49 -0700 (PDT)
X-Received: by 2002:a17:906:81d8:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c246a6ca584mr419158366b.18.1787301589039; 
 Fri, 21 Aug 2026 01:39:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591df465sm344065266b.48.2026.08.21.01.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 9/9] rust: update crates
Date: Fri, 21 Aug 2026 10:39:24 +0200
Message-ID: <20260821083925.2008135-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Cargo.lock                                    | 48 +++++++++----------
 Cargo.toml                                    |  2 +-
 subprojects/attrs-0.2-rs.wrap                 |  9 ++--
 subprojects/foreign-0.3-rs.wrap               |  9 ++--
 ...sys-0.21-rs.wrap => glib-sys-0.22-rs.wrap} |  9 ++--
 subprojects/libc-0.2-rs.wrap                  | 10 ++--
 .../libc-0.2-rs/meson/meson.build             | 20 ++------
 subprojects/quote-1-rs.wrap                   | 10 ++--
 subprojects/unicode-ident-1-rs.wrap           | 10 ++--
 9 files changed, 56 insertions(+), 71 deletions(-)
 rename subprojects/{glib-sys-0.21-rs.wrap => glib-sys-0.22-rs.wrap} (13%)

diff --git a/Cargo.lock b/Cargo.lock
index ad664a812d2..acf5516c5c4 100644
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
@@ -93,18 +93,18 @@ checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
 
 [[package]]
 name = "foreign"
-version = "0.3.1"
+version = "0.3.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+checksum = "bec05eb9c07a3f66653535e5e50eb5eb935eb00d3bb7e06ea26a9d3a1d016182"
 dependencies = [
  "libc",
 ]
 
 [[package]]
 name = "glib-sys"
-version = "0.21.2"
+version = "0.22.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1"
+checksum = "030967459f9f676851872c6304adea7825c6d462ec9b72554c733cf0c5952233"
 dependencies = [
  "libc",
  "system-deps",
@@ -175,9 +175,9 @@ dependencies = [
 
 [[package]]
 name = "libc"
-version = "0.2.162"
+version = "0.2.189"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
+checksum = "3eaf3ede3fee6db1a4c2ee091bf8a8b4dccdc6d17f656fb07896ee72867612f2"
 
 [[package]]
 name = "migration"
@@ -202,9 +202,9 @@ dependencies = [
 
 [[package]]
 name = "pkg-config"
-version = "0.3.32"
+version = "0.3.34"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
+checksum = "f6b464fbc74e149a392436b17d523f769e057cb6877f6a5c4618bc6f11800548"
 
 [[package]]
 name = "pl011"
@@ -272,9 +272,9 @@ dependencies = [
 
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
@@ -366,9 +366,9 @@ dependencies = [
 
 [[package]]
 name = "target-lexicon"
-version = "0.13.2"
+version = "0.13.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e502f78cdbb8ba4718f566c418c52bc729126ffd16baee5baa718cf25dd5a69a"
+checksum = "adb6935a6f5c20170eeceb1a3835a49e12e19d792f6dd344ccc76a985ca5a6ca"
 
 [[package]]
 name = "tests"
@@ -386,9 +386,9 @@ dependencies = [
 
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
@@ -410,9 +410,9 @@ dependencies = [
 
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
@@ -433,9 +433,9 @@ dependencies = [
 
 [[package]]
 name = "unicode-ident"
-version = "1.0.12"
+version = "1.0.24"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+checksum = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
 
 [[package]]
 name = "util"
@@ -458,9 +458,9 @@ dependencies = [
 
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
index b35704faabe..693dccb73c2 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -19,7 +19,7 @@ authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 anyhow = "~1.0"
 foreign = "~0.3.1"
 libc = "0.2.162"
-glib-sys = { version = "0.21.2", features = ["v2_66"] }
+glib-sys = { version = "0.22.8", features = ["v2_66"] }
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
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
index 95d450397ee..3d49f5a85f4 100644
--- a/subprojects/foreign-0.3-rs.wrap
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -1,6 +1,7 @@
 [wrap-file]
-directory = foreign-0.3.1
-source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
-source_filename = foreign-0.3.1.tar.gz
-source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
+directory = foreign-0.3.2
+source_url = https://crates.io/api/v1/crates/foreign/0.3.2/download
+source_filename = foreign-0.3.2.tar.gz
+source_hash = bec05eb9c07a3f66653535e5e50eb5eb935eb00d3bb7e06ea26a9d3a1d016182
 method = cargo
+
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.22-rs.wrap
similarity index 13%
rename from subprojects/glib-sys-0.21-rs.wrap
rename to subprojects/glib-sys-0.22-rs.wrap
index ea4d5f66a58..8177da567d3 100644
--- a/subprojects/glib-sys-0.21-rs.wrap
+++ b/subprojects/glib-sys-0.22-rs.wrap
@@ -1,6 +1,7 @@
 [wrap-file]
-directory = glib-sys-0.21.2
-source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
-source_filename = glib-sys-0.21.2.tar.gz
-source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
+directory = glib-sys-0.22.8
+source_url = https://crates.io/api/v1/crates/glib-sys/0.22.8/download
+source_filename = glib-sys-0.22.8.tar.gz
+source_hash = 030967459f9f676851872c6304adea7825c6d462ec9b72554c733cf0c5952233
 method = cargo
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


