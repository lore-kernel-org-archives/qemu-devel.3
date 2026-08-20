Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896DAC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx183-00016l-Hr; Thu, 20 Aug 2026 07:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx182-00016F-6k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:14 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx180-0002GQ-E0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gdqs6jSEtM8NXK8NrHwiLirrVqmY2vP6JkAX6wryTmUghC1uqzvRCs3eMhZe10dTy/cWN4vvBSzDGCu9s+Ceb/Ncog+806bxonb0w+t3zq9rnbaFOD9EWkr5t0iMcLxIWAuCpyRccRtqVsMKTdqU/JjVUK4MuFN1D0BBrj/sWM0D6yVGB00ipQv7VodkXs2mYvjRd8y8CgD0PRQ8KAdkomwIFAHtQ7obrl4h9czgWUzhbnJ556cBGLZdrHZu80xNwtdBcozqGUPwD/A/vsXUS4i8zQd3N1F/oGzXGPloCvkzjAjws7Ol9Hbl3EVIVNGogWuxo440Y/mOxnimRFemAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1SFlbrWFCylYpeCssgpjN6cpp3BoeUvAOLQpT3PxRc=;
 b=wJXZdgCFZNYTRIadg6DeeBGbrRI6/PB5hEVgdUO9HjznWtK4bazSXxRuYnLeFbMG+sl81FFPx3OQzsNb08WMERb4mGPEDhNhpjtazbsy1GpRqkgjGqvOpOJG6T+irxejx0+SACwjt78XUp2FIe4on/J0OsRZz/r1ZJy8h4mI300oY962Xj3V9rgSFkWUb9HmzwJnb9DmgZ0gOPgE5HqzQvHhlkTjdP3FT8GaPj9+PXa+BfsumJnXwb/HJ7r5lc3eGfKBB29+WmHjxy1FyaGZQFUFekca09vArHCdNeSFHL8U423+MPxgIBXxkA3HEMyHrXYhwlBi1jlG3Inww8BFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1SFlbrWFCylYpeCssgpjN6cpp3BoeUvAOLQpT3PxRc=;
 b=gP0wEVZAU18boQb5DKJeu1DKyiB/LR8XRXsnfaduhhsUWiUlGB/+DPqao8VsqSo02K/CWWdu7f4y2U9PtyoagX3S3Gi9qw78rVwUFlwBkuBCD58zysDpx1Q+d09QuII4c+MVds9RZ8vl2PfMlaClSIzfW683ORcUoow0fReMPr9WipOOXIZIrkW36t/b+GbJZPFfuM565TI0vi/0YDXEeW5xxCSlRT/ERJnO6zEibW5tEhVDSIviQu3TNJMqcD8Pt5zV/m7IrZbO8lvXwi03XR4QBCyPdNjSnueaOi57Gp45bekXt/dJ6uqSJOSz3xAA8f0AJgtZ/Ji/d69BtIlyrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI9PR08MB975321.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:06 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:06 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 06/10] vhost: factor out vhost_dev_init_backend()
Date: Thu, 20 Aug 2026 14:39:51 +0300
Message-ID: <20260820113955.509478-7-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32b0528d-3a17-4b11-3455-08defeafc84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u6ku2oexPeJky6xLwxEBRDFXA9we3CfgNUsB+BnhH02JvPeNvdVSS62yHJEkkVxrC1KzsTIxvCM8TNbr0xILIqsVJ3wTQGbT4NOEiNqT8/4hnSqz8mDq+FTOtIb/DYZozQd0Xp2d7TXE0/ji7GJPl8VurMh19mwFPqfiVJlsXtwZjgVs9duZjjS+lJoXYewNLI9pmO7y/FSdS2nEvvBQ8TtbAzKyI6wpZYRLZ1uiAtnp1Y+xeu/39iQTRb83WZO1DFGK4O9QWgiBtSAuFgDUq0s2AHp5Ao1Yz0VYcbeZdBBlZRx5dfvlNKpb+dKj2ymMU3IysM1hhnhgRfJr4JUfsR1mK9x+ZjHtjOShyxLmOLaAak+dYInYD+xSmuteEGKc2D3HnB2AdvWUyX6cz9qcZVU1lHnARAMCwBUn0pOr/CNCScl/DtP4Is3QJRsNQk//qFZOIg2heh3UVp/kGkeO8WBtONUAgf2cfagu6DvSRqpesYOb2AO97Ust0yuJJgXZ4TBzTiVyGNXCj11s08c+OKizwLZB2qRwaHr4OxSkYz+wEZPDV2CBollEHTUbEep5yKSBXU6J3TERvkXSx+VhnfQyyxHpWlCuJfZRnqPPM7cTi/WVrMxHWJwjW84qi0iZKCuDfkEz5XU1csZq09NDmCgSDuDwKB8MhrxCxrCKQqWGjf+ZBvC3E9awcrNB3U3eXxwnyqOB3PIzCGXcCYoSV46i6863h1yBQP8iiwfOQTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0VMQsTFAVgvjCiVgpLjaUYynG561sswZF8UzVmOb5UnDlCk0b0avHRO4eXn?=
 =?us-ascii?Q?FZmpgDZjmd7rV0UrQkZv5NHCUHmI5IvwuVMxHirsdtFQrQDCIdATx7eY395t?=
 =?us-ascii?Q?jDq+0PsMr8x2oZxBn0qQinvAtK80Kdi989IFKUgVqFLx8xCjMtE9BQddjHnS?=
 =?us-ascii?Q?c6UbI2kQjmtD3aCdKOHQT498kFPA0OknrSzw6en/fypxDeLmxQP781hFBxV0?=
 =?us-ascii?Q?kM3ejO81K2Scmh4PoUSjWmF3A1WL9GLRciuwYXNj3dDuBZlDC9qac85pUHtu?=
 =?us-ascii?Q?0ExabVCBKOzg9eTOSuGQMAFp28F2ttEkK28ky4AIlNEHHj927NseXg2x/2xU?=
 =?us-ascii?Q?pNfPaYRfbpcS+75x8fBb+v3s4gkmrBUMczRhRjbQZAGDWpVRa27doUiJ8lsl?=
 =?us-ascii?Q?1sGkBHgs4BBg0mcWq5uPPe+ngbrAwFEBeIsc2NfTeur8msILmHcmWHmHjHtk?=
 =?us-ascii?Q?IkNQENd+X/8XL4s6IrZrm9v8BR2sV0+sR+Jw05k6sD0oYMmnwWCB4nww2lSX?=
 =?us-ascii?Q?FrUsOROJrh9RxagRxCKEdM8v1+JfeJQReZ/VZuIj9UZsXodGtY6D6G/SvGGK?=
 =?us-ascii?Q?aAI2g0Q2NiwnMMeLfq5/y7b7gVy5B54dzn9/k/VPmnxv8ahftO2x3ib3dW0w?=
 =?us-ascii?Q?9m9TPKnR0GchlAWuMIzW0sZbp5kue41SYfeUhpKY5w4eb4+JXv2rprVi9mlv?=
 =?us-ascii?Q?LNwt27jcOpBxH5z6IeZfcwNcqa+xsaBVOFFBqCEJKpeNEXpt1Dc/UpMtRGC+?=
 =?us-ascii?Q?ecaInPNfZ0G0zqAVLmBYlDwvxZziYva+XZIYB21IfeayTSf4y0ZERREFhM0x?=
 =?us-ascii?Q?evn5ib1tkrfaeh7IZ+D7Aj3iL9S+xEnn6UyV/vZUqfTXzrTBT8GiKl3PpA8i?=
 =?us-ascii?Q?a+LK0V8nwP1VB9hwNGSRdE0B1ZXwTJfE5speK/YqGNnRRZsxeNxk0FJxxMgG?=
 =?us-ascii?Q?yQVAczQOns/SHw9Dt+j5CVPJTb2VGWSrHr4r0xp/2BeBI77hNXOnPeJCTmYj?=
 =?us-ascii?Q?95hOIHONfvJYi8F9NayjdwE919P9Pib/+QA/J6fwWapZ5dSlC/am5xWNKuJa?=
 =?us-ascii?Q?BgUUmx2UejbCXDGW67VwAw60s8AS9P+Qrj1zTw0TNQZo7MlTjQleBnrknO8r?=
 =?us-ascii?Q?hYbPEaHozVK7M4qoJpnMzchVQXZ5AVXS+n+yTyYwkSYS08JqFIwmg54E9gq6?=
 =?us-ascii?Q?P8WSA2/03bHzurPe8sCYgWkQ+J11r0cQbR10GQqGlztGIs/9BBoOrefdtsvN?=
 =?us-ascii?Q?MIXNlQGtOjd/OP+vJ7/iucZhrRWRU17Sj4TfmPNivK6maudsTpje01J9tJVO?=
 =?us-ascii?Q?iZtNMHB/nQ4M+bWTIFKo/LMl45u0IUIimDneNsUzWafJqbZ6npWH/CPA8nAX?=
 =?us-ascii?Q?svdeRFEeXOwmO8Oc8xhYZhIA82ORTm6U+9AN56G1GDPfeQeiYeKOmtGW7JUF?=
 =?us-ascii?Q?ylpaTYkYsiBDhf3YEYkdNjxVUWtVh7d0RnN5sZMpaduK2DheHEyNI+/YMMD1?=
 =?us-ascii?Q?oqm4DbW9tyeXg4+1OffU1oX1hkv0y7EQYaXTt9I3cPAtCj5tshUxeJmkVAc2?=
 =?us-ascii?Q?5gSLCJhwaTc4ldHXMvmc5Qw3WeXIeJ33x+985HNTnQHlmeX4347UqeqHO7mD?=
 =?us-ascii?Q?sqQ8+5Vfsw8ZHBRCg8/NS+PMLfX8Q8fXOJHhyVI5Ow+mUObnp22SA/DIDBVa?=
 =?us-ascii?Q?Iv8+X2PFb1qTxdTj029JR+hbBKF5zoeVblagmQlPUXyq4Gt7LUG158/evRHs?=
 =?us-ascii?Q?8dIw7QgrWm9M07DCHwLccUosBnOMryg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b0528d-3a17-4b11-3455-08defeafc84f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:06.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PaCizshEGhPFIBauFLohL7e5fzihUQOWF1Z0SLCt3M6ZpOlGWiyh8+SmteMI5aIeBjw1vMGDm6SleTMvvncT61Qrjicpe77gB4EgxSSK4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB975321
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

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 371dca17dd8..f9b54c46f93 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1668,6 +1668,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1680,10 +1702,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1694,12 +1713,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
index 684bafcaadd..9b98d34dd04 100644
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


