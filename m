Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A81C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aGq-0001PJ-6v; Tue, 15 Sep 2026 17:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGf-0001M3-Ha
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:43 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGd-00010d-Bf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZG1wfay1Mdpxkxi03QAHVQL9O+apQ9ug6um1pLdzM8ZYl2jOFsalxG1P5a3Oo9eB73zgpICSAPdWX+Ci3ev3ZYGBQphRwZZ/GzDTp0jqH0pGm09icjaRt5kvzVs3JSuX1dJGQ97U0f8BCvehpecqsd2J84sokv5kmMDNqjR23j49dIJVq3gD7+VILKlI3lJUHSiy2/CmqRQA8AYt6cA6FomNDoyQ6cMlp0249GMX02OB0lxVnNZW2BWWEpi6mEs/Z28mQtHXO72TZNFL2Rd6ysq2znq0nB5abRW3aHS0AtrblN8++tsgAEK8wMnFAtkf28VKmEePr29WNCkh7pVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=ayIXdmtC5Jg2TmXAnYL9KvlO3vz0VPEJj/Z7r5tiA6YNIS0fRY5hNhdeao+SXujuTVr3onrwy5z6RZO9whY+sD5RcwPk6gQcLHQRHzkRxFDjKAnAj17f+t3z3sIFivWGcuQvSgh2bFhg6yOxZ7ARMPfObMu9wlemDldahIBaxi6nHRFa0hYCTmh9v8zb0PgcOt+YW5OUjjlt3TIRBCzTIcEsnv8/6cnkGIOb5gBmzH+ky5dgFFuqCV42NaJGqPQKMTTwnmMxci3MPRfImIdx74f+9O9RVnYOxGfbkV+hrnl32BgqBEmt36phhJ1oMpeQ9EEhBZ6QvTfK+hiDluP54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=zfmt6ufBkiZU5yax24ZcXvHQZB2/7+DpTCHf6ebgTkhh8zHhOFEA30sD2hI3OtmVM6ATovmNhT0Wcl+YqKtyKobRgjRfs3zMAVFxx+t6JWUGpOpoNlO8Nrc7Kg7K1qjDs1/Ooq2mz7mDS0UwYhM9I5uLZArR7efCGsCtvVPYb1Wvs4rxrKIHW3Ob7clmPZARdv0ezLu290DWGQPXln6/v2idj8GSt2dHMPRW2KpGK4AKGNQLEnQrsNP/i7y09qqkaTSMBIad3CxiYRlNnNwaRpAYDA+Ki1BbLwhK7QS0/nNUUNV8f2Eh/RhvmnUckfhU11gt6NqWm2kRHK19zn5FVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:43 +0300
Subject: [PATCH v6 07/14] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-7-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a78cef2-df4c-4660-ad68-08df136c62aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: GmCfeLVUeakab+m2zapcWT+J6zjyn23gRmzZbLRsucb/EoNPYOOvcWWc0zkDVbSZTHKruBLBDKvCsHvg30MNVlJnqLbl+0Wk3zq0dadvc4bZYEjv28q8p84b/IgirEujbasOoLmiMinkULQP92AVN9NTc8aBchD9OPsmTXz2/GFlcbUwXjh26udctKtApo7N4oLSTX58HiXh5EAYHLLTREF7ApSdlOFQGpTkulHbs81br6qnPUnacKTl/8rcx6BPagkn8nYnx3helzVX5IzlGnMDpl72nhEDUzXraZwHLkTUk4W2iF3QZJqITs735e1uQHt0VWr8dJhZF7haxB4o/0LNwrFALPvwolcgPpB8W7KIG3eeYDyaJXzHawqwXYXyq3nSd/V/HdlAYen5oQwWn3y5mZVoeaOzGcvZbSua947NTqhoxvlc/9zU3fSrB0lt14KpgPGASRbY7TusFJDGbS7P1IYrvcjCZtbVTeLRRw+7O+NPb6xOUwJs+vxVSwEO+7Wd1o2VCEkC15AZJw4UkzIzOhIs9e6FgwqIC2ICIQN1NzoaZfcox0ZPToHDVqNzM7mmuoSVIxagelGP8CeREib5WlHtLySlecLmEjxTarcGzNh+velHMCL58/FU+fSb+1yst4gX5ns/21xR6DaqVphLr4L2rBoEMtS0nHSE1zwafjzXuKeMKG6gVIsRyFwm8G8FfnliR5tPHoMs6f/w/cbFpdM9epYCAA7ghvjJaEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzUvKzFldG50WndUeHYxQjl2VVlXSDlNUG1rS1hyRWJOVVdOSW1hdVJQSVVl?=
 =?utf-8?B?YVVIOHZ3ZENiT3RjSEpGdkZreWZ5UFZQVndhMEhyVjRzL2V3djBsUWRweGM3?=
 =?utf-8?B?dzZ5dktQb3ZsUzIrWGR2d3FFMkgrZGsyaUlkTVVFbGxFNms4a2JhOHlJUG1D?=
 =?utf-8?B?Tkx6QzVKS2g0WDhJTXhGSHRNL2lzYXNpM0pRUDdCeG10Y0tuNHRibzkvcUdq?=
 =?utf-8?B?NExvOEt0TTM4SzIvRjN3SnB0VStuUy9VV2R6NWRVL08yUHgwOXJraDhzaU8x?=
 =?utf-8?B?K0c3cnRHSnBZUjZYVUZobk9MOTRNOTZPam1TQ1ZIQWsyb3E3UERQWW42WHFu?=
 =?utf-8?B?YkdOK2FMQlJ1aUlUaTNjMyt2Z1ZuOUtrSElXVStWNXZRSEZyQzkwSW5NenRW?=
 =?utf-8?B?ZTYzN2dEVkZRNlBwOEFhMzdRUFFEM1BiOHRPbzljbHcvcndWQkxTeS9oUzUr?=
 =?utf-8?B?U21CNTF1elBHaFlJZFdjVXZjNWZVL05FNjhpbWsra2xZbCt6MmN1VjhubVJR?=
 =?utf-8?B?Q09nOHdpNVhxWGJiNS9Cb1B4NDQyRjJicmJOTXJ3MDhhZk9jZGRmcDBwMWRu?=
 =?utf-8?B?ZEp2MjQ2ajJlZHlKTGRnVkUvM2EzODc0SE9iaGNPZ0Z4REd4ZG0zQndsQ3VZ?=
 =?utf-8?B?amdGWjk5elhuZHBwVHVQWVRwcCtVYllrRVNIdVcyU1lXckdIdE5RZVVQeTV6?=
 =?utf-8?B?QkR5NlZGdmE0cUJCYkdRT3EraDl5ZGZPd25PVTlPcWtaQlpjMVFtN0Y4em0w?=
 =?utf-8?B?NFI0eHl2UTlsbDZJdGE0L1J3U2tkTjUzeFhQUS91Z2IwV3VSd0FjemxoTEQr?=
 =?utf-8?B?c293R3ZxdTFycGRGbW42ZmhzTnVCZTBkMmcxaHYzQnEvRm1iWS9GQ3NGTkJF?=
 =?utf-8?B?RGtWUFRveTZsK3BhWmFmTEZiSTMxUTd1dWY3a3dySnRWcnRQQzR5UlJ3cGM2?=
 =?utf-8?B?ZXJMSEpMN3VpTHFoL0p0RC92L3JoRzZrNjJ6a3AzTVpzMDBhZEFZVjNjV3Jp?=
 =?utf-8?B?WVF5NEQ1RmFmbHg5UzdJUE1peWh3cGRDeHhKcnFIT0IyWVo4Tnl0TlFGMzVp?=
 =?utf-8?B?ZTFEdWlmU1hRSHVaTEVRVE91U05FQjhWV3JiLzNhbHRjWW04T1RMZzNBbk16?=
 =?utf-8?B?SjN6TURkSUVpcTB0N2xSbmFFbEZ2TGJLMkxtNGJIWlI5VUtHS29HWWwyajNS?=
 =?utf-8?B?OGdya3BLWWFiVGdBSXV6YkgwWkNzaTJoOHpmNC9tRUNMZ1Q3UzdXY2Vnd09M?=
 =?utf-8?B?aHUrL01xclcrSjRxKzV1WHpBaHFOK0g0MHJnRHlKM1VaUjJGVHFWclJpZXp3?=
 =?utf-8?B?TGIwdnloREdNUkM4cFlkQ1l4T09DQVlFUmNLL1QwcFI4ZXc3UnFiTkc2M3VL?=
 =?utf-8?B?YTNqMThWSlN4ek9zSXkwVlR6clpUTkYxWFlwYVkvQ3dGUTV5bUJrZzVUZ29W?=
 =?utf-8?B?OFVJODAvN3g3S0c5d0o3S1JDTnc3TGRVZDVWRjh5Qjc2VUlVYThGVzZ0bDBz?=
 =?utf-8?B?K2lvTTNaZFhqWXJOUXlBbitWSDlPNFJMam0wZVVvZy84ZGRuQTBONHBQTUZZ?=
 =?utf-8?B?bGYveXpDeVVZSGFMb2RCV1FMa3RQRzBoWk1WSGZ4WnlQeTkxUzk3M21haGRy?=
 =?utf-8?B?Z1JHOXlOOEZHL2xKMitmL0pubVR3ZDdFZEtSWEF6ZVZBajY4NGZZbFJZYVEv?=
 =?utf-8?B?cVN6RW5aM1FNOFZFVXBKbnJoVlBsaytwRmFZb1NwWWlhR2JuOVc2bXhNa3R0?=
 =?utf-8?B?Q0dlSllwZmZ6UDJpVmI3WlZ6a3lrNzBkWlYxWkpQUjFoSlZ5YVloRjRjUGxp?=
 =?utf-8?B?YUtSMkdKVkwvN0k1aWF4RFpwS0JyZk5jOEJHV1RGMysrNUxPb04weEZLZ3A0?=
 =?utf-8?B?cWFCYU15eE5OMTFmOStCNGJ3dnJZeStjS2t4S2N3WHlUQ0pLdUhjU2doUVp5?=
 =?utf-8?B?UUhhTUtGK2ZScTBVNVBXL2dnWUJlWHBUbU5uUm9IcXI2bEk5N2pLUG9rWTF4?=
 =?utf-8?B?RCtFNlEweEtoZVpWT3BMOTZjV1ZYbitPYjNaTEJ0WnNFYWhGTmErdndORndz?=
 =?utf-8?B?TjhhS3owQ1hWS1MzKzBqV20vaFFtbmRJRGhyTG53RWUrS1FBd2Y1TDFIZEpm?=
 =?utf-8?B?SlhNSm5rcHVQcm96cXJWQnliM3hOUmZqTThNY1IrRTN6UitvLzFFcTc3R0NM?=
 =?utf-8?B?RUQwaDY2amxxL0xhMEdGaFNjOU1Xb0RTZ245VGRnVFJmS3NzNmpsZkJSOHIv?=
 =?utf-8?B?QnhlSW4yS2pNV1BMbldKV0s3dVhKTnRibGs4TWEzL01JTDJRZzllaFg0SVU4?=
 =?utf-8?B?TUk3cTdKZkNzcjdzd2dIRnhJQVRzbEx2TmVJdUgwNk96UDBvZURoMWQwb1NW?=
 =?utf-8?Q?jMwENF4FgEhdTJ54=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a78cef2-df4c-4660-ad68-08df136c62aa
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:34.3818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LblGkfQ3QQhYYCCetuXlzYB25rzGjPpqqs+qc4GPuLOaL1Wv0OJX4bUJub+ZISzM2pA9qVRTqT3UqPj+yS9uYdV/QZpjSqktoKZFrEkmqgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
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


