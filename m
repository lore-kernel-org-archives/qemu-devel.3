Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E76C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZu-0004NL-UP; Fri, 04 Sep 2026 12:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZj-0004HL-Pk; Fri, 04 Sep 2026 12:15:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZh-0008SI-GA; Fri, 04 Sep 2026 12:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz7FfFdsC9SvFyKgu227AupJq4rAO9ihpBL33WcyF2QHrmcLdelT7c/HelrekFJhJKBC/IuogmV9OJmRKCyCF92jB33l6+mqWj7SMGbbw5bIJU8pHWSLn1t9aPdqRBEn0YLTjgZ5dy8PISC5OfF4DgjoszRPkmDUvdnZpNIxaYZdsuPgwYmiNIuxEy2KiSXS+Ql06g5MDLOn1nrQcddQRnI1CipLDW9sJxpbiiuh7FqvkT70KvzqPWbO7FnnnlIFdN1wlSF9UstrZF216nSC3XiiryAxzxfuDwwST97vcX5tj4k2vYtT6NO1VKy8Z8KfS6sL87igBiBHRJFhhyFwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NijVbptl1TVL44BAh05HzQh2csevzHY48ezRzuV/6Og=;
 b=ahiDOJbY+b78Wnz6XUJdLb00ThLlSIHnHuDsqGxAJGPqcsksiZl79ZvC5YSbP52ld7F/iEnf++pq6OgT5hWXNnMa4hQgR8vadTZrvSBh0sMSWCwOLIOwwYknilxSVd5XqteLHEnbMzCmW6GYptZfNCmwrguMi9TvE6OG5nMqxX456V03im8vkgsCuWsHYzlxohU6i9MXtkxFR+Q9qCOXXb01SWQxGyAnBuzweDrGmSCkF8ZBETT3AwzxOZ/lXrSKqWshwnfPb2DBaht9BGmB6Ipn+NPIMX3AFoM/fRsLXVopuMoahi0fdsMrH5PuVPUtxT2faTC0D4N2COACceJziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NijVbptl1TVL44BAh05HzQh2csevzHY48ezRzuV/6Og=;
 b=ScwGRgRSr7qUQGUj6BZaCq5kKXCKvOIdDy8/iJwY9jb6DhmwZcYUNuxB1GeP3ax0RRR6KVfK/ca83GAaJw+7ZwLLsVwjKNgsOUeKdiNWWKPxTVTD2U9bX5NsM+WGUt+nya1HSP1rwnVvUcpUOaimANRl/gPMMXBvvA1Qoq1NxqdZaCkYwBtpawvGQ9R1KmEJWnl5KLfvL88nDFmxKyxwLeBcXpwGk6S5aFKjqEgiDkcq6XfuFVL590AYFIz+NSZMhNkSQvdB6e3PhfQFblHsBupK3BVYoFBU4KiyRP8UyRDHUY8BUY3/zYx5HugYn38ls2qgPnz+aprnqHYyApchwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:29 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:29 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 08/10] hw/sd: sdhci: Skip SDMA boundary stops for i.MX uSDHC
Date: Sat,  5 Sep 2026 00:14:31 +0800
Message-ID: <20260904161438.3838261-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: d864f50d-b24b-4cc4-a3a2-08df0a9fbcd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: sMyn47D30r08dCUwJVfACVaA/Olnslemt/XvQaxj8X3Rfr2ESjgxSiofL8j1cdFM10WaD4FlqXyB+mj3ndopQ0gIuOhAhJDk6cflnRTOT0Ywgn/1dM2I1UujmAehukqn7zPxyw87YOBKPdXwPW0j878O0u4nDRBdtaO5loMyvOG5A14td6cDWJhm8lzWQu+9sVjU/QHMmprwu9XPt1ylB6zQBvXV2cgrK6M/dDXFmzQpIH5blKj+aSgaYPnaDMnkvxSNGWz+5Om3pMHfNc2/3dvSRgA8m71qcXKnTfnGVyzfn5pj9noplmwuJJbQRFCn2omOHytNKEk/VLa44q9O3J+0TUDvDNW7u6Aq1neSo3tkWEbUlay2vjGK/8cZVoufniYBnOjcczEjo1czLjOc6LER04eN+uzM4rFGCBgc+BvlsdfGMfSOmglfKIwteqBGsWsab1IYuoo9iFWZhZzrP373rry4VKdO/oHHqsK9Aj97E5IeEm5JkBQHSM6+aKbL7TdRmxnSInp4gxCtBXzLzn8F2OIFV9axpKSrw2vWWB/lUf4fVLfTurlBndjYq7Nzbp9/XppfdAIpqRGdavYIK9ZKg/lecg5AbJVcbAKvwhkSzJZG805peIls+W7Zz+rEfInzquhzxbDmzXoHskKH6Nz2HqaMwCD6SExnQJP2uM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CDtzm+A5ZCChmInHUDAsA/5Ng74tOh2PxC+nB9dbxL3YufVUlb9vrP7lvXlN?=
 =?us-ascii?Q?HJL0PI95uredrkaJbVC4qdaJ9UaU2RS9CBQMUW/hlnXiGQDnKwsUc0wcVvFy?=
 =?us-ascii?Q?qXCa8tLdxd8frtdm5wLKCtQYmIjUp8lPuCcXH1x9/VwkDjDLwL8337F3fu1T?=
 =?us-ascii?Q?CDCGa719wDkM0TJH1xvKvMRnbNTPNPPy4N7etF11ExO4fwZfbuoH9Cs494QV?=
 =?us-ascii?Q?EtCp5oRIAgYf2pb12/966Uu/CmO79sGFeT4uaIqSgB95KgnLP3LCAg5pq4G/?=
 =?us-ascii?Q?wPjDru1yYV4v+IjD19LXf72441Sk1IDi0VmfDsSxSSpXIPe6xUgeQEhNs3xi?=
 =?us-ascii?Q?mM6vfWL7WYaoQBOV7iU99cIqzTwTpGJUgNjRNcyyBNsNyfUZCpAzDVQXA1VI?=
 =?us-ascii?Q?fu2VrV+bPLvkUaehbBBZ4dbGrvsayKco7YhslykV+5t/WJI4nZYviqcBeY60?=
 =?us-ascii?Q?fUyADKIM98L26lIZs+clZ9/L2PRzV6AwTWdXzsSPcIbd4rJsQRt6b5N1qSYx?=
 =?us-ascii?Q?OWVItooDEkpWmkuyt4RWqDUy16INXVW3fLoRxijs247ue59bGcDkeygWWB2H?=
 =?us-ascii?Q?0j+x/T4nGaGMG4fZ8jo46Cm3YMKGAUEVP+/+gtHZj3dXJ4WEfyVd7n8nvDv1?=
 =?us-ascii?Q?wj+/Neug6QvypJbqzv7g7HbV9jrbIcDDog4G8M5iXiUDpwOiLfxn4bkwawBZ?=
 =?us-ascii?Q?PS8314s0LZCLLvH49+6SoH78f26p/66XfMM/SHR6NhK1UWJOlzzMUn2BrJqU?=
 =?us-ascii?Q?/fmLvKBPHU7QxsNKQDvciAle3yb5OcQCegzwkrWViQ2Gto8jk4Ajp3+CuXrw?=
 =?us-ascii?Q?JJQCBhY8KikaE9pW+3iC0gURCyEm6eWNjw5IiHPx/Y8kFI8spdX2rSSKvt76?=
 =?us-ascii?Q?KX9Fw3INOIMvKqCW7HWWmmcPuNo43AF0AIe5mM6reQs5acttwwyILRuDg03M?=
 =?us-ascii?Q?JtrrOgUJ+mc6IFWgxafvIWQv+Cw2Qtqg5r337IvCQzPAAmMx0oO6M+B6n+mx?=
 =?us-ascii?Q?ZPdYac+mW3zTci/Fofu7wOWZ2OxCOJU5cuFdym7SUt5mNDRlD+RZgTJ5oyYP?=
 =?us-ascii?Q?w5v5sIK+Q0hRgJJ3D5SvBC5yA0qYYoCmQJrs/Cnx2ryHlwCKAwUh6LzUbwCL?=
 =?us-ascii?Q?ZE1iSydqYSYNcsl1i1N8xYcu1n7iPuvl8gKEpBulWMk3p9TNca4PKwo7X2Ih?=
 =?us-ascii?Q?NIRbXYBWrVeF2bmVWgualiGXZSNfSuUz/iEla1wk9iNVKr/fhy8NvlCODEgL?=
 =?us-ascii?Q?1B/4PXRXLzVhvqdYmwhvkN96cBg0V84wW9cUxiDxmI4h1OZKFcsTUbVv3vW9?=
 =?us-ascii?Q?/Y58zHywXdrQWjLRJG/BFOEcib04dTuqsUpaQ9NK7p+eAjjeXpydUxrkrXMX?=
 =?us-ascii?Q?Co+IXGn5DqVxml4ITRm9xh1K8JIR1/crNbsdlAHJgZBNRVFdX7M3e9tBa3Ap?=
 =?us-ascii?Q?TU1XlaJBNgs00OBWCYyxOhAejPP6peRND4nLeBbk8ELKnSf5nPP73F5ZZIrB?=
 =?us-ascii?Q?tbKkrs2HO7AKLV6nIpVMrknjpOdJEBsGe0i7D1M02y2C7t2PGOY0tdHa0c7L?=
 =?us-ascii?Q?AoCjC4UWhe4dOY0/dVBBJx+LbvRLHha7t5jJ/Q8khgQ16VF3Ho8pRy5AhfFX?=
 =?us-ascii?Q?Uq5dwWWN3X1EBw5dH90dWtL0rnftrcibv0PzQLvYdrQtqMfBo8IQohrfRkKI?=
 =?us-ascii?Q?UjP89rCV16D6z6KvOeIgpb2VXkUv0cvndBTymmzGlc8n4xUNsFlsXpdHZvyf?=
 =?us-ascii?Q?0uu4f+oarBKNTbwSxqPGvnRqHNGBxRI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d864f50d-b24b-4cc4-a3a2-08df0a9fbcd4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:29.5231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQz3fERRK06K9fmz+NtQcSSIvwKIKB1/RnKA14/7Q6XGbMOAPYoT75flYyeVeRViZFMNhToiUF5jwUggmniTWdGHFVX3EEau2wkLTzLXZKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

(no changes since v1)

 include/hw/sd/sdhci.h |  5 +++++
 hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 83d465774b..6664822398 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -118,6 +118,11 @@ typedef struct SDHCIState SDHCIState;
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
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4d7bbdbe7a..de0883497b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -687,12 +687,14 @@ static void sdhci_advance_sdma_address(SDHCIState *s, uint32_t bytes)
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
+    bool boundary_enabled =
+        !(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY);
     bool page_aligned = false;
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
-    uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
+    uint32_t boundary_chk = 0;
     uint64_t sdma_address = sdhci_sdma_address(s);
-    uint32_t boundary_count = boundary_chk - (sdma_address % boundary_chk);
+    uint32_t boundary_count = 0;
 
     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n");
@@ -704,8 +706,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
      * possible stop at page boundary if initial address is not page aligned,
      * allow them to work properly
      */
-    if ((sdma_address % boundary_chk) == 0) {
-        page_aligned = true;
+    if (boundary_enabled) {
+        boundary_chk =
+            1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
+        boundary_count = boundary_chk - (sdma_address % boundary_chk);
+        page_aligned = (sdma_address % boundary_chk) == 0;
     }
 
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
@@ -721,7 +726,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
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
@@ -746,7 +753,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 boundary_count = 0;
              } else {
                 s->data_count = block_size;
-                boundary_count -= block_size - begin;
+                if (boundary_enabled) {
+                    boundary_count -= block_size - begin;
+                }
             }
             dma_memory_read(s->dma_as, sdhci_sdma_address(s),
                             &s->fifo_buffer[begin],
@@ -2015,13 +2024,14 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
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
@@ -2168,7 +2178,8 @@ static void imx_usdhc_init(Object *obj)
 
     s->io_ops = &usdhc_mmio_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ |
-                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
+                SDHCI_QUIRK_CLOCKS_IN_VENDOR |
+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
-- 
2.53.0


