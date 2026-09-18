Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC46C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwM-00036o-SS; Fri, 18 Sep 2026 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwJ-00035X-8V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:43 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwG-0003Dj-OS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3C7BJiCsEpOSncP301eg2V142JZbW+SlnjAe5NJryrIwbIFvb2wDGuRv0vGdM0ZkYk2LPyMgPDiJdZjem+ekkIx1E6hQusauGSS9oQr8a0AWQ8S+NsimHvtKtyi7BDEL0cS6HgFGCnvPZF6hIlQkBKQM+5obnseZ45OXekgfNYWYAMNQy3JDhGYqAzlVeiUtsgmUNwuQbmmHkbKwQCRr2Zx22oMcSdXIkB/D7SG7LUHNj125670dDlGxAmr5RK1QPUjQqdlTS5ikXAtIetWBfnAQxIdhWRBAcuHEl2CvMJuJPnuyupypdhbpF3qP7JMhumh5gKKiZmObsvrH+o+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dz+tvtnKigbX/oRMLQY9R46dOBjnT4EgsqvJZo9ufA=;
 b=Tou1fJvMhVjGIEtJe+eaY1DnpcPSMmOFqhMTZ4rPMG1+JYKscYZR5nL1VMWvR32okpYK9xXrMkgCIiR3kL7YbKp5CtdG+J4txERkqKcYaqWuKtSoqvdnGxqU7A3QBxR+lJ60kEMPZw/hEVC4vBlEbt0CgFtcfyOzM0wI/NVf9x9vETnpC5weoTP3xXyi2kpfzqgoQMnHksNEJM7oXR65dhf220DVocJ+ybT5hafCw4gKtYeOTLzTsbTmr119S4ffwToNUHnYLPm92ftX/6zGfmSZ9sJUKjNnA1Oo79TpdqJipom3HHvO2RDEgYVsJf3FzWrZNU6/blBy5TqYzUCKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dz+tvtnKigbX/oRMLQY9R46dOBjnT4EgsqvJZo9ufA=;
 b=AYb8lSl9mE7dWs7oK74TRMwhjWlpuyld4txY8Iyocih8TBiT0+i7wQ8Rsol/T4iFQnpL3SwN3JK2AhL58GWWJlc4/ARBIfR0KT8sp06OxjWVH+L7fUp/6tlNtffU1wJ13nFKGiBpend/adzTKDOnW9rxu9S7OTPAiFPQ2riy7Z+dr6k6pJHZRG+RpwHrKDLsOdWxIyMQoNMxCzIVBDmkUPT1W+cbgI7cBi+65GprMHVgzAcuMV7bqJyXNIlbJQkGVagOGVthqexruprOecrx9+/GEGnSfIHu7lbKs2tuKMZwuq8XBV8EdZAM7Y6+5ofuqRSez45eeERWnui8Q93WCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5483.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:31 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:07 +0300
Subject: [PATCH v7 16/16] tests/functional: add vhost-vsock CPR test with a
 live guest
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-16-6ef9ef033c35@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 908d068d-4c9d-4902-e5c7-08df158b62df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|3023799007|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: +Ai4Hw55676HowRluHpeaa5ntp2rOgUpLmTHEUmiFzR9B/tCRWEP3LMmh6Vg1KmSGldSW4JiFMzbn3nWeqSts9ONITq0s1UF8Koigksz9BifYfUqkDWd3ndOaOFyJbnMCSwCcB1EeWyyhvMkQuwTReM4lnTXb/qXywobaYuyZiZalXYvVypePigtOwwV17PLIoN7gUbxuyazwLYE8WfekvFlzpWkf5cYs86bnz7FAbMjhB2nbvcZOXFAG30B/XCkC+3cuLgvyiE59EsHJFiqwrVs0h8OE8yocV6TPcicn1oPGmc659guaew9k7VkIgj51huHstXLOW6qwky3wZGfLpL+idlz68F9szj5x7aNbgtRWV0dxugKunwDJmk5DCeB3MT0PKimuTLIOvH4pBpbKEPju7/7DZIL84q46ANmSsigR4xmOxiZMPl3Qj93/DqRaxUdF0iZOuO9h4GEzNPxyfD9eP7c3q2Mz2QrhZMS3zm1o7t12tlMB3vfOgIHUihjJknGI9B9U2yk1BpAmFtJQwWtIY0kSzKMvazV1pn8xkdpstOaPgXD9Gez4W/Gld2iBgZYfRnpdYMjEf8NuKPcb4ThvLmp7ky+3lI29NDRzTBXWmFzvweOsZ0tiBRPNOdA8JvfX1LiFlCn3zZc8SJl5qvOCF47io6PKTHY69LGNBK0ZJCGBiWRftmSe7MyKwvLMprAwTT19P1zP/zfhDEGxRuSqMu4atLSsEOk6oGzygk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxvZWs3UkxXS1lrQUhaT1BCenErcDZjYk05UnhrdmY3dGhRbXFXT1FPNHR1?=
 =?utf-8?B?MERuRUFtU1h2Y1QxaVhXWG51aGJ1Q2pMeEExY282b0lDN01GUWtkbUg3a1VB?=
 =?utf-8?B?Z0NJMDFFQllTeEltRmZIQ3RXdmhBY09yajFRWVhXalZSa0pZczdUY292a01q?=
 =?utf-8?B?K3FWZ2E1dXduUWZpb0JKam9wYmp1ZmlLZkhMUXVFZHZzQ2tqTFdvV1RrNUt6?=
 =?utf-8?B?SHMyVVAxMWZnU3NENVRZV00xMFRUaGgyOXRVUTRNYlF2anZ4QUIrWDBLUERv?=
 =?utf-8?B?bHVscU9SVnBDYi9ISElJd1U3bXRicjI1TGkrK3FXSlVkK0VmYU5aSXFQN080?=
 =?utf-8?B?Sjh4ZVdCR0tuRS9QdXVsTEJWN3R3MytrWWV4Mmhvd3RoZGUzT1JhTXIwTUMy?=
 =?utf-8?B?eXIrNXUxSG5wOUJpekFyUEFWRWJOb2kwbjJ0UURLbDJqbnVZUW5tTWxvOGpo?=
 =?utf-8?B?UVpHRlh4M3RIYnFOYldmSDllZUhNeDBqRGZaRTUwVWxqcjB5SWxKa0JWK0Zn?=
 =?utf-8?B?bHlobHhhZytiY3RxL3BkZGdoL2RDajJZamVKeGFyS2k0ZDBTa25iU3d2Wk9m?=
 =?utf-8?B?NmhIZGgxQ2k4VlBCZTNQVEw5dHBBUmR2dzg0VnlxaklEZlQyejlrR0NOUTMr?=
 =?utf-8?B?TWJCQ3BuNnNZNEhsRStqb2pYeWFGcmthU2ZCb0tJSUgrZThlNjFMQmRvWnU3?=
 =?utf-8?B?NVJNYlNQbGZXY2J6SFZSZWFqNFlqQ3ZZSmpjSnhmZnA3RzlmTjJPNU1wTy9h?=
 =?utf-8?B?dlEzWUpwSCtZQXd4MmdKSjRCSUwzMm02VFBOK1F1eXBQdFozbi9vNUZsZnha?=
 =?utf-8?B?My9EeHdIY2ZDeEVXbk5VbGxrKzM5bHlSb3hobVBUZzhNd0xZZXZiTDRxQ2hl?=
 =?utf-8?B?U0V2YkxOTzArNnV6OEtmZXIyaDBQVFdiSjlrL3NNNzJPTlIzUXFrVlp4YUNL?=
 =?utf-8?B?NUYzNEkycEJCWVR2a21FUWN4NDZ4NC9LVndveWlqT3hqWHRibHQ1dzlGYXBs?=
 =?utf-8?B?RisxVkFZblN1czVHT1FrajZnNFBFTzJHcDB5NXBaSEJ6NnBHTzV6ZUNNMnp6?=
 =?utf-8?B?YTVOOWtneG1FVmpDV2FpVlVTS2R5SGNaSnlGK1A3UGxtUUpoVm1PNCtIR295?=
 =?utf-8?B?VnJkdGNHQ3NNVitTNlgxcHFYUE93NHhtRVlCYS9HenlXQkhuZ1FWbFo5MjM1?=
 =?utf-8?B?ZnVmME9jMVdWdnYyelQrN0t5bm1vT2IrRFlBbllPTHY2NjdqelBmUWRyYTdl?=
 =?utf-8?B?eXNQTitLcWovd3ZxaTNkcXFBRFJxSXFLOHZIWFhKTU1zejRzcTl6TFJlVzNs?=
 =?utf-8?B?bTMyWDRzSFdVTEJDV3dUVDNtUEFudEEwOU0zZWxQa1BkemtIRTRmakoyYUdh?=
 =?utf-8?B?VDUrNThHYzlqajFKUjhDb0VXSEtMeC9xWkdSRy9nSEYrRmppV2JENStlcmR4?=
 =?utf-8?B?VFZRV01yd3p1RlEyT3Jpdk12MFNxQ2RoQ0MxU2VZWEM2dG1KajJ6V2NPK1BY?=
 =?utf-8?B?RSszd2hSQkgvQUFkVFFsU0Q2QktXcVA2QnV0V0ZqNjVLN2FzN0pMNlFlTWl3?=
 =?utf-8?B?YjlmVjhEZVFHWkdGdnFCNTBQaDlYSWZHTTZQVzA0LzM5NEs4UjFQeCtwWjcx?=
 =?utf-8?B?K1FSQTdDRTJPb2VxM25yNGlYSzBoYzEyVWRzV2pRRUZDODdKZ0czT3JVTTZl?=
 =?utf-8?B?ZytkNjFvbU1RZnZiekpJYnlXQUhHZHpHMTBiWXJrbUcxTk5SbTdXMkFDWjFC?=
 =?utf-8?B?Ykd6cnBDVEM1OE9SUGdWU0x3UFlicThlMzBIRk9JU0xPekFISFhnbG9YZVkr?=
 =?utf-8?B?L3ZwODB2UTJsckJhNEtNcmlhUE1qa3oybStudVhvSVRuUFdUMytGYjRHZ003?=
 =?utf-8?B?YlNTSGZJTXMzZ296b1BrUXdHbFZOaW5rU2xRSnQ3QXdCZTc1M2RKME02UENx?=
 =?utf-8?B?WFJzSEJESVQ1b2UvdkUyZzRWRnZFRW83NUZlWW1RUHRkSk9IVDh6Z3c0ZHZW?=
 =?utf-8?B?UjZROXlOUXZ4eWZDWkhxSUVrdkdXUTQ0TmdXdm1ZQUxHL0lKamZYcm0yUXZz?=
 =?utf-8?B?VzlLbDgrRDR0Y0wzcFNkaXNRZlRINzBKNWpKemhkeVY4U2lWeUlYQStmNnZx?=
 =?utf-8?B?UVRNYUlTdjVMbDlHZ2FmRVkxM2pqM3lLTm9jb0cxSGdNUyt1YWV5UjlEUmg0?=
 =?utf-8?B?OEJVcm1Ldkt6bnlXZVU4dW1mZm9rc1N4Y3liQVZZY2pwNEdUY1Ewell2OU1U?=
 =?utf-8?B?NDR0eDhZOXNzWjhpTkVWdHRWVHJ5NEdBdE93ZUNhcytpUHdVV2k2QmZyQnlp?=
 =?utf-8?B?N2FkWjR3Ykc0aTc0MUVHcVVsWUFDamlvYVczWWRPeFBVWTF0TW56UHhFLzdi?=
 =?utf-8?Q?2YuiKT5EkGVOE9Fw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908d068d-4c9d-4902-e5c7-08df158b62df
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:31.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQEBlsbh4Xvz3SlynE186siZ/+DZV6Ktk92slwheZDJ9yNTprZcPVq+Cq3ELur7uZIwlP5MS4Y79fhRnjzAiwpiX3onY8AFV8Zue2Nq9MiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5483
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
functional test which runs an actual host<->guest vsock transfer across
a series of CPR migrations, for both cpr-transfer and cpr-exec:

  - the guest is booted on top of a qcow2 overlay shared by all the QEMU
    instances it goes through;

  - the host sends a 512M file of random data to the guest with socat,
    where it's stored on disk, then gets it back the same way; a CPR
    migration is performed every 0.2s while a transfer is in progress;

  - with cpr-transfer each migration starts a fresh target QEMU and
    retires the source; with cpr-exec the same process is re-exec'ed
    over and over;

  - the file received back must be identical to the one sent, and both
    socat instances in the guest must exit cleanly.

The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
requirements are missing the test is skipped.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 2 files changed, 247 insertions(+)

diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 0353b2af8e1..718bdc5195c 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -7,6 +7,7 @@ test_x86_64_timeouts = {
   'netdev_ethtool' : 180,
   'replay' : 480,
   'virtio_balloon': 120,
+  'vhost_vsock_cpr': 300,
 }
 
 tests_x86_64_system_quick = [
@@ -51,4 +52,5 @@ tests_x86_64_system_thorough = [
   'virtio_balloon',
   'virtio_gpu',
   'rebuild_vmfd',
+  'vhost_vsock_cpr',
 ]
diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
new file mode 100755
index 00000000000..035307fc82f
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+#
+# Functional test for vhost-vsock over CPR (cpr-transfer and cpr-exec):
+# a host<->guest vsock transfer must survive repeated CPR migrations, in
+# either direction.
+#
+# Copyright (c) 2026 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import fcntl
+import filecmp
+import os
+import subprocess
+import time
+
+from qemu.qmp import ConnectError, ExecInterruptedError
+from qemu.qmp.legacy import QEMUMonitorProtocol
+from qemu_test import (Asset, LinuxKernelTest, exec_command,
+                       exec_command_and_wait_for_pattern, get_qemu_img,
+                       skipIfMissingCommands)
+
+GUEST_CID = 4000000010    # we expect this CID to be free on the host
+VSOCK_PORT = 5000
+
+TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CPR_INTERVAL = 0.2                   # interval between CPR ops
+
+VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
+VHOST_RESET_OWNER = 0xAF02    # _IO(VHOST_VIRTIO, 0x02)
+
+# What a QMP connection raises when its QEMU goes away underneath it
+QMP_GONE = (OSError, EOFError, ConnectError, ExecInterruptedError)
+
+
+@skipIfMissingCommands('socat')
+class VhostVsockCPR(LinuxKernelTest):
+    # This should have passwordless root login, vsock support + socat
+    ASSET_DISKIMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-nocloud-amd64-20231210-1590.qcow2'),
+        'b94e3f34db59988a815b33dffc24f5a58502540efece2cc1ed15e0ac8749bb2e')
+
+    def require_vhost_vsock_cpr(self):
+        try:
+            fd = os.open('/dev/vhost-vsock', os.O_RDWR)
+        except OSError:
+            self.skipTest('/dev/vhost-vsock is not available')
+        try:
+            for name, request in (('VHOST_SET_OWNER', VHOST_SET_OWNER),
+                                  ('VHOST_RESET_OWNER', VHOST_RESET_OWNER)):
+                try:
+                    fcntl.ioctl(fd, request)
+                except OSError:
+                    self.skipTest(f'{name} is not supported for vhost-vsock')
+        finally:
+            os.close(fd)
+
+    def setUp(self):
+        super().setUp()
+        self.require_accelerator('kvm')
+        self.require_device('vhost-vsock-pci')
+        self.require_vhost_vsock_cpr()
+        self.set_machine('q35')
+
+        # Use Debian cloud image as a backing.  During host<->guest
+        # transfer the guest will write data to its disk, so we start
+        # it with an overlay
+        self.disk = self.scratch_file('disk.qcow2')
+        subprocess.check_call([get_qemu_img(self), 'create', '-q', '-f',
+                               'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
+                               '-F', 'qcow2', self.disk])
+
+        self.payload = self.scratch_file('payload')
+        with open(self.payload, 'wb') as f:
+            for _ in range(TRANSFER_SIZE >> 20):
+                f.write(os.urandom(1 << 20))
+
+        self.sock_dir = self.socket_dir().name
+        self.cpr_count = 0
+
+        self.guest = None
+        self.qmp_path = None
+
+    def prepare_vm(self, vm, name, *extra_args):
+        # We don't want QEMUMachine.launch() set up QMP for us.  In this
+        # case launch() waits for greeting - which won't be sent cause
+        # CPR target is reading CPR migration channel before QMP
+        qmp_path = os.path.join(self.sock_dir, f'{name}-qmp.sock')
+        vm.set_qmp_monitor(False)
+        vm.set_console()
+        vm.add_args('-accel', 'kvm', '-m', '1G',
+                    '-object', 'memory-backend-memfd,id=ram,share=on,size=1G',
+                    '-machine', 'memory-backend=ram,aux-ram-share=on',
+                    '-drive', f'file={self.disk},if=none,id=disk,format=qcow2',
+                    '-device', 'virtio-blk-pci,drive=disk',
+                    '-device', f'vhost-vsock-pci,guest-cid={GUEST_CID}',
+                    '-qmp', f'unix:{qmp_path},server=on,wait=off',
+                    *extra_args)
+        return qmp_path
+
+    def wait_for(self, what, cond, timeout=60):
+        """Poll cond() until it returns something true, and return that"""
+        deadline = time.monotonic() + timeout
+        while True:
+            value = cond()
+            if value:
+                return value
+            self.assertLess(time.monotonic(), deadline,
+                            f'timed out waiting for {what}')
+            time.sleep(0.2)
+
+    def qmp_connect(self, qmp_path):
+        """Connect to a QEMU which may still be starting up"""
+        def attempt():
+            try:
+                qmp = QEMUMonitorProtocol(qmp_path)
+                qmp.connect()
+                return qmp
+            except (OSError, ConnectError):
+                return None
+        return self.wait_for('QMP to come up', attempt)
+
+    def wait_migration(self, qmp):
+        def completed():
+            status = qmp.cmd('query-migrate').get('status')
+            self.assertNotEqual(status, 'failed', 'migration failed')
+            return status == 'completed'
+        self.wait_for('migration completion', completed)
+
+    def wait_running(self, qmp_path):
+        # Make sure we're dealing with the new QEMU after CPR
+        while True:
+            try:
+                with self.qmp_connect(qmp_path) as qmp:
+                    self.wait_for('the VM to resume', lambda: qmp.cmd(
+                        'query-status')['status'] == 'running')
+                return
+            except QMP_GONE:
+                pass
+
+    def boot(self):
+        self.guest = self.vm
+        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.guest.launch()
+        self.wait_for_console_pattern('login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
+
+    def transfer(self, guest_cmd, host_cmd, cpr):
+        """
+        Run a socat transfer between the guest and the host, and keep
+        performing CPR migrations as long as it's in progress
+        """
+        exec_command(self, f'{guest_cmd} &', vm=self.guest)
+        with subprocess.Popen(host_cmd) as socat:
+            while socat.poll() is None:
+                time.sleep(CPR_INTERVAL)
+                cpr()
+        self.assertEqual(socat.returncode, 0, 'host socat failed')
+        exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
+                                          'RC_0', vm=self.guest)
+
+    def transfer_both_ways(self, cpr):
+        """
+        Send the payload to a file on the guest's disk, get it back into
+        another file on the host, then compare.
+        """
+        echo = self.scratch_file('echo')
+        connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
+
+        self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
+                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+        self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
+                      ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
+
+        self.log.info('%d CPR migrations performed', self.cpr_count)
+        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+                        'the data came back different')
+
+    def test_cpr_transfer(self):
+        """
+        Perform consecutive cpr-transfer migrations during vsock file
+        transfer, starting a new QEMU instance on each one, migrating into
+        it and shutting down the source
+        """
+        def cpr():
+            n = self.cpr_count
+            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
+            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
+            target = self.get_vm(name=f'target{n}')
+            target_qmp_path = self.prepare_vm(
+                target, f'target{n}',
+                '-incoming', f'unix:{mig_sock}',
+                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                             f'addr.path={cpr_sock}')
+
+            # The target listens on the CPR channel: wait for it to be there
+            target.launch()
+            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+
+            with self.qmp_connect(self.qmp_path) as qmp:
+                qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+                qmp.cmd('migrate', channels=[
+                    {'channel-type': 'main',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': mig_sock}},
+                    {'channel-type': 'cpr',
+                     'addr': {'transport': 'socket', 'type': 'unix',
+                              'path': cpr_sock}}])
+                self.wait_migration(qmp)
+            self.wait_running(target_qmp_path)
+
+            self.guest.shutdown()
+            self.guest, self.qmp_path = target, target_qmp_path
+            self.cpr_count += 1
+
+        self.boot()
+        self.transfer_both_ways(cpr)
+
+    def test_cpr_exec(self):
+        """
+        Perform consecutive cpr-exec migration during vsock file transfer,
+        saving devices' state to a file
+        """
+        state = self.scratch_file('cpr.state')
+
+        def cpr():
+            try:
+                with self.qmp_connect(self.qmp_path) as qmp:
+                    qmp.cmd('migrate-set-parameters', **{
+                        'mode': 'cpr-exec', 'cpr-exec-command': exec_cmd})
+                    qmp.cmd('migrate', uri=f'file:{state}')
+                    self.wait_migration(qmp)
+            except QMP_GONE:
+                pass
+            self.wait_running(self.qmp_path)
+            self.cpr_count += 1
+
+        self.boot()
+        exec_cmd = [*self.guest._qemu_full_args, '-incoming', f'file:{state}']
+        self.transfer_both_ways(cpr)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()

-- 
2.47.1


