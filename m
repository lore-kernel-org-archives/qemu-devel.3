Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BC8C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7AhY-0000qS-I9; Thu, 17 Sep 2026 07:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x755I-0007Od-1a
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:55:00 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x755G-0007IX-0U
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMbZUgtPnIUOJFwRwcPI00SATtVOoAc3STMoGYatNlVHLzEhHJW4YWPKqQ0FArmET0qi+1HYXF7tsuPt2o2zf/0bgYsXfOTmBZcnHiY1I+iiamil5pMDye4V41TLEpSlzvaJawSXWdeIqpxAHJnXqM/5ENt+OBxffG8oXt9Tk7uCsHS5vaA8CRhXxpzfPwQd476X+UbTf1omvl3y0oSbEJuJzdFzVq5ybb2VWyNQrBDII8lygFZbPGqczN8keI3G9owgAUBIP0lC6tMx47t4DztXjZQj0qJTDCTTZIPBkOzvg1uWTMLB2ddlrxOF10yiLimpBHftlNbUd+8iLUTQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGc6nkLHyDV1D1vmhf4UtYW+sXCOz8V3Rt9ODuzlB9Q=;
 b=kdWZRsjMjS3133JlApl5w4rBFPWbuLqGmEyLittBLtCQBYuewfLDlZrSM2DFozn+udc02/tvWDpA/XgiOSxqwKYqKWupKWDrY1hzKf9Zd3TZSEKBRtHlguaQsRF82tJs+7MXir6jfHIiIvHJfo+E5vUndXwVTX6KrZfY2ueYw7VjpGwYA6Ej3QNDZAsORGapAYIeCALquB3b+osq2m8AFqGy8NRXml+3hfR10qrS8FoJrHNkliCdfDAPea2d19VB9e+G6b6kpXEZ09bHArTympJWbfcbJanxuPKsy2ZLkVE4v1IW0dSNaJvshE4prARyoOFZx78eqzRhtoKTwkbZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGc6nkLHyDV1D1vmhf4UtYW+sXCOz8V3Rt9ODuzlB9Q=;
 b=vFVxIOfjbg9SqrR5U5tz4MK/ENBa9dh+npe4me2Ek+rxFxNXWfXiDTrZO+Ejd6bANuzzFshOkb6MH8eVupDxTK5hpJKQO+I81sup0EDWCua+MEDPIbeDw8u/ZCg6HC1Ba/O/6VzpvBR3YA8cRiGEh8RJh9Zz5oOBomudMozCw80=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 05:54:53 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::7) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Thu, 17
 Sep 2026 05:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 05:54:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 00:54:52 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 00:54:51 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Meng Zhang <Meng.Zhang@amd.com>,
 Baorui.Liu <baorliu@amd.com>
Subject: [RFC PATCH 3/3] hw/virtio: give virtio-cpufreq two MSI-X vectors
Date: Thu, 17 Sep 2026 13:54:17 +0800
Message-ID: <20260917055417.495-4-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917055417.495-1-baorliu@amd.com>
References: <20260917055417.495-1-baorliu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: c65a64be-45d2-463d-c76a-08df14803197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ETQ3iDtphkQNqHLWqtoxipA6Go6nyaj4ygV6rt457Rhd/JuMwK0ii826VZYR2Pi47MdZ7Ba2G1mNNmBXuiS1op0prkeF+fVPiwBYjJHEi4nu17hhja6QJnanqBYXrFgr7YmzO0olPA5KFDwCc8F9ElGXPdzy44BpldX32Yq+eZlRiUoFFvwyzpXtZ2K+AkfV7aqoRyo0WtPLgFC7xI3i2tN06Xg3IswuxJVh6ba+sS8gxfesCmyaaNgWIBGXcCFxZ07osVJckw4lFS9f+8LAWXfAaAhDDm065zQX9kQq7ocictaNGuynG8X5lbrgNPwJNKtONgDYlFyG/qLhoqAwoeEpoZ3nMQ2a+I0je08M5MEdi5YL8h2R8mgitwgd/1ATKiTIWY9v+tDF4idISCBOAE9AZAMZj5qcNFY6borpBXmNSY7ILvClNjV1MwfLHZyUkSDVxMYYnh+uspj0Yb8yMQnjDWBgayCJf8zyepnEswnFfi3OQGSu31DQZQ7fAvjbXMV0JMhUajzOIaggt7RgdEhunf07+nqbBaYTn2dFA70w3uie7DDrl1LWvfBm88fFy+aZ8Xq1ElBrM5jGr3ZEaWnEyTuBixCdNN4GJ9PvddQrUU6yMNG86WfNkUcEi1Cc1nZYhc5/hUMLzhhRSggzo4s98z0JEDLwNda9sXJHvgAh3ywqCKPBJ4/R1d3nSglfFuOJw5iaxkiPL2U0WXu7KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6G60AcPTpEG0X8aT4hNiT3BfH1hSDcVC1jaS9Z476oFhK7EF/SH1sZZujOGLy6y0Pkvz5qsvkmOY+ABaIQBPXvCJD5fB49C8t7hXQjqCtUYJ0mVYVSF6Gh8sn+P2YLidFRJhmMEJbMA0MMS79oGIJlyLtbjrvAZ8DlafB84A15j4FbwBUe9wji+k5uXTH5/X+IM4eOIGmabvZoGCOP6RvfcoaWhRTJErEZMBDsL2TZrBAO3fRl8TdMq++Kfuf7gi6UI+nmq2VQXr7SIAAIwL6YPGQNd2C6hUHp++ka4bIDA9MEi3hJssrgidTxoPVY29BD/CbvjOY6XyjZnfx2p+9J2tmMVhe9pWG8rvqrc089j8P0coQtWBhLP6aGTLfcWUPYc/59DRa/LM+oxwmKnXIvlEKd28kWNXE81zyrWxgeFuBAMi22BuOCF+nfCKB8rR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:54:52.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65a64be-45d2-463d-c76a-08df14803197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Baorui.Liu@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:54:51 -0400
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

virtio_notify() does not reach the Android frontend unless the PCI
device has two interrupt vectors.

Based on a qemu-xen fix by Meng Zhang.
Signed-off-by: Meng Zhang <Meng.Zhang@amd.com>
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 hw/virtio/virtio-cpufreq-pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-cpufreq-pci.c b/hw/virtio/virtio-cpufreq-pci.c
index b7066d962c..5715826af2 100644
--- a/hw/virtio/virtio-cpufreq-pci.c
+++ b/hw/virtio/virtio-cpufreq-pci.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-cpufreq.h"
+#include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -28,6 +29,10 @@ struct VirtIOCPUFreqPCI {
     VirtIOCPUFreq vdev;
 };
 
+static const Property virtio_cpufreq_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+};
+
 static void virtio_cpufreq_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOCPUFreqPCI *vcpufreq = VIRTIO_CPUFREQ_PCI(vpci_dev);
@@ -44,6 +49,7 @@ static void virtio_cpufreq_pci_class_init(ObjectClass *klass, const void *data)
     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, virtio_cpufreq_pci_properties);
     k->realize = virtio_cpufreq_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
-- 
2.34.1


