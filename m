Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAE6C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJw-0005Se-6S; Fri, 04 Sep 2026 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJp-0005DQ-9S; Fri, 04 Sep 2026 11:59:11 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJn-0004Wv-1V; Fri, 04 Sep 2026 11:59:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdyDQ51xiuaie15gKUL5ykBllf1MRq2EzOCj5X2s2QCmiKnnH2w90mSmIH7MVmgnVYPlkGJe+VvHlgHuEcT+27r0QJyjh7WMU/2pdflWAuFketASRb0Pl9V4Ynz6mgB8cmKImWPOpATVcraDp8gmUqTioGJ5Vw4QpCfLCKmhsPssxYKJvbyPvcpKubBwH5ptUelDbXXoJ66Dqf61fCF0nlCDHyQIUW9i7u9qDtq0e+FIlQYB2ClL0qsLoG0w8FXGc0wD+7ZmDF1hh1U0qsT9CRQ2jxwBCePIdLSYCPJbjYMULri7Y30Ny8MOaCsmfA09DZ/PmCl1JjmE2I4aOtuKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp0VDAfnEZTVdGdMl+NM76Z2lanDroe1nrOqFOcANCI=;
 b=ih1OLx8Ddu4oqGB6l7QmpwI7LxZzaPQk5kkXAy+Azbe4W4HrpQe4ygS3QF2wdPi+USt7eYc/gMrfngM7VMq+KiRkWuzcRF5H7uiVxyjzDGY+7RU9GwbxWI5Py5zbcZloJFurwCLN0oDksIX1FTxYFoGSSWnhwmFOQePRzvuFHVoEotSDPgwYWqtzM9Ezm13OpdY0e02uUx3jJV9HDeKukws7AjtWYUX7pXbNuldr6xloOc2rMi0iUlYU5slXVTgXp0cDLwODfY7B8R3lSrZzL4HwV9n+V4F2aKQ6p6EmnWRxDKZi87Os2jeV5WC7tYMnyOU5CETJs6RKkngWqpr1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp0VDAfnEZTVdGdMl+NM76Z2lanDroe1nrOqFOcANCI=;
 b=QgLCrQdaP23igkIzsjFW+bG9FdUnoo51x2oPyW4mdnZ3If7K+POvLKk8wzKVjinvhLG9QplTlwOHQyrH5bLNuG5Yr97OmAuljzHW/U075HZ7Vsn8qL8ZXXJ2T4ZRcmkEYKLWzgmzaM7FNa+MMXG5jyTR+c2woUOkSKELjXu2w651oQaPj4dyMGKnpB25XUhAxcWaJMM/L8yTP6X2ZV3kReFqYFExCg2Kx6gwWWOs0p9RzHm/2kI+p08efco4u6+oity/yFbQW1TGBJiZcg/hhH6zoBJD3StNSyA/jQYrqQ/XZg3BQMx0UctZy+a9XAzRBil6ed6eWQExhhB40w4zXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYSPR02MB7490.apcprd02.prod.outlook.com (2603:1096:405:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:59 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:59 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 16/24] hw/misc: pfsoc: Honor PolarFire service notification
 requests
Date: Fri,  4 Sep 2026 23:57:35 +0800
Message-ID: <20260904155758.3833179-17-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYSPR02MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: fbea58e0-7f1c-4f78-4bcc-08df0a9d6ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: eO5p1mr4YDoBDL5q/D20Ja0Dwl12ZX8mQnHEQMmghaQGr8FjKOhU9uvRoeFRJWzlz6KgAU5k/SUCSZ5wMs5NTt7OOWU+e/9RyboXSKo+WzKopGDgNWchHoJRV62uXLfJ3h+STpGe1bNhw5juaDZ+m3QD2dah06cnoVyfXNdhzWXuM9BvxYPtiloHdMbyqAzL4fpxNILGNbnNgRdIul4P6FoRhSOtSZnTRXwiHCsFaj7v9oWD/bAjNABpaQSc+cHkWfMRxjUD07AKFBor+GW4zO5biKe6xvL06sKnY1hoIqAZoLaz8MKDb+lt0DUOiQ1giTFISWAsokHD2dDhUqljvU4rXrsKUP2z5iZ/OSXW4natq8zdHeLTIBOJbDqu4DB+KqEOdfDC29XEXUDTSfa9yZzVhYfGqeG/akQ68x88KdCO05bJ5K6z80ev3Bz7IT3OUn092EL2s+56xqNnuNQZjO0PjiCNCMGZ8ja4sOEm/SXzBDVfGcv4VGiGkVWsHRMx+Rferx1idWJ9Env1HqDKC/HAylm9X4ZtDPfsECBS10Q7isMR2qTLn6mOK6XW8OvzT7VodzbFqh+tulgymS1y/8cyoK3ZUtLzsOFB6kGI6serXG8gxeljAKzbQ0MYQE9I4VVKBynz8KEinmskwaJ5GK/iUB6r/guOgcl9YVcPjZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/hV7M8gUl7X8GmRcuAVBDISCyak5mSuO+PsyAs7v2MH7tmAEdNjcA+mrgED?=
 =?us-ascii?Q?8aERrQIHBhnpBgvDp5y5mJryM+59lHa5YaqwXeVuzJ86onnfAU1FdHy07xSy?=
 =?us-ascii?Q?lHsrg+OrrrIGRqQV6uAnFCe2mF/tBxyQm7aV5K1FEUBre+6ENYtaZfwnDL1j?=
 =?us-ascii?Q?lAudS2Z3MRittP+awaA3lB780pRk4yYpmPP8idpkwdkIAsw26LjuNnbSKohD?=
 =?us-ascii?Q?0xhO4RmvFpOqyimWRPDB7Z78duJTD3jQlQIYJ5EeBIgbQwENJd2BwWyB+Qb9?=
 =?us-ascii?Q?KJeAV5IWbBKwLeng1Zr7TY3H9sORpLnJJ8Vgq952JUAu4CREdip1467MtkcA?=
 =?us-ascii?Q?CjDssEfGWSu08l3k/ZksCjIngQigZyzO50plPbsdf2imd/ZHdEEnVIKcvXUR?=
 =?us-ascii?Q?cKiV89/ZXTxLJcpw4qgVh4zrDgxHcb2UygwCYS0m2lDbUrbTryRxMK4KcDbS?=
 =?us-ascii?Q?rOPNvmtB+QIe687U4lwVh1gBs/yT4swzZzA4f44OQPH8MncFfEcF90WmA4A7?=
 =?us-ascii?Q?UPom4Un2jrKaLqAUVbXZd17G13O1+DecKhgZhknbEWNFmi4FTC3mzbEoxqMk?=
 =?us-ascii?Q?+j92cDysBGxFECCoBmQfQcwZI9jueNLFqyFas6fRA1u0xKoRN9KTLJn5fDPY?=
 =?us-ascii?Q?Y7b6IOfLwfHM+Zigwm1pYtu1A5P28uY4NqPEtMorMkxAQ9RcDLBhCVStBafQ?=
 =?us-ascii?Q?oyFsSNjVe8tdnKCdtD4YQUgA56GRrzX4tN+TJQu5ouMa/jXh1+zl8yrgZhYC?=
 =?us-ascii?Q?cRXZyN5viO0BV5ZltIDXlo1qOUyIjKHMoorxSDXqZTJGis1GRzO+EdO+aIMR?=
 =?us-ascii?Q?Y12w+Aq4gXP7WEm3j2SdOgDQQO8b3D2LfoCW4F4Jx56K6yjMXG0vqYNcQUC2?=
 =?us-ascii?Q?W/bvwUoajSjn94GuQZ4ke4YfIGSFVusV57quvg4P5WHK5KBbVoiFrmmkFR3p?=
 =?us-ascii?Q?E7EhzjTkzqFkegVs0NcaX7fq1MPb98jrsY+ClOsaq/DqFztL4qP3Ogl4QU1q?=
 =?us-ascii?Q?MPXsZKsPwtiOkWbenb3WF3WFIA01RclVPJEWxJO97LSJcPfuYruRyEVbGiXX?=
 =?us-ascii?Q?az+oNyObSbo3aY5OadaEGo0FAxRlF6lqIgWRdZaEh90CnWGmeRmABpV/Nmum?=
 =?us-ascii?Q?bSZ25Jrc9dNAIUb2URJktLitRhwUVuCmKpVewVHqR7ALjUZsTSsqldYv/nah?=
 =?us-ascii?Q?Qw5Jh8MD1IgC6hAf7OTBxhLjH7FMuzKNTf/0qLFaToNKXrzg9f+FvT6tP2gA?=
 =?us-ascii?Q?behuWz5JNoDObSKef9h8ImYGbMo8Fwjr1gH+C34DEcZiWUTv5g+nnI8UU8ka?=
 =?us-ascii?Q?BNH8Bo4GtSkMMZBOd928rDtAIP9AU+wua5OOvkhAcdgpbXLRlXmMrSN7PQQS?=
 =?us-ascii?Q?4jfD/etltco6WopCWUggYjtU+/BYZ0YCjddIUIHwTXrJ/+F2TRbQzbrqu511?=
 =?us-ascii?Q?t733p5avyZUQN1HTaxx/zVaJnM6/I6EfjUFXYzqjWFjvcXE8QBEhkwAtD45b?=
 =?us-ascii?Q?nn6nqYyvcDVii7nkDrVnFJ5vAPa7/Y5cewB+t+Typp1Q0KRckE4YkSYWAJmJ?=
 =?us-ascii?Q?tKInB1AtL1VT17Luy5Grhe9j/+PCPQYeLEHqnrSeTqFzGpxM3inpdbSwMo4N?=
 =?us-ascii?Q?jkOILBj6yyQusyY7sggdSYLokV4+HHqwYmuyau1os0mll65Dr/hflWrecfa7?=
 =?us-ascii?Q?kDDG3OKUTygMu2BVzU2i5GMz8jA0EnAjsMgcqw6fa9gi1VlyTLA2r8WFHDGS?=
 =?us-ascii?Q?fYfFYjpVaFb+wR+6sz+ehscYbgAJweM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbea58e0-7f1c-4f78-4bcc-08df0a9d6ecb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:59.6307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBTvICNQoCQcpKKBgjwPsvrwoUxBW+BMBlv4LWI48VK68gENTN1cp4SMZD0PtxAL8B97vKmZsaDDXoDltq8pLSIF/5lLn3VOyo9JpVnZskc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7490
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

Polling firmware requests system services without requesting an
interrupt. The old model ignored this distinction:

1. HSS requests the serial number with REQUEST set and NOTIFY clear.
2. QEMU synchronously fills the mailbox and clears REQUEST.
3. QEMU incorrectly asserts PLIC source 96.
4. HSS polls REQUEST and neither waits for nor handles the interrupt.
5. PLIC source 96 remains pending.
6. Linux registers the MPFS mailbox driver.
7. The stale interrupt immediately enters mpfs_mbox_inbox_isr().
8. Linux has not submitted a request or installed its response pointer.
9. The ISR dereferences that null pointer and faults near address 0x10.

Honor SERVICES_CR.NOTIFY, let IOSCB own the pending interrupt state,
and route the SYSREG acknowledgement through an IOSCB clear input.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---

(no changes since v1)

 include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
 hw/misc/mchp_pfsoc_ioscb.c         | 39 +++++++++++++++++++++++++++---
 hw/misc/mchp_pfsoc_sysreg.c        |  9 ++++++-
 hw/riscv/microchip_pfsoc.c         |  6 ++---
 4 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index fd31427304..e39d995b64 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -26,6 +26,7 @@
 #include "hw/core/sysbus.h"
 
 #define MCHP_PFSOC_IOSCB_MAILBOX_SIZE 0x1000
+#define MCHP_PFSOC_IOSCB_IRQ_CLEAR "irq-clear"
 
 typedef struct MchpPfSoCIoscbState {
     SysBusDevice parent;
@@ -53,6 +54,7 @@ typedef struct MchpPfSoCIoscbState {
     uint32_t services_sr;
     uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
     char *serial_number;
+    bool irq_pending;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 7c82b55986..ccc2201b7a 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -192,12 +192,13 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
 
 #define SERVICES_CR                         0x50
 #define SERVICES_CR_REQUEST                 BIT(0)
+#define SERVICES_CR_NOTIFY                  BIT(3)
 #define SERVICES_CR_COMMAND_SHIFT           16
 #define SERVICES_CR_COMMAND_WIDTH           8
 #define SERVICES_CR_COMMAND_MASK            \
         MAKE_64BIT_MASK(SERVICES_CR_COMMAND_SHIFT, SERVICES_CR_COMMAND_WIDTH)
 #define SERVICES_CR_MASK                    \
-        (SERVICES_CR_REQUEST | SERVICES_CR_COMMAND_MASK)
+        (SERVICES_CR_REQUEST | SERVICES_CR_NOTIFY | SERVICES_CR_COMMAND_MASK)
 #define SERVICES_SR                         0x54
 #define SERVICES_SR_STATUS_SHIFT            16
 #define SERVICES_COMMAND_SERIAL_NUMBER      0
@@ -205,6 +206,21 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
 #define SERVICES_STATUS_FAILED              1
 #define SERVICES_MAILBOX_RESPONSE_OFFSET    0
 
+static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
+{
+    qemu_set_irq(s->irq, s->irq_pending);
+}
+
+static void mchp_pfsoc_ioscb_clear_irq(void *opaque, int n, int level)
+{
+    MchpPfSoCIoscbState *s = opaque;
+
+    if (level) {
+        s->irq_pending = false;
+        mchp_pfsoc_ioscb_update_irq(s);
+    }
+}
+
 static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
 {
     uint32_t command;
@@ -236,7 +252,15 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
     }
 
     s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
-    qemu_irq_raise(s->irq);
+    /*
+     * HSS and U-Boot submit polling requests with REQUEST set and NOTIFY
+     * clear, then poll REQUEST/BUSY for completion. Linux sets both bits
+     * and expects completion through PLIC source 96.
+     */
+    if (value & SERVICES_CR_NOTIFY) {
+        s->irq_pending = true;
+        mchp_pfsoc_ioscb_update_irq(s);
+    }
 }
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
@@ -325,7 +349,8 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
     s->services_cr = 0;
     s->services_sr = 0;
     memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
-    qemu_irq_lower(s->irq);
+    s->irq_pending = false;
+    mchp_pfsoc_ioscb_update_irq(s);
 }
 
 static const Property mchp_pfsoc_ioscb_properties[] = {
@@ -333,6 +358,13 @@ static const Property mchp_pfsoc_ioscb_properties[] = {
                        MchpPfSoCIoscbState, serial_number),
 };
 
+static void mchp_pfsoc_ioscb_init(Object *obj)
+{
+    /* Accept service interrupt acknowledgements from SYSREG MESSAGE_INT */
+    qdev_init_gpio_in_named(DEVICE(obj), mchp_pfsoc_ioscb_clear_irq,
+                            MCHP_PFSOC_IOSCB_IRQ_CLEAR, 1);
+}
+
 static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
@@ -456,6 +488,7 @@ static const TypeInfo mchp_pfsoc_ioscb_info = {
     .name          = TYPE_MCHP_PFSOC_IOSCB,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MchpPfSoCIoscbState),
+    .instance_init = mchp_pfsoc_ioscb_init,
     .class_init    = mchp_pfsoc_ioscb_class_init,
 };
 
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 1d9154280a..899b485da6 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -77,7 +77,14 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
         }
         break;
     case MESSAGE_INT:
-        qemu_irq_lower(s->irq);
+        /*
+         * A MESSAGE_INT write is an acknowledgement event, not a level that
+         * remains asserted. Model it as an active-high pulse. The rising edge
+         * invokes IOSCB's irq-clear input with level 1, which clears
+         * irq_pending and lowers PLIC source 96. The falling edge invokes the
+         * input with level 0 and is ignored.
+         */
+        qemu_irq_pulse(s->irq);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index fb0e18edba..87c9c89cb0 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -336,9 +336,6 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
                     memmap[MICROCHIP_PFSOC_SYSREG].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
-                       qdev_get_gpio_in(DEVICE(s->plic),
-                       MICROCHIP_PFSOC_MAILBOX_IRQ));
 
     /* AXISW */
     create_unimplemented_device("microchip.pfsoc.axisw",
@@ -492,6 +489,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioscb), 0,
                        qdev_get_gpio_in(DEVICE(s->plic),
                        MICROCHIP_PFSOC_MAILBOX_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ioscb),
+                               MCHP_PFSOC_IOSCB_IRQ_CLEAR, 0));
 
     /* FPGA Fabric */
     create_unimplemented_device("microchip.pfsoc.fabricfic3",
-- 
2.53.0


