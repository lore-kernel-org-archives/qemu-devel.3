Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612BECA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXK-0000kh-TH; Fri, 22 Aug 2025 11:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWS-00082W-6F; Fri, 22 Aug 2025 11:17:48 -0400
Received: from mail-bn8nam04on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2408::624]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWE-0007DH-JF; Fri, 22 Aug 2025 11:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj/pooaNryj9U0D4SrDZEwQFamQdRGCDuNdU8UpciQKK+QQH98k5VB/3hsbDzoVH81gRfNkexiBxGNpO0SO9C9zqnpkK5C4BJtF4gP2uN/tZDGGldppyeij5dGQKMkBTcUzshdTs8PBKL+W0uvkqv76n3OS+Kh2t3ISALRwa1mgWvxvJrVFFljYmIwDVoYVg68vTuVRxLunAK5GisoZxL/5tLlfTLjZYfQujO6QHs97BecRJmuUPfYVRlHmy+RHubQ/R9B/WHDPMr9orudLATCIVPO25n2n7NVMa1q2tDh8TSom2J2j6HFzFGD4OQXSIOdMhGEUMbnurLt43qYr7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXaByh5+Yp7dWw/wZCgoeYNnUMhVukK+CdZlmC0Rhio=;
 b=qs723qxDRjTP72KV7W0cdeWRe2EIsiFGIwK1kU+cnxnqcqj3Gc8zHiqHUHrWJiB4hGKEZWNfQ2b5GM9qwDQy7vBjSlhSQ1zmBlg30P8twhpQkn1yap3XSGduZbQ0GLRCriNNoAP5oh5OpAbuo64r6XsNncvQJ9twATogJ4nVsKhKE6KMVxfB7fwlNZdlC+sHykTSG9FJzyIRIQY6nsO0FwXfAvaHAVAtgFFiSAckVYc4TkUjYkrWgllUa1olAZ/GLur7dq14o8Y/q/3EUzdUJjktK2qRR2UtTdNwTTq2574OFxSH3lfbTiM4lMH7IVbtaFq6P1gLVoWKUDOOd2IJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXaByh5+Yp7dWw/wZCgoeYNnUMhVukK+CdZlmC0Rhio=;
 b=pLfWuZntIkANdnZuPz77IZxGsbwKI74sgHw0/yro+Ht0DmSR/W4nB0q5NhK0DgLhMTzMWLUeBV3ytFxlhYFzXWU/4IftFZHu19Dhv0+hqZCDCL2XJtX2BFG3wgW/HrcAVFl2WdwZAb9gYLleqrSp5EvCUzm+fePscH/J1LU0yxo=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 15:17:23 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::b5) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 15:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:22 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:20 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 29/47] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Date: Fri, 22 Aug 2025 17:15:54 +0200
Message-ID: <20250822151614.187856-30-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 50387070-5f1e-4db2-8630-08dde18efee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WjEAbvwNJQMvsqrJRxNSMAhzVgT7zh2Kp2U3w8MSpERFgCxDcnSrhvEZ6sBU?=
 =?us-ascii?Q?+najuTeBa2EUvQtghfo6KoQjmWNcYesXZAx/n2qyxQ/XT8Vk5KXY1nGGNVMO?=
 =?us-ascii?Q?jVJJa46w7APyNkTqj75i9p3NekEIOkmWT4698/crTYGqsb5Syz8/rTpUAJ5V?=
 =?us-ascii?Q?ZTNISbKXI/RiPf5gnArcOXX2Mvp1swEVPIFvzzRS3nOuWjgXYtisw8OX1Xcj?=
 =?us-ascii?Q?ikZQdD/PazWlBlJPMFYuWYQf0X/HZJ4ZkIa2GqcaIXd+sAul4/xRxRDA8Spv?=
 =?us-ascii?Q?+4RhdP3kLk1mSP/+4FEEJBuZgIUj6GJh5QJzRqf4VGSI1wAUT0KCY4ircXZx?=
 =?us-ascii?Q?qKP6IQXkw39isacseGhboV55529/QD23UwL3Hag9n3hkNN0QXJGO6hjZu4tj?=
 =?us-ascii?Q?K3TJwyZ7vGJzsFwdQiPdiap2OxfweZqYOxP5uSTUavUoWaZ+kEXaH6uMP9eY?=
 =?us-ascii?Q?HXpJBw3D3CuEnWcZ6Y5IDjgPYNyhT0mzekNeI2PwCLAtNpKRaafIxJmnmU0E?=
 =?us-ascii?Q?Fk6QGOjtUXsnAYOmSWNaV5lmOpUXdsYVp7qUDuIMUki1iWmCbwG4+1WXntpv?=
 =?us-ascii?Q?5gpjvUOfbakRZB8+hIi+cgeV9U6T5FzG2kjUR6LjB/YGkwk1XfCZNGI7hS0x?=
 =?us-ascii?Q?Ugb7WzLGBfedC3os2MyEuB3GB0sBTqDHSmVPVdNEj79kyycEZLU40r1lZ+If?=
 =?us-ascii?Q?d26S6ArtsSf83V7MR5usslKCRFXqLB0YDDmQFCVrOeoP/hd2n1Sh8sH0Gq6T?=
 =?us-ascii?Q?IAL5ffI9j2fqwzTOYFXMKMKFNS8EHP+hfTPJI2a6zsdcZDuGyhZ9jQ79Srbv?=
 =?us-ascii?Q?cuP1J9bFmFRMP2bwXkJvcVbzPgssl/GsIqFCwpPPIWOvtJuq2mPuAg3mTMJH?=
 =?us-ascii?Q?8C4Mz5gXKWWUvi1QvGvro5yWj4pmzUt2VK4KuodIkdWqMyOuo6t2fo6bN1uj?=
 =?us-ascii?Q?pdypSmHh8I0SgIX12/HQ/QidB3r2nW55VlF46uBfhttzoTd6QmSey/zGSQpl?=
 =?us-ascii?Q?biZqu0pBcKKhK/kSCpXBaHbHngGgbpz3Kq4jykE6sOq/7Md5O7+TMdNv8yFa?=
 =?us-ascii?Q?cKa4iFuRdiBD74XMVJhE3EsujHcq8AZ+SKD4YPYTaP5rpfT4Npsa2Y6l0Np2?=
 =?us-ascii?Q?B4xQcjx12sdpcczmQPSBdaVkSHS0z7FqPNhvTspWa5M3sMPcXmxnQpD0Ld5b?=
 =?us-ascii?Q?Eydh0kkDr7Q6iDsekBlCZ1NHg/8hDhV6nBgrrtMErktgTLlI9TZ+V6RmIpij?=
 =?us-ascii?Q?1T0EzAwY5FR0+CAdysUFjSarbkDVwINZ6vDqmp1ldrUy0mrnefbzB/pg8HwG?=
 =?us-ascii?Q?9eGfjc94f71rCYkgLtqHosca2BCearQCWbViC6jeUifX3H0+7OJA8K8+yWYR?=
 =?us-ascii?Q?2NuImu/mCWAAl4vPn4rSoqqAE9OfwbZV/a9OJ8lr86HIpt5e5dJn0tpmQmpp?=
 =?us-ascii?Q?Sfp06u7G3SOLruCbKSDvRMxBlOAy5Ogdbawcy9rDXbedQU+QWhxxUfoX1/Qx?=
 =?us-ascii?Q?jrAbROvkIEijS2gS3rGZc9cSn+rEtaZ0TKik?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:23.3666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50387070-5f1e-4db2-8630-08dde18efee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
Received-SPF: permerror client-ip=2a01:111:f403:2408::624;
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

Add the versal_get_num_cpu accessor to the Versal SoC to retrieve the
number of CPUs in the SoC. Use it in the xlnx-versal-virt machine.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 1 +
 hw/arm/xlnx-versal-virt.c    | 7 ++++---
 hw/arm/xlnx-versal.c         | 8 ++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 39bc414c85c..7bdf6dab629 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -78,10 +78,11 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
 qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
 hwaddr versal_get_reserved_mmio_addr(Versal *s);
 
+int versal_get_num_cpu(VersalVersion version);
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index ad7b3135a67..274a7ef9889 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -344,16 +344,17 @@ static void versal_virt_machine_finalize(Object *obj)
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
 
     mc->desc = "Xilinx Versal Virtual development board";
     mc->init = versal_virt_init;
-    mc->min_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
-    mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
+    mc->min_cpus = num_cpu;
+    mc->max_cpus = num_cpu;
+    mc->default_cpus = num_cpu;
     mc->no_cdrom = true;
     mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2a0aca74708..181f35d607f 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1817,10 +1817,18 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
     const VersalMap *map = versal_get_map(s);
 
     return map->reserved.mmio_start;
 }
 
+int versal_get_num_cpu(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->apu.num_cluster * map->apu.num_core
+        + map->rpu.num_cluster * map->rpu.num_core;
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
-- 
2.50.1


