Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1FBC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIMd-0006z0-KG; Thu, 17 Jul 2025 02:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5l-0008Af-EJ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5h-000865-JQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idkGHwv6pmeTAhqgTjVqPwn8pB104XDgL5/WOwov3Dw=;
 b=DlFXCCChL9iDPwkSexJtvFLm2xSpXA6LciIw17alvf7MkBT9WJqvCLNx/04zOs5iYMhjXL
 LDviQY3oqQf39i8On8LyOPyYCkkwx2XXhcRXevVZUs2et6f+YMKNZTlbNdpb62zma0A7MZ
 cDwfenHgDIrdni6ejugjkpnc8Ywk7tg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Gr2DzOPYPJuRERGWtBY-5Q-1; Thu, 17 Jul 2025 02:27:35 -0400
X-MC-Unique: Gr2DzOPYPJuRERGWtBY-5Q-1
X-Mimecast-MFC-AGG-ID: Gr2DzOPYPJuRERGWtBY-5Q_1752733654
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so2520295e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733653; x=1753338453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idkGHwv6pmeTAhqgTjVqPwn8pB104XDgL5/WOwov3Dw=;
 b=ZKN6KV6eoYP2CP1i4ifcmUSQ5E9HFef0aJ9vv4N9rpy4tz6l1c5+stzZbqsN3EL9gW
 jGLnh17c7V3rlwA+OFIIPqfe+CvgUn0i4Qd9+Edk77Rhhqlb1HHzw5fxXJxtkjweBl0t
 uRt9Of1vTyF0ESctbhHWLK8IwCtWl5gkt9KozNd3ChaqyH18NX+W14bWfK0mM0/uSAea
 gtI+Up+Fof31gmN311nU/BzoLApP2uu74+A/ICb4SF8SZ3jwpjA9kXcj/G3e+AHDhx8E
 XmlGdVv0KnLOqcmdMy02h0uynbEeZpAQOLfwDe+0xyLQAZhdzK+0W6TMrek8ed2zV6De
 Zx3w==
X-Gm-Message-State: AOJu0Yxdp01U86Tp16ajCh1DTi50pQR1c5JcFcXvxXLHypzv5RJi4dA5
 pv+cWjoGq9FPhChaBJav4Rz5LBia3cZLrUvO+4FsmsRepOXdfhFiqR3P1dD++8ABO1UCJecfQNC
 yKM0rXKxf7VFRZgB0OBzggVaHMZ2+lp4NzuLn/aYAeTlO6LAGZojP8NxN7jZUCEbvdgKYt0mgQF
 0k86oU1oGVToxFYVQZpmRA4ZiQSDYXBYCKY3GBvfdC
X-Gm-Gg: ASbGncsBQpRMNCvwDZRPItIcalqzkn8itNsEmMRfkXmVSOwRMlVxnlbcStPi+VvGUdE
 d9U6JJIZwLp/aJQvcmFqumVSGz5iiMm/qGrGVENTYj8ZmGeKw1INubctMYqWvt0VRzc9Hq3Ukse
 MtddnqYrOS+H7bgXppKzTDliKKAiZViDvtkxaOacznab2/wwYPSN7lty41k4bJTSswukzfN0ngZ
 EblCCYvCsDaZl8MdOO0XE7cHz5dBKVLTXaPtRAvKVqgfsxdeFyYPKyfmIZ+8Uw8kQUaSPp3g+Ht
 BFtu5VuqXCMu0slZoQ0e+cVWMdmuyC2mvDpGxX5pZp0=
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3b613e66eaemr1140201f8f.13.1752733653268; 
 Wed, 16 Jul 2025 23:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHra9UfOABKEB5T130dQ6ZZFVGZu4mHDHo1L6t3BM9ReMpJah12MQbrITyMyROflUJgshaO2A==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3b613e66eaemr1140179f8f.13.1752733652817; 
 Wed, 16 Jul 2025 23:27:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1d5sm19941359f8f.78.2025.07.16.23.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:27:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 1/4] subprojects: update proc-macro2 and syn
Date: Thu, 17 Jul 2025 08:27:24 +0200
Message-ID: <20250717062727.305466-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717062727.305466-1-pbonzini@redhat.com>
References: <20250717062727.305466-1-pbonzini@redhat.com>
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

Update to a version that is accepted by the attrs crate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                                       | 8 ++++----
 subprojects/.gitignore                                | 4 ++--
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build         | 2 +-
 subprojects/proc-macro2-1-rs.wrap                     | 8 ++++----
 subprojects/syn-2-rs.wrap                             | 8 ++++----
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b785c718f31..4baf6ba663c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -118,9 +118,9 @@ dependencies = [
 
 [[package]]
 name = "proc-macro2"
-version = "1.0.84"
+version = "1.0.95"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+checksum = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
 dependencies = [
  "unicode-ident",
 ]
@@ -155,9 +155,9 @@ dependencies = [
 
 [[package]]
 name = "syn"
-version = "2.0.66"
+version = "2.0.104"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+checksum = "17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40"
 dependencies = [
  "proc-macro2",
  "quote",
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index f4281934ce1..9d579f72d12 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -16,7 +16,7 @@
 /libc-0.2.162
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
-/proc-macro2-1.0.84
+/proc-macro2-1.0.95
 /quote-1.0.36
-/syn-2.0.66
+/syn-2.0.104
 /unicode-ident-1.0.12
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 5759df3ecc9..ba7de070292 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,6 +1,6 @@
 project('proc-macro2-1-rs', 'rust',
   meson_version: '>=1.5.0',
-  version: '1.0.84',
+  version: '1.0.95',
   license: 'MIT OR Apache-2.0',
   default_options: [])
 
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a0094174084..3e6dc318a9c 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,6 +1,6 @@
 project('syn-2-rs', 'rust',
   meson_version: '>=1.5.0',
-  version: '2.0.66',
+  version: '2.0.104',
   license: 'MIT OR Apache-2.0',
   default_options: [])
 
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
index 6c9369f0df3..0f06cd8e111 100644
--- a/subprojects/proc-macro2-1-rs.wrap
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -1,8 +1,8 @@
 [wrap-file]
-directory = proc-macro2-1.0.84
-source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
-source_filename = proc-macro2-1.0.84.0.tar.gz
-source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
+directory = proc-macro2-1.0.95
+source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.95/download
+source_filename = proc-macro2-1.0.95.0.tar.gz
+source_hash = 02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778
 #method = cargo
 patch_directory = proc-macro2-1-rs
 
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index d79cf750fb4..1e5e9d9fb6e 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -1,8 +1,8 @@
 [wrap-file]
-directory = syn-2.0.66
-source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
-source_filename = syn-2.0.66.0.tar.gz
-source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+directory = syn-2.0.104
+source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
+source_filename = syn-2.0.104.0.tar.gz
+source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
 #method = cargo
 patch_directory = syn-2-rs
 
-- 
2.50.1


