Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537D0C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx181-00015z-3J; Thu, 20 Aug 2026 07:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx180-00015i-3H
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:12 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wx17y-0002GQ-BC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:40:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJfBDR8tQyfm8Fcr0Cbt2fAAJ9OH1dqX8ARh7PE2owbIAEUSPxmbdc1NAkqrwhWbtifQYe7enVR9i+dj9orSAWudfE6nnMJatAFUfvwiEh+Nk1v9Bm+Ca4I+XjbEsprQhkRkJszdSvnqVbkT3hmvtjicR7btyr7SpG+9KHAcZcL68roi0vJqjpXr3fKBqXcYshifZfLXEuRersAVIsd1KWQjSBwlFLEyp9yXVAiFOsIBikQTnPr7ekWapiCYa0RN8wzES32qE6mEE/LEWONCycFweEV363Nit1s4Wgj/3nxMaXzqneJhZLg6kRXuvV8AjROeFIDSE557v458mCfZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRQp4SJ1CFZGQ8N8POMcsM93ey3nagvDuHLCAtHM6nM=;
 b=auo4ty0UFHlwT/qImsdk6pj2P41sauVdn4F9jeSEUFdX/+d9dpzlBu002PNZsTYsuUoYysE9NEaLnF6UQ7ru8ur993KFjTgw8N89S7GK6/RVtoRm6ofBVHDXRTTZY2+bGHSIwM4HxtFxZwp8PvtUZgy/xjSoeJVeNkqYN3nZQcbC9oUr6ULsDM1qorc+ECNfvsMogUHoKAVi0tt9SGuJjG+rgmdy61wvSagZPmdyYi54nr+fIG16wVRNxGutiKQJex+XCRMQT1KAjnLmsE98o4UK9XvjRIQHkN19PzF9Gl8aC2HfVaASJJv7tI/7JHM7XbnEaY8oPTXy/c85w7IV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRQp4SJ1CFZGQ8N8POMcsM93ey3nagvDuHLCAtHM6nM=;
 b=bHA+m+mV95LSB7Y50Emh2Z83PPBJLjwdSf8U10PUhUdASz4liDz1qPNxJFCWyYVwqKjJRdhoRRUPjRIURUnZ5/HT9x9BKOeB5szIFNCflPfRYwgGIUeRSWIdFEUp3lycNSNtnOV8V4qPVgazwvLrEwzvrUM17Ym34J4vx+MFrFqlSl8UyTblGJQOVSlfxRz3SKNd45pp1/kt/LXrKcI7mKvLGBumLDkeXzMfopYShYhfp67Yh3n5pdfQ7BGUKr5g7ngcPUc1HhG/s7/qN1unAkuCnvT4nIDQCkXcogHEPO12uGaUwXuOjfqezqU1ENOXyKk0s1yqcmqcagHBQb9CIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MI9PR08MB975321.eurprd08.prod.outlook.com
 (2603:10a6:290:c1::15) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v4 04/10] vhost-vsock: fix FD leak in realize()
Date: Thu, 20 Aug 2026 14:39:49 +0300
Message-ID: <20260820113955.509478-5-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69b9d791-4ffc-4594-df59-08defeafc794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|7416014|1800799024|366016|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W0SY++ej5tDXOXlPL4bTQt9DXN9njBRWHcV9X0B7Nda7bnwuMXTWaMNEvd3LyKdAM09XLPzllDXbVm3+VejOFoK8CA9/+Dcnk5nMSwa0NI4ydAJ9jIRToPJDOBq/BM7u47/lQ9zvTGhK51icU0yB8iAzP5qsyuLsbIN8zACXtONQ5qJbP8LGr11LjEXJ72guZZAxMPQygDQIdtj4EUgCHeyeU+hhe8Q3tFRuFKkSQWuGDLTj4hzHmTihCeb+iP/LEkgA5PQFCcnyxfBu0wYnRAbjF+2Tvkd0PyYswgeT3QJfRjsuwXlDY6mC6x6o4mBzBACRi0DZtNSpmmuaM8fIwHNHof+EINrzovGryA0uj+t4V8wsJkjkJCpx17sAD9WWPcP/FzAcsbgTUsGPq9vn9YykmcWtUJKCPvmx6jtjLE+ES7/Y83BOxBtTAX0qefNwP8OGkICAp/po105JhvRaTd1bXuGB6xU5eLA+HevTK4/+1ys1CucYHa5PMI729fxMX1gwdJ9bXtaCVV6uW939U1aSN++sMHjwjcrUYRFwgxev211PP5Yq77UVx47If2SFQFMD8Klv7I8CKa+lHR04Z4VpP7jK80l88Dz44r/aN3rrkAES6CKdOdXlLz8EFI5LcV/ou5JBbM1HHSv7zq9zdMTH/9ftyMI2Uu0pptd2ZPbw0/lOWKjEka6JvbxMAQhMWrdZDQl1FPX+/G7X/6o+quEBgXLFim+34rejS/CgtFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(7416014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wBYvh9TH0loy8oyafPTG3AexdDTgq//NZ/r1mgvlCsztqguTrdKtumoJzmR?=
 =?us-ascii?Q?yIm6uEmebRE0PGNA04Gnwo3fZyha9l5xnmQEfjWzLeNytP0FAqlhUO/82quA?=
 =?us-ascii?Q?Al8/H1j6Ieh6Sd0I8mOOJQ6gaD3l0BkKd0faHkDbY9slg73aXAFbDcnAYV/m?=
 =?us-ascii?Q?RkuDF2Ub91ZnVNRr/G4+KYTlxzrBddNqrael1z2Zvdoz/BhEIqMFSHn3Aitp?=
 =?us-ascii?Q?MJRqf6nUdYZoqtCx6ieHNLewjkRcmU+lQfxXoY7CVa7a9+rdj67xRCiLm4NL?=
 =?us-ascii?Q?6Au1U101vgxr8VGrxugVnu9LRMePejnWGQT/h6BBLYwxVXt89YZMZ58aw73D?=
 =?us-ascii?Q?TBFKw6fyLczuVVvoyjGI5RISlHZIPHXarxFtoMxkhzISqN4dW35cSQPDJZ1V?=
 =?us-ascii?Q?nS8F3OYtGn6onblWVDdmcS70BMWabIQgGUfzHbQ5Z85yKrym0tq7Pjcpkt0Q?=
 =?us-ascii?Q?fHgwzNMo13/0S60FsK5sKOdXEZcwOEhLx28h46M9YXFEFVusH5C4NTDuhLYt?=
 =?us-ascii?Q?OoQWsc/Mwyc/96VfNnSHIU+BUEtTv5EKN0qCW9POReTnHWzZDb77PfNZQWTm?=
 =?us-ascii?Q?mEBv8NdFQCGOcUkt4gS45pQGiid9yuBlZCZR4c8WKRUTdHHtxoEyxDXFPQKU?=
 =?us-ascii?Q?KULiJ2YsyWcUboW3P4EFm7aWAToPxXavM5qmCNGID5a5UOn9DF6Fy2EtwC1U?=
 =?us-ascii?Q?T4VhjPUAUTfcCD1olf4SJeMg630ApQEweJEF14PEDTFRz6XM/XuuYwRo9JlH?=
 =?us-ascii?Q?Y7HZgexnm4jdg1WmDszfyzvEvb6RfmZ3ky0+hdQ+M8vQLLQRMiSQ53xgBeIf?=
 =?us-ascii?Q?qqgXbmLm8SmrbatgWFueziBTRHG+qN9EAc1L0OIYjWPp7D9StnDiG1f0XQKe?=
 =?us-ascii?Q?W/hl/Tiuxns58QV1bCuXPO9dcC8m5w+30kNCg2V+yq1jCY7YUVFOv5dphEiq?=
 =?us-ascii?Q?X+TcL85D+5YCC43B4A1kBKXhlk+CfeQA2aT4/m0Vu8hmphkvolf++8ayRP9+?=
 =?us-ascii?Q?jdwcrMQoh27qkGFUKmvVuQaMW66UeqfFy6W+XoGnfr2AZiC0rWo9g1TNbh2o?=
 =?us-ascii?Q?/02gOacXvrqwev2oxqGPwztB0UdoBG7A8Jr9FD7pzSgOxTH4EAgDVwXXcJU2?=
 =?us-ascii?Q?jYMnk1pI9OcnTlLE0JPuKpVpbDSXrGNgdH9iq8QLolaCoH4F1V1PacvmOoes?=
 =?us-ascii?Q?sDJcXjAgY2UOVM8pTsLjjTAAnUv+lkcYLoQTGd9rRBwYN+tQxCwuXFOzHEf7?=
 =?us-ascii?Q?pClwQWvOGXb1BRNTFkOdQM3H5KswMIbwN4UF9yUh7VD78nkztY3hKkNvDhtp?=
 =?us-ascii?Q?gURexSDgehT+kBOZZxXLMhHNCfuI7/lm1em+47ObAzfpfm/z7JkcxjFHyjt5?=
 =?us-ascii?Q?Y3A0JfaJO0VsfgchHZRBb38F3d2dpu8YGZk/cNgpWPO+gE0uO0uNBgUzX6cF?=
 =?us-ascii?Q?iAQ73AyRHxTq1XBODVy2HAeTibmiVVW0I5kKlBZyj1gc7nSC8r+UrSIyl4V9?=
 =?us-ascii?Q?DCZuPMNkspwJaZYuuIgM0wgBQ0HWPN3ZwHzfbAb183Cc8zqQYw1Rwmynsk0F?=
 =?us-ascii?Q?f74HSx8IC/Wp6wXfLS3oJsr8MNrlqiSumginx9EwL57Ar92BY6jwxnoutU3+?=
 =?us-ascii?Q?ndpa5D/ZQqbdSJBKiUfA1h86LZCvLtQ4rRuXTSSU38pFY/+Ld/Az7XrSIUYy?=
 =?us-ascii?Q?omVbBvoEwMrUXBENQVCWl1RuWRJOugSlAx5WMmBJ3+llb1TfsE3c/DibHjoG?=
 =?us-ascii?Q?RuYQAjyIAjc2O59PQaTx9Yp2JMYiLD0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b9d791-4ffc-4594-df59-08defeafc794
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:40:05.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLqn7NqZKEgMMn6sMOIhEKjFFBF00vQG6PfNgeAzCqWPTHybcn0MaqOmUeYigIA1+XAv2DlkMiaQtSSpORTZcnaamj+Gze2xCNvcNJm6Eio=
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);
-- 
2.47.1


