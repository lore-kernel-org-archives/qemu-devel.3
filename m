Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFDC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMFv-0001Tt-Ot; Tue, 20 Feb 2024 04:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFt-0001Sr-VB; Tue, 20 Feb 2024 04:17:37 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFs-0004Le-5q; Tue, 20 Feb 2024 04:17:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYnXlN150N+NZH1dyFtgz86jOdW5sUgFw66uV/oHbkjUDkm7B+U0DKtHfk1kY+qOYPMkHBMZ8Xw9JCckbSqXDHwGEC4hQfVeUpLbtPjdBbnrciixpieWCdC40Cy44G4HMnodA02X2NQ0GyAQehVNRWSyMv4cj+l9J5vTAsYwo5qLLFClgi3319IP2FaYzmTWJB5H0bHSRc+Rx9ZQ59XrIbfvvD0UGK7slj+3q8GknFOx0gywhFP3f8XS6sCIghe74uxF+aZ8/ZTO0YGrvtAzDaWi1sY7tZT+CfySL4UUyJ2rVYmeGxo7VtJmHANVxLuBQhi5VqFY0NMwOk//f7BngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0od/PrEcbSIF8ofbEoWOY+H2cDNF/S9ZlA1rOMDabY=;
 b=Wq6gf89Aqr43dGgikkOhaGEvqf52xhYXOen6MCcE4JXtgmDixnCbCXJmRXXQlEraa/FW+dChkol64M5tENaKoTC/IGMzhD1DsGacPT86Oy6klNlCmZoJr6VJH35uoDhIYN7U0GbDV5r+41BOycV5dD6UeVOCtto3M71JrRTiXv54iythsb514ONWO5nPsYOAEIYi8qsrjICqiSu0YoCXA1zZgh8/U4oWuqfyFn5iCwdu7XgAo+MVu5lyJG/l+U9WBmXGuabG6+gm8l/eNz0df6l6JMXKCsEVRAa+Y8O8y+Kkkci5QmeHR13DDS6QDD48bBZEEgZPMUUX8fX1mN+RUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0od/PrEcbSIF8ofbEoWOY+H2cDNF/S9ZlA1rOMDabY=;
 b=w9LXiIrtr7G6UW9CBwXY4TYSWO11NnPjilQi6VM7d9gWS6vVA4P05VS3m3dFIJYp7cPcHlF9NUImtrGCHcomu93nFMYKJcNIcsySRyr7rYnIjtJzBSk3jbY87g8HJ4frIUc3kRGhoOUbWwCOXwvjpJ3Hs++/9tRGHBBV3GDvc7w=
Received: from DM6PR07CA0127.namprd07.prod.outlook.com (2603:10b6:5:330::28)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 09:17:33 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::b1) by DM6PR07CA0127.outlook.office365.com
 (2603:10b6:5:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 09:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 09:17:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 03:17:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 03:17:31 -0600
Received: from xhdvaralaxm41-docker.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 20 Feb 2024 03:17:29 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias
 <frasse.iglesias@gmail.com>, <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 1/2] block: m25p80: Add support of mt35xu02gbba
Date: Tue, 20 Feb 2024 09:17:20 +0000
Message-ID: <20240220091721.82954-2-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
References: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd93676-6978-4663-6824-08dc31f4c4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcCXhdgeL+wAIEEobmh1j00LX4mdib8nv1Dg5pO+9QjKqLpPg49B9kJ3HvpP6yZlE/hJVdprOyf3ltfX29/MaBfELVyhZEm0j/f4plG2ySSzsiKsPR6V6OUrAUO7qouegGBd/OFeDaIL4jdzS798OMy+Xf74tIViB3P2LMNO/ojqA7AFKI67dbP8OfrBXD+1iQqEVrwOzO2+63YHRl5Mk1UngnhNbvbN446GhR+VnpJQEzZtX8UUsONJpN8wysQXnoIzBdyqKuCjsCOGOsc5/6RfG/xotunZ0GiNP6MqIdEvRAvyW5IU5w4dNIlCZHJnyWtd4QICsJnKW4zw9H6cTL1aFuRCuVZozkGel+MDiU9s9mD8i2izkGNWcj9D3MitlXTZEPkCLwKDohJgyqUk2odcjNLB22fESnXShPqFOHBv9qrf8mlcTDt9sHGi2EReyjfbnZJNguy3RwGZsV85hJo06rtisj1cYq0ZvlEDg1rMcOTZeQ+sDoct0gmgXpiVaZqWBWc6PnxUugFn84D73la5xjTQ3+Ms1vnNPTi6WmtP5rfKgyO9NRGCz+IdtjL4hvs6UNuA+Up3sVzEYJc9x4KVv3T5ckTRfaxFaDo/TW/Mj3YsJt7MYZP+Ng++Xhuk9/2uzGKJxsYTZuqb5GL6QACWIAlfJXlDOE2pdxN4huM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:17:32.4504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd93676-6978-4663-6824-08dc31f4c4ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add Micro 2Gb OSPI flash part with sfdp data.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/block/m25p80_sfdp.h |  1 +
 hw/block/m25p80.c      |  3 +++
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 011a880f66..1733b56950 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -16,6 +16,7 @@
 #define M25P80_SFDP_MAX_SIZE  (1 << 24)
 
 uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
+uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
 
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0a12030a3a..08a00a6d9b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -267,6 +267,9 @@ static const FlashPartInfo known_devices[] = {
     { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
     { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
                    ER_4K | ER_32K, 2) },
+    { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
+                   ER_4K | ER_32K, 4),
+                   .sfdp_read = m25p80_sfdp_mt35xu02g },
     { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
     { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
     { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index b33811a4f5..6ee2cfaf11 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -57,6 +57,42 @@ static const uint8_t sfdp_n25q256a[] = {
 };
 define_sfdp_read(n25q256a);
 
+static const uint8_t sfdp_mt35xu02g[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x7f,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0x00, 0x00, 0x0c, 0x20, 0x11, 0xd8,
+    0x0f, 0x52, 0x00, 0x00, 0x24, 0x5a, 0x99, 0x00,
+    0x8b, 0x8e, 0x03, 0xe1, 0xac, 0x01, 0x27, 0x38,
+    0x7a, 0x75, 0x7a, 0x75, 0xfb, 0xbd, 0xd5, 0x5c,
+    0x00, 0x00, 0x70, 0xff, 0x81, 0xb0, 0x38, 0x36,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0x43, 0x0e, 0xff, 0xff, 0x21, 0xdc, 0x5c, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+define_sfdp_read(mt35xu02g);
 
 /*
  * Matronix
-- 
2.25.1


