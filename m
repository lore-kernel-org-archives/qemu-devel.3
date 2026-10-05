Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54095CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCN-0008Mo-S2; Mon, 05 Oct 2026 11:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC4-0008G8-Ao
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:32 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC2-00056Z-Ha
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vENsG6lWcayd1/LMbF0g3EDI7ZUONSxC/nF2Ufo4k+S/rd4V2U8EaNUg+rbT/4TXv8orNVg1FVNdxJdisot4jIovaegSYCbJFvANN9sNWHXDHfbQPLFE3IISHqq6lIynHtAy5ub1ta45nKw4JBrDJLDpp21zVGFPlPOvRtJGucbiCtsVcqsWtFBAQjb9kfy2lg4gQpjhZ1NH2sG9ZSt/vnC39x9t3OVdT1CAjcpdRC2YWPcAO/5LOrsisb+fzUvuQWXvDvXWAJX0jWoJdyGuYgfKBZHTRUNrr9J3CjwJqqk+AtIzP5nU9d3qxqbRd1Y/GAjgqWyVj9uWtNNr9kYNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=mR7QYVzEp1uTmao7tlROW/LMqxQLrzLBsyqmncb+GjxFqeUUQ94UTinF2BGKjlqDw/PHmbrWY3ygb53lHJhM/JVenyvzL9eoSgrPO/Omod2yyGI/rmhkaLVqEk5jfgZhLRSqVhqaq8jWEr6P9uJVg/U29hUtD+b8gpDE7WUGvO64efq6QUFfoSv3yuRy5juiPacXCdE2uN2Rz1ok3f8p9SE07vRWvgxzT5VAGhnTIEx9CxGGCs/WzzScKWIOQLgb71j4cMplTwMs3y5k9bpGOVc35173Aa8NQxii63IPCKaqGJismU82BPRq1RCRH4BEqgHlbb38K0qanD8+/n43dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=vNwXU9sUR0GcyADJh/KbpuB87y4RsL1A5yIpOMHQjzZoK0ehqoxK/qs/sC3ur3p5Ur6s7uhw2qL9mWLnfF7LJ1xZ9fItBY/KHzCYZb8Bi5ZwzcbvenRhi13Aa5KHUCMhXAzWjONTU2zFP/iBNBzvXpLQioWvGNBG93cDp7U9J6lMmkfhVvFsyZV68gQP+JdHu9865DqkqPQnL7V7wAllPtt0HRObKGn4bM5AivqfbUdKMHwBcQdLul6KuXhf5xRBV80Ru63KMR0IrW4zJ/RAH8bzKESVNzlsP7uTsENfKwDAus0VryDnTdesvSv8+xJ0lxAU1i50UTNEoeHM4hn62g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:50 +0300
Subject: [PATCH v12 11/21] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-11-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a115c5e-6847-49f0-fc6e-08df22f18340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: zwo+F0V3w5RwblTRJ7kIbs+2hKUX9R9zroggNFu0zk1sqbxEkGYHo0o+FMRedEqFOl+vu8755DZzjd/LO5aXIdMgUPI+SSiD7atY+AxCkEioVYJ4wgsCmw6RKjRCpjy+VduDzu/nUQZQ8fCaV9sjljotKXSUluSEQr08mrNoxjhBHdyVrmrdM173Xg9bXzvU/19/O+TgHopbhqaiPHcN04CgEUDeYDjPAA8IpnAt2WJBqCgj3KMB8HaLz9vwNSTFMMQxSjILdW4LWUF5vO0uULmZSXGN3d9bfN+HUb9+u6POla5SHz3HVmzd3iVUw8RzF6c0Mf/w1cdcPtYj4nv8j0Gbt24f9y3AmqAaIaEAFZvaOGbjPbiS2XzcVa10RH7it3QVnEhk9cUsTH90asJCfVKxY1Ns6dbFucUE5pO4TdlzrF2avt+FVeoFngdX4GRoVy8LHIgr9bh1C5+hyMjFGMh7gD0RozHSkLG6P70TTCkwlcza/dZRAdv2JJLT0559uqboam22tnH3PW2qmV/WRogHmrSYJeWo5XMgl4RWs6uLzJQjCeikeO0bPW3/vBjqHixvZYDdqdauMohDtxttMqAr2+zoKRnX7m2QLFZ1dfSx0Ov37zKQ09T2BKJwW+mG3s1e6YCXUUvt5yM0zPrQHRaDU3vt1Mq0XkMe1pXkuVz1+tOFXjsMvsafMTIkyiGQchw1XbaiKhqyD7G6b7uJrd3IbJktMN6Z9jddFHTyEYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENiTmlxZytNdUNSNy9va0tseTVmdGR3VG9EVCtnVHFOQXdKeWY5NGlnL3Np?=
 =?utf-8?B?dThoUmh2bHFsQmkyOGJhcTZFM2hNN0N2NEU0U094UTZoUkFORVhDaUI1NXMv?=
 =?utf-8?B?SkRCQ1BSc1I5QmtWZkY2MjVNNjNOT29HUHVQTzFKQk8rd1NibEc0V2p2M3da?=
 =?utf-8?B?cTZ6WUhoaGtMNTFneHlRRVMrWi9XRmloYjBQMnp3MG5QWXJPTm5VRUx6ejVH?=
 =?utf-8?B?YXdIWi9FdGlsTVVsQ0RFT0JyanBYZjNqY3UwcjF6c0tMNFk0b3RCUzdIb3lo?=
 =?utf-8?B?VSt1WTNFSG4zcTZ1SU5JTGtVcmNZK3VQKzNtMk5aL1pOVCtzeDd0QkZSS3lP?=
 =?utf-8?B?dWhkQjNzM0oyV1ArcUJaZnNJRmJtc3p0QUNVbEdnTERFNm52U3lTVnhqRHpV?=
 =?utf-8?B?SWJ2bUdORTV4M0F2YU12dVZpdVh5UTlydEpYNjQxU0IxNUR1ZTJtQmxtZndv?=
 =?utf-8?B?eEJNc3VkK2IzanJlUW5rZlFhejhWT1lTd2ZWYnFEdENrazR5ZFpVUDRQRm9O?=
 =?utf-8?B?UmhDN0hRNEkwNW5hYWM2WUUzQ3l2UWR3R3NxRkNKRkVjam51b2N0U0o0dStI?=
 =?utf-8?B?TTZDMnY0Q3BQZTJBMlFlaDZybG1PU3lBa0FMbmpHaWl6RzgxWmdRWktnc2pi?=
 =?utf-8?B?RWxJSTgrNWVJc21ZYXFiZldtaGJBNHJYckx6MkN1eWlSY21XLzlVNzdTbGsr?=
 =?utf-8?B?SjFVMzVualJqRmM5YWR4Wm5QYW5mcVhoK09QM1NHbnE5bm5CM0lrcSszZ1ZM?=
 =?utf-8?B?azZvditVYVoxREtHdGRlTEM5Tm1oRXh6NitQY093VnE4SHJpajdjQi81VjR6?=
 =?utf-8?B?TTFSOGgrL0RVTHRZbERoZkpFaDJyRzFHVUFVRkxIWWFDcTE3UlFHRFNKQlJL?=
 =?utf-8?B?OVh0cUZwUFRHbkFKUjBwYi9LemMwdHk1TUxIMC8wM0hlM1JCSjNSdGR1NVlE?=
 =?utf-8?B?VHFZMTdJM1I5ZHcxZG5lME5CMGNvbTVqdGtzdFZzY1hyejYxbzl2dkgvd1Bi?=
 =?utf-8?B?Rm1PNDByblpGdW9WUmVSS1BVcmpUdnhXcjBRenpwZTRadnltSXl5akdiOFZL?=
 =?utf-8?B?c3NNNjJHZFV2bE9PMmxHd2JHZktJdlBmY0RLZUUyckJ6b2FVN1Y3eCs3QTYy?=
 =?utf-8?B?MjQ3VEZzTit3Y1BsYndmMVpOeWlwSmxuQUd5ZHZUMFBFTS85TWxqaXQ4dUNY?=
 =?utf-8?B?OEt6OVMyZlZrUUJnZ3RhK0tucWVlNDNkZXNxaFJtcmZzd0d5cmNYZnJQVmo4?=
 =?utf-8?B?STVvYnhaejVKTlRwV2dRYlZMbEZZZlVQZnlBb0pScTdKZG9iaWF6TVkvemxr?=
 =?utf-8?B?VEdLM2NXMHVvUk1pWWRmQXR2ZG95dXZrekF4eVdxY29BdEdGQmZvdlczc1pj?=
 =?utf-8?B?V1Jod1VXaXhJT1MyUXA1ZW1wYVVwOXdKaGhGZU5JeDhHSHRSMGNHQ043OXQy?=
 =?utf-8?B?VWxLTzg0Y2pIbWZqZ1d5cVo2VUgvcXpKalBzMWZQM2NNOEdXa1lzVElDeTJX?=
 =?utf-8?B?NGR1bFdMU0JxM3JWS3JGMHAyZThQTjJVdGdNRTNGeDV3YTk2UjJvMktEY1Z5?=
 =?utf-8?B?THJRM2RoUlhrc0dieGdwQ2VSWllOcU1taEhTdTdxcURsTnVGWE92eXVReXkx?=
 =?utf-8?B?VWVQR1VUNU1tOWN5czBGMjM0dFh6MU9kZkZaRkZFTjM5amdwUURrb0hEandx?=
 =?utf-8?B?YmREMncySnZBRjQ3MG95L2NnVFRDYzExMER6VnJZUThWeDlvVlNXRlBkWUF2?=
 =?utf-8?B?d1NuNUdNOGViTU1mNm9nZTMyb0hzV1hFQnJqWFMyQ0d0SHhjZVI2VkVIWjh1?=
 =?utf-8?B?bFhXWWlmcVV0UXBKQTNINDQ0TnZycXBycEo2UEwxTHNRZWE0a2dBQ2pFdDhV?=
 =?utf-8?B?UHJhTnhYTXhIYWRnaGdDY016V3dZWHlkVU01dUtDeDUvQTNUMWpRMEVYR043?=
 =?utf-8?B?dU05ZS8raDdkOUtFcEhwTGdjSzVManBGeVVVbG85Vm9vcm0rWjA5cEtHamU4?=
 =?utf-8?B?QS9sc2d6QkhmRFBUNjg1RWdBRExRM0xwamJFclZrMUJmODhmSEt3dVpiNE5v?=
 =?utf-8?B?cVorbXUzaFlIck1NQTFzdVJtRzE2ZDV1dGlxNkxvQ0ZvNFF5L2FpTkhldGZM?=
 =?utf-8?B?azlRL2V0eVBTbko3U3E2REtBcjBrajBJWWxicmNyNTdENWVTaHRoUGsvQTBE?=
 =?utf-8?B?czJoNHZxMGh5TnFpZUlzeXZ4TC91WWdwSFpaRDNEUDNxR3g1aGw5N2pQT3ZO?=
 =?utf-8?B?SHQxRkZERVVudVM5cnEwa0tYSlg5UUpHRmFPcHF2SFl0Sk9NYitJaTJVQTVn?=
 =?utf-8?B?S1F4dElMR3FnTUFOWkpET1JDbUN4UTdQeGpjVGlLdUJxQ1l1ZEQxelNnTUg4?=
 =?utf-8?Q?fmIlOm+3TjZepRmo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a115c5e-6847-49f0-fc6e-08df22f18340
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:19.5296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYah4MEx77ClUncsmAICS9N7UeEaUz70Uz0SOuz2Gq13G3M2tKdeFv8WbI44TOm0LopAP85wcDTLRkzXydlpK+MJ5zeIFg74jtFYzhBg8FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
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


