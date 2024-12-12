Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A811E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLemT-00060Y-Jl; Thu, 12 Dec 2024 03:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLemO-0005jk-Jy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:41 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLemM-00084H-V5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992959; x=1765528959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dvW/9USk/3KOBVQvwVDQoO+8iMOV0d5XqkhqHEYwI8g=;
 b=WEFEAnsfOYWfdlcfZKD1Jlp6qs5YXr0THuXDg6gygtvBKAZSsrptpxUK
 emFxevtWKarZ2fy6FrasJpC7x2aIj6Tihrfa/CcZ/1NiGLqIfSZmGQg51
 lmNgPDAspJGK6aOn/AfOX/XfCP0/l/eo27NHJ4oKN+rIHdvCFXcOCrglF
 4/wVOdYvPYdW06lWdRQJi4zq0jRp8BHt3Cnh697HPQkL6vdcwc4vspgpO
 Y9sW9flqgd84jQj07Dzxmt6BC2BhlUXCm/cMnc5JWBo1NURl22zyujwtz
 5y8qkigrLdFc33zjC7G1AixvberDUH7EgH9mlGnqzML9xuCA9AwuAZzWA w==;
X-CSE-ConnectionGUID: wiw4MnROSnSYdioYqB4F6w==
X-CSE-MsgGUID: oKcOA4U6Tu26mZB8WZ9w2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34125019"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34125019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:28 -0800
X-CSE-ConnectionGUID: TPnbZIFGS3CVc2qVLJ5O+A==
X-CSE-MsgGUID: 2kCMvmHwTiKVREbuPSSPqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407204"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:42:24 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v6 17/20] tests/acpi: q35: Update host address width in DMAR
Date: Thu, 12 Dec 2024 16:37:54 +0800
Message-Id: <20241212083757.605022-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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
Acked-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
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


