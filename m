Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02398C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhivW-0004Bl-Hn; Fri, 01 Aug 2025 02:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiut-0003SM-24
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:57 -0400
Received: from mail-mw2nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiuq-000579-NL
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pftG5qlpmz5LJXPL0ylIDLPlNKUyHtfUP5oYHJ6FQleWWGObBuvis0RaOpxDPGL3MRBa8NvDkZych9kkj3GsQXBgKWphLPYxhRsVxwjZJpjfyNQcANr6a4qIYm1Qlo2HXmMdRwaBm9ZUxfRVB6y+LIx25vTW8ZxP3NvMZUzMuhkQEFv2fompNoZUNlzwv/m3eGhc9+qvIIMpeT+v+BykHmNJ47V2/wbFgWzObvY6cm5Zrj2UlmAOjKnCgwNK+vPSfwvJkn15HQGl0EittHCMk46QFybRnw1+nezSFs40VDSuFyk6LKIoG7O+StP5wypJ+jATuyuRpOlFa4hAAYhsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SYhQCk1pTNce+3ef1PSUKqJwJB+uTu0VWF3IHcOwrQ=;
 b=Q1WmwVFlHlol6ejY6uixQztiTimH9Sq9fvWRt2hn6KoHZM1XAULTL148oaERga/kDqjeiKtGteyV4XAdo9Vlr7TxVTUcygHrU/dzab3IM4oCcqTxy2VMK5C8c6wsCe9k337jnhjUiXPhF/AIPIQz4wId3pKfg99hpbMQsF85qTiR9MzceOZNi9rhe028gtAaZujwA6rcH07VUojEabP/bd574oB5P8TQmGaaWTQ9qvI/4Lz+QnLJkL8sLur/6WZ6OmZbqokQeMq5XMhXvG5XoCxQ01gEW0OeokOEttwXxUcm/2eb2bLGLiIlWLytgxhPhdAI9/MQozlLjrvb7liAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SYhQCk1pTNce+3ef1PSUKqJwJB+uTu0VWF3IHcOwrQ=;
 b=Yz8aOFhdpSSDtQii423AzYHWIabnlZFqUiqeRvCehSYHOeK2Gf10t5O7jbiBoRCjCPQ8j6iasUa8T8t1S9OQStl77bAJtgwj/35Srb+bx9Nx6I5gXB8FG2rYgkmc1PszikmI3S1QPvKkBHPP99fweEexj3KJ5HcZ/G1N7bbxCWQ=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 06:06:44 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::3d) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Fri,
 1 Aug 2025 06:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:06:44 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:06:40 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 5/6] hw/i386/amd_iommu: Support MMIO writes to the status
 register
Date: Fri, 1 Aug 2025 11:35:06 +0530
Message-ID: <20250801060507.3382-6-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 289096b3-4ff2-4518-7caf-08ddd0c1978f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mMooYM+8TDx6r19/UTKJ8Zmn6rCytrvnxi2n0QoMDyLdMJG+fS2md9kai1E3?=
 =?us-ascii?Q?UzIN361gjFLQrtTDHm80hR22nTTL/6xXBKMc12/eSnHnJNX46B2b9SKm+N74?=
 =?us-ascii?Q?+9VspOms3e+0yBaqtacjNzJpMZu45hyV4REpTDZ07bkm/nWjxg8MekfAf2b6?=
 =?us-ascii?Q?2d5nwjSMniKf54TCJZm39QpWjT/pKqsVQ+qFdrpo4ANQsL3kMevaUuuZBQjO?=
 =?us-ascii?Q?Ilg3oAEWMqVUTp0IXtZKmRgyGLvrvES6xNTs7P051YYSKkA6iy9k9z5NT5X3?=
 =?us-ascii?Q?VlX1GprZ5T9ivGepbR0yf8j7dQhuIKAX6jZ1N4cn+9zv/I2Nk1KBx31nKULJ?=
 =?us-ascii?Q?BUTTk4oTXp+tlkNd8apill4JmV0pgQDDCPHxqQ20JMuPlttcUzepDfY4s43m?=
 =?us-ascii?Q?Ay7Ga1z4Nuk921aPebQk/u+8ydAYXyL0+tNcjE0srMEsM79En5tRcNGuNECd?=
 =?us-ascii?Q?wsl8m6yRmjEYzQWCRRu+ZWXeZXhG1Ca0+LAf/vfIwL0nO4qpaBooI1sQ1KY0?=
 =?us-ascii?Q?1kPndApQ3RgcONntzgl5yk87hWsaQ/+VEDhsjyYvq5VmvVULyIm4KTl1zGm6?=
 =?us-ascii?Q?ug5tBNlOsAqQrXh7bbgL22jWa5PF+EqppQj9JGf5ZY/MDlf7QuZfs7afHpVf?=
 =?us-ascii?Q?ga6owImU/jyhbxXIBHg7p3XeSTUHQ7kMGxt1QgZG9U8qYXUBcspE57QW2rSO?=
 =?us-ascii?Q?gJF4eG98uvg4sMvR8uTtxjOEOReu9eyP0z2TVbc3esfEp2CxAnnrf5kVZgKD?=
 =?us-ascii?Q?WJIjZ4ndpW6wbq3C1DYJ00hO3fxhay5zZNqDaGXq8uCj3DOkRpGmdaFDMG2d?=
 =?us-ascii?Q?MhwqeK9pLBk9edTA6CBN65smMmSNzYX3J+dllb0MY478DwsqN3ehF7xYuBZz?=
 =?us-ascii?Q?glmjtXBAG4KYVJmLetqR2qJZCDh1+1VB+RPWw+652DfXAFyc9lSJJqRHX8SO?=
 =?us-ascii?Q?+dqRabLxM/UgsNYT3c7uq3PuKaQmG3yBPwbMsCCEFyz1Y5Dagc4qB05KCkCr?=
 =?us-ascii?Q?rNFpHl4bS/I3wMd8yebudP6yDi4YRNvToqTCT8ECkKgG22L8MvAZuEICa8EK?=
 =?us-ascii?Q?l/id0SASML9vLfxhUo8B3VQbR2rw/UZ7rkWYQfkS8yRfr0K426JnaSFKHgxu?=
 =?us-ascii?Q?hN/KH8J2p9fPBnon8ShzBtMHhKgESWJmGFDgdoXiZHzSjLLMG1sjGt+ZVgV8?=
 =?us-ascii?Q?so39VeJnmnvGGVyDtjoUrgjV/t0sKQXgdYHv2d/Dg0H5OkkwspduqOO9TpYm?=
 =?us-ascii?Q?75fwgNLUPo9D9jDBQDNL8ZRSF4Y1Gx19Jrr4IgMToeDrusCQofTZ1AREBRaC?=
 =?us-ascii?Q?1JdtJ5uyqlFheQczWhqPcVpYSijbUaV6rdcKYJKAu+X8Nj26RAy6OSkYyfeu?=
 =?us-ascii?Q?s9KA07Ma7B6F8mheX8BMI2SSd1cpYUCJGuwqxsEtloQNe9zl7DWdj6R/sVwq?=
 =?us-ascii?Q?pOwUcqFhSRQsEcsOj4xfkmcRut/vgK3j4hDhlfF4BNKnx6n1NfaR+8pyYsYG?=
 =?us-ascii?Q?BvKskyMH9qwtkrJRpqydzduhAnqX18mgq07D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:06:44.5157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289096b3-4ff2-4518-7caf-08ddd0c1978f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
Received-SPF: permerror client-ip=2a01:111:f403:2412::61f;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Support the writes to the status register so that guest can reset the
EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
respective interrupt.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ea0cb0e21fae..681a46c3ceb8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -862,6 +862,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         amdvi_mmio_reg_write(s, size, val, addr);
         amdvi_handle_pprtail_write(s);
         break;
+    case AMDVI_MMIO_STATUS:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
-- 
2.34.1


