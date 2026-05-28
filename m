Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A239CD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 00:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSOJy-0007wo-5w; Wed, 27 May 2026 20:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOJw-0007wD-1r
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:09:56 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOJu-000607-1j
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivJl7HZylL+k1CGlgTQLvjsgkob9mlkPYYwIyDoBPvxQPiuQQnk8Ku2p7F+MJvBgFFjFG3AAH9AAEXu0YaVP9SMXeBlfegC1CWcpg3Xx6mwMnlNwX1yxH5/UuswlVCvowrqp0eHYTkEl5x++Pv+JOIqIKZTmyYPjPt4SO06KdKBYgzs/+VO4883/zkLhUX0DW2jkMuWad1rUOABnStm/Jx+zWoow+sBZE3xd1dLNARI5z9WC377vdebSNxDRVAljvFH4XTxnm+0c9eDLkWppfCnE04nhu6RCLIyv8gjLUYpK2fj5um1iFja3dxXtrJJSj30vlWX7SS5lmkiOStPSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J68FecJVV8fCCDwnfwyI6YB+T5NYCyuPTmO4qh6UgAw=;
 b=fBYTq4sYtABEbPA6ROeDhiS246J5K5RavU0GyHlFrWfvqP1k29+CUKkVauJ3qrAEaj3PFb5zQyCgqziHFVEcewPV/+uu4PgKegjZ3jhAQHj4X+NYqonHVAnFB0JxqaNxeH5YPml4KfKTBg3LJ+zzSnxBEU25Badyc/8YbZACGeWYL4NEvnkvsEAqw+G8NUmvu/WA4APYG/VQWiuDO+C0eAFB42TS1Q2zUEFtoJ7tfuDGMVIvbm6vg27eVBFDvAalueJsjEmw0hB6eSNQAy9JfxYuGKvATGTFCUkW7/cJntsdWI5UiGY6tE9CWPeFwo5LMmTQo5lurj9o3/sgc0PA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J68FecJVV8fCCDwnfwyI6YB+T5NYCyuPTmO4qh6UgAw=;
 b=IWsU4HO7immpkqKmiS28GWunu8q8wmYEYmfu0Jo3D0XfrONP/GN+yFyzl01cLxPPBgQ91/BFs7uIucuxVaJlsIE3YgnDuYx8ZznKb8V/1oHWb34LLlfP28/27+T6DAEbjuE4h3jFAttQIv9cD6RqfpCI/ScSu/Fd+BDyDqBJWt4=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:09:45 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::9b) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 00:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:09:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:09:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 07/12] accel/kvm: Move post-conversion updates to a
 separate helper
Date: Wed, 27 May 2026 19:03:32 -0500
Message-ID: <20260528000416.8161-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b509a89-3a75-4416-262f-08debc4d6cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YspS30bY3ck8gUe8fOIr/drFcYCBbm/8KSN3M0nmyd6xQhGIf4MLOdwD9D28IgkBIfgA2FZwET9g4PUixXC11PcGZpYG0Sc+QcfnSYQqnhwSiVN5uSyKRa0BNGZqj6LfEzIYgqMkD5XN4vBoSKmboT8CFjHKKEqOwz/WgMW4vyluAe08fAZJB2BjXMSpzpXxu0MWi2MLS6G8vHV01jehlqxIQ6ia3Lv08XkrL1qb6zlSL4DprRvzVTrBgBoK7mCJsNzBjNAXrC5VsH9lapOPT6K9M/aMoyXQDjWas3PqaVZNHxom+I2Ctitdh5EieaSAgfXEEw/iTcXm02IweGsZRyUvXmzUu4GBKKUOZxhNWJGX+IfFOWxOkN9gRAz96s2OLuD+btzGUR+gtwzhcTC2lth3ud+kL9eKBlfWKkMjE11982g9DQkNVZsxUpLk0wHAaCgDKTddmGU502wPx1Aswe9298BmUip4SXhCYv8Dt5kfRm2NJ00PUj5KHfR0SdppQpSK5aVb8P8fnf3jh1sFbwEESflI4BtaWITKLe2WffP3TWlvTIbtoRa0oBdzry5ye8WkUKF1lprAnGzLn0pQQmHO0JDT2XxTbljIGtA+VGmK6DlwGa00N4w+t/o9dLvbczsjd9Ao9GznmwgB5q+Eo3xTEPXt6so0LtHD3h/EY8pAmQ4HwVyp3r366lIB9SE3F6Oqc5S9Qgk8cyS513VbdhCslGLYABXhDz2UBNJS0ZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5yWWTmBDbeFfA+x1+K3BEXgIeAV6gxO9hNZ/UP/gnH1IqBF0wlMRMkbjSgBDQ8F/i7bmGYUEhReDN0ktwkJb6yrrZE8/M4DoCMdTp0YrWefV+5ICsh09YAHu5JWKh5vN87POkLuJ1X/0htxD8e0RgvUI/p7oZ/Dxg6mXDUGFQRs7EkYXkVmxo9R61gxpVULowXMi3J/sw/ZQa076L13HLsAA+X8zLL6J70QvJ83ZBlm23Kp2V4Etam3AGhB/speRQLiE7fcZzm2CPQv7R7wtZjm6HdftG/44QcCYfiIohb/PCSdIiCPOcBsV+59Lv8pJGlaX7Z34VjECLTtuDuVYu5n1iINt4usRkjZ7n87ytt4FoHg6vOuWK4+OTtUUMceugFQfp5tJSd8fELO0qBuqQaFr/Lzjlypoc0qPfC9m9wLI9sLW1T8Lq3o8LnYa2Cyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:09:45.7390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b509a89-3a75-4416-262f-08debc4d6cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently memory attribute conversions are followed up by other
bookkeeping tasks like discarding unused memory or issuing iommufd
notifications. Move these tasks to a separate post-conversions helper to
better compartmentalize and track these tasks, and in doing so lay the
groundwork for a pre-conversion helper which will be needed in the
future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a1832712a4..0e6ff2de4b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3445,20 +3445,26 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
     hwaddr size = int128_get64(section->size);
-    MemoryRegion *mr = section->mr;
-    ram_addr_t offset;
-    RAMBlock *rb;
-    void *addr;
-    int ret = -EINVAL;
+    int ret;
 
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
-    if (ret) {
-        return ret;
-    }
+
+    return ret;
+}
+
+static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
+{
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    void *addr;
+    int ret;
 
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
@@ -3485,7 +3491,7 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
-    return ret;
+    return 0;
 }
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
@@ -3533,6 +3539,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         }
 
         ret = kvm_convert_section(&section, to_private);
+        if (ret) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_post_convert_section(&section, to_private);
         memory_region_unref(section.mr);
 
         if (ret) {
-- 
2.43.0


