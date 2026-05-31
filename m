Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74300CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWt-00025O-FK; Sun, 31 May 2026 05:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWi-00023d-5f
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:12 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWg-0008Ra-CS
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyiioErpMJ5GbdovhF3RMCpbpOC1gp3W94jYM/dlhwy1KoSCF8sX89IZZVJPa3jpXEkwP6J3TvO+EaOhnyg98u2Xr/CN5+mnvHDmHYVjaQK2dL0jllbYbAKmGG+YceL/CIhzGLsikxuY63K2RgswvF+Kol5yvTDYWAhRcZ+a0zlJ32PJ91TSNFVafcthfBEF+IAA4AtkOUwQP7hH85pfXkANrzls1f/+vfvvxKMeJm4aqYwUnQJl7xeenu1KubViqRXu8LVqWKrRsjCMWW1A22NqtsJ28K6VEE9ck5NlGmmH6AOBhSvBtQFPcs97KYFtCMCCuXj/Gwe1FqjTRsA+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2ah4vQE+yObY/wJsFF0WsgtqDM8qfmUUzUCMFIX7Vk=;
 b=L0wB6EZfohFQK+qFBfWyAI5Qy/p/nl3ptUMF19/nbNi05eQbhXGT08UqYtG90q4nxRz5SBeTYRe53e/wArJGfx5nNaUlBKOjt74seA/QWcP7tDdV6WuX5NEu8/w56vOfW4DrOO6srMYwzvYKhS3ue6NZ9oMxITSCQcfg9NBQyJ9NW88BVDTRR0BwNPIZN6LY1kUmXYxeksk5mXLuuNSqsB+VFkG3Lc89MS4IzBImR4IoLCEu7o/tgzcQMTBU6pu22JWpxsMVUO7dJZ+RyWOdXDSFWZf3h37VBk/gOe/XPlNvFcYWxQDTRFjaVjtGimaCGA4yVcXu0F+AzYzLctHXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:52 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:52 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:59 +0530
Subject: [PATCH 08/10] hw/tricore: wire peripherals into tc27x SoC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-8-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f1cb72-a1e0-4c0c-9b86-08debef7726e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: J0N8NlbQfaE4GGfubzU/Qv2UN0cU7yAhQUlg6tzdF3T5XNEQHWjA8moQ5aefK1/u94zt2E+Y4T0E9oxSFw3Tbiwf+q62IHQ4PlXxo5ThYvJm27/rzlytsJ63md7japdjEQolWvYlVZmuKsNVYtGF82ZDCGxMJJkePfZwFkEpIjCd3lMk8LR/UiB1xV8kbBNeJJFmuVEMsHGAYb1QX8nQ3agruoyF4wUUBmUWOuKTk7rDF6DiyyZTp8Zbbjx+Nkg0SxFD28HBr7pKE07Kv63Mr7NAEnOO47BuI1Cf9nxySnB1ePaGGEqJSfDa0qHsiXKEhH+yMCGQZ5SjeOQH9r+GvWpJd7BkAFK5HU5Bl5DIPRVRUysD+A6Nj6WsFTrItBGjH42aEii0frT+x/kZHVW3ULfTeHQl9UaFzL2nAfPqXJ1Rmw2BC8CuQfvlDZCdASbYA/Cg2rCVOAqYS4JrEO9QHUB/IV7nnWFcfPE+NJ1xWpiGwmhS3k9F82dw2TgsJYEwECXCApx/VGC+bFoFtWffVAg3wZvlZYeGviP/6NyTEFVPxL2Qul+bi53vjIyPIN71E2nG2e7xdxn/L4h2ucOwY/Cl0ToiulU7vna5HMx7xZfwLiXLmGzEg/9b3iuaemNBjwWY/+NCTCz82UxuYb93kCJxYaF3Gr+2FuOjD6nqjCa/SuBm7ZP2N/0ViPtu4XxAGQa1ZGMeO/uqJGcFGgTZ00eIPcL8EenG5JlzRyIPrcUKpRwqa0U0UcV1qcpFs8jA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdWRE1oYXY3NzI1cEhmL20xSk5UYTIxakNudHFxZnNocCthQ1JGa2FyZFEr?=
 =?utf-8?B?TzAxbTB5UWMwai9LUzVMelZXeEJ2RW9rakZCZHhOMVFhcDJGV1gzTUtSQXhr?=
 =?utf-8?B?NVBzS2VQK25ONzNwdjNwWG9yWHRpSjFtMEwrTVB1Q2tQTHdHbHllRUVBMnhB?=
 =?utf-8?B?eFlqVFI4SHdVYmtzaWVTQkJ4S1JXS0dGUFRVM3FCbitrWHNkUWdrS2N3ZCtD?=
 =?utf-8?B?NVFrT2FySHExeFlNSDRURnVnNXNmVXNrRCs4dTR5YkZGckRheG1aTkNWanYy?=
 =?utf-8?B?YmlRS1NaRGEzL2p6UFBPQThFbVQ4cUxTemlibUlDTno2VUpQRjVMR0k5WGg5?=
 =?utf-8?B?YStqU1dUYkVuWEpvRFlady9kdS8zUHkzd1hFLzZYbmtUMUlqa0dJV05BZ3hP?=
 =?utf-8?B?MmlWeWdMUzFDSUl1T1JFZk0zZmxzWGlYcVNEcUlRdGRGcmdlNXp2T0VQZUQ5?=
 =?utf-8?B?NVV0cld6Z2xIOTM4TkZXazdLTHBZcjgrdmRrTGsvVVJzb2Q3d016QkUwYUFM?=
 =?utf-8?B?NzZBVWF1NVVJZ0FsKzlGU2JUSDlmWDlHcGlaWm1LUzRFTFIvajlCUVhOM2R2?=
 =?utf-8?B?ZkRxdm5jaTN6OHA1aXRBMWtBZGxPVXgyUlppVWpBL1hQc3FCbHRmTGZObk9K?=
 =?utf-8?B?NXFIdkh4aG53YXdhTVUxRDNsL2NhbmlhZjlHSnk3UnlKUWgxRjFBbm05N1py?=
 =?utf-8?B?c1VvRFVSY3pyQU5iVEtIMWJITnBYenJ3Yk1Cd2U0Y0dNOGh0bVY3RjB2RkFt?=
 =?utf-8?B?a1lRZ0orYWQ3cytNbWRmb24vSzJTUVJTQjlBb3BUa2QxaGpBNks3M1RRcUx4?=
 =?utf-8?B?VWhkV3cvTlhscEt4TnlEQmtYVWlmNmkyM0QwSUQ2THhSUFhpWFBKZ3N1akRB?=
 =?utf-8?B?dThwMXZiWGNmc09rT3lvZnZBN1RBUEU0ZzJ0U3VqWXRoRnp5WTdCU0txSnNK?=
 =?utf-8?B?aWY1bTlSdWhtb0FRTm5WWFNad3NBbmpZeTg1M1B5UlA4RUpEWWRSR1NaK09p?=
 =?utf-8?B?VjZHNndiK1JYSzRBZkVpTXhGOVo0aVNlYlhxWXhRL2RMY2Z4VmREWUF3UlBL?=
 =?utf-8?B?RzVtSlN5Y2RvWWo5dkRxV1JSbURBOS9OV0JRUThmRHBYSXROSnZsU3Y5OThC?=
 =?utf-8?B?bTVsMXFJVFcrazVjSkVFQ1NYWGxUTlRSTTBSb3htVDdvQi9pNHkzOGcwR21K?=
 =?utf-8?B?Y2hFa011RFExalhzOCtmbkkzK0JvSDdDSksxMHIxNTdJYkZLNDBTNFRtalFa?=
 =?utf-8?B?MDJnbUE0dVdJVVg0QTRQa0ZXU2x0emVCMlZQR3pSYTM2TjZWOFRWNCtkZUFt?=
 =?utf-8?B?STZKcjUzMzcvOUhKcGRKTkYwempoZVdTUkkyTWFyTFU4SGlUT3I0SExGMTJl?=
 =?utf-8?B?bkxjb1FJSFErL2pOZFFOWDFxd3hIQkFPY3dWZDNrMG0rWEo3TTNXSEo4WGY4?=
 =?utf-8?B?Mk5ic1NRWVlrNURrdGs0UHNrNXpNdi81dDRWTmVyVVEzdWVkSmtwT2ZhWnhs?=
 =?utf-8?B?M2U5UEttUjFOWHU5ZktRT1krNlE1ekM4cWV5WFJucmduS0VJRmkvaVVpVVUy?=
 =?utf-8?B?V1ZMb3VSYkJkdVZPdDlsYXpOS3ZSeDVIZlUrdWVueVRvSFluUllvK1c5MlJS?=
 =?utf-8?B?U1pUWTRSMGhPeUpkODkxMXg4dklUNk1aNW5nTkllVENVY0dwYVFPVjZSYkNB?=
 =?utf-8?B?TWZoRXoxdDV0a1hST2lWdGdZTzZOaExvUGp3TFcwQmQ0Rms4TWdHcVFETnpI?=
 =?utf-8?B?V1pqcWxJWTBycXZvWXpuWGk2emZxRDVmNVlieGFhb2YzUS80dWVXckxaODJO?=
 =?utf-8?B?Q1NvdlhBOWx4SStJR3hmNUMzbTRwOVFxVjhueDA4MEMzdmZKYnoydGZrUHFY?=
 =?utf-8?B?TXl1YUhaeElMTnllVnVIaXZxRkh3QUlxYzVETVIybElTR01TU2pURDNZcVpt?=
 =?utf-8?B?WjMwUGlKMUR4S2tmbFAyajJBMk15LzdPZVJLSXg0aVc2VUdKcUk4Z0FBWnlG?=
 =?utf-8?B?VTF6ZkRQcUZSUndCVXhBeHdJVGZzOHl4eGwvSm5vTERDT3RVVllRTllKdnF1?=
 =?utf-8?B?ZW91ZldzTWxpc2FMZm45UFFQVjlxZmJsMW9pcGhFaHhIbVlpeGVxd0ZJaFVD?=
 =?utf-8?B?a3BORktXS29jUTRBME9iYjVCZW14WFRTNnhSTFpMSzlZcVhYYU5rSXFyZEVV?=
 =?utf-8?B?K25HNTdOYWVLd3d4VUp1b1Z2b0dnTHUrSk5SSUJJOTdkV3lHUmx5YTlKQjhF?=
 =?utf-8?B?c0VqUUt4ZjVlZlIreVRXODltQWU1Sy81bDBoQTNvTHFjd0padERuWjAwb3Y3?=
 =?utf-8?B?dVNrRVpqK2xuRy9TNU9ybkVYKzdDR2lKVUpXNUhIT1lpSDVmYWovZz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1cb72-a1e0-4c0c-9b86-08debef7726e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:52.0262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J8DCw6f9nfYhxL4LXJvKx4/jCuMhwT2OiYzFScK3rNNYriBElETS4vlhGTFA/H6VdeRgmbykCBGkwbpnPrbog==
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

Map IR, STM, ASCLIN and SCU into the tc27x SoC at their hardware
addresses.  ASCLIN0 gets serial_hd(0), peripheral IRQs are routed
to the IR.

Interrupt delivery to the CPU is not yet wired -- that needs
do_interrupt and CPU-side GPIO inputs (follow-up series).

Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/Kconfig             | 15 ++++++++++
 hw/tricore/tc27x_soc.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/tricore/tc27x_soc.h | 13 +++++++++
 3 files changed, 90 insertions(+)

diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 6c04f64949..fd589f7b78 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -8,6 +8,21 @@ config TRIBOARD
     default y
     depends on TRICORE
     select TC27X_SOC
+    select TC39X_SOC
 
 config TC27X_SOC
     bool
+    select TRICORE_ASCLIN
+    select TRICORE_IRBUS
+    select TRICORE_SCU
+    select TRICORE_STM
+
+config TC39X_SOC
+    bool
+    select TRICORE_ASCLIN
+    select TRICORE_IRBUS
+    select TRICORE_SCU
+    select TRICORE_STM
+
+config TRICORE_SCU
+    bool
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index 5b1b07cee1..2995ef8631 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -20,10 +20,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/core/clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/loader.h"
 #include "qemu/units.h"
 #include "hw/misc/unimp.h"
+#include "system/system.h"
 
 #include "hw/tricore/tc27x_soc.h"
 #include "hw/tricore/triboard.h"
@@ -61,6 +64,11 @@ const MemmapEntry tc27x_soc_memmap[] = {
     [TC27XD_EMEM_U]    = { 0xBF000000,                  0x0 },
     [TC27XD_PSPRX]     = { 0xC0000000,                  0x0 },
     [TC27XD_DSPRX]     = { 0xD0000000,                  0x0 },
+    [TC27XD_IR_INT]    = { 0xF0037000,                  0x0 },
+    [TC27XD_IR_SRC]    = { 0xF0038000,                  0x0 },
+    [TC27XD_STM0]      = { 0xF0001000,                  0x0 },
+    [TC27XD_ASCLIN0]   = { 0xF0000600,                  0x0 },
+    [TC27XD_SCU]       = { 0xF0036000,                  0x0 },
 };
 
 /*
@@ -179,9 +187,17 @@ static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
         sc->memmap[TC27XD_EMEM_U].base);
 }
 
+/* TC27x interrupt source indices (SRC register numbers) */
+#define TC27X_SRC_STM0_SR0      0xC0
+#define TC27X_SRC_ASCLIN0_TX    0x14
+#define TC27X_SRC_ASCLIN0_RX    0x15
+#define TC27X_SRC_ASCLIN0_ERR   0x16
+
 static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     TC27XSoCState *s = TC27X_SOC(dev_soc);
+    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
+    Clock *fstm;
     Error *err = NULL;
 
     qdev_realize(DEVICE(&s->cpu), NULL, &err);
@@ -191,6 +207,48 @@ static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     tc27x_soc_init_memory_mapping(dev_soc);
+
+    /* STM clock: 50 MHz (fSTM derived from fSPB) */
+    fstm = clock_new(OBJECT(dev_soc), "fstm");
+    clock_set_hz(fstm, 50000000);
+    qdev_connect_clock_in(DEVICE(&s->stm), "fstm", fstm);
+
+    /* Connect ASCLIN to first serial device */
+    qdev_prop_set_chr(DEVICE(&s->asclin), "chardev", serial_hd(0));
+
+    /* Realize peripherals */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ir), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->stm), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->asclin), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->scu), &error_fatal);
+
+    /* Map peripheral MMIO regions */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ir), 0,
+                    sc->memmap[TC27XD_IR_INT].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ir), 1,
+                    sc->memmap[TC27XD_IR_SRC].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->stm), 0,
+                    sc->memmap[TC27XD_STM0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->asclin), 0,
+                    sc->memmap[TC27XD_ASCLIN0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[TC27XD_SCU].base);
+
+    /* Connect ASCLIN IRQs to interrupt router */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC27X_SRC_ASCLIN0_RX));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 1,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC27X_SRC_ASCLIN0_TX));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->asclin), 2,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC27X_SRC_ASCLIN0_ERR));
+
+    /* Connect STM compare match IRQ to interrupt router */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->stm), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ir), "irq",
+                               TC27X_SRC_STM0_SR0));
 }
 
 static void tc27x_soc_init(Object *obj)
@@ -199,6 +257,10 @@ static void tc27x_soc_init(Object *obj)
     TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
 
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
+    object_initialize_child(obj, "ir", &s->ir, TYPE_TRICORE_IR);
+    object_initialize_child(obj, "stm", &s->stm, TYPE_TRICORE_STM);
+    object_initialize_child(obj, "asclin", &s->asclin, TYPE_TRICORE_ASCLIN);
+    object_initialize_child(obj, "scu", &s->scu, TYPE_TRICORE_SCU);
 }
 
 static void tc27x_soc_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/tricore/tc27x_soc.h b/include/hw/tricore/tc27x_soc.h
index 2d2bdca3fd..4e24789d4d 100644
--- a/include/hw/tricore/tc27x_soc.h
+++ b/include/hw/tricore/tc27x_soc.h
@@ -22,6 +22,10 @@
 #define TC27X_SOC_H
 
 #include "hw/core/sysbus.h"
+#include "hw/char/tricore_asclin.h"
+#include "hw/intc/tricore_ir.h"
+#include "hw/timer/tricore_stm.h"
+#include "hw/tricore/tricore_scu.h"
 #include "target/tricore/cpu.h"
 #include "qom/object.h"
 
@@ -65,6 +69,10 @@ typedef struct TC27XSoCState {
 
     /*< public >*/
     TriCoreCPU cpu;
+    TriCoreIRState ir;
+    TriCoreSTMState stm;
+    TriCoreASCLINState asclin;
+    TriCoreSCUState scu;
 
     MemoryRegion dsprX;
     MemoryRegion psprX;
@@ -124,6 +132,11 @@ enum {
     TC27XD_EMEM_U,
     TC27XD_PSPRX,
     TC27XD_DSPRX,
+    TC27XD_IR_INT,
+    TC27XD_IR_SRC,
+    TC27XD_STM0,
+    TC27XD_ASCLIN0,
+    TC27XD_SCU,
 };
 
 #endif

-- 
2.47.3


