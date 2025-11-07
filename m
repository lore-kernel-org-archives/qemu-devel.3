Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C443ECCFA1A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdk-000083-R3; Fri, 07 Nov 2025 05:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdi-00007X-No; Fri, 07 Nov 2025 05:24:18 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdh-0001Mc-6j; Fri, 07 Nov 2025 05:24:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBC95J1YR3J9LUvuFhKp5lscQjUfwXd4ZWmtMhyqK/WQfl/8Dthcv5MUmaw/yQukCOnn1ybTXNhuUByEOczjfaiLSk+1ZqnjwCyfM7HUWoHoWk8AMHxvhoUU0MSz6vW2c3ZZENNr4efiSgrHdRLzEvAH8GJoW8RZ3CF6+SHiXle5MBga+bUFNNMiQi9eL8ANB5NQURGcbU+R/KgLpgeV1isVUoGXJJAXzG5KbHootYfF3mlOsdrE38kV9eemXuBd7asVIQiCgFabNGb10Oy9CK9YSLtsDZoXZV0AG9yz6J2z8itHORBd2abgDyCOU4X/ZTOCWr6jJK9nB+SUOOo14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSv5QKFD3tWmtdSGCj7BNqUyO4ztu/VTThNVj+AHFv8=;
 b=D3z1zgOecySJ74JI1AoZHWP7eqsbr5fH0di4JyQSM7LDUrI8IIL2DDZqDrO5f7XThlO5l9clVuKsxBMRj4c6wfbZk+YC0wIdWcUvpWUauHSRN2dUct2HXs76lT2xEqDlniCjiryH/HKozS2V2yJey+MWBf6WNSXZ3FouGufcrmujA+36wPGFDA6TdN6TCRwd1JrURCKhx/nEn7TY8E3Kk7A6WwBxQ9ivDF+aIf0ozluxfiPqAz02RmPTUlLdH1BuNnlnqFDDEj89sjAWcq0CAKrJzyigCXH8lN2Mvk70YLPGkbQy0UY0MsPSLCnefoWzEtEC4mIxi5L3lGeW7XUTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSv5QKFD3tWmtdSGCj7BNqUyO4ztu/VTThNVj+AHFv8=;
 b=ujsKGKmThlKH17V/HTrw0gLCsJx2bMeuZUdNgLXqAS54nXs8FPXVI5ZAtK/CgSVouvsWv4WVgtY6SeFjZe1KlTxi6joy5jFQf+LrMgxs2MLpJJ71EHaD5loPlHneNubwIc8O5WTKZDllVSYSGGMTSOGXFUDD3pUtHSiOpO7eDQI=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:24:11 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::bb) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:24:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:24:10 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:24:10 -0600
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:24:09 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 9/9] hw/intc/riscv_aclint: implement the
 register_time_change_notifier method
Date: Fri, 7 Nov 2025 11:23:35 +0100
Message-ID: <20251107102340.471141-10-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 34449fde-d246-4ec6-713d-08de1de7cb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wcg3pZPJeoI3lm8Mj2ph3bJ8b+gxNloPsrvU/QBEUiCmWR9s9DgvV0N6eOLq?=
 =?us-ascii?Q?CBHW1k5YzWVmH3QCtM39AERkDb8rXsWuU0uhPIuyeLgMewebvBd8L90xAS4N?=
 =?us-ascii?Q?oPzRVJcuocTS9PpVOe7Md8AKFnxuhyMq2Taw3rLv9ixyRFJPLl9ZbH0cZEPh?=
 =?us-ascii?Q?RcdFQ9bwfC4qufoJV8CTs40NwlbYk2cKIoszwVD1LCG0TwGGFJFAPq7wGnlq?=
 =?us-ascii?Q?adIntn9jSs2e1dpCv7MYJmcvD/9XlgWZGnuMeUAEqzCGILW5RzqnfdGMQ35A?=
 =?us-ascii?Q?jBqTv3L7bkMmb8Oac52Duupn00fmlBV7Y5CJUWrlBTFdimDiZ3hPVlD6Chhd?=
 =?us-ascii?Q?ihlHICHQKystHoJSlwW8RQ0ZcJTxg3dBKx0WueMmZEdVE2/NAreAJVRIJjSW?=
 =?us-ascii?Q?qbgmc/2RFx064/O5FQVoIbam1cFuK5DXz44djp9bmiKm1PkqLke/eN7F/kSX?=
 =?us-ascii?Q?9y8EkWHMNoTUnCd56Yfi17AhpMY1G9/8HrftSn4SWRI+F4ZseP4r46TJ4RNi?=
 =?us-ascii?Q?dlw/02Ucpao7/AVy8TsCjECXUbn4GLcs5GrnUxoGqFEKVNLrLZlBv4cvRoPp?=
 =?us-ascii?Q?r+GJN5e323UYVyOPwtmCPUB1gEZD0AEuaSoAQ8xvjtHQ88hRAny6I+dbaRO4?=
 =?us-ascii?Q?nIrz6csoqL990hIiKAIYhFTRka8v7V9fVpe0pMzJd/wsZenBZnOXzTnCk+z0?=
 =?us-ascii?Q?X1WcJdSnrvq66kvR0EaAGNdIRgpwQ9yYJK1LINcyaBCmL3CvhyGdYMQJexba?=
 =?us-ascii?Q?wxOdG6PKazN+PJSPr4WCU140baUMc46GVpZgEFL/+DxvS9SWFK4HOAR0UvWv?=
 =?us-ascii?Q?Xn8cj3KlhlUwwfJ0IBz9Vk5zftZYcSyXm0ARWJijub7g3kNvc7Gp1OlvYi7e?=
 =?us-ascii?Q?BzhLn2poJ1gtke24BwCRSysJd3KOWZqWdw1bFrWpTLew7T31uAlMJnYKgZzK?=
 =?us-ascii?Q?daJgkUYWrAsLq/FmMz9Cu3927xcwTETjV04CIoxhJw3BDBFRi2SvOmgiwyMS?=
 =?us-ascii?Q?PG9vG6qtfdM/7u8TiuB5Jvo/Aid7TfyGv5rcL4Qj+OP5KYFKnYTXDumKo86F?=
 =?us-ascii?Q?65nGAjr/GRuJYO5reBpUSX6VWMc3+h+Xc1herdhQFSjwoTXJkxqzWJ/IwYGE?=
 =?us-ascii?Q?lbQ7Vgn5G6AqUdTpR+K0Egok8mu7VrDB0lX9VNSx5ufpgsunFzUpmgg3PsIy?=
 =?us-ascii?Q?Wo6TCjef8HKmuhu5hTuLJJEXY/mV0CxcUskaSDPor0o5jL0Swr4bSmDRl/I1?=
 =?us-ascii?Q?l9uO+Z83QgoXyBQvYiahH6HBslmTHwVX8JCLo+s2mmeIr/VOMIKHhGxxmaaz?=
 =?us-ascii?Q?XQ/i2HF32eJSSOexNqbhG+lFf2wTpw7jJSja7u3mMOwSuSgMma9MH0LryXjx?=
 =?us-ascii?Q?WAB67eEbw9PsK/sctXNalIEj4K+dhb4D4sHH/EIm0M2nN8flBz9OgbTpweW+?=
 =?us-ascii?Q?GfMhOnFW/jWnlOKHrSo8mhh9DMcOC05tJxfiBr1PaETo2dobp931diuC7Lqs?=
 =?us-ascii?Q?DQ6dJ/ddyNUi4l3i4qZ3X1kKAF16/5Qh+hWwPcEScHJvuu6FESRgK1/2Dj8F?=
 =?us-ascii?Q?QuYHZ14VaCprVVDNy1w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:24:11.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34449fde-d246-4ec6-713d-08de1de7cb1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

Implement the register_time_change_notifier method of the
RISCVCPUTimeSrcIf interface in the ACLINT. Keep a notifier list and
notify it upon `time' register modification. This effectively replaces
the explicit calls to the internal riscv_timer_write_timecmp CPU
functions as this is now done by the corresponding CPU notifier.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/intc/riscv_aclint.h |  1 +
 hw/intc/riscv_aclint.c         | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 4b7406eec00..3451aa1786b 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -32,10 +32,11 @@ typedef struct RISCVAclintMTimerState {
     /*< private >*/
     SysBusDevice parent_obj;
     uint64_t time_delta;
     uint64_t *timecmp;
     QEMUTimer **timers;
+    NotifierList time_change_notifiers;
 
     /*< public >*/
     MemoryRegion mmio;
     uint32_t hartid_base;
     uint32_t num_harts;
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 014b733d72f..f5e120cc853 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -26,11 +26,10 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
-#include "target/riscv/time_helper.h"
 #include "hw/qdev-properties.h"
 #include "hw/intc/riscv_aclint.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
@@ -239,15 +238,13 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
                 continue;
             }
             riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
                                               mtimer->hartid_base + i,
                                               mtimer->timecmp[i]);
-            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
-            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
-                                      env->htimedelta, MIP_VSTIP);
-
         }
+
+        notifier_list_notify(&mtimer->time_change_notifiers, NULL);
         return;
     }
 
     qemu_log_mask(LOG_UNIMP,
                   "aclint-mtimer: invalid write: %08x", (uint32_t)addr);
@@ -284,10 +281,11 @@ static const Property riscv_aclint_mtimer_properties[] = {
 static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
 {
     RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
     int i;
 
+    notifier_list_init(&s->time_change_notifiers);
     memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_aclint_mtimer_ops,
                           s, TYPE_RISCV_ACLINT_MTIMER, s->aperture_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 
     s->timer_irqs = g_new(qemu_irq, s->num_harts);
@@ -338,10 +336,17 @@ static uint32_t riscv_aclint_mtimer_time_src_get_tick_freq(RISCVCPUTimeSrcIf *if
     RISCVAclintMTimerState *mtimer = RISCV_ACLINT_MTIMER(iface);
 
     return mtimer->timebase_freq;
 }
 
+static void mtimer_time_src_register_change_notifier(RISCVCPUTimeSrcIf *iface,
+                                                     Notifier *notifier)
+{
+    RISCVAclintMTimerState *mtimer = RISCV_ACLINT_MTIMER(iface);
+
+    notifier_list_add(&mtimer->time_change_notifiers, notifier);
+}
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
     .version_id = 3,
     .minimum_version_id = 3,
@@ -366,10 +371,11 @@ static void riscv_aclint_mtimer_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, riscv_aclint_mtimer_properties);
     rc->phases.enter = riscv_aclint_mtimer_reset_enter;
     dc->vmsd = &vmstate_riscv_mtimer;
     rctsc->get_ticks = riscv_aclint_mtimer_time_src_get_ticks;
     rctsc->get_tick_freq = riscv_aclint_mtimer_time_src_get_tick_freq;
+    rctsc->register_time_change_notifier = mtimer_time_src_register_change_notifier;
 }
 
 static const TypeInfo riscv_aclint_mtimer_info = {
     .name          = TYPE_RISCV_ACLINT_MTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
-- 
2.51.0


