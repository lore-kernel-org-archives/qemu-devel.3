Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B50D5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hp9-0002zm-1r; Tue, 29 Oct 2024 04:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp6-0002yO-OD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:32 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp4-000823-Ab
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191410; x=1761727410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=18pQ9+SfnSigWSBylZF9eBI8bbh5P/JEEPJ4cx3fM/A=;
 b=VR6GhBUiM5QBLvXtx5ChGYQ/On7FnATKKQN83oDZZwfueA6SsIgqiAC/
 Oh3TlQqgeltQIrw5dxDFSA74mIvqzrBy3YATVKl6jyaPUsUE0yAu/ExKA
 LtaxW3Dxf8WF3DmXNqNTR88nkQjBv/fgJPHXuug0E4B+i/uubbF4PsBXw
 oCMuDyQgTq7clz4Sh4JJgdvou121iF2YJorXdGthBcZkL2CZFolpK4Nc0
 kU9q4oCt1c2bGZ2RoDlLoyXPpMN0yZt9/Wa9VmzbGcrfVmYdtGwJ76KGE
 rWB21t76/Dc4DLr8FZl0Gt0/XRWgpJFpWE8Oxy+KjCkHp6dZ1wbbEgS0y w==;
X-CSE-ConnectionGUID: bXbGLT+nQB6dFtb6zBLrsQ==
X-CSE-MsgGUID: ekISJSmsS7iE15cF/v3zNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592770"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592770"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:25 -0700
X-CSE-ConnectionGUID: q1TPc99zQ6OUBM19J8sHfQ==
X-CSE-MsgGUID: +VW8Tz3wRAmRqD2ApeHdjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847110"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:24 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 01/16] arm: Replace type_register() with type_register_static()
Date: Tue, 29 Oct 2024 16:59:19 +0800
Message-Id: <20241029085934.2799066-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/arm/armsse.c    | 2 +-
 hw/arm/smmuv3.c    | 4 ++--
 target/arm/cpu.c   | 2 +-
 target/arm/cpu64.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 255346a595a7..58ed504b2bc3 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1731,7 +1731,7 @@ static void armsse_register_types(void)
             .class_init = armsse_class_init,
             .class_data = (void *)&armsse_variants[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4c49b5a885f1..6e847e8773d8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2065,8 +2065,8 @@ static const TypeInfo smmuv3_iommu_memory_region_info = {
 
 static void smmuv3_register_types(void)
 {
-    type_register(&smmuv3_type_info);
-    type_register(&smmuv3_iommu_memory_region_info);
+    type_register_static(&smmuv3_type_info);
+    type_register_static(&smmuv3_iommu_memory_region_info);
 }
 
 type_init(smmuv3_register_types)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1320fd8c8fea..38ad3fcacd33 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2738,7 +2738,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register(&type_info);
+    type_register_static(&type_info);
     g_free((void *)type_info.name);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 458d1cee0120..c1cac912a088 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -841,7 +841,7 @@ void aarch64_cpu_register(const ARMCPUInfo *info)
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
-    type_register(&type_info);
+    type_register_static(&type_info);
     g_free((void *)type_info.name);
 }
 
-- 
2.34.1


