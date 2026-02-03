Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D006BE87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIVf-00029k-Td; Tue, 03 Feb 2026 10:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVb-000281-Pu
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:07 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIVZ-0006OW-0x
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:40:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJz4I6eeZc1h1YFL67/HZsG4ElKrGHarGN6pvemmCg96WgqdDmxH5yUyMevn8bV7heMU7gx8zn0yaHyFpYTtE0FAPgG/yIEphRKBiFUpt1BMMNQ5Og9lFzQvfklsG/MCzh24W1i0mgOKU/3NLewjcxUmw897Vid9V+f82gelHHswF7wzrGlGbYkQ+dUh92pCtsu3KGssy33G6WgJuiGnHKh2e0w/8IKWFxEcxs3d++kj5RhADFe/q3FZZCSBgA9VVivK1lOU9OQ0KHda7cQZebx8coS9ICHG1V5/+iaP3PckedsMmUeYBnJhcL75hQohc+Z8KJ92mk6vJw48FkWNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpWaMlm7FwL/g24UtmrhBRNLq5bbsotSKkJqK9NGC/k=;
 b=DJWsd8M46+IKX46vLSuJVW1AMyPF45Xg+/JDc/JcGuTsWHv32oqBoep1+vUVcT77iBDH45Z4sMZM/wkls9m1FGM/uLJ3tlg/Rd5cjeN5oQDCt6PqVqKDBRWW/FepgvfbOjc9y8uq/j9bGZX8RgZa4ByzXEequh3Dag1PdBRqzU/5Ap+ZRufbIL94qWqpor/ZdUCJ5ISwdYDfZu8rCJ1B4R6vSCTqCBYBd6agVGDVpoCdhNIc4a4k63hFRNvQ6wlBeEyRtDxUsNWVWF1BBOvsuD/IlgFuVI9j4Sp32AwWGnOgPsDf45a0C6QJ+xfX6mpPA7vZL6q7Ddq+X/VF5DoTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpWaMlm7FwL/g24UtmrhBRNLq5bbsotSKkJqK9NGC/k=;
 b=a0vQGQHFDiRTTuZjoCfIY1vMezlfZUnGyto/IwWbwYG6jnpaHvGrCNI8rGMO6MCd97NKJTFHc+xBTJv3AKNtNKYOl9+wV7Ls7GrzMXhSbSZWJd17w/XqoVMcLgpWFQr199MR3eTBgOas+C/4TbqitAsrbCImsPMleYHCJJAT/+M=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:39:56 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:60:cafe::cf) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 15:39:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:39:56 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:39:55 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <mpekovic@amd.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Date: Tue, 3 Feb 2026 16:39:51 +0100
Message-ID: <20260203153952.1337-2-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203153952.1337-1-manojlo.pekovic@amd.com>
References: <20260203153952.1337-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c96407-97bd-4c82-58af-08de633a7bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vy1Iba2gF5b2+z4sILfcOjABwf0cp2bUKyfXdfpvF6IKQUtH/v7Le/b1Mgni?=
 =?us-ascii?Q?ru9zzNeb481d7GMLaqSAQgu+rrGf9f5eJvfPb7TVMA0TcOjlVBqo16R2w0yk?=
 =?us-ascii?Q?E+9Ket7K0anrx+c0TXxowpYXN7i4EN79Y+dwRVCRcLbbb/tijsOAitGdrsOr?=
 =?us-ascii?Q?MU/Vw3jkQQnetHCdOznCpCGQHgYrB3wJ025dkPZylkLuzDBGSVE5eqelgIv9?=
 =?us-ascii?Q?Oyb98V3ppRagHPoF5AjkEGlYYZHqYnG/wnA7VkgHYomUDImOxAwqNNHMSsi/?=
 =?us-ascii?Q?lbrooVjYFOp/UqcHbYfjcFea5hIZSa11NxCCDtuNblcYPZJ/u2Os8/Ef3kMJ?=
 =?us-ascii?Q?Jk6iLvN8p2lvnIVjyUXfBwdWNCrWLV4SLtVOjeJi56UyO8liUy4CsWefsS9H?=
 =?us-ascii?Q?YberPLgX13L95aAeslsVDK+AZRtD9Yj6AQFebM+cIXgeUvwPbeQ2RJC5m0Q9?=
 =?us-ascii?Q?XpxeT0KkfO4Gyx5IkiS5DMBw2gi6Lm0QhmlJNdL5OvVnc4sZZ5fUWSKByaQn?=
 =?us-ascii?Q?CTX60SVpmLRt2zFAPm0MIxQlMSnq+c+h+hJTQ0Dw62nvb0lVYjNBNmvc27HV?=
 =?us-ascii?Q?mkEOjvgfYAU6rzPLGkjahtrn3Hg6tY6ZAdAeWCd2LLdBhwh51KQyRiWZdx50?=
 =?us-ascii?Q?HElazNT9HiO0QftNRkc7jYpGmE4P4VY5Tq7ZtLyFeL3ulvAKfWKwscTU5FDG?=
 =?us-ascii?Q?UhapERHj8Q/akbt+bMvcuZjYC0zVspUzDhh3VP1SdMxNOXuVVc0dzEZaSwH6?=
 =?us-ascii?Q?OHk1sY0845aFdIv/LUkn6onAkiJIqCFTWiR1UutQUaPxQwPxyy2aTT4DPZyw?=
 =?us-ascii?Q?vDEmtIzDNwc5gIg4mNqMSJ8zYRx9g9TRD24Q4EUXkzYNmZKhe9lFsoPgTzuJ?=
 =?us-ascii?Q?TWnLd+KKZFK6wTRTYeGEejbAQNDLwA78kR/fzuOY5anyZCawX17iSUM18b50?=
 =?us-ascii?Q?x7FnthHviI2TGQIj4XYyxyg9DRlHBudEDSSeAginr4SyFDePBez8UL/DIRwH?=
 =?us-ascii?Q?unce108mlqWOY7EIRkwcDTk0+JSKSaIns5j5UtYEbmChIXfL7RYEJrSRpiKz?=
 =?us-ascii?Q?B77+GboQUzUZZAmsRm2p6MNXz6HbXS5KZEOPOWtKzFQo/po7LSt/Msw9C4D1?=
 =?us-ascii?Q?/pArj+Y0pExgmW+N4+RfDMrreyIjiXhl4sDg1Zca0xkfDD4UqMWFWhxiJ8u5?=
 =?us-ascii?Q?trbLYAAdYtrDngpVxLU+Dar1LwKGKLscZGnH8RWTcxAWemtEV42Zjw+pchRW?=
 =?us-ascii?Q?4r9p0sfvetciGeuzJSUqagDqVxWMKF8XFeVyy+fZkxKtsXY7bj3vSW3Bg1mw?=
 =?us-ascii?Q?IXS+9XgcfE2F5defW+NABC/vAAOIdI6m9u4F5ozyWb/cpd0Ykg4LntsMoGi1?=
 =?us-ascii?Q?pM16cHht/wmy45U2WCE8/hsD2g8XA3b9I3mggTMNG8vH3BspUN4alSZCtodS?=
 =?us-ascii?Q?b6WOAYdg3KN7+oj7cMdvY+9STlpTOYHDMybZ2Pl9FmY3+addBBGrkxAsiPTD?=
 =?us-ascii?Q?cg7U30ufEP+ZS0hwP+AtqnZNQnUvTz4h3G1Ku6eDLZ7VU6aTk0Kmt1ewN88r?=
 =?us-ascii?Q?I/b+yUuNJHEDryMFZ1883LVv0rt7PbqhKVSL6jlHhXpCo3XAQlEpEle54wRg?=
 =?us-ascii?Q?jSQ4vXB+oMXb92bGXvnolQnlaWWl84ZwMqpUHi9+MfAKZd1LoFUSj688/3jO?=
 =?us-ascii?Q?LsQWNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KJSXhoz4hA9syJjNSO/tzNLsYBhoo6XgB+/mE49ejO3dyi3JxAdFI0wTqGJ2nd+j43sfJDM5Xb26mVC5/Abkouc4DBvU4PEwkq4UNB6OSd2Pk/oEe6E7y/pbC35O5rJTd2KuYf2FqB1VvpJUj4SMFPS1mEI41zU2IecNu8BlzwPzbo5XuzyHWNFN2B5ulzT/q7giURn+dtJAxTqURb/W4Wzvw3sKHZYD5VyOp2XAsu9iS4yVJPCD4yjDHSR28Vh8G7Sa4vnwvGLsc0L5ubUa3uGUqqmmXBJi2IO3oIjBma5bBUvfVkBlJQd2MDnzYLTuuDqfFJ5JSoE44h1FpgCcIZBpG9KalzvRfL6GgEmQe5nJUuElGCj7Z0D1xLov+Gl/A7zmg19Zv0Lu/D1N6ha9Z+tH4cv5XVBossn3KpgecHEMqhsiEG2FmCEc/vw/dU7J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:39:56.6786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c96407-97bd-4c82-58af-08de633a7bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Manojlo Pekovic <mpekovic@amd.com>

Extract atomic capability checking logic into a separate function
vfio_get_atomic_cap() for better code organization and reusability.

Signed-off-by: Manojlo Pekovic <mpekovic@amd.com>
---
 hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..6a6c8f1807 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1900,13 +1900,41 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
-static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
 {
     struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info = NULL;
+    struct vfio_info_cap_header *hdr;
+    uint32_t mask = 0;
+
+    info = vfio_get_device_info(vdev->vbasedev.fd);
+    if (!info) {
+        return mask;
+    }
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
+    if (!hdr) {
+        return mask;
+    }
+
+    cap = (void *)hdr;
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    }
+
+    return mask;
+}
+
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+{
     PCIBus *bus = pci_get_bus(&vdev->pdev);
     PCIDevice *parent = bus->parent_dev;
-    struct vfio_info_cap_header *hdr;
     uint32_t mask = 0;
     uint8_t *pos;
 
@@ -1934,26 +1962,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
         return;
     }
 
-    info = vfio_get_device_info(vdev->vbasedev.fd);
-    if (!info) {
-        return;
-    }
-
-    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
-    if (!hdr) {
-        return;
-    }
-
-    cap = (void *)hdr;
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
-        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
-    }
+    mask = vfio_get_atomic_cap(vdev);
 
     if (!mask) {
         return;
-- 
2.43.0


