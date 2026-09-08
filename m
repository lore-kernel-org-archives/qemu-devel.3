Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D599BC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIJ-0000T0-SE; Tue, 08 Sep 2026 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIG-0000Pc-Rw; Tue, 08 Sep 2026 06:43:12 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIE-0006bO-Q8; Tue, 08 Sep 2026 06:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMfViC78INrCZNDR0Yn7DAv0+Dnxrur04wNQ28tWyjfBIDiSdLjFfNXUdOg2iWE6hY1kG4EowJNL0uZm33KLGr7jXCiFmOcwUXiLuzR4yj4jKKMKhDRPAiLWoNsqYKJHNQhyvahnLg3a7xO4PTrbTwRKAC1aBsm8Wj+sy+yxnxwoBQA3iEs13IgIC7Sg15ha/gJ3Kc96V4ZjASGI3D40yRQl3CsxCtywR77MHSoh9r5tP9vmpG2Rh9FIQcyii39cLu46ct4ztcev/zkC/Ef2SH5bNaA/rkn+ZWYRzGqipwmutebtShVwGvZbavqM9o9E+zy9mQ0WIix+jyFpm0Vjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiqQX0TSej/Hh5Q7A7uV8LuwCWi7zDBQi85GkFNokVU=;
 b=KZVsgbtOgAWK6xkb9tQV1lTqOl/DFD8+AURExJCnBpgjLiNcxu6GyCulFmRmg2LufN1P8mqp2W8XbeQhRjCD36ZA91XQOCjZ1GAnPAhNccne4WBfqaUyeqmHA6KaeOd5kXdXY3VbC3GdcMFHvmP/Uogqwad4XJPk87HrLrv2tV2tyNTdzpOWdTDTJ6s8/foHTgBE26XLNJ7UGRb71ipzHn4nn3pdi630z2Yl5CVJCSlomEjVYy8XgzBAHy17Jhc8QfKPtQcDluAgZ43xebH8EAHCM8coWDWcGBIbS0WSXTe3De0Dyo5PlY1lPV7WUzFPc2lD4GBwic7Lj1I1/QEa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiqQX0TSej/Hh5Q7A7uV8LuwCWi7zDBQi85GkFNokVU=;
 b=vajM/VzvLx/O0x0wYtW9ziJ53TSM1wuTc6UtmR6Dy5FUVGyEtMhfTiKuCUYnuceWwCSz+c9Lc78tEhl03eo8Sbi71q5rsQUXoDyF4k8ZmpRxaaOMscmvLLIqb2RNo4xdOp8PhpK495eEUI8icrIzGjBaNNfrdIOPN5cWMU/g6ZW9vgJPmF4pjjqulei3VaewuaTTO9WyQnaD6ELNDCQ9wtJIHQGHcbHwTcIwpUrt1yMqjFx/Xz9ipFj1tUTraaKgSZHuoOBApz8UfqjKDMx63vFnUPKugNNDlffoPe75EXCAJBDsHO39Em6ocfSTjjpXXoVx4GW5D0u9J/fGP0PS+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:42:59 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:42:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 27/32] hw/arm: phytium: Add Phytium E2000 AHCI controllers
Date: Tue,  8 Sep 2026 18:41:36 +0800
Message-ID: <20260908104159.1621764-28-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: bf619a17-6fcb-480c-ceb5-08df0d95f33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MhO4aMmScn5q5V8dS/hwPvsEf1c483k5HKMAQ3atxmtO0+cJKasRgOhFFJF2VEiYNu4NKLf6z879UbJInTC0ikrUM3VPJWQiQmtgea/j+uf+z5eQtH3cgZ3RTZ3DXDxzS8XNFI2sMkO1kmzgMZwYYk1/QU/rUvAds7UNA2wB4DcZ2l11SfqyBhel+ywwtX3NdeS4p9fe/u4KUJA7X9TmKKQ/jVJIXUsbhC+fgWNzVL6WRK2Av+Wfd7FN/zqtcbGM4SWroQZHTTX0XTJTacZr+Vx2vMHi54jEeB9nFcQB4L0uYIUs42R3N1HECHSBI2ZwZQk9dUEAcjTfQNxlDoERayJJR8B2uET0cd/DzttaIkqDRHNkg13h2NZw/oalxLkE81aI1o2caRHjUhWAEgBt9t0/geDgEWybTgauEeBZo4X72Lq5cLlv21NBhjpvNyGfvYSC1scVwRJvPYqTqsSuM/WGIHmAv+M5sLHBUzTJqPb7YuoobiR6rnJPWkgHiYQtyZI7s5ATVDiNivB0LMu1JtuDlLWfFHOE9tpp8nB2oEl2D9F5PgEN00RNC3iqBc/BrIej5IG6y6cPdygSL6N7e4xsaJFYHyK8lrm+nGSPKMRD1wn6OFDzYC4IsqaP7GYqVcEVn4MQUg3L9f2LjkUf+91INpJaAa51sZPTSSCJb2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9z9+fE5Wsi9HMe7lsbnDphdaRqgkOlGjwQdiWQmrKlgIdZByh3MQT6YAb0ea?=
 =?us-ascii?Q?oF5Dv6Z26gM6tDmJ/m5DLITneaYtCzwJTUjnIpH9vcgEmwArxM6ERESAFjC9?=
 =?us-ascii?Q?hYdMGfAJw1dcWi1dB/q/LirrubEwEvyLq/v3wmsqv6f09lobsKEATm4hMkcn?=
 =?us-ascii?Q?WR5T0G9n/0/7RZpfxSC59nFmOgbjhWraiw+0pMl12Gr3uRaMKLm8JYGZQJ1e?=
 =?us-ascii?Q?e7SIgUmpyjOjYtQzPangc99pbAfvCTOHR8gz7ni/0ecuUZP+9HRgeA1gUK+K?=
 =?us-ascii?Q?gHEblv0+UkmGBny8N13lUP9yUEtuXrxwtmAkSt63X1r5KvjXtxvxQe4G8L0H?=
 =?us-ascii?Q?2P9FGq2nr0BmpQkUIBvf1tN1C5IanuCWA1vIkFv3MBPbnYMb8n4drO1a8+fH?=
 =?us-ascii?Q?AY/OQJtXac9zcmREQAqbmg2DTPjUMDlfWNmIBAHU04DgRpBFAY0KKy6WrIYY?=
 =?us-ascii?Q?1BFrKe0NBEldiGWGoCq5VATAS+3IahdDSyl1zJPEuPMz1S6n8wBc+7TEHRnq?=
 =?us-ascii?Q?A4DkejL+V2SyRNK+foW02mNrL9KjGR38s0pB2VvrIUcKR24bC79Mu/mo4agi?=
 =?us-ascii?Q?3gfyzXFgLF+MYNkzieu7yQ1ZVWboq/tJ4mO1yLZPdmyNrfs8xYj0KYzNeax2?=
 =?us-ascii?Q?U0hCn4854IY1gNgznWwUE5/fQWwdUhqdNpH+Su5cCy15qtbXay8ISUX6ED4N?=
 =?us-ascii?Q?lzCDE85W02ckzQg9r0tj6Xg33GyfXiga3vi5cSO/AhEFTzJYnq5uhjzbNG+W?=
 =?us-ascii?Q?UYUWK7v4Djn8dqoNcgr/QwJmv58hONhoZS80QOp5C1EhRS/o+SX/kk+eXH0R?=
 =?us-ascii?Q?P20BD1iMVR9qDaEuNMe+s5UKnDRhkCGsEA+pAP9Qj+5q0/KswkNowh3GUNW6?=
 =?us-ascii?Q?HdyNUbt9Rq+V9PZttcLWCqTxmkqo6zaKxs7RxHjAyjaHzoES1IhOyjBcJOBs?=
 =?us-ascii?Q?qJZPySfkjaUr4SABiQOaq3o+NdPkLWR5Z98GZ4QLgj0JCgG5Tpr1QSrSmAdz?=
 =?us-ascii?Q?4ZmEczvOSzotBvdQ29XSERiwzEaQDSn7xngNJeyxlTdCX9rqe912RzOjC5T4?=
 =?us-ascii?Q?xeTb6bWfqf9Qb1jIFtAVVzeXIjNY6EvID48ddFHHCLNSij6jcXut1+oAA8hg?=
 =?us-ascii?Q?TAK2JsPA7DvY8XrYX5iX3iGq7uIwD0dap1x6xn/ZX8OiMjWQ5F1Shjg7VH+T?=
 =?us-ascii?Q?4l0DY3L7EnVcUqEw8Qw5VSdiSvD3B6HeRc1lQMHNRhaBKi2rq+JYEKwgWI9U?=
 =?us-ascii?Q?qL9lctpQLQgCR4Rv3Vjp7Xm0qKn0Y0/WqJhRN2ga9iOQIyvhkYkapZXhxExp?=
 =?us-ascii?Q?ND7wZ4jICTMcs8MojdRHqLfpGKp3OP3MwCrSOSOMpSxHZDon5bBsiWuOUrsN?=
 =?us-ascii?Q?RSRrOF50M6vFFTy1HmYFRsuczsvLc6348rz/k3nhF3TFSXtrHowlrcPBzkdr?=
 =?us-ascii?Q?IO288+HrsYGqjvnBZWnVbkYNcJkWA+JJzfKzDpUPrgKAwqTaM1mSU18EoE29?=
 =?us-ascii?Q?Z0xZ9nmgTaJJUoTQv1Epz4ziVtm3ZQMj/tQWDH5M6aFismrDalbAy0AwCGEK?=
 =?us-ascii?Q?rhZZJuIi9X20G1J5I9F8WkN2qlMtMyc+BPweT1k4QH3l2ja0+Y2Fuh20JA95?=
 =?us-ascii?Q?+v4JG3W2/6eio6h0M/UjXJJjx5FlHxYoKj9RGfP7EgQMHs6R80yIUvSLq6mo?=
 =?us-ascii?Q?1R3hgGoSI6p1YjMCnhRVIUR4ZKNWmTz4xALcPK7T/0BqWcT+3jL7K1bJPVvX?=
 =?us-ascii?Q?5hI3YDNpxBI9TQIsJ09UmAGgtCw/34Q=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf619a17-6fcb-480c-ceb5-08df0d95f33c
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:42:59.3060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+jQyvGpAQhInFBjM+JLxL8Mr2Eiqq/RsjXw7IubJr5vFj/On0mBzKAaKYIvZ+AI4cStnL6oOi6/znbzeUl7oaZY9Q384+honGJ8cvT/Vw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
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

Add the two single-port sysbus AHCI controllers integrated in the E2000
SoC and route their interrupts to the GIC. Both boards expose the fixed
controller blocks, but Phytium Pi does not wire either controller to a
SATA disk and therefore rejects an IDE backend.

The physical COMe board wires its boot SSD to the second controller.
Attach its SATA backend to AHCI1 so that U-Boot and Linux observe the
same controller order as on hardware.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Move AHCI controllers into the SoC and attach SATA in the machine

 include/hw/arm/phytium_e2000.h | 15 ++++++++++---
 hw/arm/phytium_e2000.c         | 39 ++++++++++++++++++++++++++++++++++
 hw/arm/phytium_e2000_machine.c | 27 +++++++++++++++++++++++
 hw/arm/Kconfig                 |  3 +++
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/phytium_e2000.h b/include/hw/arm/phytium_e2000.h
index baf9edd261..3d45a82811 100644
--- a/include/hw/arm/phytium_e2000.h
+++ b/include/hw/arm/phytium_e2000.h
@@ -24,9 +24,12 @@
 #define TYPE_PHYTIUM_E2000_SOC "phytium-e2000-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(PhytiumE2000SoCState, PHYTIUM_E2000_SOC)
 
-#define PHYTIUM_E2000_NUM_CPUS 4
-#define PHYTIUM_E2000_NUM_MCIS 2
-#define PHYTIUM_E2000_NUM_GEMS 4
+#define PHYTIUM_E2000_NUM_CPUS        4
+#define PHYTIUM_E2000_NUM_MCIS        2
+#define PHYTIUM_E2000_NUM_GEMS        4
+#define PHYTIUM_E2000_NUM_AHCIS       2
+#define PHYTIUM_E2000_NUM_SATA_PORTS  1
+#define PHYTIUM_E2000_SATA_BOOT_AHCI  1
 
 enum {
     PHYTIUM_E2000_QSPI_DIRECT,
@@ -53,10 +56,12 @@ enum {
     PHYTIUM_E2000_BOARD_CTRL,
     PHYTIUM_E2000_XHCI0,
     PHYTIUM_E2000_XHCI1,
+    PHYTIUM_E2000_AHCI0,
     PHYTIUM_E2000_GEM0,
     PHYTIUM_E2000_GEM1,
     PHYTIUM_E2000_GEM2,
     PHYTIUM_E2000_GEM3,
+    PHYTIUM_E2000_AHCI1,
     PHYTIUM_E2000_RNG_REGS,
     PHYTIUM_E2000_PLATFORM_CTRL,
     PHYTIUM_E2000_SECURITY_CTRL,
@@ -77,6 +82,7 @@ struct PhytiumE2000SoCState {
 
     DeviceState *gic;
     PhytiumE2000QSPIState *qspi;
+    DeviceState *ahci[PHYTIUM_E2000_NUM_AHCIS];
     PhytiumE2000PBRState *pbr;
     PhytiumE2000MciState *mci[PHYTIUM_E2000_NUM_MCIS];
     CadenceGEMState *gem[PHYTIUM_E2000_NUM_GEMS];
@@ -107,5 +113,8 @@ void phytium_e2000_soc_attach_sd_card(PhytiumE2000SoCState *s,
                                       BlockBackend *blk);
 void phytium_e2000_soc_attach_qspi_flash(PhytiumE2000SoCState *s,
                                          DeviceState *flash);
+void phytium_e2000_soc_attach_sata(PhytiumE2000SoCState *s,
+                                   unsigned int index,
+                                   DriveInfo **drives);
 
 #endif
diff --git a/hw/arm/phytium_e2000.c b/hw/arm/phytium_e2000.c
index 4ded28814e..bc3491ca27 100644
--- a/hw/arm/phytium_e2000.c
+++ b/hw/arm/phytium_e2000.c
@@ -19,6 +19,8 @@
 #include "hw/arm/phytium_e2000.h"
 #include "hw/char/pl011.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/ide/ahci-sysbus.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/i2c/designware_i2c.h"
@@ -85,10 +87,12 @@ const MemMapEntry phytium_e2000_memmap[] = {
     [PHYTIUM_E2000_BOARD_CTRL] =     { 0x31800000, 0x01400000 },
     [PHYTIUM_E2000_XHCI0] =          { 0x31a08000, 0x00018000 },
     [PHYTIUM_E2000_XHCI1] =          { 0x31a28000, 0x00018000 },
+    [PHYTIUM_E2000_AHCI0] =          { 0x31a40000, 0x00001000 },
     [PHYTIUM_E2000_GEM0] =           { 0x3200c000, 0x00002000 },
     [PHYTIUM_E2000_GEM1] =           { 0x3200e000, 0x00002000 },
     [PHYTIUM_E2000_GEM2] =           { 0x32010000, 0x00002000 },
     [PHYTIUM_E2000_GEM3] =           { 0x32012000, 0x00002000 },
+    [PHYTIUM_E2000_AHCI1] =          { 0x32014000, 0x00001000 },
     [PHYTIUM_E2000_RNG_REGS] =       { 0x32a36000, 0x00001000 },
     [PHYTIUM_E2000_PLATFORM_CTRL] =  { 0x32e40000, 0x00010000 },
     [PHYTIUM_E2000_SECURITY_CTRL] =  { 0x32f00000, 0x00001000 },
@@ -124,6 +128,11 @@ static const int phytium_e2000_xhci_irqmap[] = {
     [1] = 17,
 };
 
+static const int phytium_e2000_ahci_irqmap[] = {
+    [0] = 42,
+    [1] = 43,
+};
+
 static const uint8_t phytium_e2000_gem_num_queues[] = { 8, 4, 4, 4 };
 
 static const int
@@ -409,6 +418,22 @@ static void phytium_e2000_create_gem(PhytiumE2000SoCState *s, int index)
     }
 }
 
+static void phytium_e2000_create_ahci(PhytiumE2000SoCState *s, int index)
+{
+    int map_idx = index ? PHYTIUM_E2000_AHCI1 : PHYTIUM_E2000_AHCI0;
+    DeviceState *dev = qdev_new(TYPE_SYSBUS_AHCI);
+    g_autofree char *name = g_strdup_printf("ahci%d", index);
+
+    s->ahci[index] = dev;
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
+    qdev_prop_set_uint32(dev, "num-ports", PHYTIUM_E2000_NUM_SATA_PORTS);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
+        phytium_e2000_memmap[map_idx].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+        qdev_get_gpio_in(s->gic, phytium_e2000_ahci_irqmap[index]));
+}
+
 static void phytium_e2000_create_xhci(PhytiumE2000SoCState *s, int index)
 {
     int map_idx = PHYTIUM_E2000_XHCI0 + index;
@@ -815,6 +840,17 @@ void phytium_e2000_soc_attach_qspi_flash(PhytiumE2000SoCState *s,
     qdev_connect_gpio_out_named(DEVICE(s->qspi), "cs", 0, flash_cs);
 }
 
+void phytium_e2000_soc_attach_sata(PhytiumE2000SoCState *s,
+                                   unsigned int index,
+                                   DriveInfo **drives)
+{
+    SysbusAHCIState *sysahci;
+
+    g_assert(index < ARRAY_SIZE(s->ahci));
+    sysahci = SYSBUS_AHCI(s->ahci[index]);
+    ahci_ide_create_devs(&sysahci->ahci, drives);
+}
+
 static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
 {
     PhytiumE2000SoCState *s = PHYTIUM_E2000_SOC(dev);
@@ -851,6 +887,9 @@ static void phytium_e2000_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PHYTIUM_E2000_NUM_XHCIS; i++) {
         phytium_e2000_create_xhci(s, i);
     }
+    for (i = 0; i < PHYTIUM_E2000_NUM_AHCIS; i++) {
+        phytium_e2000_create_ahci(s, i);
+    }
     for (i = 0; i < PHYTIUM_E2000_NUM_GEMS; i++) {
         phytium_e2000_create_gem(s, i);
     }
diff --git a/hw/arm/phytium_e2000_machine.c b/hw/arm/phytium_e2000_machine.c
index 5ca2922e91..9c41403ba9 100644
--- a/hw/arm/phytium_e2000_machine.c
+++ b/hw/arm/phytium_e2000_machine.c
@@ -23,6 +23,7 @@
 #include "hw/arm/phytium_e2000.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/ide/ide-bus.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 
@@ -50,6 +51,7 @@ struct PhytiumE2000MachineClass {
     const char *direct_boot_dtb;
     const char *pbr_boot_mode;
     const char *qspi_flash_model;
+    bool has_sata_boot;
 };
 
 static BlockBackend *phytium_e2000_drive_blk(BlockInterfaceType type,
@@ -84,6 +86,19 @@ static void phytium_e2000_attach_qspi_flash(
     phytium_e2000_soc_attach_qspi_flash(&s->soc, flash);
 }
 
+static void phytium_e2000_attach_sata(PhytiumE2000MachineState *s)
+{
+    DriveInfo *hd[PHYTIUM_E2000_NUM_SATA_PORTS] = {};
+
+    /*
+     * The COMe boot disk is wired to the second fixed AHCI controller. U-Boot
+     * probes both controllers and exposes the only attached disk as scsi 0.
+     */
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    phytium_e2000_soc_attach_sata(&s->soc,
+                                  PHYTIUM_E2000_SATA_BOOT_AHCI, hd);
+}
+
 static void phytium_e2000_reject_legacy_firmware(
     MachineState *ms, PhytiumE2000MachineClass *pemc)
 {
@@ -217,6 +232,12 @@ static void phytium_e2000_init(MachineState *ms)
         exit(1);
     }
 
+    if (!pemc->has_sata_boot && drive_get_by_index(IF_IDE, 0)) {
+        error_report("%s does not expose a SATA boot disk; "
+                     "use if=sd,index=0", pemc->machine_name);
+        exit(1);
+    }
+
     phytium_e2000_reject_legacy_firmware(ms, pemc);
     phytium_e2000_create_ram(s);
     if (!ms->kernel_filename &&
@@ -239,6 +260,9 @@ static void phytium_e2000_init(MachineState *ms)
     if (pemc->qspi_flash_model) {
         phytium_e2000_attach_qspi_flash(s, pemc->qspi_flash_model);
     }
+    if (pemc->has_sata_boot) {
+        phytium_e2000_attach_sata(s);
+    }
 
     firmware_loaded = phytium_e2000_soc_firmware_loaded(&s->soc);
     s->bootinfo.ram_size = ms->ram_size;
@@ -315,6 +339,7 @@ static void phytium_pi_class_init(ObjectClass *oc, const void *data)
     pemc->machine_name = "phytium-pi";
     pemc->direct_boot_dtb = "phytiumpi_firefly.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_SD0;
+    pemc->has_sata_boot = false;
 }
 
 static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
@@ -324,10 +349,12 @@ static void phytium_e2000_come_class_init(ObjectClass *oc, const void *data)
         PHYTIUM_E2000_MACHINE_CLASS(oc);
 
     mc->desc = "Phytium E2000Q COMe Development Board";
+    mc->block_default_type = IF_IDE;
     pemc->machine_name = "phytium-e2000-come";
     pemc->direct_boot_dtb = "e2000q-come-board.dtb";
     pemc->pbr_boot_mode = PHYTIUM_E2000_PBR_BOOT_MODE_QSPI;
     pemc->qspi_flash_model = "gd25q128";
+    pemc->has_sata_boot = true;
 }
 
 static const TypeInfo phytium_e2000_base_info = {
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 988e8e0327..9b6a1f1d5b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -131,10 +131,13 @@ config PHYTIUM_E2000
     default y
     depends on TCG && AARCH64
     imply PCI_DEVICES
+    select AHCI_SYSBUS
     select ARM_GIC
     select CADENCE
     select DESIGNWARE_I2C
     select DW_MCI
+    select IDE_BUS
+    select IDE_DEV
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PHYTIUM_E2000_QSPI
-- 
2.53.0


