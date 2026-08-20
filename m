Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6911AC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx18A-00019n-Pc; Thu, 20 Aug 2026 07:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx185-000181-Ve
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:18 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx184-0002GQ-B2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuQ4vgD/OGzEVi6il3xKcoWFKsZVZFnLrsCxdhp2JbsFAHZOjjNbIMvuSZdIXCcvyoRWHQV1UB4JxgF3z386FM587T53E9TeNAyxf2VEaj+Z5/e/WxMVAT0yy5Vsuv/ACkMnrncMbIEQCHM0tCeiilvuRuMbgz2bN3tVCjSaHaBZumTlmoZlZEpvakjjqWWZ+x5Kym3n5Y62VbiComOsKgyBmz6FrfaMCxFmaC/vbQC4mGk1sY4EHch5Lo4r4ES9b+2p2Z+d0xbQIONnHD9MlUsBiFjOolBu7tJ3LBqjOchfnVYrG4djDUFXg3VtT6Qci4IiDanJtg/s9RinuYbztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms//rT4K2mvNuRn3eWSKsDJV7oObkOq2kSzrOIGkDUI=;
 b=cT/iUr5fgOjC07ClkozaXTp5WTmZs0phwQwW+IPl085umLWmUbq6LYlOoHxNCMQI0aTay4oxzf6yFahRstqiKM21dAPLdCEf6KC1g7Xi7XHkSUWRGAGPC4CSlny0Ndwsl2nDwyUPbCt37WTwCb81nJnBXwK1Zonco5JAx8267li7JXyqN66DXC1opAVAqUzONZCNDWS4VOmaZMxDxa3r9OvR7BM1CCmd9x9EBzCtKIkTQpKtBJtu1SR0NqrOMSJzxicujbJd+z6oGx/7q8uMO9E2anotXLhIn8s9HINn6/I6XaY4kCLRG8tpfqMp1KlRAWywDVmOD5Vf4pt6YmXzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms//rT4K2mvNuRn3eWSKsDJV7oObkOq2kSzrOIGkDUI=;
 b=IRglAHeidYF5YFh6v5DaH3TacSDnBp9Jm1PNpNt/fGAiHNP7JAC+Y/0U/fpKySGYhV6ZsseSqsisgI/zixBStJMATX1uVCzMiHmq9tLPdyMRGRxT3IbwgHqfMqSR42VP6UnTCLN1SstymQy0X9iVdv7++IXjoN7LI90Fzb1gL/sc0zjSI5nDZWItvNoGjVC13xSeYU1tfMclkVJ6lqaMdU2Vxg9+XRYXLEw4Dz57plnFw+ENX7lCkKJyfAlSrEkouPgkJNwb8aNdpezl5rKSUNaKqSRsteapDtBHhjAuPzQ3WKb7YDpINU5gdt0U+TgKlp+XWjgo4/mNXBUlC0PVWQ==
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
Subject: [PATCH v4 08/10] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Date: Thu, 20 Aug 2026 14:39:53 +0300
Message-ID: <20260820113955.509478-9-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9ca42ed-6ee4-4121-3444-08defeafc913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bh9xQBeWR96lh3Y56R4E1922RwM2/JEbSUZ4P9WcknyRsSu7rgnXxb9ld5jcmAnRmySSUo9xeqTkokjFOzaP1BlpF8Il3g3SmICA9ldzRJgIwBZbvfwQHvjBvrQAJdblxZLr91KqQTGn43TtjAJvUXCjbHzGI21Ntjwc+lo4J6B8A97gXNJxUMjLU/XYfC913blUeIxt67gdmtnJ091tmpsEoSx2Xo/n4T0WueMTTmGqJ4WmugiKCEgoJ2PtAaSQI3ZzxTjIujiNM+10TZYL1aD0DWQ3/d3z1fEEUPsBsLX2rcsD+ArqHpCNgd1+krbeOpIbi3PfntqDeQXXaRY6ojQECn7nsHSQiYoOGLcHR4GHbMahGNREwUCqt2xdUrnp0CB+ed+q9E8IJDmo3HbnejOCks1CuUfCZm0T3ue6flJzSLFT1jzM2m/wvqyF3Pi503c7rpJil6YIwX+bF3eQBfFgqmtaYYjgEVwJcjO5+Usir9b8AoPXsNxl46vhnFd9PbG901aa2uLv3guux+F2C/FNYlDKeWUlERYXLKKsroZ9laa1OChxxrPfr5S+to4/es+3z49L3tiQVH/ERdq02Hy2T98nBRygPvshpyvOr4sH4FRCHIbIl9lEb4IieaPy3o8MhZuH7WRhlpAOJhujMsFo14MrdCvmrgRDrnoD60DYQVlYJDdJXLJyZrBlg4dGLe5fFNI8pK4AUPqcKPDoyNEIUAB+0B2uZl6x0pOi41k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JD0+2vqj/50+3fqp+gDI/DIoxQ6g5MkbLuvrd1F4DVz3O1TCWkSUfYCXk12?=
 =?us-ascii?Q?Hr8i1vsJhnaG08OZvjnqgY98cgyIGXFkLicueFlkmUCvnSvyMkB3ybYyvzYr?=
 =?us-ascii?Q?C1usW9nyRM77hqgb1mZo74fUwgUKMWi9GV7Ix7d/oW1+geqJiJbpQNiHIelg?=
 =?us-ascii?Q?IS8E047pGyetd2a0rZgXQgHnq3Txoe1RWNEIho7YUmt6c58wE+dlFSWAu7Om?=
 =?us-ascii?Q?uKZ/wX79/WbQ+zrJqNGKHVPAHWsHwMr+dSQ5Ss4witAKQnsPD0dof+RGvdgm?=
 =?us-ascii?Q?3CEVnLzIxvPA0gPAP1BfMHh4270k1xAuF5FbJ5IWgmnqNxVa7vfCb42sln3q?=
 =?us-ascii?Q?KIGZkAEwp0MrbMiWN1C0jtRuzfZ0CVJk3IRLcYgDIXmgtyrisKN/9BKKJgvv?=
 =?us-ascii?Q?VY6HkTYzRprxcunPl1sLwi9mYylTQdLvKSzeOHR8lrkveRIRhqsFpoM/fFPz?=
 =?us-ascii?Q?FdKQQwHAoqXRC8iRV0lsr5X1R45gm45eiP1pD3px1gi66thyRmJDJlnrXlT4?=
 =?us-ascii?Q?lkCLHbg9UdBzBuTBWEMF7a+lASd3lzTwvWuLV9YjrTuoe6rGEdrMOzV/X2MN?=
 =?us-ascii?Q?1opum6k9M6BOnlDJWcws0M/vBOjpD739BVCRhnf7/f+G4Ja8BthzOo+4QgBQ?=
 =?us-ascii?Q?/4dy7zeaQjf8mo8eEVFC0VqGeTeTtWjyDfNt2M1zop+aNn9MEzPAL+ep6QuX?=
 =?us-ascii?Q?q4lN0c/QTPGDAD2AfhGk3RPnDgKXuYz82s3Xmdl98iX7H/RLb021U4r8+NHO?=
 =?us-ascii?Q?Q7/k36C1Z0ur6zQ2vrsMVBShr8px+/Etzd3jkV/YTxCq1mN2uR+VVO4dIohR?=
 =?us-ascii?Q?O41hL/sUQxhXLrhOnJutKfnWiz3YvAbicHQnD5u/rnCYNKp27P238rIDgLd2?=
 =?us-ascii?Q?KZuSIpwx/wVqxE0+UTXLwc+Omd4H4xiCFzsifZeryF+rJgEbSGXg6h4+R4PI?=
 =?us-ascii?Q?dK1Uc6ROdAdJ3DkydaoEjXGt9QQ0VDybQcOt1avm/SwsyOXb6kHwqNDIFyeU?=
 =?us-ascii?Q?8Pf+CU+kJf5JCuWngFbUTlkTjCEaEW/+5aREZJpddFzBPgTlZiXwioaixNz0?=
 =?us-ascii?Q?AgJ0Mik4VuOb9XRS8nedteK3z4NsPDBjMrxx8fUUT8tzgfMjOYJiW7cahNpM?=
 =?us-ascii?Q?p/mRcQyc7BKJJ+JTxSDp5W9I4ze9bttKho6+mw4WXkeQCyI9DUXixAbxg9/l?=
 =?us-ascii?Q?OdwEZdldx6fKo+ZsyJNsFYTLy+td30Kc7pAicovb79kHDhhK/9fQdYWvscSn?=
 =?us-ascii?Q?BXVnR0b/qYS8EdT5zbSGSOx8I38uxauQDN56t0zJo/dyyRkCzlPOLgeuJHsb?=
 =?us-ascii?Q?i0ZPz79hwG4Gba4EPybk7gOSaIuqzpQNrNPb2o7TAuef7h3Vu2zvGa7s3te/?=
 =?us-ascii?Q?SJPxq0JcQB8hSB6GH2OfpPesLSdsF0QUbO0de/0FypXQTU/LPhZvFb5xaoE/?=
 =?us-ascii?Q?2BK8/Yg2t0VKdY0YsFemZqdFV4rQqje3xqxul8Jtz0pZ12Zgqa4auB43bl0i?=
 =?us-ascii?Q?DdwE74t9ihlje2yUhFnuRg1/I92/wEy7CpSYTQWom111YqYSxhVa2DGck1qO?=
 =?us-ascii?Q?YqtwON7YoNdUaUtzALleQEOcF05hmPc0pkQnQ3Y7zzuY8OcSXy2HzfhMPLgS?=
 =?us-ascii?Q?GKyN4ztoseTXW3m+Jc6NoVV7oc3VdZ580Dui+Zw0FQtxpGmXr3oZxxs98KY3?=
 =?us-ascii?Q?RvlM1rsmUzaGVdPl1n+gD8QgupYHKArKo6w6OYyNEgrxeLmx8lck+77C8Jyt?=
 =?us-ascii?Q?IM4FqYw5A3zCP0STIJKBdgVxbgIDswQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca42ed-6ee4-4121-3444-08defeafc913
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:08.0719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bg+J/0SUvhfot7YCX3lB2lTIBHs3BNbzdaGz+RNysy3xAKh1Owzpb5EUXXR0PI0gZ/2E+kQ99Ey7tInUZqLlBe+AF9QwfAwOhi0FHvXp8og=
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

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 include/hw/virtio/vhost.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2bb9a23fee4..ea17bf01080 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1690,6 +1690,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1707,7 +1725,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 9b98d34dd04..44e65968d9b 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,19 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() / vhost_dev_reset_owner() - take / release ownership
+ * @hdev: the common vhost_dev structure
+ *
+ * Take (VHOST_SET_OWNER) or release (VHOST_RESET_OWNER) ownership of a
+ * device that has already been set up.  Used to hand a device over during
+ * CPR.  Returns -ENOSYS if the backend has no such op.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
-- 
2.47.1


