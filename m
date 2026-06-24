Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D1CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRkF-0004HF-FZ; Wed, 24 Jun 2026 13:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcRkD-0004H2-IZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:50:37 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcRkB-0006Z2-HX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFTtPZGJK2jZd0WglQgONnhM3EllZG4uGODgrZFxhgI8WUOudvfvqqUdZA2pXAp4Nuuymgg6KoJ/xGtPoflhAGr+bhm9nL5yXmb1W+Uomvf4hbZQQrfuvyNl655KGOt8HCRDUhe+7rEijEGViNcfn0V7LlFdt0NRXu/R8zbICeqgYZISf57LjQIGp7AlCHY2FczGVEURkcpauX2QKgfumz2IQSC2Sa6E1YQXFGDwalBWafZrFM85mJextS9ePOfb9Miel38+QE189VlrIh8PJtmTuACilbitcGsc2gVQ3F+o9khMXWT1UWVH0buxwAm6gocoSbiBStUFxVNCJGIRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIJSYpUxtJTQIv9e1WAkDpS2/55Z0JVZfhT6VYW8WPY=;
 b=SNE7qBbQyKShKPRDpYwDvOY483rKPq8SX4sb3zHsLxg9cqrLM5Wx0WRK9O7/bs6vjEUOmUKc5gC4zd865wDYXUwuJrdZerAQqAMwZpFiKD0OzVe2NCfKqxAYDEeQ9UDFFSQdHVrug+9IH1P6iaIEJeYU2GZPdeRFB0MQcddgrddw/oTId0QVIrCZrofdEA26/oxhzKvgiMN98W224LxBIhfe71IAGZJHBQWz8taGGu7nY93g5ULNLOMXa0TUoJXUNwTYt0j0vEqZ/dzNS28ozGGr8wR35HTg++yruYvWZU2bVOba5lGR7aozRLFWwdsH+Jrsxe4MJQ5XI94W77324w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIJSYpUxtJTQIv9e1WAkDpS2/55Z0JVZfhT6VYW8WPY=;
 b=n8y1EIQ7qNuYfL5LfL5LABnKKkZdb1734W+95MNbmyQ89KZVObrZaQcHyfFjlWm+aFgUjyLswh0aumSwWOH/MkHjl6uDyzXRP6HZgzKyUdMCr7GHzAie+fsM3nWgWeD8A27inOY364OFs794naJd8LCWEGfuB5Rj6V23ajPme/i9jPv1IABmmGxJX4h2v7B0tclACgzecQGomyxHtGKUvFjWuzpfdUdfXW/ERQRDxe/wdaDdKoy1GgdFf5AawLWc2EMjz3nWrlZ45mV2w6IaFulB37NmANrfZHx9CDMR/aPl/AAJzEpf/omuWdK4WWb3rJebHxl6zHmtCMZ1/RqFVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MRWPR08MB11681.eurprd08.prod.outlook.com
 (2603:10a6:501:93::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 17:50:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 17:50:29 +0000
Message-ID: <d4ae743b-3569-48f7-81c4-b09323dfec54@virtuozzo.com>
Date: Wed, 24 Jun 2026 20:50:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] vhost-vsock: preserve vhost FD during CPR
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, peterx@redhat.com, dongli.zhang@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <20260619105514.128812-5-andrey.drobyshev@virtuozzo.com>
 <82e01e80-f65d-4f38-b475-5f5624587868@maciej.szmigiero.name>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <82e01e80-f65d-4f38-b475-5f5624587868@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MRWPR08MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f6f484-792f-47f2-6533-08ded219149f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|7416014|366016|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mArUcgeJlJb7Gy2Yi2XeE5FOJrV9asYj74d0/WaBidqy883MG3MR9DiKFnW4uKyf27PeqfmHnD4RSCoTaqQp7j3Kb+D+QuXEy4SAQ73OTB3VrIp4vT0FM8Vo4n3f1lBtNpdY5tQD/WcKAPLVEdDaKbTWKJ9yrHZJ3IoSRhML6r07pM9hIHlUYC1A8z+WP+vKQqZ57CZA5tekPWugv+zBZf6R8NXq/0d67t2eWxklqnKeu70gxeysE4gG33aOGPGa7/V7VCB7RMKcurVaGBltlg81D787birX04HI4RwwJqaUna5RLD0yV5GtJetjui+a04oUUndIQx+QixJTlaJ7WHLb/tqIUM4wO0sE4d3We51oCHzIVIXoGjOnwcu5xD94ZLw3aD/Q006iZnaSi1C+3hF5LfHkasi7eT47rcAR9aBUGkEV5g/YmQB2QRJPizEbIozg7p9nwXaVCzM1TlpOY78W/F3ldAAKtx27q9GOXbDdBNApKQzdJFQVJ1RkAY0k7U4JPfGZORTm6CLNpjzYqoU+oeTTjbIxrT0i9FWJILDxviov/UgmQL0R6sDfkSzSPBweBmiEyhk0WRClPtW9Y5JkOAiZ8udFDO5oQtAJwnRETddnWXrpBOdY+PkNcAM/cC1mUJY3bGGfke27Z8jwlKD6hnNpE7q0N8Z+z4DwMl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDQyUFAzNHlkQnlRSjE5Wk9HY2VIV0hiUGhSUHN6b3RPcmMyTno3aXBlZ2Fu?=
 =?utf-8?B?R2RDTmp3Snd1Z1ZWOFZTc1pOdDVjYXBLWURwUGtvcU0zSTlMcHQwdUYwWDJL?=
 =?utf-8?B?dXFiNVNPZ0hya3JTWFlHUE5udHBMVE1SdUt2ZFhUYWZWcWRkTk5jMkJxVjZB?=
 =?utf-8?B?S0RVaWdNNnAzRitpQnlIbCtJa1RHd3FINEdxd2MrMFYwU2pqaU5DN0pDZUEy?=
 =?utf-8?B?bTIwejJjSUlQc1NjT3M4TjdsYjVGSGJ2VGd1cHF4cmtxYjBMdDVnSDFSTUQv?=
 =?utf-8?B?RWdrb2Z6cHBvU05SUW5aUTNXUmhiMjJxS3k1b0hxbkUyTmtwbmZoSEtFUFNZ?=
 =?utf-8?B?K0RaRG5iR3pKU0hoZDZFZlVGMHUramdtQ0Q0bkpLVk5KZWNiNmsyZlRoODJV?=
 =?utf-8?B?cWNSMUpLNVA2SmtiNmx1VXdTMHhwZzJ4eHAxSUV6d09Deno0VTNnYStRSXBG?=
 =?utf-8?B?bTVnRUk4TGM0cDB4WW9wUEcwZ2xIMC9DSE1LNEFXS2J6YUhJTGp1ekNpODg3?=
 =?utf-8?B?RFN6SFZ4WHg1cTY1TWo2UVJTa1pwTXU0VFBJb1RoelI5L3g2YUEza3NQdi9F?=
 =?utf-8?B?ZlNFOWNyVHFxd1NqYzc0TEtFQVhSUUNtTlo5RXEzblVYL2JpWTRCQ1ptNFJB?=
 =?utf-8?B?bkNLVXNTYUwzajRkaWJvcS96bHc3cVNUakFSVlpES2JKcFBZcFpvVVNGL2FM?=
 =?utf-8?B?R0RWUTQ1QnlKR3hUMngwUzA0RzJ3K2Q3bmJFN20vZ3gyNXl4Z2MybnpBNmEy?=
 =?utf-8?B?aTYxVjZCNnlQT0YvVWlvbG9uQm5rMURTMFhLRTJzN0lVcVJjc3FZbzZMRUVY?=
 =?utf-8?B?NUErUVZSWnVBVUZUVE01NFJMN09vVTdFb1ZxR09rY1RkdkRmQmN1ZmxrcTd3?=
 =?utf-8?B?UlQ0WFVyTnVGSzZ1OUhMcGZUS0ZCUzltL0h1enlndnJyOG1TdFg3NWRIVGJD?=
 =?utf-8?B?OWwvbmE0dFdqQ3daeXA1RWdmNVBWQlBIazhOREt2VUNyYjF0Rlc1bERoZm53?=
 =?utf-8?B?NmVnUzZWckRTV3IyRVpWdmRVV2xGTlBFSTROWUU2MjVxQkFmeGR0N2R5alU5?=
 =?utf-8?B?QVU2cWc4dnhaRFBPa0lPTERrOUlCVzhHM1hhR1dLUFBiblkyQ3RsNWFsbHJh?=
 =?utf-8?B?cHNxNjZYeW91a3U1WW56YThTT3lwSVRETFdWNjRrVndxakZFT1RaUDMweHJY?=
 =?utf-8?B?alpkTFJwMmtKbzBINGQrRTMwUnZRSjVYZ25xTlNCL3pFVjVSa0FIdWxoTVVW?=
 =?utf-8?B?Uy9Fd210dU0ySzRRRlVqeldqbjBxcTBTSjA0TWQzc2pEWnJrTUhZVng1QUMz?=
 =?utf-8?B?Ukl3cEFMMDVxd1phNllEdmV4dktueGMrakZDMVZQdnlHcVlsdm8zcFgwSmJC?=
 =?utf-8?B?eDcxb2VvNXk1YUR2SnRaM1poMjlXZ3NXVS9xTmxrOGpWNWgvLzdWZFlKTlha?=
 =?utf-8?B?MC9XVHM4RDMrWjJhMThDQ3R1UU50ZGhYZFlzWHdSZHRORXVnNUk1em5TeTkr?=
 =?utf-8?B?RVpORHZ6NGJidTFKZndRQUtjcDB4VXU0K2tTblROcmMyNGprRDR5OFhQdVpG?=
 =?utf-8?B?T0dlQVl5Zmlkdy9hNnIvYTVMNXVhbDQrMldyeGxSWm54aytNMlMrSHc0aWsx?=
 =?utf-8?B?M2VsNTVlVldHTHo4ZU1RUjdmNDBUQjhLN3p2V3IvUDZ5Q2VKdlhCZWk2emZ1?=
 =?utf-8?B?d2ovcURnOXBmRU5hd2NjaFU2RllPSmpWamVJYURMT2g5VmNobnZVenR5c2dm?=
 =?utf-8?B?MUNERmlFMElHWjllRGtqb0ZTaEF5N2xxMWNqVnBkSWRoQ1dWZzZQZ3k3Vlho?=
 =?utf-8?B?c29OM1hvRmNkUDZ4MnVIMG9TZk9lVlh2aE9KQkFjRm51cUo5WEdRRHZKV1VF?=
 =?utf-8?B?azkyd3RlU0gxZnhqUE0zd0xHYzg5QjFGbmFFb2tCeVI2WFFhWmF1SmY1TG0z?=
 =?utf-8?B?VlZJdkNTbWhiaUhESDExaEpVbnd2c2RpVFl4WXNhV0hWdWlsRHpadTNndTY4?=
 =?utf-8?B?Q2paQjUwdWp0OE5pYzVUU2pJRkxuT1pBSEgzRzE1eW9kQ1p4RGZWcTNyamo2?=
 =?utf-8?B?Q3AwYktRRklrUmIxTXRkYUJTL2FKYjJhVHFNZ1MxaFoyRjVWdENkaXNYeFdG?=
 =?utf-8?B?cjJrR2tHbnFUaU1FMWpzeE1jK1kxU0p5UlBTZDlwUmVHb3V4bDFSUk9BTUxj?=
 =?utf-8?B?ekE0eERGTmJvT2R1YklWd2FYL1VQK3RjZXpOYXcvWk9RUzRNbTIyQXNZYXFE?=
 =?utf-8?B?S0k3b3VuaFhJcHlPbCtqYzRNWmIxUWFJWFM5MDRJU1dUa0NKdkZoamVRSHpB?=
 =?utf-8?B?d3RhNk1NdVVuVS9vb0JuRmk3M0FvcHJxTWJrQkVnc0RoWndaemtQOWtmeVdO?=
 =?utf-8?Q?aWok7bWdoENEbYJs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f6f484-792f-47f2-6533-08ded219149f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:50:29.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQOt5maY57/wz0JB1J7Fl2g9eSpbs4qw98xwvL5qeGq+3mJlB1Enk/8fkTWbWk8v/DT9hYDSQiuZRmnv0A3sUN8tP2YrioMmA4CYXU7Nzjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11681
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

On 6/23/26 9:27 PM, Maciej S. Szmigiero wrote:
> On 19.06.2026 12:55, Andrey Drobyshev wrote:
>> During CPR migration, instead of reopening /dev/vhost-vsock device on
>> each initialization, let's make sure the already open FD is preserved and
>> properly reused on a subsequent initialization.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   hw/virtio/vhost-vsock.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index da244eb1657..ea9a7d2149d 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -20,6 +20,7 @@
>>   #include "hw/core/qdev-properties.h"
>>   #include "hw/virtio/vhost-vsock.h"
>>   #include "monitor/monitor.h"
>> +#include "migration/cpr.h"
>>   
>>   static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>>   {
>> @@ -126,6 +127,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>       VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>       int vhostfd;
>>       int ret;
>>   
>> @@ -141,7 +143,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>       }
>>   
>>       if (vsock->conf.vhostfd) {
>> -        vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>> +        vhostfd = cpr_get_fd_param(proxy->id, vsock->conf.vhostfd, 0,
> 
> Is this proxy->id *guaranteed* unique in a QEMU instance?
>

It should be if it exists.  But it may not, in which case we'll crash on
cpr_save_fd(NULL) -> strlen(NULL).

I guess we might only cpr_save_fd() this device conditionally, i.e. only
if it has ID set, and then add a migration blocker which would refuse
CPR for ID-less device.

>> +                                   errp);
>>           if (vhostfd == -1) {
>>               error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>>               return;
>> @@ -151,10 +154,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>               return;
>>           }
>>       } else {
>> -        vhostfd = open("/dev/vhost-vsock", O_RDWR);
>> -        if (vhostfd < 0) {
>> -            error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>> -            return;
>> +        if (cpr_is_incoming()) {
>> +            vhostfd = cpr_find_fd(proxy->id, 0);
>> +            if (vhostfd < 0) {
>> +                error_setg(errp, "vhost-vsock: could not restore vhost FD "
>> +                           "for %s", proxy->id);
>> +                return;
>> +            }
>> +        } else {
>> +            vhostfd = open("/dev/vhost-vsock", O_RDWR);
>> +            if (vhostfd < 0) {
>> +                error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>> +                return;
>> +            }
>> +            cpr_save_fd(proxy->id, 0, vhostfd);
>>           }
>>   
>>           if (!qemu_set_blocking(vhostfd, false, errp)) {
>>              return;
>>           }
> 
> So if qemu_set_blocking() fails the FD leaks (existing bug) and now also
> CPR has this dangling FD saved?
> 
> Furthermore, if calls further down vhost_vsock_device_realize() fail
> AFAIK vhost_vsock_device_unrealize() won't get called so this FD won't
> be removed from CPR - even in something else in vhost stack actually closes
> this FD during error cleanup.
>

Agreed on both.  It seems moving cpr_save_fd() to just before the final
return would remedy both. I.e. only register the FD on successful device
registration.

Thanks for pointing out these bugs.

>> @@ -193,10 +206,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>>   {
>>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>>   
>>       /* This will stop vhost backend if appropriate. */
>>       vhost_vsock_set_status(vdev, 0);
>>   
>> +    cpr_delete_fd(proxy->id, 0);
>>       vhost_dev_cleanup(&vvc->vhost_dev);
>>       vhost_vsock_common_unrealize(vdev);
>>   }
> 
> Thanks,
> Maciej
> 


