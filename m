Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3574BC44533
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmSUc-0003ww-0Z; Wed, 22 Jul 2026 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wmSUZ-0003uz-Uu; Wed, 22 Jul 2026 04:39:52 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wmSUY-0007YR-7h; Wed, 22 Jul 2026 04:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSrYqNw4kbPawq5GIONPWroSnHh/yTw5hZeAx12rIopcC7ZPx2UOnXWjAIiVQZrlWwqFSqb8p7g2ijheb4pvEFtp6iyF+MdNtG6fmc07DspA4JT5Nf+UMy31sJedKyiovs8+Yy9OdBLeMCN0pdrM/RhbKjRQI/dAtgmFhvawEcCyMJWeYfNXaMo1JwXrMjvL0hZ/vJOS+Nyw3MbkBXMNJRW816f4t2DVceQ5ambdUUPtOZXtX7lvFo+849ka2YDVt4tyBaY/FKz7qKhNTGb0vRjpAlH3s0I9ZSg7fcvO3Dm4jPWavwxgLEFUosSTpcnHrqQrUXrJQc9Z6b3WVAsTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS4sOAaQDHPDD9stDSV7HZio0nI+RtzLlcF4SdRcTAI=;
 b=pfUsQnpyU3lkpEOqRMVBdxh4YSwrfW/khANV7H8AQe07PdmA9CIQTfKVsRu3+neoRMoZXzfLbPaVrTWExthdYrCFukr00QEnVA7vCQgVXwGCbVrw4kSg2sZ3XuI2lrEL8b+xrIktVbRZid/I+SzG+gYRGwfS9n6zVAYPQxmuwitkVQXMx3ICxPIw3/HALGZt84RAymBx0v+YdJ90UpeCpu+JgMIiKuqEiuY1gb8ROjeuVSdsVosvVu/Ji56/+iEEX7UEEjIPEJoo6Xz4C7ctiJxieMXb7Awaa9rDOoAp1nD2M1FyDyJJrw/+BatC9P+1D6mAJ0/5RQBgNHmFc8CLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS4sOAaQDHPDD9stDSV7HZio0nI+RtzLlcF4SdRcTAI=;
 b=BM8B0izpixWgruFq0zm4PxFME7LOEkrABi5Rg2GL7xf7ICtUYYrqKCzVsLLUcoek8uo6g3jJdrNsofo0n3Q1ozJ8lmNAhPlogk8hsrNAt9mI3/ACzdrJsig3E6ELBSBwgMgZUDrucfohSvbinkz8lEL4/oImzMwlaW9T9zo7qFm0wsywK8+BNJY0b/5xGDBNEKnQ+XubO2d8RPB0B7yEegHcwF44d1a4OCsrTUCZYvHt11a0DIWDFYJLWW/f1QC4ObBOGJBILet7W7qkF29ze4Ny9wE5BvE56jLwyosVt2wYk50Ytl+J21ZLtREQZsR0sfUgP34TIyhX9tAM6n9Fhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AM9PR08MB6290.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:39:43 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:39:43 +0000
Message-ID: <6a089ab9-d93b-4304-ac82-3b61c1746357@virtuozzo.com>
Date: Wed, 22 Jul 2026 10:39:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iotests: fix three spurious local failures
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260715103451.1930909-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260715103451.1930909-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::23) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AM9PR08MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: e48ad8da-d738-4591-f145-08dee7ccc6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DX/NWwVfY68Y2yH3hwC2MF9IxxeZMWm1hMw8qSHSTo+3ZqJ0D7C8FfUSv39LSK/SUQOQ+GPSDtK1kjD4xWsYk6QbEEADv8aLfk9LebhWc/OkB7+14EjKVZ67Y4BiRbInXiLiqnReW9OyXTwjTl2iNfjQKAKYaSBtVDTbwOUxHewde25Uwd9lE/9bppRe/M+mx2MuVa4Ywqh2ztvxSxzh5j+k/ty9vDZehg55/f7PU2uDsTGhU2ER0+T3DUgkKOphQ4i1yQVg4gjjbluonmHz2vIrJkXZnSlg7SF/9YLF9JUe2fWPKwDnV1EYREbLfFyUjo0jyP926C0ayLMprD/xazFvPZtP6OufiDvajqppVLXxzpByCG+VH5c5IXHQqUntAmQSSGmedGz5m8ozID8ABrwgEPmsfTz3ObbNu9Rda9yOzzeIdm+DrtKtpixnvhA9fx0ogi7rH8gpiFvd+QfIAee8bwHUu23N6Be2/kmPsYgNJlg69MZ0wNCu+fGHa+ba6futYD0vkcZ6jSaO2f2an4DtAHFc8D7zwDAUzul9hWL9UBEMvNroIiprWkT69TmS+16Eqe84U7t0WofwqBfS6MB9uAiKwcuQBVbSSG4/W7EeUVKU1hxoRjfkTPebvDFzJ3WzBg6Bb1LvxkE1X/uhc4FY7PNB4NXEiBQnnDPaezM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBHUlRwSkdac2c0UVFjd3hFOEZGcXFsQTlabUd5NDBDNk9IbXJBSUQ5WjQw?=
 =?utf-8?B?dmZpUTNNSVNrTWFaUlBtcHIxRDVCNHBkc0hreXZJRzdWQWdKTGUwdG1HL3RE?=
 =?utf-8?B?a0hpR0ZCOHR0b3FCbmhoUVJXRHg1UVJnNGdrU1ZZVElkL2pETGFET291Vkdu?=
 =?utf-8?B?bmFrZXRCNFVSdmdGNGRON0dvRFVROGhuWlBmbHN0bUM1Z2xHdU1sUDk4eXBR?=
 =?utf-8?B?N3BlYWlrb0FKSFFtNkpwUEttVm8zVlg4c3lnTGpkM2dvazJVSHdmT1VqWG1H?=
 =?utf-8?B?RWhUS09ZRTFTdU1ZVzE2T0NnclMrVE9RSWt6dVVXRlNRVHVQV3U4aXZiSm5Z?=
 =?utf-8?B?WHF5RWh1M1B1WmZkQ1VpSEkrZlFiSkd4M0NWMTVYaHc4a2hXcURtQnBlWmRJ?=
 =?utf-8?B?ZHhYeHZoN1dOMCtSQVZHUzlKajV3LzJqbzh3N0I0RUtVckhDaCt2NW8weWxX?=
 =?utf-8?B?d2VNVDdzZFlseENaQXZMYXBkL0ZuYzNXaHNIN0hmSDc4dk9QRmJSY3owcXo2?=
 =?utf-8?B?UFRkSnhnWlFTenE3V3A2Ynd6cEtIOXF0ODRxRE1kMXNaeERCVkR0QWgyeXhP?=
 =?utf-8?B?QTJvNXVjYUR4UlhDRlpSQk0rQ3FMbGMvdnhneDlVek1NUTFtU2hBQWc0MllD?=
 =?utf-8?B?MjkrY1NmN093WG5Ra3dyZmlBWEZuQnY3VWdVdjRKSTRrV1Q2Nyt2SUx6enVy?=
 =?utf-8?B?MVdtOVFJalA0N3JRQmZqOGN4R3k3YTdORlRFQTBlWklEbFpveVdIdXhhdEdt?=
 =?utf-8?B?WW5oRFV1cUlRUkdaM0tQeDBlQzRLNW4zaWxHUFFqbGNzMndod2pvbjViYzU4?=
 =?utf-8?B?VHpEYlMxc1BXNDRZdE8za3RtSXg3a3krQjNrYW55alpubzI3NHh6MDM2UHJP?=
 =?utf-8?B?YmU1Z3VzTFRrV3JteExneWpHR3hsWi8vRGVLRERkLzUrVk56QkVFdlltdk5q?=
 =?utf-8?B?aXIrU3llWWV0M0o5SU0veHlwckNxUlNHb1hjYTdhajhtME84aC9ESWZ0NjFk?=
 =?utf-8?B?cHlML2hLSmZLS0ljMkNwdWl2Zld2UzlYMVJDalkrY3FlcENzUFNXOTRoRkpM?=
 =?utf-8?B?RmFmanB4WjRyTVpqOGdsV3lRZU5hSTVjZmVCRVh0WTRnVnU1ZnNvcldiYVNP?=
 =?utf-8?B?S05hakwzU21hdGZSSTNBU294TzU5VG83Q1FUUTJyazRQV3BDblFZalgzcWxS?=
 =?utf-8?B?ZXcrVGwxOWZuRmRmMGozRGNCeUp2Y0RRT2FiMlVRZlBFV3NVcTFaVE5HMW9M?=
 =?utf-8?B?WUNQTS9kNFJCUm50ZTVZWkF0OC9FYjkxMjB0TzdDbW9LeDR0SU1LbFViSElL?=
 =?utf-8?B?U0JSN2s3alBnN3JVdVpsSkpObTBVZ0pXTkZOMTRYcjBNNGl6TUlQVTFnKzFs?=
 =?utf-8?B?NXptRVF6RlNGWVYvRU85MS9mRHUxaFNvZkE1TjRDMEhCeWRxbS9mWm4venli?=
 =?utf-8?B?cXllVlQ5cUdrTkdFZm1mMm9DYXduSXR3b3FKTkgxRFRwM1JSR0xMSXlxZldr?=
 =?utf-8?B?N214dUtuZ2U2OERyTnpJZkozb0dVMXVIY09zeHh6T20wUk5OTDhFcTJBYXNl?=
 =?utf-8?B?eGw2OU9WYUxiandtcEhtZVFlTk5ibi9qMURXMjhrOTBDSTVZQWt5ZGpFSFht?=
 =?utf-8?B?VjNzNVIwTllVdzd2Y1JVK0M2MEQ3citQUnNBck8yOXY5a2Q5TngxOFhFZzF2?=
 =?utf-8?B?aG8veDFDQXVWbWlyK0g3MUpaVlk0YlU1YWYxTXlGRHRmbjdMdS83SkkxVUls?=
 =?utf-8?B?OWg3MEt2aFZEZnZGL3pQN1Z2OUJucngwS0xsNTJGUVNZSzhsbXE5V1lZRTFJ?=
 =?utf-8?B?Z2VkSFRvdWxhRExwczZCS290UzZsQW1aL3JBRkFuOCtPMnFGNDZpcDNiZjIz?=
 =?utf-8?B?Y0hORFBRdlIvUWhZZ0I3amgybjBFdTQ5a2w4Q1c2dkdoY2tzMTZJOXR5MU1Z?=
 =?utf-8?B?eXNTWCtUZmtwb1pUMVVBN1pkSWkzd1k3d2F6d1MxR1FITEVCbFB0V1R3Q2Fx?=
 =?utf-8?B?NVZqQTRycGlhRmROZ2xuRzczRFRDeW9DN2xkVG54OGxtSXNnajVvTDQ3bXE5?=
 =?utf-8?B?cmFyZVVHRE5pR1dxMzVlbUk2a1ZWUmFmcnVCR2NPNWhRTkgreDNFeVBYbHVV?=
 =?utf-8?B?WEhBSUxGMzBDMmw0OHRya0x0eWN2Z2tEak9rQmtzQy9sUUIzNTRYdlFHc3NQ?=
 =?utf-8?B?ZzNVdnIxNjV5c2pJSDkrV1pldll2SlpTSUdtUXU5S2YwOTNBL29MbEpKT21x?=
 =?utf-8?B?ZHcwaVEyaEhucFhTbDBVL2xneGJrbG42OXlMc2xGaUFXWkNFc2k4Y3hKUVgy?=
 =?utf-8?B?aW1SU2oybjhOU1VlQVlQWjR2L3JwcGNwc0RkN1FqWnZ6bEkzVGF4ak05REdP?=
 =?utf-8?Q?Ld9RPTw4Re161POuCTAgkHyvK1DtMy92WbgCVweG0JCA6?=
X-MS-Exchange-AntiSpam-MessageData-1: eczxg6cZcZPVrw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48ad8da-d738-4591-f145-08dee7ccc6e1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:39:43.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYScYPMqAaL4LhAujpOIo6FeVrXkBAx4lD3P/JX2KfVmqU9Ij2tu8myqrzA8gl79HVQ8XSDXD1u8kgNOV5q+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6290
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 7/15/26 12:34, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Three independent fixes found while chasing a clean './check -qcow2'
> run on a Python 3.14 host. Unrelated to each other, sent as one
> series since they came out of the same session.
>
> v2:
> - patch 1: drop the now-unused 'Pool' import (Kevin)
> - patch 2: rename _notrun_on_no_fuse to _notrun_on_fuse_error (Kevin)
> - patch 3: replace the dropped assertion with a check that bitmap0's
>   content on the destination has not reached its final value right
>   after RESUME, throttling migration bandwidth
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Denis V. Lunev (3):
>   iotests: run the test pool with the 'fork' start method
>   iotests: skip FUSE tests when FUSE is not usable
>   iotests/migrate-bitmaps-postcopy-test: replace the timing assertion
>     with a content check
>
>  tests/qemu-iotests/common.rc                      | 14 ++++++++++++++
>  tests/qemu-iotests/testrunner.py                  |  4 ++--
>  tests/qemu-iotests/tests/file-io-error            |  4 +---
>  tests/qemu-iotests/tests/fuse-allow-other         |  2 ++
>  tests/qemu-iotests/tests/fuse-mmap-shared         |  9 ++++++---
>  .../tests/migrate-bitmaps-postcopy-test           | 15 ++++++++++++++-
>  6 files changed, 39 insertions(+), 9 deletions(-)
>
ping

