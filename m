Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7856FCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKL-0003KR-Pa; Thu, 08 Oct 2026 06:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJy-0003Fi-IN
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:58 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElJx-0000xp-1H
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQV0FL4mtKcPWVrdhtHSCNrUnCCbgVP61XOP1YuhE2m44s0AQ6rma0AqfYix/c5tLNJg0cRacWsqGRfJzdfELKxkOtleyDSmTJ5begQTPeGg3qAV8Ex60hpvaXXIdEi9z6ThCzm+G5EB4neJRVTzyVGwcetn4zBb5mm5xx6Kg1GwLLfpcbwX/Oh322yppN8n6NRlPsQCmjSfpy8MHjYEpszwLZazw3BPf9qPJdqYxibXxapc82iQWNudTywJvamdCGOMbE590a0m9k/DHUN0sGgykDwL5ak2Hi5ApiZT8eOE1VLcOiUfPAD2ROv2FbOX0qS+oXaw93u1ERA/m40V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=Tio+zeVnwlBkiLP5Xg0npxJbqskovW9tVMZyfi2gNHGpHNQpWsrTCb1Htu/VwjvwlVDY/RrNif9/Ecaobs3BNEiY50WXT4HvA5RBW8A/ctltTzZSJyfLeKvRn44vB9kbb/lCxexauWrHt/n1h2bbtdxUprnrR91TXnV6VICBITFeAQHe9OorQ2NNu8jFsws4q85UBCKYhkrGQNtsqf1rDyuR7JddxNGjPUe1Ukq3vpf7e7D5R2fUUlBrbEn1MACJ3q1a7RrOpyKE8Ci619SWdqZ0ryVAclWXPjpMgYNGF85Vp6JPy9xydEUC5BAS/II7Q/zYbtioDKakqVWnTJM1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=rDUGTOtrJ05vSl6B/z9lySJzJQcsgmQSgP8oHHSZIBIdmWiMRFD2l4d2IlgLQP/syuc9wV3vA5HTmZQrYzlKQTPNdUBkpGOdNJaQE4b/p3K7VRRsQrwaMqLfq8nHUp6KW5H5KO2ZPZk2ECHcA4W5VlhhohMDg0HTel1XJtBFnDbovm43yDlUkisxWLn3NMSpXaO+viGux/ZQB0NFybvpGcsOspMH2zxzu9NGkDKfYg9M8FBFMi/BO2Sej40yqoMfxjyijP52/uotpolO/SwK2M7oJ+BPjkA+EunAVQs0e62oDAGxtvzyO6p5lro+6NnTGNs2TNKGnpORa/VVI/WyRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA6PR08MB10593.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:25:41 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:41 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:35 +0300
Subject: [PATCH v15 11/22] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-11-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA6PR08MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: bfad5392-7b22-428b-25fe-08df25268058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|23010399003|1800799024|10067099003|56012099006|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q5gbubUfDcpH5fbUek7+2DgO01jtEVMq6oYYnZN9weuBhIqUb8hpBtYhX77UkIbjVIm2LI6JsBlSn/HTy0fIs9GWvPjk1BBNXAx/kJww2dY38CWKwLyzcVwoxlkRM/TxQpABs1W6z3MGYj3Zqp8UeA1kHiainCkN+dxPrQY8wfXJIppRrxFAhxVURGlzaxV/KsXsDOWWusDfTQs9hnlGeDK75nqcsXaXDWugOl+J7liQ3nQu/e46OJsjGQj/5+dPXLGy25CAea/IepJnppeAf+yxuiz33aD9y63QH3ofUisEFNe9PWYfYAlp1M4Uv5jjad2aYcwCEtvqz7bUCmb9JAGIt5kZMgrp9gRmXfwzWI8ObHCUEx1IG0gtozF+JBL+bMkOshQ1QcuNQGxD8IMWivgPRTdJrTywi9dv8waMI8mj2xvxbjMWwDiKdR9vUUq/quhl14AOhxqBYCS3CEMDKN783zkYFNQWKMlwdb8Q3rOHk0Oy3/GxYMlgMf0TQVrnpOGtQtXQ1XKBPFBT0/yJOvf/QtJ1bdlBxcujvF+Ln+lOClkCx2HP5MEK6HHW7J3H+B28nSZu6GVMlW1hLQwsAxKT3G0UBxDthjcXvIZqrqLUKxKgUbQtWJ0kVwn9bB5N3VcR3Ui2BAtGaozG8F9E4WC9HGl+52jYYsvqkcG5/ETTJiOKrEvMHfxKjuCci9Aikc8CMPZEVXFZ7w8Sc9Hrvp2GSYoZfPQdcEyCREfR1nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(23010399003)(1800799024)(10067099003)(56012099006)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpmWk9TV3JTcEsxa21EVUJKVUdFWDl6eHdNN21FaDhXOXNjU2VIWTE3V3hy?=
 =?utf-8?B?R2VVOWZ2di83dW1DTTAxNUlTSjZxbUpzZU5TWmV1c2VSV0gwd0IvaUtLNVpy?=
 =?utf-8?B?MEVNMVdHeGZCZzB0QW1UREExNUhXeHdhZlNDVkN4TVhpYWFPY1ZLVWY5Y2wy?=
 =?utf-8?B?T1o3L2tnYlNmRHI0aVBIOG1ManZPZlE3ZzZ6U05pNkJuL0tDYkkweHBicnZj?=
 =?utf-8?B?L0plMng1ZzBmeGljY1hueVhYZitjYzlGeW8xQ29ITlRxVHRjM3Mrd01LTlpP?=
 =?utf-8?B?RkptenVOZjJ1MUxLOGVwN1Z5Mk5EeEtycVFyWlkzbTdpTVpyOXRsNldEaVpF?=
 =?utf-8?B?cHk4WlFOcEJKdS9uVWN6WXQ4ajBHbFRrU29VN0Z4Z25lM3hLOW03SkNqZjN3?=
 =?utf-8?B?SkJQTFE4Sm1jZEJPUkwwbFVkSFIwYUNQM05BK3JONW9kTXJJRkprQ2htRG9z?=
 =?utf-8?B?cGx0L1Z4Q3NtSnE2VUlocFg1bXpVZnMrcm9PWUN4dktDcU5IUmJyRnJJZDg5?=
 =?utf-8?B?RjMvZFF1U05nMmtZKzM2TC91eEJIUEtXSjgydTdCSEhMZ0dsaVNBMEs1ZklU?=
 =?utf-8?B?dWZxdHZKL3MzME5VODVGRUhjaWU3dDVzSnJmRU1PbzFsOTZ3QlFkWWptb0JI?=
 =?utf-8?B?dk5KdzNSVU9DRkh4ZWRVYWJCTkhDSGN4QVlUeWlOd0ViT3lPeEcxMVRxbVVF?=
 =?utf-8?B?T1p0ZExabXVFWENxSURDMW5zWDdXNzZNb3F1U1VENVM1OVhWVG5TbVBibFIy?=
 =?utf-8?B?MGpVano2V0l0RmpheHZCeC92VlRvcmpHczRwRE9sS20rZU56Rk5lUE0xUk9m?=
 =?utf-8?B?U3VVcE1GZUwyd1NKZDc2YWtJZVNMSFo1dWF4bzQyT1F4N1kxOE5HNXkzRkpF?=
 =?utf-8?B?Ym1CRkxST1Zma2c0ZTQwSFRSN2pxTnJwQm9NWW5ST09HK2V0anEvTmkzNGx4?=
 =?utf-8?B?bFdVbXpsalZDMVpzODg2M0Q4VXh4Yk1Ob1lMcjFqbXoreWM1S0o5SWVhMDdj?=
 =?utf-8?B?ekt6Z0Q2bEZVd2d0ZFJZbUdvWCtKbGsvMXRuM1NEWksxRVhZYzRjR04ydmlk?=
 =?utf-8?B?RmhwZFh2a2VaL1Jya3djQUp5MnYvWWpsNVNuOHZROHlldmozWTJnL0xDMi9I?=
 =?utf-8?B?ZmlQTUtCN0lzRkNEZklMSlpHa2I1NDZ4RHRJTzhtbzBhNjdCZTNCTFVrbXFU?=
 =?utf-8?B?YzFxNTNOaFR6TEZma2FLdjV6K3RFbWJ2eHkwSjFoa3duV3VqNnoxZDFBekpj?=
 =?utf-8?B?MUs4ZEtqK2xTOUh6OEIyQkhYZ1dSek85TktMUitoa2MyZTBqa090T2N5YWF6?=
 =?utf-8?B?dnBpNGFrUGpmZWxrSUk5WWpLL3BvRjVsR0tIbkZXeVg3a1JuaWlET0JHNzVE?=
 =?utf-8?B?WmxNc1FTWHNuQkRJS2hoTE91NUx2eUtJZlR2SytsUWh2d3lsb0ZSdy9URHVL?=
 =?utf-8?B?V0xzWGo4RzZBTGU1WUZGQVFZQnRTY0ZoL1c0elltQzJDVm9yTWhHWVd1TFNm?=
 =?utf-8?B?VXBjQSsrNUxqY3h1TDRIL1VJRitBY1BMckVsd0hhaUhiZXA3YXV2bUI5cG45?=
 =?utf-8?B?dXllZDI4TmZoMVF2QzNuQnh0ZHFDVUNYSGI4QkEzNWtFbkVyUGFCN25seTNj?=
 =?utf-8?B?QzlwbHlrODNXQld2ZllEWVk0VEoyUlFvSkVpYnZpRTUvaExYUGhZcndzWnNk?=
 =?utf-8?B?VTBiLzVvazJSUWZDb1hSeXJFeVB3TjRBZWlOMzNWL3Q3SDF2bjZyYThySXEz?=
 =?utf-8?B?aE9PVTFuMWZjT1g0a3lPMTAxLzFLTTN1U1VGTTNOS0VUbjM5OW1wYis4RTdy?=
 =?utf-8?B?aTk1dFYzUCtuenp6RHJOWU1CWnB2QUtOQkR0ZG1ZM1d0RlgrT1YrY0kyVkFH?=
 =?utf-8?B?NzJ6ZWxydEx4WkFnZDllRW96VjIvdHpHWFFNRDlmVFBSMXpaclFNMU9Tdkxt?=
 =?utf-8?B?NURXa1pMeVJjV2hwM0VJLzdBZnFpRmV2TkZLdGJqUjFxREhTMVZnK1c2OTc2?=
 =?utf-8?B?QmhrRHdLYUl6Mm5VY05EenZXU244QklsazZZa29DNGVWcnpoRXVMK0NibkVO?=
 =?utf-8?B?Sm1qZjArOUVrY0p0MzVLcUpNaHpXWk02L3Jkano4ak8vbXdSMFo1QlBHQTE4?=
 =?utf-8?B?YzlaanNXWnhIUDN3WDI3U1hCazZRdFZTNDJqRUFPMkxhTjFncjNsSUhzQzdj?=
 =?utf-8?B?MGNoV3U5L1hienorNHN5VWNYV094NTdvQm9YTzhDN3lXUEc2Q0hnWCtkVDNT?=
 =?utf-8?B?Y1ZwZ1YzdHI2ejZZb3VITjR2RGNGcjU3SXlma25BM3pvVHFXUmdJT24xK0dh?=
 =?utf-8?B?d04rV2p6aks1bXN5cWsyamZsaWJ6UW5wRFZVbzUvWXY0aGRzWlByZzRnME5B?=
 =?utf-8?Q?pgD1rlEL+b+oPU0A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfad5392-7b22-428b-25fe-08df25268058
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:40.3402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOvCnwr3/VRwOvdhFUjvr5vUMJGerIMRqU0Zy6v1raqu5I2DIcSuCkh6qifW1u6Y2dj2dMPQSx8T2OzhnRQg886Tgq8UzjdChsq+lKeUL1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Split the first part of vhost_dev_init(): selecting the backend, calling
its .vhost_init() and reading the supported features - into a new
vhost_dev_init_backend() helper, and call it from vhost_dev_init().

This is in preparation for CPR restore of vhost-vsock, which needs to learn
the backend's features at realize time to negotiate them when loading the
incoming virtio state, but also must defer taking ownership of the device
to post_load.  vhost_dev_init_backend() does exactly the pre-ownership part.

As a result VHOST_SET_OWNER now follows the feature query rather than
precedes it.  This should be safe, as no backend requires ownership before
VHOST_GET_FEATURES - the kernel and vdpa backends do not check ownership
for it, and vhost-user already does query features from its .vhost_init()
before set_owner().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
     return r;
 }
 
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp)
+{
+    int r;
+
+    r = vhost_set_backend_type(hdev, backend_type);
+    assert(r >= 0);
+
+    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    if (r < 0) {
+        return r;
+    }
+
+    r = vhost_dev_init_features(hdev);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "vhost_init_features failed");
+        return r;
+    }
+
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
 
-    r = vhost_set_backend_type(hdev, backend_type);
-    assert(r >= 0);
-
-    r = hdev->vhost_ops->vhost_init(hdev, opaque, errp);
+    r = vhost_dev_init_backend(hdev, opaque, backend_type, errp);
     if (r < 0) {
         goto fail;
     }
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_init_features(hdev);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_init_features failed");
-        goto fail;
-    }
-
     limit = hdev->vhost_ops->vhost_memslots_limit(hdev);
     if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
         memory_devices_memslot_auto_decision_active()) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 0a322efec1d..b2b644c0d1c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,28 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type,
                    uint32_t busyloop_timeout, Error **errp);
 
+/**
+ * vhost_dev_init_backend() - set up the backend and query its features
+ * @hdev: the common vhost_dev structure
+ * @opaque: opaque ptr passed to backend (vhost/vhost-user/vdpa)
+ * @backend_type: type of backend
+ * @errp: error handle
+ *
+ * Select the backend, initialise the backend instance and read its supported
+ * features into @hdev, without issuing VHOST_SET_OWNER, setting up the
+ * virtqueues or registering the memory listener.  This is the part of
+ * vhost_dev_init() that precedes taking ownership; it can be used on its own
+ * so feature negotiation can happen before ownership is acquired (e.g. by CPR
+ * restore).
+ *
+ * On failure the backend may be left partially initialised; the caller must
+ * still call vhost_dev_cleanup() to release it.
+ *
+ * Return: 0 on success, non-zero on error while setting errp.
+ */
+int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
+                           VhostBackendType backend_type, Error **errp);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure

-- 
2.47.1


