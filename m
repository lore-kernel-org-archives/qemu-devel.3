Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E64C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 10:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfH8J-00041S-Gt; Wed, 28 Feb 2024 05:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rfH8D-00040z-Ml; Wed, 28 Feb 2024 05:25:45 -0500
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rfH8B-0002ul-4e; Wed, 28 Feb 2024 05:25:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKV8JnSQ0l/qG24RdeZAfkuRs8DzKCj7E5ayJ8VirU2UnGp/6XekOWNs7c/D6yCdwhQAtnH/2gptUU0C/0QVbsque5jd+b+SL+4XX9tVPu8IaMIThyDo5JfJNHv9SdXEa7zj2oHTOaQfxWV1lf397XSqdscPmHScVgMPGI8HSEnJJDlrTfBugcL73SVz2MHwpcmpQFWxmjVbbpY2DHalvYQ+jpswhgWkwupMYB9E9QA3Ef963vYEYdxR1x2eoVKue3kzPpvKeKFiZLkYQiZmlfWIN0XUQ0wKEkNeUc/xQ9pRCO+5QyI7RsbDXjlKkmFe/t4QrxmMAojAdDxdrW61CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkuVm1/q7f/IfDsEHpEHPLDsh8LbilGteOvM5IAckUM=;
 b=WAjiLuI6Myn1RyzwLIDV6F3WsDzpfb+smFgdb7Y/pYxqDs7Ye8MukY4kHOnHU8Mz7oKoJHTIZkPPKXqdjqBOTIZJ8h6aUYmDM8t3bEtbvmewp0h43z00tXD8PNItzAzSdShNJLPjV9piHUT7xZwHHhirV9NBX6LoiUwcUVF2eURcsxzvTGXmXZjQqXb/BslCPZAp2VbSkLN1gWJ2uHgclPOwkTQnv2muDZnrPvuKDA3mN15QDHrmXs11cdhIHEF4CfRG0DUuWioAY+DsdbcHO9I8w/5up2zaQ4lJSQRUaq5KAnaIRV/jqmsgRGwI0QK88cMQi7emRS0OUDCbV+7eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkuVm1/q7f/IfDsEHpEHPLDsh8LbilGteOvM5IAckUM=;
 b=aOtngFs5qwZVJyjafWEQRCpQF/RAkA15YH/ScQ9FzBBZHb4ajOgbLwkf8+QH3rG7M57CN67biR6gIw0L9IIZUntgjMPbgYGUhaoq0l/ijOiBGHGRPiXO9JTQSSuF1tNDwFQAl0tcfXltGPQ2uwynm8MOsSSB+s2mBJYDXFyfW81cutFbw/pe5epBEWNzE+GfU388bc7LWs+3RNaZY16Woh7t0PrmoD8jjepTLB5B3EfVZ3U61EaAXUg260k0E1KTCi0kSNfYQOtyHl4XYv6BBl1tS9XrgAMJ50JuIL5v1d2JPpvMHWqVcGRF4x7jKeyxz2yrlJ/lAKw7tztzcEuaZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6206.eurprd08.prod.outlook.com
 (2603:10a6:102:ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 10:25:36 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 10:25:36 +0000
Message-ID: <42466483-7583-497d-89f5-cbd447f5647e@virtuozzo.com>
Date: Wed, 28 Feb 2024 11:25:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/21] parallels: Let image extensions work in RW mode
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-13-alexander.ivanov@virtuozzo.com>
 <a9791fbd-e07a-4757-bb54-b4283bd7f4ad@virtuozzo.com>
 <99fd7075-fd25-4ccd-806d-6d2c0f3e33f0@virtuozzo.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <99fd7075-fd25-4ccd-806d-6d2c0f3e33f0@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: de56691a-9265-455f-0f55-08dc38479a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u92F0Q7bUECxDFLoWrcG3J5CRvgx2TnOUrLXzm8eZt8LpVTHC5WzAjMsAMU1d9gQRVP+CpxGW3BzONX08N5rhGMSJqpv9VT+RelKJWsEBi59WAjcj3hG4ig1lC7Cp6V63fx8CDSRdbT7X2u0kxM2ZZEcfH5H2GNX7vC04808njBiq7Hrg5jFzpb4W1MURC+OmsyNz4rQ3eaMwns2gsVSmi7nN7QKqg0cWrCkHonrsLRsO2UrUs+PYe3nZuezcwiGdVY/oGcdBxHOqtiHi19Uf7jLhGLpcPo1HZRupQyODXXSdZ47cB1ePlinwielUNwl4E1fMoCxxcJZwnBwypT0/stgE1bhfB3PskpKpB0lW4Hsa7puDZbUBcUo2sd6qTMbP4f4LM3x8G+CaHoU512E3QH5uy9sHOmVm+s8cXdf50lVU3XNNpNvQaI+A8VewwD2wfTOtGStTM18gP63mbWHXpQqv+yaHJ+PCl8+Ro+kSyC10TIssMJ9yRPs8DJvqJQkKiOntQYeSj3Puc/38dRKB/eIVRcUmzckU8pUA2VZdw9ByhN4vqaOao32JShgvslRDC67Pm3CYqx2z5288f+CQKAPGzCLPPYYoZSx2jTTJVuFPb3/GiBu1wbmFN2wwEpBPzxUFs3ATKeLzaB9HrnJTSpCPjpI5J3yu62Q1JIj1Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzBYcTd3ZW1ybzg1N0xETUdDUGxLeVpOZmJsWDNza1dFVTd3UXVBbjMrSFgw?=
 =?utf-8?B?V0Q2ZkRNVk5xbG52UHUzK0ZyRlFZVldJL08xN2dqZElYZHpTeXN0aFQ0QTc2?=
 =?utf-8?B?cDN4TWRiVkFsQ0M3Z1MvWDc0bVZvSm5vU3pwWTFpVHZDdWdUTW90VEg3aHAx?=
 =?utf-8?B?dlVjVG1Od1U3c0thaXBCME03WDRKTmlZVlF2NlQ0Q05TZHdmV3pveHhlOUh6?=
 =?utf-8?B?NmJPSFFJMERvemdTRFRBSTl6U2c1LzlxYXJTUEJZRGd1QXdlQStCTlpRdExF?=
 =?utf-8?B?TkdWTkwrQkNmQzM1NWg1RmpPR0NFL2FyWG1pZURRckZMdDNubEJNWDh4djUv?=
 =?utf-8?B?UDR1WUxYTXl4L1hoSlRxOGlVRnlMTHNqNVQzeEJWYVhzRTBidDJFVm9HTUU1?=
 =?utf-8?B?bUJGSDIzeXVzVGxBSTNrZHFIdW1rL2puaFJNL2VlOEU3UXp0UU1GSktjRUVU?=
 =?utf-8?B?TndYV0FmbjBWM3ZUR2tlZmVQR2IxYktyRTdjeTFoZUl5VUtBWTdYVWx0RHB3?=
 =?utf-8?B?MzZvb1hnanZjNW1JM2tRSE9qeE84NjRnYzlVQURkQUZUbnZTWS9TWWRhckpj?=
 =?utf-8?B?ZWRlQXdBdk8ya1U0NkVTeExwVXpvMEVtdVVDNHdnOEJpaGw2YldTelFwZjMv?=
 =?utf-8?B?SVYzaTg4M0pBOEZGblJPSUVQTmlEMlM4ck04VDRTc2gyTUZ5VVRsbjVPOUxW?=
 =?utf-8?B?aUpxM21JTUUzNllMNjhiRmFsR2tpN0ZFNnQ1VC85S1B3TzhvbXRIV3Fydkhk?=
 =?utf-8?B?Q1E2RDdQR0UyZHJobGZOcmhtcUg2YVVCOVlBVXdOQVhJUWxlTUJpMmJMUHJi?=
 =?utf-8?B?VWo3Yi9ib09tNGZ1bVlDNGVXM1p0a2xDcENBV1FFSlJ0QUVnaG5scGRhdWV4?=
 =?utf-8?B?bTZQWFllQ2cyZ1hzeHN0LzZCY2RiQ3Z6TEFxSjJvdStPb05ZWGVFUHVsTDFY?=
 =?utf-8?B?Rk5OVThrNXVtR2RNWHFKQkNCS041NTNveE5vYk80cVBzNVdablV2Zk1XTk9W?=
 =?utf-8?B?NVhtcXhvdUN4WGJjU1RlVW1FZzdTcm5oK3h1bk9KY0VnRzB4RE5iT211YWh5?=
 =?utf-8?B?MjRndjRvRS9GMVhERVFyNktlNnAvRGY2U0dBZUw5MGRadEdUcktqOEZuWldF?=
 =?utf-8?B?VkZqZE1xTUx6RWZzcWJ6aWczNlh6Wk1sbHpXRkVWMHFXN3RhdUtOOENuVXB1?=
 =?utf-8?B?WFA2Z2VqTVFVVEhlSFh2Rm5rcHRTY015V3YvRDdyZ1FMS2pUa2JsOFErbHBB?=
 =?utf-8?B?M1lCQWRDRmF1QjhFV3J1eU5iNXB0cWdXbEh5NU53blVhTDNJa0xpSXc2TXZR?=
 =?utf-8?B?bUQyZFk5bUt0OXpUZU9FTU9uRTduTDdWcUFwZXdva2h4QTFIQkZsMk11bldM?=
 =?utf-8?B?aFhqUHJqZndNRzZrZlpCMEMrYTlYd29TMUF2MzBtaitpb1ZJWlcyMmxCdG56?=
 =?utf-8?B?cjRwMjd6cllqZEJVMzdhbjZ2bzVCR0szSnc0c0JIKzFTYzdsZzVCU3p3L2x4?=
 =?utf-8?B?UE40SmdxZXk2SURwUTlwL2dXbEhvMFprSEd6MHljME1QMlB4enhTdUZXendM?=
 =?utf-8?B?QzZ2aVF5VHdTcmhnRUpqd2VFMUJsVURKUlVtdmlSR3FEZjc3ZDlRU1hGaUFz?=
 =?utf-8?B?VXZUTHo5eXN1SThPZGtvdGFUUHd4eFhubnRFQlJGbGZiR2NKeUgwVkxkVzRm?=
 =?utf-8?B?aUNpUDBtUng4dENWRlQ0NUQyYU1QNnRYcHBVVlRtZmozbGxiSFltVGlEQ2R3?=
 =?utf-8?B?OS9KbTRqTDdlWjR0SlN0Y3JpZ1oxK2l3eDgyK1dqaFlsTW9QQ3BmTnEzdm5r?=
 =?utf-8?B?NWs4ejdlQ1NJMnA5V2d5NWExZG1pa0VTZUdlZ25MNDl0cUV1TUJrT2lBTW9G?=
 =?utf-8?B?bVdMRnVzNlp6V2RmQzFwY3hNWmJIdE1VRXMvVXgveHZndDY0NlRqaG5iZmww?=
 =?utf-8?B?dHE5VWtOV0Y2dm5VOWJxY3ppeU1yWFlPY1Z2RUJISVVqQ2p1VXVVdUJzQ2R2?=
 =?utf-8?B?cDVXRTFsY1R4Y0ZuOUpnOHNwSUxPYzR6S1ZBN0VkK05RNFVmWEh4N1hOS1Z1?=
 =?utf-8?B?V0QrWGxiek5aMzFwTTZpbDRTTkJXUStJTGxqVER1dXE1YlpLbnlwY3RTRVhj?=
 =?utf-8?B?T3MzZjV3dnFHT29SeFRlbnJqK1JyaFVkalJRcE5qMmljeXlwSXY4RzZTZi9F?=
 =?utf-8?Q?dOWWIc8X0rpOQtRgdVsLEzE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de56691a-9265-455f-0f55-08dc38479a54
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:25:36.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOcQtJf0WGZA2G20KA6kURdb05YA9KiqmuCdBDiaGR2XDfLOv8EPey00FrM1G0YMgYcfSVemCEcDrD9+vwrFCjr8yqc7jQOoT1B9BBI6um0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6206
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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



On 1/18/24 14:31, Denis V. Lunev wrote:
> On 1/16/24 15:45, Denis V. Lunev wrote:
>> On 12/28/23 11:12, Alexander Ivanov wrote:
>>> Now we support extensions saving and can let to work with them in
>>> read-write mode.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>   block/parallels-ext.c |  4 ----
>>>   block/parallels.c     | 17 ++++-------------
>>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
>>> index c83d1ea393..195b01b109 100644
>>> --- a/block/parallels-ext.c
>>> +++ b/block/parallels-ext.c
>>> @@ -175,10 +175,6 @@ parallels_load_bitmap(BlockDriverState *bs, 
>>> uint8_t *data, size_t data_size,
>>>           return NULL;
>>>       }
>>>   -    /* We support format extension only for RO parallels images. */
>>> -    assert(!(bs->open_flags & BDRV_O_RDWR));
>>> -    bdrv_dirty_bitmap_set_readonly(bitmap, true);
>>> -
>>>       return bitmap;
>>>   }
>>>   diff --git a/block/parallels.c b/block/parallels.c
>>> index a49922c6a7..d5d87984cf 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>> @@ -1374,19 +1374,10 @@ static int parallels_open(BlockDriverState 
>>> *bs, QDict *options, int flags,
>>>       }
>>>         if (ph.ext_off) {
>>> -        if (flags & BDRV_O_RDWR) {
>>> -            /*
>>> -             * It's unsafe to open image RW if there is an 
>>> extension (as we
>>> -             * don't support it). But parallels driver in QEMU 
>>> historically
>>> -             * ignores the extension, so print warning and don't care.
>>> -             */
>>> -            warn_report("Format Extension ignored in RW mode");
>>> -        } else {
>>> -            ret = parallels_read_format_extension(
>>> -                    bs, le64_to_cpu(ph.ext_off) << 
>>> BDRV_SECTOR_BITS, errp);
>>> -            if (ret < 0) {
>>> -                goto fail;
>>> -            }
>>> +        ret = parallels_read_format_extension(
>>> +                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, 
>>> errp);
>>> +        if (ret < 0) {
>>> +            goto fail;
>>>           }
>>>       }
>> Reviewed-by: Denis V. Lunev <den@openvz.org>
> This patch also deserves a note, what will happen with
> format extensions clusters. According to the current
> policy, we have only transient extensions, i.e.
> CBT. Cluster allocation mechanism will reuse these
> clusters as they are not marked as used.
> Thus we should either set format extension offset
> in the header to 0 or perform any other correct
> measures to properly handle this.
Yes, all the clusters used by extensions are marked as unused
on loading. In further work they can be reallocated for other
purposes.
Agree that we need to set ext_off to zero.
>
> It should also be noted, that on any QEMU crash
> appropriate format extensions are to be properly
> treated. We could not make them RW until this would
> not be addressed as we could easily mess up with
> trashed metadata.
If QEMU crashes after extensions loading there will be
zero in the ext_off field and an inappropriate dirty bitmap
will be ignored.

-- 
Best regards,
Alexander Ivanov


