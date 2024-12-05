Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C25FE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4kA-0006HP-BX; Thu, 05 Dec 2024 00:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k8-0006Gq-Rx; Thu, 05 Dec 2024 00:49:40 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k7-0007B2-8i; Thu, 05 Dec 2024 00:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377779; x=1764913779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IJWVRmzDJbwLIewLn+CtruGga6G97lX0CrTx7B/D3+Y=;
 b=JFoXl8P+62lRYZ7A7KSO6teEYKWCJ6135aHN4O6oaBWm78vtY+QIq5eP
 34s3G129f5o36QjYMhRQ0YxfVAgZMe6chj6E/O492MScQ7i76nvaewH+l
 OMnEZZAchCbDQMoGOkvBqFFcRqvyT3ZisTsxQoeYrmpKAqiJI61Z88Muy
 JwB9l9U6o7wKBAfRZnSb6SbllG6jj5TEAATxlt5GH04gJw9Kf4GUAd0Os
 Okxq8YEhcPXH45TxKx7CGtkBkCygT2LUcd+PY8qEY4q7ouLi5qy/14Xuw
 fiPXQant3Mj6ch2v+qWCDwW7CLb5saBWAAH6F8XVHOPZqGSQSORpfoWww Q==;
X-CSE-ConnectionGUID: E16kPp3iTbWRjADTenzmhA==
X-CSE-MsgGUID: ZIQ9ZfDCQcGggArrJ8p1Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815661"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:38 -0800
X-CSE-ConnectionGUID: fjnL5WZoSYmotje8jHaYog==
X-CSE-MsgGUID: tlA4ynduSDCkWUaLwRA7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455043"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:35 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 08/13] rust/qdev: add the macro to define bit property
Date: Thu,  5 Dec 2024 14:07:09 +0800
Message-Id: <20241205060714.256270-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

HPET device (Rust device) needs to define the bit type property.

Add a variant of define_property macro to define bit type property.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/qdev.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 5e6580b6f261..66810803ec9d 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -103,6 +103,18 @@ fn class_init(dc: &mut DeviceClass) {
 
 #[macro_export]
 macro_rules! define_property {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
+        $crate::bindings::Property {
+            // use associated function syntax for type checking
+            name: ::std::ffi::CStr::as_ptr($name),
+            info: $prop,
+            offset: $crate::offset_of!($state, $field) as isize,
+            bitnr: $bitnr,
+            set_default: true,
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    };
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-- 
2.34.1


