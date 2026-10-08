Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F81CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKU-0003Mg-KU; Thu, 08 Oct 2026 06:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK4-0003Hr-Hc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:02 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK2-00014o-EA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRsyJ/TVuYweqJvQDvrYEr2dNw+DiNLt8+xz9832kfq52snw7RkG0dvvesVy3l93y2xYAQKul2c0f6PCDofqqWbF/bgMG9WgTdvaRqO+uYCRtJrBdnZNtAc4H4uoPQ2zfootvCphrudy0npDOyeL/Z/7vNRoGFio7GNOcKj1bjGAKiV0syDK5610Tf9MYRC3MXBd+Qh5/cALxK4tDk61Kevw8tbQJhGWbSdspaMkHBgcSxF1riO0BiwoctexeBUw+Xn/zkahoGrcyhSmYBlzDcSYGlAepMgiadQAY6P3MLDwMP2PEC76XFZe+FE7Tg/JuVy9bN47nmqeML2vccsbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=qJcZcehqklT4ZHqXZmxdnYErZRYp6TsgxPeFNnXLxowajkM8uhvzY0HG93nQG81PAfBSnavY2zjViAzLFtK6p4h9kqAg9FJ901Nk+n9o34CZrmw8zx54ZUJzHB0lSGDto6O0DbuEvHi1TEXI5wUf5KUaqhxYVcynvHHCyMe972GJaT0Dps3YdSqonypVQVljuS+kQ+tmM+wjUcdCgrXzIHIe2LTA9fj2FjhXJeLqHY5JUmX3T96dh8F4OhjJM8Lk92T9dSZwKCRQxO7JfxddmjZrbNf0IpOryfy0vbJRgZ9Cs8ODopsvt7sSg3xDpuRXSY1pBG/0cRtxXzNNFl4MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=ymBrsbFybjtAzX47aXlO3QtufbSYsoUeyxmhslv5kHN+SCgoB1fNGz6Vi+MFW6YuUWRZckkAgVcHXKvvJnJyg7J80RXeSNwtgwSkXiOsh23ymMfnq0A0eo9j4PbuV2yF+QrV//gGQG76D1zOmCN/fa0iA/NcqsHNeN5k/WipBEjy9AGk+o/K5mdFlnjhtv7pmB8JyEqLY77tf2RCPXS2TCvkbnQT2WMkHmvwGI1noauH0Ep36dJXNbL/MIKtayBn0npoft1nUCIBK48nEJWbKdtChglaUxlTSSyRxD0ZfrG225DeLQie4YURNzDlolFPxUjahMYPsuQ0l9KZUfq2dA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:43 +0300
Subject: [PATCH v15 19/22] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-19-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f80b74-81d8-4712-e841-08df252684b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: PSQ+K8um1PuodgaXybNWCwdLl/zxHFyhRjA3VjgOwcU+BmIRSVVJhRZu+m68ndbgZEXnJmLvUDIfstAu+4n8m5Q1N3WPQyJxQr4k0xbpYrloTtZMx5fioY/el3TSw+tCpPpBUrByqrbAzcXS8lSsQ+M7IFbm1qJ+UB7lMTQxYBlTBVtN9cJjLet6ioRWtl5r//ltnp4TzerTjsCQ3+A0HV6v+aG1fpm4XHNoKnjf+2a3yLeCnKgAW1B/KpWwKxtbfgSWbOimsWQDtd6AjOJgy8f4T1twQlsWIhFy1XlED/IrTjVvyECM2uKoZUtxWPqJ/OcFHjt2srRO71G/Ehv3VkDEnirK1BkkfXBgnkvp1gNAbG6ecco0a1x7I9/BxJ9kEZJtaiHz+LlJVw5qBmhDPj9ekLc+OCEepDBtaKtWGCxTN2jiWRNLLiEwx2QoPsSMlNrC//aUnGfO9nX9nB7u6x8SKoMikE4ffckgpdDGJhdmmQ+kiIuKbvuMJ7phvTJOKKpkotas852jFbwuiNYAQxeddZRPxak1c2uTVZkcZ6uSJ19pndWPSmUX9vFpXfZM77AXHSXRYNos3nqEoR7FkudzdeaId3nQAe/UyAlI0ZxgWXkreqSz+wcJ8S6Cq7iwmyrL7Yf0tt+mSDBI76wW8xO6CLlXeYiOICeSITsjvFoA/ePl9E5niNgLdrKBDszQ2cMZleV7GPq8ZqwYAkaBIPc0TKYP0XjUzr4GRDWx2Mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNQTldXdmExckhQVzFVbjVMKzljeDVsVm9wbitQcXBOdVZaSWdaU1BNQnhW?=
 =?utf-8?B?TkJOQkoyOUFpWmdBUHRPSUJTQms2NmdmUDNyNHhkQkthN0RscFFjRFZyMUpD?=
 =?utf-8?B?bjQ4czVMYUM4S1lWK3ZwTUozWnBSRmk0UjRwa0ZrNGtiWi9YQzFhY3A5MEwx?=
 =?utf-8?B?RDBPZ1pnRDRYZlhUbGNpdXAzSzIwejU2YU4zYnY5SWdjRFpSdXdBbGRGNTVJ?=
 =?utf-8?B?TmpvVHVHTjVZclI1WXFudGJKcXhyMXBkaWFwK3NveGFrdStpYlNiY3lPTlU4?=
 =?utf-8?B?dUFhTVNhMFVIRGZxQmdtMFBLSGU1YlpndGF6ZHRrOGlGTTVOTEpwNHZkQnV5?=
 =?utf-8?B?ZHE1TDhwc2VOK3R4Ylc2b2JQbE14c0JqRzRTbnkwNDBTWWpJN1BtZERRWmxz?=
 =?utf-8?B?MDBVK2ZXaE5mUjlIWURGS2YwN28zRlJtVWxqakRvY3pTZDJrempuQ1lSeERS?=
 =?utf-8?B?Ky81ZWt5OC9VQUJmbDU5cVBNZVhnM3lKVlpYVjN4ODVheHlSSnlZNnJGc1dO?=
 =?utf-8?B?U1dTaS9GZmdqLzg1MldDNUNKYVZMeFhRb2FuVHcrdHp0NmlGaXdPcmF6VGpJ?=
 =?utf-8?B?dVVyWkxWWGYrdEx6K2c0SFphei82YnJhSnBnVHNTNEZSdEZyODNBdFhhU09S?=
 =?utf-8?B?Z2g0VnZCVlA2a2htd21YS1MyRVVRODhVOVVTUldFWEV3RE8ySFhsSXVsZTl6?=
 =?utf-8?B?TEtLYUVxVVAvOEVqUnQwRDd6cTFBeVZ2cWM0R0taTzBQaEFkNC9BVk9UUnEx?=
 =?utf-8?B?VW5zd0ZUR2tSRlg0VkNPeXNkeDRYVFZSVWx0eW00L2dNd0w2VWlURkQ3SnQx?=
 =?utf-8?B?dnpQK0FFajd5R2dTZ0xKODcwaDVnN3VKWkdJQUNvMzk3QmxEVmliVVp5c2xq?=
 =?utf-8?B?enNTSGVEaDFaTzE2dVMzRVQ1TUZQdU9SL0wwYnhnWThCQVB4SWF5bCtkUW43?=
 =?utf-8?B?T3dTc0s1NEY4c2FYaHVETHp6WmJrbU82OXZOajNxaEpjUUI3ZEZGaFZzRENG?=
 =?utf-8?B?YWZHWUNMb21KMVcrVzVaSzR3WUsvK0MxSHVZT2c1TjZ1cFlrQXlRYWhrRVB4?=
 =?utf-8?B?b0xxM3owV1R2UUVXR0ZpZ1E0VzlsNmpkcDJyTmxNY213eDZhdHBud1UydmFW?=
 =?utf-8?B?SHJ5WTlvNDlFdUdoSmYwSjhSUWFxUTYzbW9UNkRCdTU3UTcvSHFGWDN6WTlS?=
 =?utf-8?B?V29jbElncnBKQldLSUcxU01nRTJac0lFWkQ1Q0dpcE8xWGV6YzJxaHFvTjFy?=
 =?utf-8?B?QWx0RGpNeWlWUHg3d2xLbDhVa0lzWXBlUDI2S01YVmRKQmFydUp2WU8zVUhT?=
 =?utf-8?B?YWZKbGJHVUhWSlNnczU1c2VzbXdDZmhnTHFYUkltbkZ4NXBWdnFjWWZnZWhm?=
 =?utf-8?B?Zm1hS0QrUXg2STFlUEJxSUhuOEhFRmY0QU4wQXJrd1FPNDBiRThvNTJIbENu?=
 =?utf-8?B?SE4yRFRuaGlVQTV0ck1IV3J1SzRIWEdaNnVGcG82WHYyWlRTS0NpLysyVGs4?=
 =?utf-8?B?QzhkcWNPRVd5MDhwaDJ2K3NHSEljeGVtM0JGeFVnMVFsdGpxb1hqQ0dFeThM?=
 =?utf-8?B?ZllVbGZ4RVZIUDEweEMzTTRrOWNvZXRWbDFoVWhENkU1OVVJYnRVME80Y0Rq?=
 =?utf-8?B?MjBhdUdiQnFZYmsxV1doc1Nnc3ZwaEZ0MHEvbkptQkNFOTd3czNZSDBZU1U3?=
 =?utf-8?B?eUQ4TUVnQzZ4SlBhWS9neHBjaGFjWWN5a0JJQTB3djd0WUsvbVRNaGtONmxL?=
 =?utf-8?B?alM3d0daS3plRnRxTnA4NWtwVkptcUdVdGt6NE1IL2U3ZCt2RG9tV2FkaWMv?=
 =?utf-8?B?U2FJQ2VyczZKWDVlWDVWdWhEbWhKR0FwZllCMm5EYTZXWHArc0JteEFscU9J?=
 =?utf-8?B?ZzNYL3pLM1pLci9OUnR3U0src0xLMVpJZzF3UXpkQWZEbUwrc2hJZHZFN2lZ?=
 =?utf-8?B?S2o2dkVrZzQyaExXNHduUHMva0pxc1ZCMnliSHN4SmQxVURkVXpZNlhDbXUz?=
 =?utf-8?B?RDlTL2I5WnpwWU1tZ3ZiQVB0T0FCekdYRGhJdUVTNkI4Z2tjdWxYbjNEdSth?=
 =?utf-8?B?WUtiV0NDZHEzYzlFTGd0dHcvWGtpTjVRT0FlVzJLdXBWV1Z6TWdVeEtYWVFh?=
 =?utf-8?B?UWN3YnRDVS8zckcraU1ObDBmcDErOEtwVnQzVkFqZkY0NHNWdlFlWDlqaGtu?=
 =?utf-8?B?L21zRkZYREFFUE1yV1p0YWQ2dXowUitpQWUrOXRROGY1UzhGMWhzRVBQeXVK?=
 =?utf-8?B?cXlUV2tSRFJONHhXNk9ZQmtVWW85TTFlTUxWMFBrRUh6ODhicW9QbXlWeHRu?=
 =?utf-8?B?NUIxdmd5dVVXclJrZkVwUktlc1RZSFh0UjRxVVFhRDdZUkZHSDl3cG40eHI3?=
 =?utf-8?Q?K7OYGGN9i99w+mnc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f80b74-81d8-4712-e841-08df252684b7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:47.7963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DZxxDshrWq4sNc/BYX8vS+DsIKdW1DNrgo/6Np4VTR1Q8ARkpmR6WohzR/Y7Zaa1ko3k0H2Jgo+aC/7zrVI21alb8TZ64cGHKydEfhSakE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


