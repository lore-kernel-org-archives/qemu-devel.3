Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66878E87842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIWz-0003eo-Tc; Tue, 03 Feb 2026 10:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIWx-0003ds-IC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:31 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vnIWu-0007Jq-Om
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:41:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXpCyHs1agJsZjnyH/qCe7S9t4Cv1xW8mMcjJK80UJiitifsTOJxiNorEYkWXaf5acl/yu1wgX85DlY9XZj/qeAPaXrMtgdtwDF8kwxHOaoYn7Qy9b04buJ2xOLFd8nrIphXDMXCB0RKponvhmF3wgSvEkWQU0xGg+8+aNai9yaduf+NaLAQ+SUpvb66FG5ibkQT4mAnyyWIPoX/d8o9//Yug8gUhbliEchwHaUGzKe+hDNoShsnctFdgKOrmp458PI/a236MbPw9EaUBfMwZqBp/gYEITIW+jJFtpANABqPb/8HuHSn/e06YTmUnRE7x3kfC2qmFad8N+4GGYMTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpWaMlm7FwL/g24UtmrhBRNLq5bbsotSKkJqK9NGC/k=;
 b=OHj+BvnUNoI9VsCFqlW+30Qw5gON0RlLV6+zrf20xj18oUZ6qa6hAdBGPxzCybOAMo33S9eGM02E2C37XgDiD6On5RjoPMsosuiTUiDscqYI0kr8R+QpqAHEotYe9EtW0Q3zW3uS2sqRucd6xtwd5EWxF3kZ4MvICPQcRCcpTKQbXIxHnJTHw6vlCslMMq95xUyHpcCRpCNrI026rIfckbpXlK/F8nfAqJoABMYRyTnXRClgDoAK1HWTCmD9XTd/KvMSYlYCBXzqsZU2Zc7MMC8pYJsFJpEY0FwEVj2iR+vVd8Oz/hXoqmvV1B1B8e+zeMMe5yXb2zpMuNsnVmH1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpWaMlm7FwL/g24UtmrhBRNLq5bbsotSKkJqK9NGC/k=;
 b=Ho6jCMRVMP7FZ9gIyXYtljreIBRp/iGB3u9Fxx2PF8qXbxCL+26wrOutfTT2WFW1e2t49RxmP61otGOZAyz9PWvNnefNfgE7fEIhtNYQ1zD6sTASEkt0ta8En+8s9BZdDoGTQsdNpl/GCQYFcpF6ifmKDb2Hlv2soHUnB2YeRMU=
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:41:25 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::34) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:41:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:41:22 -0600
Received: from RSBMPEKOVIC01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:41:21 -0800
From: Manojlo Pekovic <manojlo.pekovic@amd.com>
To: <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <Nikola.Prica@amd.com>,
 <Dejan.Andjelkovic@amd.com>, Manojlo Pekovic <mpekovic@amd.com>
Subject: [PATCH 1/2] vfio/pci: Refactor atomic capability checking
Date: Tue, 3 Feb 2026 16:41:11 +0100
Message-ID: <20260203154112.1668-2-manojlo.pekovic@amd.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260203154112.1668-1-manojlo.pekovic@amd.com>
References: <20260203154112.1668-1-manojlo.pekovic@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: f120f274-312d-435e-06a9-08de633aaf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFbm92Xwb1JMVKY/2ZjOTxzKvoxC4cxEHcnssN8C0jbARxIjNO5Mj8e2qalX?=
 =?us-ascii?Q?KEVqVz20VRESpc6kvfu/tlX+CH/MwNnCGRmgIiz8py+3eTJo9q9Xp6QDgr/B?=
 =?us-ascii?Q?T5gaI8OqCPuG5R20MYFr9QyXcnUiC5JtnHYaKb9kLgHbD0ZlAzykNZyaiYKJ?=
 =?us-ascii?Q?4QcPm8uSKyt0BNyeb9Di1M1+wvbE2J6anYw2A/WSFtJB+W+iInY+mG5iVHL9?=
 =?us-ascii?Q?MvCPc/YnLcGpQXm2IqexT5EKFFTPubyREtJ4xDwpuhyWHoJbSr3+NEuBEwN5?=
 =?us-ascii?Q?WSpePiGMI2g/A+tdyziMIseMYi4+ujjxtVTYZ2raw+zfbEAvdsVBlW7uVDEc?=
 =?us-ascii?Q?tz0dwdqIztOgJEH91+Agf2zaloVj7x6ObsDgd0hE2+ziQR3L1azU1nsCi3fy?=
 =?us-ascii?Q?+PltKrvFsb/F9eAb3SOb8VOdQZHKSQQ1J85Z5h3stg7tKrAxMDBX1iiKd2Ee?=
 =?us-ascii?Q?Hg7X0qHMc3sl+p+ZgkG75szDkN+4K6sZ0Q5aHV5zcVf71l/x6dyfz73XLQkJ?=
 =?us-ascii?Q?xSktZ799HCdSHIufIsKQIqObtRK8cVl8GOpMm3yqBwOEhalSs5linVGx8KXz?=
 =?us-ascii?Q?HIJM9E+y+WeMGY2sN0yuqTygvmGohXuAg6uaimyadZPVYu8FIbuDsEp/NOwD?=
 =?us-ascii?Q?UqrP5qQGfagKa5TXhzIoNYAJluODbyulLQQQNsUHL/TL3G1RSi5CUmZug+Uv?=
 =?us-ascii?Q?xFpjhNXMT2AsUI512Lppebr5nkRVFIAqFYAdOqCblT9IK4AfjEh1+ykvdPh3?=
 =?us-ascii?Q?YpJ9zjJB/L68wTHyXqtvCJPK4Cezc99xr77sihSnGTz9Ubv+nOZl79LCKeAq?=
 =?us-ascii?Q?CZxhOVZkn7w8nJzaW+r0JktHmocmYHElOXAZRiKw2XBDgirGwz9agUlQBmw5?=
 =?us-ascii?Q?uW9WfmHRYzl9FRWj3axDi8TmZdzBjsTiXsWyHrnXXAk181VYAWuhuk8xDkq6?=
 =?us-ascii?Q?lfFawNjeCX0ujn0LK4tVwtVWIy2EZ/69A3DLzKPzbkfv6G15vl7dAKEJXxTg?=
 =?us-ascii?Q?ak8ex9/XvXwZxu4aAONxGQhb19drf1068Q8nP6d1/2yghpwBF6IUNNG1TNsL?=
 =?us-ascii?Q?8Rdy+eJoukqmr/oLkpVgsBZNR5eoNo2LPB55tQztDApT22f6SPpSEomBcGYX?=
 =?us-ascii?Q?fM2ij96Ac6VEAAWTTajeiP4kR1m3P3Gu6fi7lyAcyM0CmLBQc3pfdNur9V0Y?=
 =?us-ascii?Q?/LyiuAmuoQuL6xvPF+IaMl0cpzov7kCShqbmLf+0vWLYRjpmE+r1efD553H+?=
 =?us-ascii?Q?ClnV1ep5/P9tGmJ9sUGTKImX1pbcoCxpwUAi08y8wnJ6as0hK16WoC0iJqoh?=
 =?us-ascii?Q?1jG3rqU0HwgsR7JMBp8ZDQ+71tZGIBNxPL1CtdRiMMHiTjtyIWDJ67+tIwJi?=
 =?us-ascii?Q?OeRAAOqPhVJRe13NNLsvE8r8gB1DaBBwkyxurv8zrRX3kE0PNdd1nBibNqfs?=
 =?us-ascii?Q?H5I6UZ4L17hh+e3xhIgJJZvGMpK/xoRrB4TkYl2spnhLNVAhrZ3IlUCXtcTT?=
 =?us-ascii?Q?jyg2DSFFIO23mFBFAaS2xLOMeCD8ya/SK/bHOefO+BPgfNVL/wFOqFSav1RV?=
 =?us-ascii?Q?RLZSpWoJvH+MVecYg9fbOsFahYaMFOCtAha4OKozr1d4ZQUKx4QqUlp96+Dc?=
 =?us-ascii?Q?fbJzAEt0P9A5pnNJ4Be6oWPzuJD3to25Gpeo7mfMuNg4OGwq/uNJ84VBxEGt?=
 =?us-ascii?Q?7pWqYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sk+Jl+43Eqj6WnD4vgV95Z6KfiDiHg30vjSTgDMNZBgZwtQRW6ozTkUqeZjJRqpojsuEP+h6dlB2qNeJlgX8IzQSxJaX6EgS1PQPfK3a/5Bf4EGQm4dy6mWadBNqLjzwTHiaSaEe7/OuJfSXQrZUWlReoAiwyeiiT/S+zE/wslVCyfwqdeW0mtZQYxZUbfijvAdbbBoWreYFnpu/IRDKWRvLYpvc6TdjvJSxJYDDLHvxvYL0drrj+/0qqfXwGruN/Fru+tV6FdxqMZTW3T+klMT8nuEDzzDwgPswbXemXyNJXpmm6PqiBD3NtV14t8XG0QEkjh3G7vr1zdOucN4uM5bG52QIIsc/0ZogVOein0d+Nu5FfAlLf5kLYDlTRZUfK0m9KGjlxnZ8+AKDAwIB5PsFWwJ5xpt7CAP7T85VNyiB1NiofxHqjmxDhO/1A+/X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:41:23.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f120f274-312d-435e-06a9-08de633aaf5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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


