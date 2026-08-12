Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF982C5AC67
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxu9-000854-O0; Tue, 11 Aug 2026 21:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu6-00083f-Do; Tue, 11 Aug 2026 21:37:14 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu4-0001Yf-NT; Tue, 11 Aug 2026 21:37:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn9a31qeK0qo0OEC5m5fQ1f70PD9pJFRfKmCTZDGNQQURRXz4OCTt1XO1kYivPgqT1fW3KM9Z0bFMGyFjIm7jyGPe/HHn78Q4pte9xJnsapcbipAdwFQaMlLPbSvruCLfJrQ7DSahmQR5c/b8hqLwrwwNhwa8KtxAMXbxcWSI9QNEkc29sxsvb9UEUAkDtjTCbtPq9tfEfH95eitfZRIIFyqJ2ua1gL8Za4yzeXxOkXZoqskOlHBn9A6YxLXolZ52N2DfBG1Sr6Kkw89f0eN3sFjMjKpCEvGuXp+ewySHvitoHB3x04D7IxBA0JCoDMkWsoqPLl0XswAAXOOxA3Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0e6HyZUcGYsVnuM+gm2u7bKlN7X3lB1oWRhkYpGGuM=;
 b=PzMC5sUGd1i2IiH8TLwXICr7FXDvgumgrAl7lGfIJbeNPTPwkmW03tPlHbekGpus1R9B8Yji+wvdLn1YX2m3Z061bMPhl0nv82y3X82zDyR5arTNYb/4a5SWKyKs16Z03RkFHhb8CE4x4tbJH/p7CtefAeIaSgv48Qn+RC6h+EBfZr2bG5Ekz3CMT666EcywajEZfWnzauguKjqMH/q4kuw4uWC61Egal2DmczGSDyVRlzY39hicjErZEqtsZmEC1b0iFpp2hy+OVYMlAVu8lu+MD1iWAxFLk/o6NK9WkmPX2GEc3n+TeO0BjBSf4xje/BBvn7dqG3u1GGEZXldFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0e6HyZUcGYsVnuM+gm2u7bKlN7X3lB1oWRhkYpGGuM=;
 b=cz6Ap29h63xOOWNZc6yfvaNg4yEY9+2In8p9O60w7yAAvh8OfplIREuFe6B6DaNsO2Oo57ExuDhhvuUdteu+ZmpjVysnTo9g7WS/3kd9UvJsXOmBPaBAcuLK1MuJrfOV4EOxqA3s9adMKjLG7mB2kKQQAHdgD0JfDpPxrJZi6y3o6IKz8t91fgXL3MhqDl5Ij26m42qdHAREcgukvvFp0fzYti1pZR2lU7tS9nHfcOYAIGYamTa+6tjJAOrizwb5hUkXjSrYcZoWSejivMdtUZ21PqAYDIel9lXw/guSaOuF/vUgbagG0LxmVHuhDOQ9SDl7Ns3oX5QrhSAzOUVlRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:06 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Date: Wed, 12 Aug 2026 09:36:09 +0800
Message-ID: <20260812013619.2134092-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a71739-40f9-40ac-fea4-08def81237b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|5023799004|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: gdvG8jnLMsW609mrsAzXG5VYmbrFuMdlp992LpEC788d551mEivrVG0ytU34piYADXpNc+vYvFM6rE7weiIe3EMG3w9uzGfPVFHtSxlouV+mXutxhA8LAhKGl2yFiskODFmL+f6Zcdv+nCakAEqF3Ll2NROv/KTYYc420OYw3yxJfCeltMAybBhN90cgjmLbaM5HrpnjgTtLtoPJ+L1vynXfI0YB0fRWKQClp07jeR/5NQyab1WwTvq+0ikcU4AMQCzMSEOtQ5yTDH9UC/NJq0n5tq63t6P8smtow3IS2t6TO5DiZMQkDqm8By3hpFyRyGTBSam42RPObxGbUbcTMlyHetZEYlpOldL+fxbualUf+AwO1YGmxSRICuBC0bV6bBULM5fDJPWiJpbMT37gLCQkO7qG6Zg72sfS15whNZJ0wTa0bb7N8zK0ps5q+CS8m+G4+ANkEhBweCw3/fhrHwJ0MKytl/ExHGujzf6OJpKS3SCkjjirtPNLHRHq8yKn1WZ4D+iTDWfyd4Ds1EFy8XiFenIDkDS3EWk9RDJG4Vq7fEDC2iGXWfMB6uZ8Ua7TApg1wgHF6pEpbpA1Iob2lscJ1ZZOtL/2ddGyofeFLvClzlpWyuFW0PXHSmFMWRPHrEbWiw6+M2zGuEHINusrx/0kGsfgEBg59SZCiUTibHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcY/QifqTxiJlP3UIUnrqJTkq1uk0IbzOLSpcJNlZrjgn8EObmZhbpzJE7hT?=
 =?us-ascii?Q?ktTpCaGi5TwGNX7wb54q705tkADEM7awpchrcjBbtxcaPEkXbPupLYFoZV9M?=
 =?us-ascii?Q?q4hT0NHwt9cGhlF5VoqhPtqlvsS7QoUbCiLRLwTT6c4gFNQWkyjKJG+TAajQ?=
 =?us-ascii?Q?V6HH1ep71exoG6c6IzsMWDjajpcLV4cSGvQqgH2+/Sq1lWT2St819IJ/2Y1s?=
 =?us-ascii?Q?JF/fu9oUny2fDRwua1EjWjLvhVEABUeIinzZSmlDMwW2vixmC38CzTdzBKgp?=
 =?us-ascii?Q?8e9DbLOKemg2xwgmGoTHtXT0NnciGqwFlSicU6TaFalMnYvBxi040rTCOk1Y?=
 =?us-ascii?Q?bsMk/NNvuqG7sGCfzwRqXnN2Ox19iE1crUkhxUo5+N34WdGYoU4SnxWsoOTD?=
 =?us-ascii?Q?JwgNVgSIIxU8I3XkN/qilC39jtKeFQbJLO9bSFSPKD1nT45B5d7AZeZqQt90?=
 =?us-ascii?Q?wk6HoRD/D/sqN4x2MRw5DSBzmPG2ean4SyjM8Zr1tFbLsuomw9Bw79S8pHPu?=
 =?us-ascii?Q?LC1G7VrjtRVwXIZm1y77kPx2qFVFnw0LFcbM20LzbPCmjvKP08cDYE6FUIGM?=
 =?us-ascii?Q?TF1/HKkzTu4jPziqSKSDjohoLRfbPkbgkPLqCvxs1mzx0CANvt+t6aDcs4Go?=
 =?us-ascii?Q?Hif2BNJHBRVrFCnxN4uup3kWDDDfe2dmc/sKf7pYahU1VmzTJ3rOnJSDZ+Gh?=
 =?us-ascii?Q?p3loDlgq00wUv8GRUj5GrGxf2dl5UG1oo59GMMoueRw82YZ5U6BCIDEANV9m?=
 =?us-ascii?Q?53JuQXqx0Z9sSZ0Z2wnCcwyIN0/a58HvOY/IJqjgM+WKcov2MTAr7WxK+qWN?=
 =?us-ascii?Q?0ksuDwVqWQkIUKMi0j40jVYVbD/h8K1mHX67SIdV1Ma1wmk28WiMCfGuTQ4C?=
 =?us-ascii?Q?5mD56ME6Lr2Op2bfssP342xP9g6eUoE93VuNCybK7utRPtcGpQd0oM3Uxjgc?=
 =?us-ascii?Q?WhY9rD5tvztbgxJVG9iGOHPIIux1k/dYFos4atwmXB8lexKJU7O0fEDPllGW?=
 =?us-ascii?Q?FdRpaw69Vq8wDOC4HtAlV/araiim7QvtnDiLtREoFBftGwYsaBecpWBKNR0b?=
 =?us-ascii?Q?RHc+o2XSRdxrXnTHQWhZhNTn8bCiur7g8ptZ30jRqVKg73hoTJl5eT/fpKNw?=
 =?us-ascii?Q?BXrnA6vxDWZbWZG88dd/CGZ+H0KMaRu5ybyU03bJj1bbJmOZWRau/EJvU/6b?=
 =?us-ascii?Q?AEY57OYuClOFFWje7msE0/QSS9iexJ/3enE6AoGnOl0rxYCmlACM1PJ49Uvt?=
 =?us-ascii?Q?75InGn3ZxUP2MYp/krYLUIFCfjwFpZFOajGTaUZJ3ZtfbDklXLZRHdyYfeuh?=
 =?us-ascii?Q?qETKaAlA2j2h3xzwi/KRX2rPBFvh5ie4gQU+8ZYh9jNkPKNKqSWLRwNRQJry?=
 =?us-ascii?Q?x4TOKTUnIctgwSkfG/BgO/xP+rsBH91HXIrtXFSv/73Z8BUiLjIrdbBzvdlw?=
 =?us-ascii?Q?oZpMhyEpj05PdvYzbUkrbFuDze7WaXLYiVXLmPgSt12aKefLrTCK0qGCYxvs?=
 =?us-ascii?Q?W6QHc26lW5yE5+wh5JrUvrv47XtDTs13qUrmP7LDyMxRSokLEcdfwhFzFi0h?=
 =?us-ascii?Q?kQn8+SBlbcdiLeJo4PKWLDO2IjTptktaNCgIUjZKvpOY3cD+7FqqVIvNXSTy?=
 =?us-ascii?Q?5dROIv0ug0OvsvgGtFJVwVVBKMR/Uo05f4XdW5/q3KSsizeLk2ZpByAcxhCI?=
 =?us-ascii?Q?2QkF71uUI2Od4rIqXemaG+/wJH/LFDIQ2+kxag0zUTIM0dTn1mf8IZouDBlI?=
 =?us-ascii?Q?EFeiin2UVXYibjcUsKLvK62faIHOFxg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a71739-40f9-40ac-fea4-08def81237b7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:06.2318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhEgYitfwhzOI191c4HVIRItDKv/vxeo9CVjhGlPem9IOHKlSenbX+d6EgtD8zfhkBZVc/1cCIEVfFHSv97680ovuEzXNy3NDN24bI3MhZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

U-Boot's i.MX uSDHC driver enables IPGEN, HCKEN, PEREN and CKEN in
VEND_SPEC rather than the standard SDHCI clock-control fields. QEMU
only checks the standard fields before issuing a command. It therefore
silently drops U-Boot's MMC commands even though the controller clocks
are enabled. U-Boot eventually times out waiting for command completion
and cannot load the kernel and device tree from the SD card.

Accept the complete vendor clock-gate set as another valid clock source
for i.MX uSDHC. Also report SDSTB when the vendor IP and host clocks
are enabled, matching the state U-Boot polls while changing the clock.

Keep this behavior behind an i.MX uSDHC quirk because the shared eSDHC
paths also serve controllers which use the standard SDHCI fields.

Reference: IMX6ULRM (Rev 2), section 56.8.10, 56.8.12 and 56.8.26
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c         | 27 ++++++++++++++++++++++++---
 include/hw/sd/sdhci.h |  7 ++++++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e58a610397..09aea733ba 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -992,9 +992,11 @@ static void sdhci_data_transfer(void *opaque)
     }
 }
 
+static bool sdhci_clocks_on(SDHCIState *s);
+
 static bool sdhci_can_issue_command(SDHCIState *s)
 {
-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
+    if (!sdhci_clocks_on(s) ||
         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
         ((s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY &&
@@ -1613,6 +1615,10 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDOR_IPGEN              (1 << 11)
+#define ESDHC_VENDOR_HCKEN              (1 << 12)
+#define ESDHC_VENDOR_PEREN              (1 << 13)
+#define ESDHC_VENDOR_CKEN               (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -1629,6 +1635,16 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_PRNSTS_SDSTB              (1 << 3)
 #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
 
+static bool sdhci_clocks_on(SDHCIState *s)
+{
+    uint32_t vendor_clocks = ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
+                             ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
+
+    return SDHC_CLOCK_IS_ON(s->clkcon) ||
+           ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
+            (s->vendor_spec & vendor_clocks) == vendor_clocks);
+}
+
 static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
@@ -1664,7 +1680,11 @@ static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
     case SDHC_PRNSTS:
         /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
         ret = sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
-        if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
+        if ((s->clkcon & SDHC_CLOCK_INT_STABLE) ||
+            ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
+             (s->vendor_spec & (ESDHC_VENDOR_IPGEN |
+                                ESDHC_VENDOR_HCKEN)) ==
+             (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN))) {
             ret |= ESDHC_PRNSTS_SDSTB;
         }
         break;
@@ -1923,7 +1943,8 @@ static void imx_usdhc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
+                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 8083379de3..c542d47f9b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -110,7 +110,12 @@ typedef struct SDHCIState SDHCIState;
  * Controller does not provide transfer-complete interrupt when not
  * busy.
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
+/*
+ * Controller uses vendor-specific clock gates in place of the standard
+ * SDHCI clock-control fields
+ */
+#define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


