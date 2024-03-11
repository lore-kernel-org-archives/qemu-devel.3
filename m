Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB8DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFu-0005wF-6R; Mon, 11 Mar 2024 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFE-0005bU-Dk; Mon, 11 Mar 2024 14:19:29 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFB-0006sL-RJ; Mon, 11 Mar 2024 14:19:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIDmreTuIFf2SyLjQdxiwEJcqFeTrkPh11crpvC/8FzcrqU85nwQ2e4X9RBWWvzqAJRnp85IZ91iwcpUap/DoWtI/ZQENHAM4WNB1bfbMlsHs4MdJlGpOxICbTuqzikeMVWFrqEjm3/1TIO+TIu6/l6d8mVn6n5U2RYkvJw9kz3epGP2hPpC0P3USqact5f7snuwVwCUZKNfm9mDTaDnygLq9MU7p98roZojweG6n+yBTFjiDNM77SeXk5tvhqwbr33596Lf6Vw0OryaGjbk6vrepyDJT+zKelkgjGaYrqzMHT8GI6o/98GE+Ap9R+epb2sm0EEY/3SufUC+LSwadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8icE/+AbYk5Ib/T3ouUtIj2nyvt0i82WkVhv3DS96s=;
 b=NwMFKNsWeVwULMeSnf34YrJ2t0LNKO87HJpWphtqmwlemFZTzskGt+Fzq72VQThtOGBvA+JbtSh+QqBrhb3fOjh1ZdGWkaNb+EZgiP50mMK1VhU5s3UY4WobbZjtf0Q57JF13tgopVlZvSqczds8dRj+OTu/g+vx6HHcfkbZsxbB8f0aTo10Zb7TBvFU28OIzm31B6ZdYpn7Hhgm1YuDqFeBodVsRZgb/D80QpDooPc51/+OSdw2Mpb7SuVDC4fymU9LuaQi0HA6JDsI2JpQpCYuPEpgTzWwancMzLpy64jGMRUTir+55/0q+UTQ2GLu9TnpLvW1qQDiddhrTtGHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8icE/+AbYk5Ib/T3ouUtIj2nyvt0i82WkVhv3DS96s=;
 b=zhrWdIbFr6q0XB4Xnk0ZOVTDnr0UTJHa9AXS4wjuMO6oDQXQOXwDp5DQLwvEjIRFZ91EGktnXODmyV04CQDgO5agiunFcv7z3eJp8lszfKNw3R4czmZFejyWdZSjm+28FNNRGHvFyjAqDWi1/QXMOCj4HG1VKtx+mk7lhSza9xiCJYQnu4jA1JgFjI2oAewR/D+ax/ocs6i57WXh5uahzRDYAPW0YX4cLepItKCbkbPFWuiLvRHwtWYvbh+Ymw9vaOIvoGUGJsrKFUBHCs3bap8/tZ2j8Vp8PowOS613LnZQvS6c4+ZL+daYNx7msept8e7Nflgjq8tsbBpU3vxlfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:02 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 07/22] parallels: Set data_end value in
 parallels_check_leak()
Date: Mon, 11 Mar 2024 19:18:35 +0100
Message-Id: <20240311181850.73013-8-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab15ec7f-c71a-4600-7aab-08dc41f7ba77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Jm7Vy3hv8skWK5DbnuZM1J9uAsfB84BqH5RHep2tFwJfPAFQ9i80/01+nUhKSo5FQ7V9QQr3LMEsjoXWSvRPmKV9hgdB+k8gTpkRee4ZD3QZtfTp40vSHToHHFj/9PYKIzAq/EP3x/ng+1pgw0YkWhrJKl3mWwsN5j8x98Ga8IfAiGl0UcKcGMyfJtxUGzc4kbqnoIT19cw/ljOzUi76RaZ3c45xmsRGI3m5Al66L3hcKrtxO617kvvZRVe2XCVTjLhUV4/oMPDCysUXlYnWEH1DEcKgwRB3TRrkp9eHJTembhvjgiTK6i4mfqYzTm2wUqCNNfEQMKeQCqwSv6GwbLzw9HihorCFwE0MFE+nntaJaKr7xi1BgdiAvygpnsLp7LUNPo71akJ4+WIj/yDfPVx3YelQXQ8cNAsuHU1HuaVPHs6iMHB/yDM99oAShfJQpoE0Zd6SQnKutgozJa3NCmjk3p5qx9xwMQghk4wsLAw9X16nk/lHbIzVvNWiLPMyyV7gBqMNGnTz7mUENmYyPRSXJRoEtywlU3r32Lxy6VGwx5IyKLgxCUsqMhlO6eb+OiPaXDJwUo+qVd24HTEUZ62QhYqaBQLCgCf5uTNyOwknxk/Nk23+IeJZrq1AOVkGNaedU2kS9xbwG8mAZAJBlnIIyf9ZE+rY5BB5mK/wrsoxg5Z+ikWdAqbd+aTLVGEG8i9x/Pw7+JQDoZAvK7e/sB+s4v+0Xy6WlMJis7THzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFARIBvvnmjGjEr2kwLD0j3Yek4ekEuGZEdQ+tkBVvbnkR2Cl2jm8zG6abR/?=
 =?us-ascii?Q?pT2g4y4K0iiqXcQT0TN1OYR613LIxe3dEXMm3X7UeZGVcJnj3djk5fLeBtzX?=
 =?us-ascii?Q?P8ZxgIy37QvdB3cO/n3rBrctP2z+uggZUTZot0tPw0MUYBSHaTf83NMdyNNT?=
 =?us-ascii?Q?+ZiQqtNbtLYGGm/3hLtXtvyHx+fbxAuLwjoKFvU4dsLZnmBmc3iNMu/nbaF9?=
 =?us-ascii?Q?YpH9v1lumAWu5xhOKz2k5VSH6mHAnspKw/Zg2cpgtzeb/mKSOy0pGeJ/aGSn?=
 =?us-ascii?Q?ioHO0NGp4s9sdlEPjrR3PWAQapnPlNSOWeqIhS40XhM++XjrWF8HubCCUcI6?=
 =?us-ascii?Q?0rtd2siwoS/eEU7nlLoMvAQCEEHwDbUMXRakVVwzlzn0XVeCVUEVZbFVqsQ0?=
 =?us-ascii?Q?Vm8/y2TJD1UjICB/Ouv59gW8N1Njo9PZF/eYMqtdKHHJxCwzvTwT1tbPyl7g?=
 =?us-ascii?Q?jk7Y9gd4X3N/cswHUyDCRnhAwnVrPBxf92CY0f/mX5LTliI6fyIShQoHmkbV?=
 =?us-ascii?Q?Tnc3wwmMja6FCO8ayRDhx3uJ8V5PZt0xWzuoGCowkmIsgI5UV1OHn6MmJeHF?=
 =?us-ascii?Q?zzaMGQmsdHJj4EjGOyxtQ8kQULODNCu1FkSUdQkf+OpbQ1P6WF40fwM0U+Dv?=
 =?us-ascii?Q?31utvMYQIKm9FN2vf3CCNEv6Kn4NRQY8KAHaSyLfxlQHUyA3sPfsHX1lfnQl?=
 =?us-ascii?Q?0S1RTzfBvU+dRuaw8tpkPEmmyXTenHI6ZscWbYnFWfqilfSSdQFnFNurU04Q?=
 =?us-ascii?Q?WDwWmPI4zK6UhAB32C8ehW3IEMyyRsDTRrwR/WkX2Od2smeVJfkyWIZfpx1H?=
 =?us-ascii?Q?6hK4IAVYWc3zXaFBvHoz4IvN0s8ojlCU/bR46zYxmHb6/5j/p3Q1QqEdxs+4?=
 =?us-ascii?Q?ixgH4FQhnnNo1fwZIasfPsc/E9ibCRHK+6i9EYO8Q4fj2ACjgfbli37XOXno?=
 =?us-ascii?Q?46wwn8aAzyP6dZbth5baj6+86GGfbccQeTgj+xAzq79iJse6lW6omOL2Nfv3?=
 =?us-ascii?Q?LvH1ITjMSUeq5DPwfetOpGhTGK02tWOBKyrCkmkD3+tM8Bnj1WxZ21ABxt9f?=
 =?us-ascii?Q?oE5P6tjy924UHSTWr+33bc5MSaauW2FBY1K8o/pM47vsnYYBr8sdqgF/cqL5?=
 =?us-ascii?Q?fSh7l8ghqEzI96Hku0jIGaGmVgalrh3tgpqls0uzRWoScAZzcAscvH12f2XS?=
 =?us-ascii?Q?lCi0UdOdcs5ep6hnTqmXgOSvN4ZHHf2w5NsubbS2leIQL+b3L2pqrJR4Ivsi?=
 =?us-ascii?Q?TvE5vcZYm5GFWuTVhwI34KinDaAxmbGzwl3eC5ye7vYYUOGLxBIs1hJ/N99v?=
 =?us-ascii?Q?cehv9bx59IFuzws9CLL0vaPGti0DjpQU69QY9BEO8ddaWgIRvrkBiKfrXg4U?=
 =?us-ascii?Q?2DQE/5FRG7VcHfVjP9IElQiYRfJdGNQIL8mA6N/hxx7rI/eNNc21O4geUAE3?=
 =?us-ascii?Q?vWtfTXgGNizcFuBKrv4/HSlIDdisuNoA7x+df7xB7Yvd3ILhES6dmmfCCjEM?=
 =?us-ascii?Q?OFDGjcmQ6KnIvho9Q+pmSEKW07nXEdcn8xGIDG7zy3YFMqdygZ/vD674O2aT?=
 =?us-ascii?Q?9KZEskrVwtJAKkjzUKy4LCy2dVLTReokwRsdbS6Av0KZGgIRJwV48LqxGxls?=
 =?us-ascii?Q?npp/riP90i75St+q8c0wEpU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab15ec7f-c71a-4600-7aab-08dc41f7ba77
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:02.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aMKDYdShpcMG2UF44i0fcEhtng08ki+NMnSkuOXFsK4vQYAiEjfGtXXGSQpc1tJvNTQa+NujVLywaJeCvfP+qxzSVT7tPS9cn+MefB0ghw=
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index c6d82961c9..e7c3763017 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -811,6 +811,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
+            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


