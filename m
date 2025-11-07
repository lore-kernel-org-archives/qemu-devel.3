Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FEBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdg-00006L-Ud; Fri, 07 Nov 2025 05:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJde-00005D-QR; Fri, 07 Nov 2025 05:24:14 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdd-00016z-0n; Fri, 07 Nov 2025 05:24:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee/Oi4yhMyHGcD7G2Rkz4uXyw8Z+elhSigDlr/CZybuo8V4ihN2pFwEtw8edKDnP7JW4dJKiOqFu8n+olGxv7RdhArl4s4nBcFwpfaAxqQ++sFxsc7Z6noYVuxrlt7XTdZ793caegrsjPwCzP/fQkRdqSr3Tp6Fr04P25LHCSvEZ1g9JZYcWm2r/96KX/cmY3dICJOGwafdy1bDAKSEJvT0xpRCqFz1gL+WAy+8jUds1ZLVMUnzER+h/aAhp5Q5liXRrflC8z2GaxEJCbxN+KK0Dc+t3LADpbkN9ISi97giqzceVA738f5+gQ1nPHOkLSpXtOqdJHq6mfR2no4qpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGgnVJVM/3ggrCB4lMW1V1MAgwQpjDnVbokLnX6PbBM=;
 b=PjDhpkjwIeriT+LRQboytqwkV0xUIefIKl53vV+s+YN/T/v/B3ijFiUvA1km0gPOb0cdtORELihwBJL5/qqFnNEkyE8GQ6C+hKMfstZ+x1WOv6v4OyVH3SxLaHhCZgvyA2IYWQK4zAQewo3qrqdddokwl0Eo+zbG0XzG3ohxO95NZY8fepSgh4Lc4ZmwT5ntnrl2Wtjw+J+ox/WqYfM9nK5yArTdny3MHUYA/il8b0ieLGk9J0k46jfMpg6aDeyNdZfpHUtgDvbA7o8K7EweC5CGMZWBDji1Kskk4bFZN6Bi1Cl8h37pjjA5/yb1n9sWIHlKXKZkfw+Q1MiEDDfqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGgnVJVM/3ggrCB4lMW1V1MAgwQpjDnVbokLnX6PbBM=;
 b=3vUktBq5R4EboBKtS9cqtQ3lO/T5yVVzK6cmrpzKAvMFHXgnH0h/RPgRbd330RhXcXNecxaVoeqyzTz59xkfOnbgPuiYFpJkcajifGOG1TJnVdvtMjui2ghgyEuQ70DnkhIACnR8BZG1rMo8fje49EJiW4JOwVailM20qgXeP3o=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:24:07 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::bb) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:03 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:03 -0800
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:02 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 5/9] hw/intc/riscv_aclint: implement the RISCVCPUTimeSrcIf
 interface
Date: Fri, 7 Nov 2025 11:23:31 +0100
Message-ID: <20251107102340.471141-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 858c131c-578b-41eb-f637-08de1de7c885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ilmyo23RGk7yKFTXa346bNeWjwYozpZDCIDHqXdghKW2u5e0kBp74L4W8jSU?=
 =?us-ascii?Q?uWm9Pz8nOP6V7sfyrZ07/riknKw6OcHXIg6296ncndDwREVwE8lDYR96nOfJ?=
 =?us-ascii?Q?IvVfhAbxbqP5alSd1iH4ZrkPK0GM/Urpd9oWSa8uNJzvNHCBV6BmsdLD4Uv+?=
 =?us-ascii?Q?d8rKc/sv0KvXbdfiSFoKDPe5AoOS/1uaqJygaZYkBpugnzm39jEU4lIaNsvc?=
 =?us-ascii?Q?FGL7CWI60vJjiJJ3ISK1qNJmgIiv9Rad8UrIChrWe2NRvqMlB0NQQAOUqeya?=
 =?us-ascii?Q?BqeA92Ot0s6+fC1I2Xz/134hmvMa/Di4dN0zU5CgHO3PYZn2zfmJq778SxbV?=
 =?us-ascii?Q?wY8nWULvrLx85tFqZJ7/iYNqijtb+vwajsH8TJ6euM0OnEsmu4i+ThGoasow?=
 =?us-ascii?Q?jRtHeBdBgzoyRllyP6Kxa/dfNTsBSMKh+QXzGcJXbjss6ovbVmIgs8k1R1Ew?=
 =?us-ascii?Q?VVxpUnMUsq8ZFOB0Z20drj3ddcIVgl694TR47YvyrHG88gKQdgjMjmGFg6eA?=
 =?us-ascii?Q?jPuMNildH6XZlyEPjHlGoz2rR9qmpRjnvJdp8yHxd5DH1KFVVi44B7zo/UDy?=
 =?us-ascii?Q?vFHj2GaGDijJAarhSraOgnAPEI6rAtVl89yxzAChhvsuRJEw5Fms1swtfN1I?=
 =?us-ascii?Q?7+h89mKfDpM3EWIE51V9QWxvqcbQmtRFP7E4pg0JaOXuNXVu8NKTbyrmWvgf?=
 =?us-ascii?Q?sS+/BasdFJGzf4scsohpPD/U/K83zwmyX2yzSWZY4yKz5q9O4Fmjnt/WWOPq?=
 =?us-ascii?Q?AuwPJv7QvVU4zHR/fsbgRCd+WfUKN5Vw/5CsH4xIwd6ez8gv5c/Iyjtunfou?=
 =?us-ascii?Q?WeDzfGIiwcONTXltkWepjkYDuukVTHknauZ264b2KwP78MhpJ7H3/bMtlmBE?=
 =?us-ascii?Q?H2K2MSt6KjcHMM3dk2mCL9xKaGirrxIsM9i9WO4s3Xxveb0CXhskcqYr/Ey7?=
 =?us-ascii?Q?pzRoafBMasnlPFK7f1LiZfSkvhMk3i7uRSGK0hlb5oRRn2uzkS+h2zCjLOOM?=
 =?us-ascii?Q?A+8uSx92WWriD1EG3SdMETQfGP0X0n0f3/wGsMWlfdkTd53ZN9bTeLnCVl/2?=
 =?us-ascii?Q?wmPhsLKtunNhPNVYUJJC69HRXE8totEPc8uLTj/BwQzNY40UtYAtEM/XZ9QT?=
 =?us-ascii?Q?JFMWQYvtYN8qH255YYOC7SM5c82hGOaRvt/bGFgNAiMBGF/6kJ2Odr/OtcYV?=
 =?us-ascii?Q?ph0aBpbwKxQR4T2XrnMDNgDs/uoSxea/B22ej8RNZzYyu6ELyR+LT+1BggiB?=
 =?us-ascii?Q?uJrZjz2BS+29ftpgwRSVhNWMk3SUyKSSjdhgff374irO+QjDAJ4gzr/SrI2m?=
 =?us-ascii?Q?9vm1OnIgHFWME+StFrQPES4MZxG1YQR1ir02NMNUtsTKDOeuM+uslGKvHClT?=
 =?us-ascii?Q?z1ZAJ/MH48lBwMO6ocP/Ve6wpfQny3NW+TGzZpOD9tCUDyEyp5ZJw35oxG9e?=
 =?us-ascii?Q?3+bD33Bh9xDK4Y0OqJXfgHNMl5ZKv4cYc/5RUVuNAjytTlcZNSKBzA7Iib0+?=
 =?us-ascii?Q?w1jWU/Q9l3hR4f6kcEoVueaM7WrI9Fiqx3iDdh8RLVvRW1HOwyrds/RJiBvX?=
 =?us-ascii?Q?FSAOrcOlOQl/9NPRaiM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:07.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858c131c-578b-41eb-f637-08de1de7c885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Luc.Michel@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the RISCVCPUTimeSrcIf QOM interface in the ACLINT mtimer device
model.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/intc/riscv_aclint.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 95398e48821..4a4449d9d2f 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -325,10 +325,25 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
      * Pending mtime interrupts will also be cleared at the same time.
      */
     riscv_aclint_mtimer_write(mtimer, mtimer->time_base, 0, 8);
 }
 
+static uint64_t riscv_aclint_mtimer_time_src_get_ticks(RISCVCPUTimeSrcIf *iface)
+{
+    RISCVAclintMTimerState *mtimer = RISCV_ACLINT_MTIMER(iface);
+
+    return riscv_aclint_mtimer_get_ticks(mtimer);
+}
+
+static uint32_t riscv_aclint_mtimer_time_src_get_tick_freq(RISCVCPUTimeSrcIf *iface)
+{
+    RISCVAclintMTimerState *mtimer = RISCV_ACLINT_MTIMER(iface);
+
+    return mtimer->timebase_freq;
+}
+
+
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
     .version_id = 3,
     .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
@@ -344,22 +359,29 @@ static const VMStateDescription vmstate_riscv_mtimer = {
 
 static void riscv_aclint_mtimer_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_CLASS(klass);
 
     dc->realize = riscv_aclint_mtimer_realize;
     device_class_set_props(dc, riscv_aclint_mtimer_properties);
     rc->phases.enter = riscv_aclint_mtimer_reset_enter;
     dc->vmsd = &vmstate_riscv_mtimer;
+    rctsc->get_ticks = riscv_aclint_mtimer_time_src_get_ticks;
+    rctsc->get_tick_freq = riscv_aclint_mtimer_time_src_get_tick_freq;
 }
 
 static const TypeInfo riscv_aclint_mtimer_info = {
     .name          = TYPE_RISCV_ACLINT_MTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RISCVAclintMTimerState),
     .class_init    = riscv_aclint_mtimer_class_init,
+    .interfaces    = (const InterfaceInfo []) {
+        { TYPE_RISCV_CPU_TIME_SRC_IF },
+        { },
+    },
 };
 
 /*
  * Create ACLINT MTIMER device.
  */
-- 
2.51.0


