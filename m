Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14771C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx188-00018v-Nj; Thu, 20 Aug 2026 07:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx186-00018S-Rc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:18 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx184-0002Jh-FM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeoIukb/mJQ4pHxsS4PpkIorH2Ri0kimZAOuw3sZdqt6iI78ywtHKX9rzBMhuc8xJJ1mkGJ3BlW+nkTtrr+l0tFKvo43f0CdclFiSivMCsmHwv2/WEUCMRxH0Z9PM3LETXrVm7kL3EDAasduBBStLTPsWrWpSb6hbaYdhhIUtptqkQjFq4Q+7Xwd+5PFYdcJrz6seHf4EaOjG0TtZu06QaeoTYQYCQ/h1bYHzYzIVOVC5cKx8aNWAU7TimpAkKx2sfjQN5vaMernFl5P77dloNevSeYnztaq48lo+tdsE96OZli2QDpEtjSEBWSyLUGd1ns5B6kK6OTTDa7+RYUCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j7rXaZ+Kq3OHqbfkyD7nprRUvo/ITxJD8She5NHJ5g=;
 b=Fh2235s0NJ+ytdx9hm1LI9dVqmt8j6KaUb0tmy3MsLd+MkUjldQG0I/+mm7uwlD3cbTzY4tkxEDgQBglsjeOFlj0KVfPB0XQXZUlpqWcezqDOpb2nQs2Df+B3YxQaADdBqEHwBSOscPx/mkLLMbK2Ts8Lx/myEDepEybuDWXcYTcAg7Y7gsrQfascsE1Q//V0/lXaKFw07ZnUfk/QUejr2WEGg52kyEG40Au1llOc97daTFgsg82YOSIRBaYGEitLkamej+Az+yJEqSxgTOY+zkjdyKr/vwCncqk51+SEzs+l608L+zjldPuW8eYhkizgK18d8Ango7KbgrRoyK7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j7rXaZ+Kq3OHqbfkyD7nprRUvo/ITxJD8She5NHJ5g=;
 b=dN8H6UYJI3aRgQ962M9n/adssd955J6zvNYIKraS++xgBEu02qGXQasNYNHw3EUyNxRLIzphTIs5U3f2dc5ePuB8508jEqHbp3PpY00a2gw+VtLDivDjvXSdAkzLnnqz4RTHNFYqVrDjnvn93Hb/eDXT1jsjMGsAhz4qL3F3l16L5i40+zzYfdxzzB/c5Nvt4kw6vpWH1vsdKBgYa8BC4U9j4Rtn2AIw1NuOUkpJxcqbbxn4hcwuRMTZYVV4D4WUMTs1VcWA/ksDTMQr+HY6w8QxEORyjEoL3tvIxXKWatmWC5FC5L3mTXaUfVo7TbQbJeWyd+vPfEzmyIkZcuUJ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI9PR08MB975321.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:08 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 09/10] vhost: add vhost_dev_is_initialized() helper
Date: Thu, 20 Aug 2026 14:39:54 +0300
Message-ID: <20260820113955.509478-10-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::31) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MI9PR08MB975321:EE_
X-MS-Office365-Filtering-Correlation-Id: 022520c1-fc7d-4a81-224b-08defeafc979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eUWjiYRcgja7GsAjWt+Zu9HEoIOHGimAsky/4r/CSIPX/lDpQ1qMB+5uKF5WxTVMXTFx0FzfehlGEYHFxchWZi9iE3OFPTWx7MRCJ0MI+zADvODds9fSASjyjCoBGuBHR5G3aU08YUOnBlERCzREUCNix9NW/ylNURh/SHm4gtfwQo7qS9vEfIhxRgZ50w1YK/qh9jB4qfEIdk55mgqByPpv10F615bToMPXKlzjJLZNBoFbnNqWs67xKamIRtAekDQXGeGQ3ZyZT/UxUb259CU1IlY/nr7+xma5yzY0Jm3VvDwInmXIlcbrYaJVcZdm27xgxSz751twV20zLuRypL2obj/URoD0rlUMtDWwTZCnoLzSzu05XCyyf22223CS3IyNrkD8P1KLoxVNwZjb5oCBfm1tQ/+mTh7lJDiPIaaQ3j8SeQTCLsUQuwv1A9urm3DIvbGWAW4SXqiAYLz8NPug8EJt8LoobXqSNIXc9JYsI9Tr0FYVJ+iMqQBopk5PcgCWn2jkjAuQvDhCfGv0wEwEls88TmIsnvF54NyE/sbL+TiEh0j6Eskwy3+PCGN2Ipo6eMV7NrCwfN/1dzAlvC/j7cf7lzrC8mclr5DVGuuk2hL0ev/GUqT7xGHy4mkE4NQMgjjJvfljsHyqTwxjRFnsk7WFDO6eRWJENPU4Wub5n544ZTgzZV05Nw3wfng/l4saPBsIUBftNpkJdq+jn/BoJyZ1E7GwVTfyPwvMCaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0KhC72py1qiBmQhKMWZbPk6cYPLHR11qMeBRZQi5793Lsk1wnbepFruWGbF?=
 =?us-ascii?Q?O51mjvkyk/BNimvdxmwVqBOgFpebZt1jApBMk9ZpWAc5Zdv0c8Txv+7pdQDM?=
 =?us-ascii?Q?7iAhSyBkytCGldvfSZYwiRe2tT/ZfeWj8F2ZmdtvWb4v9ju8QNMJbVVGt7Zv?=
 =?us-ascii?Q?ugfL3L3GX0QTuUVES5C/FgXynj58IKJcA/pWxRtQ/xh9K613Ah9P7NezXKtl?=
 =?us-ascii?Q?vRAtub7WaVMfN5t2NzCNnoKqvsOy99WpRnd6HJ5jW3K7usL8IA6psEvudEn3?=
 =?us-ascii?Q?Z+7Ya5kKO1w/wFabpXHcJpOkYlraz6Di9I0iJS+yboFlYsuWlZFlJNl9wp4z?=
 =?us-ascii?Q?Asdehz1eeWoQBXKVz8XMZOPF7DJ0WXPfdTFsL9WQ4N2yLS0AzUDVp5oYavRv?=
 =?us-ascii?Q?jcBMBkutvBp9iXGVpsRc+UbqzfCVtPMJTzzzeCKjXpf55VRsWXBXbojGWLdt?=
 =?us-ascii?Q?gtkvGhYTOpwxuTJ9ZkBT+KuMu7diRyxnDzsZ1v5uhluvNMC5Sr8nrjWxmaR0?=
 =?us-ascii?Q?j2jwODs+izFtlM/9LmzyxpSkeBi3HdEHEqSVJZVfl2CBzvQke94VVIbXowgA?=
 =?us-ascii?Q?pvAOw7ZhhNmsJ30P74409t5+bf5EWzlCm0Jb3cpKH6lLH6rczjsnP8yTu9f0?=
 =?us-ascii?Q?mMtpQyQEgiizjTghKYaxImC5CAqx+7hXKiUhg0rvmfDYPu4pV5h/uuUAc8kC?=
 =?us-ascii?Q?Kb9Flsq+w8xDiOoLzMEuJpb8Ids4tbsQhOL4rX69560Di/gffCtTy46vtCEI?=
 =?us-ascii?Q?+xRt29/fHBhC4vODrqgCtC4jBVHXhwlXhjum56Uc72qfFc3dqhVq8HM8Iudn?=
 =?us-ascii?Q?q39SVhFJHEzFLf4KHRoP58dClR3at8T8Ht0CSjaVFCFlvHxZazQunKNGIXmc?=
 =?us-ascii?Q?sFZEkfsskSJ3k5CspsSJ7YmlGptGIA9+vmqVzSjL4Xb6EYPfziYdleqR6D+Q?=
 =?us-ascii?Q?w0LXGOrOYNmjUf5+AgGLYwbodVx3G+Mhxc2tZbPqTtvFFj+dMFgC4qG0FMk6?=
 =?us-ascii?Q?RyprDa5lx8kx1hnT72s3uR1W+7BZr3beTuMg4iChUhPtoEelV9WjoNivE6XM?=
 =?us-ascii?Q?X//wG5rBwTdIIUl4koNRoPPy55sswNW5eNEiH0zVvfqRpoHedJGReRvW4DH0?=
 =?us-ascii?Q?zYbnCIjSE/jwRCYSGOZYjvu7uVl5eOMnZPHG2/Uxh8GRoaGbhqGDB918rnd2?=
 =?us-ascii?Q?hxGp/Ei1IQHwo2JkA8Hgrq4p7LJe5TfT348ldKVgP/+K+w+d53aw+6pYiQ1U?=
 =?us-ascii?Q?SyZdjwW0ktXMSoWURLJl4wszFyjfpGPrzpa8PfLiF+dTJNUcS8nUcVn7CijT?=
 =?us-ascii?Q?TbpMAhZnSbk3r6Cj+2sXO+AyQF+/cLOg8/sxU3Hi41/x19HlsLe09xDBRbtk?=
 =?us-ascii?Q?Cn+iQ33fr+mPzspe9/ojyNW0NfnBU0QLM9pDrQTbjFptio1k6+O6CviJDFWV?=
 =?us-ascii?Q?VdGtgYHVr6xZxeeY8GnWepEh0JvCvJqYNGAxfliWAYXTa1VMsshzHRNBnrpB?=
 =?us-ascii?Q?wcdAbG8LOGULSTlY9HuBGO7RQZf7hKwHolIp7caOEob8VapTfzXq8IP+DQAi?=
 =?us-ascii?Q?QQE3Z0qyo0SbJAPoypGBLZuS93Wf4AShEKdvP94jgUuuYLT3Ec1PMWvK0hHS?=
 =?us-ascii?Q?glBJMJtZx2j44Un9T0aPOpPLzc/OEnNiZq9QNzblDQOQD8rNewCJOwIhDZMe?=
 =?us-ascii?Q?21VxGhP00UxO5x2cS5HmR92PozDR+xwy8EWS92354XiBrVRsGRnFDxJboAsv?=
 =?us-ascii?Q?brhaWwC4fKV8RrFerJ4UkHi8MZHKsfo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022520c1-fc7d-4a81-224b-08defeafc979
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:08.7587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4dXyGLErS+oY0EX4Y/Qb34x+3gYA/tzSv8fyh9QIjiZ4j7/NJ0jo9YMqkaROwaD27xhR2jnbkYWPySF9xzlc6GuvIwGvHk3oby3TKyqPtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB975321
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ea17bf01080..a81cd94f900 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1821,6 +1821,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 44e65968d9b..7c4f032996c 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -236,6 +238,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {
-- 
2.47.1


