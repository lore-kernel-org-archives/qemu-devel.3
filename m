Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6560C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJtN-0004fl-A3; Fri, 24 Jul 2026 13:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wnJt6-0004e1-FW; Fri, 24 Jul 2026 13:40:47 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wnJt4-0007hg-3D; Fri, 24 Jul 2026 13:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N566yuj9VGwNXkFH6zIdgasXAozcxHmzBInOSFInbvGObcHBgC55OMCM55hGykh1SQdZv/T7k9nL6azxnukP81YyiGlXNHgqrvckhGnW/Uko+aRV2LetDG6CAimA9SM51LbFpDTtnfDfAht6ejWBXLOVdBtAakU5xlx8ChtjdPlJQQPvr74AVjgy/yPltkLO4Jj5OE7R8My5Bi+J/C0HomWsmAtFLOLBOsVZ0HxiApUla5QLRVvQQC4mLRhEWJiglNJe2vn5gMfRiLKYs5xuD3F2kq0Wg7+mcHZvkEAv/v3uC9xWuYWyEj4Pv50cuQe836t+R/Doh2UegDzJ/VdPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYhnaEB+/VWgrp6P2NbqxJHG7Irt+mllDKLOcFrnNCc=;
 b=iL/OyYAE0Hxi6tVKh+IeFTeAMW/wXcKoTrXzQDNw4LHbYksmHE48+8atOTojuu4GQ9+LJHNwlyCMobvRwzE4PnOF/wYhFy6grn8izMvggdFpGmavr6uUTiOwydEQgbgY2UmeKT+qApKApw471difQtZJt9eBq4acrfMs4+KSozrbDAS40mk+ZpUCVATh9Md8Llu+E2uOhnRrYOOvpQFOZ0VqB1GuQ5/O2QnKmu3f0zNYiI0DIZMQbwfDFypQWOki8L1b2Jw4PhQg9Intkz7a3tn5GhrgrNQ3sfPJYuE9Xg15pM6/LaLquFoU1u93j4aaLYYMxEZnkLRKnYg1k+qUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYhnaEB+/VWgrp6P2NbqxJHG7Irt+mllDKLOcFrnNCc=;
 b=t6tPxbqRXIo4lYzBZH8dgAoACD1KwrsLGn3Cg7a8XdV2X6jiMfxS1TL7a57hi5O4bAjy9Ro7IMXzoR+mZrXYidarDozqjZT7YjY+AVEx8T7aXTRtMJ4zqH4ny6aynLx4FJYLdyov91KNSnoESSjE6bSFi3wfqH8h5o/az0gGtWHGz5WDNEp6HnqkBWKKfhRysM6qGj4rBgnzeLmVLcZdD0NSYCFUPvpvdjt7vYJrAb9jHpstAp7JKNPLWW3ehWt+koPio9fJZDyKRMgFcrBbk6QNohUBNqWiyqbP9MUFgJfHvu87qPjDjneraTpoD/90m0mPN7IAQ8ViUxv2134oNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB11815.eurprd08.prod.outlook.com (2603:10a6:150:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 17:40:35 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 17:40:35 +0000
Message-ID: <94b57bd6-8604-4b28-9770-2a0716097afa@virtuozzo.com>
Date: Fri, 24 Jul 2026 19:40:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: do not try to clear the dirty bit on a
 read-only node
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20260716153552.3376009-1-den@openvz.org>
 <e586cdd4-f9c6-4889-894c-7fc71ca15286@virtuozzo.com>
 <amOYtc1byX2pFOH5@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <amOYtc1byX2pFOH5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB11815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9389fca5-bc9c-471d-353c-08dee9aaaa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|1800799024|6133799003|56012099006|10067099003|5023799004|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: R7yz42BsXFFeV7FyS/R4NTiuj618u+yJZPEb8OSbJxE4FoakJ+3+oZBBQw/G+SHM6gz8DKV7Z2g/alN+Sei9Cr56Jyxjd8UBJaxEwD5pD+17Os4pA/RE+hzFmydYxJLzJoSvNqeMpdlhveGBZCi4+Kd9qcvBMd+KVyfOaCKviDcG/9972TM2hTbeDvAMVWvdThk3DO4ZW5PJTYABnJztDnHnG5XD5dq9nwL/rXYh5z8V43GX4qumOS+IdLiyVFCHp3m2EO+AdmNyeXqHwAWBcGQCne6MHU+gnveBD9ukfy9EPnMrgjBwv0uLVoMFHOfoCQ4HNltOerr1EEIJDSNQXgYjS0GUDPrURcdObBMVzfK2izH4b4X/wiIGyIo5pajbaY1V3E0XKEc4m2fyc3U3L/QYTzeDkOjKN53eh1FttCHMERf6w8492adVbYRcboXCRUW6nwQjtZwfLYWbFo8D+HIRlCavlc4z877RN690niCHVh6VyH+opzijqdHM5UD6nxHdhhkmsgGbZEw9A178i5gwSTFKqZjlbxct0BhrmnW4iZkdfEHM3I6HN6LdBZdiiuvCcgcCa82gWfPBAUX2wShX3OjB//4WgmpnO4+09zuhw5vi+ucPvCp0Fg2OR9aDqZa8a9AZ6XoDnZ6C6Aw9pNllFy4meRiBOhNBaRA+1No=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNSaDVZdFFETTNTNklJTi9pRU0wc1IzZ0VnMUlUYkVQV2NpSjhkd0doWk9C?=
 =?utf-8?B?WUZsK0gzQjJML1Nvc3FwbXN3K3NYL1hBblgvcCtpazF6UnVlUFEwTkRLSXU2?=
 =?utf-8?B?SVdRV29mV3JoS0pGSFRSNjQ4ckJmRzBxZk5meGlFMVR1UXJENlk1SFN2TDBr?=
 =?utf-8?B?Y0tVVmlNdk11ck9YeVBZc0VQa005ZTdhMkVZMWkxbnV0NHBBVWdjNHFyVkFS?=
 =?utf-8?B?WDJsVVBpUlFjaEZMaG9VUzVRbUxVcnQxVFFzbUFVbGt3dEdQVmxIdzNwNitr?=
 =?utf-8?B?SDZ5aG9IQ29GUVBNano4UG5JUDFLb3JHY2ZUbjg5RVJuSkZZQ0RCVzhGSTBJ?=
 =?utf-8?B?RTJJd3FLVVpjRkhDVXlFT0hQZjdOdUx4L3I0Q29WWDc5UU9tZjYwTUduVHlM?=
 =?utf-8?B?aUFXSlpOek9LLzVtRitBUGN1UGQxc1ExRW1RMWZFQ3g2Sm5YZFh5eWFCUzFs?=
 =?utf-8?B?M25tbXNncVJzU20xbUhkK1IyNWQ4aXlKSFZpcXFqZHBmY2lZRUswMjlRNGU2?=
 =?utf-8?B?RWNKb254S01rSnI2MkJWem9NU0s0b3JhSnVOZHFwU3ljU0tkYkNGd255Z1VF?=
 =?utf-8?B?clZYSzlWSlJpV00rYWxWQUNRZW1iamhWbVIzSW1tYWIwWTFNRkdFTEY5Q1hr?=
 =?utf-8?B?ZVBVUCtJQlhTamZ0VmVlak1YMUxZMmhDcU1IVWc0N2FselZTWnRFVWlHTEZi?=
 =?utf-8?B?VHNzU3hVR3BoajNnWHZyRlk3Y0lCbXY1eEc3VVJDZDZ0ZkU2UjIzRHlNQmJi?=
 =?utf-8?B?SW0xRlVaVVlyVHJjWjlQVTdSMjJEVXFuaWx4dGtkTmpLR0NiNVBHbHprem5Y?=
 =?utf-8?B?RTRDdWlXMzJXdGtoSFRoUHN6OXpUTzZmWnhBU2Qwbm9tVlBoWTJkVWZReWdl?=
 =?utf-8?B?cmtyRnFSeXVJUEl0Rkp6UzlQUm8zVUhGdHJxL0xLTitTTXdpaWZGMGtFUW5K?=
 =?utf-8?B?QVl2T1pydTI5MityMVAvMzBubk9xWnF2MEIrSkFzS3U0cjlVTW9INXFRTDQv?=
 =?utf-8?B?RFQzOGkzdDlYRXNpODM3Rm8wWkNyZk5yNkxsYjZ6SGNwT0t0aHR0ZWhvblA4?=
 =?utf-8?B?a1R6YVF1T1c1b29NTVlTdnBUNU5sY1YvcXIydkJKUFRXbTF3bzV6bHM4UElH?=
 =?utf-8?B?YWVQdEhCRUQzTGg0aWVNNUlzc2JLNUxnWGVZUi84NCtoaDdwdWtDeTMraFNl?=
 =?utf-8?B?blZJL2hPOGo4REZpSFBMaXRYbkFDcTVvY0ltc3hQUEhqeW9rRDZFanFjS0J5?=
 =?utf-8?B?Nlp0b1FzNU9ieFA5NERYSWgrWkxUbTNMOUg2U08weGV3V204QkloQ2R6d2pR?=
 =?utf-8?B?Zi9FUHY5Q2JIZEIvZ0FMRDMwQUVZazBYcjhIR2J0QWcrZEVZV2U0UzJ2dEI5?=
 =?utf-8?B?SUNoV21pdzduclBYU2JuMk1tQ1MvZ05Wak9IbWN4aHZRNExjM2tzck1TVWZm?=
 =?utf-8?B?eGNzaUhiZ0RGK3RHZ3hFWkl2UUdLdWJNdmwyZFc4VXIwNnJGNFdKZEVOTDFS?=
 =?utf-8?B?eHB0SjlYTkVyQUZwWFNTNWJTdnBZWnp3bitPTHFTRDcra1hPbzErMTZmNTVI?=
 =?utf-8?B?VVBQS283OUpjYXlYL2VldnM5NUxYdHZQa1gvWWNNNytrNGt3VmN2eXpUSThh?=
 =?utf-8?B?T1FYQTVVcG1iYWRBeGxUM2JyQVhieS9mVDZUU1pyU1NsV1k3cGd5WEhOZFRy?=
 =?utf-8?B?bGdrZkdYU0lTZVp4TG1jRzhwd05TYUtjTXZ1UEJWU1FpcENaZVV6VURBRkpo?=
 =?utf-8?B?VXltWGZ0Q1RLakZ6KzlldE5XSWpvbDloU3pwQStUNEhNYm9yN0tVZDVCVmhz?=
 =?utf-8?B?eW9qY2tDSmF5eEo3OHNZdWF0MmtveTY0QU5JYUt4cnhMdmRYZTdwV0RpSUh0?=
 =?utf-8?B?RVo2Nkc3Sm13SHR0Tmx4eXUxejhwWXhMdUhIQ0ZsTUg4N1dRTU90TnR6Znlx?=
 =?utf-8?B?L045WFhLYTAzQmhuNGhteEVlclBsVWNPdVdZaFdQWDArbXdsNkM5US9jbW16?=
 =?utf-8?B?QisvcG9Jc3plTEFURGhqK1RJbmw0RXhLRmRpTjZSQkJmQ3NpcG5RVTN1UWM2?=
 =?utf-8?B?SHRjVXdKSGU0d3BNU3VFRjF3TktBaVhrcGFuZWRXWmlHbWlZMFZoU203ZzFX?=
 =?utf-8?B?NktSRHQ4SFRxaEpwS0xLTFROMW1pdTljYkJ6UHFoT1ZHMUdXeVFTTU1ndXMw?=
 =?utf-8?B?YUtyMWV6YmJjY1p5eW1XNzFqNUJ3VURSU3M3VUphVlhwSWNJb3pZOFNxZHJS?=
 =?utf-8?B?RDY4Q3NlTkVKNWlrTVN3elYxeTlrSWFvNjBGR0xSQnBtZlVydFpvYk16cGp3?=
 =?utf-8?B?YWZsVDhHM2FRVUtTM25RQXE5L250Nmg0K1FxNWRWZjNsRG9MMVdsQ2ZxSitw?=
 =?utf-8?Q?T/uPJoQsI7pnvHIkGNOvl5Hk7ZIDhPzEnG5l9XkeNaoEq?=
X-MS-Exchange-AntiSpam-MessageData-1: I2http9yuOJAfQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9389fca5-bc9c-471d-353c-08dee9aaaa7c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 17:40:35.0623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnUQpYLj9UnWH3jNODwecjgkuQbi2S9aVa507Td5OiviLFythk07jTyNb4vxFVqbQOvU5BiaKYGl+nwg2DP2Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11815
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 7/24/26 18:54, Kevin Wolf wrote:
> Am 16.07.2026 um 19:54 hat Denis V. Lunev geschrieben:
>> On 7/16/26 17:35, Denis V. Lunev wrote:
>>> This email originated from an IP that might not be authorized by the domain it was sent from.
>>> Do not click links or open attachments unless it is an email you expected to receive.
>>> qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
>>> plain write to bs->file, unconditionally. A read-only node can still
>>> be dirty, inherited from an earlier writable session, and that write
>>> then hits a missing BLK_PERM_WRITE and asserts in
>>> bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
>>> close -- closing is expected, the dirty bit on a read-only node
>>> is not.
>>>
>>> Skip the clear for read-only nodes, same as read access already does.
>>> Any other still-dirty node keeps the unguarded write: it is expected
>>> to hold write permission, and a missing one there is a bug worth
>>> seeing.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> ---
>>>  block/qcow2.c              |  6 +++++-
>>>  tests/qemu-iotests/039     | 11 +++++++++++
>>>  tests/qemu-iotests/039.out |  3 +++
>>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 2ab6ddd7b0..adb177e6b6 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
>>>                       strerror(-ret));
>>>      }
>>>  
>>> -    if (result == 0) {
>>> +    /*
>>> +     * A read-only node cannot resolve an inherited dirty bit here;
>>> +     * leave it dirty, same as plain read access already does.
>>> +     */
>>> +    if (result == 0 && !bdrv_is_read_only(bs)) {
>>>          qcow2_mark_clean(bs);
>>>      }
>>>  
>>> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
>>> index e43e7026ce..94a8bfe754 100755
>>> --- a/tests/qemu-iotests/039
>>> +++ b/tests/qemu-iotests/039
>>> @@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
>>>  # The dirty bit must be set
>>>  _qcow2_dump_header | grep incompatible_features
>>>  
>>> +echo
>>> +echo "== Read-only open must not crash on close =="
>>> +
>>> +# We must not try to write the QCOW2 header to a read-only image.
>>> +$QEMU_IMG info --image-opts \
>>> +    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
>>> +    > /dev/null
>>> +
>>> +# The dirty bit must still be set: this open never wrote any guest data
>>> +_qcow2_dump_header | grep incompatible_features
>>> +
>>>  echo
>>>  echo "== Repairing the image file must succeed =="
>>>  
>>> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
>>> index 8fdbcc528a..c66361128f 100644
>>> --- a/tests/qemu-iotests/039.out
>>> +++ b/tests/qemu-iotests/039.out
>>> @@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
>>>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>  incompatible_features     [0]
>>>  
>>> +== Read-only open must not crash on close ==
>>> +incompatible_features     [0]
>>> +
>>>  == Repairing the image file must succeed ==
>>>  ERROR cluster 5 refcount=0 reference=1
>>>  Rebuilding refcount structure
>> Actually the problem is more subtle. The following command line results in
>>
>> qemu-storage-daemon \                                                   
>>   --blockdev
>> '{"driver":"file","filename":"dirty.qcow2","aio":"threads","node-name":"file0","cache":{"direct":false,"no-flush":false},"auto-read-only":true,"discard":"unmap"}'
>> \                    
>>   --blockdev
>> '{"node-name":"fmt0","read-only":true,"discard":"unmap","cache":{"direct":false,"no-flush":false},"driver":"qcow2","file":"file0"}'
>> \                                                   
>>   --chardev socket,id=qmp,path=master.sock,server=on,wait=off \         
>>   --monitor chardev=qmp                                                 
>>                                                          
>> via query-named-block-nodes:
>>
>>   node-name=fmt0     drv=qcow2  ro=True
>>   node-name=file0    drv=file   ro=False
>>
>> which would come to exactly configuration being asserted in the test
>> and this setup is pretty legal at my opinion. In production we have
>> had something lengthier with more snapshots.
> Yes, I don't see a problem with it.
>
> However, I also don't get a crash or anything with your QSD command line
> and a dirty image with this patch applied, so what is the part that is
> still incorrect?
>
> What is the final result that you're seeing here?

  === Image setup ===
  qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on dirty.qcow2 64M
  qemu-io -c "write -P 0x5a 0 512" -c "sigraise 9" dirty.qcow2
  # expect: "wrote 512/512 bytes..." followed by "Killed" from the shell

  qemu-img info --output=json dirty.qcow2 | grep dirty-flag
  # expect: "dirty-flag": true

  === Launch daemon ===
  ./build/storage-daemon/qemu-storage-daemon \
    --blockdev
'{"driver":"file","filename":"dirty.qcow2","aio":"threads","node-name":"file0","cache":{"direct":false,"no-flush":false},"auto-read-only":true,"discard":"unmap"}'
\
    --blockdev
'{"node-name":"fmt0","read-only":true,"discard":"unmap","cache":{"direct":false,"no-flush":false},"driver":"qcow2","file":"file0"}'
\
    --chardev socket,id=qmp,path=master.sock,server=on,wait=off \
    --monitor chardev=qmp \
    > master.log 2>&1 &

  === Connect and drive it ===
  ./build/run qmp-shell master.sock

  (QEMU) quit

Expected result:
[1]+  Aborted (core dumped) ./build/storage-daemon/qemu-storage-daemon

Double checked this on current QEMU master.

Here I have just stated that the case inside the test I have added
in the thread starter is not artificial and this is not a mistake.
Such a command line has been generated by libvirt for me.

>> File descriptor in turn is opened in a correct way - with O_RDONLY
>> that is why the problem was hidden for a lot of time.
>>
>> Would it be more reasonable to disallow to set dirty rather than
>> to ignore is open question to me. Playing with permissions and
>> changing bdrv_is_read_only() seems more dangerous.
> I don't follow, sorry. The patch fixes a code path that marks the image
> as clean. Setting the dirty flag is the opposite operation and happens
> here before we even opened the image. How would you disallow that?
>
>> Also worth to note that bdrv_co_write_req_prepare() has wrong check.
>> It should check file descriptor rather than administrative permission.
> That doesn't sounds right. bdrv_co_write_req_prepare() is a generic
> block layer function, the file descriptor is a file-posix implementation
> detail.
OK. You say that at the bdrv_co_write_req_prepare() we check
only possible permission and that is ok. That was really
unexpected to me and that is why I have wonders. Designed this
way, no changes going in.

I can live with that :-)

Den

