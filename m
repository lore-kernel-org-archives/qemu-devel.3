Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6910C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9iB-0001Qe-W6; Fri, 26 Jun 2026 12:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i7-0001Pn-N3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:23 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i6-0007dq-4l
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTy5I6WAeXsoKe5Ns5x3B8gj7lK5sTQM8qPZqkYp+hL5k+mRwJftRztdGr0nhDugqtknOCEg/tDF/KVMT21IpJ94y32oh+eETjjcGTm0xhJsWUIozQti5e6Hd4ANUdQ86VamilbtlApxE0gyhK2P/PG9diyjI4UuD+440W7Ia+kKrlkshgMaHAQWFBNIzgCS5JuD5fF9rpv+dpicBFl6BIzsMM2D22GfIOSpXY0Nl3toNdRkww1IqrNNaRNy6r3YnRXsFxoJmAhXv1XhzeV1q5adrST4XIndnXBJJtYQ2c/xsDWY/OQ/r8pXSv1ibX4yOdPCVCQc3hgknaTJyd4C9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W08jAF0pKJhrQ+4ppVNjAlJR1Ujw9iR5wxfeUtV5aEg=;
 b=wfFlidcrD8rDJXdMITbIelJCmksKUWtXLh6zUAEB9Dnr4QKYk9RZ1L/BHa0Ltn9MGXdz1HNaBxxrqgWaKdo8EpvyK/H8/JYCaVUaCqa2Qx6bizuVf35f+E6zXzsxIoE2WPj3iqqMpvaP6Yoi8UpLpnE+FG6TYKJRCaEWL5j7aZ6K2th8zuNix8mmXLUOcRup9XK5GLV1pqYUb8cq/aCwU1kwla3oG+dR+Wl0NIzuAYnn+wQ49hHgK8XCbJepG7hnNaGWleil9xkdr/WLGlBznJL6ycMGR7khDpXngoYbTxm5lu6lbxbV4voUqpTLTYOdzFxhYBjyOp3IzUyN2hftGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W08jAF0pKJhrQ+4ppVNjAlJR1Ujw9iR5wxfeUtV5aEg=;
 b=AyNOm+Iz7zo0b1ambCyT+lfbSFHiSe2GNw4pfPxkBNbAKLgOHhBxa6IraG/WBfvApBBf4vWQXOrmnEjIw4Mh0l7uKW5+S6IUdaP/IVuyJDgI4QQGFoJjCrasc0DuIfyOYALE9DU9tQIk8Rih/EqhKeHCVMuSJu4V0IuDt9WfHRMrhc2gh+ISmh21aJ8mjwLB6i1vsT4eBy8xxz4IAWaAdbKwomsCwdEywHgbHlSgp3/emkyr+ITfqyvDQIbrOvfNyYDQlY5atpYZ7DN0pZys82nJC3Bn4AJRlCVwmrxSwveZCB+VsEmqwx90VDvCnpZ624Z+xmYXeb2Tm8hEob0HSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 5/7] vhost: factor out vhost_dev_init_backend()
Date: Fri, 26 Jun 2026 19:46:41 +0300
Message-ID: <20260626164643.2526-6-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d106941b-681d-4203-e87e-08ded3a28d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: oW5JIwdBoLwIbG5//qyDs7wUZoXmz8MauGbU4gmI+/2V5WLmnmfUoos+5bg/UOVMT+Wr0YoiW4iP/JQhqKVYfx6ov2DHwvz/rJA+1LjxbcRtGrYPJ33pDDU/yst0G9wIIGPLHxT8Ev3dO+NArltCLzchAuLcBC1v1ozcN8PiHaBg8RP5V6NfszMvhNOY97E4gR8sccrYo5RXU8/IfqbdJNXvAXCWrGSRwxLREZqWXUKWou1CEGuNKRz2oKXAG3FqgRFm+GzGAySiTU6jVY+Ez97w+tu+SDnH1IyAz0/z747CBf1So+XybGPmSZxaLdnlY6Gf1udAjHNtOQXQRW8MSEYxa4JnTgQH0ssShhbRMOoxOicbtmNE3iaEMSesYFeCCEX0YoatHpdVoKjs4g+8a7NZYV0HlfPrpZ5RwBEmGF1UEI8yta0MIrUUn2O2JRs1qP658Nig2Dwt3IGRehvWolap1IZc/xZ4enzJz9TScsDNndJR/c05zun3inTr9tpEK+AYUBDpB6e791PPMiVTzByNTDMxjgw32W/ydR3hhZd93S/qHud9AI5cRLwwtNsnRN9D9lVLN6xgt2bYo9zdIRkWryureUoa3r3hmTMZc3tghx464GVG6EKjOeOKgGo75ei3O6LEniWdaMaBD/5A8KsmmRSt3AkFKvtHRbaT6+z8mGm7P/yUh+jNcO6bpfORlntbR2tqtWN870ky32mNaHdYgST0hJJzURTg5VkxFHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZs5t1diNmGL5hw7kMzjESgA6vRwY0Bp3NSR1R/5TeSq8XOCuYDvpYIjEMwM?=
 =?us-ascii?Q?c17HMbSl9PbPZFXUKuBnJGflCoQzFTf/f4o2TFwQVUvGkF2r+smJnVmbtVpf?=
 =?us-ascii?Q?xZlkCTTqAvweeG0rv5yytLbtLjpq3nranu81jqw0nzrFikyyMjlCAjEMT17P?=
 =?us-ascii?Q?P1em6/lgvucMeA8XZ0XJQaifh7MnFznaBfm/3JAgvsRmyWLi6GetYja9tYaM?=
 =?us-ascii?Q?2OXROGFEQVTAD315957eh8tlU794H9t0ZAah42UlQTomMadNgJ3/HeTx+W1G?=
 =?us-ascii?Q?cBHflEqf+fPOD9IjxNfb8mwkie281j8axpWmB/xsdkgq4QVAHCV4pbcyJZxU?=
 =?us-ascii?Q?7KI7I8mwhZiu2Zckmi1BxfvXKOURUrxUuf8GzEWy7kNhp0geJ5bGgghmPnex?=
 =?us-ascii?Q?3slQjEHhWKcHErXu3vABvKO8ObIO36zXzQZ7GF9mUJKO5wunf9bXpdXVJQJJ?=
 =?us-ascii?Q?coU0iq0RSHpQNycqZVWInAiXoUBaG52kPrdAnn3hdRkxglQWhSUhIhhd+zpO?=
 =?us-ascii?Q?1+r6DD4gEw4trO4IeNmUK93pTrqIBg2y++sGM5LoNXuAVcinGRR1e4YlN1eq?=
 =?us-ascii?Q?Tp2KE2/kg19q8sqqVJ+agk/snQrqb1/ZCUowsZwdvUWnZ6PBl7A99SKt1rxH?=
 =?us-ascii?Q?eKl6q4xBP63CY37H2voIDi8lDRSy607M04OwHejcOpbiUAVQYRSi06OuIAwO?=
 =?us-ascii?Q?m8yKpFNZFcUoxfG7gheeMBQRn7Q9Ul97r3edt1M9NHL4aHg6aH6xO2XHTsCz?=
 =?us-ascii?Q?cCMbB+P324UKBoF+ZhaP9QUFF+UNI7y6VAxqLTSAzMFtymGmSUL8anhTA3MD?=
 =?us-ascii?Q?8ju5+sOqJw+vKf5EBRc84qX42N+quhSCYuMB7Caev5byui/zvOjFDDUQ9nGF?=
 =?us-ascii?Q?Zb6VOiMOq+CbHwv9Si0vm4pTBPgIx7OrY7mNc0nOKllNqoveqOtqCp7NwhBm?=
 =?us-ascii?Q?9nxr8ejDIaiQI+pNIDYFK9N6lX7TQnlZibqTTmSDAYI3uvDehlLlszIxCMDE?=
 =?us-ascii?Q?UBC9Bakvenh8kQ9PHbr+leysX9vp6vETjGTldAHqbyMVcDXnwsNChqEbe4Aq?=
 =?us-ascii?Q?RJ4eotFzuzuF/8FqkFGK6YCfdpSBUVynnazaFJdVD4kaQ1w4TsoUxzaFR3t+?=
 =?us-ascii?Q?z2eH8SbluHK52AYxJnfgOI7hcwbNVbu9vUvjV2cglVWxgY/36dqug89zggwY?=
 =?us-ascii?Q?u00EfS4P7ZqVW1z3L5tohROdBNXICEM/SFem7uMoZkqA+p4Vy/2aqiVf4IVg?=
 =?us-ascii?Q?DPumDLD5PcRI1W7gSsmVihI5q3Aa9OkxuudwCwKJ6XuH2w1KGE9/JcrkNTr4?=
 =?us-ascii?Q?WiMSKCZjwj3eozNBNK1tdZ6AgrdVxiUHbcHinTIwx3iF2A1/8sJ37B4vG6lz?=
 =?us-ascii?Q?XdOUcq3pauhPMOFgTnPzuG+Dl4+CBe4PVf/1pcXN/UB7t9gURPlpExb+7mM1?=
 =?us-ascii?Q?8ldb7+cead9Z17ji7ILyvyeHIA4kv2P55NOINCCVTFjszUJUFM5rnmDIlCpc?=
 =?us-ascii?Q?+DE/IQwTUwFZm5yN/ZNfS3wfGWhkYmj1svKozByTdg5yeSJjx5G7cAZoHaIa?=
 =?us-ascii?Q?Tbi0qRk04ZnLiRAe35w2BfrkQocO3YrGiQDPiBIf8DNQHTuY2bOchzH+hh2i?=
 =?us-ascii?Q?FIILfXI5QQMx49S1smKq5aPLzc9A/js9YZQfxa4h4wzPB9VbP9pWEM7UqdfF?=
 =?us-ascii?Q?o5PZlozvslf+qjH5XUmmN23Vs86NkGsB9+7jNlb/SWREKJF/m30toS0LYdZK?=
 =?us-ascii?Q?5OMz7702UuAoQjb3bOmBmfBM6i3MZhA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d106941b-681d-4203-e87e-08ded3a28d29
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:04.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNyA0jcW9qLj85gh1w3wGCnoq7d5bbpVGhvUgmsbXos8nscSz8EbebiaHl43bEksTbfiqL3/CLXPChFmrdW51NEYfKsPqxTj+f86U8Amuaw=
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 19 +++++++++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b529..f11588cc51a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1667,6 +1667,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1679,10 +1701,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1693,12 +1712,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
index 684bafcaadd..bc81e09663e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -156,6 +156,25 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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


