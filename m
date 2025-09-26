Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C6FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22bI-0007yy-OW; Fri, 26 Sep 2025 03:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aT-0006l9-PJ; Fri, 26 Sep 2025 03:09:50 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22aF-0006gs-Gi; Fri, 26 Sep 2025 03:09:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i066dFY2GBLhnT43JQTT9vy2P4WbXGJwTDr25JqUFs+2qaHwYn5W7hP2Aro1V2VrH1CtR1SkzdC6GXDWpZlDjICDxoTDVSNACgFRvnx0AymulVGkx0h6xpzLvMozZHjbZguJrm6J2GUqfeP9oxKRgSXQHKeuguGF2Sm2fCLyXRbvnzQJ1V714VtoB6qn4IVr4fWn3citf/OQHgtBBhQieE18GKOVitYA/bWJvotKqX0pOY6fvUYWHTACSi0j8ldqYh0HrfzNJxZzkSU+m6gB5OekXY0XMj5fMAqVqHzkmjk0DtDv6shRvDTNVXX5bo+ySbiiQC5ppmfRBcjDu8Uqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlJDcseIU8su1ldR01v/SuSzsm9Bl46VEStISTBwrjU=;
 b=nMI2geo9P2dBrTGjG2jmbFSNfiq66ymqiRoD9MfgLjOTkHENXm8JiSnYw4gZAyX78Scsn28y0C0MfMyw7BqQUR4KWZNEyqvNpIpmNCGN9J2QwCw9kCHQWtUOp6orT71JFAp67dUS7G2f7kZz2sbDPzTlc7spKYvJmAtqluGZC5dMXoy0fli7CCwA40b0eheYVSSSDadsm4CcpwFEPkhI4iv6UAnPaCHkmofPBjWIGS686nLyLfvENzX9XPY/uXfpbB+MtxyJM8TlsK7jQtZjgDU7ZY3rYn3VSQf+QOAImnIUjx+b6ejtDFGja8WdgCreCHs60kw8py6BbhYpsm3C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlJDcseIU8su1ldR01v/SuSzsm9Bl46VEStISTBwrjU=;
 b=iqliTGGN0iJQtHeI0tZGFWcWFcK5Z3Rbsjh57/Tszkwe0/iojaSO+luv6zUxgXFdtgVNra8gUMBFVEUQz8Z7YMaGlDqriH7hCJ5D88VmbTYVVPAjNPpITCzXwcSVbFJcJWCHPEEau5Zed8La4xtTh7yVV9wR2BcyokodTda+tko=
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 26 Sep
 2025 07:09:25 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::de) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.6 via Frontend Transport; Fri,
 26 Sep 2025 07:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:12 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:11 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:10 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 33/47] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Fri, 26 Sep 2025 09:07:51 +0200
Message-ID: <20250926070806.292065-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: d6100c29-98de-4150-332e-08ddfccb9fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJZbVVnja8h8Z3VVhwrzXjEt8VdxGpNVRPKkD66OvgQJRRiVQftc8JxzuzNJ?=
 =?us-ascii?Q?bf5Cr7MS/+9zEfM5IOaQmPJqh5N3gy/ZP85CS79OgJBIq8M1n1q61T3fOyl5?=
 =?us-ascii?Q?dGeVJNbUqy3k/qq9SJ7P9Ycra96FWu+EHNt/YhQ7Y++NuCdNZC80FvyFAXwU?=
 =?us-ascii?Q?JZqTrVxhL/SyW3ohAaYKzn/B4s9Zf7PdSFJtxrA2zjcjtefKwblIJNzMRhlX?=
 =?us-ascii?Q?cmZnSo34Tzn1OkG4nb2kx2AW4VPpSnHpEq8qNIO4E7o19ii6A2OJqZktXxl0?=
 =?us-ascii?Q?EvgCnuKklVlqCi16xS1ZGhXsGnPM5LP+6M8qHFgoixvpJJGYm/uZU+r80KKp?=
 =?us-ascii?Q?jzr5h/SW99Gk8zCWjautjRljCQnPyHTYnAsBSumQ8WfWox6TfFIMzCi3bUjZ?=
 =?us-ascii?Q?KniY2aFgcsVsbyYGF3tOZ0wO3+aKjHwNv8alop99gtAa0vbCbFhm7iwagrag?=
 =?us-ascii?Q?+vwDeebSyIJ3qXSLZ+QaYW2bbToZJuCxnG3z/f5eXg3HWKTKqanA2Nit9ogk?=
 =?us-ascii?Q?KTdJbOV1OGn/vg3ydsDfn7esYgIO2djF0xAVWUutbux+zZzIWCVBroEhY1Qq?=
 =?us-ascii?Q?gGt9BHj8pN0jEJcYVLWpXDmobWZ3eHImVKT4DtuAHJnsFK93rseqyOFwrCBj?=
 =?us-ascii?Q?7P2NGDAg1UrdCg4YKVRHOK+IHK8KjSC2Jt84XY5ikQK8cGFWbxfdF74U2i9Q?=
 =?us-ascii?Q?tXNWluR4chqLY/ONMVsC+58/zYf9KImgXCgX2JnnjQ0IJNGMj93Le3SvLhn7?=
 =?us-ascii?Q?0/g+sfRPeax1FMF7RkkqLEawBOneffIphuyrCxGBzHD439dkyOQVQd1i8pql?=
 =?us-ascii?Q?OT/3R7cvRA70TCRFrljGj26tiQHfPRAD2423+stuGtIH16fUMKGYFDSJTtAs?=
 =?us-ascii?Q?QHhv8SouwAhYyyT3jhoWB8R/qWjjggd7ENOGIXhwVGYtrxjZeJdEqu8NYRQf?=
 =?us-ascii?Q?EOQ1KwURXfLRsSQvmV7lxE1M3+l70I9MwJZA5H0gXyhSuRsxqRKsM7wsRDkB?=
 =?us-ascii?Q?DcMHpXXreExUGIM3nqYZt7iGpZjwpBHYuqtVM4V10ACud+vRyslBKFFh4H1J?=
 =?us-ascii?Q?rI3wvIe9yWvWe/9fUsxllc8wwoec2XedtFJZihccxCUpia3HtKv/DQJfjCf5?=
 =?us-ascii?Q?4SNZrBXTUKROCFySN6FuMc9zp+9WECuO4cpaz4PtyvmHVQ/jCVsic3dhu76m?=
 =?us-ascii?Q?z7//psNngNojnh3Llc2w4PQIelHGsarJIO+KJAz6avZbDKqQ+WU47Aurb7HD?=
 =?us-ascii?Q?COqtEp3qnWn/73AL7rWWSDjMPY4bZjNOw5C0ZcHYWUWhl3b2W3wp7BaxEBCK?=
 =?us-ascii?Q?SfL5HAixeqPrhAtDFxc6lr/5y9ap57YgC7dngxbB7YClfJ8GpwLSahprNjd6?=
 =?us-ascii?Q?DrhZnbDeXMO9lFKzCtWu8mh9PwRLAN7fNHHo/6vJGSQSVO2Ei7/pvFxr2JvB?=
 =?us-ascii?Q?CPrupGuUbAPtQTcDbZvRfWtxj6gnyUutrNVHR1NeyPdbne5//4P6KIkiUvC4?=
 =?us-ascii?Q?H0rDUVZQ7kPfvk3069ef1B8VHFH8K/G2mrC/bJ2xtKmykKzcJ4uDbMR+PTNC?=
 =?us-ascii?Q?qOwUrpdHXA1TPCnFSQU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:24.6965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6100c29-98de-4150-332e-08ddfccb9fe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2e28b807d71..6604e24a9cd 100644
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
2.51.0


