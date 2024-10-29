Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22409D5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpB-00030X-A6; Tue, 29 Oct 2024 04:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp9-0002zs-1x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:35 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hp7-00082C-6Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191413; x=1761727413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3szCOy0+zAlrtzzT6GSA9q6eiS5v3qx/Ef32mg+t+JM=;
 b=Y/NFllQd3phUcs7L3ewCDBH+P7/Jhrn3ct36+HwGxU4bCdVYSDoMgpF7
 XPfl5mxak/W4Rg9YMY+NwQm9LSdvEoXu8vHmuy/pIalX4AHSimjHrwD0W
 DWXCGqJYk0HMpblyhvx6Vk6yZpOY5m3wg6QoLpOhJcRac+ZSZNp3INSyk
 JDwyUCLLZ6pYWTaqqlM0HFMd5+Iubf7ILRwDFWBk2zD6mL97HXMTiKUQJ
 VQAw3HbTB4AKRZum9P+HCCFcREelHdkFxzSgmC1C8eT8OTRoyECE02HhQ
 LRjGRgzpl/WrD1AGf47xnvh7VPuGLWQeiaAKfGg2OAXvPH+c8DxnMkh6C A==;
X-CSE-ConnectionGUID: 8BiaZvViTlegTASLCp0xkA==
X-CSE-MsgGUID: p2SekVdDRTu5hGMldD8mRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592782"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592782"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:30 -0700
X-CSE-ConnectionGUID: 2D+cpfsrS9GmG97DdBOg+g==
X-CSE-MsgGUID: dqC65bORQYqF5fXYEXSVIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847163"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:28 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/16] ppc: Replace type_register() with type_register_static()
Date: Tue, 29 Oct 2024 16:59:22 +0800
Message-Id: <20241029085934.2799066-5-zhao1.liu@intel.com>
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
 hw/ppc/spapr.c   | 2 +-
 target/ppc/kvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c10a70a48ee..81bc4c5c44c1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4826,7 +4826,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
         MACHINE_VER_DELETION(__VA_ARGS__);                           \
-        type_register(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
+        type_register_static(&MACHINE_VER_SYM(info, spapr, __VA_ARGS__));   \
     }                                                                \
     type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3efc28f18b39..0d464824dbcb 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2633,7 +2633,7 @@ static int kvm_ppc_register_host_cpu_type(void)
         return -1;
     }
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
-    type_register(&type_info);
+    type_register_static(&type_info);
     /* override TCG default cpu type with 'host' cpu model */
     object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE,
                          false, NULL);
-- 
2.34.1


