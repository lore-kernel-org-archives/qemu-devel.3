Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D963D2E9C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPxf-0006hN-HG; Mon, 11 Nov 2024 03:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxE-0005xQ-Vb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:25 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxC-0003UY-PY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314363; x=1762850363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vl6xxV8v/QZLbvpsYXDFXJDoSnwigLDUJ9JPfYXQmxU=;
 b=X21LHanmv/O6bZmxrVYHUUjZAW+Z3eiCJfX1cGl/VYktsy3mHBKfJRJ1
 uw5/KJ+qZ7JxsSnxZyfO+EAQYxUerG3p1/FHfxyK5EZjwBepYOc87e++o
 qtT+5D824A18vuexcSm/+13CIypfP2941RRdx+ewy4E8UUBzUIhJoYm5j
 sJRVhG9mVbKN9MiRek3HT//meBQoPlElo/GbczhCLfaTC6e2nvpuyYmQh
 G+J1k3OwRd9qG3y7Hd4EPwg/tXmNbc4Wr/DQtJ94u7HV8C2Qh2Pzwh9Sk
 6BsYkMVc6wveuCBFD8ZlKbjl7WsQ4wifNQFkOwSyOBB6U/PcXJHcdehy3 w==;
X-CSE-ConnectionGUID: 6xmbc2weS0qJCpA46eK0Kw==
X-CSE-MsgGUID: M/cGQEQ/THC6jwcuR5LOQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334579"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334579"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:22 -0800
X-CSE-ConnectionGUID: s2HYfXPvTx6bIRmP/lTtkg==
X-CSE-MsgGUID: ZOb/W9M5Ss6ND7ZBVSL8cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608425"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v5 17/20] tests/acpi: q35: Update host address width in DMAR
Date: Mon, 11 Nov 2024 16:34:54 +0800
Message-Id: <20241111083457.2090664-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Differences:

@@ -1,39 +1,39 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/x86/q35/DMAR.dmar, Mon Nov 11 15:31:18 2024
+ * Disassembly of /tmp/aml-SPJ4W2, Mon Nov 11 15:31:18 2024
  *
  * ACPI Data Table [DMAR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping table]
 [004h 0004   4]                 Table Length : 00000078
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 15
+[009h 0009   1]                     Checksum : 0C
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   1]           Host Address Width : 26
+[024h 0036   1]           Host Address Width : 2F
 [025h 0037   1]                        Flags : 01
 [026h 0038  10]                     Reserved : 00 00 00 00 00 00 00 00 00 00

 [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definition]
 [032h 0050   2]                       Length : 0040

 [034h 0052   1]                        Flags : 00
 [035h 0053   1]                     Reserved : 00
 [036h 0054   2]           PCI Segment Number : 0000
 [038h 0056   8]        Register Base Address : 00000000FED90000

 [040h 0064   1]            Device Scope Type : 03 [IOAPIC Device]
 [041h 0065   1]                 Entry Length : 08
 [042h 0066   2]                     Reserved : 0000
 [044h 0068   1]               Enumeration ID : 00
 [045h 0069   1]               PCI Bus Number : FF

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/x86/q35/DMAR.dmar           | Bin 120 -> 120 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 46f80be9ca..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/DMAR.dmar",
diff --git a/tests/data/acpi/x86/q35/DMAR.dmar b/tests/data/acpi/x86/q35/DMAR.dmar
index 0dca6e68ad8a8ca5b981bcfbc745385a63e9f216..0c05976715c6f2f6ec46ef6d37790f86a392b5ea 100644
GIT binary patch
delta 21
ccmb=Z;BxVG460yYU|{5#$R)+7KT$Op05(qqk^lez

delta 21
ccmb=Z;BxVG460yYU|<xT$R)+7Hc>Sg05*ICk^lez

-- 
2.34.1


