Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9457EC531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDF-0004EK-8s; Thu, 23 Jul 2026 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD5-0004Ay-CT; Thu, 23 Jul 2026 11:19:43 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD3-0007zZ-Ko; Thu, 23 Jul 2026 11:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1yMr5erH/ubWzvOi2ObwZI0I1i66fJXwAY18MV603bNbsZYUlY087jS9ET8WAO/wv6A2dC1fmXizpG9ToSQKJTZSTWhbd7PTaptXNR5CAaCmqcCaVf3zTvq/yOm4OVVYHw/YKN+ifmrSff10CLsmMAfgZ3SWANRLCZSweShEEy9n3LWPC/xY1BczZ84nqI2siTVzubA5RgKZy4CCjaX4uyoeWnCnCGVK6jERPLV9GgSADNCwmGxwVJC0QLuLJG1lT+lmYwXGqIfRjkHTAGbAeu5O0xIcgWcIKlvYCtzEIyKl+OaYJPNhUBjAkCoTejyeWnIlbMzu5xr25SolF1UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moP7k6X+hNoOnNA6gwYXEhkbpSr0Cxv6gmtgIBoJt/c=;
 b=rnKM4dwquV+rSQgN9DQ1TeX6VKM30Zh9zEFUIMrqCmW0eNckQryraxGhoxoez4RZZiIwaDhKFBw41amNYIg54LS3oDIMeuSwdffUa+mDpNuZoxyfe3semxb77pCOASAOpSePH/WPWuZuYkTqKdGtP+tv0iYDkbiS0nvIiBFWcsaexsAoaXJ6Ac7RRI8yKgXaaKCB+kuQdkOzQRML5MegheitzfZdBaqRawJRa0EfB9YdZXSsiMolLpW6C5E0pux0JnBzbuOMau49JLjHwgbrTr23J2nJzhvcChkWrPfF1yNXbTc7O/vl8qc/Pgirz68WbJ9UCv19+/6Hoca6LFQlWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moP7k6X+hNoOnNA6gwYXEhkbpSr0Cxv6gmtgIBoJt/c=;
 b=QgDEtySzvL3Iod4HuTBf7F+ubGq6wzTQrwq9GxRX/eDlBTNY9BHe3RgQPxt8fhrA53BJr5kQUsOuBBryqfPm0xWqNDNf0fX8IoT1gjCMp1W+J0XxN01vRg6FsNKEPTyotKOQVnYfxBuQdttD8Ao0Z7ZqSSbVTjUU8B9+TCLxiSCoxRXpHnhzFzXo0WskO8VzVM8iRdCy/0wjfhAFzW8Cvv26zZDoyLmB6sztivbuTHjUYJlkTaXqNTh3Eu9llTZejozo0smg7f3fJqGF9f7J2EpaevJ1LBy3H/uVIVvMsJ2u+VVlJKUNS5RUWlhrcfYQvW13NPqYOMkttwDLy22CjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:27 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 10/26] hw/sd: sdhci: Support version 4 ADMA 64-bit addressing
Date: Thu, 23 Jul 2026 23:18:37 +0800
Message-Id: <20260723151853.2143177-11-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6f026fc-57da-4584-687d-08dee8cdc8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9ErnnwRTChjU++SfwJQa8sV6UiqrouMOIwkIe2L84YOh/pPjzKUvH0aQH9k9oaUgMubPJD78dnXTJfDSyNNP/25kjdd3MTKjlit4xpreOmuEk7osqPvAxbArsVTAwv/ry3zWkd+Lk7NYUnAv+plMdi+5Lg5x5SDRp+Htkg9NM5YU1+V/0BX5fs1Y5yFR0yESqVYfeOiyDaZrgDxtgc1T6yOaJtGzollaWmwcK8lcy+2QecMnOIq7zEvtEBj6LeSRtvugReduOgxPKtxov65lijgN6hYXuSL2uudBzh31eRn3nHY27zNmd7fSuj6W78IKhvIOay3dIE4XcvaxcKUYNNIxWy7xVh++zU2O6t5Jzt6mytlWp+EGA9d2lMZ8dwL1NrnSVdHZXvYsTwhpVueS3ZbNVKw0/qL/FwlgxjyNoPaxG3NsWFu/iRiOwTMpCZKAbQlrWUK2IG6aHs5D8BmI/iSX+65BUooOnbO3fr39QC6Q0jIdHTV/tZbmAqqNkgfk3Fqs+ZIOjIvMUz39rLD4IxuF3jB+/chEqkog+7Yuyq0DaVD29x+HOC4cWv7WSJ8CW/z0C2jWyJPJebMAQhK2F6SBUTJMzTlS12v3+8MRHjg54Xuulaxs5q6LhawNJjymY2OLeb3z/4roovm65tWbB8hvubykeLq2pJkFBkx9wbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkJgFQpW51AvK+or9akHepgi1RGoHh3uFkiz+E/8c33skkKBo/kB0gEcGKW5?=
 =?us-ascii?Q?4ZTVNuIe1yatSnhFjoUW693T7cqKW1rsHUGSZbQpif1T0+IWccpxh+cvKlBO?=
 =?us-ascii?Q?xL0TQ9HumeWP+aRsI7SO5s6k4LNLYXOA+R2VXghyu5RXr2DzjbmaRyDfpP4X?=
 =?us-ascii?Q?N16+lxJviWHWHOAEGiZbCGvXLnLQyduZWzH3FJewqYMZg+KjO5iSNd92MOIA?=
 =?us-ascii?Q?J7vqxKez4z8ujkcL20ev3VAFm3aKhhSO9lN+EwOCN4uTYKnaKiPdTAYbdqUR?=
 =?us-ascii?Q?cMMG3fup/ZIvtN+8LEdItOe2UeukCCs9OJbVrlEjhyRyfbwLV2A6IB/RPWw4?=
 =?us-ascii?Q?zLAbSm2p/Z1QWbkBPVArfGaZ2tHoGhP9gNRbRFnLtT7wXm+r3u3xTjMajgDv?=
 =?us-ascii?Q?2IMQUXd081R4Ngkgv0Rcvp8t/jHuOPWNzvPPIKKku1qSh/2+S+YCL/lj3gp6?=
 =?us-ascii?Q?0qR5QL5u+Dj9b4P0Xdeff3PreH2APPiQyw/LGMCAgGgbJQPU1qgEhem1pEGs?=
 =?us-ascii?Q?5zD3MvRNgSXsNis5Lzr+xldAGJkcE0ufu1Eyg8+rdSuT/RzKPYhQWJg0qty4?=
 =?us-ascii?Q?1GQSYJ5rCE8y4PximKIiYJEsx8ytn/7wBtODZA6y7u2vrzc5/3MOVseD7659?=
 =?us-ascii?Q?SD31wn/JH5+RoimAschaRQwI3K/oPhy9lJFBD/yrRcMRD9RCEJJrxe77I4QY?=
 =?us-ascii?Q?OvcVk5fS4JP02KwhMqSMOMkJQ2+rdB/zb5GVfEvYPJMXA5KXYklY2yO+ndIS?=
 =?us-ascii?Q?m111UcWftk35bjnNYaqM52ldG33nYGMdG3UhntLZrHx1QyFY4Xq0smKPcdy2?=
 =?us-ascii?Q?w02h6Uwx+AaU+lSpMbNUZc1pgpT+Wi27rfeDUt10V0zvPbY8oZuRpmk2dboI?=
 =?us-ascii?Q?mBro541/K8NYbU6CoNtN5xTYaq3xc2Q7yFpVKiiZJQqFVVQEs2A892M3cCi2?=
 =?us-ascii?Q?ZqAV8CfLamZJm2WHuIL84ODCQSnQutHPqcgQ5qo1X2DWlDKR2cI0FHZjkrjj?=
 =?us-ascii?Q?VuVJWs2gCwu7yqVItiqgoVljACe+bRLgbQLXaIRmABDdvU6sJAxk3NTMScrw?=
 =?us-ascii?Q?sPkbaq4l36GON2+YgMnTm4l+f0X6JmFDP6AH3L+6BkxbGiVCwuU3EDmomyiV?=
 =?us-ascii?Q?5HG/HxoUWU40lZH+7RGL7nqlEM2ZZAB8vqX32aW6z4BmiH3ur4YOUJe83qGd?=
 =?us-ascii?Q?vemjlZDNECMlL6dSa2W2xxaThYxSDOtKJPgYd0coFa5Ixvs0v0+Iu70epmJ/?=
 =?us-ascii?Q?jp/9fxIay/VwZ6EDzh4Fg2VtlQeaaKV885LufacI6C7JX6Fc+YiZRmijmOzJ?=
 =?us-ascii?Q?/oD7h2Omuju0KA6rJuwkqhmK0XBBJCcgQYPLt+aYHfPVoFG1nFW/zz7Q/w8h?=
 =?us-ascii?Q?dfgRwI3sWn+CCEANy+gO8aa8XLZrs78/CGlHNSBsktjw4a+FMN+GekfTpCtH?=
 =?us-ascii?Q?dnBBhNA1jChUYFdBDVgRZeZ7qpx3W1LHaMhbD7zk+V+y7B8irlBz7k2vz8g3?=
 =?us-ascii?Q?H8TER6GkX3m74wB44nC8aagOhvs1C8BqMfHBCgyJ21tM9F+HgnRxsWIyKBnR?=
 =?us-ascii?Q?rfufPKxmql1GSEylHFEZOPnv/0Hk6szWWteLjPgSeotHOl4NiyQ6mxKksEvz?=
 =?us-ascii?Q?+B71Y6HeQV8N7kMsb6rk7F0mZh0rHI7qhS0DD5TNdslXNP8mUbrhIeYFlz6y?=
 =?us-ascii?Q?L3E4AfApcJ6Hj7BeV/T3Lc1ADR5JYi+sDuDaSNQb3HKeGtnEJs9lSohHrWhH?=
 =?us-ascii?Q?HVWDPxv8GE7wXhtIgVcytshCiczXJbI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f026fc-57da-4584-687d-08dee8cdc8cc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:26.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CX3wRVVF64kf/0Dt9/oxxQJsLELdOgMuPAjTcTsqllf1P2u3E7BdBgslhi+ZSyJCEbQKnF6jyj/PqUFuBYjzSnp8Dq8PsZTWuToDuZCqHY=
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

The Cadence Linux driver enables version 4 mode and 64-bit addressing in
Host Control 2 but retains the ADMA2 encoding in Host Control 1. QEMU
treats the transfer as 32-bit ADMA and uses 12-byte descriptors because
it only decodes Host Control 1.

Resolve the DMA type from both control registers and use 16-byte version
4 descriptors. Preserve the legacy 12-byte ADMA2 64-bit format when
version 4 mode is disabled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d2132035eb..00a4b9b0e4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -227,6 +227,23 @@ static bool sdhci_update_irq(SDHCIState *s)
     return pending;
 }
 
+static uint8_t sdhci_get_dma_type(SDHCIState *s)
+{
+    uint8_t type = SDHC_DMA_TYPE(s->hostctl1);
+
+    /*
+     * In version 4 mode, the legacy ADMA2_32 encoding selects ADMA2,
+     * while ADDRESSING_64 determines its address width.
+     */
+    if (type == SDHC_CTRL_ADMA2_32 &&
+        FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4) &&
+        FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, ADDRESSING_64)) {
+        return SDHC_CTRL_ADMA2_64;
+    }
+
+    return type;
+}
+
 static void sdhci_raise_insertion_irq(void *opaque)
 {
     SDHCIState *s = (SDHCIState *)opaque;
@@ -781,7 +798,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     uint32_t adma1 = 0;
     uint64_t adma2 = 0;
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
-    switch (SDHC_DMA_TYPE(s->hostctl1)) {
+    switch (sdhci_get_dma_type(s)) {
     case SDHC_CTRL_ADMA2_32:
         dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
                         MEMTXATTRS_UNSPECIFIED);
@@ -818,7 +835,9 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
                         MEMTXATTRS_UNSPECIFIED);
         dscr->addr = le64_to_cpu(dscr->addr);
         dscr->attr &= (uint8_t) ~0xC0;
-        dscr->incr = 12;
+        /* Version 4 pads 64-bit ADMA2 descriptors from 96 to 128 bits */
+        dscr->incr = FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, VERSION4) ?
+                     16 : 12;
         break;
     }
 }
@@ -998,7 +1017,7 @@ static void sdhci_data_transfer(void *opaque)
     SDHCIState *s = (SDHCIState *)opaque;
 
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (SDHC_DMA_TYPE(s->hostctl1)) {
+        switch (sdhci_get_dma_type(s)) {
         case SDHC_CTRL_SDMA:
             sdhci_sdma_transfer(s);
             break;
-- 
2.34.1


