Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE72C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxfdp-0001uW-I3; Fri, 19 Apr 2024 00:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rxfdk-0001u0-44
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:14:20 -0400
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2407::600]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rxfdh-0000F9-5p
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:14:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=essMYa36UEEL2s0TK5CvDEm1HOTaNT7ZhnKAQHbXgkmE+M6KMaOjUb0GbPwbvPEnYkW9CwOAUkW87MbA4nZfnMjyo4tK/o92pgw7elbDcnHXy1wlfnQBu2CduY1WX0ItU8rkMLHym+Pq4j1pw4N3x/PQsWU8/FBUMihpVRPY3QrPNa2Eq6WoK1kazVtiASJXS13eegNXcEgX01qis6iS7rS6vmKl8OQtC3Kvz7Uq8gYXkVVKrmCIarvBKrjfBMhe4BmVCccn2Z2wFKaXInUMuDS7oOQfygoIggsO/YSR4duIU/NPn75kJn3v9vm0kt3UCeA5/ha1RWEC+Z3bn7zcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Iegew8C87PUBULbDOFADEVQbH+6F4VJbkJFD0Bu2N0=;
 b=g1Uo5KDfDTjDEX43xmAZ2MiuMnR11WaFZYTjKEyylvYvpfDHvTkNQpuZmKkQwA4ib9ZFgOUEOwhx8ypy/Yg7npIzvA3zxySRU65aq1YlZUeS/dACy8MqJpkRpIMqtPjftn69GfDAdMLbT2JizXJZa8Xn08N5A8AT6A7Q+HCiAzCObMMwtl1P+QRZr+MPXif4VMbSQHA/mDtPBTOY4VLjd+gT+LuKcNUG9js3THuKfARuRzbqHHrxd8kGy6JAvAaeW2wIauvK0ItW7aZzNDKvcMBs7d/jVKOZrcnReDNJvkGCrabp0jl0Mk1E9/MrTDJE48DTyL0cKM1djASPsAa3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Iegew8C87PUBULbDOFADEVQbH+6F4VJbkJFD0Bu2N0=;
 b=Ybq8HvDbmkVcQnETVSdEgXLXNUVwm+CDxPc25D9oaFmErlWKrVtrfYsMTXypdxC6FtWiFDsZOXXhd+jaxyfYH7fHU0oVhQ8jrdu3AZgS6n7zhlTANXq/TR6AbDKq0ur2MapDSkIChzvmrQIUOGBSWxzwdJFgWfw7J+eA1xYNQb8=
Received: from CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 04:14:10 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::1d) by CH0PR03CA0027.outlook.office365.com
 (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Fri, 19 Apr 2024 04:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 04:14:09 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 23:14:07 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC QEMU PATCH v6 1/1] xen/pci: get gsi from irq for passthrough
 devices
Date: Fri, 19 Apr 2024 12:13:51 +0800
Message-ID: <20240419041351.633856-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419041351.633856-1-Jiqian.Chen@amd.com>
References: <20240419041351.633856-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b3a9bf-66db-4283-c73d-08dc602729c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqfHkXKKKT+80xUZIy3be65NiO2nEviZHRqTJ3b2IToOeCcVyZo+ptNebVLJSDERdJSH6Dw2ipmSX3PNW7oRaICaMSDxBh8XQwORrFM9ickW3QHHc9Bkhum5fP8yp5hCGM7wtC6kOsq1SCdg4pbnToAUgE2Ia3HmOTsXvByd9RelpgEl0yim/pcA2zMzHvjE5xrCAHC6zh9FOUUINYv4rh4BPVCCI2BGqtmSHVcNUD8dSsXj8UYqNSS2lwDsFTrerNeZftio5nx1/r/SQUt3BFDM85O52IjZkDvcsR9EZRizq9NaBT5LSA9sylPjHQUUsny9w6xuBEvD4akHPO4Q/0zLtELDBJDMekUJviHYI/ZbYkb199YLTlfkEGYZ8QKhA6hY6NLGzVBYD/B/twkUc5LdrdjkfauCSE1B0JwiI8mZBxmnTwrt6Yz3Idq+U6IM1Yw5mLVc+gWmMvqBC74EPjaDh0aTCCGhwJfJtftmCrOJZHQgGYslvtaq2tswyvZWkEPZKdhpszQsQ2DwLTI8P5+dwH2+F9dV6QvbxN2UhFxmig+ANr1d5OxV0BhfLeTQJVMNGELTX4kME+yDdl+XuCTpAfTaDX+D3f9l+rc31sVIpWeOggRKOTKD6E6+HeB2kABs07fHhilahGNZG5KtgbAGBgTOwIModqkZtz5RIxZj2kjj6C0Pbc/hc9XYm78FJ1Dhv8VuxZInv920747rQaiTHOydIoyhgUCaLnXewaGGbx3z60+qIADXBICalJto
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 04:14:09.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b3a9bf-66db-4283-c73d-08dc602729c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
Received-SPF: permerror client-ip=2a01:111:f403:2407::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
the irq number is alloced from small to large, but the
applying gsi number is not, may gsi 38 comes before gsi
28, that causes the irq number is not equal with the gsi
number. And when passthrough a device, qemu wants to use
gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
the gsi number is got from file
/sys/bus/pci/devices/<sbdf>/irq in current code, so it
will fail when mapping.

Translate irq to gsi by using new function supported by
Xen tools.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/xen/xen-host-pci-device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716a2..5e9aa9679e3e 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -10,6 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "xen-host-pci-device.h"
+#include "hw/xen/xen_native.h"
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
     ((PCIE_CONFIG_SPACE_SIZE - PCI_CONFIG_SPACE_SIZE) / (PCI_CAP_SIZEOF + 4))
@@ -368,7 +369,11 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     if (*errp) {
         goto error;
     }
-    d->irq = v;
+    d->irq = xc_physdev_gsi_from_irq(xen_xc, v);
+    /* if fail to get gsi, fallback to irq */
+    if (d->irq == -1) {
+        d->irq = v;
+    }
 
     xen_host_pci_get_hex_value(d, "class", &v, errp);
     if (*errp) {
-- 
2.34.1


