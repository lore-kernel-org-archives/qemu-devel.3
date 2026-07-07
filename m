Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C4C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5rm-0004Qj-TH; Tue, 07 Jul 2026 09:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wh5rj-0004QT-Qb; Tue, 07 Jul 2026 09:29:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wh5ri-0002q8-0f; Tue, 07 Jul 2026 09:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avZ4o5g9XuVL2DkSUZTsjDqJAC02lvTYPEetdgl95nnlRqtl3x2a5ZM1NU2fz3ei129vwHbw1BtorRZYKijjiI1kaM/Agxm7awuGR3xTyfAR03hjDEBVd0t+ZCeZX6IfvBGtPRi/jgfcFjBdP7ngBW9tSY8KtBMf/9uuymRicVFIHTeA2ZJsX/2Hig564aJbfW8Gu3KatEFdcjHYyl8rLwgNtJio682k/870lB4CbXB6DcD40dG8iLgBkQVr1FMYNGRZV4pS+uSyvgIe2EX3L5CnOH6/QuHFMxY1UgrjOnEA6YOwraMLifQE+f3VGnVAPErjv6So6OAccN+t0Bf7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSooLPuQcqBkNCy+TSBEcwWEZG7cz+DEl73sqcVcPxY=;
 b=yOEGAm7iMQTDuFMI1k+gRsTNB4D+CXCq4xX2WFCtaaW6fMc92L0zlIU5la3MBvWQZME6BGpWwyymuk+ofF0Te6aZ+S6Bl6qZ8Ign2iyxv56vKOCxlPUtniiYMZVI3j8L6E8r2i8GPi7V/175uZkoHOEJxstGdBJKTPVjMS2pyXeHGNQsAL8vJOYNQ1m+FWBE/GMxNDa1BzM1pm3CPw0pvbkuVhIdb/2pcKZ0oCJBqUnJUX9E7mRrSh0MT7yYLv3ijIB4h08aR04M/YhhxqEF+Wo/rOV0C6jFxlD5UCRYwKwRyIPVuiLrqs1X53mHqwzMQyDr/soqkN1ZCmGE94sJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSooLPuQcqBkNCy+TSBEcwWEZG7cz+DEl73sqcVcPxY=;
 b=WT0Z/07gy+CNQqkAEV01/nQeD6T/eE3CuXsVtRcXEXCvbFuBG4H+vIk4T9M4DXXratEj/izEIuoioPoqutYYa7afPEkhiR0LyyblGKB81ZW9Hy8FkOEdIJU7F9k5fiaZJl6LLlK0Ohv347HEvjnwekxGG5vsxneEvctOXZf3n67R1rob7UsqSje5uiMIOYzhgQQyDcZrJ9XVtoiEfFqzb2RHbbqvY1mfhgG/UxVddW3vqxGfitCVRREjG7uENAyih9sdsoIeENy6U+f+S6CYIL2F9BsScB1k5OdagIhDRO+1t83IA/sDHI79nAw/Pv0vLC59lyIxOvAYVlOVKE3JcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SI2PR02MB6103.apcprd02.prod.outlook.com (2603:1096:4:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:29:23 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0159.018; Tue, 7 Jul 2026
 13:29:23 +0000
From: Chao Liu <chao.liu@processmission.com>
To: alistair.francis@wdc.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, kai.liu@processmission.com,
 bin.meng@processmission.com, Chao Liu <chao.liu@processmission.com>
Subject: [PATCH] MAINTAINERS: update Chao Liu's email address
Date: Tue,  7 Jul 2026 21:27:01 +0800
Message-ID: <20260707132701.71164-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SI2PR02MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: cc252a78-066b-4095-1dad-08dedc2bc20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|23010399003|1800799024|376014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: /l9vFm8x3cNqAVUw5Pa96lfH+MT24jKPx5ztqgw1rN3O1hYfYu6WDl1YlaB/vLqzNYS3N4EAPwHYa4fzaWPWNlWJiH19Zqlrq+tpZfVEZPNSDD3GN8FP3tk45+QfohIls1cJY0XZqf++k8E4+q6ART06J5pkOVrgaJYV34uguy1VjXtpb6zW0XGStygLF5XIte6bxJSUHvOBfgbHolwLouLItvpqTIo1sYaR2EHUjNTV1EfXT/J+JL21dYkeqXQzTTn5qc4fVUYiJynMdfDYa1CWNU53ub10IUD9Dyyrjh4m5G7gfZNW/2nNN53u3ZCIlBpx4hEzPilB+tBXMmsLqSkzfWjd5rXQR+xDieMSXKoUW+91B+pqmUbHCIJ3oc8tfyCkr/HWfBlSktIxX15hOURD5WQ2PrU+86JPNkjKrnmRK9yEL+V5T9vJzAVJlqyYJS+boO3+1uuIIK8RPcvqQs4XQzoQdgznPYfb4YPKr0bxIw8UEYUCFpx/kJahCVF0iOtWFbEKhiR+l5jYGevLf8QsCgWsmqcfWOb4IXovZYBPskxxjEe2HDCB8y4Xv72jymGJHVH6Oxav8H5w2Jo7Xm6WhnVGpm35Ki0U7tPrnD/qeZk79HegsZRd9cEpq4HHrMvUBxvsujnco3T759sACrjN38WiIEbC2YB9EG79TYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(23010399003)(1800799024)(376014)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4uCGbVb9x19+w5/Budp/xUKYLyGWBZTd/M4yBgQY1GdjrvAc3KBdeO+in7X?=
 =?us-ascii?Q?Rb6tE8FH8phtgiAEt+Z1h7BoCNkwxANmlg1Df0pOBQn5OR6c3qa+wtXN9XjJ?=
 =?us-ascii?Q?aHy/7QKV1z5ZgMzlulsvY7Vj4wJ+v0aeUrtt4L3BypnDNF0YhibvPa37WYSS?=
 =?us-ascii?Q?6pQjzcEelbVZRWrG8ONqBQ/DpibNg17B21AQ6xX3rG4CQiW5rXdR5dz0n/Yy?=
 =?us-ascii?Q?Rb321pf7/NUoczMpmiVq8TU4QllO4x4KOL2aKHV7kmsmYZKkUhdmHb6oDcQH?=
 =?us-ascii?Q?mW/tYLujq4bZOw+bOiyzR0FoAZ6rxBOGSDny7IEA6HBkR9BcodXLgPcuCwcs?=
 =?us-ascii?Q?VkP7NSxsyBtxenu3aKhM4NciAPcAQ9F7LOhE4DwAWugK8mLSaBBHKjabb/Xg?=
 =?us-ascii?Q?mTbdCcva5FY2mB7fD/Qe/3M8OYhjXx1DiiBD40k37PjPu+MaOx6zdTby/3yd?=
 =?us-ascii?Q?UAwHcKZVcfae4GzLB+8KM6T4gZujjCdcRbszJ4/9sX3KQiXhUNu+P89nUohG?=
 =?us-ascii?Q?tGw4NOHPDBHs6Wk49+fYAF5tW3Mm7/Kw+Uks+BF901qBAA9MwME8ScrJ7ywV?=
 =?us-ascii?Q?56vQbIQa/IEUQkqdQN96wSbVEACVdx79MziEm2Ao6bb16RQLpXT7Ma0OZeHT?=
 =?us-ascii?Q?yf/LCiyduA8OrWkabPDmceKgqNTK9ocwpn6tI5W3ZD+UNy3/pXZcorOGXdy+?=
 =?us-ascii?Q?ntM5nFXqUx/GLFZjxLGaxyI1PvYLjwBVYz6zMjJGbA2qyjvkTeG0scl3nkmN?=
 =?us-ascii?Q?svr9jOfqFLn7OL2swwPYYKe5/st24+HT/495+qso9wl/MJC2/mhh7AHzUqWE?=
 =?us-ascii?Q?kqEv+1mr8pCqci6MNnuZKBHgDaK2iCutGBiZmiHPANld1bEnx1wxxZChVvrh?=
 =?us-ascii?Q?IBi8a52K7+vCTdc94Zzwm6CUiKAPQxnnjq93TQ5bAnwjt5j0rzMo8FMG8y/u?=
 =?us-ascii?Q?4VtqI70QRhpzSSl9EbCx3zrxaGf5Tw1kay/ge7JMBQf62U8bsJdcUM9x4PBw?=
 =?us-ascii?Q?XCD8xstKEG4JDx7KCo4ezAXTpEqm/FImuvMUv3oTwUaxKJRf+INlCIsAi4DA?=
 =?us-ascii?Q?DIrPJIypVgU6Ij2DYgstjO2j7QqpIvoYQgQDvhUcpc4ccoGgjp+OSEM0KIBJ?=
 =?us-ascii?Q?8oRrm+NPN7ltLBNGd4SNjWvmfgMLPKHhuDwrI+P/Ib4pKOdk791r3vIwLD+0?=
 =?us-ascii?Q?1U5ildbJ9yC/c3uC778XLzcRcnZZTGybmn9Z+RTfVpVcf4u44xUcicCG6B0L?=
 =?us-ascii?Q?DnKwysVce9x0SxBst0EMhbSSNo1+Bwiq+/qUsXTRdTAY7rC4CYSLHZW0jP4M?=
 =?us-ascii?Q?C1yK9pA70Sx0HZZq1zyqNnY6ShKX3u1qk+p8Qvb4znIAXMBQPtR+R1gCn0Xq?=
 =?us-ascii?Q?nAhVY2+CQVAmMv2kJZyROjNTysJ3KR7fBSqAkINKRnTvDora/7dotH+9o4IO?=
 =?us-ascii?Q?+oCRYfndLgdFNjOfEde3e9NO+7wbM4YoROyWNjW5qL04xPKPHSPfF/2Yuq2p?=
 =?us-ascii?Q?hOPTDN40dFyUnhefFCepNFAPkoHEzbIzOMZ2Jr6m22OVuc4+3Q7bYNk/39QR?=
 =?us-ascii?Q?W8RlRkHOzvIlcsIxIxtYHGsDa96/6AVxFB9gHE7uI9XhC0MeoS4O0q8Sd+YD?=
 =?us-ascii?Q?qgL0oSxwexhrCdUYK70ao9EKhXd6xBFDDDkFtLH0LTrSczbpjE0+3YaW+mCb?=
 =?us-ascii?Q?QqltbJvGCyTpCDaJ0frtSdWFJMDtIl+v6jwQWBGeGBiQ3HY8iDIPGpHQP4jc?=
 =?us-ascii?Q?9jN5pnkHYE8clKbS7SEtRoVDrP6ZbEw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc252a78-066b-4095-1dad-08dedc2bc20d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:29:23.2109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iErutcyg+D29/YTzyhMdAyhj3Q3cxxlBYRihorGs7RM7A2f6WCz3r1vg22l1smb/xfNB9AIdKtcoZNjJzgEz9sDitT5EJ8dOCqAnCAJ08rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB6103
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

I joined Process Mission over a month ago and have verified that sending
patches from my new email address works as expected.

Update my MAINTAINERS entries to use the new address for future upstream
contributions.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7268c431b7..ff57d40bf5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -353,7 +353,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
-R: Chao Liu <chao.liu.zevorn@gmail.com>
+R: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: configs/targets/riscv*
@@ -1817,7 +1817,7 @@ F: hw/riscv/xiangshan_kmh.c
 F: include/hw/riscv/xiangshan_kmh.h
 
 K230 Machines
-M: Chao Liu <chao.liu.zevorn@gmail.com>
+M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
@@ -3793,7 +3793,7 @@ F: hw/pci/pcie_doe.c
 F: docs/specs/spdm.rst
 
 Checkpatch
-R: Chao Liu <chao.liu.zevorn@gmail.com>
+R: Chao Liu <chao.liu@processmission.com>
 S: Odd Fixes
 F: scripts/checkpatch.pl
 
-- 
2.54.0


