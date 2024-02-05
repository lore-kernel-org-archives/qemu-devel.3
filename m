Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54403C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwwl-0008Cs-Bv; Mon, 05 Feb 2024 06:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rWwwg-0008Ch-U6
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:15:26 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com
 ([40.107.237.53] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rWwwe-0005NQ-CX
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:15:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL5Ivimtzlx1jbMQl0YVVwRS6ccHlSz4s3yji17J4uxdO8rMybKFBvLutoX57FGQmRzQLmH66QQe73FP8/LVkRk/9MmiV4v8h8JBjE28uivp7+4Tqxyv+XdW/nFmiDRAz42CJUfaT3LaohYh1HnIY6UMoCJrZTPQv4hRFNkPw3nEX0A8IOpNN/lr6FszVru0e6eNEVowfk7CNYZZCNydcfZSAeGQmJTvMjxOWcORikAWmX0d/1y5y3wACvMyrPaRc1M9PPPrnlJCOw4NMqmauMzHtL9aro5KJRNgkMV/pdo0qxOjhtGxRBF8GY4yIMtZkW3hYwLMV7YrJdZZptMF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KZYrw2WOd5f4kkd7w+bhraZ0yrFmbszD4XtE4vK1PE=;
 b=PMm6A+w0DAlRjfvVHoC1ADHm7ayijGiC4xkUNWAKxs01l/uZ2uSWOsh+J+UcLN9L/J0K1BXcN61otD2b7BeUxTbNEonBE7RDp+4X3/7NDhpLFuuqokpRvlqPItBorShFsXCjAVtA7ZvONXiBvCBvoGcylsn7QbXZXZwo22XUnEAQHngbkSV7/VF3WM9fbcbGwnzEUYgzeGtcAWq3T0O5vN0pKIT3IdSPrrvlzr1+RWLQB0mcr4DxRuDgZQK1Bc++gD8pV0mCv5tKdxCAx8SDVYp30s0VWSZ/wlVKHc3+SH5fVCkofVmgjsdX9HqVlS0ZFkeFcQbxGF7YZ/mFM9K5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KZYrw2WOd5f4kkd7w+bhraZ0yrFmbszD4XtE4vK1PE=;
 b=m0nNBE2Ge3rPjeH/Pxdm9fQjU/sO6gT3enVGezgnvnyBVyZRRFnl1xJ5cunw0ecuRTzm36t1ItS3bdx/1oFXuh+auTTNhwJcUP3v2w2jjq+rwLyDoqwBz+B0OpDA4+dENqzNE2tsh1C2cNlNk2hYBjS3cfe7NSwmRuIuixw/fLNExcrLKmg4pecb7TD6SHM8byq7zysuPJAq1LOmc9nw6CVcT6vzcU5GfY8OP1wCEgUfI6G+dhXOeEcPovYGdCRahxQKJooH7FsRDDNMneUp/Xi1d8btChAZ0/lyYmRll4nrcYOTo5axmBRDXGBnVWXBiSt/urUK5cSqFrImP8h6Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Mon, 5 Feb
 2024 11:10:19 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Mon, 5 Feb 2024
 11:10:19 +0000
Message-ID: <6bd7f665-23d9-48d5-9f79-0b012e3a6205@nvidia.com>
Date: Mon, 5 Feb 2024 13:10:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] migration/multifd: Add a synchronization point for
 channel creation
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-6-farosas@suse.de> <ZcB-O5WiZtvGiyNR@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZcB-O5WiZtvGiyNR@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: de324c6d-18e1-409a-5bcd-08dc263b09c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOfcRPo53X/Q3natV1KjrVjgfXJcLdFCMeDAXTdPr91O9WrZKTzeEqSvV4qP9wqpH622OTBxaFWpgjWBSRig0BrTp5BT1kF1KJ2ddRnKWqEnQE8chFD67sikKQNRzvsWfbYYVSMw9NMCUvsKyTSMT3YL/SWL0bOdp1z2eZgQBSVnPPZrIvWbk+NhXyXnVqoytQ1E9qggru32ByDxOA7DuFu0VN83341Vhf/U/Z4HOJcHdk69MIDQsNbbnNBNsQCWkKq1cEhUmNKpPtn0xY1R6XoyAp3dbEhyW6xFvNT0xsDrBMaa/MuxuK0mtyinHzPgf/tWOtqDQLV10A1igq26REWOtnobWgeUwpYZ6KEeyI/KLI3y1mxSCAKJDeuQCw2oJbBeOITYqziHkgo3k1A4BqqoRWQpbwpbmfjkyZVDhK9hAkaV2L7O+XHD8uqCRw99ADvE+T0NCMnLsveJxogVY7+e/Kpey/YL0qc9OsDVF3qdPLo3eMEcm2+u88zL0WKaZSPmgEqAmH7rOq6rinc+UE994rqlSoRiIbQ4x6leVq39RIH4k10gtvzorXUsugpxarlEni+lnD0eNcFR+eeO9OopMRAGvUu0mX9ejcwLi9j6S2IgQxxVy8S1FspkezDaMHbX9MV776PoFAJXT81Y9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(41300700001)(86362001)(53546011)(6512007)(83380400001)(6486002)(2906002)(31696002)(36756003)(316002)(38100700002)(26005)(2616005)(478600001)(5660300002)(66556008)(4326008)(66476007)(6666004)(6506007)(110136005)(8936002)(8676002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yks2Nm5iZ08yT2lQZWVwVmE1MFhpVkN4d05CcmFqR3Rtakh6Q3hVU0J6Tjdk?=
 =?utf-8?B?NGIxb1ordHdmdXlKTlk4SUxVcEVFdEFJWk9LZDk3dFg2YVBRM0RZWVBPQS93?=
 =?utf-8?B?U0NnckptRTd1cTRQa2xNbGtFYmdiUnlJWXhlMko4MVYxNnBaVDFVbnpCYTVU?=
 =?utf-8?B?Zi9IYlNyWTNGSjFaZjRGckZvUG1RNklFTWFlVUM5bzN1ZElOb1ZFSDdhOHMz?=
 =?utf-8?B?TFROb1ZFWkhHSk1qVlYxcWpMU1BOSDJ6U0dHbVkxR1Vpdm9ieWt1MUR5UFFJ?=
 =?utf-8?B?M0Y2TVJzaVhIWXdaRmh4WXdpaXVQSUlWMDdTSG51anVFSGZjbUtUZXllMlcw?=
 =?utf-8?B?alJMaWh5M1FIaW13SWcxTVA2RGdHSUJsM1dTU2dQTzN5ejROSHFoL0ltb2hT?=
 =?utf-8?B?dWdVbVhCelA1T1dtSUZmamV4bG1tdnhQYjFCNVhFVUk3SXQ2SUJ1aWVmVnov?=
 =?utf-8?B?cEtLR0ZIQkp2UjRSV1dKWi9IcFlBQi9rRnFvVXhEUmRsVU9QTUt3M2NjTHc3?=
 =?utf-8?B?V3h2VkFybldIOWNGNTJ0b3RkaWh1VjQ1U0d6UXE0dTByalNyN0hFYzVFTEZH?=
 =?utf-8?B?azBYbEIrME5DeGVkUzdDbW0xNjdSZnBNTkQ5THR6VjkzZE1rc09BZ3FVd0VB?=
 =?utf-8?B?UmxWRHpnaC9ONS9ldTlpTGpaV1JrVXE2WVRSVnFLR05uczVacU12S3JXejBW?=
 =?utf-8?B?NW9iakZFNnR2Y2RMd21kVkcxeStIalgxQW5UOW5LZmJHaVVXMU5FVjc2Zm1Q?=
 =?utf-8?B?bFphdzI4eHI3ajdmNUM3RmVnWVpMSmFhQmxoWjRiRCtjUnR4eGhRNzFISytk?=
 =?utf-8?B?UlRzRlVTQVZaSEdHai95L0xoaXVLMmxLSkVMdVdkVXVwMzBJZmFRd0ZWa3A3?=
 =?utf-8?B?L3l1cEdGZStIVTljbFJEd2c0cHpzUmJvMklPWTN1MjV1K3pBKzlXc3AzSlFs?=
 =?utf-8?B?eGN2RFI2VjJVUGcyUVRnblMwTFFIa3RBdVpNWnJlQ0hmM2hqSUhweFZOc25V?=
 =?utf-8?B?RVFCczA0L0pUWTNDOU1uN25NalVBY1daTkc0MTdXM2JUeXZwNHNvNFd1VDNH?=
 =?utf-8?B?UEJyWVRpY0dOYlJ0RUNkUTVpb2lBZWhzZHFLd1M0QTE1elpLNk9aV1U4MTE0?=
 =?utf-8?B?dDZiSGNNbWdYK3VwdG1JY1VSL3lCUzk4TjZBcDNrTzVmaVViVXg2MWU3QkNP?=
 =?utf-8?B?ZXFQajMrUEJjTXc3cjNyclErVk1Xd1RabjRWdTlYaVV0OEgyU29DTGc0TkE2?=
 =?utf-8?B?YkVhYlA1RHFZem9lVmJ0UTd2Z3c3cEpmZE9yVG5oQjVlVjZLUGlNeXlOTjQ0?=
 =?utf-8?B?dFF1bElNMDYwTHJjeG5MeUUveTFVYWo0OWJacFU0TVBHWVVPZTJqV2RLaUJh?=
 =?utf-8?B?SGpnTE13ZS9LdHluaWZGOGRvVTAzbkxTeXZkbUpxUEtIS2pRUDZvL1ZNTWlQ?=
 =?utf-8?B?L3ZZb2x2RnkxRGpiOWQxbWdBbWYxSHZuTjNPNTBxVTZMQ2VXaHRIa1RvZjg3?=
 =?utf-8?B?Ym5pbSszNjZvd1BLcHlncTIrZTZZMkJHOE8vamJXR3JweHI1UWtVbjhLczd6?=
 =?utf-8?B?ZnVSaGs1VlNwQmtkdFBrUjhBZndPZGs4SkRjTW5HVXd3REVuSFNhVk5Vc1RT?=
 =?utf-8?B?Q1R4MXJVUzJyR20vNVRvc1Nqa25QQmdDMnNKTXBvc1NzdlJkcUFINzI1MzBU?=
 =?utf-8?B?VjB5L1A0MW5XanNuZ3dscG5kNXlvbUQvak9XVEt1b2cvSVlGZFhzYjhTSlRt?=
 =?utf-8?B?dmlLb3BzL1p5dW40SDZjNS9YaE1GWmZYUWN2bWNnN2F5bDlaM0ZaOGRTL3dK?=
 =?utf-8?B?WHZwVkRMNnBQalE0TGF0OW5yaEF3eUU4d2RxaFlQYzlQYWVvbUdQSHkvRHR5?=
 =?utf-8?B?UEFYSjQ4NTJnc1dxcGcySGMwbzFpaXZ5S2NsbVNrZkd5OCtESUxicFg1UjEw?=
 =?utf-8?B?aS93czdRSFhzSitIdCs2d3ZaRmsxZEdnYzl0UXl6VmlXaWkvbGNqY3FiL1Bl?=
 =?utf-8?B?cGtORXJUbzZtd0NramEwQ1RYYitQMGNzK3NOcDJZeUdTS3U0Tzl5RlNlMmxJ?=
 =?utf-8?B?dGE0MjZQOG9BRzl4RW8rVCtUellod1d2aTd6OTc0ZVR5N3d6RzhsZ3lRNWFl?=
 =?utf-8?Q?vm7N33XceGMLrUfWpJVx0NWUk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de324c6d-18e1-409a-5bcd-08dc263b09c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:10:19.0573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwzt1q4fE4SiakhQDorGsh99RjlO2c2ewZKxgb2X/wN7FMTKiwKXtqq+muSn6fHKmLoqzIgmPC9934mQagd/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
Received-SPF: softfail client-ip=40.107.237.53;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
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


On 05/02/2024 8:20, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Feb 02, 2024 at 04:11:28PM -0300, Fabiano Rosas wrote:
>> It is possible that one of the multifd channels fails to be created at
>> multifd_new_send_channel_async() while the rest of the channel
>> creation tasks are still in flight.
>>
>> This could lead to multifd_save_cleanup() executing the
>> qemu_thread_join() loop too early and not waiting for the threads
>> which haven't been created yet, leading to the freeing of resources
>> that the newly created threads will try to access and crash.
>>
>> Add a synchronization point after which there will be no attempts at
>> thread creation and therefore calling multifd_save_cleanup() past that
>> point will ensure it properly waits for the threads.
>>
>> A note about performance: Prior to this patch, if a channel took too
>> long to be established, other channels could finish connecting first
>> and already start taking load. Now we're bounded by the
>> slowest-connecting channel.
> Yes, I think this should (hopefully!) be fine.
>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/multifd.c | 67 +++++++++++++++++++++++++--------------------
>>   1 file changed, 37 insertions(+), 30 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 1851206352..888ac8b05d 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -360,6 +360,11 @@ struct {
>>       MultiFDPages_t *pages;
>>       /* global number of generated multifd packets */
>>       uint64_t packet_num;
>> +    /*
>> +     * Synchronization point past which no more channels will be
>> +     * created.
>> +     */
>> +    QemuSemaphore channels_created;
>>       /* send channels ready */
>>       QemuSemaphore channels_ready;
>>       /*
>> @@ -561,6 +566,7 @@ void multifd_save_cleanup(void)
>>               error_free(local_err);
>>           }
>>       }
>> +    qemu_sem_destroy(&multifd_send_state->channels_created);
>>       qemu_sem_destroy(&multifd_send_state->channels_ready);
>>       g_free(multifd_send_state->params);
>>       multifd_send_state->params = NULL;
>> @@ -787,13 +793,6 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>       trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>>
>>       migrate_set_error(migrate_get_current(), err);
>> -    /*
>> -     * Error happen, mark multifd_send_thread status as 'quit' although it
>> -     * is not created, and then tell who pay attention to me.
>> -     */
>> -    p->quit = true;
>> -    qemu_sem_post(&multifd_send_state->channels_ready);
>> -    qemu_sem_post(&p->sem_sync);
>>       error_free(err);
>>   }
>>
>> @@ -862,39 +861,37 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>       return true;
>>   }
>>
>> -static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>> -                                             QIOChannel *ioc, Error *err)
>> -{
>> -     migrate_set_error(migrate_get_current(), err);
>> -     /* Error happen, we need to tell who pay attention to me */
>> -     qemu_sem_post(&multifd_send_state->channels_ready);
>> -     qemu_sem_post(&p->sem_sync);
>> -     /*
>> -      * Although multifd_send_thread is not created, but main migration
>> -      * thread need to judge whether it is running, so we need to mark
>> -      * its status.
>> -      */
>> -     p->quit = true;
>> -     object_unref(OBJECT(ioc));
>> -     error_free(err);
>> -}
>> -
>>   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>   {
>>       MultiFDSendParams *p = opaque;
>>       QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>>       Error *local_err = NULL;
>> +    bool ret;
>>
>>       trace_multifd_new_send_channel_async(p->id);
>> -    if (!qio_task_propagate_error(task, &local_err)) {
>> -        qio_channel_set_delay(ioc, false);
>> -        if (multifd_channel_connect(p, ioc, &local_err)) {
>> -            return;
>> -        }
>> +
>> +    if (qio_task_propagate_error(task, &local_err)) {
>> +        ret = false;
>> +        goto out;
>> +    }
>> +
>> +    qio_channel_set_delay(ioc, false);
>> +    ret = multifd_channel_connect(p, ioc, &local_err);
>> +
>> +out:
>> +    /*
>> +     * Here we're not interested whether creation succeeded, only that
>> +     * it happened at all.
>> +     */
>> +    qemu_sem_post(&multifd_send_state->channels_created);
>> +    if (ret) {
>> +        return;
>>       }
>>
>>       trace_multifd_new_send_channel_async_error(p->id, local_err);
>> -    multifd_new_send_channel_cleanup(p, ioc, local_err);
>> +    migrate_set_error(migrate_get_current(), local_err);
>> +    object_unref(OBJECT(ioc));
>> +    error_free(local_err);
>>   }
>>
>>   static void multifd_new_send_channel_create(gpointer opaque)
>> @@ -918,6 +915,7 @@ bool multifd_save_setup(void)
>>       multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>>       multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>>       multifd_send_state->pages = multifd_pages_init(page_count);
>> +    qemu_sem_init(&multifd_send_state->channels_created, 0);
>>       qemu_sem_init(&multifd_send_state->channels_ready, 0);
>>       qatomic_set(&multifd_send_state->exiting, 0);
>>       multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
>> @@ -953,6 +951,15 @@ bool multifd_save_setup(void)
>>           multifd_new_send_channel_create(p);
>>       }
>>
>> +    /*
>> +     * Wait until channel creation has started for all channels. The
>> +     * creation can still fail, but no more channels will be created
>> +     * past this point.
>> +     */
> Let me double check with you here on the TLS use case.
>
> IIUC we still can have more channels to be created if TLS is enabled: we
> notify the sem as long as the handshake thread is created, then the
> handshake thread can further create the tls-armed iochannel?  However I
> think I get your point, and that is fine, because if that is the case, even
> though this loop can complete before tls further creates the final channel,
> we'll still see tls_thread_created==true and join() that tls thread first,
> then further we'll join() the next multifd thread even if a new one will
> pop up, or if it failed then nothing to join besides the tls thread.
>
> I'm not sure whether Avihai has any input, I think this can be a good idea
> indeed.

Nothing special, my understanding of this is the same as yours.
This fix looks solid.

>    there's a dependency chain on the ordering if my above
> undertanding is correct; we may want to document this somewhere, perhaps
> right here on the chaining of threads and how we handle that?

I agree, this is subtle and may deserve a small note or hint.

>
> This may not allow a concurrent migrate_cancel to respond, but I assume
> this is good enough; the migrate_cancel request is indeed at least so far
> something I made up, but not a request from anyone.  We can leave that for
> later and fix the race / crash first.  This seems to be a complete fix from
> that regard.
>
>> +    for (i = 0; i < thread_count; i++) {
>> +        qemu_sem_wait(&multifd_send_state->channels_created);
>> +    }
>> +
>>       for (i = 0; i < thread_count; i++) {
>>           MultiFDSendParams *p = &multifd_send_state->params[i];
>>
>> --
>> 2.35.3
>>
> One other note is I think this will also deserve a cc: stable? But then
> it'll mean all patch 3/4 will also need to copy stable to make Michael's
> life easier.
>
> Let's also copy Dan when repost; after all he more or less owns the TLS
> part.
>
> Thanks!
>
> --
> Peter Xu
>

