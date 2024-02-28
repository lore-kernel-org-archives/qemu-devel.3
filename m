Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AF8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGfw-0006md-Bt; Wed, 28 Feb 2024 04:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfGfu-0006k0-Dy
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:56:30 -0500
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfGfr-0003Wc-VS
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:56:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEjI65XlWy6RsPS5XbzI0cbAi4YSr8E2oBZG7BtwVTt2LJ83SlojtN9FmR9H0M+FAnsrnXEZKkzeQwrizH9IbkISqhihhhc51sSsCGUHFZJaoW5Gx2k7ju8f3li54av21c81FvkGIOKYITolKumovS3Y1OQkZ1XZqvtBOOF86jXH69mL20SrXFkcr1wqQL15RuBnelTONwzW911rXU/fGrSrkpqxoIsYK2uSM8v5h5TznhgO0KpMY67L5lT22LFDbdmZ4Pzyc0UD2Q/06sV4ui3mo27sUfRsmNvPU/yWsYhCipPQBCrBP05CeNtN9PBnFC6Dudp4kYnZLynxfNuY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKX8I3heyJ3TQqYCm/LCbL4sNIoZvtZNITkF1pFpR3I=;
 b=ksLtOL1JTJ0amprXSRlwuuKM8G2FlHSMYlecFIdkKBBi4904XiYLkyVVa4rq/nq/GWXMiAmB7SHyRVFZhfH94/mWcMprGKmA5iYlK5vo+lLqXRMYdMHKX+Bjln/2EjhokP76KkN3luDjGJzTYV3R82yvi/oMQ/AA8sEoEIzNqJwhyn2b9u0M4CRYdVBQnsmwgZbGrr4kERJaGC7SECyG5N7FtVtklZWI4ixvIyEYVzcKifiG3m2zJCeiFNXPqgxD50s1h9V4TyAn/DykdD32YjllVObcCMm5hGsQv2hCnOBvjmLN2e64y25CX7AL8mYxciXeXIc6MOVIXg73/4dGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKX8I3heyJ3TQqYCm/LCbL4sNIoZvtZNITkF1pFpR3I=;
 b=ZsPYSQbrpqwmgpfCNIPiuH8ZsJc1L6M464z8Aaze6lL0H/R+HJCrIasCuLOMxtN7pHRp8ESW2501fTuhBxbxROE4VBhEAS1P7lmPUFCeT5IMaUmYsTGG1pYuAWV7hA49JE3ZX+4hWe/Pu63xUVLoxgYwnVLdVuHeFyYQB+lIMygGNBzuWa6R4WglSVba7eyKOlanzYiereBEYGY4sxH1eQYJNy3uRkfVhgf6Vu94oxq5K+jgbtoBq1JW5gvtXr2Dxqs/fqfCo3d6cOunMb/eGK7xTvfkc4vL88T02KhwJWvBNEutN4y+E5A/kx2Sb9u0LnK/jO4vsRcSIG2CRxYoTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 09:56:22 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 09:56:22 +0000
Message-ID: <80e542a8-d663-4d97-a63c-e2e699bd22e0@nvidia.com>
Date: Wed, 28 Feb 2024 11:56:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Content-Language: en-US
To: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240222155627.14563-1-avihaih@nvidia.com>
 <6fa132c5-8ed8-41a6-a70d-90230ce3ca84@intel.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <6fa132c5-8ed8-41a6-a70d-90230ce3ca84@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0351.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::27) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 111294dc-7d11-4583-b519-08dc384384b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe9+7BvA+3W+zCrJhFWrEHpI4vAS8r/fJ9qpBUJrcszn01suzRFo67gxXH1gbwSIYiKCQjwljJ6XuMVWflg3mg3GbspjUR8k5pDHtqe5BPgvULZwDB2PNtwpzfMDhqftBxGXenSZ7bvjuKyTi6H5MJQANB47zBNP3YgfBdJhkUD5gkK1fHOucRWJud+2675MeyLIR9oPd5dV3tuifoF3riLtd/qbetYmAglgSQOj1eIHVKQCB4GATvUq1aV/ILok0V+KaXy7J2uwplQujG2lVqjXuoNk8yNJkeHQmYNR+tgM2J0Rbq44l4dngCKQLNu8qwlkU64w7RQ2NGJyiOZKpVy/g+W1faPFHf/NND+yeHtfXa1ZE6Dpb4gKsxROy5Agf6Fxwtek5czPLZwYgyTlKw9mWhxFDqYz+wwHc+MJVVlw4kr758DWOlCx/4O4P12VDpWAO1PVHgTc2z6yMVAzxS3OSVNgyrOmsCb1E8hruw5IisZVuZtqUnWVjw5mexAaJltXo8AY5QWLwh/CeeWf4TA2uuP73TMqbX8VNKndeRNu4AUeABsjnvvt6mONk3z3+V/Cp3AGuMJTZNed2323zNvI17Z/T+ZMuhxv0cH++zF/XOsFlPJdoECU7q/p+lqhGswqhvz02RGpvdeG8H6Hc5zbLTHrcKw+BsAUNRJrXOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUQ3UTZtR29MOXdGT24wWHRnYlpaeUE0NDFqNnRiWU1kS014Q2V3b0lxZDhR?=
 =?utf-8?B?NHpxbFhVV0t5bjZmM0psa3JyZXpCUmVidVZrTWo1c3RQR2U1ZnFoN0tOZnpX?=
 =?utf-8?B?QUV0RzJVKzBlU2NlM3N3YU4wTWNjYm82eEVDTUorbEplME9CR0J3cklOR0tY?=
 =?utf-8?B?REV1QjltazNZUnlGQTRLdEJLQzA3K1FsYy9JVmdIaWk5ZVdRWHc1by96bDRM?=
 =?utf-8?B?NDRtd1BmaFB4ZFE2MWVHZFo0aG42clBnY0U0YXNyTzJNOEJLNjl5d2V5UU0y?=
 =?utf-8?B?V2dESkNwd3QxZ0x5M0dPQW8wV2tIaTZXaERXd0hWQWgzTlZWZm5mNnArNzBT?=
 =?utf-8?B?YkR3NDBPb0wzd3dtVkRxY0w1ZXZTc3JuUGdhUFdESzRQL1JmTlhkcDh1aCtx?=
 =?utf-8?B?S3BObjd1V1Vxa2s0emlxVndPSUpIT2N3ano1TmlDbjdjZ3YvVHdHbXE5UWlF?=
 =?utf-8?B?MzFKVmFmV1FBUzM5SWcvSG9LSnRlSExzOCtEbUttSmZza2FlKzBWR3ZVZnRt?=
 =?utf-8?B?Wmt0V3VmRnpJYlcyU0hYOHd6TU5WYkF5eDU3MEpjTUdvL0lhN0RMTWo2SzBI?=
 =?utf-8?B?NHhwOWlmOHRNMS9Qbm9nQmVCWTk0R1NsbWYvL1BqK2pDSXJtaDhhalVxaWxm?=
 =?utf-8?B?bk14bDRrQS9QMGhybjhJSXZOakpTc1lsSkNlcVMvV3QxUDlEcUNIQk5BWFEv?=
 =?utf-8?B?L2dIMDZvTmxHSjRjeHhaTk14QzhJRmQ4NC82NGI1dnorUnU2anRZaHRTSjg2?=
 =?utf-8?B?eWpSUW42QWQ2SVZXUnJTM085UmFtNnVUR3BUOHdqY1hmWlZwVVBTblA0NTVx?=
 =?utf-8?B?d2RiN1BwQ1BVcmlaelVkVzZNc25EbkRKTm5wc0JsMTRGc0lINm5OQ2d5TmZN?=
 =?utf-8?B?eDh2ZUZLczAxS205WG9qOGsrWWV2MlBMUTBFSHhrKzdGOGVhRHppMmUzZ0JU?=
 =?utf-8?B?aDRHUFIzRkMrUkt6cVZjV0FiVmV1UmZud0dpOEdHRElvQktaNFJSMG5VS2li?=
 =?utf-8?B?bm9KM2Z2eTZFbG9VWFlPQ3d4TlJ6ZDNWVnJPbmJzL3FkUHVRcjlpcThMTC9V?=
 =?utf-8?B?OXJlMllHV3Y0dkswK0MvcWQ1am5kODBVbm9Sa1dldTUrZEZIRTg0d3VDWldQ?=
 =?utf-8?B?VzNUdGoreDNBbTI4aU9jYW1aODQ5aFBjUGNJMHZGcDhPRHJjanJPdStyMHo0?=
 =?utf-8?B?cERlbUNnY2I4dkplOXVMcDk2MHRxaE5CMHFSMU44ZVlyMzUzQThCZjBxdjdi?=
 =?utf-8?B?VkxRa2JoN1NYZjZaY1p3SFY2YjE4TE1CaWMxOFRuWjlKemc0QlJSajVYYXV0?=
 =?utf-8?B?SHp2YVRHdkpRWTdTSW12QUtUWG11QVhsZXNEL0tCems0Y0VlQ0xCQkV1WXFV?=
 =?utf-8?B?dUFYeXE1ODF2YXNmSFRadG1KUllocHE1TTVCczV5eXpBenhVdHkzdkRJb2hi?=
 =?utf-8?B?U2pQMGJISEN1cHhpb1FQY2JXVTdXeU1GY2dIOWRPOXVnd3Q4eit1UEJMNlpl?=
 =?utf-8?B?Wm9XS040ZkJnaTk0SUh4TU1EZTR6UTJnWVpHMlhHSTFTSFlmWWpsK3RaK2Uy?=
 =?utf-8?B?NXdmK2E5Q01iaWI3OHhEYTRWSjAvbm1ZemRwREw0RG1mVktPNTh6YmRabVZR?=
 =?utf-8?B?eDJDUXRKY2pEYjJjbkhxa1llcHVOQVZKVFNVZ2w5YVhJQktoYjFTSSsvWmFE?=
 =?utf-8?B?SFFuc2kvcG41dk9PU1ZKTVV4NTlCVGpVeGEzOStoSDZhNlJCZ1JBYXJjMjNE?=
 =?utf-8?B?dE53SEhIb0VYdGJsaTF5UGozVmdXaUF3K3pEeEx6M1dkck5OTzlXSjNUdnNa?=
 =?utf-8?B?N2hwMW5lTUNUTGdRTGJKKy9QYjJQYUtHd0plRzY1ZWVROHNaRDZ1MnZVTFVR?=
 =?utf-8?B?TTlQWUF4aWFYeGNsc3dDdTRVK2pHelFFN0Juc2Rra3lvaFlFYURRb2xDVW9n?=
 =?utf-8?B?ZDdRdEZIR2lZRzRSUW90RU5FdDZ2R3JrT3lFNzJ4cDU4eWZJZExaNnZMRlVL?=
 =?utf-8?B?ODVYVEZiajNGZTJ6b0hQcVBWL2hnRGVaOVhleGJyREJwYjJ3TVVNREdMLzBR?=
 =?utf-8?B?UGtieGxzL2p2blpHQkdoNU1Bc3FINFZPd2sybVZybEU1SHQra0c3VXdobEFE?=
 =?utf-8?Q?VjBvY9ETRJJECLk3DeGvF327T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111294dc-7d11-4583-b519-08dc384384b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:56:22.2117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASrroXTRSAK+/2UlS20kpc6JWZs18R6tSb02M9k2RZdn2pA1IRVYtwnYMCh/aLt6qsgFVWP1uwOJsGbyYU5wTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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


On 27/02/2024 5:16, Wang, Lei wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/22/2024 23:56, Avihai Horon wrote:
>> Currently, migration code serializes device data sending during pre-copy
>> iterative phase. As noted in the code comment, this is done to prevent
>> faster changing device from sending its data over and over.
>>
>> However, with switchover-ack capability enabled, this behavior can be
>> problematic and may prevent migration from converging. The problem lies
>> in the fact that an earlier device may never finish sending its data and
>> thus block other devices from sending theirs.
>>
>> This bug was observed in several VFIO migration scenarios where some
>> workload on the VM prevented RAM from ever reaching a hard zero, not
>> allowing VFIO initial pre-copy data to be sent, and thus destination
>> could not ack switchover. Note that the same scenario, but without
>> switchover-ack, would converge.
>>
>> Fix it by not serializing device data sending during pre-copy iterative
>> phase if switchover was not acked yet.
> Hi Avihai,
>
> Can this bug be solved by ordering the priority of different device's handlers?

Hi Lei,

Could be, but this would probably be more complicated to do.

Anyway, it looks like this serialization behavior is no longer relevant 
or valid, so we will go in the direction of removing it completely 
(please see other discussion with Peter).
But if you have some reason why this shouldn't be the way, please do tell.

Thanks.

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

