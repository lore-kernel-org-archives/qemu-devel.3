Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF3CE77172
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4ki-0006hR-Jo; Thu, 05 Dec 2024 00:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kf-0006hB-IG; Thu, 05 Dec 2024 00:50:13 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kd-0007Br-Vx; Thu, 05 Dec 2024 00:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377812; x=1764913812;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=163co5V0L2579CPnezHoIN6M6o+8Ub2IEuDw5h91upg=;
 b=NQ6uXEqbVLoAUbOjEUPGdnNctckrpBFjWhdDctDYWW4qPU125T3n128y
 JA5TdGaVp5Hf/dOIzdS2xOKrE9QLunz6ykVBHu0mnlEH8JavL3BNaSNpB
 AcS10vOYuzcPoT0P6BvGJa3TRClXEVv4f34u5z3AWqrv8SiT3dURXDbOk
 CvyMqoHRMdo3VcwvGsXdwMETTTBiGW5JDkmnrNopKbBEW8Rt9FWiKGSLJ
 8TKaPfCQnFf9GPQZo/ddhNN3+XEyaxDxh6jlwAUIPw2Qawgda17rNUXVq
 b3tFXH5hJnzPA7PzbncVB2CzK2B2MV97BM+3TEju0tzb6EQWlS6gGZyqp g==;
X-CSE-ConnectionGUID: +hsGLYkXQ2OL0aFkY3ii9w==
X-CSE-MsgGUID: o+Ln+NEkTQSyKDySWTCzHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815692"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815692"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:51 -0800
X-CSE-ConnectionGUID: 8xZHD59IRnCk5pAw4SIMyA==
X-CSE-MsgGUID: aBSIfJ1iRxC2OFMTQQoN+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455084"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:49 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 13/13] i386: enable rust hpet for pc when rust is enabled
Date: Thu,  5 Dec 2024 14:07:14 +0800
Message-Id: <20241205060714.256270-14-zhao1.liu@intel.com>
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

Add HPET configuration in PC's Kconfig options, and select HPET device
(Rust version) if Rust is supported.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/Kconfig       | 2 ++
 hw/timer/Kconfig      | 1 -
 rust/hw/Kconfig       | 1 +
 rust/hw/timer/Kconfig | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 rust/hw/timer/Kconfig

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 32818480d263..83ab3222c4f0 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -39,6 +39,8 @@ config PC
     select PCSPK
     select I8257
     select MC146818RTC
+    select HPET if !HAVE_RUST
+    select X_HPET_RUST if HAVE_RUST
     # For ACPI builder:
     select SERIAL_ISA
     select ACPI_PCI
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index c96fd5d97ae8..645d7531f40e 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -11,7 +11,6 @@ config A9_GTIMER
 
 config HPET
     bool
-    default y if PC
 
 config I8254
     bool
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
index 4d934f30afe1..36f92ec02874 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,2 +1,3 @@
 # devices Kconfig
 source char/Kconfig
+source timer/Kconfig
diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
new file mode 100644
index 000000000000..afd980335037
--- /dev/null
+++ b/rust/hw/timer/Kconfig
@@ -0,0 +1,2 @@
+config X_HPET_RUST
+    bool
-- 
2.34.1


