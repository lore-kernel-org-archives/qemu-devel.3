Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13353CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPC-0004tx-Kb; Wed, 12 Nov 2025 23:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOt-0004kA-Mr; Wed, 12 Nov 2025 23:57:41 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOq-0001cQ-0I; Wed, 12 Nov 2025 23:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009856; x=1794545856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vrtq2f7EYKo1Y2JQdaB4jUwdVNa0g270/cI5G1Tsp7g=;
 b=JrwDsB3ki9F1i3/jHgDA7+uxeHpTnmQDyXAQv3B3k1lO9NbBDkrSWMCt
 AHuo/mLOhsSxMrnLZmGHpyRmA7/mRoF+NGrhomZEuI1z7tuyUdW6ZecmW
 3YnXT4To6dLvKPBmdF/SJywvPe89fo+w+8eZGDw6VwI3Ks4Iiz+p+3z+e
 2z3Qj/8do/NohiZ4hqMvPcqH7uQN9vWsFasdwUyVijRTlBZeNxFJPBuGk
 cvxy1JMa3234Pn14d6OcYxE9xRQIBDaZiQHerCxJPkaj1j/StxFcTRxro
 P8SqS8PC2gaH8DSR2eHFbV78vr1lOTSx2EopeR9trrKEQDdLMQtvNpKCM A==;
X-CSE-ConnectionGUID: EWY9WMAZRWu7am9sh8+24g==
X-CSE-MsgGUID: ZJ97oRYtTqe1a8ZTTNDvfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682075"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682075"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:32 -0800
X-CSE-ConnectionGUID: d2DXnVfyTFmTkX6QMweQGg==
X-CSE-MsgGUID: jGDTgdXUQIaqiroSR4HDlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663238"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:30 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/22] rust/bql: Ensure BQL locked early at BqlRefCell
 borrowing
Date: Thu, 13 Nov 2025 13:19:20 +0800
Message-Id: <20251113051937.4017675-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At present, BqlRefCell checks whether BQL is locked when it blocks BQL
unlock (in bql_block_unlock).

But the such check should be done earlier - at the beginning of
BqlRefCell borrowing.

So convert BqlRefCell::borrow field from Cell<> to BqlCell<>, to
guarantee BQL is locked from the beginning when someone is trying to
borrow BqlRefCell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/bql/src/cell.rs | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 8ade7db629cf..0a436f7eb431 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -141,8 +141,10 @@
 //! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
 //! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
 //! thread will panic if these rules are violated or if the BQL is not held.
+#[cfg(feature = "debug_cell")]
+use std::cell::Cell;
 use std::{
-    cell::{Cell, UnsafeCell},
+    cell::UnsafeCell,
     cmp::Ordering,
     fmt,
     marker::PhantomData,
@@ -377,7 +379,7 @@ pub struct BqlRefCell<T> {
     // for std::cell::BqlRefCell), so that we can use offset_of! on it.
     // UnsafeCell and repr(C) both prevent usage of niches.
     value: UnsafeCell<T>,
-    borrow: Cell<BorrowFlag>,
+    borrow: BqlCell<BorrowFlag>,
     // Stores the location of the earliest currently active borrow.
     // This gets updated whenever we go from having zero borrows
     // to having a single borrow. When a borrow occurs, this gets included
@@ -426,7 +428,7 @@ impl<T> BqlRefCell<T> {
     pub const fn new(value: T) -> BqlRefCell<T> {
         BqlRefCell {
             value: UnsafeCell::new(value),
-            borrow: Cell::new(UNUSED),
+            borrow: BqlCell::new(UNUSED),
             #[cfg(feature = "debug_cell")]
             borrowed_at: Cell::new(None),
         }
@@ -688,12 +690,12 @@ fn from(t: T) -> BqlRefCell<T> {
 }
 
 struct BorrowRef<'b> {
-    borrow: &'b Cell<BorrowFlag>,
+    borrow: &'b BqlCell<BorrowFlag>,
 }
 
 impl<'b> BorrowRef<'b> {
     #[inline]
-    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRef<'b>> {
+    fn new(borrow: &'b BqlCell<BorrowFlag>) -> Option<BorrowRef<'b>> {
         let b = borrow.get().wrapping_add(1);
         if !is_reading(b) {
             // Incrementing borrow can result in a non-reading value (<= 0) in these cases:
@@ -789,12 +791,12 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 struct BorrowRefMut<'b> {
-    borrow: &'b Cell<BorrowFlag>,
+    borrow: &'b BqlCell<BorrowFlag>,
 }
 
 impl<'b> BorrowRefMut<'b> {
     #[inline]
-    fn new(borrow: &'b Cell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
+    fn new(borrow: &'b BqlCell<BorrowFlag>) -> Option<BorrowRefMut<'b>> {
         // There must currently be no existing references when borrow_mut() is
         // called, so we explicitly only allow going from UNUSED to UNUSED - 1.
         match borrow.get() {
-- 
2.34.1


