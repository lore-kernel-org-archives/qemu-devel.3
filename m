Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00486C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Lky-0002YZ-BD; Wed, 09 Sep 2026 13:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lkv-0002YI-Th
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:06:42 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x4Lkr-00049u-Ln
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:06:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySky9rQZzcQ8P7nLcQO8SGoF4B20Q09mw06EYnShn5Rwb5MdnXkZJ/lIQRcJwfXoC0U82kzShh+6scGsKAzhQv2Ogos0XD1N6ogknZBz358dEDflPyzlCcyT+pxPmQiWIRW0OUYWuLQ3ByIblaQ64tJwYHPWFYT38HX2RdXp2qOWIE+8OALTUtUVtsgKtYx1J1+S5uVvlVBh8jmkmr9l1P2GW38LY0LpE0xFThJPbYI42T7+V967PpHkGBgNMddLJkj80oxkhZzMMV8g47pCKWqOoluUzzmxUqsG8JbGHBU0MKpFzCrTQPokME0F6EAzMH3PDG8FsR3GFvjFF3pAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzuwhoUNocK14XivCNWFhmeNVidLMWM6IUpSLagtn5E=;
 b=iRr+e+SfT7so2Ffza9/jIWYRPoWpQuI2xpRp5gfgGDewk1l+G3IzGPlovbIKSuGlhEOc3Mt/X9w5/hk0dhAhHBwxyVDO/CEaNvyftO/B5XhTdUUP4eD+QAqIAcXqZpKSvZbZPiuCq+I4/SXcXQ+lDpnyY0NET2oU7n0gZNTNAFMf+SJO0AXPhjYwc4UmW1BvU8BKIs0DoPqlkVuK3CZFcOLx4jmQNvej6uFOgZQzl5Tie0B3mF8dX9eCVw+b/6xrvOR4+kcyrydtI/PYF8RQV/aP1MB0AEXiOrBZ1au98TnworBNY9sSNdE35sF6e8BWACTsAr7+HUeJfIFEzFzdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzuwhoUNocK14XivCNWFhmeNVidLMWM6IUpSLagtn5E=;
 b=w606sxynrzNGL5urYPuEaEzlzTnKjHS9Ao0BipctW8IB0qlH3Eu5s7y3fv+xDudMvQ1viQXKOVAisfjsRRkuUdcn7pm6//j+++0yErrP0JJMfX8pW6calTpgpa3rB46/8Ef0mioKCIZv8NM6WhMjb+9PN059DnyrNP5BPbnj1VgxUj3sEkejwe7fLwrjImH1TSZS1MPmx9ej6nRfjTNaEffkhVDcHn7Z7iwFiDQPg38B4XAqqscTOn91TeztNaERQiRMrHskOzsGeYxkc3sXjc2lM9g/OK22eVC9Ts5kaFj/K9LLa30Vo8dAb6b31n+Jy3rb9Kt7QnAzf9U2XTvg1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5976.eurprd08.prod.outlook.com
 (2603:10a6:20b:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 17:06:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 17:06:32 +0000
Message-ID: <af67c138-31ad-422b-b192-28fcdb1ab0f7@virtuozzo.com>
Date: Wed, 9 Sep 2026 20:06:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de,
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-8-andrey.drobyshev@virtuozzo.com>
 <ap7IX4xa8nXsWkJU@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ap7IX4xa8nXsWkJU@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db5fef9-68be-4322-bc2a-08df0e94b26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ysOwjv+CNtlvY8/2H0rarFmKZ9KQTmISQr1yZNpkJlzPm15xj79vkZx2wVSR/93WZ7wG3x2sEVo1re0O3IJJVLMfgIfTnKwg4lR2i/Oi/axNr3VTERLIkQdyybJF5dS4G+jGPrxJ1b8aWTSi/bvZAYna/kHL7nBQOJC4u8zHrjVvlspnZ3jHHbl4Ep0+KpwmKnqWX1bm51a0sxDCxbVpiXD0BtcainsBfJeWbPXkF9kwmmRcrUUSG2Zecr1osH0rEl355Pbnlxf8dChORvXyuPJli+gPa+vBhnt3qVh9BTMmH3/BKboXuhBHWKHHIWPgVkWiQx4eX7yGEjXe0ZMbXioCIGajz6UWYL6i9lRx8VNdEnqAJz8XPHYKqejgl0usVbHLdDZLHDxr3DvRtx7AREAxRTrtyAYdfuXZgHESipnisq8zJf5LiMPycAuuzteC6cY+vf6uevyYsTNq+WPIO5NrRvvXhzDctpvXn//7cE4DhCsGo9IP+BqHXwxgsxJrDubNm5/4A5erIVVVe4Rxqf/RfTuonHm55QvvVSHt0IQgx1bTYlQOBPe+spinmbq2J8E7x1pdwxoHRbvprJoDsKkHbIEUFfIym/v/CMK79/E0TqL8KGucdr+F3rZm+Y0PcUYQjVo5qsmPcBQHi9lj0i4qRC1H0l/d7FThSlBEpnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEJNWG5maUovRUNoT1BRQVlvV2lscU9GQkkxdGtRWjhkakRZKy80eDhzN3g4?=
 =?utf-8?B?ZStZR21qMWpGalVBMnVRaFI2T0pwN1V5UTIyaUpRSnQrSlROdVlnNmJtVmFi?=
 =?utf-8?B?RlJ6SVExb2JKQ3cyOXcrcUZXN3BKNEU1NWJKeURNWHRGRXd0eDB5S2tGaTk5?=
 =?utf-8?B?RmR6N09Dc0ZkekhZOGNybThmbHFxSENlaXArYkdYLzhWWWczcUFIbmVmN09h?=
 =?utf-8?B?WSt4b2kvdC9ZN1NCRFZ1NlpGVy9TcE8xVEM4NEV2NkMwd1pJUk5BUmZkZmM2?=
 =?utf-8?B?SjNjZytWbHVNWXpydzdpRS96cTViRFVmb3laVzhENmVDMnRHWk1yNjltaHUv?=
 =?utf-8?B?bkE3YkpQdkdUb3g3ZWhjNEJZclk3ZGlSWFhZanVCVmVFWXNEa0xSaDZ3dUhz?=
 =?utf-8?B?QzBpQ2dmS2lHZlQxWVFjK1MxZ3RjdmJmcWQxYjVLQ3NneHJSZTBuRGVjUmxV?=
 =?utf-8?B?b3EwODdkSWpISndPMkRBdnBXQXhzYUJnUXVjR3oreVpyazF5OG1DMm1oL0hz?=
 =?utf-8?B?TFBwbit4aUdTT0RlU1B2RWo2SnZWWlluKzR6WGh0VlJ2QWZ3MFJaeVl4dW1R?=
 =?utf-8?B?U0VKRURrbldSMjFoNi9LVWFsTUJkMGRXTmtuN0dvTnlWdWp1SGxsWWJrc21j?=
 =?utf-8?B?ZW5ycVp1OEV5TldUY3ZVZ250NW9xM01YWFFaeUtDSlJuaGliL2l1QWhFTHh4?=
 =?utf-8?B?dHdveC92eUwxTHZVUW15ZU1SbjNKSzd2YUxac05SbmxVNmJMcjI0VGZsQlpB?=
 =?utf-8?B?NDdiTmZkZkhuV0xoZXlMeEhEazNwSlNmMC8xNUNSN3ViSHdXWlNMeVNiOTNO?=
 =?utf-8?B?ZzZPdGQrQlZZQWxyZkYzZFRRRFBTSXZFL2UzZzJtQ1EvT3lvdmlPVFRkR1Jo?=
 =?utf-8?B?UWFUeW5McEhoQS9MTUt1NGNQaDE4U01JSkFnYlgyYXE5enpMYTh2eWJKK0xT?=
 =?utf-8?B?ekp3VHhJa0JXUGZwa2gvSWJYWnROcjBkclVDVWM5dDZGYi9mYWh1ZGU0dkc0?=
 =?utf-8?B?NGlic1dtWmhlWWFITWZqdldCU0tibURqVkZYY3pJTFRHWkVqWlJtSXpmNE1Y?=
 =?utf-8?B?ZzNYNUhWcjgyQ21ObzY3NW1OUUdTZGpVTU9tdVlKUDQwYnh3eGk5S3QxSXNx?=
 =?utf-8?B?eVZNd2NLVWxHL213a05EdHRnd2YwSVJCc3UwdVg2M0FIMzhNY0Q3Q3N4cDZG?=
 =?utf-8?B?KzVxcFFTNlphdlB0dDdrY2ZKeDhaY0lBdjc5SzhhV2VIN0FNR011a1lOQ3Jp?=
 =?utf-8?B?YUdZQjdhN3JGZ010YURZOVZjdG1haDloL0ZOalNFSlF6WDBqaU1XemZoQWNa?=
 =?utf-8?B?Ym1UMzgxcXlMRVJTYkpmTkpsamkxQlJkWHlYZGxDTUlTbis2MG5FU2FpWTB0?=
 =?utf-8?B?aXNuVDN6U2dTc1Z4allSbVYyeDRCM2dTVkdUNjJnWXl2N3hzcCswUVh3bFZu?=
 =?utf-8?B?eWhRTVNVd1Z2ZEI3RU13MDNnc1pHYy84NVJ1NVpVOEZvMm5tOWxZcUNiaEEz?=
 =?utf-8?B?NVRrR3lFVjVEQUtoRXVEWnR2NVd6aFllRlhuL3dpS3FVaVBremJOZGEzdlRX?=
 =?utf-8?B?Y29hUnVBY21sT0VBK2Y3bG4rVzBpUGd6WWVUWXlJUVIyMC9NWlQva2YvM1B4?=
 =?utf-8?B?RGFMRysxb0dSZnVxS3A5V3pDYzNjYlk3T0hwMWpOYUpiYVc1RldjdFhoZ3N0?=
 =?utf-8?B?WDkxL2lmaWNZTVZSaFhWVDNWS2V0dXFhaHk0N3lobVYvUCtXWmRnYVlMaGs2?=
 =?utf-8?B?ekJFV0dBVUMxcnRITWdvQ0RvcmpqZXozNjJwUDhoTGlFbkhQQzBMVGV1bjI4?=
 =?utf-8?B?UzJJNnNqV1ZKWTErNEcxdFpTcVI0Z1RwZjRXQ0dWWFZBSXljYkIxVHFEWVBz?=
 =?utf-8?B?VlFROUQ3dzlsR1N6bDFBcFA3cnd1QWJVd2JwV1I0Z0ZZUVpBYlRPOXkvOW10?=
 =?utf-8?B?TDJZdTB2M0orY2VyeWVJRmprR3FWa0V5K0dhUDAraEQrUzd5ZTY3NzlxMk5y?=
 =?utf-8?B?TUN3c2V0eGM1WXA1TXZ6TDFsWEVlUHIvZXlndWdERzFta00zalRPMEFGTTZn?=
 =?utf-8?B?ejZQdVMzNUVNRGE4MExuelgxWjJ5UEUxZFQ0d1JwZVNQVGlxL3E4eXlPOC9r?=
 =?utf-8?B?L21aUnBXRjFSZXM0cWNwZk9sbmFuS01yMWs1bVpleHUyTTMwZ0RFSHkxQzRN?=
 =?utf-8?B?S1ZOWHZiVTNsTkJnL1lZWi9VUHpMU2t4NE0vcVE5K0d1TlJCbU4wV0hLV3RT?=
 =?utf-8?B?Rk50VnprWmQ4c0tVVTlaUS9hNUVCVTJ2WjNoeCtIdVZnQ3l3RGc5YUcxZFQ3?=
 =?utf-8?B?bDEwcWd3SjNib05XZCtHUElKVmhWZXlLVUxXWE1EV2dhUW5WNUk5WE41OGNu?=
 =?utf-8?Q?oIcRI/anSfbwqogQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5fef9-68be-4322-bc2a-08df0e94b26d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 17:06:32.2582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLtAKBAR6+GgM3EoSbx9zrH6ehkpw3bsdmfYcQEtRHIZaZBHcj2PdNqStLNnGJ5bLaSq1CpsbaRllXkEbR68GLBCNdnfBZW1bJzLz/tcDwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/7/26 5:56 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2026 at 02:39:52PM +0300, Andrey Drobyshev wrote:
>> A device which only went through vhost_dev_init_backend() has its VQs
>> not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
>> would crash dereferencing it.  Check vq->dev before use, so that
>> vhost_dev_cleanup() can be called to release a device whose full
>> vhost_dev_init() never ran or failed along the way.
> 
> Is this a fix for a current issue, a defensive programming measure, or 
> something that might happen with future patches?
> 
> Stefano
It's the latter.  IIUC right now there's no way to reach the cleanup
code with vq->dev uninitialized, but after a subsequent patch this
becomes a possibility.  I'll add this note to commit message.

Andrey

