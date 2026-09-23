Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D7C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Ots-0001YE-BK; Wed, 23 Sep 2026 11:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Otq-0001Y4-6l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:28:46 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x9Oto-0006vU-FN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:28:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va3kz575FCGCC/YWVzD3nFvHH9u5Zwk1PlNyC9oZbSz2oMosXq0eveFboB1+43vFxB5kK5ebgZpx/8VvdxbGwhJ4pygJ1oUMjmHrlSZVehRCob4ie1CFf1rR/yB8S9QPEl0hqKk+meVq+GI3WJf+Xwtcmv4y7F3RtQPMMg3qGw7w4lJk63x+3hUsz15WOhU7tW9U2TWakZ7+dvmwRStauTkLGqHRVtnC0/3qCXGMLsJt/CCMtoGBO5vbfg52AF3GKaahvyZhxKLdWhkshHukErF0JEZw4RDT0SFBYFx6zDlll0mXh0WQrkgwAtS7T9p/GV5zZW2TnxkK2xvCh6mBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLg2weFY8B24/ef9fWHwvLFn7/GZw9X+4AswIY/m2dk=;
 b=doYB8+sE3r344jR9X0lAL3S2jRfQI4+rmubJTEUHGBuWRT2rCgMQroNjCwKeN2ugJ8ycGPQuRfTIji3D0zTP0xSDBsRkL/k297TI4T+xbEJHyPQufmAxDlF1yw32Kl2hWlHJAt9Bzqb7+1KonhLjthuHX2NkFVjD5xP1PeIFqvltMrwmziy7yKPpOVehKGmMgznHfCg3pdIjPCtmfc6nJZUCFQMbxZhgdsu7P9zALHc2JGHjFQd8VjQ7dswxgmpXJmhnBSga4MYI+VQiv78nN78NSa6Xxp1TBkcwAi0FGhqNtrlrvoWaUNwiKAoQZVNb3o417LA4ehIsYoTPaWqo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLg2weFY8B24/ef9fWHwvLFn7/GZw9X+4AswIY/m2dk=;
 b=Ro+WSqW5zAkiUSGZcDaz6izBPES/X6tr1k5Ol5bkln942BWQRJO52IRjavgYIxm1iXE9aJLT+o7hjPALjhvdFBh8tJRY9zI2qxyRlCtSJxN8sVeU94PS2TRgU5l7GmWlpSJTFz5c2ft6X2sgT/piKhbaXYZ1ZrnlMqqGgdZ0ZkLDyZwH3sQ+iP/PPOIFIZbpnT1B1AI3Mj4GcCCSPpOJTBpNFCC4inxs7A/5o1Xg8nxfKCVfK/C0pW2FuPkQO27o0Cq2BelxHXRd8ac3ysNHI3aU37163RIehmcobI+vA85mrdNxy6QzsUvxEA+OTdf/ZoFwl9Gu+5UShIwBUEcJWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8476.eurprd08.prod.outlook.com
 (2603:10a6:150:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:28:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:28:38 +0000
Message-ID: <28fc03f8-6383-4036-a405-fb3e70f49a6b@virtuozzo.com>
Date: Wed, 23 Sep 2026 18:28:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] scripts/qemugdb: some fixes for 'qemu bt' / 'qemu
 coroutine' commands
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a97cae-60ce-4a83-0109-08df198756a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +x3tzzhVHaLdzTQIghZJl+zGgXMcNXy2YJa1wfNP8RFKWPmwDt3nZ42fakuVBlMFAUNmV5ihfiOrt7F30U81ggxdhxlo5BDBO6QaoUHNFu8U/3pRLMYMe4gi2PyU7TfdO+PXAyWMRg1Xndw7+t8JNHVIEXCEo3ML5ErTMt4Nfd39q2YvImS6H+Zw1FI588bnEtmgv3XbbMwSJbfyptAvpDSaaXuR+Mjh4K64uju7OxjC/jFGxWpRprFwrQb5BPxU366bUluG7alj0mIg+Pd7l3CKdPGMLt18YMKZihshWakBm7tOBV9vcf2Uu5eaiHXDfL4PRsZIGPZrW9MBnHG86GqPZy+hJV3IuTgc6+7xay82EalBSc+QQufKun6fGUSslCO2yVj2VftRHZNQU4x60hFF96Zu2nhdFOdWcSRICrwXHBgsh3Z4LLe46aaFX1pxv8LeJrCmJGtioJcGSy04WgJ/dQo2gx6oB/Ob5UJ2SPyH2DRL7ksTNPOkTPHzaCJKPUE2z6nP2soKKkA1nfUDaRBZvf/NwVcqUWGAXhi+NZolrkmNTDSqNtfcOvKyJt/BYS+yE0xiF0GHWPQScrWgxoEnRs3jWq8DIXpOroaz+5cKFwtXXwV9Zqd8rgZcTE9e3sC7ALu8blg7NKhdYLeGcWdYwyTd8o1HpgCDzjg0weQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNGSlVCalVCYW1oWEdheW1FR0JkR1MwK0N5d2FFaTNVZXBFWm5YbC82RDd2?=
 =?utf-8?B?K3R6V0ordXpBSXZET3JSZFdwNzBmemZDbVc0NWMzaTFUdUZGakZKRDJlOHIy?=
 =?utf-8?B?YjRBcTdaT3RkeERRZnhZNldwcGtsUnhzYVlHRzhtVzB2Y1VHRDFoSGhRVWZB?=
 =?utf-8?B?Qnh0RCs4Q2FGNFkxL2tEdHNrSHFMVk12Zmd0UTJQZjB5MUh4ZDA3RWx6bS9p?=
 =?utf-8?B?TktjYk1IcTNxbkg4cVlQbmt3am5KMUF4eTM0RmJQUHFWaDA5U0p6cmVIeTFo?=
 =?utf-8?B?YzEyTW1qOUQySUcrczZpUnIyZXE5SU84YXFid3BrcVBKdzNsc00xSEFFTkZE?=
 =?utf-8?B?TzlFWTJsampVWU5ENDByVVNvb3ZsN3JMZjZEV1hGeXEyY2pSSzJNRSttUWVx?=
 =?utf-8?B?emRpTFdKYkc5and3eWQ1QjNHUXVpN0p0SnFhc0RoYnJUdUdEdHY4aWRKWENy?=
 =?utf-8?B?My8vNmlVRFRCd2tzOUx0NDE5cGZJNXJVOFkzK3F4QVhjRjBYT3ZLOEVLK1hu?=
 =?utf-8?B?SDZuZWI3NGFjWkhUSWkyZ1pCVld3eldBTnBRZ0dSWmtqcXNXb3dQalFRN1ZF?=
 =?utf-8?B?T1FDT2Rvc04zcnB1Z1MvK0hJYkFvTUZhdSsyMURad0NubjJ6VEtOdit6bmZk?=
 =?utf-8?B?QjZ2Q1ZMRXZwSUJvdW05N05qL1F3S3JmcENyamw1aWdwSXRJRWVlWXh3Sytu?=
 =?utf-8?B?ZzZTUnpoOFdmeEc2TFVHekoyOVVxTUV3NFJ1NW92QXBOUWs3VW04cFduVmRT?=
 =?utf-8?B?QURLTnhOQytOUlAxYTNwL3JPMHBua1VaQndSbytKb1htQlBtY3l2TFg3MWVk?=
 =?utf-8?B?YjFSeG8rb25KTmxOdnlMME1FOUJKT1NUZzBadUJZbmZ2VUxDcXgzMzB3TG1w?=
 =?utf-8?B?Uis3VElGUkVRM3pMS2tNK2hHSnplOWMvNlhIVzdFdFlQREIwaUNQekxDRDlo?=
 =?utf-8?B?SXpwK0ZUNVZKa1hpZnVTcVBhU0k2d3RydHBoZVZlaW9oVUJGYzRBcFhLK05u?=
 =?utf-8?B?anN0RzdDdWxkZXZ5TlZtUnhmR0RXTzgwYTVHZ01pWEEyNzl2YnNzZlpDZEFQ?=
 =?utf-8?B?Z3VxVjA4cmJ0d1RGNm1taXFEVE10TlhnM1V2WVYyc3V1L3M2WWVBNTNjQnp5?=
 =?utf-8?B?aUVtY1ZTMmFEVkxrZW9hakZya0RZdzRoMzk3dVpSbzhJYUxwWE91OWtGanVW?=
 =?utf-8?B?dGtUR2xibHgweEJITkJ6ZFRYbmN4OXIyMDYwSlRLZE5LMmJ3bEZYeTk1VzhQ?=
 =?utf-8?B?VHpGNE5LTFdNY21ROVZvaU1kdlJQUmpsaWNsN2N2V2pkVzVMdE92Tnk2TkVk?=
 =?utf-8?B?dTdYUUVBVStua1JoNGU0Y1FFSGNjV2FXSXlOUGpxR0gzelBNZURaazlEMjVC?=
 =?utf-8?B?Lzd6SHl1SHgwQnAxUlpuVG9lYTQyNC9CbmtvZERTcm54N2VmcXplaTJzWTNp?=
 =?utf-8?B?M2h6SXlTVVZDemVwTmNRSVEzWmdWcDlRK2w5REJGZ1VEMW1QN3hXRUVRZStK?=
 =?utf-8?B?bTlIN1VGYlVBWGg4Y2RKbUVDUVYxTUUzbDFqNGJPdUpDVUFjdlhkWFVsSUty?=
 =?utf-8?B?TDUwWnZsdXlZQ2tHR21pVjBPTnJlZ09VR2oyNWpCVE5BQ3VXVmdqbVpQYmlQ?=
 =?utf-8?B?QWJoMkhVY1NwcU5HNkZsR0RZSXZqcUFuYmZVREFCc3J6SFhTTk1nbG92SWxs?=
 =?utf-8?B?ditQQ2U1WUl2Zk91alVMUkx1K3Buc24zVDF5RDlRTG81TVY3NzZ4YzFSZWxj?=
 =?utf-8?B?VE95ekdOZlRXcUZ3WVUwd0RIWFVEQmlwT0NBTXloamdLYkpjNzcrd2N5U0xl?=
 =?utf-8?B?aWVtbTdjZElLQjNiaUs5cWpMYlBZdnZWVlVSQmFWNGVzc2tSZEIxR1k5V2Zk?=
 =?utf-8?B?ZWs2WFIyNGJucDFBY1BjTGlQbGpvc3NGM1U2aFVhSW1qSmh6aUZCak1FRTkx?=
 =?utf-8?B?RFkzZ2cwTjY0N2hpWUhmc0VNbHc5R2k2cWVxMDNhZm0rc0MwWUptWnpURUZm?=
 =?utf-8?B?VHBzR0hJQTMzL283clhIK3Z5ZDIyaFJ2NlNSRXdRT2hlQkI2dXkwNmttS3pT?=
 =?utf-8?B?LzZQQ2dwRG9rb21zWmRxTGdDTm5BUHJCYk5ySlovV3Zpek5hcDdQdlZXWnZ2?=
 =?utf-8?B?OXJpSkFZZHUzTXlpQ1hEbVpwVlIrOEpxMnpMTzVTdXdrR0E3ZkpUZnd1ckxH?=
 =?utf-8?B?NEluNlhxTUZiYm5aZVloNSs4Y1MvSmZpd2lmV1FxYW5SL0JNNDhXRWFmdHFW?=
 =?utf-8?B?TmhPYjRMeTAwY0YvYXBFU2J1RWJ0SVNrS056d0hRNW1pNnZlbGk3L3luUXo3?=
 =?utf-8?B?MFBkclo5VGQwSndMenl1YTcxT1lSS0JndDdid0c0L0NEd3EvVXJtalBhdE90?=
 =?utf-8?Q?UnKhXhmfdomCaHiU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a97cae-60ce-4a83-0109-08df198756a9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:28:37.8893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPDwh7JYNjLtkLdHaMPKbEbo+wKYY6g4d9D7jbTOyHkSl2B1twIF8/Mm0LCGdgaKmQAsLQOt6gH/QtswnZgk2AgjhSiwIs2YJMnivxDVETw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8476
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 8/4/26 6:17 PM, Andrey Drobyshev wrote:
> A bunch of fixes for functional bugs, cosmetic improvements and fixes
> for annoying failures and corner cases which I encounter when using this
> script in gdb sessions.  Most of them are basically fixups for my previous
> commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
> detailed trace in coredump").  Still I did split them up cause it'd be a
> mess putting them all together.
> 
> Andrey Drobyshev (9):
>   scripts/qemugdb: coroutine: Fix selected frame leak on error path
>   scripts/qemugdb: coroutine: Get rid of fallback pattern when dumping
>     backtrace
>   scripts/qemugdb: coroutine: Only attempt to restore regs in coredump
>   scripts/qemugdb: coroutine: Don't unwind past the outermost frame
>   scripts/qemugdb: coroutine: Fix patching pt_regs in the coredump
>   scripts/qemugdb: coroutine: Fix '--detailed' description
>   scripts/qemugdb: coroutine: Handle target absence gracefully
>   scripts/qemugdb: coroutine: Speed up coroutine lookup in a coredump
>   scripts/qemugdb: coroutine: Don't touch the coredump for a plain
>     backtrace
> 
>  scripts/qemugdb/coroutine.py | 135 ++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 49 deletions(-)

Friendly ping

If someone else is using this tool for debugging - there're some genuine
bug fixes in this series.  The bugs were also introduced by me, so
that's more of a cleanup :)

Andrey

