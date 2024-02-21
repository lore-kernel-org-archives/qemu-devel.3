Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A80FC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rch1T-0008OL-Ck; Wed, 21 Feb 2024 02:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rch1N-0008NM-2g; Wed, 21 Feb 2024 02:28:01 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rch1F-0008UM-Do; Wed, 21 Feb 2024 02:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708500474; x=1740036474;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3JICSjf6M0kKgsolTp8ey2+2CcYHO111m7nPgLVo5Xw=;
 b=RUrAOgpPf496ZzQk5zzLEaaSclBY/Gf+ZBhIe9BHhp2vuQ/T3aelb+vj
 YmttMthRmK4AqGYj07zYxB6p8nnTphJssfM7qY26TrQFkG91Y4VmAMFfC
 4McnsYoUAhQ4X+ngkSU8ViuhHCmo+8QK6Zbwoc4TXUyrJ91ftJ4nTM2ho
 HfqC+La3RaR8bS72I7FTfgxWR0IcH2OPfHuyWvwqFajcMp7orvH28xhd/
 LOeXaMxia7cfbr7Lc3aA3lEPIGxwmD4Z4Q79j23GseF0r3OQOTYyG8mI1
 KgZ2IWNu1AXvv5wwV4y9wTyi+lWsRekSL/WqRklk+lFI3yJErb/rryVg0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13347368"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; d="scan'208";a="13347368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 23:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="4982749"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 20 Feb 2024 23:26:16 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2] hw/intc: Handle the error of IOAPICCommonClass.realize()
Date: Wed, 21 Feb 2024 15:39:48 +0800
Message-Id: <20240221073948.768828-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

IOAPICCommonClass implements its own private realize(), and this private
realize() allows error.

Therefore, return directly if IOAPICCommonClass.realize() meets error.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v2: Add the missing ERRP_GUARD(). (Markus)
---
 hw/intc/ioapic_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf6214608..efbe6958c8d7 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
 
 static void ioapic_common_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
     IOAPICCommonClass *info;
 
@@ -162,6 +163,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
 
     info = IOAPIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->io_memory);
     ioapic_no++;
-- 
2.34.1


