Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9N1H-0003Yu-Uv; Tue, 21 May 2024 06:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9N1E-0003VS-NF; Tue, 21 May 2024 06:46:56 -0400
Received: from mail-am7eur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260e::701]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9N1B-0006lm-Pw; Tue, 21 May 2024 06:46:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwnU2JK2NNpRLzRnofgcv6tKA1zTvifc21yzvtPgN7jJCfnLOZhceMp46FaMXQ2Q09qPCghR07NBpiTnfXeayjeZ6dmHsndvGlKyXC56wE+iXWf4CDhMc7ORb7/VKwZJ2nWF5NXY3VM45kiO3GrXoLpuAgU1JOqK9ywJJzC78qn6ETarQqnXRnHB9O/y+HdrudIs1FPC+91cxMo346mCJIXI0pzpttafz0JjrJFFMXDbF9e4Hq4tvKYkgzsvHuxo7rkc+gHPaTvzLTk0+A7t6MxOuQgdC4Pt4BKFqQ/4RAr8p5jFa7wHaIkwq77QYNf8PrSkvuFhmTtS69AYBIZ+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baKsu67GbUR48avJeq39sW90lMsAhFuOH66epB15J7o=;
 b=TZ/iUY9FjzuVqKhElmZLg9fNfCbpTWkS7LDwELpmCBve7VNYyzL0fnlfanlwwjApBb6RIM7tD6yXJtM07TqnDiUXY1Qyh+9jkSHkqQ5xCtB6nfNbxKIoh0tKU4pBKk+L7Idl8in+ATTmIGZ+GSZdY62LJbbcBXygk6N6Y4QhPpF+7zz9DOBtWgsxpadp/TyAx/RIx0OesMgq9fdiG+u3gDFH1iTn82+AHtz0MqPrhWlAfj01rrfQe4R59VUbHx5UqOgAa82j/1u5RBKcskkeFcNYk3xhVoTfqZ8XuFw4NpbpT75On/cel1+dOk5A/CLg3LtN/DfkiFitP2b0Gt+QqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baKsu67GbUR48avJeq39sW90lMsAhFuOH66epB15J7o=;
 b=NqeeyNTKCK4rPWKg2ES7hIRPhc/WL4Q508D3LOypF/5SaeSurNieNniS/ibH7HbaqbNIdtdeOnBOGG5HIowmbEXU5DeyKC2KTYbDJtPGMXN/dZ7eVB82vpQWM/NqsUpYiRxl+KQpggcsTMqQeReKl8e08fYPR3FyAZy839AoyOY20dzjPIGnA51UtURhTwB03+ukq5Wml9A8jCdVpzYiPxsTyWtvabCLw7qr30T1xjc0DIFcQcY/So1R7ZgE/ZdsSIhQHxnYHO86rPyXCfgLjW9lhGFXxiMA+hlv7lo3iY97O3NLFnPcjwURPTcWm4y446ywagxCwsXTvWTjYtPrdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB6458.eurprd08.prod.outlook.com
 (2603:10a6:10:258::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 10:46:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 10:46:48 +0000
Message-ID: <cf9964c9-3775-41ad-8077-3d1a4fc68090@virtuozzo.com>
Date: Tue, 21 May 2024 12:46:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] qcow2: zero_l2_subclusters: fall through to
 discard operation when requested
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-11-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-11-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::14) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c18d3fd-4287-43ab-6bd1-08dc79835084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekhtdTl2SXdzRnRDSEJBdGNzNDc0eWNyQ2xjVDNmK2Zkcm5CYlpsdU1VK0xQ?=
 =?utf-8?B?a0FwWXNnYVdXYlFRV3Q2Z2J6M0ZSbGQ4Mld3UEdvME5qQlNrRnd1YXRwRUFG?=
 =?utf-8?B?Z1F4YWtRL1YzVnlEK1RJZ3hNeWdFY0h5dnljM204ZDV3TkdhSkZpQjNPMUZ2?=
 =?utf-8?B?emtUVWVmaEI2MVJKUll1V2taUURXcmFXWDVmM3VqeXIvWGtyNVhhZWNwamRL?=
 =?utf-8?B?MUYwelA0aGYycEY4NUtsRkVVYW10N0VBbkM2US9WOHNmbG4zeGRkSXIxT2w4?=
 =?utf-8?B?NncwTmNkTHFaMitFRVZRSVdtQVFPdkVZTTNTb2dwaTB1QTNXM1NnWkhiRzBu?=
 =?utf-8?B?VklLVzA0THhYbWZmdHNQZ21kUEtaNU9xUjNkRVRzU0MraUxVdFphbURUcVJF?=
 =?utf-8?B?Zk9kbE0veENIQ3ZST2YrL21aekpia1JRYWgzanpBZGJRclNGVi9KaUZaVFB1?=
 =?utf-8?B?d0RFWWxZMGNZQTk2MjgxVHZlMHRxajZreFpiTDNuY3lQcW5hMHRWdGN3ZXUz?=
 =?utf-8?B?cFZFRjlLRmxwbmQycEEwNldXLzZwRmlsR3hZWmozUWNEZUFnamhlVTF3Yi84?=
 =?utf-8?B?Yzc3eVBrRzlsRU1LNmNYVG9uOUtkdHVlY2E5dHpvbzVYU2FldGJPMVo0UWlF?=
 =?utf-8?B?WWY1eEg2cURUQ29mSU9XSmd0NVU3UWFIUG1ScFZpK3p1Y0FuNGdGMks4bDZm?=
 =?utf-8?B?cDJITTFpbmZ4d3FXNVRzOE5EOHpEWkhRcXZzQjN3d0FDbVBmVUFMTVBQMkhN?=
 =?utf-8?B?MzlkS0thbGVEUU9MWWhoRHBuVE9LRnVYQW1MN1l1UG1ITjRqc0Z3YnJqS01x?=
 =?utf-8?B?Nmlsd0YzUG9YTG51Z2FNK3A4dW16RWhxQzJxUXp1ZU52VXZaYXZ2MElPZXVS?=
 =?utf-8?B?THdlTnBRTnc5aEtvZFBjMk90YklaaTJRK29yTUFyS2FSazhMQkxaRXZjcjBK?=
 =?utf-8?B?Vlp2NFo4dWhhVkJCZWh3aU5Tc0daNDNNeUFGaUl0L2ZGUGMwekp5ZUJwb2Q2?=
 =?utf-8?B?d01jTnRvSUdnOE56aWQ3dDdNbHNtbTZpd1c5M3RkRk1PdUNVbXlNR3FDd2FI?=
 =?utf-8?B?WlUrUmd1d3Yvdk1YU2hTSzdnTzdTZzJKTGcxNzJiSVFmMEE1bnVCdTFZeEZw?=
 =?utf-8?B?My9FY254emhBdDN6NkZVN2dOcjBydldVb09zN0pzM2g3RFUyUnNIc2V4bDBG?=
 =?utf-8?B?bnl6VnRreGluQTRUTDR3Vno5NDMrL0E3L01tb0N2UjBPWUczRDlSdktuSGJG?=
 =?utf-8?B?THdUaWgybVdpTk40T05RVmNjak5yWGRtRnZBSFcrd2Rlc2dFUDlobXliWW9w?=
 =?utf-8?B?QmFzdFRHVlJaWDk1TURtR2JobzZGdWhnZ2d0clhtSFpzdVl5cWIwWXg2YzA4?=
 =?utf-8?B?NkRoVXBoNmEwNFl1NE9RL1dkWklCUS9RNGpPTEFjSUhoZFBxMmtodURBMUhR?=
 =?utf-8?B?cS84WElmTDVZSThpUzNVM1FEMHl1WWpTRlZkNkExbW1sVWRCWXNIWXF4Q1dG?=
 =?utf-8?B?TnNDRU54YnpsYWVVem9ZNkZLcVlOc1psdjdGcVFFWDMva2k5em9hTFpzQlVK?=
 =?utf-8?B?M1JER0U2Ny9qTGU3OC9rQTJzSnFiN3BUNUFBeGh5QXdmTm5kcVpKb2pmVHVp?=
 =?utf-8?B?T2tucllWaGJHZmNiQThFbU5UbXRxNCtvYjdMZUhFQlJJenRWQmd4Z1k0dGZj?=
 =?utf-8?B?SGk1eWY0RkNBVHluN2MxWDh5MCs1SStaSHpTcElNcDJVbWtVUTFNcWxnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5Vc1psQXR1S3dIQ0tuTDczYUZEUzVjTTg5dk1HeWorTVIxclU1bEg4Z29X?=
 =?utf-8?B?R3d1RVd4Yk5GMC9lckNJY0pyWGJPQ1hWZUk2N0gxN3J1NnJjbzBxakw5N2tL?=
 =?utf-8?B?TkRnbHY5L0FyTU5vS1p0UEhGTWl2cDBQdkpuVGxnMXVNNWF6K3l6S1Fyc0pO?=
 =?utf-8?B?dXpqenlPZ2JKaXhpUmlkTWhxY1RZUktISlR5SXFHZVdjanVORkIyTWEwK1hS?=
 =?utf-8?B?Q3R6ZDdlU3dKazQ1b2g5UmZ1YTdaM1NXeG92Y1g4d25ydlFLYUpKdVBjcFB5?=
 =?utf-8?B?d2tINTM5N0dRMXlENnJCYzFmOHM2eUFkS3NBcDJPWG5FT1I3Nyt2SU5sejhY?=
 =?utf-8?B?N2M0UXlJSEZsMW9QbEl6RTVuT0ZReldqUEk1R05xNlF2S0F2bTh4c2V5bVc0?=
 =?utf-8?B?WEorWVZyZkY0bmkwdFJiSmVUdnd5SlRmSGRxMjcxcWYyNWZ4cDBiYWdhMEU2?=
 =?utf-8?B?RGcyanlvT1BiZWhRY3dFdHozcHdBS1NUYnJNekJBNFBWd1JYMDRCNUtGQ084?=
 =?utf-8?B?NW5GdzZsNzh1ZWQwTTVUOTk5R2Zxc0tBRUZRa3hRV3czQS9jRnFrSUdVaXVu?=
 =?utf-8?B?TVBOT1NtcmFYNk5BQnlpZWRDVmpSaDVNUW9DbVQxZk80ak9XUkV3eE1JWFRC?=
 =?utf-8?B?ODVrL0t5VVpmNjNzb2dFVVV0ZEpaSjEvZDVUWHpwYnlJTUt0dEVtWU5mZTJW?=
 =?utf-8?B?ZGNnUzF0cnV5aGF4UUxrUlBYdFEzTXd4WEdqRjliclMwZmVHZ0ZpL0JVdjQw?=
 =?utf-8?B?SWZ4NkRuRzJETFk2NytON3Bnd3lxVDJDQnRSSmJ2MmtmTHp2VlVMQUJYTy9y?=
 =?utf-8?B?ZWlpaWxjUjN0cGlUNVdmVmxOU0JnSE1LZXF0YTQzbXZBcEhnV3cyZHlIOGZR?=
 =?utf-8?B?a0xsaThaRlZPeEtJQ0taM1l1WVM3RmhoOCtGYXZoUlpDYk5yMUcwTW9rN3Ft?=
 =?utf-8?B?a2M0dUxUdVQ2OCt2V1ZTVDhJeWNQQVZIbFR6dEpib3JCdDMwWWdaM294VXRu?=
 =?utf-8?B?NVNCVjlUKzFCOENhME5hSTR1RWJ4cVF0SFRDT1Z4Z1hqckZ6UmlWdzNRaTVS?=
 =?utf-8?B?cUtManQycVBIZkhlekxQbW1kMGlsbjV2SmNqTDA1UEwxME1FOVlIMjlvM2xl?=
 =?utf-8?B?TW9abUZuaXR6K0NHNHpxemF5Nm1EcllJRVppS0tqV3NvRVo3QXFrVERqZUpz?=
 =?utf-8?B?K3hJT3hFU09DbG9jaVlhdmJhdU5JeWY4YU1NNjZYNkc4Z1Jrd0dqV1lGSG5U?=
 =?utf-8?B?TVc0MUIzZU9sWE5CYW1wRDFWbHBDS0FVRXJzcXlkQ3FCWW9UNzJTS2t4MkVE?=
 =?utf-8?B?VFJNNVIxSDIzZit5cGtzemkyaEZPKzRmZVVqa1ptM1RmSGRjaTRpS1FMWnhY?=
 =?utf-8?B?ZjEycHRWQXErVGZwdG1CVmx0b3psNkpPNDNXUElNN3BtMXd6NXBveDh0eUJ0?=
 =?utf-8?B?K1Z4eXN5V1QrQnZKakQ2OXNUblJYbVBpak5XUUgrNkttZGhzNWwxcTFQVEw5?=
 =?utf-8?B?T2Y2RkpRU1dpd3F4Vzc1NFR6UjB3Z01Hd2RRS0o0MHJDWjBOWDNUank0ZFV3?=
 =?utf-8?B?QWNBNEtaWWg3SVJPNWJTQXVXa01tQnpEMEhzSnZFeTB5ODlwRUEyaGFmRzNk?=
 =?utf-8?B?K045a2pKM2I3OFh4QkhwOGJMcVo2QUhibWg3NncxV3FTdDJDclpISlA2bnJP?=
 =?utf-8?B?T1ZDRXVaRWk3REJRdFhONENkR2Zwd2RDL0R5aVdnZWpELzN1YW5DWTZmT1ph?=
 =?utf-8?B?Q05RdmZhV0RVN2RsQnc0Qkw4NndXRDBObWRtcnpNaVlkWCtYL2Fxd0lFc1d0?=
 =?utf-8?B?Y1R5eU51eHhIa25ibGdPSEFJNXlZcG5FSlRRV2ZFTmQrM0xpcUZZd25lb3ds?=
 =?utf-8?B?cXhXUUE4azNFaUY2akkvOVFuRFd4dnp5eXBzQ2hNZHdvSVJKaU01Q1FKc1dl?=
 =?utf-8?B?YTVqczNrV1RkUzAxdTd5OFY3WldKSzBUWGswTHhXbGNzeFRUUmlQMlpHcmlX?=
 =?utf-8?B?bUY4SWt0U25jMndiQSt2SlU3Y0pnYThYMnp5R0VWTTFJcXBZaStUSVB0YWg4?=
 =?utf-8?B?ZUNTQW94YUUyZ1Z1RUFKRnZCMTBYdFdRbElwbFV4eFhzU0F1RVMxUStYenFa?=
 =?utf-8?B?VnRQbHY4ZmdXNTdDUHBJWk91N1JJTDRLbzAwQy81ZFZCYUFNWUE2TE5nSzE1?=
 =?utf-8?Q?IxFLe+XbaKakaQuJsopaAxg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c18d3fd-4287-43ab-6bd1-08dc79835084
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:46:47.9521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjuzLi2ouEX5/Jj/AoOitsIy2UxpX3K7QAaDK6JnwYuSJ6IOrkq93UmehDeTIGky56M6QzzLbb766a1lygefHVfVjpdt1sdGrKnMQ9p3K50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6458
Received-SPF: pass client-ip=2a01:111:f403:260e::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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



On 5/13/24 08:32, Andrey Drobyshev wrote:
> When zeroizing subclusters within single cluster, detect usage of the
> BDRV_REQ_MAY_UNMAP flag and fall through to the subcluster-based discard
> operation, much like it's done with the cluster-based discards.  That
> way subcluster-aligned operations "qemu-io -c 'write -z -u ...'" will
> lead to actual unmap.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 3c134a7e80..53e04eff93 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2107,15 +2107,16 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>   
>   static int coroutine_fn GRAPH_RDLOCK
>   discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
> -                       uint64_t nb_subclusters,
> -                       enum qcow2_discard_type type,
> -                       bool full_discard)
> +                       uint64_t nb_subclusters, enum qcow2_discard_type type,
> +                       bool full_discard, bool uncond_zeroize)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       uint64_t new_l2_bitmap, bitmap_alloc_mask, bitmap_zero_mask;
>       int ret, sc = offset_to_sc_index(s, offset);
>       g_auto(SubClusterRangeInfo) scri = { 0 };
>   
> +    assert(!(full_discard && uncond_zeroize));
> +
>       ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>       if (ret < 0) {
>           return ret;
> @@ -2140,7 +2141,8 @@ discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>        */
>       if (full_discard) {
>           new_l2_bitmap &= ~bitmap_zero_mask;
> -    } else if (bs->backing || scri.l2_bitmap & bitmap_alloc_mask) {
> +    } else if (uncond_zeroize || bs->backing ||
> +               scri.l2_bitmap & bitmap_alloc_mask) {
>           new_l2_bitmap |= bitmap_zero_mask;
>       }
>   
> @@ -2197,7 +2199,7 @@ int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
>       if (head) {
>           ret = discard_l2_subclusters(bs, offset - head,
>                                        size_to_subclusters(s, head), type,
> -                                     full_discard);
> +                                     full_discard, false);
>           if (ret < 0) {
>               goto fail;
>           }
> @@ -2221,7 +2223,7 @@ int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
>       if (tail) {
>           ret = discard_l2_subclusters(bs, end_offset,
>                                        size_to_subclusters(s, tail), type,
> -                                     full_discard);
> +                                     full_discard, false);
>           if (ret < 0) {
>               goto fail;
>           }
> @@ -2318,6 +2320,18 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
>       int ret, sc = offset_to_sc_index(s, offset);
>       g_auto(SubClusterRangeInfo) scri = { 0 };
>   
> +    /*
> +     * If the request allows discarding subclusters we go down the discard
> +     * path regardless of their allocation status.  After the discard
> +     * operation with full_discard=false subclusters are going to be read as
> +     * zeroes anyway.  But we make sure that subclusters are explicitly
> +     * zeroed anyway with uncond_zeroize=true.
> +     */
> +    if (flags & BDRV_REQ_MAY_UNMAP) {
> +        return discard_l2_subclusters(bs, offset, nb_subclusters,
> +                                      QCOW2_DISCARD_REQUEST, false, true);
> +    }
> +
>       ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
>       if (ret < 0) {
>           return ret;
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


