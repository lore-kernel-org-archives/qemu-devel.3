Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8262FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPmu-0002Ka-1Z; Tue, 16 Jun 2026 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmt-0002K8-9o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:51 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZPmr-0004Ot-56
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5yxO50xj05alJAykGGmdoIYyTAw5yuvAIWVkNTNqBvN6D80SbEWbOKcbbgXCExJfZ1dY5bBTSg7f7PDG7SVOTCbSzeenXLMXtI0zJIm3VNXvh72oE1yLSHzWII8Bj6R89mux6i0G9mXFHvz+6LZG01YhJMpGTLUQgzb3GO8vCDk5leryEf2qUH68wbI2cKXVt/POg8LhQ3yRY9x1ouRN9CnOs2pdhsMEOR9lK6fEAfUClFRuBzTEszGs6oHHSMO5/qOfJ1gFPct/RP5R3F7srHKuGHtKv/hDv8uWUPGOJwww9zGMPHn/sbq3Whs1Ac+l5uNHKrSDi++DwthcaBPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+lfvpqP+ijTA2UH9NjVUI16UYYo0kAH1hunDM/bi9g=;
 b=G52wBvIoM8D3Zni7b7rA/MiBiaosPv9TNNuwsgfKY3JZl7+eyWT6sqESMJe7p9HbU0GiMYm9O6seap9Kiwlcy8/Tt8Kadw9Gkcm+brV+PD7tqKC8dz0X/ONNiL5YOE5DBYsOIK+7RZMejOIp4PhpeO2ZMuZD67kvRPj2V0u0Mk6IrNHwywUv5X9HgRMK9eOzvlN42esw/KQfB1iPtikgKEPrY0j7fuR+I6XcCtT6yNj7qxdiDP/SNqT7chiWFItB3BC8Jit2jLZNtZKEQsU+gLTzRdNnP4F44vxEgIibIHrxhTyoSP9TbypGnVulUJ3iK/GSX9SD430A5IiEWDn7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+lfvpqP+ijTA2UH9NjVUI16UYYo0kAH1hunDM/bi9g=;
 b=J/440lCVxtKpmS/eJTfl7/YbglHv0T4woB3TTfnncQ/yymb6fa3vQiNmvImoXvt50H2dWWx/6Bfp3obi2ApgDRy8cpNdni0azAgzLva15yC+WruUGVy3dseJmp6jVyRjga0nwt+KGt7QkC3kgRm+iiotRo8vTU7EY4EbqRKeDMI=
Received: from DS1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::15) by
 DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 09:08:42 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::51) by DS1P222CA0009.outlook.office365.com
 (2603:10b6:8:454::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:08:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:08:41 -0500
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:08:39 -0700
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v12 4/4] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Date: Tue, 16 Jun 2026 17:08:08 +0800
Message-ID: <20260616090808.3047939-5-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
References: <20260616090808.3047939-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 26381971-7f4c-4e8a-e93c-08decb86dc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003|43062017;
X-Microsoft-Antispam-Message-Info: zRXlVWuEX0fO90Iz3XbMpN3sLa7A4SkEUsEWoXbH49i7d+zLTAqbJzI6mEFnMEFTJ5Mld+mQGHOWKIpMn9GxG42o0GXcqD5wb+kSehZno9eY8iJGTQz3sc1VLburUNZgXhzX5m7k1prW73pyqSU5PN/ywGwKmV2YiTRnFAzvyt+MRdYyCGm0QtgKEpWDvQp8cdRbeCisrBgxW3VrCKdRX88J8vf0odyjmKCVDPANxI58kBW/SCDiqJNi5oakh3oZH6QBnXOuUrzh5TS3V57ltPrMZX4fbsnmKYjXXLAQoyUdODYH9Gyla+qAEmAucowWKGntHdXAaSWWTtTBy1dMBUAcj9QJkzFX6pD0JeDnstPDBgmVHijkedjoNqQJxxubJOpd5YRFDxbJSCllWnE92leWdq3jAbABmWMbQ3UnMUsDtgpPy0fUVSewkvZKc7hHQX9oRMs6OSoPpwmjJcLEfB5infGNTP/1vn1rW1AHuYJcyyhbQ8UdvFtFHrAno5bj5TB1jiXy6b6HCvUUhUObHyRDLD+ltZ5QzIOozmy/SqzO0ryLVgIcgT6u4nDowMc+BYQGehElR25Yhjlqeuc4M9I8hraac4+5WfN4hY+BijKw2WaGJLSwU9oeyTO+//dcRH42meyQLpqdDWzUULxQ+R+yUebzaV48Y0U4UG5LwcWIm24DVDYUWTyKIPBOlbmtfwOZyZtxTWnhspVzRo+RwrWaRsUhV2r8vQtdoks12vkj/AmrDbHDVFMVI4sSNRbxO3YImxsAIcuI9bEZtxC9RyDBcs5QCzvFwXqEHsDNE5Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ftTFRbCkfEUPiha92/mJYkpA8LCuHeeMjzJFyLc8AYNFhFlMdUwccEWNpFt4xdBRAXsubEbA8OH/ZzM6iNPAh2/915saLbddW6eow+vuBPV/C3SgMEzpdO4pLWif7EAPblbi+qRbXHYmE0NRTKkQCObOUfFD26pdtbP/P5IWkbxWGZTfgtN5gIYVn1yNw4ZmpGO3I+h1f2mjVovXDr/T5hHJtLEgocwcZhi6Y1M8aGQsnbg07kRiWZtd6b4K+6mwCxfgb30d3PoOUDQZCASLhMh7sTQiOzOkBTQZRMa3OS7wqjkbCbCAdqa2thcGjUdDqHSWKxn/14ZXi8HYXMxU/m/E2HBA10cEadx85w0AC+R8Z0ZExfb+07YXIufaWuOVaZxWWSw6UXEdNBjuGSysfsEd7enWyNmMkWVkmkWbMvVUatM6/0fc2HsRyhU1pYZF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:08:41.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26381971-7f4c-4e8a-e93c-08decb86dc76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b5b581e17..192b5337d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3346,13 +3346,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
2.34.1


