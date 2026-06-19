Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02AFCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWst-0007mp-DH; Fri, 19 Jun 2026 06:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsr-0007m8-RP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:37 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waWsq-0003Ts-DN
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6H5AlEyjKBfSL74II6eJtymdeOpZk0aGNvgj+OxMfPPWFNbHUe2AuVux2s2A9D+76vTrN82ayPYWFxkphqQuwD6eQPwWLyzDdopjNJV14NYxy8jFYkPqlxDM7bga3IARHLrgXFqoKoa64aQUU+LIwHaOMeJWpU9htBdJv5EoxVhxDprMrzZLVcDOWjNSFaXoHYIMdVokZaDWshNA637Rorc3qYZtv2xfxg2kFc1TNZJeJKwXu4MMzOwbdRoKraSYyXFTUciB3NFYtfpWBNyl39Vf7yb/zJ3mp50oYn13xj/aaBhSrRqwGnjJfv74RmWFRBXQy3DHa32IfpxHcvP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdub8YwHaRt+hobvmkpSoOXl4FYLk0vtbTCm+KBDJLw=;
 b=G1fhqTg7lWC0ZqXid4ZNsVGAi8xgyd8VmRANIkahU76pahM+Pb6294Mzd5h0ILMyBiQ78GHuYUJKzEACwB/NCswLqn/+XI58pO0uJshPz0iy8O0tya1soI0V3Fk/3DqMJZGj7Wey4qVoN9RtZSApXB8QIvEi0MPk8pnkZAQ2t2f/5GkCOJJkZbRivj5uqAv+gslwtOYFSH7OqyQgVk+wFM/nsIGCKlj/rB+dlx3yys8pB4Vjr8VQdroloDgg8BdskRCzZYyStfE4BlYx/hYXLpuxRg3s63gMmO5967GYa7Uk/eSRhp5MtBfTaMhiYvqEsGvwo8Pqt45OSWR8Qrxvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdub8YwHaRt+hobvmkpSoOXl4FYLk0vtbTCm+KBDJLw=;
 b=hHjdXZiwWWpCpsdHq9M7FYg6r+9Bm3DqO9QQ4e64E13DvmVk6S6RIxN3cE86488oV5N3C7lMy3dpZtXzEk76siUu8X3bqdi0Y9i6jGShRFAFtpRTn3IyjMEPuObfjtg2A3c/f31DBXiqrkc+617gxDki07Yd6XK3OIxNVOjkJRYpEIF4SYGaxAWDdJoriwH42s8h09gnRPCmRezEA34/CO1MW41zCrwawPrZZMaPnEpuaRvuRmZl0TdJI3a9Cz1j32NCs2edJuBDsn4lsLvEgNc4nBuslM2Yh7cNRFAoRc4EQEf8/eAZbfn8/zjLv8XcFNmh6cEY8fFjzxP0wOmHiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6576.eurprd08.prod.outlook.com
 (2603:10a6:102:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 10:55:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 10:55:26 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 4/5] vhost-vsock: preserve vhost FD during CPR
Date: Fri, 19 Jun 2026 13:55:13 +0300
Message-ID: <20260619105514.128812-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0089.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e123c02-b1ac-422e-019b-08decdf1444d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|52116014|376014|7416014|22082099003|56012099006|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: bwitkTFE74k6Y2bbMrm9jau9nl9NMv8etpjJ+mavnygYO28IdoYiPnuKyzRp+c6Xr9SFNAggsIRn2nLdSRG47VQMNuTBO4rE7QsElFzS/KedGI8HjsMA3fA0Wdll/bgSyAC847nEIkpOnE3PyrUOPWamcwkXj5r3eKqmSu4w475foa2ifcEfAkuifjVFPL8FEpj1ggtcWbskvlJiOm7gf+XbX2DGoqBKYSKYNVwrB9OWQVDwOSs0XCE6iZJGwwTpFtIqFBVoNi0VgVBT3ZXTMRhIND+zMYSO/g+3ZIBNrg6D1drzVyE0lJ6IIOkc4gWtTxorLMDq1DokxjK1+6xQdaUI8e/EXfBJfdZqrPmFgo60FJ5wPnftXnI71Mf/aeV3Nk9TEHwz67yFW7r/apqh906lwk3z1tc27iVVFx+mq0AT1omAh6ZBsTEnjdar3flmSAW3qyW/JK+lSgBBeRFAEL9LCaKpbLyVPsvhnsFU+53S0j8xaFeVCoMx46TBsCrCJHAM9UKaNQzE0bGPaslSAm2+yXD+HFdmUj9deawyc5HDKzuFIP1iBi7sj09XKFeVafBavbnj9Jgiys7wNM3j9uBZpFZJYbTi/vYAhqfLrhqXZlj5qM2EHWzMVzMnTxNz/vr1ZdHasnI89IWxxGolKRCXCPtM8ytTqThojUgpveUtq7PEZEdkQadWKco71mKuW9hatrs36ArhiDGozC8QGcuveGr/p4J50iCZrDKw6SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(7416014)(22082099003)(56012099006)(18002099003)(6133799003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2T5L1Ufkg+ClXp7i2dUDXV9nKAArCLYa5+z1QfqXcRXWVSYDMTMsQ6rEfsU?=
 =?us-ascii?Q?NtDObcsznkvtLuhuYZ12sMFdV5ICXr0yPWkjgQr6F+nJWt1AxAppxZftk67D?=
 =?us-ascii?Q?DZrfiPs4W7leP/bP65ZUszkpbU82xwSU183xvxK824gqoiOx31jfAqdRuju4?=
 =?us-ascii?Q?pL8UBc0Eaq/mu/mbUsTLKI0ZTQ8qbIGS6LpPvdjKHFVrByFnp1ktsKlOdJ7k?=
 =?us-ascii?Q?SSPiHQfHVwyc19N+xi6mWF9yW3uZ/RmVG2zCkUzRf0GtM8POpINZqzcP1nQ1?=
 =?us-ascii?Q?GRifrvBaHje4w5utHbomdzJd7Ou0nUJEb5gkxphJCpw0WaiBt4sof814Ui4+?=
 =?us-ascii?Q?3AGX48PpY6mrMdLnNOaXejJ9Q3AACTUQAOD8aLai5CzQJb09CiciZkj6Us99?=
 =?us-ascii?Q?XTYi0ytM76d1NTL90yrYGzkM1UzUf4qaQ7Q+ayXK9h1lSeITswkOIaIr5UAs?=
 =?us-ascii?Q?DgfSYbUnBDR7dSCQW9TGlNOqpETGihGgzDSV+jy25NHGraKH5sBhQ83RK07M?=
 =?us-ascii?Q?QMsWPcLBlpUrbZh+WWUAVDlfsw/WLO4no8JqpQcCBg6uhu3rRG4bQhAZVEjf?=
 =?us-ascii?Q?ROHJvP3jVDWj3fgDBRMfMEgJrMtpePonh0xUj0SrV3UBebH0NHkOmzpDJIl7?=
 =?us-ascii?Q?EW9CtjN/vKT20lqc61nvUX0QyjAB+f3Zx6dw6k5loOA/+rM+KG9BkUsw02qT?=
 =?us-ascii?Q?uAeoI4d7zkHoANK0MSgEb9t3a95Kwr6QOUaE68fF7KsZ3e68eJ5JaRIh7WFX?=
 =?us-ascii?Q?RgBDCM0ic3vxuZgtOLg7lE2BTNDGvv4c5+yl7ZOPQR6qrggoyGS/PwvQQDiq?=
 =?us-ascii?Q?gBkZHvhvOoqxkD5MLFW2OBqfcdYOAjSuc6SLcLHa5ZA42rj71cgNg1xYUn7j?=
 =?us-ascii?Q?HAsVZh6Pej/X/o+JZ5KUyNfjQegjDh+bQar5LGbdeN35ARUcPb3KKXqOLb4C?=
 =?us-ascii?Q?/+sYuMGCFV/VBS3bmCCuydj4PVAVbxTgPoVacGnv8C+psQpPP4C8Mf2NGE8w?=
 =?us-ascii?Q?Z+NBSdFzlV3jmqYB3Ppk3+YiuHID321QI4qv5FeZek5HA24ApUlRzNrY1D7d?=
 =?us-ascii?Q?nZwusXVEPVa8qmlqO4kqD78vcFZS4ARCr39tdihbD004fYsXX0bfmz+5xNkk?=
 =?us-ascii?Q?mwLZK6bTRpUY+XT7RlxrFlyuwlu2oWDZAko0eUBayex1goLoMgDTKFjbXj3v?=
 =?us-ascii?Q?z6OqEx1hiAEUsDUqayKtaUdAG3vPv37g5qZFv5ZtCll1CMXYzr0BNqPwgwWH?=
 =?us-ascii?Q?w7fam8kc9VvXcEA89NmAnVKsXIyIX4wqUHuyvG6r3d8G9lGGTp11Ummah+9f?=
 =?us-ascii?Q?mM5a6o8mYVBkiXxbwPhbD2Gz65jV5pJEFD/zq0tLK9N0YdbWl3UbFTb3TOkx?=
 =?us-ascii?Q?JplubOwdf5k75b7jpFm4z4KcVlBGfmS1o+elwZemjGLuGqiCDz2RUP7hjJ1b?=
 =?us-ascii?Q?zj24YOZ8HDhZR1Xhhfbq0GnDrSJE3g0TTowfc8XwzqJOX8dJWoHXh16KZk2m?=
 =?us-ascii?Q?2Gtrq3WyV3NONdRZdgDsezAL0cc8ib7IF4tUR+Q1Dj/inNKOErNhnq7xBmMd?=
 =?us-ascii?Q?dW3iZQW9luDE745pdZ4t7Ru+j8sGswBLYGXcapPOJDIy4rSbquHcLaaq56WE?=
 =?us-ascii?Q?UOxfUhN/g89gWJkBAueEEQryXCkV7RI3VOHj9nufX57HAvBij5djpWkfyz7m?=
 =?us-ascii?Q?v4bm9sLr6WjkLv8hLboJsuV3wkfGgP4cLcgaHq/sWh8DZADbdu7h+uWkZKP/?=
 =?us-ascii?Q?m+55SKx7ga05yf8ZiloMJMrNfVy7ktE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e123c02-b1ac-422e-019b-08decdf1444d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:55:25.0870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z53xHY/n7CtxS1K3W68Jl2p3EnrA6ZsW8f0zrRZIWli2vmLSIio6yoCTBzcO6or9UmiMgKapOaMU9hPHQpTeDTsYwnO08wjd/mW0TwSh8v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6576
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

During CPR migration, instead of reopening /dev/vhost-vsock device on
each initialization, let's make sure the already open FD is preserved and
properly reused on a subsequent initialization.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..ea9a7d2149d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -126,6 +127,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
     int vhostfd;
     int ret;
 
@@ -141,7 +143,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (vsock->conf.vhostfd) {
-        vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
+        vhostfd = cpr_get_fd_param(proxy->id, vsock->conf.vhostfd, 0,
+                                   errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             return;
@@ -151,10 +154,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             return;
         }
     } else {
-        vhostfd = open("/dev/vhost-vsock", O_RDWR);
-        if (vhostfd < 0) {
-            error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+        if (cpr_is_incoming()) {
+            vhostfd = cpr_find_fd(proxy->id, 0);
+            if (vhostfd < 0) {
+                error_setg(errp, "vhost-vsock: could not restore vhost FD "
+                           "for %s", proxy->id);
+                return;
+            }
+        } else {
+            vhostfd = open("/dev/vhost-vsock", O_RDWR);
+            if (vhostfd < 0) {
+                error_setg_file_open(errp, errno, "/dev/vhost-vsock");
+                return;
+            }
+            cpr_save_fd(proxy->id, 0, vhostfd);
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
@@ -193,10 +206,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(proxy->id, 0);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
-- 
2.47.1


