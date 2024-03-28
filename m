Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8D2CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps1X-0007vB-J2; Thu, 28 Mar 2024 11:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rps1V-0007tu-B5
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:50:37 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rps1Q-0001Lh-8Q
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/LV7O4JZ4NwySarKeJ+URrM5EJ4+glj/stx3ZEboSzNpO5DJJ1KGdH6+/IbQZiKyV4VLF3vsYshkKsPBTq0zS48gbxEZHFuEMibIs+3wrwVzCaiIBnOPcMZl3KZP6ZSrXAGdqkBsHK4FclffZoRuaXqTB0t9Ie5jiua96hZh3+beUwNQwdvgoxArzBgXN/JCxmsuBSdhM0/VRJ4akqmN8Y7IVUqm803PiDYcXPpP9QQUdMsYrziooOnaOvLDlWc6/ziIV7juOfwpeZW7eZY2mlIZDyBpZ29GNZFPUMek6fnDvB5oLPQNpUjteXpUtos/CRCd8B/k729Hzz748koYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxXuLvGB0rJhYid1C3QwTJP6AaU9t1/CGEf+gXlyTZ8=;
 b=lDxZ+d5E/+QYgi7Bzv3ErBgVP0GhHQs1bg37LO7QH1ItBp8e7N5wcYMYg/np8bsHsR6FHFP3PDA0XDdCu3xD/wSk4OB2bb62xhUgoEwHq93UYrd9+lErJaLzBVftaCCcyJo33TMQP7Wm6qkE0LjCitLDh8bMaMCktota9QZT6IhkPmySIUOU77kQkF2M90SQW8VzZUPFcx0tYg5q1mRXx/kcc7VNpRzaCV7tZgDcWxuA05Egl2omE2zaoOsYoedauRia8eBRkl8eBZhYovV6XovB5hdJMVM4Nw9VKBvE30v30viu27aG40nW2F/2Dy1Fq6vdz7dVbxmXZ61WNz0DHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxXuLvGB0rJhYid1C3QwTJP6AaU9t1/CGEf+gXlyTZ8=;
 b=GMkSErxeruStYKeg11iBZAy6aoySucPgBdzQPL9vRZL+P2LZdEcqGCGehh/D/wcWmH0NWBIucPKfA1X5lhCRQv3EblaL2Pp4hHtF1ll/ORCBP61cm+OLHvPVx1Jli9e95Ig2o7wIZHqcCiToj9ZWiPih/IzYzJZ7k8X6JQ8aJtcbdiwjP/zBvToC0LpVusaRAStwpc/NVoHUosMBha8dOvlMSOO8Z17C0WeDRDAHyKSVz9d7BEINDX45nJq1CguEuZeYDAkIXFF/VyvnUCV1fe25i1Kici1XNBiOiO9hYaeDdu23pffHoIc02oWyadRrWD1w49coj6cjfSwPOITo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 15:50:27 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:50:27 +0000
Message-ID: <9d3a476d-9e99-4ed8-8320-8bf86269dbf3@nvidia.com>
Date: Thu, 28 Mar 2024 17:50:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-2-avihaih@nvidia.com>
 <9aea916e-ea64-424b-bb48-4d1ad75e85ac@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <9aea916e-ea64-424b-bb48-4d1ad75e85ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b13af8-12b8-468d-6d12-08dc4f3ec9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgc+R+7sAOsW4tFtONgGVGV5/mYrEDrZi45aht5vqOPCZfhVrQPSxjaVCF5KhInPnXditOtPUP6L27fQzP4fpYdRMXRgmVvMk3gtEM3aDu5pWnoUR0/snHYYH1pApcSi96dm3pNDY+2P/9pgJMYM522rhT/xjPEHe/1S+cl/iFej+mnd1umnhXj0lx7Zdj1dRvd06hZXpNFquEs7W5WERmC/3K7xucIaErKR9EI+O/z0pCV4Od3wW97uCqn1GkzaFNStgGQ2KnJcC4ae/Hb75DvU5hR/n6RaEChN2K6uKJKvtgWgPz5mSlEv1WwLyO0xj4wtFRvjkHD7mjERI2BAjucfoq6mEcSlnUhgOTd6+Hls7ye1461c3UTHLsWTJFDBWpuxlZPiDbwh1hihAg2cBrTUUrQ049KFR8HQF/F+kifrlUWIemFSIU2CY0+8CGgU2+IFQVE2ljhFLKBtOfB6aSr0UMfJhAw/ZpfZzeKHkrsTzi6Y/merDGQ9zWeXBnFQuJSD9zTkHADLwfS2Z8jU4XOZzKHkscO1zPdjbuYbrTLvl0kewTETcbzf8levSq0Fhu9D3FoEfRR4LR17BWj3o8EVItQWWollB3Dd2ZzE7tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmhoRHZ6YlJqUmNsUjE1UWM1dTRib1FnMCtUVy9MaFNickF5S29uSGxpVzd6?=
 =?utf-8?B?U1FoS2RKaFVLdnJXSE54VUdCL0t1OEdheTNMaW9ndmxwdnNOcnpncS8zay93?=
 =?utf-8?B?bXFpQTFlZnExaGZWdjFnQVJVZzkvUnJKQ3MwekVQUnIyNzl0Y2ZEWGhJVHNm?=
 =?utf-8?B?ZmFMSjJydEsvMVpKcTd4MWQ3SGRkcXpqNi9iVXV5eFFzYi80Mjc1dWw4S0tL?=
 =?utf-8?B?UmkwcGdieFRRcXBaVTl6MDRYaGZkS1JlM01vaU15TFY1aHl1aVo5N1lmMG81?=
 =?utf-8?B?V04rRkY5dW1pZUgybWtkRmd1ekhLZ2JIc0JyT2thSWdPcGF4U09iSVEwMGM4?=
 =?utf-8?B?RVVFdUxYWitKU04zSUpyQXhoTW83RDQ2WGc0OCtYMUE0SWF3U3B1c09iaGVH?=
 =?utf-8?B?UitwUmVoVCt6SUhvYUh5OWtOMW92dVJ0Q3RJZnc0SkU5MVkvUFJHS3R2TGI2?=
 =?utf-8?B?OHJnQ3N4RzMyWVZvMmxKSk1vT1NmYy9QMFgxUXB4NjdCejRlWkg4UUlQVXhv?=
 =?utf-8?B?WHV3QWJtaFBuek5KOVo2d0NjOXg3RDVFL1NDb2dLdFpXZWQ0QmJtU1R2VW1G?=
 =?utf-8?B?VzduSGpabnMzZHVXSFF3dVAwNVdRaTJCNGpGam1TSCtWSXBFdnZWQmptZHg5?=
 =?utf-8?B?OHRWa0VqUXd1bHpEMFp3NXNzVWp1T0FrSitGNEU5cHhGbzZuNzhnOTZjbUxE?=
 =?utf-8?B?OEJFZHFmOXhyWlNtZm1iSmd1S1JpcWRyNkFlTzhGNVFPRGpubnhPdUNmM0ZQ?=
 =?utf-8?B?RnhFYTAzZU45bkEwSUJLamMxRWVZejBmMkRsYWdtc1lJaFdybDlOQ3kxVkF5?=
 =?utf-8?B?SEV2eTJTY1lUcmRPRUNJTXlzU0x5VWZwbnpFMW8vTGRlTXN2Mm5JZjlWNkpR?=
 =?utf-8?B?T3NZRWhmVFpLNk9FNUFBSlgreWgxWk9oUnpyWmdZLzNpaENHc1lWUEpOdFJV?=
 =?utf-8?B?OEhQYis1SW14c3VaZHdQQWphMnlSQlUxTmpBc2tMNlNhWkFQeUU4a1RkVm1R?=
 =?utf-8?B?dUJ2NllFVHR1NFlXQWN1UDdPenZtZEtsbXNjRmdHN21nU1Z0WlVoVUhrYTBT?=
 =?utf-8?B?MUQyMEswbzVWeWNMOUFTQmtkcm9NN3BrTndjb3A1ZVJDalF6RWcxaUs0L3o5?=
 =?utf-8?B?V08wVEMwUDFOSkl4amtGVFRpQm1LU3hBUEdOWmxkMlhtd0dmMDI3S0pEWnox?=
 =?utf-8?B?eGtkYjB2Yll4Zk5LNnZ1MW9OR3RYOHVRNThxMkFncnRYbWtkMkk0dDdZenpS?=
 =?utf-8?B?QVFPdElKN2hXc28zd0pSZEVHUE5kOXBleTNYUVlXQWJLK2lJZk10dEhrZmFU?=
 =?utf-8?B?U0J3Ujd3S09NRlZGYS9ZVllmYTM1ajZIU2VQamdVaXN3WjNHQUxIcGdxOG5H?=
 =?utf-8?B?aTF1MHZWM2wxcnFSK2VzQWdnVHpleEI4MzhvaXBIWlY5REFxeGZLKzg2UzQr?=
 =?utf-8?B?UmF5RnVMRFUzNkJSUTFKUFFLQW5RS3Z4MHRHbExzN2ZNTTRyc3JxNGU1M1p3?=
 =?utf-8?B?by8zZG5LY29qQm0zZWZEVG1qcStmakNUQnBiZkdCcngzVVJJb3VUTFJIWTN3?=
 =?utf-8?B?VlJjb3hrT3MyTEs4eEJjN0Q3enBFVzV3QVdsamxjdXdneC9CSEdtL0h5bzJx?=
 =?utf-8?B?Wk9XQnRhY014RXN1WjhSZnEyMFUvVzUrVnRnZ2lFNzUyTEE2YVJCNGpTS252?=
 =?utf-8?B?UnFTNmRtbndkdFNsMFdaUkZLTjFYbjJ0Z3JNT0JkNysyUTBVbHhrcXJPdVZF?=
 =?utf-8?B?WmZBbGJ6UDg0WEUvQWh0MTNwWjFoQkZqc0RlYjBnZEZyNmVNeGx1c2JpZGhW?=
 =?utf-8?B?NjQvQmJDTm9vb01IVlVuMVdxR1RwWWgrcko0MlBteG9BZVZVajR2c0kxQTVr?=
 =?utf-8?B?YzdUaGUrUk91ejFEVStxbDRBNVhQdk5iQU94MkZkRnR6RHBpRHFNMnRpNHlE?=
 =?utf-8?B?cWVUYnVYVnFhajdQL0RoV29UZ2d6SkMycTdNalNUdjFzZStpVWxQOG1aNFla?=
 =?utf-8?B?d2d6TWJnenJ1NndWU2l0b3lrVkhZTzVNN21URGgzd1E1VmRxNEgyZGJCTHlF?=
 =?utf-8?B?M0d0ZDl5ZXlnWHdUVDRBTnRlUGZnRnB4WGVPR01ZUml3ajE0bTZscUJyeGti?=
 =?utf-8?Q?YU1c7mVNx5r4CTMW3p6w9SJZC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b13af8-12b8-468d-6d12-08dc4f3ec9ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:50:27.5748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVJXh4vAtm34PuljGs+nt9ISBVSjw3E7J3NhRQexzgtnLaZs0ETYsviaw+h/vhG+MDPuQxHWMOlgyXIJFS4jVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 28/03/2024 17:21, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 3/28/24 15:02, Avihai Horon wrote:
>> After commit 9425ef3f990a ("migration: Use migrate_has_error() in
>> close_return_path_on_source()"), close_return_path_on_source() assumes
>> that migration error is set if an error occurs during migration.
>>
>> This may not be true if migration errors in migration_completion(). For
>> example, if qemu_savevm_state_complete_precopy() errors, migration error
>> will not be set
>
> Out of curiosity, could you describe a bit more the context ? Did
> vfio_save_complete_precopy() fail ? why ?

Yep, vfio_save_complete_precopy() failed (but it failed while I was 
experimenting with an unofficial debug FW).

>
> We should propagate errors of .save_live_complete_precopy() handlers as
> it was done .save_setup handlers(). For 9.1.

Agreed.

>
>> This in turn, will cause a migration hang bug, similar to the bug that
>> was fixed by commit 22b04245f0d5 ("migration: Join the return path
>> thread before releasing to_dst_file"), as shutdown() will not be issued
>> for the return-path channel.
>
> yes, but this test :
>
>     if (ret < 0) {
>         goto fail;
>     }
>
> will skip the close_return_path_on_source() call. Won't it ? So I don't
> understand how it can be an issue. Am I missing something ?

It will skip the close_return_path_on_source() call in 
migration_completion(), but there is another 
close_return_path_on_source() call in migrate_fd_cleanup().

>
>> Fix it by ensuring migration error is set in case of error in
>> migration_completion().
>
> Why didn't you add a reference to commit 9425ef3f990a ?

I thought this commit didn't introduce this bug, but looking again in 
the mailing list [1], it kinda did:
The hang bug was fully fixed by commit 22b04245f0d ("migration: Join the 
return path thread before releasing to_dst_file") and then 9425ef3f990a 
re-introduced the bug, but only for migration_completion() case.
So, you are right, a fixes line with 9425ef3f990a should be added.

Thanks.

[1] https://lore.kernel.org/all/20240226203122.22894-1-farosas@suse.de/

>
>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/migration.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 9fe8fd2afd7..b73ae3a72c4 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState 
>> *s)
>>   {
>>       int ret = 0;
>>       int current_active_state = s->state;
>> +    Error *local_err = NULL;
>>
>>       if (s->state == MIGRATION_STATUS_ACTIVE) {
>>           ret = migration_completion_precopy(s, &current_active_state);
>> @@ -2832,6 +2833,15 @@ static void 
>> migration_completion(MigrationState *s)
>>       return;
>>
>>   fail:
>> +    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +    } else if (ret) {
>> +        error_setg_errno(&local_err, -ret, "Error in migration 
>> completion");
>
> The 'ret = -1' case could be improved with error_setg(). As a followup.
>
> Thanks,
>
> C.
>
>
>
>
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +    }
>> +
>>       migration_completion_failed(s, current_active_state);
>>   }
>>
>

