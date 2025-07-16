Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA2FC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyrC-00013a-W4; Wed, 16 Jul 2025 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyr6-0000sD-5J; Wed, 16 Jul 2025 05:55:17 -0400
Received: from mail-bn8nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2418::614]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyr0-0006Jm-3s; Wed, 16 Jul 2025 05:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juzXv7dLaqaGuJLxwuZULfu+tDup59A4Lx787abMLYKQCwHOIm1JlgRDxBi4h0XqnKrUgS2qoMGMk/wQeiJaF8Ghz3r5Ytzjy0MSoc//vkTZNHxsMHvUvLvwLVenKtKPN61jl6T6iwhasrCqvHw0bWMq+mWkpllS0BmKD+KpraaAHbjh8bVU7FYY13h9cJOPr4vZ7u06hIZUXebJX/I7xEr2EpgS06+zXvgOJx9CHqU0cMoXbpCa67fI09A24sJzgQt3HmFRl8+AeaN+iCPzo4ut4b7t60JJvCIoUKSDWB2XNhWvQrkPOyzwO3NVgEAdaRqr5aisBYzQTyC9T9nauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ltRVSfHknaOdKqpYHgPBajLrOHhp20FIlSqZrELeME=;
 b=l9B7QVKwrVlvr8H5Edhq0mPLgs/1ytiBH+0316QILnphskogcNgPgXZUSHwClG0IjMnVXPWpZZNGZ8EQ+T6rP+d63DVJAk2x13iOBfNVmqhLisBblX1fJTIJKAx3oNN889+rHG4UMwkJ8GvgxpQRTn0RhpTewt32t4Iv1xCFRBBSlHy99peyKxE20nIIk1cjDFIhajc+Yk6sL0mKHQEL/wq7ErQeHRuW3eIbloFc64ofYBBlgmvZLSlNcoNkTtPY0pHXFs9eX4SDBR2bb/Yd0/T5mEO0hL8ch9/rJ4njAKU+t4ZoYPD+wveKErHWaNZVTTRA/kHpbnBhHuAX0UO6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ltRVSfHknaOdKqpYHgPBajLrOHhp20FIlSqZrELeME=;
 b=Y/QWJUXc/yLTHKbYj7oc+Ou2amzNaBnhM0x8JZkYv17T0c/tKvy8gxPmU8e6QqSmk79EZdjzq12ZizCOlT4pRpRkCsfMvI5qyc4Dhomgbl2jF4rTw3+lxjuMmeSYANqbscYkmsOZ0xb0bbZfzVR6XoJ2zotVOOZVXupNPQbbyTQ=
Received: from DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 09:54:59 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::9b) by DM6PR14CA0064.outlook.office365.com
 (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:54:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:54:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:54:58 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:54:57 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>, 
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 01/48] hw/net/cadence_gem: fix register mask initialization
Date: Wed, 16 Jul 2025 11:53:43 +0200
Message-ID: <20250716095432.81923-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: d813fbbf-011f-467f-fe45-08ddc44ed3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kUugVGoqP774ogpSXzJVwDllDdfc9W15Dv9YeNIB0HKnhksB4M6RD2i1lXiP?=
 =?us-ascii?Q?KVOcokS+riv6eqfXgIwqx8ww6cj6AcT9qR6xzw7ha8eH5U+NeRsNBxFMGqcg?=
 =?us-ascii?Q?FnIrRu7LW1mO99miX6KjTcM33QJdrugUyA9Q0eVp2rovc97yBSPwm6h/5rX3?=
 =?us-ascii?Q?9C3DomrAgbLA0q6m7MxiWRqFMMz3X6FU2gvl1Fx+0wa5qmRMyD3gGLON/ZrQ?=
 =?us-ascii?Q?oSHPTJ2CnC/uLy5qregdjigpaeZFgHQA2oAWhh6qb0S9Z6FoCBiIMvN757m1?=
 =?us-ascii?Q?/o5BaJyA1ELkQ4TOgYw39guPUL10NVWhhIjXWcjrlxauaElZMZHaNF0P29m0?=
 =?us-ascii?Q?7qz1i1G1GvM6AqrrWEyEGw1Zi5G33NlKfO17hbx5Pfx0PYr41iaO4KvW6Ck9?=
 =?us-ascii?Q?XOEbzDIB+W1KzraOLDb6Jen6qWZ79JMNKBlDwJZEhj/6k7dOF+H6UhIJOj4W?=
 =?us-ascii?Q?xAL7lLfiu8FtZK6VezA4tXwcCFeae9aERjJZXJjUdkiRiL73U/kUfcZPllb9?=
 =?us-ascii?Q?kUY3HPAg9+ewDhmj0awmeg0NhzIDBp9Zeoc8yqmqkC4X8VDyu1nzufl5ltm/?=
 =?us-ascii?Q?kF8UZxmBb6loI7B2baykumChPlfGxFyMQXfJWe2g0zi00/jxxTWJSR6nOPCF?=
 =?us-ascii?Q?/WCkwpppzZ7fYgCQlsB4jEmkvFfiorFKd3PbQ8AGJiWdmVnMg909gAY7P1sK?=
 =?us-ascii?Q?LjiPJVHIuVuKzKcIEzQ0fP/RjYsTOmHesyTG3OMw9LW8g18LnBDB0kYdjz06?=
 =?us-ascii?Q?r1MQceR5H0gedOTKTNYrIO2mAk+SB45xJHF2NhY1lBoeouHbSDz+qJWLh8r7?=
 =?us-ascii?Q?AfI4kPuKjV2aPLzXJ1b7UBkg6RlrPtJ6Pg60whSeOK2FIdHmUIKAlnf36jQL?=
 =?us-ascii?Q?ndPRxHex1QxyNZANejVYatAqesuVrNQiBdpRD6B92ns14YnwXeoCTVSKZ+nE?=
 =?us-ascii?Q?4V94OHZZ5a2JDGr9hKzjHuWBKksN1S2VgeaJjHC8VFL4VxLAJEJyoynwcf9O?=
 =?us-ascii?Q?jqpsuUZfa5B3wOy6plQhasT5G7X72nAMuupCZERhGPYm+pp3c78n+93VI++H?=
 =?us-ascii?Q?OZ8Fo5IzLGGjKqRlihN14ETQbYnerhkq26n2A/65sR1qJul3L7SOYFuUmlqo?=
 =?us-ascii?Q?KiDn66R0qZpsIvda96WgEjsCD5wBfLVNWinQItTz8T9C64TavMXrSRIRO531?=
 =?us-ascii?Q?IXVuXdclIh0D74otKXdtOZyqxrnGTSQdvMjVzybMA2KNDYstMXjBEYzsyWgx?=
 =?us-ascii?Q?jPorZJsuCoVUKCwdfNN9MpqevMSK0gkKs90nE8FsaQLb+TM286lK09DKurVO?=
 =?us-ascii?Q?3y75T+l262DpSx4Rmy4FMV9cCzEBwFfVf2JjBVWX9lougvXiHDD9TBO0vMhk?=
 =?us-ascii?Q?xTxyMkRMF0gF4i1Epw2TDo+NB+9YR89yER6Ubo4oCelqGoPG8FFDWeu8p2r7?=
 =?us-ascii?Q?z11Z4qwqKY7sh2DXILl8HlXbAIryw1luzGktl9k4P/ujlr+I7+N9fBN5r+Uq?=
 =?us-ascii?Q?0m7oHISP5ModPrJHPf1gTgXrU7w7PDjtG6XD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:54:59.7450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d813fbbf-011f-467f-fe45-08ddc44ed3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585
Received-SPF: permerror client-ip=2a01:111:f403:2418::614;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

The gem_init_register_masks function was called at init time but it
relies on the num-priority-queues property. Call it at realize time
instead.

Fixes: 4c70e32f05f ("net: cadence_gem: Define access permission for interrupt registers")
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 50025d5a6f2..44446666deb 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1754,10 +1754,11 @@ static void gem_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < s->num_priority_queues; ++i) {
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
 
+    gem_init_register_masks(s);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
                           &dev->mem_reentrancy_guard, s);
@@ -1774,11 +1775,10 @@ static void gem_init(Object *obj)
     CadenceGEMState *s = CADENCE_GEM(obj);
     DeviceState *dev = DEVICE(obj);
 
     DB_PRINT("\n");
 
-    gem_init_register_masks(s);
     memory_region_init_io(&s->iomem, OBJECT(s), &gem_ops, s,
                           "enet", sizeof(s->regs));
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
-- 
2.50.0


