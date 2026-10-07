Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128EBCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwf-0004vf-Dy; Wed, 07 Oct 2026 05:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCL-0001MV-4H
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:32 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCI-0006sq-S5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfiS2FOnVq1tzYsA0nQhYaBeDyVnrLZc/2enoMmSyEeRmbRMLuPuyi/QPqVcPMHQ0koWD3lNHtcrcrgKBGr7HI1dz8nCImt4QstFCe1B+2HhZ8yJDJU1z/MzsO7/WWR7d0HiYlXwaClWZTVjh5Zewp3TgHh2VDLYz2bkpcJrp75bBvYTgvfSdXifyEhy6R6gQNtCa9H3/K6WbuYWOD1U++I3DwojssoU6ApbJ9+uIp72fvUG0IK8qUJfPL37wBngBoQLGOcN6Ndd8xKwjU8jzXeXP6P0mDGnjUDItEp+DeHysImpVS0fMacKiHwXPIeUsentg8QNFcWeLqjrD4zBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G62jEWL4p8z/zj8yi4tqUinfBr3w7Nq5mP93gBI9xq8=;
 b=wo8Kl+IDVsy80HHVCOnpuSfaa+VRcWDIFOzu9Q7o40cXc5kvgZF4GIcdVx7Dd4a3heKEu99jq0P6iI5Z8YcLYn09gZwNglYwuGV+VWwjzHZMQLwsnmpYAtkaqZPobDkbFgytbU7k7OHcDYLWZXBZlp/ssh29W0hHXtgkmVA1o3oVIsqN/g/R/1cTVadqU4+IT+BdDQ1sONnsuFe9wJelz4Yux1Mz6Ww+LW9NYlAUTz7hX+KsuVULMlciQmyOLdW8y+ODFa01EKAhr2VtUY1PK2qobtEfKGcSFEwqKht0YyGMonoar8C+Omqwt4caWRUVkXf+ZnopDED81b4zCODNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G62jEWL4p8z/zj8yi4tqUinfBr3w7Nq5mP93gBI9xq8=;
 b=UnCECIn002ei3VgmiCxa6P+pRFCt6xOT9/N2hfs0NPo5rrSJDJeoBf7RzWwoIDnV+q023FVgWKbCXx//SPnBEfyDnyXakraLjMeH1sUUy93o4uI42MaMBol6UkhoOYgpqg0WKh1xQTrgK//itR2cEdDSN0A+R5yrczlUukjZBObJHOKxX0FvjJuvHorGULkgde8ZEJBiqnPxbLF2zu9G4cJdC+g/YWumPsl0RPSHJbBUkbSif+RTG2oPZU9zo1PEED3cEfP3WNOcw3wEQ2mCSuiAXkcgV6kqETy2pR3/dFRwQM3L9r4YKUH8UVY00HWZ+R7HXQwjWckOep5lPvZsnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:08 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:08 +0300
Subject: [PATCH v14 15/22] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-15-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f37d3c-7823-410c-dffa-08df244e9779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 5+PQI89NG+15dNSTsdSCCxWnysFPp4Fgh9duN+vnqP1sdDTlggb/+CWIoqBRo3fQBP2Wlbo95MQBPl74Fen4gSSZlDp/0bEDROKlX1YUziydm/0wtavzVdKyYZ6+ccNKwlDCETD27JgIz/nQ1DqU1dDRWjUqXXVIZ7TCw1N4X+WQl2An1WjEQe1croNVopOm8ylKMTck/PvznjjKWIlVk1v4QCIyibymQApyH1MVFtVmO5f8r6eQmM78YdZQwl6Ihrg/3e4YJ29rtyvzKgtXeYPP+uKZaLNtuZUVT/E8m9Mx1qiMFXQ3oN0xxlS3xrUg9WsbT/pnIEcsHHyKuj2S4ncSqEXG/2vhbHQfxWW7c6xRxunjuuJ0kNS9DBxlEMEjKXcVWIbFclJb45Vr/HfUsy1tmOpCgmybzHI7GrbS+0x1M2Pkpuqkshh9LL9dhs3l2ZzTAKWvg7iq1qP1UgIukaNPVT/6DPI4euZ9mA86YZihGj2jbX89F6qSiqJwH0G2jlO+Nfc+DvB5yU7LQk6dln5J9hJSvQtppAuzn/gMzLrp2SBLhCNjnbdyDFtYerHNKKxSq1lbsZ+q8q6YZv3ZynR6tIbg/AfXY7OP0TcVaB2kIbsjDezko8phYicl/HvLavapqpL04/8u1dkOc3T7/4E24PtQgkgoOnovlFR55ip07Ju9g6bh43kM+1H8rXL5373Sh5mRVuvgDaXuddr9elWVajRnIc8jycnNYnKKCGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJHbnIwNDYxbGcraHQ4MHNVS3NPZVFHbTRVSG1WQmxEMlMwV1NaZk5LQTQv?=
 =?utf-8?B?M3dud0JLQUcyY2JtVWl3TDNsT0s1THhldXErNDZJcGkxU3FMR1NPQis2OFpW?=
 =?utf-8?B?NG9UVGJSVXFaZFRoQ1hmU0NJYzhhSHBaSmRxVmdabUg3ZmVDcHdDUFIvYiti?=
 =?utf-8?B?TkJWMXdBOFNMVkYxaVpQcHRvWm9QMHRqYmppS2pmcnh2N3lmbThFak9lQ243?=
 =?utf-8?B?ZXlJM1lXbVI1U3RFaXZRUHJCdVd1WXpTSUVHT1FBc2MybmdTMnplL0ZLS3JW?=
 =?utf-8?B?UHJjSlpjcjRhTjJYdzlDWlZmNkRjYUJPbS80R2NrUm5vMmc1UEYzdnRPRUdz?=
 =?utf-8?B?VStNeDRKcE1GeGI3THZPOFFTZHlTMzNUeElVOWtQY3l3N1VUczNoUkJzUjZD?=
 =?utf-8?B?d3hjYk5JbEhnQmp2ZFNVLy9Xai94R0dWUWs2UVIxQnMya3UxdjRzVHJ4U2RI?=
 =?utf-8?B?L0dCLy9OOVBzWmJvRm9XME1EKys4cEdYUWIxMmc3V0dUYmVnV0ZRcGJ0Z2tw?=
 =?utf-8?B?LzFvR21JbTIrd05kL2hsQlZuaXNjZkFUaC9SMmVpVzZaaGhsSFg2Qmw2bWw2?=
 =?utf-8?B?bko5bU9KQ2xIdVZJSjM2c2phWk5ZQlFGK1p4UHRsL21CNzA1TVkxUEIzdHZX?=
 =?utf-8?B?SERrc3NXSmNycU5xcE5wTGFwZ0ZzNlBSUEdqT2YvV2lLRHVEaDVLR2VWVlhY?=
 =?utf-8?B?TmdPNFdpeFVNdmg5L1BmZW4vbW1iSUtXYk5raXBMZnRkQjE2M2N6elltbWts?=
 =?utf-8?B?aU1BQkZGODA4TlMxT3I3U3Q0N0RHdDhOSVd3SXNnK2poVnI0OElNREFBRTlK?=
 =?utf-8?B?UTE1THhnanJMM29PandSTTYwQXFSbmZHdWtPVXdGek12M1JLdDhaYk1CZk4z?=
 =?utf-8?B?b3VZaThUb0p6NWRUWG5PSmh2czJzbm5ZSUEzRGtRVWhLQlR5RDltaE9Wam1k?=
 =?utf-8?B?d1ZoZlNyTjRiWUhid3o3dUcwM1NqalRrMGkvMFFOMzFDTENmbXhySnhCVmZF?=
 =?utf-8?B?Y29GOG9CRDZRd0hUOXpiL3pGWlVUNGpSQVdWN1QyUVZzdTNHSkRvQXJrTnJK?=
 =?utf-8?B?NzVraHVPNkRUZ0owRnQvRzQvd0V3Ui83bUdFN04ya29vaG00NDFTMDIyakMz?=
 =?utf-8?B?cS9aQitLUlBBVENsQzhKb0w5MCtsV2k1WWdJNVlhNFRId3dZb1VCMWFFM3lq?=
 =?utf-8?B?WXlibUIyb2lLeEtYUVJBSWo3YlpQMGJmZ21leTMwdUZDRkU0cWxJQkxJSUcv?=
 =?utf-8?B?My9ReFJ1WGx0ZU1KZ3YvbnhpWS9xY0dlSkdOeWRZNFoyaU85b0JXakJiSSsr?=
 =?utf-8?B?NGFCT1J5dmVWbTM5UzRBcng0WjhMd3FxZWlpQkVmL3FlekJQU3J1QzI4RHZr?=
 =?utf-8?B?d2ZqU1FMTDFKZWU3UFNFZVdXY3pDK2djSGpHaGlobStzWHp4SVpKN1g2SmhI?=
 =?utf-8?B?QVFVL0dTRXJCL0VHRjZGbzNoQ3lScjNsdnJJNkkzM3lNTHA0ZkNzVmpZMU9R?=
 =?utf-8?B?dWNBc3gvUnM5dW4zZENZNTl0c1JmUTdPK0k2TnR2SCtYVUd0dU9RSEYxbE9w?=
 =?utf-8?B?eGdjNC9TMXlab2RFc3pEV3VKTWlvRWY5U1FzQ0xNdmRPZnFkU1ExSGY4MHp4?=
 =?utf-8?B?UHExZFZkQXFpQ29GWElReXFWL0xtQ3dTVEx5K2NRQ0x5cFVOZWxkMGRxNXhx?=
 =?utf-8?B?TkVkSGorK2EvL3VoTzQ2NWRCaVdlbW5sVzEwYzQ4UHdDNXNQdHZMMmwzRG5F?=
 =?utf-8?B?VFkzNEhKaExpcE1nQ2p5ZDc3SGp6enZEMHRmeU9xS09OYmovVGozUndPbWVv?=
 =?utf-8?B?WEY5bUp0MWFmZWM5RWhaVUdrY3c2Z3dDSHBQb0F3SVpuQ09EK0RQVGxKeTlq?=
 =?utf-8?B?a29rbm5UTVRyc1VvZUdYZHd4SVprMUpsdy9HVVAweWxMQ0lDWlpyWXNVRTF2?=
 =?utf-8?B?Y2VDK0JXZ2NPcnlTdEkyVkRjTWliNHFKTldSNzdxQm9lZXdtWkl5OWlKdWp6?=
 =?utf-8?B?YTByQzN2UnpHMlRRTlNTSlBoYlVJWEdBeWJKV3dKeDR6bVJBUDBXSklsU2U4?=
 =?utf-8?B?bEROWjd0SDFGMkNGMlNib2M3cU9kVWVNdUhvc3R4K3JtUEpTYm9qdnQ3aTZh?=
 =?utf-8?B?TDJnYUpXSFRzUHl0VCtKQ1ZDYXdIZVUwTkwwcFVrdUhiQ29XK2w4ZkpRekdR?=
 =?utf-8?B?SURrMTYxZ0dBT0RJL0pFMkRXemNSSXBveFl3V2l4Y0hsalJLUE9oSWw2NE5o?=
 =?utf-8?B?NlF5Ni9mbFFHeEMyZHpzdE5rdXk5VTVzYkQvUnllWkhmQ3JUTG5jdHFnNlk0?=
 =?utf-8?B?V215WFA0dW5Pd3JmajBlRnFreDhnRXBFVUhMMWVFVFZZNis4aWs4SjcvcFJW?=
 =?utf-8?Q?VaKDJx9xuJv/PbgA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f37d3c-7823-410c-dffa-08df244e9779
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:07.8557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+FNnx38HNY+65rbGvnPCPFrF9urJSKJoVO6mkxwXK8Iv/gYM1dc/d+8U2rvc5+DwpX00fMrcKVL6ijV5CiiPqAUew3Or1DKEygQsm8UXAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
teardown for all those paths.  That should be safe in any case: the kernel
refuses it from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 24 ++++++++++++++++++++++--
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..3432b9a43c8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1876,14 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        if (hdev->owner && vhost_dev_reset_owner(hdev) < 0) {
+            error_report("vhost: cannot release device ownership on "
+                         "cleanup");
+        }
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..f6e32b59ab2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,11 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


