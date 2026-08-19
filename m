Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0D1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhS2-0000Vz-KD; Wed, 19 Aug 2026 10:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhS1-0000Vo-8u
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:33 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwhRy-0005AC-Pl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDMysETp9XujBQYSVMHXwDNDFC7eY2ye1H1Rv2hb0oLD3unDNErHtAnON3DKU+Twr5JohIJ8780Yp2bph6PWFpKg5gdGO6ilAvo2dfxPMnKSZZ3WWmiHW3QaNaMRDSxpAHS9xnJuGuQX8mHDaLRB/Escgx+eNJJzOK18Wc2vDc949YdEo7ZV1bFq3OY836mtO3B4x6yCsBDJt8dFwpY2blOkYf/Z7FrbpVVwUjdkXmnJcGHj9/0vY3gmxDK8PGebfn63lBzj4BNLg71s7EKrrIu2Z22t1iPubViTg1fUfvTL26FQ2s9Y0eoWCRLHl4vlKyMCrzf52Qd25nQ6Vq5f0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH7N+LVqxdY7xan+3D4H6ZjPMaA72Emfzt1FhDn3YAY=;
 b=miCOU4tRp+hDU9dqDZl7e1EVosvXwwrQ2/2+NZ/KPnsALxYkdjFBznEIKtfi/wu06WTJgBQjNfiKuC9OPFiK4M8fgFE10eImKRSLXRBEcXQT3BOFWGLJYCAENFhIRL4DSrx3jdfwe7Y2Mc/cDV6QiV0zJEfCaQVkPv9feD2eWdEoW0i56q9IAvTo49c7OaNnw/PduDucERn5XyM1lJOl5HdoryKjziaJEVmMsDyOKfLrDAUq69vC1oVtOYIkPcwyunza2BKAgKKmvr2At4nvxW7f8/kQt+WLZGozuwageB6GQHnZhzSAxMgG3zytbHLzT/uu1oReEkgIbt7B/VBKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH7N+LVqxdY7xan+3D4H6ZjPMaA72Emfzt1FhDn3YAY=;
 b=ds1xAmZGxCUGGgc4jM8VwpXD9bm+pmIi2xK91t64Lzj1yqf0jJCQWrchAIWwK43lZkW8FcdgWGaTT0iPG8YTAJmCnU5k0L0XmetWbda1AOB6pODxOZNAZ4CDK+h3cqHpUJuvZPrahqtrohPd3ua7xMylf8UMFO7oC9aB4DUZpCydECr0WDHfPHPYNUJ97bhreMLRw8BeMDGBilQDb+VpIIbIfgjTgChUvHujp6jwmJM9GNZOyI+d4I5jd4HnPiTBti4wxC9dgqQdoMp4Lt5rPQ2TM4wA+x7YYDo3Ivw/a5ImQvX0vljLBWBd171fAj4P0tlY3J3MciQfA5NaLFERYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by VE1PR08MB5839.eurprd08.prod.outlook.com (2603:10a6:800:1a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:39:00 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:39:00 +0000
Message-ID: <29e16e29-4bf4-498d-b42e-ef5b926f466e@virtuozzo.com>
Date: Wed, 19 Aug 2026 17:38:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-8-andrey.drobyshev@virtuozzo.com>
 <aoR0_7FBFAyFw_b5@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aoR0_7FBFAyFw_b5@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|VE1PR08MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1c138d-1380-4da5-9584-08defdff9be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +vxz+HqZObolG3gwexBrdzzjyEl1KguQCblGwsNJ8lJr/3aCSxrAVoHXUtRrJp33wU6XfvbXJNstcPY7QNG0aKrU3yyYYfQA9hCvwQCk3N2hRSkHWAnzVG119dMAJFy0ZIz4WTA3FOad4U8FA9WMucksKsF36yx8d8sIOkaOCl0W6q46iwJtI4eYnBKsuRcCI8byTfdy57MXD9OfHhFvI+rxhz6OFNIqZKon8cObQ9Qha7H7X+LhxiVWKTVF4TDKl9NMNpAjROnzJVRxkWs5gD9JXaqC5I/XKnyvQZfmFbN50oi9nKRZIJb8tq5vrft+Zxs0HoERBTew0hxgwYyhyUex9mbXCRI84CtpcNXDfDjHrRwA7Qx3UVUtRebr0OgCaNvJK6XJ4fAVqyaQDQgFCIaIYqRuS6WJ3Wkd39jNF0atz3HxEZX9jmd1YvTB8a7tEIRANmzQl0ZxW61q23A4xvTcdk3f9GRQycHGe84vaQF0UGnmDixvUvLTb5fbxd4+yJWUDiKytFmMZKXdav0VYUVd5XWvlCqsFKnLhZrIDfoARtLffrmQI7svgT/E0/Nnszq6V+tX64y9zuxoZ43/YAiKGJM6fYpFliWP/lQRxzhFmOnalUOokrpjDju5/ZQlKWqq1dCc1kZu+qjgUPapvOyZCT8vbxZl9E/IC3PiZ1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdYbHdyeVZ5Q1UvTy8rTGE5T1llUXUwMTYxRzgxbHU1ZkttWHJlTDBjVGM4?=
 =?utf-8?B?OVl0ekxvaXRCSkpSSFFJNmhUdzFESnZaa0w5WXJsanVTOUNIbWtaRHBiUWNB?=
 =?utf-8?B?U0dibTBCTnpqUmhNcFVwYThHUTlCZlczVzhTTW9DWTU1alVPS05rekRXVGpL?=
 =?utf-8?B?R3Z4a2FaM1o1SmFLNzR2alJEcXh4aytzekJHVWJWK2RRd3F6NzJCeFErcXl3?=
 =?utf-8?B?UEllTXpNaG12cENRTHF2bmY1NURaUnl6enEyK0RPenlHcmJ2b2F0ZTgxN0ZW?=
 =?utf-8?B?Ky9pNU0wbDdTVGlUbDZkQzV5NjdONkc5RnFLMVY0RGJtKzdtemdid1E3alFZ?=
 =?utf-8?B?Mkl2UmlVM3pBM1h0RFpTODhVSk1lcHEzZ0RiSk1yMDRITWFTVlcxVFdyQ1Ay?=
 =?utf-8?B?VWdTVjVwOFJqK0lUbUhtNDMrKzhFOEhzUkcyRHFuZ0hwQzRvY1dCZlpVZnlr?=
 =?utf-8?B?dkZ6NUt0Vlo3djBkTkxjNFhwcFpNOTI5Y2ZGS2hWZ2ZqVWcwLzBYM3JxVGRt?=
 =?utf-8?B?VC9xS2p5VVZwNFBjaVdQN3FvZkNkQWJSeUZIL3NkRlhhWEtUV011bDlNV29u?=
 =?utf-8?B?Vi9VVGtDUStqLzNVdHRCYWNtYkFGV2krQ3RBMmI2a0ROSDNITkdLTHZHeWwr?=
 =?utf-8?B?QzNrdlc4bytUblhYSVpscmlGQzBvVmhtNU1jK0w3QTJ2Mm8rWjNmSlhob29x?=
 =?utf-8?B?Y0hydDhaL0xaaWFhQjk2UHNZdnNubHBZbjBoTnZub0w3V1NZSUs3YTdENkFP?=
 =?utf-8?B?M1V0TW15TWpmeGpsT0RsQ2RIL3k4ekRyTkQraEVKK0JLODluZEk1ZWdoUmVJ?=
 =?utf-8?B?K3FiL2lLdE5vNFVCN0YwY2kvVGpJN1ZMRjVuTmxpcnZWQmY3RXExT2hQdjVt?=
 =?utf-8?B?MFRkU3pXMHFuSDdzSzJhbzlLU3NRc3QxYk1ialJMaER5ang2c2RFSU9aQ2ZN?=
 =?utf-8?B?eHg5NHBWL1VkcjRnU2hWWnVZWEtFYXl3K09IekE2QmNBOTZPTmhONVp5eUtC?=
 =?utf-8?B?bzE0Um5uVUszNUh1emd0MzYvUU1EdlFUSUJ4eUZLaE4zZnExREFPMzc1WFZu?=
 =?utf-8?B?UGN2VTZNVFRlOXVKdlpRaFlvdnhwK2tiNEhZZ1Qyays3SnhRdmEzM2ZCS2lp?=
 =?utf-8?B?bllSWExzSEEzZndXUkVZZXhtOXJUTU9qQ1ZvY2hwQkRiS0d1V1pEbEpqY2pv?=
 =?utf-8?B?Z0pKZnR1WVlSSmUrdk5JdTZVSEJtVVRTc015UzJLanYzMVZZUVFRblNaMndI?=
 =?utf-8?B?S2ltNFRLSnNKbHMrdFJoVGg1cEF4SEpUVnlja00rYkZmT0VqdTB6alNzL2xD?=
 =?utf-8?B?WG5nNVBCMFNnODY4Ykpzamt3Q3hueGdTbFRrVFpWeTFmeXhzZ1pWc094d0VD?=
 =?utf-8?B?OWVKSFplVTRUMHRrWGJsZHhMMnI5NnRQZmkxcDlxbzZMdFlQOXowYmd1VTdC?=
 =?utf-8?B?VkpDeXNrRVVwYUNqdk9mV3k1dkNBMitVWVIrcWFuMjFPbnhmbHFNS3A3a1g0?=
 =?utf-8?B?N1VjaHRlQXFmaURoVlBjNlllREVRM2VObktrVWdlTlpEeW9CdFVNQzErY051?=
 =?utf-8?B?WjlwZnJQSTlXcHZ6WCtUVVYwN3NET0hrZFYrSFFFTlFzUEMwc2tQWUVzdXM2?=
 =?utf-8?B?Szhad0l2U0g4anBMZmxIdEVGb0RocGZLTnRrMUN6cnVSaU42aExqak5JSnk0?=
 =?utf-8?B?R3lmQ3g4QTNkZU5hdEFPMU54ZnZvRlVBTVo2UFp3WTlmUU1maUlPdlpZZktN?=
 =?utf-8?B?bVVNdERuTERzd2txa2NBREJoUEd6UkpGQU5QcDJEQ3p4djZYMythUCs0MVBG?=
 =?utf-8?B?V2NrdGJsQzBoMzgwR1JtOU1jRFZlUXBQR0g4T2JKOThtLys5Y1psL3FCR3cy?=
 =?utf-8?B?c2toZGd4VGtlYVJabk9QZjJEa0UvWUtZcitRdmNIMTZ5emtSeGpQd25GSHB6?=
 =?utf-8?B?cDhBc3hnUGhXaVNtOFVheHdRZzNUQkhRQ3BPeEFiRDE1ZStjeFdIRVJJNVY0?=
 =?utf-8?B?WGpCWlEzcWtodjdNb1Q4U0JsY3kvSFI2RlgwUUs5SGZNMmJETWl6REsyUEd0?=
 =?utf-8?B?MVJnZ0Z6cmdXUVFxZ0J2Tmh6T0grMHZXQS81WHNyWGlwYjY3TDg0UzRsdEx4?=
 =?utf-8?B?MUVFdTZTdEVKeXdja1Z5WFMzMVFPdThrYWdvNGZPT243Z0piazZNTVFaMjd4?=
 =?utf-8?B?WWRLQTVEZ0NOaXl5T1Ywa2wrOEY4dUVPWXlrTDc4M1pFTmtOOXpwMUNBYnly?=
 =?utf-8?B?OUx1VWpWVWNNTjRmdlJHM1lpNzB6ODFkMlk2ZmQrWG9pQmtleWdHMFRYKzlv?=
 =?utf-8?B?aUNCamg5aSs2NWtvN0cvc3ZRWGtwbkRqNWdiQm1KLzdtelNHcXE4SHlOemRF?=
 =?utf-8?Q?LFCI+Ulk35p4p7sg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c138d-1380-4da5-9584-08defdff9be9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:39:00.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRqsx1Bl5zngs2CQKDKFU6vI0XaXtYziJtvTGdm7d3V7P7gOMk5IWFMM1P5qprKUME6b/Q+0CXnyBrZjNmhvpDx39wRcv07BZxL6oBZuSqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5839
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 8/18/26 6:30 PM, Stefano Garzarella wrote:
> On Fri, Jun 26, 2026 at 07:46:43PM +0300, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and targe still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on failure:
>>
>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>    cpr-exec).
>>
>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>    queries the backend features by calling vhost_dev_init_backend().
>>    It doesn't take device ownership and doesn't touch the VQs which
>>    still-running source might use.  The full init is deferred to
>>    .post_load().
>>
>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>    the device is started at vm_start.
>>
>>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>>    fails after pre_save released it and the source VM is resumed.
>>
>> Also harden vhost_virtqueue_cleanup() against a NULL vq->dev which can
>> now happen if an incoming CPR is aborted after realize set up the backend
>> but before post_load initialised the VQs.
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 147 +++++++++++++++++++++++++++++---
>> hw/virtio/vhost.c               |   2 +-
>> include/hw/virtio/vhost-vsock.h |   3 +
>> 3 files changed, 140 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 7eacb608d07..b02b3f9cc03 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -76,6 +76,17 @@ static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>     bool should_start = virtio_device_should_start(vdev, status);
>>     int ret;
>>
>> +    /*
>> +     * On an incoming CPR the full vhost_dev_init() is deferred to post_load
>> +     * (realize only ran vhost_dev_init_backend()).  hdev->mem is set only by
>> +     * the full init, so refuse to start a device whose handoff never
>> +     * completed rather than dereference a half-initialised vhost_dev.
>> +     */
>> +    if (should_start && !vvc->vhost_dev.mem) {
> 
> Should we also check `vsock->owner_reset`?
> IIUC it can be left set if for example vhost_dev_set_owner() failed.
>

You're right, we should.
> About using `vvc->vhost_dev.mem`, I'm a bit worried if it can be a bit 
> fragile for future changes.  What about adding a new field (e.g.  
> `initialized`) set by vhost_dev_init() when everything is fine?
>

Agreed, let's add 'bool initialized' field.
>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>> +        return 0;
>> +    }
>> +
>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>         return 0;
>>     }
>> @@ -111,18 +122,102 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>> }
>>
>> +/*
>> + * Re-acquire device ownership if a CPR migration that released it (in
>> + * vhost_vsock_cpr_pre_save()) failed and the source VM is about to resume.
>> + * This runs before vm_start(), so the device is owned again before it is
>> + * restarted.
>> + */
>> +static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>> +                                    MigrationEvent *e, Error **errp)
>> +{
>> +    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>> +    int ret;
>> +
>> +    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
>> +        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
>> +        } else {
>> +            vsock->owner_reset = false;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_vsock_pre_save(void *opaque)
>> +{
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>> +    int ret;
>> +
>> +    ret = vhost_vsock_common_pre_save(opaque);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Release the device ownership now for CPR migration.  The device is
>> +     * already stopped at pre_save, and destination reclaims it by calling
>> +     * VHOST_SET_OWNER in post_load.
>> +     */
>> +    if (cpr_incoming_needed(NULL)) {
>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>> +        if (ret < 0) {
>> +            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
>> +            return ret;
>> +        }
>> +        vsock->owner_reset = true;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> static int vhost_vsock_post_load(void *opaque, int version_id)
>> {
>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>> +    Error *local_err = NULL;
>> +    int vhostfd, ret;
>> +
>>     /*
>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>      * tear the vsock connections down.
>>      */
>> -    if (cpr_is_incoming()) {
>> -        return 0;
>> +    if (!cpr_is_incoming()) {
>> +        return vhost_vsock_common_post_load(opaque, version_id);
>> +    }
> 
> nit: maybe we can do this in the patch where we introduced it.
>

Agreed, I'll move it to patch 2.
>> +
>> +    /*
>> +     * CPR restore case.  The source released device ownership in its
>> +     * pre_save.  Complete the handoff here, before the device is started
>> +     * at vm_start.  Init vhost device on preserved FD, issue
>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>> +     */
>> +    vhostfd = cpr_find_fd(proxy->id, 0);
>> +    if (vhostfd < 0) {
>> +        error_report("vhost-vsock: could not find restored vhost FD");
>> +        return -1;
>>     }
>>
>> -    return vhost_vsock_common_post_load(opaque, version_id);
>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>> +    if (ret < 0) {
>> +        error_report_err(local_err);
>> +        return ret;
>> +    }
>> +
>> +    ret = vhost_vsock_set_guest_cid(vdev);
>> +    if (ret < 0) {
> 
> Should we call vhost_dev_cleanup() here?
>

Yes, we should, thank you.
>> +        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> }
>>
>> static const VMStateDescription vmstate_virtio_vhost_vsock = {
>> @@ -133,7 +228,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>         VMSTATE_VIRTIO_DEVICE,
>>         VMSTATE_END_OF_LIST()
>>     },
>> -    .pre_save = vhost_vsock_common_pre_save,
>> +    .pre_save = vhost_vsock_pre_save,
>>     .post_load = vhost_vsock_post_load,
>> };
>>
>> @@ -144,6 +239,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>> +    bool cpr_incoming = cpr_is_incoming();
>>     int vhostfd;
>>     int ret;
>>
>> @@ -172,7 +268,16 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         }
>>     }
>>
>> -    if (cpr_is_incoming()) {
>> +    /*
>> +     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
>> +     * then fails.
>> +     */
>> +    migration_add_notifier_modes(&vsock->cpr_notifier,
>> +                                 vhost_vsock_cpr_notifier,
>> +                                 BIT(MIG_MODE_CPR_TRANSFER) |
>> +                                 BIT(MIG_MODE_CPR_EXEC));
>> +
>> +    if (cpr_incoming) {
>>         /* Reuse the fd handed over from the source QEMU. */
>>         if (!proxy->id) {
>>             error_setg(errp, "vhost-vsock: device ID is required for "
>> @@ -205,14 +310,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>
>>     vhost_vsock_common_realize(vdev);
>>
>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> -    if (ret < 0) {
>> +    if (!cpr_incoming) {
>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>> +        if (ret < 0) {
>> +            /*
>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>> +             * by vhost_dev_init on initialization error.
>> +             */
>> +            goto err_virtio;
>> +        }
>> +    } else {
>>         /*
>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>> -         * by vhost_dev_init on initialization error.
>> +         * CPR restore case: only learn the backend feature set now, but
>> +         * defer taking ownership or touching VQs (the still-running source
>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>> +         * is done later in post_load.
>>          */
>> -        goto err_virtio;
>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>> +                                     (void *)(uintptr_t)vhostfd,
>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>> +        if (ret < 0) {
>> +            /* vhost_dev_init_backend() does not close the fd on error */
>> +            goto err_vhost_dev;
>> +        }
>> +
>> +        return;
>>     }
>>
>>     ret = vhost_vsock_set_guest_cid(vdev);
>> @@ -234,6 +357,7 @@ err_vhost_dev:
>> err_virtio:
>>     vhost_vsock_common_unrealize(vdev);
>> err_blocker:
>> +    migration_remove_notifier(&vsock->cpr_notifier);
>>     migrate_del_blocker(&vsock->migration_blocker);
>> }
>>
>> @@ -250,6 +374,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>>     if (proxy->id) {
>>         cpr_delete_fd(proxy->id, 0);
>>     }
>> +    migration_remove_notifier(&vsock->cpr_notifier);
>>     migrate_del_blocker(&vsock->migration_blocker);
>>     vhost_dev_cleanup(&vvc->vhost_dev);
>>     vhost_vsock_common_unrealize(vdev);
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 7ae2abe33cd..3734e3f20b5 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1647,7 +1647,7 @@ fail_call:
>> static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
>> {
>>     event_notifier_cleanup(&vq->masked_notifier);
>> -    if (vq->dev->vhost_ops->vhost_set_vring_err) {
>> +    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
> 
> Is this change related?
> 
> Oh yeah, I saw your comment in the commit description, thanks for that.
> I'm just thinking if it makes sense to move to a preparation patch in 
> this series.
>

Sure, let's commit it separately.

Andrey
> Thanks,
> Stefano
> 
>>         event_notifier_set_handler(&vq->error_notifier, NULL);
>>         event_notifier_cleanup(&vq->error_notifier);
>>     }
>> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>> index 5ebc63afc5a..6d0cff4fb93 100644
>> --- a/include/hw/virtio/vhost-vsock.h
>> +++ b/include/hw/virtio/vhost-vsock.h
>> @@ -15,6 +15,7 @@
>> #define QEMU_VHOST_VSOCK_H
>>
>> #include "hw/virtio/vhost-vsock-common.h"
>> +#include "qemu/notify.h"
>> #include "qom/object.h"
>>
>> #define TYPE_VHOST_VSOCK "vhost-vsock-device"
>> @@ -30,6 +31,8 @@ struct VHostVSock {
>>     VHostVSockCommon parent;
>>     VHostVSockConf conf;
>>     Error *migration_blocker;   /* set when the device has no ID */
>> +    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>> +    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
>>
>>     /*< public >*/
>> };
>> -- 
>> 2.47.1
>>
> 


