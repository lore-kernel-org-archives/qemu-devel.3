Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CE3D68B28
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBaVh-0005D0-SD; Thu, 14 Nov 2024 09:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tBYN3-0005qW-8N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:50:45 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com
 ([40.107.92.74] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tBYN1-0004Ex-7p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5JVR9UIEeyjQvGDXD3EuBGoBI/qFIAV/depytnhLk1MJ0O7AkaGPJRr089He0PaPQTVhCwqqItn3WQ4x/0iW8YB5ijhvo77BjovfuOkkhZ2BaY4FJAAa0Eyxak8/wohtLK64RzbwYxwv0S/2m4XenlPlG00+duhq23a4KaphXqlfpmRBRss5Yih/QlQredBsl/Qx9YbCKULnQYLqmNXUUIzz81OzuhzA9PgGLueoWR1mpIORkAIOWsp83XwZccQeVNPPtsa3rilJo+S8WxEPs43iyIXTOA/TP719DfV4M3sOP5iYya+RO74qa39BuvYpsM7iNa7WdxLuj2enFoPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mZLWlEg9JkS7SP5cFp8t2Ajv5o4qBN82v5YQdnBcZs=;
 b=ykLKYkcPkFxkIIA+kUPDUjaaCUudCrbSLkOtBUpTqtRU7FxmSxmu3xkAQ/PqICqTybLYEaf2nKIBO+GPOty4SsA/iHlxO1S5yi95jYRR+drfvGb0PHtwalAbkvirPEWa3JW++IUPakQMoV5Dv2T0e5CfE7wiybBIE7PESTU66ROFWYKdg7D+X+XBzNgL2gfMHiy0TCEhNVIGucz2Zz43zNvsoW7nXkJ4ABgzgBNxAuXVL8FEWCf35H/J2EJ+iKH0MrG0NAuyhjYjQDifB4Bo149JY44suYhHaFA45Qmv2eCYX9zFb6bHeRvTbd9QIvWLqITcacYSiR45o6eAW0BTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mZLWlEg9JkS7SP5cFp8t2Ajv5o4qBN82v5YQdnBcZs=;
 b=h7YTWI+o5/ChcNmlQsoTbB8OFfRrw13naGcIOizklsMjH4amrFRxFmYmP1nHr9ZpLgSSrdyxndYn3M/ffkkaVnM4+0ZEbQDqMksYbiR4DzhoE//2uAeR/u49fH7ds0agYj7k1Y5s9HtHu8v9iT0xZ0HBMrg6Alq+dc7smlWObIE=
Received: from PH8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:510:2d2::29)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 11:45:37 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::75) by PH8PR15CA0002.outlook.office365.com
 (2603:10b6:510:2d2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 11:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:45:35 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 05:45:32 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <Suravee.Suthikulpanit@amd.com>,
 <Vasant.Hegde@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>
Subject: [PATCH] amd_iommu: Fix kvm_enable_x2apic link error with clang in
 non-KVM builds
Date: Thu, 14 Nov 2024 17:15:09 +0530
Message-ID: <20241114114509.15350-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4637f636-8b27-4e92-910c-08dd04a1daa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?koYz72DT9qwB/PB6OHUyWj0IsXFGK5T2qSSa91UEgFUy+4OKe2bcX5oci8bQ?=
 =?us-ascii?Q?a7l/CC/UUIHVnK3dPCJJ+fI+dtUFhD27WgypFVgFkncQm8922KDflrvR8FoU?=
 =?us-ascii?Q?shOkpKDmSCNtQwMZImuhaI6Np3AsWmp7YMBqvHDDlShF9ccbvCJREbraaSJ0?=
 =?us-ascii?Q?Co2tUw9x1WXjBdvPkwMV95IcwuMlXN2oO1UfcYtQDMc37LQPgqedXLOUHqCl?=
 =?us-ascii?Q?EN/yhqnyRFNFATLyvn7ZaIiS99Im6zblq05Y8zoELonn2muLeSEYvP2MXSFy?=
 =?us-ascii?Q?BfpsZP8eNeRy8ta+R+fGhlTz0uor/LkX4Kc+rlcrAOt9BH+u41bJp+zLedLR?=
 =?us-ascii?Q?eFBFewRJC4dakeA49dGURi+qY6/i7rYAkVvqgjIBlB9Hy2VqcgiWnrIxq8/M?=
 =?us-ascii?Q?/WgIn8Tz6M1N6B5MEhorlp1EWmgmn5AIZLtAexFlPSz7QPmJMSqBsFH5fvGW?=
 =?us-ascii?Q?ePkYjcLWovNfoaqV80XI7RlBPX6x480naYWy2ZzHQzb9VM+3W4lWbKi8DW6O?=
 =?us-ascii?Q?N8tYGiTgJHhdNxMtaH1htMupe9x9aztXO4mQ88shbHT5e+CcPwka+yNEVN4H?=
 =?us-ascii?Q?XUG3+alSuPDZykYRRQMGCcVbakcuHUFA4TNWmczGR6zROFeENWjwZ9dW611T?=
 =?us-ascii?Q?MocHMFJ8NLrR6clGo7URFXN5xsVdZZhcmeHFUGOpMmhry7ceUKY9f0puPTP6?=
 =?us-ascii?Q?Ud7gilt3AdFymnw6kfEt2eun13VcjZSDAEr+91RP7E0NwUEvfnnOesAZyZ8G?=
 =?us-ascii?Q?hfqKQdYQpzlG14fJUNN/LzP+tKmEhPkBGg8jLpaGQV1MFzGNqavJLgEB7gwq?=
 =?us-ascii?Q?Vi1hkg3Gty6G9c4h+WaYXxQSqkot05Yqd46iYfRt4AKGJ1tFQx4OyqX+ufyd?=
 =?us-ascii?Q?u1hvh5xHcjC7BFJ5re1cZNK2m3GOKmWeikLGgJWntwcaCTQm/4Lal1WJ0m+N?=
 =?us-ascii?Q?UAOgB37XuCX95faAbszViXdol9fZF70T0vEt2HYkENrusVEai5xf8KkMUxRD?=
 =?us-ascii?Q?tkjiK8pNfDhZDrt+2/JorBntEERXKd+zpBeReC3+qBaqnya0h967a35Vma99?=
 =?us-ascii?Q?vPei0e/vr/1WLeAW9rD3naOZX5bAKbcyuExlKkz/e115oz1d2rdNUKY5Dt02?=
 =?us-ascii?Q?E68QEU3vaTsREN4rpFcSVF/+u5ciSH63To+yyG7noAL3zvFJcgB5ERR58zBG?=
 =?us-ascii?Q?rAprYWjb4FoKyWUMfpWkky4A7nyWXjbxT9yfR952ccjSfCwo65r9GEEZ7Jf7?=
 =?us-ascii?Q?woO2wKpxQ3O8TlHAPeDCFn0iiucNbTlToblu55Vw7zByPdqllwrS4Bpj8zdR?=
 =?us-ascii?Q?yNigQlWBNDzybmyfqMZXr8wFacyb4AEoF5hucp1OYFfv2RwCgFnlndnwjXx6?=
 =?us-ascii?Q?4uTPQkWktqSjF8jWS8KWR2flb7HRquZz6TJc/8pyMPuuXiHRbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:45:35.8336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4637f636-8b27-4e92-910c-08dd04a1daa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
Received-SPF: permerror client-ip=40.107.92.74;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Nov 2024 09:07:47 -0500
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

Commit b12cb3819 (amd_iommu: Check APIC ID > 255 for XTSup) throws
linking error for the `kvm_enable_x2apic` when kvm is disabled
and Clang is used for compilation.

This issue comes up because Clang does not remove the function callsite
(kvm_enable_x2apic in this case) during optimization when if condition
have variable. Intel IOMMU driver solves this issue by creating separate
if condition for checking variables, which causes call site being
optimized away by virtue of `kvm_irqchip_is_split()` being defined as 0.
Implement same solution for the AMD driver.

Fixes: b12cb3819baf (amd_iommu: Check APIC ID > 255 for XTSup)
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/i386/amd_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11d..af0f4da1f69e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1657,9 +1657,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-        exit(EXIT_FAILURE);
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+            exit(EXIT_FAILURE);
+        }
     }
 
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
-- 
2.34.1


