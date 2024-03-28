Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDF8CD128D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps5T-0000if-Se; Thu, 28 Mar 2024 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rps5P-0000gp-Ac
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:40 -0400
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2409::601]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rps5N-0001ns-4d
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtI2u+4lBhCrxxkd/S5kgrCEpRXLTUGaRCJBVR1BmJc+XHWiHeDtsl/cTrtobcsTwBKBOcjoX3yrfX3KUZmH8tD7jVm4Knf8Cn6binhmwgWSgfLOy9UVkW1E9i7x4cqyExj71jKX1hZY8q751wbuUk0s6hvzjVA8BdaxVtKRiP/9YDZeVPHKlLJlv575xpUYBoW1fdaS7cfF7CTr+HTwf58LQzIEPcHlGA3n1p+hKba62/OCwNjD1M8+a58ggzZUP9GixJFvQ2C/jRpxQzhNndijDilcoibTCioV6EU5u+l8aC2NOB3JDdcnBUGCZwLrJPCSL9CcxyOoWHp7HoMK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMz1qi1nC0SyeOe5VbNOTSsi8sCvpxwlAA2176oRr6I=;
 b=f300NM2I3BhEpJKOd/O8iMBN+BI3OPERZGWoYC7m4VmLEs2Y0ql9oEN8NodM+CKCprwB0yvRBUYe7SZR5SdjqCAaqPagverKyS208r6zdGaW9lUeoPc21A/h7VApJ7jmtLiBHDJCoP1jz67m41LNJVIokL1awi9Mp6CCRgnKlQp7lsIyNfvYSExy/2D0DyVTeaf7d1IAent5v6h/0cgqfSik1hJI73o/tl/A/mm8tW3TFOYio9GAoZ4xPNwAJSrv9AgBJMy/muJQ+aZNwC38jEqjCPqCdOSEreU60jhNQJsMww14LgsPc/QS0hUwQgvBTxbLWPG8wLCaSjssAQoBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMz1qi1nC0SyeOe5VbNOTSsi8sCvpxwlAA2176oRr6I=;
 b=WlehmU4OmrZmbcRxj9EWMQyoWiQeF4nYTwCdJdEL7eQu0sNQCnhwCgucb/OlHFvRj3p6kYXZgGJGQ/bArWcIPViAeF2KExHD7zWiLPQzB0+jQyYIHDSEnTxZRoyQiCWL4zWwP+tkMptXqtqB6d6qOV3VssF+oXoscNiQRH0wOHKOsJaWxbFTz8cCWReuIh5XiDW4VDs5pJr6ymcjzQYrMfpUD7nfqXjevySViMZyX9at5xsutkd3np5Y4tzVe627To0c/AmtkcOaE+8IuiJNxPXIgAkj4MM8V8phfIpwBS+nV3WmmtI8LcBshoIVI968YPl1kfgkjXH2CHkWkL/lPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 15:54:25 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 15:54:25 +0000
Message-ID: <ed605487-8e14-4f74-8b6f-8f104ea617a3@nvidia.com>
Date: Thu, 28 Mar 2024 17:54:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-2-avihaih@nvidia.com> <ZgWIMDjzXG1Efwgv@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZgWIMDjzXG1Efwgv@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 64937f8f-bc02-40e8-4194-08dc4f3f57e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOgi/COFJh0nICtfW4Aw+j/N0to3TcjzJpu4EzfwL+cwmGsMk/U8NRlIQ3gueENgpwZ4cz4Cfa7/1y3p7r38SK3JXb4ypkLuFRGYy4HbUrBiPY8sfGN3Xph3NBOU6wCh+ARs7M4N8Zu4laioe50kyANeRAjG0UWyxA0pKZRZ8azZpTbjeT3NJynT4BFwg16VDmyPk9GGCrgUXrAvYCTEu/A9w1HpgI3Fgtjz2urh+6o/5q1TYGr5yQX7hYqBNPta3XB+zk3gBTfVGj+KeuSAktmLEU791VM9HT9O+rvuLaOcu3MeFjRYxQtJakDfTdc+9z1mFlLoSXLLoYTQifNkIdP9FaZ+0cirFXSHpLSCf5IjKYEmeWIJHBRumUb6bDWyJ+mCusvCvGX5wQHqOdpEYBDW45+iDdq/BeWBgTtb/pEMC7Hk8DbSc55LnH5F2m8Kplkd+J089E/qhPJ/TW01QHAp0ZoX8W668AsTPR+FLVrAhHPJbzug+SSb1SHJQpbrA1Tj74Ynd3q4zlFji2CHgH6V6uwmtqAiE8R0x2q+eapmHDGBjsnkJ9votTo/HHHq2Xf57Lvd09vn6g8OcTB0B6xVr+BAeGG/E470KOCxg14uZ0wnjr+00ByKrFpGmsFt1Ow+jJFP6N9wHLbmQqMvUQK6wMQw8aXX/il/VaocBg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRMaWF2WDMxSkVuRXR4eGZONTRCNmloWDE3V3ZOd1FkNFc3L2hVZmttbHZD?=
 =?utf-8?B?T054Z3JPVmRLV25MbkFyWGhYR0pHS3dWcXZjK2I3aGVjMXpyMGV1dWFzaUF5?=
 =?utf-8?B?U0MwMDlSaWg4Si9oQjB5dS9uaUJpZTBFT205cmNHMVJlZndtOEZsLzZOd0h1?=
 =?utf-8?B?bFFNbmljY1RHZEszRTF4bnU5RG5rRUM0S1ZlcmhHQU9sTk1EU1ZKR0g2VjBh?=
 =?utf-8?B?NDBzV0tRajh0Y29qR0RNMk5vV1RoMGJIMEFxQTNTcWhqKzduSFdFcXJENm8y?=
 =?utf-8?B?cjVyTldPV21tdktHWTdGZFhWVSsyYnd0aUlhNDIwajlhSEk5ZlJHcmJKaFdM?=
 =?utf-8?B?ZzZXSzliVVlQR2NsOUdzUXBXWmUxd2swQjJUVWFrSHloODdCUHEzSTJHVFA5?=
 =?utf-8?B?Yk5Dc204NlplYitPYWlLU1hxN3dYVUw1RGV3a0pUNjNFUWtpTFVwNFJmaTN5?=
 =?utf-8?B?a0tIdXJOYzhnWUYvU3Q4RFZnM0NhMWU1V2NIQWJLRytYa0l4SWZOMDhoaW5t?=
 =?utf-8?B?U1JmNVlWckRTMDk2QjlybkxRby9QY1p5OTRLd1dBM05VMFZveFFhN1lPZlpo?=
 =?utf-8?B?MWhmc0dmaytnZXY0cGtTSUpXcXRmV3JlcU5TRnRZdHppSXZ3SXlKelhrS0pJ?=
 =?utf-8?B?Zi9NTVNWcXY0T0JNQUx2R0k5MVpLSkR4OU82aVorUDVUaXlsUnNhNXY0ZjFm?=
 =?utf-8?B?NTU0cGJvRTVHU3FOSThHZU5CK25Kdm5oRVVuZ3NGaTJ1MTBIcXEvYUJUVHIy?=
 =?utf-8?B?ZHdqb2d0WUVZWE1iRERiOVpUTkJvbXlzUVAxWkZ0cXhWa2xCd3RVVjR3MWFL?=
 =?utf-8?B?SWR3UUNVeCtLVXZvZmJxcU5WRFUzVGdGaDFjZG04OWp3Sjd4dDF4R3FFM1da?=
 =?utf-8?B?V0l4MTZaWEdwbWwvdElQRVVMZnViOE52SXRSTXVhN3JodVNpbmZ5Z3h6SWtJ?=
 =?utf-8?B?NEhjK29Eb2hDV2hxS1cwVGxPUCsxTWVNWTRhME02U2ZBVXZjWjg0cjhiNWJR?=
 =?utf-8?B?MFFaaDZpcFVsMWE2Y3VpaGd4VDlPL2VrR2lUbFZXSnA1WlJab255THdNNkJU?=
 =?utf-8?B?cnVUVk9rWnVCK0EvWm0xYXJneWswcHhSMXFZQUt5MFVQUkYyMkVpaXhqRmZz?=
 =?utf-8?B?aTY5WXFucWlPV1ZBQ1htVzFCYzBMWFhSSmRqYjYwNGFqcC82N2toc2J6SUQ3?=
 =?utf-8?B?YnIrL1lLdUg1amdhNFNGY1pvTnk3VHoxNjBXTFJ3YVA1bEJ6UU1PUUFpc0ht?=
 =?utf-8?B?ejFsUmZnZ0c4cldnUTVITTl0aTJNZjU2TW5YVGZRU0YwUmtCWG5vdHIwSUxs?=
 =?utf-8?B?TlRGR3FOMFJiMHZ3N2U3Z2lhbFNQSVZ0eGx4WXF6KytWUnhjWldBSml6Q0U3?=
 =?utf-8?B?MUxEcm1ta3dkZ3dZeWQxSDlYQ0dKdDcyZTNNNXZMazVwVnpsYnltYW9GenRx?=
 =?utf-8?B?ZzdFUXAwVExiZWpTTWZ2QkdidEZNb2VYRFNrWHdDSzQvaGxid2QyZ2Jib0Jq?=
 =?utf-8?B?WGgybXNITkNUOVA3WFBFRnNpNXpKdjhHTTBHVVJPWWo5cFVJbUkxSHF6VUtM?=
 =?utf-8?B?Z2hZNGpDOEI3dTJtZkdCbDl2ejVJNzNzY1MwbU4vQzMwV2cxWGt6WlJtdjRI?=
 =?utf-8?B?RVF1c3ZialpyalRzZDMvbVVrZDFpUEJIT0NZSlNLMkpyYXVLYUVGSE1hOHgv?=
 =?utf-8?B?c3J5akJkOEFmR2hoaDJ1WkdhOWY5T3FDOGptOS9ZcEVGRHFWTmgwOUJXbU1U?=
 =?utf-8?B?WXUrZkk1bEEwMFZ5d3VKUGttWGRHZ3VtTEdkV2NrYkJXek80Uk1qWHVqOGRm?=
 =?utf-8?B?cmdtUktJUHpwb2NicldnZnROSFpKb2g0SGtMTzFkWUlyQlpqNlExZ1pnbFdo?=
 =?utf-8?B?SHVkRHYvdWhZMWJ1czkwcUlGOVdUcjlOYzBjaEFBRmFuQWoxVkIwS2ZYb1F5?=
 =?utf-8?B?SXNFTFZOL0d6UHphbHpQM3NsVGtTbTNTRnhnMTgzRVpUb3ZtbnZySVVwY25T?=
 =?utf-8?B?R2xDTU9ueDFURGMwQ2xCWXI5LytxeHZGdklZanpwQnRhVU44MUlQL1hZMmFY?=
 =?utf-8?B?emNJaDE4aVRVV2FML2NOUHJ1NWZRS0NVVzRsMi8zejZqUUZIWTlwV1FZYjIw?=
 =?utf-8?Q?j3vHpAzNM0TemPsC+1ud1Xl5H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64937f8f-bc02-40e8-4194-08dc4f3f57e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:54:25.7396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCpBAV4GbA08d/XJRAH8jTgyvo0YzCzgfJmqgbLK1BbGxkkJPfMIScIspzFvaXQX622N4pU6eHKnNpGVGc4i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
Received-SPF: softfail client-ip=2a01:111:f403:2409::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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


On 28/03/2024 17:09, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Mar 28, 2024 at 04:02:51PM +0200, Avihai Horon wrote:
>> After commit 9425ef3f990a ("migration: Use migrate_has_error() in
>> close_return_path_on_source()"), close_return_path_on_source() assumes
>> that migration error is set if an error occurs during migration.
>>
>> This may not be true if migration errors in migration_completion(). For
>> example, if qemu_savevm_state_complete_precopy() errors, migration error
>> will not be set.
>>
>> This in turn, will cause a migration hang bug, similar to the bug that
>> was fixed by commit 22b04245f0d5 ("migration: Join the return path
>> thread before releasing to_dst_file"), as shutdown() will not be issued
>> for the return-path channel.
>>
>> Fix it by ensuring migration error is set in case of error in
>> migration_completion().
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> I'll attach this if it looks all right to you:
>
> Fixes: 9425ef3f990a ("migration: Use migrate_has_error() in close_return_path_on_source()")

Yes, sure, go ahead.

Thanks.

>
> Thanks,
>
>> ---
>>   migration/migration.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 9fe8fd2afd7..b73ae3a72c4 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
>>   {
>>       int ret = 0;
>>       int current_active_state = s->state;
>> +    Error *local_err = NULL;
>>
>>       if (s->state == MIGRATION_STATUS_ACTIVE) {
>>           ret = migration_completion_precopy(s, &current_active_state);
>> @@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
>>       return;
>>
>>   fail:
>> +    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +    } else if (ret) {
>> +        error_setg_errno(&local_err, -ret, "Error in migration completion");
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +    }
>> +
>>       migration_completion_failed(s, current_active_state);
>>   }
>>
>> --
>> 2.26.3
>>
>>
> --
> Peter Xu
>

