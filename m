Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8508CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPP8-0004pI-KC; Wed, 12 Nov 2025 23:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOp-0004jo-AZ; Wed, 12 Nov 2025 23:57:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOi-0001cQ-P3; Wed, 12 Nov 2025 23:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009849; x=1794545849;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y/Z27usq9NO6Gx7PFhdqImE5l1fhD5PaRWTiCqUeEvA=;
 b=lwBJcJhgpS5MYkqvArLq/cMzbPcONPe2zVhNK3sZENWztgyxmBHct16M
 X+s2wpRRvLhSQNHE7+gAf8G0T1ZXV23DHX4whz5/kVyu3jY5Wd0QwFQvp
 FbCUORtY1NEvTv7K01toOnzmKzhtcZler/+FjL550gdR3ZXYkb4KHt0nF
 uDnrN5IGBfNs3fHQuHROWV99CKCZZWiTMLq0w6+zDZAGHgVCECnqpqUJY
 87K594t0n86fqMvdvo3vHuF0EoWQdpHJ0WcWfVLxrVP4PQ4h95U7ahVqm
 Zp8AZTWNHa51uCQyrAJStMkRS3VnOJFODM9m6ghZdA9lSdBsxpxl2O8G2 g==;
X-CSE-ConnectionGUID: K2YArIYARR2QDopMwmSdZQ==
X-CSE-MsgGUID: 8AdaWV7pSmCC7xNI4n5DNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682064"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:27 -0800
X-CSE-ConnectionGUID: u+7KslJrTmqe+3Kv3s9kjQ==
X-CSE-MsgGUID: cZlBZ7KgQ7eISp8U0fI/7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663226"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/22] rust/migration: Fix missing name in the VMSD of
 Migratable<>
Date: Thu, 13 Nov 2025 13:19:17 +0800
Message-Id: <20251113051937.4017675-3-zhao1.liu@intel.com>
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

The VMStateDescription of Migratable<T> missed the name field, and this
casused segmentation fault in vmstate_save_state_v() when it tries to
write name field by json_writer_str().

Due to the limitation of const, a custom name based on type would be
more difficult. Instead, a straightforward and simple approach is to
have all Migratable<T> instances use the same VMSD name -
"migratable-wrapper".

This is availiable because Migratable<T> is always a field within a
VMSD, and its parent VMSD should have a distinct name.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/migration/src/migratable.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index 5c47c7d1c2fa..76e524774a3c 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -421,7 +421,11 @@ impl<T: 'static + ToMigrationStateShared> Migratable<T> {
         Migratable::<T>::FIELD
     };
 
+    // All Migratable<T> instances share the same name. This is fine because
+    // Migratable<T> is always a field within a VMSD. The parent VMSD has the
+    // different name to distinguish child Migratable<T>.
     const VMSD: &'static bindings::VMStateDescription = VMStateDescriptionBuilder::<Self>::new()
+        .name(c"migratable-wrapper")
         .version_id(1)
         .minimum_version_id(1)
         .pre_save(&Self::pre_save)
-- 
2.34.1


