Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B2AC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42qC-0002Q8-OY; Tue, 08 Sep 2026 16:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42pu-0002Ms-Cp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:54:42 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42ps-00071X-4U
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJKRZHNaTzm3Y2+lJk9c7AQ1ULcPYPsU5vx7JGw1HQq9/ofP0G7TE/t/5Kq+wB5aQm1VAwVpYDeWquKgnbG/Cz82QGsrpc6iqbVCZTLm9TRSZFPKmvRrE/QQAEl8m6/+KkpFH0BkU8Htb+0QR1dKqm94doWT2w22d0HHKxUSZK2i7rbZveC3VA9+CtMmQzTaws8SHai7qKsHAiqegMZZ3AvefxRvtN4lFH4BP6/bgPbo2nZR6i9ua3q2Y/lpEGHQx8u1IxVRsAm3YsuKNUvlD6QnC4G+HSD3lg4JpHgKRS+URGqBSugdykP82BxclHhiQb6I2NghFks7XC1aKKbr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A3fx22BjFILEGOnOCgXQYJanWV9QN2/jwNgofmQzwM=;
 b=qaQrtLRpxoJYkShAKta4bXmrjfv18rg4Gl1xNGegky5r/jQp6QKxV76BD2k31v5xrz3Sjv3M3BSxh0kGWwCicdtIfMFJ94RPoSGKab4cNLHtyvN9nfyT3p9nzYnS9oPhifYTMfMGP4qYAvyOTgW6wqNpSzCSH1LE9jn00BizpNo5ZXkJ/p4Fq/vinQV6vFIwmPsWJ4wkQAgH0fsr4a6d4cPJbv2aQDIX9IAdQmkl3I9+AoCkutN385Lq8YTslxYEjj0z50HNQeRuVGLMGexCt7cmVBb2ecIvvyEZ2TBcqrHsOlxX2p5H4O0fEsRmkT7vQf6jVFFVqTFoMqxI9GEsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A3fx22BjFILEGOnOCgXQYJanWV9QN2/jwNgofmQzwM=;
 b=cbwBqQG7SvzNeks3fqkepFjY5ngrLoegwKecCNw2EFf3sxxNCdEp2W2i71cAxkU+IoP4X9p5dkYfGjPVy5Z2agJfg5fn3TUlwSxfdNPBQ8Gq8tE35wwVB1LyVUberPaXr8no+DA1mgylJBTlBAi1ZW1P36N0MfgbdqQcil5vi4A=
Received: from CH2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:610:57::18)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 20:54:26 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::a5) by CH2PR12CA0008.outlook.office365.com
 (2603:10b6:610:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:54:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:54:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 11/19] accel/kvm: Move post-conversion updates to a
 separate helper
Date: Tue, 8 Sep 2026 15:48:31 -0500
Message-ID: <20260908205236.838281-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 03915917-c662-477e-80d6-08df0deb5d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|1800799024|376014|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MYmEEtgli54Vk7Ygi/3SuuZI0nUdM6wB59uZd8DgMs2mAs/IUv22VRqExN6rrAt/D8W/jVRpQYkJbHpj6BOsEgwSoMAoVcGG+PkW8IB9Qkc5yf4MDG6wUX20lLFgUyi39V6rZN0sPXKEmjyJGQzBUB1Vb8S+BL0RLK323qO5oQOoREmhG6D/ZCL4H7FCCEprBwsLJfrCdDaF1f4WhUG8oCn+f4IbEthNtzJw1w9IIXhtVQ5bPBQddiC2uxnJCG7S9xy/0ZtnD9P5thFtUtH+9qphpr9PwILIh8XXOvGEZH1AS4vNwTnaFAQilwxhptemc5iTKKdLyT6miiQCBCLou7iJc0kS2mY+Dw7u0ZQJPFDL4QUzWe/aHA1jvLLFHaOTd+6amoqA7ekW/ThS114KtbN6rpodI4Jm4gmvL3MjrxT0F4yeL37gKCcpg7laHV8vqfyN7+bSidYyeZqO/+Ho8GotjaDhNKsZZKobSxpG38FY/45jZAmkWxfZtu6RlDDwnM7FeDciq2S9yCUTUGuAlN16hgEjYBY5XsuDM9fZtjDAIZ+sYqJkmroF71xEVu6j+ci6HwRohyA2m2XTBpxO3m07fwHh9sXyHQK7UKqp5caRmyu6RYsu+n1B9Slj0UyRFH/V2O+H0gzD1pwHswTrUmELR8CXuJ7Y6LmmWm0igHL+7XTjFSCHHCMFW4nv/AQFjwzoRoEdQd7mz3WemAnN2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k6K2Q22viyC08WIix2mOHhW3UAcHMwnatklpbz458tAV56hge9OZ4TGWeY36uaZmcCKAxovZnxZD4W6XMz4HlymaKWS4hlVkAQ1/HnSuXPdvsX3gm5yyvALBB1fHM/ip2T6MwRA4iR1RV4NuNE1lPTtTFIwBV4HIA7qd7F/F9pvErQGo6S8Q4JLnb8aC0nqKJ8fSbUsRFEjkAV6t6dQDf4e7E0hxrbyNY0WadrpXykTEsboWNfrCgwBtKG7um2lzrV9Uoxep/v8cyxEVsY+SNzamSrxB7AqHWEufePYXRr9XHh1yyFnRnYXiktIx+4lBjG+DXhyCiNnGzO07sClfOKZXxnbcv7QDRBtnn8hKNFLnSSMloG8p829+zL+q9ZtYRpFS31XiWTLrvWc9YNw9cSlo6iOlU6oYrWpCEwJHDQ+xvECDUCc8jSvbwgzEFEEn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:54:24.6781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03915917-c662-477e-80d6-08df0deb5d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 accel/kvm/kvm-all.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index bf81a19423..b6a3839055 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3437,20 +3437,26 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
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
@@ -3525,6 +3531,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
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


