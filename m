Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9654CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXs-0001rK-Sp; Fri, 22 Aug 2025 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXC-0000Ob-UU; Fri, 22 Aug 2025 11:18:30 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWr-0007IP-NL; Fri, 22 Aug 2025 11:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvJmJj/UMnOvZF9rg4kiuv9ZK/jcKOohQ4b2HjTZ+tY7VjduGv5hu9FX0KJ+c33Aq6AzqoxAmVsiRlnnXvgrMQ8ntwLhd9oLxuKrU8fhLJDT04sW2nBJBuOJ6yXwsoKIzIJ8ygUuBUjuwUwhWB+w2dbQDkLTJMT7vpzEhMjoQFuD/LygXR6rN6Bg0QayRCfopeEZeHZqCd714o4K1CpOxc95BdktgzuVvfs30o3XxSfuhpDc4QTf6KpPqZ/Cg7WFAKFMEkAQD6/61ZZ+yoj8McQ8vK8/hbAPDTjcs7a6P/KruhWwSld4FBzYN3VBAgJA7/ooIVEGCzmEPsNKaWNbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=bF9uHFIVtqAbMkdFhtK9Lx2wFkuODZ9l8PtHvUSVGOXJDSRUvdVOAjQUm1t5L1ZsWDIuDLZ9X/TftcvIIq2otp4YJmoJvC4V2yhXXNnLGvWVNnKIXihOTZosydMubXZU/fHFsTq297U5sRUH0Z0cWNubE+E0KC2LXM2XtqhUbT+iBr1ZhVwUZekM4PesYURsgDr1Xfcs5wkMJHbbCqY25wFP3E/hW7i2thSuqXsO89M2XtPchWem7N3iEPBQXQDdCmPKtYPwcpa6394QXGog5h2UmUB/KocudrlWznI3hwCVDLPnatoNoK9SJ8W/q0g2WGOGPDqi58ACtru5covueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHK8ys2NHiMe5Y74ks2/3+TVAL4SbZHKA/dQxjpvi6s=;
 b=TiWOA63zmhGxt2zBh4pyzpH/+oknzLXA85oRMCSTUTG3hGjdFCKxMMUps/kHXm0kTuwaVMoNaQPtcyhBowPLsJQPe9sAFRUcqBxnJqbPdzLoUKHJYZCs1T8OSL+BFrSspGPx3z/rOV3+TJ8Ij4dDsKTEUZH/jDwGMObDGOSGmoA=
Received: from CH5PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610:1f0::19)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:57 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::73) by CH5PR05CA0001.outlook.office365.com
 (2603:10b6:610:1f0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Fri,
 22 Aug 2025 15:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:55 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:54 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 45/47] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Fri, 22 Aug 2025 17:16:10 +0200
Message-ID: <20250822151614.187856-46-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b7295b-ff9a-4df8-7dbb-08dde18f1345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zMcqHLGqrBbZmlXHObpDuDEDFU8IupCIRq/b/KtzoAQJdTIWjpRP6sjr+MwV?=
 =?us-ascii?Q?vTTZ5K9/Ny5LyBumrDOrTlFf0RJj1dqMWz20TIwxTE3JTmY9zLYBSOS7Sv42?=
 =?us-ascii?Q?LHzM8x6SXKBYzWX3T5j1d3Uu6A5v8rF0f6DzEc49gud9qbiwEXOhVPQw7a9M?=
 =?us-ascii?Q?jBUtYu98BXerFxMzUXA8lo1ISCVB3uh5z8zCo4oEiX+31pxcIwEA/yT7sgub?=
 =?us-ascii?Q?ckWHZyFEsZNcCJ3uzM/oD8jALZHipoRawzlPxfpj7l+rntUQQmRWm89cMQyJ?=
 =?us-ascii?Q?43AwPUl2z5FyYQBr6Bx5Y5mMJve2e2zAlSHXdn0MrP5YXNk0EWoEqPRsFW8N?=
 =?us-ascii?Q?XI0k/hbpwL6nRGUf9B7zBkFhB0yeMd2o70NUprtMBIVMh20Etk9nneCTaVK3?=
 =?us-ascii?Q?KrUQZ6l6IPUfY+kqWw92KfdKKsOTZVZzsOBxCL1oG78GIxU2QSE/+Yox5XRD?=
 =?us-ascii?Q?cbu8zL7BaV3E13OG6t00P542KUVTS5Zcw9iuOkXkrzy4boeRjJnSNMmLJssS?=
 =?us-ascii?Q?/Jg7kG3qWNzYPbQhf09cvcuT1K7/QadryQR+yEk5Rg3XurEWWJH3UC9Two+/?=
 =?us-ascii?Q?IZU8axjWBLgrbXVpCDaEQXKk10FaJqWzwqgzU5MFlTtjSv8YTVx9ClXQ/EMA?=
 =?us-ascii?Q?LW9E64GIpbmFnUQ8LTlNpAFStdBSyGVLRnE2V5Vg1vCnvkkZdDwE8qclQ7cq?=
 =?us-ascii?Q?A5Yntrf3ThbF262l/raittf/tJYi+ZB/eRYEELm40dCr5rU2SShQHwos+xo5?=
 =?us-ascii?Q?nOL4Ozx2Cguc7nfCQf3IR9UNifmzX/D4DVWHplEgki4tFvxmj8Q12ofXrOqI?=
 =?us-ascii?Q?jbgy12MEqjM5fRbxB9vmKVBzMml0HplAGZp1Xq+0nCyxgi0dssYojgbPZH7a?=
 =?us-ascii?Q?BTeHaLOe7iVzRGiBl7mKJXbiqMkAiglOsbyUDu2fG+A79TuTm67t60hq/PfF?=
 =?us-ascii?Q?5r+xQUaBQWcHtBuYGx95yKmvP+AWt/3k+ZOI/t9r79rrU8OJgIoPgXxKyeBZ?=
 =?us-ascii?Q?j7rUD1Is7oczG5as0TaaY8ydCA+tRenLEGHRM4fNvelb2BDplY9z91Mf5X1V?=
 =?us-ascii?Q?zueskEN5y7osEFeuVwwtk2aARXgk3VX+a5QmrPBhpFXzneFQGQj1KSMhot/x?=
 =?us-ascii?Q?x378Uw2s4gK7L5VMqeOhK9azJXCPqzro+RZTk2hM6kpaQ2psHxdkkPF5E+Cf?=
 =?us-ascii?Q?v4RLo7R4paIG0GGjaBWgnYDmBY7MeVeXsM/tGXjYr2qVHSl1gxNVi0Rdjnx4?=
 =?us-ascii?Q?cCyHemzgv3n7GEzYPDuIAMs22/zPmSVps2M/hLZnuHrr787tb+T28ufQuPI2?=
 =?us-ascii?Q?T1va7aMju5eDZGeGQY78sZVZ2eKfbWIHWwJnrdXJYQ6TT/i0ubS4X5s1QW5Y?=
 =?us-ascii?Q?BjMN5RCuHStKI9CSpwdV6/i0qteoeEwwX1+VbY3PLogxz/xZXHRrgPvE3+v8?=
 =?us-ascii?Q?aYzqKtih0XPFZG7VlB9AtHxLmqOstnKj+AK4mfjfEkHxGAzN9VLNX5gMHIgD?=
 =?us-ascii?Q?bj2+3VH9f61L8NwM/kESzN55Dlb7fY5voipA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:57.5557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b7295b-ff9a-4df8-7dbb-08dde18f1345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
Received-SPF: permerror client-ip=2a01:111:f403:2417::62b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Add a note in the DTB section explaining how to dump the generated DTB
using the dumpdtb machine option.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 94c8bacf61a..5d7fa18592b 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -63,11 +63,17 @@ Users can load firmware or boot-loaders with the ``-device loader`` options.
 
 When loading an OS, QEMU generates a DTB and selects an appropriate address
 where it gets loaded. This DTB will be passed to the kernel in register x0.
 
 If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
-for boot-loaders or firmware to pick it up.
+for boot-loaders or firmware to pick it up. To dump and observe the generated
+DTB, one can use the ``dumpdtb`` machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
+
 
 If users want to provide their own DTB, they can use the ``-dtb`` option.
 These DTBs will have their memory nodes modified to match QEMU's
 selected ram_size option before they get passed to the kernel or FW.
 
-- 
2.50.1


