Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FBBC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoG-0003H5-9U; Mon, 14 Apr 2025 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko7-0003Cy-6S; Mon, 14 Apr 2025 10:29:08 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4Ko3-00065M-Qh; Mon, 14 Apr 2025 10:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640944; x=1776176944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JlwAJVaOBg0frrStuFTBGtDlgJ1sKkSJkiatM13LyxU=;
 b=PIi4NCBaiuYrsg767ldQ+eOevDtzJSpFI4Q/2Cm9qshI0BIVhsrHCohv
 ci7asuWClFhNbWbMigznQUk3D+LU4whXuJGp5l4HbWEveOUawEL5PTyVC
 XbeFYRd+rJNIYuA4a7BZK0Ivjm0XgpC+RshR+CkSmdbKRkgoPgRYgkXxk
 fXP6xkHRbs4X8rq0Nas3zk1iDHSpGMrvX4lr98zO5KcHxIhswEN0XzfzO
 JuTlVlFXoI3QUfBNeXZ5p+KN45LqyAqDhKvV0T61G4czWmo0Wzf6XgV60
 qJNfuFecHIdHX5U0n6lDKDN58Syzy9ig3bcqrUl7+57Fyc/TZJ+1uTGNM w==;
X-CSE-ConnectionGUID: aVFMbb1VQ2yDZaquUmePcA==
X-CSE-MsgGUID: 7Csf/RLkTG6mT3wsNZQIRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501833"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:01 -0700
X-CSE-ConnectionGUID: +STcyIIxSui3pHxv6GV9vQ==
X-CSE-MsgGUID: VS6LsYITTLCyssDbh4LqcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606059"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:28:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped in
 BqlCell
Date: Mon, 14 Apr 2025 22:49:36 +0800
Message-Id: <20250414144943.1112885-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently, if the `num` field of a varray is not a numeric type, such as
being placed in a wrapper, the array variant of assert_field_type will
fail the check.

HPET currently wraps num_timers in BqlCell<>. Although BqlCell<> is not
necessary from strictly speaking, it makes sense for vmstate to respect
BqlCell.

The failure of assert_field_type is because it cannot convert BqlCell<T>
into usize for use as the index.

Therefore, first, implement `From` trait for common numeric types on
BqlCell<>. Then, abstract the wrapper and non-wrapper cases uniformly
into a `IntoUsize` trait and make assert_field_type to get usize type
index via `IntoUsize` trait.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/assertions.rs | 30 +++++++++++++++++++++++++++++-
 rust/qemu-api/src/cell.rs       | 23 +++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index eb12e9499a72..232cac5b8dba 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -22,6 +22,34 @@ impl<T> EqType for T {
     type Itself = T;
 }
 
+pub trait IntoUsize {
+    fn into_usize(v: Self) -> usize;
+}
+
+macro_rules! impl_into_usize {
+    ($type:ty) => {
+        impl IntoUsize for $type {
+            fn into_usize(v: Self) -> usize {
+                v.try_into().unwrap()
+            }
+        }
+
+        impl IntoUsize for crate::cell::BqlCell<$type> {
+            fn into_usize(v: Self) -> usize {
+                let tmp: $type = v.try_into().unwrap();
+                tmp.try_into().unwrap()
+            }
+        }
+    };
+}
+
+// vmstate_n_elems() in C side supports such types.
+impl_into_usize!(u8);
+impl_into_usize!(u16);
+impl_into_usize!(i32);
+impl_into_usize!(u32);
+impl_into_usize!(u64);
+
 /// Assert that two types are the same.
 ///
 /// # Examples
@@ -101,7 +129,7 @@ fn types_must_be_equal<T, U>(_: T)
                     T: $crate::assertions::EqType<Itself = U>,
                 {
                 }
-                let index: usize = v.$num.try_into().unwrap();
+                let index: usize = $crate::assertions::IntoUsize::into_usize(v.$num);
                 types_must_be_equal::<_, &$ti>(&v.$i[index]);
             }
         };
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index ab0785a26928..d31bff093707 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -309,6 +309,29 @@ fn from(t: T) -> BqlCell<T> {
     }
 }
 
+// Orphan rules don't like something like `impl<T> From<BqlCell<T>> for T`.
+// It's enough to just implement Into for common types.
+macro_rules! impl_into_inner {
+    ($type:ty) => {
+        impl From<BqlCell<$type>> for $type {
+            fn from(c: BqlCell<$type>) -> $type {
+                c.get()
+            }
+        }
+    };
+}
+
+impl_into_inner!(bool);
+impl_into_inner!(i8);
+impl_into_inner!(i16);
+impl_into_inner!(i32);
+impl_into_inner!(i64);
+impl_into_inner!(u8);
+impl_into_inner!(u16);
+impl_into_inner!(u32);
+impl_into_inner!(u64);
+impl_into_inner!(usize);
+
 impl<T: fmt::Debug + Copy> fmt::Debug for BqlCell<T> {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.get().fmt(f)
-- 
2.34.1


