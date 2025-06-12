Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18260C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPj7H-0004kf-GV; Thu, 12 Jun 2025 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPj7E-0004kE-2o; Thu, 12 Jun 2025 10:41:17 -0400
Received: from
 mail-germanywestcentralazlp170120004.outbound.protection.outlook.com
 ([2a01:111:f403:c20c::4] helo=FR4P281CU032.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tan@siewert.io>)
 id 1uPj7B-0001CY-K9; Thu, 12 Jun 2025 10:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usRtdJQ1CkCCHZhSyRsCKyOQu2Rd57NyESQKTso3cUPghVoO1jjgsh9rBdbrIpqPugfTxPQ+spTwG1PBUGOTfnyps4d0ANfJOQwoy/6ovE9Nva5LSwsXNnAEJCVpIJopyL29FArXosFhV6HZ1NKaEAMV/Z/xezC6buJvm8tBPFm0UxRFVhCwhNfM7ClmXwPnToDqaGgbSVlFOD6dRchBPpEVOyIyNwYlPrJu7LkP5oHL6+lnZtS0B/zdYZ0BvAM1xuYoqAPGXh04TlLyIPjnkEChfpiEn7u7OulI7wT87a+ybTDr0OJwWPwlEbysPNNpWNlamT7DPk5JTJiP+5uvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY+/6XjmQ9ANg9AR55KZH/Th05bf171u6mVSpMrnJ0E=;
 b=v9MtlhK8hXwT3TNqgsBipuxbJ4Pq5sDDazrakO9p1ErvLyBKjo0BFbIL4POogh/M1By0MHHstZg9iuRx9WJRsmZYW9+huS0unHW5htZ+LAMdK7nCWRV2swFSdZLsLA5mIAiczjAI7zrSSJiHY70UQtGqd70L368STyAZjjulqyuxxo00dEfBbkliVmiv7NcVIUcCmd0bLOuXNZTi9pSlvuE+r6jqhXaTe7tSspcUxyNqpZll0zryGwrpFJ7XFdijqXD8vFOm+liSyHI29wNJ/Tn8ePj907/5TsoJr8859KDcZCENFxtylN2T8HTXGtfIPuc1oRTQdaEZZ0c6tWn8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR2PPF1D699E748.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 14:41:06 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6ec7:ece3:1787:5e48%6]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 14:41:05 +0000
From: Tan Siewert <tan@siewert.io>
To: qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: [PATCH v2] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Date: Thu, 12 Jun 2025 16:40:49 +0200
Message-ID: <20250612144052.22478-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR2PPF1D699E748:EE_
X-MS-Office365-Filtering-Correlation-Id: 65799033-7974-41de-a507-08dda9bf296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|52116014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d8qmfdT0asPj1h7elNFc/fPuet2CdGSCDwvdnZpGcM2ce09pdQLUpTyfjO6k?=
 =?us-ascii?Q?xBD5z69H7pl8yt2ffCCQxzZXxs38PgILNGSvnjvpGBXCc64eOy9Hh9xHSTMb?=
 =?us-ascii?Q?KX9gGSvN5gjRtV4Ey5q7/oNO+FnKL6IV9dLPdMRtg+1QHeA/bYZEdH/f5u/l?=
 =?us-ascii?Q?h1sUr+nRmBvvUzeZMguATBkc6J8CjhWhvyCqq8ZKiQsBrQriJbBBl7wuVsy4?=
 =?us-ascii?Q?Nkxl9jT+LmK4Xtf0HXJvfPKDgAKYSGDPZnjmPe9ltbeZEcjLKayrZfxhIZZ+?=
 =?us-ascii?Q?o/Wj8GhHZQX+OVIsep8C9QqBTYEUfOkDspRr+kwphHwbRLNeY8WqjwYtvWdv?=
 =?us-ascii?Q?uzhjCS3rf0xqljTeKMfhJxgS7rmvjveNVs0trE0Yg5Hzk0sCV2NFjJJTGbSZ?=
 =?us-ascii?Q?PWS/+ZedOFeaRZaQg/lUE2p2ufl5vSLW0em+gsiIvgRL05Ceh24zSKEaQQrp?=
 =?us-ascii?Q?rIfNJtm9VEABoFEucSSwgGTWSWEQDW7oFf1npTK3o7USq7bZF7CYJiAZ2J7p?=
 =?us-ascii?Q?RODMmQUY04U0sXcfFvkhtleqgGeVq7/U/B0XFrCtg27sdfgElQYFI34nwH9g?=
 =?us-ascii?Q?1K2yyrWu1xWfC/eWo2Rgf6Vl4wZFcy1rUpllmvRFWvwG3fsBVyJ7kkgM2D0U?=
 =?us-ascii?Q?rj8GyWpKYElhtXkyxQa8sbQlhRPSoR6ArEuDTYa79P20pqfEvZviXYzgzudM?=
 =?us-ascii?Q?7RQrTjjuk7I7kHiwR2C68artf5vgAWtrwJhKAjDZBkXEosdqHTLSQry8JQMX?=
 =?us-ascii?Q?dXyTbiOjpQ9lAW8jqw/+5XybOZfsW9ahclvmIpi4yZZaHtyg3R9shhcrZwal?=
 =?us-ascii?Q?gmtN4ypVxNHtE8iY4C8Y3aEy7iaeu/xXFFOaZ4YxV5GXINd9UJgao0CdZdLO?=
 =?us-ascii?Q?wS89TCF+IQ+wwcrep4N2ZBwspVzyOp6pov/4ZDzGyYpoJxRJYRyXhDr9EM/x?=
 =?us-ascii?Q?9yfxlI9VHl8RjqUN3Zsoc6YponQ3J1Y+CKm2FrIlRaONg2oclDL0fR8kQaQ9?=
 =?us-ascii?Q?dCoTvP/WTZ7OciZQTpXCjbmeqkmNgzxEMtqKqDX51SjNm57d3DS3W07bu8sC?=
 =?us-ascii?Q?Q3s5qhNous6U3K9KM0s8GVfS69bGlOJNr8C9ia+q0Fkqtu7AamPhB3Gptrf/?=
 =?us-ascii?Q?W7xrznASLqrl7jzEZkCp9ByaE3qPPlJU406sz0vQW2gjdc8t3ZwMTreD21B0?=
 =?us-ascii?Q?ql9EqCnPCCXn3LKXvwm7He55fjMPC9UfyDJ/nm0jp7CVXcr2BJt9eMf0u+y9?=
 =?us-ascii?Q?Z1nusxqKzlfVUtxul0G9KCEjtViQu255EeusqOy0o59SrezQF3PuzfqzXlFY?=
 =?us-ascii?Q?g6BNsdRLYL1zeORBCFfICanaSRzOE8d2kS0iVzuZ32S7kvGcDdmGKRPQuoiT?=
 =?us-ascii?Q?KoqfYkl+bM8BsEwNabbJ4DW168NeaDiI/mN3FggCHsrTPRIekC1RsI8ONtrP?=
 =?us-ascii?Q?Xbz9ZwOLxDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(52116014)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BqShNpI/N0xbwFU9Y13b+7wAoBrJvps/yHDr0Dtta8fw2DCQmT2TOvm8eUsX?=
 =?us-ascii?Q?e4yBztn3lm/BBnPuKr3ElSUGUQBXaYGkS/uTSEivxN3FoFhWP+satBeN5SKE?=
 =?us-ascii?Q?196sVVhchGo3m5tiIOY4sNLv88cfleO6TYWyRSdIr0juax5fNs/KJoR1g0TF?=
 =?us-ascii?Q?bFkFtSxlIMNHvsnZt//7cwaT/6sPgP9ZInHaL6FT1HbesF2yqlJ7/36kEo+P?=
 =?us-ascii?Q?46xcj9xucQHR7ZWRdEVsh86SFBPrIIHjuIeQZl+uBIep1GRYhTF4vptOI16J?=
 =?us-ascii?Q?lfng9WJfpUOAMNm1zrPlst8u2Xov7vQWixSqrljV5QJB99bS+nCalfJjs/mo?=
 =?us-ascii?Q?2dDM9hsAYPXphZfCg/EuqzJQN8csl0IDGNpwgaZmvePgkUPeedV4DDZp/2FL?=
 =?us-ascii?Q?njwuGbitme1W+9IKurHbRgUDIBvAAJ/cWVaU1wa01H6q4mc05SA9zdgiH6aJ?=
 =?us-ascii?Q?AmIPm6uEtFyYxu3TKYqIR9rtPHsv6VS88GHvvbsrQ9pH1KW+pURsXeyy6hGz?=
 =?us-ascii?Q?RNEvCEBsu5EKInHiCobkJTaQ3tLPy4ssFfgD+ZxCm3+kyydqHIjZR19hK1/r?=
 =?us-ascii?Q?CvnARFt/WLQh5hDlr0jp+Zz6dJ7/kNZjSrztEgW4dIdT5vmKGQioSR6RTfOH?=
 =?us-ascii?Q?StEeZbUIZro/eEw58NoIUcsmcKuqJBr4OQfZv2M6h9pBSN9IOTT27Kh8R8oI?=
 =?us-ascii?Q?n7wN2rp1C7un509TUMl72uBb5uey0Yh5NWfI8201Tmxuo9ZMMkV+6Z1SQMDr?=
 =?us-ascii?Q?tB+doyoyATa4culgrX4sKvI5qn6c92pmEVdDLHEAgU2/GUG/nxSoZe4Ki6Wc?=
 =?us-ascii?Q?UuA4a8LVYFcBGVnSGxr1XYyY/vfvwjWJQMk3Cq6WxicA+StFGktgVAGMxMxR?=
 =?us-ascii?Q?uqMW2NloTMtfVNoa3ufWaSRQNqalCNzFh2fLiX8EfcDAAPAfNmz2xF4qgEMV?=
 =?us-ascii?Q?Ur7vj2w2OYJhKNHiyXMtWYVzJ1yrKRbWvbAcYxTYl6yWYnT//C80qflxNwAl?=
 =?us-ascii?Q?f8NafTYNItIiDnyk9K2E7s8qPqdnU7B2nvTEnaaY9iZaZzpousYtSC98hnOe?=
 =?us-ascii?Q?RJgfjD/5UQAQ2XFoi7NeYdgqX+zHI7Wu43II7NMym4g+lqu8LMnmOnk14zS3?=
 =?us-ascii?Q?46Z8P8ZDOS/dJ8jUEpwDGJIuDmgCa2nekv0OvOFHKlC2217zDbPo1Uk6AT27?=
 =?us-ascii?Q?gwo7xeu6mKWMuOK/Z4zm3Artq5WQc9dNyHh2mGQGaGeGhoZ1uhEashWLw8K7?=
 =?us-ascii?Q?/pqKK0cbcj3ehszwhWpV/YoLDtraLH0sEzG4ZwJd5DjoJapwTnIqyfj6xYqP?=
 =?us-ascii?Q?I/KRRpTuT7z1LwjBI8m1jk0KcOyr2azYK0ZldeE9LQjJMy3KXVao8M+iYCrf?=
 =?us-ascii?Q?cSFvVZAwi1ATsYPAIA0Rs2HLXuthQDJ+ZBZPpvBzSPEouw/ZpK8LeX7J66KG?=
 =?us-ascii?Q?OVy+DukYpoyX49PQEMfCiMirBQ4fyfSACCVBhqKAyDxkJMOFqegrEbYynZNe?=
 =?us-ascii?Q?a99dNhE0qo+aI6mE5Cloy/n8kHLfo9snqRzmR+42VRvqst5w7cNJCG7PpfZ2?=
 =?us-ascii?Q?bnKbAIrnnkw3iVaDlHDwsW379SjmYWvDNj5cU0q8AdwkT3SaZr8r1kCCv1dz?=
 =?us-ascii?Q?Q1bA9WYr/bgvYaqex5kCdO0=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 65799033-7974-41de-a507-08dda9bf296b
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:41:05.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY+hltj1j5wLnUHwZDnEgfxMxLrWSKiHG6cly2z0DMikTbiS3P0buz/tF8r2OYeH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPF1D699E748
Received-SPF: pass client-ip=2a01:111:f403:c20c::4;
 envelope-from=tan@siewert.io;
 helo=FR4P281CU032.outbound.protection.outlook.com
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
both need to be unlocked. Each must be unlocked individually, but
locking one will lock both.

This commit updates the SCU write logic to reject writes unless both
protection key registers are unlocked, matching the behaviour of
real hardware.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
V2:
  - Fix protection key register check to be an OR instead of AND
  - Add missing return if SCU is locked (like for AST2500)

 hw/misc/aspeed_scu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 4930e00fed..4dcfe8f7b4 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -91,6 +91,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_PROT_KEY2         TO_REG(0x10)
 #define AST2600_SILICON_REV       TO_REG(0x04)
 #define AST2600_SILICON_REV2      TO_REG(0x14)
 #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
@@ -722,6 +723,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    bool unlocked = s->regs[AST2600_PROT_KEY] && s->regs[AST2600_PROT_KEY2];
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -730,15 +732,27 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+    if ((reg != AST2600_PROT_KEY || reg != AST2600_PROT_KEY2) && !unlocked) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+        return;
     }
 
     trace_aspeed_scu_write(offset, size, data);
 
     switch (reg) {
     case AST2600_PROT_KEY:
-        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+    case AST2600_PROT_KEY2:
+        /*
+         * Writing a value other than the protection key will lock
+         * both protection registers, but unlocking must be done
+         * to each protection register individually.
+         */
+        if (data != ASPEED_SCU_PROT_KEY) {
+            s->regs[AST2600_PROT_KEY] = 0;
+            s->regs[AST2600_PROT_KEY2] = 0;
+        } else {
+            s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        }
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
-- 
2.49.0


