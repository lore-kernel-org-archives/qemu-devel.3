Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB6BE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRr-0000ve-6P; Sat, 27 Dec 2025 04:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRn-0000V3-Of
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRk-0004MH-BL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8p/Bpe0gmBVLAqwDcW5Zxplm8I9ytkWLraykQNKpZ9M=;
 b=IXqcWysTdUSvR6u7x5jlpgTOm8GUgR69MiKtnbkrKQ8iTm3/rj7alAqsrG+SXUFKVSn+K1
 1PqY+0uVO13XcW0RH6UWeWqs+LvtOYD1ekyUqc7bQQb6jxPAdbm2oxhycONpSbbI8dGpKb
 brmyc48ms+jJq0uksDlivd13FGHF2X8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-5mX0-G6rPlWXQGneDpqBKQ-1; Sat, 27 Dec 2025 04:18:43 -0500
X-MC-Unique: 5mX0-G6rPlWXQGneDpqBKQ-1
X-Mimecast-MFC-AGG-ID: 5mX0-G6rPlWXQGneDpqBKQ_1766827122
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so5533820f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827120; x=1767431920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p/Bpe0gmBVLAqwDcW5Zxplm8I9ytkWLraykQNKpZ9M=;
 b=sQW+1cUH7Pq16InfDIicMVSuLsUht1BHdUhXoHvlHeXTtiwV+dKHrPd/o6JDzTAN2G
 OW9fDhlc7QR6Y20w80nLygzCbF2bql+z9ZXh+M8/LnmPURN6kn8g2fXehYDHTfXh+83M
 T/fpO5U9CXcUYzlbk6HUFdGDBgOnrrWxYF75WeJBDzIXoKeeOHWM+oix/p+WaylS+OCK
 S53gS0o356EWDEhYnMFOCZ8OqU8DQblmrau+efeJGdksPvzlx9dpeTIeYFa4mIw4jqnR
 kVGb2CgUQ/1MRWqN1ZaYcQGUdqHt/PIMzdU1iEeX8TtiuyDTa3GFmSPYdZ3i+z3rQ9EI
 rtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827120; x=1767431920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8p/Bpe0gmBVLAqwDcW5Zxplm8I9ytkWLraykQNKpZ9M=;
 b=Fzk/WWy7ImJBXB572pFu76VEUigQL2o4x7khCz5BcF6MPtrnAGq8bJ+GLWhwZewncb
 d5MkLE0lBFOlz++tWToVMdwM+sOS6touqnPNInP72h1TyA1uJDlLCUAiXLufNoMMuPG3
 UCa0dgYGnMiqLsWr0PewqpjbirXRxzDsXHbLvfiAtpiPa9vSKyOLl8MpYYpgz9O0eTq4
 f1XcEZENZaainEis2d5DSCnAT9AWw+klScsjTOXRDiSuX2HzWxERvOIzeVkmz6vS0Ydj
 K7W/U5kWOofuqXUJ92v8jXhc8+N1IxsV8OnIVkxbBkUouzWP1xjvG2s017aS+WOSu/Sl
 8jiQ==
X-Gm-Message-State: AOJu0YysBGWIhoUuI9YGpx7zWnFtbysWjF29NhhiqdkGU1pRKbwZrFH/
 Nah+yk9GI5V83tyLHf89g8wi3iDYQ1p1o8Xd3hic86qw0bbFD4kPhUyaiOS7Tc/wnhMzE4r3c0L
 zRbpWXi6S7hwumWs9DaizRt9eaZbo7TKWdYreHRWWXnLr99C275ykRVztyF0kYAHL6JvjKlNmkq
 YZ7R4E27LFG12s4CBBbt+o4PUNLzKufxHIlxivbfQk
X-Gm-Gg: AY/fxX4GHJ4UdtkIucu78RhwiYrpKBFbcDY9ilxoyV81z76sZIwayYwzb22h8jYpApZ
 hSSEO7z11lv6TCzW7CiMUsuS4Y3h8uKcJi9irC4JKP+iPp5ba8UatM38smAVz++/N0GRv5itcGW
 nItVykmBg35y1Pr5vgH6o//wvfRClVmH3Gcvpncm5OyK2tiFLdFNc5qrv0k1LvrU1ONVIhc+fYc
 0tAPJlFXu25Vb5OYNe7VTN4/RFSzYBddPtd98wT5I7BLT42/8d7+yGIVw3yOvalQHRfeoda251R
 576BlxmKxu/aeleVTgi+ljwYBwme6LYqe2RYEbv7MKnWo1gPzlpaBazjY63WcFMMnpwqRstrHcc
 hxFo/yh6qnxtEA9OXlXLe6GIew0Oj8MVnCSJ9gEZ5iX0QGbiv4BUB7xJXelFOifGw2ol2Qpv2bS
 AJ1s0GWn5A2g8BHQ4=
X-Received: by 2002:adf:f392:0:b0:432:5bf9:cf22 with SMTP id
 ffacd0b85a97d-4325bf9d1admr18151076f8f.3.1766827120484; 
 Sat, 27 Dec 2025 01:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF773MeYjm1VFhIvuqc0SdmBm93iIJm/C7LnADvueQnLpyqyVnsRFxQGn2AmV14dYskkJ1Wg==
X-Received: by 2002:adf:f392:0:b0:432:5bf9:cf22 with SMTP id
 ffacd0b85a97d-4325bf9d1admr18151057f8f.3.1766827120041; 
 Sat, 27 Dec 2025 01:18:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm50858965f8f.4.2025.12.27.01.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 070/153] subprojects: add probe crate
Date: Sat, 27 Dec 2025 10:14:57 +0100
Message-ID: <20251227091622.20725-71-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The probe crate (https://crates.io/crates/probe) provides a probe!()
macro that defines SystemTap SDT probes on Linux hosts or does nothing
on other host OSes.

This crate will be used to implement DTrace support for Rust.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20251119205200.173170-4-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 scripts/archive-source.sh                     |  1 +
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 .../packagefiles/probe-0.5-rs/meson.build     | 22 +++++++++++++++++++
 subprojects/probe-0.5-rs.wrap                 |  7 ++++++
 6 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 create mode 100644 subprojects/probe-0.5-rs.wrap

diff --git a/rust/meson.build b/rust/meson.build
index 76e10699b37..afbeeeb47a7 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -4,6 +4,7 @@ subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
 subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
+subproject('probe-0.5-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
@@ -11,6 +12,7 @@ bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
 glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
+probe_rs = dependency('probe-0.5-rs')
 
 subproject('proc-macro2-1-rs', required: true)
 subproject('quote-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 8f97b19a088..a37acab524e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -41,6 +41,7 @@ subprojects=(
   keycodemapdb
   libc-0.2-rs
   libvfio-user
+  probe-0.5-rs
   proc-macro-error-1-rs
   proc-macro-error-attr-1-rs
   proc-macro2-1-rs
diff --git a/scripts/make-release b/scripts/make-release
index bc1b43caa25..5f54b0e7939 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -42,7 +42,7 @@ fi
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
-  libc-0.2-rs proc-macro2-1-rs
+  libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index c00c8478372..011ce4dc3b7 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -16,6 +16,7 @@
 /glib-sys-*
 /itertools-*
 /libc-*
+/probe-*
 /proc-macro-error-*
 /proc-macro-error-attr-*
 /proc-macro*
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
new file mode 100644
index 00000000000..e6ea69533b7
--- /dev/null
+++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
@@ -0,0 +1,22 @@
+project('probe-0.5-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.5.2',
+  license: 'Apache-2.0 OR MIT',
+  default_options: [])
+
+_probe_rs = static_library(
+  'probe',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+)
+
+probe_deps = declare_dependency(
+  link_with: _probe_rs,
+)
+
+meson.override_dependency('probe-0.5-rs', probe_deps)
diff --git a/subprojects/probe-0.5-rs.wrap b/subprojects/probe-0.5-rs.wrap
new file mode 100644
index 00000000000..73229ee1c29
--- /dev/null
+++ b/subprojects/probe-0.5-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = probe-0.5.2
+source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
+source_filename = probe-0.5.2.tar.gz
+source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
+#method = cargo
+patch_directory = probe-0.5-rs
-- 
2.52.0


