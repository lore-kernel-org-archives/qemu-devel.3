Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD014C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSB1r-0000up-8p; Thu, 19 Jun 2025 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uSB1j-0000kk-Ct; Thu, 19 Jun 2025 04:53:45 -0400
Received: from mail-germanynorthazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c20b::1] helo=BEUP281CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uSB1h-0003AT-Mh; Thu, 19 Jun 2025 04:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KenZMLB/N3sXg1XTrF0a8Nnr0bRz4N0RgZm3mTVPFTYWlFUbxViaOzCt7jXGHdCZys9NLvXC04ZqC/gMi9wjMU58U6xBdhmVNn3PvAOMbn/wpojwv1aag4mXCMSkvWdN09Nupng0iVSNy6st0RylpNY67m4uOAzgiDImuO8ZOY424/IvLuY73icmMjuOOBXdkupephBE05NzC6OfHd6bGAYHe0UTXaIU8hVmNPDGa5ebuFsPSvJhmI9RBSXku79cLC+POTBRD4du/gFKvVLb+Vec8xjLRQaRzpgTJeTVfocrK7f2/Wb5QK5tY+x2FdPUGLZhz0+0zSsla0hrSgP2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJzJn4jm2xy9XTzvHex4H4aNNxduruxz0PuGDv8dR1s=;
 b=mYunMbBTy0Y/hHM8A6RuHk+CDX1kVTwZCCQAenDEfq9A1h//PoE/Yd4v7wkuzFZkkeqWvALXCzS9713nESSZXi70HkgCmZJkuKyFXbSpdN12+NzQn8meM2jpmrxfO7StbV7g7nDhbbtClcVN4StQQPloona/Vf6FZDmx5tvlkk/wCUpyoL323IUEx8gbvSD08G/9ykYtZt1uBZTD+yeGIaZD5qQOX/ZQNB1Tv998ql7Ye17rp5Lkcjt9NzQwXWZCJrlYi6xoTRUXeJ73drcLtEZbUXjT+DwQdENFN9MnlF6TaqF3VtJZo3LutxaDjECfkRzvaIWQaeYQK/Ra1HjXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR0P281MB2447.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 08:53:34 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 08:53:34 +0000
From: Tan Siewert <tan@siewert.io>
To: qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH v4] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Date: Thu, 19 Jun 2025 10:53:27 +0200
Message-ID: <20250619085329.42125-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0041.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::16) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR0P281MB2447:EE_
X-MS-Office365-Filtering-Correlation-Id: 875ddce6-7b77-4cbf-ae8c-08ddaf0ec5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JrtsTvjLnu523SNSUH8OZzpmPTShp0T1bYJ7WVQ+qcMdTvT1kcwx/HEQcOlb?=
 =?us-ascii?Q?7UIBjIODRMsJPGxJtt6sY7JY3Ysj76tXtE7YGTgjzF0uMJSwSX8n7kJJqLfS?=
 =?us-ascii?Q?Bc+FpEPKyTACxeoL8aV94PARURYmdv/hHIvKnAP+ObDn0cql41FP5eawTTYt?=
 =?us-ascii?Q?tSHj9aVn6U/SYMMEBNWrNRhYv/H+6g9sJb1gzbwIvVySeAJhrPcIyWeU1VEa?=
 =?us-ascii?Q?27m5xEqb+lFHNGxu72YCWv3XcvBPLDmKSsZR57hbhg4JPJV7NPA3iOWqnR9h?=
 =?us-ascii?Q?oZifxDUR+L96GMM7JNOxYbV+dDhvIdPlWYI0g/SK8dNOE1xOVD2UrPnGSAkB?=
 =?us-ascii?Q?4yTkbEzVQ/g4sbSRgeyt5UuK/l0MkRJyCzcVXGba8cztgmTsrrpo3U3FRiPF?=
 =?us-ascii?Q?HQtn08/XUyi7iF7KbF0dQyExi1/udwYhN0TLMbYAEvTSVi0ufjh5ATSl/cgB?=
 =?us-ascii?Q?bMsrRmsR72j3mdVFvnIbXupNrFJMFsTtSqd5x+6SD6O+8rfHC9KWtMCYupao?=
 =?us-ascii?Q?kbP/UQdLbnR0fLWlwV4DLQidQJ1lwJEASSVylE6AmtTjYCwoD/8kpvHW26m3?=
 =?us-ascii?Q?x1ISaK2bL2vkZRBNYmfSG4RI5bEfqoBz300RHnn4h8QpoOqyINPY3AolDl9E?=
 =?us-ascii?Q?icYHCoWHRcytj9VfaPL7rA34/pBUic7c6IJ/HkCEStZ6umxdF+NyAom1+xKe?=
 =?us-ascii?Q?Krac759a4vCs9pMyrTwqTw54cTi5GAksjuCxJtLUKO4cccFTlSQd174G3Mqx?=
 =?us-ascii?Q?UirToMlbZErrZxGfFbMcCCytSqfFZxf7YRJ9vPUtz19IpIxaIHTyzyI9qt9m?=
 =?us-ascii?Q?n5sxtNgbHF7X36F9UsE+rojkkFYXxsa5qrRw6bVZj910rA2zTuDE+es5RY+q?=
 =?us-ascii?Q?Mja61hTsB+RAfl7d1GtfC6aZyqu7YNKMQHtrbYymJt6DfRO660ircKNj7tSt?=
 =?us-ascii?Q?bPKsb6J2u9QRT9d5mu6lmCmmugWcU7GuIEZQFK1kif28V34uema5JDYqOjFO?=
 =?us-ascii?Q?lCc49Db+wxr2HG+W+M2FUQ2uuWFLNJhB0FgJqjD0NdG+RCx48w2ZWs+6Mi6u?=
 =?us-ascii?Q?WO0/MVopdmOlKmqURKCytzXBTjW/KG0VJm6u25Do6Marr8ppzJt8F8dhv7lE?=
 =?us-ascii?Q?c73qgV0gtELa7mGtK8FGy4o166EmLL/e/KyR6Y4eM0GQjOJ7rFpgVJRW7ljt?=
 =?us-ascii?Q?y5o+L8Zzj3Dq9Zzz0jifqbNnJI9KpT5/seWzDCEtT8mDxoYQot0OpC2n27h0?=
 =?us-ascii?Q?NjBX8SNe6eC/9j6eKn2LBRnEedB30Ep8d4jpQkueDthARYKcbyb/6kSY6/13?=
 =?us-ascii?Q?a95paHIn3+tNzLzHECZoaTc4v91eMjpMaLi7vAwogNAbnXbX0v17oFJYfAen?=
 =?us-ascii?Q?gfEO3keNTo15yE4XlPWNPML/G5vUp2SNWPLQpb63oynk6rCMnaju2X1fDc0c?=
 =?us-ascii?Q?kEey2t7hdjo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5x6xu9/od9QwEWUaiPn0ZshyN6AOWZ9jPTVSndvkBh/0BhYQeO+/NyAh3MDy?=
 =?us-ascii?Q?zytJlQzKjro4RaAqpldHCgfwuJPGKzv2b729alI4shsEG3Jv/aWuoYEj2P6u?=
 =?us-ascii?Q?n3mgA4q4qe1rEuSsKKODN4NSoGKCPmbS8P6PQhaN8aY0wsWny4tfcOoEobCT?=
 =?us-ascii?Q?wDo0ft8oKJI+NLJ23hFJ8C6byWsXKmIheYoK/FN1VpeE6VdDpvZL5Xr7tN+H?=
 =?us-ascii?Q?t2a+BWzER0RyDVLyGONfqVezSq+JX4857isVKuESjQx5Cqyn1JhKQnkVfUWr?=
 =?us-ascii?Q?T+e+REWEaQUEFieIzY3LDi74GhxRx/MNOnq1f6zumF6rfsTcGDBYSK7YQ4kx?=
 =?us-ascii?Q?CkWbRwvpgM7GcXT25l+1eDliHKrpAJOGdD3RjKrvLBBzCyXoFrrYUsIcl7jI?=
 =?us-ascii?Q?nrDpmve9RWmPw1JVTfo0uSG4n8EwQqxVD3OP5GUjfR3LRyK4JKDQHaUFNBNb?=
 =?us-ascii?Q?i4WOeTysERruDuY5vUn9ugyMafwIxoFKHXX0gLcjGfznKNysC3gXo2qjPATv?=
 =?us-ascii?Q?atcqeQZgOFeu+2vy81q3tG5OkSyybgeo+cdbt6EoD5XLB+VU9tf+QKc9yntr?=
 =?us-ascii?Q?PvvThSddV+CEQ443VXPoO7VBfhFBhtmm3QxK6CcfddR4Yeq/D3/m5T3Dw0wb?=
 =?us-ascii?Q?LyhYBxF5VwFjYSIdJv0h50YoljpKCDAGsIuh4FUzBcJIXJwQuL7uQWK5dPpc?=
 =?us-ascii?Q?oeeIuoSazVagOW1MaxJeMS11TGH+B1wtGUARXkFZ2IDnzfqyfNKJlqeh2Yde?=
 =?us-ascii?Q?8VSLcDwsZMsa+go6dzALicCNZfIlO+x14Rs25QCvvE7uej5cm5wQLDxCNoHs?=
 =?us-ascii?Q?m0Vc8GsiYBMO2pFYJ4mqiAt3LFGZxE7DIxSdxmynNDDvfHSK6JTQTNeO8gG8?=
 =?us-ascii?Q?XcRVWD2bJJOQSrbDmJAWmAP8+/UXsC0+RUc0WbWoYgY4StVfp0nIn+sa461Z?=
 =?us-ascii?Q?Nko+UDEuO1p736FJxF5E0NbteW2BvKb/cKn6osh/IZ76M7GSAzbbCAxz25qO?=
 =?us-ascii?Q?qEEjjOwvBdh3bsOJcJ0gglGyUIBPXRWd/T2l3Ks5BP/aNp2+rZw2CQuCF8wW?=
 =?us-ascii?Q?lS/WSX0+++IfCC4Hoxl/WI42YDuxc3wdIkdRVsIYV3FGxa0X+7owyC6M4FWc?=
 =?us-ascii?Q?OMxCTGHueYO0sZ2cFC3GPPunYdfGdiRykdY6xNKHFv/zc8H9yZ3rsGFETFiX?=
 =?us-ascii?Q?lHH3jYgzZYdOuHzeSRElvPVRw/DVRNxt6UngdABpa6iLqdYunp35QzgHcg9Z?=
 =?us-ascii?Q?J7c0Lgh90/u4qlzdKoxHKDwT0KMTeOxDvwwEzetb5kWLd/f9cG0szqfTiR0q?=
 =?us-ascii?Q?Us4AK5lx02zzrCbgn0KBV1mM1Vo7kGCNFweRt3RRT4tmCoE46RbfRwQNbWMh?=
 =?us-ascii?Q?kjJwF2seKvXAnmqLB12wBUXMOUFm0dHx80leauwcB3+8VufKKWPEjweoi5px?=
 =?us-ascii?Q?yMddaPqAejLqAaTNnWhJDpE1VO8lMReM9iIVTb4hcy4CMtjskrVZL4WQTaTs?=
 =?us-ascii?Q?FzIvh+Bp6iDlndraJjDR2U8gb1BYL4IopaxI8j+pfDkv3aPMzo2Q/0YoJj7w?=
 =?us-ascii?Q?Ym3m68yPy5/fKvDeZDklKRZKuxIVxqzdp7dD5ttvEF85l2vsTSm9+4jyiugx?=
 =?us-ascii?Q?aehE8Nh1NV8rFfw/4FJt61c=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 875ddce6-7b77-4cbf-ae8c-08ddaf0ec5a0
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:53:33.9702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSP/fmLlnnNJkunbZqVQuVhS1rDgpIx+et/uwDkwUuHn65Vk8WpInvUJhLdEqrdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2447
Received-SPF: pass client-ip=2a01:111:f403:c20b::1;
 envelope-from=tan@siewert.io;
 helo=BEUP281CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AST2600 SCU has two protection key registers (0x00 and 0x10) that
both need to be unlocked. (Un-)locking 0x00 modifies both protection key
registers, while modifying 0x10 only modifies itself.

This commit updates the SCU write logic to reject writes unless both
protection key registers are unlocked, matching the behaviour of
real hardware.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
V4:
  - Fix mis-understanding of or operator in lock check [Tan]
  - Move SCU protection data variable outside of switch case [Cedric]
  - Fix u32 -> uint32_t mistake (now bool as same result) [Cedric]

 hw/misc/aspeed_scu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4930e00fed..39832cd861 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -91,6 +91,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_PROT_KEY2         TO_REG(0x10)
 #define AST2600_SILICON_REV       TO_REG(0x04)
 #define AST2600_SILICON_REV2      TO_REG(0x14)
 #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
@@ -722,6 +723,8 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    bool prot_data_state = data == ASPEED_SCU_PROT_KEY;
+    bool unlocked = s->regs[AST2600_PROT_KEY] && s->regs[AST2600_PROT_KEY2];
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -730,15 +733,24 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+    if ((reg != AST2600_PROT_KEY && reg != AST2600_PROT_KEY2) && !unlocked) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+        return;
     }
 
     trace_aspeed_scu_write(offset, size, data);
 
     switch (reg) {
     case AST2600_PROT_KEY:
-        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        /*
+         * Writing a value to SCU000 will modify both protection
+         * registers to each protection register individually.
+         */
+        s->regs[AST2600_PROT_KEY] = prot_data_state;
+        s->regs[AST2600_PROT_KEY2] = prot_data_state;
+        return;
+    case AST2600_PROT_KEY2:
+        s->regs[AST2600_PROT_KEY2] = prot_data_state;
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
-- 
2.49.0


