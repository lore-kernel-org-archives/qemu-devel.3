Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76BCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESEf-00031R-2Z; Wed, 07 Oct 2026 10:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES1F-0006P9-CB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:49:27 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES19-00042B-B0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQf+rFWsgje4Cz8F95cpQPcTZ4oUv8OFIJ6hVZOW12y3II53kIIfbdLaQ5KvMguwU3zm0NgCU5mzNiRW9PoQK0ITva5gL/v/mmnEHLmsakZ2R6wvf1xvWmtWgimK8aj4H0tS4sV6j6hjQrZ05eY8jK7ApLjCOp1THEFAaedrNHRDPQ+ahtu6eZWa1d4jThatppg53HiO5HvM9U/Bpfsrg3HZ0PznKp2y2Tia1w6tR43ttm0ztII3PPiizL5pJTLpUIuji6as4Nh6GJkvSkz64UEMzfnA2+1Dv3sJfmFYATojzvlJ/zjeYRj0SQ3OnB8OJv5oi3SYKPckvMGsuxCwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygDuSSojy1K4ySomDQUyfqpuUXXu3aweZpqYx5LQhj0=;
 b=C0yQHv6TG3Iv2WFnJwPWrhnL1PbFGRE2uLLMGxzmpx/caRcLQOW/tmN7ZsWnZFAZSX3LRC0jGnBlVFK2MhXcOQ5uYqqeXsUuztZAw6ZxxBN9AEKElghWN9yl+obnSoLwqCL3vWR/yrf1hRFKuqAvaRyjULRB1qnrnxVt5eSw1ddjMxGRvYMkYf1lignDw8NCNmLLvenPrR4ARAXkuuo4te0fhwzHa62Hb5CxZYdne+TXRQwMdgTnHRSZOmwOgYGAFRCSVK9hN0B+dB7CB+QxLWY1E+Gs8LsqJwcnUbVv3Js1pwVH1aUdN2V9DHc5aQ97hne7IKpZDc3ZlxfIUm2/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygDuSSojy1K4ySomDQUyfqpuUXXu3aweZpqYx5LQhj0=;
 b=LCdwkqW9fEO4DW/COgclspczowyt12qV+6mNGJDbPW/nXB33s/eYnrwgy+jEoFaSFtfAbCbnEpQYDkitYOlDj9EpxaBZK/3LW+d9Ni2RhjX+S9KG9aNM+uo/2am4c1LkE94Sx1SbLFgBwCOVfh8oKb4tkp9t/YccWh+N3g+MOMA=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:49:06 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::80) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:49:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:49:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 04/19] accel/kvm: Fix handling of conversion ranges with
 multiple MMIO holes
Date: Wed, 7 Oct 2026 08:41:28 -0500
Message-ID: <20261007134323.1606088-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6c45b9-6b30-40ff-f07d-08df2479c0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|7416014|36860700016|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rj223u1OmY5H1aHe+TCmCXMbT7GMTOWGyAkw+mCMMe0PU7FE6Q2HKezSsNwLkzBtgm8NQ07EF86l9HzPFJ8UbENGtN0wzvdlD30mytoNXoyv5AUoF9+TZr7B4NvA21HyVLkIP/IO+isbQmakjJL+Sd2k3ZL2gi3H392mIlHa5w4PKbUOJZgyI58RsEUFysvNjxDzByMEFKwHHU7OnTCsATko3ddjTiwbVbecusMpaGdxxhqxhCpIf+HfwNUzByLWl1qQbvUktL52AytbaWI4hKxQFMhiXSLYgSQe9gHj+9Q/em/b/KbR6xOK+VfQKzqoU9QTxHmllDPloIMwSteomXR/D8WZphqPE7yTAkSl+ZXriv4H/peE5VF7l40Jo/+elheguAaE+nuFN01KEEH0Yy0utTFmZWJ4yaZTfbmhB/6jLt/0ZOnzKEdfFF/RaH8O/wtbB22V3QS6txwXGgtU2jzmcENNKNaTJrx2OzFm52ZCUkIBkBGy/I3jKM76z6q897QTFY0tLhGbV0uxn1Vff3PF4Xnr9JNhEVgblCwEcQzBgZV5wcjbqdCoCxzMrv8AQTYloP9gAHy/5LZZxOEiH9g2LlxwTR5gacZIt+S1bGDgd4PaCPdd1O8W2IAuKatcFg+7i1G2XFM5KbTRKj0HZKf7GpxhcOhxO80tfZ1/2jJiIHpg9uSXRr8SSImn7pM+lw6dOErA/BgbhVeKH7cEWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZw5wANkzJF2Qhm4ilx2vH4c82V1pUEjQ0bgqVJKyCWRuyDP4KK7f92u/FLtdfsI5fY8+qkIHiCN00gsn4ptT8QBupUv/bvfAxHLCcSDow5L+OJx3zw4ZA+tokVJbNkfdMFci5BMHEe0t1buBQ06MRuM0sLXVl9l/9HgJAHxYaQrUm8DI4IQ4UJI4WuXB35f7eIb8l5njtzV0icV2o4rJCh7n3X2FSh2EcvtjKb3T93SoI1hT/qgwVoEAzMmzvgZ7JqUEjRqPTS929qOn+lXPy7WITkizoqI7syz53MNw55f1UQVsz8LWsaGmxMmOSIVYyEhh2HyVkiOnwEQPWGBwnjFNXDPIvPbSheNoLoZIAeqHp5HbSWSC9D2zbK9tcwgcO2eCFYvpVhZ07dU42L6XLFWg+LeIGLVn7IRuRo2k0hqIlgkBQc/KUsDdxoc3dsB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:49:05.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6c45b9-6b30-40ff-f07d-08df2479c0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current handling will properly handle MMIO checks for holes anchored
at the beginning of the conversion range, but misses subsequent holes.
The current handle_memory_hole() helper already processes all MMIO
ranges up to and including the sections found at each iteration, so
handle this by simply calling handle_memory_hole() for each additional
section/sub-range.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f0a79c9bda..2dfd14c257 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3493,7 +3493,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
-            break;
+            if (ret) {
+                break;
+            }
+            size -= section_end - start;
+            start = section_end;
+            continue;
         }
 
         ret = kvm_convert_section(&section, to_private);
-- 
2.43.0


