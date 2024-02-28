Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F57C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 00:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf7Se-00045N-Sy; Tue, 27 Feb 2024 19:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rf7SI-0003zz-7j
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 19:05:53 -0500
Received: from mail-co1nam11on2057.outbound.protection.outlook.com
 ([40.107.220.57] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rf7S7-0004mV-EP
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 19:05:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSctM2rf5CeaF5a4+Y9qBwAoROgwkRgPrS283YXnTUtv48KmgW3+6zGstaA2loohFZgCxVGMoqY+txu1HqfqWgDszAbUwu4I71GCN7d975Rw64tyS7m1YgiTrCzOj6zJPEMqikBHOBtprmR2CZxKmrQEyHcH1kKmknsTsaTJLNS8R4OG0cnQCPPIFMV1/e3g5Fa0CYybxsm8CottYnPqLsjiSJCx5J7GSkYXO4zWtJLgpoAg1f30mydkdmzqQQwoMAB22lAYZh6QLrkiqEuNKWjSDeu+mwS1pIfG08IkOVPUHxWUtpezINefbEWKqRX/yjyMirZwkb01W+hrE9DVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrgs1amYH4obwD6qW2uVN51AfJmnVnE+otzghIr1wAA=;
 b=ddj5j/9xiLJzomMndwuUOkwUt+MR7Sz8xuzoTfo8obRWM5eNRf8Rtk6BFxUvvF0mS9QFjDKksRU0l3Pu/AZYQe5m+/WkJq4p8mIBjjObHIxL33c36cQ/7vCJ+aazMbcl0hM9OifJsmFmt37M5pPwte7kq4usyqpmIJ74Gg9G0HjvoVsW7yl8bMYcClpYFOIvb5u1S4yFEitDU8rvdLv6pFsJA0rzrPXmTpQvvvW0M8zmo3IVvOSJ0Fw8WZHonc1EPBLlmUF516rWTTBOXBL6396OM2WIZV0TA961ai92+KKctqmMMYec7gM+wygaEL00M3jxOQKpTBLfjFIch9PqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrgs1amYH4obwD6qW2uVN51AfJmnVnE+otzghIr1wAA=;
 b=m6CfwG5NDoQzbgxQliCZ7SyWXW3+PNImI6Fo3SdFirUtDUcXftSAAZqx+rxHG8sjptnia9gWom8uU1+ZMyrTyTH+LNbf8aaVYGF4Rk79EViFAI2E7znM1MytcIGLpy0tcIkCAew1wHjp5vNnf/ifn8z8qU98OAFOcsdIN0iybhujtosC080h4gToJ7DLoiDSIt/y3YDvEho45QmewYnKI+Ym6ZcV7w5gn+MtkhIrZ3yjd5BikgBB4ZS3X1axRUss50RyGqIMAFHe9gsAtL/0v6pZUM2o8B6u9GHwI93SgY2F/Je/gJgEnUuwR5RW/9ttr0HertppYdDr+/dYghfzHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 00:00:32 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 00:00:31 +0000
Message-ID: <f7fb1999-4400-446b-812d-184fa502627f@nvidia.com>
Date: Wed, 28 Feb 2024 02:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20240222155627.14563-1-avihaih@nvidia.com> <Zd2SPGPVhW80b1Hu@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zd2SPGPVhW80b1Hu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be45f5-3a65-4fde-5af4-08dc37f047a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3geNxa9AOjfGdtwDXiBPmnMXGEiD0fnGS0dGq+5gP8qC9vMuXF5TPqlbyHxHLW6DM695O89zBY8BfIuGEGkK1mcLA6i13PtvPJueyYSzDeKFHr69FltUQG9UqRv9UwfROLoC0fo2Z0wyeeBL7pGrQ/Y/kYmQgoQADE685xGfoZ71NC3feeANeb+uMPHRwmqxrktSaopyQhhdkMGjzbGyCCtmXm/wabGfgYjbo9rtxj9hn3UnGrsRvzhAgy36+YorucWa0kFMFBl0eJhBO76yGFD9jmBBL90GsSQrplgIsxwxpwAF9/YnGDwrqcEnV8J6Ovwp9yqIJw2l9shkzSRgomEZ9m5dICpm0yOy3t5/3zVuKUmhE1a6LTIlxzHu+H9ZDawAmpebAlzrLO3IA3GYB1uJLU4dCwWyQG0Ymv1X7tesiCinE7PN7BV3LPxWP0PvSYOaWGQuA1d6TkJFC4cQhpnXjvFM4qMlPyQWu3tSPYX/jT+GINXQ9xYG2TTNPudkmbnw1dVRH1e755o6cI/pVhgNIaUOftEW9+cHJn/HaOlEpTktj4WWs1GUDuQyyvVyQ/fNofmYCKfVbRgL/zQzNbv9zMcI77hXhojRVCmGZ8iduMC/QGysAnP8RBVE/cW7H6QGYCPNKyFQnhdUsRZ9Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHo4dzlBUXRpQ0R5SmU2NXVtcFhsWXBMTnB0SXFBWlpBY0lZS3lodnREV0ZU?=
 =?utf-8?B?dUlWZGFEbGovcCs5WkFvNWxVWno4VXJ0MkVqd1V6akxFMUpiM256MW9jby9P?=
 =?utf-8?B?alB2NHJETHB2Sk1RZVE4WHFLWE9oWmJ2OTMzUXlzZXR1RGwrb2pWWUxvNWpS?=
 =?utf-8?B?d3RjOFZ6WkJmeDVQSW13ZTc5eW9OSGdOMnZhT1luUjVHR3FCSGlKQXpQQWJJ?=
 =?utf-8?B?V3dtMnovN2k2WS9QY2JvMkNERmxndFk1RVFXcWFyb2F3QkhpL2xlampQVmJD?=
 =?utf-8?B?WGhLMlhIQjlsVUh1cDVLUzJzdFVYK0E4Z2xidHJWakpKVFpGcU9tSm5KdHpX?=
 =?utf-8?B?c1ZKbDB0YUFxV2VqTGdwR0hUUms2VE9VL3dJVGdwbkoyMXI5NEdMRy9WajAz?=
 =?utf-8?B?RGpYSVZlRzMrYjZ4K0F4RjRQTmQ1a1A0Mk80ajBLd1VtdjFyT1loQ3kyS0Vo?=
 =?utf-8?B?dUdUT3dneFJkdERlSmpQWHF2RnFkUXF6VEhia1I1NnVDbUk3ektxL2VmYm13?=
 =?utf-8?B?djZxOFdxZWpUTmRzcVR0M0t0RlY4L2UxY3pNSktQU3orNGR4bG5tbXdnUi9y?=
 =?utf-8?B?Zkd2UGpGcXNTekFWQTRFQzUxRkRwMEZzbG4za041cHdJazIzWlVNTkc4Z1JQ?=
 =?utf-8?B?Ynh2eDN0c05LeldMcGY4QU5yaC9VMFZMdlVXdDBTZkdPeFRHWFlsY0t0cHdq?=
 =?utf-8?B?U1ZwTTBCWXdQRjZFci93TFZFc1pKMG9OMU5wREtDQU82WnUvbkJHRDZXZFpo?=
 =?utf-8?B?Nmw5L0Q3NXB3VkpIbWxsWDZ1amlFY2lySTZta3dBTjNzRExuaFZrOTMxODZ4?=
 =?utf-8?B?dzVGZlJyby9CUVBIZDV5dkRpSmZCczNzUGFwMWF1N05JZkJ1RVBkeG14NHUy?=
 =?utf-8?B?dXFDZTdZNFdFL21VVDJRS3BOdTI0MEdINitTTHRTZE5oUDM3Nk84ODViaWRI?=
 =?utf-8?B?Z0s5QmQrUnVnVi9KTGZIblJMbFM4cFNWNEZ1d1dLaTdyMXE0S1pzSmFQeFpr?=
 =?utf-8?B?Qld1dnlpeC9MNTBlOWZwR2NnVXd1VndOMmZBUUlOS2RoYnh5WHhaWWNBd3hw?=
 =?utf-8?B?eWJPaDBadTRPQ0hPYmRxS1dpakRUODNEd2ovdVZSNmFlaktsWW9qV3dlQVVw?=
 =?utf-8?B?MHRrSlVoT1hLSFpTVHc2Z245VElmWkd6UjFUYUxrWHJPejVrdld1Z29zU3lC?=
 =?utf-8?B?Y2swLzBjb1NSUndGc1BrYVo0d3dKR1JZQStHL0tScFdrblphTTNKbHNVVVJI?=
 =?utf-8?B?Wm1VbElqWGlLU0twQStqZjkzS1kybUFKUXF0b3F0c2pSWm5TZkVvUXU0Qk11?=
 =?utf-8?B?NHovM2JFaE50VWdsd3FFWE5hRGJ0NzVpRmhkcG9lcFRHa2JJdWZicC82VGpq?=
 =?utf-8?B?cDJVcnd2R0ZQVXF3UzdwL2VvZXdWSEtjLzRIdGRRdXh5bFFWNEdSRzFwYVFy?=
 =?utf-8?B?ZTIyaGZSb09CY29zdmRLbzRGL2tIQmpLQVR1R2hIL3B6M080MHZQeDRNOVU1?=
 =?utf-8?B?NkNscERiSTZraHd0S0ZaeFlKc094YWZPYlRVNEdDSzBDbnVJU0dGZ2V5Tncx?=
 =?utf-8?B?WFdyMFZMUTlZS050TnFTQ1hNUU8wWnpoZTRXQi9QZm5QYktNaFlhL1NGc1Yx?=
 =?utf-8?B?ZmZKclNyYUlQSmRHWStuZVNZRWphWjI4LzJjRzZvYTNJdHRxU1dDYWJ6NE5m?=
 =?utf-8?B?b2R0c1BYL3dySStKRXZ1aXE5TFdoTkpKR2MzYTNpN1dSeEZyUkpReVJRRVZl?=
 =?utf-8?B?T2E1QWRtWnYyWHMramFJVElPWmQyVjlBVHkrcmdrSjlFSWw1TTlvd2xaNVRD?=
 =?utf-8?B?dTJrUlJIdlVNMkZKK08zT1RvOFozSm9EMGpWc2xkZElyMnp6aVdQY3ZrcC9C?=
 =?utf-8?B?and3UWpDMDROU21ML3R4YlorWER0eEMrZ3o2Z3NDVEZQN3ZVVWVVdjlYRkxJ?=
 =?utf-8?B?Nll5ZHl6Y2ZiYVVLeTdwbHZqVzgyOXQ2a0dWMGJBTEpWbnJ2ZVdWYmlRUmtS?=
 =?utf-8?B?aVAwWWtKS2Z1Qy9IWHN5dnNJeUxlWjN5bmpmYmozSDcvYXg5b1dpYzVLM21F?=
 =?utf-8?B?OVBEOUZzNEh3U2VZQ3VQSnJQd3puZDVKbWNrL2lMeWNvc0FzSUIyWDdySWto?=
 =?utf-8?Q?X+YcTrbi8pfEVLxsxtQu8TSQ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be45f5-3a65-4fde-5af4-08dc37f047a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 00:00:31.5131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv5k9hI11akS2Bnuf9s+aArjXZBFnhsy3Gd/C5tAeUYa26qq7gsgK1XbAMSO2A9I4ASy7A2VmNn1u3BzYfe/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Received-SPF: softfail client-ip=40.107.220.57;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 27/02/2024 9:41, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
>> Currently, migration code serializes device data sending during pre-copy
>> iterative phase. As noted in the code comment, this is done to prevent
>> faster changing device from sending its data over and over.
> Frankly speaking I don't understand the rational behind 90697be889 ("live
> migration: Serialize vmstate saving in stage 2").  I don't even think I
> noticed this logic before even if I worked on migration for a few years...
>
> I was thinking all devices should always get its chance to run for some
> period during iterations.  Do you know the reasoning behind?  And I must
> confess I also know little on block migration, which seems to be relevant
> to this change.  Anyway, I also copy Jan just in case he'll be able to chim
> in.

I am not 100% sure either, but I can guess:
This commit is pretty old (dates to 2009), so maybe back then the only 
iterative devices were block devices and RAM.
Block devices didn't change as fast as RAM (and were probably much 
bigger than RAM), so it made sense to send them first and only then send 
RAM, which changed constantly.

>
> If there is a fast changing device, even if we don't proceed with other
> device iterators and we stick with the current one, assuming it can finally
> finish dumping all data, but then we'll proceed with other devices and the
> fast changing device can again accumulate dirty information?

I guess this logic only makes sense for the case where we only have 
block devices and a RAM device, because the block devices wouldn't 
change that much?

>
>> However, with switchover-ack capability enabled, this behavior can be
>> problematic and may prevent migration from converging. The problem lies
>> in the fact that an earlier device may never finish sending its data and
>> thus block other devices from sending theirs.
> Yes, this is a problem.
>
>> This bug was observed in several VFIO migration scenarios where some
>> workload on the VM prevented RAM from ever reaching a hard zero, not
>> allowing VFIO initial pre-copy data to be sent, and thus destination
>> could not ack switchover. Note that the same scenario, but without
>> switchover-ack, would converge.
>>
>> Fix it by not serializing device data sending during pre-copy iterative
>> phase if switchover was not acked yet.
> I am still not fully convinced that it's even legal that one device can
> consume all iterator's bandwidth, ignoring the rest..  Though again it's
> not about this patch, but about commit 90697be889.

Yes, I agree. As I wrote above, maybe this was valid back then when the 
only iterative devices were block and RAM.

>
> I'm thinking whether we should allow each device to have its own portion of
> chance to push data for each call to qemu_savevm_state_iterate(),
> irrelevant of vfio's switchover-ack capability.

I wasn't sure for 100% why we have this logic in the first place, so I 
wrote my patch as little invasive as possible, keeping migration 
behavior as is (except for switchover-ack).
But I tend to agree with you for three reasons:

1. I think block migration is deprecated (see commits 66db46ca83b8, 
40101f320d6b and 8846b5bfca76).
Instead, users are instructed to use blockdev-mirror and co. [1]. If I'm 
not mistaken, this operates using a different infrastructure than migration.
So this logic is not relevant anymore.

2. As you pointed out earlier, the fast changing device can accumulate 
dirty data over and over. VFIO devices come after RAM, so this logic 
doesn't achieve its goal in this case (we may sync fast changing RAM 
over and over).

3. My fix in this patch won't solve a similar problem that could happen, 
where a VFIO device with a lot of pre-copy data (not necessarily initial 
data) may never be able to send it, thus not realizing the full 
potential of pre-copy for VFIO.
(I personally have not encountered this problem yet, but maybe it can 
happen with a vGPU).


If you agree, I can send a v2 that simply removes this logic and gives 
every device an equal chance to send its data (like Joao showed) with 
some explanation why we do it.
We could also give RAM precedence over other devices only during the 
first iteration of sending RAM (i.e., only until first dirty sync), but 
I don't know how much benefit this would give.

[1] https://qemu-project.gitlab.io/qemu/interop/live-block-operations.html

>
>> Fixes: 1b4adb10f898 ("migration: Implement switchover ack logic")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/savevm.h    |  2 +-
>>   migration/migration.c |  4 ++--
>>   migration/savevm.c    | 22 +++++++++++++++-------
>>   3 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index 74669733dd6..d4a368b522b 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -36,7 +36,7 @@ void qemu_savevm_state_setup(QEMUFile *f);
>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>   void qemu_savevm_state_header(QEMUFile *f);
>> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover);
>>   void qemu_savevm_state_cleanup(void);
>>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>   int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index ab21de2cadb..d8bfe1fb1b9 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3133,7 +3133,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>       }
>>
>>       /* Just another iteration step */
>> -    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
>> +    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy, can_switchover);
>>       return MIG_ITERATE_RESUME;
>>   }
>>
>> @@ -3216,7 +3216,7 @@ static MigIterateState bg_migration_iteration_run(MigrationState *s)
>>   {
>>       int res;
>>
>> -    res = qemu_savevm_state_iterate(s->to_dst_file, false);
>> +    res = qemu_savevm_state_iterate(s->to_dst_file, false, true);
>>       if (res > 0) {
>>           bg_migration_completion(s);
>>           return MIG_ITERATE_BREAK;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d612c8a9020..3a012796375 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1386,7 +1386,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>>    *   0 : We haven't finished, caller have to go again
>>    *   1 : We have finished, we can go to complete phase
>>    */
>> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover)
>>   {
>>       SaveStateEntry *se;
>>       int ret = 1;
>> @@ -1430,12 +1430,20 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>>                            "%d(%s): %d",
>>                            se->section_id, se->idstr, ret);
>>               qemu_file_set_error(f, ret);
>> +            return ret;
>>           }
>> -        if (ret <= 0) {
>> -            /* Do not proceed to the next vmstate before this one reported
>> -               completion of the current stage. This serializes the migration
>> -               and reduces the probability that a faster changing state is
>> -               synchronized over and over again. */
>> +
>> +        if (ret == 0 && can_switchover) {
>> +            /*
>> +             * Do not proceed to the next vmstate before this one reported
>> +             * completion of the current stage. This serializes the migration
>> +             * and reduces the probability that a faster changing state is
>> +             * synchronized over and over again.
>> +             * Do it only if migration can switchover. If migration can't
>> +             * switchover yet, do proceed to let other devices send their data
>> +             * too, as this may be required for switchover to be acked and
>> +             * migration to converge.
>> +             */
>>               break;
>>           }
>>       }
>> @@ -1724,7 +1732,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>       qemu_savevm_state_setup(f);
>>
>>       while (qemu_file_get_error(f) == 0) {
>> -        if (qemu_savevm_state_iterate(f, false) > 0) {
>> +        if (qemu_savevm_state_iterate(f, false, true) > 0) {
>>               break;
>>           }
>>       }
>> --
>> 2.26.3
>>
> --
> Peter Xu
>

