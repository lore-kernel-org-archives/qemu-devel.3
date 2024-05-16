Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84407C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 10:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Y7o-0000U1-KO; Thu, 16 May 2024 06:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s7Y7k-0000TL-Qz
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:14:10 -0400
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1s7Y7i-0000UZ-Lw
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:14:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRQp0yuCNR3BeI3WPxoz2WCg/EKLyFAoYbtLLSFUJ2s/BJtutN5R+j4f1UWcENaUVjn1ZW2mM9IvbA3LSy6bRVbJJGpcNfgIbREcFLawVolHNEzLawinhrPJt2XOjamJ6bhREGUzgcPk6CKW31ArayB9KGAf4CnDDxVLGHm6GJxM82oVFVR8MXjo0jyYkEP9tsGiydBT1ZqOgAHNSPilsxBLWfYPL6p4y/Zl2nVLvdTMVfKAoimwdj4mdIQ3QubFml005uuIE6dxTVW+NXR1plgpAbRZwWI6EY+Ic1iHO6YHnbT+fqwcbVlhPf5fcJDOeRENcIkjoQXwV3HD/y+auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEMEB3wKzvfQ/AFFTBXplx0jxAU0bH2rBrLniIkwOOA=;
 b=AIsbOFUg3VneErNZ05xdoHsABdN+L8GRRfsQe5v82N2HPuvFpC4NLtHGqFQcyhkkfOnroM8XjZVCUeiuJ1wVHGhEFH1Ou/4k8Z68C7ScDJR8EJoCYRyvEVAxrfv8oeLTMVL8QG9FNWe2nnGcG48iUkDrBA2BxBgGPEq83CSbwibPvMeudfBn8cR8eR451XCZS5Rh6hVYheEobKDfIi+6pZDCh5WDYEv2yMOS7MXkvIzf1mEZbw1gUVbFJMfc9pQfX9mnOkBl+um97cXnhEdFGSziMCqKT7ActEVeN8B7vqdZwdNk2vjKn3mrFQdIuvAVxNPzaju7n4jJaNgBJnGAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEMEB3wKzvfQ/AFFTBXplx0jxAU0bH2rBrLniIkwOOA=;
 b=sEw+PTHaaM1FtBHH001p/x2iUaszlu+tQhNb6KBsCdMz4x6FwbyEjX31cb8FCwrAh0CVhV1MtPcAX3SKlkyjLW7hHv4cvZhpdbNzt4Ig6u0dFp+ZlXlq5y3j7bO3CP+oTYM4c7dCLmGQm/d569ciloFROf8fjQLR6lM6Cv04OvM=
Received: from MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 10:14:01 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::b5) by MN2PR20CA0059.outlook.office365.com
 (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 10:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 10:14:01 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 05:13:58 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
CC: <xen-devel@lists.xenproject.org>, Huang Rui <Ray.Huang@amd.com>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC QEMU PATCH v7 1/1] xen/pci: get gsi for passthrough devices
Date: Thu, 16 May 2024 18:13:38 +0800
Message-ID: <20240516101338.86763-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516101338.86763-1-Jiqian.Chen@amd.com>
References: <20240516101338.86763-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0a7b4e-0268-48e6-06a1-08dc7590e839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/XYQwvs2o10Nbm2rItE1LMjJME7VAqbb2XvB90/DZn8G4TZczpFce9FeK10M?=
 =?us-ascii?Q?kmkR9aEpwbyTGkXWaU0VEZA64z5ffjuGzbEgXHsDUGR8rMY2x6yDqQ7f+gbf?=
 =?us-ascii?Q?X4zaTpJGA6sjKmlXGMlxyD0Jhwvmszd6ar5DD0BE3moGCkvLEkOiNmTgWv4t?=
 =?us-ascii?Q?+NgYJhizyKjrSAbNgjiUytGMWrvGbXNykzHVMA88bfuDyIQPit+bRMmdQOTF?=
 =?us-ascii?Q?+bUyVVRMT6X6Oj4wNHOMwqD36dsa0tHVeDYmHj+zUV5haVHgF436cyxrTKW5?=
 =?us-ascii?Q?aQtpGyna6m/maF61EGcJzsc+xSmjxpVOq91NdteZ7MaegiSguqP6iM1+34Ca?=
 =?us-ascii?Q?qt8oisbCRxH0hc3fx4tnbG1BZ82BuFDMIHwSOAUr2RhTtuzXUgh/0IxpPaxd?=
 =?us-ascii?Q?i8c75Xg0xyZZupFPYWGtuUD9ujeHzCY5eyqeAgekAyHH5lgyvPV5ahIeTR9J?=
 =?us-ascii?Q?9A9kVGwHgnD4++AKTH3gn1J4i4JTOeJIuDntzWT1OHemZIRhK0pekPYZ2Wlp?=
 =?us-ascii?Q?E+/ivoBZ28YJZCl32fZ1D4BrzXtgKeHWTiAuAqqfatfu31PahxXqX9Zaa3hI?=
 =?us-ascii?Q?+IdV1A0NBpF48dQbvFxt3+v2dqcQy5OGSyJvbci0uduOcMEEYMnBDR/hOPu6?=
 =?us-ascii?Q?8G4spXOFroYqXr9UtvJiMsyKNKzkxv8wJQjw5Ao3AdBm6qgul5zNXsMGJ1Qy?=
 =?us-ascii?Q?8T6atpv/R0MR2cYiH8m5QKs32w504fUzqQI7TvYrPxSQ7mBsn9cUq1oRjIUy?=
 =?us-ascii?Q?tgr9OR7Y9xCPy5xkRhYZTgF0vAOpENalBNRhGAI7claXlinztjq6lvaogU7b?=
 =?us-ascii?Q?G2Ci+ypx7ZhbV5HhFKhqyTHjtmTxUUfhd3uJBWjSaViba5sy7dWyUsSUkcfZ?=
 =?us-ascii?Q?qo7DHdciaaKLaH1g+jHdLQlkkzKPS/pWeWs/Q3Qnt4TtFKhpKyVPwasObyeE?=
 =?us-ascii?Q?gxnvRu5NkMR4b9kCL1k10t7K+nH7HUCMLNJqqSrADCkqDwPZXIkyXqnsiy7g?=
 =?us-ascii?Q?ayDpnANqO7jFF5CtLRsesXL9BcJdDKTBxFnI5CAOH+/crIbW0n/k44X2uzkL?=
 =?us-ascii?Q?TCHEF9fskR1YagobmdThhpxgoDZL5dS440UdlZcRmXJXjw9234bFMxbP1P2R?=
 =?us-ascii?Q?LoBulWnZnn/6ZNitJT/PqlfJYeeK5OmMOE5z6vNclxvisg5mQGwCoBbyFH6t?=
 =?us-ascii?Q?5h1TKNa/EoaHJLqVHP1KmpdzdK/YurhLPiObAwtP574RWqiDP7zoUkLSiG0B?=
 =?us-ascii?Q?eC635rdf9mqfd1U8aG7eKT4Ggnpn8LdqsbJid1TxkFypJSukNdhhNRg4qJRt?=
 =?us-ascii?Q?cwarUGEBkNRwAVE0dxpGlWH/1uodUFAocGruFumN344IVueVGhugnO7bmqzT?=
 =?us-ascii?Q?3KfchVY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 10:14:01.1090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0a7b4e-0268-48e6-06a1-08dc7590e839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
Received-SPF: permerror client-ip=2a01:111:f403:2009::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

Get gsi by using new function supported by Xen tools.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 hw/xen/xen-host-pci-device.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716a2..2fe6a60434ba 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -10,6 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "xen-host-pci-device.h"
+#include "hw/xen/xen_native.h"
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
     ((PCIE_CONFIG_SPACE_SIZE - PCI_CONFIG_SPACE_SIZE) / (PCI_CAP_SIZEOF + 4))
@@ -329,12 +330,17 @@ int xen_host_pci_find_ext_cap_offset(XenHostPCIDevice *d, uint32_t cap)
     return -1;
 }
 
+#define PCI_SBDF(seg, bus, dev, func) \
+            ((((uint32_t)(seg)) << 16) | \
+            (PCI_BUILD_BDF(bus, PCI_DEVFN(dev, func))))
+
 void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
                              uint8_t bus, uint8_t dev, uint8_t func,
                              Error **errp)
 {
     ERRP_GUARD();
     unsigned int v;
+    uint32_t sdbf;
 
     d->config_fd = -1;
     d->domain = domain;
@@ -364,11 +370,16 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     }
     d->device_id = v;
 
-    xen_host_pci_get_dec_value(d, "irq", &v, errp);
-    if (*errp) {
-        goto error;
+    sdbf = PCI_SBDF(domain, bus, dev, func);
+    d->irq = xc_physdev_gsi_from_dev(xen_xc, sdbf);
+    /* fail to get gsi, fallback to irq */
+    if (d->irq == -1) {
+        xen_host_pci_get_dec_value(d, "irq", &v, errp);
+        if (*errp) {
+            goto error;
+        }
+        d->irq = v;
     }
-    d->irq = v;
 
     xen_host_pci_get_hex_value(d, "class", &v, errp);
     if (*errp) {
-- 
2.34.1


