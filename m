Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE7C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aE-0005Xk-G8; Thu, 03 Sep 2026 07:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aD-0005X3-3S; Thu, 03 Sep 2026 07:26:17 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aB-0006gK-Aq; Thu, 03 Sep 2026 07:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnByxuPTeZwoPJ201clRM8pZz6eU41Q4hJ6cMu2Mq1GEMy/L+QG2bRm0mrabL6jzOdjRtPhl0JFTKcdN/2WjY2Hoc1Mzc8O9CqkRK7ynz6l3gCZHWte2Gb8PYsgM4EcUkwSZXjefiLHcNoebRr/dak7Kh2g2cuRMxLNSJSGV5rcq+LSlBsU8qhpF1rzD1S5rsJlFQdWrzhz11TSLnzBGbeyl3Zl3u2sECo9cDUwVqA+D6Bq1jzy4uyYPHyxqxNLMqojp8QNG86L05xL7Xo8Zkezv7xFHzN28OjGrzZpzbBYg9qeJxKMbCUaAki5qmuN9iXNbAWQMc3BaGVVrFzuVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMr2MBfXZ6nzhlZEvTEEoENW6TSa2co8cwLmcENFbPo=;
 b=G0wvXhz5JZbBBpBnt1oZtUm3GHOKusXWhWA76VqQFqLtvmt6U4uCagwzLn2oDDVF4iUvmr71W7V3W87CM/U+0igzclak2P+Pvll1DaSZiQawB8SdYfNjdOURSQsoWnyd9km2Kwv8BWo2/DRevb8c36XVHHAr3Hs7TaRHEIrzWrDN2vNztwWcoMPKHxzt1OsikoOiV/gbTL8q5VT3pHFqSZVNhpnPXVryoqHTLM+eLPuhCbhmOrd24eA8WR5zWSLsQ42AhTMcw+kHHh6cl9tAaFHpkFGOgVjJNX5ic8lBJWZDSnpNZ3NLTJM1W/BGG+HrSgYLFPzvDJb0RkscVCJgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMr2MBfXZ6nzhlZEvTEEoENW6TSa2co8cwLmcENFbPo=;
 b=tNKR/nUzEFEdtFS59gn2uDecoGbkAVHhJ+xg90WZ0wXIYUv/ZTOOCsj912gCRQVFG539IZOlcnLve9aYHdB9z7vRA91JilP4yDqIg2r5zaFmY+1rwTN2q9YuYzplvVUTmjmPOzWleUex2Zcrb80KClsTrWXxUCpBzdW8JwTFNr53fG755f2OOFFp2lscgLLjYTtYsZd4C5rdKF1ddnRa8ctq0Bm9uKuMLhF7NPAQTcwKc7PaGq0vJIK220jxgCaI9GlEF7WzEyQKYBMyfsUX3W0rxEkwk3Hyy+qXGi3uR4rkez2KgZ81Phifwj6M3EFcT6p/dymQr6yKdGV6/gBOZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:03 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 06/33] hw/arm: phytium: Connect Phytium E2000 MCI controllers
Date: Thu,  3 Sep 2026 19:24:46 +0800
Message-ID: <20260903112532.3276678-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4b8c3f-496a-419e-6c5c-08df09ae236e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YHjE9NJgL3+tjr0V3rHeTFuTRt3ltEwuSKi6WwIw4WmTyyZOWXclLVnEIQk/2ocjnzqIqTBntvHNfH7MzChGKhD5GmlTZFoZBAqMRZ92rUW2WIzUUpktwKHZSRZ7kk9iHRPvJt3nzXLU9L40oD6A4C1YnjB5cLcm5CkBiNoXIgaUaOkbE+PNEgi5IXt/2sAk2qS8n77qnplvYPLKpHYs48AvGJ4rPImGBYXe2iiKRtUlXpOR8WXSsO6etCOXAyImBDydT6jLFTyiMDvEsZlEKqZadP4PJ99S4xKb2bMLcy2qtInYSH022iFAcJrKjUh2A7kqJ5uUMy7Cx/Z7fsfTmOUdBG1PN17ZabRVcuFzT4SDNUDsw/au/n008/MnOIXfZIG98m378KT9f+RRRjMxNkPD8PZz3CYurOR43EIVDqEe27/7G04bRiVeMG9ZEusGB5fzV8DWinSy7p2NwdTp9+LemKkqvSQmzgb7zGZOtsead0A4iTarj7Gd8QRkH1Sj9EU49PlZI4G/aXj0aZmixiCoen9PbToT3POnoigpYfHk0lVI/TtYuakDJpv6DPlcBd719ikJxTPUxA8edpedZYiRRr9wAPBNIpmzsYfOnRcBcc/HPlU2YLWCh3CQ6Z5KeJWozIXe+yLIlMxPohkWyHELh9SsHP5n6popU8Fct/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTZ4KHXpOBHjKOa/0gsdktX/sxXmb4+Nc3ZrAJRA4+EY3YCYH0qH1qU2TPRY?=
 =?us-ascii?Q?Folh7RUBGUbNT2CnzLphBF9lOgD2dLWP6D+gPmwPqBuWcOsy4aP8mF0VacDq?=
 =?us-ascii?Q?yBoAlVgdTE8rpZkmXDnXwSFKOWM+STb9H8wRY+z9kmAEBKyA1h7sI+Q1c7Co?=
 =?us-ascii?Q?qbJR1oFc1nfcZ/Br6epCyUBxWvkEfb+6D5fkNkWxU98Ngw+7Mb7nXwhBF68u?=
 =?us-ascii?Q?/04kQB36iYsLbu4GLJYonPYAICBO/qz33w8bTDuvJpRRG71TBTyJHG0vkX/w?=
 =?us-ascii?Q?aCLbUoH515nugKnfftZD+ji6zewUPdyXhypAHSikXPbzsxbYL8BZjfjMv8iX?=
 =?us-ascii?Q?AxRGxJyQiHCWxrenWEkyzre2CGOE9Sz90Ty9MGMG322PfA7RPrzwj/TAP8dj?=
 =?us-ascii?Q?ZWC4E1Be41ApWIFZwimHhFA0BXTzNL7Tn7RhP+ranVahcBqbmiUW7LSOIGCK?=
 =?us-ascii?Q?T7heMlYS9ilUL3nPT+9gZfQ0vNqbltSxVIzMt0p+QhVTYhHlkxCtsVon6xE6?=
 =?us-ascii?Q?lsnY/wzdVMqFRGIn6sXKiUoTP87Kd+dAn5mkgU1fkIDgVXnTDX0eXsxIzdw2?=
 =?us-ascii?Q?kKsOfzmUnJrFqUAvMpY1uiNb4yA01r4C2YsMQTrj3dcWKht3bKqrN1UASKf5?=
 =?us-ascii?Q?Pd16qPJUHbNdDNlqvYa2dfrBHwXX6dZ471QpbX31g7zNL4vije3peltPQzcR?=
 =?us-ascii?Q?JqAaiT5OzwYcMnP3dWrvL+nPh+Y1EbNARdoa7WLUNd9jo91RCuIAH9ODm3ch?=
 =?us-ascii?Q?KMrZKxxEQsW/tLyjQLexgaJ2GcRXo//3u5bM4yRgffP3FO+dMqcSSdbtI9rI?=
 =?us-ascii?Q?jYQaPstMz8nKChuMXkhMpzFkBUi8hG0zOosocyxm9AUv+727T25g+wv+UoCH?=
 =?us-ascii?Q?d/9CkArD8FZWkqCuT0ApcNXht24dWL+5bLyWSaDR+klb98Z0bc5ucZEgYfR8?=
 =?us-ascii?Q?MIOAR3cWiLF5u5QTG099SFou7Cg4sAMtee2EVrDmXsbXR4WUx7hrtgMneuUT?=
 =?us-ascii?Q?tXSo6DjLEKqix1hrGjMrDNB67nPWJW/Y6d9zq5H2tO4NFnugmEVYr7FqmHoh?=
 =?us-ascii?Q?29NQUgii/CKJQyO/6gPpkjSWQUHKJ6hmDAe9ItHV9mdwcmZemTuQNPONINQz?=
 =?us-ascii?Q?ixeVSm2bd2ONciEesSj7xHwQH3XE/nC/co4sarSiQqCdIj1f4bQZ3OwfwCvy?=
 =?us-ascii?Q?1mMyVmiRfcyXnOye+Dusouc34JTZm5u+Q0FtS5L96WkPxB9iH5DWXy72H00t?=
 =?us-ascii?Q?GpawV9snYkxZvRWngi+nXpYJKkKoeNyuN0MebffSU+wEzRBJnu0cZYyUlhL6?=
 =?us-ascii?Q?Q61B52DibgwJsLWHQ9MNvq/SY44IdAAVqqrkERuDjqkxBKCiFuhSCj6QhM2G?=
 =?us-ascii?Q?hYGLemcjRrBeQCFAncqDeYAvx6RiviQ3tA45nqXv7ITyQ3KRSLa2ahyDTbfm?=
 =?us-ascii?Q?B6FgqW7idPVR6y5sfCLwfo+cVvZinobEJIJvF4UzUbK6IC4rOP6ZR149qlKi?=
 =?us-ascii?Q?QPNxA61l1Xax0C+OHVAUsFa5ph06qy+hSa9uBzCGDHf2EFQnLC1oAvhqgKf2?=
 =?us-ascii?Q?oqEME+DPjYvsGGJm76bebxSK9+iFH52IYmC5McYA86otSLXSz02N3Ddm5Ilu?=
 =?us-ascii?Q?YEAIZ0svhJd0bT8bw558I8MXnqHgeVyIGSPmsxDZG9S8hUfFtDi9kCaaRoYX?=
 =?us-ascii?Q?6jxKBJqLkoYmuG+h79Lm+e7OcOSs3S1Nt9bQpR6iV0zmsSIwlIN7ai87IEjF?=
 =?us-ascii?Q?+QxatPFeuNLZJPHhSA3pKvGVwRISEtw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4b8c3f-496a-419e-6c5c-08df09ae236e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:03.4654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awJHHFeeVjZkGE/RJuKpOpi5v8J1f1mR0ePrn1Ea2qzgVcSnVxh6RP/fWxAYGhuCsl/TAb/546zXiK1NZox9MIXR9t4vySmdS1hJpt3SLTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6358
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

Instantiate both E2000 MCI controllers at their low-peripheral
addresses, route their interrupts to the GIC, and create an SD
card on each exported bus. Map legacy IF_SD backends by controller
index so firmware and Linux use the same board-visible media topology.

Keep the broad unimplemented aperture underneath the concrete
devices and make SD the machine's default block interface.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/Kconfig         |  1 +
 hw/arm/phytium_e2000.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 99a5799b22..9358a47b8a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -136,6 +136,7 @@ config PHYTIUM_E2000
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PL011
+    select SD
     select UNIMP
 
 config REALVIEW
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index aac798aa07..88307184e9 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -28,6 +28,8 @@
 #include "hw/misc/unimp.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/sd/phytium_e2000_mci.h"
+#include "hw/sd/sd.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
@@ -40,12 +42,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 #define PHYTIUM_E2000_NUM_CPUS        4
 #define PHYTIUM_E2000_NUM_IRQS        256
 
+#define PHYTIUM_E2000_NUM_MCIS        2
 #define PHYTIUM_E2000_NUM_UARTS       7
 
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
 
 enum {
     PHYTIUM_E2000_LOW_PERIPH,
+    PHYTIUM_E2000_MCI0,
+    PHYTIUM_E2000_MCI1,
     PHYTIUM_E2000_UART0,
     PHYTIUM_E2000_UART1,
     PHYTIUM_E2000_UART2,
@@ -73,6 +78,7 @@ struct PhytiumE2000State {
     MachineState parent;
     struct arm_boot_info bootinfo;
     DeviceState *gic;
+    PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     MemoryRegion ram_low;
     MemoryRegion ram_high;
 };
@@ -84,6 +90,8 @@ struct PhytiumE2000State {
  */
 static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_LOW_PERIPH] =     { 0x28000000, 0x00100000 },
+    [PHYTIUM_E2000_MCI0] =           { 0x28000000, 0x00001000 },
+    [PHYTIUM_E2000_MCI1] =           { 0x28001000, 0x00001000 },
     [PHYTIUM_E2000_UART0] =          { 0x2800c000, 0x00001000 },
     [PHYTIUM_E2000_UART1] =          { 0x2800d000, 0x00001000 },
     [PHYTIUM_E2000_UART2] =          { 0x2800e000, 0x00001000 },
@@ -107,6 +115,11 @@ static const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_RAM_HIGH] =       { 0x2000000000ULL, 0x180000000ULL },
 };
 
+static const int phytium_e2000_mci_irqmap[] = {
+    [0] = 72,
+    [1] = 73,
+};
+
 static const int phytium_e2000_uart_irqmap[] = {
     [0] = 83,
     [1] = 84,
@@ -324,6 +337,55 @@ static void phytium_e2000_create_pcie(PhytiumE2000State *s)
     }
 }
 
+static BlockBackend *phytium_e2000_sd_blk(int index)
+{
+    DriveInfo *dinfo = drive_get(IF_SD, 0, index);
+
+    return dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+}
+
+static void phytium_e2000_attach_sd_card(DwMciState *mci, int index)
+{
+    BlockBackend *blk = phytium_e2000_sd_blk(index);
+    BusState *bus = BUS(dw_mci_get_bus(mci));
+    DeviceState *card;
+
+    /*
+     * Always instantiate the socket-level card object. A missing backend then
+     * behaves as an empty slot, while if=sd,index=N gives firmware a real SD
+     * card on the matching physical MCI controller.
+     */
+    card = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card, bus, &error_fatal);
+}
+
+static void phytium_e2000_create_mci(PhytiumE2000State *s, int index)
+{
+    PhytiumE2000MciState *mci =
+        PHYTIUM_E2000_MCI(qdev_new(TYPE_PHYTIUM_E2000_MCI));
+    DeviceState *dev = DEVICE(mci);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MemoryRegion *iomem;
+    int map_idx = PHYTIUM_E2000_MCI0 + index;
+    g_autofree char *name = g_strdup_printf("mci%d", index);
+
+    /*
+     * MCI0 and MCI1 occupy the first two pages of the broad low-peripheral
+     * placeholder. Use a higher overlap priority so real command and data
+     * accesses reach the controller model.
+     */
+    s->mci[index] = mci;
+    object_property_add_child(OBJECT(s), name, OBJECT(mci));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    iomem = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion_overlap(
+        get_system_memory(), phytium_e2000_memmap[map_idx].base, iomem, 1);
+    sysbus_connect_irq(sbd, 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_mci_irqmap[index]));
+    phytium_e2000_attach_sd_card(DW_MCI(mci), index);
+}
+
 static void phytium_e2000_create_unimplemented(void)
 {
     /*
@@ -443,6 +505,9 @@ static void phytium_pi_init(MachineState *ms)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
+        phytium_e2000_create_mci(s, i);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_UARTS; i++) {
         phytium_e2000_create_uart(s, i);
     }
-- 
2.53.0


