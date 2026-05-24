Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA40CD4F54
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 06:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR2bI-0001wK-JN; Sun, 24 May 2026 02:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2ay-0001vk-5Q
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:46:10 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2aq-0005Ao-Bn
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CW7+9kqsv8e0aT+mXMx0WTwSU/d+wsAGAI+GXC3yikXE6h4FGczfgai1Nj4eYrlCI/tGEfsYSAsxa6IFv2UAPg00YtcTOhSaLPiEU2gM6N0sIwCBxwRCIQ/Pby8r6NlLXsaLUj2v5Vy6t5/yeFpXUNfA8Hsmv4p29ToW9SDTerq7J4TVZvlpSzqkCfC6/43/18tv2bVElcLyZkOt8T9Va56LMoofQqRPir333XKoE+ZxbXJ9u/iZPjcGsFgrfjLWGpqbqLQCQ3bmwfzYUcoQ225Nov1w2X/t17AUn6n3o2WWmNdNlEjDk6EJqS7Fsin4HYy0cxpcUim4mC0PQMS3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY6om/L7Y6KKboIPgVsRnuZqcf8d6D3hZm52rDAO3Fo=;
 b=IzNyQxaJ207madK1/ZkZ33pO8k44OOCaYu4Iq/N3RWE2/mYUmmbDlVxLqdzm3ss+JIY8r6r+Z3ntxFuxTpPJoBgNQxSb8Cg3u5xxgsnNC/K3AnGmSQZloCn+x90oYuBI78HGu4hRlRfO6HS7nPhtCybgWj4dt2DkgMlafmc7EX9TW3FEWfI7XsTj8INDgCU/r9ZkOMz1Q3qbDW8flb0WfmGTrmGAvPMRL7vQUcWd20ykcxJie/ytKDl2EaqOOl5roWX1JPRvftG+cWg1VDM/Mdf+l5BcPe9XHXPm6nyMADWCqKTCDC8V8tlTKNPFFeAHktGwi9cPsMr0hatT1joIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY6om/L7Y6KKboIPgVsRnuZqcf8d6D3hZm52rDAO3Fo=;
 b=mkKYgoq3NayEVm5/FkvT2AMIKqb1lzvqATQtFHC09JYy/T9CLBKRUZvitpthlvI0D4IxAK3IeBvVKQPPEfC1e2ZoLcfCOrt0O+R0IC0M5HXFPknF+A3Yf7qExGBMXHbFV2U4+cLdydr4wgPj2Jw43g4NMTQ7xImLUQnunKfHw3LVCcoxHAnBAhnOLtDycxUmCGwxIqFdEnamayxFdeCSiQz5vfLAd7DJnfbzYJrkW+TJFGqCoU9EsJoO4N8rk+hnkeg7iYC+pAqKj/UBL/pRfQVk1bovwYClq58v9IWZlo2H0LtOwJ0kJm3yTI8No9qh9nvLv3tzc71sICgG2HnAPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Sun, 24 May
 2026 06:45:39 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 06:45:39 +0000
Message-ID: <5af18c64-267e-4948-98c9-20d94b4db4e9@nvidia.com>
Date: Sun, 24 May 2026 09:45:33 +0300
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
 <e4803220-4d73-433a-b697-3aa67dc55e12@nvidia.com> <ag8e-Czuujdt5hm1@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ag8e-Czuujdt5hm1@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b27760-4eb0-4216-d7dd-08deb9601123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4JKCCm82puYPmS9T1vGbXecQyY5/KWf3LsoKCBKeogUMM1mhNRiRU+jjhW5K8+2ygzld6/Eo7J2bw/vwLAd96jcJF3g4/OIFhWlctnG2zsIPZQyMdKfybiDQOgc62fcofSjCrJ2y2fSRt7cQx2zCLeNVH8aCJSlknrBN09b7ieaIPG+X2WFeBnWZrj/WCusJqb1UHBs4DSqnj45Fc54az6FNPZDP0b6QjoHuJnk/njMX9pGM4BMCXQP5UhaFgiqQ9Bxew8rBt0/Hk1Sa2rbbw1M7gCPNXiShjmcQtyc/JZ51Rfsj5c9PAK9Owc3JATk7RIngUWN7A6UKzwQWkCHwzofzjoJIrQWvACp442rGExZCePJHtk86MyfbzgOb3N4vdX7Rm++klur7gEasxh6giW3sU/4DoQELMFDy4yOq0udrGZkxn1CvlFzU7ooglCyv3kC3ZrNixq0WA/4eCCDk4BBda7PBLfsf52uD6A8eScVFkzgGHtsAD4GFsRqYWf5A0WaxjRDqLCId3PlNXFn5tB0IqUH5/T8X7IzpjZQoOHWLUNdwrVgBke9Pswy0DC2Xt4rb5qG/5fnPs6RuUZDoCELSCuFD+e68OMRhXRyOjqbMW/ezxWNpV1Hz5mAqpqRXdaLbddOsV5KoTT2cNepLZ0z7uo3JGX8OSKjsPCQphbrfNHPCb8jLcCPxPnRxM0kW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZRcTVhTVNCSGVHa3FPRWZlK3lveU4zSU5sU05QbTl5OGR2R0xqdWRLT290?=
 =?utf-8?B?cFhJM3ZPQVBjTExzWUsvMWp5cGl1MjFKUlAyNG1DWm04azFVU3k2VVBOL2ZC?=
 =?utf-8?B?UkpvOTVOY25xQWNnVkRaaFREVy8zYXpwUlpMTk5wRlp5ZkpYZDE4eE5vYm44?=
 =?utf-8?B?VjhOd0N2d3hkRkRleDh2cGcvMlFQRURpOEorVDBOY3ZkcUhpeWpqbjBtdFps?=
 =?utf-8?B?TVpyWWNMbGRXWGVMdFFuc1cxaE8xcEUrcURURG1vTjlHMEErTzJtUVJRRERT?=
 =?utf-8?B?ZWRwL3UxcGNSVng1QkNoRjY0TVFTRTczRkVGaSs5WWp1M3dKeWRrYXNNMFNL?=
 =?utf-8?B?dVR2Rk5SRk4vODJHVmo4dldGRWtBbllTQzlmMkFaSUFMVVlaLzZ1WDZWUlkw?=
 =?utf-8?B?KzVkdGtiZ003VnRZSThuNytvbFNKMEltUzMzR2ZtYklzOWM1UVFwWUwwcHov?=
 =?utf-8?B?R2pQZml1bll3M3Z3cndjc09QZkdBUStxRFVLSWVMT0FqTFF0Nk40WGE0eHpJ?=
 =?utf-8?B?YzRkMXRkQUppb3RQbFRaNEd5ZzMxNGtjbEtZZC9pSHd6bjNvQXl3QmszNlJ2?=
 =?utf-8?B?RXpXTGxtUU5SNXpiNjBGck5wTnVEUnpSSTNoRWpDYzNlUUkzMTVNVnF2UElX?=
 =?utf-8?B?aGJJa2x0SnhSVG9qL1lWVEYvNEZaZXVUd3pMWm1ITWpPdTByZEYvSHJRUlZk?=
 =?utf-8?B?NGZ5VllMWFI1MGdUamR6Smp2eWg4c01ZVnI5ZDRNNVhhSGFLZENGb1BGbHRa?=
 =?utf-8?B?eWJWMEEzTzRSYU9TdTJldm5yZ2xSTUNRVCtBZU5JejB3LzJORkwrc0M1WFRX?=
 =?utf-8?B?dFdLZ0ptRTkvSXJCY2FVRG9yWkZNVEczYXBjMzVkOHYrQmt1blArYnROaUp1?=
 =?utf-8?B?dGdtZ01UYnlkam5lTW9QdG9kY3J1QkJlTWs2S2FhYUVHVHBRcHF1OGJCcTVT?=
 =?utf-8?B?ZWl6Qms3ME1qZ3BHa1ROTjdQNU5RR1VZdG9PWkFxUkpCU3FWcHhaOU9PQkhq?=
 =?utf-8?B?ZG0yMFY4RHYxZEFwUG5BNEFkdkhDMytTSHR5NTdsbnJiZjQ2bjhxcmNIWmR4?=
 =?utf-8?B?dnBxdjg3V2JPenJ0UGVrLzBMOFRhengzcjcxRGNWcUk4R3R6Z1JNdXhieDdZ?=
 =?utf-8?B?VE91N1pDdlBxdk1sZmx0aFhiZGpCcFZranpkbmgwVUxuTlhmN0RqVXZLMXFZ?=
 =?utf-8?B?VDdWSkVJdDNyd3JBREhoRGRiNExNMVJvUWl4a3NWZmlES1hiSHRTTVkyeUNs?=
 =?utf-8?B?Z0N5aFZNMDJ5bTArMWRuUnZWOXNZWSs4L2dLdlJtc2JqMDVtTkQxVGFxOGRL?=
 =?utf-8?B?ZEJpVnBZY3BlZGQzL21DR2xNbHphZ09VQWt5ejU3RkhlSEZlOFMxZC9kaEx6?=
 =?utf-8?B?N0pZbWxmejRBUk52aEVKQlZ2c05EaDJVRC9jNzluTTBRS0F1M3lqK1o4Nzhs?=
 =?utf-8?B?RytCN3Q3RGo3b0hBVUsxRmlxdXdrSzdzTENITjAwWlpMcXdQaVVHUlZGRFBi?=
 =?utf-8?B?cnFPLzB4dEN5a2Jma3VSd0lhT3k0N1lXeWQ1aXNITUVROWQ5Nmk2a2o1UHgx?=
 =?utf-8?B?ZHdNMmh4bkt0OHg0Y01ZeTgxajV0dWw0TnhocE9zY3JIU1VFVkFBeWp4cSsy?=
 =?utf-8?B?dkkvRGprUU9tTFVBeDBJRWpXYytHWEM1cmh6blpKQ1RFMjJzYzdpVVhBZmc0?=
 =?utf-8?B?cXNHbGFLSlJjTXRaazBmaURIZnJsbVpkeDRNV1VheFdTYzJQdTVORFFnaVNQ?=
 =?utf-8?B?WkRtR1lxOEh4SU5IVXhsclhLVEE2YmFLcDN5NUs3THBHaFVNZ0VGYUpGalRu?=
 =?utf-8?B?L3pRSE9Yemx1c0N2Wmh5VU5TNDN3UUlXR25YQTJYSVM5Ry9FNXZ4NlNLTFlJ?=
 =?utf-8?B?R3RNblBWc2FIemczeFVEcjlqbDZSWi90YUI1K2ZsVm01LzhWRHhJRllRUTQ4?=
 =?utf-8?B?Ylk4WUF3aEZmd2szK2lXcWtNbk9tUmpjbTBQQkg2YWV0R2YwaG80YUN3WUV1?=
 =?utf-8?B?eEg3QjROanA2ZFYrSythVHVlaDhRdVR1K2Z6WDBYUk1RQkRWUWZ3MUJyUUlK?=
 =?utf-8?B?V05BVkI4K2ZDOUV6NEUwZ3hVNGJXYUNjWDVvcGttbXhaRy9kaXlpSlV2Q3hr?=
 =?utf-8?B?T1Rlc0I0d0pPTzVsWm9vOGRLMzVSWXRpaTk4ZHZiZWEzY0d4QUtWVHRjMG00?=
 =?utf-8?B?VVIxZGlRWURneXVhUU9VeWpoRWxJaWZKVDVMSE1YbXYvVDZtQzYwOVhGSWxo?=
 =?utf-8?B?UnQ5YTM3SzRmeFlXeGVYSEZGVzd6cnNPNXN4K0FwL3M1WHlMZDFDeXFUNGNz?=
 =?utf-8?B?Wk1Ucm5KeE8ybFoybVhuS1U1bEI0TmFWcVR2UUpPZDViYmk4RWxnUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b27760-4eb0-4216-d7dd-08deb9601123
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 06:45:39.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyUt8kKNhUTGtT97oXUbMtBV+04pnUXsrkSt+wrc6uRHYuhS4yJuoZtgA6onZjEF08JFbqaKOWesUCeEDhc2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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


On 5/21/2026 6:04 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 21, 2026 at 04:46:31PM +0300, Avihai Horon wrote:
>> On 5/19/2026 10:58 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
>>>> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>>> flag is sent to the destination to indicate that initial data has been
>>>> sent, so destination can indicate back to source when it finished
>>>> loading it.
>>>>
>>>> To get a more accurate estimation of initial_bytes, re-query precopy
>>>> size before sending the flag. Extract the flag sending logic from
>>>> vfio_save_iterate() to a new helper for clarity.
>>>>
>>>> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>>> flag if, for example, the previously queried initial_bytes was lower
>>>> than actually is. Additionally, it prevents sending the flag if
>>>> vfio_query_precopy_size() failed.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>>>>    hw/vfio/trace-events |  1 +
>>>>    2 files changed, 33 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 2911583ee1..243624b5fe 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>>>>                                             data_size);
>>>>    }
>>>>
>>>> +/* Returns true if the init data flag was sent, false otherwise */
>>>> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
>>>> +{
>>>> +    VFIODevice *vbasedev = migration->vbasedev;
>>>> +    int ret;
>>>> +
>>>> +    if (!migrate_switchover_ack()) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (migration->precopy_init_size || migration->initial_data_sent) {
>>>> +        return false;
>>>> +    }
> [1]
>
>>>> +
>>>> +    /*
>>>> +     * precopy_init_size holds an estimation of the initial data size, re-query
>>>> +     * precopy size to ensure it's really zero before sending init data flag.
>>>> +     * Don't send the flag if query fails.
>>>> +     */
>>>> +    ret = vfio_query_precopy_size(migration);
>>>> +    if (ret || migration->precopy_init_size) {
>>>> +        return false;
>>>> +    }
>>> IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
>>> much (when NIC reconfigures?), then we can still rely on the window where
>>> the "new switchover ack" will be requested later on during the exact sync.
>>>
>>> Relying on that seems slightly cleaner.
>> Not sure I follow.
>>
>> New switchover ack is requested in exact sync if we see new init_bytes > 0
>> (REINIT flag).
>> This flow happens only after the new switchover ack is requested in exact
>> sync, when init_bytes = 0 again.
>>
>> So this chunk just makes sure we send the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>> flag at the right time.
> AFAIU, what this chunk does is, we may save one switchover-ack if REINIT
> got here.  It doesn't provide much functional difference in reality.
>
> With this code there, when it happens to see REINIT, instead of sending an
> immediate VFIO_MIG_FLAG_DEV_INIT_DATA_SENT message, it falls back to send
> init data in the next iteration loop, saving that flag, and saving a
> "request switchover-ack" on src QEMU too.
>
> If above code removed, IIUC VFIO will send VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
> immediately causing dest sends ACK.  vfio_query_precopy_size() will be
> postponed until the next sync query (which must happen at some point before
> final switchover), then it will be collected there, VFIO src will request
> for switchover-ack, then another VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is
> expected.
>
> Both should work, but what I meant is, I think we don't need this random
> check, because it's optimistic, it's not functionally necessary, IIUC.
>
> IOW, see the current code and how it can still race with a REINIT anyway:
>
>               migration thread                                  some vfio driver thread
>
>      ret = vfio_query_precopy_size(migration);
>      if (ret || migration->precopy_init_size) {
>          return false;
>      }
>                                                                     got reconfigured,
>                                                                     set REINIT
>
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>      migration->initial_data_sent = true;
>      trace_vfio_send_init_data_flag(vbasedev->name);
>
> It's the same to me if e.g. we try to vfio_query_precopy_size() in VFIO's
> iterative loops from time to time, it'll also work, it'll make sync more
> frequent, but it's not needed.

I see what you mean now.
However, the purpose of this chunk is not to check for another REINIT, 
but rather to ensure VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is sent at the 
right time -- when init_bytes is truly 0.

If the flag is sent before init_bytes = 0 then dest may ack too early, 
before it did the time-consuming load and we risk having that load 
during downtime (see my next response to the cover letter).

At first I thought mlx5 may report init_bytes estimate which is a bit 
lower than the actual value but then I realized it can't happen. 
However, I chose to keep this patch because it's aligned with the uapi 
that defines init_bytes as an estimate, and because it covers the case 
where precopy info ioctl fails.

Granted, if initial_bytes is so important I'd expect drivers to report a 
pretty accurate value, but still, it's aligned with the uapi definition 
and doesn't hurt.

Thanks.


