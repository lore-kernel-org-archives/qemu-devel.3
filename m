Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C18C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkIm-0000fV-Kd; Mon, 11 Mar 2024 14:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFH-0005cy-4h; Mon, 11 Mar 2024 14:19:31 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFF-0006sL-53; Mon, 11 Mar 2024 14:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFBXCmsalpWUNVYjbKweOiiUT+zq5zEQ8v5slY3iabIy4/ibb2NIHMXrecA9+eYOEuDEDJLjYD3BRr0HccKRJslhO+Hd1L/EKezG+QPPiZNnvQCgzSaOkRF7v7eZN3ir+z5ta+gqXIOK5Wpf2AcyJZ/swhTvl9psFB1jjjkuE8S8dRi2najxhCESSugctmjy7kuMoYyz6C5ZlPwkItRybrEh43Jt/XkF7ecsYBi2SFamVYz/RMbGFGoXsJwHMScD4G5E7p+rvr+f+Rr+IhtjqNEWjfJc/B2PteRV4Z1/13Dycrv8zqZ2c8j35J1FTXV4sMS8IqfdntiW0LQiWzme7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OxbiiAyH7PY2dT/SsHDxKwxCv4ufq3B4xfgvyQxr+g=;
 b=cmRpNwvr2MEIeeg6Je7D+EKi+72l53rAV62I2XOlc5GQUHQwBH6GLbrnDT+glm+hPXWNaBXawvj9gyO5N5FyST+1ZRxfZnFja12K5RunryTlNpXw7166GH4kXJN2M3zCHLqqFkGHncagr+5G0BEQcp5f3YPgW3NJdbKAnmH6RNQSShm6BUtpS3vC6EHQzlMdgeakWWdAtDUmKZyx+PbcFruMn9WR3BEdhdSJlyEXX1Bd2Sn0acpOgRnIkSoJGe9B91bZ9hzFpWk59Q7Prq49IHhmHpxVGoCbxQ4cBWSrK7sElMkcglU08NAmfEUkgRUJCXcsrrlgEJ5JmeN2TJXcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OxbiiAyH7PY2dT/SsHDxKwxCv4ufq3B4xfgvyQxr+g=;
 b=gN+pd80a2VM7Jhrz/R/DmokUawcYlzqQHkQu3+rtLC7grzXxntgZCaAY/w5DIVTvLv02WhrPgaDvl+ztmjZRUWUg6Ptc918avA+1jps1GLadi/QPwAtvct5+bBOZz1NlyQouxTUgq9gdUK1Qtg1ZbSUjuGo8y0LdF9uvdlSSRxkQM3gI9H9gd+S2D868bid3iIC7aQV0hs0SIiu76/UGcq8E02KKTTKUXCwsf130T+Uypf/l9Cpa4Kp16vc5MFd58ePpbBd7ODHYqdUw2/1TR9H1oGLtGBxhBUjFwJowco2OQLLQB2rDhAjR3N+d5NCyuelO1bDU1SrMrXSq5AJXSg==
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
 18:19:03 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 09/22] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Mon, 11 Mar 2024 19:18:37 +0100
Message-Id: <20240311181850.73013-10-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e985644-b271-4d02-bc66-08dc41f7bb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+VkThmtXzF03h8kCWr6BvhNM1GTScmdaRH2GFg69l6QNn/Rrf8LzuG22Tj0bDSSEUIMxVuBk2G4h1aoFg6aBGZyjDg450Nt1DKTA+hFO6sbXAMahxCaAi8CwmxFfdf7/5cPBySibVbpQnUoHreDNHb26GEuGjEWUF8jhHBgmUEXXxKW4VNoFC/yowdfmKW0DE3e7Ev6CoKYDgTzOrrzWP9qad09SOtoinJPBywxhFDpQ510WVu9uC9mexo56vWbljclAdZs+SHfVgYRk7P/3yZrOEZyuYi7SJzRDvaHJZWxFgZVQDyk0g3fyaVkD92Jykc1mDM+DXGkDATUqSIUj9GsYQL/L/um9KxbBavVyQBuOlpvdAKwm6SFXYaJ6HMFGmPUoxro4+kEnfoUCKPwIBssr1CCL6uw/OJ9sTqyNCnkmmO0mahucsqxyj8ndJJmCnOWRMZjZMGiIgBkel9kAbVhpeF1hYc+4r3juzq2beKGZrGEsXprIzm2gJKa/wvOsfxsooCy9igU32gW7MiHx20YetCMD+I8mZthJ0kVUBw2vJXG0xu74bpit+Je1Mu92/jVhxAzWTJlPhBj+/eR6b3Hxqne1lEizmATReo1sZ47/fNGxMte3zg96j/0an3LpRLG8er98LcJSHyHvq6CJJfmF6GQcKXwskqfTmZinD1fi+dOI0doFZ8uuF6uJdeLaZHt7cNili2jG4WKBHqLQHPVllTh28U1xYlK3Haqe0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ykaevqzKwEEH/RSPU0YiWSN+A5A9lG0ZIx+3LEnaZXVEQQfzyoA+xJInyLEh?=
 =?us-ascii?Q?BCwQxWazHeKOZuuZOnJ+z9GJjuAGOkCVKAbiZqTSfFeVzYnzkbvcB/xW4/hg?=
 =?us-ascii?Q?/oEUNHYdAEMkK2NDk0+ys8nk6ltlUUEiuoTuckwKV8O5a3xIV7EqU4ijEiC4?=
 =?us-ascii?Q?oGRmmEG9QhahjoxYCQSHbkw27Ym4ousADfbjeuAvJDCIVaEAdl1aPvuf/Szf?=
 =?us-ascii?Q?EFctrMwTpMQfeUalPsvd/fjx7Am2uBlDiX+uBsQZSxfvjA8GElVn/yHAYla4?=
 =?us-ascii?Q?llIjCKqPmLjFTGW98VlW+PhgcDvhYmqJg3dBi4+zq39Vq3v7Sa28yalRYzIO?=
 =?us-ascii?Q?55gq98NW089TPBqNttbelJMLiCav+qmhF5MQFeTfJHYLVgBvA56A7Hf9QkpH?=
 =?us-ascii?Q?VbKcoJvlJyrMOgD3YfhXElIPoNu758B/lLveQOqEEOcgp2A6GEE+FSyR1BMh?=
 =?us-ascii?Q?aNtIs92rIJYcn1T6SS/7fHK6uR69suh5riiSGBIZ0PaN5+BOHpL9YFTW/KCP?=
 =?us-ascii?Q?BnYvxBLdbt0AMkBRT/IlGFhVLybcB4dj7HCWP6H/f7JZIvemCIQDd9mJ56WI?=
 =?us-ascii?Q?gNepeo8Ap9ELh5VVBhkmAtpi2AWTiDEepV3d1zvMTU8gFQUpsA+hNlWcox5d?=
 =?us-ascii?Q?6QNIHiBClw07E64ODdsg11f3AVZ6QLsmWmG6FOBbbfF/i44OCON0Hflcy1G6?=
 =?us-ascii?Q?tMDWBKqHS+WZ/945YWRyTHrRLYx+m8tgE8riVow0st1cUvv+W9t6uqaUWME5?=
 =?us-ascii?Q?ktS3j/b3jn1IK0Tc23we9lDdH1fGjdVyK8bovN20RJzU9JAj4DNK5fctOxtR?=
 =?us-ascii?Q?cmzGa2ihDSDDHET9f+C1+z9J8Dnj4AVWgT/YYKvdRXkECom431Gskg/xqh2c?=
 =?us-ascii?Q?f2R9BE54f1968G555bP90cZtvpQJPvbQWhbYGMnHjlaWn78VH9UimCPrdUa+?=
 =?us-ascii?Q?9FteMGoI1Z/TXVqspwdKqlcMYrozik/p0a8TzMd/oewg+je+sxjPPTYG7vuK?=
 =?us-ascii?Q?MOLyT4xGhlsM5qqFL7HaYCtzOYS2fKgJf+goAdGcmkikA5bRSLNE/HcxSyX/?=
 =?us-ascii?Q?GjLpKhg9dwcYcru/de4fWhfG84eBy7TwzeLXS22DdclLCdp2egGe/o3EGhdR?=
 =?us-ascii?Q?KaDJSY7IgE15sWmvI5uEq50rt2gGfcE+FsS66+S+JREGHRdkxfpSHFKKLWZu?=
 =?us-ascii?Q?4q4KDBRI8lDYmAvy1UdVEPclP707ObDMXUZRe17EyzXvoTcRILcqr2knvKbS?=
 =?us-ascii?Q?HuKkFI4xy651d+zXsqhhv0eIqjo94EpKUIa19x4s824xIDrvcoza2LxX+qq7?=
 =?us-ascii?Q?DoncRP0o0FDY5v9EaDnQgmx6m1PM0+qLc+10bo77eoq6PiaI3slVpaYWyHJb?=
 =?us-ascii?Q?RUwMJXD2yabukwL3N+2XXvZ9Ts262vFOy4XfwOX98KMLO2uEcWoHMEFaPhpg?=
 =?us-ascii?Q?ugooWSWi5GBWP8kAZHPpDj0vRJ+NEn4URgMV1FlJmQNvVdRwZF2Muvymdbil?=
 =?us-ascii?Q?8USpxNK9IdNcARmTVaiEGeqwIjf86VGAjhoz77NKZB+MYnbanpVxlb3arttw?=
 =?us-ascii?Q?nrA9q2q4qthhvZX2LFkSGJ2/KSTTY7V3pfZjD+n2AhP614TjCR7SkeDzeiq+?=
 =?us-ascii?Q?wIlFCw9u2wHUFfiMENzSkCQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e985644-b271-4d02-bc66-08dc41f7bb5a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:03.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 191lE99I1xsSFEpljaGu1e8BCx/dK2/7WEGOSh2cB1s/9O+85k+LosvOum7JhVBOJDTOAzNtOUwHrWB6tnvf3YV7EMlDrgz8dDqYAvLBDfk=
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

In parallels_check_duplicate() We use a bitmap for duplication detection.
This bitmap is not related to used_bmap field in BDRVParallelsState. Add
a comment about it to avoid confusion.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 9056dd6a11..66990925a8 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -842,7 +842,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     bool fixed = false;
 
     /*
-     * Create a bitmap of used clusters.
+     * Create a bitmap of used clusters. Please note that this bitmap is not
+     * related to used_bmap field in BDRVParallelsState and is created only for
+     * local usage.
+     *
      * If a bit is set, there is a BAT entry pointing to this cluster.
      * Loop through the BAT entries, check bits relevant to an entry offset.
      * If bit is set, this entry is duplicated. Otherwise set the bit.
-- 
2.40.1


