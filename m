Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D72DC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9hy-0001ON-5Q; Fri, 26 Jun 2026 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9hw-0001OB-AC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:12 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9hu-0007dq-96
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyTOepvSl5B6t5Pf/oMf9QLpwUumV3nRYaJJJ7B68wDmdhT9wCUO2C+uZ2rvXYMcdBgJuwixHfxyB5O9JmM5oCtZYwmoyYeDvjR5Jps9jzjQSdAC3H1EJVkXfB4Pwd6kbTrhV92Vg3iTdJ0YDQ/K/v0O0i2nhhOCC9lyyUjVj6hmFMldeh4Yq3z2w8vMogKXGEmY/mGNro2NTS2Wt70zTRUcSWBy1icipy6AH6WiSlaS/HEksYMUXZLvsfgQUtmrfq9baT+XiJUWxBDYemc2TPmy3jV/33z2ldQeDKCUQQdS0l1ftD8BupluEvdmxCxlI/LXReZrkSOMOY9wQzTgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npRP9gTgJjV9KV93DFJ3LdmwFuvgUWpk6hh4lgfcpQ0=;
 b=cT30607mc9usICFXePWlxTN9XVi7TZNZDeR+j1MPE4luSpiNpiyRcvziYOP5fp84JxcFXQZe1WuQzYauDkp8/YD20r+a00C/S6khWokHxb1LtT8nbmEqLMdwviCS8qER1d+0eeQdcAruEtr8eZ3toHgMasKFK1cBJjgxCacef4yd94q8blMrBBvD10Jddxy/yszo3I1Q6alMNrdK5ZpJFTWBMUiH98nGXaUceErVVAdLNCPneflon1LeN+43rYtv0jX8hSvKLK5qhU34C8kAqqS+ZOtk8zq6AUaJg7njOrX1U/16RqcboYgVdz/JhwuH2RYfXPKtcCc2I7aZ/ILf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npRP9gTgJjV9KV93DFJ3LdmwFuvgUWpk6hh4lgfcpQ0=;
 b=McmGYf9n8lzMLQ5Cxd800R1X7rVbeEBZz4ZEFGF9xKCVNZ4qsg/a0ANx7zHRBxW4PE7+YsL4PBgZycxHMPr/eUx4aOzsg/1TMkgFrRtrXBw2DZpwsQqOk8y8iJJnXnxHRVweeznKkXalfBqA64awrs97E2gv3ucvQkuqysU3t8fUvJ9KfMqpIEg3vEBZIP3U2hLQh+4iBFIHGdKpWZriaHnvZmNTSNjxbQvJbbPYi/PepDLngSM53F4mY0DSBxSb4xIXZGC5S3uxb5+0/S0sw9bsVzQYhsmyjV55DPIsxeZvCBNkeRjJfQFiNpKthWnkn0FCSMr/O87bOqG1ClPIow==
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
Subject: [PATCH v3 1/7] vhost: add vhost_reset_owner op
Date: Fri, 26 Jun 2026 19:46:37 +0300
Message-ID: <20260626164643.2526-2-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 271e0f5e-2fd6-4b23-b137-08ded3a28bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: vhbCo9eyHsPw/As+jB6uCeZJy297VvY7vUevAK0bxwjpt60obXQoRjGtbl0kLPiOrXUZWs9PhT8w7NCbEGBvUdoJgMUoqUonkm1gEnG4EU38aVWV7dvnQyo2If2Ypvb3vwtEKs4p2eO6t8DcCN2CfJRkngxaEP97YPnACsJUh3fLs6fpv731HnxEmwqbOgwbDkK3Nj3Gp2md/93FqPi2zpQFoXcbL67qWPPFkA7V0AWnk0usH/yKJYw0QKKRoLJ2VQFHICT6iw65p85CzA3C9C/A4jtcPrCM001Ass7nT3ebC107B0GcNxOjyeQZ+JokiYmMt4mIHgkI85sCwcAnhH4SB3PxII6Jui1RsXK2WM2xlX9lUbJUwwyl3VWGY0sHiegVjckHaquBKiMXo3ND3GxkmYb93z6e14dl+FfmRvzo1PzxoOFfVQGlx1eBGPYMuxKh4Agi6jxRa8kg9MMoccV7mhTJ5KMF3/st2Z+qERyP5mkkYnPbj8dJmE1/NQ/uOu2F3X26UUgAwF6v97tChm3GwPW0CyW0UrSHnoSSdRzElSnGrzqYd8rhkuI5CsUgMDg0AG1CBLSTF/fEP7wNch0JAvC/17nSXQlRqTPgIJT88OvxXLnWFxgoTgYfPnvJ/p6TB8t86ORWLCrPrizaGe4Usz1aorR5ZCqe1Tl43ND8yIbT9a8vRc/1b5fYKh3qnhwcPoc5GEOxYl6oAC/ryw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qQLSKqpBTBVs2RdK5fUTJ4Ctuu5KBN20FsQGsptSpCw6gmBu+Nt1aDHIYeg?=
 =?us-ascii?Q?2VK9DFfSeIMoTqkCDcw4pwAc97oqLnuTC3gj6KbqecwvixCod5jgOcENNbT/?=
 =?us-ascii?Q?GCVLapBHk1QZ+LhhP9RyMvPAhwYbH0TwKfcXTzP3GNN7cUMF1avsQIqj3Yis?=
 =?us-ascii?Q?Cb9M/9+qCIsRb19bE/75GUfq+Hb7FARHttkhKCEwLHCRyjvMFI2KKtex87ao?=
 =?us-ascii?Q?bix1vIufUPwvLiYvD7cZQ5DXfwK3L4K9Ch4bn21/OtyHkjcSOpQ/+qa9c59Y?=
 =?us-ascii?Q?pfjSMk1gLW5EiQE3n0ML17OIyz9FvUaoEF7myD7/khe3PNZ2qY5x4MZ+oALI?=
 =?us-ascii?Q?XyR0cSf5MRjvAAob68bufsWnaYeXPsX2fGPoxBzY5Eou/xl4QUs8Fg59K4zA?=
 =?us-ascii?Q?lcE50Na6qZFmNuKoW/Luv3u3aiqyGk9lVT/EJ4Hspo5kapGLBWTtpkXns2qv?=
 =?us-ascii?Q?uudh3I8zauMi7XQZtlvE62p5MdbS3N5/hyZBKFpAfRfFcGg69Tf2seXod4ph?=
 =?us-ascii?Q?jj7t2qvh+H8UAzfl4gTXw2KAd8PyWhukZ7xI2uLF5dF5QQusav258zugOjOc?=
 =?us-ascii?Q?4rvjegTxIF9qbigsCUdakYhTfP9ud9Mqul/sy0b+96FhbGr7Nhw09H4Iymco?=
 =?us-ascii?Q?QZk5accNgEwayXlqMlHot5McRCEUt38hF+MX21a0ImHac40rYT4D70zbL7VL?=
 =?us-ascii?Q?B907JMHXxNXfX+dDjWmR1/xcSrzNU8LP6qNWNqGiBMxVOPRqM4LQEiqlNEBV?=
 =?us-ascii?Q?j0MOga/VVZmDtrK4nAREI8nTf+SYRUg2Wxr/oBYbbHJQSUF3yj/yG2tMgLMA?=
 =?us-ascii?Q?WU0WUmfzrh4mN9e/lWXtjpzA0c8VF1m//WrFjcAd/1g73Xw/630hN1I7I2n2?=
 =?us-ascii?Q?MejP8oOVfajB3I/vz2V9nDRMtvbimrN6DhFBqgKsab72a78+UYccoIkUk47s?=
 =?us-ascii?Q?l2frzBC9ReBabB+wkzlVBxhVUOsqUY6wfz0U0RZvzrDA/bWXT7857wWlCKKv?=
 =?us-ascii?Q?QfRXRgiYTw+dlul7z8WcKX0ID433RYLN395zCTLphSGCoZa5HwvuAyPKS+lE?=
 =?us-ascii?Q?Kmtnl500yoVcRDTeuzKKbtLw5wykdXYGFgvIX6MqKqWWOi34BXgAY82V2ppK?=
 =?us-ascii?Q?wLOjiZhUOwptnuaNhUS4/lSM5GeL4ytFqyk4ttS8BRiSnkAPv3PFfxCpcMPq?=
 =?us-ascii?Q?Sgr/8AagvLhwjFT+4ZVSRq1kbCP7nwANRunVBKEF+ed0zEQPp4A9en2sQheU?=
 =?us-ascii?Q?7qr6GvoVzq6VJ5zUdRpS0GmWw531i8v4+bArXbQne+dsEtYBeWqxu2QFYZo9?=
 =?us-ascii?Q?A3KWgQQp3zrGhvRuKwJbt8TxzzMTKnOdJDaSLl3+O9p8PQ8bxmyavn5YQCTN?=
 =?us-ascii?Q?WUQqr8klOSU+kiFy8GZ9nJEUrTPVVmm94nu+uZKNUR3j3ngIGpFO2lhgslvJ?=
 =?us-ascii?Q?qK8gUUdgMc6EalEKHvPMwdA5aq8QiPiCyYtqfbCgMkkXWWGRoBDhWEvzI5nf?=
 =?us-ascii?Q?ITm96MnWx27AC9xqT5bnXsJJBZqn0s63pf6waeMu/fHhZ/I+94c3Iu1OXgek?=
 =?us-ascii?Q?TIL5dYo6m37TILLmStKCS3YMU6GgwSibLhUdoSueXvA6ilPIMJoHQx5UEnfB?=
 =?us-ascii?Q?fAH59+NkhLpgZeZ6kFq+m5+V9JsvQZtfVipRwFutghP5eDIYdPyv5lV0cwRE?=
 =?us-ascii?Q?MSt0SzB2Lo4gLySnPq1HF95k6rVEnL+4vkvtEL4Xn2yhNMIwN+Cq7HBrSxXq?=
 =?us-ascii?Q?QxcyrGfyYIgVBL497WIbBcNJnRRVzvg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e0f5e-2fd6-4b23-b137-08ded3a28bd8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:01.8838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVfwMi5plium/3rqGSZ+cWVsMx5d3rRSMvVMumsvPJEL4BfnfoN0TqUBvWnml/t7yAlHwol9NbgJU2b75Hp9oBkPyzVveDeolPAZ3ceGpJU=
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
 include/hw/virtio/vhost-backend.h | 1 +
 2 files changed, 7 insertions(+)

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
index d878d7b733a..6c949e6a38d 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -204,6 +204,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
-- 
2.47.1


