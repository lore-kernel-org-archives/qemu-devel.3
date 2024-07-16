Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2A6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWe-0000B1-72; Tue, 16 Jul 2024 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWN-000064-8i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:24 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWI-0007SW-Bi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721145315; x=1752681315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ORQtPOUjRaH7fq192/3Uf+CcJuvKVSUruZo9xOxKbJw=;
 b=UyfVZ7bnkBlv/IWk4o4cBXhK6e/YbYQJ+8reW3uVfkDM38Cl0pGsu67r
 xciI1OhuDwCfoNDBEXzxM4+yRFcYBUYdw3dmp0ROwfHR4zaO3WPm+XQJs
 2lpqI+7BcxfrPx6qvqWVsGMMcRGG4KmdslomAVEbfhjW7iCBkGvC5dyQJ
 TtsJRnqMt2HgCHmzWkXDA0LUw7wW4ocXXXBgBU/ePlld3krlhww5arN4O
 RnZfpkPENlxTghEAdx7YBdQ1lwYCnsh7FgY1cwEHWwH6UPsijQrHvBXWH
 HEvulm5H5MatMMHNPbA9ZAd83M4XK3bESmgyZ0xjEkYtTo7EKBlOw7T03 g==;
X-CSE-ConnectionGUID: tTLxJbjxR6ylfQ7wRd6B7g==
X-CSE-MsgGUID: wvkroJ5NSYS1k/a8Oqa+FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18743697"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="18743697"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 08:54:52 -0700
X-CSE-ConnectionGUID: sX48Ry9oS9a3ksiDhRNKcg==
X-CSE-MsgGUID: IzrrmODeTFCDv39AExZSaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50788277"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 08:54:49 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 2/9] target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and
 MSR_KVM_SYSTEM_TIME definitions
Date: Wed, 17 Jul 2024 00:10:08 +0800
Message-Id: <20240716161015.263031-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

These 2 MSRs have been already defined in kvm_para.h (standard-headers/
asm-x86/kvm_para.h).

Remove QEMU local definitions to avoid duplication.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 86e42beb78bf..6ad5a7dbf1fd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -81,9 +81,6 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-#define MSR_KVM_WALL_CLOCK  0x11
-#define MSR_KVM_SYSTEM_TIME 0x12
-
 /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
-- 
2.34.1


