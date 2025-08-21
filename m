Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EA8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zF-0002aK-QO; Thu, 21 Aug 2025 09:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z6-0002FY-8N; Thu, 21 Aug 2025 09:05:40 -0400
Received: from mail-bn7nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2009::627]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yq-0003Dc-Nq; Thu, 21 Aug 2025 09:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9Wo2nqKuJdJth9P2MMXbUTNaQqvxRvGyZKOndsAyWm6grdxjnWxeN6/lqOw1YEZaZS0qoTHzbAb+gC6zmhH1jfM2ut8zfOzf6f2MG6nDCTe3LDb/TTUJqAKwl5UiObILPryzrDcLp5stmc9Ycw2xRFDiG/gp0RmfelOukA6V26QPTLAdc0kn8iAWVHC7p9gi8SsgeUjoqMHUAgIwKdYM9MIf9nwURYJYAJYWy+lGe2dDEx+nZx+5q3+gX5dTQhiL7z4DumaBH03cYT8l7H3i9zshtHfGpy5NCaWIfpkfYayq0semBWUgKXmyJe1kbB58NiwgZSWx90JT70Joi1RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cynUrNGjFdr9RkTVvm7we0D7Dsvardtd30A8ZMGSg4w=;
 b=O4jZXWsqZcIX3ueSgEqj+LG1VghuNfFlEsM4kqEh9PulcF2wQCZFzZmBG5CXxtK+otjHbheu0EGaecTLtaMqU/U0larWg4WZVocOOEBdWO+WgoXbtc2ryt0/6aIrade7fPHmtIFtnbpEBnY4LXoyYwe+tYQC4KNRKA9uFx44HVQwXAgWBm9qdE6ON3u+mvon/VbZJfvZdI6fJldO3a9osmmy545pHPkMn87N/AyfuaH4jYxfMD05la8mNJh27b7J0K+YH4YiUOtERiSAhhcqQqEYbqjm5YHH4NcE7jnaYOewi5pY8dncuuwyEEac+/VY/PiBqU+DJXGRSxKUxrYrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cynUrNGjFdr9RkTVvm7we0D7Dsvardtd30A8ZMGSg4w=;
 b=Bl8V7bsvQihqS6/V08FGHcNM4D2CSFpgA73eke0Su7D9SCeYLkgvLBfVMdnr1GB/oCh7gHxJhsIubN9YkFsk6J1jiCpKqV5AwY9lfGIlSvGY8vLb3FSIRzax5zYmL1EVNH2K00VZ7xb0OvAIiBCXg++bZuSoIcsm8HgTXAeMvXk=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 13:05:17 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::97) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Thu,
 21 Aug 2025 13:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:05:05 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:03 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 33/47] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Thu, 21 Aug 2025 15:03:32 +0200
Message-ID: <20250821130354.125971-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1e57a0-4354-4605-6265-08dde0b3600f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ds+MR0hnciNcNcVgSICv6CYuGZSr3B7xsZnniTW+7nxz2bKz1w7As3IWUGHQ?=
 =?us-ascii?Q?cNF9KuuiUkMBUDNQWcfg+JQJ3uAHgYyiolL35gLEbgJZ2uRQogCQLomwUxou?=
 =?us-ascii?Q?9mqMGPA7PpyVE28kndWym5UiOvcJd82BVCtnIi2vZSY7oVjCvF/HM8nM6uPm?=
 =?us-ascii?Q?Q6DfHMGaQ/wdb89vHxAlj1sFLAJtGWhcgvoskxGLnr2+LzeSujDtUC0qe6jS?=
 =?us-ascii?Q?edYz67x+NLkD7XM2+pxLJ13pMd3Zldo01nj8b5H+GfK7j147QbWuuYZS7lUw?=
 =?us-ascii?Q?6a22kLjXEaU4lzWVJ0Z+qu9KPfwwRHhV3g+OqqXeuUc1xmJ8u1BeG+HO5rZj?=
 =?us-ascii?Q?KOKWggMnIeP19naIMoNfkrMZ6KYeWUvG3eJM7Lk+QRcNmAXmzV2fAdRLTgSs?=
 =?us-ascii?Q?iyPAh5UiEPSMUltR9AtLPiCslEL+F4ZTo+OVjYYAR7xhXW7mC5gLjLgJyEy/?=
 =?us-ascii?Q?piJjjZ14NVI+PUkWSa/lY28RQfG4uDYproHExrFqYbHOqHaFU6WvLCfnnE3B?=
 =?us-ascii?Q?Vq8fHgr+IhhiNTwd38/4tbdy2MW76ZYU6jMYDS3OZvL44ak7+SSMUc0dl5gD?=
 =?us-ascii?Q?Quagco7gwfYJPVNA+Il6XXjzNaINf63sga7QtMcr+APc1L7m4mGMYR2MrOwb?=
 =?us-ascii?Q?VPayDaMTFEPhU7v/qRZy65dqDrnTtei5t5EzCfvLG97SLMNUi/ubcp3UxhzA?=
 =?us-ascii?Q?LRGr/K9dpcoCaCHELub4e99lJNWSSeC88sLz9MvmZzSjmSMdpVdO895S7Z0+?=
 =?us-ascii?Q?QuMOAD48oy1PrZsaIeWqBCK4h+uhzeNPyPI0xRccuIvYvwCRtH6cYkDUJup7?=
 =?us-ascii?Q?WXmRX5oPATOHKxA0OXLCY7WYh4ZI9sjvO9S1SNJkGOlVkzoTkxwb3o93WR3e?=
 =?us-ascii?Q?Ii26m/nACtDUmtID+pk5h/4kj2r83g09MO/mw/FCyM00CyWR2Iya5ZSAcH/Q?=
 =?us-ascii?Q?zE/UvnqMKFMCn6+SBkUE8FdnWAQaKg2REyCJryJCDkJGGN/HteQd3BJtj706?=
 =?us-ascii?Q?UvO1mt3DAGn0UhaBJdItQvx/nFiDDiF7J2bovctyHGtyDL87qEJU4OBEdfsX?=
 =?us-ascii?Q?rE8BoQB36Un+e85Kz1aCJ3qlnBem2H/z2ImKaQ2TJ+r6irMDZp5A0OjiaXa2?=
 =?us-ascii?Q?CkF/dUE9qb7ahvuo8BwdJDikQI53xUUi238o/fU69uZ2Ph5EC/PyKj8MiMP7?=
 =?us-ascii?Q?cAGuytQ6CpbTFszpKKv4IiIQmJOz22+QXutcJ9tXFfBvWZ5z3bRLIlMRew72?=
 =?us-ascii?Q?lx28815ujJ7AYW00Y+iBayR5Z2kDIuZaQyevY90RHl8k7aOmh2yMrze5tvze?=
 =?us-ascii?Q?ODjdQif+TaHgSzkeQ6zVtErfh0HfWc0OUdwP3jmryauFnuHWPA8o9ae0QENb?=
 =?us-ascii?Q?cuyhpJneggdCglzj9pW58mECSOkhEOAiPZiFemeaM4FBPqYNGawt+JkxWjNP?=
 =?us-ascii?Q?IqqeSgaLPSTCDeKwi9bRnfhXRIB2DtzNySPxYoIgjHtbe0l/yF9k+osdKxdS?=
 =?us-ascii?Q?qSGaesF9Q360wjBFmS0YBUKN6Nrt6FvV6CZK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:17.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e57a0-4354-4605-6265-08dde0b3600f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
Received-SPF: permerror client-ip=2a01:111:f403:2009::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
index 0df2e9a3f6b..63c4e6eea6e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1468,21 +1468,50 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
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


