Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E57C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXhGI-0006Fq-8N; Wed, 07 Feb 2024 07:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rXhGH-0006Fc-3p; Wed, 07 Feb 2024 07:42:45 -0500
Received: from mail-vi1eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2613::701]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rXhGE-0003Nd-JA; Wed, 07 Feb 2024 07:42:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVcbjl/50wZXiQK4u3U2bfkklSZk9thtKCAMRVSCVdiL5uagDqRPZHmbQ2ElLaqgFvUiX0QWdFyExMh1yM5dLqBDXT6KUgxOIA6C5Gu7OKOA1EAThAzl86qtyzn2FWUfJKI6VtKGW/0nHhktNepLm0yN9WRkIQmBsGyutgXsFAjXYXNY4bMWB0APEcymhM7JCbWZ9rrGADFng0nt8D2kSg1zpSbhQXaf7nnF++/XqbklaMQ2CMB3NttuqQ5FMVnZpEU8U0feWap6weDydOFDP7zAgCAbAnA62Dwrg3VXQ8bVxnQdmasHch5TkS3iKgqntCCK/Nn5NIvnUHZXz1AKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zw9hmzwiAdpzfL4c1F8FaGvurPYPOWKMWV/8s1Tx62M=;
 b=gj2jmOWi4ufAMwZkRRYNi6f5XzhjrAYiIhKtWRmtVaux4DfbSRF2jp7vxD9+RJI0RF8Ifp93vA2HxLPuhBwImXjFZlsiV9w5gOEmLgDwiD1ICgqR//zXX7CJem3q+FiiTMgsUQDloSH3ZJqOO95UzAo/xa3ys8Zd9a1a2Zg73vCFLFv2+CDIh77agEfJSeBtg34hRUVfXHRMaknLgDKPiMUo9D5YnE5IL6M/fM5mo7lIheS1Whm9pWYrFhFOW5YkxZTXxLXbQ+e3FIeqjIa2xlGnlKWLsxEQfUw5yaG431FZfU9p4yOekudaHqz+nf5HBVEO0hFZKO2Cl7KzGJvBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zw9hmzwiAdpzfL4c1F8FaGvurPYPOWKMWV/8s1Tx62M=;
 b=Mo7247bRjcWhLyBO6B11bVFUr08wOsVTnQbcJmNiS37vy+37dmRnzUVBrYfILNTFqEOX8HhhfqwYCh25UurB6pSrWn3nza292cJ4a9hlM8hAbvTKf+tDxov7LmtRt5Cm6UtBpzqtQekDNG6zqbnQcoDlDzj0CMzO+CniRMeQvJiiMr8avsG3xwQVNEcC2aXL5SYyCmElxWUw2RM20XLZbP2CLyVGM8cmjp+yCISFMutee8EfmO9JRsijb8XHyePc07HMCmOi1aPNSjkUlEGGQ3BE4UZugee00f1a/EBP0q6xTEUsJGmToHODOzjpZr74S9hbH56/7HzlPCBVQEkdtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6422.eurprd08.prod.outlook.com
 (2603:10a6:20b:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 12:42:37 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::567e:e2db:3928:5839%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:42:37 +0000
Message-ID: <74f61989-8253-4ecf-b726-724db639440c@virtuozzo.com>
Date: Wed, 7 Feb 2024 13:42:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/21] parallels: Add dirty bitmaps saving
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-12-alexander.ivanov@virtuozzo.com>
 <2d6b35c5-5708-4403-ba48-c46c50ce40d0@virtuozzo.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <2d6b35c5-5708-4403-ba48-c46c50ce40d0@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0159.eurprd07.prod.outlook.com
 (2603:10a6:802:16::46) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2eab2c-c42f-467a-5d20-08dc27da437c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDKeFLYopLmTnnbjNGcNJir0c4yzRkFTtE78JUYlkN8kgXOKGdsmZIu5VZkpk/Q57EWnjdlG2RULZZc6xIl57ngFDHXJQRlH3SJwadNJ305mgE8nw2L/zYf+0nxU5dywH5iPEx7uhsanki+5tT8VzPNY0cVc+PTzq4Vn1o0KjkBmYlDJOjQa0mG+1ssOD3HytC8cgUa/ZyN57RTcAb8b55BGmujgcTkr0pQvj+jWSts3Fzjl9BMt7v7DIjoIA3YW9f2xZ6f0ParE71p4380EH9bbz2DmT7l1WldcjKaXkzY+F667F8b8FKF5MTdPAkQc0HlAKJAW/T/qOAsroN71hLSkSuIFy11mj6WxZlwXsNMS3tjYcgmEEZcZmZT6eAQFDWHI8FXJMLoGIQbd0z/rynsUe+fMTVI8kaozn1bSkY9CjoWyiOihgLepY6bGDjC6DSdk/Zvzkigo1u8+resPfjucSQpNcgC9Z8HmO88S2QgoVm9ZtY8QlEp70T4bpoGFe2z24PxzO+efRq2KlLpcZceiZPzl7lNd+5ef8CYYSS0dwvanHXeIeeRv1HKxjFYyolgpOq2in1i6A2Eh7KtdDrvTCDrMNWMdhK2Sr9URY7lmU3fyNYtVclrLbSnYv7qv+ZhQF7pc/RNC44PL6HRM0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31696002)(86362001)(31686004)(41300700001)(8936002)(316002)(8676002)(44832011)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(2616005)(26005)(5660300002)(4326008)(30864003)(2906002)(6506007)(6666004)(53546011)(478600001)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzV5d3dUbEwyUmEyK2d0b3RNUWx1WUh0MTJJVGo2VTY1VGgvaEJESEtVSXQ3?=
 =?utf-8?B?a3d2YkIxUjFiZzZFL0V3K1hpdWp1SmR1TDgySVRJcEFEdGszSzA3VDVONUN1?=
 =?utf-8?B?VUViQ2h3dWhINkRYM3lwVTMwR3Uxa0dzSHM3MjM2WXhISHl4TjJITzRTUy93?=
 =?utf-8?B?dnc0bmlERlN6MUNYcUtjZ0xiQ2xBUC9Idzc1WVc2Z3Z0TGVxeDlTdEdPTmhq?=
 =?utf-8?B?ckdQcnJ5T1RvUkl5SVd1Rk1CekJERFRwbXVGQ01xb2xQKyswTk9nZFFXTFg0?=
 =?utf-8?B?Sy9wekpCM004RFRHNk5BTFBFc2JWNFh3WS95VnVhanBhZlEvSlI0QnZacmhN?=
 =?utf-8?B?T3JmWGFLR0I1T0NadWxQRGtkcHFwRHhpWENLYlI3UEcvQVpKZnA3MWJJd1VV?=
 =?utf-8?B?Zks1KzNDL3hqRmpoUHZSclBySGhPWG8wNTY0dmQ0V0Yzd05EeTJhRzNZWXBr?=
 =?utf-8?B?MW5zQTRURGZHNTFDc0U1SnA4aTFaR2hOSTE5aG05WUNJeDg3WDFGSG56Wll4?=
 =?utf-8?B?YkxJUENlMTNUZEhhY2FDNGIvNy9qalFTQlIxbXJwVDZpYUQ1NG95QUljVFRz?=
 =?utf-8?B?b2ZRUFZHUlpub3NKTDU3cDlMYldvNGNSWjdzempHUmluRkVIYWFpWURMSkpO?=
 =?utf-8?B?UzBlemFNVjhuY1hIVCtaaytVak1hKzkvbFVFa2pRT2pqajJwYmVjbE5oaWVO?=
 =?utf-8?B?STV5UVF5T3RaZ2lKZ2tnQ3Y2VTlvMU5mK1dEYVpKNzB5Skt6c2hNWldEcytM?=
 =?utf-8?B?dC9LckF0dzJRNlZ0ZXdkcVppLzdHaFlyZEphSjQvQXMvQThOOXF4aUluazlj?=
 =?utf-8?B?ZzZ5M21LQmN3alZuMjRldDBKeTFHaXFHWlBHbkcreGFKTEo5U01jTjJrTU1R?=
 =?utf-8?B?aFJpTzA4Yy9EeG9OdkJUbkl3bVpVMFVWbXN0YWxiaFJlaW1NSzFWWjVLWVFN?=
 =?utf-8?B?Uk1WSHk5QnRrQ3VwSktDRE9UYWpzZUJZRHREOStuR1ZTR0RtUFhld0ZxRDdp?=
 =?utf-8?B?SFl4emxyOXJ1K3JReGg0UHVxalBYaHlOSU9rVzVsd0tSMEU3REZwNm1MdVBR?=
 =?utf-8?B?SWRFTmhJMmtXTjVrUmlQL3dCbnhLeUdwNUwzQktDcHlmQTVnRGhWWVJMcE9y?=
 =?utf-8?B?cVViNkltYWxqalRtLzV0L2daQmZzUGJPaUlVbTc5VmY3YzFtVEhoSlllZ2N3?=
 =?utf-8?B?QTl3Z24xZmQvRlBVUno4RkZtRTRQSHpMYnpVZEhJVm44N05WNUVDZ1k2a3B0?=
 =?utf-8?B?TEpaKzZvV0FmNVUwVjlLSWQ1ZFhOcVFtTkVUWEMwMWR6RFlTNTJoSzJNcFNn?=
 =?utf-8?B?alU5dzlDRDVNMndJa3NXamdzQVN0VjBGdmNpaUc5U3U4M2taQjFHYnJOQ0RB?=
 =?utf-8?B?ZG8rVHp0Zm1mSW1weCtBMnlhZldvVmhJQSs1aDNXQ3JlaWNEUVBpb0x0L250?=
 =?utf-8?B?TjVsMUxsNTcydXRrd2ZTZjhFRzZEWHdBaC91czZsUUZ2Rzc5UDdRenk3NHZj?=
 =?utf-8?B?SlNMZi9wanV0bEhlQ2N0QWNMY1ZoOWhiczBTYmtYeTM5a29KV2JxZFUzcFRa?=
 =?utf-8?B?dVJCMTZKSjUyQU4ydStIakc2L1pBbkt6ZTROaTlKTGkyZTgvVnRZNDRRbEdK?=
 =?utf-8?B?b2Z2MmkvSWs5SUEwVEdTd0ZaT2R5SUJvNEkzYjByNjNlUEMwL002V2JXdVJK?=
 =?utf-8?B?Z0hNNVc2cCtaa3VFNmViUHpBYnE4cWtPemgvT3dKWWk5ZEh3TFRLSisvVlFN?=
 =?utf-8?B?cjhPZWdnbk91Q0tSc05GdExsaG1wcHpBejNvL28zelJIb1BDd1M3aVlZamFH?=
 =?utf-8?B?MVl4RUh5WmtXNnliRnVCbU82R1ZCUHFEQ0tHNXRKN0M5aTA1SnJoN2I4RkJp?=
 =?utf-8?B?Uy9JM1lzelRNNHNXbngvUS9PTFM4ZUk0aUFVYjhXODJTa05xZm9DQzhIaEhp?=
 =?utf-8?B?T25ER0trOENSWFRHZkRSQ3VCeEQxOFVlWEM5YUI5bUVDSi9MbjJjMGx4TEs5?=
 =?utf-8?B?b294cU5uaFNFZ2sxTmY4aHh1b3RYWE9VSnExRzk4aFFucG56RUhxeUlZakNi?=
 =?utf-8?B?SXJZWmpKOUdoY1orcDFxMzhrU0JLdEtzcXFEMXdUOGdTaFc3TXlxZTdqazVr?=
 =?utf-8?B?ZDZaeURsQUEwVGl1QlRKVUNqMm9JaUFsTEdaU2t2TlJYUHF2cFpjMDRSWWtr?=
 =?utf-8?Q?XNAeAD7T+OQX2GKWyyAiOSU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2eab2c-c42f-467a-5d20-08dc27da437c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:42:37.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bS8C5HOUAsBhDDALPVaiW1CHUEbUJWqHy3l1wbxYN9nFqAZV64X4Z6Yz8wOUyZVP6yPyGkBAD/cQMp61HiO+Xye0KKoU78ytctKwSZVEZfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6422
Received-SPF: pass client-ip=2a01:111:f403:2613::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/18/24 14:27, Denis V. Lunev wrote:
> On 12/28/23 11:12, Alexander Ivanov wrote:
>> Now dirty bitmaps can be loaded but there is no their saving. Add 
>> code for
>> dirty bitmap storage.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels-ext.c | 168 ++++++++++++++++++++++++++++++++++++++++++
>>   block/parallels.c     |  16 +++-
>>   block/parallels.h     |   5 ++
>>   3 files changed, 187 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>> index b4e14c88f2..c83d1ea393 100644
>> --- a/block/parallels-ext.c
>> +++ b/block/parallels-ext.c
>> @@ -24,6 +24,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "qapi/error.h"
>>   #include "block/block-io.h"
>>   #include "block/block_int.h"
>> @@ -300,3 +301,170 @@ out:
>>         return ret;
>>   }
>> +
>> +static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
>> +                                               BdrvDirtyBitmap *bitmap,
>> +                                               uint8_t **buf, int 
>> *buf_size)
> Do we need a error?
I think no. We save bitmaps in a loop. If some bitmap has a problem it 
would be better
just to  print an error message and try to save other bitmaps.
>
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    ParallelsFeatureHeader *fh;
>> +    ParallelsDirtyBitmapFeature *bh;
>> +    uint64_t *l1_table, l1_size, granularity, limit;
> I would say that 'limit' here means 'bits_in_cluster'
>
> We are writing the new code and I would prefer if we
> would have bits, bytes, clusters, sectors etc are
> clearly seen in variable names. It is quite complex
> to track various measurables.
OK
>> +    int64_t bm_size, ser_size, offset, buf_used;
>> +    int64_t alloc_size = 1;
>> +    const char *name;
>> +    uint8_t *bm_buf;
>> +    QemuUUID uuid;
>> +    int ret = 0;
>> +
>> +    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
>> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
>> +        return;
>> +    }
>> +
>> +    bm_size = bdrv_dirty_bitmap_size(bitmap);
>> +    granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> +    limit = 
>> bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
>> +    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, 
>> bm_size);
>> +    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
>> +
>> +    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
> As far as I can see, bdrv_dirty_bitmap_serialization_size() returns 
> bytes.
> That is correct. Thus multiplying it by 8 seems fatal mistake.
l1_size is amount of entries in l1_table. Every entry has 8 bytes size 
and corresponds
to one cluster containing a part of a bitmap.
> I am also quite unsure that we should roundup to the cluster, that
> will occupy more clusters than needed. Can you please take a look
> here
> https://src.openvz.org/users/ibazhitov/repos/ploop/browse/tools/ploop-cbt.c 
>
Why shouldn't we? We need to have l1_table which should be able to contain
all the bitmap data. Note: there is not a ROUND_UP(), but DIV_ROUND_UP().
>> +    /* Check if there is enough space for the final section */
>> +    if (*buf_size - buf_used < sizeof(*fh)) {
>> +        return;
>> +    }
>> +
>> +    name = bdrv_dirty_bitmap_name(bitmap);
>> +    ret = qemu_uuid_parse(name, &uuid);
>> +    if (ret < 0) {
>> +        error_report("Can't save dirty bitmap: ID parsing error: 
>> '%s'", name);
>> +        return;
>> +    }
>> +
>> +    fh = (ParallelsFeatureHeader *)*buf;
>> +    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
> bh = fh + 1 ?
>> +    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
> l1_table = bh + 1 ?
Yes, it's better.
>> +
>> +    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
>> +    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
> I am quite concerned here. Please compare with
>
> int save_dirty_bitmap(int devfd, struct delta *delta, off_t offset,
>         void *buf, __u32 *size, void *or_data, writer_fn wr,
>         void *data)
> {
>     int ret = 0;
>     struct ploop_pvd_header *vh;
>     size_t block_size;
>     __u64 bits, bytes, *p;
>     __u32 byte_granularity;
>     void *block;
>     struct ploop_pvd_dirty_bitmap_raw *raw = (struct 
> ploop_pvd_dirty_bitmap_raw *)buf;
>     char x[50];
>
>     vh = (struct ploop_pvd_header *)delta->hdr0;
>
>     /* granularity and uuid */
>     if ((ret = cbt_get_dirty_bitmap_metadata(devfd, raw->m_Id, 
> &raw->m_Granularity)))
>         return ret;
>     raw->m_Granularity /= SECTOR_SIZE;
>
>     block_size = vh->m_Sectors * SECTOR_SIZE;
>     if (p_memalign((void **)&block, 4096, block_size))
>         return SYSEXIT_MALLOC;
>
>     raw->m_Size = vh->m_SizeInSectors_v2;
>
>     byte_granularity = raw->m_Granularity * SECTOR_SIZE;
>     bits = ((raw->m_Size + raw->m_Granularity - 1) / raw->m_Granularity);
>     bytes = (bits + 7) >> 3;
>     raw->m_L1Size = (bytes + block_size - 1) / block_size;
>
> which means that the header is rotten. In that case can you pls
> take a look why this has not been caught by tests?
It looks the same if block_size is cluster size in bytes.
bytes - bitmap size in bytes
raw->m_L1Size - bitmap size in clusters

In my code fh->data_size is l1_table size (8 bytes entry for each bitmap 
cluster) plus
dirty bitmap feature header.
>
>> +
>> +    bh->l1_size = cpu_to_le32(l1_size);
>> +    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
>> +    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
>> +    memcpy(bh->id, &uuid, sizeof(uuid));
>> +
>> +    bm_buf = qemu_blockalign(bs, s->cluster_size);
>> +
>> +    offset = 0;
>> +    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, 
>> bm_size)) >= 0) {
>> +        uint64_t idx = offset / limit;
>> +        int64_t cluster_off, end, write_size;
>> +
>> +        offset = QEMU_ALIGN_DOWN(offset, limit);
>> +        end = MIN(bm_size, offset + limit);
>> +        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, 
>> offset,
>> +                                                          end - 
>> offset);
>> +        assert(write_size <= s->cluster_size);
>> +
>> +        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end 
>> - offset);
>> +        if (write_size < s->cluster_size) {
>> +            memset(bm_buf + write_size, 0, s->cluster_size - 
>> write_size);
>> +        }
>> +
>> +        cluster_off = parallels_allocate_host_clusters(bs, 
>> &alloc_size);
>> +        if (cluster_off <= 0) {
>> +            goto end;
>> +        }
>
>
>
>> +
>> +        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, 
>> bm_buf, 0);
>> +        if (ret < 0) {
>> +            memset(&fh->magic, 0, sizeof(fh->magic));
>> +            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> +                                  cluster_off, 1);
> That is incomplete. You have to clean all clusters inside of the
> extension.
OK
>
>> +            goto end;
>> +        }
>> +
>> +        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
>> +        offset = end;
>> +    }
>> +
>> +    *buf_size -= buf_used;
>> +    *buf += buf_used;
>> +
>> +end:
>> +    qemu_vfree(bm_buf);
>> +}
>> +
>> +void GRAPH_RDLOCK
>> +parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error 
>> **errp)
>> +{
>> +    BDRVParallelsState *s = bs->opaque;
>> +    BdrvDirtyBitmap *bitmap;
>> +    ParallelsFormatExtensionHeader *eh;
>> +    int remaining = s->cluster_size;
>> +    uint8_t *buf, *pos;
>> +    int64_t header_off, alloc_size = 1;
>> +    g_autofree uint8_t *hash = NULL;
>> +    size_t hash_len = 0;
>> +    int ret;
>> +
>> +    s->header->ext_off = 0;
>> +
>> +    if (!bdrv_has_named_bitmaps(bs)) {
>> +        return;
>> +    }
>> +
>> +    buf = qemu_blockalign0(bs, s->cluster_size);
>> +
>> +    eh = (ParallelsFormatExtensionHeader *)buf;
>> +    pos = buf + sizeof(*eh);
>> +
>> +    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
>> +
>> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>> +        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
>> +    }
>> +
>> +    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
>> +    if (header_off < 0) {
>> +        error_report("Can't save dirty bitmap: cluster allocation 
>> error");
>> +        ret = header_off;
>> +        goto end;
>> +    }
>> +
>> +    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
>> +                             (const char *)(buf + sizeof(*eh)),
>> +                             s->cluster_size - sizeof(*eh),
>> +                             &hash, &hash_len, errp);
>> +    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
>> +        error_report("Can't save dirty bitmap: hash error");
>> +        ret = -EINVAL;
>> +        goto end;
>> +    }
>> +    memcpy(eh->check_sum, hash, hash_len);
>> +
>> +    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
>> +    if (ret < 0) {
>> +        error_report("Can't save dirty bitmap: IO error");
>> +        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
>> +                              header_off, 1);
>> +        goto end;
>> +    }
>> +
>> +    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
>> +end:
>> +    qemu_vfree(buf);
>> +}
>> +
>> +bool coroutine_fn 
>> parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>> +                                                          const char 
>> *name,
>> + uint32_t granularity,
>> +                                                          Error **errp)
>> +{
>> +    if (bdrv_find_dirty_bitmap(bs, name)) {
>> +        error_setg(errp, "Bitmap already exists: %s", name);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> diff --git a/block/parallels.c b/block/parallels.c
>> index f38dd2309c..a49922c6a7 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1466,14 +1466,25 @@ fail:
>>   static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>> +    Error *err = NULL;
>>       int ret;
>>   +    parallels_store_persistent_dirty_bitmaps(bs, &err);
>> +    if (err != NULL) {
> For me this looks quite odd, indirect check for error. Not good
Will add return value;
>
>> +        error_reportf_err(err, "Lost persistent bitmaps during "
>> +                          "inactivation of node '%s': ",
>> +                          bdrv_get_device_or_node_name(bs));
>> +    }
>> +
>>       s->header->inuse = 0;
>>       parallels_update_header(bs);
>>         /* errors are ignored, so we might as well pass exact=true */
>> -    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, 
>> true,
>> -                        PREALLOC_MODE_OFF, 0, NULL);
>> +    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
>> +                        true, PREALLOC_MODE_OFF, 0, NULL);
>> +    if (ret < 0) {
>> +        error_report("Failed to truncate image: %s", strerror(-ret));
>> +    }
>>         return ret;
>>   }
>> @@ -1525,6 +1536,7 @@ static BlockDriver bdrv_parallels = {
>>       .bdrv_co_pdiscard           = parallels_co_pdiscard,
>>       .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
>>       .bdrv_inactivate            = parallels_inactivate,
>> +    .bdrv_co_can_store_new_dirty_bitmap = 
>> parallels_co_can_store_new_dirty_bitmap,
>>   };
>>     static void bdrv_parallels_init(void)
>> diff --git a/block/parallels.h b/block/parallels.h
>> index 493c89e976..9db4f5c908 100644
>> --- a/block/parallels.h
>> +++ b/block/parallels.h
>> @@ -101,5 +101,10 @@ int64_t GRAPH_RDLOCK 
>> parallels_allocate_host_clusters(BlockDriverState *bs,
>>   int GRAPH_RDLOCK
>>   parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
>>                                   Error **errp);
>> +void GRAPH_RDLOCK
>> +parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error 
>> **errp);
>> +bool coroutine_fn
>> +parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const 
>> char *name,
>> +                                        uint32_t granularity, Error 
>> **errp);
>>     #endif
>

-- 
Best regards,
Alexander Ivanov


