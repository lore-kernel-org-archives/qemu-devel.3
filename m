Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F95CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eE-0000vW-DA; Fri, 12 Sep 2025 06:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007R4-RV; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-bn8nam04on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2408::60f]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ci-0001O1-9t; Fri, 12 Sep 2025 06:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prFGm+VtoLRN0fZmMljF9/cwlhEui0pY6cu9d1WWZYZaxCtPWvuv+3gBuEVMAt7rz32nakCTfrHaJROcHmaKG7C2GP13kmmqOvopswlVx/iScfc0jdpTBq1CZBu1Y5EZiSTuareKJz8K0hkzBsP3Djmp4zd3243uiF2PjaYfk8nbrQ2CXWRuU4N2JcwtfcCjgO86VWbTMJSHhjrl6kXhu3G9DZWyjLiGXZRy559cSp9uW6EJ7inWpW/3mMW1P/A9x1hhzCtbfA128ZB66LClUuVkN7RgqGE2ojS8/Br92LnVng6sewNUmDGX781C54Sr6Fb7BBjkcDpfLtkO0osTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SrLEqEjQUaDOwqgTE5xnngqS3BaUTNZ/2FiQUIsXNs=;
 b=bpgfTLWi2xsQqjqbNsTEvL3zExMFksejIbHkhw3spnk7YhNcTjCvqg+S2T6BN4QQo5KgW1YeFhypZQYYBT6gpr0joutcVuCRylkjcuG6Vxmh/ahJF6hrnAqc9qDfknowegnuA/vvXiYioFbH8gPMZ0OacE3x/azTXglGPNGnqTUOXEa7iClfhNkJ8lMhgxDf4ORtt1Fgo82+cQ+CsWw4HFsqH9CjYFoxiEPK5R1GSk291M2JRodMHs6Dzbrhnk2uGuXAQ1+J9mIBaT6Qzer8Hvg3s6qheUoNS8y76+OU1ZVU4S7Jn8ArDJnDIyPe1+zcnlaoaQpMWin4iTEmRog8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SrLEqEjQUaDOwqgTE5xnngqS3BaUTNZ/2FiQUIsXNs=;
 b=p1flHHj05l0OjRBEsK8mQCavZnzfvb4nKICOIS+SmrO0iNyUFhB2+ET+uFScu9Ct9cxHGilyfWAhRrWqcW7pnY+WlMMtHRE3PN/ZJzOBB7mn0CUY17h9GuCtsqTk/9oJADZLyRF9CBVoUh3LZpI2a6Ix77q5asKdOmUUe2zPXDg=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:13 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::d2) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:20 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:18 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 33/47] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Fri, 12 Sep 2025 12:00:42 +0200
Message-ID: <20250912100059.103997-34-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b92beb1c-bc01-4e73-5c27-08ddf1e395ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kewcmHPmo5xM+GSEmt/FXVxyy2b5VmrNrKsg7Pvod8o9609oruU1aRgx4FZ2?=
 =?us-ascii?Q?bkZSp2k9lPUXgPO++DUGm2epsSWrbM+OMANzwTkAad/9fWx02D1Y62jbtMk4?=
 =?us-ascii?Q?ivYCcBloZns40f+gVuVw7En8I8M0dwJK6/esmxkBkIh2hCQT5fOwvymnPPBi?=
 =?us-ascii?Q?fFiKeoFyYXzUwc162LRxdeDt07pGrvAMUZwQAM5AtO1kAm8N/oUH1ZfO6d0J?=
 =?us-ascii?Q?xJWLHR4ZTT5qe+pA5hUsTfu+z78opVSQefOWsSyViXmCGPeO3Vt3ecDTqxGY?=
 =?us-ascii?Q?3xphTRf4ePeGtSTQ9zlZ9tom9LrFI36XxznHg5WCQ6MQIwMwkKuamMbLUvfM?=
 =?us-ascii?Q?lhwntNQzJtB1crscUiJzkrvl7BnjijSVslwXPqw9bzwh6mIRyJvBlyixHpQ2?=
 =?us-ascii?Q?uStvYApIQozd5NmdnFvdoXrX1IMSrDHmRdGPWZQZlbnPQm/fvdxA8oeAywVb?=
 =?us-ascii?Q?B4RlmHQt+/TubqVYvg0NNHX3zUcWRc0yy3DKlqMAST4MAIxtMUYtw9J9m6m3?=
 =?us-ascii?Q?yD7rM/Z5vLkpji2hVKL5uG/f2mHziWwHPWU8vodY0qwciXd68svlBsQ45XBw?=
 =?us-ascii?Q?LeKH5kwyjMdN6Y07aEPVeWdtf7feb97HNSJKzVNvaoFZ5+rKfZ8aIRVVzOoU?=
 =?us-ascii?Q?IsMuNBkcjplFFUgJlwhLc0cxVbkzPh78kAsk2GnH/L+m7mctB5NnvjCqZqj1?=
 =?us-ascii?Q?cdyRMAO8IrJcbyyuzaOylV6/1YgyidFqR0vZ/mmBtD8yT70jjVxBSrhKzady?=
 =?us-ascii?Q?EWjN+G2y/Sp8BCro46qNhUCQGD/141ZjIccPO0TipUh5QRywTvbtU/2MtIEv?=
 =?us-ascii?Q?72qmhrE60cmXijSgjVwXKdbQb5Z/E3TICjwh7IipJubH78qKH9J12Px9CWmD?=
 =?us-ascii?Q?WNPQqZU7R4dDSfS/Ydnzkco4jpYegrx1S4lH7beDIaR3pVdg4IQsXKEtzUF2?=
 =?us-ascii?Q?oHn69e0yOCrx0LgY3bqNqedLV4fMaU6Qh5WCYGXpOsCWhvjJqWGciHNCYxhB?=
 =?us-ascii?Q?tgiCBVBi1YwTN/ETOm5yucJB/B6HjfVth6FReta9kRlIiel9gOQRUtcsAS+z?=
 =?us-ascii?Q?4nivXNYVWtlpI5NksYGyutRGJPpd1KKHwM9gBCvNZlbutsul7bbygfo4hSTU?=
 =?us-ascii?Q?0xe4vLMHi1zjMw1ZoVFBUzcZoq3Ua72r470nZG1l7RA6X13eLT6SRMj71SfX?=
 =?us-ascii?Q?zMCIa6PPlbXfVrU4fpVrb09oNUyZUfGiLogT4OXvuIM3BAbJWjxaj3ybAnje?=
 =?us-ascii?Q?IhsxWq8SrRillN4qb6FSvMj8KOe5vSFLPbN/KRbcWR1tbWK7RAZnZEhI56Po?=
 =?us-ascii?Q?F6ODphyzB2tlc1gLCQuD8fxrh46MVeMD7jmcggWVwLONX23ADFVG4KgSnlg1?=
 =?us-ascii?Q?17aLuS03s7h+DdKAKegnKEiZx6qO7UMAZ9XkcZs+Ze1au6Amr83btJ4iNBZ5?=
 =?us-ascii?Q?GE+HMniTcm5fKp9rrqNsDa8FQRL71F5rqdIDV4AJj+yJuHVnMejDuwFN7J1E?=
 =?us-ascii?Q?CGfKWo2V6xQKJiop0ZmPgDWxVhx3LZ9jzto4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:12.7569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92beb1c-bc01-4e73-5c27-08ddf1e395ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
Received-SPF: permerror client-ip=2a01:111:f403:2408::60f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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
index 940233aad06..02119d13533 100644
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


