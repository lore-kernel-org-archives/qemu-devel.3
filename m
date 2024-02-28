Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA64CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGQ8-0001yE-4Y; Wed, 28 Feb 2024 04:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfGQ5-0001xj-AV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:40:09 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfGQ0-0006Db-MU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:40:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESM/kGyel+EQXPP+Q0YDGD9nlc++Jz0JpdyDWUMxXxjKQbexmIuxuecTjvyfakbq+JXBEyWDn2eSzOWskbwhIVyRPa53SDIRsKVCiSNh2uOxdhjZvpXK5nFh2rskpG0nT4dOfE86cxM3svE32mbJj8DsQL2ektIUWHNlI9Nb2Gem8FkN2sq09tkKdAc2+6+vdTGykFhmfoYGY3oXOqV7a+IXqS6aRIqFKCwlBIL9mydEcxAMK2qWSsH4rrc+kNWIdDiu4RjpBYmQHusla1D6cOLCFk7cZL2Yjx75LQm6kkLv9caq+oWkNKiN82hT3zYV0QaPh621MfDQn2JVQCZSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fas59M6yOJTK0+9JzDb4p62tbWeBpJ0ulaMBZFixhvQ=;
 b=klmRvZFnIbCmoBhfK+KhyY1OzHo5iOFAZs5ezIQ8X2ofscDsmPqFdShDd3xLE4iqUGsC5Y07Wz3gadmiQ+k5yCBCTp38+8mF1J7/Tso3X1aOo2yVf6S8jDOKwISGKThBju12icqc8lcc78bqunWEAmdTUTqEy4NlBA68q52BmMS8tZZdwPTkydHXrUHMxaSmdCX4jA3EF0Z23X+NW/cyNzQl47nNIL946WZvdKW/1pvaY3yrFqpaD2JLLgETt6NmrFlGE56TKu771+5hLf71M8R/NOcliwgErvhmaFhBdTHZWDyhMYbHwYS3u7J+exrzh0FyNBy7uPo/7Isn+5Ja5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fas59M6yOJTK0+9JzDb4p62tbWeBpJ0ulaMBZFixhvQ=;
 b=MQCWP9m2Jx9siGsguyIbCmNOy3aZJL2u1/I9OkHGtyKFktyWY5R1MlCXrPuy/X1aRgpXhePX7sc7FlDRJTg2xRbJZwBJZShqLampTevD+1FzHac74UGsbLcxfx99cVOIJOmDwTo9Zv1CJ6pKlWjks7d3NzcNnrB3bDuQauR4wk6l6y3gFujqg47MVMt76p6V2ikF3Mwz0Ip8oO8E3FCTpj81cPkXLyAeadInhX+HJz9JzIx+Qnyympg4kQq5MjXNPC3B1THCvP0tm+84EErwi8McL/7WVAkHDaJxstz7xG1Ce+RzFdS9Md2+pBndxOZ09VEOzReZownrtqpkGhrrWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 09:39:59 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 09:39:58 +0000
Message-ID: <f882db98-10e3-4c95-9ff9-1ab9a0c145ba@nvidia.com>
Date: Wed, 28 Feb 2024 11:39:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20240222155627.14563-1-avihaih@nvidia.com> <Zd2SPGPVhW80b1Hu@x1n>
 <f7fb1999-4400-446b-812d-184fa502627f@nvidia.com>
 <Zd6iw9dBhW6wKNxx@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zd6iw9dBhW6wKNxx@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: d571ae58-af33-4d3a-bf91-08dc38413a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMGl6CMLSoyKiZoeM5Y4aM2RgU2yOhMhM2SHtlQc3YOBuXZrUDrk5Sm6Zej8gc27/8vlDwUfoU6IOfITdVBGfGN9Wtp8gaNQGx6VD+3FoKTX8eAT2KoTo78ezcSqfNji8sKYKkChwMqSX5Na4UJfp38PNMgLPzkxMnibsQhzQ9FodaO9VSKfQWNO2iH2qYMBzRBLjvbywu+XbUUOzxJInan7Pq3aVc1Bt9tN08JCyLHmH6OLPLl3eS/h3AJNGgzXb2cQHvwFralbCMwPzJsm4bQkyNuJF2Z5CF9rV8mxAop9ANtbgOsBlKPiBJqgcRIq9AXcAGzyx8jxPqKagktMRt/zcsGkfclb9gqej3f4H7/6QN2s0xsAr/10wUunTIq4SvjTbpMckKSaEwAUR8jnBNpeuZ6miltUXZtADZD5wo/UZXQoh/ncU2OqE9UGDQIocdfMSz8/BtJc8HJtrf7ZbGeeBotUsn/zvRX6IAjW99ShDNeJ0nccS3OAn1+R29digJwS/zdKUOnyFAuzQNQvYuEr2Avc8Mym/Ow9iqRGJ+Gs2nwFRPwZzongW2up9LScgJHBfjw+x3Mn8knlDLodE816l2fCUROXPjQdTo6eebgVD5nsnf97wlD/Nw90Luvqb2FOxpDzIXvlosiFl1IFbTsJ1PcLNRdZcOSMA9Rez5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjA2VUs4T1ZVTXp6TDBOMnk4Q1QwTUliU2dhSlVFMDJkNzBteUdMcjVndHJF?=
 =?utf-8?B?RHhiV0RTWXhsL0JMOXVxbWVoa080RStDN1FnMnN4NEtHWk5reUNjNUhrajl3?=
 =?utf-8?B?N3pvbFprSnRITkVLYTdpOUJsdU4vQlgxOC9LVUJhUk9sRHRkbmRoQ3pXSFRL?=
 =?utf-8?B?dWNsYTJxVnVvWW1TamxhSmtabFZzVWs1MXpsTnRBaVhWM09pRTkzU25kMkJG?=
 =?utf-8?B?V0ZLRmNROVM4MXRhVjEyejFod2RFQzRqaHZ3aEFYYytEYlZyTXJEMkt6T2Ni?=
 =?utf-8?B?bUEwV0NwNmQ5T0ZRdExwSTFvdjJHVk9xdEljZnl6SHBlOURpaXVBMzRmYms0?=
 =?utf-8?B?dFFXNGpSR0t6L1gzWWpLNWQ1YkFQcjV0eGtPYlcrcE9LWWcyc0RNK0lGL0RX?=
 =?utf-8?B?TE1NT1puMWYyL21UKzdVdnlrd1V4TW53eENFTUh2Vy9DN1dkcTRDTVFjVE1L?=
 =?utf-8?B?OFozUWhEbzd0ZWdhck1nc0thcVM4Z1NKWlc5MW96NnE3VHBlUnhWcnFWaGpy?=
 =?utf-8?B?OVlMcTRwMGhyNlhocDdqczBYV1RmSWZHWnFxMW5qazBXeS92V3ZIbUZ0dkkr?=
 =?utf-8?B?R2hvNFdQNXI3SThNMjNMOGpBNjVYQnQyV2doSmVLQnhyOXF4NGZtN0diVnF6?=
 =?utf-8?B?N1MyeEo4YlcwaVFkQmtwMk9vUEF5VkhzMzJ3cVc5eXdPTEZkRS9jZ3VtejNL?=
 =?utf-8?B?aGF1MXVqK1BBcUNRMHZMbkUySXZPRGhNY01BNDMxNkRvZWJhQlY3aHR3WGJn?=
 =?utf-8?B?MDMveCtscjBjWkVpVm9zNDV3ckNsZjE5aTI0bDRUOUVJMTB2Y1BJRzFmcFZW?=
 =?utf-8?B?OFFXTDYrOWJhNWg2RmVncDU1QXMwcXVJbDRPN0J1NEFuOVA1cVJBTFE3aEdw?=
 =?utf-8?B?RnpLRUU4ZG1WcnlsSi8veHhFOGFocTF6Q1Y2YVNVT2lSRE5UbEFFb0Q3NkND?=
 =?utf-8?B?WHNXRG9qREo2WmhsQmlYWldXT0hDYk42S2RHQm5GdmlBWEVWK21RWERMc1I5?=
 =?utf-8?B?RG1NSGwzZFZkR0I2SkkzMmFteHNwdjBLQTRWMGJEUjJIYVF1VE5xd25KOXY0?=
 =?utf-8?B?bVVoWDdPTW9SWHo5amN6ckdiUU5xb0dhdFNkbjJOSWF3Z25pbGRBZnJMVGhO?=
 =?utf-8?B?QU1ja1VZa3FrTmZIZk05V25sajJJSGxUWFBVSkJMRU1YTVJCVHZnSXVoMGRl?=
 =?utf-8?B?YkNmV1g4VTlOSmpzbm5rUTJ4SjBxSWp2cFhVSXZTcTd3M3N6d1l6NEVuQnky?=
 =?utf-8?B?SCtXdDlxb2RxZFBDMlBCOFNuRkNrbTNDUGx5OVduR0YxaTU2OFlCTUtvMGcr?=
 =?utf-8?B?aW5FcG50V3dhMWxKWm1WUncyYlJza3JWYmdPaWw2V0hXUHhYek1WNXhvb2N6?=
 =?utf-8?B?TGM4S3hBNEFyVi9Ibm5KV3ZRdjdBQit3QVpSWEJDSE9YRkhLTHZnOTBGV2JJ?=
 =?utf-8?B?a0Q1MEdHWjZ1THViRUtBdTdCZVpXZ25HdWdpZTlDNVJZTWxyNUsrTi8xQVB2?=
 =?utf-8?B?bnY2M1JtYll0RnFhWC9ITUdOb0dNZzlmRHo1VUtNbDBzR2lHaEoyZVBDWUdE?=
 =?utf-8?B?aUMxQmMzbWNvdVhUMW1wRHl6VUxtQ2RYU3J5UXZDa2VUbDBjd2RROENDaVVF?=
 =?utf-8?B?VnA1MzN1ais4ckVYQ2sxQWtPZzkrWjlxUlNMZDZwanltby9LaFRPMHJ5NFFq?=
 =?utf-8?B?aHhuaDRRMG1OeEYvcUgyYnVYY2FWQkFhemN4bXFuK2kyc290RVppL3RpdDJJ?=
 =?utf-8?B?UlFMK1BkK2FvR1dLL1dYdS9TZk8rL2krb3FIUzlVK0tHVjdkdW40VTF6RlNy?=
 =?utf-8?B?dlFMSUVsdGtrMWZUMkF4S1A5cFJPeHEvWjdRS004NjJGaHpVekttaHdkSmNB?=
 =?utf-8?B?YVgrdTRsQjhSUVBoNUNKOEJFejZIdGxzbjRlejJUb0FIMG1DeURodi91TEJE?=
 =?utf-8?B?UlFnbVQrWkxMclJnT3F5am12c3pyZmRNcktXeERxQmlZZis2NTBKUlRIWFBY?=
 =?utf-8?B?akN4WlE2ZmRUWjd6bGlvRXBtb1ZTSGVXeGpNR3A3Yi9sVUtpcDBZWWZ0NDFD?=
 =?utf-8?B?dXVyd1BtZUxZeEgzVktiQkJKZXQ5aHNkYjhCekQ1ZUFsU3dwLzJLOXFaSm5S?=
 =?utf-8?Q?qU/7jyfZMfFkifyFTYr80tqsQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d571ae58-af33-4d3a-bf91-08dc38413a5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:39:58.4910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgyu5OyOs6y4Wnvq78YSAxV/MNYGvfBOlP4pWuqRmSpTp5ww8VwnaQjZ5EYEOGxHgFrU4rDTu6ZO/n+neVD+Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 28/02/2024 5:04, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 28, 2024 at 02:00:26AM +0200, Avihai Horon wrote:
>> On 27/02/2024 9:41, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
>>>> Currently, migration code serializes device data sending during pre-copy
>>>> iterative phase. As noted in the code comment, this is done to prevent
>>>> faster changing device from sending its data over and over.
>>> Frankly speaking I don't understand the rational behind 90697be889 ("live
>>> migration: Serialize vmstate saving in stage 2").  I don't even think I
>>> noticed this logic before even if I worked on migration for a few years...
>>>
>>> I was thinking all devices should always get its chance to run for some
>>> period during iterations.  Do you know the reasoning behind?  And I must
>>> confess I also know little on block migration, which seems to be relevant
>>> to this change.  Anyway, I also copy Jan just in case he'll be able to chim
>>> in.
>> I am not 100% sure either, but I can guess:
>> This commit is pretty old (dates to 2009), so maybe back then the only
>> iterative devices were block devices and RAM.
>> Block devices didn't change as fast as RAM (and were probably much bigger
>> than RAM), so it made sense to send them first and only then send RAM, which
>> changed constantly.
> Makes sense.  For some reason I read it the other way round previously.
>
>>> If there is a fast changing device, even if we don't proceed with other
>>> device iterators and we stick with the current one, assuming it can finally
>>> finish dumping all data, but then we'll proceed with other devices and the
>>> fast changing device can again accumulate dirty information?
>> I guess this logic only makes sense for the case where we only have block
>> devices and a RAM device, because the block devices wouldn't change that
>> much?
>>
>>>> However, with switchover-ack capability enabled, this behavior can be
>>>> problematic and may prevent migration from converging. The problem lies
>>>> in the fact that an earlier device may never finish sending its data and
>>>> thus block other devices from sending theirs.
>>> Yes, this is a problem.
>>>
>>>> This bug was observed in several VFIO migration scenarios where some
>>>> workload on the VM prevented RAM from ever reaching a hard zero, not
>>>> allowing VFIO initial pre-copy data to be sent, and thus destination
>>>> could not ack switchover. Note that the same scenario, but without
>>>> switchover-ack, would converge.
>>>>
>>>> Fix it by not serializing device data sending during pre-copy iterative
>>>> phase if switchover was not acked yet.
>>> I am still not fully convinced that it's even legal that one device can
>>> consume all iterator's bandwidth, ignoring the rest..  Though again it's
>>> not about this patch, but about commit 90697be889.
>> Yes, I agree. As I wrote above, maybe this was valid back then when the only
>> iterative devices were block and RAM.
>>
>>> I'm thinking whether we should allow each device to have its own portion of
>>> chance to push data for each call to qemu_savevm_state_iterate(),
>>> irrelevant of vfio's switchover-ack capability.
>> I wasn't sure for 100% why we have this logic in the first place, so I wrote
>> my patch as little invasive as possible, keeping migration behavior as is
>> (except for switchover-ack).
>> But I tend to agree with you for three reasons:
>>
>> 1. I think block migration is deprecated (see commits 66db46ca83b8,
>> 40101f320d6b and 8846b5bfca76).
>> Instead, users are instructed to use blockdev-mirror and co. [1]. If I'm not
>> mistaken, this operates using a different infrastructure than migration.
>> So this logic is not relevant anymore.
>>
>> 2. As you pointed out earlier, the fast changing device can accumulate dirty
>> data over and over. VFIO devices come after RAM, so this logic doesn't
>> achieve its goal in this case (we may sync fast changing RAM over and over).
>>
>> 3. My fix in this patch won't solve a similar problem that could happen,
>> where a VFIO device with a lot of pre-copy data (not necessarily initial
>> data) may never be able to send it, thus not realizing the full potential of
>> pre-copy for VFIO.
>> (I personally have not encountered this problem yet, but maybe it can happen
>> with a vGPU).
> Thanks for a summary.
>
>>
>> If you agree, I can send a v2 that simply removes this logic and gives every
>> device an equal chance to send its data (like Joao showed) with some
>> explanation why we do it.
> Let's see whether others have an opinion, but to me I think we can give it
> a shot.  In that case we can "break" in the previous "ret < 0" check
> already.

Sure.
So I will wait some more and may send v2 next week, if no special 
feedback is received.

>
> One more thing to mention is then I think we need to calculate the case of
> "all iterators returned 1" (aka, "all completes") scenario.  With the old
> check it is guaranteed if the loop iterates over all iterators then all
> iterators have completed.  Now we allow ret==0 to keep iterating, then the
> check needs to be done explicitly.
>
> In general, it could be something like:
>
>    all_done = 1;
>    loop {
>      ...
>      ret = se->ops->save_live_iterate(f, se->opaque);
>      if (ret < 0) {
>        /* error handling.. */
>        ...
>        break;
>      } else if (ret == 0) {
>        all_done = 0;
>      }
>    }
>    return all_done;

Yes, this looks good.

>> We could also give RAM precedence over other devices only during the first
>> iteration of sending RAM (i.e., only until first dirty sync), but I don't
>> know how much benefit this would give.
> That sounds a bit tricky.  We can leave that for later until justified to
> be anything useful.

I agree.

>
> Now when I checked VFIO code I found that VFIO still may have two issues:
>
> ====
> 1) VFIO doesn't yet respect migration_rate_exceeded()
>
> That's the knob we use to limit send throughput when user specified the bw
> to be something not zero, then throttling will apply.  Currently it seems
> VFIO always sends limited data per iteration - a little bit more than
> 1MB-ish?

Correct.

>    I'm mostly only looking at VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
> which seems fine, because in qemu_savevm_state_iterate() there's one more
> migration_rate_exceeded() check anyway:
>
>          if (migration_rate_exceeded(f)) {
>              return 0;
>          }
>
> However it may be good that VFIO will also use migration_rate_exceeded()
> inside the iterator (before we can have some better way to do throttling..).

You mean that you want to add a migration_rate_exceeded() check inside 
vfio_save_iterate() before we send any data?
E.g.:

static int vfio_save_iterate(QEMUFile *f, void *opaque)
{
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;

+   if (migration_rate_exceeded()) {
+       // return early
+   }

     data_size = vfio_save_block(f, migration);
     if (data_size < 0) {
         return data_size;
     }

Or check migration_rate_exceeded() not only here, but also during 
sending of the 1MB buffer (inside vfio_save_block())?

Either way, I think this would only complicate things for no real 
benefit: even if we do exceed BW, it would only be by 1MB max, and IMHO 
this shouldn't make any real difference.

>
> 2) vfio_save_iterate() always return 1
>
> IIUC right now "1" means "all data is sent"?  But that seems not true for
> VFIO if returned 1 every time.
>
> I think it's not a major issue, e.g. the main migration routine even
> ignored the retval of qemu_savevm_state_iterate(), the rest VFIO data
> should rely on the upcoming loops over ->save_live_complete_precopy().
>
> However I think it could already break bg_migration_iteration_run() as it
> doesn't do that (it stores device state _before_ normal iterators).  But I
> agree bg-snapshot is never ready with VFIO anyway and the feature itself is
> probably still flaky, so not a major concern.  Just want to raise it up
> when we're there.

Sure.
I think this "always return 1" in vfio_save_iterate() was a small hack 
to avoid one VFIO device blocking the others due to 
qemu_savevm_state_iterate() serialization behavior.
Now with the serialization removed, I can add a patch that changes the 
"always return 1" to a proper return value based on remaining data left.

> ====
>
> Besides all above, I think we are just still not good enough to do proper
> bandwidth provisioning over the iterators if the max-bandwidth is set
> pretty low: even with above change to allow iterators to proceed with
> ret==0, we can also hit the case where RAM is very busy, it consumes all
> bandwidth, and migration_rate_exceeded() reported true, then VFIO will be
> skipped again as it's after RAM iterators.  We may at least want to
> remember the last time we iterated here, and then for the next iteration we
> go with the handler next to it.  But that should not happen with high /
> unlimited bandwidth setup, and can be another story.

Indeed.
As you said, I think it's more of a problem with low BW. If it's fine by 
you, this can be addressed later if we see real scenarios encountering 
this situation.

Thanks.


