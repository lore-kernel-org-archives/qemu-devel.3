Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A826C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkGa-0006ds-DF; Mon, 11 Mar 2024 14:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFG-0005cg-7p; Mon, 11 Mar 2024 14:19:31 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFE-0006si-KY; Mon, 11 Mar 2024 14:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNGvlAz5J5wxCpZTReWyXFBqtVFj8VHLt/5U56A211wdZQdFnb3v6LjhDj6PcZbn0ZC3o0wKH6/U6YhxJ0aIMAcZu4SaIfio5oKstFA3Hf1y4OYw/xjDUEkQY/w2zxpZUIBzl5ad912zlkINSP0jHC5MNEaZd8vlbTtSHwKsx/BfwRWda+xA/KCvMvULwF54+mE6QZ4IByhxyv72mQ6McZE343zFNUmv0eW5kAFjO9ybxW5wuTx3nGIRfeLzM4Rb4YiFYox/CUTLxrVPE8A/sJn5rUp17n7uEQqpl1z+B3IxQlgq+v32m3Tf6IK2i07Rb53Q2JVQdtHA1iB1VuEbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eAza9MO1e1QyqNnJJilYnpzqErg1iPU/3qJ+wO6rBo=;
 b=YHaRakI28HX2Vb8EO2quKpE/4Ww/0gwTZm6c0S0nEL/e4rkRNj+J8SCgAv3vspB4gXncQVVcNYZj3OF47iME3VA2x7FOiDk6NzES0xv0Cm4idAYgT0D8wZphSaEHKRTp2asv7wg8jAspgdEK55WDKONXYxbcgfc8z8sRkLy88STuOemqq5W99yGkx7Kd4kivBMgkvk9u40j5tNdqG7PirRWTD1yUDfrZp4WI2zpzmNC1ZAg0WPjuTjXX1yMA1aI0LQyIPpKwxfouFRnGRlY8fdemtbXZfGZNWeEzfg2yq2UhBy6Hq7qd/Cz0U/j+alozeQJc8ZjjeY1ifsIka3jGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eAza9MO1e1QyqNnJJilYnpzqErg1iPU/3qJ+wO6rBo=;
 b=QYWFfOm8phbKi3Fjdi8HaIEyhfoV971B0Pf0IEWG/kQSeXPBgAIb21c5wP4bIndF2YZZoBkdrQVP8KEoTy695KXQ66ny1y3O8DK1ofn5ndWS1f1/+K0npy4GYD/GTU7lunehrZMbeS79Wce9tdoKuBjMUns1ViQfSY1BWbMmPiwFjiHrRvw7SvlPpm85UV1wU2rAUcOf33+H2xr2f0lLKdCMcOKvDBAcsBJVd2/t+eRDNXcwt8hEvEnkGeKpzWQnXepTscClUmzo/BsMI8Q+IjXjB1ZEneTeIjBAJIKA+vs+b76FM6oEgp0RITVuUZ9LdKAfEsI51ND1EUQL6JztQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:03 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 08/22] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Mon, 11 Mar 2024 19:18:36 +0100
Message-Id: <20240311181850.73013-9-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 01063d92-8bb8-46fe-a135-08dc41f7bae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRkvDqkVg3x81MO+a813zajKAY5isZCD6/ubKaxmBGkYbxKJtsj86ocWGbpU3G0PiPCPY7DfA+U/6jEyLHdi86erKAFTPj4qpiE3LRPHqisslsIUlFF8l/dmG+VT7M/X+Os7dg4XBV+AX0rNj/hqskGkHcNW/yYBMSQZqund1atoVE7b+t4UKRmOvsq0mCq3Zo6WR0vhh+iVVPBzN5e8MnC7AmmKVJ6N66ezoCwvgyubUv66yLicwiOts4ixLvffk+3hIE4sMvEPF99rxrDWwuEoiTczpYMlG42nw6j+QaKAf0VdzwAaHWI78T0aVZp409gGsxfo30Bnl2NypPerSqc8k9ewWd5Lf4XqOq5vStn2Ka1OBkydndWk+kz7eMxiHdOk7oXPudHxI4le/bkDf3gXm7ztYn5apbkk84pAEXJ9X+U0kSH5ETBJjXrGqkfTNmMfRqinJnGE8DoZpH/PoTrbeDjJHWKlLWGJS0A3WkKXd+CbSCCQBSu7x0CT6aFGEyP+5lu927e1I8XarNcTgqWN1blTUuQlgEE/VfFYYj+0kNeJcH7OS2sACBmCbI02vrxGicnH2k+A3LhE0pjbufoL9/8PZXD7rBbhqILhQRDqaJlgafurGvugT6MtvlHOxrPj8uqJjIvJLEtxk00dXnWusVAEBm2OokcUcJMHLu25eSUoQkrhG+NtvFzTl11cuPXRmETv4SvLm0h22+Ebrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iUhZi+FjhOUKc9gJZhrDxME/a10URtOA1pCM99PIGJLb7XaNuFoWzV/w6uze?=
 =?us-ascii?Q?LpF5kIojfmAStN6L7q4XK6sOKdd9SQNRk9ucwBj6tbs186RHNGmrSgnb1vUN?=
 =?us-ascii?Q?KkcRnJ8SGTEpS0rEeaR6HTwpTGrc+9WFM71HLPKT3Qe+6ccFk8geqVMdei89?=
 =?us-ascii?Q?D1XlMMYNed6IxJdi9kUpO1Hr+RXrzVki7YO48vxJtYW101an+oXvNe2o3g9u?=
 =?us-ascii?Q?HteSSkK41WTEGHSSvTiq8yZCxvlVvl+a0nIZKLD4VitOrbS2VF3LEGw4Kx1V?=
 =?us-ascii?Q?Um+Qleng/2igXPpa22zeCoNINCqEAE7Li8ZXas1er6H+593wJ32V0R5qkEqx?=
 =?us-ascii?Q?CozZRlXGXFSzz33+kCVREaHfasaiiPwhzLVfn4LFIY7BLl1aO1/KzxTAJmzt?=
 =?us-ascii?Q?cBYUNf10F8Jw+C/+JnQ4uwn0H8WZo8qVTD3e8tTUJjczAinOQgyG2b84uA1a?=
 =?us-ascii?Q?uTUtMnnsvzyG9ZCFaIZEvnKQOP6XKvxKjvE0NMFBiErMmUTFVQgUrJEFQX5i?=
 =?us-ascii?Q?u3wdNGR1zY1/6rRqbdlYsrp8YThr3mkd0bABZ6fFB8nH1gkIi+C3NDXSFPF8?=
 =?us-ascii?Q?IDLMXdSY4FaLoSkhp/3QWz91/Lk3BZEh+Dmipsnvk7+C8+RQ968mY7mmPsRt?=
 =?us-ascii?Q?4F8EC2sll+5dw54EFY5inSzvdP+coOtdvkxxCdDRNY2oUkR+37VzfiGLjqd4?=
 =?us-ascii?Q?0AiKCT/7NI3sMAMrBVReG4Vc0xFrWGQ635FdsQTG9gIJEf0K6Ur9W0x9Y/hD?=
 =?us-ascii?Q?gfSNzdJNZgqtM3pQ0CDcFQPXaayRdpBGQuL3yUyG1aEz4RztNBmQWYhlzErR?=
 =?us-ascii?Q?+iZFCaj/lDvgOyRtn12Yu7z8+grVbPW+iY+oS9WYZ5VlGfH9LPorWo931Ac+?=
 =?us-ascii?Q?WSmTTWWdLl+KMXC7QRLw8BDlUed7bOwscURg5d9HTLRVxXUvCeazBvokSzb+?=
 =?us-ascii?Q?QuVUPzoE9XlluWvTyhQKsfcwGWoWV8JdtM6rGFgrI0j32uLANpFyMFVtP1Ic?=
 =?us-ascii?Q?os6sQSH2vpLUJ6Sg/NkCDzQhqPINul/yE3ggFJPKnuI9mD/vnJtL2V23J0EJ?=
 =?us-ascii?Q?RnxghP9Z3o3KS7S/0x/az4Kj75sI2x05CKAhKWpFvPVtLs2UBFqWefNJJ5Bf?=
 =?us-ascii?Q?q2quDIuo9SeUmWAuoYoWwojha3G4mP+IAiTWqpPEnfht+pM531jm/NFWmY74?=
 =?us-ascii?Q?7Ob8X4XHaG/qzjW+WV9K0/zaATc9ttkO2E31FmsCQxeDwvUPpm0YojmXs4Q7?=
 =?us-ascii?Q?ucJ6FZQb2UmznNUpHcPZvzujrRe/sp+1VSGHOf30SNgf8sv9VoLMF0WoijG5?=
 =?us-ascii?Q?3lfH5hH54+rvyQTdHSGM8ITqG4T+XbSygdwULNEtfaCDfyNiNqAU+x6zXPDY?=
 =?us-ascii?Q?QtV6lSR7BHfA19I2B2R6Tmwk5ynDK4Rzrpr6a2jMMp3WM4E9y0h/FMbHn+SY?=
 =?us-ascii?Q?/3ocGtMAHPuRBs7329IZ4BKCFlc268s3ncsULAR5xHdTSlQP2OD8hm9IxtrB?=
 =?us-ascii?Q?oM6RW3yYvpfcL0mpa2cI1BXJ2kb6yc2vfGUirwyYaTHaDHQlwjNQNlUs0+iV?=
 =?us-ascii?Q?RseqijwdQl5LTHtJkXYwtZZrelEw1iRzNXUiNbaqNwcOp1KPZAgLRcJdaunM?=
 =?us-ascii?Q?pi523W3fD4GFSpXf5NBiSvo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01063d92-8bb8-46fe-a135-08dc41f7bae8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:02.9647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aoffg8F7YtqXassDI1ovlmuzZ7IqymKsGzvFenPeLBw1Dx3erxPdtXkqfNt09gExTc1Ne1iknXGSK0XcS9JUhAz3w/31W7f2kZ9NA2/PPwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5653
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index e7c3763017..9056dd6a11 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -812,6 +812,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


