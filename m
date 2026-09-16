Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F7C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sW5-0007Zk-Pb; Wed, 16 Sep 2026 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVy-0007YT-A7; Wed, 16 Sep 2026 12:29:44 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVu-0005RC-Tm; Wed, 16 Sep 2026 12:29:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joczKhpJTdMc9Mf79pdnLLTMOzRgEyPBbUNYGj7N+Ugvh2Nj22ALtN7lsoOWsOM8WjCC4gkOVSMHOkxv9RAKrQeiDIP/wWUDVpUU59fVrpC7FcFICgFI2sYrtTmBOjiIhFNj7yQhj2qBQQoenG/20iYwTYyXFrDJ0ihetwc51Aq2ztT1+P+r3DgfLtpKtAtUI5mS1pkVzvTIYR6VfeSWA0RhDjE6YD/6R6iPHfSckIqpQWYP/KAODAcIt4IuoiElkwAZHX4AOEy43GCyfBAQCJH9Qpeqv/9dZEgSyydLx253oTqfeiY+xDUjspeVI/b3M2uBzshfVW6mvmFI2iNaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qi47FpqhKYHLs7RslMSDevVLb69/Wuv7Xl4ZudDI3c=;
 b=QIkdz27oXrDyUAYuSFxS05A93q0rpjxEky9hZeR3Nt5d73JT5MFTCl2BVNL4Cvo385dlie82w/XkZHWDmeOBwc/PlWXCiO7w6OfUP+FXGYO7P0O6hhPM9D00h4Aj/7pHkU3LR5xOHaeCisTdGi14ZMupbr2T0Rxj0LFJtJipoIsd79+f1/dccj4k/WINpYL3tuFMPWtMDOC1c4HtiAVoidvVyq4bohUr/Oohc8hCOdEvZx4GpLpblPFcEI+NCBVt54bNLDZCLJ+jzLc2bUcVW59cR3YN6Cm2ubIBgPext5gTsMCKazBEQ92ta8zsh0btUcYmX+P21p89TExwUtu3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qi47FpqhKYHLs7RslMSDevVLb69/Wuv7Xl4ZudDI3c=;
 b=iwggFa1gHNISeh3rssHMehre/t75WtfdODI+v7iqr0XkxyDwPgLLCbe995x5+yRxNH6OenMZ1+QrWzND4VS00G48G1DXC6ROwHMxK9qw5FEXmKxD6Dkv6VtSVQR9bf2Jgum+sNpGUNrJlx7HFHGsuhFhc4mmpfRumNboy4jXYX6GkvCOLLekj15wPVCyGaIqTyoAXYpilYAtgp6n3BDwf5rC6K1vGoI3dxybr9ghgDUTa6kAu2gjQ76eiBmM19R+557rttAB4SVR5qCSuW6b6gJcl+NBH+maOxdW6IBQr/MTQ8DqohlgvIHl3y6NtRv8NIPVkRBe1xxeV4BHVGcsmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by BR0PR08MB801654.eurprd08.prod.outlook.com
 (2603:10a6:2c8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 16:29:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:29:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/9] iotests/124: cover backup of zero clusters and
 holes
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260914145250.2792879-5-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
 <20260914145250.2792879-5-den@openvz.org>
Date: Wed, 16 Sep 2026 19:29:16 +0300
Message-Id: <178957615605.653083.16638772047906940607.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIVP296CA0098.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|BR0PR08MB801654:EE_
X-MS-Office365-Filtering-Correlation-Id: 5289042c-91bf-4ed8-0ecd-08df140fad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|1800799024|366016|3023799007|10067099003|6133799003|56012099006|5023799004|4143699003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 0NdVVzFuKiAL33i5vjt3icdbd5oeUj3QHDEJzdsOqWph6U0Pqx9ejF3df2E9ay+ccrYAfpQJRyQaFU+LJSG6PnCiWw0p+cfDorWbWwfFIxiLHirSqyZE4IF4iC0A5NfoAbIE6D/XWV8XYcwi60UqkS0IlUvNmKVGJdZ4lRJdaum/Fim+R1QSsleiNLy61hwYZdTusj5C7ANl7nNs1B33S4MvtSTdpgVH4BwXQ+g0zi8vEV0usaXBPSxalpAebBszXeHqKPBknydFF58yIEF6sOGDpkzjkQLY0TwxtKJVRo5T4pkaWZnIdSW+Gc6qNqlawpPiwL39SgdXv6oUPELd9slFhLsgH7YSq/g3hZu/L0kVal8+VL7ICfvMyKXNhVbeaJbF0LOjBVxV7QHSPPpK5jJjCEm8c8pTGiJIfxEXAQNfbcGfB5KaKfiT70yN58vEzl6HwRsMrU549GZ8Af9XIwx95B6QUQgpWZvoTUl1b1CCOiF9vNLYTdEDf6mGWbVDJ0Nb3wIv+m3yHJeZ06FBCvL7N91EA5naW7wHT7898ErTnfGHRnKMMyBilrCjFICQvyL6/VPcstke9oVYKe9nDc+Cvm08frhw0cV8cdAcvB1u3zNRgZYV4alf6ZftmPiS9tK8sGU5ln/c2i+WHgjET/KrEws7gjypwOa/Yph6fC2mwH8xEFFOkFZC4CkjVh3wEY7/8phSTrZh3eYC2U9p/Bh0Vcr1wuE7c7Fqrq1zHDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(3023799007)(10067099003)(6133799003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFJWHl6YklFQy82QTVlVjdGUGZpbVM3dW4rQ3psRmdGc3B4TFIvb2FWODRL?=
 =?utf-8?B?M29WNE5yRVgxYTZuU09FRVBrMGgvUmU1NFI5enRGQ2gzKzdnc3UvZG5WaFJ1?=
 =?utf-8?B?S01kY09Eak9QcUJCMlMxVXZlZUZPeXppajdRT2U1eTJ5MFJleUJ6ejUzMGMz?=
 =?utf-8?B?aDRTZTVKOENpOWVLQ0pQV0RXNHA0MGNVRHFkMDBoQXR2WW14UTlhbE5lck9r?=
 =?utf-8?B?RkRPamNzRjB1bFhpN2U5SFJIb1JTZEpSQ09YQ05aZ1ZXYWxiR09TT2FZN0RE?=
 =?utf-8?B?eEpNdU1IQVV5WEZoUW5xa1B6bFVYYWswUzlBU0dXazIybHYzd3g4Z3RtbmhJ?=
 =?utf-8?B?bHNVaVp4SDBXK1ZrTERPWkdGdE85Y3MvTXd6eVNnVTJ5WldoZVo5YzZYOXFx?=
 =?utf-8?B?MkdLVjRYNS8zR1pONVVSeVdOalZ0L2Y2dmE1ZDNlZ3RGNHFaekczZ2R6VFll?=
 =?utf-8?B?MkdnMlByeGx0UXF1ZG9GYk9wSW9CN1lkRzZMcTVJK29YL0ZLZFZFeGdlQm9S?=
 =?utf-8?B?OXJQQVFFeWg4djc3cVhYamkzemlzOTQzVDlIOTlZN3BLamhPbEJad0tuWlFW?=
 =?utf-8?B?SklBZFRCRXNlSjIvWHQwZzlTdy9MWHVUS3ZCaU92VDcvci9naXRXV1lzSExL?=
 =?utf-8?B?RDZsRHhNNzloK3I4bG5PMmViYjFKYUJoQlAxdUd5YzZZMUxxN1Q2SFlBSnZ1?=
 =?utf-8?B?MnFKK2dwcHpKcWZMT0d6MzRBMWVwNTV6ZWlYVG9PcEJ4ZnRFQXd5VjNWeUts?=
 =?utf-8?B?bFQrVHlJNWdYNzlXQTdnSnBZQmFXaGR5YTkxUXB6ZzJka0tyQ0RSenNMT21l?=
 =?utf-8?B?T3pESnJMSU5TM1VuRDFQbGVrd3hYQUh5ZTYxcit5eSttS1B3WEVvRkUrbnZh?=
 =?utf-8?B?ZC9aT0RLSndndkhCNGNSRnJhcWRiQ2N4MXJLUnlyQ1VRL1BtT3A1WHlLNnZa?=
 =?utf-8?B?M3QvOWxPdFlrN2NIZWdPWmNEMWI0Y2pKUWlub1hBYkpyNFpOak0xb2FtU1RW?=
 =?utf-8?B?RUljR1FSVEExUTRxUXcxN1Q5TVBTeS8wckF5SVNoT09sb3VaU1ZzeXFJTjM2?=
 =?utf-8?B?SWFUeTNCODFGbHhoZkwva1o0RGZPQkRZblZNbXF2dDFtUjllbmF3RjczQlFD?=
 =?utf-8?B?SWNLMVlVSTlybFFYREhHQVNISENkUnd5ME5DSXFWQ051YVVHa1d4dFFKa3ZR?=
 =?utf-8?B?bnBRUHo4S01mNWRNcUc5VVMzRGxiQ1JFTGIxWHkwNXJiOC9WNUFLVXRORUtl?=
 =?utf-8?B?ZTJVZ1FkSnQza0E5N1pQSk1FbTN2YUtvNDJFK0c2U1RDcWhReHBZRWw0dzJI?=
 =?utf-8?B?dVFKTzJwelcyaTVsNjY4YXM4NXdsNmdoeFNDOHdlUnl0TWNsdk1pZjhwcTdR?=
 =?utf-8?B?YnFsYTcrbnkzTE5raHJ2UkE4bk1ERmZLK1VIckZ1cG54ejBSZDI4RlJIWXF3?=
 =?utf-8?B?U1ZFSVhNMnVqdmwyVEswVGtQWFkxUkRHbncyVnBwdFV4MENyT1VyTElXYmFh?=
 =?utf-8?B?L2xxSkcyY2NmNXowTzNIYnZKaVhGOEkwa1NYV05UNjIwaDcrUTBzWkVUV1hJ?=
 =?utf-8?B?YWMyVGRIMDFjQWZHQU1HQ2wvejdJU0tSTnd6YmE4MkZCdE1md2pvbTgwNXdK?=
 =?utf-8?B?eHc0U09OWWJzckdVMGYrVGNNVkxtV3d3dmZtVzVOd1Fiek1wUktMcjZSNWpO?=
 =?utf-8?B?eGZwNk96cHBVZTBXODJlUExoYXJPeXBqaTdxdlZpeHZiK0YwbGRUV1cwK2lk?=
 =?utf-8?B?c2IwUC9panp3eXhXUFRNTVI0L1d3dGZIVnNxQkhST0piV1RxUVZ0VytsdFhG?=
 =?utf-8?B?VWd0eEsyRW8xNmpqS3VaK0t4NjNxM2svM003L3hIWHlRMmtUM3g0b24ySDVR?=
 =?utf-8?B?bTI2RWR0QThPRElRWmxlK2pidUNQYXRoL0ZxdEV6MEsrd3AwUmI3WVhpdnlm?=
 =?utf-8?B?OHU4RldBMXdkd0FUcG9qOXd1VG43eUZYZEw5cW0zZ2dkK29aVW5aUlZqRFFO?=
 =?utf-8?B?WlErcDgrY1pvVTQ2MWhHb3pMQkFKK2QxSTIycnNXN29NV1BIU1hSTHVYU0hj?=
 =?utf-8?B?V1ErK2VVUmcxZDJKdkwySXVhaWIyQlVxUHpPN1JwMVN3Sk03YVhzaGMwM0FU?=
 =?utf-8?B?Z013RWVjRDloVlRWOVgrcW9JYzF4dWxXbkpsUmlwdlY3cTNTcjdKQWg4QU5l?=
 =?utf-8?B?VlJNQlNKcmJFMkk4SWE3b1pmVWtjVUFTV1NnSmdKVjJmczUzWXFaTGtnNTZr?=
 =?utf-8?B?a2ZyMnJSWEZ1L3BOR0JNRjdBTkRkTHorcnJMK3krTHd2eHNiOTFFdFVocERk?=
 =?utf-8?B?aW9SeU4yOXFxNVVQeVhtbndLVmRMc09razBiUlcxdlE3NERwbndkTFlUcUJE?=
 =?utf-8?Q?FfHTIJseM6B6YYY0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5289042c-91bf-4ed8-0ecd-08df140fad38
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:29:27.4276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXPuje5P+Mj2YW7ZIwc7ESAqoX963G9eLsZ2K3ZFUCztz1FpN11yF9vi7cIFHfwI8+Km6dk4O6cc7IHHooDEz0vUUrnho6dHRrIYS4f/ZaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB801654
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

> The backup tests compare content only, and their sources hold data
> alone, so nothing pins how backup treats zero clusters and holes. Back
> up a source mixing data, write-zero and holes with sync=full, sync=top
> and sync=bitmap, and check the target with qemu-img map, which tells a
> copied cluster apart from a write-zero and from an untouched one.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
> index ab9ea4d8b59..30730e7f678 100755
> --- a/tests/qemu-iotests/124
> +++ b/tests/qemu-iotests/124
> @@ -22,8 +22,11 @@
>  #
>  
>  import os
> +from collections import namedtuple
> +
>  import iotests
> -from iotests import try_remove
> +from iotests import (compare_images, qemu_img_create, qemu_img_map, qemu_io,
> +                     try_remove)
>  from qemu.qmp.qmp_client import ExecuteError
>  
>  
> @@ -748,6 +751,345 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
>          self.check_backups()
>  
>  
> +# Backup of sources mixing data, zero clusters and holes.
> +
> +Extent = namedtuple('Extent', ['start', 'length', 'kind'])
> +Case = namedtuple('Case', ['size', 'layout', 'expected'], defaults=[None])
> +
> +source_img = os.path.join(iotests.test_dir, 'source')
> +base_img = os.path.join(iotests.test_dir, 'base')
> +target_img = os.path.join(iotests.test_dir, 'target')
> +
> +SIZE = 64 * 1024 * 1024
> +MB = 1024 * 1024
> +CLUSTER = 64 * 1024
> +
> +# Data, write-zero and holes, every combination at a cluster boundary.
> +MIXED = Case(SIZE, [
> +    (0, MB, 'data'),
> +    (2 * MB, MB, 'zero'),
> +    (5 * MB, 2 * MB, 'data'),
> +    (8 * MB, MB, 'zero'),
> +    (10 * MB, MB // 2, 'data'),
> +    (20 * MB, 4 * MB, 'zero'),
> +    (30 * MB, MB, 'data'),
> +])
> +
> +# Single-cluster runs, and a zero run ending exactly at EOF.
> +BOUNDARY_SIZE = 16 * MB
> +BOUNDARY = Case(BOUNDARY_SIZE, [
> +    (0, CLUSTER, 'zero'),
> +    (CLUSTER, CLUSTER, 'data'),
> +    (2 * CLUSTER, CLUSTER, 'zero'),
> +    (3 * CLUSTER, CLUSTER, 'data'),
> +    (4 * CLUSTER, 8 * MB, 'zero'),
> +    (4 * CLUSTER + 8 * MB, CLUSTER, 'data'),
> +    (BOUNDARY_SIZE - CLUSTER, CLUSTER, 'zero'),
> +])
> +
> +# A zero run past the old block_copy_chunk_size() 16M cap.
> +LARGE_ZERO = Case(48 * MB, [
> +    (0, MB, 'data'),
> +    (4 * MB, 32 * MB, 'zero'),
> +    (40 * MB, MB, 'data'),
> +])
> +
> +# Image size not a multiple of the cluster size: a partial tail cluster.
> +TAIL_SIZE = 4 * MB + 4096
> +TAIL_CLUSTER = (TAIL_SIZE // CLUSTER) * CLUSTER
> +TAIL_DATA = Case(TAIL_SIZE, [
> +    (0, MB, 'data'),
> +    (2 * MB, MB, 'zero'),
> +    (4 * MB, TAIL_SIZE - 4 * MB, 'data'),
> +])
> +# The partial tail cluster falls out of zero_bitmap, so it copies as data.
> +TAIL_ZERO = Case(TAIL_SIZE, [
> +    (0, MB, 'data'),
> +    (2 * MB, TAIL_SIZE - 2 * MB, 'zero'),
> +], [
> +    (0, MB, 'data'),
> +    (2 * MB, TAIL_CLUSTER - 2 * MB, 'zero'),
> +    (TAIL_CLUSTER, TAIL_SIZE - TAIL_CLUSTER, 'data'),
> +])
> +
> +
> +def coalesce(extents):
> +    out = []
> +    for e in extents:
> +        prev = out[-1] if out else None
> +        adjacent = prev is not None and prev.start + prev.length == e.start
> +        if adjacent and prev.kind == e.kind:
> +            out[-1] = prev._replace(length=prev.length + e.length)
> +        else:
> +            out.append(e)
> +    return out
> +
> +
> +def layout_to_extents(layout, size, gap='hole'):
> +    extents = []
> +    pos = 0
> +    for offset, length, kind in layout:
> +        if offset > pos:
> +            extents.append(Extent(pos, offset - pos, gap))
> +        extents.append(Extent(offset, length, kind))
> +        pos = offset + length
> +    if pos < size:
> +        extents.append(Extent(pos, size - pos, gap))
> +    return coalesce(extents)
> +
> +
> +def create_image(path, size, backing=None, opts=None):
> +    args = ['-f', iotests.imgfmt]
> +    if opts:
> +        args += ['-o', opts]
> +    if backing:
> +        args += ['-b', backing, '-F', iotests.imgfmt]
> +    qemu_img_create(*args, path, str(size))
> +
> +
> +class TestBackupZeroClusters(iotests.QMPTestCase):
> +    def setUp(self):
> +        self.vm = iotests.VM()
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        for img in (source_img, base_img, target_img):
> +            if os.path.exists(img):
> +                os.remove(img)
> +
> +    def hmp_write(self, drive, cmd):
> +        res = self.vm.hmp_qemu_io(drive, cmd)
> +        assert 'error' not in res['return'].lower(), res

Minor: maybe use a more test-friendly self.assertNotIn() instead.

> +    def write_layout(self, layout):
> +        for offset, length, kind in layout:
> +            opt = '-z' if kind == 'zero' else '-P 0x5a'
> +            self.hmp_write('src', f'write {opt} {offset} {length}')
> +
> +    def assert_map(self, case, backing=False, gap='hole'):
> +        # Content is not enough, pin the data/zero/hole split as well.
> +        def classify(e):
> +            is_hole = e['depth'] > 0 if backing else not e['present']
> +            return 'hole' if is_hole else ('zero' if e['zero'] else 'data')
> +
> +        actual = coalesce([Extent(e['start'], e['length'], classify(e))
> +                           for e in qemu_img_map(target_img)])
> +        layout = case.expected if case.expected else case.layout
> +
> +        self.assertEqual(actual, layout_to_extents(layout, case.size, gap))
> +
> +    def add_source(self, case=MIXED, backing=None, opts=None):
> +        create_image(source_img, case.size, backing, opts)
> +
> +        self.vm.cmd('blockdev-add', {
> +            'node-name': 'src',
> +            'driver': iotests.imgfmt,
> +            'file': {'driver': 'file', 'filename': source_img},
> +        })
> +
> +        # Write through the node, so an attached bitmap sees it.
> +        self.write_layout(case.layout)
> +
> +    def dirty_layout(self, case):
> +        # A new bitmap tracks nothing yet: dirty all, then re-apply.
> +        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
> +        self.hmp_write('src', f'write -z 0 {case.size}')
> +        self.write_layout(case.layout)
> +
> +    def do_backup(self, sync, case, target_backing=None, prefill=None,
> +                  **kwargs):
> +        create_image(target_img, case.size, target_backing)
> +
> +        if prefill is not None:
> +            # Not zero, so a skipped cluster is provably untouched.
> +            qemu_io('-c', f'write -P {prefill} 0 {case.size}', target_img)
> +
> +        self.vm.cmd('blockdev-add', {
> +            'node-name': 'target',
> +            'driver': iotests.imgfmt,
> +            'file': {'driver': 'file', 'filename': target_img},
> +        })
> +
> +        self.vm.cmd('blockdev-backup', device='src', target='target',
> +                    job_id='bk0', sync=sync, **kwargs)
> +        self.wait_until_completed(drive='bk0')
> +
> +        self.vm.cmd('blockdev-del', node_name='target')
> +        self.vm.cmd('blockdev-del', node_name='src')
> +
> +    def backup_and_check(self, sync, case, gap='zero', backing=False,
> +                         **kwargs):
> +        self.do_backup(sync, case, **kwargs)
> +        self.assertTrue(compare_images(source_img, target_img))
> +        self.assert_map(case, backing=backing, gap=gap)
> +
> +    def test_full(self):
> +        self.add_source()
> +        self.backup_and_check('full', MIXED)
> +
> +    def test_full_zero_overwrite(self):
> +        # full skips holes, so only check that zero overwrites prefill.
> +        case = Case(SIZE, [(2 * MB, MB, 'zero')])
> +        self.add_source(case)
> +        self.do_backup('full', case, prefill=0xcc)
> +        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
> +
> +    def test_bitmap(self):
> +        self.add_source()
> +        self.dirty_layout(MIXED)
> +        self.backup_and_check('bitmap', MIXED, bitmap='bm0',
> +                              bitmap_mode='never')
> +
> +    def test_top(self):
> +        # Non-zero backing data, so a hole and an explicit zero differ.
> +        create_image(base_img, SIZE)
> +        qemu_io('-c', f'write -P 0x33 0 {SIZE}', base_img)
> +
> +        self.add_source(backing=base_img)
> +        self.backup_and_check('top', MIXED, gap='hole', backing=True,
> +                              target_backing=base_img)
> +
> +    def test_boundary_full(self):
> +        self.add_source(BOUNDARY)
> +        self.backup_and_check('full', BOUNDARY)
> +
> +    def test_boundary_bitmap(self):
> +        self.add_source(BOUNDARY)
> +        self.dirty_layout(BOUNDARY)
> +        self.backup_and_check('bitmap', BOUNDARY, bitmap='bm0',
> +                              bitmap_mode='never')
> +
> +    def test_large_zero_full(self):
> +        self.add_source(LARGE_ZERO)
> +        self.backup_and_check('full', LARGE_ZERO)
> +
> +    def test_large_zero_bitmap(self):
> +        self.add_source(LARGE_ZERO)
> +        self.dirty_layout(LARGE_ZERO)
> +        self.backup_and_check('bitmap', LARGE_ZERO, bitmap='bm0',
> +                              bitmap_mode='never')
> +
> +    def test_huge_zero(self):
> +        # A zero run past the cap on a single write-zeroes request, so it
> +        # has to be split. qemu-io caps one write at 2G, hence three.
> +        case = Case(2560 * MB, [(0, 1024 * MB, 'zero'),
> +                                (1024 * MB, 1024 * MB, 'zero'),
> +                                (2048 * MB, 512 * MB, 'zero')])
> +        self.add_source(case)
> +        self.backup_and_check('full', case)
> +
> +    def test_tail_data(self):
> +        self.add_source(TAIL_DATA)
> +        self.backup_and_check('full', TAIL_DATA)
> +
> +    def test_tail_zero(self):
> +        self.add_source(TAIL_ZERO)
> +        self.backup_and_check('full', TAIL_ZERO)
> +
> +    def test_tail_zero_bitmap(self):
> +        # Same tail rounding as test_tail_zero, via the bitmap scan.
> +        self.add_source(TAIL_ZERO)
> +        self.dirty_layout(TAIL_ZERO)
> +        self.backup_and_check('bitmap', TAIL_ZERO, bitmap='bm0',
> +                              bitmap_mode='never')
> +
> +    def test_mixed_cluster(self):
> +        # 4K source clusters, so content varies inside one 64K cluster.
> +        case = Case(2 * CLUSTER, [
> +            (0, 8 * 1024, 'zero'),
> +            (8 * 1024, 8 * 1024, 'data'),
> +            (CLUSTER, CLUSTER, 'zero'),
> +        ], [
> +            # A mixed cluster must be data, or the data at [8k, 16k) is lost.
> +            (0, CLUSTER, 'data'),
> +            (CLUSTER, CLUSTER, 'zero'),
> +        ])
> +        self.add_source(case, opts='cluster_size=4k')
> +        self.backup_and_check('full', case)
> +
> +    def test_top_zero_broken(self):
> +        # An overlay hole before an explicit-zero run: the zero prefix
> +        # must stop at the hole, or the backing data under it is lost.
> +        size = 2 * CLUSTER
> +        create_image(base_img, size, opts='cluster_size=4k')
> +        qemu_io('-c', f'write -P 0x33 0 {size}', base_img)
> +
> +        # [0, 4k) stays a hole, the zero run spills into cluster 1.
> +        case = Case(size, [(4096, CLUSTER, 'zero')])
> +        self.add_source(case, backing=base_img, opts='cluster_size=4k')
> +
> +        self.do_backup('top', case, target_backing=base_img)
> +        self.assertTrue(compare_images(source_img, target_img))
> +
> +    def test_bitmap_straddle(self):
> +        # One dirty run straddling a zero/data transition, both ways.
> +        case = Case(SIZE, [])
> +        self.add_source(case)
> +        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
> +
> +        # One contiguous dirty run each: [7M, 9M) zero to data, and
> +        # [15M, 17M) data to zero.
> +        self.write_layout([
> +            (7 * MB, MB, 'zero'),
> +            (8 * MB, MB, 'data'),
> +            (15 * MB, MB, 'data'),
> +            (16 * MB, MB, 'zero'),
> +        ])
> +
> +        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never')
> +        self.assertTrue(compare_images(source_img, target_img))

Minor: shouldn't we do assert_map() here?  IIUC the target image map
must be fixed in this case.

I've only found minor issues here, so with or without:
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

