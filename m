Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC3DC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ofx-0000HQ-Qh; Tue, 01 Sep 2026 09:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofv-0000Fn-Ln; Tue, 01 Sep 2026 09:37:19 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Oft-0004KL-Di; Tue, 01 Sep 2026 09:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6eqByUJFbzD3xXc3GiXvrEuS/9IQ++7IJvL9bz3W9c9eOknvHQX7u8BFuqGBdhpX4k5k1UMZ45jXoWnOZQuiFX18nFbZXiwdkfAhoNOaK3DekivviCdtkit545nBUvLvoaR5fHJbPuH2wMqfdSxFytTxiefOhj0kVGWSnrYEgWKQzmsnGvVCs7FBDEwGcFWhDUC8Namf5ub4Xdkzxt+ZvdVlZgu6ogBOWd45vHISv369CEfX6NyEcjWTyP3Td52cIED215cNScuqtrdMxA4aK4LLlLPtnrrGmUdAoB7krGhN+Bg3/5evVIHiuG3eqQDskdXh8tGOOLv5t5EYp3U+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeZeNEnNNyiLFIrMaf8clg94zkBlStVG3QLtBXx7DOA=;
 b=mSEfxZjDGFOgmmWOLqVoEN4bbrdSDqqY5natciIMqRelntRlEPRIQ7E/hR3uiODqb4lp1LQ8GfyR+TMoA0VZfZuEHCBWwh2GIdKFYhprn87kWd0aWnHgDjAPPMrctLdH6M6rjrwypwlaaxa0zF772bS7mqPzDJyOhC/1BFD4QCMKUYrzsazbBxmYR42ZLOtC32kCXHKBhLKH37foWpt5T4vzFeyODPXXUeutROBNUqS+w+A7sNdyDHht3sy/X1/AgMA6vfFIiPiFvosN2DF3BNd+iZD7ituPugYGAQ7FFBamUB1Y1z7jwvbkWb0E8E6fm6YW91W5GSI6ziZAogUZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeZeNEnNNyiLFIrMaf8clg94zkBlStVG3QLtBXx7DOA=;
 b=HN2zXEnpx5T88BZ5JfJV5gp650Zr0YhhZ0k8VmXGGCN2IB6Ew5y7jDLJ61CF2z0IEVUGcY5SP/4aNJWj3HCRuJQvNvvt95Rn1PNL6efXh//PmnXSOn3pQfC2n8LkTXH6Ksd+X51KMlxUXX3z7EPs3TShlK51jIaCU/p5uhmSBLXBED5phgAemcfTX5EDD3vIvxtZ4EUfBHMlWmYVywoKnAC/PpITHQNG0uspxT7/e21pElYqGVYhUjy+ebgmw7aC80tG8dlEQS2TzG4n4sL6wg7hogrufpgJU/S2D1WxNOUWBCJlDD1wp1nJgVadqH3ah1xa5T9osbO+KHJfNuTBhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/9] iotests/040: cover large and fragmented commit
 runs
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-3-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-3-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982593.73810.11352368693763396759.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1762dcb2-2816-4211-547c-08df082e1f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|3023799007|38350700014|6133799003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6FcayAuSIePU++QCCPwYQQsx87FrIoxRHtVDCYBqwuTJbi2mLxYrQgiyglXRa25/G/M5bTYTezkl5nCWg7Q3gxwpyljoK2PSnwlCvf2Jmq7UoeYynCAdi9GyYzxjevgSJ5OQTd+FWpsMr3KQ74VGN//xQnjUlRxrRL+5wgwsQXjIvNEqyGhuchl7FVhNqYQeKhDC237hVGrbDnPDtMXcyhmB5QaReDWBcLhJorRtDT3KGRBdta/GaAscuTh0mwhY5BECJHPKkf5BMX7yULQft4Ved1yZiRBFypZJ4RYAz7Ml7XkCwV3FBw12Nd6Nv58hp6biu7xTVAQuIXxjPAL3ZoqGTzUeny+zNAjzcxmFKQRZdnXal2BbX4wUF4FNGtKa770dJz7R47QUucMgBF7TGP4CkvQgaxGY9IRCMvixWQ/nmwoV+/mIGJPEWYv31T5Okyu6PGS6HlSmsVGwENpBUu2B1QtL6+da9+X2Z028Bpp77zBT/nnOVECAtWLKwfx3ClWLgYsooKwEe6AXr0caXMN+f7sMxANk9P5NicFgIAUgJIBT7yuCaLpZTErFdMOv6IH003aM2IHb1Z7/3au1qjqALHTPYgYWzVAyWawh4uvVxljdpDAhO2y6MN4KgBRiekpKXS+z10LggC/cX1E/M/WxsKW/wdcoKj9dTXnUultTEDjjrzrwWin5CaaYE7oP6ua3ecpIh8AsuaVkgXgCSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(3023799007)(38350700014)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNBeE9nK1Vod0I3VnpPQzFZMmpJeXlRcDlKaldHTStkMG1MWXJFSDdGRjN4?=
 =?utf-8?B?SjU5WGVTTFFxZ0h2cU1iajlub2o4NXduRUhMZ0xLS0liSkV5VTRHRldWUUI4?=
 =?utf-8?B?NkN2UnBMTVhBRWVnZTFINGF0NEUyR24zakdQaFY3K1VHemRJcGhPU0VvYVVn?=
 =?utf-8?B?OXdrbVMxZXVVSmQ1SzU2czBINzZxY2p3QWZXT2dtL09sZk8wTlJFdWQyQXJy?=
 =?utf-8?B?TDZGL0VGMDZJb3k1eEpuNGowQ2xVNkFmcGh0dUpKY0Y0Z0tlV1J5WkI4VXR5?=
 =?utf-8?B?SFdwWCtTQkZkMjZzTzR2TmNlTXE3aVNsUkxTc01JeHJvSzYwTmVKNVNGVXdM?=
 =?utf-8?B?MWhrRkZoRmozeE94K0o5YzRpL3hJSlNBTTRtQThGcEhLU3pEaFZlWnphNEQw?=
 =?utf-8?B?NGlWMzRUUUVtUlVsYXU1cVlaanlEWlMxYnB5dk5LNGhlZVNQWDZqYXd2anRD?=
 =?utf-8?B?ZkpYUXNyZFBDbzNQMVhiakgvVC9hTGFqSWdieEMyYktFaGVrRUVQVDBJN21k?=
 =?utf-8?B?TVZ2OVFtaHlJbVV1YkMzbkdwWjY3U0xhUW5kTXE2aWppajZNQllrNVF2N0FY?=
 =?utf-8?B?YUFUV1Vrc3Zqb2VpRURDbG11RStrNlZBRWFiYlAwbTNvR1ZvQUptQVh5TTF1?=
 =?utf-8?B?N1REblZOcVpvQm8xUkdIQU16TElsYWJ6RVVSZVMrT0o4aHhpOEg4dGtYSnVU?=
 =?utf-8?B?SS83MWdaMVpLUlpRNkplY29SZzBQbVM2WUNHdjRKZWdZNGVxc1U5RGJrZCsr?=
 =?utf-8?B?eDZoMFVnTHUyZFZIVVlWeFF1R3gvS0FSVHZJdWFaNkdHdk13a093anVjUHpL?=
 =?utf-8?B?cnRiTUpQQ2ZEcWZod1F4UVVoQnBtcXF6UG03Z2gxaTZNMzNQdktuNVY1ZTVF?=
 =?utf-8?B?aTREQjhDK1FrN2FxUmthMERONUZNWFhYV3B4aXBwVWNVc0F1Y3ZRNWtZTE1v?=
 =?utf-8?B?c2ZFRVcwTXVFOXI4MnAySU9VbS8xb1VRWS9CelhqTVJRaUljUmo3OURSRk5h?=
 =?utf-8?B?MjBmcVgrWW51ZGg5bXhyZ2VhaldRbkttVVZhZEV1MkxKb09jWGxOVTc2Z2Y0?=
 =?utf-8?B?MENMekYwb0FsZm1SYnZqR0R5U015ZVBMeXBuYVFWOXUrZXk2M0JBWnFHVjZn?=
 =?utf-8?B?dUtkaStTYzdTaW5yY1JOeW05R3JIL2JXeEpmYTlQK3JNT0ZNUnRZL2MvYWZN?=
 =?utf-8?B?ZnlMTFUrUzMySGwvRzRwRldBeVoyTGJZSWx0UGZQUENzOG5IK0xnZW9MVkJi?=
 =?utf-8?B?MmhYVjRzbGZ4L2liWjR0WUdienFMYVk5Y3lPSGFPbzhUaUZOWGxPWTFuUUh6?=
 =?utf-8?B?WG5VOGI2dE1IMUJodDg5cWZRd3JEU1VRRXQwcGs1TkJNL2dSMWJSSWVPT2Z3?=
 =?utf-8?B?Q0VaK0svcTBKRFQ4Y3JsYThhZEZ1dVFkb1ltMlNSYUtKdE96SXhVQzZNQnRn?=
 =?utf-8?B?THh4MGJKZ2owVXdyaGVSdmVHbGljR2tiWGticjlEbWRORXZFQVRMRVhWT1Fk?=
 =?utf-8?B?NXNmWXZVUHFxK3hIcm8wRkdwOFpXWlRpSzBCWFVXeG84bE5vT3M5dEdscTFW?=
 =?utf-8?B?dGorczJnWEx0TFN1bHRpcFd4WE50eGpKb1ppNTlLRW5aeDZVdDB1dTRZMDdX?=
 =?utf-8?B?alpZS1ZsQkZwSUFGdC91aHIvbnkrb0dLLy9nQm9xVC84MmFROTZwKytuaW9o?=
 =?utf-8?B?Q0JTUEE3T3VUQU1lYW8wU01lOXRMeUlQYy9zaFg1SXJtaW10WjRjclR6UGdR?=
 =?utf-8?B?R0JlMlpDYWMxaFdEOE5od2NRN1FWSnNSZW43UzFqNHhyQkRxcUZVL3VZMVkx?=
 =?utf-8?B?c2tkcVdlVExLK1RlK3ZDSFVud1FkaXlCS1BCS1NwVHlFUWErYmVIZDZsMmVa?=
 =?utf-8?B?OERMNk1mMkloZHRLcmphR0EvbjZGYmpBd2hoTkEraUdJRXpZOHhJL1FHaFJy?=
 =?utf-8?B?am5LcjZCcm5mTXIrSVlFU1BReWQrOG91NGtVU0g2T0tOSGZocGNPbk9SeUJW?=
 =?utf-8?B?b3NjMXlXbVFnK1Q3WVhhc1UxRHlWczFXd3pwU2VrM1V1WmErRXI4a083S2dk?=
 =?utf-8?B?WGhVblN2RWZrRmlWOC9qL0xIbVJQaFFwZmEvZFVkUmhOWTVPd1NySVFNZXNU?=
 =?utf-8?B?YkpSQjZiQy9ndkhPN0s5NVVMV2lucS9WWXhic0hQc21FM2V3RXQ2UGhtaDhr?=
 =?utf-8?B?V1ZyMEFRcytBVXVTM0dNMmEzNUZPL0loZ1ZpUVZwWlo4YXlWNTZaSHZMd1hm?=
 =?utf-8?B?OTFZQUtqbW8yN2ZrUXkxbW5OK1BlSm50MGlQcEg2UXFpUGswd0pncWYrdC9G?=
 =?utf-8?B?Y25aL2lvVitvMjF1OXFWL29Cd29uMms4U0VSTk8wSjkvbnVyMFJqUjd5T3Bp?=
 =?utf-8?Q?no3V7b83ZlMdWAEQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1762dcb2-2816-4211-547c-08df082e1f24
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:09.5223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERd+TZNxqDtrXnpwmdAwjOdSQbsAPYUu1eU2SgFEen0Qi/BeUaBg9DmXwRUgOIwf9LUZl/oxACjh2qK9b8ovyD9rg42r1B5dxyOnnPv6x+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

> 040 never commits runs long enough to span more than one block-status
> query, so the answer that commit_iteration() is about to start caching
> goes untested.
> 
> Add two cases on a base <- mid <- active chain, committing mid so the
> job takes the regular commit path rather than active commit, and compare
> base against a snapshot of mid taken before the commit. One case mixes
> multi-megabyte data and hole runs, the other fragments them down to
> single clusters with every transition off the 512K boundary.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 5c18e413ec9..57e32b99c10 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -25,13 +25,14 @@
>  import time
>  import os
>  import iotests
> -from iotests import qemu_img, qemu_io
> +from iotests import qemu_img, qemu_img_create, qemu_io, compare_images
>  import struct
>  import errno
>  
>  backing_img = os.path.join(iotests.test_dir, 'backing.img')
>  mid_img = os.path.join(iotests.test_dir, 'mid.img')
>  test_img = os.path.join(iotests.test_dir, 'test.img')
> +reference_img = os.path.join(iotests.test_dir, 'reference.img')
>  
>  class ImageCommitTestCase(iotests.QMPTestCase):
>      '''Abstract base class for image commit test cases'''
> @@ -951,6 +952,98 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
>          self.vm.qmp('block-job-complete', device='commit')
>          self.vm.event_wait('BLOCK_JOB_COMPLETED')
>  
> +class TestCommitLargeRuns(iotests.QMPTestCase):
> +    """Commit runs long enough to cross commit_iteration()'s cached span."""
> +
> +    MB = 1024 * 1024
> +    CLUSTER = 64 * 1024
> +
> +    # Runs several COMMIT_BUFFER_SIZE (512K) chunks long, both kinds.
> +    SIZE = 32 * MB
> +    LAYOUT = [
> +        (0, 4 * MB, 'data'),
> +        (4 * MB, 6 * MB, 'hole'),
> +        (10 * MB, 4 * MB, 'data'),
> +        (14 * MB, 6 * MB, 'hole'),
> +        (20 * MB, 4 * MB, 'data'),
> +    ]
> +
> +    # The same, with every transition off the 512K boundary.
> +    SIZE_FRAGMENTED = 384 * CLUSTER  # 24M
> +    LAYOUT_FRAGMENTED = [
> +        (0, 45 * CLUSTER, 'data'),
> +        (100 * CLUSTER, CLUSTER, 'data'),   # data island in a hole
> +        (150 * CLUSTER, 80 * CLUSTER, 'data'),
> +        # [230C, 231C) is a hole island in a data run
> +        (231 * CLUSTER, 69 * CLUSTER, 'data'),
> +    ]

We explicitly mark 'hole' in LAYOUT, but not in LAYOUT_FRAGMENTED.
Maybe make it consistent?

Also, the next commit changes how block-commit doing write_zeroes() -
shouldn't we add 'zero' regions as well to test that?

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

