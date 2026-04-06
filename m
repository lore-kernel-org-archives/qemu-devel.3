Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A1DEF4ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9iwj-0000J0-Uc; Mon, 06 Apr 2026 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9iwb-0000Gt-J9
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 08:20:42 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9iwX-0006hX-VP
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 08:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jucdx4CmIiptG5xOeXUguwpHKoafT812kfCCDWBPUT+GNQE924DixVO5CCLzE4H7ZaLzSwTJ6UK+PxglMeiRDNNmm7CsHvDzzdidQ70Fba6pDYFz4CMqsqeI0tkoYZLMVEc4KMqKiuCgxoyWVkKCAqFvt8IQax0QFmWkAMx7X2btNUgiqqM48DvbjRlRO3Qk8Nox7j/38ZqUF957eg0L5Sxax5p9MKYLifiW+XFi5hVBEWkKdZcMl0AqMcw1SJLlz0ODuinJV4JrXqK0OdCDu5bHEaFh5hDrPb/rAfKf7G82Wy4VZtJqrfxuZC9xmJJtzsw+Z0gMeb3ZmZn02vmbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3Xhof7Lg6D64xBMdBoDFg6fq461lwTHtcHD5ISsqYU=;
 b=MGk8lKb/0LV0pWfy/TNgAXAGAu7XHVxewuQ8BMl+Ea39AvfaYDiJss2MhhxzdadKdQfzvFvvvfKF8DUSarGhECByIq7M9rX4F/d84MupWCc5SJ4LrKLuIh1MUuTTvBAGRSO9GS7/D53dvPCnM3Wj3L+1uGiU7vZfSNBjKMC5NpEwN9PCU2EhY9NlX5hBBeHPo19/g0+8EEUAYWNxEjJQ9GwnQTL0wBncXOjWPvf5OmY6mmZnSkRQwUBzQFGnVY7uFoINHUplrnYLShKnqG3cFjLcQKHvb1NPtUkb/MvmAn+hW9wXqa5JFwkOQFBIVdobJkpJo7daIRqHoW+R/AaWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3Xhof7Lg6D64xBMdBoDFg6fq461lwTHtcHD5ISsqYU=;
 b=S45qIu0tjldWcRInn/Uw/S+90MQ3YLXo3vzNKFy9R2FJ10zdKDB0/TxYZRVCEk6OvxtAMfo8x2SU1KkoasSe312whcvg5PqTcLEsnxepgXekqkSxOjNFzpKS+hDOViKPYIrb+rG8GqRjt1cPgRL/O38TWTdvyZhrquazj/dM/qwyj6mD/hRgSo8MnuwqVCzhq0bwhB8700AJ4nE7Yl2PFIzmbQIz+Oh9mxxXUfbjgh/zrRq0nN3A2yrx8t0fXDVOiGnCujikt54PEJYEtSSWEziTF19Qr8a4k/vCLgEJsyMgJAmxtv1QJrimtOzAfP9ZJbxJbQKK6Z+x/Lk4DqS+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 12:20:26 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 12:20:26 +0000
Message-ID: <f8482f15-73e3-415e-b905-1ab5d77e653e@nvidia.com>
Date: Mon, 6 Apr 2026 15:20:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/12] migration: Introduce stopcopy_bytes in
 save_query_pending()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-8-peterx@redhat.com>
 <82b40877-482e-4dbe-add1-6e0cc4292ae7@nvidia.com> <ac54tN39eq0Rv6T4@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ac54tN39eq0Rv6T4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cce0609-11c7-4399-8c10-08de93d6e21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: aXfH76lR9REx4EjQSjxB9QS/Agd5EwGfLLvb/43O9womAmskicsFBvr1ZwM6s4yQqB2WwyarLs5JC2vzZZsASDE8QSoVF9t8RvkepwDaqljlAkthEiflMZbLVOnzyRzBPoo7547nhOzKN1QnsaFJC6sPkD4z/cygrDraESAT5R5Hi37L+ibAel165eZzVA7RBSgjrVbj1WU/4333TJ3SgoO4+EmQ6IFWZ85UA1FyGcra8P4kxdSuxf2eebymNGe7AeTVmP49jC8IYuZfN9mgLQv9qFkDjQHrd63yPx5JiRwTiflEiFpJwT+kXoa7l1ezjgVp77mzHOIfhREh09Jax3RZg/QlYW62OgRLTcYN74rvzE0dyA6pqyJQ1fieOUw2hazvnP2LgMLWYlNqa3W8ToUTHZ3+a/CYFRUjrj8XwN4hEOjqml5j2ZyB+44RLiWKXlF1J0zqCyA9VQnhrps6q9y/3ST8JbTBkXnqeGU/CcalbaKapG1BxE5pLWkvYdpR8OPpCffbL6iFnnH+qkAbGAmzvOj9WrQfaUM2WKp1SxM2bsB+5GMaA2N6a/1Ui1HyeygqIeFNprgvFgdImMJr63tCA2T6SsoNcXxg9714A2OOXmTdwKrJLYL6PWDJyYvy8cpp7U22mFC7aKNU5WAidcPao4lAD5j/7GqlbMakXWXKPi6XG79R0gsZ+9E3t+RQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJmVHRGM2c2enRSU0Z2amtsTndEN3NSVWFaTkM1UFFsVkZjT0p5R29PTlM5?=
 =?utf-8?B?bzV4Y2ZtaS9uN1VnZk9YSHNmZ0RIOU9xbkJyMWJmblI2NW81czhRNFZEZlFw?=
 =?utf-8?B?STNoNjVTWmhNL0dHaGM3ZHBYN21Mc205VGplS1ZDbk5lUVp1RmFIN09vSnVN?=
 =?utf-8?B?SmRoY2ZJOVNpcFpVME5YbXh6QitheHk2UHI2Q2c3S3JsZXBvczBZZjA5dDcv?=
 =?utf-8?B?SlM2NGVSRmtKYndyVjVlVTB1NmZUMUVsNnVsQ0tzYStZc1h5NjZBQTV2RlR6?=
 =?utf-8?B?WTdyK1ZkWGJBSThGYUZQT2hUSzhGMU9BWkVyWlRNcUdZY1g2amJyVXV6azRv?=
 =?utf-8?B?YlZnbGwybzNENzhBU3ZKVXE5K00xSk9OaGltUi84azJ1U2d4am1XeXNPbVlo?=
 =?utf-8?B?T0hrclJYN0E4L1J2RWQ3VXlQdG40Znh3WkJxaUxGaTNQTzJidlpXM2hMa1Zo?=
 =?utf-8?B?VFJJNC9xKzU2LzBlRFV0dVgvbE4vVjhMVlFtMFlNOVBiUkRHa0JZTHZNK1NK?=
 =?utf-8?B?Q3BzRGx4L0xZVTZuMW1XYUtEay9OVENJY25jVVJKL2dDN3BmbnFZRlJ6bVli?=
 =?utf-8?B?OWF6cmR4bUdqNnd0SHZPaG1xNTB6U0tNbFRhdmRDbnJDUlBHVlE1bnVsTHIv?=
 =?utf-8?B?Slc1SmxPR3pSZ3gzSmhzTDNHam1Kc0NXYlNldW1KUUhZdWFHdWVvMHdyUFJ5?=
 =?utf-8?B?SHNqMitjSGJNLzE4MjExcUNTRjVjVHJna0lhcGd2RytwMVc3TkViZzUwZTdX?=
 =?utf-8?B?YTRlR20vU3YvSUlEYnVFR0pkckY4Qm5jT1B3T0FQcnkvRVpWbUs0NXlQb0pw?=
 =?utf-8?B?NUFGQUJMcUt6MzhZaUJYd1N4eTdGRVVVSDNQa1VwbWVDRDlHQ2ZjeTc0eTVE?=
 =?utf-8?B?d1ZYRU53dTNJR0RiZ2p2ZVVTZ0tKaE1rdWJyaVFCb09PVDJFMisrR3d2YzJL?=
 =?utf-8?B?aUlnZTFuVUs0cXhNVGl0clJqOGdua1M0R052SG1JSVd1Qmp3aTZidFR2VHRP?=
 =?utf-8?B?OEo0V2xBS1Y1MkptSnljTDNqd0l1dDl1TjVPMlNmOFJrS25Vc2FrVTBqekVS?=
 =?utf-8?B?eldSM2owRUlvTGh6bC9tVVdTUDRLUGpGS09NdHhwN3lXZUVJVCtRREh4a213?=
 =?utf-8?B?OGdkRW03ckJoUENnbU9UM010Qkk1RllHN2VxMk1FNzl2S2dCZk0vZmUySG5W?=
 =?utf-8?B?MEtyY2JGcjVvdUxJbmljVEowSzQxbVRsUDFKYkoxVXFKS1V0MFlaQlV6WHJa?=
 =?utf-8?B?RWxwTWc5SlZncHlhMGhRUHFoM1hURUFEeWFQWnFIZ2Ryb01xS01TZTZZclIy?=
 =?utf-8?B?Z1NQVmU2VzVyKzd5YnhVNktJT3NhNTd4WG1FTkNVMHhtVlQ0MWRLUng1UTVL?=
 =?utf-8?B?MXlRY1hpeGV4TjBPbHVjREx2YUJFd0ZibjdZeXdGT3Z0V1dOU1Z6U210cHky?=
 =?utf-8?B?c2wzTzdnQ25DbVdlWW1lOGZVQzNKY0JIRUkwdjVLTEhtaXZzU3lHZ3FYb1Ev?=
 =?utf-8?B?WnQvK3Bna0N5QnEvRExiVWZZbEpLYk4xbDROeG5BNjdDdTN6NXhtZnpXS1hM?=
 =?utf-8?B?aVowREE3ZTJUc1FoVkN3bFpXbm0rK0VqekZQa3JmMWxnNnJYbkRoQUFwSXUz?=
 =?utf-8?B?cU9mS1dwQXcyVGZDV3BGdzVxREd1c0xQNTkrbWo2T3YzUkE4cEFaZWtHMklM?=
 =?utf-8?B?cDN1amtMVEMvYTQ1NnVWSmpKOGwwaFVtTGM0bEZDYTErSWR4M0VjVXo1bHd3?=
 =?utf-8?B?V0k4Q3B4WE13NXIrRkpST2pzdzBSbDBPbmFtbFJ4blA5b0VaU1VFK2s3eStM?=
 =?utf-8?B?cmFEOGprTjk3d05QemFUWEZ1N1lsd0pqNmJkUmU3YTUrTXpXSjlYNUlVenJn?=
 =?utf-8?B?WnRkbFhESjFTZDR6eXFDSWxKYzhrRG5jdTJQamFvcVM3TDNRQTFIdVBxNS9P?=
 =?utf-8?B?Zlk1b3dMaUx3N0l2RUwwRnFBdjRXT0NTalYvc3FQZzlwZGNwNlN2VWhXemJo?=
 =?utf-8?B?MkRWZXcydGl0aXBoU0FSQ3hYNXFiZXNWOFYxbW81S01EdkF3TjViMnpHdWJp?=
 =?utf-8?B?SDUvSG9DTFFWWkdEMU5qNUxnRVVOcG95V1F0MTIrK3hadzVTOWVCM3dwV0E0?=
 =?utf-8?B?T0hyV21peHpTTVFwKzBlMDc2cTQrbllOMC9TZ1dNenlIS1pMamw0ZC9nWkZW?=
 =?utf-8?B?c3FYQ2ovRTVnYW96azBGZGpwQm1Ba1Y3N1NwSStKZm9JeHM4WUVMU216dDg3?=
 =?utf-8?B?dTFFbXA4SHVHeFlIak5EbWo1bkRvVktKWlVCMXFZYkx1VlNWWEpGZWhiQ0pt?=
 =?utf-8?B?NHY5N3pDN1pjY1E3MkszTksrZTZvaHZlYnpoQ091TWFjOVJ5NlVwZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cce0609-11c7-4399-8c10-08de93d6e21a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:20:26.1366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaKwAy3W8SOkZKVNnZQT5ez/Li19MW2Azw1qj068oZlDxkNpFGAsapIWBThFSgayK2cuiGs8q3avHowA7Xu1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=avihaih@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/2/2026 5:09 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Mar 25, 2026 at 06:54:58PM +0200, Avihai Horon wrote:
>> On 3/20/2026 1:12 AM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Allow modules to report data that can only be migrated after VM is stopped.
>>>
>>> When this concept is introduced, we will need to account stopcopy size to
>>> be part of pending_size as before.
>>>
>>> One thing to mention is, when there can be stopcopy size, it means the old
>>> "pending_size" may not always be able to reach low enough to kickoff an
>>> slow version of query sync.  While it used to be almost guaranteed to
>>> happen because if we keep iterating, normally pending_size can go to zero
>>> for precopy-only because we assume everything reported can be migrated in
>>> precopy phase.
>>>
>>> So we need to make sure QEMU will kickoff a synchronized version of query
>>> pending when all precopy data is migrated too.  This might be important to
>>> VFIO to keep making progress even if the downtime cannot yet be satisfied.
>>>
>>> So far, this patch should introduce no functional change, as no module yet
>>> report stopcopy size.
>>>
>>> This will pave way for VFIO to properly report its pending data sizes,
>>> which was actually buggy today.  Will be done in follow up patches.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/migration/register.h | 12 +++++++++
>>>    migration/migration.c        | 52 ++++++++++++++++++++++++++++++------
>>>    migration/savevm.c           |  7 +++--
>>>    migration/trace-events       |  2 +-
>>>    4 files changed, 62 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>> index 2320c3a981..3824958ba5 100644
>>> --- a/include/migration/register.h
>>> +++ b/include/migration/register.h
>>> @@ -17,12 +17,24 @@
>>>    #include "hw/core/vmstate-if.h"
>>>
>>>    typedef struct MigPendingData {
>>> +    /*
>>> +     * Modules can only update these fields in a query request via its
>>> +     * save_query_pending() API.
>>> +     */
>> Move comment to patch #5?
>>
>>>        /* How many bytes are pending for precopy / stopcopy? */
>>>        uint64_t precopy_bytes;
>>>        /* How many bytes are pending that can be transferred in postcopy? */
>>>        uint64_t postcopy_bytes;
>>> +    /* How many bytes that can only be transferred when VM stopped? */
>>> +    uint64_t stopcopy_bytes;
>> Keep consistent phrasing?
>>
>> /* Amount of pending bytes that can be transferred either in precopy or
>> stopcopy */
>> uint64_t precopy_bytes;
>> /* Amount of pending bytes that can be transferred in postcopy */
>> uint64_t postcopy_bytes;
>> /* Amount of pending bytes that can be transferred only in stopcopy */
>> uint64_t stopcopy_bytes;
>>
>>> +
>>> +    /*
>>> +     * Modules should never update these fields.
>>> +     */
>> Move comment to patch #5?
> Sure, I'll address all above.
>
>>>        /* Is this a fastpath query (which can be inaccurate)? */
>>>        bool fastpath;
>>> +    /* Total pending data */
>>> +    uint64_t total_bytes;
>>>    } MigPendingData ;
>>>
>>>    /**
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 99c4d09000..42facb16d1 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -3198,6 +3198,44 @@ typedef enum {
>>>        MIG_ITERATE_BREAK,          /* Break the loop */
>>>    } MigIterateState;
>>>
>>> +/* Are we ready to move to the next iteration phase? */
>>> +static bool migration_iteration_next_ready(MigrationState *s,
>>> +                                           MigPendingData *pending)
>>> +{
>>> +    /*
>>> +     * If the estimated values already suggest us to switchover, mark this
>>> +     * iteration finished, time to do a slow sync.
>>> +     */
>>> +    if (pending->total_bytes <= s->threshold_size) {
>>> +        return true;
>>> +    }
>>> +
>>> +    /*
>>> +     * Since we may have modules reporting stop-only data, we also want to
>>> +     * re-query with slow mode if all precopy data is moved over.  This
>>> +     * will also mark the current iteration done.
>>> +     *
>>> +     * This could happen when e.g. a module (like, VFIO) reports stopcopy
>>> +     * size too large so it will never yet satisfy the downtime with the
>>> +     * current setup (above check).  Here, slow version of re-query helps
>>> +     * because we keep trying the best to move whatever we have.
>>> +     */
>>> +    if (pending->precopy_bytes == 0) {
>>> +        return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>> +static void migration_iteration_go_next(MigPendingData *pending)
>>> +{
>>> +    /*
>>> +     * Do a slow sync will achieve this.  TODO: move RAM iteration code
>>> +     * into the core layer.
>>> +     */
>>> +    qemu_savevm_query_pending(pending, false);
>>> +}
>> I think the iteration terminology here could be confusing, because these two
>> functions are called from migration_iteration_run() and they don't refer to
>> the same iteration concept.
>> How about migration_pass_next_ready/migration_pass_go_next?
>> Or migration_dirty_sync_ready/migration_dirty_sync?
> I get the confusion, but IIUC the word "iteration" normally was used to
> describe one full walk of system resources, introducing "pass" may causing
> another way of confusion to me.
>
> E.g. see Dan's post in 2016 and since then iteration was defined as so:
>
> https://www.berrange.com/posts/2016/05/12/analysis-of-techniques-for-ensuring-migration-completion-with-kvm/
>
> Here, migration_iteration_run() was named to say "run the current
> iteration", but it doesn't necessarily mean it can only be run once for the
> current iteration.

Ah, thanks, reading the code with that in mind makes it much clearer.

However, I think iteration meaning is still not consistent, as 
update_iteration_initial_status() and 
MigrationState->iteration_{start_time, initial_bytes, initial_pages} 
refer to iteration as the 100ms period for rate measurement. Or am I 
missing something here?

Also the MIG_ITERATE_{SKIP,BREAK,RESUME} return value of 
migration_iteration_run() (and their docs) may be confusing, as it makes 
"iteration" more related to the while loop.
I just skimmed briefly, but can we make migration_iteration_run() return 
a bool? (I don't think SKIP value is really needed?)
BTW, while at it I noticed that the migration_iteration_run() doc is 
stale [1].

[1] 
https://elixir.bootlin.com/qemu/v11.0.0-rc2/source/migration/migration.c#L3202

>
> OTOH, I don't think it makes much sense we define "iteration" (or any new
> term at all) to be one run of migration_iteration_run(): currently, we
> invoke handlers' savevm iterator hook for each migration_iteration_run(),
> but that's pretty random behavior..
>
> For RAM, that's MAX_WAIT.  For VFIO, it's something else...
>
> It was still a "grey area" and no way to define, even if we may want to
> define it at some point to make each iterator to follow some rule.
>
> Comparing to that, iteration to be defined to describe one round of walk
> for all VM resources makes a lot of sense and it's a criticla concept for
> precopy.
>
Yes, I agree. I guess some refactoring of the migration_iteration_run() 
area could make it clearer (but not necessary as part of this series). 
Thanks.


