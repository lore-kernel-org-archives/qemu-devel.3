Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073F9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3jp-0006mZ-8I; Thu, 21 May 2026 09:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3jf-0006iH-1u
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:46:51 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3jc-0002M3-Ei
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:46:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpup7qSuOV6TPomkhZyZbgxCxQIINR6YiJLJEWlx4xngLVAM2gyKyLfOw1pkaCPZPb36Il9yz4+5eDEtVBO4cIQ/GoCw22MHRZlQJlU2KAtqMAsm+X82TGONQWHeD+IA43iO95z/Bz9ry8Y6c3qtjIPzI9aU6JViTc1LLzpVrVdKonHa6tuq+CkoAmdLXi+zaQqN0rz6sIzFikvk92G09wZQOijEyiQBD4odWGZG5+AVstgCdSRhCVlcnYaiXVfyWQY9wUW++dTA1c2tbyvOWK/uB8s3+2XqYueVpn/LS7qvYcmec3nU4UEmoPogYEvnUij7XV4vwgM4QVTvexQZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsWd1TNE/TP0g77kKdPasBurj0uwrlujzVerh36+d30=;
 b=UqAU43uHnq7cTIWosRS9rcsyWqxdoUdliJm2xGo4jj6kFCEpucO+MsnCFVehoznkSsQFtkDTquxZ3ZuPWoEart7wGdEvzVxS1DMCLaJq4mES1ryA+UR7n5OUPnq59WR1N9H7yXGNr1jOkpcWSvO+LO6J0Vr0J58l6AzD5v+uAT33wKGhI4oZ+J8mqxK53lfE6QkwXiAdQJESws6cH2W5FcZ4G+FbdS2tKv/b1Kmo0ZbQoRAizrxcBeTDUWBzw2SdXl4UGBQ9TZ4xBvGYzQcEERBOlDGYDadMhxhuxpF0AHpVUjKy3wzbhbAKa7SBztQBMAgdOZRnz9b5E+9DImnPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsWd1TNE/TP0g77kKdPasBurj0uwrlujzVerh36+d30=;
 b=ZamyFRKkxUPaPT7PHYCadK3w4wxYcK4+kVk7vadrFJLeKycfxOF+xMr/BgVnTAqlTFcZmpSkeeX+fMWyGcQFmOlMe5NGKjbhvg2lVd2UqVQlEisCPl0Xss1z6MVwqVrx1AwdDu3/FfJeplmiH/DjO19w2URRpSVQCvDa+7Nk62pZQL0bwYiop7Ei95XKRKIWP7OOcff9iDh1f6ER0phkzYx5IBnQcjI8/fNqnKY9uwySCNJjdFGMTA0zfi97qROKYSVt/Ouw07YPkxMjksKADpKP1cEthLYsf7jZ5lZY7fX38aZTWVbU1YK2HEwvZSZ1URRIpaF4XP9MoFCxg08fLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 13:46:36 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 21 May 2026
 13:46:36 +0000
Message-ID: <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com>
Date: Thu, 21 May 2026 16:46:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com> <agzAzawATnGGMIGO@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <agzAzawATnGGMIGO@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: fd545a0d-503c-4704-6953-08deb73f60af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: +g571C+jw3kYzByLFnifXCkgBgm7iUoHDMT5jl58vA0nLng0R2fBsxZrwxitEqLgrkUVct3rYXF4lK0auJ5+k1Sbxv83bvLZFwbFRvPgJ81HM2JsMS5N9LpSE0TfGspq5T353An9vmc9sfU733ZfhAVQwtbf8YX+sRhChAaMvF+K2EJJhQEhz6/qpzBCqgC4zoFhhiOLcj0vgyfPPTVkiCJmYeZFkvd43o4w7eWAlYwYmIEESg/GLOxXxRUkG7FuUFlT5gp7dbxpGZdsAcCBT1GBwAXbbWOqMUK/aLZjW09oueVqt3nU5+fsDqr86DIGaUpRzy4OMXvymRry023OqmsCa6AguFK2hCf2xmJnS+/5B68w3kfrfj/vhFWpzUZ6M1Hjj6QFNMMMEl75TUy4g4WOSqL7n3yZZDPDsA+kl6XMtbKdT1ADUbFXrpcYaZmjuP7jtFsd3mZOlPF+AqR3NwOany0LglhB7IKdpYh5UWNxTwbREdUUyHaZ7Nc1g3XF4/EbhN7vMtVUS6n6aZJQKGHLWQIE6ryaozNi2qeqL6BKFBBInMK7A6F9+R8dSBPxJ/SxzqoBHTyFKEVnCKbG8fq/52gWlgQFcAh41Azw7jP7n3mB+CgcP/nM6zGuFzsvstekpxGy5DecqxiDBv5VYIRGUhB7TjzSBgF3C+Jp4wnsH5FImmPH+oFzadPnruF8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkUvYmZmYjN1dC9meGlDRTZHbGtCVzBma1BSZnJaVFJ3ZWNwOXZ1WW51OXV2?=
 =?utf-8?B?SjdkQU1EVFVIT2xYT29ITys2OXFWL3MySXJGWGxiU05OM2tNQ1lOZE1INVB1?=
 =?utf-8?B?ZUc5N01Xd2lpM2tnaXRCalNlaEcydUVldkE4VDd3TU5QZVZ2V28xQ1VPYzU4?=
 =?utf-8?B?OVY4bXdhcXZZRjFMejlnMkdhWk56SGpuWVh0MlRTQWE4bVZVTS91RXpnRkkz?=
 =?utf-8?B?RDJuR1hqVVJZWkFNMm9ONjdiYzhKeEl6K28rS2dWREdCRC9JdkdBeEpDcVdr?=
 =?utf-8?B?TmhXYTU2dDBNV09vR1Y1RHhMNHUyaFhRLzhTaGVlaEhVYURXTDdhOGMwNzZa?=
 =?utf-8?B?ZG1ZNzJJNDYydFRYU1lFNVdtUzBSSjJSQ1RMbDA1Z21zYWwxRGJjZWRXMGw0?=
 =?utf-8?B?YnZhRkVNd05Wb2dQNm15TTQzNmkzWUxtREZrVWJLbjJHUW1uL0l4VG5vRjRr?=
 =?utf-8?B?bDAwS3BmaXpSYXREdVNibk5lVTRpSzJ3TmVBdWNWMXJpNmR1VzJxSFZSWGQy?=
 =?utf-8?B?T04wMkk1aTlDRUQ2TE5xb000UDc2Y3BnN0xFcHFJdmIxaVJNeU5TN0JQOFRw?=
 =?utf-8?B?bFdldzAxT0doNXRRZFhkaEVIOC9tY1lYY0RtQWhJdk9ETFh4bjZ6OGtSWGN6?=
 =?utf-8?B?UlluWjRsMldlSzRvcC8zeGlKdjY0SzJNQkJuUXJjdVhRL3FwUERDOTlERWJm?=
 =?utf-8?B?b25lTFFtRDFWM2NOUmFhOUJDNTcwcEZuZXYrelVBaW9Rc2I3ZllqMHc4RnJm?=
 =?utf-8?B?TzJUMUNJSENya2RrMG1qRUlYTnhmaVJtUWR2RDl6UWIvQ0h3NzJ3K0xsUmdl?=
 =?utf-8?B?SUQwdTJ1NFRxSDZ4TUczTFFyTHJQR1BxWENGaUR5N3JmWkNSMzg0cEFBUjZI?=
 =?utf-8?B?N2tHdFJLTzJVcGp2bGJaQUhnNFh6ditrSFpnbTV3TURsRVdDZHJrTXpZQkRV?=
 =?utf-8?B?dW1OTElnSnZTWjUvT1pJYk05eUkzWWJwRzVNTjRlSmdyUnQ2WmNSU0JyYis4?=
 =?utf-8?B?d25tN1I1QW51aUo2TW9wT3MxcGdidXdTeXo0REhhUVVLeldFZmFGMFI5dE9Y?=
 =?utf-8?B?ZnlncXR4V2tJc3E4d0h6SnlrTGNMc0UxYWxnVVdCaDBRTU91NkhKRE9YYUJu?=
 =?utf-8?B?YVV6TStteU9VVzBwWjNmd3laR0VFZytRNStsa1lYQkRkbXVhT2p3TEFDNklZ?=
 =?utf-8?B?NkNycEovaFlQbGMzYTRhVXdQZFZVNkNobmRHMUlNaVlkVXFqQVNGd1pBdzQ1?=
 =?utf-8?B?YS9yUU5IN2NPQVhldzhtTTBLMVhFa21wUFlmU1pVdjd6czVjYllESFBiQ0Ix?=
 =?utf-8?B?SzVSSzltMEswbWtpa0VEdUs4Sk1USmloalVScUxmamRubHlCbmJKZFh0ai9r?=
 =?utf-8?B?cmpXRkVxL3NncS8zMzd5Sit3V2UvaGwyTStTVWp0TWtsOGxsZUZIYUJTRWZN?=
 =?utf-8?B?RkxBSEd0akowY0UwVEhML1JIOHI0T1pZd2c3RkZTdXRBNlkxSXZLVjFVb0lR?=
 =?utf-8?B?c05hMTVBUis2OU5xdk1QQ0lieGV0cEx2aGgxZVpubXpEMlh5dTdaRFZGVld6?=
 =?utf-8?B?Q1RaN0l3QjBSWERocDVoa2tVUDNpam5WVkxEU2ttbEpiRE0zS0k1a3pPY2xv?=
 =?utf-8?B?aGFlLzQzWGZmc3R2T1Z5L2QxTWQxOHQyNUNwQTZMTlZxVE8zWXpiRGdZSTZI?=
 =?utf-8?B?eDVxaE1jRFZlRk1BdjJpdUoxcHNzQU9oeUdONVptQnpIMHlNZEllV1NvdFpF?=
 =?utf-8?B?cmRSUzdDaEI3TzFHaGgyai9zYUcyKzh0aExhRGRlRU5ZQi9NVEZSaWFoakRX?=
 =?utf-8?B?TTBDa1UxVzJHZmpLRjcvdUQ0cFd4UVVyZmdMRHl4VHFEQytmcmZYQWlKSEFM?=
 =?utf-8?B?NTFPWnJBSGM5ZEVsdldYalIvWnJ1KzQyVFoxcm1SaEd4bHRueHFiODV2UnB4?=
 =?utf-8?B?UkFtdU1LNUdCK2Y3RFhsUWZQZ0JGSWNWZmhmTDFNUXY0ejJMdmFkeGFWbnQy?=
 =?utf-8?B?WU5PckZsSTZiTURkOFVlaTM5Z2srejE5M24yMzIvM0RMNGpxTlhpYnJoRzhD?=
 =?utf-8?B?NnBWa3plT0xvMEtTbm5nRlNZd3U2bFNPaGp0YmpEUzNWVHdaaHNvZmdQSHhM?=
 =?utf-8?B?TDdjbUpBcGhBQ21sb0dHaVBkUzFFaFZSaExpemtJdUExYnc0cVJEeTk5NGpL?=
 =?utf-8?B?RXZHMU01UkRuUWdrVnI4U3NIUHlFUDZGZEZPOHRROXF0TnZuVjQ0Z3hnaXUx?=
 =?utf-8?B?RlZ4RGtKQ0U0YlJra3FLVDd5MEpwWDdsL0t3RGZabDZxb2crUTN2djRFMXBH?=
 =?utf-8?B?cjBUY2QwdHhneThnc2hrMklVaTBJejI0dzdKVnlkUzVPMTFVWlY1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd545a0d-503c-4704-6953-08deb73f60af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:46:36.7780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hvODF87TpmEtxr8ltpmqOhkvr2E56ds7AcEh4RkL/m8xo61/GoVbc8fdo1go6BsFZXEkWDPSFbTv/to4ZRdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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


On 5/19/2026 10:58 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
>> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>> flag is sent to the destination to indicate that initial data has been
>> sent, so destination can indicate back to source when it finished
>> loading it.
>>
>> To get a more accurate estimation of initial_bytes, re-query precopy
>> size before sending the flag. Extract the flag sending logic from
>> vfio_save_iterate() to a new helper for clarity.
>>
>> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>> flag if, for example, the previously queried initial_bytes was lower
>> than actually is. Additionally, it prevents sending the flag if
>> vfio_query_precopy_size() failed.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>>   hw/vfio/trace-events |  1 +
>>   2 files changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2911583ee1..243624b5fe 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>>                                            data_size);
>>   }
>>
>> +/* Returns true if the init data flag was sent, false otherwise */
>> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
>> +{
>> +    VFIODevice *vbasedev = migration->vbasedev;
>> +    int ret;
>> +
>> +    if (!migrate_switchover_ack()) {
>> +        return false;
>> +    }
>> +
>> +    if (migration->precopy_init_size || migration->initial_data_sent) {
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * precopy_init_size holds an estimation of the initial data size, re-query
>> +     * precopy size to ensure it's really zero before sending init data flag.
>> +     * Don't send the flag if query fails.
>> +     */
>> +    ret = vfio_query_precopy_size(migration);
>> +    if (ret || migration->precopy_init_size) {
>> +        return false;
>> +    }
> IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
> much (when NIC reconfigures?), then we can still rely on the window where
> the "new switchover ack" will be requested later on during the exact sync.
>
> Relying on that seems slightly cleaner.

Not sure I follow.

New switchover ack is requested in exact sync if we see new init_bytes > 
0 (REINIT flag).
This flow happens only after the new switchover ack is requested in 
exact sync, when init_bytes = 0 again.

So this chunk just makes sure we send the 
VFIO_MIG_FLAG_DEV_INIT_DATA_SENT flag at the right time.

Thanks.

>
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> +    migration->initial_data_sent = true;
>> +    trace_vfio_send_init_data_flag(vbasedev->name);
>> +
>> +    return true;
>> +}
>> +
>>   static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -664,11 +695,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>>
>>       vfio_update_estimated_pending_data(migration, data_size);
>>
>> -    if (migrate_switchover_ack() && !migration->precopy_init_size &&
>> -        !migration->initial_data_sent) {
>> -        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> -        migration->initial_data_sent = true;
>> -    } else {
>> +    if (!vfio_send_init_data_flag(f, migration)) {
>>           qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>       }
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index ab27ff5ea2..e91858354c 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy
>>   vfio_save_iterate_start(const char *name) " (%s)"
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>>   vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
>> +vfio_send_init_data_flag(const char *name) " (%s)"
>>   vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>>   vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
>>
>> --
>> 2.40.1
>>
> --
> Peter Xu
>

