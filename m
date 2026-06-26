Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628CCC43602
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9iA-0001Q7-4b; Fri, 26 Jun 2026 12:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i5-0001PK-K5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:21 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i3-0007dq-Pq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX7rC6NBrbKrwkiAn6gEDDAfi1FxE2cYA/SwWltwL5nhKLvMPLH+UX+xdcBpj8rUNcdvjvoPjYu0YkA8QVGcwLS2rdQy5lel5WrH7g7ppfS9uqmq6TR+mkf7xkt3RPUm82b/hiOI7BoGYEnzG/Ybp0xWJCClPvg+EKs4mCuHfhXmcINdjLnkuSOUNn2XfnAKxHVA5XQKc++yW1AyGz925jLQrekBjMs/a4dV78TXBBzqtIruryRK0S5dxwWYbIx+zg5hwT5SDOjTmX0GDQo1TMU8zULyLo13VJpyyzE2TM8UyfK9UGToAe01HTOJK4MDnynQLi8drjbvlM+exPeLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUC6D+LgkBC0rkJ+yCa8sXMN3VYrvbVXc7tbsMkaYNI=;
 b=hAjsazQoAU2DWoPKyeNXDTjFHHrPuK46WfgHrR1fOHRVSaUcFPAgCRja8QVeJweoH4EJXqmkpH9J9g+wzNSCamtpuiH5G1ZjbpWZgIYBRY3paC77vOjBPWl98qtYE0k1wVUOGxkylX/ctFQfMnUPwSVlD8iw1HwTspu1LvTHxomXvXSZ2qsUGaJsOqS+CT0oJsgNOS7Qjrt1eroLX4q1KuoF488im5teU69Um8g5hL/WUrnoxqfCN37hzR3UBxvCsdKaDxn1aSB4wrY+7bcdpyNtaeX6pkrNcozNgOvkgKjjxG10ORoQsZ9YeGwcdpi5GoFF13IaCBSja7JisfBMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUC6D+LgkBC0rkJ+yCa8sXMN3VYrvbVXc7tbsMkaYNI=;
 b=oBD3oMYG9HgSCMG2+qIP8Yw90zBtqkWw08PzBlmNmEKfGOy/Dv4wMmGlbrM07Xe9WiGzxpG6ZK5ce68j31vWLNcLs+DxjwYzsB65Y0BqN2xmXx3ixLhjhi0JIS8Lws1Dqdppt8KDZcDAHz4XNL4cMM7FZxqhsMYglEFeIhWNhT+26a32JjSLRpHco6BX2nGsIiLInaZGgg/wGFbOQPyo/4t3YZZ5972taM5CJFAIbri2aDXaPmo5uHBKAekY3FP++8EAYTQECWazZaY55M8Qo1rncE9BWaOtPsvSSALwFnXtDQiv/Xf2uEvAO+UDlsO8MCBDx+TELvB/n3ASpDSi7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
Date: Fri, 26 Jun 2026 19:46:40 +0300
Message-ID: <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89900135-f04c-42ae-2425-08ded3a28cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4QyDps7oJLt9kcNAS5zPH54FVV91wDoPoHhciTjnt4ZISk0xHACmhNn1PYl7yP/mXA2sle3f9aSoGofu3ahxCpQVlqjwT40orVTgTe2rh/S8lZPBPyB6ipiPUQ2r1fj98xx/Ahjvm9nlEiwZ0q72t4gIaXPQvk3f7z3716KHZruX0IzsDzxQdEho94WqiBEQSpki5fCzoiniSArWLVRa577qtStCzV3DgGQ25b5oburDTmJQwbahuLTVDTxtauj7VK15HhQCbJrGi0nm8qzwbcR2wB9oaSXgGaizj1qiWfMcjFGEkjQG+0xbcqqhw5VXCj2+7GNs6vUMzQzS3UpZdgCtcYGErHuiFFDhTBh5+uA+2TSGS9PiIuF5dYH7+HcHzGBBE8uOCdwTzqU7S5Do3lG1sDs8TE9LAZMykvrrkpcPKdTQT54wKX4WVq3UnfU31v4f5RjoFqdm7gWM0vrIkdXGvRCgmvofkyUkF5eTj80OC+mGy3bq/3dU7svmYXl6w6UwGYELQqO9p9Rb9DpQP2X4HZa4nHpNMGzDQavdfo9VuDA6/59uzErNSMne2oc78dzirSan0fe1SyeZZoqUJYJ9Ezl/xvPy0r+wruktK6WWGf9pe/9Rchw3ZJBmxIdUjiYbOx3n6AVZmdAE4g/IpEHvj+0Jk9ltgi3MUyOygxepN+TQApKzLRQSav9PuXsDthXE0rWHr3pem7gVRquQXIAuJ2/FuNNa+tDNPTACK9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYQPy7PwDE6PqC6TIdTvoKA16Xw1b+DnamGmfaNuGrgMweX38joBoyPxeNTv?=
 =?us-ascii?Q?szKP1aSPo8Kj8WxelD8Tpd0hcMw/m4gPZ33OdJLp+LoRHXqriqm5Fq6x6YOD?=
 =?us-ascii?Q?ORUXAZlX45ou42yNBu6RGgU9LsM2VmsqtK9goDkeMgaQaKWLA7NVql62f4Hy?=
 =?us-ascii?Q?tk+7wYuhKPXDpDVQqHu8AFmJf0X0cshuYA6BNEdfPGHxdOMs/GK0ouRJj+b8?=
 =?us-ascii?Q?SviWfYJMnKjhM1bUUstqpBlidiJTqran9sBzud3Kg17j7ZKwxqH/K8595V49?=
 =?us-ascii?Q?iAQE5yEXJedbxCl+5loiMEVj2LQTziOxLbSTBlW6Ooaw8UxT5YUOmH2Eu5Vl?=
 =?us-ascii?Q?ouX4mhEH/PgUUZuUmeSnfhXvnnfYhzhR659NB/+2xWLQ02OC033137HT5wZn?=
 =?us-ascii?Q?vZpO1JayRROiKV7/Q9nLpDABC8hpA7/DjrnZ1mc5UoPiXo+OW8YnElhw3/Ki?=
 =?us-ascii?Q?dV32SMnpe4T/K5NzUrlxgTauUK1reIqUkdVpwJOlmR1zoSqzfcCmWq5lbSGz?=
 =?us-ascii?Q?/zLNpwdv2wb3h43vj3wrw3F7rUosm3SEVIb8FEsmZa3jcjo4PjHec3SYmRP/?=
 =?us-ascii?Q?nd+XQ6HWtB28LFh/qZv1t8JkqxD3tGh+y0mjMbuk7QX+UO/gjbgesmx/omJd?=
 =?us-ascii?Q?nxXDv/4LvfSMfeHFuRhLe5Js2o4WeD0NQZBz/SLGX8gxhYdNoYMvfj/VxQoI?=
 =?us-ascii?Q?Kb6/zEQBpGAmeYl0b34rbIpdVPtAG5ZkPv9RuHl4JRIDp8NmUFGatqXEJ3hw?=
 =?us-ascii?Q?0xSAREujDsRhLwdZ3Z+0/D86q6/yqV9m+51+77LuqZ/tcdTktKxnOizER5sx?=
 =?us-ascii?Q?ZRwrLg2l3/KhuYpIFVx76d7pWoOC5qeM7Q0fe+LL8bNxACAsy3OafFXy4T9c?=
 =?us-ascii?Q?4ySBAQQ7wC5/q3d668n21Owi7eXVizV/ElguKvb7B3SzEOTkzuBGu1DQLlCd?=
 =?us-ascii?Q?1lsaQyPC5IZ3CEiQa0sR+O/G5jZpCEs90Aa7LpbhAS7sioUSR3h5nYUYoV5a?=
 =?us-ascii?Q?1/dn2LqElJm8gaSztpJ7yGPpH4uBr5918temiaqu8wtd9fI0tkbIoMstUGpu?=
 =?us-ascii?Q?aXezixBW2HzxOd8pqUI1Uyzj1DPc4cpixrT+XEbbT6ztnzbtJ+NaO8AQqCBl?=
 =?us-ascii?Q?vC30CgkQX0dgLbYo33CO6QrVcr7yJuaLhGpT6pDN1n5+qE1kUxIs4AK23Z61?=
 =?us-ascii?Q?Rk8+bGtn8BseAvhhs3R9QcFfFPOuQcE5Evte2BMXwL5snYzik30ILfdiCPeD?=
 =?us-ascii?Q?OUkortf7ada3X96Od3N2xAhshrz5zy+DvXN/U0I3Uvxin50/JlsMG4ZRimZl?=
 =?us-ascii?Q?PhPuJTI5p808ZjIE/orRr0th1upzOTleESg3q07lxqZfyGu9YsH3vT6rEx31?=
 =?us-ascii?Q?apQljnujrljjA6ErNjvsX2K774FfLAZd6rCZbvY7On7w6o396XMTpAZN2BT+?=
 =?us-ascii?Q?sVSrV4x5NA0dJIVYtgf2Chyy3+8MFuwItdK66k+2VPLs4SjyQezLVCaQbDU0?=
 =?us-ascii?Q?O279uYxjO7wytcN2YsebL5Xf81Rf2ISmh7+2F54MXgdCaSbjzWuVJj6XLzM6?=
 =?us-ascii?Q?wmWwmGqFQgecsx1PkTM93KmeuI8KrQRumlF9j0JT0kgx+PgUnGATGt7mwlqJ?=
 =?us-ascii?Q?roTUAwR4JVfXG/RnYOjGR8Vp7kzDzGcKr4LKiHu51Fji5EJQIaZzIl1T7VAT?=
 =?us-ascii?Q?TKIqrG+CFpmi1tR8/HzcDeIhoyF2a4VWKb54lbgE6TNMCvUz5uD1D9FChpAU?=
 =?us-ascii?Q?u+gPubhGSY/7DwkuxlksKO3iNieCQ1o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89900135-f04c-42ae-2425-08ded3a28cd9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:03.5655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTpeWqW6ZR4AQyNfTZf7FEnPQXmzokbpzOP5jChmu0U4drYqUAkgF+HrYZf1OGO9IYV0oIdTeqjpdXYZ0fi+l6oCDTmx7rzE/dPytt9eaTk=
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Since the key in CPR hash table is device ID, CPR needs a unique ID.
Rather than make it mandatory for every vhost-vsock device, we add CPR
migration blocker which only fires once we attempt CPR with ID-less
vhost-vsock.

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index fd7ffa88990..7eacb608d07 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,6 +21,8 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
     int vhostfd;
     int ret;
 
@@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    /*
+     * Having a unique ID is mandatory for FD preservation during CPR
+     * migration, thus we add migration blockers for CPR modes.
+     */
+    if (!proxy->id) {
+        error_setg(&vsock->migration_blocker,
+                   "vhost-vsock: device ID is required for CPR migration");
+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                      BIT(MIG_MODE_CPR_TRANSFER) |
+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+            return;
+        }
+    }
+
+    if (cpr_is_incoming()) {
+        /* Reuse the fd handed over from the source QEMU. */
+        if (!proxy->id) {
+            error_setg(errp, "vhost-vsock: device ID is required for "
+                       "CPR migration");
+            goto err_blocker;
+        }
+        vhostfd = cpr_find_fd(proxy->id, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
     }
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
-        return;
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);
@@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (proxy->id) {
+        cpr_save_fd(proxy->id, 0, vhostfd);
+    }
+
     return;
 
 err_vhost_dev:
@@ -199,16 +233,24 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    if (proxy->id) {
+        cpr_delete_fd(proxy->id, 0);
+    }
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..5ebc63afc5a 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* set when the device has no ID */
 
     /*< public >*/
 };
-- 
2.47.1


