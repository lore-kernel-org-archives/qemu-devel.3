Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C10C5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsvU-0001O2-Pc; Sat, 24 Feb 2024 09:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1rdrgA-0002wY-6d; Sat, 24 Feb 2024 08:02:58 -0500
Received: from mail-sh0chn02on20711.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::711]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1rdrg8-0001VP-1w; Sat, 24 Feb 2024 08:02:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf6WtkmWpu9Ohem9XfTM1NhO/5Q5wz9OxY0rVk39prpNyXcSAx3ZjI8OoJIZo55KLGs8Z3/ttXjV/t65MiEiynnO5m2Mn3eadu3YYwMloDpSib6XfKCXyV/VUEQFtri4rkDFs6Jy0v13chGthxHpET32VFQQZFk5BcGIu14GE9F/TQJcaGhHGm7rObayoSm3HUIYz4+0IM/EOOuTZKaG0a5nJMrLutI5uugbqDDkWWHGOvcgFY1ZTw+5Nv2ttFlLTzm+ZH/LcWbdEyK/p1hSdAvYC2ZlRV22Epts+VydAg9vnOdAPV6LoxS2VcCFXac1yKdTJjCPByObSTGLoatd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWauh5qbR7+5H40NhmX90nMlGZMSJkHhCWDRtBrFsaQ=;
 b=HmKx9NkTm5qU2oKyXhcwSYVCD4VA3KXWIkm6oi6B6KUDetvFztwDU/PKBhSEm0IqQPqZP7DVd9I1V2nYjp4uuw+y8pxOGeuegZijvzinG5YNbWz2+q9q5nmyMlWO2NskY55W9PLZX/4gO+RmeDngtIXIF9z+BUHTztXYQPAo0mffWRACOySf3ArOKS4nB4U9zMmjdHo8IguH9vpFJRjYup+aoAOjcpZZ0cR4UDJ0Ra7Fg7ZQC9VwDzs5Dfni3qf70mZ5m4yk/452x9S2/vAd+9V8ZzEMInAAOeNfbkj4YsoYAyE/RZmBma2O6xpo/k85wMOastadBmag03FV6dR1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1319.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Sat, 24 Feb
 2024 13:02:43 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::21d1:48e1:7ca0:1d76]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::21d1:48e1:7ca0:1d76%4])
 with mapi id 15.20.7270.047; Sat, 24 Feb 2024 13:02:43 +0000
From: "demin.han" <demin.han@starfivetech.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Subject: [PATCH] target/riscv: Fix shift count overflow
Date: Sat, 24 Feb 2024 21:02:35 +0800
Message-ID: <20240224130235.340584-1-demin.han@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::20) To ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1319:EE_
X-MS-Office365-Filtering-Correlation-Id: 13792232-4dff-4275-0093-08dc3538e393
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFhmKHqpxBsnSEWqt/oPJwIL9231b+dYKGSlcneo0aiOM/qAYeTBVyfV+jOk6gAtY3Wbi+TuPzsvPDxJizaL2YFRawz3+aetCi8ShelRsfWKNF5JSv1uvyFKyNrx0ersQHm0q1qhEekkDzsaZWjwztf+rt+BsafUupao50k0h1JLLPAmsalb06dH21tdRkggckp34H02mNgC8ymbf7toq2X5VA+5Rf7kTt+Afa0yr7y/3rbpmasjlP9ZBXdESPpf2B34EXOqt/OaFrzRjyFbTrOQDQR+DG2eh+ITxLQalA9c3oNqagv7uQcF2RjHvzx1XIjAWRugVYCTbtz2el0C+SdmCBDTJrW7IJkoFK3hPWahoL+3yadE+Wvkkh8AyyE7vEc9ylNodvj7H3/XePkbPDRqf/IOjxp/e1MZiLBKLAbvTKfTZ9pIk87SzEkh6RtPN2JoQJP+Y6xqbCoQzqx8xodA/qCROerPZUA+ee1AztrxxN9yngPHSenZm4kqt8wT9osXHHE7QMllzHU8Aiqih3zCPY206O6n9bYcN2qJ6+lU70VwLaHFiQZqS6+goVYN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQL57qfIPNp7kp+8wfsKIlPlkJI0zn5jRWKvX+yS+VhZM1q5EBrub5Rhdkm4?=
 =?us-ascii?Q?Me8rJINI2wr3//vvgg5qRMAkEYSKOUkxuX0B9UDpLskoRZ/hRJFt6X7JGEnw?=
 =?us-ascii?Q?qEiQ2otn5Yyy5kxHytIOf4TC/o2F6wm23wDQJl2TRFI5dN0kk67FRNNX7GxN?=
 =?us-ascii?Q?xzkCjDcpiMlovHRJE6fy/0xE78Hwitb42lbpfZn+MISreEcFXwT8/2PovVgf?=
 =?us-ascii?Q?TPE/1BkFZS/Fb9924u3UvjmXwVVtLPV5jeMYCI07HwafXHGBAHJRufRUIpi/?=
 =?us-ascii?Q?r1QdBgfhR3lYJtkIT6mta/n1Ab8R+ZczR/oOHnYFl9JBAVuKIKY35ZSdaLBY?=
 =?us-ascii?Q?r8arSYUjR/SQPciUMmaFus8aykCCW3l7BCy6atx8GJLKVzUiE8Z5SNhOQxT+?=
 =?us-ascii?Q?FaJqJSIwWKuqNBRu/Spbtr/rBrNErj0M8wtyQK1+nMrLsaxUhQ/HXp6kVHz0?=
 =?us-ascii?Q?RJyC7rLctpmzFFG4K2i8dGOgsnNAdeXhZNTcKXBFHgsS0npbc+KujSYTVArY?=
 =?us-ascii?Q?l047dIBbuoOd+SFmaY80SaB70wXgZFnjR+T9Cdm6neVneKWTs5j9JfDrEp28?=
 =?us-ascii?Q?oQSRZZ82t9xdCoVhuvLvKLtAXojADfr8aIW6qP2xXs22sh3zANMc93qW1iTN?=
 =?us-ascii?Q?OJ9cNCtvs9SswMzf4h3+sYyL8kuPjJf3WJOUuNCgkJ6fSlb2YmwJsqqV6ISd?=
 =?us-ascii?Q?FJOo4NUwb4j6UP910OOXDTqwHDtgES1q8T7uey1bRYlLPQD8lUs5STqIZYtP?=
 =?us-ascii?Q?W5kUUfGq4QXPfWbW9TI63sH9iRwJc1jL5MUPqLwGCehmhJ5bBpikU10TUAwf?=
 =?us-ascii?Q?DLv53KBzAOK1aKhLJfEqbhXafWjiOAUpA5XQS4ps28BJZrkuNUq3rlIV3D1k?=
 =?us-ascii?Q?vAdi0MFYk4C7S6L/J49HSg/CNicbd7m3rYPoy6CGUZ/+wm9IxejmHsX8AhgC?=
 =?us-ascii?Q?LRKmooVVvJL/FxezTWJSTEG14zNUP3JT1YIZWkx5DdDkQwJFoFWMd+YQfg9/?=
 =?us-ascii?Q?7lOAVLtvAyD8mWUYcdO/m9RhXfXdS9J61iMn4/M7m/regdRu/KzzqFOthaX+?=
 =?us-ascii?Q?+OmzA6sFV4QVopZWVPRe/YN2yl45hnDlaAESd3BU724CuBkUnEkZO1wsH0h4?=
 =?us-ascii?Q?KbXJDi8WuxPkQha5jUA7VCeiqB41uS4bG4q0YhIFu1I0JHe32DU2Hyy4wwU6?=
 =?us-ascii?Q?jQXVL3KCr5tgLjQGkYIXb8huRTQk2C+v4yGbx0gcYwpC1VFMEJTmoK2n/WHZ?=
 =?us-ascii?Q?p5+DLwiQeUdKY96kdxM1Oxp6deF3g/ThDKEVkEpemSbldUqOLkXlE/NsD3qu?=
 =?us-ascii?Q?IDqiygZwJBcaxf2fbp+XU0tE8MQWNeqRpUbbDD8yOaJQ8nAVKBeZFfAzdLYd?=
 =?us-ascii?Q?UXqU6enAm84fWnw9jZ6KQh36TEyTCb0CI60bKaxbxd7MAjRUtdWihd0yFMEY?=
 =?us-ascii?Q?O/A08xDU/3o4oZu91xm14HgEFwYp0Zk49KGcyCB9bTudbRhwBmbrE0gHauvF?=
 =?us-ascii?Q?40cfHMPxQIZkD2U2q9spa8JwBX2+KAYfIOYmloqY5mSExeUwLMzBgYDKPkl8?=
 =?us-ascii?Q?S31dXZ50Z6QMEEc9EbZqNmpkqXRXUzvu7pZw09sHrlDC5a5qRcVAwivKVjP1?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13792232-4dff-4275-0093-08dc3538e393
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 13:02:43.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6EI5SbmX0bAdmoduyoME5NqCdijP0s8SQogQr2QTPmLuXhCOjhDuQPp1MCKvyRw71Mb927bqC4VceghIpG3TWXii1+cSou4sQ7j+LTmXGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1319
Received-SPF: pass client-ip=2406:e500:4420:2::711;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Feb 2024 09:22:42 -0500
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
 target/riscv/vector_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..ced0aca633 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -53,10 +53,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * VLEN * LMUL >= SEW
          * VLEN >> (8 - lmul) >= sew
          * (vlenb << 3) >> (8 - lmul) >= sew
-         * vlenb >> (8 - 3 - lmul) >= sew
          */
         if (vlmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
+            (cpu->cfg.vlenb << 3) >> (8 - vlmul) < sew) {
             vill = true;
         }
     }
-- 
2.43.2


