Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4759CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAU-00070P-J1; Wed, 20 Aug 2025 04:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAR-0006pc-8u; Wed, 20 Aug 2025 04:27:35 -0400
Received: from mail-mw2nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:200a::610]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAM-00015g-ER; Wed, 20 Aug 2025 04:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlIZe0IqvUgR80nPP2dGXpbkeqk01qFDBwpvz0fg7Pj+8/OwBvkCRY1VojL7Wb++ZgYfGoRitIrda+2/ftwdixJ2xVmu8i5vXzyvR0dfa3LR+6am4TzYqRHYpNrZD3S0T+a+/c4Oq5pPSdEYohfkhzS4PZeEHWlotDDIHpjGV3IPZeV/Bvo0ZP763e8grKEClk/oaob0sc3JW8/f0MigWQvIezXbPqjYiPl1pVSOvuFjVDAiQyMSB8n9KkP/5DnFB+OsRMZkLNiKg2kQzlI2wkMF4Vu9eX3PtfFf8odePLxO7/BiXo12lU1VB35moIFZMTcjA6Jv7E2LNFT0eJomdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w2KORNVBloILL+eq/MJpBajK/PlfT9EpCWOMmkaC4Y=;
 b=sF+rOAvfWfkJZQsZcnzpPuVeWsFdQDY2uFlc6N6zfobbgwVz7pTPrnpCPIk0giXSaWVovr/+w6iDJkGfN89PfNV+vNuQ2an2kUY7lEOkahGcIaZIWamRuX6or/UrRnTSWZ+QXZfAVVBmjFyhQ9opO/OAzqT8ih7ulrRU33A+F4tsMau43kGMUciFCDsw7aFQN7FO70/wQRXwG217xsM15Yy259ICeeOuwzI1sSjgE0DvdPDfnzDL5wp6DfAfim6m1+APk0gm3glkuYKI5h8jx4ChiYhdM0dO2m84J6Cp+WPZniN+g3Q14jA9Wba1fHV10GIfV+8vHvYfM+nrLbAFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w2KORNVBloILL+eq/MJpBajK/PlfT9EpCWOMmkaC4Y=;
 b=LO8zDwhROPKtzZL0gwKK83qARnfHBd/pG/NFHMLwaPw9zTRq74TAAV7j4FUUj1oChbZfKWYuIxL9cXpICxcLhwvD1hORAxc8SzHmjtOMbYFoGF1yiZwxhbZiQMIt49PJ7CrDrOWq5JZzH2/cCZe25euJITwQ2uZ25C4hlqOm4K4=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:27:16 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::fe) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Wed,
 20 Aug 2025 08:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:13 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:11 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 33/47] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Wed, 20 Aug 2025 10:25:32 +0200
Message-ID: <20250820082549.69724-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e8717b-7411-48d9-264c-08dddfc35f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rV30/nc48DV3AmF4oKf9ccivsJWINyNSpPt1TQh1Xn/KveEKqxtZijiwE0z5?=
 =?us-ascii?Q?CGQ91qB34aUsrWMRWUtESdrFNhSEMvc/6s28RT5oxMNfIPkPnAIy1AsMw7Ln?=
 =?us-ascii?Q?ISeRAKz1lQEWBdwSyvrWNK+70igg8oYl0ETK1XuZWOHaNKh9wt54+CmtkGmY?=
 =?us-ascii?Q?RTbV6tS7dPxja3Vl7anFU48iqMToSPxVdd7W/HMgYp2CiFdIajDNUOAnXrOH?=
 =?us-ascii?Q?Dn1/TVXG83M+IpG828fFCPCwQ2rdNDlWjQTevPBT6KyUXZb/Lv9kBefU3YbT?=
 =?us-ascii?Q?rDD8SHodKGnQemnEcgZQwmrli1uVNxhXh1qkxi7hn1s9b78RblRorHR+cfvd?=
 =?us-ascii?Q?SwymihZagVDcYzyduTmF+gNOnWoNUoXBK1bXb1lAnKjhUVDBaOrt3mVHL9fU?=
 =?us-ascii?Q?6I40qI108FuQMAD0OEg1nVIdqQj843sLDsG4WS1H2botBsuhAYucfI2iJiRr?=
 =?us-ascii?Q?MNZ+PA+AKBa+u1Ks4Y8PaAsZVWtepHGSet12F4fp8t/pqo3XjM7nY63tGBhh?=
 =?us-ascii?Q?BaxuUu5geDMokDRSQVRtuDIhDps5gLMPwPQ6ju2rNSu0q6IUCxhgiXJ6o+hR?=
 =?us-ascii?Q?gvFUYceGqyGweymdwi0a4a55Ae6f7hQAq+HXVKIWs8CsYyRIzRfiPTX96WBM?=
 =?us-ascii?Q?H7p/Qeou8HzXK6vu9duEFE1FXZ9O6FAMlXxIOGJysnKEmdb6qOHx0Lsk7/p/?=
 =?us-ascii?Q?7RmHcRTv4dCSjdmg24Kyj3yOh0Pi27PbbPitIB6DP1SGkV8X/9Ck1EZmJlEC?=
 =?us-ascii?Q?RDqAdP7pds/trn+RgO2MVLCW589o20Cb73YsxVWyHxFIaO8HSNEUmO+ejFjh?=
 =?us-ascii?Q?MAMHd6HXxFgW+7tRt9nsAdfkeDg+xLBsQeQzGUlQ5cT5EtA0lCglZ5L3YbH6?=
 =?us-ascii?Q?aswdiTYr2QVgnzzdMLgvvXfB7mCxz5MWLqMqq+002+Wm1HKYFVZapYpUSgZu?=
 =?us-ascii?Q?d/UnAGW7WC96ZPK8w179PVFhYvyF2CdWUQFN6p8ISHGfC8zUkuJmbYKvIJ3s?=
 =?us-ascii?Q?WfIMHYDGFEn9dVsxcp0v09p0VRGy16fZ6a1L1BK+Vl1pLlvn2vRxT44WA8wf?=
 =?us-ascii?Q?6kv+5ZpmYDSkXlARBu5Iy1UvvqB3YmLIU7UJ3Mn9uLMPaeAHPlww3daJw10G?=
 =?us-ascii?Q?+rA4m3u/nXa3rPTAmABYR2/yS45nVqaioS5TTpbqUN/b3CpEMkW6TaHT18sa?=
 =?us-ascii?Q?shh8blS+qvclo8/ZOlVXEedt9AeUDXHgbS/97bj/sx0Us5+kzGKA1E1rxF5M?=
 =?us-ascii?Q?KPsWJpVVM8+1nUnOSGaa6jv4ddgNwFr56BDAgIuiKGsaFnl1tzCaJcGgsv66?=
 =?us-ascii?Q?QwJ9F18i8a5aMoYuRN6ANQlDlpULMnKkqg2Y/qXFNOF7w1NIBYoch752EYxY?=
 =?us-ascii?Q?amoWFHgEOLPgE17X+rQAdnrUMxuiomRKC6gniAbZ0e7UkWCNs82Zki3uvlDR?=
 =?us-ascii?Q?sevSYMEeGHtUCstvKM2qMPMx4rAWSPUnB4tOn9I2QA3TZZxdJELqdQJrhE1D?=
 =?us-ascii?Q?AwWe7ZS3Gguiz/int1Fb3Hrv7myyEfWiTrwm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:16.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e8717b-7411-48d9-264c-08dddfc35f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
Received-SPF: permerror client-ip=2a01:111:f403:200a::610;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
2.50.1


