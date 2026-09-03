Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77D4C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25aE-0005Xi-4A; Thu, 03 Sep 2026 07:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25aC-0005X1-VD; Thu, 03 Sep 2026 07:26:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x25a8-0006f9-1J; Thu, 03 Sep 2026 07:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul6cKukt5t8jbr13tfGqAD436N7VZmbV9BEyNSQ8Fo5eDTyICy9N80XnLePorsp5aaWFQegp6qzGdut0GcWe4BaL5xKfh2wj73+yK0VrIRV2VQZt8ASRySQe0xdCdaAzXerbZr3bpF8kMTU2yUb6KfmyMhI6MxtdahYXqe+F78zqTBEyQ+NzaDU6qyS6NAJdnQ/Uw0DN8PzG72EekRECeG/fSqQWIgGwO4InOAzDlBBcrayPa+WiUT3UuuwCoN9BnB1pSrD5jhLrEoXUrtBHYTfbCOPxVpE/Af0hF89kWNKWnQ8l5okJiFixVFdSbxaekCpQvkm4PljNdQOzOY8olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLvYLX6o4gmwcnDkpC3vIO9SnCMFN8fbA8lWZfVnd2U=;
 b=sHJNtVOoP8RFind4vqGomKhXtvGqHC9A5+/kf6v75h1BAAddCnKezJjuBNE99CMeqAxZwMok5lX8V3jPdKo/eWrqrhwi7L9SCw1YwUmi7VqIvGZUQpZU+7x3/rOBw9Oswt/Hkx4REUWccd1PRmYPFpYh1AJrlZyfpPYxbCwVfWYieNE0NNcq9HCKnPQlSD7py3ORTlbUW5l4YQOfiQ59JrNVDc3lfcKKtVXOB8nbQFIx0U76V1sldZ7QIexFHXaV/josic0FxtjPVNb9tGBD8pfTDlO+yJ1Rok1Ub0FqG2ooa/ST2JFU98tFJdQ9yJW6tQv+/FW4D6wGFN6iS13JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLvYLX6o4gmwcnDkpC3vIO9SnCMFN8fbA8lWZfVnd2U=;
 b=oYg+duNopKfP0Z604aYYFJGJzqzaDq2sPqtFSdvd5iMpkjxLFqCMeN9GgtCykJHJSmrFrewOpgPvmFppTOl2lABG+MT2GHhEjLz26/MvfoBBR78hVckzTXpxXZFskFWX4zYFZod9r2+38PEAR2uH9iXbUJotyb94CjTopPTK21Qy9j+mWfRCB5WLiVTb7t2KN11KxjDicqHu0LY7ojYLE2TThwYyM/GiukypvT99LgFy/GHa6LAIpCzFAc+V7bPLMXao1zBPI0Tjhb9ldVH6sgs7sdInZdVsdq1ouwCvWiiRPkyjQu/HLNu8j2XJXi158i8XFL7YbRrIpUBy7D416A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYZPR02MB6358.apcprd02.prod.outlook.com (2603:1096:400:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:25:59 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 11:25:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 04/33] hw/sd: Add Synopsys DesignWare MCI controller
Date: Thu,  3 Sep 2026 19:24:44 +0800
Message-ID: <20260903112532.3276678-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903112532.3276678-1-bin.meng@processmission.com>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYZPR02MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: fe92e43c-7bf8-438f-0c88-08df09ae2106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: enKUr1qfnSn6MxTM/SXI12WMPXTsE04+2IItNR06ZvoTH48IqjKvKMM0axeqKvt4q3viYmLNUQYpunwaVeqySxWk3H7Ul5LQa5M78uSa+j/EmvtpxE13e/cWS2+QY8/Kr7RNL4AFV75hQiBQVe7olDH+XAcd5fuapQ+lRgOSsoO+ZNOBgdSsNfFkPY9qHOUDFUtsLquMuyTZcgzfztjT/LjCqeUL2Si7VpktJBQ0S+n1yzoUmpzUUrYv01lMgtNkiAttkV8d3auMcvHXHsUKM6iI3yAhaozf2y/ABBbzmMn3Efrqz52BneS354js1bj2Omlb/1gN/Ap5cDVCFTgEKxPiUbw/XOjqMmcTBVXz8FIaaQ/PyESzDMO7E1ICe4glx+6bO2OI6mNtpKjhGSat2H33Y41GMc4WvHZzc25qLD8F0Av1MiajPkbuCJak6ueVO4/dQvLLyFTvpT+yw/d0SONuXVCQyse4a3gFa4hXhb7pWE3bhI1TMEPojvyiEgzBBZXw35TVIGqq+DVWwmEjeuRhzp0JvKZi0rgTrOoZ4PFBnJINSq3yD1Zj9JbazKd+6blT4BZF6IaX5C/b6EGW/gWneqDyqlLFRo6le6lLpNcOFi8l4O/fV1Z3+dw/XOi9tkHY/7YRwtQyIQS1dSFCiLsTvQjOMP7xWPuOFIGa8ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9ZQ1ZmQnRlaWZzRUhqeDhDQXNya1hSY1MvbHczQ0xKZGtZTjhZa0dYdStY?=
 =?utf-8?B?ZENNRmZWam85ZjhqM1BBZktDKzJMbDYwRExIYUp6dXpFNXBWRjhxVDhjeHEr?=
 =?utf-8?B?RDNuem5SbHBMVHNTV3FPd1RiaThxVkJoZ1dJZEE1cllpWU9vMXhNZ1JvcERv?=
 =?utf-8?B?SkFBMHAweXVJdUtZUFd5dmZ1K3F1c0Ftam9uZEhBbWhwamZ5ZGxjRkFjS2lU?=
 =?utf-8?B?UlZaa0NZVlVlbXNpRDA4eWN5N0xKanZhZUR1ZEowMU1pTXhsQnQ2a1h2djhw?=
 =?utf-8?B?dkttNXZaWVN2cjg4Z1NKQ1N4WTVVVkNDM2ptU3dHVk1NRzRWYVdJZEFoWXVD?=
 =?utf-8?B?bnRnLzJPcmMzTml5UTJrWm9sd0x4VG8wb0pvdWRzcjNObUFYVzBrUlpDTDJq?=
 =?utf-8?B?bjlDeVhnL0dWdzBQY0MyWHVySlFhMTJvTitoZGFtQi8wclphVkNBZUhyeHpS?=
 =?utf-8?B?eWdjblVRejhFa0R5di84UFF6M3BBSGhZM0ViL0Z3cEdkRWdEVTZZY0x0ay93?=
 =?utf-8?B?ZmU1NFZDZUg5NmxZc3puWEhiS0E4YURnQStiZlZMS3NMbDdYNkh1d3YyNVdV?=
 =?utf-8?B?UGppN2Y5NjhJR0xQaVRXQWZ4a2hBc2cyN0xCSWFLMVBaOUs5NGp0YUJOTitk?=
 =?utf-8?B?cWZLcHJ5YW9FWmlVNXVWR0pSVTZhRWhrSjFaUDhTMmdENWxxM1JybVhtZFUy?=
 =?utf-8?B?a0g4YlNYZ2tqWExPNEo4VUUwbDM0R081SFNtYkVVTkh1QWZ2a3VaYnJ2Vkxt?=
 =?utf-8?B?WHJpSkxpVHFaMDhyYTAvWGpOZFkyNGFIMVR3SVpoU1lENk9QY2hZQmdDTUVO?=
 =?utf-8?B?SnFhMGJHbWprOXErdXdYNTZpUVlqVXR3b0dqdXZvbU03UXNSbjBiVThnb2dK?=
 =?utf-8?B?RENKSExNK2JZZnVwcnNybWhUN1kyZ0QydTVWZmpZS3JvT1NPTzhOMXRZYkgy?=
 =?utf-8?B?M0Z3SERmSE9VQnA0TS9LZWlGWlhLZEY1L2k0OEo1cGtsNnZSNmQyMG9wOUhF?=
 =?utf-8?B?ZGJwYVNFN3JubWJyOERnaDI5Vng5RXVyVHhxWi9mK1gyYkk0UVFpeFI4em9W?=
 =?utf-8?B?bkVWOHVDd0xReTFJZ01xWnV3blBpT0k4TS9qTWE1Ly9SbktoeVZTVXZPd2dt?=
 =?utf-8?B?RG1ab1VhRHJyZzJxRnZva3E0TE9zekk4N1gxVmowSXJYUkpIdzB6WEdVWjFR?=
 =?utf-8?B?QzU5cG9wZjZzbG1JdURCNVgyMzRXMFMwcU1yWE1qK05LWnB4cWNaTHZCeGM3?=
 =?utf-8?B?MzBPdUdINHJ2SkYreWxidUFTOWZEWUNjV3JNQ2Rmcy8xbTJIYzdLM050bXVq?=
 =?utf-8?B?cEwwT0pSM29hRmlBR0xQNExKRko0MlBmcThxdGM3U2E2MVhCbXJJd0dwOUJX?=
 =?utf-8?B?UTA4Q0Yzenl2Q0dkSTlocXppU1ZVYUhzd3hXRE1sVFdkeURhMHoxSUduajZD?=
 =?utf-8?B?N3A5UkF5ak14V3ZTL0YwUW1jMUVuRTBTaFYzVXlzNEEyWHU0ZFZheCt1bWRC?=
 =?utf-8?B?M0pPSi9nZVRvYmFBUE1wN1ZLQ1hGa2IxbUxyYU5UZG5VbEZPSEpjeFVCc3ZG?=
 =?utf-8?B?OThDajNyRUNkUzNwajRybWRjR1UwdHpaR3EyL3hwYTFVakErNjZuMmNJRDJO?=
 =?utf-8?B?Y3lpaXpWc2xXek9Jc1ZJSHdKNm5QV1dHNTlxbzBCd3JZUCsyWnlldHprYTlw?=
 =?utf-8?B?dFdIdG8vb2xGb0hOM1QyUGZxWXlQTGNlNjRZTzdValhwZjdzdWJOblkvQXlv?=
 =?utf-8?B?VzE3TUJCZzA4dnVCdWJnVnA1OEg0L01pYnhkQUdjcnM3b0VVUTRvblYvUkda?=
 =?utf-8?B?Q1M0Y3dXY1R4R1VKUy9nTE1HM01DMFdKdWlkRXJjS1J5akV6eERWbXVjK3hE?=
 =?utf-8?B?aHUvOG9JYWI1Z00vNmRsQis5ZVo3WDJzSHM1V1BiMVhPclpadzhUKy9aZEpU?=
 =?utf-8?B?OXM2WWg4U3NxRW5qR2VIamdjZGNDemd1ZWM5VVd2b2x2QTJhd1g5bi9UbG1w?=
 =?utf-8?B?VGNsRGEyeXkvaXJkWXQ4aS9MNGY4Y0xXOG9oV3AreExZcDBPTFVUZEw1dUx6?=
 =?utf-8?B?d1VRYWFCUzk4MklIMlI2OUpqNStYbG5IL0ZWUmFSUk9lMXU5cWEwYXhOR1dk?=
 =?utf-8?B?ZCt5ZVBFcmFpVzlHYm5uL2lpd2tuSnN2bmxpazZIT0pWdEV6THBnaThNOWho?=
 =?utf-8?B?UGFWa0tqOHhxYUlyNSthdlZiNzBmL3h4NlZTbmNQUG9Wb1pPMCs2L3c2R1lP?=
 =?utf-8?B?Z1p6dWtrQW5vcE13ell0SkFiVDVvMkRiblVYMGZXQzg0YSs1TEE2UjhrUndW?=
 =?utf-8?B?RGZDbkUyazh6cC9GdDl5QS9VQjFJV0MvZ1JNc0RCUWlIbnl0THFwT1lUMTJJ?=
 =?utf-8?Q?KKr6dgFxoaYZ//Tw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe92e43c-7bf8-438f-0c88-08df09ae2106
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:25:59.5245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLRPKHLPPIwKC3fgcCDwwSvL2EMppS9zKc9LrsBU4eDcQxBACCeUHctHbD9AiQLL6f8yfN33suW2slHIKAl85xXlYRedSmkfTGMEXFTUVYE=
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

The Synopsys DesignWare Mobile Storage Host predates SDHCI and uses
a distinct MCI programming interface. It is integrated by Samsung
Exynos, Rockchip, HiSilicon, and Altera/Intel SoCFPGA platforms,
among others.

Add a reusable controller model based on the DesignWare Mobile Storage
Host 2.40a databook. Cover command and response handling, PIO FIFO
aliases, reset and interrupt semantics, card state, and the standard
32-bit internal descriptor DMA engine. Also support the later 64-bit
descriptor layout used by vendor variants.

Expose class hooks and immutable configuration fields so vendor
extensions can reuse the common implementation.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 MAINTAINERS            |    2 +
 hw/sd/Kconfig          |    5 +
 hw/sd/dw_mci.c         | 1382 ++++++++++++++++++++++++++++++++++++++++
 hw/sd/meson.build      |    1 +
 include/hw/sd/dw_mci.h |   74 +++
 5 files changed, 1464 insertions(+)
 create mode 100644 hw/sd/dw_mci.c
 create mode 100644 include/hw/sd/dw_mci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a1830cdad1..1ea3af260f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2411,8 +2411,10 @@ M: Philippe Mathieu-Daudé <philmd@mailo.com>
 M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
+F: include/hw/sd/dw_mci.h
 F: include/hw/sd/sd*
 F: hw/sd/core.c
+F: hw/sd/dw_mci.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
 F: tests/qtest/fuzz-sdcard-test.c
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index c69bf24f8d..dc3ebefa52 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -10,6 +10,11 @@ config SSI_SD
 config SD
     bool
 
+config DW_MCI
+    bool
+    select REGISTER
+    select SD
+
 config SDHCI
     bool
     select SD
diff --git a/hw/sd/dw_mci.c b/hw/sd/dw_mci.c
new file mode 100644
index 0000000000..245435f43e
--- /dev/null
+++ b/hw/sd/dw_mci.c
@@ -0,0 +1,1382 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/dw_mci.h"
+
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "system/address-spaces.h"
+#include "system/dma.h"
+
+REG32(CTRL, 0x000)
+    FIELD(CTRL, RESET, 0, 1)
+    FIELD(CTRL, FIFO_RESET, 1, 1)
+    FIELD(CTRL, DMA_RESET, 2, 1)
+    FIELD(CTRL, INT_ENABLE, 4, 1)
+    FIELD(CTRL, DMA_ENABLE, 5, 1)
+    FIELD(CTRL, USE_IDMAC, 25, 1)
+REG32(PWREN, 0x004)
+REG32(CLKDIV, 0x008)
+REG32(CLKSRC, 0x00c)
+REG32(CLKENA, 0x010)
+REG32(TMOUT, 0x014)
+REG32(CTYPE, 0x018)
+REG32(BLKSIZ, 0x01c)
+REG32(BYTCNT, 0x020)
+REG32(INTMASK, 0x024)
+REG32(CMDARG, 0x028)
+REG32(CMD, 0x02c)
+    FIELD(CMD, INDEX, 0, 6)
+    FIELD(CMD, RESP_EXP, 6, 1)
+    FIELD(CMD, RESP_LONG, 7, 1)
+    FIELD(CMD, RESP_CRC, 8, 1)
+    FIELD(CMD, DAT_EXP, 9, 1)
+    FIELD(CMD, DAT_WR, 10, 1)
+    FIELD(CMD, SEND_STOP, 12, 1)
+    FIELD(CMD, STOP, 14, 1)
+    FIELD(CMD, UPD_CLK, 21, 1)
+    FIELD(CMD, START, 31, 1)
+REG32(RESP0, 0x030)
+REG32(RESP1, 0x034)
+REG32(RESP2, 0x038)
+REG32(RESP3, 0x03c)
+REG32(MINTSTS, 0x040)
+REG32(RINTSTS, 0x044)
+REG32(STATUS, 0x048)
+    FIELD(STATUS, FIFO_RX_WMARK, 0, 1)
+    FIELD(STATUS, FIFO_TX_WMARK, 1, 1)
+    FIELD(STATUS, FIFO_EMPTY, 2, 1)
+    FIELD(STATUS, FIFO_FULL, 3, 1)
+    FIELD(STATUS, BUSY, 9, 1)
+    FIELD(STATUS, RESPONSE_INDEX, 11, 6)
+    FIELD(STATUS, FIFO_COUNT, 17, 13)
+REG32(FIFOTH, 0x04c)
+    FIELD(FIFOTH, TX_WMARK, 0, 12)
+    FIELD(FIFOTH, RX_WMARK, 16, 12)
+    FIELD(FIFOTH, MSIZE, 28, 3)
+REG32(CDETECT, 0x050)
+REG32(WRTPRT, 0x054)
+REG32(GPIO, 0x058)
+REG32(TCBCNT, 0x05c)
+REG32(TBBCNT, 0x060)
+REG32(DEBNCE, 0x064)
+REG32(USRID, 0x068)
+REG32(VERID, 0x06c)
+REG32(HCON, 0x070)
+    FIELD(HCON, CARD_TYPE, 0, 1)
+    FIELD(HCON, NUM_CARDS, 1, 5)
+    FIELD(HCON, HBUS_TYPE, 6, 1)
+    FIELD(HCON, HDATA_WIDTH, 7, 3)
+    FIELD(HCON, HADDR_WIDTH, 10, 6)
+    FIELD(HCON, TRANS_MODE, 16, 2)
+    FIELD(HCON, FIFO_RAM_INSIDE, 21, 1)
+    FIELD(HCON, HOLD_REG, 22, 1)
+    /* Later revisions use bit 27 to advertise 64-bit IDMAC addresses */
+    FIELD(HCON, ADDR_CONFIG, 27, 1)
+REG32(UHS_REG, 0x074)
+REG32(RST_N, 0x078)
+REG32(BMOD, 0x080)
+    FIELD(BMOD, SWRESET, 0, 1)
+    FIELD(BMOD, FIXED_BURST, 1, 1)
+    FIELD(BMOD, DSL, 2, 5)
+    FIELD(BMOD, ENABLE, 7, 1)
+    FIELD(BMOD, PBL, 8, 3)
+REG32(PLDMND, 0x084)
+REG32(IDMAC_088, 0x088)
+REG32(IDMAC_08C, 0x08c)
+REG32(IDMAC_090, 0x090)
+REG32(IDMAC_094, 0x094)
+REG32(IDMAC_098, 0x098)
+REG32(IDMAC_09C, 0x09c)
+REG32(IDMAC_0A0, 0x0a0)
+REG32(IDMAC_0A4, 0x0a4)
+REG32(CDTHRCTL, 0x100)
+REG32(BACK_END_POWER, 0x104)
+REG32(UHS_REG_EXT, 0x108)
+REG32(DDR_REG, 0x10c)
+REG32(ENABLE_SHIFT, 0x110)
+
+#define DW_MCI_INT_CD               BIT(0)
+#define DW_MCI_INT_RESP_ERR         BIT(1)
+#define DW_MCI_INT_CMD_DONE         BIT(2)
+#define DW_MCI_INT_DATA_OVER        BIT(3)
+#define DW_MCI_INT_TXDR             BIT(4)
+#define DW_MCI_INT_RXDR             BIT(5)
+#define DW_MCI_INT_RCRC             BIT(6)
+#define DW_MCI_INT_DCRC             BIT(7)
+#define DW_MCI_INT_RTO              BIT(8)
+#define DW_MCI_INT_DRTO             BIT(9)
+#define DW_MCI_INT_HTO              BIT(10)
+#define DW_MCI_INT_FRUN             BIT(11)
+#define DW_MCI_INT_HLE              BIT(12)
+#define DW_MCI_INT_SBE              BIT(13)
+#define DW_MCI_INT_ACD              BIT(14)
+#define DW_MCI_INT_EBE              BIT(15)
+
+#define DW_MCI_IDSTS_TI             BIT(0)
+#define DW_MCI_IDSTS_RI             BIT(1)
+#define DW_MCI_IDSTS_FBE            BIT(2)
+#define DW_MCI_IDSTS_DU             BIT(4)
+#define DW_MCI_IDSTS_CES            BIT(5)
+#define DW_MCI_IDSTS_NI             BIT(8)
+#define DW_MCI_IDSTS_AI             BIT(9)
+#define DW_MCI_IDSTS_NORMAL         (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_RI)
+#define DW_MCI_IDSTS_ABNORMAL       (DW_MCI_IDSTS_FBE | DW_MCI_IDSTS_DU | \
+                                     DW_MCI_IDSTS_CES)
+#define DW_MCI_IDSTS_MASK           (DW_MCI_IDSTS_TI | DW_MCI_IDSTS_RI | \
+                                     DW_MCI_IDSTS_FBE | DW_MCI_IDSTS_DU | \
+                                     DW_MCI_IDSTS_CES | DW_MCI_IDSTS_NI | \
+                                     DW_MCI_IDSTS_AI)
+
+#define DW_MCI_IDMAC_DIC            BIT(1)
+#define DW_MCI_IDMAC_LD             BIT(2)
+#define DW_MCI_IDMAC_FS             BIT(3)
+#define DW_MCI_IDMAC_CH             BIT(4)
+#define DW_MCI_IDMAC_ER             BIT(5)
+#define DW_MCI_IDMAC_CES            BIT(30)
+#define DW_MCI_IDMAC_OWN            BIT(31)
+#define DW_MCI_IDMAC_SIZE_MASK      0x1fff
+#define DW_MCI_IDMAC_SIZE2_SHIFT    13
+#define DW_MCI_IDMAC_MAX_DESCS      4096
+#define DW_MCI_DMA_CHUNK_SIZE       1024
+
+#define DW_MCI_IDMAC_FSM_IDLE       0
+#define DW_MCI_IDMAC_FSM_SUSPEND    1
+
+#define TYPE_DW_MCI_BUS "dw-mci-bus"
+
+typedef struct DwMciIdmac32 {
+    uint32_t control;
+    uint32_t sizes;
+    uint32_t buffer;
+    uint32_t next;
+} DwMciIdmac32;
+
+typedef struct DwMciIdmac64 {
+    uint32_t control;
+    uint32_t reserved0;
+    uint32_t sizes;
+    uint32_t reserved1;
+    uint32_t buffer_lo;
+    uint32_t buffer_hi;
+    uint32_t next_lo;
+    uint32_t next_hi;
+} DwMciIdmac64;
+
+typedef struct DwMciDescriptor {
+    uint32_t control;
+    uint32_t size[2];
+    uint64_t buffer[2];
+    uint64_t next;
+} DwMciDescriptor;
+
+static bool dw_mci_run_idmac(DwMciState *s);
+
+static bool dw_mci_is_64bit(DwMciState *s)
+{
+    return s->hcon & R_HCON_ADDR_CONFIG_MASK;
+}
+
+/*
+ * The 64-bit layout inserts DBADDRU at 0x8c, shifting IDSTS and IDINTEN one
+ * register higher than their locations in the legacy layout.
+ */
+static unsigned dw_mci_idsts_reg(DwMciState *s)
+{
+    return dw_mci_is_64bit(s) ? R_IDMAC_090 : R_IDMAC_08C;
+}
+
+static unsigned dw_mci_idinten_reg(DwMciState *s)
+{
+    return dw_mci_is_64bit(s) ? R_IDMAC_094 : R_IDMAC_090;
+}
+
+static uint32_t dw_mci_host_bus_bytes(DwMciState *s)
+{
+    unsigned width = FIELD_EX32(s->hcon, HCON, HDATA_WIDTH);
+
+    return width <= 2 ? 2U << width : sizeof(uint32_t);
+}
+
+static void dw_mci_set_idmac_fsm(DwMciState *s, uint32_t state)
+{
+    unsigned idsts = dw_mci_idsts_reg(s);
+
+    s->regs[idsts] = deposit32(s->regs[idsts], 13, 4, state);
+}
+
+static uint64_t dw_mci_descriptor_base(DwMciState *s)
+{
+    uint64_t address = s->regs[R_IDMAC_088];
+
+    if (dw_mci_is_64bit(s)) {
+        address |= (uint64_t)s->regs[R_IDMAC_08C] << 32;
+    }
+    return address;
+}
+
+static uint32_t dw_mci_fifo_capacity(DwMciState *s)
+{
+    return MIN(s->fifo_depth, (uint32_t)DW_MCI_FIFO_MAX_WORDS) * 4;
+}
+
+static void dw_mci_fifo_reset(DwMciState *s)
+{
+    s->fifo_head = 0;
+    s->fifo_len = 0;
+    memset(s->fifo, 0, sizeof(s->fifo));
+}
+
+static void dw_mci_fifo_push(DwMciState *s, const uint8_t *data,
+                             uint32_t length)
+{
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+    uint32_t tail = (s->fifo_head + s->fifo_len) % capacity;
+
+    while (length--) {
+        s->fifo[tail] = *data++;
+        tail = (tail + 1) % capacity;
+        s->fifo_len++;
+    }
+}
+
+static void dw_mci_fifo_pop(DwMciState *s, uint8_t *data, uint32_t length)
+{
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    while (length--) {
+        *data++ = s->fifo[s->fifo_head];
+        s->fifo_head = (s->fifo_head + 1) % capacity;
+        s->fifo_len--;
+    }
+    if (!s->fifo_len) {
+        s->fifo_head = 0;
+    }
+}
+
+static void dw_mci_update_irq(DwMciState *s)
+{
+    uint32_t core = s->regs[R_RINTSTS] & s->regs[R_INTMASK];
+    uint32_t idsts = s->regs[dw_mci_idsts_reg(s)];
+    uint32_t idinten = s->regs[dw_mci_idinten_reg(s)];
+    bool core_irq = (s->regs[R_CTRL] & R_CTRL_INT_ENABLE_MASK) && core;
+    bool idmac_irq = ((idsts & DW_MCI_IDSTS_NI) &&
+                      (idinten & DW_MCI_IDSTS_NI)) ||
+                     ((idsts & DW_MCI_IDSTS_AI) &&
+                      (idinten & DW_MCI_IDSTS_AI));
+
+    /* The top-level interrupt is the logical OR of the BIU and IDMAC lines */
+    qemu_set_irq(s->irq, core_irq || idmac_irq);
+}
+
+static void dw_mci_set_idmac_status(DwMciState *s, uint32_t status)
+{
+    unsigned idsts = dw_mci_idsts_reg(s);
+    uint32_t idinten = s->regs[dw_mci_idinten_reg(s)];
+
+    s->regs[idsts] |= status;
+
+    /*
+     * NIS and AIS are sticky summary events, not aliases of the individual
+     * status bits.  The databook requires both the member interrupt and its
+     * group interrupt to be enabled before the summary is raised.
+     */
+    if ((status & DW_MCI_IDSTS_NORMAL & idinten) &&
+        (idinten & DW_MCI_IDSTS_NI)) {
+        s->regs[idsts] |= DW_MCI_IDSTS_NI;
+    }
+    if ((status & DW_MCI_IDSTS_ABNORMAL & idinten) &&
+        (idinten & DW_MCI_IDSTS_AI)) {
+        s->regs[idsts] |= DW_MCI_IDSTS_AI;
+    }
+}
+
+static void dw_mci_update_fifo_interrupts(DwMciState *s)
+{
+    uint32_t fifo_words = DIV_ROUND_UP(s->fifo_len, sizeof(uint32_t));
+    uint32_t tx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, TX_WMARK);
+    uint32_t rx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, RX_WMARK);
+
+    if (!s->transfer_active) {
+        s->regs[R_RINTSTS] &= ~(DW_MCI_INT_RXDR | DW_MCI_INT_TXDR);
+    } else if (s->transfer_write) {
+        if (fifo_words <= tx_wmark) {
+            s->regs[R_RINTSTS] |= DW_MCI_INT_TXDR;
+        } else {
+            s->regs[R_RINTSTS] &= ~DW_MCI_INT_TXDR;
+        }
+        s->regs[R_RINTSTS] &= ~DW_MCI_INT_RXDR;
+    } else {
+        if (fifo_words > rx_wmark) {
+            s->regs[R_RINTSTS] |= DW_MCI_INT_RXDR;
+        } else {
+            s->regs[R_RINTSTS] &= ~DW_MCI_INT_RXDR;
+        }
+        s->regs[R_RINTSTS] &= ~DW_MCI_INT_TXDR;
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_send_auto_stop(DwMciState *s)
+{
+    SDRequest request = { .cmd = 12, .arg = 0 };
+    uint8_t response[16];
+    size_t response_len;
+
+    if (!s->transfer_send_stop) {
+        return;
+    }
+    s->transfer_send_stop = false;
+    response_len = sdbus_do_command(&s->sdbus, &request, response,
+                                    sizeof(response));
+    if (response_len == sizeof(uint32_t)) {
+        /* Auto-stop preserves the preceding response in RESP0 */
+        s->regs[R_RESP1] = ldl_be_p(response);
+        s->regs[R_STATUS] = FIELD_DP32(s->regs[R_STATUS], STATUS,
+                                       RESPONSE_INDEX, request.cmd);
+    }
+    s->regs[R_RINTSTS] |= DW_MCI_INT_ACD;
+}
+
+static void dw_mci_complete_data(DwMciState *s)
+{
+    dw_mci_send_auto_stop(s);
+    s->regs[R_RINTSTS] |= DW_MCI_INT_DATA_OVER;
+    s->transfer_active = false;
+    s->transfer_remaining = 0;
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_set_data_error(DwMciState *s)
+{
+    s->regs[R_RINTSTS] |= DW_MCI_INT_DRTO;
+    s->transfer_active = false;
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_refill_fifo(DwMciState *s)
+{
+    uint8_t buffer[DW_MCI_DMA_CHUNK_SIZE];
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    while (s->transfer_active && !s->transfer_write &&
+           s->transfer_remaining && s->fifo_len < capacity) {
+        uint32_t length = MIN((uint32_t)sizeof(buffer),
+                              s->transfer_remaining);
+
+        length = MIN(length, capacity - s->fifo_len);
+        sdbus_read_data(&s->sdbus, buffer, length);
+        dw_mci_fifo_push(s, buffer, length);
+        s->transfer_remaining -= length;
+        s->regs[R_TCBCNT] += length;
+    }
+    if (!s->transfer_remaining) {
+        /*
+         * DATA_OVER follows completion at the card side. Keep the transfer
+         * active until the guest drains prefetched data so FIFO status still
+         * describes the readable bytes.
+         */
+        s->regs[R_RINTSTS] |= DW_MCI_INT_DATA_OVER;
+    }
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_store_response(DwMciState *s, const uint8_t *response,
+                                  size_t length)
+{
+    s->regs[R_RESP0] = 0;
+    s->regs[R_RESP1] = 0;
+    s->regs[R_RESP2] = 0;
+    s->regs[R_RESP3] = 0;
+
+    if (length == 4) {
+        s->regs[R_RESP0] = ldl_be_p(response);
+    } else if (length == 16) {
+        /*
+         * SDBus returns a long response most-significant word first, while
+         * the controller exposes its least-significant word in RESP0.
+         */
+        s->regs[R_RESP0] = ldl_be_p(response + 12);
+        s->regs[R_RESP1] = ldl_be_p(response + 8);
+        s->regs[R_RESP2] = ldl_be_p(response + 4);
+        s->regs[R_RESP3] = ldl_be_p(response);
+    }
+}
+
+static bool dw_mci_idmac_armed(DwMciState *s)
+{
+    return (s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK) &&
+           (s->regs[R_BMOD] & R_BMOD_ENABLE_MASK) &&
+           FIELD_EX32(s->hcon, HCON, TRANS_MODE) == 0 &&
+           !s->idmac_fatal;
+}
+
+static bool dw_mci_send_command(DwMciState *s, uint32_t command)
+{
+    SDRequest request = { 0 };
+    uint8_t response[16];
+    bool response_expected = command & R_CMD_RESP_EXP_MASK;
+    bool long_response = command & R_CMD_RESP_LONG_MASK;
+    size_t response_len;
+
+    s->regs[R_CMD] = command & ~R_CMD_START_MASK;
+
+    if (command & R_CMD_UPD_CLK_MASK) {
+        /* No card command is sent, so the CIU must not raise Command Done */
+        return true;
+    }
+
+    if (!sdbus_get_inserted(&s->sdbus) && response_expected) {
+        s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO;
+        dw_mci_update_irq(s);
+        return false;
+    }
+
+    request.cmd = FIELD_EX32(command, CMD, INDEX);
+    request.arg = s->regs[R_CMDARG];
+    response_len = sdbus_do_command(&s->sdbus, &request, response,
+                                    sizeof(response));
+
+    if (response_expected &&
+        ((!long_response && response_len != 4) ||
+         (long_response && response_len != 16))) {
+        s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE | DW_MCI_INT_RTO;
+        dw_mci_update_irq(s);
+        return false;
+    }
+    if (response_expected) {
+        dw_mci_store_response(s, response, response_len);
+        s->regs[R_STATUS] = FIELD_DP32(s->regs[R_STATUS], STATUS,
+                                       RESPONSE_INDEX, request.cmd);
+    }
+
+    s->regs[R_RINTSTS] |= DW_MCI_INT_CMD_DONE;
+
+    if (command & R_CMD_STOP_MASK) {
+        s->transfer_active = false;
+        s->transfer_remaining = 0;
+        s->transfer_send_stop = false;
+        dw_mci_update_fifo_interrupts(s);
+        return true;
+    }
+
+    if (command & R_CMD_DAT_EXP_MASK) {
+        if (!sdbus_get_inserted(&s->sdbus) || !s->regs[R_BYTCNT]) {
+            dw_mci_set_data_error(s);
+            return false;
+        }
+        dw_mci_fifo_reset(s);
+        s->regs[R_TCBCNT] = 0;
+        s->regs[R_TBBCNT] = 0;
+        s->transfer_remaining = s->regs[R_BYTCNT];
+        s->transfer_active = true;
+        s->transfer_write = command & R_CMD_DAT_WR_MASK;
+        s->transfer_send_stop = command & R_CMD_SEND_STOP_MASK;
+        s->idmac_desc_addr = dw_mci_descriptor_base(s);
+        s->idmac_suspended = false;
+        dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+
+        if (dw_mci_idmac_armed(s)) {
+            dw_mci_run_idmac(s);
+        } else if (s->transfer_write) {
+            dw_mci_update_fifo_interrupts(s);
+        } else {
+            dw_mci_refill_fifo(s);
+        }
+    }
+
+    dw_mci_update_irq(s);
+    return true;
+}
+
+static void dw_mci_set_current_descriptor(DwMciState *s,
+                                          uint64_t descriptor,
+                                          uint64_t buffer)
+{
+    if (dw_mci_is_64bit(s)) {
+        s->regs[R_IDMAC_098] = descriptor;
+        s->regs[R_IDMAC_09C] = descriptor >> 32;
+        s->regs[R_IDMAC_0A0] = buffer;
+        s->regs[R_IDMAC_0A4] = buffer >> 32;
+    } else {
+        s->regs[R_IDMAC_094] = descriptor;
+        s->regs[R_IDMAC_098] = buffer;
+    }
+}
+
+static bool dw_mci_read_descriptor32(uint64_t address,
+                                     DwMciDescriptor *result)
+{
+    DwMciIdmac32 descriptor;
+    MemTxResult tx_result;
+
+    tx_result = dma_memory_read(&address_space_memory, address, &descriptor,
+                                sizeof(descriptor), MEMTXATTRS_UNSPECIFIED);
+    if (tx_result != MEMTX_OK) {
+        return false;
+    }
+
+    result->control = le32_to_cpu(descriptor.control);
+    result->size[0] = le32_to_cpu(descriptor.sizes) &
+                      DW_MCI_IDMAC_SIZE_MASK;
+    result->size[1] = (le32_to_cpu(descriptor.sizes) >>
+                       DW_MCI_IDMAC_SIZE2_SHIFT) & DW_MCI_IDMAC_SIZE_MASK;
+    result->buffer[0] = le32_to_cpu(descriptor.buffer);
+    result->buffer[1] = le32_to_cpu(descriptor.next);
+    result->next = result->buffer[1];
+    return true;
+}
+
+static bool dw_mci_read_descriptor64(uint64_t address,
+                                     DwMciDescriptor *result)
+{
+    DwMciIdmac64 descriptor;
+    MemTxResult tx_result;
+
+    tx_result = dma_memory_read(&address_space_memory, address, &descriptor,
+                                sizeof(descriptor), MEMTXATTRS_UNSPECIFIED);
+    if (tx_result != MEMTX_OK) {
+        return false;
+    }
+
+    result->control = le32_to_cpu(descriptor.control);
+    result->size[0] = le32_to_cpu(descriptor.sizes) &
+                      DW_MCI_IDMAC_SIZE_MASK;
+    result->size[1] = 0;
+    result->buffer[0] = le32_to_cpu(descriptor.buffer_lo) |
+                        (uint64_t)le32_to_cpu(descriptor.buffer_hi) << 32;
+    result->buffer[1] = 0;
+    result->next = le32_to_cpu(descriptor.next_lo) |
+                   (uint64_t)le32_to_cpu(descriptor.next_hi) << 32;
+    return true;
+}
+
+static bool dw_mci_write_descriptor_control(uint64_t address,
+                                            uint32_t control)
+{
+    uint32_t value = cpu_to_le32(control);
+
+    return dma_memory_write(&address_space_memory, address, &value,
+                            sizeof(value), MEMTXATTRS_UNSPECIFIED) == MEMTX_OK;
+}
+
+static bool dw_mci_transfer_buffer(DwMciState *s, uint64_t address,
+                                   uint32_t length)
+{
+    uint8_t buffer[DW_MCI_DMA_CHUNK_SIZE];
+
+    while (length) {
+        uint32_t chunk = MIN(length, (uint32_t)sizeof(buffer));
+        MemTxResult result;
+
+        if (s->transfer_write) {
+            result = dma_memory_read(&address_space_memory, address, buffer,
+                                     chunk, MEMTXATTRS_UNSPECIFIED);
+            if (result != MEMTX_OK) {
+                return false;
+            }
+            sdbus_write_data(&s->sdbus, buffer, chunk);
+        } else {
+            sdbus_read_data(&s->sdbus, buffer, chunk);
+            result = dma_memory_write(&address_space_memory, address, buffer,
+                                      chunk, MEMTXATTRS_UNSPECIFIED);
+            if (result != MEMTX_OK) {
+                return false;
+            }
+        }
+
+        address += chunk;
+        length -= chunk;
+        s->transfer_remaining -= chunk;
+        s->regs[R_TCBCNT] += chunk;
+        s->regs[R_TBBCNT] += chunk;
+    }
+    return true;
+}
+
+static void dw_mci_suspend_idmac(DwMciState *s)
+{
+    s->idmac_suspended = true;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_SUSPEND);
+    dw_mci_set_idmac_status(s, DW_MCI_IDSTS_DU);
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_fatal_idmac_error(DwMciState *s)
+{
+    s->idmac_fatal = true;
+    s->idmac_suspended = false;
+    s->transfer_active = false;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+    dw_mci_set_idmac_status(s, DW_MCI_IDSTS_FBE);
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static uint64_t dw_mci_next_descriptor(DwMciState *s,
+                                       const DwMciDescriptor *descriptor,
+                                       uint64_t current,
+                                       uint32_t descriptor_size)
+{
+    if (descriptor->control & DW_MCI_IDMAC_CH) {
+        return descriptor->next &
+               ~(uint64_t)(dw_mci_host_bus_bytes(s) - 1);
+    }
+    if (descriptor->control & DW_MCI_IDMAC_ER) {
+        return dw_mci_descriptor_base(s);
+    }
+
+    /* DSL is expressed in host-bus-width units, not bytes */
+    return current + descriptor_size +
+           FIELD_EX32(s->regs[R_BMOD], BMOD, DSL) *
+           dw_mci_host_bus_bytes(s);
+}
+
+static bool dw_mci_run_idmac(DwMciState *s)
+{
+    uint32_t descriptor_size = dw_mci_is_64bit(s) ?
+                               sizeof(DwMciIdmac64) :
+                               sizeof(DwMciIdmac32);
+    unsigned int count = 0;
+
+    if (!s->transfer_active || !dw_mci_idmac_armed(s)) {
+        return false;
+    }
+    if (!s->idmac_desc_addr) {
+        s->idmac_desc_addr = dw_mci_descriptor_base(s);
+    }
+    if (!s->idmac_desc_addr) {
+        dw_mci_suspend_idmac(s);
+        return false;
+    }
+
+    /*
+     * Bound descriptor traversal so a cyclic guest chain cannot monopolize
+     * the vCPU. Exhaustion follows the descriptor-unavailable suspend path
+     * below, allowing the guest to recover through PLDMND.
+     */
+    while (s->transfer_remaining && count++ < DW_MCI_IDMAC_MAX_DESCS) {
+        DwMciDescriptor descriptor = { 0 };
+        uint64_t descriptor_address = s->idmac_desc_addr;
+        bool read_ok;
+        unsigned int i;
+
+        dw_mci_set_current_descriptor(s, descriptor_address, 0);
+        if (dw_mci_is_64bit(s)) {
+            read_ok = dw_mci_read_descriptor64(descriptor_address,
+                                               &descriptor);
+        } else {
+            read_ok = dw_mci_read_descriptor32(descriptor_address,
+                                               &descriptor);
+        }
+        if (!read_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to read IDMAC descriptor at "
+                          "0x%" PRIx64 "\n",
+                          TYPE_DW_MCI, descriptor_address);
+            dw_mci_fatal_idmac_error(s);
+            return false;
+        }
+        if (!(descriptor.control & DW_MCI_IDMAC_OWN)) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+
+        for (i = 0; i < ARRAY_SIZE(descriptor.buffer) &&
+                    s->transfer_remaining; i++) {
+            uint64_t buffer_address;
+            uint32_t length = MIN(descriptor.size[i],
+                                  s->transfer_remaining);
+
+            /* DES3 is a next-descriptor pointer in chained mode */
+            if (i == 1 && (descriptor.control & DW_MCI_IDMAC_CH)) {
+                break;
+            }
+            if (!length) {
+                continue;
+            }
+            buffer_address = descriptor.buffer[i] &
+                             ~(uint64_t)(dw_mci_host_bus_bytes(s) - 1);
+            dw_mci_set_current_descriptor(s, descriptor_address,
+                                          buffer_address);
+            if (!dw_mci_transfer_buffer(s, buffer_address, length)) {
+                dw_mci_fatal_idmac_error(s);
+                return false;
+            }
+        }
+
+        descriptor.control &= ~DW_MCI_IDMAC_OWN;
+        if (!dw_mci_write_descriptor_control(descriptor_address,
+                                             descriptor.control)) {
+            dw_mci_fatal_idmac_error(s);
+            return false;
+        }
+
+        if (!(descriptor.control & DW_MCI_IDMAC_DIC)) {
+            dw_mci_set_idmac_status(s, s->transfer_write ?
+                                    DW_MCI_IDSTS_TI : DW_MCI_IDSTS_RI);
+        }
+
+        if (!s->transfer_remaining) {
+            break;
+        }
+        if (descriptor.control & DW_MCI_IDMAC_LD) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+
+        s->idmac_desc_addr = dw_mci_next_descriptor(s, &descriptor,
+                                                    descriptor_address,
+                                                    descriptor_size);
+        if (!s->idmac_desc_addr) {
+            dw_mci_suspend_idmac(s);
+            return false;
+        }
+    }
+
+    if (s->transfer_remaining) {
+        dw_mci_suspend_idmac(s);
+        return false;
+    }
+
+    s->idmac_suspended = false;
+    dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+    dw_mci_complete_data(s);
+    dw_mci_update_irq(s);
+    return true;
+}
+
+static uint64_t dw_mci_read_data(DwMciState *s, unsigned size)
+{
+    uint8_t buffer[sizeof(uint64_t)] = { 0 };
+    uint32_t length;
+
+    if (!s->transfer_active || s->transfer_write) {
+        return 0;
+    }
+    if (!s->fifo_len && s->transfer_remaining) {
+        dw_mci_refill_fifo(s);
+    }
+
+    length = MIN((uint32_t)size, s->fifo_len);
+    if (length) {
+        dw_mci_fifo_pop(s, buffer, length);
+        s->regs[R_TBBCNT] += length;
+    }
+    if (s->transfer_remaining) {
+        dw_mci_refill_fifo(s);
+    }
+    if (!s->transfer_remaining && !s->fifo_len) {
+        dw_mci_complete_data(s);
+    } else {
+        dw_mci_update_fifo_interrupts(s);
+    }
+    return ldn_le_p(buffer, size);
+}
+
+static void dw_mci_write_data(DwMciState *s, uint64_t value, unsigned size)
+{
+    uint8_t buffer[sizeof(uint64_t)] = { 0 };
+    uint32_t length;
+
+    if (!s->transfer_active || !s->transfer_write) {
+        return;
+    }
+
+    /*
+     * The functional model consumes PIO writes synchronously through SDBus.
+     * Its FIFO therefore remains empty and TXDR continues to advertise room.
+     */
+    length = MIN((uint32_t)size, s->transfer_remaining);
+    stn_le_p(buffer, size, value);
+    sdbus_write_data(&s->sdbus, buffer, length);
+    s->transfer_remaining -= length;
+    s->regs[R_TCBCNT] += length;
+    s->regs[R_TBBCNT] += length;
+
+    if (!s->transfer_remaining) {
+        dw_mci_complete_data(s);
+    } else {
+        dw_mci_update_fifo_interrupts(s);
+    }
+}
+
+static bool dw_mci_idmac_offset(hwaddr offset)
+{
+    return offset >= A_IDMAC_088 && offset <= A_IDMAC_0A4 &&
+           !(offset & 3);
+}
+
+static uint64_t dw_mci_read_idmac_register(DwMciState *s, hwaddr offset)
+{
+    unsigned reg = offset / sizeof(uint32_t);
+
+    if (!dw_mci_is_64bit(s) && offset > A_IDMAC_098) {
+        return 0;
+    }
+    return s->regs[reg];
+}
+
+static void dw_mci_write_idmac_register(DwMciState *s, hwaddr offset,
+                                        uint32_t value)
+{
+    unsigned reg = offset / sizeof(uint32_t);
+    unsigned idsts = dw_mci_idsts_reg(s);
+    unsigned idinten = dw_mci_idinten_reg(s);
+
+    if (reg == idsts) {
+        s->regs[reg] &= ~(value & DW_MCI_IDSTS_MASK);
+    } else if (reg == idinten) {
+        s->regs[reg] = value & DW_MCI_IDSTS_MASK;
+    } else if (offset == A_IDMAC_088) {
+        s->regs[reg] = value & ~(dw_mci_host_bus_bytes(s) - 1);
+    } else if (dw_mci_is_64bit(s) && offset == A_IDMAC_08C) {
+        s->regs[reg] = value;
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_reset_idmac(DwMciState *s)
+{
+    s->regs[R_BMOD] = 0;
+    s->regs[R_IDMAC_088] = 0;
+    if (dw_mci_is_64bit(s)) {
+        s->regs[R_IDMAC_08C] = 0;
+        s->regs[R_IDMAC_090] = 0;
+        s->regs[R_IDMAC_094] = 0;
+        s->regs[R_IDMAC_098] = 0;
+        s->regs[R_IDMAC_09C] = 0;
+        s->regs[R_IDMAC_0A0] = 0;
+        s->regs[R_IDMAC_0A4] = 0;
+    } else {
+        s->regs[R_IDMAC_08C] = 0;
+        s->regs[R_IDMAC_090] = 0;
+        s->regs[R_IDMAC_094] = 0;
+        s->regs[R_IDMAC_098] = 0;
+    }
+    s->idmac_desc_addr = 0;
+    s->idmac_suspended = false;
+    s->idmac_fatal = false;
+}
+
+static uint64_t dw_mci_ctrl_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & R_CTRL_RESET_MASK) {
+        /*
+         * CTRL.controller_reset only resets the BIU/CIU interface and its
+         * state machines.  In particular, it must not clear registers, FIFO
+         * contents, interrupt state, or the IDMAC CSR block.
+         */
+        s->transfer_active = false;
+        s->transfer_remaining = 0;
+        s->transfer_send_stop = false;
+        value &= ~(BIT(6) | BIT(7) | BIT(8));
+    }
+    if (value & R_CTRL_FIFO_RESET_MASK) {
+        dw_mci_fifo_reset(s);
+    }
+    /* CTRL.dma_reset belongs to the external DMA handshake, not IDMAC */
+    return value & ~(R_CTRL_RESET_MASK | R_CTRL_FIFO_RESET_MASK |
+                     R_CTRL_DMA_RESET_MASK);
+}
+
+static void dw_mci_ctrl_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_pwren_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & 1) {
+        sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
+    }
+}
+
+static uint64_t dw_mci_cmd_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+    uint32_t command = value;
+
+    if (command & R_CMD_START_MASK) {
+        dw_mci_send_command(s, command);
+    }
+    return command & ~R_CMD_START_MASK;
+}
+
+static void dw_mci_status_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static uint64_t dw_mci_mintsts_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->regs[R_RINTSTS] & s->regs[R_INTMASK];
+}
+
+static uint64_t dw_mci_status_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+    uint32_t fifo_words = DIV_ROUND_UP(s->fifo_len, sizeof(uint32_t));
+    uint32_t tx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, TX_WMARK);
+    uint32_t rx_wmark = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, RX_WMARK);
+    uint32_t status = s->regs[R_STATUS] & R_STATUS_RESPONSE_INDEX_MASK;
+
+    status = FIELD_DP32(status, STATUS, FIFO_COUNT, fifo_words);
+    if (!s->fifo_len) {
+        status |= R_STATUS_FIFO_EMPTY_MASK;
+    }
+    if (s->fifo_len >= capacity) {
+        status |= R_STATUS_FIFO_FULL_MASK;
+    }
+    if (fifo_words > rx_wmark) {
+        status |= R_STATUS_FIFO_RX_WMARK_MASK;
+    }
+    if (fifo_words <= tx_wmark) {
+        status |= R_STATUS_FIFO_TX_WMARK_MASK;
+    }
+    if (s->transfer_active) {
+        status |= R_STATUS_BUSY_MASK;
+    }
+    return status;
+}
+
+static uint64_t dw_mci_cdetect_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return sdbus_get_inserted(&s->sdbus) ? 0 : 1;
+}
+
+static uint64_t dw_mci_wrtprt_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return sdbus_get_readonly(&s->sdbus) ? 1 : 0;
+}
+
+static uint64_t dw_mci_verid_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->verid;
+}
+
+static uint64_t dw_mci_hcon_post_read(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    return s->hcon;
+}
+
+static uint64_t dw_mci_bmod_pre_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (value & R_BMOD_SWRESET_MASK) {
+        uint32_t pbl = FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, MSIZE);
+
+        dw_mci_reset_idmac(s);
+        /* The read-only PBL mirror is not reset with the IDMAC state */
+        s->regs[R_BMOD] = FIELD_DP32(0, BMOD, PBL, pbl);
+        return s->regs[R_BMOD];
+    }
+
+    /* PBL is a read-only mirror of FIFOTH.MSIZE */
+    return FIELD_DP32(value, BMOD, PBL,
+                      FIELD_EX32(s->regs[R_FIFOTH], FIFOTH, MSIZE));
+}
+
+static void dw_mci_bmod_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    if (s->transfer_active && dw_mci_idmac_armed(s)) {
+        dw_mci_run_idmac(s);
+    }
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_pldmnd_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    /* Any write, including zero, releases the descriptor-suspend state */
+    if (s->idmac_suspended && s->transfer_active &&
+        dw_mci_idmac_armed(s)) {
+        s->idmac_suspended = false;
+        dw_mci_set_idmac_fsm(s, DW_MCI_IDMAC_FSM_IDLE);
+        dw_mci_run_idmac(s);
+    }
+}
+
+static uint64_t dw_mci_pldmnd_post_read(RegisterInfo *reg, uint64_t value)
+{
+    return 0;
+}
+
+static void dw_mci_fifoth_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    s->regs[R_BMOD] = FIELD_DP32(s->regs[R_BMOD], BMOD, PBL,
+                                 FIELD_EX32(value, FIFOTH, MSIZE));
+    dw_mci_update_fifo_interrupts(s);
+}
+
+static void dw_mci_uhs_post_write(RegisterInfo *reg, uint64_t value)
+{
+    DwMciState *s = DW_MCI(reg->opaque);
+
+    sdbus_set_voltage(&s->sdbus, value & BIT(0) ?
+                      SD_VOLTAGE_1_8V : SD_VOLTAGE_3_3V);
+}
+
+static const RegisterAccessInfo dw_mci_regs_info[] = {
+    { .name = "CTRL", .addr = A_CTRL, .reset = BIT(24),
+      .pre_write = dw_mci_ctrl_pre_write,
+      .post_write = dw_mci_ctrl_post_write },
+    { .name = "PWREN", .addr = A_PWREN, .ro = UINT32_MAX ^ BIT(0),
+      .post_write = dw_mci_pwren_post_write },
+    { .name = "CLKDIV", .addr = A_CLKDIV, .ro = 0xffffff00 },
+    { .name = "CLKSRC", .addr = A_CLKSRC, .ro = 0xfffffffc },
+    { .name = "CLKENA", .addr = A_CLKENA,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)) },
+    { .name = "TMOUT", .addr = A_TMOUT, .reset = 0xffffff40 },
+    { .name = "CTYPE", .addr = A_CTYPE,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)) },
+    { .name = "BLKSIZ", .addr = A_BLKSIZ, .reset = 0x200,
+      .ro = 0xffff0000 },
+    { .name = "BYTCNT", .addr = A_BYTCNT, .reset = 0x200 },
+    { .name = "INTMASK", .addr = A_INTMASK,
+      .post_write = dw_mci_ctrl_post_write },
+    { .name = "CMDARG", .addr = A_CMDARG },
+    { .name = "CMD", .addr = A_CMD,
+      .pre_write = dw_mci_cmd_pre_write },
+    { .name = "RESP0", .addr = A_RESP0, .ro = UINT32_MAX },
+    { .name = "RESP1", .addr = A_RESP1, .ro = UINT32_MAX },
+    { .name = "RESP2", .addr = A_RESP2, .ro = UINT32_MAX },
+    { .name = "RESP3", .addr = A_RESP3, .ro = UINT32_MAX },
+    { .name = "MINTSTS", .addr = A_MINTSTS, .ro = UINT32_MAX,
+      .post_read = dw_mci_mintsts_post_read },
+    { .name = "RINTSTS", .addr = A_RINTSTS, .w1c = UINT32_MAX,
+      .post_write = dw_mci_status_post_write },
+    { .name = "STATUS", .addr = A_STATUS, .ro = UINT32_MAX,
+      .reset = R_STATUS_FIFO_EMPTY_MASK | R_STATUS_FIFO_TX_WMARK_MASK,
+      .post_read = dw_mci_status_post_read },
+    { .name = "FIFOTH", .addr = A_FIFOTH,
+      .ro = 0x8000f000,
+      .post_write = dw_mci_fifoth_post_write },
+    { .name = "CDETECT", .addr = A_CDETECT, .ro = UINT32_MAX,
+      .post_read = dw_mci_cdetect_post_read },
+    { .name = "WRTPRT", .addr = A_WRTPRT, .ro = UINT32_MAX,
+      .post_read = dw_mci_wrtprt_post_read },
+    { .name = "GPIO", .addr = A_GPIO,
+      .ro = 0xff0000ff },
+    { .name = "TCBCNT", .addr = A_TCBCNT, .ro = UINT32_MAX },
+    { .name = "TBBCNT", .addr = A_TBBCNT, .ro = UINT32_MAX },
+    { .name = "DEBNCE", .addr = A_DEBNCE, .reset = 0x00ffffff,
+      .ro = 0xff000000 },
+    { .name = "USRID", .addr = A_USRID },
+    { .name = "VERID", .addr = A_VERID, .ro = UINT32_MAX,
+      .post_read = dw_mci_verid_post_read },
+    { .name = "HCON", .addr = A_HCON, .ro = UINT32_MAX,
+      .post_read = dw_mci_hcon_post_read },
+    { .name = "UHS_REG", .addr = A_UHS_REG,
+      .ro = UINT32_MAX ^ (BIT(0) | BIT(16)),
+      .post_write = dw_mci_uhs_post_write },
+    { .name = "RST_N", .addr = A_RST_N,
+      .ro = UINT32_MAX ^ BIT(0) },
+    { .name = "BMOD", .addr = A_BMOD, .ro = 0xffffff00,
+      .pre_write = dw_mci_bmod_pre_write,
+      .post_write = dw_mci_bmod_post_write },
+    { .name = "PLDMND", .addr = A_PLDMND,
+      .post_write = dw_mci_pldmnd_post_write,
+      .post_read = dw_mci_pldmnd_post_read },
+    { .name = "CDTHRCTL", .addr = A_CDTHRCTL,
+      .ro = 0xf000fffe },
+    { .name = "BACK_END_POWER", .addr = A_BACK_END_POWER,
+      .ro = UINT32_MAX ^ BIT(0) },
+    { .name = "UHS_REG_EXT", .addr = A_UHS_REG_EXT },
+    { .name = "DDR_REG", .addr = A_DDR_REG },
+    { .name = "ENABLE_SHIFT", .addr = A_ENABLE_SHIFT },
+};
+
+static bool dw_mci_fifo_offset(DwMciState *s, hwaddr offset)
+{
+    return offset >= s->data_offset && offset < DW_MCI_MMIO_SIZE;
+}
+
+static uint64_t dw_mci_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    DwMciState *s = DW_MCI(register_array_get_owner(reg_array));
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    uint64_t value;
+
+    if (dmc->vendor_read && dmc->vendor_read(s, offset, &value, size)) {
+        return value;
+    }
+    if (dw_mci_fifo_offset(s, offset)) {
+        if (s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK) {
+            return 0;
+        }
+        return dw_mci_read_data(s, size);
+    }
+    if (dw_mci_idmac_offset(offset)) {
+        return size == 4 ? dw_mci_read_idmac_register(s, offset) : 0;
+    }
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid %u-byte access at 0x%" HWADDR_PRIx "\n",
+                      TYPE_DW_MCI, size, offset);
+        return 0;
+    }
+    return register_read_memory(opaque, offset, size);
+}
+
+static void dw_mci_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    RegisterInfoArray *reg_array = opaque;
+    DwMciState *s = DW_MCI(register_array_get_owner(reg_array));
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+
+    if (dmc->vendor_write &&
+        dmc->vendor_write(s, offset, value, size)) {
+        return;
+    }
+    if (dw_mci_fifo_offset(s, offset)) {
+        if (!(s->regs[R_CTRL] & R_CTRL_USE_IDMAC_MASK)) {
+            dw_mci_write_data(s, value, size);
+        }
+        return;
+    }
+    if (dw_mci_idmac_offset(offset)) {
+        if (size == 4) {
+            dw_mci_write_idmac_register(s, offset, value);
+        }
+        return;
+    }
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid %u-byte access at 0x%" HWADDR_PRIx "\n",
+                      TYPE_DW_MCI, size, offset);
+        return;
+    }
+    register_write_memory(opaque, offset, value, size);
+}
+
+static const MemoryRegionOps dw_mci_ops = {
+    .read = dw_mci_read,
+    .write = dw_mci_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+};
+
+static void dw_mci_set_inserted(DeviceState *dev, bool inserted)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    if (s->card_inserted == inserted) {
+        return;
+    }
+    s->card_inserted = inserted;
+    s->regs[R_RINTSTS] |= DW_MCI_INT_CD;
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_set_readonly(DeviceState *dev, bool readonly)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    s->card_readonly = readonly;
+}
+
+static void dw_mci_bus_class_init(ObjectClass *klass, const void *data)
+{
+    SDBusClass *sbc = SD_BUS_CLASS(klass);
+
+    sbc->set_inserted = dw_mci_set_inserted;
+    sbc->set_readonly = dw_mci_set_readonly;
+}
+
+static void dw_mci_reset(DeviceState *dev)
+{
+    DwMciState *s = DW_MCI(dev);
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    int i;
+
+    s->transfer_active = false;
+    s->transfer_write = false;
+    s->transfer_send_stop = false;
+    s->transfer_remaining = 0;
+    s->idmac_desc_addr = 0;
+    s->idmac_suspended = false;
+    s->idmac_fatal = false;
+    dw_mci_fifo_reset(s);
+    memset(s->regs, 0, sizeof(s->regs));
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); i++) {
+        register_reset(&s->regs_info[i]);
+    }
+    s->regs[R_FIFOTH] = FIELD_DP32(0, FIFOTH, RX_WMARK,
+                                   s->fifo_depth - 1);
+    s->regs[R_RST_N] = 1;
+    if (dmc->vendor_reset) {
+        dmc->vendor_reset(s);
+    }
+    s->card_inserted = sdbus_get_inserted(&s->sdbus);
+    s->card_readonly = sdbus_get_readonly(&s->sdbus);
+    sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_3_3V);
+    dw_mci_update_irq(s);
+}
+
+static void dw_mci_realize(DeviceState *dev, Error **errp)
+{
+    DwMciState *s = DW_MCI(dev);
+
+    if (!s->fifo_depth || s->fifo_depth > DW_MCI_FIFO_MAX_WORDS) {
+        error_setg(errp, "invalid DW MCI FIFO depth %u", s->fifo_depth);
+        return;
+    }
+    if ((s->data_offset != 0x100 && s->data_offset != 0x200) ||
+        s->data_offset >= DW_MCI_MMIO_SIZE) {
+        error_setg(errp, "invalid DW MCI DATA offset 0x%x",
+                   s->data_offset);
+    }
+}
+
+static int dw_mci_post_load(void *opaque, int version_id)
+{
+    DwMciState *s = opaque;
+    uint32_t capacity = dw_mci_fifo_capacity(s);
+
+    if (s->fifo_head >= capacity || s->fifo_len > capacity) {
+        return -EINVAL;
+    }
+    dw_mci_update_fifo_interrupts(s);
+    return 0;
+}
+
+static const VMStateDescription dw_mci_vmsd = {
+    .name = TYPE_DW_MCI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = dw_mci_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, DwMciState, DW_MCI_REG_COUNT),
+        VMSTATE_UINT8_ARRAY(fifo, DwMciState, DW_MCI_FIFO_MAX_BYTES),
+        VMSTATE_UINT32(fifo_head, DwMciState),
+        VMSTATE_UINT32(fifo_len, DwMciState),
+        VMSTATE_UINT32(transfer_remaining, DwMciState),
+        VMSTATE_UINT64(idmac_desc_addr, DwMciState),
+        VMSTATE_BOOL(transfer_active, DwMciState),
+        VMSTATE_BOOL(transfer_write, DwMciState),
+        VMSTATE_BOOL(transfer_send_stop, DwMciState),
+        VMSTATE_BOOL(idmac_suspended, DwMciState),
+        VMSTATE_BOOL(idmac_fatal, DwMciState),
+        VMSTATE_BOOL(card_inserted, DwMciState),
+        VMSTATE_BOOL(card_readonly, DwMciState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void dw_mci_init(Object *obj)
+{
+    DwMciState *s = DW_MCI(obj);
+    DwMciClass *dmc = DW_MCI_GET_CLASS(s);
+    RegisterInfoArray *reg_array;
+
+    s->verid = dmc->verid;
+    s->hcon = dmc->hcon;
+    s->data_offset = dmc->data_offset;
+    s->fifo_depth = dmc->fifo_depth;
+
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_DW_MCI_BUS,
+              DEVICE(obj), "sd-bus");
+    memory_region_init(&s->iomem, obj, TYPE_DW_MCI, DW_MCI_MMIO_SIZE);
+    reg_array = register_init_block32(DEVICE(obj), dw_mci_regs_info,
+                                      ARRAY_SIZE(dw_mci_regs_info),
+                                      s->regs_info, s->regs,
+                                      &dw_mci_ops, false,
+                                      DW_MCI_MMIO_SIZE);
+    memory_region_add_subregion(&s->iomem, 0, &reg_array->mem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static void dw_mci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    DwMciClass *dmc = DW_MCI_CLASS(klass);
+
+    dmc->verid = 0x5342240a;
+    dmc->hcon = FIELD_DP32(0, HCON, CARD_TYPE, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HBUS_TYPE, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HDATA_WIDTH, 1);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, HADDR_WIDTH, 9);
+    dmc->hcon = FIELD_DP32(dmc->hcon, HCON, FIFO_RAM_INSIDE, 1);
+    dmc->data_offset = 0x200;
+    dmc->fifo_depth = 256;
+
+    dc->realize = dw_mci_realize;
+    dc->vmsd = &dw_mci_vmsd;
+    device_class_set_legacy_reset(dc, dw_mci_reset);
+}
+
+SDBus *dw_mci_get_bus(DwMciState *s)
+{
+    return &s->sdbus;
+}
+
+static const TypeInfo dw_mci_info = {
+    .name = TYPE_DW_MCI,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DwMciState),
+    .instance_init = dw_mci_init,
+    .class_size = sizeof(DwMciClass),
+    .class_init = dw_mci_class_init,
+};
+
+static const TypeInfo dw_mci_bus_info = {
+    .name = TYPE_DW_MCI_BUS,
+    .parent = TYPE_SD_BUS,
+    .instance_size = sizeof(SDBus),
+    .class_size = sizeof(SDBusClass),
+    .class_init = dw_mci_bus_class_init,
+};
+
+static void dw_mci_register_types(void)
+{
+    type_register_static(&dw_mci_bus_info);
+    type_register_static(&dw_mci_info);
+}
+
+type_init(dw_mci_register_types)
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index ebf09e30a4..d7b97cdca4 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
 system_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c'))
+system_ss.add(when: 'CONFIG_DW_MCI', if_true: files('dw_mci.c'))
 system_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
 system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
 system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
diff --git a/include/hw/sd/dw_mci.h b/include/hw/sd/dw_mci.h
new file mode 100644
index 0000000000..de4175540d
--- /dev/null
+++ b/include/hw/sd/dw_mci.h
@@ -0,0 +1,74 @@
+/*
+ * Synopsys DesignWare Multimedia Card Interface
+ *
+ * Copyright (c) 2026 Process Mission
+ *
+ * Author:
+ *   Bin Meng <bin.meng@processmission.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SD_DW_MCI_H
+#define HW_SD_DW_MCI_H
+
+#include "hw/core/register.h"
+#include "hw/core/sysbus.h"
+#include "hw/sd/sd.h"
+#include "qom/object.h"
+
+#define TYPE_DW_MCI "dw-mci"
+OBJECT_DECLARE_TYPE(DwMciState, DwMciClass, DW_MCI)
+
+#define DW_MCI_MMIO_SIZE      0x1000
+#define DW_MCI_REG_COUNT      (DW_MCI_MMIO_SIZE / sizeof(uint32_t))
+#define DW_MCI_FIFO_MAX_WORDS 2048
+#define DW_MCI_FIFO_MAX_BYTES (DW_MCI_FIFO_MAX_WORDS * sizeof(uint32_t))
+
+struct DwMciState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    SDBus sdbus;
+    qemu_irq irq;
+
+    uint32_t regs[DW_MCI_REG_COUNT];
+    RegisterInfo regs_info[DW_MCI_REG_COUNT];
+
+    uint8_t fifo[DW_MCI_FIFO_MAX_BYTES];
+    uint32_t fifo_head;
+    uint32_t fifo_len;
+    uint32_t transfer_remaining;
+    uint64_t idmac_desc_addr;
+    bool transfer_active;
+    bool transfer_write;
+    bool transfer_send_stop;
+    bool idmac_suspended;
+    bool idmac_fatal;
+    bool card_inserted;
+    bool card_readonly;
+
+    uint32_t verid;
+    uint32_t hcon;
+    uint32_t data_offset;
+    uint32_t fifo_depth;
+};
+
+struct DwMciClass {
+    SysBusDeviceClass parent_class;
+
+    uint32_t verid;
+    uint32_t hcon;
+    uint32_t data_offset;
+    uint32_t fifo_depth;
+
+    bool (*vendor_read)(DwMciState *s, hwaddr offset, uint64_t *value,
+                        unsigned size);
+    bool (*vendor_write)(DwMciState *s, hwaddr offset, uint64_t value,
+                         unsigned size);
+    void (*vendor_reset)(DwMciState *s);
+};
+
+SDBus *dw_mci_get_bus(DwMciState *s);
+
+#endif
-- 
2.53.0


