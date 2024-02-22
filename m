Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9FC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 03:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd01q-0003Q1-V1; Wed, 21 Feb 2024 22:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rd01m-0003PR-UK
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 22:45:43 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com
 ([40.107.94.76] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rd01k-0002z4-Cf
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 22:45:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwqSP+Gsf99HfDfucLIoydKFYllHJ0UJaZnPaBCm84H3VSxB56u8wrp//yhc0dZ6KNBZS/wjJi85S3/syFYCZ7WggOY3uAg2yzbiqKTcuuCC8D2nyC1VTtnrHODyGF3BYtpDXRGTp+TAfSjYWm13d3Pz0qR/Ig3Zi1d5zTFfHrvskUz5gwtgk5yBh2qQa7ytcwFQriD8fh9ZIJ4rtZGJpIqjmRt7QHAiKuibtdQFtbbfFRugRVXJJ0aanot1xb8fUHzW2vsWIbPbiGBzb7oAbFj0+qgDIjVs0nq8J+8+y65+C87Ols3JVndSw5gfiX00Nkkk9XTkQitWSom2RfAW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWrbS8eJnNTz3LPIZ4ldZ403pYsWg3XyASNre1CQILc=;
 b=BjmewEMKx56IWksh5sbWkBN5RrU4RL99b4+2VHSiVkTQ/nyOcWQk/aHaFs4tjBPwdpNgBd6Gh/wPpSFIqvcObr6asYBZ+3uYKQ4GD5J51xADw9ktFMrYPtwpgqfoc2fqKjy1g+km3AYRMSr9QRIb05GsXdO/aKUWKnnNJquXJG9V0k9UecMyKMGrxqFmfn2HN46jDgce7As+2wIG7M1sE9O1lB9+0AP+FetvyR+63qQS4czIZBS0mXiGnZ+RpvT8/NNvDSltZxku0wdhVvD7hD+9OVYeB5450JpEJi0ILAoDZ4lr9ziWcZZFUta+MCwK7NqaODyrNM8XVarX8QZACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWrbS8eJnNTz3LPIZ4ldZ403pYsWg3XyASNre1CQILc=;
 b=2W349JsAe2TcU8cgkqt43QQMGfIXEos0gafQPM1nV41EVnYfP/BQPXuIDi3vtzG7AZ4dgoxkOQLyatOdFyxWpPeOxfDDeki7oCyuD6iUY8KGtX26e1o4nAeHjApKi2TBuegfMshiA/wMp4g6s5AJ+oC3n62FbhmMmtwVC68/oaQ=
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 03:40:34 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::bc) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 03:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 03:40:33 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 21:40:32 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Date: Thu, 22 Feb 2024 11:40:10 +0800
Message-ID: <20240222034010.887390-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222034010.887390-1-Jiqian.Chen@amd.com>
References: <20240222034010.887390-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: be96fb8d-92bd-4782-e5aa-08dc3358067a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlXMYMdoyal2pqeN5kBDGHTjJl8E5Ulo56ULJouhbzfN2E4MSf1CCVJgqAKjIgk05CZB2XefHULxdJdKSQjco19zX+cCOD4yoctvsNYYgvdf4RWh4jTrOnBFryxAkWDwuy/4Gpg2E5sQv3iXrerAZtLfufCJRZMZ5LpNZZPS0jHzmFt/cSY0vHhsDW9yzseeuXC+5wMEFCD/hJeHnMf7syo5OCf5DEz/vR2Gprx5cg9KqXWTtbEMiZ/BXjBeGu2rme6zLi4XbPO2pl5Hk9aDOt0lCu6Tkj60AEkOyGK9L+FYcrLAPFDvY8Nb0SMjYF4lAVvfIDUnNm7kLCPXPtGpDgBfLoUV+a3cTIp+7coK9Hq8a2Bd95E+/hOjB6UHD5dn+PV55cJwEJI+uDb0AShutXFifpCs4Sy9eNAtmMunTNEAvMjTHmPqIRkvfgl7lD7rNAgWIQM5tQELVaCHqklx7mbsgcVfXMw4vVKzhkKdhjtOMqg7TL/nCWO70f+8tMscOuiMOl7sDL8IEn/qSrHTb+P6xTUu1vjQ5ijOlnjTqfMoUfYzJSMu6xo9bXPG+mPS6agNJxGGEYmJadSSvHelfyOdq7CvE7W7Rs8kcg/OyDa1MznhZjDxr5xSevXJsHpFoyDQJFjdHUU5ufcFodi0GXLFp+AzOAjmNzpn6avW8pc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 03:40:33.8155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be96fb8d-92bd-4782-e5aa-08dc3358067a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
Received-SPF: softfail client-ip=40.107.94.76;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In current code, when guest does S3, virtio devices are reset due to
the bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c68..da5312010345 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2197,6 +2197,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
             pcie_cap_lnkctl_init(pci_dev);
         }
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
+            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
+                         PCI_PM_CTRL_NO_SOFT_RESET);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
             /* Init Power Management Control Register */
             pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
@@ -2259,18 +2264,46 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool device_no_need_reset(PCIDevice *dev)
+{
+    if (pci_is_express(dev)) {
+        uint16_t pmcsr;
+
+        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+        /*
+         * When No_Soft_Reset bit is set and device
+         * is in D3hot state, can't reset device
+         */
+        if ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3)
+            return true;
+    }
+
+    return false;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    if (device_no_need_reset(dev))
+        return;
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        uint16_t pmcsr;
+        uint16_t val = 0;
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        /* don't reset the RO bits */
+        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+        val = val | (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) |
+                (pmcsr & PCI_PM_CTRL_DATA_SCALE_MASK);
+        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, val);
     }
 }
 
@@ -2297,6 +2330,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, true),
     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 59d88018c16a..9e67ba38c748 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -43,6 +43,7 @@ enum {
     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
     VIRTIO_PCI_FLAG_AER_BIT,
     VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
+    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -79,6 +80,10 @@ enum {
 /* Init Power Management */
 #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
 
+/* Init The No_Soft_Reset bit of Power Management */
+#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
+  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
+
 /* Init Function Level Reset capability */
 #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
 
-- 
2.34.1


