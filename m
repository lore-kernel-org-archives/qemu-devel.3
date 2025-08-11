Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D63CCA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVDh-00045y-8g; Mon, 11 Aug 2025 12:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDf-00045I-2F
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulVDZ-00012Y-DQ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hlU8bznwYi7/BJmgtxk75tZW/kbsGO8zP8CVQnoj8y0=;
 b=ip0CnEiQPwx9nw6j0MICBVjN1VgEyFFnVEfox1vbGJ9Jl9w6ak5TBbleGA//3KfIXQvnMU
 xYosiVuLI8nwC+pv0TdpZ9wLecjr5vn4WK9NK7PCMWgCEHxHJcjsaPx9MvC59dp0wKqvV1
 0kZjEh3Mb+NCI+9EDfxVVqLxVvaOIZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ULIUVWNBO8--TUfr6O2X5Q-1; Mon, 11 Aug 2025 12:17:46 -0400
X-MC-Unique: ULIUVWNBO8--TUfr6O2X5Q-1
X-Mimecast-MFC-AGG-ID: ULIUVWNBO8--TUfr6O2X5Q_1754929065
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-459dbbf43c0so28334015e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929065; x=1755533865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlU8bznwYi7/BJmgtxk75tZW/kbsGO8zP8CVQnoj8y0=;
 b=TGXveRqWkvMsuxRuOs9mWWYxQ3c7SF0ardNt/N0rZYtsVMGF9rEJi95P8DbetNWIAp
 iJEIqvKjUgU0XDRc1e2CGU7CWXQVi+8MycpcoZscz+IpzMmYUi466uetpUsp/2PpuZsR
 TXhqrNtAbe/BmmVgFSiYu6Sgsyp45O35XB1Q7wisQRWlZ1XxnV1h8j9hV2omjmL26/3o
 m7xhl8P+UW86BD/6M0bEvu50x4DFVqS7g9k4P3Tp7fQLB2uLfgINCBOniMzrpXCWIzHr
 R+7If3EjXdLxuVEyWpAGA8EYRDLK1IhHkO9SZSYFRf5dJNJ0P0zvRd55FBTYqdb8xPww
 qL5Q==
X-Gm-Message-State: AOJu0YwvSB2aDQKDwax680qe85q0rsAbarPvYbmUm/Evc1rwyRgU2xVE
 A9d5Q+ZGIfqMPvwNW8AFqd1tPusTnFmyfupswjp3RAlJoEChvDJyA7TJ/hvbOhUatHqtbRLFskR
 PdRYHF/3JkwwjmQ20/aBhXNy7N+k0+ev9w15Wi1JM3/jPM15QjQg2emy9uVV0e1Wjf05W4jP5Z3
 cugRPvnqEbhQ/bNKKi0DoIh1CbMacLfGufoBm+bf6p
X-Gm-Gg: ASbGncvpBBlS/IcVtVLgI9nga9GR6BU5azgRzwsV/W+ycZRUorf7f2phP7y7r7N3UhP
 RldBgtCfojuXngHqSke9wIGIzdWG5Hl5Dlx6SxF7pv1W3jJ/onjMnIb33qNHAc46KFe0AVmVBJK
 YQAk+zcERoUd0qgUb6+eUVKsTz3iSNq275Fas0Imuc8sXSOcDOEef213ywBfkOtikc6gZK3T3O+
 tPOFa1z81VX91rAko0Aw+S8BDIRBO4ho44hrCtkn7/EmddmTi4XRL/lj8/PxetmGbQKXeR/VPQS
 AWtjLbmWH+cgE7Pw8K/YlxVB1T1uEyWlnp7AjlGspyXP
X-Received: by 2002:a05:600c:1c98:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-45a10d966cfmr1958995e9.11.1754929064787; 
 Mon, 11 Aug 2025 09:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1qKLdmt3Y71abcxR3wXiirDFR2rSnu+ov6jxbLWoSATd517ZudiKLVnU/hZCLlMvxfWgWJw==
X-Received: by 2002:a05:600c:1c98:b0:456:942:b162 with SMTP id
 5b1f17b1804b1-45a10d966cfmr1958705e9.11.1754929064322; 
 Mon, 11 Aug 2025 09:17:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0846777sm31356529f8f.48.2025.08.11.09.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:17:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 1/2] rust: do not link C libraries into Rust rlibs
Date: Mon, 11 Aug 2025 18:17:36 +0200
Message-ID: <20250811161737.220835-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161737.220835-1-pbonzini@redhat.com>
References: <20250811161737.220835-1-pbonzini@redhat.com>
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

When a C library is linked into a Rust rlib, rustc remembers the dependency
into the metadata and adds the library to the linker command line.
Unfortunately, static libraries are sensitive to their position on the
command line and rustc does not always get it right.

Meson could work around it itself by never adding these static libraries
to the rlibs (after all, Meson tracks the transitive dependencies already
and knows how to add them to dependents of those rlibs); at least for now,
do it in QEMU: never link C libraries into Rust rlibs, and add them to the
final build products only.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build |  2 +-
 rust/hw/timer/hpet/meson.build |  2 +-
 rust/meson.build               |  2 --
 rust/qemu-api/meson.build      | 15 +++++++++------
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 2a1be329abc..16acf12f7cc 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -7,7 +7,7 @@ _libpl011_rs = static_library(
     bilge_rs,
     bilge_impl_rs,
     bits_rs,
-    qemu_api,
+    qemu_api_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c2d7c0532ca..64195410a3e 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -4,7 +4,7 @@ _libhpet_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
-    qemu_api,
+    qemu_api_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/meson.build b/rust/meson.build
index 331f11b7e72..45936a0a731 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -18,8 +18,6 @@ quote_rs_native = dependency('quote-1-rs', native: true)
 syn_rs_native = dependency('syn-2-rs', native: true)
 proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
-qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
-
 genrs = []
 
 subdir('qemu-api-macros')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c458..88875e723d8 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -79,15 +79,18 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
-                 qom, hwcore, chardev, migration],
+  # Cannot add qemuutil here; rustc adds it too early to the linker command line.
+  # Instead, we add it and all C static libraries to the executables only.
+  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros],
 )
 
-rust.test('rust-qemu-api-tests', _qemu_api_rs,
-          suite: ['unit', 'rust'])
-
+qemu_api_rs = declare_dependency(link_with: _qemu_api_rs)
 qemu_api = declare_dependency(link_with: [_qemu_api_rs],
-  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
+  dependencies: [qemu_api_macros, qom, hwcore, chardev, migration, qemuutil])
+
+rust.test('rust-qemu-api-tests', _qemu_api_rs,
+          suite: ['unit', 'rust'],
+          dependencies: [qemu_api_macros, qom, hwcore, chardev, migration, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
-- 
2.50.1


