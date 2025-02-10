Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9600C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJjr-000076-TN; Sun, 09 Feb 2025 21:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjo-00005O-Tm; Sun, 09 Feb 2025 21:41:32 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJjm-00087n-VJ; Sun, 09 Feb 2025 21:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155291; x=1770691291;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hb1E+rvhbzGMqxScQskJB9sjdylpqfV6pPId6e63v94=;
 b=TECYSYuRLpxyJ3U0nyltU/OjVP6w0S2wHQEvjQSiEGgj5jL+FxS/bHW9
 5oDXr0da9tDSXyx+J+H0tCwNxfApkmQhjA33ADMRAZxrrdu0VK8yGJvAh
 9X9VtY3N96luubYcSLi/mwKfvGrBXzG8u30bp6ZAtNPF0VEinSiL99eyh
 mllLL27u2/d+Bns/laMLfxsjjG+MlOPj/lLLmg4eg/MGvi/4c+stN0pB8
 +BkxaWAs4oBgZuFQepZZk0fUSyKnhdJOzjB8pT2aMUQENCkha2PfCXEqm
 XujU9nohE6bNMKuUzDHmy/Jc0+wiXZmUDU10Wuuf18M8YQDIYc8+vnezv Q==;
X-CSE-ConnectionGUID: gaKGANCZTJ+f+Pw+sVpwpg==
X-CSE-MsgGUID: q0okhtYBQHGcutl/rmgvtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351245"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351245"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:29 -0800
X-CSE-ConnectionGUID: +oR4jyecR3WQe0niqKW6dw==
X-CSE-MsgGUID: QLOleOOuS1K0Z9ZIXkeC6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938209"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:27 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 02/10] rust/qdev: add the macro to define bit property
Date: Mon, 10 Feb 2025 11:00:43 +0800
Message-Id: <20250210030051.2562726-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

HPET device (Rust device) needs to define the bit type property.

Add a variant of define_property macro to define bit type property.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/qdev.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 0041c66ed0cd..28d9be723d89 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -168,6 +168,18 @@ fn class_init(dc: &mut DeviceClass) {
 
 #[macro_export]
 macro_rules! define_property {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
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
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-- 
2.34.1


