Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47413CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXX-0001GN-EW; Fri, 22 Aug 2025 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWm-0008Hc-M2; Fri, 22 Aug 2025 11:18:05 -0400
Received: from mail-bn8nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWP-0007EW-G1; Fri, 22 Aug 2025 11:17:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiEpiuADPke+DHfcixOquET6NjDlJFwxyuRtGM1CDkezek7s3e0ZRGG9LXHo/XUklNYFezTlll8jEz+n5mF9Y2Z71jxkTQvtXJ1BuRKJkYlk1vhfmJ6TvHQgzLhPMrgQVDlLb6Sbz0eqv7joW5XtQ/DpFP1jcBTHI8fO4iIc/Z5oDr4kc9HIuAltXF66XeWmedhTuL7hswV7a/3YF60YofKSRxe4A3tqaAq6q+TKvZxodW50hSfoDU2AEB+VBow4r8okjF61X3FQnu+m0Av+LnaGDKI1Js5bySWnWLUkQbS5ipgu6+CpSVyhI/WehoB7TcKp1d9i6ED9i4z/hbPnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHgBdcCSLnMe4vfRjFcAmaNpAatEzqPKVk1GjwUUoqs=;
 b=YyBEngisO0kbuB8UfhY1GRcd2H0bXyRV0IsExZAPI/LPg/RJqHPE08ETJWiUIleQfR1Ev5u4700MKtoid+YWAqWnBnY7bxD264U/PK1NXO7NEKeyiG99Py14IrKIFo19YAtaIAJeZ8gkXzUVZ3njSD4m2toRsoQMjNWp72hHtqyamsggM3IRxuJVhpaIHYHCOuzfu1JZU7UA3lkklZCUl+ls+mXIKmTooPZeWq2AvaVTB32MghPRVklwAiO4zHhHJ2O4CDl4RoSG6cAscrwehOIK2cjnMWjzvCx2qZLd5d08eA+zAnQgDifxM+UjSWNQuyxduky6Aob5Rd076gjzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHgBdcCSLnMe4vfRjFcAmaNpAatEzqPKVk1GjwUUoqs=;
 b=JmJWWbY5wp5Fg57OpCPKLpZ+HlKrLllNeaA7xIZBrnC9Fje9VE4CPfM2oqEoKs1oQ7V4wplucVFrmFLA0I+ifc36xW7IujXW72ON9iFs9/upuFW8Av7pX1VDwmNYuszqfbf4H3pWHnjP6QqMbgindEUI/j63/n27y8v+9CpPq2E=
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:32 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::b6) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:30 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:29 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 33/47] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Fri, 22 Aug 2025 17:15:58 +0200
Message-ID: <20250822151614.187856-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 945bea25-52c0-4457-f911-08dde18f03fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3wab/hKI4BJojjW+XTJOYfzzAba7LNwrMAptGRbutd1yScpy+HfDCN8nF6jx?=
 =?us-ascii?Q?iWj/LzK8wpGsJBzSmUQqJcuBWLOTy+4xMjmL3H9AIxRuv3xyO5Qz5BaKlO7B?=
 =?us-ascii?Q?i6mRSJY8d24ariyQz4Rtvdfq+gxQ2yRdsnTgrp0K1xEjCy3AwhLtLlG6gOo2?=
 =?us-ascii?Q?FNIvZATqjTNepczGo8wzlOx+Whk/7ai29jKZnb/1Rtl/V6PmiGe2J7h6Mbzk?=
 =?us-ascii?Q?xnn4m60OjfX3zLVxAxoCRU1jsRhx5ErHCl6GE5AXnBnhW8B+0BKQKFUTXwwq?=
 =?us-ascii?Q?AjJVSZMZsYZkF9zEbNN8nROsuJ0tKznCstz0advzhy84Z9xU2+KEMQY1+6pw?=
 =?us-ascii?Q?48g5ELTS3Frf0qKzl1+y6keF9CIrFU3QDCpP4wQ4bbqyFYlwTzE3W2eT5/I9?=
 =?us-ascii?Q?lO/B5sQlE1sQKZ5mWvmGyRrL2r7YW/SaM8x2vXe5gigBubdoGrrhH/9sqwSW?=
 =?us-ascii?Q?kHOZpFuuRgm11lWKXPdiE+YBxUJmT7/YTnF3jtURygGOMvSzL7mN1VStZ5s7?=
 =?us-ascii?Q?hKbfbXCjDIBM1S8ZZMis1DDvkBRnkgFlLUyDca36sEGEkeFsmjYEL3ahzWR7?=
 =?us-ascii?Q?R3cETo46VcBuIjMs0yzAI8z2/l+ZtZ2xOeltRhsgtRnYWhV02rgy2qkyDy+S?=
 =?us-ascii?Q?sBmFEfgqmYxeEE4K6KUvmd0LSzv/kuJqCgCUBAtxHB7U6ciJpScR9V8Jcz0e?=
 =?us-ascii?Q?DgOahZbqwLsWTuk8uStDNo6mrc2p2ocPrxN0twzUtcr2CJsirPRz7uyXllrb?=
 =?us-ascii?Q?xhkfC5cLRgfnPC0A/L2pOI1u1NE9xsYkQ/pSeaLb24wuZ0P2z+f07owMiHXA?=
 =?us-ascii?Q?Gm2S9UJqS2lsx6Z+W8M+u2DFh+NSRN0tHEz4+VuW3EdpNNEo1KlDM6/bUk+B?=
 =?us-ascii?Q?PxDRn+Yy/SppEdvkocx6/rnExq9QKqnpOlC5n0xtwzERhZHgA058vSr4ETrD?=
 =?us-ascii?Q?fjjrvANgznp4n2rMzRNKrWEXMq89+LTpHsLWsBfg0iHCpzgkDkmHQgwjRObT?=
 =?us-ascii?Q?nvVu2hLbn3C9Dz/ERg0h1sato5IFNGuOj8grIi92c35t5tnEnq7rr3QZ6NvV?=
 =?us-ascii?Q?BFLw0hyeEkrOBY8dI1ZrlZVPOwWxqSzINF7yNcHHGr3u5nOlmWlyNfSWACCQ?=
 =?us-ascii?Q?Jyh2ttewjb1v1y20AoWiZq80QtPySY9tlXiBhxhMqRUw5BRiDF0ZSkAR3yrm?=
 =?us-ascii?Q?Ysw+PIyBlRnoY1BtRVcUGEjf8hiH0Om1mIGrIqBY/Uvszq2jhMc26wlAldWk?=
 =?us-ascii?Q?Lqmav907TuaSGQ78IfBHN3ogGItQuZk6kURUPhJXasvfGCtMSQkdPLcpIpU2?=
 =?us-ascii?Q?we1OGPs7qWhjc8p8OK8ve0krXpUW/1BY94bdHjlwLFa/t9R6mNQWepX+RFTv?=
 =?us-ascii?Q?9MxxVePF/2AyQp9o9z60VYwXW4IC0+aWiJrtug4JAqnWKKRPFfa8aN3a1Cno?=
 =?us-ascii?Q?tkfBoNlJ85sTV8gAwlzAoGuOf+gB0q/LdWf6FHvy0DUU2tueaudHMMU6SnU6?=
 =?us-ascii?Q?zq3kZ2XjuG8ePb5iYl30WdniOV86WhoHj9ZC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:31.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945bea25-52c0-4457-f911-08dde18f03fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
Received-SPF: permerror client-ip=2a01:111:f403:2414::61b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

The CRL connects to various devices through link properties to be able
to reset them. The connections were dropped during the SoC refactoring.
Reintroduce them now.

Rely on the QOM tree to retrieve the devices to connect. The component
parts of the device names are chosen to match the properties on the CRL.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 181f35d607f..1462c2ffc84 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1474,21 +1474,50 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
     sysbus_realize_and_unref(sbd, &error_fatal);
     memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
+static inline void crl_connect_dev(Object *crl, Object *dev)
+{
+    const char *prop = object_get_canonical_path_component(dev);
+
+    /* The component part of the device path matches the CRL property name */
+    object_property_set_link(crl, prop, dev, &error_abort);
+}
+
+static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
+                                           const char *name, size_t num)
+{
+    size_t i;
+
+    for (i = 0; i < num; i++) {
+        Object *dev = versal_get_child_idx(s, name, i);
+
+        crl_connect_dev(crl, dev);
+    }
+}
+
 static inline void versal_create_crl(Versal *s)
 {
     const VersalMap *map;
     const char *crl_class;
     DeviceState *dev;
+    Object *obj;
 
     map = versal_get_map(s);
 
     crl_class = TYPE_XLNX_VERSAL_CRL;
     dev = qdev_new(crl_class);
-    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
+    obj = OBJECT(dev);
+    object_property_add_child(OBJECT(s), "crl", obj);
+
+    crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
+                            map->rpu.num_cluster * map->rpu.num_core);
+    crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
+    crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
+    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
+    crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
     memory_region_add_subregion(&s->mr_ps, map->crl.addr,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
-- 
2.50.1


