Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67930CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMiG-0000TX-C6; Wed, 07 Oct 2026 04:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGUF-00046X-Vp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:30:49 -0400
Received: from mail-francecentralazon11023085.outbound.protection.outlook.com
 ([40.107.162.85] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGU6-0007Co-PP
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:30:23 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lA0W5A5pcSfJ9FdJbPKSyVuhTloKEFemz4bMPkD9fP60DJP8dSO2vc8D/ETU5n5TQ8vta8bGlVJ1Hwj4xkv7zAdbqweGA9UsUZHFuJEbzBt6M2ajpP5AwjN9KN7TikHZd7wPjHIwxRsy2aiJZLZrz66MFBB6I+/C8vFSgZFPmI5hio3uhZeXaeV3pcnfqu93nZflMFOhuhdiIsFwpC/jLvBnIkzd1vJ8CeX/cz4J9B2lBJkRwcXgJN32wCFqEpQv2uD2V6EFlkx0I0khaYDblzqWiurMbB/9Zra7HQd/YjOtR18EfsDPyrdt8FAPgdcnYBVwB/i9TDcmfCX+3f6hIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=caFqVIJyqjpzHpSbXXBKM3wlg9mmvd4XB3mHfeSecKKZEgISpFFuABgm5MHk4dXkdfG3a/TMV8daH4IhDbI3vfMJ+CJX7Yqd93yLWQxaH2ykydXEW6WfEizJMR+Z8lXWA9Up207I+p0UaGKFQyYmgxjbJRYi94GIogMFEVyem6koQBISQt6JV+nrNbiLdKV9HEuCLJf1FKiVAcZP3DyxISLHieCzUXNQV8iy7s/f4SmiAXprFohBzw3sIwIy1LOO+KFIOxjBDdBdYwMUAXeiUdWAnmoLXIEXuVvzVUJThUudAtS5UL7a5PHL8jZgb0JhOgk8K+gQPHSIiejWxBSIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=Nw2Hec1M2Z/a8RedCNYWiGcbPrAggcoTlookaQ+9HPBNvVMeps+6sTDKXlxUSsLojGUJGjJcuciQheDmOyKfvdfA2jCjxrBW1Ng3loRKP96oMfvCtCngDFjT3HcpMHnjoszrjiayHGPAn0kFBanBNyp418pH/ASQNauovHKVFZtpDRK0oSAInmCc49I8qBOEd1PNQz6umIRtsCiTXlC6x7CKRayd6dGbYpgzNoAR8+H1BO2qFXKLpyKhi5jw3W9+rGv0fs4V5tpoiRWAEYOkreyFl2o8JtRlOmzsqDvdNd8SYky3dqvZqDKkRs64hQg8PN+w5l7+0tS+w6VVPYtH4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:54 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:54 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:32 +0300
Subject: [PATCH v13 09/22] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-9-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bfd195-57bc-4454-07a8-08df23b1f577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u2E7zTdyED21q6tPEjwt2CaM/D9aXq0JBcKThlfKkfE43pV6s/PBV+sxE2ntYYyuuzIc7z0AHnyLvUcc6hjwv22VDG+fGezETOPNXgoO831F0toiFXhjjg86dTp6lV2lZlz+jHN8eViClWz88vNLSiIA8yYdI04Vj2jqA2TD3zFoomKoXDtbFutyIRND+4fXoRgANQpoGPEioCxxoezsEzfX+C1WE7aLokeKpvDUxyNIUF4iTKr6cgZmnJ49/kEElb3Hcce4cXRDJWV+EBmptwdAlGId40tbnl6ejDnyPmXEM2/wdSeYeKj2y7B7grPv7iMlynsgdCcGxGN/dSZGfi3W8IIq0ySTuazDKgtx71Dhn7hbZIgBJWjmK5qzpB94XjiW4LeJFDBtA+MsMdQsvOqUYCiW7GZTIeExIv1j4DOJ6oPmFoQBS9VBnQv542N1PTjPCbJTTnLG4eNKf69KX86DNXe1MzlMcLOXiWkBc07LQc7N4HQxwCpo6icR6lvkGJO/9Nn5Qnl1oYzDwr4NFaEWXDJ2qkznbD8PGPVHvEzAqlz55T101BR8SA9U1MoKJuOqfzzndj9Oz3gN+AtlpQxnwnjEYUhUnMooxYGMHZZcIRZdjVt0oPrfsnjKLuXugP9eHxjCvFYD39rbxOJmKOmKRTJsDMOP9TeQvAQ187vq8Nu115dNJjhmgmLlkOUu7bJqEJ9jQEa6D6FbvGHU+zgCRtige9PFOAIiTG1Khz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FTWVZ5Ni81eUcrbHd6U012UDdzS1gzNExHSmdac3phYjBPZmhLTUpiY0h0?=
 =?utf-8?B?MWI1YnJaZUI5dUcyWXNZUUlpYzVvVTRtS0JaeFlhOWFaci8vZG5YcFhKUm9Z?=
 =?utf-8?B?ZmVPNHN4TkFUNEV3OWhPVXZZNGQ4OTZjKzJoSXNFaEtaK2tybFVEVE1iNHFX?=
 =?utf-8?B?aHVIeWowNllGdElaaVR2RnBURzJVbzk5MXlRUXlyU1doWTByMDNHQng5cHFn?=
 =?utf-8?B?aE9CeG1TNk1IQ2U1Mi8rUGhWWTRtcG8waUFVY3Y1SkdJU2wyQ3NZemh2OFFt?=
 =?utf-8?B?VTRNWjZRK1lnVzlPemE1b3kwUllDWXB6YWZ2Q2VxVkRlZU5WOHdYNG0xbEF4?=
 =?utf-8?B?a1RLMUhrZTN4WFp1YTFlc0VoNEt1SDJydUp5MFZ4WnhFUjRpK2l3aVdjaWxj?=
 =?utf-8?B?WTBtOG9lUHFRcFR2d05VZldnZ2JGV25EdWpIbzhWM1d4eTJMSlA2QWpScU42?=
 =?utf-8?B?N1NVTGJSSjJpNnNLdFdjcGhQZG5PenRVMzAyM0p6K0pySXpjQ3ZsdzJmak1w?=
 =?utf-8?B?alVzMS9SeFlIQTFTUWh1ZUVHcEdYYTBaRndMcmdINzN5OE5jNVNldG50clpv?=
 =?utf-8?B?WUV5cUV2WVRRdjh5bU1NdmVqWENnTnZPVUM0eWJuUURpeDBFZFpQUUZSVmJD?=
 =?utf-8?B?enRUT3dJYTV5MjZXZEs3NWV1M0x6VmhxdWhQLzRZQlFvdEJFZ1lYTUM1cjg0?=
 =?utf-8?B?Ly9XbmxBdkxRK3pKMFl0VXF3V2E1OEx3cExWaDNlMUE5VWpsMDZTVkxLZWpV?=
 =?utf-8?B?LzVPMGJucHdienM5UENDSGFUdDVhTlVSdzFxNEc2aFIyTDhaZHA2cFY1dGQ5?=
 =?utf-8?B?bEJnV2ljNk5ray9LRVBGdzBUNlZ3S2RUOG1qV3BMNkNKcjMrb09NRnNMd0pz?=
 =?utf-8?B?OWJpazNDbDgwWXVwUzc3RWRVd1FqMWZJT2ZXUHlKYUM4OVZZOGpManY1OTNz?=
 =?utf-8?B?bzkvMU1idU1nUU9lM25vRHZyalRLUjY4K1hweWFHMVdTOGhkL2crWTloQksr?=
 =?utf-8?B?bktSQXVsdEpHb2NnU0tYdUJTaXJ5aXVPSE5pbE5McmhhamNUVUx5L3ZDLzk1?=
 =?utf-8?B?MUdoOTVjYUF4Y3d0ckdwM0pNcEVxKzBzTlI2QS94UFZELzN2TGhFaUtXRXRh?=
 =?utf-8?B?MHlScTV1d0p6MVhONWEvWlJ5SysvSWhoTFoybkpOZFBVQnowMzV5QThIY3Vk?=
 =?utf-8?B?UjNUM3pSQmNnRnYwRXAvdHdwQXhTU2FSSmxDNzg2NWdaR3hDQXo0SzZiQ3dh?=
 =?utf-8?B?YkFVY1FPNWloK1Zzcyt0cDZEdXRtcUR2MjhERjNsZjZTSzhvSk1XNWNFUU90?=
 =?utf-8?B?Z3ptcGpRdHBLNTZDQVBHZ2R0MU5SNjR1SDdDM3NpU05mQ29ZajN6dmdtd0pk?=
 =?utf-8?B?bDNsM0hrSVNTbEtxQm1aVFQ2Q0xwNGhYbW5XQUVPNDBqdXZWUnNYVFpQK0FQ?=
 =?utf-8?B?aXJYcUxjL01zandtcC9KWGpSZ21SRnFHUzFUeXJaVlRhOStHMWdRbGRHcGhs?=
 =?utf-8?B?L0pVRWsxOEsxT1VoOGQ4aFpveTZ6NjVEbGcrS1ZBbytEQjgzRHlVSm5SR0dj?=
 =?utf-8?B?MnpJQXEwMzBqSFl0Q1lubzNvTmh0U3VTWG9hMkRQby9HQzFKV1lWR3g1YnJX?=
 =?utf-8?B?NC95RktnZ0QrQnZtak1tRWR4L0gvdHN1NEZOaTRzd2RJOHhUUkIzUiswQ2dU?=
 =?utf-8?B?MVhxY3l6RmprRnhjRXBRMmE2V3IzOVNtLzkrZk11eElXeTAzNTlaWUtLUlNF?=
 =?utf-8?B?aC9lSjJSd0pQeDRldGt5d3ZQRUtNYjJORlRJdFhmM3ErT2x4bVNXbDZMMG94?=
 =?utf-8?B?cFNxSkRtOW1tUVdXRTViaGtzK3RFQnJqWDdoOTNiWGFZaDBpODdTTFZvT3lo?=
 =?utf-8?B?SjRXRmxjalJzelpHeTQxaS9GdW8wYmMvcXp5Q0FVZFY4c3IxR2hpc3dzNXU3?=
 =?utf-8?B?Q2hvVzZYcHZ1MXdHem5QTVowdzhFekxrTldCdlBaVm55WjZRazRzZnhmVEZE?=
 =?utf-8?B?ek5FWEk2dnFwaW95NEcxL3RVVVR4VjRycS8xanRyRGNNMHd1OVRrTnR0bTFv?=
 =?utf-8?B?dkpFaFVUNVpVeCtyS1I0dU1WdWVudmhKcURZc3NRcE1rVHZXY1luVGdxMHI3?=
 =?utf-8?B?TmpCZFd6ekhrUnI0TFB6M3VrRG9OOHJKcHhVdzNuMCtPcURoWitNbkRDRTdm?=
 =?utf-8?B?T1pqQk94d05EWTU2akRjc0lqdlBSeGlNTEEremJuVDBlTjNZcEZrcjIweXZy?=
 =?utf-8?B?WHhuakg5VmxCMXBQUVRicG5zQlJySnlXTFlNMU5BSk5uMHJXR2NJS1VHTjN1?=
 =?utf-8?B?VUVaVm5DVFM4WHNoZ251SHc3R2xhZ09haWZKUHVzWWp3R1FPTnp5cXZjY1l6?=
 =?utf-8?Q?8qMsuZG1r9lORBuw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bfd195-57bc-4454-07a8-08df23b1f577
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:54.5408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhNVNh1flCzUrCyyLSb7XVJSvAjkj5+0uEkskrYDHoiXKhlqAKrVOVdaTW3D5iH9/j5HoKynGHA4lfhhmLEWP1al8x2g+QJ2mC6X5zBmIVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=40.107.162.85;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


