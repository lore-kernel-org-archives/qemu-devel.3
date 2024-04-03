Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C487ACD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs27g-0007WS-Ru; Wed, 03 Apr 2024 11:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rs27f-0007Vn-CP
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:01:55 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rs27d-000804-3N
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712156512; x=1743692512;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D3XkFY15FONloZazI+Rbvga3vbPIX7g2r+yqtCRWlZ4=;
 b=PE7H4ps4VKJr74DBhDiwXqDnBNbURR4SIzjOIyWgAmwcSIeVkGRhNL2I
 dwSx+eBjDOWGXV43fCsW2Col3mawfvPq74VHXEf0H+chima9CI3VqxXwD
 M64Bto8JNYKZdD5OcqjXFx+7SQkXV+y3WXMeuTUiLdYzGXyGrILdY3Iau
 xgxk9+2rSbPCdMbT9vVCH4iLg8300crD+Fxc8OzJdGN/rGDvp/mRIYntc
 hTOgWPlSw4SQn9QqVlqlKrfPd18lLdVieEsnvEZK6/R2+yoNiZpT3uJjd
 mkBoe3e4bvF0dyBMRgeKp+4aqMeO9biqVlLdrEYR/WIhGXsmf5EyolKj8 Q==;
X-CSE-ConnectionGUID: aE1wUEU3STaNdp38GjQaOQ==
X-CSE-MsgGUID: 7lTq2X8KRX+QQrIFygOIAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7580697"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7580697"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 08:01:19 -0700
X-CSE-ConnectionGUID: eV4/DiT5Tb6Us32Ao4er2Q==
X-CSE-MsgGUID: eysoPt5+TqS1hQP1X9KINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; d="scan'208";a="18289674"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa010.jf.intel.com with ESMTP; 03 Apr 2024 08:01:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, isaku.yamahata@intel.com,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Date: Wed,  3 Apr 2024 10:59:53 -0400
Message-Id: <20240403145953.3082491-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
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

A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.

When PIC is not enabled (pic=off) for x86 machine, the PCAT_COMPAT bit
needs to be cleared. Otherwise, the guest thinks there is a present PIC.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v2:
- Clarify more in commit message;
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


