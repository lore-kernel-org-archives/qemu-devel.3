Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F88CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKP-0003LI-6b; Thu, 08 Oct 2026 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK5-0003Hu-FZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:02 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK3-00016n-Q6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES3jWmyZL1PIzCDoxzGFYME6fdK0NB2WQMgV78mhYf2fuAB1fnJ4LUrn1t+k3LMAYNpmqQSxXhoenj0nkf6oDQ4MOWYstdpCAqe8ivgMIDIHk4fchIuMcdj16T+KZBj3Ix3ZdHxbHb0Oedc4+TsymTn/HNhNpYi8EQwGfYgTwADlj1Y5d36Qf6goC/d4SpjoPIMrWB/8Gn4vuog/5D0jqyrvy75vvWPUOdU3Xw4+99akl55QehDoMBDsGwROsLfFUpgQOT+tLo5Am3K0ZrfNU43xXoYxg0Foy6ijF4JRSIpYgUhteJsNn/mNJ23hqllVM6HTxmwXQeTXfPqkcev3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAMpN32Rq3bIC4EheVR/hrRCeywr4pPoA0kp/Ofn4NI=;
 b=Gs/9sFu/oDmuhb6EDacOMSzpPPo3TuB2RLmg1pkS2W8OnumVMiTGDWy+oSensw3GTygXxgO/qddKjy2xpgN01gd+LmpIWaUCKu/G3fVcSIDExzvPwBHYcCAon0omQGSfobqiYB377Kt4hEZjzBIVVkzFbD1RwzXqHstsaCtON4wPDXuxpf5e6RBJfkC8n8uS0+fK2TFAclrTzioIi734iYfpryP1Vi0QkRrg3GgCT2xwvTrXf35eSutkh/vZuzd+r0KvBMRl4NvemORpAlkcMt/mGY5qV3v5uQkNHYoqq5xfMIPXwh6StARLsyJMd0mLn6VLt7FTpaf8ejP9d9er6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAMpN32Rq3bIC4EheVR/hrRCeywr4pPoA0kp/Ofn4NI=;
 b=Ld83a3OIpezw2xdvNTDPuKbhWOYWTh9ZYRs4t6Oa+ygylYm/BTd+T7t3iwP7n3jfi91VQ8ZiSs7My6A+RaCpRTORKzYuSEu2R7o6Zeq9i1htY+kDjTLByzwyNi1tsni2Z/DyasXXvnZUJqM3Ted8VqsoEMNyoN+AD6Ac0QfWu1XsnwAQxYqWsZK6nDU/SzIgql2cux0Y90uvc1b0Ucfu6ZB2FiqHi00Zl0JrOba6ZXUEZuWFyYc0xG0xKPalqy7mkpVLQGD91YVykxlMDVE1VhA3fgGis1T+/ST5lMk7nwAEfrfw2CrNUKcKnrBg9rytpD9tOjy/kdkEUE5wrUo9Ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:42 +0300
Subject: [PATCH v15 18/22] vhost: release ownership on exit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-18-301b73b3f843@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a4e28df0-91de-4b4c-a89a-08df2526841c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: xcVWPxTBOrjP5pKGNa/a0QFgXIgUD6go+lhpCyT9MfaconftGW/dDhPrAIQq14BGg4Vwwz13IzRFb9m1hM4JjxYYAlOjV9x7itj9TYICKDZbQ77rXD54HJyS0CF1AdkZbraQwDbSKoyJDybc9s4fkUP/1klh8O2j2V6hTW2JRAu4MzNlJIv25e1Q6BiNxDPh/QmIH5IPBbGNpy1Gt5fUj8Xg3RG9XzO38uVfu4lA+VTYV2+KqeCFftlfoFbGfrBpFmSdP3fpS7FAX5yYW7xFosMHVejzFQnJoeLUadGN1JI7nN35EmDLxfMDPZFn4/Yb8SNJJUbx4zFx5OWx9cI8MVJT2k2APyx/TtJejJV9FiVl4EIYUYjvljPUz6LACIVubXFjmgKos9GM0U+zW/ueu3qbnRqV/MUOsRzT65brbW2jx4LP3z1yJ9RaPwMvhXZ7ZogE0IQ+N9LjILUdJYtchtLZ1cXB32yEF8sfsnlleoOiJLCQlVYsHudpZVbMGkW+3smcZ12I2whXmfWpGnZpxVLPwUWiBLKLOKs8BBcYCDvKHFnJZwrCycaYhJpZdzVKcYDbbg8OeWVvgWx7smbSdHxYBbyt2j6Y5JvaqH9ogILuclzMBOtQOE9rqwTMhTbWWuLfCE7YGydRS3oYNvywMbdmRtKJu7bgHWPf3rFBw4eZ5WaA+tlKKqLJrs/y9M/wg5BtWptxovdf70JYW1rvBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTMxd2NxVmw1RjRHS0cvSXppZmVRNnIrTUpPSU95a0dNOGZLeUNLbnAyRC9M?=
 =?utf-8?B?eEVJR3c1QmRiSlM0dkdUbFptSG9mS05FM3JqM29YZkZEYUNCaWZsTmIrQkt2?=
 =?utf-8?B?K01sYjBJeG5BZXNTQXFkajJSY3hvVDJpNy9MQTcxR3pOS3R6TTlxcEtiNnRI?=
 =?utf-8?B?K2JQVFRiQUhKMEsxODlLdm9vQzd6THduSTlxRjhJbGJVOC9qMUJBOE8wbFV5?=
 =?utf-8?B?TDFuRVRBYnNGaTZ5Vk1QNENNZERTeUQrTE9lb0lodkJpbit5dGx3QlZWN29S?=
 =?utf-8?B?dnZxN21oK0hGWkhXbkVSc2xndDRsUnRxYWx4TTBYN2V2UVpnRmo2TUpUWGQ0?=
 =?utf-8?B?MnZ4RjRRNHBIT2lpZ3RMZ2w5R1ZtdW9zUnlrTithdS9aeGg3UzVHUHZYL2Jy?=
 =?utf-8?B?MDZkb3NBdHBlSHQybldzM20yNWNWa2lKRGhVY1BOc0E5TjNYWjNJNEFzZzdR?=
 =?utf-8?B?NFFNbTlhOFdTeHFlVHdhcFpoVlFyVlVhdklvdWxqSklsR1E2VEJ3L3VjcHZk?=
 =?utf-8?B?UjRVVGhZODFJMkZQbGtxRHp2dWk3dEJjVlIxL3crOC85ZGdtNXQvL2ZQaW5E?=
 =?utf-8?B?UG12WVJVWnE2ZFFFN1dzOVQ1L0lMay85aWJ2WUp6MkJza0d4ZFowS1BMRVdt?=
 =?utf-8?B?YWRJVlAvMVhSN1V3aDN1MGgrdEh3UWY5WVNzbWt5WE1SY2RVRHNvbkpzYVRI?=
 =?utf-8?B?SkVyVllUSDVBM1kyUXFxQnNHQjlPS1JvZWlTMm5aa0g1L25DNzlzWmVncTND?=
 =?utf-8?B?bUljNTlZdGpWWmcxSlE3NG9PVFlSaDlRakhNbmJ4YjFxYjQwVXNZYnFxWlhn?=
 =?utf-8?B?WVdlUkhjdnZ4WjU5RURCOWtDOWpUSk96MXUzOENZR0RSYW0zVjE3YzB3Um83?=
 =?utf-8?B?MVFPakp0SXRFUHJOWnFkaWlIRTJkdUlVeXVISDFJencrTU9LaDRETG85bUs3?=
 =?utf-8?B?MGw3byt1ajlCSkhMa3cxMWxYNlByaTZYWDdRR2p2UEpoOTA4SGpiN0F5Vi9G?=
 =?utf-8?B?a2tSdlpDWVFZY2h6TDd0TUM1RUV1dHFPVjkvNDJlNkwrNDFUU0VqZ3Vlblk4?=
 =?utf-8?B?eUlDbVpwUm1PRWY5SFk5ME52eml6THN4QWYwUGFoa1REOGJLZlVoTFQyS3c5?=
 =?utf-8?B?RzFHYU5wS2kyS211VXNGSk5PVEdoUm1DbGhLb1IyaE9sdWRHdlhESWZrbk9j?=
 =?utf-8?B?RStDekd3emdyVXpMaTVlZjVZZnNkZzJvL2JqTk5HdEVyc0lkU1oyZkVYc1lJ?=
 =?utf-8?B?dE5EZEFYckhQdTM5NFlwSzRKOURGYUJCdElBVkU4NFM5blJQOFRGOEpBQ2sw?=
 =?utf-8?B?M1crd2syZjl4eCtnMzRVdjhwQTB1UkFoSHc1REVBeFVaaTdscUUxbmE5M0dW?=
 =?utf-8?B?Y05HY3lFejFSc0UwVGJmZi8zaUhNUEVuREVCNktkdTNZNXk0VUNiVHBXbGV3?=
 =?utf-8?B?WlE4R0R3WXdXWXZ0WDNTWHpsMWpjVGZqUzNKWWlRalFpVVRxcTZMSHRGSzZY?=
 =?utf-8?B?eVRtajZPUWt2VGE2QktSbDdQS2UwZ2xoOU5YakkzM2ltTFovcE5TZHpMSS9Y?=
 =?utf-8?B?enZYdTU0bUVxOGgwZzRNSmI1b1M2eHdud0sxM3VmRURBUE5GZjM2anJFZE1v?=
 =?utf-8?B?NUJEYWFCN3IzUGdNNEhKNlMrbkZlUkkwTzBPcFBPa3Q5N0N4dW1zT09PanpG?=
 =?utf-8?B?dWR2YlJGcXhCN2hjUTB5RkRtaW9pWGNtRXN5SkJaRlVZZXRUN3k0VTR2VGYv?=
 =?utf-8?B?a0ROVndIVlIzZVJHcG1BdG4zcXpVNGREaVFRVEY3WjE4V0JTWHU4UkNIMU5w?=
 =?utf-8?B?N3RRd3VCcGhWTU15cVFxOGlMOTBzY09JMkw0NG4vRG9rMDlQcDFNd0pZNlFZ?=
 =?utf-8?B?Y0ptMUNCajhDcUxXRTBIUnhub1JvQ1hjakhjWjlxZ20zRkZBdWR1TkE1alFB?=
 =?utf-8?B?MGVETFYwUldRZzlENHBWVlBXZHptR3h0ZjVlYWZSazN1YStoWUwxMjl4eWww?=
 =?utf-8?B?YnlrYnFDSWw1am01QjNWME1HVmRhNkhoeEhYTVpmTDhveEZuZW9kR1FXMkRy?=
 =?utf-8?B?alhlK0J2eHV4TEYzcVdyb0FIcm9lNnJhaG1HbkdkNmV4cCtyYVBFUmhrOHZB?=
 =?utf-8?B?N2NmOVIzc01iaXduZHFCM1VtZmczMTZKdjV6cThHK3dGRHdCWlFBMFVQc3Bq?=
 =?utf-8?B?L2FwWWd0U3BkTjRjQ0svVVhqZ3FDdkFzYUxkWVhFMTNJSGZoTC9ORDJFSVJx?=
 =?utf-8?B?V1YxQ0V3cnl4WXkzYlNHMUZ5KzRFZWI4UVhualB0eFdXSFluYnhZcTRuTXhy?=
 =?utf-8?B?cWpiczlaUXFxdHVWaVcrTGIyWmJSbHBWY2dNUnRzOURMd1UyRk9GTjIwMUk4?=
 =?utf-8?Q?PkT819lDbm709VVY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e28df0-91de-4b4c-a89a-08df2526841c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:46.7088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xCQt/CdlVLrDLSmJX23eD5Zo9nGjHeYaM7GrKxahPw59kM5M7wLi0RJIMAeQ8A9fbkP3r90TtUoCJ0yZT6pOyX/MbC4+xu1THUqSiNYaQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a target which has loaded the state
but hasn't been started yet, e.g. one started with -S, may be quit
normally, with the source being resumed instead.  Devices aren't
unrealized on quit, so the ownership stays with the dead process.  The
source still holds the FD, so the kernel never releases the device, and
the source can't take it back after being resumed -> SET_OWNER fails
with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 20 ++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4310e1b43f5..ab60b9e06d4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -31,6 +31,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -90,6 +91,19 @@ static int vhost_migration_notify(NotifierWithReturn *notifier,
     return 0;
 }
 
+/*
+ * Release the ownership of the vhost devices still held at exit(), so that
+ * another process sharing the backend FDs (e.g. the CPR source) can take
+ * them over.
+ */
+static void vhost_exit_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          exit_notifier);
+
+    vhost_dev_try_release_owner(hdev, "exit");
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1860,6 +1874,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     migration_add_notifier_modes(&hdev->migration_notifier,
                                  vhost_migration_notify,
                                  BIT(MIG_MODE_CPR_TRANSFER) |
@@ -1913,6 +1929,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 14484b8de24..b9ec00f9b0a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -117,6 +117,8 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     /*
      * @migration_notifier: releases the ownership when an incoming
      * migration fails, vhost_migration_notify()

-- 
2.47.1


