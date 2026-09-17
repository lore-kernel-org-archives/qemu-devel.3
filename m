Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98451C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BVF-0004HF-Fx; Thu, 17 Sep 2026 08:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BV2-0004FW-KY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:46:02 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BUz-0002qA-HM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf3alGX7TghMz0KDUwUH4v9cyEgjrhu3EfnUsLEMmgrFxvS3XdVoLIDc2sN3gZLdh/vJATrNOYyT1iLicuDz6dP8XYoAen+cd35suIaFXQxQTi5ayIElGsWZGKDdWbg4cGsiL4Lkq6OIcwUBnm5E3NQVBKe51MmvocWpH67ki/g6mCsSyp17ht1WnDBYeKh4agQ0NV4muCMV60fpiUf5fZ24uToCNEkFKuGM7pM2mupkWjdWJyt+MDQmYOQSh85kKfIul03a7D9r1gzBc30klavejLuzy1rJIkVRxm/7buQI2zACTgWaF4BbfjM4IU2eQ8iRpQKfC00VoQaON3NotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uwZ77H9xo7nHsQthuRpYJ39wSKMs0MLRxZMyWnQPx8=;
 b=vJxaFlsgplFpXK80x26uQTn9kLLCzXKxfr0HjE57guSecZ75dXHZrQ0zenLrQ4ZXo1cciAiF+dPUqpkKNE1EAlqI6+UHUfCVzzLVkrB2pgFUI3wlXS7LLPdSJoCvFUHH9ZfihBX5T30axBB3XWqLn3y84mQuRbAX4TeB7vrkvHrfzu3b/k+iFhSdU4vtgKYttkPV/jypkbUVVYjO4thLy//ugxfDC4Lk/CBSLOoMINNtabb45x/ZflhXUVQOrAXqLLqG8vw0FPaTt2q0cL+xSrq/mkdSKiRjNvlUWIr1RjFo34UY7eMqWkVICntNkLMl7y5sHEzBISiQ3y/QeOHKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uwZ77H9xo7nHsQthuRpYJ39wSKMs0MLRxZMyWnQPx8=;
 b=JOfjwA7ofqyExk91mDRoVO4KjwLLILNTYH5aAdQu8K9ZUckZcJxVztzm0B+IWFPpNvZ3mL7tUeq0+ttMVBCEn2JORwJ2fPr4Ez3NYnI3WZ7fDRy2ieYlWxLwXwLjtwlWg27Ua33SViUR7dKeZnqFpL1zWgauM7eW/kcrFxXhlOLsLABieDv7OtS9B0zLXIvWVliYjULzJ+B3zqH6JFPayVK3KXOUcpHUz+BxobLjyrH4YvELcfgB6sZo7vNG2YEBLLxExcM2S+S90BJNwrvs8BHVhm5vBmKK1ccTAkuCw5Ftwh95OnTXWf4n9AZvnumknJMG6XYI4RDPhQexNl0WHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9749.eurprd08.prod.outlook.com
 (2603:10a6:10:447::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 12:45:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 12:45:50 +0000
Message-ID: <aa5a8276-8b37-43a8-817e-356214b3d99b@virtuozzo.com>
Date: Thu, 17 Sep 2026 15:45:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] vhost-vsock: preserve vhost FD during CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, mark.kanda@oracle.com,
 farosas@suse.de, den@openvz.org, clg@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-9-4d31b2dc6afd@virtuozzo.com>
 <aqq-9QeEXkZ8EISA@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqq-9QeEXkZ8EISA@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b801b56-07b5-4338-572f-08df14b99a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SXjZPCkudTFBq9KjZuKdTh5ZM1NFKY4Kw+aoZvVt52vrHWzi97QsbbSW/pX7gN4lYDq5rNGQxkpwRMgGGBLTinKoREy3RACxKJe7FS3w3Gl2nkdMMwYd0+yGDTpBahSYMIpL/GdLjoaCY3oAr5Mh85Cgyl/R0VTewop8xDToP7jfymjuDvUOwTScqot99Y4BT8jc36iogt86ka8alSzlkt8QJucWos0afTszXLCoRN1RYvHzPQsg4DQhm0vLYvEYztC2XQkuFIN8BGdUrRpPeF2WxAVs2HoU+0yV78nboIYoKLuFJo72afhbzyp5GwJJuv2S4FkruQTizutoJkKanBWkkVghN8Q7JfOmY9Vli4h4PzPHLzw6/Hgcd+ivHFEEPqwNSSp00N9omb6ADHeu8Kyi1vvBC2itVzGG2GtZ+cBsDRkrsWSEIKJZrM3qe+FokZI3VuhkQWVh52Q4ZcB+iWkWRIJ5HACFhEGwPyKiQ6+chsjqDpq44sO6J+FYShuQnYIZm3k6kEY6sfYsTyVNhp4lKZPLaM0WONt06xeOUmC8ElZlBNktBQj0VzOC5cnhHkmURfi6Zn2IhKPaI036npBzDeWCMDYlkkAUD8I3i7nsFLsFVb0OHlEFUODZMATvVZq7G9+TAvksbf1b63Gcx8UKyNp1nuDeKQmJ/d23ftI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThPeXdRdUhyYjZOMlB2ZmxZMHRjN2R2YXIvS2taYURWV0srZ3plOVFpZHdl?=
 =?utf-8?B?czgzQ2ExMkVQNUxUUlpyL1lKYmRSbS9YUEdwL2Y4dW1NZXJEMXhKZHJRZEUx?=
 =?utf-8?B?UUpKakJnSmhlRVVpKzF3ekc1VWxGM0kwUW9ZVmxwUVArL3JLbEdKQTdNTDBY?=
 =?utf-8?B?TVc0TmNlOHkxZ0kyN0ZSb3RWcEhSSTJ0S054UlMrNDJuTm1WZXZndktOWTFC?=
 =?utf-8?B?dzVTbURqcGtWaTNLRWdKWFJ3QlFkd1B4MENoMEpsNkZ2S3l5aWdxaVl4YkNQ?=
 =?utf-8?B?WDhjRy9zeWtza041enovNzhNVFdZSEIxWWpjbDN5YUlOQWZZY3V1dFRPOVk1?=
 =?utf-8?B?U3B6OVNuR1V4QWowcmE2cno3YlMwMkRZbk1aRWxSUE13QlBIN2ZDTElGcTho?=
 =?utf-8?B?RFFMNldqdEtkMnVlUUNDYUFIRzk4WW50RkRqbXlVZkRVRm8zeFJSZllVYmx3?=
 =?utf-8?B?M0FNcXdQSUowdUl0V0E0dUh2WFI2Kytoa3ZEK1lhZ0dxQ0MxYkM5dFJVMXd5?=
 =?utf-8?B?cGJoV0twbkdQR0VZQmNKbmxWcEVyNC9HS2dicUVpdFllNGhTUjh0R2lYYTFR?=
 =?utf-8?B?ZDl6QlhodFZzUEpTS05SSGpsWkU0cXlXK05rOGVJWDFmOE4zK1pTMzAwNW53?=
 =?utf-8?B?SUFHQXFHZDZiZ0xLbi9zSFpFVHkwMitaaUNVd01Jc1ZaZnVDNTR0ZWxJV3dq?=
 =?utf-8?B?TWhFRGF2ak5PY3Q2MnZ2QzE1cFYyMVJjRzFPSWFGNXBKOThERk9BdjVJR1pM?=
 =?utf-8?B?a3N0S0RCTDNpVjA1K0ZuRHdiMzZ3NHJST2VRWE1TVkJRZldSMlpGdDB5Q054?=
 =?utf-8?B?RVBIZnN1UTdZeU1udzFjc3hFT2NWemQwcmsxcnB5WXMvb3VKMXY0bVJ5Y1d3?=
 =?utf-8?B?MlFNVmdhQkJRdXlraWJNVTQ2UnpOQmdFVTI3Ynl1ejVhQVU0UjZ2Y0syeUM1?=
 =?utf-8?B?UzNiN1EwMnZKZzVHNnJXY3EzK05uaDh0NU82WGVXVVBnNGd2cGlEMG4yQXFq?=
 =?utf-8?B?UFNuaWpkaUlPOXFVNzJFZTlTd0MrSXJDQXJNR0dOVlJ2NFJnaE1YaHRGQXNY?=
 =?utf-8?B?dkZHNWhtbkdtZTFiQThqb1FwcEhqb2FjV29aaFVpclpjRGJESVp2V0k2bkVE?=
 =?utf-8?B?SmoyQmxpYVBvVlNuL09FR0p5VEdzUlIvL0c5V3VBVUR3Q2JDdGJnZE9YTzZj?=
 =?utf-8?B?Y1AxdXd0T3E4Qm9YS1hvQzA4Ym9BZUg4Ym5lQXkrMk5SN0d1TSs0UXM3VG9t?=
 =?utf-8?B?R2ZWWjZ0MWZQWm12WkIyTHdEZzh0UjF1WGgvK2dnSjZ4UUpuUHJxcHA5U2Y3?=
 =?utf-8?B?eEJGOStSQ091NFZUZy9XaFIrTkZDdTRxaE1QTmtGbjh3YVdmc01WVUQ0bFpt?=
 =?utf-8?B?T2pSN1JwTDlsNTBUWi9FQm9aTTMvWGR4REFoZFphRUh5dUNqeTEvQzRLNHZt?=
 =?utf-8?B?Wnlvc1lROG9BS3JvcWNpdDBSQnkrZGI0dmNRZ0QzWlNybmxXblJaa2xobnhL?=
 =?utf-8?B?UkNzTm1jMFFUTTdRSHNvelNvMXhBTkJOREkxcC9adnlWMjZ1c1V5NmN2Rmo3?=
 =?utf-8?B?UzhvS1JQNHFoMlpRSzcxcDVrdmVaSzhLM2lVM3R1emhTZHg0M2IzaHhjK1B6?=
 =?utf-8?B?ZkxmY3lIQk9mOHRVRnBkYUQ5aXM1VW5UT3FjTmNYUTUxd3FpM3kweXBUVnp5?=
 =?utf-8?B?Q1JXWnZTeUxYMGFiV0pueGtBbmUwd2VLUXVoc3lRTFI3dEFjY1hqbGRrZDFJ?=
 =?utf-8?B?c1RtZjRtOEpaaExrRlR6eVVvSHFDK0tSWnlQdm5jQ256Q1hyQ2gxQ09ScnAv?=
 =?utf-8?B?OENVOG01N2p4d2tHMUUzTHQxWndod1dVNDVEbjVFSGhESkdiWjZCWnF3K3NB?=
 =?utf-8?B?REtOUzk0bm93MFVmV1pVak9FNFJ2M0wvTHAxTk95eUlLOWtkL1JER3VGMUlV?=
 =?utf-8?B?MWNJSEtlbTlMYW9mUXpzanVOOGVhYWJ0WGZLelRDa1ZTM2tQUkNoZVhiWUFM?=
 =?utf-8?B?OElpcXIyRlZTanpHVlFDWmUvdHNmTEdkNHRmamxYMlViSUs5eXFyVUphSHVt?=
 =?utf-8?B?enE1SEVEczFmTEoxcUdUTWJWSHN4RGNXVFJBS2VNcE5senc5QVJVaFUxVEhZ?=
 =?utf-8?B?OVFWZmw3b2ovZVJLMjY1VXJOYnFab3cwUmlLcTdTK21PMGRzMWpXTjRnSVdv?=
 =?utf-8?B?Z0FJRUVhbEkxTGt4aHlzWkN5Mml0VjUvK1hoUHNNK1FCOXc1dGQ3QzZPa3U2?=
 =?utf-8?B?K05RM1J0U0JrSUc0ZFBGb1IzMzhmaXF4L21mUTV2RkUxR3pqOGpRdFZrQita?=
 =?utf-8?B?d214dW9STVhTZVVXWnZRVCtTZ0JVY0JHL3lCR04wdzNTL3F3cG5xS3VlcUV4?=
 =?utf-8?Q?A//8J5nS0mNs3Gfs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b801b56-07b5-4338-572f-08df14b99a78
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:45:50.4360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhWtBFOpeHgYXj+8epiEtYSSmhKqNqp9JbpGRUs/oUhxN9HpwZP5LoDXQ8OFrpStGEH3CyNvB9SNIHVOehqmwL/KbSUd1cGi4zlGEyvO4GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9749
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/16/26 7:32 PM, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 11:59:45PM +0300, Andrey Drobyshev wrote:
>> During CPR (checkpoint-restore) migration the guest keeps running on the
>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>> we should reuse the FD from the source.  The FD is saved in the CPR
>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>> target via cpr_find_fd().
>>
>> Use the (suffixed) device path as the key in CPR hash table.  Device
>> path is obtained with qdev_get_dev_path() and is essentially the
>> device's address on the underlying bus.  As any vhost-vsock device is
>> attached to a virtio bus, whose .get_dev_path() forwards to the proxy
>> device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
>> always be getting a unique non-empty path with qdev_get_dev_path().
>>
>> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>> Deferring the ownership handoff to pre_save/post_load is done in a
>> following patch.  Until then CPR remains blocked, so the restore path
>> added here is not reachable yet.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c | 30 +++++++++++++++++++++++++++++-
>> 1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>> index 3ec20d87606..34eed2ea997 100644
>> --- a/hw/virtio/vhost-vsock.c
>> +++ b/hw/virtio/vhost-vsock.c
>> @@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>>     return 0;
>> }
>>
>> +/*
>> + * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
>> + * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
>> + * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
>> + * which guarantees us a unique CPR name.
>> + */
>> +static char *vhost_vsock_cpr_name(DeviceState *dev)
>> +{
>> +    g_autofree char *path = qdev_get_dev_path(dev);
>> +    g_assert(path && path[0]);
>> +    return g_strdup_printf("%s/vhost-vsock", path);
>> +}
>>
>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>> {
>> @@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>> +    bool cpr_incoming = cpr_is_incoming();
>>     int vhostfd;
>>     int ret;
>>
>> @@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         return;
>>     }
>>
>> -    if (vsock->conf.vhostfd) {
>> +    if (cpr_incoming) {
>> +        /* Reuse the fd handed over from the source QEMU */
>> +        vhostfd = cpr_find_fd(cpr_name, 0);
>> +        if (vhostfd < 0) {
>> +            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>> +            goto err_blocker;
>> +        }
>> +    } else if (vsock->conf.vhostfd) {
>>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>>         if (vhostfd == -1) {
>>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>> @@ -207,6 +228,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>         goto err_vhost_dev;
>>     }
>>
>> +    /* Register the fd for a future CPR after a fully successful realize */
> 
> mmm, but if `cpr_incoming` is true, we should skip this, no?

Yes, you're right.  Haven't noticed that this bit is broken mid-series.
Thanks for noticing.

>> +    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>> +        goto err_vhost_dev;
>> +    }
>> +
>>     return;
>>
>> err_vhost_dev:
> 
> Should we call cpr_delete_fd() in the error path?
> 
> Maybe with patch 14 both are fixed, since it seems there is an early
> return, and also the delete in the error path.
> So now I'm thinking if it would be easier for you to squash them...
> 
> Not a strong opinion here, but if you want to keep this patch, I think
> should be fixed.

It might be easier for me, but also harder for anybody else to
understand what's being done here.  I'd still prefer keeping them separate.

Andrey

> Thanks,
> Stefano
> 
>> @@ -223,10 +249,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>>
>>     /* This will stop vhost backend if appropriate. */
>>     vhost_vsock_set_status(vdev, 0);
>>
>> +    cpr_delete_fd(cpr_name, 0);
>>     migrate_del_blocker(&vsock->migration_blocker);
>>     vhost_dev_cleanup(&vvc->vhost_dev);
>>     vhost_vsock_common_unrealize(vdev);
>>
>> -- 
>> 2.47.1
>>
> 


