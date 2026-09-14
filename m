Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1068C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FS-0004Oq-Gq; Mon, 14 Sep 2026 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FP-0004It-PI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:07 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FO-0005Pw-33
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:41:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Em85fz+jOsYDBMXJVyg48O5KRppLaiZXFKfuV65otsXG3TW7+My4m+DPjFoOnECoAIOt5bMeGEXD/fjVQhWYMEBvnAyJLm/rO8Ayoj8JGYc4Nx1bFshxxRXnaNUaUDfc7GZK3I5ma8CkconicaAi3SQKSkn4+jk6azgyNZNRLVPpjaSGkQNhnq7ht1n+aU6XZIX25DnzsSx1vUt7fzhJtngJAiUtd4eWca1LPYnF0059R+uCDhVcdTQ1n0xNnslp+zDiwyHPtPPdwP74dl/AVUjuwbnXw4y/bR8l5d5ku/27PasYrj7izFXQOYHs1j0kW0tQdekoWf46xd2lXVqJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh3+nr3NsnYKwwfIXzajeOgYUgt4kKJhQC2r2S3sh18=;
 b=ars0HNmHVlfaIw39P9AhbAkELDyyw0NExahGq6UCKV6ruKni2dvv4GCPw9OrRCQD0IrSEIl3Qrp/xR8DuTbjUyUm1iV9tNAzHMXVeLHq9qQNQVDB4DxwVqSaESlC+DXR8lYi04GU2/8TckSWZ0MV5MKmu229d8sb5/NUqT5cTvE/jZNOPjwDHJDx+eJGy5bvCLJdgZlPO9uIIAxFp/HtHJlQIvp7h8ASWxBWQRVG70PUDuHQSkvyHjd4sGxM7qKDRT8Ooi1Qr28rfa7Nfr47C9WAXBRCdbYWhSXKCbnnBTOIGJ6zOKTuOomTzc2+WHVtI245Qj/1eXvN8l/xREA4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh3+nr3NsnYKwwfIXzajeOgYUgt4kKJhQC2r2S3sh18=;
 b=if4OWFxFgE8ZAu+0RhjACX4lZyZ4kSb/fsWJi325UpoJmNnejbUNW0Jx9XBsCo7aO+5Za1jb4LS17YoLTzlHKhu5JNjLA0lRayMhlAhtAZd6hXc7rE9SGONZm+7Co3ZHz1+UmlknAuneQCot7+5DE3JkyS0oheVrsjs6p6BLjLHm1YVMyi+EcO+fLT0mM+hYnEQTxLzycJTdwOZqGq9ygjWHoCfsfP3C+uApG5bw3WqNNPNbuRykfJ7VkQA4gN+Q2DA80xG3OU/gozQBeSlCWIv21WuSQiBFw1OK4kXStDWBsRe53eSxSmZzp6FccesOXyW5XMXXbfi1wC8PqeARag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:42 +0300
Subject: [PATCH v5 11/14] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-11-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b76ac3-bf0e-4ada-4cc1-08df123bd33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: uBxvWClXjSr87hG82Xb68gT0z8fXL7lpKNyT74UzajAXQiCCjRHz+8lCNC15NEmPPBcVwc2q/F2N2afWKPBf2q0oL1A/n2/dvbBLIqANG4sMJOtuwm8rgJ2MHoZDEn6IkMvN61PduMCZPC1uCeWt7TMdgklL2PLE3yQwSB2+SlftwMaOmqyvgqnu6MS5HHvovZcE7Z8PEnWe/RTd4XpH6dQ309+lYyUzR8l+gRWpzksM+JTYGvZkl7J8RUKp8dN1gKSQMyH7Ffc29ZQ5c/3Iwjr6t3a1r6CT5WPFNhlvJn07JqbSdlfmgcpiO7AAwO237k03c3wfFum+SjESHKkEEcDFE5S8Nw71GGqFUkBYnrORJ3G2dPJcuV7gNC8HjGKH+NTzGm+D3Iaz30I5MGdHcz6djGR8aeHfXIklCDiIToLV+zH8UjnjKcqplSvoGb9DhLUv0Q085uz+zrjUMI/2jk5VvxVQj58gO7zelaOrW052o0EM2/B1jRktowudfxmBThurlPk962h1sesPHigsxhC4UBzJcmvt3BoUNHHMMEqJL/+W0KKJSUU9So0DXiJR8ry1KWdrzUfMSj6wnqsQj2gmkTLS1YhX98KXQtQTsgxAM0Yw3JIoX74DqVdWV4lYbZQNVTnXpI8genJu9XPA5EvwGzLND3dJh42moEg0CrWJV/BxIg2rXp4Gv9QUr0ASjK2zveXIlHCAgecZS1qA/mfUzdOVdJcZl3t/IX0CFmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1hGbUptMlk0SDRCcU10ZEU5SnRZaHVoYlU5N1JReGVlbjdDUzVseFNEQlFO?=
 =?utf-8?B?L0RDREFmMHhnd1lxdEdYUGZPa3pIMndhQTExOE9OY1F5dUw3bGdsK21WN25O?=
 =?utf-8?B?WjFPVXhlbWRLcWdGVmZybHZ3dlh6ZXgySXdaTFpsVUJyK0lkMXg0VXhSek9w?=
 =?utf-8?B?Y3lLcURtKzcxZTZSdlJTWkVYOHpkS3cvbHBnSkJZSUMybk9jdXN4dzd0ZmZq?=
 =?utf-8?B?bXAvbGFaTUtHblMzZmliakV1ZWNPbmZkWE9EQzl5SVRMckJkZWsxOHlNYjE0?=
 =?utf-8?B?Ry9QYTdjMk8xNHVDT3had2NPTldaT0g5N2tiTHVtdjFsMHNkd3FTbHZZWTNa?=
 =?utf-8?B?MWxmdlkyblU4ZjlkcTA3cTIwMEpxT1ZNQWlKN05zZFJxK0IrbVU2cEV3Mnp2?=
 =?utf-8?B?Nm1iaWxneFptUGtURHNMbFhVNUY0NFQzVFI2R1FXS1hpSVU1VlU5aUFqK29k?=
 =?utf-8?B?NEVBMkp1NGFpZ2FzdGlILzFMRHl2ZVZpWGNGMXBwVTVFT1VHRmltV2dCWXB6?=
 =?utf-8?B?Wmc5R3VrZENhdGdiVEI2MjNkVnE3Z082eFBmaWFIbi9PMStJbkI2TklZTUYz?=
 =?utf-8?B?NVhDUEc2WjlyNGdxcGd4bHZoUGhjd0NKekhwWUc4ZjNhRk5LMVV1Vm4yajRR?=
 =?utf-8?B?WjVYcXJ6UEVJMlVpYmJLODI5R0h5WTNRZ3p2NVNuc00ySnlrcXNoUm9WS3dZ?=
 =?utf-8?B?ZlVvZThzamxRQUE4cWEwQVVKUUJKSGE0SGJTeDBaNHNMOWo0SnJNeTRtcFc1?=
 =?utf-8?B?MVNYSm40SW9TQmFLSllRQXcvaFFHOEE4WGZZZkZHY2NKMDlIWlB6LzRKdDV5?=
 =?utf-8?B?S3JTbGs4aWlDNXRVSk1BVUcyMVA1WWxyL0FzWEhIamorb1BYWEM0Z0kvUks0?=
 =?utf-8?B?OGFacGFtMzNqTkQ4UFVMRWwxRVJHc29jb3VmTm4zN0lqUWVhdmoxNVN6UkM1?=
 =?utf-8?B?eDB6NEtuYmM5cDFDd2NKaDJNRmxPNGR2WEczL1dEaEx3YmVod1RST3ZRNWs5?=
 =?utf-8?B?OFVWTC8vaVhmajIxWm50Z1ZQNi9YOHR2Wk1jM1FTTEJQWGs1V2NSS3I2dURT?=
 =?utf-8?B?eUVMV2RrUUl5U1ZRVUVHRGMwZVdIclNHOFlCZ25tbXZEbi8vM1czMWVPaVZY?=
 =?utf-8?B?UHVuUkV6dDJZS3BrTHB2QmxSQnFMZldXN1V1VTBURVJTVzRJMXhTWi90SlBy?=
 =?utf-8?B?TlE0Y1Y2aXVHMThYQTZ1Z3RIQnRtRHBsb1Q1L1Q2K01ycC94TWF5NUJxaTJa?=
 =?utf-8?B?RVhnNjc5SHlzNEx2citDMGJJWmo3bFlITXRiZVpDZ1ZhemhXV0UrRjRSaFZl?=
 =?utf-8?B?eCtTRW5lTDFWdVoycjZyTHhDUmU1a29IaHcxZ1d3SXZRRkw3bUMxMDlNY2dK?=
 =?utf-8?B?TkRaSXRlaHRUZkxTUVZ0TTRvSEV5S3JhdWRrbVptSnlSQTEvRGJnYTQzM3dh?=
 =?utf-8?B?Q0RxWi81VVZuT0tNZXowcWtVSm1keEZkTnJYQ3oydWNlUGVVaGxkbGNKQlMw?=
 =?utf-8?B?MldLYjRpRHlEQk1tRnRYWHR2NW5uOW1aY0V3dU5UMW5NeXRZUFpRMzd5OUJC?=
 =?utf-8?B?dU56cFpJaDZJWVJzQUhQenNDY1RhVFpOK1VTQUxJejFlYlJFRzVMQzNySGFq?=
 =?utf-8?B?ZCtCc2hVRDNMNnhBTDB4YllHbCs1ZS9oSWhtMWZkRGh6VGY5b0QwVkkrUzIx?=
 =?utf-8?B?UzZXK3ZTYnUyWnpGQ2lZMnVBa010Z2oxejlKOVlNVkw4VHg4d1JSN2xzREda?=
 =?utf-8?B?S1FlRWkzWmlWajVWQ1BKV0pkMWJwU280ajdmZGx3Mzl6M0taRUpHbnB1Ykph?=
 =?utf-8?B?blVXVzBpbnNZN291R2p3SjBOemdUY2lEeUpZVkdMTnNzQXE4VzNkSVdYdWEv?=
 =?utf-8?B?NjNCaytsMW8xbUZYaGlKZnprVUJNWXJla2dhS2Y3blFLaWltam9nQTVyKzZj?=
 =?utf-8?B?WHB6Q2VrS01ZRGJKL1R3REkrNHNqblhuMjUxL29Hb3R3WVJPQUNtZkNsbzZW?=
 =?utf-8?B?UGJOa1JMSmdseEJJVkRDdDI1RUJzOTB1Z05Sd0MyaS9Jc0hxYzE0TW51OEg2?=
 =?utf-8?B?K2lzYnBpRXhhUVh3RDN5cnRyVGMwNmhZL0h4YVhrc1RQNnNGTW8vOHZkTzBw?=
 =?utf-8?B?U2txc2o5eXVUZCtlZkx4bU42cmVmUENOcks2UjN5WGQ3MjZiSkZ3aWJQNGVo?=
 =?utf-8?B?bWFNL0xxWFVieUZTQjhKZlA1OU05L0NvcW9sdU04cGdqbTlFeHNGMkI2NXZZ?=
 =?utf-8?B?Ri9kdnJBS2ZkSFN4alNJNlAzY3N6Y1pZOFVXbzczM1JPek9tSFo2enNERHZ6?=
 =?utf-8?B?Z1FuRnZnOVQrSjBqby9mR0NGaU9JN2ZHU1Vkd3JLdzBscStFeHY2Z2F5WW0x?=
 =?utf-8?Q?1zj1Gm22B0hiARJo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b76ac3-bf0e-4ada-4cc1-08df123bd33d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:26.7475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqYfOrqWIzevoyl1qWRREWbpPGKvKLj0bUNHWltKoOAmqE0a/HzlIu7M7kRXRzPkDDd4Sqfynp0PC9CzElFAhrfc8YDB//HELu0rrCVLd7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f9b54c46f93..2bb9a23fee4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1648,7 +1648,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }

-- 
2.47.1


