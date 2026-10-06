Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0264FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN8Z-0004zV-LS; Wed, 07 Oct 2026 04:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4R-0001AN-Pr
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:59 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI4H-0000dx-7J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:55 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awiQBgGND+q8QZDGLf77MuYYlIs/NIkyQOJqHPrfIb44mEjF9dlOdUaLthkxjzn39s75lh0BzdRotiVPLisLglGxb0EY0gkfxdmXs4AFQ5+8VhUIfI5gU0QuEKRZjynWJjbytnkuhDbRupWfF1Oq1YhkA6UHoLf+RsSazSm0euTYHD/lzpcN24JCKIh4jQjywquoH7CIE/Qu6Q0dF3Hefq+n/a67wxHxyXmBZPW41fRskJIB5CAL4mx37cHAMBBealeeStLd/wD4tkLFZNrzhvnU91u/hDXWQIaGsfhQjL41BFlkTSFt9IR+6Ww8iQJjxl/2gN85sGP7pl2XJuWnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=kLlIYWN8kUjdr+mT4Jr1RJ0pyg7Pc6Aoe2LY67ebK44aDC4PZkqFNzOLAg+HFjoY5mZa5rCobV/0gGftohXBf1Xdy5mfmuyOW+S/CIo1hqOZvdZATtlHpBFVb9W6mNCxMXKUi9GWs64gcRXncpSq3O26DLSegdPxkdOs9CGuJMw/EyNd7eXBjQQ5U5c4YPdEltL86EpEmDjJe31eoLUAtCb00Nfk4JIPcxaui6qChVOZ06QG5IKdk3zLE4eTpZ608MRd+qaEwfxUUu0NFdhjVFCSBUbSw8s8Yvp5bjVhQ8vMX/Luw3vEw5sXdivEzF5uNPtiuSFZrll+6hk2IWqzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zZJ89Z45bQcI+MDgmQM5LzF7kuk0PxBH91uljpEleQ=;
 b=DdFEvkhT7zavFYRz7Xp31DAZ+KWqlTZtUiMqWuJDb3ixNgzbQvPHatShTd7Fs5LjqCbbzhDkVrxoilvOINMKWEVRpCnAn1xM4xUeZz36ZBaaDfgdVPbMUk0yPmPFBmLzc3pwMRBQSHJrjWora+JyOz2qvRhT2tlll5vWROcxzy8ZQtRQ5QgoYRQONrUYEfcyt0EOg4RS2Sn7WNfOh+lZxxrAkLYRQ9WFPC3yZHkrLL6l/S8BLgqpjrE7gaAl8ZxjuNK+OVxgzOq0BWzY2GUkZ1xC9r1+7QAfvXUbvGLcIqc/O4lvpftpjyKwNEEwODPzaD/ekz1mASMeAFkwak6WlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:56 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:56 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:34 +0300
Subject: [PATCH v13 11/22] vhost: factor out vhost_dev_init_backend()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-11-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 600f9316-1b27-4b14-721c-08df23b1f64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LuPyWJAnFOzS1x3oe8mchHMLIlfeSkfNv863gYvjRTx/jzfEBsIHAReSeaBrGGBODdRY/FGCavJDgONjhNhPj1blx1ZmN0NVhmEEQZwdU4qC5R57VAASemsGHEZg1ZuUaMntBWU3FnCdEb6Cw9Dq7XzvQmh1oPYymHjTHd6IUsXD41BSXYtO43UZnmvV56e7j1MeUoVc9qUyEud+ioIiw2+3wdg5RueqADR3X3AYZPtUyarq0NXPKvv3RFlUzb/9IF39W9GVmj5e0TTePun3KpGqioj599l1yd5me7QxK0mPofJLL2I9AWy+8EYStrzx7zLxxFknZ9OsBRFSutuTfxqLPD3Z0cI5P66yO6Yk9YF/7GzP5OA9YfZjtxrmI/N4WmayR3TgPYfDTAUrNJd7FSwwZtFFH01IP3OqQ1Xdu6/1/ikH5mPamlYxJy5KprPYxECZUqboPS3rEHSKK1bErhuMUaPZXbMUb8WkIsn+iQsMfysKJgs5HCztpwEZniR7JIh0zhlWU8exN4qkOkMjE6bMOuC7xeOqKL9ZwkgElLG8h4lrocJh65zZ2WpypfoIlwadAUfKgRpmXNjvA34xdDDbm/+OrY6gbDkCLnGN6FSSVo9YMReJCwl+xeD5vlNyMD0Dlhy1ySijaZsCn/JpobBBoVB+tCp2sSL9ugg+yM+SQ2uXAEc/yl+gjSYW1UFu024NcBRuiP4uxtZSigtLuJGlBitZspDHBOV+QMr9Yv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ays4NnVVRFkyZ2gvMnZPQ1k1UHR6OU12K2Y4c3ducy9yZC82M2pZVDFQNFdF?=
 =?utf-8?B?MjhFWjZnUS9YUnhWNUduRFU0UHVDcSsxeUhpcVVNWEw0SGxjV1ZlY0RERzRP?=
 =?utf-8?B?ZnVHN3VKU3hndUxsMTVCS0ZjaFBueTJKSUFXU0VvOHhvL09KZmpiZzhFZjB0?=
 =?utf-8?B?ZVUzd3pBMG5uQmk1dWxnWkpQUmpRV2lmYVYrVW91UkNJQ2ZCbVZrZnlMVzNV?=
 =?utf-8?B?R1p3ckdoTDd1K3dYSHdWWE9xRS9CRW42bndBK3cwVHByZWZIdzFYVjJuRTlP?=
 =?utf-8?B?SHkzb3hlZk9XSVllUmdEWVd3OVVOSXdSc1RoaXNYZmxHUitnYjRQdlNQSDFn?=
 =?utf-8?B?YXZIbXRjQXp6Qkc1cnJkRXB6a0lNWW94R1JKTWQ4THNjQVdjMEl1YjJ3czk4?=
 =?utf-8?B?WlFvMlRYSHhuVXY1cExOV29DWVJ4MWp1TzdMc0JQL3c4RldBNUk3K0NQdmVQ?=
 =?utf-8?B?dUUwYitIcVVhNTZNTnk3MldhMVhyV082TTJnMHhJZSs5OTBBWSt3L1V1alpj?=
 =?utf-8?B?K09iUG0yVURacTNpUjhoUW5GT2RNbGZqU2VNWm9KSXNuOHBRR0NObWFKcmZy?=
 =?utf-8?B?b0RwdFBFSm9zS3BBSDI1WWpLcGNuNzhWeE13WTYrMnlwaW5vRnhEL0VDNGIw?=
 =?utf-8?B?Rmp5NWFwREVtK1RJOS9wMENScVA3YTdERlJZditmQk9VcnVodkxsL2x1Rmpw?=
 =?utf-8?B?cTlETjFaUVZhNllDbXFNZy9BMStQUXdZUWphODlaOUdUWlJDZUxXYXI0aDhp?=
 =?utf-8?B?cmZUNGpHVDkvMEtPUW8zRFgzOXc1YTVaS2NPQll5R2VtY25mNWI2ckJDeFFy?=
 =?utf-8?B?SkpsV1dMQjd5blZ5VkxtNW5PcGZNSmllaXB4WE5waE1TaDhiSU9VNXdscGRy?=
 =?utf-8?B?ODJuMDZxZVdmYWUvRkc4cjV4V3NSZTZNZGlVUG5HTGE3STNTdUd0M2ZiTGRD?=
 =?utf-8?B?OVJYU0RLVjlKNkdOWUpZd0JwUVIwd2JDL0xZdE1MNURMOUhETStscG9NK3Rh?=
 =?utf-8?B?VmFyUWhoWk5DeWVYNFRmSWdLWFJCZGRPNVNjTE1lK2c3S1phZlBOSDE5enR6?=
 =?utf-8?B?R2R5anMydllod0Y5TE0wbnoxRzNCZ3czT0hLYzQvZHNrV3NackhVU043RXY1?=
 =?utf-8?B?N3M1L3VnWCtCYUEvTWU4Z25zcXZ4KzBLWnM1VVpZdSs1R0V6TThJdTFkb2p1?=
 =?utf-8?B?a2dSVm4zdHIzNG1SN2piQmRzb2w5bG4wRUZNa3REd2JHUGVMQlkzS1FpOEw1?=
 =?utf-8?B?V05XNU9IYm9MVEFIcjZOMWdodGlOakF6aWU5aEpPSjF6TzJ0dVlzeklSR2Vt?=
 =?utf-8?B?ekpYa2ErRmswMncvNlZUNWc3emtvQWhFVk9FcThHTGZmNjdXaGg0UUpuVWdX?=
 =?utf-8?B?cGh2dW5YdlczVkIzR0RwN3VVMlhEaWRxMXBJbWFqbERpVkJ2U1ppNk9NWFU1?=
 =?utf-8?B?NTBSSlZaVlpqMGlJc1lyODhRNE85OUJLdlFIRnBMci9tc2lEem0wL3ZqZDV3?=
 =?utf-8?B?VU1sNHFPMnROL3g0eFU0WVNmUFNWYWpYTHA3eWVRY2g3Q2lzYkdYekY5NTVE?=
 =?utf-8?B?S0JqOXpsRWNWMlg0dEMyUTdzWUpiQVN4TkNINHFyK1ZtZ3dJNlJQZytua0Rp?=
 =?utf-8?B?RFQ4YzhTS3F3YXIyc3VLU1NmZjRtNG94bzhLc08ycDlsS0hMU0hBQVFuUERP?=
 =?utf-8?B?T280bEFwMVJKdVRsajkzRlFNUW9EalJFNUtPVElCb0R0U0FLdWN0dERZWWN6?=
 =?utf-8?B?aFlIY1dCNlB0NnJFWkNRWHdWTkl4S3l6bW95UlBNZzF3a2huZThuYmZKQjJW?=
 =?utf-8?B?bTBxR2FyNmdiVFhxaHc4bnZoRFc5OWxzRmhwZ3dwMkNySjNiSHNtQTdIQi85?=
 =?utf-8?B?UGxFT3N6VU05a0NvUDBsRms0c1lkcXcwZHlLdEIzT1NvY1RQcmxoQlZXUlQr?=
 =?utf-8?B?SmFMa0xqQzY2Q29YZ2hDaUpVUEQzWXdNRjRxWVRlY2NQTmxBSVl5WVZVNkhH?=
 =?utf-8?B?ZG43QVMybEh1UFZ0YXFmZmVheWdjOVJzYVdpNWI1cE9iL0dlamRxRHAyTTc2?=
 =?utf-8?B?bUF0ckNzZEdFNFRrYTNYekhKLzJsNm5rSE9PemJsaFRSdkczaHkrc3NJY3ph?=
 =?utf-8?B?dzlaQ0xpaHM0TzB4NXZDa3hTeG1CaEZ5bTIvZ0Z1ci9tbGdlRjFSYWRrcDFh?=
 =?utf-8?B?UmhMSGRRZGRhVks3S1lKVlBXenhKR3NQbHQyRkg2Z2IwZVlRNHVXYWlTMVJI?=
 =?utf-8?B?WFVsditqa3dHOHlQQ2MydVN1S3l2cVl2b3Z4S2FtR3l5K0xzZWdrR2crUFhq?=
 =?utf-8?B?TkN6V3ZNVGxiOTR4MzNiVUJwanlyMUNsUUtwem9ZRC9ac0g3K2M1UXQzdDNU?=
 =?utf-8?Q?OLfq9t77c6ETmYUI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f9316-1b27-4b14-721c-08df23b1f64c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:55.9114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aiLNXzjqVSvx1aEM2JfXyl54rVSsjlRj0QPyubXC64i+d4R/6H/VnRUUPUoLoB0RXRMBwwPba8vOGvTnkNPte0fxLVFUKDx7HdNsfGOBRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 33 +++++++++++++++++++++++----------
 include/hw/virtio/vhost.h | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 68a8e404818..99561ac5868 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1681,6 +1681,28 @@ static int vhost_dev_init_features(struct vhost_dev *hdev)
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
@@ -1693,10 +1715,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
@@ -1707,12 +1726,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
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
index 0a322efec1d..b2b644c0d1c 100644
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


