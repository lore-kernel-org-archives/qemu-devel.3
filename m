Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FBC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 15:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6NN-0001PO-MU; Thu, 08 Feb 2024 10:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rY6NM-0001PC-15
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:31:44 -0500
Received: from mail-bn1nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2407::601]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rY6NJ-0002v4-DI
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:31:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWkk0n2zt24t4HZbIq6eSgsPZmpprbDlt8c90IXXPov352teuqFOUmFzK2RloW0myDIFHqh08dCCkDVrZP8EadOZWbtxYTgf7yjUVB1L4Rlgs57evm0UhqA//TAA19aSlZcJBjtURlB/wIzKfJZ2H+UF1YtH3D/J1QD++OrTXY4rgMs55aYA4OIn+M5PC63njUe/bE9H3QMvZmnoimHAa97J2DuaWMV7b2nlAVtKEwuMs9LBzzYHwKd1+2lOyeFXDkcdDOvgq+0wCCRKECxi8DWcEAsuLbjH0NN1Ch9Ul800DrEfv4AfTatFvrc+0sDSrMId7LnQR+vem6HMjZs+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1enQFiQ9kO0qEjvWpMPA0nUJfAZfNmz26bVENY343s=;
 b=g+NaRac7dqUYER0j4HHyHGZDBxP57xUOrJJ0apQ6jzV605op7gV5ZkXC7oHXAh44Lmfzn0lNw3VEsELPkyp/C6Ba9nxfIywui8R/QjB3VsEkdZ6twswydoUBm1qHfw3k7pitpT4513sown4jluHq8P7LvbrQCmP5eNOBXeKcf1R0IrVc8j2iut8nDX5nxbDmCzH1GNJW9K0Ctxv2Msht0SpYh7ZoXRghJ6hSSrahon5bU18IKraugrSDDBqkHQehiSXjIwhVMOWvvzWOpUAXoBo/im2NxX3ry+SnRL4rv0uNM4OK0yCSIV6iLArNd/6awTCq71Uu+mxCL0Ifp9NZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1enQFiQ9kO0qEjvWpMPA0nUJfAZfNmz26bVENY343s=;
 b=dws+Mkol9md6Q02SgcRTfSy1VU/Nv05bpJTpYaJuk1UEjkY/c9qq0mof27z/eWNpBMenU1phAAX6R9ziL/yD6S6EixwTgDhUryRN4tOKGHLK2F0As1hX+7outB9OPT5VcQtWLQuQCWVxPFFwu46n7W5Hc0tJyURqA9fBRF4ZH6886gjLDUvd10SK8WUjAu7tL5HbhY9CTPt9Vb3N9ycIisDrBuQpH84Jd3CiGB7V7SsdzKVSJ6tESQLfF0DSbaOZibmZy3lItLZxxJXGuRaGjAUCdTGqx1CmlugN4dMIgGLapr0W2ghDPPDhLtwU/ow2IkoImO4/a0lLo91Y1hO27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 15:31:36 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 15:31:36 +0000
Message-ID: <f1882336-15ac-40a4-b481-03efdb152510@nvidia.com>
Date: Thu, 8 Feb 2024 17:31:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Maciej Szmigiero <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com> <Zbcm1nXzQ_r0eGG0@x1n>
 <0f75090d-bbe1-43cb-b649-a0880bc413c4@nvidia.com> <ZbiP1Ayqxj9BLdY7@x1n>
 <113f4fe5-30d4-4aff-9f60-91b2a0c103e5@nvidia.com> <ZcIJNfoHs6iC1ZwN@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZcIJNfoHs6iC1ZwN@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee81e69-c6d4-45a1-b6e5-08dc28bb099a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikr/Fcd/5x8eyOOwzadDKnYzfoHCsBmEOlvSbHOLtMiy8N03q4jP6B0JCoaKMSgUSI33Gflew1EamoTLtYibSZkZIGhuOYc1DQJokgjKRC8Jw+mqk256BUK12njyWpvRnFxN7ACUKn/ntRQruWlGVL5kJvLsDy00lH9COLp7omL9XqzkSx8oDkKEr3IT1fTQleyclkYiIw3XOBKfYx+oW2AHl4t3AcBn38ntQ4StZ4dwX98SvFpet/D1CPpafc9x5XP1s1yVB0J7mvj63+RmCphyLC7hocLfCupg84YOc4zqtE7MqBBDbaq7qp2MisUoZ2M+oauGNKIPvZPd8zlMoruoH4yYChAuVNDpC68hUH8BExNtVNPdbf4s517EeyDvg/AxtQY/58YBgQ3gBrX1onyMwR9qK9q4XzvsPrrgYeCsgyQKO4wvqvFEPLlpx06Gc8AMWsvZy+YSW47Oq9G0GDsFlMFNZzWsXsLUUfHOX1K84848JQCh647aZeDl9u5+tqf3xjX+s20AWwr93JLJmp7CDltDe1MgwJiJKLX42vaZ1gmfIzljiiVLPHMNkSMI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66899024)(6666004)(53546011)(8936002)(6512007)(66476007)(316002)(31696002)(2616005)(36756003)(30864003)(66556008)(26005)(4326008)(5660300002)(2906002)(66946007)(6916009)(54906003)(8676002)(6506007)(41300700001)(966005)(6486002)(478600001)(86362001)(31686004)(83380400001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3plVXR0cDI5eVlZUnN4QmZnYmwwdks1NVAyM2lBTmE3U0JVeVZkMjV0QVdR?=
 =?utf-8?B?eTlBenBtdThWZlMvcjBwZmZXQ3czSnk1cTlPNEFVRWM0YzFKc1JrMDBUYldp?=
 =?utf-8?B?R2k4Y2hCU3JUY3pKRk9BdXZQL3haL1gvd3R5cTRMY0xocUxQYUtjNkd5bWJq?=
 =?utf-8?B?UlJqSUtDNFJhSUdBTzlkMFJjaDI0RTFiWjNJU09KaW9jZERxUC9Ic2tnMDB1?=
 =?utf-8?B?eXdVaHZmSFNnMmZ0WTA3SFZEd29GdmROdXJ1VW9zUXNJMks0bkordWVKMEFu?=
 =?utf-8?B?Wnc2VENKMytudFpyc1k0YXcyNHJPd1RKWCtRYUtiWjAwMkQ1aGNxR3UxMUN3?=
 =?utf-8?B?WW5ZRDNaUUZ6Mm5YdDM5YVBKZ1pINHhRb0d5a1RCOFNpVjhvR3d5WVNGV3Jx?=
 =?utf-8?B?YzI4TjVRWTdKVzkrdkFpUUtQSXdTWGZZNU10aFVOS2JSbFIzcGgzTnJhTlJ4?=
 =?utf-8?B?QThRSFd6c1dodFplTEZZZ0hUcy9hNDFyRWhlR0Y4VVZNYVBXYXFnd2RnYmlt?=
 =?utf-8?B?RG9ZQXpkanlxL0ZBUFp0emtaVmZCdzVMWVNwZGUzVWlISk9CMWhHMEVuMXBL?=
 =?utf-8?B?dDgxSEl4M2dwM3drcHRxQXA0My9Pc3c5M0ZqbHpKclVSNUZmY1lXVFRnKzNP?=
 =?utf-8?B?R3p1UUFMTEVCeGRvYkovaVhja0IwSTk5WHN6eG9FSFZ6NVBVeGhvMFNxVFk3?=
 =?utf-8?B?UjVvSmo5dGc4WDVQeHlaV0IvbTF1ZEJ1eVdsbGwvMDFEakI5RGhWaFpvVjZu?=
 =?utf-8?B?d3R4U1lxenlhYUQzNzBoWjhMQ1hvM2EvWHd6U3hjd2U2MG1PUVd3Wng1WjJH?=
 =?utf-8?B?dUVXMUFDcWhCU3hqVDlJcWx1NkRDTDBYQlJ0VXNqWTZVbHdzb3RwSEh0aXFT?=
 =?utf-8?B?YmtlcnlKOHZqeXZ4Z2hXRTkrYnFXekd3ZW84bXlVRTJtbkRKOHBIWTB6ckxq?=
 =?utf-8?B?Z2NNc0c4Ujc0cWxubjR0dUY4N0lDbzcySENUM1o4QWpCRHFYZmhJMjFOaXA5?=
 =?utf-8?B?ZkJUYWkvdlVZelRhR0xCc2o5d3BjdEdTcXpTMWxLeFNyVlBpQm1FRFVYSXFN?=
 =?utf-8?B?NGFzWGQwUGJDak5OTjk2UlJOL3VNL0lsSllESlJ5dUdpNFBOM25pblk2M0hF?=
 =?utf-8?B?NE10K253QlJJTWtVOFR6YVJ3ZDU5dkdMcWFyd3N3a1dqUEpLd2M0b04rQmoy?=
 =?utf-8?B?U2EwaFEvWWh6RHVzL0Q3bFVNMWR0cDRlcTIrcVhKN2paY2E2NisvcXpFa3d3?=
 =?utf-8?B?ZVhwTVNRZmNpdWdGL2pNY1pWckJBWHdoZVUwcE1uNisrS0JsMXFpUGdIbDVQ?=
 =?utf-8?B?OEg5ejZPZmZHVmZ5emlnVmFxbnJaSUtXV0VwSHR1elNOL2hMWEFZaS9EVkND?=
 =?utf-8?B?OEIzTXJsWkxWdG5RdUJlaVhSTGdzWGdCTlgwM2pmNFdjVERsOFpJMnlHVnNk?=
 =?utf-8?B?RjloaDFEUWFOaGIvVlkxd1c4dDJ1T2tYK01GQnhlb1NoSVVoNGh6NmRqVFZH?=
 =?utf-8?B?QjRyZXNDUW8yaVUxbE90dTU2cC9KeXlpTFVkeE9iQjZ4eHd0SjJnQk1vVjcr?=
 =?utf-8?B?Q0poK2pVcXhwaS9nZ3JEYTdaRzQzQXZOL3pQc09DWW95Skl5dUx2Yis3M2wr?=
 =?utf-8?B?cGI1VjFyd1Q0VzR5RjBJbHpCOGtNWlczWUNuZUd3VFg3blFhOHNhekF4RE85?=
 =?utf-8?B?QW9UTDF0MkN0aEtvWml4V1RwenZUd3dsT0MzLzlyR2tvRXVQdnNIemU2VFRK?=
 =?utf-8?B?eHIvOEoxSDQ2bkRPd2tQWWwxMC83MHcrWGNMb0hXcmxCdkFZcTBlOCtySEsv?=
 =?utf-8?B?UndQRnIvMXNzV0FwVGpaRDh2RzdzRzc3SDk1bWdQL090dlJmOStQaStYTk95?=
 =?utf-8?B?cldhdzBxNlcxRkJxS3lEU3pMQ3pvb3lkOUlub1R2RzdDM1U5Wkg0bGc1TE0x?=
 =?utf-8?B?Q0NrWE92MW5RYXB4ZmJlK3ZvdlVPRDF2RlV3TnRFaU1YYWJNeGpaVkQyRTF3?=
 =?utf-8?B?MmZvR0hVd05SNlh6S0l1MkxhNmM3K3prVGl1dzVKS0cvT21BOG1mVzVXTzFv?=
 =?utf-8?B?RXNhVzNBZkJBamJOOHlTcC9PdWlZTFgxV05ZUmFZTTd1ZTRMYklRMHFCSmZa?=
 =?utf-8?Q?zYuhtYGL47js2kAtftqbohEuF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee81e69-c6d4-45a1-b6e5-08dc28bb099a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:31:36.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IscDCWVHERthLRgecuzZny7se1NddolEuu8+X7aTtqTxUuhhqrIYuGEZSNiMUjGuhMVGt+HPNaWrnuaI7cZo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
Received-SPF: softfail client-ip=2a01:111:f403:2407::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
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


On 06/02/2024 12:25, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jan 30, 2024 at 08:44:19PM +0200, Avihai Horon wrote:
>> On 30/01/2024 7:57, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Jan 29, 2024 at 02:20:35PM +0200, Avihai Horon wrote:
>>>> On 29/01/2024 6:17, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
>>>>>> On 25/01/2024 22:57, Fabiano Rosas wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>>>>>
>>>>>>>> The commit in the fixes line moved multifd thread creation to a
>>>>>>>> different location, but forgot to move the p->running = true assignment
>>>>>>>> as well. Thus, p->running is set to true before multifd thread is
>>>>>>>> actually created.
>>>>>>>>
>>>>>>>> p->running is used in multifd_save_cleanup() to decide whether to join
>>>>>>>> the multifd thread or not.
>>>>>>>>
>>>>>>>> With TLS, an error in multifd_tls_channel_connect() can lead to a
>>>>>>>> segmentation fault because p->running is true but p->thread is never
>>>>>>>> initialized, so multifd_save_cleanup() tries to join an uninitialized
>>>>>>>> thread.
>>>>>>>>
>>>>>>>> Fix it by moving p->running = true assignment right after multifd thread
>>>>>>>> creation. Also move qio_channel_set_delay() to there, as this is where
>>>>>>>> it used to be originally.
>>>>>>>>
>>>>>>>> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
>>>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>>>> Just for context, I haven't looked at this patch yet, but we were
>>>>>>> planning to remove p->running altogether:
>>>>>>>
>>>>>>> https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
>>>>>> Thanks for putting me in the picture.
>>>>>> I see that there has been a discussion about the multifd creation/treadown
>>>>>> flow.
>>>>>> In light of this discussion, I can already see a few problems in my series
>>>>>> that I didn't notice before (such as the TLS handshake thread leak).
>>>>>> The thread you mentioned here and some of my patches point out some problems
>>>>>> in multifd creation/treardown. I guess we can discuss it and see what's the
>>>>>> best way to solve them.
>>>>>>
>>>>>> Regarding this patch, your solution indeed solves the bug that this patch
>>>>>> addresses, so maybe this could be dropped (or only noted in your patch).
>>>>>>
>>>>>> Maybe I should also put you (and Peter) in context for this whole series --
>>>>>> I am writing it as preparation for adding a separate migration channel for
>>>>>> VFIO device migration, so VFIO devices could be migrated in parallel.
>>>>>> So this series tries to lay down some foundations to facilitate it.
>>>>> Avihai, is the throughput the only reason that VFIO would like to have a
>>>>> separate channel?
>>>> Actually, the main reason is to be able to send and load multiple VFIO
>>>> devices data in parallel.
>>>> For example, today if we have three VFIO devices, they are migrated
>>>> sequentially one after another.
>>>> This particularly hurts during the complete pre-copy phase (downtime), as
>>>> loading the VFIO data in destination involves FW interaction and resource
>>>> allocation, which takes time and simply blocks the other devices from
>>>> sending and loading their data.
>>>> Providing a separate channel and thread for each VIFO device solves this
>>>> problem and ideally reduces the VFIO contribution to downtime from sum{VFIO
>>>> device #1, ..., VFIO device #N} to max{VFIO device #1, ..., VFIO device #N}.
>>> I see.
>>>
>>>>> I'm wondering if we can also use multifd threads to send vfio data at some
>>>>> point.  Now multifd indeed is closely bound to ram pages but maybe it'll
>>>>> change in the near future to take any load?
>>>>>
>>>>> Multifd is for solving the throughput issue already. If vfio has the same
>>>>> goal, IMHO it'll be good to keep them using the same thread model, instead
>>>>> of managing different threads in different places.  With that, any user
>>>>> setting (for example, multifd-n-threads) will naturally apply to all
>>>>> components, rather than relying on yet-another vfio-migration-threads-num
>>>>> parameter.
>>>> Frankly, I didn't really put much attention to the throughput factor, and my
>>>> plan is to introduce only a single thread per device.
>>>> VFIO devices may have many GBs of data to migrate (e.g., vGPUs) and even
>>>> mlx5 VFs can have a few GBs of data.
>>>> So what you are saying here is interesting, although I didn't test such
>>>> scenario to see the actual benefit.
>>>>
>>>> I am trying to think if/how this could work and I have a few concerns:
>>>> 1. RAM is made of fixed-positioned pages that can be randomly read/written,
>>>> so sending these pages over multiple channels and loading them in the
>>>> destination can work pretty naturally without much overhead.
>>>>      VFIO device data, on the other hand, is just an opaque stream of bytes
>>>> from QEMU point of view. This means that if we break this data to "packets"
>>>> and send them over multiple channels, we must preserve the order by which
>>>> this data was
>>>>      originally read from the device and write the data in the same order to
>>>> the destination device.
>>>>      I am wondering if the overhead of maintaining such order may hurt
>>>> performance, making it not worthwhile.
>>> Indeed, it seems to me VFIO migration is based on a streaming model where
>>> there's no easy way to index a chunk of data.
>> Yes, you can see it here as well: https://elixir.bootlin.com/linux/v6.8-rc2/source/include/uapi/linux/vfio.h#L1039
>>
>>> Is there any background on how that kernel interface was designed?  It
>>> seems pretty unfriendly to concurrency already: even if multiple devices
>>> can migrate concurrently, each single device can already contain GBs of
>>> data as you said, which is pretty common here.  I'm a bit surprised to see
>>> that the kernel interface is designed in this way for such a device.
>> Not that I know of. There has been a pretty big discussion about the uAPI
>> back then when it was introduced, but not something formal.
>> However, I don't think having a few GBs of device data is the common case
>> for VFIO devices, I just pointed out the extreme cases.
> I had that impression possibly because our QE team tests VFIO normally with
> vGPU, and my memory is 1Q ~= 1GB device data, where NQ ~= N GB (mostly vRAM
> per my understanding).
>
>>> I was wondering the possibility of whether VFIO can provide data chunks
>>> with indexes just like RAM (which is represented in ramblock offsets).
>> I am not sure this would be feasible, as it will involve major changes to
>> the uAPI and for the devices.
>> But if that's something you wish to explore I can ask around and see if it's
>> a hard no go.
> The thing is if VFIO always relies on 1 fd read() then it's impossible to
> scale.  Maybe there's chance in the future to provide other interfaces so
> that at least data can be concurrently read or updated, even if they can
> not directly be offseted.

Yes, this could be some future work if it turns out to be a serious 
bottleneck.

>
>>>> 2. As I mentioned above, the main motivation for separate VFIO migration
>>>> channel/thread, as I see today, is to allow parallel migration of VFIO
>>>> devices.
>>>>      AFAIU multifd, as it is today, doesn't provide such parallelism (i.e., in
>>>> the complete pre-copy phase each device, be it RAM or VFIO, will fully send
>>>> its data over the multifd threads and only after finishing will the next
>>>> device send its data).
>>> Indeed. That's actually an issue not only to VFIO but also to migration in
>>> general: we can't migrate device states concurrently, and multifd is out of
>>> the picture here so far, but maybe there's chance.
>>>
>>> Consider huge VMs where there can be already ~500 vCPUs, each need their
>>> own get()/put() of CPU states from/to KVM.  It'll be nice if we can do this
>>> in concurrent threads too.  Here VFIO is one of the devices that will also
>>> benefit from such a design, and greatly.
>> Interesting, do you know how much time migrating these vCPUs take?
> Most of the vCPUs took only a portion of milliseconds, but some may took a
> long time like 100+ ms.  We still haven't looked into why some vCPU is
> special and what caused that slowness when save(), however consider >1
> vCPUs taking 100ms they'll be added up lump sum contributing to the total
> downtime.  That's definitely unwanted.
>
> If we can somehow concurrently submit device states save() jobs to multiple
> threads, then it could be potentially useful.

Yes, I agree.

>
>>> I added a todo in our wiki for this, which I see it a general improvement,
>>> and hopefully someone can look into this:
>>>
>>> https://wiki.qemu.org/ToDo/LiveMigration#Device_state_concurrency
>>>
>>> I hope VFIO can consider resolving this as a generic issue, rather than
>>> providing its own solution.
>>>
>>>> This is just what came to mind. Maybe we can think this more thoroughly and
>>>> see if it could work somehow, now or in the future.
>>>> However, I think making the multifd threads generic so they can send any
>>>> kind of data is a good thing in general, regardless of VFIO.
>>> Right.
>>>
>>> In general, having a VFIO separate channel may solve the immediate issue,
>>> but it may still won't solve all, meanwhile it may introduce the first
>>> example of using completely separate channel that migration won't easily
>>> manage itself, which IMHO can cause migration much harder to maintain in
>>> the future.
>>>
>>> It may also in the future become some technical debt that VFIO will need to
>>> take even if such a solution merged, because VFIO could have its own model
>>> of handling a few similar problems that migration has.
>>>
>>> I hope there's some way out that we can work together to improve the
>>> framework, providing a clean approach and consider for the long terms.
>> I understand your concern, and I hope as well we can work together towards a
>> proper and maintainable solution.
>> Even if we don't get VFIO to use the multifd framework directly, maybe
>> adding common APIs would be good enough.
> Yes.  Note that I haven't looked closely in your patchsets right now, as I
> mentioned it may not apply due to the recent fixes.  However please feel
> free to repost whatever that you think would still be worthwhile.

Sure.

>
>> For example, take this series of adding a common API to create migration
>> channels.
>> I also saw you and Fabiano have been talking about a thread-pool model to
>> replace the multifd threads. Maybe we can use such scheme also for VFIO and
>> even for the vCPUs case you mentioned above, each component stating how many
>> threads it needs and creating a big pool for all migration clients.
> We can keep discussing that.  So far I still think it'll be more valuable
> if you can propose something that will apply not only to VFIO but also
> other devices on concurrent save/loads, but I don't think I have everything
> thought thoroughly.  So feel free to go with what you think proper, and we
> can keep the discussion in your new thread if you're going to prepare
> something.

Well, it turns out that Oracle has been coding a PoC for VFIO parallel 
migration over the multifd framework.

It looks promising, so I will drop my efforts in the current approach, 
giving the lead to Maciej from Oracle (CCed him here) who coded this 
PoC. AFAIK, he is currently working on an initial series based on his 
PoC and he will post it when ready. I think in the meanwhile it would be 
good to CC him in other multifd work that could be related to VFIO 
parallel migration.

Thanks!


