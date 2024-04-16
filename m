Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D87C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcuD-0005qQ-4x; Tue, 16 Apr 2024 03:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcu9-0005pL-Dt
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:57 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com
 ([40.107.237.74] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwcu5-0001xT-1x
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPMtVDqYn+O0tbPlyt3UHwIFaJRjm/kLCgt2rzrzh8ukHQUadEKVpwTry0ZEMIYAjqWy/IngBAbOgkYlrBJwH56xa7lWX3u1hPqh5jNj7VAmtYvBjs3NBXkrNYTXUhTFg0QZWAcnb1Yv+CYx/JG8R5+xdrNo3z/kvt2VoBNdxpF5naz0+O56X29I4QJeWDds8fQpxj+yHEobbLFF12Fv5xQxUrHigb7koJJz/iIBlLKMr1pHwfDH/SPRQgQA0zTqbvoXG7GAWSRajecenXKfYt7KEH1WnYILyppTbQXo6EMzR46C82/DgfrUgGTEC8mg12jPA2vLg25B38dSVyBUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqfWU1eXEp2ZbR32oVbCz+yZdeDAyZeRsf+SQU6ynLU=;
 b=biS7XBrawn9vYsDgbFPza5DocwyrcyuOfWyOMu48XzJXnCW0i6E5KT9mlyGVqUqQDlw4Sv/OBo4Wv5okls/zse2qk/N5lwGCXA7gC9ImFNj/4yolPs0CmHzgW5lS7tIGlEVWq+NDRU//VCV+rZq9gVDtOfaF4IFAQQeSnNO+EZtt5uTk45OIlWM+h1Q6dZH5tAhXfb+zZFENFmJRmO/kB3R5fEpdVV9pK8y2kfn8pIW52yHqkVu9DxOUUHSSTRG167WM73jsuSh8TjqskPejceaVGm+1D7Lsrtl5VhOzz49ky02rKSU1gz9jV+bTLl7Xe6eEcE/9NI0yuzP7MpJUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqfWU1eXEp2ZbR32oVbCz+yZdeDAyZeRsf+SQU6ynLU=;
 b=1eVKHTJWsAm//oZ9M+N99V8/MhfeR8KL+mXLS6hYymsP/NLzGBi/QrEjQnxFSKMcsDafBxnI3pdaQb2KiwujtV5rDbT4Im7PxMtiSUNw0ptjMjib/uusDEqz4nRGoswyAZZR8hFBm4uAb3bFsBt7eA/hjP/HyI506adypKNRXjc=
Received: from CH2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:610:4c::11)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:01:48 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::73) by CH2PR10CA0001.outlook.office365.com
 (2603:10b6:610:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Tue, 16 Apr 2024 07:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 07:01:47 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 02:01:44 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Huang Rui
 <Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Date: Tue, 16 Apr 2024 15:01:27 +0800
Message-ID: <20240416070127.116922-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416070127.116922-1-Jiqian.Chen@amd.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4b7c08-a869-4d01-3a6c-08dc5de3157f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMqkSRPzBtZEUuRYZHFEdd37jz2dmPpIMLpEfPjUgDfceR/Rcd6QfU0uxgnGOBwimrRZzLock4ArWp8FfvQLpLhRpx6CVZ+2caLYLR0/N4aPW8bS0XUt2le3QwCtbgdJMRyt/cQbCUTk5MUXOqmC9x2kjIzXOllAiRuEqXml/xTLxujj/aqiyzu6aW7Awb0woCEXuIiXPfSHu+shbsBSZBiuU+SRLIbbNmPmw2oTlJJYA8uxo4TECOjztDb0oYHassqxJidgMJr2m8i63EE6wJFAYwtvwA4llInmrUdo5idUoo80zYA1mJrucmZyld53B6F9x6wBoROOn6IVpobWnGM5KP9SbQyl3U8IAOKU9Qszn4NW/Dvyu2Z2FtG7H06Dj/KOZjN+lshZbaDTrVbbsmYYeZok6rNw2b2f8rJWTP5BNs+sp/YIONBTiufP85heSdIhG9Nep9lu/q0KbDJEF5OIKHg5BBXGwS+lu389YGqDaW823NlZwSv5o7WTPUKA3zwPtJE2P5Ngwu+NEBTJ6PxvicPIyA1UffyBswaKO6wo2VxeUKSzn4zNrGcY9dUW2nizvZaAeEM/VoGDDADdEb97933hADUZRzFkBjJE0ygfLmpwQp92My/ogXVL1xsvBjSlZwFSs5tLTGLGWmu6MqE/QNZ1LmSK0A9r1RvbkwpG8Y7YW+uc4FrarhzkfFz5JLnjBUY2nAU5ysQWZWwz+JcNKrrM0euh95hYr7gDtFvSnqJEocQJwoS4ppxILKZ8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:01:47.8605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4b7c08-a869-4d01-3a6c-08dc5de3157f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
Received-SPF: permerror client-ip=40.107.237.74;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In current code, when guest does S3, virtio-gpu are reset due to the
bit No_Soft_Reset is not set. After resetting, the display resources
of virtio-gpu are destroyed, then the display can't come back and only
show blank after resuming.

Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
this bit, if this bit is set, the devices resetting will not be done, and
then the display can work after resuming.

No_Soft_Reset bit is implemented for all virtio devices, and was tested
only on virtio-gpu device. Set it false by default for safety.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/virtio/virtio-pci.c         | 37 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-pci.h |  5 +++++
 2 files changed, 42 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a1b61308e7a0..82fa4defe5cd 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2230,6 +2230,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
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
@@ -2292,11 +2297,37 @@ static void virtio_pci_reset(DeviceState *qdev)
     }
 }
 
+static bool virtio_pci_no_soft_reset(PCIDevice *dev)
+{
+    uint16_t pmcsr;
+
+    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
+        return false;
+    }
+
+    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
+
+    /*
+     * When No_Soft_Reset bit is set and the device
+     * is in D3hot state, don't reset device
+     */
+    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
+           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
+}
+
 static void virtio_pci_bus_reset_hold(Object *obj)
 {
     PCIDevice *dev = PCI_DEVICE(obj);
     DeviceState *qdev = DEVICE(obj);
 
+    /*
+     * Note that: a proposal to add SUSPEND bit is being discussed,
+     * may need to consider the state of SUSPEND bit in future
+     */
+    if (virtio_pci_no_soft_reset(dev)) {
+        return;
+    }
+
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
@@ -2336,6 +2367,12 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    /*
+     * for safety, set this false by default, if change it to true,
+     * need to consider compatible for old machine
+     */
+    DEFINE_PROP_BIT("pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
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


