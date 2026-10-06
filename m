Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4EECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN7G-0003Td-HL; Wed, 07 Oct 2026 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI40-00016L-Qp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:40 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEI3n-0000LX-Hj
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:11:25 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfk9z9u3TLJwAxFMh1Lmqvw5mI8Fu0vDvJ8jjfEqmhr7C2ci7D7K7vD5pv5gIBrNOD8p8qgLBPiN1ZlV298OUrgpf4bEEUE0G1XzaDtiAz775TLp0g5GO329bytwhUT+aL3DeLKZC/Lv8WrX9AHssE2RO3mV7aAwxQpCA9fsg63VVM6CISKiNQ3fc7fi4MinNo1wM4BSLAYdF7sRK0kJRqzr3+Vu6Kgt78fzcmpbhmr0R2A5ApWFetUJ+h2bC4IwmCUmmcBziXi87S6oXy8zDLOX4NZY8NTs7XcRIB562ebLP8dQxqTWvxDoGQTJZEkwILI/GICvYZu5kvWMr9OJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=nIqxi+dpFZtH4ARuHUDe9kSjlVAca53DSf9kpmqic7SZ9Jshyt+Ane+1JGWaR2P2ga5iB2i0aVFiEsqYUnFY62x2gHZ+hpzzaKEBoQoIVD7wUf9bUcw0THXhf8fWa/teir5zBQM007Vxn2GiBM0gPCJfbChIkyQNbfaM0ruhL/3g7lb6MjTmMDvnyGF70CQStmrolQd7GDYn9J0uYB+1O8i24QC3om6smqwW1d35x8BvaTU672Hrv45kaNMP7xxXI1o9ObB9B+E2MQEb7d2FrlwONTbTiWzCSqC+JIlEGEVdIlO4jr3ULZ2KEmh66WCoa4xFl/ztsqJ0D5PODMDQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=VeI4HJQ+64tHVybBvUJoBoslu84G9AhsJcN32lSNpduuI6DX5YNIsDN8QKf6ci8Iyd4kNadtTA8AEH7pfkBjp1hBRS1BHiypUy8vgZiuoNS1/k1y8rokO7aR9Pcd9x4iHEKY541O7umxv4jOdHK7WVcFmFP3VsEDy6HUkzddGiHdyeCMPkFl5tHAty4Y/992JEV3fYVCEDOCjMWDn42wKq0qYdVLp5fwFhKVSPH6cI1WzuIi7PlE9w2mQrZybCiyO+/2+O+ApTfYmiukV4oKJ9b6F7R3ABMfwTz/YkDANS2o/KZJl3UUiwDo5ngShHOOZrEtPCoB1GnZHW4R3Eg25Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:53 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:31 +0300
Subject: [PATCH v13 08/22] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-8-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8dcce87d-3561-4bb6-9b47-08df23b1f510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kNWJ3DC7rIF7uGuJL7/IRDkQcaSlnKzEkQnFiGMM7KVC7GOzBryBQxa1fz1IeEcTFqpxoEWABgq//7EXHYCeDVz7cgIej9dFOheT49dPFW+QNQCwC+aa2pHseZQqvaKGtJ/XdM+WAHfdewAneJBgT++AAqwlKQEUWUTNBD/N45VkHWXFX3UfCRNpeUy+W68nWXXD4qTKm7Z2aKA8bUI0e/T/BuWedC6RFWyiNM+vJ7TY6Jko0gCYNBc8FvnLxm555Kwy9pnh7z619FQMkZ6Fw9m8ZoBDxB+PjIaV/ZtbSYzwyVRmRW2z/yeTsafNavtrDRcY+LhLP6WesZgvKEhIpIj2MbdJRUmKRXV5KsuLNzgn0YDfLOU59+Y2pmo/MgDYslhU7J0cPLKNkBlPSbdxjGRJ1YC30wbgHcIaOYP2WIWTA6BreeKZp7Iw5J8vCbl9GCNz2gHrOf8xcZ7utS5Vst8kRuzXujO3F1cY3Tg+MrNUd9O9gNoX+XteBejIvyVSDk2nxTTcOTzTcILUOf4lo1sm0f91SrEmEKTNvTa7AWkr+IoEti4K4jn2sAw3rt9w4MsYiW/+lntIDEGtCMK3krPqnEpsvqhc5qc9BZ9ZjiVnJIfIcdRQ7vayKSBWLq7/+ZnjXH61U/hg33hwR4adlLBBnKllP42MaqxVXDSxTc9Zo1XjMjPnKocA5c+5a+wfl63+frs25LjdfgiiyTDpwrDQBo+hhE0tx/XsUL7aIk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1pSHdzbkxzMDlXd0RwSWJWMmhId2UySC8wYVlTNERQcmUrS1V2Z2M3THBS?=
 =?utf-8?B?VndRQkExUnI4V3l6WFJyMzF0ZHVLL3QxbFQyeE9SWUZrWjlZRXk1aWVWdGJL?=
 =?utf-8?B?QWNMTmV2WnRMWFN3Lzc2YkN6ampwQWlzdVk2ZXovTUk3L3dEUDRiNUZlUE9q?=
 =?utf-8?B?OS9qQ1JHME5uQXZRdm1CTk5DZnpRWW9uT3dQOURyamc5MkR4ekZvQVdMV2JO?=
 =?utf-8?B?QzNiSm0rVWdnVWtFY2xFRlVzVm9XZEo0Z3VURmNmSzUwRjBnV1RlSHRza1VU?=
 =?utf-8?B?ZXc3bUx1VlVsOHlnRjZzZXM4Qk9uaTZLY2hTQUR2NG1TN1Q0dWhIZFo1K0hD?=
 =?utf-8?B?YVJTUko4VlEydUZOU2RIWXdSckt6UWsyODV5U28wTXdnQjlTdys2WE0rejBU?=
 =?utf-8?B?VWNXZm9kRGZHSkNnc3RQSkRLb2ZSc3FzRjU5K2xyc0trM0ozMmdmazRKNlR1?=
 =?utf-8?B?ODk5UkttMWJlRHA4SElNWHNRQ2dRaUMvUFRPWkUrellENnFTQXlQcVVnWm84?=
 =?utf-8?B?WFhpZHZzQW0rU3JCeDZmSDRRSzFpQWtyTVRrc3Z6S2NLNXBwbXJwSzR0VmNn?=
 =?utf-8?B?aXI3QVhjdk5NdDVDaGFlQ1E3eEtnbnhWam10TlQ5M0paaVNvOWR5UklQeit3?=
 =?utf-8?B?NTU3UzVDc2NPUWhxU2xaWU5nVjA1N0xVb1pZSm9XVWlFVFBiK09yMk16eHVV?=
 =?utf-8?B?S1BXZDcwQTRpYW9zcXJ6R284eERCK01NRVhCeU9YV3dCWmdGTmdZMXUvckhG?=
 =?utf-8?B?ZENnNmkvTGUxbUhsUnFoWW5tTGtra3NRRVJQUzdRckpaN1RYUkZhSVRUZDFW?=
 =?utf-8?B?SGJOT044cE9nWGQwbTB3NGtZMDNTWVB1MHJ3emlZVXJyUTF1K3BLOWNyTjgr?=
 =?utf-8?B?RmhNd3JEYUllSUVTSE9VNERkclBONUlFQ0taZ1NPZ20rWW9nOGh4dTNPWmpw?=
 =?utf-8?B?Njk0L0ZtR0d1OCtna0dvTjRIQzZOMWlEZVlxMkl2Vk16dFhRREI4cDNkaXNT?=
 =?utf-8?B?cm1QWFZpNEV5Y00yakJrZWZTS3pkcnJoSlVQYmErV2VrcHRBQURJbWZVcGQ1?=
 =?utf-8?B?RXdWTVFUbEdhK2w0YkN6SSt0SmtCMVVaUzVudllFMklsaCswTDdzeXFZb1cz?=
 =?utf-8?B?dU9pSGZlRVZDdVZ4ZUdRUTJ3cE04RU9aOGs3MmJhbkJvbUJLWnpGcjkxQUIy?=
 =?utf-8?B?UE1meHlId2trYXgzMGh2aW84NGpOL2V4NVdEYUdrYWlWWkc5eU5IT3ZTUms3?=
 =?utf-8?B?enRmTGo0bzE3UVpGR3Q4VUR4OHRUTUIzUkRTakw2RHhnS1BUMkIzNnd3eHBY?=
 =?utf-8?B?THBLQ3pINDA1Q0g1cUNCNUFBS09UVlV4YXJXNjliSkxsSE1YL3c0RmFTbHpT?=
 =?utf-8?B?V3ROUVQ3N3FHUDJFVGwzdjNFajdCT3NoRWQvaVU3dFFQZFJZdDNrS1ZvdThn?=
 =?utf-8?B?d3NvSWhJMERyR1Joby9jU3NLSHVUekdNRy9wVEJQdTZRTWJvMWorUkhUSU9y?=
 =?utf-8?B?MTBPczRIeXY3bmdTUmxobTlKTm9hdGhiK21heXhqWllQY1haOEpVTHc3OTYw?=
 =?utf-8?B?amJVOXBZVTNNM1NoUnR0WnliSjJncEtoR3ZzejBtK2tuNGhSTFQ0SVN4Nm1N?=
 =?utf-8?B?ZG95TWhmSitCdHVpaFhvTDdVV0gycTRtczg4SjJWeGVUNVB1VXBxdDV6Vm5E?=
 =?utf-8?B?K1VSTnRyZFFJcmtGZ0MzUEVkNDBHYTdkK0MyRlVPTjBxODV0WG0xSDBwanVO?=
 =?utf-8?B?REY2S2ZlNGpzTWNad1ptMVdhdGRyemZVbGV2TmVTY2RxZUl0czRRWXlEWk5l?=
 =?utf-8?B?M1djL2hna2xSL2ZjZWFTM0xXV2gwTDFrUnJwMlJBSmhCdVdNWG4wNmJSeFVM?=
 =?utf-8?B?UXo2TWhYTVRJd0kxbVYza3dZSVVCKzZaSDlJYmhGdVFxSndHYnhtTTRyYWJr?=
 =?utf-8?B?QjZHdENVTXFxSWMrMmNnNm1zV0NkSkhmQWU4RHM5Z3ZWVnluTlFORjl4eVVq?=
 =?utf-8?B?QVA4b1E4cFZELzA1NnJsazAwcTRoa2ZxcWNIWGVPOTdHcE1URmRvaDZaV3Bj?=
 =?utf-8?B?a3MzRmI3V2NtUGthU09MNkZVVWZ4SFhyRHY5SnA5a1NUSHhCbXJnYldzbkxB?=
 =?utf-8?B?TVR6bjRVN0trOW0xb0Fvc3ZOd21HVEpBQm5tUy9YVGxrTnZmNy9iRmd2cnE5?=
 =?utf-8?B?RytjamorRDFtV09QUGlacTU1aWE4Ym81ODZyT2RTejZqNUZURUZ1RHVVYndS?=
 =?utf-8?B?b2pWMDBBTHNNaW1zakZBcHRrQkxBcFQ4dmtWMkF2K0hKRXQrRXdPWDRBZmRa?=
 =?utf-8?B?bHZ6QStTNGtLOWUyOU91YlNxZnlQRE52YjFXS04xK0FmZ3YvSWpyaU9ZQmlO?=
 =?utf-8?Q?SWKaz5rwXsJNNHa0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcce87d-3561-4bb6-9b47-08df23b1f510
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:53.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgEjgXEwoT9lMT3On/ONdN5GNxp8hHc/TkmohFEVPlfAeqoQZKTgdxZw2waQaq2enAIH3JGpwSgM1eSA01TtoLROu3wL1vrvLe/jD0SK3sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
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


