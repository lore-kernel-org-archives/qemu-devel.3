Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03266CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnb4-000628-Vl; Tue, 28 Oct 2025 13:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnb1-00060F-Hs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnau-0004QF-29
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWhg4MaiEkP19owK+TL8EIAXAKrNBH/O36emy6V+FXk=;
 b=JwuX43pliSs9td+mOD7oFpFfMNe/A0AdPnuhmarawnenEszfyPuOCZGYr1+0ZR6OJqiotz
 gN7pS2+4s+EolkaoStmq11F1iwxi8PefMWua/QNzpo35b3+d16Rwdosopi3XsxFw99v026
 xT0ys2+uenQZOtvBwdll5h6Fcdh2JN4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-bXLm-HM4OL2LddTCeTizGA-1; Tue, 28 Oct 2025 13:34:46 -0400
X-MC-Unique: bXLm-HM4OL2LddTCeTizGA-1
X-Mimecast-MFC-AGG-ID: bXLm-HM4OL2LddTCeTizGA_1761672886
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-427013eb71dso5750646f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672884; x=1762277684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWhg4MaiEkP19owK+TL8EIAXAKrNBH/O36emy6V+FXk=;
 b=jBILrFQTxynFP0Abn8id2qu5QZppudelIHOTUyyR+gIgUlWtrp3tmjlyqXC6PSxDcp
 7Fhy1sFfHqIEyU8cbc6nlSqB00WsoS4yWxooDtoTbOXyOd+m+feYRSExgboodqnja6RB
 NFEC4Xxe7OTMyF0Qb8MgdbQxoZa4BtZNYyj5/JIbeHtIHCc28ID8AOTqgOUvbDFLU3fQ
 J8lyKF8DWy+9/MXr8tGSPn4PLf+Hj4GxLEuvN+FlVFD2WGT/XGO5yhEBO3R0ahOjG98J
 5sinxH9gjjRjTt4vJNWvVJzf85cebqcFsZrvCA7LW5+hCMIfRrrptAeF9dlL6XhBIKDQ
 1Qmg==
X-Gm-Message-State: AOJu0Yx7/VWXuUC9EeWlPVZTbGoyZyusm3h+m7qVyCggKvIWJmgowP2m
 OLh2zL7uL5HIY7tM2650v5AQ0TazcPV3exP+XAfjTS1i5iVfY0kU/vaXZ7N6QqYrpxGkKVVjqp2
 45T8PopdVGjkPUtHpo762HVvF1CnKKcczcxXEM35ZUCNG88tZwybp319lknvnFMhSUuSN5n/6CF
 GtSvuk1ZlJ0lWEpl2t8YD7s+jtWucm/Us9jkO73Zj6
X-Gm-Gg: ASbGncsDzOfqblBt9DPUlxJ2EX0KeXVGVMlcbAffmVukPV12ysL343Pb0npy41WrIHS
 jgBROctIF4xd1kXMw2DleAqGv6Fl1u14ecPXNdSdBXH6KIHBQFcvmDitkysco4H1XgdEYd+lBK6
 0eeKGN/nASqLyZk7TnSCh3Fej0HIN+quPoGYudfgk2OQM1jTOsaVnK8qix48RqxHg4/zyF6rX7h
 Fo4rheGVEyj1UAmfpNBM2lQRm7B8nw4q1fAEVptw+G6TkEZ2XL4wLbw67YAF2OrlnT3KcrJeo+n
 k1sNp1FcPu0pM1dKVkQHVlmXr4BUQDWzFyUFXWnfUgRzDME83B75x9MdF6hMKbqkdOn0Id5Qwoi
 qAmpTM8oOuytaQOgqsKMKXGSSvD0C5nnimRlbCEaHmk1uK/IiG2gEgZGix3TlHIUzEXmjI+LcHw
 oClKQ=
X-Received: by 2002:a05:6000:2406:b0:428:55c3:cea7 with SMTP id
 ffacd0b85a97d-429a7e79ffbmr4019170f8f.36.1761672884560; 
 Tue, 28 Oct 2025 10:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtbOdFGCYuJvgqEV0Ta/yLKwHU4SUwRUPD3XBDT5MZ6nyB2sYUL//tatzc4zfdY97r09lP3A==
X-Received: by 2002:a05:6000:2406:b0:428:55c3:cea7 with SMTP id
 ffacd0b85a97d-429a7e79ffbmr4019144f8f.36.1761672884082; 
 Tue, 28 Oct 2025 10:34:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm21379479f8f.28.2025.10.28.10.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/18] rust: remove useless glib_sys bindings
Date: Tue, 28 Oct 2025 18:34:16 +0100
Message-ID: <20251028173430.2180057-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

The definition of types needed for g_autolist(), g_autoslist(),
g_autoqueue() need the imports for GList, GSList and GQueue
to appear everything.  Rust code is never going to see those,
since they are not used in structs.  Block the types from
appearing in the bindings.

Co-authored-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                        | 1 +
 rust/bql/src/bindings.rs           | 4 +---
 rust/chardev/src/bindings.rs       | 4 ++--
 rust/hw/char/pl011/src/bindings.rs | 2 +-
 rust/hw/core/src/bindings.rs       | 4 +---
 rust/migration/src/bindings.rs     | 2 +-
 rust/qom/src/bindings.rs           | 2 +-
 rust/system/src/bindings.rs        | 4 ++--
 rust/util/src/bindings.rs          | 2 +-
 9 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index c5710a6a47c..8ad37c992b1 100644
--- a/meson.build
+++ b/meson.build
@@ -4251,6 +4251,7 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/include/.*',
     '--allowlist-file', meson.project_build_root() + '/.*',
     '--blocklist-file', glib_pc.get_variable('includedir') + '/glib-2.0/.*',
+    '--blocklist-type', '.*_([a-z]*autoptr)$',
     ]
   if not rustfmt.found()
     if bindgen.version().version_compare('<0.65.0')
diff --git a/rust/bql/src/bindings.rs b/rust/bql/src/bindings.rs
index 8c70f3a87ce..c656cf18845 100644
--- a/rust/bql/src/bindings.rs
+++ b/rust/bql/src/bindings.rs
@@ -18,9 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{
-    guint, GArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue, GSList, GSource,
-};
+use glib_sys::{guint, GArray, GHashTable, GHashTableIter, GPollFD, GPtrArray, GSList, GSource};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/chardev/src/bindings.rs b/rust/chardev/src/bindings.rs
index c95dc89c56d..63bfbb8ce66 100644
--- a/rust/chardev/src/bindings.rs
+++ b/rust/chardev/src/bindings.rs
@@ -20,8 +20,8 @@
 
 use common::Zeroable;
 use glib_sys::{
-    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GList, GMainContext,
-    GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc,
+    gboolean, guint, GArray, GHashTable, GHashTableIter, GIOCondition, GMainContext, GPollFD,
+    GPtrArray, GSList, GSource, GSourceFunc,
 };
 
 #[cfg(MESON)]
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
index 52a76d0de5c..654be9185b1 100644
--- a/rust/hw/char/pl011/src/bindings.rs
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -22,7 +22,7 @@
 
 use glib_sys::{
     gboolean, guint, GArray, GByteArray, GHashTable, GHashTableIter, GIOCondition, GList,
-    GMainContext, GPollFD, GPtrArray, GQueue, GSList, GSource, GSourceFunc, GString,
+    GMainContext, GPollFD, GPtrArray, GSList, GSource, GSourceFunc, GString,
 };
 
 #[cfg(MESON)]
diff --git a/rust/hw/core/src/bindings.rs b/rust/hw/core/src/bindings.rs
index 65b9aae7536..730d5b28a3c 100644
--- a/rust/hw/core/src/bindings.rs
+++ b/rust/hw/core/src/bindings.rs
@@ -20,9 +20,7 @@
 
 use chardev::bindings::Chardev;
 use common::Zeroable;
-use glib_sys::{
-    GArray, GByteArray, GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList, GString,
-};
+use glib_sys::{GArray, GByteArray, GHashTable, GHashTableIter, GList, GPtrArray, GSList, GString};
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
 use system::bindings::MemoryRegion;
diff --git a/rust/migration/src/bindings.rs b/rust/migration/src/bindings.rs
index 24503eb69bd..e9c058386c2 100644
--- a/rust/migration/src/bindings.rs
+++ b/rust/migration/src/bindings.rs
@@ -19,7 +19,7 @@
 )]
 
 use common::Zeroable;
-use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
+use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/qom/src/bindings.rs b/rust/qom/src/bindings.rs
index 91de42f2426..e61259ec2ef 100644
--- a/rust/qom/src/bindings.rs
+++ b/rust/qom/src/bindings.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSList};
+use glib_sys::{GHashTable, GHashTableIter, GPtrArray, GSList};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/system/src/bindings.rs b/rust/system/src/bindings.rs
index 6cbb588de3d..ddccfe0436f 100644
--- a/rust/system/src/bindings.rs
+++ b/rust/system/src/bindings.rs
@@ -20,8 +20,8 @@
 
 use common::Zeroable;
 use glib_sys::{
-    guint, GArray, GByteArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GQueue,
-    GSList, GString,
+    guint, GArray, GByteArray, GHashTable, GHashTableIter, GList, GPollFD, GPtrArray, GSList,
+    GString,
 };
 
 #[cfg(MESON)]
diff --git a/rust/util/src/bindings.rs b/rust/util/src/bindings.rs
index c277a295add..3514a66f5fa 100644
--- a/rust/util/src/bindings.rs
+++ b/rust/util/src/bindings.rs
@@ -18,7 +18,7 @@
     clippy::too_many_arguments
 )]
 
-use glib_sys::{guint, GList, GPollFD, GQueue, GSList, GString};
+use glib_sys::{guint, GPollFD, GString};
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
-- 
2.51.1


