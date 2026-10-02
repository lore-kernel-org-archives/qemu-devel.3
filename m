Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03706CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuj-0000zI-2W; Fri, 02 Oct 2026 09:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuQ-0000sx-5m
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:42 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuO-0007Qg-J4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvYGRQizQ9RPub5tgB4lX+anez43mEYYuva6w3gXiCZt5KklomL16/aUO5/YSkDXmudMxqFDrMQqRF6NSj6P21IjEaCdqZmjcxKMr5yQr4ZB9AB6swxYCHu+tiPUBuxC8Ak9xKK68oY/x/UahlvSgbCYV5+tGD7EslBl+/m0PHbMTst10mbKnqkm4L2odDZMDnI3FceBRKZ+KfKmZwv0f7erVVpGxhP/7L9Unwkiv3VhKh4RGUWmSBfIOQb579gItRbhtFDfGTnAa/NiHJq7UL3qwIztDdEpInL3Y3myt3vUKIoX080n+ouFOU3k4Pox9SC6PUzwoEO9aJ/lQ4whOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=IDUxW5BdyV74yJKUuJrt2O5f+jcjF1qWQWVBHBE9lNvgf3Pi+aosOmVn3+KY1mHCZmeXOlfrA9JiO31zuUtmrf5/XRBXysRVrf/zCkl8kvGzSj4Lh+U9Mtjt8hgr6nd7PhTuJAwQPML5RSGWbivWrpcv84d0DGBaiOZEQ0ob3rwOKOC/u58fzbwfmgAsaGiFeRVb8yT1eekMDqIf/CtsLEvuaArow5DV3uUnkjh9jT514ikqTuXuVz1nn3wxv6e3KAMUJOnHmPwF2j3fZSoPoSrJrxPySCnWSFrwwn1BKbX5/qw65bopXWAQReqTqW8SapmX1/Qe6dgiQoEvXhYA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXhh68le3RfUJjypRVq8x/GzIl/qjsOycrfUzYBtG0=;
 b=uVNRdrrlnHwajet+HD6T2+wcYONN3Vz7G7dKj8tGv+YG9/sMqO3WpnpeQq3hBvGxvrwXahn1wEurAkWCo2rnbJeqgRrDL2EimqCJwcp/Ui/MPCySKUlZa5F7e4IAAw5B7wGN8uYxrcomcqyUeJE/foTXEW68kixyDoCK9jzhXJPAGC4YpBj9Gt1e90FtOyqBUeoesaewCZ71yMLN9AFFPOJTC6XbHRzjblTXs2KL9yKD4xsRCWK50xWzQHFIt+4nzAJYjf8WSEvj9kg07Wg52JIopky9m7xaAPBClkJG+eY0kxVQNdmGvxRwWJr9BABkuN/tsplq7buhxTHyQcZ7jA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:28 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:21 +0300
Subject: [PATCH v11 12/19] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-12-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f56deab-d458-4b34-2097-08df208569d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dAaa/qaoNwol9W135E1WP1X0rMEjyRdaU0fohgg71e3omYlQEOwxMUt9L9RFalCC95W8JzDKKUL5fBQ4rByMdvFhWekQuxeoZp+qqy2rgUzWh91FYpEIgoxugrITsFObwbN2In/6APk1Wmqnn4pV92UAXijp/wehMGnio2w7EXirKOQS7uv2RS+p/VDeh7uZsyET+yNFyZvQ9Qf7D7GrMj+wa3amUcjcQ8HqPrFQ8oOCIbDuJPpPSjPfiOcxcB8QiABPdSohFxwr0eakGIub+ebkV/lIwWKBxdYhRZDgDcCC+h/DLpztj0JpdRNjVf3FWdnHZpnix8FlQpmxPg214YSp6mI1Mk9bBZR+mE+a3+F77nfZedjob/9k0k5V9XYDPj9h66km2YqBC7Jc87dRSXbv6xUZ/4fdcQ3wpSVnYkd7AwJMFQhiu7JSr50b0IcKew7Vq7NdCmuYRKqcHbHfk5MniXoXvYsFMCaDCr1c7zk0U4H78Dg+Ol9oFMnfFrJMkpuR4N2wOiCJo0a9B7A0BBI372T/uwzLbpAdBn8jBxV/F890q5bWr44RfvOWgvMiMPbYyJ1N0ArxK454No4oT/yQU/yWL2NMGTaIuKxCa/6IdAoU9nJUvDA2hbfK6pS+XMO3jBUp4a8YQckB0ha1RCmpDBXrzXzBuz65PhObCfG6y/zZU+mi/9yn2AWtVRupSnhfx47RzpRB+LVxiYh+Hj71exenL0OLv1STuo8C4ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVBWldFRDlLdlRwZ0RJcWtlaW9RRWY4ZmVBTmE4cmE0Znl4d0hKNlA1cnhC?=
 =?utf-8?B?NEhrQTZKbHo1ZG5lTWhuZHh4THloT2trMWNnZE04a0pPd0lpc29Md1M4V1Bt?=
 =?utf-8?B?RUVENlpISW1Dc3ZCRkNuRHZKRTZGR0l4b2htcWhMOEU1UUREb3ByZld0L2xq?=
 =?utf-8?B?eVhZeW9xUVVDVHJtZ1l5WFdTUnY0L05ReUI4UjRWbHAweVNVdExqZ1ZiM0FB?=
 =?utf-8?B?SjdiNUJGbmM1TERDdkF0OFNWK2xQNVBoMDJ6alBDaVZnODA0b001Q0M2ZitN?=
 =?utf-8?B?Q1Vpcld0OHlJVzZJODhQSk82c3FhaE1DQ0lmYnE5aDRSd3NtNGdvZlRPUEEy?=
 =?utf-8?B?cGd1Mk10R2dUT1B5NnlqUlQvWHEwbG5XMVR6UkRneUhoeEJ6REUvOGUrcFNX?=
 =?utf-8?B?dkZ3NHk1M3lhQ1ErU0I4Wk1YbmwvMnU4Um9QRVBIcFRxL2dNMUJZQ0Z5Yk9a?=
 =?utf-8?B?bm9qQXNFejAxOW9IOFYxZ1dnRDZHLy82Q2lrUWZMb3FOQjhFNlp5eXVncnRo?=
 =?utf-8?B?b2RsWUV0UjByYmxtamZ6bElDWEFkeHVyYlNkbjRQME8rTUJXRU9iYmgrdVZr?=
 =?utf-8?B?R1hFQndmUkZCTXVrVy9zcFRodWlrWmYzaDNjR0NmYnNSRnlQeEtlbHBHeFVR?=
 =?utf-8?B?MnJHejNmbXdCQkRWMkU3RTRGYVZEbXJTOGtGNFBRSUp1UTFmUWVFR1ZNM3U5?=
 =?utf-8?B?NkZqZlEzYWlBVzBDTUJwMWZyY1ZRT0JLbHNWaGpYNWIrZEN1bnU0VlNad3lu?=
 =?utf-8?B?UG9iZTFNcHJIdjZkUXl2akQ4a3dMdVZjL3pKYi9GSHNIeFNjbkdGMGJTcGRG?=
 =?utf-8?B?TGxra2VjVFptUEpDZks1djdKOFpPM1ZZeU9UZ0pZb0VDcFhtcllkS2YydjUv?=
 =?utf-8?B?ZU9YN3h1elRjeWJaLzhRMU5XWlNGTG5LdzlleVNMSmZINWtLRWNNdDVyYWtz?=
 =?utf-8?B?cDRJRVhmb1VIVFV2a1FyZ205WTJ1cEgzT0FidXdQSXhwQXdtRXhsQmY3Zmhp?=
 =?utf-8?B?YmdzVGEzSUJJNlJ2Sk5ScXVJV3lNbDlnWXAwTEZmd1l2R29NTk5OcVRqYmJt?=
 =?utf-8?B?SWNqU2NyU3IxL0tkT0N2STVqbDlVcG5sVmYxdldYQzg5eXU0NUp4OXVMRU4r?=
 =?utf-8?B?TkhpUnJCbnpMQ1VkeWNBTFJ5bXFUMk54V2RjYkNPVlZEaVZkRVhUZCt1YWsx?=
 =?utf-8?B?OEVrdVhVRVhpbWNLZ3Q5VXRyZlBXUmFSZGNXbjd3M3hpaUlXbTV4cExTQnpW?=
 =?utf-8?B?dE4vaFlxR2poNTVDdGVlVEx6Qy9adE8rZFYzdjdnTFFnemgyWkVQR3V5dTVF?=
 =?utf-8?B?THkrakpQYmtsL3U1T1NmdU0yaTZmTTdSbXgzbTMzY2JWUkMwYnNyZHVETEoy?=
 =?utf-8?B?dDZKUDR4RFNyRS9XUDJ4S1o2SkoyeDZrVU9Id3h2bzFENXJrZUM2S3dRUUNl?=
 =?utf-8?B?bWkwOC9ERlVXWnlhOFpza1l4cUlKODU3S0pKb3BOeG8zMVh3NHh4Z2YyTytK?=
 =?utf-8?B?Q09zekVEVVJ1MExOQmQxSXhmSWptNzBpQlkzZmpuazMrcXZvZzh0alFrTkI2?=
 =?utf-8?B?ZmVLUk41YzBUT2xzZzJKU3BSSGNtdi9SL0dTMzZVMEJIcm8wYVdCTFBCMkVQ?=
 =?utf-8?B?MFRqNVZNVVJMTHFKWGMzNG1rZW5iRnRYRk1aVjEvakpnQkd4U2dYY2g4eW5C?=
 =?utf-8?B?bXpBQWhTVVFHbWcyT0xBR2NjV0VpanFsOUVPTnNrTHpQSjg0allFQWlTbHQy?=
 =?utf-8?B?eUJGRndDeTA3M3lzSXJPajV5a20rRFFyOU0xemsvZ1Z3TlBVaVpyeUNKTFpW?=
 =?utf-8?B?aVJuMGcwRTJQSkhkQUppeTBOVzBEZHh2R2JrQko1ZHpnRW91d1lvSHB1TVlC?=
 =?utf-8?B?cTE2SWliK2xWVEt3SWVVVGMvTjhzS0V5OUZ6U2FSQWFlT08yR1RHTWdpRk5w?=
 =?utf-8?B?dlh1aWZhZjlHbjZmcm1RQWVLdjRKQTJSYWNWRkdSQWhySDRrc3V6UGJUTnc4?=
 =?utf-8?B?T2RuQ09FbjZmRzh0NTI1ZEcyRlpHSnhLZzU2MW9LNDNBYkVCNHJjTzIvdEFF?=
 =?utf-8?B?bUlGLzdpRWV3MjJxUEJtN0xPMStFaXViQ2p2NXI5elcrSGtMTHpiSGdRUE5i?=
 =?utf-8?B?NlpXRnl0cVFWV0pTclJRSGNjSm1aeGU3NUszY2grZUIreWJFN0dLNHpHbElN?=
 =?utf-8?B?SGQrREFLOWZ5QzZCcDNaK3ZyclpXWEdvUWJsb2xhYnJkZ01qVXVzdGttb3VJ?=
 =?utf-8?B?MW5sYWxmdCtUblpqSzVuS2dTOTlLaitpQXpCVDJjRUJwREpRVmQrVU1mNjAx?=
 =?utf-8?B?OWtFbHhhYUZSTXVzTEI2TVVrUDBhU3VicHNQM3h1WGQ1SWlCYU41djRoQTRx?=
 =?utf-8?Q?VFugLevDY//ANxN8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f56deab-d458-4b34-2097-08df208569d5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:28.9513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHXIo//frSNABuzP5ADGATrA4cSQlv8JwhOJQeFVVyrKC76DDpyqb6pEI7IoZje7skxXPHpPTmCWe0hJ2XaX3t55/GvTUQMdNKmJAYfn27o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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

A device which only went through vhost_dev_init_backend() has its VQs
not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
would crash dereferencing it.  Check vq->dev before use, so that
vhost_dev_cleanup() can be called to release a device whose full
vhost_dev_init() never ran or failed along the way.

As of now, there's no way for the cleanup path to be reached with
vq->dev uninitialized.  However after a subsequent patch adding CPR
support for vhost-vsock this'll become a possibility, so let's prevent
such a crash beforehand.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99561ac5868..dfdfd49da3f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1661,7 +1661,7 @@ fail_call:
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


