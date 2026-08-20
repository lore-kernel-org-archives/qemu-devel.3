Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DED9C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx185-00017e-E1; Thu, 20 Aug 2026 07:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx184-00016w-5L
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:16 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx182-0002Jh-EM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYk6RT3YzEIfxC8HC1r4UFbx/xdl9j2lu7wBQ6p1TPLkx0mbi3K9wxvCumK4FUCfg+JaSmEtINIS7vgM81SpFoOmCPmlrC5VF3N0ZBZnC2GhI2AGboVwsYt5rgFks7eAwjK2h6Ig3k/jvyrcL7wtQWEni8pQUyeUSGYEeTJEPcpXb8AEYx7clPiDWLCwAgDTHOxNcQjOjUCeEsiDqBqmUhnSU8Hr7xTKo0sYtmwIHk6Kx5wMdPSgg9lKu7P6Ht2CZ5LIUbtJpcYht5AiOfu1nzCdXifSLE0DhJn2RGPbs7vkbI/yX4/d44zigxiNCG/K3h1eK+nahSyKEnXmkJYOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6978tR5YK/wrUofvEQwbSzK+G5kIDNHkjdbfiZUSls=;
 b=iLpazfJS398BjTWqJaqyahvx6WzwZ9iMdbjq7jQ4XFbjPFiYyzNT8ODmVFJ86uT5h3hvwYOQ0U6L/3wgWlC9qJ/YKRT/hKxKx5i0t4tekT/k14xLw7TUityG19UTOb85ue7A1tVClcLuK4lLQO52tHQup2c4dRGu6KCi0rdU7PXl+TD481YPQ2rQ13QQkn/n9RENR+k+jnNR0i6UICXAvpu5CnbDPNt5/S/tDAs6OF/jPIhJIEDDLTtp9rcdMu3FvJRFQIG4k97lTXNAmc0OmAQKetQxJQyViVN48emRSI2EmVByuZMAq345MCxbjymkXSDk+07b6P7lajOyBcNVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6978tR5YK/wrUofvEQwbSzK+G5kIDNHkjdbfiZUSls=;
 b=CPsk1LuyP633NYlHEeujadKGPL1lXBTXS2Ii6lzsKIu8UMXMKynMBv1XTZuKudj/2BwUf8amut0JfZUao+BJf0LjJf97lJGP3cB+Cspklc6cUypsJbXbTdExJOmA9OPu8MXCOZAcXrAjJk8c0Q7wrJwLKI/1bK/bEmG9+85r/GzANk4FKFWFU1BYVudDpjeq4dh0zOzLrOUOWfsfRAKzvU8JA18FdHts3Xb2zk+XJbQgpZ+IOt2yIJXXYaTs32t4Zo157o937T+Mw0aRy0P+6d2tysPYHplT3wH93FIVaiACl783FMoeW3K9rJojuBcZj0Aod2zehUUPhmzbBZFSMw==
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
Subject: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
Date: Thu, 20 Aug 2026 14:39:50 +0300
Message-ID: <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 155dffb0-8e71-4984-de56-08defeafc7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ncqJQLBkDVcamsRE0I0u3+PNNVpZSjoqu6JDoomQETd/7ml3/lYan1BYgm9zY0WGInqWtqbBFQSzlmoiPaMvEGOn+iwxYovUBlt6Y4wJQykS/ttynmGytknUZy/iP+B0puokyQoIlwg0HjpU/W4Qa40AsD554FSeY8cnjpx/j0O3Fq8GZh8uEEHbTvyc77iveTwltkvZAWGsIlqFZEEH0gdQUXbShx2hV/lCrDd+IkcRNsNv0hY5tChp3C4C4n3I/BPYbb2RQMKK9XIerFpBP9jSZcAmmcYDQ2+YEGhRnmEusYoeOiqaz5C7AHgYFN4ZDrhy5KgJ/oVo0cN0Pbu5pvGObriBlc4kp3S9pS2xNCdxzz4pl49n1o2QqFndn1Oi1wdYA7gpGW3Q+2/jjVt9Ibs/ZjjRSy4LTb5fgoohWjnLC35/hjq4ojGPGSAkS+al2+fIdjdT7V5HE/Ax7Y2Im76fRGZKcnrVfqz9jRNyS/EEVCswpRLbSD+aw0NACvuDjz+wGqyv75HIVIRMGwkDnk+lZlR7x6nF9vH5dYDS1xzHSqXXTrPilRm7DDbUT06Is+bZdlA1YicGBzofPfn8zRyAMoX6bZfKUWPoYgErY1QGUU06ujhKEBQVEwROXQXh+w8C2zmUmaDS4CgP5p51d5P1616L8Gdsn37cQDkHjnlYRFd/shKfo6lE+krNg2hK7u78bxMDhaD/FfmZ6VWMUcHNfaqsN+NjbnjqM9mmEBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqjw7Q1IGbNnrjNQ9NRWMXOW9aMzGexUD9Mzpq1wwo17Is8zllzTDqSa3MuD?=
 =?us-ascii?Q?0vZxmcSqd++puj/oc9RHFGifngPSQAdbM9wYF7Ivz5kYTu5GwyC2JOG/N2GR?=
 =?us-ascii?Q?C3RGeueT59wRA1XQTp8C5lU2zzSHeIQ9sEb/daMf6pyWVDgkpcSoAJjVGx3L?=
 =?us-ascii?Q?vHBvaG+sr2EvqKyGbj8unjfTsi3shs0x5ZrExdCNyLVltTQGN2a6UhHZe0ce?=
 =?us-ascii?Q?MFmwR0SRUDdTAR9EEbOPaIg58uAs9xNRCWDhzuok0FEfYWE6+Un+du4Lwrpk?=
 =?us-ascii?Q?+mmjKIsmy/FBFThEWFVuk5AshWU2YJNBHVvyaEcLu01IqJQAyEmnNxbt+b92?=
 =?us-ascii?Q?EYJ7Raz89zxmBY6uSG33fhFS511UHU0PljzOmmZlW65H47HADVjPcWiK0o8P?=
 =?us-ascii?Q?ts+J00ggcWk4xa6m4KV0vnbpnLNo2i4W7JSk4phfWVB58uk6Cd5ls9ch3umo?=
 =?us-ascii?Q?WvOKoLrKjGTURCWi/Vjcnrf1aHuwH1k4pZaUsmU6LphCF/hOoLEyJwqhndKy?=
 =?us-ascii?Q?GvJm2QobPUZP8OQMBHN5flhjNLX6VtgtCWFtUUnTh6PMZL9fJ9/PUd0ifj16?=
 =?us-ascii?Q?T24R5GgHs71kVUHvqy8Cuf4/QYto1CGIJ5WLdh2vPgyyjO3QdlQKjI8unzh1?=
 =?us-ascii?Q?O/lTTxFHKOz1U0oOnCnWX1N2ED0PECI2rJNn3jR3sCUfuci7AJN5yakfiTI0?=
 =?us-ascii?Q?RPZC/mQ2OXNvQYe1Ibg0PrUqNR1s8Lng/+rs9jzsj07PJPsg5kDak3YZ/FPo?=
 =?us-ascii?Q?qthzTOdDyqkJxlR97rQY4gYjwTxI6d3gnlZNwClRWkzbBY4K8WTB7fZmpX9Q?=
 =?us-ascii?Q?+AA+nJfz1PHLEFPqZRUHm8/ytZW50iZ7ZVrY7Dkrcp2GcZ0pEao0mvCpBEM1?=
 =?us-ascii?Q?aGamE6jbZOFKJGQZgcJa/8rRcP07GJaunBXd+qfr55jyiZvtDpC9wBzY0K1W?=
 =?us-ascii?Q?/bvgqkCdIff+KaiS13uMOGtqb51D1lAt4yRx4PzOBI0BI+1GZviG+BfjaBxX?=
 =?us-ascii?Q?TibZXNaAlXeayj+AqtmQ0vpJLHv2RiFxI2//aBlFJIE+DH+dX+yjtWa44h21?=
 =?us-ascii?Q?YdBCd4+KzSVZvoflWbb8XuEbcIElvBLbFP/HgB7xUVZr2mtNMxSvRvnkuaju?=
 =?us-ascii?Q?M0JERVOQjYE5uTJr6r/lhiq3SmqAxcO1HYeVbw8yWTdD5bmzW2cKXiiWVR2Z?=
 =?us-ascii?Q?S6JnuWfA1Rg0hDNcC37z4AQaZBMHitATvBDaeK4ZYczJ6k1f/uv0j9JpSy/W?=
 =?us-ascii?Q?hDlTv2b27HM0taLP3SN7LutMMYRzRUN/5u4Y6BB/26jaQ28dqjPkqOAj4URD?=
 =?us-ascii?Q?x/yfdc4twf3CjSqs6hmR3HXjhLF7QfXoAiuZjKRD4pB/BfF6M7yLpGdHXcej?=
 =?us-ascii?Q?gRy/OadSw1uFAkCpowFMt9I0uo9BjsAbTHbp53QpU3dIBeJRTqZorv3GH82d?=
 =?us-ascii?Q?jWi675UgmPuN9Rq2kYoOxp6RRvOzHqR+JJuEEa4eojbHXhGguL98Y0x9cqXy?=
 =?us-ascii?Q?y5Vc2DY2L4ZCKVIONC3JTBZP0M8+LnXbrOv9EGWlCZQW7xNheryMgz7zjZYC?=
 =?us-ascii?Q?2VaS29xuVGEYtDuw99x5CBw6XFz79wYs1KLT7G8YX/GmT38XLa5GLMmYJP6Z?=
 =?us-ascii?Q?2+AJac35g41IrD5vxg3c9D3TX2RyNch7HJiR44UyTVFOGFFasqlKzSqFk7N/?=
 =?us-ascii?Q?lHcuB24QbJh0V72TyOSNxiN1apVYMhj6Zx9Vu4MOKyE13A4Ks26GI3oi+BhK?=
 =?us-ascii?Q?dFv/S8KxkuMUiDOPmSBW3d85rWs9We8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155dffb0-8e71-4984-de56-08defeafc7ec
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:06.1383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8OIH7b05Vw3RkgQm0kYjO0DfYlTqGgje5zzXjJlklzzBSx9X9/pQ3xD8qktKyoUA+1/hC9rqvUeIbGdJBZZMk7jQ67D4NFAD/e2NaG3x/w=
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Since the key in CPR hash table is device ID, CPR needs a unique ID.
Thus we only preserve the FD with cpr_{save,find} if this ID is present.
In a following patch, when we lift the CPR migration blocker, we're
going to condition it on the presence of ID.

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..cec2c31f0ca 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -143,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
     int vhostfd;
     int ret;
 
@@ -170,7 +171,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
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
@@ -207,6 +220,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (proxy->id) {
+        cpr_save_fd(proxy->id, 0, vhostfd);
+    }
+
     return;
 
 err_vhost_dev:
@@ -223,10 +241,14 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    if (proxy->id) {
+        cpr_delete_fd(proxy->id, 0);
+    }
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
-- 
2.47.1


