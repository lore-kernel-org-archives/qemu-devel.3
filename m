Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A0C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwN-000376-GO; Fri, 18 Sep 2026 09:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwK-00035t-0J
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:44 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwI-0003Df-Cn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUQtPoaKqe+YMCHn4jYQ0Ez4A2O6KdRSSqrhLBrUiAEQLdSmS3OnrQ+73knhi6wzujA1j+XMppZaElP1v6SZM3TvWA8dOY7c8v1YwfyMagKz4BZcV60qbMOqkjJPaEsRUSJuXnZ7XGYSsMexsqm0cmES6G+z2p6JgxkzDTTBx/zQmV9wQfc+WQGbcr+6MDbwrmc3zQklHGMueKUy79370B28ZzWawEcARmNkXxCHqIfT6EConfJEZwNZy81P6VyWeI40NoDIoktF25QVZv2tVGIf4TCJCWTmA/uHrkbo3QliT4X0txPDw1lmhpS8v9jFfm4QcHlD33COaJVF9y/gIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=VHIgFN5p0iKiFOBiDP3rHYsV1cY+3bcDRSwbwF+dfDzu2VgQxUsMXEFvUo02XzNlxSzaNT09p/GyXMBTzbKZjuLaKnaybnt/Ewmk5VdGMJnWit9KKcNxKBdCnmTR5PxAxXfgsQ2k0v7L4tNFrediGFM0x3UmKjUUwklXt958d7pJdeDnpMoxPZgGG55moAh4K6gj0O7zObBmszkEHDTgEqoMvJ3zFlB43dOSCZhrIgIHkhB51AB2lcWKX4lnaX9K7sUNwXdsPRFWW3J5xmQVr34sv/PQrxhtAVHCU7qoTTMQ4v65XHRzG722Bito484ZdpofFUJReaotSeBiJYga5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=lccFaRWZK0XThIrvH5R5ElANxShQaOMDFyuNaIur7tuVnmVXz+zMb/TOca/AbLz9V1YR6dKkm3xc7uMs9b8Wm2II5qLjnjXbq31h1d8+6zvL5Sdq+Y6ubbHKy1BKe8lfolNgE1BUyrrFLhUFswWxJTeMXbYIzQTMD9+aiB4qAAfLBgyg3xA23VGp1s9VkPjuJUi+B1YigFrjkyQsyNY9tkR/C3ugiQW8Q3qqyaPirTfr580fNAQOKXp94O+q1hHD0IIxL9ZW99r1iH2Qk5mv3IkAzZcf/lM+0P5lHy8SnaKnjCdRAas02HNHmEh85I5zYQvvV6DV9EhyulHULnHXnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:58 +0300
Subject: [PATCH v7 07/16] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-7-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de8ab06-ef76-49a4-c390-08df158b5d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: BQUhA7ULNKgNGN0dzg52iaF8Gnn/QBhLfdHr/5U4ZF2RJVI4Qngq3jRQbAXOjduGz19mQP9ZQsDA+S48Do+sHjEObFaOvFTbWlRwjZnYdii44y26tBkZpkwOlNLOEgPO8FrcYHsKUZO6aWVEfv0XlC/jnJ+vc10e4gmlVnFq24MZZC7n/dnGz96uyAwDYjjGufq+Dq5yQvOW4NqqBFzYic2EPGRe5UNOaVg6OYTeRRNk139OOvYlLbSyJ+B2FeTS63zG2Kj51Xz8Ex0QTKmclvXSg51sHNFy4UGtKezzmKEDm9+03NMUE5vIacYRsnKuqi9NQsVd/xTynOTnxHrrj5fh4iaFDct5q4tDM95EN58iKXCCPNauuTyNeLjn54esv6FwEK1+2hMB9bBdZvq1aAXCK9x19W2J5UXbRrinsHB3d1e7ihaSUh6CIyF9y6nOWIFeYXKELxVjjPKh17l6MIYZuS3UsOKqtKJQHuChCGDUz5qlMWKCi6LIygi4kqezZOZyzURjE/rvirsNBmRfOfSWY8XWm+ZIPDENfR5yf9C2nderwZ0G0KGQC8iE0mOp8F7Ruwj1f6JgVK/1tbZYZbHtJPh+I1eWdOD0EmCKj2jSo1V9Pec7FclVSmXHYvPJd4/rvUocjFejIhXPMH43ocuhag9VQ0KLz3Opjqsaf3IioweFn7m+9U+z6c4oTrNQHshWPGR3flKU5xPOSVOzq6B5z1iN0gQqzCgU/kOjsfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVScDR6enIxOW5HOVk2eXBjSkl0dVVNYkYzNXpNRWw4WWZaeGVnMkQ4TCtz?=
 =?utf-8?B?ZG9XNzdpRG1LbWdxUFVlK3ZJRVdMamRIdVdadjJPeldROEc0TVFzRU8zcng1?=
 =?utf-8?B?bE9leTdGWXRUcmtEc01adGNCejMyQUtRYjRQakxDKzYrWW1VUDdHM1Znbmc2?=
 =?utf-8?B?dXdSMXppK3lYUWpUcU03VVRnK1luS3BGMFNOenJFUHY3TUViZ3JTVFhLMWlT?=
 =?utf-8?B?b24vWWJBcXVIMHIreEJlTXE2R0NTdXExRVBxOG5qK2taVGV2end6blE3NmFP?=
 =?utf-8?B?akFZaXM1R2xncE5McWxQTC9aOUtDck5vRGM1WFVDZklzZ1FDbXdpcXFHRVJx?=
 =?utf-8?B?Lyt3cVNGeER6RC9ndGNXNW5UZjE5d0U0MEZiMDA3aHhrMEpkQVNpWi9aVUxs?=
 =?utf-8?B?ajdvaHlHK0FSKzBISks4SnRwVGM0NjA5Zm0xVWtZTklqMU1tb0NYY2k2QjJH?=
 =?utf-8?B?UFNnVWhZMVZ4R0pEaDNkU2NFVVlneFlVTEpDNTRuTFZpeGNhLytwcCtSbitU?=
 =?utf-8?B?SE51VVJCbzVkUWtuaDd4RWF4M0g4YnRVOW1CN1Buc3NmOTZJdGU1aG5iZ3Zy?=
 =?utf-8?B?SzJWWHZXUkRVb29XUXNFZWJCZ0F4Q0FBaHlEMWJFaURpK0hqVXUyc2pzT0NN?=
 =?utf-8?B?cXVwaFdlaThveWQzYWRhb0VSUzAxbHhYY1BCSzYya0JPZEtZTUc0TldGQ0sy?=
 =?utf-8?B?aDNvSmxTSmphVzVoejQ4eGNkYVVadVVMeEhOd3o2aExBMS9WSWVTdUFjeVAy?=
 =?utf-8?B?WGZwTzI2UCtzSnpzbjJNelNjMFU5SENwYm9PdXF4dFhyRVZ0QlR1d2hadGFi?=
 =?utf-8?B?cFpzZnExZlI4ZVIySW9RUFZsM0pLV1I1Z0NIZExSc0gvcGRBcTJub1pzbG9w?=
 =?utf-8?B?dFQvZEpSM2hTcWhLZ3ZvdXZaYXo0VFhDWTZsbWo2ZWZYdDYyUnl4eExEWW9r?=
 =?utf-8?B?eVltTXQ2Um9VUmFDZ3RWVGwvMnFrdGJsSjQ3YWo4dDdlQjYxVU5UUzRCemxU?=
 =?utf-8?B?QzdYQjZXaThQa012akVHVmxXcnd3ZlR1YXRDUnBPSXpLTzhnQ21NblFZY2VD?=
 =?utf-8?B?ZUNMZ1BTYkFiMGRka2c2cmFHZ1lXeE03dWk1TnI0dUpSRlVZYmlMWjZJWTVj?=
 =?utf-8?B?UzdzWkpRUktMMEFFVDhRWjVSMVY1MXNpc1poWVAvSTdtblpFMlVQcDhTb29O?=
 =?utf-8?B?d1BLZUJjUm1jc0trN3RidWg5aHN1V1IvenhMVTBGSzJZYkV2YlowRG1iMERE?=
 =?utf-8?B?TWlYTmFOZDNHMWJKVk5ERVhYcWpYUU50Z2ZTTWlkbUhTb3pmV21vL0pvZ0Jh?=
 =?utf-8?B?Qk1manBXWFY5SEkxeGhjOTNvZXcvWDBnNys5ZFpIaGxZbHZCVlpaZUlvamoz?=
 =?utf-8?B?dmRtaUVDZkMvNENzdVNkYkd4Q2xQZVpVSGt0RDJWOEZZSzR5bEthcW4rWXpz?=
 =?utf-8?B?Wm5uQ2FpcTlBb2JmK2p0cWtNVjNxQmZkbEpPeWVqbyt0cG50d1M5ZXhxWWlw?=
 =?utf-8?B?R1ltVUZJT1kvWEtId2M4TnliMjVKeW8zL2xHalYwWFlKMVBWRk1zOHN2V3BW?=
 =?utf-8?B?dGwxWTNsK05tbXBKRHMzU0h3TEUxTC93Q0lPS2w0YnBsSVNaVTNxcU83U0ZQ?=
 =?utf-8?B?R2xLQklZNExaYkFWbHc5UW9tRHJBcENWUHo3RTBOTzJzUnpxQzFTNkdPRGda?=
 =?utf-8?B?aHlMMjZCWTNsQ09Sd2tVM2FJbmV0SytFT2pNV1FpSGExZDhaQU1PRVI5VXBl?=
 =?utf-8?B?T1VrV2tKbklBL3lQcXgwNERKcjdSaFFVM216R3lGZDRibWNnck9yQkRNbjUr?=
 =?utf-8?B?MTYrVXNjUkJXT0JuWXlaaE9ZM1lIZkE2Lyt0WEtGS0dRdmdZQS9QQWhseFUy?=
 =?utf-8?B?aDJ6YzVKY29xY1NZMGpyamR5Ykw4SDZHNWFIQ0RmbWNFbTJwVzA0RjZjMkxC?=
 =?utf-8?B?NVYzYjlORnF0TWR6SGJyTWR0SS9xSHRBQ0VWM2hwTitwa3VyeHBxalJZUTQv?=
 =?utf-8?B?Rmo3T1BBQU1mbmtrS09LTVRoVkZ0ZjQ0UVlnbVZ1UzFwSjgrY0JoWkxhNGRO?=
 =?utf-8?B?d21abkR6UjhYRWJnNjNqdVpIcWNzRjNSOUpSd3ZBZUFSdXhqeEVIR3BwL2tH?=
 =?utf-8?B?TXA5bFNoTlo3TkE1eEtJK2ZEM0YrSVZXQmE2a2FuWHJwc2QrOUh5cW9nTE8v?=
 =?utf-8?B?SUFhcTc2L3AxZ2VpWm9Ca3RUcjcwaUZDUFh2MmNpWEx6d0VlVVVEOGRjMzlB?=
 =?utf-8?B?VEtDZFhyRWpaaHlKVkNvVHFKbFhSNEpIb2dGam5naEZSYWZEeWFWWTdDNS9h?=
 =?utf-8?B?SWhDaE5xbWdFc0FBeVFNeXhCRzZYRW93V2lZSHpYYnIyWTVQcmk3Y0wxdEUw?=
 =?utf-8?Q?FzvS0CdWqQ0Raqn0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de8ab06-ef76-49a4-c390-08df158b5d28
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:21.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDTKCDf4JnnYOEX1nGqZYfj+Rwrv8fCmG5xTgV+oLd2ZJDJ1Aq4ZsBXbmz05QPw5K/d11Usul12+RRtVyHa1oIrLf5EYXBxnfLmIcFaz6WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
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


