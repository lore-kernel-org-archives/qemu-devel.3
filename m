Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EFDC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuE-00089P-JS; Tue, 11 Aug 2026 21:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuC-00087P-HM; Tue, 11 Aug 2026 21:37:20 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxuA-0001Yf-Mb; Tue, 11 Aug 2026 21:37:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0U6JrW1jOTvfoVCfeHyuiF0iiQLKgZkch3YNXj/F7veYnNoTk6Q40kGawtyk1Ba27iuSC7FSKiRrIsDAJN6obI5vRM1CZbeOcFJyb0byQ+CabmvNkBXplEdzqu2CzLzonhtzfKQI6Pyoop5kWnzF1jP6Pa+zYidu7E+TFIef/3rlLESnt1mnC68ovlkmljB5Cmz/0K/tDF4S0S/n20UuORoVCGt4oiijVR4ns/Bo6Qp2I+U5Aa7Pebw6izMssqMO+Nc+kf7AwgRFxtHg5zpfGOAUjsbaeqFVjI9gaQTCldJdQsdGTgnlWduw6go9BScUm3k2rJVqEj1tCUBbD9AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmjambCZASxnAMnWHw3XeeRwybVl+3otoon3NUpuyxg=;
 b=CVyn+VhXWf2yxUo3By4/j2qe1gua9Rdj/xQPjY8R3Li1fbL57ttXf1KkT5jAI3g3KcxvH07tBJ82Lm0x9b7xpZ+RJZ/Dybs6XNGYMYFGcfq07ARHZqvJDPi0B2+sU07YchBYGqqT6W13RzzxJxEdRiEaiJwOEVTYxD5Ch5La3LBzOTs8m4pliqdoV0VbbjXkajbcWp5CcExqjOETeMS2mXpJKxg7hPs0Xqh3UP+PWgqcBhedpSizKel9OAv8XZOXhgvjujqbkRphYoyQxN2rJT4ksS6bHYAA/Xs8bMwa1B1DF+YUJbABOOGgBN+EdIzziE/IM7ihZpn9RpVWQ99+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmjambCZASxnAMnWHw3XeeRwybVl+3otoon3NUpuyxg=;
 b=Kq0FkZF6PZ2va7mxwJs1HSK7l140Wg4nFhr/5J6qmYOX4TJZPQli0ztm3GAb6mpAcTBro6s/wNJOOkXklsWrWieS3vu0gXg0lOT4wP387Qwpe7q2mmZdgc+yo0i2tJPs/3KU7Yl+w7uzuBOrinYew29T6CmA7rNXmydrFAU4X7bGUlfEV9YCsJhAq/Qx9HR1xGXh+OJ3WgMSpXJZMDGEWcxujH8LgtHzToJfN71qwmJTQhBQdSn/z1sNWSYLr0YIilxQ1fx9mw9wVktwLjbln+6oXR4/CVRbzPE0InBPariAl0sHbhh+4IHXxXwyT6CH5oPtdKk4pX2EcmkDPJ4gdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:13 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:13 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 08/10] hw/sd: sdhci: Skip SDMA boundary stops for i.MX uSDHC
Date: Wed, 12 Aug 2026 09:36:11 +0800
Message-ID: <20260812013619.2134092-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0af511b5-716f-4c4c-596f-08def8123c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: GGYS0/TFPAM/U5WbZQHVapSFESFeeGBa6AU4EyGrOUV9irmw9svqXgfqQ370E85UZeBrbKHwKbHPxqrO92wCkqCBvV2gEmWattvwkSgh7b/Mzx0SEKPVLKw+s59iKJwNoyeDl3D6SGmmyLEgSNje1CpmJUdYs6JtrgMgEJx2yOb4f/9gqAq+zZ9g+hJN8OLtoW9QDCbAG1q5yPluYvUX63p/J8A3KPetqU6DpeejiDYTWkyhLz9yYuOU4Ay7sMA1UzQVAxhS5YsGS5XpJUY5HIGMAKqDB5ZZIgdPAUKhhzTMuYvRGbJqtbeZtrrpNtEGYZTq9Fx8hHh2oWhNg0ZGZFxk2VNtm067hFMXR2ey5KqMLY+PUOiMJ6OPB0Y0DKdjnp75qDjx3P/uA2L1ACgk8vxwIjFioLaz5aZxujTLrqGgeqhBk7ThGwzYYhgxtw8606TpdYolCvl08GNXyExPeDQvQojelxKg9jtqj5YEEHiSmuxRf5KUY/OG8RMN04rzBme/J6P7ePw198Se+9FMmxkoYCWL/cND7j21W7L6PggsfMSNRSSCZ+ls9CRGjjt2bZswob+yWT+YtWVzeIPbtMXhW2qmAcIkPIAuIBc6c8uQSM0RXprzcNi1fejVURKVfKMgrJj+HiP18K7hfmaJ4KLMBr5m5zfGlaUXbOxQzPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CTf3Bi3JzK1qLKX5yzMYmW5Tw4KpkCLhgV0Y4qfGlMmZHXrT5c5zErLpfAs?=
 =?us-ascii?Q?l4fpqAT6XBtjAoZlrkE3oOK8DqajntYxZ85VxTIu/OuIp3Ilf/oz7IWj3Wuu?=
 =?us-ascii?Q?2nevas6NOafJRPDU7eWdjZ1EdfGavp/DpkhbS9O/J6I34K+8k0Wgd8dj/ygx?=
 =?us-ascii?Q?Gb7Lux4gE6SqnERur8jjapobts7deuB5dF87IPwB7z9v5Anv44L0+5SQ17AP?=
 =?us-ascii?Q?5poPaqkAofpmPOXBDTiKbYqp3G2hZByP0Qlt8adS+ezGRG1UKIU5tHMf8Jx8?=
 =?us-ascii?Q?kEu4RJGNJz+8ygzviiWYBpav68Du4RQaotYXfEv3QUS902Qvtkc37ZBa+ine?=
 =?us-ascii?Q?PDB2l/2GjIiVh7C6XBxl/yeoD42LaSI2IjlveazjQhpQjHxHjc7A6OSPX1gb?=
 =?us-ascii?Q?fowYliIatCYApGQjiLnkfW1KUoQJ0ENf2CyOv+QOZn/1mL9R+fQ+LH35Czr2?=
 =?us-ascii?Q?27yBibG9aKFYV66DZde5fthlc4HJNpNtD/DliONk0MFm7b61ZbxhLQ0OPjSB?=
 =?us-ascii?Q?2iGEkNwqKGf9L+EbB8VIvLLrTHE8yIJTJ3ZscgQk5pyig1XlgwpMTmDMDbeW?=
 =?us-ascii?Q?WQ1DbjZT+31WSoRyg2UJWdBjzWcWXh/O5LckV5G0NbRerG2GGzzKHDa2hBap?=
 =?us-ascii?Q?tiwYFswgxE34C1ZFokHInK1U5il/QPDk7sixMGHPfvtbV86e/naujFRjRRI8?=
 =?us-ascii?Q?plO5f06axULb1rDWg2X9E6RvlNI2kk6aRIbkWrwyh7nirBp6QPFOWVmvABTR?=
 =?us-ascii?Q?7ysdUFBLUqkbceJ9TW2I0ZlXs0+hnQP5LEcuue/vIBDxv25K4YA4mXTafozg?=
 =?us-ascii?Q?q+9YqABkxQiDTecX2TUBa80X77HDh5NdQueIlSW6oSFrImfmF0ur9NwNKKcj?=
 =?us-ascii?Q?eZQvvanKf2PKIJ05pDbof+/dBeKmeMsfAgs8CriIOc5rrqneCCgvY/qMEkdW?=
 =?us-ascii?Q?U+1Avmtt/XKF+TQZQXvce8mUEyIjpEetBJZJthvUucnwus3y2cneufQTYNm6?=
 =?us-ascii?Q?cu7djpU4Xx4y7nmMRVqARDGUEElDvZq+Yaz1RA/r65kREdXph2xl9vPZlnTp?=
 =?us-ascii?Q?dggn/xt9UZ9U/OxvqsMg+yf1zi1gy7eNYEETG4VdtyPRJWSJg/3kwge3xwkQ?=
 =?us-ascii?Q?/bV52G3AbGZ7R1qFyUQxpsAjrppnHBqgKRLNv5zt/6kMJBrh7y3HIU7vZvBL?=
 =?us-ascii?Q?MXid+cFgGVKEwf5GqvAJ8+67d+qhXJ4SD41anEXQvzrUyGKvzMupb21esWzF?=
 =?us-ascii?Q?Zu3RqITsXVfuURxStGen9Y2luDXCGJpuBIy+6HuMwzRn4nj93tw3pMIEmm7B?=
 =?us-ascii?Q?+GBnYXqbmCEs0J63Y5L8ERggX0WTLYvXKXxEqq2uezTAEjgd6rOoUIfSPEyq?=
 =?us-ascii?Q?tplfToCD4EOGAJ//5yEcNwDKt+V0lyM/BoAX7G+l81XLaTSvnNeNz93SW8Jr?=
 =?us-ascii?Q?MMW9TVmtJdaSs4L9q3pdgyUCzioaXZkG/+w+4+QfbCKvLn82GZBTAjcCayYy?=
 =?us-ascii?Q?kFn/3rDIRCuOQhBEG63pFrGiYQ8IeCxA0UEZblGvzXGjE1p/8CadP7hcA8LB?=
 =?us-ascii?Q?Lq6U+LM57aN31BVX2lgDWxssLFna1m3XF3Gow3XuCQnMzSScueSaSqa5foHM?=
 =?us-ascii?Q?D004m0rssHDdDECX7cQbCf+3NXUQt+LmpnMcvCVklSsHxK3QguxzOmqpq+Ol?=
 =?us-ascii?Q?kIm6nMrQ2/ufAriXEbWppoua6S41h7gY3rwe/sHEQnYwyCZJAdDwV2f/5gWQ?=
 =?us-ascii?Q?yxRGTQGmiD8yLGepyUMi7Q/J6Ig6BT4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af511b5-716f-4c4c-596f-08def8123c15
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:13.5680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHuvqvTwff5N9c3otwHXGDqkJ7fgRnTrxsjbbSvqN6Lr4x3xG2D+8iusFMMQf2CEOxOLSl0sK/RPsr+5toqELSdt1HuxhC0cMVc9Tz+pDWk=
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

The standard SDHCI Block Size register encodes an SDMA buffer boundary
in bits 14:12. The generic model stops at each selected boundary, sets
the DMA status, and waits for software to rewrite the SDMA system
address before continuing.

Freescale eSDHC and i.MX uSDHC instead expose BLKATTR without a
programmable standard boundary field. On both controller families,
bits 14:13 are reserved and bit 12 is the high bit of the 13-bit
block-size field. Linux masks the standard boundary encoding before
writing BLKATTR.

Despite its name, esdhc_write() is the shared register translation
helper. usdhc_write() delegates common register accesses to it. The
existing translation inserts 0x7 into the generic boundary field so
the common core sees a 512 KiB boundary.

For i.MX6UL uSDHC, BLK_ATT bits 15:13 are reserved and bit 12 is
part of its 13-bit block size. DINT reports successful completion of
the whole internal DMA transfer, not an intermediate boundary pause.

U-Boot programs one contiguous DMA address and a block count, then
waits for both DINT and transfer-complete. It never rewrites the address
at an intermediate boundary. Reads larger than 512 KiB therefore reach
the synthetic boundary and stall with blocks remaining.

The missing field alone does not establish whether every older eSDHC
has a fixed internal boundary handshake. Limit the new quirk to only
TYPE_IMX_USDHC, where the reference manual, U-Boot behavior, and the
observed failure agree. Existing FSL eSDHC and standard SDHCI behavior
remain unchanged.

Reference: IMX6ULRM (Rev. 2), section 56.8.2 and 56.8.13
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++-------------
 include/hw/sd/sdhci.h |  5 +++++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2ee62847cb..7c014d0345 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -599,11 +599,13 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
+    bool boundary_enabled =
+        !(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY);
     bool page_aligned = false;
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
-    uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
-    uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
+    uint32_t boundary_chk = 0;
+    uint32_t boundary_count = 0;
 
     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
@@ -615,8 +617,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly
      */
-    if ((s->sdmasysad % boundary_chk) == 0) {
-        page_aligned = true;
+    if (boundary_enabled) {
+        boundary_chk =
+            1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
+        boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
+        page_aligned = (s->sdmasysad % boundary_chk) == 0;
     }
 
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
@@ -632,7 +637,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
-                boundary_count -= block_size - begin;
+                if (boundary_enabled) {
+                    boundary_count -= block_size - begin;
+                }
                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
                     s->blkcnt--;
                 }
@@ -656,7 +663,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
-                boundary_count -= block_size - begin;
+                if (boundary_enabled) {
+                    boundary_count -= block_size - begin;
+                }
             }
             dma_memory_read(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
                             s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
@@ -1818,13 +1827,14 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     case SDHC_BLKSIZE:
         /*
-         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
-         * Linux driver will try to zero this field out which will
-         * break the rest of SDHCI emulation.
+         * Freescale eSDHC and i.MX uSDHC use BLKATTR without the standard
+         * Host SDMA Buffer Boundary field. uSDHC accesses reach this shared
+         * register translation through usdhc_write().
          *
-         * Linux defaults to maximum possible setting (512K boundary)
-         * and it seems to be the only option that i.MX IP implements,
-         * so we artificially set it to that value.
+         * Keep the largest boundary in the generic representation to
+         * preserve existing eSDHC behavior. TYPE_IMX_USDHC separately
+         * disables the associated stop semantics because its DINT reports
+         * completion of the entire transfer rather than a boundary event.
          */
         val |= 0x7 << 12;
         /* FALLTHROUGH */
@@ -1971,7 +1981,8 @@ static void imx_usdhc_init(Object *obj)
 
     s->io_ops = &usdhc_mmio_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
-                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
+                SDHCI_QUIRK_CLOCKS_IN_VENDOR |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c542d47f9b..387c2dc80f 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -116,6 +116,11 @@ typedef struct SDHCIState SDHCIState;
  * SDHCI clock-control fields
  */
 #define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
+/*
+ * Controller completes contiguous SDMA transfers without the standard
+ * intermediate buffer-boundary stop and address-update handshake
+ */
+#define SDHCI_QUIRK_NO_SDMA_BOUNDARY     BIT(2)
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
-- 
2.53.0


