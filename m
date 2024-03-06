Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02970C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoKM-0001At-1M; Wed, 06 Mar 2024 05:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rhoKK-00019h-Dc
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:16:44 -0500
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rhoKH-0001nK-Us
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:16:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYVd0Sr3J9tZ4s7nAJLRFewE3P1R5O+uR9jTsircS0+Kh1I25FsP2faQXZP3HPdtHikwbBx7T41eV3xnunRzrV84gLY5QJiyZ7GQjgXuDCq3xxhTglAKrCEly8zqIDj9TFPafJgjxJzsBoYa4dFOHY79F++e3nbvh4t47J/tNglAJoDt5YRs0OeX9oZDMT8RwuA6BUx8KrU4YD99/+bdJoVdYGr/3pmfewPIZrJyWg9ZexGTtGCnL+F7tpjZLVU1GaTKM6C63H79mlpt4wJnTUA0wmIndshYp/LU/xZIE4XswXG0vs9HwFQnho389NXAbkOYc/ar4vYjUk4heX44ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE/T/35XWKPA0ISmX6Bmua4nZd9SDoM3gL3FE37F92Q=;
 b=e8ygBYRLEqnAKNb/GhNNItFq3P9arCKu2tT/9eiA8YHV2/CTw5zP7A2XY09XXNdrXggzvp4G4j4XxY15ZxVyK3Qa3LdxW68lolGpboqU/bFYO+W+hqam7EA+Z5SqyKmPS/zAIp4o6LQmt8CJemynyfUBDqAxJGz4HZyrZH4AiG1DUKc7Fc/hex3ikzKDDf/hNSm7YgDMEGxhp3jEgNVO+OyCDUksMzdAH2HErXHh6cNepIr7bAQfq+4vHvspizwOSmyowLc6QBnvMqBzj9UVQejz1mMXE+5GIueO2Pc3mIZD+XGPAMZcvkbP7IYYeufNvhhAwzgHggMHzBtTNEJevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE/T/35XWKPA0ISmX6Bmua4nZd9SDoM3gL3FE37F92Q=;
 b=Cht4mJ0t0x2mYoFqVp1T+UVuJ8KRZe5Jr/Z2FdBQOy8f6dvJywsusqCx8sBd5jjLf8ulOt+Jv7QmILEfQsDZLziRdx4x8CR0zPX+IGIZjBr/tYXRZAJG5zEscaOwva7qzt3KCiA6q9wGahTwsvxm6SUsNnd5Zvoc+sXBKvLRA25bZ6eFZaHD0GwYqp883leHBqrbAYH2Tw9qEDkpqphUb4OwcrmXb3QWrIyxAHcD6hiMMZ3U7uQWwfGhZx7YVwwnIixTOIxo/BPUPNAN2K3nxLTLt2e/WdAZzUFqEtBQomlrKnOjXvFSEMRTg2c9M/+ItiXZKn/toCAz7YLR+u62wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 10:16:34 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%5]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 10:16:34 +0000
Message-ID: <11899e68-a3a6-400a-b031-078ef1de0fe0@nvidia.com>
Date: Wed, 6 Mar 2024 12:16:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/26] vfio: Always report an error in vfio_save_setup()
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-3-clg@redhat.com>
 <aad3aa6b-79e5-4968-8bb9-ddd35883d02b@nvidia.com>
In-Reply-To: <aad3aa6b-79e5-4968-8bb9-ddd35883d02b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbceb24-9d63-46d4-95c8-08dc3dc68054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNb1WXW9Ac7f4ZpBeIYiLAbNjFbEe0bmTWtCPmENKxeYV12imy2wKyOSULYSs2dx1A27D/upCEk/uDHuxIzwhGjXVA5CRVIDaFAprwjjeadnY1eRgrYdSV96FVRoTqOxeYpMqpUcBOGi9GLoh+TGOKTZqoj84d4GJS3Rb0V9NzXeJ97LDb+x64QGwTMkSCSLwlMEOFK0sps2/BW6ZkSP16IZPReIbyvGvi+8sW2kU8RvhOeW4LSHgcWMMcS/cra7UMeL5hI4ZfkIOEuMWIqH6PBeK2K5wjd8umGjSfH+hnOTU/+pDQPxYTKn/1xekUjNBPH6A0TCq8fzyLel2oFNrMdN2kq+1O62bzIsvyLBaP1zemQANBDoNyfJFVzIR4J8chtDVYNpWsBRJdfqS/n9yYiXyj/6H6cVnMkPF6ldVYkjlNI/Ea6Dobldu1EV39lOJnZWksj040La0F8ZTV+W7Gzxc/1QfRpRI/jUt09KPN8LTXL+MViVTRltq1dZaSt/qnDrhNe5d1kkgjU2fAkCU7lcrM3VWeCqX/YhI1ScPmgxkW1vz7auFdg2j9L3PLQxQkRBtE+CzYdoIvZ/SHVydMfo5wURZJ6cgmZyF5KPzHQcjdq1aJo3luhslIa9iSHRgp9zm5KVGBbluYnKz9eSm8pf5S89JUO2blmkJBDG9nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnByeVBIcjBLa0lwb3RaMmh3OEZDWEJ0b01FZGptN0VmQlo0TlFyaGFPTXlh?=
 =?utf-8?B?MDNFcGs1NzN4N2dUMmIzSjhjTWRMUXAyNkZoYzVONTU1MUhZYURrSUJUa2c2?=
 =?utf-8?B?dmRma21YMTBBbGdmbStDNEhSSG9XdlVQcURBMDljSm5IRjNyOEs5MHZKVWtH?=
 =?utf-8?B?Tzd6M0RTVWltd3Y1eUxrdTAvMXp6cGtyYXd1ZzNOUGM3dzdhWnlwQUFIL0k3?=
 =?utf-8?B?N09ZMGh5Vlk1TnlJOE5XK2owMXJ1eVRGS0Fram91OVVETHNpcWZRQWV0NmtH?=
 =?utf-8?B?WXlXaHJmQStham1RNUxjdmpHSDJJTmhlS3p5Ymk0c3dvOWtQNnJ0THVKVEth?=
 =?utf-8?B?djNVMFRoczNwL3VmSHQxVkE4MkFTcDFjWkc3OXc2bmU4enUwMkdpb3Y3dTlI?=
 =?utf-8?B?QUxrNFRMdE84c2F6bmN5RUVFbC83L2dZcm1TRXVkaVNjd0ZrWHpEYzh2cVFh?=
 =?utf-8?B?UVM1WVhFekRUdHhLYS9DakRoMmVZRDBoUDR2Rk0velhmWlBXRFZFUTlaN3gx?=
 =?utf-8?B?K1hGTEI1UStMV25ZNXRJS0p4ejV4R3Q0Q014MEpBak1UWDE0QW8vT1ZYWWVo?=
 =?utf-8?B?LzVTZzhWYm5PWUxEcjFlcUlkYW52a2NZaVdKMjAxTEMyKzBQL1hSSmhpNzdY?=
 =?utf-8?B?ZTlIeXByTndobFhNSDlmNFBUelZRNU14VnpLRm5sTmRQNUhIMHBPUldrbk9S?=
 =?utf-8?B?ZHBtaFNEcHlyNCsxMkJVb2lyQzR5ZUgyRFhjTXh4OUxmdzdGdGIyTmVwekVR?=
 =?utf-8?B?M1pPdVNTNURNOFVlV1JEb0tMNEZxdW1odStYWG1LbUgzc0RiNXBtcEI2NE9w?=
 =?utf-8?B?SFRVb3ZxSVNtTXYrZ1V2clRlcndrckpLa3FMUk9LeUZkUkJ0NDcyMSs2WFhv?=
 =?utf-8?B?b3dsbkFrUW5tTWp5dkZOaEJOSU9VOGx3L0U4eUJLMzZneWE1amd4TzVaN3ZU?=
 =?utf-8?B?amdvM082OE9XQVdtamh3MGNyb3JWTFA5MHVUcklNQmdUQzVZMjdLUE45SzBE?=
 =?utf-8?B?dVhtc3huWWNyNHV2Nm1TWkF2by9kZkMwR2RrRVlXL2dRTC81SERoaTVsQzRD?=
 =?utf-8?B?eHlBVGluWkZ1MUhWdTgyY1lVaEh6Q081LzdPK1V3WjBNYXhnbDdsdjF5UFhU?=
 =?utf-8?B?OWRiMTE5SU4ycDV2dUlZb3pQOVZhUVFMaDVJMEFZbXNiMVlVNU9tRHdiRXZL?=
 =?utf-8?B?UHp3WnpDV1pjc3RtVFBxVmVSTFRxYkxJMEFmKzlCNWRwTjhSMTh4cTY0RXgx?=
 =?utf-8?B?Uk5qTk12MWFaTWI1aTFaYUFyeUVNaU5CME55QVZiQmU0WGd1cG5XWHBRSEox?=
 =?utf-8?B?NDlwTjlQSU52bUVDK3FjK1F2N0xDbk1vTHgxKzh3b1graEUzK0pTc2NJZEFs?=
 =?utf-8?B?K2R4Z1dkVy9uZWxZQTFtOVFCM3lmVCtJOENkNVQ0QlZ6ZjRvUVdidlg4clE2?=
 =?utf-8?B?TERZcnYwRkZ0RVlsZUEwUm0xcU5qQkRyVHRYWWdDTk43Wlg5eHhYQkdneXVP?=
 =?utf-8?B?S0tNaGY5eUhDT2xna3F3Zm9hdDZPU0JmamRUSVdvSGpLcUlidEhhMjlUWmho?=
 =?utf-8?B?SGsxb0RKcTFtckJwWjlkSGVnMzQ1L240c2EreHdBNSsvK1B2S0JuRVJVeDJC?=
 =?utf-8?B?Vy81c2c5VnVnQkpMcnRHbUpvY3U0TzNxRFdMbGxVNkhrcEQ3dWVsOXl4UnBx?=
 =?utf-8?B?ejhzNDl4Y3NlTGpqS210NzdJN2puMkx5Z2syUEZJZ3luQVVIcHhIaklCdTkw?=
 =?utf-8?B?N0xkcFJKeDRUTllWcG42ZHhmR2ZtTTZ4eEo3UnR0YnIxVDNxWThqcG5kTVdt?=
 =?utf-8?B?VFFiM2o2WDcwNzFXaDhHanYyTk1XWFRHeFhkZFNmRHJZZlV5TmJaWFNLcmRi?=
 =?utf-8?B?SW9raWxwelVqT3BlcmRNcDhPVlBLVnRoSUFheHJWdGRXZWFpZXZaaWpGYTdj?=
 =?utf-8?B?eTJDNm1SQkw3d1BYZnE1bHgxSFo2ZHlsQU0zeDlqeERjaFRqbXNyUkpSQUJm?=
 =?utf-8?B?ZGYzWWdkZFZNRktRb0pXZloyZ1R4MWlmOHFjT3ZaWmsyTWw0bEowems4TWRk?=
 =?utf-8?B?RmsydVBXalpwUDdxWFltRzIrOGZsVlRUczJ4TktnT0N5V1B5Qjlqbm5tNmQy?=
 =?utf-8?Q?hbOh7cdTob9yo0WfhSzZrVqln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbceb24-9d63-46d4-95c8-08dc3dc68054
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:16:34.7595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wJRQuYwi76j+uQAwNUosz3trpNDcKEGiuOOnDCd1xES0xi8QBpg1Bt121+oQRHBUOyWnl4rkm9CqZ69oIbAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
Received-SPF: softfail client-ip=2a01:111:f403:2412::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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


On 06/03/2024 11:56, Avihai Horon wrote:
>
> On 04/03/2024 14:28, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> This will prepare ground for futur changes adding an Error** argument
>> to the save_setup() handler. We need to make sure that on failure,
>> vfio_save_setup() always sets a new error.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 
>> 2050ac8897231ff89cc223f0570d5c7a65dede9e..51bea536cc290ba0aa393f78b017b0650e333bff 
>> 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -383,6 +383,7 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>       VFIODevice *vbasedev = opaque;
>>       VFIOMigration *migration = vbasedev->migration;
>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>> +    int ret;
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>
>> @@ -397,13 +398,13 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>       }
>>
>>       if (vfio_precopy_supported(vbasedev)) {
>> -        int ret;
>> -
>>           switch (migration->device_state) {
>>           case VFIO_DEVICE_STATE_RUNNING:
>>               ret = vfio_migration_set_state(vbasedev, 
>> VFIO_DEVICE_STATE_PRE_COPY,
>> VFIO_DEVICE_STATE_RUNNING);
>>               if (ret) {
>> +                error_report("%s: Failed to set new RUNNING state",

Oh, sorry, forgot to mention in previous mail:
s/RUNNING/PRE_COPY

>> + vbasedev->name);
>>                   return ret;
>>               }
>>
>> @@ -414,6 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>               /* vfio_save_complete_precopy() will go to STOP_COPY */
>>               break;
>>           default:
>> +            error_report("%s: Invalid device state %d", vbasedev->name,
>> +                         migration->device_state);
>>               return -EINVAL;
>>           }
>>       }
>> @@ -422,7 +425,13 @@ static int vfio_save_setup(QEMUFile *f, void 
>> *opaque)
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>
>> -    return qemu_file_get_error(f);
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        error_report("%s: save setup failed : %s", vbasedev->name,
>> +                     strerror(ret));
>
> Here it should be -ret (and also later in patch #12).
>
> Thanks.
>
>> +    }
>> +
>> +    return ret;
>>   }
>>
>>   static void vfio_save_cleanup(void *opaque)
>> -- 
>> 2.44.0
>>

