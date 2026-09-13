Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD1C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qE2-0005wn-Gr; Sun, 13 Sep 2026 15:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x5qDl-0005pF-24; Sun, 13 Sep 2026 15:50:37 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x5qDi-0005un-Dm; Sun, 13 Sep 2026 15:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js94z8nV59PN9gW1cFvHfRxTyS/kpuqTeVt7mUmwbr6mafzdX12JBTiJrVP8khaEOrww23OK2uF4AvUJIL+itu/CSoYzdYqLSmR2Tk12vdyLuAeuFTo2epWAeMcakEF6YLaLE8KZDLgDP74MuTtHk3ub7DGdZVteIEXUr+PqkCi0XhONdCme3J3P+URuvcANHKucNN1RfSbjpfLVNelq6zN3noAX/gzIyhdZWh80YDE9d4Q1CTTz4fMuC4qdtXy7Qira8qX7Hnv65GQgV8Aw54/9yRjL8TUZQAPsLTEN36TxEiwuAQomjey4RritncFBZtDBeoET573j5yiPxUpoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdnnYClJ59XLKTCtgE7/iDCT2iRXya79CZ/4EtcZnTU=;
 b=TBqPJofFWz5UBRWdrRb60AWsgG64o4joUVfXu2KILMyziR1iuiDs9hJod62Z7rtly13EL6Hs/8RfMUonA+NLV/97brGAc2iPJviJHBk2R35gm4i/slsyXK/3ZNXWQYPvp1JM2Kb5e5qJrRlW3nZIqDPjBUO0v88e6+2gKNKq3VvZeRe0NDk048xvrG+D1LaOXxxukTICf91wWte+wubLubuOsRcJK3sr50fDyB4HsFx58kCWr6ie4PKZAwYqI4f/wC0JyzV6D0U+ZwcbIOiF3AZatgVNBhnp4Rim4AfzudJQmHvs8NTeF2kBylYDpP9pGHHEmyP+Re9QqwC35twRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdnnYClJ59XLKTCtgE7/iDCT2iRXya79CZ/4EtcZnTU=;
 b=pdgRcoNt4gmwcT5tA7O7gLMNoQF686lUHpoA1+P83HE7FjvByxXjR1y/OuyQaRs8Lew9qhSLs5Rq8U0WmVJPa3S9WrLIedbuqF3iT/BcFUVQhJTxtz0olfUxsOcuoEB3pVnCKt39IPN/rtaQQFhfZGLs1ekBJpAwuIuRFfi+ykl3Yj7qAjDx2L5+/+ZRzzOkIFgqoQrPp7xSb1jedGEcNwS5Zu/lnfrc70cebiDs4zsbU1lqFjNIoO4GvcDxdg2If3iZO4nUBBIpabt9dVmnI1ZxEKT4ejMypnADDrA5b+9p71nVupeVLFqE4PYe44dEu2rPVh+eY+S10QWkgV7S7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by MI9PR08MB940098.eurprd08.prod.outlook.com (2603:10a6:290:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Sun, 13 Sep
 2026 19:50:28 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Sun, 13 Sep 2026
 19:50:28 +0000
Message-ID: <4bb04192-7c77-4dc2-8137-f0672fc7073b@virtuozzo.com>
Date: Sun, 13 Sep 2026 21:50:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260903144143.2328870-1-den@openvz.org>
 <20260903144143.2328870-20-den@openvz.org> <87mrtx9zai.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87mrtx9zai.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0017.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|MI9PR08MB940098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9b7a72-48a6-4ac3-7c21-08df11d04314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|23010399003|56012099006|4143699003|5023799004|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6uhhcSeXbWCKGbr4RTnRc80T/+FV/N/zixXIjy2ghIXxtubOjgXP12vq/zDBNdohyJD6kt85nJrcu/OJjIBLzYxUIzzqSA8+bzcOMJTVgBeJO9nIz9ELbfxf+XsHMEB+4GO9PWz3Q1K/ZLCm/Sc15P6tzYcDcTE4LNau3zUN6uty9v3KWN9QNWvJE4kXT3h1775Z1j1mFfPplIBj+s8CL5JPYlqJk1VmKRsysVZ+mPpqAD+PTXgpH358JB4PY0QG0sqVKypw6Y1/t6AriqbozzYZAPierfMENI9UMLJn5p/HIzncvgmGOEotvlIIvXPyNaGmncLq7gHuPyxCJDU/aCRK1PzGFQGu4eQ+gr7dTNs0dBuZI9628AyKKUXWhU88O0j09ixqWtPwM+gm0Bv2agTOQfIxa0c4abX5AtJWBYzLM9htuOR5fRtZSkHuyeKF/BPjuJ2pbl77SbVjvWFTQul0GC2A+QthUM4NYA1+MkmkR+GDVz8OhAJFrfzqYHWRsz7sArZOYJRk8hIcG0PY5sSyjGxAieznvnyv3kwzbGt90sls1503cc9oMkVqG5PtBzC3IDn0ZDAg2eUezT/c+wM2RGmyHxBc90TEWD4dJFAz8jLH6gm8XaA9EnLrSZDMw/i+QhYip95K7NTbc0nIKb4QaUl6X2eNHojkKf9bfkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(56012099006)(4143699003)(5023799004)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1U0Sk40Y2dzN0NMb0VmRnF1RzJIVnNDMXo0ZmJWY2x6UXJFa3NnUDQyMTVz?=
 =?utf-8?B?a3d4NzVJRnNyTi9kUm5rc1Fua1pDSnpYK2xhdmFYUmZrZmxZSFVnNHlaY3lV?=
 =?utf-8?B?dmpRQUx0bG11R2EzQzVIY1NLcHRyaWljbVBZbEJHdWZEanhrd0gzTWxEY1Z0?=
 =?utf-8?B?Si9BSHg1SjhmWmR4SzZwckNzY2dOREdwd3puM01sOG9ZV3lHazZmbTlrSTkw?=
 =?utf-8?B?UUNWU2V0Nk94TzlERVpVWHlTR0tPK09meVZwZ1hqRHZ3MnhsZXBrTnBFWVpi?=
 =?utf-8?B?L3hMMFluVEJlVTlwU1RQTUNQSWJvRzdUc3VwazhSNituelFwOURtSStHTmtw?=
 =?utf-8?B?NjVUNVRGM2hJWFd3akNFdDRhYzI2dElveWd2QkZzQ0xFZmVDK1pHSkNoNjZW?=
 =?utf-8?B?SXVZNWNzOUVrblEyRGRFT3JpQ2NodFU0Tk52cXF2TWVuSU95ZU1CRkhFRXQw?=
 =?utf-8?B?M1E4c0RYb2V5ZE1Rc0xzd25PeEVHa3p2eENTZUg0Y2RQWlV4bTlrYUdtRU1R?=
 =?utf-8?B?clprQzhiNnU2ZExscGdNZU1nMkJrVHZQbkxtWEt6S3ZsYUxibmtaQ2doL05H?=
 =?utf-8?B?QTFrRzdkQnI0SUplZHovUU4yTURlU1UwS29ibmpLRFdLOTNkN3VxSUZnU21y?=
 =?utf-8?B?U1VQMzNwT09sWjl0RTljUmZhVDlRNUxFcGZhWlViYWRsbzFpaTd4dnRUbkIz?=
 =?utf-8?B?eDNBYVc1NEd1dGdLcWl4Wk1xdzI1TUZ4NHV5akVmdGhubnN6cTRrSlRhdUto?=
 =?utf-8?B?bW5ZNjBqK0NuNXZ3TDB2akprcno1azJsbTk0d3krZ2NCY2VuTlRXcVpzK0w5?=
 =?utf-8?B?emdoMG8zcTF0di9IaWVtcmppNVJYaXQ1ZlAvYkVGc25BajBuWHJNZmhRV0Yx?=
 =?utf-8?B?V0dBeEJjL2dYSmI5c0hyV3R4Q3NXSVI2MHFjLzVDcXFSVHY3Um5ienFTZFNr?=
 =?utf-8?B?MXBzYUV5TWpJQWxMVDh2clM0UkxtSDlyMnc1bURBbWQ0ZkExVFhTS2o1ZnAv?=
 =?utf-8?B?S0Nxakd5K242ekl2UXExMmtaTElsenl4WGQxbUlQbzdEcVBzS0tsdVJtQ2tC?=
 =?utf-8?B?cGE0ZG9yTXlaS3ZJdjNNeVA0SFlNejJKblN4bEkwNXlyRE9aYUcwcFZFYnhj?=
 =?utf-8?B?VzVkdHYzd3lsNEg4bi9TTkdPZ1dzbzgvVk9zZW5xc1RwcDZ3WnphSStjZ3Ux?=
 =?utf-8?B?dm5ZaUUrZ0w0Q0V3WlU0OWQ4RWMxQXZvMTdVUTRjbE1wa0djRGd2TG5ObFVs?=
 =?utf-8?B?aFp6MGhKY1BpeEJ3UWo1QnFVK3RJcVduREk0Y0p1Y1MxZ2lleldVRnI4UktO?=
 =?utf-8?B?V2QyeEpjdm1ha2VyZTB3WGw3SFkxWTlTOGxvSkt3bXVNSFZWcUVtc2tDcWIv?=
 =?utf-8?B?L3lIeWdSUGxvQkhXQXJyRWxVclhmQngvakUraHBhbDhQZ0hzUmdFYU9nL0Yx?=
 =?utf-8?B?TW5NdFVpbXBNaTJLcUhmd0hKZnBBSjN1VFA5azZMeS9DN0dOZDdid0dJQ0ZV?=
 =?utf-8?B?L0tKQndhb1dzTHJHdVR2QUxGVHY5dExtdStZRlRTVWl0SmJTQy9KZ2QxNW5J?=
 =?utf-8?B?Nmk4M1REeGkzWlMrZFF6YitVY1J5T3JUNllDa3lLMUZPSnUyQjNDM3BNV1E4?=
 =?utf-8?B?MTVRTEZXc1RlekJUSXhxcWVTOGdyUS91bXNzVWw4VUxscGdIVTIrVlFzaitM?=
 =?utf-8?B?N3g5MVBwSGRuc2Y0Qlo3MXZEUnJZL0NHbk12Y29saUdqUFJYMndqV0RUZXVO?=
 =?utf-8?B?SmFOZ3RXOUR1WDVZVXRicnZSWUFNZnZsZmRxVnE4ZElQU2RkZWNISE1kV3hY?=
 =?utf-8?B?TGFCVVVoVkJNaW5pVDcwL1VoRlBDbWp1ajQrZDg3WC9QK0JlTXhPUlZndWhK?=
 =?utf-8?B?QklxWU1GZXJvN1YzRjhTaTM5SjZNVWVBTUlCV2Vwd1dFUmF3ekxqeU83T0c5?=
 =?utf-8?B?b3B5aHRoTFRJYzRaaGJITzFCSFlra1I2TEl5MzM5dWlzazhkcDA0aktUeWM4?=
 =?utf-8?B?WFg3OGsvMkRMWDgzOG9jN2I5azNBRGg1RlJ5TTl6SCszSXZaZ0hxdzQxUVJ1?=
 =?utf-8?B?Rlk4MjhhcUh5cjlzKzlTWGxWaUp5cVJjMkw2K0t2M2hNVjFHTGQzaUN0Z1l2?=
 =?utf-8?B?NTZOT1hIOExKQUNJK2JWM1N5TGgreXRITkZqdk5YZ0dRM0kxd2VnK0EwWXJP?=
 =?utf-8?B?cnpZYmlqaDdJK0VOTXhyUWlaRTAzVVFYbmlxb2lkZlh0UjJ3SHhIa0tIazg3?=
 =?utf-8?B?YjNmdUNoS3pJN0FsNW9zdTJBMlBNYzNCTTFvUGdRbzNiay92bVk0Y3hiU1ZV?=
 =?utf-8?B?MytmRnlIekh4UWdCTmxvRzIrM3ZXMUpZY0JqdXhlQVdTVUpPaW93NVdIOWlK?=
 =?utf-8?Q?G9zH0h4rq6DoTRFQWXq/rKr/Kx7WaFS4dD+ko5t1G5U4K?=
X-MS-Exchange-AntiSpam-MessageData-1: RLC1B/dJ4A2fYw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9b7a72-48a6-4ac3-7c21-08df11d04314
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 19:50:28.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfmR1Y7P4PAIdkawrjGL46/IA50p5iBCNx9UlPgXdDNS63KuB0YIJyB11EvZYHwcnLGPLR3FdwnsVpS8cAqRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB940098
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

(first, but not the least sorry for late reply. It was really
strange that I have come back here several times to write
it correctly. Hope this will answer to all remaining questions.)

On 9/4/26 10:49, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> From: Denis V. Lunev <den@openvz.org>
>>
>> Nothing tells which persistent bitmaps an image carries. qemu-img info
>> says nothing about them, and the only other way to see one is to export
>> the image over NBD and ask for a bitmap by name, which needs the name
>> beforehand.
>>
>> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
>> in the same way as qcow2 reports the contents of its bitmap directory:
>>
>>     Format specific information:
>>         bitmaps:
>>             [0]:
>>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>>                 granularity: 65536
>>
>> For running VM process the list is built on the fly from in-memory
>> list. This is the best we can do. FormatExtension could be dead in
>> the image while VMs are running as all bitmaps are cleared on
>> non-clean VM stop.
> What's "FormatExtension"?
Format Extension is the area through which dirty bitmap is accessed.
For now this is catalog of extensions with the only implemented
extension - dirty bitmap extension. This is specified in details in
docs/interop/parallels.rst, section "Format Extension".

>> A bitmap of an image which was not closed correctly is inconsistent
>> and can not be used. Report that as well, the way qcow2 reports its
>> in-use flag, so such a bitmap is not listed as a valid one.
> This is helpful, thanks!
>
>> The section is left empty for an image with no persistent dirty
>> bitmaps, and an empty section is not printed, so the human readable
>> output of "qemu-img info" and "info block" is unchanged.
> Perfectly clear now.
>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  block/parallels-ext.c                         | 26 +++++++++++
>>  block/parallels.c                             | 20 ++++++++
>>  block/parallels.h                             |  3 ++
>>  qapi/block-core.json                          | 46 ++++++++++++++++++-
>>  tests/qemu-iotests/tests/parallels-checks     |  6 +++
>>  tests/qemu-iotests/tests/parallels-checks.out | 19 ++++++++
>>  6 files changed, 118 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>> index f687f2da7c..8b8035af91 100644
>> --- a/block/parallels-ext.c
>> +++ b/block/parallels-ext.c
>> @@ -736,3 +736,29 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>  
>>      return ret;
>>  }
>> +
>> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
>> +                                    ParallelsBitmapInfoList **info_list)
>> +{
>> +    BdrvDirtyBitmap *bitmap;
>> +    ParallelsBitmapInfoList **tail = info_list;
>> +
>> +    *info_list = NULL;
>> +
>> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>> +        ParallelsBitmapInfo *info;
>> +
>> +        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
>> +            continue;
>> +        }
>> +
>> +        info = g_new0(ParallelsBitmapInfo, 1);
>> +        info->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
>> +        info->granularity = bdrv_dirty_bitmap_granularity(bitmap);
>> +        if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
>> +            info->has_inconsistent = true;
>> +            info->inconsistent = true;
>> +        }
>> +        QAPI_LIST_APPEND(tail, info);
>> +    }
>> +}
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 2a5ceb8978..e7d65d0458 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1624,6 +1624,25 @@ static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
>>      return 1;
>>  }
>>  
>> +static ImageInfoSpecific * GRAPH_RDLOCK
>> +parallels_get_specific_info(BlockDriverState *bs, Error **errp)
>> +{
>> +    ImageInfoSpecificParallels *parallels_info;
>> +    ImageInfoSpecific *spec_info;
>> +
>> +    parallels_info = g_new0(ImageInfoSpecificParallels, 1);
>> +    parallels_get_bitmap_info_list(bs, &parallels_info->bitmaps);
>> +    parallels_info->has_bitmaps = !!parallels_info->bitmaps;
>> +
>> +    spec_info = g_new(ImageInfoSpecific, 1);
>> +    *spec_info = (ImageInfoSpecific){
>> +        .type = IMAGE_INFO_SPECIFIC_KIND_PARALLELS,
>> +        .u.parallels.data = parallels_info,
>> +    };
>> +
>> +    return spec_info;
>> +}
>> +
>>  static BlockDriver bdrv_parallels = {
>>      .format_name                = "parallels",
>>      .instance_size              = sizeof(BDRVParallelsState),
>> @@ -1653,6 +1672,7 @@ static BlockDriver bdrv_parallels = {
>>                                    parallels_co_can_store_new_dirty_bitmap,
>>      .bdrv_co_remove_persistent_dirty_bitmap =
>>                                    parallels_co_remove_persistent_dirty_bitmap,
>> +    .bdrv_get_specific_info     = parallels_get_specific_info,
>>  };
>>  
>>  static void bdrv_parallels_init(void)
>> diff --git a/block/parallels.h b/block/parallels.h
>> index 27d8c3ac83..012f47320b 100644
>> --- a/block/parallels.h
>> +++ b/block/parallels.h
>> @@ -32,6 +32,7 @@
>>  #ifndef BLOCK_PARALLELS_H
>>  #define BLOCK_PARALLELS_H
>>  #include "qemu/coroutine.h"
>> +#include "qapi/qapi-types-block-core.h"
>>  
>>  #define HEADS_NUMBER 16
>>  #define SEC_IN_CYL 32
>> @@ -111,5 +112,7 @@ parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>>  int coroutine_fn GRAPH_RDLOCK
>>  parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                              const char *name, Error **errp);
>> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
>> +                                    ParallelsBitmapInfoList **info_list);
>>  
>>  #endif
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 199efc1e00..7499aea641 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -188,6 +188,35 @@
>>        '*extent-size-hint': 'size'
>>    } }
>>  
>> +##
>> +# @ParallelsBitmapInfo:
>> +#
>> +# Parallels dirty bitmap information.
>> +#
>> +# @name: the name of the bitmap
>> +#
>> +# @granularity: granularity of the bitmap in bytes
>> +#
>> +# @inconsistent: true if the bitmap was improperly stored and cannot
>> +#     be used
> I'd recommend "if the bitmap is in an inconsistent state and".
Ok

>> +#
>> +# Since: 11.2
>> +##
>> +{ 'struct': 'ParallelsBitmapInfo',
>> +  'data': { 'name': 'str', 'granularity': 'uint32',
>> +            '*inconsistent': 'bool' } }
>> +
>> +##
>> +# @ImageInfoSpecificParallels:
>> +#
>> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
>> +#     including the ones which are not written out yet
> In review of v6, I asked whether "not written out yet" relevant to a
> user / management application.  You explained what it means, but didn't
> actually answer my question.  I failed to point that out then, sorry.
> Can you answer it now?
No. Dropped in v8.

Right now the main pattern of usage of Parallels image driver
is working with existing images, which are still available in
some places. In theory people could start VM directly from these
drivers but this is would be very strange story even for me.

Thus the following patterns are to be supported as the first
priority:
* qemu-img check
* qemu-img convert
* qemu-img info
All these commands opens images by itself and handles things
by themselves. That is why QAPI change here is collateral. It
is not possible to show ImageSpecificInfo without this change.

Nothing here could observe the distinction.

> I also inquired about the relation to ImageInfoSpecificQCow2's @bitmaps,
> and you told me they're basically the same (correct me if I
> misunderstood).  I then replied that the documentation should be
> basically the same, and you agreed.  Did you forget?
This is my fault and I have missed this is the v7.

    # @bitmaps: A list of parallels bitmap details

without the "(since ...)": qcow2 needs it because @bitmaps arrived in
4.0 while ImageInfoSpecificQCow2 is Since: 1.7, and
ImageInfoSpecificParallels is itself Since: 11.2.

Also in the diff: the struct description lost its stray "dirty", and
ParallelsBitmapInfo moved next to Qcow2BitmapInfo, out of the
ImageInfoSpecificFOO run - the v6 ordering you asked for.

Thank you for your time,
    Den

P.S. Can you pls drop 2 words into thread for
   
 https://lore.kernel.org/qemu-devel/20260824133729.1141990-1-den@openvz.org/
     If you believe that proposed API change is no go, I'd go rewrite
     code with online 'check' command. This problem is real and the
     damage is very big, which is not just single cluster lost.

