Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF544C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rff3J-0000Kw-2Z; Thu, 29 Feb 2024 06:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rff3F-0000KJ-BE; Thu, 29 Feb 2024 06:58:13 -0500
Received: from mail-he1eur04on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260f::700]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rff3C-0007X5-24; Thu, 29 Feb 2024 06:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6ox4720Ga6DKWG27fcKpxSgc/u4mWqAE6kRdHiXjjlA3dZ+NelFo8LNr9LizVCGuRQpX1wtdz1F9/3W4DYQtzV7qKU0baYsI5nfBrXt38crY08UD3/NFoUTR2MiEULO+MV2ysTt28dqVVyZXtDXSBwdAGCOUxoF+LUa9GggVSuUu9/w4IQ1KYQ3flNC5zco/HSM2YffCRekfiZpb+DUIiB9Y/XhQYozzrrxNfZTC68/xouHB0RhJ1V79TBYYBRKC8hbHGkQAsHgX+Dw8RJ61/NjObJ7/tDhGRaHsT/QEgztTmsVYhxtM0twrIoVBrljmIuefn+Uegl0GbtqzlOMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5Vcc02IBX23O/1+e/2zdWauKyTeQKq22Npy3qYIWj0=;
 b=Ed8z0/oYXSsq2JOR4xo2p6IT6ZbV+ckEQeT+t13hADNtgUvW9JQJWydYmkGhqmJDHLi/aqnV3RlpHmW6dy9azWXKqzIf5AEYm6J/Qo3KV9Qua+3hsOKgdWrCkt5KaLAh3p3aHlIdrCz1Pgvej9bDZnHb4rXAryl+5RpYYIil9GJXh+US7IqnWRf56LYIyPtoR+xbaKhDINggf3e1WaYWfiM2OhZVdIcU8DKMF7SdTpX1mDh3t8TR0Y1vgjYGIgzqcKIgoHHEcAzBWd9LT+Gd+uEmDB9Eek47r1Q/k2vHUuqtassJUvZkwmk6wOEVSeBUforPIwd+EdxKR5MJ00Y75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5Vcc02IBX23O/1+e/2zdWauKyTeQKq22Npy3qYIWj0=;
 b=UxQj871h+8tjzOsa8NxqNejloBpr2risT2+/F59w9eQAii1l3AscoEkpo43GqhG2Cjf61HldEFn/wLWHWyy0zqgBpbIrVYJSXJLuGFM6zT9xAo0PG6smXrvMaBIeUjNKbYti0t5jRcTKG2zCLD++xUu/cvD6fsQ4IhidRqZ1lSTG/UH1TmWh7Jln4gAipa+uqeqrZCCBynl3Z3UQ26VH27JKx/vafnZA3SpjewTh2tMtZMiO9j2HAoF0A6Mu4iAclyp0XnGv/b0ZSeuaUMmWQqr6kacCIpiq6Dl7qRajDYTPT+8dM/nAs4aX9bKed35jUiSK9OWOmah6OS0Fl0vTHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV2PR08MB9878.eurprd08.prod.outlook.com
 (2603:10a6:150:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:58:01 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:58:01 +0000
Message-ID: <607d1a2a-c1d9-44cb-8afb-f14406ec9713@virtuozzo.com>
Date: Thu, 29 Feb 2024 12:57:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/21] parallels: Handle L1 entries equal to one
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-14-alexander.ivanov@virtuozzo.com>
 <5be339a0-14ce-492e-a775-d6c263a2c35d@virtuozzo.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <5be339a0-14ce-492e-a775-d6c263a2c35d@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::27) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV2PR08MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ea8cb4-ac66-46e1-6275-08dc391dad91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwyyHOY1W+iw0b8521wSkBD86gs53YcgQci2EjcBh4eWg/8HXaahqntfTmBjrmfdW/lUuiJYOe+4dlK+X80s/O4DAf2A9yR8ml4HfD6nGuElW8kfFg3EJNoFlYyZHyZdj7r/HAotguqihHxtgadvmsdaBeW17YxxXv+KqcqA/AEd+KCg90twKfV/DIvnejVvSkfIygrQ66VIPlO2RHNOQ892x1kLhQj5qAdzVPpXoVAix491qeWDnZ95GqGogxgIBDxFUEnD3dQs1742ZBq+7hPufye4sL8NPxwRKbiqmz5FRmtopQbsCmsveSario8ZL61jZZ11np5Co3FYI76udHNhOvfLllnNYfqhZs9NJs9GbCRFNvZfbJqfpFMuZ2X+XfvXfQua+BoHRSREpuGenH1vNadSvJ8UxVKOZIXMbqR9jC1ctsFTu9cnhXYaD2sIqINxgrE4ZaGyO3NVlZy5S6KMP52VDUFgKOAAiwG14GiO4U/i21PEKaRgz8t9mNCo8h0Gb3tdDHt29lsb40v1/vvYQitQjp4qAhv3jEJMYQljs4/dooyPGc9v2M55E17aZCUWi98YF+eId5CuAxMuu/fUWu+ayS23sv6cn6nJtIWtb8V2k/bhqGiZfRZ2xpnN8m+mOLrIouGX0CQ7M/VxmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3hKTzBRay95UUNPMm4rc3VKdHN6L0pHMkNNQU1wOVhKMHZCYmNmT1B0KzNv?=
 =?utf-8?B?Ty9KektXNzl6QWU0LzFMNElrd0ErNU11MEQwcjQ4SDhLd0NSampMZ2ZHdU5K?=
 =?utf-8?B?VE1HdDB0TnFvQXJxdFlZeER1azNXRjlROXZtaXlzYVVkMjdsL1d1QWFSd3ls?=
 =?utf-8?B?bHk5aVFxVVpZK0M4bVI0T2Y5S2c5cSt6cjMzbktwVVNINzVZMi9zT2ZuczdU?=
 =?utf-8?B?WHJGVHZkMms4Y2RMZDBlNTVFazVwbHVnZlU4d3dtdEY1anFvQUxJRlVyU1By?=
 =?utf-8?B?c3J0WTZrajFWN2NTR0ROT0NZQjBrN1ZFaVNBc0twcHllM2NJMWhwbFRTdDBw?=
 =?utf-8?B?NHROYjJNNTUwLzhLcFk0N0NsUWwrNWZuS3pVUDdSSnRwWS8vcGhkRmZzNTdP?=
 =?utf-8?B?MFdXMHk2N1duV0lRWVl1K0ZHdHhTbEZYcjhNS0wra0lnYWZIbFZJdi9FZitT?=
 =?utf-8?B?d1VvM2l6aUo3NWE5bkJsYURRSmNZNk1kQTg4YXJxYUY5bDdORDJ2UjYxVW1U?=
 =?utf-8?B?WUxGbVJDTFV3dkJNQlZ2VS94RmZUcjVONlFFbXcyenpST0lVN2RDVU81bk5l?=
 =?utf-8?B?Z3piK3dJeDRIaVNzdHVUdlNyVldhaWJyTzRIZ3JjSXo0d2tyRGpRRW5PYnM5?=
 =?utf-8?B?eFhVRFFMZWdrOE5xQVpyMzVmcFVVbGxNaXFqdzVUSks3ZUlMaFZISHZsdWhu?=
 =?utf-8?B?ZHdoQXZId3c5ZkFXOWNwdk5xdk1iVUlRWEpNUllqcnRENFpXdG1ERXd0UFIz?=
 =?utf-8?B?QW9oTnpkUXRiZ0U2NmRFRlBSazBMYUUvdi9DbG9sNyt2WHFPR2ZUbmlneG1j?=
 =?utf-8?B?SWJYWnRkRG5SN0dnR0ppUkUzcWlKbzdOaUovcXZicVVGbjUrVkNlZHA3WFY0?=
 =?utf-8?B?YXc2Z01jZjU3bTN6ZEpRYzNqdk9SMU8yc0MxN2F6Q00yMXd5R3dGcUtoa05E?=
 =?utf-8?B?aU1pUUdjYkxuQWdJUjJkbUg5dnVHSmpzcFFEZ0RDSDY2SnllMmtYSllHdXRN?=
 =?utf-8?B?d0dHQnhpS3RqNlZpMVlOWlQrMnEwbnlGY1BDQ0M3YXJXZVpEUHlvUTdaUm91?=
 =?utf-8?B?RjAvL3FrNWlhTVBIeU5kSlMyOGlKWXAybzdxSHpXYkMwbDIyam9UOUZIazJD?=
 =?utf-8?B?b3M2cmVObVNscVVXdWlNTHVBU01MNlR2bzNSUThkcDVyajZTbjZsdkVBZUJC?=
 =?utf-8?B?alc1YTNBdWpxdm5Hd2lET0pCblJRKytoeG1nN0NPL2JSRmlZVUdTdnNhM21w?=
 =?utf-8?B?eW1paXk3ZGVrMDE4eFBpN3IvNFhkSTIyTlhMcllXZWZyNS9UQ2tyNVpvOEJ6?=
 =?utf-8?B?dGdRdFZ4d1hkTDB6N0REOWMvQllvOTlKOWZaZ2M0UnpweExCVlBNSW5jRVJl?=
 =?utf-8?B?cVFwRWdSc2ZzS0RnUDFVV252OUkrOE9uVEFaamx5a2dKWHdjRFZvenQ5SVhi?=
 =?utf-8?B?Tk01cWVvelM2Z3JWOFYrRnE5Y3dLYnhkaXU1cExta0l1QmdoRHdMbEthU3Nt?=
 =?utf-8?B?RGQrWEw2endhTDJpUlhzeEF6ZU82YlNWRU45M0FiSFV1YnVxend6bWN1SUwv?=
 =?utf-8?B?djc3aWJuZWUrNUZwUTdCTXM1Um1VOXJLZTVsWnRDVkxSNWpvdDQxbW1ndytJ?=
 =?utf-8?B?L2t5T2VBdkt6cDMvZy9CcmlYblRzQld1Y3RZbmc0bUdGRjYxRXBsbU53WmV4?=
 =?utf-8?B?a2M0N1hlTVk3RldUYURaSDkvc1gwT1VBcm8vcFMxSWZCdlRjR29oK3RKQVlB?=
 =?utf-8?B?eFFqbVcyRW04ZGNPd1J5RFpWczdFQzlsdTRMcVY4NXpqT0s0d2lwcHdKUWpI?=
 =?utf-8?B?WDFDTCtFZkpHRTB5d3l5dWxsQ2tOV21rZnpGa1RzTVU4cDRJN0V5ZVJ6a3Ru?=
 =?utf-8?B?UDV2Y1JpdENqS0ZScW92bXFvd0V0VkhrbFJwSUdjNEdRL2UwclZQZ1Q1eVAy?=
 =?utf-8?B?dHNuVzJyU1NLMWNIRDhiMEhVYTNFOEhTY09MY2RmSHpRb0hEZGZudDlNQWly?=
 =?utf-8?B?L3g4QW1aaHVkS3o1K2pHR2RDMEphT2thTHhvZUhzSUdaNnc5TmpQY3Q3QTJW?=
 =?utf-8?B?UTl5WEJVVGRmdDRlRW9rSGNBQ3p6VCsxNStRQUp4MGlBZWwwbldCQW03ekpH?=
 =?utf-8?B?a1lWWlhUc2NjSThmR0JrSHI3ZitGZSthRTNWRjVkWWlaQ3RPQTNhMVpQTFBL?=
 =?utf-8?Q?3umxtGMTtx11YV8+8rRF5O4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ea8cb4-ac66-46e1-6275-08dc391dad91
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:58:01.0317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAdhGAXkeeAUN3EUR5TLQRaBBm3HPxnuVO4FW65efychL4GfF5B6tZ1Eo56bTfQV9vgBPw2jDYNE8iDYUkYng5fb+IpVfxHUoiYLkMgUbYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9878
Received-SPF: pass client-ip=2a01:111:f403:260f::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/18/24 14:37, Denis V. Lunev wrote:
> On 12/28/23 11:12, Alexander Ivanov wrote:
>> If all the bits in a dirty bitmap cluster are ones, the cluster 
>> shouldn't
>> be written. Instead the corresponding L1 entry should be set to 1.
>>
>> Check if all bits in a memory region are ones and set 1 to L1 entries
>> corresponding clusters filled with ones.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels-ext.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>> index 195b01b109..033ca3ec3a 100644
>> --- a/block/parallels-ext.c
>> +++ b/block/parallels-ext.c
>> @@ -354,7 +354,7 @@ static void GRAPH_RDLOCK 
>> parallels_save_bitmap(BlockDriverState *bs,
>>       offset = 0;
>>       while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, 
>> bm_size)) >= 0) {
>>           uint64_t idx = offset / limit;
>> -        int64_t cluster_off, end, write_size;
>> +        int64_t cluster_off, end, write_size, first_zero;
>>             offset = QEMU_ALIGN_DOWN(offset, limit);
>>           end = MIN(bm_size, offset + limit);
>> @@ -367,6 +367,16 @@ static void GRAPH_RDLOCK 
>> parallels_save_bitmap(BlockDriverState *bs,
>>               memset(bm_buf + write_size, 0, s->cluster_size - 
>> write_size);
>>           }
>>   +        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, 
>> bm_size);
>> +        if (first_zero < 0) {
>> +            goto end;
>> +        }
>> +        if (first_zero - offset >= s->cluster_size) {
>> +            l1_table[idx] = 1;
>> +            offset = end;
>> +            continue;
>> +        }
>> +
>>           cluster_off = parallels_allocate_host_clusters(bs, 
>> &alloc_size);
>>           if (cluster_off <= 0) {
>>               goto end;
> That is not enough. We should handle all-one and all-zeroes according
> to the spec and all-zeroes would be much more common.
Buffer for extensions contains zeroes before handling (it was allocated with
qemu_blockalign0). We skip all  all-zeroes l1 entries and the stay zeroed.

-- 
Best regards,
Alexander Ivanov


