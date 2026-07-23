Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9532C531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDK-0004Jn-MS; Thu, 23 Jul 2026 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD9-0004Bp-01; Thu, 23 Jul 2026 11:19:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD6-0007zZ-Vm; Thu, 23 Jul 2026 11:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZkeKG4OD/sxA5bQ0Gl7tI95TLRB3MQHbubHS6Ecu1wAzV5gYzrRca4m1SbW6fEpb1qKWu+SM3dUaV+/Q0LUWvhy56uKUKaEzqdqaVvtLlHEie32j8+hit0c6FuP4S8A0/R0ahYtWnUmYuefzR8WNhoRhBbhr5MmIzGiKvZ0yasT+zP0C42QudyL6PVG+x+T8jRlzGeCEZQO66PuHWWgRGy69rTX+F2C2XJHKZVm3moisa8mbLXuSjJt9mwhKQbiyAFoJQ74v2VrVs0rRXeYlnXBPxZOaIocZVRKtPSk/lmCEwh9RSFX3KKFYWVF262WEn8vyR574Rw83mrtp07VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOQk9owve0RKpEylsUPAGqj7ECNhYVQuQpfGZS+L/Ic=;
 b=hkRQbDo25cclvhxbWY+RavUWCLpjOmzMY4b+Qw4Mq9VQV6s+n8A02dqE5VIBdMG0ygKiuytLEJRfdy3U8ybVm+jMYqBGjdUEMOdt+dToehYF45TEyu5nZB4LCgotgdIPrZ7DTEjcsWR0XkH6d0DjSZUBGd/cADtoILpUnGSAAphQzWQpjLfu1Ya+E0cPR1tvqFYddNoVfDc0ZiebnKFQHQ9lI377USNvLzvVaT2f/+z1fnpsygzlLolCcyCchFR31E7WRmULcc/HdkCE/OZZfVpiRITUJypXgBiFao0m/JbsgBV/NKBnl7N6CUIJxjXKgDui1JLMW7f1JLMxVVlhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOQk9owve0RKpEylsUPAGqj7ECNhYVQuQpfGZS+L/Ic=;
 b=NgnwZxsv1/qME4pFYWakCeywjPX8+taVwO/KRjhLKft2TviBxzuYusafuhVM3nvYWamSFxkyJT+WbeDR28vPHU07mqDFAc4QoHqffYxarBlbXVmE8dBaEnUX4dy4qYg0Vtw1BrmxqmyYyRGoquf5wlhYEVLvax2XWeNBSy7eSk4iy/zabA2LOcCGKOTBaUcVjdcAyJkUlAhkGDRU9orT0RX7ltQJ5NUGc2sW2pIzC6Bdz9ZXe6JblQrLsqsRHZn/7t7/fzwilIzfKG6pBzHHnq3gIFegi+bHOodifwdgka38ZaU2n5H8ZlD/Z8VGGjeZjHGYY9ZOQlOPIyne903FWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 12/26] hw/sd: sdhci: Run ADMA independently of MMIO
Date: Thu, 23 Jul 2026 23:18:39 +0800
Message-Id: <20260723151853.2143177-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 187479f3-ace2-4901-3aa3-08dee8cdca3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: gq8SBT2E+qOeI+AfgTj1v17R32lutj/PuU48+N3nu/LROp5ISw6bHX6OqPkHjwrh315uKbp5CABdlue2D4swJvOZ5rym3AMycKucUlePriV7YH93F1ecB0fIBLzBNAuK1n2/cmhZ2u676qmB5Gn4/xmLLNfSu0jwYeyEWjKj1/NhXEzkNPOh744864GP7ogzcju1xM8WcysfcVWzsRz+v90VsKMEx/HcdDp7a2R/9fEQ8uk01/xMdGlxo0viYPpE59nqyHLsWpdV5LmTiQPDqesjziWAcSmbWdbWJuwH+vMZFnxMhDT7xSLv3lma518UutAdRQYBY1Thw4ZBPuBMCs1LGJQNT9MY8wz8KNvTyCOVRDOFgBG7hDuGKA3Q66Jpg6Xi9BEM3KgEfRYfbpQCBUs+zj4o9U2aZGAIv0ipt85VBw5YEekOZcZ805IlInZx7smfJdg4Ja8+clKGFAkmv7iv8NLCmpPGvOIdkOPIJQRkxBQiqGBYdkygonvi0OJ6RfOEY8XUAOMc0yW5dm//naSaQ7QBTXzuLarfsdSdoJfEVHZRPDkjevJC31M8NgRkJTiD2JKAFMyuwpVlVv5771EZkwX0cBtdtNRqRzFAW5KjoqOZkDPY9y2QqpVzkpTfyaHGby3gAhade8UKhJBgjY4xmmBMuz2XUI23W2pQivI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVzJxFEQp7PJkDrfDc+AMWE+WG8HQOVjqUucUms61HZ2WxaYaTx9Bsm/3VI0?=
 =?us-ascii?Q?PedI4E817U1JF2IPDy9EawWLdyznqflN/ynEflQHvxhRIoKvYkMtpz3myt2z?=
 =?us-ascii?Q?JWK00+lonENosGWqcVlnithk3Ksdh4OejJ+8cyeHYufMwXMWDwekOk//c6Yt?=
 =?us-ascii?Q?GTBkYpcvPCaEzlaUg4szzOdoxDbv5U2jx8xZf0S61HagFaLFcVilezGX2yFL?=
 =?us-ascii?Q?awU90qtZxKxtal5Ey0FmORIyzhnzWspDoNporgRJhPKVWeJ5afbpFYGXJt2l?=
 =?us-ascii?Q?fTZnKIilcFiP0zE9ue2ehrWQ8GVnT0EXCdCaru2baKATU5lN5ux9Omx/nd8R?=
 =?us-ascii?Q?Gt3JPAdPBsWwWnPsFhDIuuc315HwD8AO/kfbdIeBlaW4uRV6WCf7HTItHpsx?=
 =?us-ascii?Q?1PP3hhtR+nAJlIRVTdUtk0TXN/xDJrmwKOcKfF1mngUnkM+fLaUpA4QqRCJT?=
 =?us-ascii?Q?CK98ILcESQotXZqRjz1XnnHQ/CQdwbDebrC0HCC1umUpmlric2jZGp3HTePS?=
 =?us-ascii?Q?X95uvwTjcC8sslOyfKCbWpH77enMoXkOf0lDAUMAI5quKUPpHV3NxBdbZ1Rn?=
 =?us-ascii?Q?O9T0ZI4JS/67zSUnkjUmCDK/kcMtd5fioY+gLOp2Uq5gdJ7JtOlGIHWMRge6?=
 =?us-ascii?Q?Dl0q2MjmDkDij96Njn+575mc1YyhKKUGV3YtNmh2vxj5Gq+dH/2659hjUmfe?=
 =?us-ascii?Q?LFmK47/g5gWLVD7iDAwMSlix8xVa0xtAX/Z78JeSI6mcgA8ISPnPpR7LBEh7?=
 =?us-ascii?Q?DqoDFBP1kOveysTX0r8I8cHbdGG1hXmas7TxywdrhFmMFa7grM79RHEoVe2P?=
 =?us-ascii?Q?coN/U1x5DZx5QTt0DzSlgiEr0KRj39edG83OuT88KmKdSOfGJzBgLOqAjaBT?=
 =?us-ascii?Q?ayiE4pZVg3cc51GglliXKMwyz4qbBVHfIrmYNRm1KSfWTiUq9D9Ba3W30zzn?=
 =?us-ascii?Q?9mjGgQM0r1DGJEkp+FTKqY1k6Ebv7nevKhfz0sIhseWuNrczZ3G+EQu2CMq9?=
 =?us-ascii?Q?36/Q/iQYg2zl9B49pJIJcy0eIZtJ7c14eaBHOxt28sEQ1cE53zTmHKR8gLSX?=
 =?us-ascii?Q?2YPeAsYZyS/6RTUoPyy+pz3oBVO1ElFmRVVMto+2IhtZo0Mkrd/LU2SxOCZc?=
 =?us-ascii?Q?x9GXGXgEHI+vOekKxkkLgpSGU+CZBN8m9YLbhOkwIQG8VRwjpW7wXEtzxtfk?=
 =?us-ascii?Q?NS++oaqLzdq4WPA0s/Yj+N0BFeUOtojoYm287hVItknvFM1hhqL71+KgI/93?=
 =?us-ascii?Q?UfbDUMuWqQmzzWu1KAYGr869YMBK8gOKSnj3oDWHBiEmQkLpn/zMZGd4c5Tq?=
 =?us-ascii?Q?eYIrWo1cQyR9DcZUaWzBwRfHxuZpSY8ysyBjhCeUFHtamczrLweJ8cqpsj8B?=
 =?us-ascii?Q?1bxPfIa29Goh6nBNFio31ykMNaxMR2myG3qrBSHX2PJ96qw71qeYgArU/duS?=
 =?us-ascii?Q?jX0Vb3CplD1Bdd42lCmnoiAEnp6GIX10sotAgr3xQZ5CdMQkDoGcPETYl8JU?=
 =?us-ascii?Q?Br/WmAedjRWnb4Ui1sjGeWvG8jYNGRfCYAyUv7u3+Mn5UExX2wZlZjdy47m6?=
 =?us-ascii?Q?fYs8C9P3vAfllkgqiox9AY0UY24FMRUWdakkPVDqh4glcibkaQRHtxXAQeFb?=
 =?us-ascii?Q?feW0/TbAp+ggqbIHuiPrZ17606orzPBygZWnzhpWsAki/+zgDzAzCjvKvcib?=
 =?us-ascii?Q?PYeMKvDsT35L1MUV/xxBKLttCrb52gG+4dnxVyQAOpPLgI5nx/KUI+CszWO0?=
 =?us-ascii?Q?dcTuZnHZ1mucMNiH5L8x0xn5a1F0gnQ=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187479f3-ace2-4901-3aa3-08dee8cdca3b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:29.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfh3Ebr+Gz7JNJ7HAY65rbSB/FlCaDgJ8ZYVJ+84GPrLCuO3+yqkDnMTiQGm7718qfpOsWjKvSQAdH1EzRSsfwo6rsJSSLBqrwcpJFV+IM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
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

The SDHCI model processes the first ADMA descriptor batch inside the
command MMIO write, then resumes pending batches before every later
SDHCI MMIO read or write. This makes register access perform bulk DMA
work and can delay a status read even when completion bits are set.

On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
19 MiB FIT image from SD. It can report:

  Timeout for status update: 00000001 00000001
  Timeout for status update: 00000003 00000001

The status already contains the requested Command Complete bit, and may
also contain Transfer Complete. However, reading the interrupt status
first executes a pending ADMA batch. The MMIO read can therefore return
after U-Boot has reached its one-second polling deadline.

Turn the existing transfer timer into an ADMA-only engine. Starting an
ADMA command arms the engine directly, and each timer callback runs one
bounded batch before yielding. MMIO reads and writes no longer perform
or schedule ADMA work. Keep PIO and SDMA synchronous.

Cancel the engine and clear ADMA activity and error state on DATA or ALL
reset.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 140 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 54 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8d85e1551c..e716a0d89f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -277,6 +277,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool level)
             }
         } else {
             s->prnsts = 0x1fa0000;
+            timer_del(s->transfer_timer);
             s->pwrcon &= ~SDHC_POWER_ON;
             s->clkcon &= ~SDHC_CLOCK_SDCLK_EN;
             if (s->norintstsen & SDHC_NISEN_REMOVE) {
@@ -348,7 +349,34 @@ static void sdhci_poweron_reset(DeviceState *dev)
     }
 }
 
-static void sdhci_data_transfer(void *opaque);
+static void sdhci_data_transfer(SDHCIState *s);
+static void sdhci_adma_engine(void *opaque);
+
+static void sdhci_set_transfer_active(SDHCIState *s)
+{
+    s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
+    if (s->trnmod & SDHC_TRNS_READ) {
+        s->prnsts |= SDHC_DOING_READ;
+    } else {
+        s->prnsts |= SDHC_DOING_WRITE;
+    }
+}
+
+static void sdhci_schedule_adma(SDHCIState *s)
+{
+    timer_mod(s->transfer_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+}
+
+static bool sdhci_adma_transfer_active(SDHCIState *s)
+{
+    return TRANSFERRING_DATA(s->prnsts) &&
+           (s->trnmod & SDHC_TRNS_DMA) &&
+           (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
+           sdhci_get_dma_type(s) != SDHC_CTRL_SDMA &&
+           !(s->admaerr & SDHC_ADMAERR_STATE_MASK) &&
+           !(s->errintsts & SDHC_EIS_ADMAERR);
+}
 
 #define BLOCK_SIZE_MASK (4 * KiB - 1)
 
@@ -405,7 +433,13 @@ static void sdhci_send_command(SDHCIState *s)
     if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
         (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
         s->data_count = 0;
-        sdhci_data_transfer(s);
+        if ((s->trnmod & SDHC_TRNS_DMA) &&
+            sdhci_get_dma_type(s) != SDHC_CTRL_SDMA) {
+            sdhci_set_transfer_active(s);
+            sdhci_schedule_adma(s);
+        } else {
+            sdhci_data_transfer(s);
+        }
     }
 }
 
@@ -850,7 +884,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 /* Advanced DMA data transfer */
 
-static void sdhci_do_adma(SDHCIState *s)
+static void sdhci_adma_run_batch(SDHCIState *s)
 {
     unsigned int begin, length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
@@ -956,12 +990,15 @@ static void sdhci_do_adma(SDHCIState *s)
             }
             if (res != MEMTX_OK) {
                 s->data_count = 0;
+                s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
+                s->admaerr |= SDHC_ADMAERR_STATE_ST_TFR;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
                     trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
                     s->norintsts |= SDHC_NIS_ERR;
                 }
                 sdhci_update_irq(s);
+                return;
             } else {
                 s->admasysaddr += dscr.incr;
             }
@@ -1012,50 +1049,52 @@ static void sdhci_do_adma(SDHCIState *s)
     }
 
     /* we have unfinished business - reschedule to continue ADMA */
-    timer_mod(s->transfer_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+    sdhci_schedule_adma(s);
 }
 
-/* Perform data transfer according to controller configuration */
-
-static void sdhci_data_transfer(void *opaque)
+/* Run one independently scheduled, quota-bounded ADMA batch */
+static void sdhci_adma_engine(void *opaque)
 {
     SDHCIState *s = (SDHCIState *)opaque;
 
-    if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (sdhci_get_dma_type(s)) {
-        case SDHC_CTRL_SDMA:
-            sdhci_sdma_transfer(s);
-            break;
-        case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
-                trace_sdhci_error("ADMA1 not supported");
-                break;
-            }
+    if (!sdhci_adma_transfer_active(s)) {
+        return;
+    }
 
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
-                trace_sdhci_error("ADMA2 not supported");
-                break;
-            }
+    switch (sdhci_get_dma_type(s)) {
+    case SDHC_CTRL_ADMA1_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
+            trace_sdhci_error("ADMA1 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
+            trace_sdhci_error("ADMA2 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_64:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
+            !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
+            trace_sdhci_error("64 bit ADMA not supported");
+            return;
+        }
+        break;
+    default:
+        trace_sdhci_error("Unsupported ADMA type");
+        return;
+    }
 
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_64:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
-                trace_sdhci_error("64 bit ADMA not supported");
-                break;
-            }
+    sdhci_adma_run_batch(s);
+}
 
-            sdhci_do_adma(s);
-            break;
-        default:
-            trace_sdhci_error("Unsupported DMA type");
-            break;
-        }
+/* Perform synchronous PIO or SDMA data transfer */
+static void sdhci_data_transfer(SDHCIState *s)
+{
+    if (s->trnmod & SDHC_TRNS_DMA) {
+        assert(sdhci_get_dma_type(s) == SDHC_CTRL_SDMA);
+        sdhci_sdma_transfer(s);
     } else {
         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus)) {
             s->prnsts |= SDHC_DOING_READ | SDHC_DATA_INHIBIT |
@@ -1098,21 +1137,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
     return true;
 }
 
-static void sdhci_resume_pending_transfer(SDHCIState *s)
-{
-    timer_del(s->transfer_timer);
-    sdhci_data_transfer(s);
-}
-
 static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = (SDHCIState *)opaque;
     uint32_t ret = 0;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         ret = s->sdmasysad;
@@ -1235,7 +1264,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->norintsts &= ~SDHC_NIS_CMDCMP;
         break;
     case SDHC_RESET_DATA:
+        timer_del(s->transfer_timer);
         s->data_count = 0;
+        s->admaerr = 0;
+        s->errintsts &= ~SDHC_EIS_ADMAERR;
         s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
                 SDHC_DOING_READ | SDHC_DOING_WRITE |
                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
@@ -1244,6 +1276,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->sdma_boundary_paused = false;
         s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
+        if (!s->errintsts) {
+            s->norintsts &= ~SDHC_NIS_ERR;
+        }
+        sdhci_update_irq(s);
         break;
     }
 }
@@ -1257,10 +1293,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         if (!TRANSFERRING_DATA(s->prnsts) ||
@@ -1521,7 +1553,7 @@ void sdhci_initfn(SDHCIState *s)
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                     sdhci_data_transfer, s);
+                                     sdhci_adma_engine, s);
 
     s->io_ops = &sdhci_mmio_ops;
 }
-- 
2.34.1


