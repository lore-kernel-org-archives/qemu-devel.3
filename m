Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3CC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLDY-0000yz-PK; Tue, 06 Feb 2024 08:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXLDW-0000yO-RN
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:10:26 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXLDU-0004B3-1v
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:10:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laH5mVzvcjtZ94NA+z3zQ4SspngGDhhCnNZSr05RWBD+vZ0ltk+s7EZIr/3gIX5nHHqPf2Y9pBJwGF6U6x4gvmE0mG8qvmghMv1ztdMYU4kYc5ZEUekbV7fK+Nf6lkgu/RNV+mtRuFYumI+AOUipJgiSXVumKtsHYwrH+nHII7zCCGOfSCWMsqZ3WRpLrWrjHsrCnHlBxUZMWJMOQrEdCPalK/oA8kjz0RC32WxkJGKAjr01OEgRcA2T23b6aQIbJITDhzT3pn3wYvLKRIc0BifdGKlnaFdV5mbeXYq/nV7wtUFs2Di1ZOCuF+ha92LWgHyiy7702hCLFr2PK4n11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiYmnl2Ed7cppI9YrBuhuBKgNaFTA46uF2v4SNyYUBc=;
 b=kpv+Zj5ltVXizOqF8Xv5pItIJrY+RudXhpqpgPhKQ8REKezIGnTJM4SNn9/LA8nYV0Qe4wvNCOn6nO/zk9BNauFbi/gUkzIyTo3M0zDG8sa4yiOWpm7BZNZANAJqODzvbZkCR2e8G18EsC8G24/nJg/9/aKqSj2jgmKpdOed38fzCCrrl4eoGinZSrvpK8qFK+yzJ5T4Dxrqag6icqYGxw48k/Pibdbs+h7rVdLpmf2d9Ok4XgwTOtxiNWzWnUm3l4tQaRcen+utUUotmGjf3afzA5or6VOEgmLRm7HtoKifAQha016o2NXdSoMobIAtcWuT1qDn9Pp6OQoF1ude+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiYmnl2Ed7cppI9YrBuhuBKgNaFTA46uF2v4SNyYUBc=;
 b=cU1plcf31ZPxkn1MulsDp9OqadPuKzn2et+J+UgaTM+/Y/mLnPzV1e+CcR/KUTJKZTgAeLAFvkHx+cAXNKc9aVF1Uho4OodQm1poWNIvkseQJwoKZUCpmunRSTe813PD1PTwM4cusJCAnWrUDAt8JR/CjKBv7VRHIfolI+OpR+aSz7DSkHEgH2wjx9O+9oB8l35L5aaHmhKOkBxWINxkyqaQGUBQ1R5fMaaChrM6yO36eUDAYp7rOgFTQzS6VZkajS9VRAwnR0MpDbJbL9l8cLooAdeRiCBf7x+gu5tTbfP4/Qa7rio/4NEXaigcjmdGYRO5yN7/6RUGNgFwdi1bGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 13:10:17 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 13:10:17 +0000
Message-ID: <4a1ae6f1-83ad-4b9f-be9b-f62ade2db8c4@nvidia.com>
Date: Tue, 6 Feb 2024 15:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] migration: Add new migration channel connect and
 TLS upgrade APIs
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240125162528.7552-1-avihaih@nvidia.com> <ZcIEKpNDXGe3J4ra@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZcIEKpNDXGe3J4ra@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb35d7f-410b-497c-d6cc-08dc2714f6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqasdmf11V/vyaiK9c9lBMgtDRwI+RBTCq0+StuiCMfYS+NSN8j1/aVd9gxsLubA6WAorfNXTzTdwHAStdD5gRIB1US5IKd6ZYNdLfaPQZpKGtsXYoRzwrQ0lyIL2Z92EX8VHHDCzKxQWueCMZhfLwj8d0qA/hCSs/fERAFn71W50gWPckFTEHOowsCgZWRP3TkoXs4v/k3KWAidySe/pxXCdBHGt5cL+xvPPE2BEL8SHoLhaDWNBU4vy6Qc8wqbtlvEsh0aJ7G2j8qYVnBhbKHwGG/LmVHmi4r3hHx5ojk3BLSkHzogoeH1PAY3xpE/QDrD4hiiPS/k3mrLkbDcxZK9jRFAwJ7mHGnARVx+yqWiVZKWHbwyiy+uhhOLr/AEVWj+Y+ozy9Qe3p0/It4kJqfOqwbLhT2AvuX9f4InFH8Q6Pb+N6A87Qawrw7NZBHtHBJlY+ktygwz72KbhGAJRbjeaDKFqcDPfTfbscyVB90DJhhdagbYAwPJL1yEuMgo/NNLGzUOaU8tdyqHnL84Rq8TbLIgddJSkU+Yd7SMrPzychJAOepGeR/Of5RemnlASHXNJWNJDDcoh/yp3qKqhVgReybdiItPb1KEafY2m4vaCf7uqbGbMwtHH51077vVg3YFDtRb1NPdtbFti8uKug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(26005)(41300700001)(31686004)(2616005)(6916009)(36756003)(478600001)(38100700002)(6506007)(53546011)(6666004)(6512007)(83380400001)(6486002)(8936002)(5660300002)(2906002)(8676002)(86362001)(66556008)(31696002)(66476007)(4326008)(316002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMvKzZlRWhZSEJTTTRWZk5ETVRBOEQxNmVOOUw3NWNsa2xyZGV0T1BROFBG?=
 =?utf-8?B?T2JyODgxbm0yc2xVcE9GZWFPbnJ2NjEzcCtDR0MvZ2QxQ1Q5RXJ3NlB5bjJT?=
 =?utf-8?B?UkM1WncxeU1VV1lZdjYwTjlmdjFlaktBbTVxL3l5bFV6dGVKRFRzbXJDNjBR?=
 =?utf-8?B?YjFVWGo3ZFpUT0N3S2prTVNmZTNVSlUrUzg4V0pOb09UNjRzd2RKWEJIK1BD?=
 =?utf-8?B?cE0wOWdVU0ZNVUw0cGFBamFGQmhvRThPV1lRajd6Y3dXQmdNaFJCbSt2V0Vh?=
 =?utf-8?B?MUtxR2s0UWthTWx2emNWMmJRSnVTZTRhTlg3RjZGeUxKVjQ1bzMydVFHVFlY?=
 =?utf-8?B?SExsb1VpbUR6bmZJNlJsRkdUWURVR1JUZEtjcHFkMndoRmc5RGJzQU91UkVj?=
 =?utf-8?B?SFBRUHExcWp1TmVYSnUrY2dYSU91R3FyOFNZR0s1RlBiWExheVYyY05UUHZN?=
 =?utf-8?B?RWtRRVFsVHNmd09MVDdZblJ1K2N6NTJxMU5kaDR1c0RzYjRTMFVzL1lhNnRw?=
 =?utf-8?B?T1ZCZThaME9ETVBYT1VWaTZxTkVIN3R1em5UL282VXBFdzQvUnNsNCtjcWl3?=
 =?utf-8?B?d0hXTkpJcnNncDU5ZXM1bTBTNWo0bDJhTzZpSmNQbmVndUN2L0duWEZyMTI4?=
 =?utf-8?B?T0FUeklzRk9YTWZxSllxVWR6SFdzYzYxU3d6RjUrRzlTNHhTVS9jWmNKZDlj?=
 =?utf-8?B?eldiYWtiMmpwTkpod1VsU2l5SWRlWVptczk1OHAreGFsMFZSZTBIV0pTNXc3?=
 =?utf-8?B?V2NJSXhqM1YybXJXTkJSc3BIUlZPUnAyZkhQWGdoV2kvaGxobjhIMm5UK3M4?=
 =?utf-8?B?b0U0S3F1cWtaN2JMYU9MMjMrekE2U1JqMU13OTdQdHhnWVZhYXJhVlk4cmF1?=
 =?utf-8?B?MkJOSjdaM0tQb3MvS2k5MGd3MEhSM0FOcXIxMU9DRitXSC9IR2dPOUtsQ2V0?=
 =?utf-8?B?UVJwOEdnWkhUWWpsakJodmh6ZWowQm5nUEh5dCsxK2JnNndrc2kvSWN1VzdC?=
 =?utf-8?B?RFlJRTVzWEU0MlQxRE5vajdkT2cxd2dlYUpzdEJjK1l6NS9oUVJPbnNyY0NQ?=
 =?utf-8?B?YW1kNFZZUHJxUGkrNFJ4RFluZlh3WTdDemV3UzU3ZXlpa2l5M2hQdCtjQUdM?=
 =?utf-8?B?SnJ4NU9EVlN3L2JZMmd4VXBVQmJKYWFwYkFHZDZxM1NqTWtVeHIwTnQ3WStM?=
 =?utf-8?B?WkE3WmErRmI1VGxBZE5VRlIrRWs5Qi9ReVcwQ0dRbGxHZFgvdkJCbHRPTzAw?=
 =?utf-8?B?UjliemF0Q2laUlhSQVdBMFhCOHZaTVJpMGdNbElkcVM3azg2dVFZSWdmem5C?=
 =?utf-8?B?VlpKVnJvb2JuRURNUEM4d3N0Vk9KbE85SVAwZ0RnRGN6NEN1YjBlWnM3enVn?=
 =?utf-8?B?cU1QaWQ1MFA5RTdadUhsNnRxNmRiVkNnNnhGblIwS2dnWGxnY3kxcE4vMDQw?=
 =?utf-8?B?ZEFqeWkraVpzeDFzMGJ6RHdmOHpJRUo2OUFzV29teENrYUVBaDRPZ09CRU9J?=
 =?utf-8?B?a2doQ1hwMFo4b2dWR0F4NEhJdnZKUGRDcDVYVFBHc1J4WSt4Z2V0cS9KQ05q?=
 =?utf-8?B?SWpHcmIxak1iSjZsWnZTSEVUYzNSRUIxVEF4V0hLRFcvTTF6bnpnZ0JDQzVu?=
 =?utf-8?B?RDFSbWhxbG96Zm1BUmh6WHc1dUlXMTEvSXBYZlM5NmtUU2F6SXkva2dvMlpJ?=
 =?utf-8?B?V1ZDS0x1dXM0TS9EenREckkraDYzWFg5MHB3T3hVbVVyUXJUOXFDWVV0NkNi?=
 =?utf-8?B?V3F2VmN4clJZbGs4WlFFeUVhZGxxcFpZZ2MrSUl3NUgycFlxODV1aElwUEtE?=
 =?utf-8?B?bzJiSk9wQ3BEUVVycUlZNi9MZDRBdnI3Q3lBSDl1WS9GK2hXSXJ4enhCUEIy?=
 =?utf-8?B?NmwxZ1NGZS9QMEdFUlBPZkVLVStBL1dxdzlRaDNpaU5NTUNWdFFwcThCa2ZI?=
 =?utf-8?B?dVYwc21sZUE0WVRwaGF0NGtpSXlSUG9DV0MrTndaSXZ3eTZxMWptNkIyakFK?=
 =?utf-8?B?djhWa21EdjBkQjZMNjBJK2QxUE5iUkdlWER3Qkt4RVlVTDI5UjhhSnV2VUFp?=
 =?utf-8?B?SXhwK1I0OUhxOVljSFkrTG1hVVhXcjJOalhiUFRyUkdxS1ZOL3NRb0x3OXVz?=
 =?utf-8?Q?QgqiBaH8+CiGEkpCWW7KTjkY5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb35d7f-410b-497c-d6cc-08dc2714f6cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:10:17.5256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLSL9MNTF5VOf6Rfp/tiYf8fdff1HW66Ze5BL17Z3ZYM3csX94ngDIoao61WBKnuObdPDL6Rx3HCaUlCblc1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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


On 06/02/2024 12:04, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jan 25, 2024 at 06:25:11PM +0200, Avihai Horon wrote:
>> Hello,
>>
>> Today there are several types of migration channels that can be used
>> during migration: main migration channel, multifd channels and postcopy
>> preempt channel. Each channel type has its own code to connect and to
>> TLS upgrade itself when needed. There is no unified API for these tasks
>> and it makes the code a bit unclear and cumbersome.
>>
>> This series aims to solve this by introducing two new APIs for the above
>> tasks that will replace the existing code.
>>
>> The first one is an API to TLS upgrade migration channels. A new
>> function, migration_tls_channel_connect(), is introduced and is used by
>> main migration, multifd and postcopy preempt channels.
>>
>> The second one is an API to connect migration channels. A new function,
>> migration_channel_connect(), is introduced and is used by all migration
>> channels other than main migration channel, i.e., multifd and postcopy
>> preempt channels. The reason it's not used by main migration channel is
>> because the main channel is a bit special and has different flows, and I
>> didn't see a smooth way to include it.
>>
>> Patch breakdown:
>> 1-5: Some fixes and cleanups.
>> 6-12: Add new migration channel TLS upgrade API.
>> 13-17: Add new migration channel connect API.
> Hi, Avihai,
>
> I am queuing patch 1 as it does look like a real bug to fix asap.  I'll
> copy stable for that one.  For such patches, feel free to post separately
> next time if you think I should merge earlier than the rest.

Sure, will do so next time.

>
> For the thread race issue: I believe it should be fully covered by
> Fabiano's series, at least that's the plan.  Let me know if there's still
> something missing.

Yep, Fabiano's series seems to have taken care of everything.

>
> For the rest: I didn't closely check, but obviously many of the changes
> will not apply after applying Fabiano's fix on the thread races.  If you
> have anything that still think worth merging, please rebase to that (or
> wait for my pull; it should happen this week).

Sure, thanks.


