Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2582AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 08:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrZU6-0006VS-53; Tue, 02 Apr 2024 04:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrZU0-0006QK-JL
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:27:05 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rrZTe-0002Kk-GS
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 04:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712046402; x=1743582402;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oqRlFjM4Byuq2EoybXA7ZPwKzcwQB1899rGr0ET3fIQ=;
 b=cVFeOT8MgulserCbS8nB71qMHtIWfvo5di4ji1opsX7U8WsNOuzv3hon
 CdddBSpgvSC1VIEJHE9MItOcAhv3ciS6SSSxzrf9tMw8Rt3hrMuFWbTw8
 tmC1XQKdBkqNm5eMDLiY1E7cf387Uo81DpOCxwXRmgr5j3OcU9cnwIvM8
 jOXdTkNevcRKxlC2iV32l7/u0BjyJfDzGyw4P1piZ7JUv4R9/52Qm9fL2
 mTM8VFOstS77udfnLGKZNFltw/hUrAaYlObBAQI4+CmX1A0TEvT6shoab
 kuDwQg1sLYr9eSF2dhvqvK2ZDydJYRUmxxOqbW4LE3iP98Qol4sasEBt/ g==;
X-CSE-ConnectionGUID: /W0t8Y1+STaK8gfT66j94Q==
X-CSE-MsgGUID: 3pMWi8e/SIyrvTJfca9HWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="10987586"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="10987586"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 01:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="22657735"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2024 01:26:36 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	xiaoyao.li@intel.com,
	isaku.yamahata@intel.com
Subject: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Date: Tue,  2 Apr 2024 04:25:16 -0400
Message-Id: <20240402082516.2921143-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/acpi-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 20f19269da40..0cc2919bb851 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     acpi_table_begin(&table, table_data);
     /* Local APIC Address */
     build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
-    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
+    /* Flags. bit 0: PCAT_COMPAT */
+    build_append_int_noprefix(table_data,
+                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
 
     for (i = 0; i < apic_ids->len; i++) {
         pc_madt_cpu_entry(i, apic_ids, table_data, false);
-- 
2.34.1


