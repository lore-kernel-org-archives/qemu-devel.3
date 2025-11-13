Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9936CCCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPP5-0004me-E4; Wed, 12 Nov 2025 23:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOl-0004jP-Es; Wed, 12 Nov 2025 23:57:38 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOi-0001cD-EO; Wed, 12 Nov 2025 23:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009848; x=1794545848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BKH9yA0Qsz9LGfsXOTzX4oGoyTFGK6vx/kuKBMBwGWM=;
 b=cGVuKEx86YVkTM8svIgXLcegf+FHIIfYFqLZAmaSWOMVHHGtSWVBhFlg
 FfRiOIfMv0OZFUIhx2FpQVqXzwEKzxPBEyxKgBEBrwgU3yuWawZqQHxwJ
 i0TzO9MTEvfkdKkfr8IsbL45QwBLEIZcObFRi+SyqJ4BsAc2ByzLyn8L8
 4JxBOF+10QUzqbJctZPGRk2Ti/hYMisxq2kPPN64RxwBkSXXNWFJyjEsP
 NnqAHtNGSJRqgPFFT4x/wdYNnyneG5qFrbddxhYHdBw+UtZFRmaWV+lmi
 1ExOpTvhSkK/pUx1UOwuizT0mGhBUcQCwp0JM2+NWjsn/lVgexXOiKYE3 g==;
X-CSE-ConnectionGUID: /nAR2q1eTWiyEkBNEHD3FA==
X-CSE-MsgGUID: xwODB0oVRPu7k9VkUEIZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682060"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:25 -0800
X-CSE-ConnectionGUID: kTv2e95pS9OSuHnji7HjUg==
X-CSE-MsgGUID: jvJdE8owTp2G2pgcvnz4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663223"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:23 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/22] rust/migration: Add Sync implementation for Migratable<>
Date: Thu, 13 Nov 2025 13:19:16 +0800
Message-Id: <20251113051937.4017675-2-zhao1.liu@intel.com>
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

It's common to define MemoryRegionOps<T> and VMStateDescription<T> as
static variables, and this requires T to implement Sync.

Migratable<T> is usually embedded in device state, so it's necessary to
implement Sync for Migratable<T>.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/migration/src/migratable.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index ded6fe8f4a6c..5c47c7d1c2fa 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -340,6 +340,9 @@ pub struct Migratable<T: ToMigrationStateShared> {
     runtime_state: T,
 }
 
+// SAFETY: the migration_state asserts via `BqlCell` that the BQL is taken.
+unsafe impl<T: ToMigrationStateShared + Sync> Sync for Migratable<T> {}
+
 impl<T: ToMigrationStateShared> std::ops::Deref for Migratable<T> {
     type Target = T;
 
-- 
2.34.1


