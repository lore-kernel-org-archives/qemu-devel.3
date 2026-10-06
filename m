Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC1CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwK-00054V-9j; Wed, 07 Oct 2026 04:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHFd-0002ez-2G
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:19:38 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHFP-0007JF-Kf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:19:18 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by GVXPR08MB11009.eurprd08.prod.outlook.com
 (2603:10a6:150:1fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Wed, 7 Oct 2026
 01:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDZxUaA/gfuAiTsXO91iDgXB4mWHqgduuMLoXHGzU7+Zp/MUUCG2RqlYwPAodPh+yOF/OFvpyNqz4xHMG7Gj8Euml9/mkKAdgzop5idzd8nrO+69T95jx13fXy8I83n87EuSbwiFDmQAbCjLckVifz0jqSIOf06P/nmKXjPosvcgB+nXIiA8Q9b5UX1zLqXWbfm/M9oz+nY5RKtZ+N9mkXIWiXerpI7HPYNysmsSCKjgzy4gYFwlCaHh2TDwxIOSxd+Nh0OaHwQ5pBzE8J9ctkegGfUgbItoUabQlM//gtxXnBgDMfvai1UNE3qgpP55wpgV6C/UleTCnYo6e5zQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=NSwSeIfw73n1TAqtLL2usRPXOIC1xVH0ikpXnBYb0D0E0Hvn6Wv+P13mRadL4T//BFkummVdJtAWSRwYzMF6in1iA5duwBjwxm7xwtiuhaOn1GXAqkI8S7bUO4N4Hy8pPTEEqHjvGmZWixFzt64MTp0feqnHMWVDkX7fOpYfhE5Jae8DZSnig0TqaZdNEt39+qAIo6Y8pM4H25sBgE45bx54JA1hvZv12z0UUAPxJdAeU18S3jLj/zVfQtl3sqeFr8rxq8FwrrUOG8fJECopR/IEWpnCMOc3Xgg5rwZZvrGbuVkh4PFBcWEJHajMJkU3aLWPTsdhiDVeMhzhLQKdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=V2PhS73OWkEmqHdbElxQlbwVBgSitMnydNg3B3aK6BjiBZv+VnNK2ldOH2N5zekxq/uNSVKDNLB6qoxb0t/9oH/VchMoLJUOe1P8Aux5RUpiJhgVOp+PwL8if8Nx5AHG+G+vkbk2Gmip94eH8IgYE1ufHAmIjaoYdKZu587DoZUA2/gWtHXMPSsHZhSIrjQE7RgOQZu+NDpEh1nWGyZcNdY7ermrwRld0wPZY7Dj5gyaCjuFOMdYgXwkScFkjP6Thu09KDJN4ChAaLnGS6FE5V1hvoM8deh2N1J4oZTyrF3JZc1GbXSI54IF57Sm6fVQFnpWuji51foF9WVJY9OutQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:53 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:30 +0300
Subject: [PATCH v13 07/22] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-7-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|GVXPR08MB11009:EE_
X-MS-Office365-Filtering-Correlation-Id: 444bfd28-c6ab-46e5-5e2b-08df23b1f4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dBTVmfAVd7/laj4fzzEL9xc9VOQVzgyVdxbWWRM2eGsKu/6PsqOOf/BxXc+WmtUz/H150GuMM+sAhtbUV9Zf9tYzgjv6CXxBV5EcNbIyMDoccyaz+65NOM7jfmN2Zx33Ql79jVC3TSDT7OM/HC7+lzm8gTGIIOTk3qscTrf0DlQCXQSfr4RtbPs9W70jp1M3ibWdyeI5f4B7969k5i5bxF0cBouJxg1ttSXEVep2HexDnCxpejlcJK8hbGgGJn/6ZE5KHm8TTLPcgf5MCF4/jIynUAjfHH6fkQQYG2vvgfw+40r6NcZqDAp/v1DWE0x69OlOnE2WuZehI7gyXFvVfNmm5wxE2lToCJlJUQxr3MbqgY6lhPyCvIVgIePxhvoq1bjfBEPGuveevQmsvgXYlhhMngp009YTHfSbsVJFCWjuuNjHt5bgMHmVHxUWaH1OlRq1/FBFh2o+63d6HAR4kwfECS1OANwqas7uCVvSNRqGabLt2DG6CLIRxztWNkK5bBobTJNscfm9JIAFVhugtSvNHBjuY1/pEUzDKlw5aROr4iiLs2KnM3lAn6tDy6SgF0+BUZ6Zf9se18Q9p6YZtCZxdaywH9NIQim8zmZEnd32SWZl1spcJkFOD37FzAdV3AKApQXwjq/hWkgEHqoVBWTBUCeBFx47wYjmz0zdwhdl0E0Jketen9BC0ifLRo0KW5rQcvWXquxvXxhqLJDiqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDJvRWtsbGNLOUdRT0QzWW5YNE5JdXhoaWJiV3IyQ1hid09ZV2d1V2tseTI5?=
 =?utf-8?B?NDJaU2dXb1NNM2ptTGxvQWN0Ym5EVkNZQ2FjMituTzF6SWdCV3Fnb1krMDk1?=
 =?utf-8?B?OVNnS2hITnZpQ1prWldubzlnMlJSQjdsQm9WMGFRVnhoTW9tME9JYzdqWFk2?=
 =?utf-8?B?TmtvMlhNVTJaaS9mRGZ0WEQ4d2Rnbk5BMVpwZ1lYYys2WGJKQm44ZVpCUUlL?=
 =?utf-8?B?L3pOOFM0a2M4ZTlJWXJLVXN6d0dFa1ZTcSt5azJYRldSMjVDVm85UndZU2dm?=
 =?utf-8?B?VDdLQk4yQ1V6bE1vcTZ4eXphT3JLNk1makJZWDdyTVNZN2xOSnFZUUc1T3dS?=
 =?utf-8?B?cE16bFlrT1k4TjQ0RlZiWkkyUThseUo1cjF5aDBZN0VkSE5QQ3BlK0huT3VY?=
 =?utf-8?B?c0t4eUpTdVJNOFN6RGNRMmNqYWlRZ3loV1pYY1BvYzVCcVZ6UFhQY1AvTEh4?=
 =?utf-8?B?NVo3V25RaGIrOC9jUExROGZFNTVNWWlUNFBBaW9DcDhxa0UrbWdiVFYxRmc1?=
 =?utf-8?B?NnJvcVJSY05JK2J3RmJNOGxqcmlVYkx1VmI3MkxrcmIvV3FqOXFrQmFrTktH?=
 =?utf-8?B?MERFUTMxemp5aFF3ZGNPUkVvZ25KVENRdUZQc1BuN294YkxqV01UODdyQkEr?=
 =?utf-8?B?SXZiY01sR3E3ejI2WWxBNnA2WVZYaldmeUpnOUpPYTFucVZoblZzWUhyeFVQ?=
 =?utf-8?B?OXRDM2RFUHhIRlJXNmtkSDZHZ0hHZUlLZ3ZOWXBhS0FMYzFlMWYrdVZleWxt?=
 =?utf-8?B?OVpxTUNuT2tIMnZTWndXN1BtVU8rZm43UnZFa0ViV0k5NGYwWkZxVFZjWGRO?=
 =?utf-8?B?WWhXYTIvcndQUVJDVCt4UEp1b0VLd21Ib1o1cXZLdkFaa0dnWjlSRkx6SU10?=
 =?utf-8?B?ZFBONWd0RWhyUmtxOVBuYjNsbzFPckg3c0txNnZyUzAvZVNGWmxZRGlZcDlk?=
 =?utf-8?B?V2VOY0IrRGNmeGNNdDhjSHpacU9OR3ZHL0htUHhwK2FoWnlrbXNJUnFTZkNj?=
 =?utf-8?B?ODdsdkw0KzJWYjFvNFl5TEJrVDNUREM2ODdYbW1XZlZvNXM5OEdXQm9RZXRu?=
 =?utf-8?B?STZaZGs4Nkx4NU5zYXhmZ2JMbEt4Ym1KRGJtV3BTWFpzb0NFbVZhZDBaZk5u?=
 =?utf-8?B?M0xtcXpSQlFMVXRtMDdEbS9FYjBsd1d1ZFovVC9zRXFYTkc5UHBVOHpsQ0ts?=
 =?utf-8?B?WG1Qd2c0L3gzRjVtQTN3ZU82Q2hwR1BFQlowd3FGRlJVSjdVUlRxcTZhWFUr?=
 =?utf-8?B?eDN4TEpLL2k5am9HZnpLYVExbFRDMkRlWmhBcFRkQVk1Wm12bmJHQjJ4cHRN?=
 =?utf-8?B?bndNNDFrUHZyM3JQaVBFT1ZDaXRrdWtvWFFoZXZpc3RVN1Bob3M3aDdYSWJ1?=
 =?utf-8?B?Mkp2UVFQcGZGVlZuV0cxenVwRnI4QkFydW9GUUkwN0oyWFZQdzJNRnFuTjhp?=
 =?utf-8?B?ZUgydDBudEpnU3JraGhzN1VHQlYvZytIZUxJRXc4ais5WnpJUFlHZ3gySHF5?=
 =?utf-8?B?Zmx1dHE3c3l4Z0VQU2gyYmpTNXY0aUpIV0RJYjFFSUZLdExyaUVUekpkcXU3?=
 =?utf-8?B?WFJxRitaUmFzeVZ6OVdsQkVtMVpVa2RHQjl5N2FiSnVZdFVyUWRQcUNOM2pZ?=
 =?utf-8?B?M0hDcER5SUNaQU90clVxSWJGQkZObTQzcjYydUoxVWdqMVRBWkYwajJWSEh5?=
 =?utf-8?B?Z0ErNFBxQkZFaXZEaGVVVVY1SmxzQ1c4ZFA4QlpjVEk1dWQ0QUVBUU5JYjZS?=
 =?utf-8?B?YUJ3V3JPR3BqdC90Vmp6aEhqODYySmVXR00yOEpJbzdILzJ0V2pzd2hSWW5l?=
 =?utf-8?B?ME1vdnF6dTRlN3I2TnJyWEN1MzcxUXBCT3RrdFI4bytvREFaaTFKOG5IT2NQ?=
 =?utf-8?B?d3g1VVZyRFJIdWw1VmlvZTd2bnVlb2pmWC9zZ0hESVBOTWFSZkwrdDZ0UVZP?=
 =?utf-8?B?NVYrWkg4bGhlL3k3eFpqK2VNNDczaDlpYmlET0JqQk95OWZsYW1kNWE4dXFG?=
 =?utf-8?B?QlAzbXFXNXpCTDRLNHBFbHoyWllXR3BVUWRmajMvWExCZG9KR2MzS1pyTXBL?=
 =?utf-8?B?eDFSQnNhelovY1hkUHRleVRFeDZVRXh1cE9hZnNoUmxYcmg2OHFzcG1nQzNn?=
 =?utf-8?B?RUhJaW1tdlNQK3BhaUxSZStpcElCMlFyOVBlNlo2NTVqbmFIaEw1MXBBRlQy?=
 =?utf-8?B?dlBJbndtZ1V0ZEhqQmFEWHcvREk3NTFUN1lJV0Q3NS8xb0ZIN2pJQy9SUUVx?=
 =?utf-8?B?Y0Y3SWh2Slk4TlVGUWxrOVZucjhwMy9zeUw5NVIrUXJaSjN2NDVocGVZd01z?=
 =?utf-8?B?cHJCNVR6YW5hTFk3UWFZc0dQbHFsS0VQN292VEZvRFgwTWxFQzlmZVkyWGlU?=
 =?utf-8?Q?2yOQ6GlrTn9HmAd8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 444bfd28-c6ab-46e5-5e2b-08df23b1f4ab
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:53.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L/dwD73oesnav1NqAzzRAMb4L7naoJ6f+E/pf+AY+d9pm/lFNNOY5gOFsJmo4G07Ari2Rz5W+3AfZL+4M0pGCFdt6MJVA53YdFUxB/QnfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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


