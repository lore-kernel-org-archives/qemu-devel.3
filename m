Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22a4-0006M1-Vs; Fri, 26 Sep 2025 03:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zt-0006HX-SC; Fri, 26 Sep 2025 03:09:14 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zf-0006aM-I4; Fri, 26 Sep 2025 03:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJHYhoey1ibv0WnIFXdf+F9wp6J4vDKyefnN4AP8Vj6CEaaSTNgP0ziafMlumCzI07qwlAUMDerV62THxFIhRjdwlMDZRczfuXnjfQeK81WHn6+sZNajWTkBId2m0HVyuHBS284QdRWZGTl+tKCo+/Zlbqdn/0SoDIbUrR0B27pKHYaceYibuxgrLNUmfjMQxghfZGh4Yv2HmlZKVzClZhNfbIwk6Apfoteq3Jm7cJYYcwA/aPzyqltDIsySyUkD6xUbe+Xp1lNhIGH2Mw82g46laYJ1KIWdcnhJgsUDkG8MSKNHj6Px9BhKmZim3mzYQyBmg0a3VAeZoRMd+JhfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1k45OdUIesKxxDbBxCwrh3YJLQeC/2kc+q1VWUhh2Y=;
 b=NnSxXoyFI1Xi32UYMmS5Pxwrz3g8DXKW8Lio4yIG0ofb62tFa77WlhBG8vCfAF1H5X7pJW3zQzgoR0VVm8yFut/PIxB6lEqCLjoeh9uZafKHHQdNOeuVXXAu3f233EIXVuCkLQ/XrFPhcptWHh1KQcePv2I2pJpUeOkGN33NCSfbh5b54FdQaPexPcl3Q4aX/wLLQhaDgPeqDHFDYhmXrAgpw7Ie6qPVs5j0sck4fb6iJ5xlNKJ5Gqb4v0VlsT5fmas55mSr8Ck6J19qWvi/Jb+owT+IBJiaV0enY45U4J+GUXNugnfwyDupSWw8ksYK8Z2EDTXlMDmxyGGhz7DvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1k45OdUIesKxxDbBxCwrh3YJLQeC/2kc+q1VWUhh2Y=;
 b=j24JXydTUFTi5w6FdqdxEgan9MjQCSZgZX9r+0uBh7Fv8LzXozZa6ZOG+IIiz/4X5MznJyK1UIsRtGZ4uhmX8A/bbdKgg5Qt6C+mGQwt2KANEb3AOREMJSgKwTPkGZv8TfuPRKOiypxA4S9zuWFlnixvCYcXTg9yYFIZIdgq13s=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 07:08:49 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::4a) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Fri,
 26 Sep 2025 07:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:35 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:33 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 12/47] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Fri, 26 Sep 2025 09:07:30 +0200
Message-ID: <20250926070806.292065-13-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2e638f-c50f-49cd-4260-08ddfccb8a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmljRFIyLzlGNFN6ZEovOUE5SVJXcTQ1R0ZOY2NkeElsL1o3bUx0QkZLS083?=
 =?utf-8?B?L2wzTm9vWlFRNzlNemVPVUZudEN5VGV5Y0lmVExZQjlidWs0N0FhZWx0bitJ?=
 =?utf-8?B?RmNkdzh2Wnc1MkpVS0RGVXdZa04wdWIzS1lxaXpiWlp3ZUlBQ2pEQTQyd2lm?=
 =?utf-8?B?bTVqcDZNNUJtaG9sY2k5OEFhdDdQdHhhL2NwOElJb1d4cEVGNkNNTFJxRTJW?=
 =?utf-8?B?bEVhRkZZYUt5NzlHVFNQelhxWTB5V1E5WW8vYWRwSnRrdjJXdnBFWTF5UEMr?=
 =?utf-8?B?bVROQ00zeU9SZ0VNa3VFa0svb2dVMHdVU0xzTjFKNWtESUt5UTZHaTY3aDN0?=
 =?utf-8?B?aXEwbDdpTW1QYWtBdjRhUXVWS2Y3RVZ4djU3N0x3UmM3Ym5LRjhWRUxGQ29U?=
 =?utf-8?B?d0x1Vnd4dUcxaFBDR1huaHA5VFFGLzZNbU5HUmt1VGRPR2RYMnN5MnUwRkwv?=
 =?utf-8?B?ODBJVTJnZUJpMmJoTnQ2MCtjbm5sNVZrOXpSSkhITDhobmkrdFdJMXFMU0N2?=
 =?utf-8?B?S2thUEREaloyUXFpSUxTcjhUVnJvVjlJQjNBay93VGxjTTBnNDg4R0xUNFZw?=
 =?utf-8?B?NDNDc282QlEraTMwYkg4WW9XZlIxQ2w5S3ZJQ0JBU3MrTmpUVTJYN1ZBSTB3?=
 =?utf-8?B?QUZFdWd1OEFDVUNkUWgwNW5QWmdCN0dzYWI0bVZuRHhZNjFwUVZDS1FFc3o4?=
 =?utf-8?B?YmZjVVVWNzR3cDlOSGJOSE9UUUxGTjM1R1doOU9WSE5KTC95d2U5aWs4Q0Ja?=
 =?utf-8?B?VHYyZ3RtNHUvdWhxMk9Xc2hxS29haVlyMnNrcFFTajFsT3B2T3pWZDJKM3ZT?=
 =?utf-8?B?ejJ6dHRqUmcxK2QrUVA2WERqbkhaTEdMSnlCbVBYWE1mZHRFVHhaRkl0djVU?=
 =?utf-8?B?c0ZCT1JORXEwdWNXMHY4cUxhd3JCRWs0QjNrVlpOV3FMNU5FWWJTejZKUUNH?=
 =?utf-8?B?UWtaanNlZDNzUDFuakN6M2JRQmdKQVdnQUsyV09GOXlOT3RITHR6bnRNTWFx?=
 =?utf-8?B?cVZ5L21mdkFvK2kzOUI2bmQzTllTQ0xMSHFGem5jc3Q1Z0x6VndlREhZODlI?=
 =?utf-8?B?WmhBanBaN056TnNhRVRXb3labEdRazg5ZVAxdUVod2o4azYxdjNRSjhDSCtY?=
 =?utf-8?B?RTdCbWhMWGVreEJKZGZIYjYxNnFTb2dEb0tnQnZDTThESVM0T2tsclc0aVMy?=
 =?utf-8?B?USt4bE9QNFhHSHAwM3BHeVFwOEtWMDdMT1p1eHBzZnBjOHF2c1VHUnV4clY1?=
 =?utf-8?B?a1VmOFk2R3JVZUc3Qk9HU3N2dktRYWc5ZGhha0FsSGtGV0laNzIxSG90OFZa?=
 =?utf-8?B?N3VCdmRqQ2dJNjM5MXdxMXN6bGxmVnZycFgrcGZtTGJEUXFucEgvUjV4Z2NW?=
 =?utf-8?B?Mi82byt6a3YzbjlFSkZGbllWUWdnR0FaTHhNQ01zTmZzWUgwUWJZOGRRMnBG?=
 =?utf-8?B?WXBneVBiRFdvN3lGWHowNGJSTDR6b0krcGR0MTdUTkRzaVB6UlRuTlpIRVU0?=
 =?utf-8?B?c09wRDRGYkNmbjhPTU5FUG9UaHJsOWR4Y1ppTndlUFdrYytvSk9uZU42Wm9W?=
 =?utf-8?B?ZGtlY2YvYytIWnFjRDdDNE9KNVZXMHZCdzVJREc2UisvVDcxRjBIblFYQkpC?=
 =?utf-8?B?TzdtMGNnTmh2K1pUaklaeXZ1dEZhc1FFeUdDSGtub1hNVFVkblFLSDl3ZDVX?=
 =?utf-8?B?SWlXekVLR3RtT3hGb3JvQmdLU2NVekJxS0hlbVFVWmMzQzNKUCthVm9jWCt1?=
 =?utf-8?B?UU9kc29FdHVHdHdRc2VKQ2hrdlFZNGJQTnNuUjFsalhmQkV5NHhkTmtTSUE0?=
 =?utf-8?B?Z1psa09EMkE1MWdGbTFyOHcwZEVzN0wzKzkzdTJHOEFoU3hrdDhhMWorSXdE?=
 =?utf-8?B?clRwbGpzTEhMY1RBRE02MlhPQ0NnaDBIUldTOVRRbGFLVDd4R0lEV1g0MFVL?=
 =?utf-8?B?QzREa2EzUXZhSUZxc1lPcXoyWjUzRnl4YTVZQWtnRlVsZDVoQmF3NStuUEI4?=
 =?utf-8?B?RXZJMGtGL1habm82VWsrRWNCK3FiYUYrOFg0dXVYRkRYaktxM3Q3Wm0zTGI4?=
 =?utf-8?B?RW1jMUttN2xodnZFRGhvbFQ2TDd6Rks4VVhVbGVycEhPS1NETE9oVXFuWXdR?=
 =?utf-8?Q?/lYI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:48.6178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2e638f-c50f-49cd-4260-08ddfccb8a65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Luc.Michel@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Improve the IRQ index in the VersalMap structure to turn it into a
descriptor:
   - the lower 16 bits still represent the IRQ index
   - bit 18 is used to indicate a shared IRQ connected to a OR gate
   - bits 19 to 22 indicate the index on the OR gate.

This allows to share an IRQ among multiple devices. An OR gate is
created to connect the devices to the actual IRQ pin.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 964250bf151..d3a084a0639 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -41,10 +41,21 @@
 #define GEM_REVISION        0x40070106
 
 #define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
+/*
+ * IRQ descriptor to catch the following cases:
+ *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
+ */
+FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, ORED, 18, 1)
+FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
+
+#define OR_IRQ(irq, or_idx) \
+    (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
 
@@ -172,13 +183,57 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
 
     return versal_get_child(s, n);
 }
 
+/*
+ * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
+ * used to return the corresponding or gate input IRQ. The or gate is created if
+ * not already existant.
+ *
+ * Or gates are placed under the /soc/irq-or-gates QOM container.
+ */
+static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
+                                          qemu_irq target_irq)
+{
+    Object *container = versal_get_child(s, "irq-or-gates");
+    DeviceState *dev;
+    g_autofree char *name;
+    int idx, or_idx;
+
+    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+
+    name = g_strdup_printf("irq[%d]", idx);
+    dev = DEVICE(object_resolve_path_at(container, name));
+
+    if (dev == NULL) {
+        dev = qdev_new(TYPE_OR_IRQ);
+        object_property_add_child(container, name, OBJECT(dev));
+        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
+        qdev_realize_and_unref(dev, NULL, &error_abort);
+        qdev_connect_gpio_out(dev, 0, target_irq);
+    }
+
+    return qdev_get_gpio_in(dev, or_idx);
+}
+
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
-    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+    qemu_irq irq;
+    bool ored;
+
+    ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
+                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+
+    if (ored) {
+        irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
+    }
+
+    return irq;
 }
 
 static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
                                       int sbd_idx, int irq_idx)
 {
@@ -1215,20 +1270,26 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     g_assert(s->cfg.fdt != NULL);
 
     s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
     s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
+
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-or-gates", container);
+    object_unref(container);
+
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
         versal_create_uart(s, &map->uart[i], i);
     }
-- 
2.51.0


