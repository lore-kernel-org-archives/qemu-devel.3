Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464AFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9i9-0001Px-3p; Fri, 26 Jun 2026 12:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9hz-0001Oq-Hu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:21 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9hw-0007dq-S1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOsfNB8Gnu+anBntxLgZXJm31P+NyyrPZnPAllyTTXDVJAgAd7SYFlBtPoB6hYzY0/EupDKwNbjbd1J6bCSGCcJQgSOTzwWkX7AkswUcIwtpJ6CRf8FiLYo9RSULSLgfwui9+2yh/K4jcI5xAvt/f9foHYT5AnjEotdKGjSmqnmQn7g2n7WiBfOwYBEzKVRk1QjIcovFfHw20agGq7cLc671B+5ePAZxXHQxi57T7d4QFgViOzu20RWGFy6pC+1gKX8K9qjqJrB+7R9zkNlM87rIDkG69wtNWfEnMRE5/UX7N+0dB/0RIKbNlR6bwvDDkoRL43UsHv7Icm6iJW46WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo1RST5p98XYTNeKj7dqkBfNk3/RdmsWpteWXRjOsmQ=;
 b=H/97AnF3CDCty4e5KiWU7aJSnUgAtm5fA4uYRQnNH2QWXemtLWZ6UBv1k7eVsGGvtmyTsI7Oi0a1x9xoAKkbd1avSYVi6r6lJbxjiMWGzxipYSn64JnLef4E2IgPKFdOztiU2GRoZDElffC4lPfpciySZL4dwJJppeaDkEOaSrsOpNlBI71r9qASVV5msqnZYwcdcjzQBWb7nQmI3Lr4Og5G1uFwbaEBk0c/fb3au3eTSm5ANpNZHWmTJrA8J+/9y1tiS6BDLY8ke1vYIxhU/3QrJhOQPlKZZaDRTUb8sL1j48ns16BaTKVPYrJBTej8Bg7JAQisBM0emnOfvVBogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo1RST5p98XYTNeKj7dqkBfNk3/RdmsWpteWXRjOsmQ=;
 b=haxySnVTYq60iJaF23cVSzvJesrE1+uKYaw3HaG2NfeUiJKanMYnE2Q9KHjKNz+x5DJ6p10ENFXg1pcSCyW3wzGEt5TClZAOwyMdVxtF+n/IHIsAwnqbcceaFLvDeEOf+CLQcc3WBOnGEyiuQO4kChlCB5+J7SBlgCNUnSrJOBiFJeUd7yu9jLhlO9GfPZq70K0ML9Zy+roel65UGAZ9gesARLZhebRv9db6fiF+Xbl3UHv7AACn1yQVCMXf0BRBQJoxW/O5mJ4FH7B9QBPsoDVUUOmVEvohYUeGWU85iAOmraiDozJE5L/S5FiaowR8doXrf/710E+ec+7tr5Ibsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:02 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:02 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 2/7] vhost-vsock: don't reset connections during CPR
Date: Fri, 26 Jun 2026 19:46:38 +0300
Message-ID: <20260626164643.2526-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9beeb1-c541-47f1-3b66-08ded3a28c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: sAXJvPNOHmdrE0M7S/yUw+owavPJEi8bDdDwpTdB3GEihmqioubhQkJCHu6QfGC3jEBWA2YCt62Gj4LleVNGLdgHLVjshAjLpLwA4LYLNa7e8VetgDIyCWpssjtaa22RBQIou1Vaf458i+2r9tWeq2YgMZjmfnw4oHRtucULemvN38l8THjSHNOE+jAAP5kWRVAifssLQU47HTJGOkjN8hi2lKnqkMqA7jRdfdBtWNQmBmNz0U7UKM5es4PtXHkPO+Wfmgbc90oPM53rP3bin/mmAwylGlJgnJKoGF4BInzdh8zK76LcrwXxQA5IBrBB9oW2YZiVX5nFS57bsWTCkVJnevOZ69O08yRmEcNn6k5Yn6hL9rVKYbu6530uLhogkCBcGS25oqBLwoLH0eLEbmu79LRGQVDHhjUHUHIzc8mocrDqSckvboN+X6EERs+4LilyEcmNUtEE4TaHLV8LJD7470/BTVaT1V6LXzxuCO13ZLV2oCvp55vhmxW3egzRkLSDErite7euBro9CAxkQx2v8hLaL9m9ZyE6Z49l4/V4jn94JVAoiquGTsoylOwsBGYuwH5icQtU0VQ8Iioif9xBVq3A5Zq8VsiSX5xrZzeIDqfC5xanQAuoDi8Q91WI4cyYZGbvKyuuDMLKHKY4mil/od4lJ0nN7C8FkEshYOZ8vb13tazEFr4tKRUfcIM5/VGwA2M9xoYdZfgrjeLf7r8UkAirwQKIoqu9cCe+Dfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJouuFiHLeKrhGSSABVTv/b2HK5a/rD22s+E8F3p1Rkf/bCoOwK26qfdmeC0?=
 =?us-ascii?Q?HcxkSHmDRHXgoVwbIn+dULH7D2Nk6tChbVweEWQ8D6CTXQTkGT/iz5H4/F3I?=
 =?us-ascii?Q?f++X2nBlcitXRTPuEMa77s7y44zA6gn+RXk5V9HKrrFJU3Wf9ErNzAexJBsm?=
 =?us-ascii?Q?YHPserMlOhyVEER4yGD+kOmHht9hlBqOIu10ZGfastMumbgkeFRdgRcaOFot?=
 =?us-ascii?Q?LIUy2zd+UJZvV+I1DmI4vnfpfP3TPjqA7wneNEtbDCmnHLbOV4qFVqbMnHlr?=
 =?us-ascii?Q?PJ7tMo6JEmfPTNojP8Ush/T7kEo6OYMDNh9myV/hDiS+OqNqGbhtcuTD6ZO9?=
 =?us-ascii?Q?YkaJudVE0wkLWQseDnCNlJFPEke28Va6Ji/GIfiwdQPWNnA0hb470AJ4vDPo?=
 =?us-ascii?Q?UH/RREzDSrNHAefSyKtoF23MkRigcCRJFIDlUCCEZvKj0skxHgFmENi6nhcf?=
 =?us-ascii?Q?68yqk04g/vXPJecSzdoc79E9YTjbNByf2Al4LL+BtpXOPtG8owWysJ11xMQ2?=
 =?us-ascii?Q?P7+RtPQVVdMyTLrSrtbhI/CNqrBKE/UiJBD7xBdR0tvTuU0D0vpGCAZTeA1h?=
 =?us-ascii?Q?4Uz0uzr+p3L1R9fpm4VUV9V8TyDiDO6AVf6tAe8NVRtzNNKkFhZEOSZUe5+b?=
 =?us-ascii?Q?ucsELxyOLqHP7DmNIPUSqabvMOEwOUAEm0fdaSUcfvQNK+H5LEmo7gmbXCrL?=
 =?us-ascii?Q?+o3EhipHWU+ttioLjeQIVcganUc+P0mQMJJx6YIvmae/7pg1tNuzpdwYCrBa?=
 =?us-ascii?Q?6UtbMGI5g2khyxzr33fooajgHuKJ0OxdLoCGowxigsxENVvaWu33+Tx/z+5L?=
 =?us-ascii?Q?zjvsvnrwzpa8VVgFOhgG/FGoUS81+VXUoihF2uVx7g3E8i44d8REt1Yitut4?=
 =?us-ascii?Q?ZUvck0ElaC2hc4iSxkF30HFSFJY1eM/K3JWfLZHy25orSwxidkyGwFMUf/62?=
 =?us-ascii?Q?e/QafqVvuslgU5PCDXG1L7W70CoW51osrcej3ksgcGR73aIJmnQTHno8SiCc?=
 =?us-ascii?Q?1pGQa4KgcaV4Fgl3Ukqxj6zWMY9L9pe1whUUV/zqRZdfd1LW+iLQBFRmp0Om?=
 =?us-ascii?Q?lunTDMc1xja3lzuSMMJLBpBxHI/48t4r1Jr1TXu3b7anSX6nxxqMDnREl8iv?=
 =?us-ascii?Q?b/bss9Da5u//3lbCGYHKS0cOZkNsggFQMYSx7NeWsBD4YCh8wWGo7TevN8xW?=
 =?us-ascii?Q?uaYM/CrH6rKSmZIknmk1sEEMmh61EJnb6kJUlNQF+GSwSAX4/kx54nLsphgj?=
 =?us-ascii?Q?qtVe81bMkhxnPHVSGnYvzYFk+UVo2oYZ5CDC/nMGoHaFMtyRVmlnBE03XhSh?=
 =?us-ascii?Q?AqBnzaDHrqno30n8X4CyjOjnVHg9KSnbfpfom8ZpZRzMfz4rPRnR7win+rzK?=
 =?us-ascii?Q?QmoJSWUeWVxzDLj3ynv/9WtrcMI8CN/M2HMxitKdOf519MCI1C8X9qm5Maw3?=
 =?us-ascii?Q?1gKZtcDkloYVQ1AGasdR60JBlk/qRB2DLXfyAmeM56c9f+du2/Xb400NMp9q?=
 =?us-ascii?Q?36NIbkw+22+moyGQN4Mh1nsuvl4Ub3aUuZel5U05Lqcf6i/f1Vz1A0jxuMzL?=
 =?us-ascii?Q?tZl5G+ejuHazBFhzmbcknA2D0u7cPYhI9uhAovkvIBQInY32h1alktgsav9G?=
 =?us-ascii?Q?VffCWrdzt89pG2OJd3fU/Bxf+nKvfQqqdeQoXlgxRCbmp4dZUdlS6BiWwwQD?=
 =?us-ascii?Q?PkvddtT0U09bladVs7QFEHxp3fIl1K+Q8qMNPRhrSEWmNux9w/sJbIM6YJzM?=
 =?us-ascii?Q?PxD1v3Z30CIjbsevszAdWMZ/TyhjiXw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9beeb1-c541-47f1-3b66-08ded3a28c2a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:02.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yw4jTYaIYf6NtPdQ9GpH1/yZHGiqUn2RqcpJUXEP9hPKRZo3y1K3SLAQBLTOEU55CjZQ9+7H8h5kJP2KkrzGjS4qJSImf++7SW/zKOi/RwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..cdc58d58790 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -108,6 +109,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
+    return vhost_vsock_common_post_load(opaque, version_id);
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -117,7 +132,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.1


