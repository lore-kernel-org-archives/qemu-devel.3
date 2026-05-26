Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9CACD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnui-00055Q-0d; Tue, 26 May 2026 05:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnue-0004zT-Mp
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:17:24 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnuc-0000Xc-HI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:17:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT1fe7twr23DRY88SQvgoPL71c7PFIhMUW7qAYqaDtNb2jCGJ9ZkmDMpWbbMxkrDfBnb5qcdze1qmf1Rfb7tIQb/dnle2mbTwFBakCBXR2ofrBDcd5xHUxhlOD5mnwAbFUF+3GBg4jy0JO+5bETYIL0HDFJy2F1sN8kYdvvMWwGMmZSPOAEJDHvyJJKR2UBhS+746p7CbZtQPJMvxz9kmRH9wuKSQzFv1c7NePXlEIkRkuWbbShfIx95UlM8eNzNIYjDuKVPqVOCxYcH9N2aKKRYr0dHU19Sfz986RbJQcRJLTttil3Ha54XphinWN2EMZCNoypFEROGi+WbtYecYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9bewd72nOvBg9iGmxiz76GbPocrdH5V3VtFDE+11bc=;
 b=L2X5khA8Fsw0ZJTAVRuwtZASgNWbMCACCh0Re3dNCpAqkEmSGWcD7OFF4c4p6Oy3Maf5kRZxBz8raNb7BT93Llc/d2w8i66/mjN2c+/pJwCpWV6Kqni9TTLMsF7Pf7l/AvIXjAEymmJ1ZQHkDlHc6dMivmidjmaJULxFw86z3fh/hG14b2vF+6W9avWN/W63CrlvvHhe/nqTCOjDKd00xaLxRi9QP8QPUgc2PPdqQtkLIY8y7ri2czwO6YyLbBvXkMUyZ+a6Q422NPXmBpy3D52U3S3IfrQexFuT635L7Fbjorl65g5mLRK7EWZWARP8EGTu8hOrNki9S2aAg8pGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9bewd72nOvBg9iGmxiz76GbPocrdH5V3VtFDE+11bc=;
 b=jLOh6mbsOgukhEiRVti0ywu2HwGzz0MnLnLgBVJQDFypf+rVbApuFxbtNwOItdUmLX/aYv88SwE8dfogpkTdw6X7A4aedkccVMK5F/XSZEFqZ9rrAKbu1zPBv1CZFgBxx0KvraUIYm86ELbxZQvRFP/buA9wzuXDowSj4wCcpoSpyP8jIy70SUF83IQEuKatHJMJjCq5diTChI/OZI0/lB7fit0EAXAXvHW+ex3hjxMbrBO8F5x0XdqgpHmavBKDTtwS3mzFji1PyheFlgwOTxXW2RpBeAlJ1v6nEX4ITxf5wWz3o+dUGkQqTWpm/is7InlHFK+1jxSsQX7CcSsKvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 26 May
 2026 09:17:15 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:17:15 +0000
Message-ID: <a75a99be-0af9-4c46-abef-02a6e5231824@nvidia.com>
Date: Tue, 26 May 2026 12:17:07 +0300
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
 <5af18c64-267e-4948-98c9-20d94b4db4e9@nvidia.com> <ahRoln21IZAO_iOA@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ahRoln21IZAO_iOA@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2b4323-2fc8-49dd-b031-08debb0793d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ADO06FBtVyX9li7gznMvkt6dVoh3F3j07B89WlLcBInPow9awFumNlG+KG5pjOGwNEtT8HaMyS42ZkJh32/M+W79/sVyYOF157A7vX9gqrHleCmzzo+jAD8WKJX2Zww1Du0JoxJzaaS4xIpc2/hmG0Dc7H01WJvNmZRHGI0S3CLuFFfw1dwF/ccqb7X+it3JZZmA1KbY3DFOdrqI6FxTr0h6FlZYt9H+XCRiHSr1M/M6ZlAaNGIeI9QkLxGajUjoTQtY1xQ+ube+meFeuppjs2bQggyIWbLf25nfHYRkKMhLWWEwLX1ATphSJpaWi7nb+Tb8+zBZHCxL/vfG9IYzYNJRFi5wc01iMMZ7aLFgTKtuaTalPXplCmr63aarXPV87tq/OSgipD5JwfzSBpfnGaFDk+VuzGQymWWjgqaAMAqJH5cCUS4prM98f7afTeZpeCGbpbWdNFHfR1uiSoUP5MpXJFSOb9e6rTv+yB7jRdVXyAP170C64/JcYzfml4vUtja1/whtTdPpgResLrH1W2aEBlPImYmGq5Jnl/psmhL/VqdItujlkYirmKQRFqHwqLXcEAWC8txYkYRZAuZ5KuHBy+Rb/eaoENnhLQ+VJ04yIOE+LJKp00HoFxsd6yGKVBu2+Oyn/rRkL4MN4DaZVX/PT23PtJcc4mB1rNhLJtC0msxCxd6HIwXqQMc/4qD9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Y0bmVkK0RkamI5Zk9zYjhVYWpldG9kNTZ0Nk56OCtNQ1JvVlhQZmZUSlJI?=
 =?utf-8?B?RHYydWRYcEJMYnpiQVRZM3VaVURFZ1B2VE1rM2tWb3h3a085anZNaXpYUUFq?=
 =?utf-8?B?WTN5c3NrWkx0U2Z4b1AvTFN0NDF1Qk1lWVJVc2VMdXE1ZWJiZkZDZWthNGk4?=
 =?utf-8?B?aG9sV214T3hnQkpWMkE5N1RRVmJhWUJ3cWgvQXVwSm9wVVR1ajdpV3ZsS1JW?=
 =?utf-8?B?MzZENklZUXJ1QUJoM1Z5TU4zLzZabDBsa3B5RUR1cGd3c01MUDB1dW4xWmE4?=
 =?utf-8?B?aTV4MjlxZUU0MHBWWnR2b1pmVEZXdkRqakpuQVN2VU9JZDl2WGVxR0NXZTlD?=
 =?utf-8?B?QkUzS2JlNUVibDh4K0RYLzZKZ1R5M3VGeWRhMnlCS0tjTEFSTHcxVXNHRVl6?=
 =?utf-8?B?cmlTakpmOEl1cWdJYmZ1NUthZUZZUjMwZUYwSmUxNEdwcFU3TnNwWHVGZlZ5?=
 =?utf-8?B?NGRtU3BBSlVhV0t0SEZuWUVFZXFJci9NMXNvbXA4VkRiTFRpVlQrY3pleEdv?=
 =?utf-8?B?bnlGNHBLek5KeklRWjh0K0ZZL3Q5R2FabFV5OFdkZEQxeW81d3VxZlI3emdt?=
 =?utf-8?B?NFN6MFozTEpSSEZwSksweFNZcUl5dU8wREdrNFBMamZKVWdVbmhCS2JMWktR?=
 =?utf-8?B?aHltbWNoYmQ1eWZSSjdsajc5clNJaXpZeVZzeTRqZ3czSGdCdjVFN3NlT0FE?=
 =?utf-8?B?Ym56eCtHVHpKeVRiT1BRRHBVNWwxd2pkOVIrQ3FzRC9EeUR0RDhEVVpXR0Ju?=
 =?utf-8?B?Qno5Q29ZM0hud09yd3Y5MmppVlhVSzdRTU9TQTVpQXdmNzRSM0EyZ3BLRUJx?=
 =?utf-8?B?R1ZBSTVGMkFyMFlRMkp0UUk2S2VlOHlqU3JMYk9tRUg4WTNMczFtOGNOMWk5?=
 =?utf-8?B?UjBrL1ZrL1lWNW1kMlB0TVhPSHRNTHZWMWdtSHVINGVCM2V5cHNubDZac2xq?=
 =?utf-8?B?TzFpL21hbUFOWEpqMmpaUlpvRFphdWhwdklQeDFrZGFJM3ZCOFBSNFZHMkJW?=
 =?utf-8?B?N0tUYUR4NGhKN24xRU5YbXlTMHdWMS9QV1FFS0x5bGpjekNaV3NONVgrVnJ1?=
 =?utf-8?B?NFI3N3NESXZNRC9POGdIVjhTdTBYRHZ3dHYwZmJvckZuRWMwaFY3YTh4NlhF?=
 =?utf-8?B?MnBhNzUwZGhMNE1RTVlCMXk2RVdzR0kyUE4zMkk0azR6NWpmakd4OFBUUkcw?=
 =?utf-8?B?Z2NXNTJKaktBdUkraGZjckRIOTgxQXZkeDNTYzdEZ0pSekY1UXlvRm5PN0ZR?=
 =?utf-8?B?c3hqYmthRnRINGFUWmJMYTJNZk45YWFGQTZaL01FRU5ZSmE3dFpUWmdqNGF0?=
 =?utf-8?B?aXFLd3ZMVjEvblJRcEh3UVFDZ055dnFwUDdDcko0L2NLMTYwVEtUS1NDcmox?=
 =?utf-8?B?bjBsdTg3OUViU29XRGc0blZzcXhwTlNFZFNuM0xRTEFkdEdOSExzdXhzb3dm?=
 =?utf-8?B?VCs2R3kwd05uMTNMTkdJNDNBVGV4azJJTlUxTnpsZEFqMUhSMjRRdmtDbmcv?=
 =?utf-8?B?S1NBTjRiSzRzVTRFbTFYSEtzVHdCaU1aZjVTVm1DWDEyUTdoaDMvOXRsSFlS?=
 =?utf-8?B?a08yZFhOMXVRRERvR2VPSVpGNjFuZ3hXWXNycDdldVBzaC9iaGdHV045dlFx?=
 =?utf-8?B?RCs5Uk1KbndIMjlESHRQMEpUSWEvc3FyVHU1UE5oMGVuK1g1Q0JraENoa25X?=
 =?utf-8?B?bEUwS3hVRUduZ3BpZUVVZlZJNVRnKzRwK3NFeXYxQVg2STg1cmdOUFUvSm1r?=
 =?utf-8?B?OGVxSkYzMVVsM01HeFg1Zm53LzFQNVdoVFJ5Z0RsbG9jYjVBQS9FRGswRUZG?=
 =?utf-8?B?YkswbGJtUGJldS9ibDFDUkt1ZkRIUEZWTkl5UmN1aW4yL1FhTlltWlNKdVY0?=
 =?utf-8?B?bWc4ZmxFVnQ3bkhUMXh3clI1bFY3ejYzOVJTVGo3cTZQT2EzeFBmb2ZMVDgy?=
 =?utf-8?B?RTVra1o3UjF4bDkyeUN2MEhjYlNESzA4ZS81eTNoWEdEVGcyalArWGI3ZXBO?=
 =?utf-8?B?czR3SEdPcTFYRmJhV1M1YXI5M3c5bTgyUmJ3ekNuRDduTkZHUUxRQzVYNFlp?=
 =?utf-8?B?ZWRNelBXWld1NFJjcGl5bGdpWjZBeDdMb1hFUUlVaVRxVXAyb3NLby85MWZQ?=
 =?utf-8?B?Z2VCcDFKNzc3Vnk1aGxINXdHWk9aZmJzUFp0T1JROFNaQ2hRZFp4N0xkQUo2?=
 =?utf-8?B?cDdpbThOR2pEZktxR05uOTR1Tm9GZkVTZEJXc2pQbkttbG1hREJoRndoWlA3?=
 =?utf-8?B?Q0lrR29ORUxzVGM3QzNwNUJWTVg3dG5ONFRudnJ2aXdQdkdVOEtRd0o5VEpV?=
 =?utf-8?B?MnkvY1V0R0trUEhzd1p0TW9rZFFNVzlxQXBRd1FkWTlyazVZQnVLUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b4323-2fc8-49dd-b031-08debb0793d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:17:15.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IybOlNdp7xJ5bBDlP2v+pvwLXt+CLPK0QvRIsKx74MVGun7zaUVqgELFGiEA42j5vJHmWOQxtG30KH80TA8gpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/25/2026 6:19 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, May 24, 2026 at 09:45:33AM +0300, Avihai Horon wrote:
>> On 5/21/2026 6:04 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, May 21, 2026 at 04:46:31PM +0300, Avihai Horon wrote:
>>>> On 5/19/2026 10:58 PM, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, May 05, 2026 at 11:14:18AM +0300, Avihai Horon wrote:
>>>>>> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>>>>> flag is sent to the destination to indicate that initial data has been
>>>>>> sent, so destination can indicate back to source when it finished
>>>>>> loading it.
>>>>>>
>>>>>> To get a more accurate estimation of initial_bytes, re-query precopy
>>>>>> size before sending the flag. Extract the flag sending logic from
>>>>>> vfio_save_iterate() to a new helper for clarity.
>>>>>>
>>>>>> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>>>>> flag if, for example, the previously queried initial_bytes was lower
>>>>>> than actually is. Additionally, it prevents sending the flag if
>>>>>> vfio_query_precopy_size() failed.
>>>>>>
>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>>> ---
>>>>>>     hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>>>>>>     hw/vfio/trace-events |  1 +
>>>>>>     2 files changed, 33 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>> index 2911583ee1..243624b5fe 100644
>>>>>> --- a/hw/vfio/migration.c
>>>>>> +++ b/hw/vfio/migration.c
>>>>>> @@ -456,6 +456,37 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
>>>>>>                                              data_size);
>>>>>>     }
>>>>>>
>>>>>> +/* Returns true if the init data flag was sent, false otherwise */
>>>>>> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration *migration)
>>>>>> +{
>>>>>> +    VFIODevice *vbasedev = migration->vbasedev;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    if (!migrate_switchover_ack()) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (migration->precopy_init_size || migration->initial_data_sent) {
>>>>>> +        return false;
>>>>>> +    }
>>> [1]
>>>
>>>>>> +
>>>>>> +    /*
>>>>>> +     * precopy_init_size holds an estimation of the initial data size, re-query
>>>>>> +     * precopy size to ensure it's really zero before sending init data flag.
>>>>>> +     * Don't send the flag if query fails.
>>>>>> +     */
>>>>>> +    ret = vfio_query_precopy_size(migration);
>>>>>> +    if (ret || migration->precopy_init_size) {
>>>>>> +        return false;
>>>>>> +    }
>>>>> IIUC this chunk isn't necessary?  If we don't expect REINIT to happen that
>>>>> much (when NIC reconfigures?), then we can still rely on the window where
>>>>> the "new switchover ack" will be requested later on during the exact sync.
>>>>>
>>>>> Relying on that seems slightly cleaner.
>>>> Not sure I follow.
>>>>
>>>> New switchover ack is requested in exact sync if we see new init_bytes > 0
>>>> (REINIT flag).
>>>> This flow happens only after the new switchover ack is requested in exact
>>>> sync, when init_bytes = 0 again.
>>>>
>>>> So this chunk just makes sure we send the VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>>> flag at the right time.
>>> AFAIU, what this chunk does is, we may save one switchover-ack if REINIT
>>> got here.  It doesn't provide much functional difference in reality.
>>>
>>> With this code there, when it happens to see REINIT, instead of sending an
>>> immediate VFIO_MIG_FLAG_DEV_INIT_DATA_SENT message, it falls back to send
>>> init data in the next iteration loop, saving that flag, and saving a
>>> "request switchover-ack" on src QEMU too.
>>>
>>> If above code removed, IIUC VFIO will send VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>> immediately causing dest sends ACK.  vfio_query_precopy_size() will be
>>> postponed until the next sync query (which must happen at some point before
>>> final switchover), then it will be collected there, VFIO src will request
>>> for switchover-ack, then another VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is
>>> expected.
>>>
>>> Both should work, but what I meant is, I think we don't need this random
>>> check, because it's optimistic, it's not functionally necessary, IIUC.
>>>
>>> IOW, see the current code and how it can still race with a REINIT anyway:
>>>
>>>                migration thread                                  some vfio driver thread
>>>
>>>       ret = vfio_query_precopy_size(migration);
>>>       if (ret || migration->precopy_init_size) {
>>>           return false;
>>>       }
>>>                                                                      got reconfigured,
>>>                                                                      set REINIT
>>>
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>>>       migration->initial_data_sent = true;
>>>       trace_vfio_send_init_data_flag(vbasedev->name);
>>>
>>> It's the same to me if e.g. we try to vfio_query_precopy_size() in VFIO's
>>> iterative loops from time to time, it'll also work, it'll make sync more
>>> frequent, but it's not needed.
>> I see what you mean now.
>> However, the purpose of this chunk is not to check for another REINIT, but
>> rather to ensure VFIO_MIG_FLAG_DEV_INIT_DATA_SENT is sent at the right time
>> -- when init_bytes is truly 0.
> IIUC, that part should normally be guaranteed by this line you added prior
> to it:
>
> +    if (migration->precopy_init_size || migration->initial_data_sent) {
> +        return false;
> +    }
>
> Hence when reaching vfio_query_precopy_size(), precopy_init_size==0.

Yes, but here we only know that the estimation of init_bytes that we 
queried previously is 0.
Because it's an estimation, it may be lower than reality and then we end 
up sending the INIT_DATA_SENT flag before all init_bytes were actually sent.

For example:
Precopy info ioctl reports 10MB init_bytes estimate, but in reality 
there is 12MB init_bytes.
We send the 10MB init_bytes thinking we are done with it, but if we 
query again we see the extra 2MB (no REINIT in this case, because the 
2MB belongs to the same previous init_bytes chunk). So the 
INIT_DATA_SENT is sent too soon.

That's why we try harder and do another query just to make sure the 
previous estimate was accurate.
But as I wrote below, I first thought such case could happen for mlx5, 
but then realized it couldn't happen. Though I still chose to keep it 
for the general case, not only mlx5.

However, thinking about it again now, such scenario as the above can't 
happen as it violates the uapi, because init_bytes can't suddenly grow 
without a new REINIT (and if there is a new REINIT, as you mentioned, we 
are fine since next query pending will catch it).
So yes, I guess this extra query is redundant. I will remove it, unless 
you think otherwise.

Thanks.

>
> IOW, I think sending INIT_DATA_SENT is fine once it's guarateed the next
> vfio_query_precopy_size() will revoke it by the newly populated REINIT
> data.  Essentially, the race window is pretty small here.
>
> If you still want to keep it there, I'm still fine; having this extra check
> isn't making this incorrect.  I just want to make sure we're on the same
> page.
>
> Thanks,
>
>> If the flag is sent before init_bytes = 0 then dest may ack too early,
>> before it did the time-consuming load and we risk having that load during
>> downtime (see my next response to the cover letter).
>>
>> At first I thought mlx5 may report init_bytes estimate which is a bit lower
>> than the actual value but then I realized it can't happen. However, I chose
>> to keep this patch because it's aligned with the uapi that defines
>> init_bytes as an estimate, and because it covers the case where precopy info
>> ioctl fails.
>>
>> Granted, if initial_bytes is so important I'd expect drivers to report a
>> pretty accurate value, but still, it's aligned with the uapi definition and
>> doesn't hurt.
>>
>> Thanks.
>>
> --
> Peter Xu
>

