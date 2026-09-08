Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D987CC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIE-0000M0-4z; Tue, 08 Sep 2026 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIB-0000EZ-Lt; Tue, 08 Sep 2026 06:43:07 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tI9-0006YC-88; Tue, 08 Sep 2026 06:43:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLti3/bAtaiDRQTg05epdaU57yuWAT9zL4BTU9Gs3oJJFbUkuTMoOr9lvywaJwn4MO2IftY3HpdpcC//aJdlBp0dizoPYJBd/9sPrwdt7I/9kcwCxty5WjOZrfX3yJh4ICymhhLU9RnZ0LL8mwMtFfUAwm2taVVeF71Y5es8RLkO5kczhjx3kfmZHirWWPBK7MXPI+QjwL1rx6AL40S7KdqW+znyuJA3lnBdzXgCENO1LR867oN8RuPAbOrisdI3Un0dIsndHHKE084MGli2fZwyCIPvdnPxZ+qzcYI7mX3wqFhX0kpwN/ZUIJpfCjsN8VzDIWG6bSUTpDFI4VHQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk/fi60X4lpHk7qCoJR67JnQAeWAlp1EP8jpNnUjvvc=;
 b=JzYIq3Kc/ZSKjZYOvPI9zm6siwMXnGvEgz1mYpd5DCoJNooKPlN7StTESEExHe9MLv0iJ6CpNQMoBfEqgpuInaSfYH91tdkJJ+xfqpjp2prTl0RecGPu1aUViIG8u+K3wV5mGZyR7svLqz1L/KadaHegl9YOZpXuK69d90eqdrjuo+BggeVTORXP49lC+QZd8/RVImicbokeqwstKmnVOsHyd4V1gjuefztFAc4TcMlLvH3BTv6Sy+WISAxLijOd3Ue9QIx1YyDJINH3Y6P3JbL6tWvc/JUkvYGurdWhd2rhjR/vWHud/nvAypYCr8rgVn3I8NJWxLA3euJybLSN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk/fi60X4lpHk7qCoJR67JnQAeWAlp1EP8jpNnUjvvc=;
 b=H4cQXcs+pIN1FbADAJ/1WAxxaJuhXhS7nRabDMRL3V7DMQ28FsxTRAbB9tkzn+5zILJOsVDKQiz9rFodRqOr+D/Kj5QeMotfWcUWaVevfiZTFihHhcoeWG9whU/GeQdPojUqcILTjbWTJixTtHUdDPXWR8z7F/wbe56zLhKySP4WF4TeqGUv67ckNAUbQaGRwsZnZBep290vpPxlF3rXfLTS1fzRUBEdJ1JUdfhKff2A+0BQtlY7SzUZNOGIKlrbkSvUTSVb02wIRiXyDkNJtPUzFzb9BWIEDYzxNJQeMJ1or16odSeA2iliFxP/N+762Yid+VtldmYWaRIoWwdmug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by OSQPR02MB7928.apcprd02.prod.outlook.com (2603:1096:604:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:49 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:49 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 20/32] hw/arm: phytium: Add Phytium E2000 xHCI controllers
Date: Tue,  8 Sep 2026 18:41:29 +0800
Message-ID: <20260908104159.1621764-21-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|OSQPR02MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfdefa8-7914-4964-f86a-08df0d95ed3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: RjWz7PlrARtCTSEoQyOTldjKRjzjhrN+MEnbPd/3/qKzXpa3N3Q2H1bc7JYdIssR/wcEJaRQH/r/sWOsm82pu6Vqdp0UsIcSk8oN/bcGKcF8mahTsWlYSzZgMSFfiL5a9qM06vfHkJ49wqQDSz/Q4HgTH/7BomfU+7awD47SibM1YplbyuUBujBbbP8GzFbwhvF2SYHR9unkx/WIXhp2goDXjc5035HUZVHFdJ1cd6aZ/dXQqGO/7pD2XYSdwgyNjm4xWrNKPSVxlkHP9nO5EMlliQInG8KbVRLprC10PlyLyFpXxsAO28OmM9sw07dm4WfbTKvUmey67TcCUPcwnfdItHKaWdSxVdHkbUlzFwTGmwFVclF74laA8EsMOnwYqbNliaIAHncAxTK4fbmcWYa7qZN6M/yXlB8gvEY7YUAmEDCRwy2KDd90N2Ft12ZDmhZ28i8TsVg8hLk1WvPKoRNo/g1Dw+cKHT/RpmUPDTfigTBiATdKcAdwqCB8o3PmsPF2Q1/CFMt8tY0SLDt5E85FbNtPWE+qYE+nN5YBvziOQNaBQGsIi0dv0IulcNO+nphCvAcbSXQGWFh03d9SyDGQTn2XPvzVHwNArFp7I/2abcfbTgNMkZLd5JXRpiFrCIj4WftJCaPaonrJuMYEAYVn5aFJV0b8rvJi5umbQh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncrIsgYTWxShQ6Iok4t2Xu95bLN53uUv0dtKnfAwi2qubQcFC8fFydLMoE+c?=
 =?us-ascii?Q?XnEtF2/6g/OIP+TFWn+80gar42dFGLXo3X0bBN/wZUuxgGGXENUbVFvD73RC?=
 =?us-ascii?Q?bSFW+Qqm3KMjn/KarB1zkwWRRkTTm/yx8KARGj1UlGeliHnrtLFu9JKW7QLI?=
 =?us-ascii?Q?AGUUA+c496bO0ErCEH2W+682IBNNSRZRjpryYqqvVka7brDuUNbBFDK1FEVN?=
 =?us-ascii?Q?iGvBi36woVCItxeeZ6cPsEC90bRXGnmRYD3lCRwPjjt6PadFRd2iH6grXp2q?=
 =?us-ascii?Q?taSWkmN8q/RKRrrFDoGpqeQoqVtPyph7VSvWSsm5WYIehNXCelRj3XQwnHFK?=
 =?us-ascii?Q?/SYwKwNKSIbKPy2WsPQlPsMHxBJ/3Tjon9d3OvrV8+L3l9j2JySYBdaB54QZ?=
 =?us-ascii?Q?HzSisAfXux8pn0ekGG0tD6gfzqwqykJsXdgDKhjQOFuJ9dKE+5evVIpJTPKa?=
 =?us-ascii?Q?LNSCsOo12qryoWZW9do18ffkbs8HPJ+snR2atCzzsEUpAPa7oo9/4kMGNHwe?=
 =?us-ascii?Q?faGofbHOXhhoa2FbfkKS9jDWcNMf2ltG6J1yjUN5IUfWQpcWLeZLWk2IkFC2?=
 =?us-ascii?Q?X/IjdMx408MuiN9dlIPZkA0nKykxBMiE+RCek60wASH9how+zABh5s0hq46w?=
 =?us-ascii?Q?7BrC+OIqJZLRh7k8wfqLKT8UotR9z3mkI3V6qaYYKQLNO922sxd2FS3RM4IG?=
 =?us-ascii?Q?kEmMUfi080z581x+W9sU/4G8Y1GVaDkYYLIAUP0O7yLxRjPl1RRqkCG2dEDK?=
 =?us-ascii?Q?Ydqd+d+jXHMJQ8oXjQqX1Qqdgdyed49kVttMKYc+do5cEB0Nt6jO60lLeLmJ?=
 =?us-ascii?Q?5SpkUTfOiypqizJNH0Zksf7648ldiqvgukoQmY8Z8wPz3D2RwqSfXA+OtTGZ?=
 =?us-ascii?Q?3qwpI+VyLJidZb/XjtF9DwmpSguTZwvyMDI7sI/zPaGpgApmI5y5Q6ajlloV?=
 =?us-ascii?Q?iZuuo4VWhWvorS5rMex9B/F1lFpKzOuifCKZux4z2Jh0zIeXOZhGuSLsskNq?=
 =?us-ascii?Q?DbGxD2S2+m0ThHm73s8slmmWVlbGUa/bsyQXP79SoZElTlRS+sJ5dMNbCvip?=
 =?us-ascii?Q?c6r7uzGrf6Aw2UQ2IX6MJjoLP90Hpep/VW4GQrUDMa3sFFog7TZJiRfJBS2z?=
 =?us-ascii?Q?2UbLcSsSPgVYDaibJi519HHczS4dLAg3+JnI45ACiuL2N4YKYFNGRtEaIUEo?=
 =?us-ascii?Q?hkwoNSYO7IUpkN43/ohQy6F1k9bhY2mBp0tGjOLWd4tkiSUUqv8VN+6tlrBI?=
 =?us-ascii?Q?rmrUZ9bhegzhQkpiWWOO0JRf3aVfQhRfUv1+HbGbLrAEKUxUDe0A+UgDEcVe?=
 =?us-ascii?Q?iXHkUUgViDWCFWq44uYbACl14Q+nA4C2854fe0ak1AsOuznJfimMrj/yKBrT?=
 =?us-ascii?Q?IWtbZQrs91YUSq37+7wvB6wG+RhXCFYIIfTK7oOwCI1X4CQ42aTT8pI5a5QK?=
 =?us-ascii?Q?aKHsuYxv1dk2eaec7mff63an9sK93BTixu+2FvuOPR9Hqp5noS01WNSfwWp7?=
 =?us-ascii?Q?Bjljlb9QARPycmgwI1FBT5qsbWAdd68ei/gR7IAantVWugixNnfNrlO4HDao?=
 =?us-ascii?Q?8FtBa7qMX5+Rmk16uQj7Nbykbx6TAv6WaW+kf4xX9BUhPjVgGf6Cd0mDwDhY?=
 =?us-ascii?Q?AY21odoix6FSG3RTOJeyODss60d2GUhAaeBFf3BqU0ULJjs9SZFYqLDRc6Bf?=
 =?us-ascii?Q?uU7cOsYVHe+ikkTqp1peostqH/8F/NPbEInp75gV1/CAwtr2xFAQRS2lDKF4?=
 =?us-ascii?Q?q7SKW1o9oXhLfQokRQENWt/EjiKX5B4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfdefa8-7914-4964-f86a-08df0d95ed3e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:49.2203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ8SkqKr+kHAcFJGOod4G6Ttw2v/N4/8/AZHQxNPfc8F8d4YWzrsYjy6szN5GAsYL6wy1jrntV5YZjUBu0LMwP6Ot9NzkwYc1ec+O3ANSM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7928
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instantiate two sysbus xHCI controllers at the documented addresses
and wire their single interrupts to the GIC. Match the platform quirk
by disabling streams and expose one paired USB 2.0/3.0 root port per
controller.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move the xHCI controllers into the E2000 SoC

 include/hw/arm/phytium_e2000.h |  2 ++
 hw/arm/phytium_e2000.c         | 32 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 3 files changed, 35 insertions(+)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index 228d1ecab0..079f7298e9 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -51,6 +51,8 @@ enum {
     PHYTIUM_E2000_PCIE_CTRL,
     PHYTIUM_E2000_PCIE_PHY_CTRL,
     PHYTIUM_E2000_BOARD_CTRL,
+    PHYTIUM_E2000_XHCI0,
+    PHYTIUM_E2000_XHCI1,
     PHYTIUM_E2000_GEM0,
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index c282de7088..e74005289f 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -31,6 +31,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/sd/sd.h"
 #include "hw/ssi/phytium_qspi.h"
+#include "hw/usb/xhci.h"
 #include "net/net.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
@@ -43,6 +44,7 @@
 #define PHYTIUM_E2000_NUM_IRQS        256
 
 #define PHYTIUM_E2000_NUM_UARTS       7
+#define PHYTIUM_E2000_NUM_XHCIS       2
 
 #define PHYTIUM_E2000_MHU_BASE        0x32a00000
 #define PHYTIUM_E2000_SCP_SRAM_BASE   0x32a10000
@@ -79,6 +81,8 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_PCIE_CTRL] =      { 0x31000000, 0x00200000 },
     [PHYTIUM_E2000_PCIE_PHY_CTRL] =  { 0x31500000, 0x00001000 },
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
+    [PHYTIUM_E2000_XHCI0] =          { 0x31a08000, 0x00018000 },
+    [PHYTIUM_E2000_XHCI1] =          { 0x31a28000, 0x00018000 },
     [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
@@ -112,6 +116,11 @@ static const int phytium_e2000_uart_irqmap[] = {
 
 static const int phytium_e2000_i2c_irq = 106;
 
+static const int phytium_e2000_xhci_irqmap[] = {
+    [0] = 16,
+    [1] = 17,
+};
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int
@@ -397,6 +406,26 @@ static void phytium_e2000_create_gem(PhytiumE2000SoCState *s, int index)
     }
 }
 
+static void phytium_e2000_create_xhci(PhytiumE2000SoCState *s, int index)
+{
+    int map_idx = PHYTIUM_E2000_XHCI0 + index;
+    DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *name = g_strdup_printf("xhci%d", index);
+
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    qdev_prop_set_uint32(dev, "intrs", 1);
+    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
+    qdev_prop_set_uint32(dev, "p2", 1);
+    qdev_prop_set_uint32(dev, "p3", 1);
+    qdev_prop_set_bit(dev, "streams", false);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(
+        sbd, 0, phytium_e2000_memmap[map_idx].base, 2);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_xhci_irqmap[index]));
+}
+
 /* The vendor DT maps root-bus INTx solely by pin */
 static int phytium_e2000_pcie_map_irq(PCIDevice *pdev, int pin)
 {
@@ -792,6 +821,9 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
         phytium_e2000_create_uart(s, i);
     }
     phytium_e2000_create_i2c(s);
+    for (i = 0; i < PHYTIUM_E2000_NUM_XHCIS; i++) {
+        phytium_e2000_create_xhci(s, i);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a77a4c2a09..39a7f77611 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -141,6 +141,7 @@ config PHYTIUM_E2000
     select PL011
     select SD
     select UNIMP
+    select USB_XHCI_SYSBUS
 
 config REALVIEW
     bool
-- 
2.53.0


