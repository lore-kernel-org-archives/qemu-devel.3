Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E320C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reIVV-0003Xp-UO; Sun, 25 Feb 2024 12:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1reIVU-0003Xe-AH; Sun, 25 Feb 2024 12:41:44 -0500
Received: from mail-bjschn02on20721.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::721]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1reIVR-0007vW-Lx; Sun, 25 Feb 2024 12:41:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9964d3OXOiLk/5QVq+wN0sZF8mcZiR9aIjRH9fdGBHayckf3zCbaraqjRSdFnn2YGeHoBwiXx5C2GLj8otvpp/rI6Z+AGaS59BXMMSd89iPQJnfNOvdIz0xUVeUcHdJS/r6nb/aHF7BgZJzi8aaYn5SBjLFhlJQqxLq9ikiqT7GuipBGw4pZUQVX3xL2SrBh2JCgkYpGx0a1YjOyBPEUw6MOfc74h6GF05SdOElsPM74DBXFWN2NCj1t8+BRn/M54UvUwsOzKOiC36+KhG49DNe9wscmuuOMY3eO9XNCM9zCs8EiOmTPDcGYxEu/Ne0QSKJmM93y6+rhkpa/shNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf3389rY33uXWIzVMnuwj0pGKqXqGuzNB8dBSizBsII=;
 b=BCDqZ7ADGMcUGbIOra3HWnvSaubsHKVnxk90hKquL1Dwjxg9tbcS+lq0bdu78mv14snIjwPtdRrqrOtR4n7bJG72O9M9AceMiJTWHhzZRq2AMslw6JvTT7awYCu0lfhKngAwEqp1r5YhVyZ7ei6e2ziDxNk//KtEabo+qHkPEg4ZSXLQ7XS6ZOefbRvuUiRpgyZg+MNneVn39jGQdsazgGgczRkIDgGq7RTbz7ybrbI7uGLtD2TWqoaZkmMcNE2NEnD1PWabcCkl0ES2s/FiPz2puH/u0ePgaazBvJo/XU4WRbeADcRsvxGee9o5fmEwAg/vi0jJIAwm2sa7D3Oifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1304.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Sun, 25 Feb
 2024 17:41:24 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::21d1:48e1:7ca0:1d76]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::21d1:48e1:7ca0:1d76%4])
 with mapi id 15.20.7270.047; Sun, 25 Feb 2024 17:41:24 +0000
From: "demin.han" <demin.han@starfivetech.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair.francis@wdc.com,
 philmd@linaro.org
Subject: [PATCH v3] target/riscv: Fix shift count overflow
Date: Mon, 26 Feb 2024 01:41:14 +0800
Message-ID: <20240225174114.5298-1-demin.han@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::36) To ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1304:EE_
X-MS-Office365-Filtering-Correlation-Id: 739d89d5-f71e-4e4f-26ad-08dc3628fc4f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y7mBQcHiLa5spDVfj0w2cMMvS4zIWSocXhZYTy/Wf70q4kaHuaIZDtK7mPKAMbS2T+dN1c/R9wqFyqPcGS9Y+pTrxtuO8kWpiY78FjkNausthcLwoa+A5Oi2sTI+QvE9bS2vMgq3373UgyMaGSDNPaMnMs+ThCgX+lvlg3HTcg6EKECMlyjteqkrkiu54LXylRRLQb1SniBzgvA6Y7fcrsNnqeT0AYrI34VD56vBjYSQjPr8+CZYOYZMiYY/UiPjidu+v2SvL43o/Z0H9wdPjR7isEnsD5OUKXXqikYKbhpCKRqL63dyFApdpksyExmMqCD3Yx9J0bM7dzDOOfeI4TvDD/Y40cII2rjkvKvwSV6xgKNvN5qRpq6tYwQYTQtnuqJQLTDJMfbxfYUqWrJsZERMoU0nUpt+PAXczuw67a4Q8F+JsjsdmMm543ZBUsx6taGuBOgU7ZHV2PC5dCxbjXHWctA8H9kGKfbzAp0WMnvUCI2QTevxGM9vck8w9/mClA5a4Bf2ojCq0kCmgivXlDdjOr9hDKsmOKSoT8h/7Ga/5qU90psY7M7/TFXV+Ba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14Mc+5an48YemeIj1yVVnY76u7krYNYAXhQfQpM/fprwI4lSkXYHLuNoyXaB?=
 =?us-ascii?Q?hSTPpWfVgYp/k2ep3MGinTXQGyU5lm25TJOdbCGRCdhpGSrIXMqREiPCkZV7?=
 =?us-ascii?Q?7rnqkX53AbSzzAfaNRl8o1skN4aw3F8ahPTfxKNvaAv/hkhU1ptjiEu0M0cg?=
 =?us-ascii?Q?rzbc6qBeJ/Fk2OV+7YKI/6GxmFdqp/e9kXEk9hAQQEODmUDg/q2cYOuu7V0u?=
 =?us-ascii?Q?nwCZaGmo50z8DSbvqqLBLfmc7K8rSUdykh7c5sucKfN39/AqkhKiGoaJIjzx?=
 =?us-ascii?Q?mFp4sqw322zVi08TfJpM4OA1WHwoTia3ut723+HIYwvZ7EPoL40v3/klyt6X?=
 =?us-ascii?Q?pJ1tfckyWPfaLGk6vziixTRraiJMxaP37CBjPu/AHvvnh6RKJFUtKcxWBIGF?=
 =?us-ascii?Q?GIrUfSz1+FcmFsDH+gEMjqYvq+8/52GiLjRguRzybHhzTQCtvktxkniPnf3e?=
 =?us-ascii?Q?+2GEWVgsIxGE9YkBewNOsnaRCPQ1supgbwhjLmgf6NKee3GEsqSmnJ1mg8ny?=
 =?us-ascii?Q?8uKX05wd8f6lgIbV41cRBBs3NmnkHvOd10Y292IDJlR2to34QOTvPOdG5Acb?=
 =?us-ascii?Q?f178ujr/2UTC7uSedYLM7sNcWWnyuWebtxIls197/4tujlBl/NQx+bc6WPKh?=
 =?us-ascii?Q?Flec9nyJFnPu30C3ox7fSwh4LAHqxfBlN2C9TaipuU9T7uxMPP1vXyOagJyL?=
 =?us-ascii?Q?ph5tigrj4rQOD9vscBrv9/b64GG9rwzNDLmr8hjHXlQ2ZVVPMl5Jz91Kvq53?=
 =?us-ascii?Q?gDnxLH6C26oOjMbV/CAZgykQN+oa6p2l4OyYRnnCopG3KTmQp4btxTYzbNOW?=
 =?us-ascii?Q?ZvR5wmKAm7W88odN6L02caSO9bfaU3i2xF5Mhc/HVNx0IEDwRh6CmLKvLJt6?=
 =?us-ascii?Q?FwNQtyav7ssewLgQc0lWGZVzFo9cdfROsvymfhhBsg8BGoaOqHwJISvzWnkJ?=
 =?us-ascii?Q?dfowmTwoh/ogIbwwhY+nHUqdj8cSfyIAdWLj5uukCdFQU6Jp9zKs4rb4pnTb?=
 =?us-ascii?Q?8IGCJy4C8e93B+oczn0WuEXtlD+YtTWNHRwmNPE+TBrfi9caof8F4LPJhGTG?=
 =?us-ascii?Q?ci/mxXiPQ5xeCoyVkwWrIBJcq2sWphvaQBA4lLD9q2CyUWyyq5IzgCTeWo5M?=
 =?us-ascii?Q?ZGcoogYkhT+XQES71Tx5+gEmbt9HhJDj0oEb9u8Hz1JvNKQ7fLL8xeSyTjMe?=
 =?us-ascii?Q?A67sHHaikE9+I6uvxMvwqXhWKIMjpbRZJrQui4uwYWZCZiEQqWwKaWm0oVZM?=
 =?us-ascii?Q?LHeLuSckyX869Bbkn/+7p63o5UKAZRrxWnSoq0oz7RGegkDic6RWR6VOJ9ml?=
 =?us-ascii?Q?3gG9NYNndlitpkuD4xBJ2Hf9pAmOQo5MyKK/Sb4nXs8l2/ATosXQWdnwcKbT?=
 =?us-ascii?Q?U3eHDvnV5tdi5QPPAXcoisQRTicqF2aMWn9Wlw2qmNZ1LOrOmNDSvBbxadoK?=
 =?us-ascii?Q?RptHjqYPwEdv1k2Z6tEa/4nS0xmM75ScEsNxf/S2SSZuaRmmntZVSHSQyRVW?=
 =?us-ascii?Q?ZKpMXGsonJQNqX+Qbm8oM9dsBrlnsoHa1S5JGQM+haIuan8xPzLsyp4P8q8J?=
 =?us-ascii?Q?5N/imoyEWzJHfmLTdBQ3ZOfwkTiDkVjYHX8ctk46v8/IwzsxuB+tys6bqHAH?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739d89d5-f71e-4e4f-26ad-08dc3628fc4f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 17:41:24.1868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mtCpX1h16vQ8Gfnw8ZdtoCmP6V4m6XDg/+oiHw5XVVLOkmnyeK7V9UHTybBBGk5g+U9ewiO4Jnsi03Oj0ekHci3ZORJHADZRa/iJyJL6hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1304
Received-SPF: pass client-ip=2406:e500:4440:2::721;
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

The result of (8 - 3 - vlmul) is negative when vlmul >= 6,
and results in wrong vill.

Signed-off-by: demin.han <demin.han@starfivetech.com>
---
Changes in v2:
- Add vlen var

Changes in v3:
- Fix commit msg typo

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


