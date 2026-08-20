Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4CBC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx18B-00019r-6Y; Thu, 20 Aug 2026 07:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx187-00018k-GP
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:19 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx185-0002G4-M0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S59rv20dds9sTQDPhVc9f/2f8uDQRHX7+PSXOrHzhMk0TYQoXn2jF/I9CkNEnYjTBwaikNv5N3K09subK0SFkyJOPiAeSigmWANBFHmr6zmoaSbAY/ahpOF1lgHtUs4GscjnfXte62XhW1pr4v2ENGBguamuzp3+8fdASPsbeGOcFHj7pvIou/ykCWmt9Wsn7bJTqpvXMaNaYa38nfV0zYmANTZadmg4/iWlTdiwieBzd5hGbA8pxoo2UPX5iT1Sbp2PdLQenJU5tzlLnvj59JycxHPpEpEgRaBhBJwumHRZddGrxolkLbRrRTjgeA6iXSGng4aY0g/3HEqeuk+cPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feSLFjcyhNYicHXyJ4AYIZH5dIsttQkJ/aCkSXDuqxs=;
 b=rWWLp8boIBSnk75+BK4+ZYZGyhl1ModsEHZBxpmoZuVItsrHy+2T6nYIiTlDXDjaPzxxJTY3ddyej3+OPNjeRElg4JjAZObsP13zASL5ejaeqQWbfVGdH0vYvcHXrxzIFH7EJat7ozENUUn08guJMny0rE8CJPpechEl9Bc92zTUxUhCNvXDMMZjLgIiJ67uOeBp44ukLuw6zvMqjRLeNxyzjCacuNWvZTXRIsBsKOf71cN45JJ84bBcpRxf1ooXlvw7f2XouN4ypof16/7JrYY+WkcTSWDS9+A7ZfdyTCrK3cHI8hvOa+CRZXqNPoAKXhXmI4oevXebQMQAuO3m2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feSLFjcyhNYicHXyJ4AYIZH5dIsttQkJ/aCkSXDuqxs=;
 b=hU1+f61mNHJI0+mT6kgMBBDDLuSpgvfHX4vY+HBD7N/CBKHZ/aGD0K2KtoTqTT8VvO82JELGq9TcUDtJokV0m5fnakOkFlPJ5NRP50Hkcmff31ehqD4W+xGFHgoyXK8E6tUhcrtTGapomHuPPl16dSATk0VEjQUfiEWOHbT6eik7IwhYa4nkjg0R5ItSsZxwJ+erg0DGpEAQf9Ieh3Ti4Rx2iHFaM85Lq9uqD2bjd90ZkAQxwMB7sCDvdLnZR9voFT+jFMYbyJdvQgBxNdH0tkLejCZxZa+hb10OFx1pKswXTmHwv50rKYMZUyz/pIma0YpXNmPET1BIwxlyhPNriQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV2PR08MB8413.eurprd08.prod.outlook.com
 (2603:10a6:150:c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:40:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:40:05 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v4 03/10] vhost-vsock: don't reset connections during CPR
Date: Thu, 20 Aug 2026 14:39:48 +0300
Message-ID: <20260820113955.509478-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV2PR08MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: de04da54-0acf-45da-b28b-08defeafc73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vKawE24AMO+nX4BsZYJ8W4f50CZRvEJNsrwobqWoB4Q/4i81ZDG2W+OgRiU0pHy8FM36SO7HqmUzwvcSuRRM6XZCxE8r/SZJM3vmXs6QivhPz75Z+IgMOGR7EG7JmaVCJSW9PODOFkMFu4bpu9s6tq4dIyn3usvgArF7HeiNQE+6W/bsZ6mz4EMynnMVGmTZ3ye/ZS/wgAWIg5WayDGe4zwsGGXH0JVLqc7wedBWguHqIaKafmofft0PiTpyoP73ywykfNKBNRFAyJm1EtYxBqiDq0yvIh5KRN37awIO7zNl/oXTLLbLE8NYmSCk4S+bbLc+ZXKK5Lev+WTpORok1RRg2+Vmz2XklbnrDFsjW8mAQqSOq05a9GVbCTaTGPlb3jJp5u4WM1ICVc3hGbHzXJPEBXOHtPSgaqD0Ux821no82iCfic6BY02d8FX9GlH/Tg4Z3WhX935+svah4xLrjgCKcXe5H3Vbw4qlO3TxazxnnYl1PDZHnqC9nyHu8KDiYbtw/HWrXM7ly3/yd9EIwLrJ4PJX4taWdZn6vejS6lUGsNgW8jxqjf4jzQ33GlVkhwMvHv6+lWds5QarKxSubC2qcx7k8Ax9uJnWS35E3GU8Ak4KJlz5xLqm+Zsr/4PRh64kgQzOJDqr0O8rbEgECNgqoAXdvTkY8t4VnLTyrAmScRIUHXd/97IueoGXUIHkoyWJ889OC2oAgi2FUDW/9wThCMNcLptr8GJza6opLAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0pjIj0IIeBfqcjQltsXDmpCP2Uv358l8xbHBOSaKjrCaSN7mlOcvxta98Zr?=
 =?us-ascii?Q?o6PS8zyxz59NJuY4MsHTZAR72eb+YQWotAmY75TeTcCipPELpsxnrwJkqYs5?=
 =?us-ascii?Q?/ShYDLKGQk1IgnEefTz5IOuWhaZff79UjmvLqNX66sBbRfOR4ma1FpJrTHHb?=
 =?us-ascii?Q?9SoXAPNTAtHf5eDxuJSZK9AtsUxxRavM2d2rnDtqXGva7VsKqFiLxrRDgldm?=
 =?us-ascii?Q?T1to+jUCQ8SKQpuGirQEVyAgzCoCVxQxTYdrV51Jr+FIUkO5IEWir3sFFsDr?=
 =?us-ascii?Q?Xi5WBwBiyFtQBN6G4zn8j/u7gsfE+ei0NihLWalGaWB3zY42STACWOk2xAMu?=
 =?us-ascii?Q?nuXDAgPkNaNeV7H2BZQnGK8zAPlFiI9gWV2GPhjMMM56A6LJl+2RDAnpQTFA?=
 =?us-ascii?Q?FHX0SG9ryFCZz25NVwbxBm1gsuLDF0XmlH3byuXImrDaoUTY7YlJoV/zdqH0?=
 =?us-ascii?Q?EEh7D5lMAO+MdnWsoH9fNaNqTG6MSH+Y3BmK85H/9JisDOZULfKhZV9d/1UX?=
 =?us-ascii?Q?DnvZ/vtUMR1RDdDqWIb1cGgDzYmD/XQjBriMIdcIDUr+mpP4bf2zvA49het+?=
 =?us-ascii?Q?CPdK8MRJ2dWkTYmC1HwqGxwMhkqkADl7ALM+k7jeOvzXRG7eWO64z1RuiBgg?=
 =?us-ascii?Q?8+1NQZipaHotDMtzZClVbwHnQs60wGT1GgIlhXQRPOggWs00J75hzJbPdEzA?=
 =?us-ascii?Q?3Ej4OCUrNhdJTBfSUt6O+2dsWg2sfit1uPtsLe9xkMdMDeI/u4uDQ9UZmjlr?=
 =?us-ascii?Q?nn0wVS3aJ/YUu+jyucQIemP1/OoPe08bOQg00tnDB6YNcKn1P5KotYkw0S+Q?=
 =?us-ascii?Q?48UaPcrTG3pkCV3oHHSZug+VUogH7bP0UEw5ggSSZ9U3xEnZnaLszir+yRuf?=
 =?us-ascii?Q?TQld3ZPa9B65LlJzv2blkYeWgFukqWlowWRPvjqTkMmasgtaT88zfBTKyram?=
 =?us-ascii?Q?x4eyxMFKml+OXx+QbsTUSaHO/RUZ2Z/MyNJwAZwt3N03A/DXlJrYkzgyAxGQ?=
 =?us-ascii?Q?QfCGSjQQnSpc5YydB9JQEFlN57RZM1Us41gFOGU+xSokfWCph/ICNPT3lzqU?=
 =?us-ascii?Q?RJ2Jsf4u1WomtExw/7yTFV6ij73vB/tWerJdZl9p2B9/txhfa5K+y/52NulU?=
 =?us-ascii?Q?WBYzV44J1E365Sk5kU094QHUxfUr1NG8CmgzaQYA/AGhLV6st30e9Hofyc5I?=
 =?us-ascii?Q?czf49sv/KR1KGor8I99LubpqDHODKkhnDskiUhW9Gy4b7KPo9dkbK81PF++j?=
 =?us-ascii?Q?ufcNEpmaS4WXOrygWrAs0eCWTqRbjDhOnKOZpC/yJYTWggS9bQ20vtVqIwIC?=
 =?us-ascii?Q?0OE/nCGY8BBLikPVz67/7hQzZQ3K71g+nx6uiGBYyyYBCjgMRlu/r1VYQD/w?=
 =?us-ascii?Q?N80is9gzP48XStxKj0MYVbmiRZeh1lHUpDp5RcoLmz6L3IiUXEOFxbeAUzGU?=
 =?us-ascii?Q?n5qFECjfreyqevtfCdVpWxE3lMNYG04cPv7d4BnRYMzG9rgTTwbDk4txMPos?=
 =?us-ascii?Q?RB/832YVOpaA1bQFnK2yoUSQbUyoHgqBr+ZAdliRaDY/rcK2zY1TMsERq55x?=
 =?us-ascii?Q?Ok1WEfxCYpO493H59chLz/LBNfqDXM7xkM0m/uvaM6C8rPEn/rsnZ+rAW15O?=
 =?us-ascii?Q?zNybbknqB3XUVKBzAUdId4L9tc6qaO1JvIVmkY12+kqAs4BntMBNC0re0amu?=
 =?us-ascii?Q?Ka9dabDZBVBOx5JTJIxrmFAPNUHVNQXjH4D+PZS9hcDpmFmltC9VKvlLAQst?=
 =?us-ascii?Q?phYb/a5Fy1SjeC8dCYVIaPiEyj8I/yc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de04da54-0acf-45da-b28b-08defeafc73f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:04.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4AmxNhYahDxbcq32beJPxAtW1pXmoXX6KwAzA8t8nvHnvaKbE38enCl3sZFyAebNvBOmhI/MN1j2Gh0MwaDH3bFjwk06WA5mMdXCMUbIUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8413
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
-- 
2.47.1


