Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AAACA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC4-0008G9-HQ; Mon, 05 Oct 2026 11:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC0-0008El-DW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:28 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBt-00056n-En
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vks/bsjQarPmZNJr0C576SZpoGVF6ed5hrLsH5+ee2n5PNXsSlZBbV6UrgbmzFpJp3TBBxgHwwYAU9a2XE02lPHT3BcGAF4hxfkcrYDjt0tUhbaPG5Yz+BhiWSQC3UkVV5Ff5uo2Q+4IT662Q9yzm1R27UhP5udEwpV7QWCp28KqpVRp058iinGtxJ84DA/6ZdqLtrq4t7I0KVwaYjrzf3H6zonNDdxvn3R03TK33neJMKWNfQcwBRvJYaFBmW4yzJQQ3+Qb860SozNRpCvMv05e68Rll5MX0IWBiv26GegCEjl6RmTUtkk0gXRI3qFLvU7gddrrDCVNSKEpA5trKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=X957CTGXBs+N3oo4leTAMmZK+wTiPA2wyrA4UrsCVk8a6U+W70WWJjV0aKQWBWO46g7x6BZs3Lni5YG0LcNGjgnqn6zr3Vp691jpWthx+/ZhOyGjFQPs0nKJ2eIqAvwpLn+GbN7NAO9Y0YNugMFVLgDOqZ4T9lAuAletwecPtJ2+/IGuAauJrgSIDPGmSqdNLgHtQPpq60vcszJdB683QNJrvDrDV/VYSpj3ve/7rZWXhwVLSY+esPw9+7r63YL4EQKalz/WYQEayimVN9bZwhX64VHBJNmRQYlB8Ck9LrQ9wKXdBmIvkDSl6tsMXaOnOB0izrIXcQp9hDxbZF3/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=m5lfPC+MHzBpohjwAndz4zNuKxyGOtbFZ/xwv+rcQ5mrCzEjSI5LKvw0R3/3EjIrHT91uIaqtPHZPCzbDYt9hb1a2F8G+DmAF756l5fP7gomiagiEGeEHvkVmeFMzH3L+RCA2A5xx0dD2wYLLbmQ5xe6KKSoaRMs38hKbwUohzO7O0mbAqhZJ5D3syHIwXBJr+Q0mk54is+wIGnD+ROiaqIGXpJLG+qkMhXG/fyVsHhAgjXE0KJrzJgeTi5D2OzFz2c7vdR4e4gVil5Vf1CM9yHEL7PGrUe8UssSTDXtB5JRPwegjm+LsLA/X6/zTZAO8pC1t8nYka7yUyy8PmD92Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:14 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:14 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:45 +0300
Subject: [PATCH v12 06/21] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-6-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b7152f-6ebe-446a-ab2a-08df22f18013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iGtRtQEQZa0uzHGSS4i9TqaRR2rS1v8bG8LEfTUqJ1H1Cgy5HBHEsqlC1xEVQ0whYSE8+tntOyWGKDMJwts6lLoriQOT5dj3qAcO6qYrSN3tluAQ0qkdLwiish45ZoUy4gp+ANoXotfZel1fZIYnflHFqL7W6wdBnvB68zAF+CVuAbuG433hRD6NCmOAk8Ommp2TdxHWm54zNLrnXA5Fju0+YVAlXFR4i6icZf2YBkh3WRggo9eQzip6BJFnEw2NTOhYUsDd86L4mivpfl9NcK+LtpZagCCPHYH/nFdYG7S7Un3Sx4ZnKlFMLYQ5cEEw1AA21JqQX7H+y2wcG4+zPRFbxzJarUdhPjTJi0tuTnypMEfyyvxark40UohKc+dlmpUuRYRCxr0VanvFPo8n31qh3w6MvmvCe2iqVzeK9Dk0j7d6slaGkSj3TokbkMC/bAvwT6rcxAWTBvxtKvYRaJeFhMmcGEOUadEYq2NO7aj8/8CBOFnCyey+0snJV0CoA+281ju24GNyZV9yv3TVVxaads6ZQHHprLuwAJHCYg4FrzRZARbkCvs8uX91Ay/EuvkZqMElH2+vNFgftsfOHmYS+ztkeLMAu0O9obCyjkV/IwdwW+XFVISYm/tOI2WFyDopZKhnh+wN4kYjUPH3cGMtUO0xchp07oRvHFTq6zzWU7wURNF4QFO0+b+nSSW1+v9jtl8V/j+6wFatRUPcmtl/UE4BjDMtqiMCJMiW8cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhWN3Jyc0xjWmwva25uM2o1aVhUa2xSWDJuNjVEcDZVRHM4UktualJ6bm1M?=
 =?utf-8?B?UGlOUnFYQXNROHZvNENFbUtTZ1VoY2VQQzRSWW8veHhZVm1Yc3g2clpianNj?=
 =?utf-8?B?a0QzNlJEQURxQjQ5S0tyTFZUbXdOZ0ExdzhVRS9neVFmajFGSVE1WGpYYk1a?=
 =?utf-8?B?NUgzbW9vU2l2eXpUTnRXbUNQZWhJNzdkTzR1QlZxZVRLL2dNaTV2QVYvN0F1?=
 =?utf-8?B?Q0VOZllValVSeDBVUzdXZlRkaGwxMTdnenN0bzdlNW1Xc2JOYTMvMC9UMU9B?=
 =?utf-8?B?T2hyZmh0OFhDSVFZUjYyZHNyQWRRL1V5K3FOb01aeHAyalBtT2ZWYTN0ekZ5?=
 =?utf-8?B?L1JMU1Z4NTI3V3NUZFBlZFEvdW1jQU9RNW9pSkVmZDlobWluU3FCVlFNYTNq?=
 =?utf-8?B?VmY4Z0sycFlQYVhlUGtlVzFlOWtncjNpQW9rbXREMjRzZEo1ZTBIZys4R2NP?=
 =?utf-8?B?Tnc3K0Fia0JIZWhQZzF1Yk92a1FqMEltMHFWaFVqQ2UrQ25qRmp5ejZOM3hL?=
 =?utf-8?B?TVhBTTFhTFZ4R2RMd3prRzBGRTIwaVhzL3AybTJ2VTlYWEs4YTJ5aVY1d0pn?=
 =?utf-8?B?OEVKY3VkNDBKUGU1OWhSbno0eUxncXJNS1FJRFJYbjJqck45ekV1WnZMbHpo?=
 =?utf-8?B?RmlJT1hZcEM4Zjk0M0FrVWtmQ3JqK0Fzc0E4QVFhVjRzZWNEeGdyZjNucFVn?=
 =?utf-8?B?azVDVUsrLzNtVDVqK2ptTjlIalBOd2prWU8yejNPR0NhOVc3ZE5RSWZySjhh?=
 =?utf-8?B?eElXNHJIakdsZTFiVkF4Y1dJVVl0Ly9EUU1QOGdpY1U1YzlyK1JLMHQzTnJL?=
 =?utf-8?B?Zk1hQ3ZLWGpldzRHSVV3MWhkS095c1lubEVtYTYzc0hkOFU5bDRwdnZvM3Yx?=
 =?utf-8?B?V0RzaWhCKzc0Tm9BclQyZjd6ckhNbzNreFpYL2JRVDBrVUt3Z0MxbUMra3Ix?=
 =?utf-8?B?ZzFYTDkvVUhzYTZuQmppUXF6V1MzclhuK2I0UXM5SVEvekNrU1ZXbjBPdWEr?=
 =?utf-8?B?Y3lPYmpPcERKSkRjUjMwNG5NcHp4WHBLcDNXWi9NUS9hVHVaZnk3M01ReHpi?=
 =?utf-8?B?NXNlYm9Ob3A5NFFWU0hZWE84SUVRZmptdU04dm0vdlk3R04vN3g1MWx5dDI4?=
 =?utf-8?B?YkpVOGJEa1dSZEdRY3UzcW9jRGxvT2V0VkZTR29FQ0FZL3lBeW1FbWZsNzYr?=
 =?utf-8?B?UTBZMWVEMHpjdkcrUGI5RXBrRDlDMUxJb0crVmxWNUtsYzFIM3lYQnhIZWxV?=
 =?utf-8?B?N20yZVN6ajY2NWdzdHJIM2pmNVVzL1UwYUlmN2NnMWRJYytVNTZBVm5JS0kx?=
 =?utf-8?B?K0JrdUFtSkFDNlZPZnM3eldJQ25YUFIzSzhYS29qWXk3MUhhZG85czZUblBB?=
 =?utf-8?B?czI1NVZkSVVFcjhQTFdWQ2V3dy9BdkkrN3dTNHZVZlp4THgxUTJYMVJlREo2?=
 =?utf-8?B?ME9TNHl5c1lJQTkxVklQTHc3ZUs0TWFtSDAxeWFUNVd1cmdsT28wWVkzY29O?=
 =?utf-8?B?UE9JcTZ0UHJCbGtPOGptaTl0dWxMVFF2YWlKcEswSnorUGhOWjhSbEVBaGUz?=
 =?utf-8?B?Q3ZXcXgvODEvOWRJdE5Hc3JRdGNnK3l3R0VpZFFxWE5qQUtQMThXT0RVYytB?=
 =?utf-8?B?S1lPT0NKR3RJaVRLd2ZVVkJvb1Jjcm1YLzBxUG5sQmNFN2lWMEhjRTJQRFlN?=
 =?utf-8?B?bC9wSmlPMUY1MmlmVzYvclgzZ2dXVit3OUJ6R3FjbmtIeis1WDNsQ2ZyVXhx?=
 =?utf-8?B?RWREOFFxeHBYNWxNVW9BYXR4aElZaG0wdCsyVm90K3dKT3VtMU1vdWcvYTBI?=
 =?utf-8?B?dHFscXRKMXc3RENxWWdZb0gySEI1WkRieWJjQUdidkFYU3hMc3NXUmhTSVVk?=
 =?utf-8?B?YjBzVG5DZlYzaTNDNE56a2JIOVRTZFU4aS9lOWM0RzFjV3JvN3FyQUNwbUky?=
 =?utf-8?B?d3hQWTZLWm1BSThid0djWE1mNUpobHpSK3dNellwYnR0aWprTk9Wek1zZmRo?=
 =?utf-8?B?ZnhSZHNmZitkb2hFa2NQaXNvZTVyRFZyTzc4N05OVnNYMmpkd1NGOThSK0R1?=
 =?utf-8?B?Y241cTNQR0xycWpCZkhDaXM1VjB1MWczRWJqamJYdmxPQytFNlZhQ0tLZVZL?=
 =?utf-8?B?NVlhYXJCRXZ2ZlJta1NtNVIzSUxVWEJLdHFSOVNFWXJxK0dIZlp4RTNnRmVq?=
 =?utf-8?B?R3QyK3NBUGUvbmY1RCtNK0hMOWhJZmYxNytCWS9RQmFwWGpveEhCVnlHdnBB?=
 =?utf-8?B?RG93SzhHa1pER3U4d2d5c2Q1bWRwYUV1TXZHeXFVYjFpbUx5SndVekFZNDR4?=
 =?utf-8?B?U0xrczE3clBhV2NUd0RXN0JLQTRrM3FQSG5XYW1RM2Vtck9GZXVmYnl3a0cr?=
 =?utf-8?Q?cyoc40LzSclSvLPI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b7152f-6ebe-446a-ab2a-08df22f18013
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:14.2151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vllb/Evh3hsB/5KkTQH45UTPHinuo/+mq44AJGd4vEqHy8edRA/4gL94a2+BvhNqT6hSclwMgnGpr9noupW/Beac1jMtV9bRXQWgILF+slg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
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
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
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
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


