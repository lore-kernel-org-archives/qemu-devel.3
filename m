Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BE1C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 03:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re5B0-0003zd-8k; Sat, 24 Feb 2024 22:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1re5Ax-0003wY-8w; Sat, 24 Feb 2024 22:27:39 -0500
Received: from mail-bjschn02on20702.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::702]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1re5Av-0004FI-9r; Sat, 24 Feb 2024 22:27:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcBz0lmajLKuZ/vnRSdNc3Xc5zkZESU5ksqpczgRYNnA/lwt+8o83E4rfnOZ06PF4xLoJ3NgO9vzevEg8+dJ5RYJNvkdgFfVpAhgURf0WUHQQhMAzMxcP2ovDB1UgqfUmS4zv2zIwl4Ykrs0z9uWxYU3IURhS2ymoLdQfxnzcJSHCmvZ2mvEYyN3L1oSZf8jHNUIOUi+PFPMFI9IsgbkH9qNKIw0h0kTL3pB5yOQxH22TwTBU49FDtrv9F06iE1tK3F/I86O4TFKx0jf1Sm6GMwsNfiiVdsutUSbpQNmuAr2v5qampn9KYtOskoFbHr9y9wCqxp7eddXaLcdMSXRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCq/SaJx9rwv02rTBjaDaid+fZwXOboVxfB3x/YTO/k=;
 b=HDZjJk6jD2D9olwj+RTT4Z+9NTptWkK8LRgsrYoyW+i3iuq2PdkTiQOG1iP7bBUrtz23K00PlQLRRsRQyApM8gWaH0BT1EmdkOprMazfemDWc/HNJtKVCsr6GAj1p83J/icW00/VD2i2bFp2l2ui6PPeez9TfTH+OyLlXQkBqe/qHZEasWP3+53x2fWEHPt4Vhl3/USgXIkoVluGvzaDUDfkY8YiMz/RJ5G+f3c396FQYMsEvJrfCMQP+D4aqVmRfrVVYMsQjhiJCAUi3o3HdMgMpEhJfShy/q+VMeMcv5XQLEvGwmYabZ9sVJUGAz/cPsFwHl/5W3oLIkMN5uzJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1240.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Sun, 25 Feb
 2024 03:27:27 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::21d1:48e1:7ca0:1d76]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::21d1:48e1:7ca0:1d76%4])
 with mapi id 15.20.7270.047; Sun, 25 Feb 2024 03:27:27 +0000
From: "demin.han" <demin.han@starfivetech.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Subject: [PATCH v2] target/riscv: Fix shift count overflow
Date: Sun, 25 Feb 2024 11:27:20 +0800
Message-ID: <20240225032720.375078-1-demin.han@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::12) To ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1240:EE_
X-MS-Office365-Filtering-Correlation-Id: 340fdad4-9c72-4fd5-f76c-08dc35b1b0ee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsFeJrGiYspGsgdF19cpilYKUdhsUZHJM+1OFa/S+kFSPGkTHiR2y5lAqivKp/+bLSFu2DWKFBouZLL9MNfjAd8IkyfCbIGqGXIUkXRDdASjVUMWwKMDwxZEdVAl4GQq2p8RbIqRh5EdX7YH3HorgovCPiL3HpE2/0ykRkT2JzvY+7r6yUWyMLdT2h4y4iGKEF6aeC9lBY+khUYiOIBzjFwmC5wxkeBLhpMjUBcRDeCAqNDOocJQLadRjorWOpbgP/EextymxV+lcXStiLHde+KhzON8FeEAsiCNqdNzciug/5Yi3cWpiZBlh+BtVvzJNa3y0tARd1jNl+g6IV+lRPYHC5b14zbbXdeeBs6xFubA+H2vaZeLjVBv3uxowY7uKsHVxv2LX8WE1GmXdFSX0wbnEE8dB0DWhUZm5AGPK/7tWQbAFzkhBKCZZm87ehNB9bc+Eb7iHniiufpGfsDR6Pore8oS1nKejft+zCBxi5Ovlg/ULgYnfWeB0FU5VxTLYCIL/yZ3j4AkuzD+u3qkEJBbmI7hHu0TI5JSxU/aBipDzKHqaqiikL6dc2WngpyC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rkRJxOt5R6d/OFPFLulYE7jIknNPMnWkoc6N1d8jrghzsCLWmTg8meniUtcY?=
 =?us-ascii?Q?PstzLE3zsTFVoKMCgceyyW9FZRh9Q9usMQrn9EWCK6zVajxFGIi3oSJc7pbq?=
 =?us-ascii?Q?cUiqGdHpQytNj75vj+zMoKCFmnrK05YI5OOG5BLjIWrTm4nHY2M2cjFYbZEs?=
 =?us-ascii?Q?v3GzWUWHk5AV7A7yJ4tZ5MjuGJBoyEtdppyaZAtLz5TxCl/STvdbuv4znQzh?=
 =?us-ascii?Q?Pc+YNf/F+AFBB3v4U9vEPyI/+OtvWW1R0l5dJu8g1hDFNUoLl+lmXImmYRLS?=
 =?us-ascii?Q?uy28qDN4+fUc8Y+Q19A7lT9HIa3UaH2jqwTUnaiRNpp5v4Ci7ngnWV1UU3kc?=
 =?us-ascii?Q?XGgUaai28fCtZnIqGiqv0aKbTOH+PQ0ew/5TuN1gyMiWQ9/0UFQy3/GhjFci?=
 =?us-ascii?Q?Q8dOSrzCEicUzZjke5+1YbaATSYnRlzryZ91hYMieVu+AqcbHz0OETLJ8gRH?=
 =?us-ascii?Q?WgaakibCwbcAnRPAuBGtyNAeWIpl98S51AZ9t1jLEBGpwKI+3GUlxz+F0x+5?=
 =?us-ascii?Q?BfoAygtWkTDsgT0wFV/8Ih8t3+fBvY7AOU6lmI7x3F5Iwe3cj6dti0V1cK0a?=
 =?us-ascii?Q?uEzZZ7DzA2y99tYPk69a93/jYbm6dFPCYFn1W/Os3cyafE9Fgw6xWw5dpEey?=
 =?us-ascii?Q?q3yrFi7mRkfv3tqxx67u8nvoVtXoE4p+ptzQHvB3yYZSyN3ZPpmkZI51fDuo?=
 =?us-ascii?Q?9fmdwd8J0hHTmIYtM5kR6Gku0u63Vq0rF3euIZIr6iOfeURhlP83noMORhSp?=
 =?us-ascii?Q?PA9g2JhFtQ+vGZUhrKlwATHeaUtPES+E/UT4CBhGxcHDxUbxZaCyWCPphIKG?=
 =?us-ascii?Q?qGLd8haD9wtYZY6Fh8Hh0GpHhX3yp4qKVLDCi8EUWCK3lkWsGcryNmuBio8m?=
 =?us-ascii?Q?5VaizC1KbhxqriowjktC9smW3ovVkPIYmY19u9ao1L+NmWNmAA3xmHSmL4WI?=
 =?us-ascii?Q?2Etq+1x9CKSHPVs4cjbjTC7L5cFwF36JyjmMKNDp3t3RheudWDJIG/5emnvF?=
 =?us-ascii?Q?3r3JpHoaiF3NOk3qJ9pyYHI8JRu4TG4mJ7cMMb969vGAAqUhxpGH8OI9feJI?=
 =?us-ascii?Q?AdiPnB2u19aSEzyP2nJQWkheWVfQbgkQDXZuTINgQDp5M2XS2MPRL1nyIFOk?=
 =?us-ascii?Q?qIwp9uOF6+y6x6fMCUWqjBAGzQd1qS4wR+nNW+mAhqGMrQKjYV15+DuQTZ10?=
 =?us-ascii?Q?1fu8U1T05YxPQZYkSvVY809iYylGhN6/nnqVh37fUKpUMDCSLMzTV1gcCh7r?=
 =?us-ascii?Q?y+UTU5fkU/QPVJu/CRDIUghIOwKur+YqZpTVo5AI3uU0YewbsKMXzcuiUkuj?=
 =?us-ascii?Q?XazlBaM0vK6IT74SLxfyBDNzr12lDegmT/JOh91FWcz55YcAWZwC30pBKUVH?=
 =?us-ascii?Q?GaDgu6YDi2O4kGcAXx96nhH3aKu535bzFWss8emKM5TTQWAD2gqmdUdnRJzM?=
 =?us-ascii?Q?1Ryx7PJMy8KIDRfu8LFnCl1qecQ3DzxX8o9SNZtHlB5HpoJOjDuDRcgjhHLl?=
 =?us-ascii?Q?QigWlhQOEpQkA+1q2ueXZfD8B4VPbS18BZRYYjhXJho8FGMiLCUrm3S9x7tt?=
 =?us-ascii?Q?sjLhEpysZKCGqTsTdCbWWX330QKD8I6g61hCdrFpSy55PMIPgSDWWRA6OZ6v?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340fdad4-9c72-4fd5-f76c-08dc35b1b0ee
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 03:27:27.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw8QtvKyEGuCs9fn1/SeNdpkYPSFy6ncFr7sut45VgomrQ2WCzjGUr5UAJ0hR0KeSqKB/bc2jc3OdI+CcdR8xASc5UPwQI1p5sgi6smwPqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1240
Received-SPF: pass client-ip=2406:e500:4440:2::702;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The result of (8 - 3 - vlmul) is negtive when vlmul >= 6,
and results in wrong vill.

Signed-off-by: demin.han <demin.han@starfivetech.com>
---
 target/riscv/vector_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..fe56c007d5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
@@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * VLEN * LMUL >= SEW
          * VLEN >> (8 - lmul) >= sew
          * (vlenb << 3) >> (8 - lmul) >= sew
-         * vlenb >> (8 - 3 - lmul) >= sew
          */
-        if (vlmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
+        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.43.2


