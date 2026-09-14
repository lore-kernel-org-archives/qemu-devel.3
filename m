Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A905CC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62FJ-0004Ht-Bw; Mon, 14 Sep 2026 04:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FH-0004HS-Km
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:59 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62FC-0005PZ-Kq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlY31r6cHiXkQgARCUZ0h9YgkDXClUPu8/McAHWsRJKx2rn0uWgrjqo+WYBGcXNcqXAXj0CoS+ApCp3TtN5z/9enRDhaiMPPhG25Ihk5MprRkuwsgGN22a7lPgO0Yv4HnbipnzbiB4AeWGN8E0h6wqqCh2R2thU4teAi4W6W6cY5Hk+LM76WOfPNn3+Mk28V3Ny0Ya5a1KI8Y7YdFz2cVWv6K9CHuXHjyM/wCi7Q9YVZVBEMNFxJOOkbfxmufyEkeV+omogPAmDbEjcN9/4lF+jH7aVIlFeF8jyW2vf26383iy75oEwecaf1fDNMmyZR8JqbYYMQxvlEh6oBtcrrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XkSxBHoCv7p59LbVsSrlCGFIdRh3oKtemL7pKK240s=;
 b=Y+Mab3xPXge2+jLOsR6VOjHbAP8g2/kNJtuh/cmTR1gY5iWRd7PJ4pPVdgW4jl9A05PD5yBrgs1StZ69N9efGcCs5hbiSEcZPFN7EenL0xg1RUu9IfHt/FRIhbSWtA9GBWS02guwp1PnTQFGWnB/3ftfmVHANvi42EtRFaKZ0QlhRX90i2/DhaQmlPRlvPfcOa+nkw8K+bRjPr84pigj4rbiFre2ObpkI/r1rk92iWi4a6eTOCIfGSlqGeP2LCzCdkTg5WbWUrz1VjjJ6nN7cd0qmUWXvdxXUyAGIfaBTY6RiR80fEaIIrTeTJYXjNEcugufhaqghwc8vmwyEk0z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XkSxBHoCv7p59LbVsSrlCGFIdRh3oKtemL7pKK240s=;
 b=RJRsg0gFVC/UcEDUXIFOXI4IzVRZj30jObY5qg9tGfvl6qbwkXgY317HCtGr07DN9GaLwydJYMZzIdPkrPGKdy62i02Ndxjx8Tc760nPbupRfKedlrsiMRgnHFfphzgxsQtl7rww4NhGcXYqwznt5Ady8ThWmASEFpJSk8ZuKDemyiNC9wW1IdzzJKAGcvoxMv9Qb8UKbG79rrmPlF/Rdg2cdqsO6GS4Aj9q61tc5Q2U4dBtV3iAIo769J+xcbvKSIxsFNZtSkOXzmebMN4JzAOqRpxqXjXRIiJoZxa0lXu+Unld3PZ7I8NmU3qgzmjwO0FSYtv2T5uFOP8BpKFYcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:37 +0300
Subject: [PATCH v5 06/14] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-6-d17423589f48@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0089a009-b14d-4dd4-3f09-08df123bd173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: hbxeaIoPq624ofDx+yx7TPhKeZ7Qfr+0tUn2w0XWiI5XEIAvMHlu0AtuOXgr3/O1jAGmPppNh6QWM2ObnDT7EncstECYyPAiakfYXTYHW3JLAQi4fUr18G10FPVQWINKDFMMqHzX4BPcbNs6Db7etnYFo9N8I1Wm1ySc1cSkorZO+3WzfvBRVLOr4GpBwnjVglZUVDAK1LwoiNkt1T7XcP6BZDXh+9OluAOk7U/dZ0FiH8EAB1GVPaVRg7DMw4t6rSr/Sop2NC17hGwa0AX4dS5tqfdVTU3dbizNA09nw/q+B7C96ynJSrjBTEPH+lsDRQeylqACzzVSCJsL7s38iy/O7d06EsLQhIWSDd9PpjVDwxgbbSB7fg5zQaS3s3tzLH1pyDp226QE2hYiQ8BbvwqPqR1av45QGsVyUzP2bgYtZ85bj6Kh5l8QJB7GWd5uShl0r6e270UeIajzkMtFJMZ9eYO04GilSKZloRwpK7K9ORmGGxLTy5PoMZnKXBO4UgCsI1+tpovwSx7wrcSJZ74/R1iAnj8TguwMrFfiDOStSRQQ6SGrJqaWibgdKlqZE7zYEv01twWhj5w8e6dxeCtsKbpIgXDwplgToEAzbNmi2QduDZhbIpGKRl7tiTLRqMF8Dfl98Cb3lygsi/6NqNGMhyTsVXXJt0B4grAzibd8euxuZOLrePS5nAbZgQNHfxYzzvru0lmzf/+1cqZyQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9iRmJLSFIwNzlCbEtxcFdGSFhOSHJndm1tbnczb1FEbFRtbkt3NWx4NkJF?=
 =?utf-8?B?Mllsb0FpUEtzY3VGSFJYN3lzSldPOWx4Y0V6MjV5RnA0UDQ0ME5sWk1vczhC?=
 =?utf-8?B?MWtmUEhsZGdhVFZFd0xjNFowL2JaTlRUc3BmazZpay9qVDZhT1N0SG5reWFo?=
 =?utf-8?B?UXJvd3ljQ2VCZmpZRytmOEg0R1BpVDVlR05aSXJYVXJVWElvMzgrS0ZxSXVI?=
 =?utf-8?B?bE1FK0c0dUxteEV1cC8zcVNmOWYyTHdSNkZpTnVFallzL1VTNmUyQjRiRmZU?=
 =?utf-8?B?QVBDbHJtTWNtclU4TDZPbDVWc0ovM1lydTVQVkFkbm1rcElEQ01hWmEydVBQ?=
 =?utf-8?B?OEhPODdwUFdTdHFhVC9FSEJ6V2RIS09tM2FySDNGZVZWWFUrdlZVNmEwZnZs?=
 =?utf-8?B?N0RZcWk0aVR0a1BuZXYzWUF5Ri9mekRPUVk4c3VGSlpEaXBmTUcwNC81blE0?=
 =?utf-8?B?Qmtmb2pTTXJ6b2orZ29TMk9nYmh6dDZjVDhoT1l2aElWL2d5ajlQUXhCamhM?=
 =?utf-8?B?QU1yZHRpTkFZSXRxNWV2NmJuZ01lWVFRdHJkNmp3YzFDWm4vaWZoK3gybWt2?=
 =?utf-8?B?M2JQekp2OU9rTzFtSXpjRCtPTXdxNmVFM3FSWVUyRWhxWXVBTDZmNElaZU0y?=
 =?utf-8?B?akErTkFmUi83MDdWcEVzSnhEOXRVVnJ2dkxoSjNXUWx1amZlRm5MVXBtbk1v?=
 =?utf-8?B?SldiVU1PcG1YZWJuM3VNSlRkR0pkakJZMXFCR2tvK1FTRnFmeEdtaWo2bGht?=
 =?utf-8?B?ckQrN0VmZDRDaGlzQUhtWlpQUURFR0xYQU1RdGt4Q2RnNjJ6aFBUSWNFOHZW?=
 =?utf-8?B?UUpjemc4NmhYWVRNcjdXSUJONDZZbktnd1UyZkRhdmwzeUF6UjRJd1FiZ2VJ?=
 =?utf-8?B?c0VuWDh5ZXpxUE9pakdKaStvU0ZVeDM1dFNoWWlNd3NzMnNIakJEMEl6SjdK?=
 =?utf-8?B?SUtnajZXbTRHYkxkcmxZcDFOQndLSTJkTTNjN3ZkaHBHVi9Gcmk4UW5wamJX?=
 =?utf-8?B?OWFoejlRTm1Ma011ckRkODU0T0hnK2VSUjExcUFUajlJa1BSMG1XTmJ6TGFC?=
 =?utf-8?B?c3FCb1pubEhlYW8rMnBld1pLZUNxck5kL1ZHWmNadGZNQ0d6WEJCOWExa1Ji?=
 =?utf-8?B?cTlaYWJTR1lKQTVyZCt3d2kzNnNHTTE4Zy9HeVl2QmpNWHQ1aVRkVGpwQ3ox?=
 =?utf-8?B?cUJaWURtaXVWeHdHeHN3SE42eEVQem9lV3h4M21IVHNBKzdVTnY3UDFUVkI1?=
 =?utf-8?B?RFNZV1AxSUpHWjFXS3d1NjNWNHIvNjJsdlZzdm1vRmNrTEFQZjhMKzhtUnhh?=
 =?utf-8?B?Nk5SS1NtWDMxRE4yVncxSE81SkpqTTlLMjRtSm41MkNCMFFnT1lhS0dBUzFJ?=
 =?utf-8?B?NzkrL01yTFgrWmM3RXh0RklFNWMrdklaRjN4MjFubE52VWVIdEU3djJoc3JF?=
 =?utf-8?B?TUVVOVQza0x0NW9QSWs4VEFXQ1N3TGUzbjZ2c25nWjVPcWVzYTcxV25Cc3JO?=
 =?utf-8?B?b1A0Mk9WSlNqTWVYR2VpallXdTA4b1l0aG1PNHU3ZzM2VjRZZ3RSdE1JRi9z?=
 =?utf-8?B?aHI5aUthbDVJL25ReThJUmQ0dTErM1dnb0xpQWxQZS90eVQwQjBSQUV1eVMv?=
 =?utf-8?B?MWtvN280YWFjQk5leXJxT0diSXlSNURWK3ljb0wycEpuUklmSC9YM0pQLyt2?=
 =?utf-8?B?S3pSalkraVRkaUQ1NFhUQjZuN2U4bU9tTFE4N0x4cm16TXF4U09lKzd0bHVG?=
 =?utf-8?B?aEk2WTRwNGNzMU1CYk9iTUc0ekNqK1h3anlsWVRWTXVja2xVM3BWUmVHTEpv?=
 =?utf-8?B?SWkvb2NjZmV5cFFQdWhGN000QzI3a0lMWHZjUGNkUzNqQ3QyTjVBMHlJRzJz?=
 =?utf-8?B?V0U2MmY2d0ZFTHRvYWFBVmlwZy9pa2JCeDUzUUh4Z3kwUXU0cVNYT1JTQktE?=
 =?utf-8?B?Z0xvalUvaFh3cllnTTNWelZPR2p3UXR4eCtadDk5TXhDb0RiRVVwbG1wdGpH?=
 =?utf-8?B?Rm1yTjJpMFJQck93WGpxaCtTUDMrVENwTGM3bS9kek5mUkpROFNoempLMUZv?=
 =?utf-8?B?V3kvY3BjcXpxUUMrNUF2eE45cWgzTTRlcURYSFNrRHhHUUs1ckNzaEVvbjhL?=
 =?utf-8?B?Y3NFdFZ0QXhoaXhOcTl4Y0JqaEJhQWxTdjFKcUZDbEVNaGdYaWhLcmJtTVNH?=
 =?utf-8?B?Sm1RQmhzVkZ5UGFoMUJDVCtmb0VZdXRWVEFYTWZGTlM1UFFJQ3BvTUxYTUd1?=
 =?utf-8?B?V2UyaitsM1JSMFB4NDEza1VmK203UGRHUjJYTkxnNUFpenp4VGZpR0pEa2hW?=
 =?utf-8?B?a0RYbEJoWHk1RXhObVc1aVBuN3JoaXgwK2dHbmtoaXYzTGVacGloNEgrb2dR?=
 =?utf-8?Q?sdDzfQUk25f3W/qM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0089a009-b14d-4dd4-3f09-08df123bd173
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:23.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxCCy8pSpT/ukmWn8cPZKQtBba5uKxwiWvyR2k4oFJaR0po7wQDws7FHnOr43/6OyCenryNo1fbXLHHwKEIj3Hgu/OnvCEz2RrhknsV0L4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
index d878d7b733a..a8ec35f6263 100644
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
@@ -204,6 +205,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


