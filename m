Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F55C83F0A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjdlX-0006Ci-VE; Thu, 29 Aug 2024 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sjdlW-0006Bn-3z; Thu, 29 Aug 2024 07:56:38 -0400
Received: from mail-bn7nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2009::608]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Shivasagar.Myana@amd.com>)
 id 1sjdlH-0005fj-J5; Thu, 29 Aug 2024 07:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZCzw3tgoGQRhOwfUnK3iJtmqpTlg5mUuV9hTahNeRaiOEpe8PGibplfYR3aoaOyZ3tkp0TESyIbSVaxPlhzY3BfSGi9TdzqVSzq7p+jjBdD36ioR4iqQhh0hsrM5L08uJGBg3MIaFD5q2SKqk4/sOeZbOeYxf349HCjknM1DtsnEUOjVkpQ+ChT1ghdGNzsulG8q5J0zKtYvS+06OE49eFH2xWFW1/S7T3ddJWNhif21c9GjT5M3YPw96fFeaSEj4WPNThBC8zwbsXoeqfeW4skhwyOofYp/Kv54pFmkJ6ZiQK74+jGQcuBITjEcfjhBARkBl3fJhUcQJTeBLdYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaWsqWY9RoVsoF14fszRpGQeCK0FqiAIFFYErIAzlZE=;
 b=dA5W3xD0fgVwLnRPgWHC0SLxh76+ib7R5TmL87iobI02vE49uU6wVM25yKw9t2BhHY5tBR++ZFdYeBiiTPbBTpbTYxFyBgcCugeDa/b/S3Ke4WK4c7L34kgZMe/1k+5vQhB4LTf19GsLve3JcIDPukyla3gxgjzzimjCqUsEBM83pJb0JdYWBDJ0H411/7jd2DH6W+zI+M2EzR75D+6zSHP3WJNxiVHmKkrU5frloZThf6+efcQM/RiIzeApcv2oMWKYWjZRqWZ+1VqDypcTkkSGCp/RoAahZBqGNwag2n66U2qFRodxVx/pOSO5be/w4Xun4iYjT7P0pf2FSAOFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaWsqWY9RoVsoF14fszRpGQeCK0FqiAIFFYErIAzlZE=;
 b=4hDjTTayCCK5FRm/dh1kjVWsPTgJ0WEJcl4nJkcpfMIj1DjPyk+h2DeQONBJ06sXPcTDzPkzCwCXSWYqC6UbBBmuTZmq/w84HXLcyyMsVaujS5tfVY+e9wdVb56PdxGIIAKZ4v5u4tNvrACe8ziIfYwAms/mAAZJj2EXZ7tukJs=
Received: from CH0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:610:cc::15)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 11:56:13 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::8) by CH0PR03CA0070.outlook.office365.com
 (2603:10b6:610:cc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 11:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 11:56:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 06:56:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 06:56:08 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 29 Aug 2024 06:56:06 -0500
From: Shiva sagar Myana <Shivasagar.Myana@amd.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <alistair@alistair23.me>,
 <francisco.iglesias@amd.com>, <peter.maydell@linaro.org>,
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 1/1] m25p80: Add SFDP table for mt35xu01gbba flash device
Date: Thu, 29 Aug 2024 17:25:34 +0530
Message-ID: <20240829115534.610676-1-Shivasagar.Myana@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: d71305bb-53c2-4c73-9e38-08dcc8219440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IcE0/kOnlS7AyFp0qNgcKfYHcYE2wsdPHb3P1bWKdTbUHVswuag+gnEcaen8?=
 =?us-ascii?Q?UbRFg/UJBj7RCKgcKgJhEn+EPQG6xBYwfwSSABUDm4Fuj0SR4eH1rNu6F0PJ?=
 =?us-ascii?Q?3nGL9XH1RAv7luK6v7yIFZ63V4b4oDMumP4mIrZN7V/y/I5zLtet3eBJAFqv?=
 =?us-ascii?Q?r3qyQX+w29jB98lNbJq6nwF4khwwESO6GKqBOwSQmf8FnPu6p0bgjxtq+iG4?=
 =?us-ascii?Q?4ZbIPWTgoxd+yhPdNJfkEszLS3dKMjWsRrueG2QCyGxeDQPVyxESfvCD+rga?=
 =?us-ascii?Q?CrLCFJDfEjIk8bYPxtyyEmS+uyn/TQu8M4d7rKAspxrADFB9hj8CMVpvvmgD?=
 =?us-ascii?Q?JzgFs4ZGxZcZlgs6zniL4mtsbErPbU+2UQAW4Bmrw6iq+ctZ1e3Mjw65bFLx?=
 =?us-ascii?Q?1QZ0OxxvzzbA5VnjdCmik4GcYpxL4DK9XxvNj+yLYfyCH/JjTQIOv1BPQdkP?=
 =?us-ascii?Q?6gpVZ0feOOmIXVvekwOn7AOso1wCZv3FByD2WaF3bPn+pltlfEQV+WdP7z6D?=
 =?us-ascii?Q?7345KVi0MdFFBlPPjXOB3o7DFCKxUX38ykh+lxIu+ZiU7OXTSZs1l866/vbn?=
 =?us-ascii?Q?6kK+ekuFHA3Z5ih/K1muJnXNhl0VWdTf3lpS3YWb/wp6kll/G4PJh728uihE?=
 =?us-ascii?Q?Es6AsZdPtEMluKwddcxqHuX5V5U95UHnecNv41KAtMYMrAXt5Uj/BoeSd247?=
 =?us-ascii?Q?1H5/Luv4MiEZxc6dQIlHfyemLKj5ZYYn0p+/3fv+IBEnptgk7Kog2WlzXkVo?=
 =?us-ascii?Q?SqcSd15iMlipQEnhLw8/H5gNfk5vOemgZOLedach8UlEa0n5dW+jQEP0YbNU?=
 =?us-ascii?Q?xOnY2cixcOKcEVygQmQOEoWxoL/OzWCDfADa1a1GxVqKri3mJALZMtI8BfUa?=
 =?us-ascii?Q?qgE4sbjPRpeRyhgKfLbHNDz0cw1CBGpK1v+BnZGyQ1bJZY6lmw0gkvojpl4j?=
 =?us-ascii?Q?4OqgemhxzK8DoYZB/1IIzEsmLwLBrcAidl7mM57UAGRKNDslQ3S1rELhn+j9?=
 =?us-ascii?Q?gxSo0RzbPrCr/QBJen55ZgTO5/o+SOmS5BnrOrm+w6rwECrtmm4NT34HsT1x?=
 =?us-ascii?Q?637Z6YBinfiV+jjSVloY67jHx4JLxtBZj1CkNoGJvPp/TuEi08grqcPb+PfX?=
 =?us-ascii?Q?PQvAVtj+UhcWXLIu8rj+/22Wpk7FBdtT/45AQ2SO6rk9r3LPWaEkZwpcwlEt?=
 =?us-ascii?Q?1UMa8hi3gBNAW5GNiOmiH/UYEw7UBoc5cPyXyDuFPtwLfxIxZCxY1o+1XDrJ?=
 =?us-ascii?Q?wA9ZT9gmzrpeVda8EjA1Xf5Kt1l05od4iZvpGkoxyhyTTQ+wOzwsvoDnudV4?=
 =?us-ascii?Q?SbaFIt9vqmGyVEGoYNjphKPK5GnW8GO8EP8ox7nTKTWQUzsTk/8CBwYq6J9q?=
 =?us-ascii?Q?jBMBYEtz3kuiz8NwDcK43TMID4OJ+daJO/+zYnm0o13nJFl0ZMlDu3O3CHAy?=
 =?us-ascii?Q?aItxScmxbPj9SnYoYWfwQudBF9Ur6sGO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:56:12.3694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71305bb-53c2-4c73-9e38-08dcc8219440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
Received-SPF: permerror client-ip=2a01:111:f403:2009::608;
 envelope-from=Shivasagar.Myana@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The SFDP table size is 0x100 bytes long. The basic features are available at
byte 0x30.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
---
 hw/block/m25p80.c      |  3 ++-
 hw/block/m25p80_sfdp.c | 37 +++++++++++++++++++++++++++++++++++++
 hw/block/m25p80_sfdp.h |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0b94af3653..23290edfe4 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -266,7 +266,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q512ax3",  0x20ba20,  0x1000,  64 << 10, 1024, ER_4K) },
     { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
     { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
-                   ER_4K | ER_32K, 2) },
+                   ER_4K | ER_32K, 2),
+                   .sfdp_read = m25p80_sfdp_mt35xu01g },
     { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
                    ER_4K | ER_32K, 4),
                    .sfdp_read = m25p80_sfdp_mt35xu02g },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 6ee2cfaf11..82d84cc21f 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -57,6 +57,43 @@ static const uint8_t sfdp_n25q256a[] = {
 };
 define_sfdp_read(n25q256a);
 
+static const uint8_t sfdp_mt35xu01g[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x3f,
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
+define_sfdp_read(mt35xu01g);
+
 static const uint8_t sfdp_mt35xu02g[] = {
     0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
     0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 1733b56950..89c2d8f72d 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -16,6 +16,7 @@
 #define M25P80_SFDP_MAX_SIZE  (1 << 24)
 
 uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
+uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
 uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
 
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
-- 
2.34.1


