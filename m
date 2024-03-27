Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086D3CD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQUz-0007n9-4G; Wed, 27 Mar 2024 06:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQUC-0007NB-3Z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:24 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQU4-0007aA-JB
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711535176; x=1743071176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ykBXsEkK2ADVVDuf1AFicY9uXXOp9HytuDaW5JJ5N2Q=;
 b=BEOFsGLsrTQcTZO8K2PWqSRNpHVx+kU+62QoX/5yiPCKMCcNBaGNMLYS
 CvJ68bFtRWGlKPgCvx+9ldo9c6jzPkdZp7TXTujsQCSVQQ60w+DiXGgEk
 4dksTlj1cNADg0LnuC9FYUJ/AbvK/9WAlW/LqiFYKcNXNr/kwFHYzgjHZ
 8mCDgaqhak6jrTckJZsZqWHPU0mfYzfdZX0C8MXosBSThbnImzACxapPD
 62im6Yz+GSrzKnWCjWmo6SzL8lcj00MWs1I2y+xDRQ/d6l3KYKUUTS8M/
 BJ8KDoln1wQ5R8rtuQR/ZC3fcx6XFLEZ1pQUTTViPZT98ku+8tvOtNZH5 w==;
X-CSE-ConnectionGUID: +hclnJ5NSY6Gx2CQWYwTNg==
X-CSE-MsgGUID: iAOsyJ2pSeOibG/2V9oSrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6489754"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6489754"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 03:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16354469"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 03:25:58 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] target/i386/host-cpu: Consolidate the use of
 warn_report_once()
Date: Wed, 27 Mar 2024 18:39:49 +0800
Message-Id: <20240327103951.3853425-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
References: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Use warn_report_once() to get rid of the static local variable "warned".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/host-cpu.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 92ecb7254b83..280e427c017c 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -55,18 +55,15 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
     uint32_t phys_bits = cpu->phys_bits;
-    static bool warned;
 
     /*
      * Print a warning if the user set it to a value that's not the
      * host value.
      */
-    if (phys_bits != host_phys_bits && phys_bits != 0 &&
-        !warned) {
-        warn_report("Host physical bits (%u)"
-                    " does not match phys-bits property (%u)",
-                    host_phys_bits, phys_bits);
-        warned = true;
+    if (phys_bits != host_phys_bits && phys_bits != 0) {
+        warn_report_once("Host physical bits (%u)"
+                         " does not match phys-bits property (%u)",
+                         host_phys_bits, phys_bits);
     }
 
     if (cpu->host_phys_bits) {
-- 
2.34.1


