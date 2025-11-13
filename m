Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BC9CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPH-0004xV-Uj; Wed, 12 Nov 2025 23:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOr-0004k7-UF; Wed, 12 Nov 2025 23:57:41 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOm-0001cD-9P; Wed, 12 Nov 2025 23:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009852; x=1794545852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2S5WatjIoZmc7FdySy+887bRnIi9jDxZtOKrzrC+ftk=;
 b=h1DZ5Lnph4DsIIGCJZfwGOGfS7zSlCtcvyomDKWZ7mAAkomr7RCfz3EO
 rSECi0oqGFVtuSTtYJ4GP9n4H3nr5dAzMGnMmaHcZp8Zhr0IDYEd5Smwg
 QUXUBuODPc37WhC3Xw4vOJnw7clSQM6vph7JjWey9CLZ9TYKIMA5SAx2V
 C7q+XjGvmCRqREwSor33w4ixfHABLJcQDsnCX4xr2uPxI2WGphx6ZwSXs
 xQyrwZYv5aQKAqtxM2FL8X4Mz1uS5YB7u2UpTNZxQpA1dDItMtmc/J3XV
 jEOjbhMsw1nG3F7prVsyrcXqy9vDhnyfs12/N2ZFfgahrxN31mejR4rvU w==;
X-CSE-ConnectionGUID: ZZn/7L1TRne8T81pgFGcHA==
X-CSE-MsgGUID: 7JQ762OGS0qjwAo6uKqE6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682067"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682067"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:28 -0800
X-CSE-ConnectionGUID: z3N6LOWLQ0OKBNXQDI9+Fw==
X-CSE-MsgGUID: 0Oyf85xnQHSJ8Fa+1T5lKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663229"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:26 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/22] rust/migration: Check name field in
 VMStateDescriptionBuilder
Date: Thu, 13 Nov 2025 13:19:18 +0800
Message-Id: <20251113051937.4017675-4-zhao1.liu@intel.com>
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

The name field is necessary for VMStateDescription, so that it's
necessary to check if it is set when build VMStateDescription.

Since is_null()/as_ref() become rustc v1.84 and pointer cannot cast to
integer in const, use Option<> to check name with a new field in
VMStateDescriptionBuilder instead.

This can be simplified in future when QEMU bumps up rustc version.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/migration/src/vmstate.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 267f9c8e053a..8087f10832f1 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -530,7 +530,11 @@ macro_rules! vmstate_subsections {
 unsafe impl<T: Sync> Sync for VMStateDescription<T> {}
 
 #[derive(Clone)]
-pub struct VMStateDescriptionBuilder<T>(bindings::VMStateDescription, PhantomData<fn(&T)>);
+pub struct VMStateDescriptionBuilder<T>(
+    bindings::VMStateDescription,
+    Option<*const std::os::raw::c_char>, // the name of VMStateDescription
+    PhantomData<fn(&T)>,
+);
 
 #[derive(Debug)]
 pub struct InvalidError;
@@ -591,7 +595,7 @@ fn from(_value: InvalidError) -> Errno {
 impl<T> VMStateDescriptionBuilder<T> {
     #[must_use]
     pub const fn name(mut self, name_str: &CStr) -> Self {
-        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
+        self.1 = Some(::std::ffi::CStr::as_ptr(name_str));
         self
     }
 
@@ -717,13 +721,16 @@ pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
     }
 
     #[must_use]
-    pub const fn build(self) -> VMStateDescription<T> {
+    pub const fn build(mut self) -> VMStateDescription<T> {
+        // FIXME: is_null()/as_ref() become const since v1.84.
+        assert!(self.1.is_some(), "VMStateDescription requires name field!");
+        self.0.name = self.1.unwrap();
         VMStateDescription::<T>(self.0, PhantomData)
     }
 
     #[must_use]
     pub const fn new() -> Self {
-        Self(bindings::VMStateDescription::ZERO, PhantomData)
+        Self(bindings::VMStateDescription::ZERO, None, PhantomData)
     }
 }
 
-- 
2.34.1


