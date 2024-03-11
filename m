Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06363C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkFH-0005bj-Vk; Mon, 11 Mar 2024 14:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEs-0005Yf-Uo; Mon, 11 Mar 2024 14:19:12 -0400
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkEo-0006sL-Td; Mon, 11 Mar 2024 14:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQAd9xCGnOQ1UDj0HOBdy1d3KN8puAeFlwkAXrrpZbtJvzT+cbtQKE6fpblgaz+sWE1c0E0FrhMN0YtgkbVUOwzR6AMXMlVpywfUaon/TWoBM34m1kxqDKVuVx4nscwTeua4qx/Jpa/HJMg/yBcMw5doFiCoPOvCiTcAMDDm0J08QRXLeas+u45XKJDxSV+O79liOSJbs3okQBp4AEnAbE28gjRhVmM7yQxLHmK4c+p0D+9tm+zjMd+rvp50pN/ruY5b6HYDu+fM815oPjsU4kaOoYhvYt8Jr3fsSZwmQA5R8/DY4qTSssEpR4QYJRRcMZiDC93fKbSKYOxvcB2IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J5Di/nAPMXmygFMWzKXw4IhrG1rAsVe3/lBkjT2eEU=;
 b=DEmkLwQTqUMM5M7XjZknbfi1s18XuaFP1ngdnU9COg7eeGwmkjnwbRnrZREb6OBHiJt9rIhn8SvOEgvezLtA9+JFtRrLuXju0jPEy93ce7/I9yCGhnO2J4h0VbaZNe2+12Y28oofoMO4dXuZQZ79Q4aKwuy6duzBCvulcwzM3iwQQBScQdpo0H47MOLJSpTQZKCe3FPGty91KZJX9KhpP1tHeH01X+NvHnOw4aYTdXuZzYbXb13rWPVqSwObkCmG/nIEocm8k3k0MWBjwop62sj63ukOS2Ck3Jnu1xLr+mEo6ayvcMvFrHRz4OlY0rQJq7oC4ZrN0NQGdGP68n3K2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J5Di/nAPMXmygFMWzKXw4IhrG1rAsVe3/lBkjT2eEU=;
 b=YHZa3jN/EXX7qYlgi1dCU6bYoPpx0rSznIB7mA+dYlyEppkR0X+RZQnbCazAS9P38fJX/iJYuIyOEDxLOgKT/g3yuaCZgCipxOIZDXHq8xNdj0yfBozhB220O/hBOt2V07TR2uDO4gLc0hEgqYkVqfmIUZQjPhWwd8oep+KLN8tlaJGX5AWZYmmIcZXDfOmAEXJ3j+tu9tSiJx7VLPFYQ7+ynU6aygssdcnkj1BPgL2IaWm/fDdiMQns3uY8MYKjMJ3OvlNvZxT8oZpvTrMXIcZQxMpJgoSUQ6/FGuI1UER01JSCZogJKOK1xF5ofeG4+aJQp7mcz4xwrOQw9Fa8fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by DBAPR08MB5653.eurprd08.prod.outlook.com (2603:10a6:10:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:18:57 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:18:57 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 00/22] parallels: Add full dirty bitmap support
Date: Mon, 11 Mar 2024 19:18:28 +0100
Message-Id: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|DBAPR08MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 797cf987-9d19-49c6-f91e-08dc41f7b76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvc8e6dJIcrN8WFwnGnIbElbeHeI7Noqni9UHEWUgxH6eh098KN0zNVlksYhNbKdDu3pPApECM/E8MD/q/B+ZSL0H1pTKbTmB/ifNVdF9UhrjMAU8hXtdYeKHUK0SfpePM8pVFcdH4LMlMuY5F6L5vrqBA8QOahpYNuB/w2eRiOMN8A1hjggvPlPhs3J+TJ67jlto6PBSdiGTjM+ZMZ1kXhedIf2CpqWva5TsNWl6vf40Hy4G5e4ML0FzZWgCfkD6ZCxN4igHfh2u4P4OKYDS4nNrbz6S76kGdwnkH++RgwjUSjqCK6OLOmsMk89qoUAp4BJ1c7CpiZNt7tIkiMIwDQ3QnkaYWyp2aisw7FnZ+7AjaIofZM1bdFV1K5ua6bMEJ9iQt0oQaxtfxOpAFlPRb205qf1PoANlvl84yPfmJ215f9m+ZwrmhmERbDD0Xdeo2DtyXjuWkCrXG/zL5eBht5oUDCWWQEmHNsljOqYG7VfOWQxw47XD/0OzZ8w3G7tHTHThg/j1P500dqdrJjIeN2foujntLjuN+kAldWKoVOjodayKSzMzg4Nu7e4BGmV4M3Y688rfEBRLaLdEZk8ndVhFiNbi5npg+dvs0BA9V0FFw2kAUDpBvL+MifMnPDbHf0xPjcKvaQ1lzO1jrfi4l4EasvYsq1MhZOwEmU3F24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZD6SAz6eHuIQ2ptYl93jswd99jIxcMOHw7RzFjq5nAKMH5r2WbOKminXFtsA?=
 =?us-ascii?Q?TBxMKyo6GbdZbNOW8Exn/FD6l6IBtBKMZE/U4aLxebCr/Dq/NNmOqDLSWYSj?=
 =?us-ascii?Q?LbyxwFcKGMY6L+GR0PIGjTHmbiJ98dh2wDsN6kJH+5GyhlxdM0i8DrC6iizo?=
 =?us-ascii?Q?2mSkhOqh+ScwRhJ5t+edY7QbRrou+FCk+IswtJLbXdgJZ/9/EbugT+4/8yA/?=
 =?us-ascii?Q?S6P12YGOTcpfLC8iJDh85oXA/5fE3FkbclvemHVnIpqN7IDe0aIUuAD5AiTp?=
 =?us-ascii?Q?I2Fbyjogz/b5UIg3aTou18Q9e0RSsSnfdIDWZlZ6s2MZrUTMMYyweUr9r//M?=
 =?us-ascii?Q?aDiH6FOoWx/hrcNJtbwgCGz4188psycZfTxt3HNGVPcI0JZaCKG4IpZablm8?=
 =?us-ascii?Q?MThqVrBWDDjnAXImNNzpqB34k7dcc+WOjOKjr5gW3VbWwy27/JKFgXFd2f0i?=
 =?us-ascii?Q?ROshUf7Hl2jenTT9IYt6mPyKmt9vLMYyArLVAaAx5LgJnJymkkkBtvcmkxze?=
 =?us-ascii?Q?qI31nvzYEOP2AX0oTZTz4YdkQQdoGZb4ncrpNcmGgXIW5txYLTGqCQfk/awG?=
 =?us-ascii?Q?I9BGrLCwHsxKE54GWydEl+1TCFYlbm3oD8S+0Lcg6COwp+PTwiw7BwU/A5KY?=
 =?us-ascii?Q?cKyqcLbxAr4kGHEz9wI5qxvQxUJ8pdvEtRQrPLBSPOvtd/ltrMxxi7QTaesO?=
 =?us-ascii?Q?IB0ostzE+7QvXMykIGS9Fu0ENG0IRuW6sI5QUCA/KtG47U+lDskyfvx5zQNO?=
 =?us-ascii?Q?jIolDH/lMClACZ/q7u/9ekfioope0INGSF3ypCj1mlEZQ5xd3XZDR19PXiUz?=
 =?us-ascii?Q?KwaiYtu7Dx1VzBJjqZJI6Xo5K/7wfVRm7Nz3D9VDbcpZlLCPqAUaFuOJVBQS?=
 =?us-ascii?Q?eB4c+wTbOPkwnpudtnwZq7Yt5tXmxGo8NdvIoC4Y1Ibh8Yj5SBwM3t37jO4u?=
 =?us-ascii?Q?B5rTxRKwgWkyzojrzp0WU1vlbo/rDZa0vS8Iv3ptm0pZtjiDyzGTQ6oLBMV7?=
 =?us-ascii?Q?RnnjlW7cZbW/pnGQIx/aVi+1/ADyTTX5pLbAhUatg+/kpsNd8tx0ZFVilg7g?=
 =?us-ascii?Q?Kwl3sUDoDQfVUrJwgXUDKWnuvrmuHq9kdRJK/yTX56kFeGckfSycLTKpJt4Z?=
 =?us-ascii?Q?I4tmhpzDWG3zfOylh1RO/dWstFii/8FxAU/qFsuq+IDQiLVwSaeqgGPO12OB?=
 =?us-ascii?Q?ya2ozc5Ock1Pdv9pFvUxPNg1JLmpw3Xd0VoDZbFntglaIrDS9klXwts9N07t?=
 =?us-ascii?Q?f23k62Vg571WdrCSsibqCpRVpN29AfWxi19KDxA3AMkPMutbMQP6Ezd6fixS?=
 =?us-ascii?Q?flamO/ryLi9ztkWEGkQBON8FzIFcoFy0uVUIvyyeBP0T1vytma4K1tq5XqVn?=
 =?us-ascii?Q?8EktHCwCYXcXESxXXrTkx7nGBEBR2kKUwFCwBh/lODsU/+Hvts3LY/w0n+zw?=
 =?us-ascii?Q?UzLGYCRRWTCl1aQWfmOWCF2EOlt0d+iLf//4Nw+qaGk8b/4z5p01Nd5Yk6jH?=
 =?us-ascii?Q?84Jz8xS727IsYUuCltZKfkX/BlKYgvNGJQykGuDJZ8AlIppvlI+sr/5JMUTO?=
 =?us-ascii?Q?5Pffk4ga3Kw3e4d/57FHiPomywzwsRWM6dAd/iOMdDJUhewBsh6cojEVF45c?=
 =?us-ascii?Q?Oi/Oqou42H/9NjLzcPn7N4A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797cf987-9d19-49c6-f91e-08dc41f7b76d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:18:57.1239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXc9QHSbtogxhVb5WTPYxEY2GZKca0H8YKs3/GVM/jbf2dlJmXcP6YCSqMdkyzBxINRoGwlBAXlkR8s1+nlDfSGZ+tw6p28WuiInpzH8Vks=
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

Parallels format driver:
* make some preparation
* add dirty bitmap saving
* make dirty bitmap RW
* fix broken checks
* refactor leak check
* add parallels format support to several tests

You could find these patches in my repo:
https://github.com/AlexanderIvanov-Virtuozzo/qemu/tree/parallels-v5

v5:
6: Returned a comment about fallocate.
10: Added a motivation of used_bitmap usage to the commit message.
11: Renamed 'limit' variable. Added a few error messages. Fixed
    'remaining' value by extension header size. Simplified bh and l1_table
    pointer calculation. Added clusters cleaning after error. Add return
    value to parallels_store_persistent_dirty_bitmaps().
12: New patch, all the next patches will be shifted by 1. Added header
    unclean check to dirty bitmap loading.
13: Placed dirty bitmap loading after used bitmap initialization.
14: New patch, all the next patches will be shifted by 2. Preserved
    extensions cluster for non-transient extensions.
16: (previous numeration): Dropped the patch because the next patch deleted
    all the code of this patch. All the next patches will be shifted by 1.
18: Moved used bitmap parallels_check_unused_clusters() to parallels_check_leak().
19: Removed redundant bdrv_pwrite_zeroes() (see a note in the commit message).
    Added a break to outside-of-image clusters at image opening.

v4:
4: A new patch with limitation of search in parallels_mark_used.
5: Previously 4. Search is limited to (cluster_index + count).
6: Previously 5. Added GRAPH_RDLOCK annotation, added a note in the commit
   message.
11: Previously 10. Added GRAPH_RDLOCK annotation.
16-18: Added GRAPH_RDLOCK annotations.

v3:
1: Fixed the order of g_free() and s->used_bmap = NULL.
3,4: Made mark_used() a global function before mark_unused() addition. In
     this way we can avoid compilation warnings.
5-9: Patches shifted.
11: Added GRAPH_RDLOCK annotation to parallels_inactivate(). Guard
    parallels_close() with GRAPH_RDLOCK_GUARD_MAINLOOP().
12-21: Patches shifted.

v2:
1: New patch to fix double free error.
4: Fixed clusters leaks.
15: Fixed (end_off != s->used_bmap_size) handling in parallels_truncate_unused_clusters().
16,17: Changed the sequence of the patches - in this way we have correct leaks check.

Alexander Ivanov (21):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Move inactivation code to a separate function
  parallels: Make mark_used() a global function
  parallels: Limit search in parallels_mark_used to the last marked
    claster
  parallels: Add parallels_mark_unused() helper
  parallels: Move host clusters allocation to a separate function
  parallels: Set data_end value in parallels_check_leak()
  parallels: Recreate used bitmap in parallels_check_leak()
  parallels: Add a note about used bitmap in parallels_check_duplicate()
  parallels: Create used bitmap even if checks needed
  parallels: Add dirty bitmaps saving
  parallels: Let image extensions work in RW mode
  parallels: Preserve extensions cluster for non-transient extensions
  parallels: Handle L1 entries equal to one
  parallels: Make a loaded dirty bitmap persistent
  parallels: Reverse a conditional in parallels_check_leak() to reduce
    indents
  parallels: Check unused clusters in parallels_check_leak()
  parallels: Remove unnecessary data_end field
  tests: Add parallels images support to test 165
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format
  tests: Add parallels format support to image-fleecing

Denis V. Lunev (1):
  parallels: drop dirty bitmap data if the image was not properly closed

 block/parallels-ext.c                       | 243 ++++++++++++-
 block/parallels.c                           | 367 ++++++++++++--------
 block/parallels.h                           |  14 +-
 tests/qemu-iotests/165                      |  40 ++-
 tests/qemu-iotests/256                      |   2 +-
 tests/qemu-iotests/299                      |   2 +-
 tests/qemu-iotests/304                      |   2 +-
 tests/qemu-iotests/tests/block-status-cache |   2 +-
 tests/qemu-iotests/tests/image-fleecing     |  13 +-
 9 files changed, 502 insertions(+), 183 deletions(-)

-- 
2.40.1


