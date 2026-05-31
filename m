Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E09CD6E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWc-00021y-Dx; Sun, 31 May 2026 05:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWX-00021R-JG
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:02 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWV-0008Ra-Dz
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJmoo48hcc34fvlTBaqov379zOoitC9vMRVsCft/Ga15zoQabEcF++sZWnwcU6vwXD05lKZG/w5okAeUsx+f1cLvOya38odWiIkyKZihnTKe+LFDOoyqoPee0+Op0UUmDMHfv/IuRdUZuxgDi7F3z6Hd22CWSObKzBf1CGkg8LDBt7+Fu2MmeaG5XPbaJTdZSWrS14LojG4MtvUfBXOGO62BUOAl6qXR0opwhLXQenItYU8XWvK/XlnvhuBfswuVAAwDXt8QqF0H9kAfuXWzdhpK4QHMpHnYH0G9TFWqWjMrOckMFzGD1/xCSB0dE1Rx1Jr9WZc3x6CNc9o2OYcfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zgyES9ODRTryQSAT6k+9bKI+sNwFGMtSoNoq+sMFg4=;
 b=JE0iHXgoNnJ3Wu9PVDunz3AxNxmtGu0eJQ+cqZhSXMulv6c8b5bRcNrPIkdxjTkPiIa9tmIcof3JYRtCwjRrLW4LjfiCY5pgqvZWFEXbf+v8UPCM7X6kfy8dD3HSoDzzepuSyaqa3eQwb9idNRC05RLPjppfSZ/K8LKUEUX50zpI/TFaXkmDNwJxeOK29zXzEY77HutvgC6VDcASf56C7x9Q8qlegGpiGFFf2nEpFMY06Q/9PRYPOJ77biO4TGLa9vjZgPngSHhArDf/Gf2XcJYtI+6j9y35G6cOWIq6F7fvwQpbdXOglJv7R2iz1KygDAnH0I0OeUkodx3jhyMT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:45 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:45 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:55 +0530
Subject: [PATCH 04/10] hw/intc: add TriCore interrupt router
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-4-1c39053e5e95@linumiz.com>
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
X-MS-Office365-Filtering-Correlation-Id: a448a751-5ddf-4264-7298-08debef76e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|3023799007|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: dWyAww0VtHgT0bX7NZnIsh4LNprfOKWAuQwGcbuZmRMlH6K2YJUzdyZxfMoCjo78TqNFQhBUOPvc7RM7Jd/NjFMlwezJ5OhiH5SD9wYvqqLEYFFj2mB9RU81c1y0vH6tWWyQGwkr7A/y7V0jJ9hjRS/zUzCmNqKrHviyOc1BBXsBC2yIU8SSi1HxxiiQ4Ht7lVSm3LX1LJxDm0br6S5PYcjEchjl52g9RykQSeuIe+7tlyQ/N1rqGp1+1mwiHo8g0NVGHVZZiphlFkBkghPMa4NtdIBBSnxQcsdOvxXnqrjwZfmDlKaqUbEOWpR1Hir6Q2UNYIxvbdMt4d9rHMs+qyvQB8nzUG9rW5QOtI1RvlxnTG5f4HeDz4EhihNwPBDfAg8esZQBGtdB9Uzqp/mTLPBzEHx9mHFKlgcsPkSvZSNyFd5XvZlV2aV7sPXIjVD3AsbxqnfzPwVFcpvij6IPDWcMbih3pLFIlcrobs3tAK2EC0vE0776Is8EVEI9pJc3zVHMLTf4LLbUIbm8KlqMEG7SUGmDokjUVPAv3kWvry22IQ4PJSjz3CTJkyDNDD4jJ3XHOvqiEUqJHPmqz4X+0TvkVpaUEHC9CMTzqejCFEN2kOapJQiLvb8UYvfxhM74iLNciDzab2kNchGH3wmwkNz1CReZ5zzFkvo5l9plB9GIBzgsAtI/DEXKc1vwkenXGDLbHHcmQvtqCDohLZCEolbaA1d+VTF7TFeSKbM4fjDgw+kNuZrvtOLIOYyBXnrv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(3023799007)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dsZy9sZjdBRkFLaytLOW5ndG15L0t5ZGoxRDV3TmxZcnRJSVZvM0RwS3h1?=
 =?utf-8?B?WklhR3lCVno0OW9wbmZtaHRzbXgxTWdBeUo4MWlhY2djcnFKamlDbWh4NHA5?=
 =?utf-8?B?WUpwTy81ci9wRmdWR1BLMEwyWjlodGMyOEE0ODltcTZCVlhSS1VFeVQyYWd0?=
 =?utf-8?B?R3J2N0E5NkF5cjBnMHQwQUNiUkNJT2c1eERiREx4WTZSY1BQTENIc1ZKb2N6?=
 =?utf-8?B?U3hUS3dCdDlZL25JeG1jRkhBZGc2N2dpQ3phTTU2VVB2U0lrL3ZRTkZURCtw?=
 =?utf-8?B?NnJTeHlBRk9ET2Rzb3QzRVNUaURuMEYybTVPMHBFVUc3OEFsM0lCYWFQZG1v?=
 =?utf-8?B?c1h1NDdnRHh3ZGdUQUw3K3Y1UW9KaFFEUFVoQURpdlQ0Z25zbTdYYXE2VGxN?=
 =?utf-8?B?RmdGWEFGQ0RDUHdDYy9mWkUvcmdSbGlzeE1ROHFrdDk5NEhlejZSU0pWZ1dG?=
 =?utf-8?B?U2d1ek1pM1FLQXV1UzJPOFlCcGlreUhZVGxkblhxaUgwL0pqWWlLVGc0b3Vy?=
 =?utf-8?B?NFJpd3RVa0x1RGNYVHV4WjlEK0tta0IzMnI0U3puV1dNQ09MeE01bUwzWXJy?=
 =?utf-8?B?SzFodHV2WWRMUDJlZ3VNUUdHS1QzOHV1dWVMS21TVkxYTU9NNGpKVWQrYlBO?=
 =?utf-8?B?OWdWbk9JN1RHakwzOFB3Z3NDUXgybTFMeEdlOWFqZ05nS29ZaTc3R0FUOFhY?=
 =?utf-8?B?MEI5ZnczNDIzRnhGNHZMOC9nOHpMaGVKZG9sNG80T3d3MzlKa3BpOW10a0FZ?=
 =?utf-8?B?UkdFa2dySndQb3paRm9xTGdLdGNmbW1pMm1jelpRU3pjeVZNd3pvelBhTkdj?=
 =?utf-8?B?WDZJYlJUbEZYQVQ0WnZzVGFDcFZERmMwclBhLzlWRkttcVJISVg5VnpIeEFY?=
 =?utf-8?B?MTZya3NCSzBQUnlQbkxTcjgvMWJxWnBObW1lMzMybHVUVlc4ZHpYSWZpbFcw?=
 =?utf-8?B?eVRpUHdZR0JsQWhlZVJxcFlEVENCM0QwQmNPUitIZ1BKK0hrZFpkS1paRU1Q?=
 =?utf-8?B?bWZudnVFaDdXRkxnNlNKS2wvd1dTSjFIVzc0TXB0L2doQWFkNFF2cnFQb0do?=
 =?utf-8?B?Z1lDS21SeDI1UHd4YzlabTU0dTJRc3MzOXdOMFAvTVlSVnZkM2N6U25Ib3ZY?=
 =?utf-8?B?T3VvTWw1L0wxYWo2QWZReXlmUlQzcXBGL2I1bStESE9RZ0kyMVVuWXNyWHJO?=
 =?utf-8?B?bFlmZ3I3VnZKZHRDb2FIUzErdUpRVnRmb01RMWZTeUx5M28rWFZZUDVkbHpC?=
 =?utf-8?B?bGplN01aREtFdGxWM0FNN0k0Nk5aa2NSUkNuZHQwMS9xZFRnMVQwUTE0MTJz?=
 =?utf-8?B?UWszdEc4MDlxYlRvOVIwL0N2d0hPbGJab3gyQkpGVnFZanhpc2tNdmRZMVV5?=
 =?utf-8?B?bkF1ajhaamRnT3l2SVV1QzRKcUhhOWtpOFNxWUhpNDhqTWpRM2xKUEJiWm95?=
 =?utf-8?B?dVZNajI4bXJtOTZvWDJjemE4bXN5b3dSRElrT2NLV01pcERUeis1TWlrcE9M?=
 =?utf-8?B?N2JBQ3VWdmZSTDZyUkNqT3BCMCtCcXRraTQ5OGV2QzI2Zk9qS3VZOEdyUW5O?=
 =?utf-8?B?SldqZE90c054RjQyY2RRRlkrcnRLTTdOSXVEZmlZQnREM091ZkMyRGpVUThh?=
 =?utf-8?B?ci9UZHVGaEFERjJqYjkxRUVzb054VG5pSDBqRGJjZkZKR1dXaW1uc0dUT2wx?=
 =?utf-8?B?d2VveDFmbmRMU21Ja2NpMlFYZmw1THpuUERnc0pacFRHWk5peHA2R0ZWTStJ?=
 =?utf-8?B?UmhnaHIvbXVvbVk2Q2hMNmdLbzBPUm1uTXhXbjhwSzlFb25vbGI5dzY0czli?=
 =?utf-8?B?Sjc4eXhPRGsvUWY4L1Fvb3lKaHVadGxxVTUxblJzcVMrK0gwWldkZDgzK2k4?=
 =?utf-8?B?eE4rdjl3d2taWktQMTRwUUJzN0RnNXY1dTA1WlRPUDJkK3cwNll2RzB4ZXZH?=
 =?utf-8?B?SVJiTzdvakdTeTAvUmx3UWhsdHJZNHBnRXJCV2FxaUNRMVE3SnFHMUNzazlw?=
 =?utf-8?B?dG54NkZIL2wwOEhUNVlpckFzY1ZuU1BJd0xmS3ZQZUtGUTN5Ynp2NUtaNzAz?=
 =?utf-8?B?ZVlzKytnVFFLazBkSTZCTkNUeFFYTjY3dDRrKy9JR0NSaWNTbkRueEJYOFFV?=
 =?utf-8?B?cHRudkMxWUhXaDRQWmZBNjVTc2NjWTJvQnpHayszb2dRME80cHJibUxjWDJJ?=
 =?utf-8?B?TEtPRXlubnFWaTRFMzF1VUg1bFRGVmRSYlI5eHRDSGQzL1lTMzl1QlBMcjJL?=
 =?utf-8?B?WE40bkhtczVnMlNNRzJLZmVIYXViVWFWUjFxMVFuNHVLTXNnY2tBODlYOGs0?=
 =?utf-8?B?RXdaTVdsNmJaWXRkQ2twVzc2M0tTVjZQN0JRQWxDa3RpanFHdnhzdz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a448a751-5ddf-4264-7298-08debef76e94
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:45.5495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5ptU+NK3VFfze6IK7syoY91UDKrrMXe7KjbMFw/Xg7Ls5DyD9DZ7QrA/qatLWD1MEjC5qNP8GlqWK93MqWYeA==
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

Model the TriCore IR which manages Service Request Nodes (SRNs).
Each SRN has priority, enable, TOS (CPU selector) and request
flag bits.  The IR picks the highest-priority pending SRN per
TOS and raises the corresponding CPU output line.

Originally-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/intc/Kconfig              |   3 +
 hw/intc/meson.build          |   1 +
 hw/intc/tricore_ir.c         | 264 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/intc/tricore_ir.h |  62 ++++++++++
 4 files changed, 330 insertions(+)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 636d00b7e8..686c7d22fe 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -117,3 +117,6 @@ config LOONGARCH_EXTIOI
 
 config LOONGARCH_DINTC
     bool
+
+config TRICORE_IRBUS
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index fac2d228f9..10c316b62b 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -88,3 +88,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extio
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
                if_true: files('loongarch_extioi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_DINTC', if_true: files('loongarch_dintc.c'))
+system_ss.add(when: 'CONFIG_TRICORE_IRBUS', if_true: files('tricore_ir.c'))
diff --git a/hw/intc/tricore_ir.c b/hw/intc/tricore_ir.c
new file mode 100644
index 0000000000..44861bf899
--- /dev/null
+++ b/hw/intc/tricore_ir.c
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore Interrupt Router (IR)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2026 Parthiban Nallathambi <parthiban@linumiz.com>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+#include "hw/intc/tricore_ir.h"
+#include "qemu/log.h"
+
+static void irq_evaluate(void *opaque)
+{
+    TriCoreIRState *s = opaque;
+    uint16_t tos_irq[8] = {
+        0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF,
+        0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF,
+    };
+    uint8_t tos_priority[8] = { 0 };
+    uint32_t srcnum;
+    uint8_t tos_idx;
+
+    for (srcnum = 0; srcnum < s->num_irqs; srcnum++) {
+        uint32_t src_reg = s->src_regs[srcnum];
+        uint8_t priority = FIELD_EX32(src_reg, SRC, SRPN);
+        uint8_t tos = FIELD_EX32(src_reg, SRC_TC3X, TOS);
+
+        if ((src_reg & R_SRC_SRR_MASK) &&
+            (src_reg & R_SRC_TC3X_SRE_MASK)) {
+            if (qemu_loglevel_mask(CPU_LOG_INT)) {
+                qemu_log("tricore_ir: pending irq #%u"
+                         " (priority %u, TOS %u)\n",
+                         srcnum, priority, tos);
+            }
+            tos_priority[tos] = priority;
+            tos_irq[tos] = srcnum;
+        }
+    }
+
+    for (tos_idx = 0; tos_idx < s->num_isps; tos_idx++) {
+        if (tos_irq[tos_idx] == 0xFFFF) {
+            s->lwsr[tos_idx] = 0;
+            qemu_irq_lower(s->isp_irqs[tos_idx]);
+        } else {
+            s->lwsr[tos_idx] =
+                FIELD_DP32(0, LWSR, STAT, 1) |
+                FIELD_DP32(0, LWSR, ID, tos_irq[tos_idx]) |
+                FIELD_DP32(0, LWSR, VALID, 1) |
+                FIELD_DP32(0, LWSR, PN, tos_priority[tos_idx]);
+
+            if (qemu_loglevel_mask(CPU_LOG_INT)) {
+                qemu_log("tricore_ir: raise TOS %u irq line"
+                         " (irq: %u, priority: %u)\n",
+                         tos_idx, tos_irq[tos_idx],
+                         tos_priority[tos_idx]);
+            }
+            qemu_irq_raise(s->isp_irqs[tos_idx]);
+        }
+    }
+}
+
+static void irq_handler(void *opaque, int srcnum, int level)
+{
+    TriCoreIRState *s = opaque;
+    uint32_t src_reg = s->src_regs[srcnum];
+
+    if (level) {
+        if (src_reg & R_SRC_SRR_MASK) {
+            src_reg |= R_SRC_IOV_MASK;
+        }
+        src_reg |= R_SRC_SRR_MASK;
+    }
+    s->src_regs[srcnum] = src_reg;
+
+    irq_evaluate(opaque);
+}
+
+void tricore_ir_irq_acknowledge(TriCoreIRState *s, uint16_t irq, uint8_t vm)
+{
+    uint32_t src_reg;
+
+    if (!s || irq >= s->num_irqs || vm >= ARRAY_SIZE(s->lwsr)) {
+        return;
+    }
+
+    /* Capture LWSR into LASR before clearing */
+    s->lasr = s->lwsr[vm] | FIELD_DP32(0, LASR, ENTER, 1);
+
+    src_reg = s->src_regs[irq];
+    src_reg &= ~R_SRC_SRR_MASK;
+    s->src_regs[irq] = src_reg;
+
+    if (FIELD_EX32(s->lwsr[vm], LWSR, ID) == irq) {
+        irq_evaluate(s);
+    }
+}
+
+static uint64_t tricore_ir_src_regs_read(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    TriCoreIRState *s = opaque;
+    hwaddr srcnum = offset >> 2;
+
+    if (srcnum < s->num_irqs) {
+        return s->src_regs[srcnum];
+    }
+
+    return 0;
+}
+
+static void tricore_ir_src_regs_write(void *opaque, hwaddr offset,
+                                      uint64_t value, unsigned size)
+{
+    TriCoreIRState *s = opaque;
+    hwaddr srcnum = offset >> 2;
+    uint32_t srcc;
+    bool setr;
+    bool clrr;
+
+    if (srcnum >= s->num_irqs) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "tricore_ir: write to unmapped SRC offset"
+                      " 0x%" HWADDR_PRIx "\n", offset);
+        return;
+    }
+
+    srcc = value & ~(R_SRC_SETR_MASK | R_SRC_CLRR_MASK);
+    setr = value & R_SRC_SETR_MASK;
+    clrr = value & R_SRC_CLRR_MASK;
+
+    if (setr && !clrr) {
+        srcc |= R_SRC_SRR_MASK;
+    } else if (clrr && !setr) {
+        srcc &= ~R_SRC_SRR_MASK;
+    }
+
+    s->src_regs[srcnum] = srcc;
+
+    irq_evaluate(opaque);
+}
+
+static const MemoryRegionOps tricore_ir_src_regs_ops = {
+    .read = tricore_ir_src_regs_read,
+    .write = tricore_ir_src_regs_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/*
+ * IR INT registers (LWSR, LASR)
+ *
+ * TC3x LWSR offset: 0x200 + x * 0x10 (x = CPU index)
+ * TC3x LASR offset: 0x200 + x * 0x10 + 4
+ */
+#define IR_INT_LWSR_BASE    0x200
+#define IR_INT_CPU_STRIDE   0x10
+#define IR_INT_ID_OFF       0x08
+
+/* Module ID: IR module number 0x00B9, type 0xC0, rev 0x13 */
+#define IR_INT_MOD_ID       0x00B9C013
+
+static uint64_t tricore_ir_intregs_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    TriCoreIRState *s = opaque;
+    uint32_t x;
+    uint32_t sub;
+
+    if (offset == IR_INT_ID_OFF) {
+        return IR_INT_MOD_ID;
+    }
+
+    /* TC3x LWSR: 0x200 + x*0x10, LASR: 0x200 + x*0x10 + 4 */
+    if (offset >= IR_INT_LWSR_BASE &&
+        offset < IR_INT_LWSR_BASE + IR_INT_CPU_STRIDE * 8) {
+        x = (offset - IR_INT_LWSR_BASE) / IR_INT_CPU_STRIDE;
+        sub = (offset - IR_INT_LWSR_BASE) % IR_INT_CPU_STRIDE;
+        if (sub == 0 && x < 8) {
+            return s->lwsr[x];
+        }
+        if (sub == 4 && x < 8) {
+            return s->lasr;
+        }
+    }
+
+    return 0;
+}
+
+static void tricore_ir_intregs_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    /* LWSR/LASR are read-only from software side */
+}
+
+static const MemoryRegionOps tricore_ir_intregs_ops = {
+    .read = tricore_ir_intregs_read,
+    .write = tricore_ir_intregs_write,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tricore_ir_init(Object *obj)
+{
+    TriCoreIRState *s = TRICORE_IR(obj);
+
+    memory_region_init_io(&s->src_region, obj, &tricore_ir_src_regs_ops,
+                          s, "tricore_ir.src", 0x4000);
+    memory_region_init_io(&s->int_region, obj, &tricore_ir_intregs_ops,
+                          s, "tricore_ir.int", 0x1000);
+}
+
+static void tricore_ir_realize(DeviceState *dev, Error **errp)
+{
+    TriCoreIRState *s = TRICORE_IR(dev);
+
+    s->src_regs = g_malloc0_n(s->num_irqs, sizeof(uint32_t));
+    s->isp_irqs = g_malloc_n(s->num_isps, sizeof(qemu_irq));
+
+    qdev_init_gpio_in_named(DEVICE(s), irq_handler, "irq", s->num_irqs);
+    qdev_init_gpio_out_named(DEVICE(s), s->isp_irqs, "isp", s->num_isps);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->int_region);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->src_region);
+}
+
+static const Property tricore_ir_properties[] = {
+    DEFINE_PROP_UINT8("num-isps", TriCoreIRState, num_isps, 1),
+    DEFINE_PROP_UINT16("num-irqs", TriCoreIRState, num_irqs, 256),
+};
+
+static void tricore_ir_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->user_creatable = false;
+    dc->realize = tricore_ir_realize;
+    device_class_set_props(dc, tricore_ir_properties);
+}
+
+static const TypeInfo tricore_ir_info = {
+    .name = TYPE_TRICORE_IR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreIRState),
+    .instance_init = tricore_ir_init,
+    .class_init = tricore_ir_class_init,
+};
+
+static void tricore_ir_register(void)
+{
+    type_register_static(&tricore_ir_info);
+}
+
+type_init(tricore_ir_register)
diff --git a/include/hw/intc/tricore_ir.h b/include/hw/intc/tricore_ir.h
new file mode 100644
index 0000000000..d7b167e50d
--- /dev/null
+++ b/include/hw/intc/tricore_ir.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore Interrupt Router (IR)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2026 Parthiban Nallathambi <parthiban@linumiz.com>
+ */
+
+#ifndef HW_TRICORE_IR_H
+#define HW_TRICORE_IR_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/registerfields.h"
+#include "qom/object.h"
+
+#define TYPE_TRICORE_IR "tricore_ir"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreIRState, TRICORE_IR)
+
+/* SRC register fields common to all TriCore variants */
+FIELD(SRC, SRPN, 0, 8)
+FIELD(SRC, SRR, 24, 1)
+FIELD(SRC, CLRR, 25, 1)
+FIELD(SRC, SETR, 26, 1)
+FIELD(SRC, IOV, 27, 1)
+FIELD(SRC, IOVCLR, 28, 1)
+
+/* TC3x SRC bit layout */
+FIELD(SRC_TC3X, SRE, 10, 1)
+FIELD(SRC_TC3X, TOS, 11, 3)
+
+/* LWSR register fields */
+FIELD(LWSR, PN, 0, 8)
+FIELD(LWSR, VALID, 12, 1)
+FIELD(LWSR, ID, 16, 9)
+FIELD(LWSR, STAT, 31, 1)
+
+/* LASR register fields */
+FIELD(LASR, PN, 0, 8)
+FIELD(LASR, ID, 16, 11)
+FIELD(LASR, ENTER, 31, 1)
+
+struct TriCoreIRState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion src_region;
+    MemoryRegion int_region;
+
+    uint32_t *src_regs;
+    uint32_t lwsr[8];
+    uint32_t lasr;
+
+    qemu_irq *isp_irqs;
+
+    uint8_t num_isps;
+    uint16_t num_irqs;
+};
+
+void tricore_ir_irq_acknowledge(TriCoreIRState *s, uint16_t irq, uint8_t vm);
+
+#endif /* HW_TRICORE_IR_H */

-- 
2.47.3


