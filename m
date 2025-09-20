Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946CECAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkt-000837-Sv; Sat, 20 Sep 2025 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkn-000806-NH; Sat, 20 Sep 2025 11:44:01 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkl-0001zC-6g; Sat, 20 Sep 2025 11:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383040; x=1789919040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=waLJ79Z2ZxPOvRkgcef2yGkHILtwcEpwytE2aQ9sNt8=;
 b=YEWnuszib5UMpc1h/HilWL9FleJ6Erb95MRrpcUpuS1xV/BgpsPsWqOA
 zhlV2GKsifRcdM+NNvMsLYQkv5q5EMTkmwgdqGQimXfDAe76Mys4PTYl0
 yF1JjvgYh1pKpwXEjnTPKtfHiN3GN/LI6i7neOVP7xkPAJCeVw3hnxdGK
 Qf3m4PvpVk7Ah3Sc0BSYVQQnuEk9akLuTnuqefGV8sbzJyLtpMeAd7dur
 TTu/9IzPdd4X8cTsXb6CB/eVAPOVVWn9ifPWyuBgu/e/Zslzk4SW2ur8x
 zIj4yAtr6lWb9/NJkpmqBvtvZblt8qhSmorHg6yPPlMwp8BxcqNoFb5Xn Q==;
X-CSE-ConnectionGUID: /i1VSowERXiuUVXmvPcsXg==
X-CSE-MsgGUID: SvicmQXPRDiAQCapeS4y0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955565"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955565"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:55 -0700
X-CSE-ConnectionGUID: JUtPN4YgSFGqR4wfx+Vu4A==
X-CSE-MsgGUID: INZI3f0rR8i1Gn75AuY84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349485"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:53 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 10/12] rust/hpet: Clean up type mismatch for num_timers
 property
Date: Sun, 21 Sep 2025 00:05:18 +0800
Message-Id: <20250920160520.3699591-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

Now `num_timers` is `usize` other than `u8`. Although the type field in
`declare_properties` macro hasn't been used, it's better to explicitly
point this out and clean up this before doing other property work.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3cfbe9c32bb1..fce75415579d 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -909,7 +909,7 @@ impl ObjectImpl for HPETState {
         HPETState,
         num_timers,
         unsafe { &qdev_prop_usize },
-        u8,
+        usize,
         default = HPET_MIN_TIMERS
     ),
     define_property!(
-- 
2.34.1


