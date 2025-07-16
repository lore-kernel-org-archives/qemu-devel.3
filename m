Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B42C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytg-0008Qo-RK; Wed, 16 Jul 2025 05:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys8-00028A-WD; Wed, 16 Jul 2025 05:56:23 -0400
Received: from mail-bn8nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::62c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys5-0006jN-0w; Wed, 16 Jul 2025 05:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz3TBMnvpmhz+v8wSrXP1EgE2mHjeZABbwT4+LxvO5s/VYwWVAr49zy2TYk7SD4jVw/JMKkHhJ1suMyMw7YHlyxr05ONd3HOSwSRCXDZrc9nXYckLVAsn4pCojaNfBroeEdYywaYmAOmNhRmCV4P9aP4UyopmzcLY+b3c7q5aEvbuOaE/LYK6p4hJLnRGvr5/6/fylOjd/h4wldUVXeVezDsb9EX84hMByoouYo54Tl8LcV3wWbmqXjaFXMvIkCoLVg/lPRwc6sJWcg0JtGcd6zyJbdw4Qf1yWjOu2MDHp5Ak+WsGfpWru4Mxcp7oDrwEon6Z7csBCxgRR+kQ/D7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um4ktq2cGoLAQG44xWw3xgk6GkJzJIyvFqdlD1s1vmM=;
 b=eL8eVInHqrtL13kSs/dn/0mNqV3dWswmjokFM8ZjPjlh9UtxqzMsE8vOE32vh6YOstBmwfp+6KD5BCSIqN0X2irlPplK89k+hWUystf7SoqHCuHn02xUb7c17EkBKMEgt7d06VqQBJ7ydPiIctRlBWxbK/2XUVnTSJ/dmrNvjz8/PRe7iyrJEb9BQwk6/Zr8XtZMJ/t9b1QMOC0HMRdPkhGrxxd2O4zQCbFiB3qsWSQ8O5QY/uJSoMyFnhyzfzfTAd6wDPW5AEeeRMh9BnPrUeO38BvdWle/T6hzRD/iYj6ZbNV6+ucFoi6nYGka82e6qmvfTDmVcAWpat7/xAIL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um4ktq2cGoLAQG44xWw3xgk6GkJzJIyvFqdlD1s1vmM=;
 b=bm8nx6QzCxkcAwH/5Nxqbcq9svtIv/te/aLLmwu1U5++LqCartukFplh6nU0m/27wbA5s9z0YOmGMo6ktoVkk0ektv/yURRlFaRh6PPDcGFompVR/Yn5CdUL4onNqsbVQmOVMpMzGvYiJ4131LF3djdm7/ZXvFs4qjF3Epxr/ok=
Received: from CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::25)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:56:10 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::f7) by CH3P220CA0027.outlook.office365.com
 (2603:10b6:610:1e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:07 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:05 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 34/48] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Wed, 16 Jul 2025 11:54:16 +0200
Message-ID: <20250716095432.81923-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0478df10-1fca-4295-ee97-08ddc44efdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P91qxpc//xYhW7iUh2bEC68aqZfkgldQMpdGgI/RFPQqu1i/TzBdIkXVMiUP?=
 =?us-ascii?Q?V2s4znLkdcXMcdFzc44jpQEzPYevtpQCEsyQ+WPd1Tajw1pA7pp7PS/WThl2?=
 =?us-ascii?Q?gsDQNRyaKSuRBYmEeDD4s3jX6/lHI5W6B+rhp0jU0aZtXQCO+QZ94CkgNvsL?=
 =?us-ascii?Q?hGsj3xSAcz+MDWYtKOm7bpsrQqrgwADNUci6pTt1Ry7HZ/9FCuMfxG/6aUWx?=
 =?us-ascii?Q?7FU7rvTH8FMORKBZs7pYvGDIHk8nDry8q/Edu2am88AiXpd58SQqw/CUOPH/?=
 =?us-ascii?Q?Ff9MjL5J7fFD84wi2ksXGXhE4gc7FKKkS6ao+5gslajrd/JknAFrKzve82BJ?=
 =?us-ascii?Q?ADgj9xwYxrVmMD8v1l97FHN7ZmFxdWMejdrpVLPxAMb+MQxae5AI4GlHcyKB?=
 =?us-ascii?Q?V2kP4/6gSA1lSa/jsvql7vaG0IKfsA49SQ2xc4FNLk0K5Z20raXR0fLe5GQf?=
 =?us-ascii?Q?JG6wsQvGNLfBR0jbp3BisTJqAotlGh3NSDLTsGrQO6kTrEpAl7D9BSt2N1MK?=
 =?us-ascii?Q?vQ3EYx21UYzPYVjyGpixcXm6crx2gLvSVgzM7b1dad0Szo4TPZeymwTjL5gT?=
 =?us-ascii?Q?6H8ShTjKj5qwp75XRmY9OSmpLOMLA5QfD0CejKrtlV9w4AsVSxBRa5+lFC82?=
 =?us-ascii?Q?agU6AArcnWjxCMQPeDviC0MhaeAgZ/ckTI4yLI2JjiyKH9buPHIl/gCm1wPJ?=
 =?us-ascii?Q?0chJZ7X0WsbCOpQucRlKHyBS+9cPKGHVG2pgSGDNIjUlCBp+QwNJWG7lNEaQ?=
 =?us-ascii?Q?YJXBtjG4cjBIaxnXqbWH2TA02qfZvf6Ezf8NdhhDa4PFkZlxRQqUkhWL70Ma?=
 =?us-ascii?Q?lIay+4SpaQocFXC27rnO2m/ZVYvDxMPfCRdKunXiP+2ZXOQQXOQ2/XedAR2x?=
 =?us-ascii?Q?y569g4FGhyAWoNpwnHL/p8+5GaRQlLhD3/TtYQEuPlKvlaDdj3QxCeoTgAkX?=
 =?us-ascii?Q?+ZIgqR8S+98ls3I/5O6GjFKM0QDv+RYe9ixZUEQJVrDO7YuMt4miSWUt/ZhT?=
 =?us-ascii?Q?phRzO1dLu95pqW/RQfBPvFLQdjTcs3s1timZjxGk8Tl0Evb5nEViydndkRDt?=
 =?us-ascii?Q?xN3cqsXCOt6xFFuRDCk1ulBRTGNrsNsu1NBC2IFqiHeu2WK+O4M740Rg1uOQ?=
 =?us-ascii?Q?ysTSLnJfSzhQibzoTZrvInp3t71CKHQnwYumf6PUM0zX1vhHtdNWd1qH0Mp5?=
 =?us-ascii?Q?RL6i/FN3MgBoMrrYQx8R6FLBQcs6R8bUPccMnrQ2+ZyxadvD8G1G6OdaKUap?=
 =?us-ascii?Q?d3MmNeWmgCb7lHBJGAbGbjqQ6pdvt6HwNRemYStrVDHNvMcLIPYCPiGtNXG3?=
 =?us-ascii?Q?UEk1RVUjOrNGL1fNflFVtFf20avmxckWKy7u7b/WqXvHvmOTYScp520hAU24?=
 =?us-ascii?Q?j4wkSYkZXKm/0B3y82522H0IwkE6o2wcK4F2H1kOU6YGXFs7yjuEQIMSdiR8?=
 =?us-ascii?Q?DJzNPdOl76AohaqH2WP7GVaIFuwgGBL1WwIsiMPiWBwRs+Ah/lkNQpR40LVg?=
 =?us-ascii?Q?EqqakcAukFcqEl0pR95wuHkJd9cBvKFdUdal?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:10.0598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478df10-1fca-4295-ee97-08ddc44efdd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Received-SPF: permerror client-ip=2a01:111:f403:2414::62c;
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
---
 hw/arm/xlnx-versal.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5151822ad56..796b4911a02 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1473,21 +1473,50 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
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
2.50.0


