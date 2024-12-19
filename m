Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A152E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGp-0003k5-3s; Thu, 19 Dec 2024 11:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOGta-00072n-2G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:48:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOGtX-0000yG-BB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734616130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qn4mquEweZ71Z9jDJcuQq1s3l2ovJcdloeaI6PAZhIY=;
 b=OBUgyNVZWiKaNlDg6Ev+NjePdWQIaAM+rN2ltZTLVdMcHH7JU3SI/HSyQe9xmO6L4gXvIr
 +XtXJvVDU7ZChuqzZ7LbMUyQ5hBqHfpiShrBMb8mAWheqMdDDmDzidI6CeaqkHHZ4mTmVn
 OzlRj5Q3e0NlNPkUPZZCZVc7m+jdFmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-a_TJoLt7NOGzlZSuFarY-w-1; Thu, 19 Dec 2024 08:48:49 -0500
X-MC-Unique: a_TJoLt7NOGzlZSuFarY-w-1
X-Mimecast-MFC-AGG-ID: a_TJoLt7NOGzlZSuFarY-w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso6791315e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 05:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734616127; x=1735220927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qn4mquEweZ71Z9jDJcuQq1s3l2ovJcdloeaI6PAZhIY=;
 b=Y22LVlu91Oq1pbqTGVYooDLWFkx20fm0X9+kdnp+wKKgGaZeGy4gYCbIzEjuC4Yhe3
 UfwpDiLlycbAjrj79Pe+jkG58phcoOuAKebErYXdTyfDgzPmjDj+6q8BwR0gDFIkoHfV
 OljFAuJH7MSxDhYso+zs3J4tSVnYcSBWtAddpSRHtNWXbi2Cs4uR0z+OCWGAA/r2FyBi
 pmhjakl2z1SHgn+Df29T3NDYtQlhbcEPdbXYLiuSXuYyj5qzQwLZGw4nnAFrD2+nF2UY
 KsDTJ649ziyPtAAtgmgdRlPiioHJIctCDvzsaagJDDaABmebPt+1HG7+UFmoVXPrcY5M
 tcxQ==
X-Gm-Message-State: AOJu0Yz8l/3PuiNGppj539q4Psn+QIvbJ8b6Mwk/pDUQ6orKll5X61fO
 qAksukIpZ9e9ipXgKX/6otr+Sq4HveSAZFkIPPq7cdAJPnB4JUA4qDSV/QhHWh6rf7it3aZO3M9
 f9m1LU9HkKbv3QLxlc88KYWwUqLO+t9SeiNoDQWmonC69UyKVg7eYlzaXPL+lrDrV2dRN7pLnm2
 LfWPwgsLgdYXEHrTtIjmCojWPL0EMUIWDCEBq8
X-Gm-Gg: ASbGncs34UyqaHASJBd68dtHxp5a5USK8FEJ69eNBgyFbaf3zRNoBOOm94HGQIAugGk
 z2k6pbAIWi/ecTTiN/wLcxQJB77rXyTc4rkQhRbBoloNDQoMoEt0bWdyZjt+0kINLAx20z8xvHI
 jdSbmWVQAoQ+k/g60FFGJMvUt0txm2aVnZQ/pIjvEBnz8/wtl6+sE3U4fGDziciBqTUqAkSWKZF
 H1NUdcCfHwqHrsHk36aQRe28jd2BqGrGReNyAyy9TvRvdljWv3SLZOctG0O
X-Received: by 2002:a05:600c:3b23:b0:434:a684:9b1 with SMTP id
 5b1f17b1804b1-436553452f9mr63293465e9.4.1734616126782; 
 Thu, 19 Dec 2024 05:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmoaepJVMrUu55Nx90MG32ecMysRlQm8k6S6Ohz5xpxYumsO4Sw0un0me9jnRMsTeVZ/PCUg==
X-Received: by 2002:a05:600c:3b23:b0:434:a684:9b1 with SMTP id
 5b1f17b1804b1-436553452f9mr63293145e9.4.1734616126224; 
 Thu, 19 Dec 2024 05:48:46 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833155sm1588971f8f.24.2024.12.19.05.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 05:48:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/42] bql: add a "mock" BQL for Rust unit tests
Date: Thu, 19 Dec 2024 14:48:42 +0100
Message-ID: <20241219134843.443085-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219134843.443085-1-pbonzini@redhat.com>
References: <20241219134843.443085-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Right now, the stub BQL in stubs/iothread-lock.c always reports itself as
unlocked.  However, Rust would like to run its tests in an environment where
the BQL *is* locked.  Provide an extremely dirty function that flips the
return value of bql_is_locked() to true.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/main-loop.h  |  8 ++++++++
 stubs/iothread-lock.c     |  8 +++++++-
 rust/qemu-api/meson.build |  2 +-
 rust/qemu-api/src/cell.rs | 26 +++++++++++++++++++++++---
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 646306c272f..3935a573391 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -247,6 +247,14 @@ void event_notifier_set_handler(EventNotifier *e,
 GSource *iohandler_get_g_source(void);
 AioContext *iohandler_get_aio_context(void);
 
+/**
+ * rust_bql_mock_lock:
+ *
+ * Called from Rust doctests to make bql_lock() return true.
+ * Do not touch.
+ */
+void rust_bql_mock_lock(void);
+
 /**
  * bql_locked: Return lock status of the Big QEMU Lock (BQL)
  *
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 54676598950..6050c081f53 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -1,11 +1,17 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 
+static bool bql_is_locked = false;
 static uint32_t bql_unlock_blocked;
 
 bool bql_locked(void)
 {
-    return false;
+    return bql_is_locked;
+}
+
+void rust_bql_mock_lock(void)
+{
+    bql_is_locked = true;
 }
 
 void bql_lock_impl(const char *file, int line)
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 7ff408ad68e..50ec00e128d 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -60,7 +60,7 @@ test('rust-qemu-api-integration',
         dependencies: [qemu_api, qemu_api_macros],
         link_whole: [rust_qemu_api_objs, libqemuutil]),
     args: [
-        '--test',
+        '--test', '--test-threads', '1',
         '--format', 'pretty',
     ],
     protocol: 'rust',
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 28349de291a..eae4e2ce786 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -124,9 +124,18 @@
 
 use crate::bindings;
 
-// TODO: When building doctests do not include the actual BQL, because cargo
-// does not know how to link them to libqemuutil.  This can be fixed by
-// running rustdoc from "meson test" instead of relying on cargo.
+/// An internal function that is used by doctests.
+pub fn bql_start_test() {
+    if cfg!(MESON) {
+        // SAFETY: integration tests are run with --test-threads=1, while
+        // unit tests and doctests are not multithreaded and do not have
+        // any BQL-protected data.  Just set bql_locked to true.
+        unsafe {
+            bindings::rust_bql_mock_lock();
+        }
+    }
+}
+
 pub fn bql_locked() -> bool {
     // SAFETY: the function does nothing but return a thread-local bool
     !cfg!(MESON) || unsafe { bindings::bql_locked() }
@@ -220,6 +229,7 @@ impl<T> BqlCell<T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     /// ```
@@ -236,6 +246,7 @@ pub const fn new(value: T) -> BqlCell<T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -253,6 +264,7 @@ pub fn set(&self, val: T) {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let cell = BqlCell::new(5);
     /// assert_eq!(cell.get(), 5);
@@ -274,6 +286,7 @@ pub fn replace(&self, val: T) -> T {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     /// let five = c.into_inner();
@@ -293,6 +306,7 @@ impl<T: Copy> BqlCell<T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -315,6 +329,7 @@ impl<T> BqlCell<T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -333,6 +348,7 @@ impl<T: Default> BqlCell<T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlCell::new(5);
     /// let five = c.take();
@@ -461,6 +477,7 @@ fn panic_already_borrowed(&self) -> ! {
     ///
     /// ```
     /// use qemu_api::cell::BqlRefCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlRefCell::new(5);
     ///
@@ -472,6 +489,7 @@ fn panic_already_borrowed(&self) -> ! {
     ///
     /// ```should_panic
     /// use qemu_api::cell::BqlRefCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlRefCell::new(5);
     ///
@@ -513,6 +531,7 @@ pub fn borrow(&self) -> BqlRef<'_, T> {
     ///
     /// ```
     /// use qemu_api::cell::BqlRefCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlRefCell::new("hello".to_owned());
     ///
@@ -525,6 +544,7 @@ pub fn borrow(&self) -> BqlRef<'_, T> {
     ///
     /// ```should_panic
     /// use qemu_api::cell::BqlRefCell;
+    /// # qemu_api::cell::bql_start_test();
     ///
     /// let c = BqlRefCell::new(5);
     /// let m = c.borrow();
-- 
2.47.1


