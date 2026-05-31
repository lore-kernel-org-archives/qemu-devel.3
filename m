Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E32CCD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWp-00024W-Qi; Sun, 31 May 2026 05:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWf-00022w-TB
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:10 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWd-0008Ra-PL
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTjdpsKGe2ZuDzBlyHfjF759BgziKSpve3FGbHXNC1GCBS4vRylFZpuqzPQULL2KM2Fze1IBggD1AoW0raSDm1Pb0eEyZF5HJTYu9/VVdZWeC4tYCIC7pYYRHvfZIWgvyoQEjKupePQqkI2aM2g68bqhwwZbO3zrY8iU0JnvH7jl3nzN3jKwE7GnCFsf9+D3fzVGUANH2pCluhx9OZl24TKypEXCWH72ENKg5/2GjfGzx8RMXAAXFEORj3P6bIRGyuZVxtWYIftES/F84pj9HuydAkewISyzeFy8v1ppC35h7VZAk+ks+dT2MwH32VUMIWRGRYBndySoML3biHflBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMaExvZCoiHIS9q5DCy2/rzkIyQ1ExAXpdGzJabsJao=;
 b=enETRrISA2RtGKKErpePC0I3guiitNUDa9jeoFMaEpOPRPHjP2RNMAL6URkX+WwKZbF6PuUa6/pLuRYLHz9NH7n3Ke4FdZaFqpiCKxRyjzIuEHEjTLnJomgxhqvkfbcTSvRfnPmyu+QqRBvtwnKTbmU/+r552pETSPnNUdwrJHUK4XLN/J3YB04mwXVBsLrY6JLv8TT8tz+QwmhU+WAH3vrh03zKKAH9kpFeHcRGE9fxJXTDHU3fivDl5d0MnQNUj/P4zITZrib6+7kDCmi1WAA+8NE5garcr4MmZgjw35HWv7clA1Syb10xMRbshEbC8VcrKZxPqeMhLeGMJ/jWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:50 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:50 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:58 +0530
Subject: [PATCH 07/10] hw/tricore: add System Control Unit (SCU) device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-7-1c39053e5e95@linumiz.com>
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
X-MS-Office365-Filtering-Correlation-Id: c535cfd1-70e9-4135-4e5a-08debef7717f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: tJIz8DLkiAYFerbTJ+dxhXg5bi2+z3+utPFow9KAVD4JBlkehNv0sRJK77L6yWtDlavrniEwk6N86RdoCMJziQ3c7og4xpFIRf0puRa2Piugq45ckpKnydY8WUmIOx2QB1O7E+YFK1Lwzhrj2zF+qtBTYmXUA2J8nY8hsUz14mmaN/g5PZ/kExZgsX5DM3Tbz9XPCFIrSto4LWhaZkwPKYD6B/7dtWTOjqQ3kHyRIdSvJFwvtYjNkxDp96dlQxwVIJTUbeqAow4yDOPNsvtZHYA6ZZNMn3eOqLCf2Z4QtUvbDoS2DPKZ+sUnwL3Q1R0zzs4L+KQVIg6k5jVAPdRVdWdLqiD2RQiPMFktpnlFhH6mgSSjs+HjUOMukXkcCVKVGVg8DxFMU3v1oUx5w/pkgIeRtd8J5+afmuplpnQyp+FdKMtYshoRuY/1UW2PzCMq8K+HUtCRXg+xDuVXhVWW2G8oMq7BfbMLxuNC3wQP9kbCo3BiW9fmcrTPIs2XQW6h/rSRtdFJXRWV65vkYLcQ5FmDlFwopBXMiqkV6WjJCtb/7V4+0kcjBbcCS8EYD99lcZ/s8pV9aAqo5vRJhU2+Hzwo+PF8iECJyTd8TP2mnSUTMfXQYksavL8TdwRebcu6nRkaCOvOfvO0u/CChYZwO7YSiVKSDQn7uKXe0Yz+X+a0dGsvGeJXplzmDE6hClPzHf1TA2G/cWH5jr6jaIhYgnYxdU3tekDQVD3LMPQmS+slmc4gAqNBhBANdN6qQ+3d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU52Y1BYVjRBSWZYWkpQMlBsSHR1MUNPTjZTRWRqTXVaVVE3WmticWhZSnp3?=
 =?utf-8?B?K3JXYk1WRTZTb1JMTzgzNHJScHplNm8vZjhodHNrZk96YmRYeWN2QzlUUkhn?=
 =?utf-8?B?b2l0Q0hha0RzSmhvUnVXK0tyRDJySHZmZitFQld1VXN5WnhrbXhuaFhLZkQv?=
 =?utf-8?B?WTUrVVNvRkJHMjY0TGNQSlZzaHZxRXBic1pzMU9qR3JLQ1FnYjJQQk1CNG11?=
 =?utf-8?B?VTZLZWpHT1Z3Tk1jdlFFL3hTcExCRU5lSkRtV01tb0hiNVcwbzVDZUNLQ0k2?=
 =?utf-8?B?RHFCNTBtRm9FN2N6NWpFWW1vYkVYYUxnMzBaeXlJYTBGbW9vMlNsR3pCRmlQ?=
 =?utf-8?B?T0NVdnVGcmR3Q2E4cHY1bk04eU1PYU1BdFN4RHpoMTJmSFJRMlN0RlBLNG56?=
 =?utf-8?B?N0U3clpNSDRrMGw2NUhzbjRlYlhqRm1Mcks1dVFKaXNwS3B2RGY1bFJURFgz?=
 =?utf-8?B?YTA3Y0RRM2JaTXB6QXdOVG0xTnk1Q0pJTTFtKzFGcWhIV3JJak5CWFFCOEpk?=
 =?utf-8?B?bERKU3NKUkpJS3JpdG9Ld3pIWmI2STV1MUJsaDQzWCtsa3RybnpOOE9UTWZj?=
 =?utf-8?B?OW9OUU4xRzdMTjNQYy9UMzloSHJHNWhvTkM3MGk0RUtUajF1RGVMeUVnNUo2?=
 =?utf-8?B?Q2ExV2hxWHQyODdNc09GaWpienFsVnRqVE9hZkczSVVqRGN6aDBUemYvL2ZS?=
 =?utf-8?B?ZUExSjlYeGkxZ0lKMGpLSVVydUx6cGptRUxjdERsM1ZJam5kWE8zTHJuQXho?=
 =?utf-8?B?N1dZRmZOM3JUcTZJektsTnJ0VWlOc05VOXppRUl6M3BoSTlUb1craFluSmRL?=
 =?utf-8?B?YytsdTBWNFFSVGhFY2R3Qi9FbCt6ODV6VnFYL1U1OGZHRU1scjlsZVBKYU82?=
 =?utf-8?B?N1Y3V09jUW5RdklhdUVaeWRsLzZuUExSWHA5VE5yZnFaTTFwNnA5VlZhanVG?=
 =?utf-8?B?V2ttNW1HK1hvQkE5QmpUQU94UjRtaUlIMWR6TUhCQVJyeU5laThCTkorYkQ5?=
 =?utf-8?B?LzhNVlJVM3JDcG15VjR6TEl1OFFTVFFwOXY0bWlwclIzQWhMS3VZN3p1Mm1v?=
 =?utf-8?B?YUtsMTNIMTNldnNHVGVFayszeFVKdnU5Q2kwYTh2K1ZyVERWSy9jbWN0NVdX?=
 =?utf-8?B?NzRBdVBmYlp0b3VhQ2duMkpOMVhiSTVkeUY1QjdPQXp4eGdCSlQ5VnQ0ZUlK?=
 =?utf-8?B?OE00OE1DMTZScWJ3ZzlqV29XZU50Vm5zUHdEVmJ6amFiTTFBa29Xczg4Skhx?=
 =?utf-8?B?dEd2Q3ErbEQzZVhlMGx2dmZVaGIzTCtuZFZoUFZ5SUZHTzlZVTRsdXJIejB5?=
 =?utf-8?B?dm96RWowYWtlcVZOQ1M3M3VkTXVsMExCemRjcU1tczBZWWFWaFYyRE1ZS0xt?=
 =?utf-8?B?enowdTg0bkRGQVBQNmhnaHBGQ2IvTW9GbUxpYkcxTk0rNlUxM2VvYzAzS2s0?=
 =?utf-8?B?TGY3M3NyOFl0MmdvZVh5bElydGpQc0JMYnFSUFpnQjVqWnY1enMxUUxTYzVm?=
 =?utf-8?B?czN3NFJMOXNENjBGMlNMcGtKejV2L2JRTXlveUlwcDJ2TDYvcXBDSkRPd2Fx?=
 =?utf-8?B?VHZZM25CRWRoUkhQSW9ab2pjQk9wK0hsdG42c3hQcUxvVjZCU1pEaDZzaHBy?=
 =?utf-8?B?T3poOFRveFFaaCtNTklYRE5KWEw3Zm9qT0lHTSszN1FWQ05iSHdGVys0NmNG?=
 =?utf-8?B?aW5lZUc3TVdHMWpyWDZ6S281ZXhiS0lxL3ZkRk5RdEllZUJKblkyVXErNzJ6?=
 =?utf-8?B?aWFjMEoxM0owSjByM3lLblNxU2hTQVlqUUVrQnA5RDVZM0g0akU1d3hldGJj?=
 =?utf-8?B?T0N6V0ljMTJZSVBqMEpZSUMzMDdUUHRFb0txVWd4cHMwRCtRb3lwa2pGQUNw?=
 =?utf-8?B?bm5uTUpHVElha0lpZ21VOEJvV3YwRm5iWlFxN3hUb0Z5c1l6aDI1K0ZLWGho?=
 =?utf-8?B?RVFPQ0xhUytpcHBSVjYvTkFTZkVTL2tNeVI1TkVxczFrNnNxVHI2Zlk1V21q?=
 =?utf-8?B?ck1hbk52VTNRcHg2RlRIdk8rTlRLUzdqcVVNTkZvM1dtYnlicmtqa2lLbnJU?=
 =?utf-8?B?ckthckRlbDlGSFVYSWVzRlU0U092M3loTkZqNDNJMmt1RGg1eDVyU05Bcy9r?=
 =?utf-8?B?SHdwencvWnZJRUlwZVdPd2NRNTFuSFUrQUNKcUw0dytiN1E2bG4wMUE5WWdX?=
 =?utf-8?B?aFVqMVJ0a0J6SllOaGpKMWtVcFNHN3U4cWRkYXBSMzMvRi9ObHYxbjBKdmU4?=
 =?utf-8?B?YktTVE1XQkgxS0dsTmppaEg1bm0vNm1ndkVhOTZPVjY1M1E4NDM5WC9ZeTRa?=
 =?utf-8?B?bHY1VXE5UXIwZXQ1TXF4MkxsaXJOY0RsbFFSdm5pamxaUnBjSytMUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c535cfd1-70e9-4135-4e5a-08debef7717f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:50.4462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLpwKtFqzS93n4SSE4jHKMde9bpac+R14nBZ+jn12aHMb/b/0zfkSscrjf4MjCaos1fdNTGX1IEwTxZu69/5cg==
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

Stub the PLL, oscillator and clock control registers that
firmware reads during boot.  PLL always reports locked so
startup code does not time out.

Originally-by: David Brenken <david.brenken@efs-auto.de>
Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/meson.build           |   2 +
 hw/tricore/tricore_scu.c         | 240 +++++++++++++++++++++++++++++++++++++++
 include/hw/tricore/tricore_scu.h | 103 +++++++++++++++++
 3 files changed, 345 insertions(+)

diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
index 7e3585daf8..96e367f996 100644
--- a/hw/tricore/meson.build
+++ b/hw/tricore/meson.build
@@ -3,5 +3,7 @@ tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testboa
 tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testdevice.c'))
 tricore_ss.add(when: 'CONFIG_TRIBOARD', if_true: files('triboard.c'))
 tricore_ss.add(when: 'CONFIG_TC27X_SOC', if_true: files('tc27x_soc.c'))
+tricore_ss.add(when: 'CONFIG_TC39X_SOC', if_true: files('tc39xb_soc.c'))
+tricore_ss.add(when: 'CONFIG_TRICORE_SCU', if_true: files('tricore_scu.c'))
 
 hw_arch += {'tricore': tricore_ss}
diff --git a/hw/tricore/tricore_scu.c b/hw/tricore/tricore_scu.c
new file mode 100644
index 0000000000..4baabc7d82
--- /dev/null
+++ b/hw/tricore/tricore_scu.c
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Control Unit (SCU)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#include "qemu/osdep.h"
+#include "hw/tricore/tricore_scu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+/* Register offsets */
+enum {
+    A_OSCCON        = 0x10,
+    A_PLLSTAT       = 0x14,
+    A_PLLCON0       = 0x18,
+    A_PLLCON1       = 0x1C,
+    A_PLLCON2       = 0x20,
+    A_PLLERAYSTAT   = 0x24,
+    A_CCUCON0       = 0x30,
+    A_CCUCON1       = 0x34,
+    A_CCUCON2       = 0x40,
+    A_CCUCON3       = 0x44,
+    A_CCUCON4       = 0x48,
+    A_CCUCON5       = 0x4C,
+    A_WDTSCON0      = 0xF0,
+    A_WDTCPU0CON0   = 0x100,
+    A_CHIPID        = 0x140,
+};
+
+static void tricore_scu_update_ccucon(TriCoreSCUState *s)
+{
+    if ((s->ccucon[0] & MASK_CCUCON0_UP) ||
+        (s->ccucon[1] & MASK_CCUCON1_UP) ||
+        (s->ccucon[5] & MASK_CCUCON5_UP)) {
+        s->ccucon[0] &= ~(MASK_CCUCON0_UP | (1U << 31));
+        s->ccucon[1] &= ~(MASK_CCUCON1_UP | (1U << 31));
+        s->ccucon[5] &= ~(MASK_CCUCON5_UP | (1U << 31));
+    }
+}
+
+static uint64_t tricore_scu_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    TriCoreSCUState *s = TRICORE_SCU(opaque);
+
+    switch (offset) {
+    case A_OSCCON:
+        return s->osccon;
+    case A_PLLSTAT:
+        /*
+         * Report PLL as always locked: VCOLOCK=1, K1RDY=1, K2RDY=1.
+         * Firmware polls these bits during clock initialisation.
+         */
+        return 0x00000077;
+    case A_PLLCON0:
+        return s->pllcon[0];
+    case A_PLLCON1:
+        return s->pllcon[1];
+    case A_PLLCON2:
+        return s->pllcon[2];
+    case A_PLLERAYSTAT:
+        return 0x00000077;
+    case A_CCUCON0:
+        return s->ccucon[0];
+    case A_CCUCON1:
+        return s->ccucon[1];
+    case A_CCUCON2:
+        return s->ccucon[2];
+    case A_CCUCON3:
+        return s->ccucon[3];
+    case A_CCUCON4:
+        return s->ccucon[4];
+    case A_CCUCON5:
+        return s->ccucon[5];
+    case A_WDTSCON0:
+        return s->wdtscon1;
+    case A_WDTCPU0CON0:
+        return s->wdtcpu0con0;
+    case A_CHIPID:
+        return 0x47477172 | (1U << 31);
+    default:
+        if (offset < SCU_REG_SIZE) {
+            return s->regs[offset / 4];
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "tricore_scu: read at bad offset 0x%" HWADDR_PRIx "\n",
+                      offset);
+        return 0;
+    }
+}
+
+static void tricore_scu_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    TriCoreSCUState *s = TRICORE_SCU(opaque);
+
+    switch (offset) {
+    case A_OSCCON:
+        s->osccon = (uint32_t)value;
+        /*
+         * Real silicon raises PLLHV and PLLLV once the external
+         * oscillator is stable.  Mark stable immediately.
+         */
+        s->osccon |= MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
+        break;
+    case A_PLLCON0:
+        s->pllcon[0] = (uint32_t)value;
+        if (s->pllcon[0] & MASK_PLLCON0_SETFINDIS) {
+            s->pllstat |= MASK_PLLSTAT_FINDIS;
+        }
+        if (s->pllcon[0] & MASK_PLLCON0_CLRFINDIS) {
+            s->pllstat &= ~MASK_PLLSTAT_FINDIS;
+        }
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_PLLCON1:
+        s->pllcon[1] = (uint32_t)value;
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_PLLCON2:
+        s->pllcon[2] = (uint32_t)value;
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON0:
+        s->ccucon[0] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON1:
+        s->ccucon[1] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON2:
+        s->ccucon[2] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON3:
+        s->ccucon[3] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON4:
+        s->ccucon[4] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON5:
+        s->ccucon[5] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_WDTSCON0:
+        s->wdtscon1 = (uint32_t)value;
+        break;
+    case A_WDTCPU0CON0:
+        s->wdtcpu0con0 = (uint32_t)value;
+        break;
+    default:
+        if (offset < SCU_REG_SIZE) {
+            s->regs[offset / 4] = (uint32_t)value & ~(1U << 31);
+            return;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "tricore_scu: write at bad offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps tricore_scu_ops = {
+    .read = tricore_scu_read,
+    .write = tricore_scu_write,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tricore_scu_reset_hold(Object *obj, ResetType type)
+{
+    TriCoreSCUState *s = TRICORE_SCU(obj);
+
+    s->ccucon[0] = RESET_TRICORE_CCUCON0;
+    s->ccucon[1] = RESET_TRICORE_CCUCON1;
+    s->ccucon[2] = RESET_TRICORE_CCUCON2;
+    s->ccucon[3] = RESET_TRICORE_CCUCON3;
+    s->ccucon[4] = RESET_TRICORE_CCUCON4;
+    s->ccucon[5] = RESET_TRICORE_CCUCON5;
+    s->fdr = RESET_TRICORE_FDR;
+    s->extcon = RESET_TRICORE_EXTCON;
+
+    s->osccon = RESET_TRICORE_OSCCON | MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
+
+    s->pllcon[0] = RESET_TRICORE_PLLCON0;
+    s->pllcon[1] = RESET_TRICORE_PLLCON1;
+    s->pllcon[2] = RESET_TRICORE_PLLCON2;
+    s->plleraycon[0] = RESET_TRICORE_PLLERAYCON0;
+    s->plleraycon[1] = RESET_TRICORE_PLLERAYCON1;
+    s->plleraystat = RESET_TRICORE_PLLERAYSTAT;
+    s->pllstat = RESET_TRICORE_PLLSTAT | MASK_PLLSTAT_VCOLOCK;
+
+    s->wdtcpu0con0 = RESET_TRICORE_WDTCPU0CON0;
+    s->wdtscon0 = RESET_TRICORE_WDTSCON0;
+    s->wdtscon1 = RESET_TRICORE_WDTSCON1;
+}
+
+static void tricore_scu_init(Object *obj)
+{
+    TriCoreSCUState *s = TRICORE_SCU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &tricore_scu_ops, s,
+                          TYPE_TRICORE_SCU, SCU_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void tricore_scu_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = tricore_scu_reset_hold;
+}
+
+static const TypeInfo tricore_scu_info = {
+    .name = TYPE_TRICORE_SCU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreSCUState),
+    .instance_init = tricore_scu_init,
+    .class_init = tricore_scu_class_init,
+};
+
+static void tricore_scu_register_types(void)
+{
+    type_register_static(&tricore_scu_info);
+}
+
+type_init(tricore_scu_register_types)
diff --git a/include/hw/tricore/tricore_scu.h b/include/hw/tricore/tricore_scu.h
new file mode 100644
index 0000000000..9cb7c916d0
--- /dev/null
+++ b/include/hw/tricore/tricore_scu.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Control Unit (SCU)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#ifndef HW_TRICORE_SCU_H
+#define HW_TRICORE_SCU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TRICORE_SCU "tricore_scu"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreSCUState, TRICORE_SCU)
+
+/* OSCCON bit positions (iLLD IfxScu_bf.h) */
+#define MASK_OSCCON_PLLLV               0x00000002  /* bit 1 */
+#define MASK_OSCCON_PLLHV               0x00000100  /* bit 8 */
+
+/* PLLCON0 fields */
+#define MASK_PLLCON0_VCOBYP             0x00000001
+#define MASK_PLLCON0_SETFINDIS          0x00000010
+#define MASK_PLLCON0_CLRFINDIS          0x00000020
+#define MASK_PLLCON0_NDIV               0x0000FE00
+#define MASK_PLLCON0_PDIV               0x0F000000
+
+/* PLLCON1 fields */
+#define MASK_PLLCON1_K1DIV              0x007F0000
+#define MASK_PLLCON1_K2DIV              0x0000003F
+
+/* PLLSTAT fields */
+#define MASK_PLLSTAT_VCOBYST            0x00000001
+#define MASK_PLLSTAT_VCOLOCK            0x00000004
+#define MASK_PLLSTAT_FINDIS             0x00000008
+
+/* CCUCON fields */
+#define MASK_CCUCON0_SRIDIV             0x00000F00
+#define MASK_CCUCON0_SPBDIV             0x000F0000
+#define MASK_CCUCON0_UP                 0x40000000
+#define MASK_CCUCON1_STMDIV             0x00000F00
+#define MASK_CCUCON1_INSEL              0x30000000
+#define MASK_CCUCON1_INSEL_BACKUP       0x00000000
+#define MASK_CCUCON1_INSEL_OSC0         0x10000000
+#define MASK_CCUCON1_UP                 0x40000000
+#define MASK_CCUCON5_UP                 0x40000000
+
+/* Reset values */
+#define RESET_TRICORE_OSCCON            0x00000112
+#define RESET_TRICORE_PLLSTAT           0x00000038
+#define RESET_TRICORE_PLLCON0           0x0001C600
+#define RESET_TRICORE_PLLCON1           0x0002020F
+#define RESET_TRICORE_PLLCON2           0x00000000
+#define RESET_TRICORE_PLLERAYSTAT       0x00000038
+#define RESET_TRICORE_PLLERAYCON0       0x00012E00
+#define RESET_TRICORE_PLLERAYCON1       0x000F020F
+#define RESET_TRICORE_CCUCON0           0x01120148
+#define RESET_TRICORE_CCUCON1           0x00002211
+#define RESET_TRICORE_CCUCON2           0x00000002
+#define RESET_TRICORE_CCUCON3           0x00000000
+#define RESET_TRICORE_CCUCON4           0x00000000
+#define RESET_TRICORE_CCUCON5           0x00000041
+#define RESET_TRICORE_FDR               0x00000000
+#define RESET_TRICORE_EXTCON            0x00000000
+#define RESET_TRICORE_WDTSCON0          0xFFFC000E
+#define RESET_TRICORE_WDTSCON1          0x00000000
+#define RESET_TRICORE_WDTCPU0CON0      0xFFFC000E
+
+/* Clock frequencies */
+#define SCU_FBACKUP                     100000000
+#define SCU_XTAL1                       20000000
+
+#define SCU_REG_SIZE                    0x1000
+#define SCU_NUM_REGS                    (SCU_REG_SIZE / 4)
+
+struct TriCoreSCUState {
+    /* private */
+    SysBusDevice parent_obj;
+
+    /* public */
+    MemoryRegion iomem;
+
+    /* CCU registers */
+    uint32_t osccon;
+    uint32_t pllstat;
+    uint32_t pllcon[3];
+    uint32_t plleraystat;
+    uint32_t plleraycon[2];
+    uint32_t ccucon[6];
+    uint32_t fdr;
+    uint32_t extcon;
+
+    /* Watchdog stub registers */
+    uint32_t wdtscon0;
+    uint32_t wdtscon1;
+    uint32_t wdtcpu0con0;
+
+    /* Backing store for remaining offsets */
+    uint32_t regs[SCU_NUM_REGS];
+};
+
+#endif

-- 
2.47.3


