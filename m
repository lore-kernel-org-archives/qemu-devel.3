Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396E9CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMIQ-00057N-C2; Wed, 07 Oct 2026 03:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEG6c-0000bj-7V
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:06:29 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEG6L-00038Z-5L
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:05:52 -0400
Received: from DB8PR08MB5515.eurprd08.prod.outlook.com (2603:10a6:10:11f::9)
 by DU0PR08MB7438.eurprd08.prod.outlook.com (2603:10a6:10:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 21:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLRtYEoeHPVZdK97LUyd8BdF0lPP48lo/BEjTqgJaaq/gPdnmRYJEWt9qgUqC77NR2NfLeFSHBQeIKQh7Wyud8ie1ZWi/t2NXwQOzzwHCejtyAWz3CrpcKr5+8g4VkRoeDivRolV5qipjA9zj1BSwvsCPoPxFWosbzTYnkLizT/pV0efrsogm9xyh94nDLfT3Ubb/5bJLkWa0U+sn6MALsvOXHK7WiMoLPJ/DKrX0zduXfKpZD9wwAsr4VeEciBcoMh0l03qPSQg0wRLn1r/pXXve8hDfcUYFBUUtWLUU7BN+GH64Ten7RobcW6l3bOA6X+YrUzOFNXEW2MJAixCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LgVSEmI4FRo/UjZEq9QJfu0/1b31svET10BBklKGFs=;
 b=fSIfCvAqOzGIaY2Fcqa5iiZZ8KxDnMjG3ds+kWUVBgQOmTPE8o7GkbT04uniCeeKOkIXnWESUFdah584zP7lPHITEhw0dOn6naRRRAkY/nDbhZTENA+wmIP/LiYGN4q4wWrTgbSUkzE1vSFha1+927hlyGfHxPInxvwKshtfbLJ/8WsdgeR7TE+eSt/0YUmx7iZvb4uE3wHFQMJUtd98Kdjtky8Ite2CzlfHFNOtNqdKkemXk2fljypvl9Ibht+3CD70NfSqwFrmTBEhg6CNcXElByjKNZJV5vlJe2T4RCSNiDLXtZ+rFBoijV7kvLV6g1Z9oxwzIY1GlMX4MXIv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LgVSEmI4FRo/UjZEq9QJfu0/1b31svET10BBklKGFs=;
 b=Lz9HxXv6qH10WWvEwEJmPeyfvpUnA/iUnq5CMiSKyjEGVMASsU9GXtzW2ahNm8f33mbT4bG99mAoa4G9cP+PYxHxX4a7zOMy5aOfQ+RZwq6WUZoOJu5/q0irXBrWPyfAJzie9sUcpU/41peltKtlZUh6cKlRILbtdJzPB4OAYy6uCbz5FdIbxOGj94Qi2z714xAPml3oupa/WHlGuwqAvL8gb5NX650/akC7C2b5HWL394FGQErRSYa5hFMUxspBEiqKLQZqdTX67K4J4IaXKz1/ZOxM6jT9vdLt1bzRN5Egzo8Eynd2RrT+37JWOjcTeRAniUs4Euq88ndqt13G5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5515.eurprd08.prod.outlook.com
 (2603:10a6:10:11f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 10:29:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 10:29:00 +0000
Message-ID: <d4bed047-06c6-4b7b-a886-80dfd3223022@virtuozzo.com>
Date: Tue, 6 Oct 2026 13:28:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/21] migration: add incoming migration failure
 notifiers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, mark.kanda@oracle.com,
 bchaney@akamai.com, mst@redhat.com, sgarzare@redhat.com, peterx@redhat.com,
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, den@openvz.org, dwmw2@infradead.org, farosas@suse.de
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
 <20261005-up-vsock-vhost-v5-v12-16-40162390c68a@virtuozzo.com>
 <c9e3523e-a2ca-4187-8274-225f2c667c53@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <c9e3523e-a2ca-4187-8274-225f2c667c53@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5515:EE_|DU0PR08MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d443808-db6a-416b-cfad-08df2394a2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: UPa+qS3jqYkYJAiktjcjVDVSIPkxR8tMAJZNb3i/qw8KGtufjL+UPLMNW2rMVb7kU2DVmAqGvjex6+GhdupshqFLlXrZiJDtKVXSWZeq6oGAy546x4A2KMzbx1haXVGTHMpg1DQbPZ8la6xYuEnyzbU9pJ082qLjj2EALY/81jIAuCzpJWpf/iZ8omSjk5hvDdopn6PSMfTSQ9MCnO6gcG8Dea46I1uVZIWCbkakYdP5bUoUgH5eLGqOUPdTKw7zATKC7sRgChvyyv9319i5MoWCU32cM9LH6WTf+jFZgKZ+IZW4mY/got8E3h942A9Ak/TsAiZswkCPFcAN37evV4BWAz8t8haXe1nI3T4bAP/tLlmgtKH69Mu29Qofs68WQOpNBle7mWMqfuLfr7m8vne/Ud+IWwYwX+bwcETfsWiugUjyuJ5gdVIA2z2M/uoNYCir0jHA4oqXpV1rvRRxl12R6EcituNV/paCjkwlT14NBgI+2rewaSTsJDLs227XYoHd7dGTEmEQEvmGDOAOGBwiwyobXfLbFWVdVJQ/zNTIUlyRuHrQakHYSxtsuudortKv42wq6h6fFKNY7v1GfaKMqYpQHZdPoW+hT7FzlDJymXIUEsR+Rh0sWhWoDxWOoqNUXvhsb9FkrZtylCKcV+1EPJVRKSVngSR78K6Np7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emx3ZGEwZmpObGxOd2RhZVFzU1ZOR0FYN0xLNnU4MzBqekhrTWxCUzJWQnVU?=
 =?utf-8?B?L2dEMkh2RVFQaGU2dEdtK2ZEZnB0NW0rUGhNNWlyaUxoMzg0VytnTTVXNGVx?=
 =?utf-8?B?UFRBWUt6N05TaE1pZmo3bDVoMy92NjNQMW01R2JGekUzZ1RvU0RmT0U0SCtR?=
 =?utf-8?B?cGdOREZvRldkNi9vUkpUWGNaTVV0dlNra0hyWjFDd0xSaXZEdlNkOWZVWHpP?=
 =?utf-8?B?d3VIQm5PRWRmV3c4TFlUMTlxY2NDTDNqdm5xRWRMOWkvVFdURDZ4OUx2Qllq?=
 =?utf-8?B?VXRlYWl6cC8wVWx0clhZakdSVDk0OU15dWE2UFFhNFdpNG9ib2ExRTQ3cHFi?=
 =?utf-8?B?N2Y1K2Y2SktHN2Nyd3VJRjRFU2FzNkI5SjJZd2NkL1llZll3S0w3bkR0Z01X?=
 =?utf-8?B?TDg4di8rdEFUMnpzdDJVZzBQUnlNcTArZm90SVB6bldQNWRSVVNuSlpudWpj?=
 =?utf-8?B?N1Y2T3ZmTlJZNm4xejNNcExLTFRRcVhteitUUlB3OEJYSkxoM0VBZnYzWWs4?=
 =?utf-8?B?YytUY0hQTFRGZmJLR0RsTGhydkVlMGx2bEZUVFRFR3c2VGZNUFE3RWYvbXBa?=
 =?utf-8?B?UU5sbzBiS2NXMzkxUDQ1Y3JXWVlTOW9EL2pHUFFydTI5YTVjNmVwNXY1eG9V?=
 =?utf-8?B?R2s1dkFtS0hKRVI5VHRpaG9CcmR6U0t5YVk0bzN2d3E4Ui93OUtFem82cklN?=
 =?utf-8?B?UGt6Y0ljTldyWm9SdGRtSVBCQXlmS0RDSURJSG5nUTRNSjNTdlAzdGRZb0la?=
 =?utf-8?B?WStnbmp5OVNNbWFDeUpzUHpyMWZ0ZDkva3FqWTJTN1BieHVwYWlPUFh0c0l5?=
 =?utf-8?B?T0UrSk5FTTRLa2lnQjV3WnhUQlBlKytsWEljMUJJQXVGUWx2N1RJYkthMnA5?=
 =?utf-8?B?MzM2ZEVqUzgvRHE3SEQxcEhTY3NXSUtaK1pPRkZmdXQyK0JteVJURk54RHZ5?=
 =?utf-8?B?L3h0b1RvVVVubUN4aGtuY2RiUEc4QVBVOGZBZ0xXVkZwOTZnS1h6QVRaVlBJ?=
 =?utf-8?B?bTNoZElubklhVHJlS1MrUlZvYVBMYmhXSHZJcG5WWWJSdGRUdjY1TmVlV284?=
 =?utf-8?B?L0pBdXpUdzBpR0hzK1JtdFZ2VS8xeE1EbE5zVW95VXhhYm1FSlVBZ3oxN08x?=
 =?utf-8?B?eTZqWXhqeEIxdjQ4RWM1c1JPNXlBcGwwYlNUUVBDdGUzMmhyUjdJK3lETU8v?=
 =?utf-8?B?bjlmNmRoby9yQTlvdTlHTzNwNHZpaUdCUEZlVnY1bGNrNUFGNW9NTXUwYzBz?=
 =?utf-8?B?QkFiQzN3WDJESmlCVU9VMEhUR2xSaU1JbTJmYjRkUlFGSENzZEM2U3U3VDlv?=
 =?utf-8?B?eDQyeUFKRjBsbzJKWjBhY3FhQ2Q4ZFhERm5ScStLQ2tLNGI4eEkzVXByN1g0?=
 =?utf-8?B?R1VxeDRjN3pHRlhxeG1TSDgyNVBSbGFrWTNPWEN1dHFWYVpxa0xWdmEzTW5h?=
 =?utf-8?B?S3ZXTCtvWFNCRTJJUndVaG8rQ0tadVdnRnY4bGJOYmZFMWtCSm5UNWtwWG04?=
 =?utf-8?B?Z2NCeGxEalRQL2pSYVdqOE9KSEtHY05lblByS2EySUlHQi9lNWZZdHIybVJu?=
 =?utf-8?B?R3hIWlZpRnV4K1VlZUdtVE9sRFJkeVliQjFsVmNudTMyaG1aNnBIZjV2UGU3?=
 =?utf-8?B?V25UZENPclFXWkRKSFJtTFZRL1ZaZVZ4bzM3QUpYdTZsNmgvOXU5Q0QyUEN3?=
 =?utf-8?B?NXNuZnYzNG1ZR3RscmhmUnJBVmNXRGpwWEJwcEZsNFk1ZllKcmRJd1Q5bGUx?=
 =?utf-8?B?bm5mejJxYlpURTllbnFLTFBpUGpOUDZMTkl6TmFnWElPbVBrT3VxRFNpcUg4?=
 =?utf-8?B?L2IyRVFVME5WSmk5TzdBQ3RlakFrNHJadXFIMVdUdTFReWZzeVlDWlhzL2xW?=
 =?utf-8?B?ZEEwbmxOSkYya04xN3VxUlhCTlh4SjlvV1ByTTdkQlBGWW1uekRJN1gzdC9O?=
 =?utf-8?B?L3hFeWF3TWY1RXpPa1UxUXRYbW1YbzZZYXN6Nlpmc1RqaFFHU0ZHc05sUUVn?=
 =?utf-8?B?SnBDSU0xWHd2ZnNyVXdUOEZzWWxGTzlDNnVKMmlIOGFSK1E4VC9ld05sUUR0?=
 =?utf-8?B?NmNVcE5OdGNJc0VqNnFjbHZqVFBwcjVRM1JrSllGMFZjeE41Y2tBYkFGY1VN?=
 =?utf-8?B?RHdSVzlkZnFUaW9aU3N2V1ZlZjlaWFBVMXNydWF5blh6enBCYUcxcmtJMVRs?=
 =?utf-8?B?eG10RDBnMlNRZXZPSGt2R0k2NitsVS9udEFVSFkxMGc2Qkw2bGFScTdnVnVj?=
 =?utf-8?B?TGwzUFM0Q0h4ZjA3NnplMXl5dVdmdnNKQVhzOER3UGdJRjY0a1dwdlNSeTFC?=
 =?utf-8?B?NWFTZjhTbGNMRkg0M1pFVFpKYVY5aXV0WFNhZHR0N09iOStOWDVuUXllWTdH?=
 =?utf-8?Q?yrx7mNOZL7dJfUG4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d443808-db6a-416b-cfad-08df2394a2b8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:29:00.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSNhNmT6TK8OCILnnwl6ouQAAbNS04ZbrXrpHE5flEOwV+IXQeViw48b1HFumqoc3lTU7eMZXZ76Wa34stJpeC5Tcgok+avbn2lv4QcHKB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5515
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/6/26 1:03 PM, Akihiko Odaki wrote:
> On 2026/10/06 0:00, Andrey Drobyshev wrote:
>> A device may take over a resource from the source in post_load(), e.g.
>> vhost-vsock acquires the device ownership on a CPR target.  If the
>> incoming migration fails afterwards, there's currently no way for the
>> device to give that resource back before the source is told about the
>> failure over the return path and resumes, or before the target exits.
>>
>> Add a notifier list for that, called from the failure path of
>> process_incoming_migration_co() before migration_incoming_state_destroy().
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   include/migration/misc.h |  7 +++++++
>>   migration/migration.c    | 23 +++++++++++++++++++++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 019717f4cda..08d110750fc 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
>>    */
>>   void migration_remove_notifier(NotifierWithReturn *notify);
>>   
>> +/*
>> + * Incoming side: @notify is called when an incoming migration fails,
>> + * before the target dies or before the source is told about the failure.
>> + */
>> +void migration_incoming_add_failure_notifier(Notifier *notify);
>> +void migration_incoming_remove_failure_notifier(Notifier *notify);
>> +
>>   void migration_file_set_error(int ret, Error *err);
>>   
>>   /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>> diff --git a/migration/migration.c b/migration/migration.c
>> index fab7949fe11..55ea1e019fa 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -71,6 +71,8 @@
>>   #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>>   
>>   static GSList *migration_state_notifiers[MIG_MODE__MAX];
>> +static NotifierList incoming_failure_notifiers =
>> +    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
>>   
>>   /* Messages sent on the return path from destination to source */
>>   enum mig_rp_message_type {
>> @@ -818,6 +820,17 @@ fail:
>>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>                         MIGRATION_STATUS_FAILED);
>>       migrate_error_propagate(s, local_err);
>> +
>> +    /*
>> +     * Allow the devices which have registered their callbacks for
>> +     * migration target failure to undo the changes they may have
>> +     * done in post_load().
>> +     *
>> +     * Do that before migration_incoming_state_destroy() reports the
>> +     * failure over the return path (if present) and before the exit()
>> +     * below.
>> +     */
>> +    notifier_list_notify(&incoming_failure_notifiers, NULL);
> 
> This invokes the callbacks after migrate_set_state(...FAILED) emits the 
> target’s QMP event. Without return-path enabled, the source can already 
> be POSTMIGRATE, so a management application may react to that event can 
> resume it before ownership is released, causing VHOST_SET_OWNER to fail 
> with EBUSY. The callbacks may be invoked before publishing FAILED.
> 
> Regards,
> Akihiko Odaki
Hmm, looks like you're right again.  Also looks that this gap can be
easily closed by just moving this notifier_list_notify(...) line right
before the migrate_set_state(FAILED) above.  Do you think it's going to
be sufficient?

Thanks,
Andrey

