Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aL-0005bC-1m; Thu, 03 Sep 2026 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aK-0005at-6B; Thu, 03 Sep 2026 07:26:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aI-0006f9-Lb; Thu, 03 Sep 2026 07:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNABOMBtzXV682Q1bzpdwQtjbzQ6dPHzEyg9nXT8gdtV1CSdUKIdHP5S9hq4vbmMA+snKEeKs9XPf6Upb45ajbnMVPnmzEQy1y+GrEhRADY5D7lNpStIJzduFFwkBi246jdjqCEnTL2Oo7ibvjC1wD///DAMD4twLdX2MKHMDRooEuC7I2tG9fDqYQOu7IP7qRay6+hOEiAuMFT0gUIRhca7am6GN0KUV+pUFEKzHmG7qU11HECogvWuNajhMRSITpwWYPT5H0jVwWKQg2XtFUWa6A2IhnP5y7WuBSxIgJakrXS+YtB8e3Tb5YWiLpoNhUqPvAGDdxuI61we7KcBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuPQv9wUpkh+ZqJ9ZmbI39uB/S6gKKCZcnD8xCRFkoU=;
 b=jMmtuUpUnojkLf8hufKaI87cQd6E7y2qjFfMwUxJFLAgZMT7e66cCQB2u7vQvtMHnDAiiqyvr/rNNBWRE/DASmCmzKipoB35JPBEGs2RilTptbVPY8E07/S/Ewj8fedvHB/cX+eCZo5wM4uiSwuA4Kypo9J0rnyjAh+tRX53u98RB0MSBOtFFCnF35X2wERuFkn0CaA/PNlkNJft+RiNLesuLX2xPBmpaDQmGILhn8wAqQx3oF7vsxriOziYO4xLi4xrWvM4MSmol/eCwS4MhJKS20fPYyNlUvgSvYIlIVmxaPv24/8Edjanpv+BLVq8w7ioAexJxfY+s6xdeWNT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuPQv9wUpkh+ZqJ9ZmbI39uB/S6gKKCZcnD8xCRFkoU=;
 b=ro+/X7pxDyOqERHGnhQK0gJWtMxD87LcXz6s/6zVWoX9SsuAOfMXpTt6kueyTYjZk6NG35OsNDoFdNlOHCSXIMtjCFiriepfOK+Z2A/c0fJQCRKGNvc0wJbBf4HiXPJ75xa3TNRyhg6g8BCy8h1A48IGsDgJ39lX8HN9bquYAA7JYH7KZraVPSqFuYAWNEcHrBpHOGjybvE9iIE/+YKtATaMbIW9oF1kjWEcmxpcapqCoV+at5z4m40qq5XgwkClU436RAAdYpZpZJGz8xYepucli6/YLQH1B+GaCYz6Tq/MmjB3JLmr9aJ6ecsoSMrh0VMkTDowfbAapS8wh4lCKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:26:11 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:26:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Subject: [PATCH 10/33] hw/arm: phytium: Connect the Phytium E2000 DDR status
Date: Thu,  3 Sep 2026 19:24:50 +0800
Message-ID: <20260903112532.3276678-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 121d3384-7d5f-4daa-1022-08df09ae2827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: UTSQjyq+i7vLkYQffXocyA/niz1tqwOo53+dqr7XdepWfcV9OGLnZ8tttshA4cP9vrLspvb/wV7IUXmGtKBtWib/D/1c+Ad1FMDelNJWCbEq2SFl5lnl9h37e6lD+zTCKi+mz/UySrzYxB/jlcUCRJh1tfy6SK/v9/DpLmSfWpd+CRqxWq1UcdgSZX+Rx7GB9EmGKXZzJYGKkICI++dp1XjD1wqrky8ytuwte9Cc167OgZ5X3nDI1ttZTyCsAqJMct/BIhKJlyNSybq8li4qffSxmzaqu2nt/nBPimtdilaFLtfH9UEz3ExfULQG/jDgtyy488VCHHkI5QF//S3wlBLWbfW9H2z3qZrrMiHqsF5UgGkGeW23Mh6c6lipYRXVEplOTeTvw2teHN4tlvS1PWqjlpQhFM3jwC1yh8IhC+7LQJseVyhGMvuAOC0cnnnFBUcoPqw6t9gmK0bGCFg1xU64j3aEb2IKTL+TvTiuxdkwkt+Wdm2owchANM6igrHfUqiIiZe4mIET0bJlYwYbqnE943f3vzk2qut7rHUF3QiPz5ndX8LQFFe526Rwu/yqgPUlEr6N24bRmxGYqTFuhUfqR2qbcmOx6eqvSDeHhMw6Cp5GTl+4ieTWYxq4fXvk7E/YKhflMO/D1I8WWgC15+VNxiVb46ojQCnDz+X3f9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LMzzdHrkosS8xbUOk1nXgKLsCjo1/XFDpamvuEzL1CDdVN0rBV+SqNvadyO?=
 =?us-ascii?Q?Oh/5Xb8X82IQwQdMSKCbGpkW+84ObPuUMFFze7AS711AEjrKC6NWxKwBKceU?=
 =?us-ascii?Q?Ow5rPoe/1U2f6Cr5IA8fj3pANNrFFFmJ9Aih6FU8diIjyh4KiAHRzQ5uxuIG?=
 =?us-ascii?Q?widgRTZu0E8ja9bUb/oxpJ7wff3jjVYBt7wH41VnqqgBYdmneY9XtiTHndMv?=
 =?us-ascii?Q?qF5L29SOUadnOho8Euxr9b+97MLJDXDd2AYahZkF53DAqprHMLoVaieYyaUg?=
 =?us-ascii?Q?94AVIQTH3amiY4An6UmhtHfypXiMp5RVPj/7eeRs19XmzBDefHsl72U3ypmd?=
 =?us-ascii?Q?ZNK61iSHArFIIm4LHOm1P9SXfiWvHa+QeKsSTFiP5IKBWH3YicYjEQzAiEsL?=
 =?us-ascii?Q?OOW1n1GAJF9ib5hzLTsxkEig85rPutN3f6VuGTWqGMxm1rfziGVSUxqumZVL?=
 =?us-ascii?Q?m4tFBV+LNIXtGllzAxjqUP4hFTnRINLWEk9rJ0OqjlyEqQnsGVCCmUqkIkxx?=
 =?us-ascii?Q?3lW2WoaMFDA3fqR2D7kwLLUgHhzbcdbncC5UwAnwpKxejpEv0MzsOMn5SQr6?=
 =?us-ascii?Q?+7/jaKyHCh+W0bXc8n+3k4N9Y/JWkQif+a+KBe3v1RrrpdJCjAzLC2q2A/HY?=
 =?us-ascii?Q?QoVUHYRhPi1P7lJWRdM8hjk7GKpGYnD5vS/WDqUHM8FS6xs9iWjINZdT8lRx?=
 =?us-ascii?Q?NpQU3qNdngzt+soTdFlwUSj37UMdlUDo3sQiVAM/SY2DYoJLuxPdkJYgTvCy?=
 =?us-ascii?Q?jqIO1WGJN6knp7s7qjHxxqZey6hn85ispWyeAvzhWVxn3xotOCeBBGmdUNgn?=
 =?us-ascii?Q?yxOXrQY0OBprlXlpusXSMSegDi3eXhPr6CC802D708kOHVl6Ckm4QvEM/m3u?=
 =?us-ascii?Q?kpJPPa3jnnzT4cVcJMoEmo5I6HREFICXZXgUhBNVWo6PrVI0PwJiBMjVD+VT?=
 =?us-ascii?Q?npWvKl+9MEihKawqj0u12BEHlsWez+eeO+gaB6Jj6F/2YSNwlkAihXG/Am7P?=
 =?us-ascii?Q?RmVPk64d95Kp/F3K3CUwXf8NtRa2I1BEBeomcXlF/cR1p1/RgOhKDYBOoGiA?=
 =?us-ascii?Q?rv2+haLyDaoJ5yyuMAOjANu3IPH3nZUvTPzfer82Gxy3AOQs+ID95IWguSX9?=
 =?us-ascii?Q?AbGVAUMFzrzIdEObXfqsK4V8pWacunWS7kWrJpeUjKCrC7rSL/tOBWAptxjT?=
 =?us-ascii?Q?IroB8Q06SBdA4SBFKLvjs2TisZvRtzajWjk75+BfdBwftN7d1V8wu1Y3pDq5?=
 =?us-ascii?Q?UG2na9fWODvnrKQZ/wADrIxtXsgc3N0tBN517sWPoR/myqzpzumVP/9roZYD?=
 =?us-ascii?Q?aD4NMiI9ESLJbut602SxQUYK1WTV6v/onjURLJUQ27q6EFxun9vvXVJNpwop?=
 =?us-ascii?Q?xhV93thGaCHDlv0OA6t7AWb1wyBNH75S0JlysprsGiOR65doUTY2AnJfy+8j?=
 =?us-ascii?Q?z/vYAnypyKQgAB6i/Ownon926rc5UQWrplpFcUBDpPCC4fztL1SAkgSRKAGG?=
 =?us-ascii?Q?UMqb8Xl/lVtRPIPeahrOf35zTmgDDOyCIEy2pQPq1yP33g8emhnavVo3QAC3?=
 =?us-ascii?Q?QnRPYVVIReUEuKqMDnCTXp2Hy+SW1/d090xFEqFQVvfLiLbEc3s5xOa8N7Bb?=
 =?us-ascii?Q?XtbbgIYt7SyLOTuIGzYmBFI33i7uCg7PyXcd6RMhenG2MHclB3pZyZINnsL2?=
 =?us-ascii?Q?Dv5ffsUD6ZyTDwVuwBg6F1inGe0FRNjHm1KSOB3JdWDWwTusrkCFMonrkd6Q?=
 =?us-ascii?Q?mn7Eo0zXp+TpTvRFED/uwwBzQRZLcHc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121d3384-7d5f-4daa-1022-08df09ae2827
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:26:11.4328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAww4k+Qc1n0PWzLIdTKrmOkQIdOp3jlU5roKlJc/KJU7Ys5V5T4SHeXi+uYeng8KmZPm0CUCEuLA2q/TzrrUdCSjF6OZhoYHiqxw4GPSgE=
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

Instantiate the E2000 DDR status device at 0x32b33000 and map it over
the board-control placeholder. PBF and early U-Boot poll this selector
window while firmware coordinates DRAM initialization from EL3.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/phytium_e2000.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index c68a565330..f586184e51 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -25,6 +25,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/misc/phytium_e2000_ddr.h"
 #include "hw/misc/unimp.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/pci/pci.h"
@@ -48,6 +49,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000State, PHYTIUM_PI)
 #define PHYTIUM_E2000_NUM_UARTS       7
 #define PHYTIUM_E2000_NUM_GEMS        4
 
+#define PHYTIUM_E2000_DDR_STATUS_BASE 0x32b33000
+
 #define PHYTIUM_E2000_GTIMER_HZ       50000000
 
 enum {
@@ -445,6 +448,21 @@ static void phytium_e2000_create_mci(PhytiumE2000State *s, int index)
     phytium_e2000_attach_sd_card(DW_MCI(mci), index);
 }
 
+static void phytium_e2000_create_ddr_status(PhytiumE2000State *s)
+{
+    DeviceState *dev = qdev_new(TYPE_PHYTIUM_E2000_DDR);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /*
+     * The selector window is embedded in the board-control aperture. It must
+     * override the placeholder because early U-Boot polls it while PBF is
+     * still coordinating DRAM initialization from EL3.
+     */
+    object_property_add_child(OBJECT(s), "ddr-status", OBJECT(dev));
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_mmio_map_overlap(sbd, 0, PHYTIUM_E2000_DDR_STATUS_BASE, 2);
+}
+
 static void phytium_e2000_create_unimplemented(void)
 {
     /*
@@ -564,6 +582,8 @@ static void phytium_pi_init(MachineState *ms)
     phytium_e2000_create_cpus(s);
     phytium_e2000_create_gic(s);
 
+    phytium_e2000_create_ddr_status(s);
+
     for (i = 0; i < PHYTIUM_E2000_NUM_MCIS; i++) {
         phytium_e2000_create_mci(s, i);
     }
-- 
2.53.0


