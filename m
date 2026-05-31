Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWg-00022r-Hq; Sun, 31 May 2026 05:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWa-00021i-Gm
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWY-0008Ra-14
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsxfCXYVLLC9ZBtJr7VBeSAmUq/k1Zm/qTy5K6qL+wKu8gVhXk5wEBg8b5wysPkmB1nE2CxM6z2J25al32YZ+hPXrlImZ7WdtpkDRSIy9Uz4sHs2E8ZCfmxiN6eLMRCTVwJ1GvkxISvP98jA5b86ZAxDLDu+Y9J7NO8xg5xCZB6ghy5x1V+oHEFRl7KXWQxzcUmz6B8hF3OxhKuLeK9RJlPj/uBZGbmYXJtDceY3L1EsfSJyoCZ8HW03IbGPfQjcU9fgMFDhtmeqS3+pYynO6xT+WSTW+94cHIocW3XGpCKSxPrxSwZm0qXezfVsf7P4tZZHxyGi0tBGUZ/4hnqRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdCD5pcgD60P+75Oa02GC2qXkMCUHS/w7M0zFvYL+LY=;
 b=tuTtFDuFC1uuE+hfKsl/hyFk6r4227C24CqUlHDrtB3xDb98GH0CZBAgR82IWMM29dff8itoID0OXsB3LQsFDNaGKImxOhQmZTNs5ScloqwoALGPKncH85+rKdWLdJFTliKDzAcZiv01ahEJKfpSf5Ti+nO2GeqySxgjbRjPrjhmBti7CVylTU5LZshqZFbo3LN5/TNRjVqqup3WHm0FrOTdSgnAgbyFWX8DdkQwRw4uzVXEA0lrH0o5ENnjfrbdelexY7wCdzwLKfe3r+ku8pZpeH5ONe+b76WVVn/EQvUW6Yn58S4gLZ/0burjC9fIcw9ugmUKL0T2eUWPdPD6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:47 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:47 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:56 +0530
Subject: [PATCH 05/10] hw/char: add TriCore ASCLIN UART controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-5-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com, 
 David Brenken <david.brenken@efs-auto.de>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 967c8ccc-a684-4bf8-9dc2-08debef76f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: vNk9mVuOCMq810ZbhwELIIgY3SZOaKItkkerT7R/mf5luXt6QMucM7xHyPaB1jQMB0k7mwB4s5+eW9THF2ymxHckG1l8eAj9vYpNJo7DnC98v73doS5SoqukmZjJsoYoZpt/CXenuvTmOORbtuS5XyHk9HyDicoOrLlZQqanF3UoD/KjXnHIXRNbAHaDCwo+bVch52fRM7TsY89FZpEdpZ4t5JgL7B88e1WHzo9BuA8DwaH5jQqV0zikeFpjL4rAAGEtaipFE/G2Ju0UY41WasUibV4vJxTYbmZRq1eaqAyYHMpUnMQNLV+zIf2WRNZ9I2/1AotYIeY6KVD3uUhx+Oxh7EwCDnGOHVVDvcFevQYuN370KOZyScSm83ltOiglaikGT6iKQshQb1Hdywrvo/mejaplV9uMnSOF7bcTXfYw21Oluv7jH2Z1+rtn2zENxJhl2p9pt4vZ99h/bGToXL2H6VZyrvHhRBnpksKiQVFdzhmebRJKt6rPXWl+Y93U9pmfdFRN1GuioVEWezEQY0ALvrfmbbQ08AVFrDRZqhtqZAIZiCDTq7fLpjTb/G+kSuWPVBx1aU/+gjcEUJWc0iww/gRfU7+WToEToLWFG9qD02DC4o7CzuUU5SsQxVd3FC/+uB5maHChtMeY4rXh6dQ+hHADmzUnpONfvTM1CBkVVq6EWzTwU3oBcgqnn7BBmUF/ljag+St63eB/YmxvO3bj0tdyExDXCet7ryYRHRwbvhhtP87ipTNkCS+DRDhn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRKM0UrVUtTSllpcmliaStORDVVbkZqRkkxL0pJSWNuY01raFo3YUxIRkNs?=
 =?utf-8?B?R0pkSFdhZzBtVWdNQk4wci83YUFETzBhSklpQWJxcEdwb0hmcjlrNG40WWFL?=
 =?utf-8?B?RzVJQTVGYnFuUGNNOGZQSHdpRVVqQ0ErUm5mYU53cFpiL29xSzhKMEhvM2dW?=
 =?utf-8?B?ZVFxZUhzZnE2dlEyWE1NaEZnMVBhbEIvK2hMbjBlY01ocFRxUFRVWFpkZGhh?=
 =?utf-8?B?UUR2S2tpVy9BTkVzU2FRMHdDSFluYSt6ckgweGJIUW9ORklmWTJjRmlWTWx3?=
 =?utf-8?B?QVpTK2h0Wk9DMDhlTHlxWWVzQkN0TWh5KzZQYzg2bTRGRndnOFk2SXNER1BO?=
 =?utf-8?B?WXlqd1R4czQ4ZHdMR3VEakJ5TWpHUmFDQlcrV1R6U2pWQW81UFB3SjBjaEtQ?=
 =?utf-8?B?bVZkVVJic04yWnpFL1V4TXVJeEluMzc2K2gyOXo3TmppeHRYbGgybUxyR0sv?=
 =?utf-8?B?dk1iTVdaQU1mTXNJaTZkTE03RUpKWXlXcjZmK2NlQzFMNDFTM2F0czgrenZR?=
 =?utf-8?B?LzRUckxlM1lyOXlwUUNwWVRrQVdlaUZqWmlWU0IzTXlUd3JDaDA5TE9Jbzdy?=
 =?utf-8?B?U05iWU5PS202eW5WUHRYWTNnZlRTSHgvdjNML214TGVoZHhZcmtlUTBManBH?=
 =?utf-8?B?UnhEYm1RUWJFVVo5VjBQR1Vrd2RTTVlZME8vZC9ObmYvNXZXNDhvSmRMVHBN?=
 =?utf-8?B?R1B5RVpXeERaYjZYZVRCdjAwZlRYdy91TlBlcHhteFhldDFLcGdOQlZadTBu?=
 =?utf-8?B?Ri9yOEVXeDRxamtJK0FmaHVFWnE0SjFFQndTOGdlbkxZSnBOTDR1RlZRT3Rw?=
 =?utf-8?B?MzZOQmlqWitEbmh3a3Nlblg0dVdRVWtSd0dtUGdtTDdxczVxTFd6bS8rWVV6?=
 =?utf-8?B?OGJrbW0ySjQ2RVBEc1BNVW1Jc0I2L01VVnVaUUlWZzVML1BlYjZTRjVmQ3BB?=
 =?utf-8?B?SXlTQkJoMldaSWd1NSsyYW11MFdWRjhjcUQvWVFEOGZSRXN2K0xCSjF5dVNi?=
 =?utf-8?B?clYwVkpGM2VsVHE2Y3VieCtUTGs2WTZuVTkzZEhSMTJ3QXZDeE9hYytMVkZ4?=
 =?utf-8?B?REhPN0pCVytYeGlpYVNwUkRJbitLSmd2RXcwTjhCU0ErTmJlejdhZFo2OWVJ?=
 =?utf-8?B?c3lFZ29mRE1MT1ZEankrK2ZEZDZKWjBFMmhvUHpVd2xBZWJMKzh6QXdwdnhP?=
 =?utf-8?B?cWc0REJDZFRTZ1krc0twbWFQNXJSL2k0Vk9yWTB5REM4OG1hYWlyUEVuU1FV?=
 =?utf-8?B?ajJ5djgwNGRjSnJaWHJBZzZtMDJuek02SDc5dFNiUFhaTnRsNnVyU1J3Umhh?=
 =?utf-8?B?Z0M3d0dJWXNWZmU3MU90QjhHeDlyWEl6N05aelRRYUdkcUY4K2Q0b0RhN3do?=
 =?utf-8?B?UUN4cUU0TUdwMVRkUUhuZnc2NWlBcStMK0dkUDZOK1BiT0J1UkFSWE45NGZ3?=
 =?utf-8?B?UjFqSk91N2taQUNJYjZhaXZGaFFzQlk3dlhqMzA5Y3pIbjVOSlJZT2xsNlhN?=
 =?utf-8?B?VWpTeGdtSFd6MjNPd0tya21zODVuZmFRS2pySXRycDdieFJQRy9GL3JQM0h2?=
 =?utf-8?B?Y2JIVFNzdGQzNzVnQTBzZzhQeHU1TCtXN2EybHkwOGl6MmlnUGtoSHRxSnVy?=
 =?utf-8?B?dHlXSTI3eHZmWVZYcWl1dWZaTDFBSlErOEx6amhVeDRZNWNGVHVyU0dLbmsv?=
 =?utf-8?B?dCtCYVZPb2ljVVpTWnU1UHpJQWwzclpib1dRN3Y2a3Y5ZmdCTHFjc2w4S1Fn?=
 =?utf-8?B?aE92U1N4bUs1T0lEV2FQaUlJUmI0by9VS0x4M2pZMmdPM2pDUTJrR0RtSHRE?=
 =?utf-8?B?WkpCeEdvYlIyUm05akdpVzF5cDRqQTJoWWlZakxBR2t5OGE5aUxiMUtuUFRR?=
 =?utf-8?B?R3IwejgvQzk4L1NFL1piWENUaXRpaXJHNGdncUthNWNLemNyS1JmZ3daWHF0?=
 =?utf-8?B?SWpUNktnd0k5amFlTU5DMm5Bc1I0QTJxcU5sdmVZd29TYk4xSTNITktUL0JF?=
 =?utf-8?B?QWxOLzA1QmpWTWhhZlBPdWh2cVc4ZTd5ZGppdEl0WlVESm4yNkhDV3EzRmlH?=
 =?utf-8?B?VWREWDRYMndiL3IraXpqWEtnTmU0OFpRQ0V1blpMNU9xdG84ZUlQRWxkakNS?=
 =?utf-8?B?UjlhZzFrMjRkVG56NGtiWnNzZ1VRdDlXY2lKWi81Qkc4dkE1QjBzNEErV0RS?=
 =?utf-8?B?TWdacStoNE54R3RFSlE0aDEyYjI2RFhEOUtBREt6SElZVG9yWnpEa013ekFY?=
 =?utf-8?B?SzZnUXFQTGRlVkFabm9vbjdHWHZRUFcvaXM2bnpwWmowK1hzTm92VGpKM2Qx?=
 =?utf-8?B?K0xYc0JXVnlnZkJFbzJORkNjT1QvTTA2d09WVlFHS0ZTa3hJNitMUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967c8ccc-a684-4bf8-9dc2-08debef76f9b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:47.2768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUMxHm0XCTgz5tWqvol2WCRxRB4JWZQaSkCk6RZYT8iRFtCsdzEweEZ6cFjn6WgakSupv3CeCs+dEGV0hciLLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Model the ASCLIN in UART mode.  TX writes go to the chardev
backend, RX fills a ring buffer.  FLAGS tracks FIFO status and
three sysbus IRQ lines (TX, RX, ERR) are pulsed on flag edges.

Originally-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/char/Kconfig                  |   3 +
 hw/char/meson.build              |   1 +
 hw/char/tricore_asclin.c         | 457 +++++++++++++++++++++++++++++++++++++++
 include/hw/char/tricore_asclin.h |  89 ++++++++
 4 files changed, 550 insertions(+)

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..5e540241af 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config TRICORE_ASCLIN
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..4a7deb3ece 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
 system_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'))
+system_ss.add(when: 'CONFIG_TRICORE_ASCLIN', if_true: files('tricore_asclin.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
diff --git a/hw/char/tricore_asclin.c b/hw/char/tricore_asclin.c
new file mode 100644
index 0000000000..724dddb38c
--- /dev/null
+++ b/hw/char/tricore_asclin.c
@@ -0,0 +1,457 @@
+/*
+ * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Siemens AG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
+#include "migration/vmstate.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/core/qdev-properties-system.h"
+
+/*
+ * Register offsets (byte address / 4) for TC3x ASCLIN.
+ * Each register occupies one 4-byte slot from 0x00 to 0x50.
+ */
+enum {
+    R_CLC = 0,
+    R_IOCR,
+    R_ID,
+    R_TXFIFOCON,
+    R_RXFIFOCON,
+    R_BITCON,
+    R_FRAMECON,
+    R_DATCON,
+    R_BRG,
+    R_BRD,
+    R_LINCON,
+    R_LINBTIMER,
+    R_LINHTIMER,
+    R_FLAGS,
+    R_FLAGSSET,
+    R_FLAGSCLEAR,
+    R_FLAGSENABLE,
+    R_TXDATA,
+    R_RXDATA,
+    R_CSR,
+    R_RXDATAD,
+};
+
+static void asclin_rx_buf_reset(TriCoreASCLINState *s)
+{
+    memset(s->rxbuf, 0, ASCLIN_RX_BUF_SIZE);
+    s->rx_rdidx = 0;
+    s->rx_wridx = 0;
+}
+
+static uint32_t asclin_rx_buf_used(TriCoreASCLINState *s)
+{
+    return ((s->rx_wridx + ASCLIN_RX_BUF_SIZE) - s->rx_rdidx)
+           % ASCLIN_RX_BUF_SIZE;
+}
+
+static uint32_t asclin_rx_buf_free(TriCoreASCLINState *s)
+{
+    return (ASCLIN_RX_BUF_SIZE - 1) - asclin_rx_buf_used(s);
+}
+
+/*
+ * Pulse the appropriate IRQ line for each flag bit that is both
+ * set and enabled.  The TriCore interrupt router is edge-triggered.
+ */
+static void asclin_pulse_irq(TriCoreASCLINState *s, uint32_t pulse_mask)
+{
+    uint32_t fired = pulse_mask & s->regs[R_FLAGSENABLE];
+
+    if (fired & ASCLIN_TX_INT_MASK) {
+        qemu_irq_pulse(s->irq_tx);
+    }
+    if (fired & ASCLIN_RX_INT_MASK) {
+        qemu_irq_pulse(s->irq_rx);
+    }
+    if (fired & ASCLIN_ERR_INT_MASK) {
+        qemu_irq_pulse(s->irq_err);
+    }
+}
+
+/*
+ * Watch callback: retries TX when the chardev was previously busy.
+ */
+static gboolean asclin_tx_watch(void *do_not_use, GIOCondition cond,
+                                void *opaque)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+    int ret;
+
+    s->watch_tag = 0;
+
+    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf, 1);
+    if (ret <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+        if (!s->watch_tag) {
+            goto drained;
+        }
+        return G_SOURCE_REMOVE;
+    }
+
+drained:
+    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    return G_SOURCE_REMOVE;
+}
+
+/*
+ * Transmit one byte immediately.  Re-asserts TFL and TC flags so that
+ * interrupt-driven drivers can continue filling the FIFO.
+ */
+static void asclin_txdata_write(TriCoreASCLINState *s, uint32_t value)
+{
+    int ret;
+
+    s->txbuf = value;
+    ret = qemu_chr_fe_write_all(&s->chr, (uint8_t *)&s->txbuf, 1);
+    if (ret <= 0) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+        if (!s->watch_tag) {
+            goto drained;
+        }
+        return;
+    }
+
+drained:
+    qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+    asclin_pulse_irq(s, ASCLIN_FLAGS_TFL | ASCLIN_FLAGS_TC);
+}
+
+static void asclin_txfifocon_write(TriCoreASCLINState *s, uint32_t value)
+{
+    /* FILL field is read-only hardware status */
+    s->regs[R_TXFIFOCON] = value & ~ASCLIN_FILL_MASK;
+}
+
+static uint32_t asclin_txfifocon_read(TriCoreASCLINState *s)
+{
+    /* Instant-TX model: FILL always reads as 0 */
+    return s->regs[R_TXFIFOCON] & ~ASCLIN_FILL_MASK;
+}
+
+static void asclin_rxfifocon_write(TriCoreASCLINState *s, uint32_t value)
+{
+    s->regs[R_RXFIFOCON] = value & ~ASCLIN_FILL_MASK;
+
+    if (value & ASCLIN_RXFIFOCON_FLUSH) {
+        asclin_rx_buf_reset(s);
+    }
+    if (value & ASCLIN_RXFIFOCON_ENI) {
+        qemu_chr_fe_accept_input(&s->chr);
+    }
+}
+
+static uint32_t asclin_rxfifocon_read(TriCoreASCLINState *s)
+{
+    uint32_t used = asclin_rx_buf_used(s);
+    uint32_t fill = MIN(used, ASCLIN_HW_FIFO_DEPTH);
+
+    return (s->regs[R_RXFIFOCON] & ~ASCLIN_FILL_MASK) |
+           (fill << ASCLIN_FILL_SHIFT);
+}
+
+static uint32_t asclin_rxdata_read(TriCoreASCLINState *s, bool peek)
+{
+    uint32_t r;
+
+    if (s->rx_rdidx == s->rx_wridx) {
+        return 0;
+    }
+
+    r = s->rxbuf[s->rx_rdidx];
+    if (!peek) {
+        s->rx_rdidx = (s->rx_rdidx + 1) % ASCLIN_RX_BUF_SIZE;
+    }
+    return r;
+}
+
+static uint32_t asclin_csr_read(TriCoreASCLINState *s)
+{
+    uint32_t csr = s->regs[R_CSR];
+
+    /* CLKSEL valid: set CON bit (bit 31) when a clock is selected */
+    if (csr & 0x1f) {
+        csr |= (1u << 31);
+    }
+    return csr;
+}
+
+static void asclin_flagsset_write(TriCoreASCLINState *s, uint32_t value)
+{
+    qatomic_or(&s->regs[R_FLAGS], value);
+    asclin_pulse_irq(s, value);
+}
+
+static void asclin_flagsclear_write(TriCoreASCLINState *s, uint32_t value)
+{
+    qatomic_and(&s->regs[R_FLAGS], ~value);
+}
+
+/*
+ * FLAGSENABLE write: newly-enabled bits whose FLAGS is already set
+ * must produce a rising edge on the corresponding interrupt line.
+ */
+static void asclin_flagsenable_write(TriCoreASCLINState *s, uint32_t value)
+{
+    uint32_t old_en = s->regs[R_FLAGSENABLE];
+    uint32_t newly_enabled = value & ~old_en;
+
+    s->regs[R_FLAGSENABLE] = value;
+    asclin_pulse_irq(s, newly_enabled & s->regs[R_FLAGS]);
+}
+
+static uint64_t asclin_read(void *opaque, hwaddr offset, unsigned size)
+{
+    TriCoreASCLINState *s = opaque;
+    hwaddr reg = offset >> 2;
+
+    switch (reg) {
+    case R_CLC:
+    case R_IOCR:
+    case R_ID:
+    case R_BITCON:
+    case R_FRAMECON:
+    case R_DATCON:
+    case R_BRG:
+    case R_BRD:
+    case R_LINCON:
+    case R_LINBTIMER:
+    case R_LINHTIMER:
+    case R_FLAGS:
+    case R_FLAGSENABLE:
+        return s->regs[reg];
+    case R_TXFIFOCON:
+        return asclin_txfifocon_read(s);
+    case R_RXFIFOCON:
+        return asclin_rxfifocon_read(s);
+    case R_FLAGSSET:
+    case R_FLAGSCLEAR:
+        return 0;
+    case R_TXDATA:
+        return 0;
+    case R_RXDATA:
+        return asclin_rxdata_read(s, false);
+    case R_CSR:
+        return asclin_csr_read(s);
+    case R_RXDATAD:
+        return asclin_rxdata_read(s, true);
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from unknown offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void asclin_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    TriCoreASCLINState *s = opaque;
+    hwaddr reg = offset >> 2;
+    uint32_t val = (uint32_t)value;
+
+    switch (reg) {
+    case R_CLC:
+    case R_IOCR:
+    case R_ID:
+    case R_BITCON:
+    case R_FRAMECON:
+    case R_DATCON:
+    case R_BRG:
+    case R_BRD:
+    case R_LINCON:
+    case R_LINBTIMER:
+    case R_LINHTIMER:
+        s->regs[reg] = val;
+        break;
+    case R_TXFIFOCON:
+        asclin_txfifocon_write(s, val);
+        break;
+    case R_RXFIFOCON:
+        asclin_rxfifocon_write(s, val);
+        break;
+    case R_FLAGS:
+        /* read-only hardware status */
+        break;
+    case R_FLAGSSET:
+        asclin_flagsset_write(s, val);
+        break;
+    case R_FLAGSCLEAR:
+        asclin_flagsclear_write(s, val);
+        break;
+    case R_FLAGSENABLE:
+        asclin_flagsenable_write(s, val);
+        break;
+    case R_TXDATA:
+        asclin_txdata_write(s, val);
+        break;
+    case R_RXDATA:
+    case R_RXDATAD:
+        /* read-only */
+        break;
+    case R_CSR:
+        s->regs[R_CSR] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to unknown offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps asclin_ops = {
+    .read = asclin_read,
+    .write = asclin_write,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void asclin_uart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    TriCoreASCLINState *s = opaque;
+
+    while (size > 0) {
+        if (asclin_rx_buf_free(s) == 0) {
+            qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFO);
+            asclin_pulse_irq(s, ASCLIN_FLAGS_RFO);
+            break;
+        }
+        s->rxbuf[s->rx_wridx] = *buf++;
+        s->rx_wridx = (s->rx_wridx + 1) % ASCLIN_RX_BUF_SIZE;
+        size--;
+    }
+
+    if (s->rx_rdidx != s->rx_wridx) {
+        qatomic_or(&s->regs[R_FLAGS], ASCLIN_FLAGS_RFL);
+        asclin_pulse_irq(s, ASCLIN_FLAGS_RFL);
+    }
+}
+
+static int asclin_uart_can_rx(void *opaque)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+
+    if ((s->regs[R_RXFIFOCON] & ASCLIN_RXFIFOCON_ENI) &&
+        asclin_rx_buf_free(s) > 0) {
+        return 1;
+    }
+    return 0;
+}
+
+static void asclin_uart_event(void *opaque, QEMUChrEvent event)
+{
+}
+
+static void asclin_uart_reset_hold(Object *obj, ResetType type)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
+    int i;
+
+    for (i = 0; i < ASCLIN_R_MAX; i++) {
+        s->regs[i] = 0;
+    }
+    asclin_rx_buf_reset(s);
+}
+
+static void asclin_uart_realize(DeviceState *dev, Error **errp)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(dev);
+
+    qemu_chr_fe_set_handlers(&s->chr, asclin_uart_can_rx,
+                             asclin_uart_rx, asclin_uart_event,
+                             NULL, s, NULL, true);
+}
+
+static void asclin_uart_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    TriCoreASCLINState *s = TRICORE_ASCLIN(obj);
+
+    memory_region_init_io(&s->iomem, obj, &asclin_ops, s,
+                          TYPE_TRICORE_ASCLIN, 0x100);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq_rx);
+    sysbus_init_irq(sbd, &s->irq_tx);
+    sysbus_init_irq(sbd, &s->irq_err);
+}
+
+static int asclin_uart_post_load(void *opaque, int version_id)
+{
+    TriCoreASCLINState *s = TRICORE_ASCLIN(opaque);
+
+    if (s->regs[R_FLAGS] & ASCLIN_FLAGS_TFL) {
+        s->watch_tag = qemu_chr_fe_add_watch(&s->chr,
+                                             G_IO_OUT | G_IO_HUP,
+                                             asclin_tx_watch, s);
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_asclin_uart = {
+    .name = TYPE_TRICORE_ASCLIN,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = asclin_uart_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TriCoreASCLINState, ASCLIN_R_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property asclin_uart_properties[] = {
+    DEFINE_PROP_CHR("chardev", TriCoreASCLINState, chr),
+};
+
+static void asclin_uart_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = asclin_uart_realize;
+    rc->phases.hold = asclin_uart_reset_hold;
+    dc->vmsd = &vmstate_asclin_uart;
+    device_class_set_props(dc, asclin_uart_properties);
+}
+
+static const TypeInfo asclin_uart_info = {
+    .name = TYPE_TRICORE_ASCLIN,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreASCLINState),
+    .instance_init = asclin_uart_init,
+    .class_init = asclin_uart_class_init,
+};
+
+static void asclin_uart_register_types(void)
+{
+    type_register_static(&asclin_uart_info);
+}
+
+type_init(asclin_uart_register_types)
diff --git a/include/hw/char/tricore_asclin.h b/include/hw/char/tricore_asclin.h
new file mode 100644
index 0000000000..b142515c50
--- /dev/null
+++ b/include/hw/char/tricore_asclin.h
@@ -0,0 +1,89 @@
+/*
+ * TriCore ASCLIN (Asynchronous/Synchronous Interface) UART controller
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Siemens AG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_TRICORE_ASCLIN_H
+#define HW_TRICORE_ASCLIN_H
+
+#include "chardev/char-fe.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+/* FLAGS register bits */
+#define ASCLIN_FLAGS_TH     (1u << 0)
+#define ASCLIN_FLAGS_TR     (1u << 1)
+#define ASCLIN_FLAGS_RH     (1u << 2)
+#define ASCLIN_FLAGS_RR     (1u << 3)
+#define ASCLIN_FLAGS_FED    (1u << 5)
+#define ASCLIN_FLAGS_RED    (1u << 6)
+#define ASCLIN_FLAGS_PE     (1u << 16)
+#define ASCLIN_FLAGS_TC     (1u << 17)
+#define ASCLIN_FLAGS_FE     (1u << 18)
+#define ASCLIN_FLAGS_HT     (1u << 19)
+#define ASCLIN_FLAGS_RT     (1u << 20)
+#define ASCLIN_FLAGS_BD     (1u << 21)
+#define ASCLIN_FLAGS_LP     (1u << 22)
+#define ASCLIN_FLAGS_LA     (1u << 23)
+#define ASCLIN_FLAGS_LC     (1u << 24)
+#define ASCLIN_FLAGS_CE     (1u << 25)
+#define ASCLIN_FLAGS_RFO    (1u << 26)
+#define ASCLIN_FLAGS_RFU    (1u << 27)
+#define ASCLIN_FLAGS_RFL    (1u << 28)
+#define ASCLIN_FLAGS_TFO    (1u << 30)
+#define ASCLIN_FLAGS_TFL    (1u << 31)
+
+/* RXFIFOCON bits */
+#define ASCLIN_RXFIFOCON_FLUSH  0x1
+#define ASCLIN_RXFIFOCON_ENI    0x2
+
+/* Interrupt line grouping masks */
+#define ASCLIN_TX_INT_MASK  (ASCLIN_FLAGS_TH | ASCLIN_FLAGS_TR | \
+                             ASCLIN_FLAGS_TFL)
+#define ASCLIN_RX_INT_MASK  (ASCLIN_FLAGS_RH | ASCLIN_FLAGS_RR | \
+                             ASCLIN_FLAGS_RFL)
+#define ASCLIN_ERR_INT_MASK (ASCLIN_FLAGS_FED | ASCLIN_FLAGS_RED | \
+                             ASCLIN_FLAGS_PE  | ASCLIN_FLAGS_TC  | \
+                             ASCLIN_FLAGS_FE  | ASCLIN_FLAGS_HT  | \
+                             ASCLIN_FLAGS_RT  | ASCLIN_FLAGS_BD  | \
+                             ASCLIN_FLAGS_LP  | ASCLIN_FLAGS_LA  | \
+                             ASCLIN_FLAGS_LC  | ASCLIN_FLAGS_CE  | \
+                             ASCLIN_FLAGS_RFO | ASCLIN_FLAGS_RFU | \
+                             ASCLIN_FLAGS_TFO)
+
+/* FIFO depth and FILL field position in TX/RXFIFOCON */
+#define ASCLIN_HW_FIFO_DEPTH    16
+#define ASCLIN_FILL_SHIFT       16
+#define ASCLIN_FILL_MASK        (0x1fu << ASCLIN_FILL_SHIFT)
+
+#define ASCLIN_R_MAX        21
+#define ASCLIN_RX_BUF_SIZE  8192
+
+#define TYPE_TRICORE_ASCLIN "tricore_asclin"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreASCLINState, TRICORE_ASCLIN)
+
+struct TriCoreASCLINState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    CharFrontend chr;
+    qemu_irq irq_rx;
+    qemu_irq irq_tx;
+    qemu_irq irq_err;
+
+    guint watch_tag;
+    uint32_t regs[ASCLIN_R_MAX];
+    uint32_t txbuf;
+
+    uint8_t rxbuf[ASCLIN_RX_BUF_SIZE];
+    uint32_t rx_wridx;
+    uint32_t rx_rdidx;
+};
+
+#endif

-- 
2.47.3


