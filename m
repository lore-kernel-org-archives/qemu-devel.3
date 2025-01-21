Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6061CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taEWP-0007Nm-JG; Tue, 21 Jan 2025 08:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEWF-0007My-HF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:42:16 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taEWD-0005Sf-O9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737466933; x=1769002933;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MZB7qv2zEFLJ0rFzdkMC19zKNxW1JIUku/QSmxpL4G8=;
 b=JAF1spCyI+nLA9IbtKRs5FAF/R4t0wl9FIiDudGj9In5X9RszxQ085Kk
 S1gs/CVFDA9w8brWy3X3Y0zqHdqFLtxQM6ZrjsR+7L4ISotOz68GFMMn3
 UaCtKqcCgvx5uucacMIe3VqoNo7Ux20LFNBUi3MO0vOMs5hOrjmO22kuL
 KvepYXqMcbCyS0a6NNZdXo4hVL6MTDJR4aRD9EHsb/m/iDvim6AUxJyt+
 4+ZgvT0wwUlknzVXnQrJJT7Q7HWZFT8C9XWn5s92jrO94xqjOWNXKUyvv
 9bQt4veLqdXQvePMi6y/Mrb9vr1Z+hl0qzCXrF+Yr5m4N1dyNC0IFsDRO g==;
X-CSE-ConnectionGUID: MWpiQKV8Te2tnCPvfOTUHw==
X-CSE-MsgGUID: neA9OuKDRlCbY4LEAZzcuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37793650"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="37793650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 05:42:09 -0800
X-CSE-ConnectionGUID: JJYT/Lc4TqKe6/oAZdKrgQ==
X-CSE-MsgGUID: Jk93buC+RlaJe0oR5arLFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="107411954"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 21 Jan 2025 05:42:07 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH RESEND] i386: Only configure HPET firmware info when HPET is
 enabled
Date: Tue, 21 Jan 2025 22:01:21 +0800
Message-Id: <20250121140121.84550-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

At present, the hpet_cfg is written unconditionally since 40ac17cd56eb
("pass info about hpets to seabios.]"), because it concerns ACPI HPET is
created unconditionally.

But that fact has changed since 51124bbfd2ea ("i386: acpi: Don't build
HPET ACPI entry if HPET is disabled") and ACPI checks if HPET device
exists in (hw/i386/acpi-build.c).

Therefore, configure HPET firmware information if and only if HPET is
enabled.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Resend:
 * Resend the patch since it was missed on https://lore.kernel.org/qemu-devel/.
---
 hw/i386/fw_cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 91bf1df0f2e4..d2cb08715a21 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -149,7 +149,14 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
 #endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+#ifdef CONFIG_HPET
+    PCMachineState *pcms =
+        (PCMachineState *)object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE);
+    if (pcms && pcms->hpet_enabled) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    }
+#endif
+
     /* allocate memory for the NUMA channel: one (64bit) word for the number
      * of nodes, one word for each VCPU->node and one word for each node to
      * hold the amount of memory.
-- 
2.34.1


