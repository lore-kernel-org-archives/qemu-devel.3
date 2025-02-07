Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5830C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 23:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgXry-0005bR-Gf; Fri, 07 Feb 2025 18:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXrv-0005b9-Vm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:34:44 -0500
Received: from mail-mw2nam04on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:240a::61e]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tgXrs-0005pq-Up
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 18:34:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMMLyCg+nWuw8BeAE/XHh2JDgAH2RFpNPJTGT0zCdg5kT5D9MwuQ5oyRFepbaxQ8jlLeY2rvlDTq7X4WASpb599obmLvUSYCHO0OKbpvuXiWU8qrzjF/3hv/NYPLy3ZUR1F/mlPRonhoZu0VKKpq6ENO/2D0T9HGbmlcVPd9SkCfBT08hQaJdAcBIDynC8xM9ZVhNG/VernICiJYgh0Ihou8egXQSbPhdeH2hFJScCasFHmG7RjDIJe3qKewZLmiGA6R1nquIZ341iN/sidSbYg4TgKm38JJ8LoRUKKovdY+P7y8SPPZh1kfHXwWFRiUYuBgPQGztHWpsu42kGgN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0xS9rd3QNnBYpqjhQA/EMaz5sY+O/1DMgGIdd9YymA=;
 b=F1CDsrPjk2uxH4WrvGLk5p/5iXpuI1FCDiAcfZHzBSdl26Ave7ksi1VSkPqAFvvWjeKHLHXfIf7sPIPBdGa5X/6ijjKw9t3dNaT6SNRcPgUEDJh4ros39dloIqzYJpOYMtK43kuNjZ+V7Ah4GZxJEq4AE0AaQmBsWg337i3aElKz0Xh7ndNyB/rOwTinST7fnf/HjlgvgRjAbpz4TZ34D6mf4+Ot573WpwlFnC6AMpKT3Kxy+sB82STTrd1q717kKxr9u2s+J4or4njjNF7uD94sJzuP0QSih9JmeYSBKibkP6O08RVrgUtgqUFqcPkIftSopXf0XQOZZGIw9SCyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0xS9rd3QNnBYpqjhQA/EMaz5sY+O/1DMgGIdd9YymA=;
 b=fSG3hPvob94QpYfjk0HuUMvKlVeCEvEffqly6H2UFwM8JY9U19M4Gp/caTyOXVsBIc6QAQrTL1oVJ1lKNOlF1ACYeJsNDpNT87PPomi5K0vctqMFh+A3zi3h5Qxp/5YEGWRXFsNI3RRAKxE8spPWYTGQJIV4JzfVf3xAWR2JFoI=
Received: from BN9PR03CA0361.namprd03.prod.outlook.com (2603:10b6:408:f7::6)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 23:34:35 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::14) by BN9PR03CA0361.outlook.office365.com
 (2603:10b6:408:f7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Fri,
 7 Feb 2025 23:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 23:34:35 +0000
Received: from zweier.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 17:34:34 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Sean Christopherson <seanjc@google.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Kishon Vijay Abraham I
 <kvijayab@amd.com>, "Kim Phillips" <kim.phillips@amd.com>
Subject: [PATCH v3 1/2] x86/cpufeatures: Add "Allowed SEV Features" Feature
Date: Fri, 7 Feb 2025 17:34:08 -0600
Message-ID: <20250207233410.130813-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207233410.130813-1-kim.phillips@amd.com>
References: <20250207233410.130813-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f26e1c3-2d3b-4414-610b-08dd47cffb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFE3d0BMgl+n001RhznZpUWbE1VLyICSu8SfEXqqGjAOtPqP8mHjHhG9talf?=
 =?us-ascii?Q?Uhfw/FOyXVULH9JQOZOalhQ9s5Ds8K5RHHIIxr7vZzkxugl/8sFJxPo67Ibh?=
 =?us-ascii?Q?O5K1W5QL5fP+tOc3jkvwAmaNsQgfgWifsRqtPbTEFy2EqEoZlbctyCca0r+Y?=
 =?us-ascii?Q?eKUVMtrsY6EMVt2wiCQV1iAuqHWxg+JYMJjpFZNhns9TQg1zAxbxK1eo3q2/?=
 =?us-ascii?Q?BQ9TVZKbLjjMei+GRkQU+D6ubeTAtqdN4VJN/kg418xdh6zTtZqqBAlS4HGU?=
 =?us-ascii?Q?Yjkak7KhN1E9oF38NDH3KRb2Q5AXlUvrMUHV4dbgHqm38r2oJelT/Fe24r5G?=
 =?us-ascii?Q?DHYepLw3DN3b3Zq5tCpbsX7QDSlhVkoABKsxZjFvgIKZSy8FDxQHVt7P8lQ2?=
 =?us-ascii?Q?vgwFnD356WENZxeIzASb2Uwet717bgIvgEGcw9Qj4/eLchXatRf4+n1VlYMY?=
 =?us-ascii?Q?hK0I8ZJUIAqmlPmYIEc39SyrwMunXRPIFjwT8C8TE6C8MucFM7l1q/C/12Ti?=
 =?us-ascii?Q?IX0O8IrmnE61p1Zt83PF6MI2GfsWmVq2Wx1fxH8Z+EacAQjjoVh/hr00D+Jd?=
 =?us-ascii?Q?FjWYefUvgswh6Eswy4uV7CWTm1B65FjC4RzhI7j2p7KD9D4BDyQRfnxt6GRp?=
 =?us-ascii?Q?31360obpRv6zkLu4UplO6Yq4uil+CAnWiW9P7HLZS7lVtUKvS8Ma/OC8kvLk?=
 =?us-ascii?Q?D6ouhhbDTnkuoHFZetxMSmnx+BViCbs39/C6U0R4WlGP1a5OJk61fVknOIvS?=
 =?us-ascii?Q?lAhJcJXGZI/wYMndvN6agW5v1r9ii8BE2capSFoQ6BtCNTrrhQGkaGsBiq9O?=
 =?us-ascii?Q?dbbbU2CuJg0PnJjNYfIbC5oYJXm1aQKAVua1q+ZtXAD8E4rLjeWd2CTyaMXj?=
 =?us-ascii?Q?7/5WuhMwEDEyruAhO0rle4Y+qRGJi/UoSgzkHAFFqHWCI4BzgwQMeQQLfqtj?=
 =?us-ascii?Q?9VYVWjIY6Zx4sdXyON4TwQ2AmN6NDuHaDzCErmYqjrvtmFMv4b/sVsI2RtnK?=
 =?us-ascii?Q?BdvnzfAGEdRFkNRxzUT5xKBPlYN+Cj0Z3zBOW65ilTocYWLy7U0Qnu4Wu05b?=
 =?us-ascii?Q?GVrUm+HrT6wjPeMOxj3dx/PCjTnbA/RuNerOBwF/Zil8pfvbzV3pJZvtzhkw?=
 =?us-ascii?Q?p+5/mzEzOVEdkQy22wFs5eWSIOciHRR+uU/FGM80lVNf1MsR5CzonL8TwGFa?=
 =?us-ascii?Q?E16KM3FS5QNzhcxhHjEsfQ1v+rBHvvxJq/frfH6uOUVwYSwweYqOs4RT3Wwc?=
 =?us-ascii?Q?QSzBdgKu+X695wvWzH+YuxCcGvL+e9pV52BzSExMUijrePF3Z0KXq6doyDEX?=
 =?us-ascii?Q?sl1vy42pMYFDeGkP6NWPetj0zVKvYRnXnGFWy7WGhr0/r/z8d4CnWqV3XDYn?=
 =?us-ascii?Q?/mVSCwuYa6PK2DipCrVQtP6p47/wbY38Mt0rq+cy/0FuPSOvsBA3rchzy8s/?=
 =?us-ascii?Q?XojywIF2nbExpLJd6HY1DcXtVLjFcpuMf6tCfzJJdxFdaxF7gnvHkifCouwH?=
 =?us-ascii?Q?l6+q1H77XWQvhhU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:34:35.6856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f26e1c3-2d3b-4414-610b-08dd47cffb5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
Received-SPF: permerror client-ip=2a01:111:f403:240a::61e;
 envelope-from=kim.phillips@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

From: Kishon Vijay Abraham I <kvijayab@amd.com>

Add CPU feature detection for "Allowed SEV Features" to allow the
Hypervisor to enforce that SEV-ES and SEV-SNP guest VMs cannot
enable features (via SEV_FEATURES) that the Hypervisor does not
support or wish to be enabled.

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 508c0dad116b..a80a4164d110 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -453,6 +453,7 @@
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
+#define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
 
-- 
2.43.0


