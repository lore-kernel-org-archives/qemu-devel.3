Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF1FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIou-00010x-2O; Wed, 28 Feb 2024 07:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rfImr-0006QZ-Pj; Wed, 28 Feb 2024 07:11:55 -0500
Received: from mail-he1eur01on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::704]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rfImm-00067N-KS; Wed, 28 Feb 2024 07:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGPhFrJ7rBUhYSgT2ao2Ohh4uQ+VUTDGCgG5GYy2BTnP159vdNWpUepvooGplHq/qwObMCnEfs+AiOvR3xyrVaWaUeLEkvcsIkJebCG3bJO6lajjWuUsLp5AKPNCoJXIpFX3oHzBNQaandVX6BlTsy5fYxwKqnmH7oEfIv+d7u84xm/H27DkEcwoFZeuCu82qxoaLj4VOP2qJ5R25ylNHuosL3csbLE9NwEw2ByUEH0p0fUK431ZBXiGPCimYAsQwqF6KR6LVPbwmQOEZrnpfESgfP3jOOivihQipToEhGkNo/65pcQ4vp3GiJN/EViBY0IX5QRsNZgkBtwTBgILbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hcTRR7xBGt4JpmXpwVpzxGcb0LlD7t0GWt76kMVppg=;
 b=RcWP18ib+JFfv/Wrt6QtLNSelm3WvVTGp9Hy4oZh+wzXIeUPUOZZjXbK1DqcY1nn5F2ebpXKk1U1YZg+T2XdPmfHtrESPmy3CGBONfobLm/nKSXV0iZqD9tHsqH/5LLLdmv2hKtdH2WvT8AzPiOMIpNcNRvA8QMm/+v8SUOmiBd49MWEOol9TMtbn5R+Z3fsa7gC2n5RcQbnJJ4iKcM/Lh3zpAhGXTkRWJdc+oLacW9+IU30JUUBcts/zFolu1FZ9sxTaNSnmCxu99TxbY6DSk+HK6CipoeRw4O/P1rfyimtdUcngydnf46HAH8P+7XCVCwtF8nZgSb5AILwXw1wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hcTRR7xBGt4JpmXpwVpzxGcb0LlD7t0GWt76kMVppg=;
 b=yqItqsyRR6NPzHgFkEuJJzfwtxIBwc7iLWvg92G2HyMrqmQIiD22iwd+bb8C4kacqBXtANxGvZXc3g/C/I3QHaI4jo2P6+b+TO06PayTYksSdW5wHkeCmi0Fsai2PdDovfYVXH4UY6Fj9M9Lo+NNFI6dHh8MhbEIXUSXz2gXyFwuELhPeMLvm26ur0YgeE0mBDSEgFLeg3t4YruinMZXziIdgs0r1yh4eysoGDikbZPMS/M8Pb7QRVg5RPi4emqcrjXn93HOZ08BXoSNpJ6aVIJqyktRyPBbLveEjAZB9W/1PIxcvXg68F/B3Ub9Y/BSZvkYKFoLUDyTISD40R5/PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB9417.eurprd08.prod.outlook.com (2603:10a6:10:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:11:38 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c9d1:40a6:1a4d:d5dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c9d1:40a6:1a4d:d5dd%7]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 12:11:38 +0000
Message-ID: <c244e29f-6b87-4010-ab6e-ac1498247eed@virtuozzo.com>
Date: Wed, 28 Feb 2024 13:11:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
 <a9791fbd-e07a-4757-bb54-b4283bd7f4ad@virtuozzo.com>
 <99fd7075-fd25-4ccd-806d-6d2c0f3e33f0@virtuozzo.com>
 <42466483-7583-497d-89f5-cbd447f5647e@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <42466483-7583-497d-89f5-cbd447f5647e@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c18d3bc-290a-425b-4ef0-08dc38566a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L30HBhEd7rreyKUJm6PpISsQOSZ1U+AcPUK/Y1mkl+rQ2kT6YeC9+xIo+d9V4Ye/OEa8NGy8Cqww61Mmh6ubpqaQgAs2WMT2LASYJAv5+AoPwxVg+eba4cqkcCx6Qj+ZXwFw0whqmHNIfdeFYXzbKZcqCq0CZQuBqPHR8fZD/l/5QBpw1WJBoMSjz0MYTwxiFG52K5zv5xPqqcaMLqWTikANALaZt1ogHhcenp8ERKePWXqqz/GsRQtFxvxTlvJL1c5DfbQhYcbM0s3mr8EeCbqND/M91eMTKIF2nT7lm78DdCcIFbkkxD+1KUnQmnW5sArluaRVPnvIJzoRGHNy6pwVMW+pcVnA48JaRoG2KKimWLIyQ9m84G7as9p25tltxrTtiH4IGsQIPEUPytL3nzgdvpR3a73qB1UMzGOEDxdSbqjWsNBIyPDeyrA+oOaxs4kjjGPZpIMsVy9BjMObyqDQkhbky7tON75FAfzN/EtEwol2ecYlzJW6yXzpPQPUXVUt/scNjU49nE22EHCG00AA6p8Cdyjq+QBHaecwjQ16WLQUrauDVTh8WI/2AFi3LALlWAI/H61AcUb8gVJjhzQEfwmYV4/KSpA1V9a0ASeEWpeEikYeGfobXZbE9z0yhBTLZ6xQsf6VIXCON3L+VFrBsXzKX2M7qcKjelagY08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBWd3UvbVhNUFV5aDltSCszczZ4VURyQmRiTG13enp3dU42SldkY1hBNmRl?=
 =?utf-8?B?K0FqblBvK0JqaXdWblIyWEU1M3Fka29xWnpGTEVxNUNMbG5BbEdGSWFBQUFF?=
 =?utf-8?B?T04yemVpeEtvaTg0UU9XSUZpS3hVS25RN3FIU0VwNVJCTzlOYnRsaXlObk1F?=
 =?utf-8?B?Rm5YYndGQTJRamMzTzBrOTZpaGJacUhFMFY0MjJ0b2swWEx1Y1RBeno5RjJz?=
 =?utf-8?B?bW1EdzZtdDE5RjR1R01sd1BkWG5aSXVVdHhHNlEwK3BmTUNKMnpFNlQ1UzhW?=
 =?utf-8?B?OXVnV0xkVUpFZ1NYNGUyZDRndkllLzVaTHdvREhkckZKN2pSNUhkTUE3OUxt?=
 =?utf-8?B?M21LZGsyZGE2d0h0a0lvb0laWmJFNHh3NStWK3phandQWWg0NllEcHU1TXFF?=
 =?utf-8?B?bTNoY1FRc3dUZ3hrWWxSb1VCem1CT1FmdktwYzNMZWRTQ1luUHAxMGVLK0Vp?=
 =?utf-8?B?MCtPMjkyb2ltTEUrRmxMOVdDaDRHRjk2SDlCTXU2bW8zNENOVDROZkV0SEdQ?=
 =?utf-8?B?cHpiMXVLeWhXWkZCTGpwNkxGaUZPQldDVmpJM1NLY2Y1ampCZjhCT1FRdXB3?=
 =?utf-8?B?ekZNV1hhbkRITkVHTWlUQ29iWDZ5SVdRRzN2QTI2NGpiaTRMTkFvaXZpcXN1?=
 =?utf-8?B?T0tRZkZPbFZTTmREMXJ2WFNybWVkeFV4TzFXRTdEc0pMRlZWRGdOVUt1VHQ4?=
 =?utf-8?B?T05oMFpnVGx5MkdjSVpFNVM3TkpmeEU1d0tvSGdQZUlnVXh6WnR4eEJ5Z1dC?=
 =?utf-8?B?WWswaGhXaTkvZDVBS2orSGU0Wms0aGlBVVNUWVFjY1pscUF4L2EwVlNzb3dS?=
 =?utf-8?B?YkgydmJiZGRCd08ydE5NeVY3SnowSStTck5Sd3dOSUptZ2RDUml1aERVeWZT?=
 =?utf-8?B?NVhlK3djdUxqN2pCYjlZWUJFS3grMjB1MllVd2Q1WjBuSEl1emsxaDlRNEVi?=
 =?utf-8?B?M3dvRFFpdE9QREtjcEU4a0d6WWEvQ3E5UGdxVm1NaTVVbW0rOGJzVmp1UkUr?=
 =?utf-8?B?SU9yQjZGTzBHOUpTaktxY0o2bHozbkxzczFIQWJuT0Y3Q3FFbGdPdEVXaFRv?=
 =?utf-8?B?MlI0VEJCdzFYSERKN0dDZGdDMXFBMFhuUllJeFFtaElFb1B5cXFpYVRyZGty?=
 =?utf-8?B?QnFiamZQcVpsOFUxZnlTbmRWWWJVVnRZNnpudFJKdjdOM0lWTUIwdHVUek1Z?=
 =?utf-8?B?Si9FbVRXSUxFTHVuL3RiUkorZnhpay9UdE5RcGpHL2tHQktqUjV6cys2OWlt?=
 =?utf-8?B?NGVpakV4V25FSGN0UWN5Y3o2TlNWTzc2Q1I4Y3dTYW5lbGRyYUFsblo5RTVF?=
 =?utf-8?B?emNCcHA0bU92WjM3aFNoZ0lxbVdNQ2JTYVJLRFlMc3RDQUZKYUFNZTJFd0My?=
 =?utf-8?B?NjM3cmJLbEJPMDlUQmNRbEVVRE5ZYnRSOHRNay82amNhcTZpTjVwelE0a01P?=
 =?utf-8?B?Vmk3TkY5MnMrTEJuL3o2WGpOelhXVmEwYVluQjc3bXNub3RIdkhHSkhpakFS?=
 =?utf-8?B?YmZMRWxYTXp3MmRWNVFwVFhMNGRud3k1YWpaRjBmNC9FZURZdzQ1OHp1Vmpa?=
 =?utf-8?B?MTY4dXJ1RS9oVTdEMWVFRmtoQjgxRjMrVC9OeVA5b2ZFSVg2Q2VnQWFTQWNV?=
 =?utf-8?B?U3Z3N1hwWEJRYjR1dEZqMnhjRUFYaTJybjZQc081a016Mm16ZzZXQ3FKc3lo?=
 =?utf-8?B?YXpSV1kzZFc0bUxSODIzQ05FcEZ4aUh4d29WUTRoYVpZMjhzcEpDSU5QYURs?=
 =?utf-8?B?eVN2eENaMFhWUWdTZ0JYSXN5bXcyVm84REx1MjRJZERqcnp4WXRIejBIVnZX?=
 =?utf-8?B?eVNRRXg2clUxMHdkN2lEZjhUTWxmbnFyL1pkZS9SZS80VkpLVVBad29XcFBJ?=
 =?utf-8?B?N3FSak40L3V1YWtQL1htR2lDMEpGWS9mVk8wR1Z6YVQ4eGp5ajczd3RJSm4w?=
 =?utf-8?B?RXRoblVjZWRMZzREWUN0REJqUjBac1dUMmxSRU5PVnBpUlRYdDZHR0JSTHQy?=
 =?utf-8?B?L0tVek5vZ1YrVGNzUU9OaHpPOFFMT05YSlVDamttYXJDdys5NENLQ3pLTzBp?=
 =?utf-8?B?L21GZWZpVEp0ZWUrTHdSMkxFb0tGV21WS25ta1hDOWQxcG1hbm01U0d0b0dC?=
 =?utf-8?Q?uHVXbG3R+80BBY6htWvxg6YAv?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c18d3bc-290a-425b-4ef0-08dc38566a7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:11:38.5871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zPXkG/txnMgYnnpV8BsXvOeGMdL7smEqfP2fgnKcPfkCkjOr2wQaQNn0I86YR9xfU1H9fYEmj9v98I6g1mI2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9417
Received-SPF: pass client-ip=2a01:111:f400:fe1e::704;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
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

On 2/28/24 11:25, Alexander Ivanov wrote:
>
>
> On 1/18/24 14:31, Denis V. Lunev wrote:
>> On 1/16/24 15:45, Denis V. Lunev wrote:
>>> On 12/28/23 11:12, Alexander Ivanov wrote:
>>>> Now we support extensions saving and can let to work with them in
>>>> read-write mode.
>>>>
>>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>>> ---
>>>>   block/parallels-ext.c |  4 ----
>>>>   block/parallels.c     | 17 ++++-------------
>>>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>>>> index c83d1ea393..195b01b109 100644
>>>> --- a/block/parallels-ext.c
>>>> +++ b/block/parallels-ext.c
>>>> @@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, 
>>>> uint8_t *data, size_t data_size,
>>>>           return NULL;
>>>>       }
>>>>   -    /* We support format extension only for RO parallels images. */
>>>> -    assert(!(bs->open_flags & BDRV_O_RDWR));
>>>> -    bdrv_dirty_bitmap_set_readonly(bitmap, true);
>>>> -
>>>>       return bitmap;
>>>>   }
>>>>   diff --git a/block/parallels.c b/block/parallels.c
>>>> index a49922c6a7..d5d87984cf 100644
>>>> --- a/block/parallels.c
>>>> +++ b/block/parallels.c
>>>> @@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState 
>>>> *bs, QDict *options, int flags,
>>>>       }
>>>>         if (ph.ext_off) {
>>>> -        if (flags & BDRV_O_RDWR) {
>>>> -            /*
>>>> -             * It's unsafe to open image RW if there is an 
>>>> extension (as we
>>>> -             * don't support it). But parallels driver in QEMU 
>>>> historically
>>>> -             * ignores the extension, so print warning and don't 
>>>> care.
>>>> -             */
>>>> -            warn_report("Format Extension ignored in RW mode");
>>>> -        } else {
>>>> -            ret = parallels_read_format_extension(
>>>> -                    bs, le64_to_cpu(ph.ext_off) << 
>>>> BDRV_SECTOR_BITS, errp);
>>>> -            if (ret < 0) {
>>>> -                goto fail;
>>>> -            }
>>>> +        ret = parallels_read_format_extension(
>>>> +                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, 
>>>> errp);
>>>> +        if (ret < 0) {
>>>> +            goto fail;
>>>>           }
>>>>       }
>>> Reviewed-by: Denis V. Lunev <den@openvz.org>
>> This patch also deserves a note, what will happen with
>> format extensions clusters. According to the current
>> policy, we have only transient extensions, i.e.
>> CBT. Cluster allocation mechanism will reuse these
>> clusters as they are not marked as used.
>> Thus we should either set format extension offset
>> in the header to 0 or perform any other correct
>> measures to properly handle this.
> Yes, all the clusters used by extensions are marked as unused
> on loading. In further work they can be reallocated for other
> purposes.
> Agree that we need to set ext_off to zero.
>>
>> It should also be noted, that on any QEMU crash
>> appropriate format extensions are to be properly
>> treated. We could not make them RW until this would
>> not be addressed as we could easily mess up with
>> trashed metadata.
> If QEMU crashes after extensions loading there will be
> zero in the ext_off field and an inappropriate dirty bitmap
> will be ignored.
>
That should be considered as a minimal kludge.
Normally we should mark format extension cluster
as used and nullify references from the bitmaps
there.

Anyway, even if the ext_off is not zero and
bitmaps are present, bitmaps loading over
unclean image should not be performed. They should
be considered outdated.

Den

