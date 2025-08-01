Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39090C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiuy-0003No-9m; Fri, 01 Aug 2025 02:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiua-0003IO-2l
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:42 -0400
Received: from mail-bn8nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2418::630]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiuX-00054O-EU
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+dmSQf5XTTRn8sdTkxTRDlH1vPrzKHwcMGuFJGvhnv2jA3zfSWkioCj6XsEml3P9AUAO9xYlikP8sFYzwPL0pcnMJzJn3E4Z6zl6g9Zqbh7xw0/obpuzDTPfSq2hQ6gRD8XT+g05YULdUPLgLu7xQhODCovdp4ogpuNWDBKuC8k4jaZLWmSVXuplZyhhOVoePNs0Rjhg2AmfiTLWHy1hMc7knzverSB7C8v6tFs4NvkKXFOnTylGN6Dj8J3CvysrcmvWNgCmdyS7Q0n4yxOy3mWZ103OF/H8VT8c4Eyp2uvmXXEVO4ZPpA5R7shuiW6SggqPh4Mqhly7xGHUgF3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KGIlKnS/7zBWEs4Au9DwruzhaWdT3dNfOq5eItWJ58=;
 b=OUsesd1XNXcEf0MQ9Fk3typ8dczXrayxJXBdwy97wgGTQUx0gbma+RuSA2v7mOrRFLeZ62EwqJJauQuKTxgwe3a+Ql+jN5LRUWSkB0ejC625MjwpWQG9Lj24/pPi7TigPTCcm5eyozrnfMFGgQFCUa0n7cE83oB1bTnPmpEiYSr+O+TPvCJaszgg4iV7Y20hmtaRiQUKKOWKVgZu7gou8JWobBBoVSWmTDxO1oHBiPN8y28UnD+ZMtrVU13D7VbqD2b8H2zekLxMf2mODs1g6iFZEXxvAoUfaS7RU+MKvrRPoXWm4GWk3cqucFR6/RDGhQcmkP8cpXrrIrwDR6mn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KGIlKnS/7zBWEs4Au9DwruzhaWdT3dNfOq5eItWJ58=;
 b=5QO+aASWEsZWKP5GnemzSjwd5QZIyjbbvhnhXKOq2k6GKvNE+PIk5GBCOJliWRN+Ssws8n4xHZkvNJGK9RhfoKrEtj75d/UXGqFvrCxZuHdV0nVAdPQy2H6kN7MtM9lp4FxWr1o5gZM3QNVk/Tms3a4whh2W7J6CqkyH2TXtivQ=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 06:06:30 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::fe) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:06:29 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:06:24 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>, Ethan MILON <ethan.milon@eviden.com>
Subject: [PATCH v3 4/6] hw/i386/amd_iommu: Fix amdvi_write*()
Date: Fri, 1 Aug 2025 11:35:05 +0530
Message-ID: <20250801060507.3382-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-1-sarunkod@amd.com>
References: <20250801060507.3382-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: acc6ed43-e56d-46db-e429-08ddd0c18ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrgoaRTvwklEty+ao86BCXLXoHaMmEWMpyG74OD+Zly+MhrSZjQLcn0J4DJ3?=
 =?us-ascii?Q?WQCvFeZVejrmLtfEITovqwRtcU/iThkIhKWXTBwpuBAwvvh5kk+MAbBs8VtR?=
 =?us-ascii?Q?NTeiOCL68C7FSG6e3pvRTXObCy/wCOi4pj0CUCtGknJnCPxZZ1NRcBhXpQa9?=
 =?us-ascii?Q?DmHzS1IDreTsVLLUCDE4CTaox/jKGwHPAmu01seEF0fea0R4lT5Wn/6ZXX5I?=
 =?us-ascii?Q?bXBUFOmzp7VGLrMAITEmQFZKZxGUZ+KkYPVyuT8BCkd8WMZyKc6JJoY1yNuS?=
 =?us-ascii?Q?sRPAakJh2Hlx62c7021+UU4MOl+ORIdRcU+zdyiLb9QhnUKCN081mwDGIdYH?=
 =?us-ascii?Q?vgLcflr6BDcARA3gaaiBV0tWXhRWDejWWIVg2UumAPWfKi4ikBUsIQ7Ch2jR?=
 =?us-ascii?Q?wWgQg5MQBY0mqimNHJRKrqAGE5/3k4GG2qJDwZdYIAf9EMbUD+3zOcB8XCVe?=
 =?us-ascii?Q?TQW2mhRZKuTTVsXteHURIgbRKL2b0T1BJQNzIiQIAkBeSDxT+J1ynI3iSnL7?=
 =?us-ascii?Q?GUupqDmnXlqf7DckDrWSzrjfCo2NlRObRJwWV0G9ip1XIn3ruk8XHMwTRcUS?=
 =?us-ascii?Q?FmpJbVqrIooxA2QHDjI1vA1xOMb+/XeuX55PA8KAZ98Rnf0uRtg0qF+qUtV0?=
 =?us-ascii?Q?bKYWAyliuCnSQNp8VUZgmeeb68L+8hL8RuQlwKUueq8fRGoG9fA6GYWSQkv9?=
 =?us-ascii?Q?eyoZmorduclxWka7CMVHpdOMfEN9D+zQXzrFnptDVSC8zdYNn+L3boXklQxJ?=
 =?us-ascii?Q?TG1VGb8EuXu4sD6Cz7+lV0KsavG4rDKLASA/MGYvUh1/wLXdBeprzv9NoG7A?=
 =?us-ascii?Q?Y21vSvEnjs8K4jem1+fN3Yy+S9m7Nod6CuCw1dHi5zZeZdjcNembS23AsbOf?=
 =?us-ascii?Q?2UDBbky97k9d+aIcvv5xPXOOPcNEiDUOw3ZsJ9XoNmisRi/qGNHphQXljM9Y?=
 =?us-ascii?Q?E6/PNFeV7ZunDOUV+ZT5rur2gvsTHdMUUB9i6JDufGzjPQY/1EdwPjx8OfGr?=
 =?us-ascii?Q?KEBYdfQqVvBl/JYzvlObnHV3FQ6F8wGvH1dfiokkZk4z4l/CvHDcijnC4gJA?=
 =?us-ascii?Q?JCKxaZJ9Ox9r4neZ9ZRNSSmjyL251lbgPXsO78xxm2MnOUPKWL8X02juJ7Az?=
 =?us-ascii?Q?S/RP1QYw+/bR2MjS9mmxja0eovvO5HpLpN2LWDRIHQZWlPj0qRuR1UcXIs/+?=
 =?us-ascii?Q?q1CeXJar2JC4umhLcWsUjLfOvz0iPirq3DBL6kA41dtMDHaTxYfZOkRzOAok?=
 =?us-ascii?Q?bIngMyUtd5Gjcim1W9MLy8UixmnW6nd1ciCAxrW1sDzr6GwNEv61GQOcXeOP?=
 =?us-ascii?Q?GSdtEZ1V6qVbDSWK5/x9vik12C8gqWM6SykUFK/a5RgDJdUj51XbKj+nJ6Z4?=
 =?us-ascii?Q?KGZ0cGuTZlluW7n8g599ZhisV4k+BVTm7doq/hBbmvpyUmfFaMD7IXnt82kp?=
 =?us-ascii?Q?BcSI427dy/wsSvlS0z2CtcQR4AYh8ZzfzwMhFhN4+ERn1amOan2RnQEuvbSb?=
 =?us-ascii?Q?Ma2geipEvgFOSfcIeSb0yO1AO9P9gtE5UcD5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:06:29.5708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc6ed43-e56d-46db-e429-08ddd0c18ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
Received-SPF: permerror client-ip=2a01:111:f403:2418::630;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

amdvi_write*() function do not preserve the older values of W1C bits in
the MMIO register. This results in all W1C bits set to 0, when guest
tries to reset a single bit by writing 1 to it. Fix this by preserving
W1C bits in the old value of the MMIO register.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Suggested-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1ffd1375570c..ea0cb0e21fae 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -123,8 +123,13 @@ static void amdvi_writew(AMDVIState *s, hwaddr addr, uint16_t val)
     uint16_t romask = lduw_le_p(&s->romask[addr]);
     uint16_t w1cmask = lduw_le_p(&s->w1cmask[addr]);
     uint16_t oldval = lduw_le_p(&s->mmior[addr]);
+
+    uint16_t oldval_preserved = oldval & (romask | w1cmask);
+    uint16_t newval_write = val & ~romask;
+    uint16_t newval_w1c_set = val & w1cmask;
+
     stw_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
@@ -132,8 +137,13 @@ static void amdvi_writel(AMDVIState *s, hwaddr addr, uint32_t val)
     uint32_t romask = ldl_le_p(&s->romask[addr]);
     uint32_t w1cmask = ldl_le_p(&s->w1cmask[addr]);
     uint32_t oldval = ldl_le_p(&s->mmior[addr]);
+
+    uint32_t oldval_preserved = oldval & (romask | w1cmask);
+    uint32_t newval_write = val & ~romask;
+    uint32_t newval_w1c_set = val & w1cmask;
+
     stl_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
@@ -141,8 +151,13 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
     uint64_t romask = ldq_le_p(&s->romask[addr]);
     uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
     uint64_t oldval = ldq_le_p(&s->mmior[addr]);
+
+    uint64_t oldval_preserved = oldval & (romask | w1cmask);
+    uint64_t newval_write = val & ~romask;
+    uint64_t newval_w1c_set = val & w1cmask;
+
     stq_le_p(&s->mmior[addr],
-            ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
+             (oldval_preserved | newval_write) & ~newval_w1c_set);
 }
 
 /* OR a 64-bit register with a 64-bit value */
-- 
2.34.1


