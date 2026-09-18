Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC80C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwK-00035s-0Z; Fri, 18 Sep 2026 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwH-00035A-Ul
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:42 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwG-0003Df-5g
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4C8eoggcIa0cFzcm1XzfWDdLDHasITAQXN+pTL3TCnc6+oHYKFezVM+exXIhouHC+pnFWqJLLn68fF5BhI8bFpiPFuCiXmYn2PIk82n8iiF0yY+x32vIzNHBnHNjCbgVzYVqjjPnH1GM2kBkH+QtBlbYIbtvvcZMkFo+VzMFWDXMZGNHlWx8UeRm6NAsTAzq+Lb2HiqsJ7//zcW7fUHSAC98KL3gWHUz65IMq7tY5t1sxpX8WfbPeiQyrIITUFt47vlpzbAQV/Kufj26yDnLplMlSLQ8rHxODQ09XXKtEUiMFOvTUfGt6amLcR3pRxe3ZmwWlhKXmDALo/ktyQbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=sERrHUP4YTgQ9U7et8DP+o68ftps0d2EX0TbEI45hzLAyfdHxXIdI4G5lThBcX6dMmcn+aHAqWi+8t56JLHKWSOgCkigqYa63GarA4mSo1vMhwqikxnfycoRRGojct5DIbe59UVLxf55o8wYoW7Kbg7kAHjm4HFrVd1DsE6UL6JWKyiNkIbEV/B1r7CzUrHXY3okPgzeWqIZfGLQ1OIpvLS1UY60A2rmLHVGG0QRW/UXmEb++H/E8vujjmwvC2R/RvqeciWSQvpYFpVnznHDu5lyVe2zvQA1KQ9tzCJLWiOkK9vhO4rl5nhmlmDiGDUzeWixaKbFA73dgH61Ten9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=yhxWFZepDmu96mDK9ER7QgE+9EBNlVF3M1PISDv/+Tg12sd4S5b8aQsM1x+CYkfYiM9r62gfKG86CHm2XXe5gSn9votEbVJijME+Vc+TjMWgLOPdSG4w0LY2T3t6XbOyrzB3fvDWCXGFi3MypBU7j89IrfCFJybXk1+el1K5xdaIDhK9+QACJlbybi5387GceYC33cRcy2OpuZ1WyVZzy3MBPDtyZ9IZFBkuEUCWfvbw3//A2pzQZQ1dPjE2a0ZnINPovCTgNEac41wk5Sz3JRm9w4EGub7TXswGiU83ksbsMWuTxa8Ad2xCuoUphP7pQOSylVU60Ji8uc8/KpyHYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:57 +0300
Subject: [PATCH v7 06/16] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-6-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b3394e-40fb-4107-14a9-08df158b5cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: xnSmsULcaLFwAF6xJsRDMBf2gswOicXnbC552AXcPS4LmPhl2JGpHJ2pGRnHliXeR3rz7EZ1ZdJgWE3v1MamA9AvSDC56ft/G/npN1ZV3hZXZA7zeEXTNoKR/BT1drNktVukAM8Hd2D/jKDimaTI2PALPxZ2b8t0/cH8DQHsQUVUAYHlGnHvccW2sb/M8RgKi5jMZlb1mv1T8DHXfXHp7aYbsfefaxW1GbQ2Yudp8ldRmg7WSU245d4c+0TEBJrlTxmmJffv851z7MPd6CkODR+GWhxH4/0btayZ97O1vdksVLYKjgtF9SD4GxtNCUx3Ft0CZaYoJux5GAxyupMtclrseQxKyPJnaI3/SlxKpyi+DyfFLrzPhF/WhmIuUjR7MSQS94qitqf9S+n6G70gNR50385u1ermwTeFjDpUMf5sh847ER7PKcoDMyuEHST1Y6a20ZZNl7a/A7yfwi4vQFn4PcFS3JCS7IVTbiDJMhVztqA51mQYyKXXgb6DTdvB40x+MqwWRR7m59wi7RWTzHHuYJLJkU8G4Ze/tWuV/xGiVbJQPIq0XsIxcSZdzHxJTLOEGa58KStOYHo4+wVe3ouAxWSwBx4YYxLZvn3eBkeIiGwfseUh2beIURpRcPI3wQoqDF8iuROCGpL2/FVfyjBpz2JLW/37JHCHzl7DdzhlvcMjmwXchuCchtEou3gvlgqAEHjezT7GKR+7pOkhBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lXWlN4bGVPK053Tm9OeHZRbnU0Y1owbXI5VjhPL2xBYUFid1ppQVkwY3Bu?=
 =?utf-8?B?d2RGRzdCcG04WmxqV3FiZlN0dC9WaEJRMjFrTjQ3T0VYcnZMN2J1R2dRODdl?=
 =?utf-8?B?ZysxaGdsSmVOWjIrcXBHQldoTkJuRWlYenF1SzZyd25EOWtUTDRQckYrM1px?=
 =?utf-8?B?Y052Y1lXVHhkbVBlQkUrQWJCcktCRHpQb3ZYeGVLVFlTdTBsdmFNUzZUaVFJ?=
 =?utf-8?B?YWE5a1VUZVdXWFlxWm9UVVBCaTloQ09SelR2RHJsQkVpMHdUWUd6Zng0UVJp?=
 =?utf-8?B?U1FxUTFLeXgzWDJjL2tKZy9ldWdKOGVWamg3a3orR0pPYWF3QnRXMGRkS1Y1?=
 =?utf-8?B?blRxeHhMdUxoYjdFZ0JjbVlSWitMdEN3c2dsakR4b2JaTXlOZUhUVFVsRGtZ?=
 =?utf-8?B?d3pFWE5EZmFjemE5VzFVWmx5YlpVdWJKRW52NWgwVy83dzBTVUhqTUV0UnM4?=
 =?utf-8?B?d0lPekg2dU84bmNPa2ZNNWI5dHltOE04cllSaHBWZytQNzZhdlNHc0xmSWZ4?=
 =?utf-8?B?M0lvTnM1L20wYlpaWXZZdCtYNWw1LzhDcnJ1aTRFVGZuVWN4dDNsQk4xSm5l?=
 =?utf-8?B?cDI3K0VxOStqYm9oSlRtWDJ2bnRXSFcyTmYyOVN6SmVoVEc5YU05cFNRWUJE?=
 =?utf-8?B?OCtLSXZSeVFTUk9vV0d0SDlCZ2VOYUhrTjZSTURneGQvakZ5NVp1am9NRWtJ?=
 =?utf-8?B?LzJHeWdBcGtEcjA3SVJydTV5Z0h5cTd4Z01DeVQ3eHRYdzNvdE9TSnFQeWxo?=
 =?utf-8?B?QlNIbHBGVHNCR3hDK1pjZjg5dW4yV3JwQWt4WTRhbjhGOHdDd1J2WW9vcnZs?=
 =?utf-8?B?N3d5L0k0bnd1UTNJM2JRaERCczRqSit2NkM3NitnOS8rS1l1OFBZU05WZk9y?=
 =?utf-8?B?c2RIWHFOTkhDSG40blJnTUwwRTR0TENvS1FGUyt5akVnOUJ4ZVJhOFdnTWxw?=
 =?utf-8?B?VVkwNUY3VTBpems2V2pPWHFKVW9IM2dpdmM3ZjFlaElybURyMGxodFNlaTlk?=
 =?utf-8?B?aTZKQVlCMXZVbHhGakRFS1NNSWJnemdoS1VLMWFGS1EzRXZDY2xmQkZCQ3J2?=
 =?utf-8?B?NDdlYzFiMkV3dUR0ZjBvdC9VbVB6WW9HZ3BFQ2d6NmpjdlF5VmdNRDVnOVk1?=
 =?utf-8?B?REE3TzlYQU9ycmdLVkFDRXMrRnZBK2FJcTMvYnFBT0J2alhpVjVHT1RWNHJQ?=
 =?utf-8?B?bEZobGJaalpPWnVucHFRS3FsMEhFTkRZbmNrNnM5M3JwMU5QRFBqOWVVbmZE?=
 =?utf-8?B?NTVGaWIyUFhGK3dCcGxUYXlwMXhjcDRCdEcwSjdFb3RBaFVtdDR1OXJFK291?=
 =?utf-8?B?YjdMZmN2cktocXdNUXZlZXlsVDU4VVFXRVpWdHZ3ZXduOGdQajcxNWtKQlZw?=
 =?utf-8?B?ZFJSK2NWaEswcHBuM0w2TSttSkVrTmllN0RSSCtLMVlaWFhxY01kcm5mV0dm?=
 =?utf-8?B?U2VBc2FPMm5FYXp2Ym9HMkwzUEpzQUJBQTFoSFU5YUFMRFFEbHNEU3U3NnlS?=
 =?utf-8?B?TVZuek9SUHRVL3gxcjFGV3pZYW9CL0o3c1gvMnRKWE5EOTJUTFZIRXdmMGNU?=
 =?utf-8?B?OFZPQkl0cDA0WjhjdzVCK3dQME01RXl1NVNDc1hhSHQ1eDBaYi9WNlJsVS8z?=
 =?utf-8?B?RlF3ektyK1gwdWZ0YlhLRkNCT2hrc3lraG5hWFJ0elVudFlFdWNyM3hkSTh6?=
 =?utf-8?B?QlhVc2lST1ZHaEVPMmxQYzY2SzZZSmwvTXJDczdicVY1MTJlUnd3NUZxWWwv?=
 =?utf-8?B?cnNSUlIzVXZ1aFNxTVVhZXJWMk9kcWdRUmpIaGtBRENoQ3dyMFlLTVNmdW9v?=
 =?utf-8?B?S29VSG0vc1VaUDM5RVNvMFMyeHlyZEtSMmVvLzkzWHNBWGZuT1cvd28rYkts?=
 =?utf-8?B?UXBuL0dXMUNEYS9vREVGeFgvd21vMXJpQmI3L3ljOUpGc1BuV2xUcUdxUzds?=
 =?utf-8?B?QzljT2hVQzA1Q0NCTFNYL1htVGsxcVprV243YmJ2SkZxcTVwc016S2dYSlFq?=
 =?utf-8?B?UXhmeDBZVVhxUVBsbE96enlvRzFCM0JpYnY0cjlqYTR5WXVRcGhmU1U2VUtB?=
 =?utf-8?B?Ky9CL2JQbCtuZmdmUTJhWHI0VENnKzhTZ2F3cHRSUkZKQlM2Uk8rdHF0QTUx?=
 =?utf-8?B?cVlkMUxoaUxlNmx5cjFmVHgzWFVJRXRxaGNlM0cxbWNRTnZWaXBuR0pDRkJ0?=
 =?utf-8?B?VThsbjNSbTNGM1dzV3lJaUoycEtzL2w2ZXpoM1dqbFRzOHlSUStZcllyQ1dp?=
 =?utf-8?B?ZjcvUWhxM1JsZHZBREhMeVRBaEQ0dlVhdG9YVVdGeXVkYUk2ZXRJN01malFm?=
 =?utf-8?B?U0RrQUpaS3FmbkJyVDJRbk9NRHNPcUkvc0ZWWXdvSkhKU25vWEYwUUw4RjF1?=
 =?utf-8?Q?SuejlSLMZd2dQ8JM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b3394e-40fb-4107-14a9-08df158b5cb4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:21.0848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS2CMxuAln5ni+dSVFr9Xv/Of//iCmYhvwR6NPABa9Kp9o+d6neyzwBBOb+oSv4RHOmgNgScFal9hkgbfLK7s43xXQXoKhnawgQhCknVHHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


