Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B3E87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHj7-00018y-HZ; Tue, 03 Feb 2026 09:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHj4-00017Y-Jt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:49:59 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnHj2-0006GJ-NW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:49:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWllHgOHdNRs85twg3tRcbM2kdnR2E7Ic4YhNMgefayu0tZhSuMOjK8zP5E4pmnogekmmioA2Ky0PvAfqqSB3ciRqqv+MjzoNaKukSHVIA+nDDSR4w9v5bgItvQOuF7x1lCcV2yaXhA/lH3rnWz6FpWS7M5SByqOgvGa6jboarodJSmgEAMkCl3KN1WoMaqNRbVXvTpBGLStYUHM+A0ahOd3dypc5lkTnfL0Tisvy5IEhkuknopBnFHCzu7BhiSRGSU+fNr+hCOeL9X6SBFAKgPSuBhX6z1BdOtYIoo5XpftHutTsk7bCdDiFGvsMSzEm5/VWwE4ZJEHFYnqGmCifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p+r/FzRX5192klWXJiyh74BlMwbVPJ3CFJjGgJEoiM=;
 b=uNJtB2bf8ogZBAHSbzCjI0V6BL+90ylnId0X536vKPA+LqxB5/OHUS2Y4g5xqP79j0FYOEpMLOLZesz1Uqu4nDzta69sL+V7lc8vPmS+at4gP8mUymf4Pe+u2ONnB2QGtspQV1pf4kZiL7z4BO1AqcI7iLmGYtFNOHKWeYUnOADpZPI2wiYM9qJxT70iPnPKeMhfe2AFcxfm9rh+aLgpqDgIsjZa9StaXBhsZZDtMdpY3afGMtIpZlZnKweo28xjt57ebjiFNGd0FkN1IIKlURDlX/7ImYZaT3qQ3cRFBtc/aDhS3liL01r4DXohv2Kb9wOBuBQKOaVSg3ZWGWXgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p+r/FzRX5192klWXJiyh74BlMwbVPJ3CFJjGgJEoiM=;
 b=Pnjv1UQQyHPV9NXfcu9pIAa3suQ6/OMO95kPAIjMTLiOg/9n3niFJRtIgHIvdz12cCscnf/tjaS5e8RVfCKIQFkTpLEskJIYY0iRUEXgJwJA3Q9B9JelCH3gy9rkcDt4mHufxAFfl7j93po8TfKed8Ir1JkaPosA9xN5EgYyiK0=
Received: from SJ0PR05CA0120.namprd05.prod.outlook.com (2603:10b6:a03:334::35)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 3 Feb
 2026 14:49:49 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::93) by SJ0PR05CA0120.outlook.office365.com
 (2603:10b6:a03:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Tue, 3
 Feb 2026 14:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:49:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:49:44 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 08:49:43 -0600
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@example.com>
Subject: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Date: Tue, 3 Feb 2026 15:49:38 +0100
Message-ID: <20260203144939.49-2-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203144939.49-1-manojlo.pekovic@amd.com>
References: <20260203144939.49-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6904948d-f841-4895-54a3-08de63337aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3D6Pcr0pq9BPKtgqmIKfCMij3sj2XRnQy2sNgZyYiS4kzqbYqEfY4Db6Kclk?=
 =?us-ascii?Q?pwfRawSAIdEYfvbhdQiN9RE+hhwOfwLS7dc5p4Q563JUE6ZqIJySxmDUGuvb?=
 =?us-ascii?Q?dp5DZpvIuPTn5e/yo1HBb0H0DhYN2yQR4CX5pB9K1Rao/h4+9fhupZks24j6?=
 =?us-ascii?Q?6gYc8Gp1pG0DaMTTZatliYLtbxDGttwuYJIqu4/2Gyu6gt2K8XR2dWGSANja?=
 =?us-ascii?Q?T4AGwikW3eO9z8fkwAz4WfRLtRClvGnbMO20AwDe3ennl3vIlkz1em+zEa24?=
 =?us-ascii?Q?m3bZHV75su5ZtKiHGwEdbZXfWPUUTkEu4V5J+AjjB6sf6i9KuE0P75rJ4ADV?=
 =?us-ascii?Q?z4HBFxy/GpDi1xMaavKhx/1RqxpmqCvvy456w0KJIT436rWg9U16nznwTtM8?=
 =?us-ascii?Q?tlSZhE4lDEqHPIvsV8/nCbaeETQZYhcyuhMgWg+Quf4t14qhFbo6Bm07OKSS?=
 =?us-ascii?Q?jjSvv/1AeCFdtmAAW7bqzNed0/hxXdIG/qtYRUIjvj1n9L0WxsvsCKAP9VT9?=
 =?us-ascii?Q?VYEYJ+7sqL/Xg9vsEz4TsJzPan+/o7DB3v90z+UINAHDwrlfpc6NBdJ4LwnR?=
 =?us-ascii?Q?7vMHUv6wRpIuhtlUWnDrZj6bb9+nOyvG+g3tVvtZLHSqgebi8nSTVOmyeFzD?=
 =?us-ascii?Q?+/mOdkB9iKAKySX18foBiFYoEeHRTB04uIUSXUFMPZ2uVelnFe8fR01DiUE9?=
 =?us-ascii?Q?szyKOPUrzloalQjUlb1aWZiGajwnlDEeZs2zmmSftf1enQ5jowFkyl5cdyJg?=
 =?us-ascii?Q?yClIgY4Q4eRGPICgupEEHEML4s9ojE+587DVOiUCv8Q+DpmHrQM8C1E7ENBX?=
 =?us-ascii?Q?WXkzN6r3/RqAgmxMYNPJ7GQAvAx0+X959oSeV0Rj1GYQdeeLZVmcZ4wm+tJi?=
 =?us-ascii?Q?m1NiS1pStyhFaPVkRpmbCrGMp2Hd7nGcYfAA34oz4+Be3M0Cw/LUjwUvqdN5?=
 =?us-ascii?Q?yQ6ulNsoBN/9dUsQaYFhV6TRGK2PAbt7XdRhIgpje7sK4S3RA2fkC/2UcHQH?=
 =?us-ascii?Q?XBHp/IxJQb+wk+HkWpYE/zLe7gy8otxYmx8MgxBsy0GrvG2ZfZjMF1rROY1k?=
 =?us-ascii?Q?5603qZsQvnaDsjskvheLhqxqF6urRJSsVfk0TDSFEYePQDFMMV9xFNmZ8jAK?=
 =?us-ascii?Q?O+h9BZyipjRVelkTUNtRaqqY0/nSrOJSGBEmJ1AVGSFA9jc9SZsVox6TB/2k?=
 =?us-ascii?Q?O2vKSExydZ9ZRcDs37ZrmkstQiOXCdK92aOA8mzPowQTP6dissyjPI2nkEbW?=
 =?us-ascii?Q?PXz1zFghP3rq7nyQNscGhcejAb1E+WWeve4cvSkNbMyHjTPRAEv0QkuafpnG?=
 =?us-ascii?Q?7Jxwnh4yP633LYHDUJCsvR08juGXUCkW6Lq/LPjwY41dzYxNYVV7skhhLmuA?=
 =?us-ascii?Q?QmhlY9gnTw2M3x2b2jwDiLRQ41W75sy107I4s9SVNUNp1YmMzgOHJtz/gaMR?=
 =?us-ascii?Q?wP7NAXt4MUm3aG85jICeB1Ny/P9G41qzW6VFkUlZ7Q8dvAze6P7g/NivVaYU?=
 =?us-ascii?Q?2kYHTT4JJ3dR1yR5mXddbEQs4EZiFafv5KDq8U+sn6OWhHPsygMEkmBDUp3n?=
 =?us-ascii?Q?Jtmk7iwWkSgarC+vg6nvsIqCrffYejLVACTfPsZaBWPUhnWyAMKnon0L0caa?=
 =?us-ascii?Q?MFSDTI8YEPFwk4XSz46EgQJOPxMtPBGeAYDJb7mCQnXq5ng7xdYrMXKaUNEj?=
 =?us-ascii?Q?BcDRDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sip6U644Z6ZexzvepZhahc+VxeRHw3RY3jq25/MC6OiE7REFEm+L6NUyC1hCC2gqcr3U7mKdcrP4lR04WoyaMK85TVp4U7rDUvm5RjZ6gugy8udMGUB7WqE69WTW6HcNbNsCouUAVARRsv5vzGgYJw30z8jXo95BhqhqqnejU8OrtrWUlLKeS5jyGzWpKg3sCzhnm08vaEebGr58j2ZYbA1KijaqntNIU0BHNTtjguqGHK/bzetMbSBzdyaoP+6WtyEOaau+OSCe+OH2glU/18dRMJ7YcoYY39WLz7texEs0vZWjFZ19C/ZPujWfjSoR/i0YeXKuIWLv53eH0nJ0edOslZa91MYu4ZJdwSzqk4h0ySk0sMInr1ctHHoEoktIZByY69q/hGnDTh89dcHwwKSERlll8bME6drVuNPLZzCabvJV7CGCp/wMte5qCYNp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:49:48.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6904948d-f841-4895-54a3-08de63337aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Manojlo.Pekovic@amd.com;
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

From: Manojlo Pekovic <mpekovic@example.com>

Extract atomic capability checking logic into a separate function
vfio_get_atomic_cap() for better code organization and reusability.

Signed-off-by: Manojlo Pekovic <mpekovic@example.com>
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


