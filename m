Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C51CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0cW-0006AY-Ek; Fri, 12 Sep 2025 06:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cQ-0005s8-Ib; Fri, 12 Sep 2025 06:03:03 -0400
Received: from mail-dm6nam04on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2409::62e]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cL-0001IL-N9; Fri, 12 Sep 2025 06:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb7KD31fl0ZN1JQYFoVPrYSLgUqzLnWs+HiRYwIwDB8s+UNFmW96wm9FDUDYHBZjXkoEvjCz8gt040/nuoemayW4SWhM5e2NSZHv1TuKuBZJS+Lsarj4uJX7Q9GtNGmXRo3EhcRDeQYMJmfFlRrsAuLQQGQDMst8QaGMKdA6sfbHHsQQQNZ1O+R4cBvoTsICGCa1T156HcB2nfyZeRIusb5LeGkkRwwmL7t7BuShYQmX6Vh82cpbLnVUj273D9fsN2FdCrGSRrpRWyjhG2XpHjrXyT+LcXdGM7SI9UPzyKJxzf2dFM3mkLIqPsILbQgbapYbFsQf/JnUbdB2AABeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw8nG9vMwM7PfM3ofoe5KOFyd++8YGJnSVhvg6gjOHI=;
 b=N9WKgE9x6/ITSxKnLuSDMDl9t15tCbbw2EmyyXOHbsWQp31ygoVsFRFztGkYEluFT3Xr/O5ydRQlxzHhshzreFdZtK9DKhvsL9HMW9PDUZt6NueYgon+CjqdIQuAqKzHEeDUGB7uU5yg9n/hNwG0kqAptJGlN5nOpk8A9A4UShF5HiCmCbBjyZAL8jWbALQPpeOdqdPcx/6bnsy0hot/4DGTvzWDHlnHEMdh0JpywOeA3g7VYdO5srHBmtvMgbRraoKvXNbeYI4xM27wIHaim+RtNEs9hyqxaEfSAjv8DJf1hgpIvnUdwTiXHBf9nZHYDDRsLFkwACSFfKu2upuWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw8nG9vMwM7PfM3ofoe5KOFyd++8YGJnSVhvg6gjOHI=;
 b=mvev3F2uFUfZhpCaXXqkMe9Xj4S3Hgq5WheEEUfzrc7sjZ6d3y4A++++NgtY1WCbfQZKY7D56Pwrd73njhN7si+m7klBZG/6zL/Z454m3XRQ4BuIUzih+vMVGp1whQID+RA9SKHosezl3CNtHUBi4jvVqs0nwLe8uCzVLVanuZo=
Received: from DM6PR14CA0072.namprd14.prod.outlook.com (2603:10b6:5:18f::49)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::8c) by DM6PR14CA0072.outlook.office365.com
 (2603:10b6:5:18f::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:43 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:01:43 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:41 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 12/47] hw/arm/xlnx-versal: VersalMap: add support for OR'ed
 IRQs
Date: Fri, 12 Sep 2025 12:00:21 +0200
Message-ID: <20250912100059.103997-13-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4b1a61-5183-4724-d823-08ddf1e38994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTd6QXBqZ0xvSFp1VGgvQkN0TmZMU3JvMm40YWYrSUo4N0NxRVZxWjBHTHFZ?=
 =?utf-8?B?MUhuWjhiVDVQZ2J3VmRKOUQ3aG0ySUYyMGhYcmk0VGwzMTBBR2cra2hkb1Nj?=
 =?utf-8?B?SktMa3JrbjJadjJLeTRrNlJ4dVlXMnM5UXJPS0xaaVhTK1B6eHhGZmZNVWRl?=
 =?utf-8?B?akM2R1hJWHhyMElwZFJGcUtRQUN0RkMzRTdBS21yTEwyMlMvdHJ2ZTFpSzhU?=
 =?utf-8?B?a2FQNFJvWkhYaUx5cWxaWHd1dlZCQnZEUWFjblhEYnVwQjBsVjNaQ3ZFR242?=
 =?utf-8?B?NndrODB5TlNZSjJ3MHlBVGJpQ2VrakRZQ1N1L1pRbHhvMUlzdWxDOWIxTUo1?=
 =?utf-8?B?dkV2NjRUMi9LOG45NkJTV0pyTmQ5SHBvbTFRaDAwNzAwK01OcnduRXk0V0J3?=
 =?utf-8?B?VDE5ZUZYYXhsMTRqclArZ1cyR0JwTTJoZnlPdEpnbmdMVzdtK0hZMFpveWhx?=
 =?utf-8?B?RFI3S0VaS3VIRjlLaTVWdnVsV3FJNCtLdm9JaGNSRFhBUjA1RVFYU3FxeWZs?=
 =?utf-8?B?Y205YzByd0lBWFRieEZLK1BIK1liQlRybW1MYldVY1NLWEdHODllK0I5b1ky?=
 =?utf-8?B?QldOaUlhOVFxdWk5ODI4enMxa1JHdG53UXR4bnFDQldOK2NaaFFsK1NKN1BS?=
 =?utf-8?B?ZWlvV3paU3R3S3pOU1F0L0xEMm5LUVZwNlFwVlg2SXhMUjNrVkJVaDFpL2xi?=
 =?utf-8?B?SGU4N0d2N1hKUW5scit6ZjZaaVFGR08wN0ppaWtpM0QvMzdwbUZhQ3NkSDFF?=
 =?utf-8?B?Y3p1K0NNbDBpT2Y1TUZZUTdWYmtDTC80cWZmd1pYcjJDVHc4YnBvSDJUd1RN?=
 =?utf-8?B?VXVYdmRUalg1LzVvV3hLaE5ta0ZUYzJwaHZBY3NOSkdrUTF6am40eXliMWp2?=
 =?utf-8?B?ZW03VUlUdS9NOWhwR1k2d0ovT1ZBVkxDajEzUTc2SnVaU3BtUUptSUJVUDlv?=
 =?utf-8?B?RlBGV0ZQMjhaSi91THJ6V3RMR0QweU5sYUh6c3Y4ZEg3eDh5ZU5acDRYbGti?=
 =?utf-8?B?UGYvamlqVFNyYmlTNmwzemJTck9ra3pnM01pbmRTcEZ6S29hMW5Hcld5RGVR?=
 =?utf-8?B?bEZ4d2dHNFJaU09uTW8wTC8xQnY5MWJMVGxVUk1VWitXeTVoSFFZOGZKOFNE?=
 =?utf-8?B?cmlSNS9yWGYwakFqOEZIUS8wVzMvUXFVMjZtRkNpbWdJRE83dFArSlRVRDZG?=
 =?utf-8?B?VHUxSG1McEI0NGlHbkFTcnlZb2RGNmsxNnZpN2xYNXNudkUyYXExQ1dhVDcz?=
 =?utf-8?B?TkZEY0YxRUJnY3daNHpvQW12WVVySmtSdWgvUFhCRzFzSWJwblkxVjRQSnRl?=
 =?utf-8?B?ZlMwQVptYmZab3FDZndzTUdRRTFwRlBSM2NINGV3YjJTenlRRUNnclM5Ulla?=
 =?utf-8?B?dVl4WU9iaXpSMWFpRWV1UCtWeWliR1lEUWVsUGR6T3JqMlVGZlYxYzhsK3Ay?=
 =?utf-8?B?WG4xRTQ4SU14YUFlWDRIZHU2Vmg5eXQ0aFhOMDQ3YWY4T0p2eXJVc2xyb2JQ?=
 =?utf-8?B?U1ZoZUt5Qmsxc3lySElVc0xmRFU0bUpFV0ttT3BkeVVpNXF4S082V1Njdlc4?=
 =?utf-8?B?NklwWFdtcklnU1RGOFp5V1VJdnF0SEkzMm5tV1JPZ1htY1JLRkU3ZHM4VkJo?=
 =?utf-8?B?WDJraVJFSkMrckRTKzJTc1Q5cnJ1cTdaTmw1RlVJZTlIUnBqTDZodEp5MWpy?=
 =?utf-8?B?N1JQV3picFZEdFd2TkxIdUdQeWJTYlhiTTVHOXJJUjM3NHpsRjJLWU15YVRa?=
 =?utf-8?B?K1pYSVFmMmxBYko2WUNtTVF4cWQvMVVFbFFLZ1Q5SE9ERVByenR3Zk5idkY4?=
 =?utf-8?B?TElabWw2NS92TlM2cmNhYnhBT1kzNlMxaXp6MmgwMW44WUxOeHFEQ3NMZFU0?=
 =?utf-8?B?UzR5WVQrdHMzbTdJQy8zZXQ3RGJ3UDN0M1pTWEtaajFKOG12NVRFWW9ueDI2?=
 =?utf-8?B?TEh5WFRUaHg1RHJUKy8zTGI0Zk01SlVLaWNLOU5wL3JUYnFWdDFnajNjdTl2?=
 =?utf-8?B?YkRiemZjRTZrc0hzSmdveWFpL2xsUXN4TzhNQ1QreEJVUHdnUERHQmFWNWtj?=
 =?utf-8?Q?JyV7iq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:52.3784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4b1a61-5183-4724-d823-08ddf1e38994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
Received-SPF: permerror client-ip=2a01:111:f403:2409::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
---
 hw/arm/xlnx-versal.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4a70cb79bf9..ab769f66a72 100644
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
@@ -1215,10 +1270,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
         int fdt_size;
@@ -1229,10 +1285,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
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
2.50.1


