Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE7BCD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPu-0005SY-Hb; Wed, 12 Nov 2025 23:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPS-00056f-9U; Wed, 12 Nov 2025 23:58:16 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPQ-0001c6-BZ; Wed, 12 Nov 2025 23:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009892; x=1794545892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JJO7Uy5utj+c6O5L1yTosvifZImBMCxlVXThZW9Y0ZQ=;
 b=VZ5GVP7NtwdKRzf7XBHk3dsTWiIeWkHjC7tA5MU/+/0X3CZ2a40Z65Xw
 yPFKU0tyHx3WsbJxoPu115Q09SQCPC0BalNhXm/x53BPdILQ5Kl4Bay/g
 Fg5vCuubpDIEJTVXn8I/07h505mx0oqcjaqrbof4X7VUagPh62RYEYW7m
 uJFM1kGTOFOhpt7QahZmCYoMQNV1vYVpxU3+VdT0UCVxAE1H9c7rgpJ1+
 LUeUE60guCvxP8SEZuRJiu3YECGBfgcersN3eWZYuGBKDlUI6Gj1G7Yh7
 fMk7qBx4vMR0iptqr0R7TGMsG+WBP86drqP0G5RJagitsWNNDG9hvOzoX A==;
X-CSE-ConnectionGUID: J6zK7P61TleS6sgMPpCL8Q==
X-CSE-MsgGUID: 3hanE8UySt+3FwMDGMhjEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682135"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682135"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:53 -0800
X-CSE-ConnectionGUID: xkcwPd2yTC+9RTIsoZ7GgA==
X-CSE-MsgGUID: DkmRB5jqQSWg8AIOCe+jNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663283"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:51 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 15/22] rust/hpet: Explicitly initialize complex fields in
 init()
Date: Thu, 13 Nov 2025 13:19:30 +0800
Message-Id: <20251113051937.4017675-16-zhao1.liu@intel.com>
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

Explicitly initialize more fields which are complex structures.

For simple types (bool/u32/usize), they can be omitted since C has
already initialized memory to all zeros and this is the valid
initialization for those simple types.

Previously such complex fields (InterruptSource/BqlCell/BqlRefCell) were
not explicitly initialized in init() and it's fine, because simply
setting all memory to zero aligns with their default initialization
behavior. However, this behavior is not robust. When adding new complex
struct or modifying the initial values of existing structs, this default
behavior can easily be broken.

Thus, do explicit initialization for HPET to become a good example.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index bd673a1d0110..1bef94e560f6 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -737,6 +737,18 @@ unsafe fn init(mut this: ParentInit<Self>) {
             HPET_REG_SPACE_LEN,
         );
 
+        // Only consider members with more complex structures. C has already
+        // initialized memory to all zeros - simple types (bool/u32/usize) can
+        // rely on this without explicit initialization.
+        uninit_field_mut!(*this, regs).write(Default::default());
+        uninit_field_mut!(*this, hpet_offset).write(Default::default());
+        // Set null_mut for now and post_init() will fill it.
+        uninit_field_mut!(*this, irqs).write(Default::default());
+        uninit_field_mut!(*this, rtc_irq_level).write(Default::default());
+        uninit_field_mut!(*this, pit_enabled).write(Default::default());
+        uninit_field_mut!(*this, num_timers_save).write(Default::default());
+        uninit_field_mut!(*this, hpet_id).write(Default::default());
+
         Self::init_timers(&mut this);
     }
 
-- 
2.34.1


