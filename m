Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA9D5B164
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpD-00031N-8M; Tue, 29 Oct 2024 04:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp9-00030B-RR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:35 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp8-00081u-69
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191414; x=1761727414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2A5Haq33d7m1AJtNI3w75MshOhOiNodMu4lutbKPFLg=;
 b=CG9PVb+GcRSCAVshL/3Ch26wTV1/vnKGSXK164MpdNkkN+H9GOsapB0y
 zPLd32tFl3J2TzNeh9nuvgR5gNMCTBIe0UTgFcrAKMIpkn/hPpvWHi6Ev
 9UDViP34mM2Mls6WdVfKaI/eJEizg5CexDfXDKhEcSHMfPTAxapQ11LlA
 rWu0RBea77QY8/Dv5ScnV/sh31PmjkSk0GZIzbc3rRDBvzUd9e2NYpFYB
 O17hH8W4KoEtgumvXXr7Z1FD+cTe86o3QHIUJ9MIM76WJhoUefk2n2sCB
 z0JffSiyUdlgMWMyLfu62VzHeZl2niAI/PCG8JTWJRPcvMsLHJa3Y5Zl/ w==;
X-CSE-ConnectionGUID: lQfL1ipNQNuk9XDU+GR8sA==
X-CSE-MsgGUID: 9hKntnrLR1aC7Y2hNPr3ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592799"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592799"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:33 -0700
X-CSE-ConnectionGUID: 1HaF+PFOR3S9Z3x7B4yr6g==
X-CSE-MsgGUID: 8cduvls7RO+cgaCGOguJYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847177"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:31 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/16] hw/scsi: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:24 +0800
Message-Id: <20241029085934.2799066-7-zhao1.liu@intel.com>
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

Replace type_register() with type_register_static() because\
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/scsi/megasas.c | 2 +-
 hw/scsi/mptsas.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 221b06d6aaf6..b72d2f8cdf39 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2586,7 +2586,7 @@ static void megasas_register_types(void)
         type_info.class_init = megasas_class_init;
         type_info.interfaces = info->interfaces;
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 361b75e633ae..c6bc3479e997 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1450,7 +1450,7 @@ static const TypeInfo mptsas_info = {
 
 static void mptsas_register_types(void)
 {
-    type_register(&mptsas_info);
+    type_register_static(&mptsas_info);
 }
 
 type_init(mptsas_register_types)
-- 
2.34.1


