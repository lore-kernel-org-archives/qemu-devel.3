Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53ADCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1w-0001Tj-MI; Wed, 07 Oct 2026 04:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhh-00062a-M4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:44 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhV-00042F-9k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:17 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i537y9XVcxe9H2OWzF5p6rdPZxi9qggZyZ44/XRuT9vRY2L3puVANwvAUyN6LcLjjMeT6SG39Fv4T6bdma83ZABfVnpdM1bQbMbjwrU0qrV5Q5fZ9PCkEWM3ByvKyV8nMJMmj6ZBfrsolmJ880Pa60BzYQTVBwWKi7HGRgoMYu8HmezZUM38TcO5Lh7dgzdh6Uc5Dc9vZpTsKDW+X+tXYt1BHE58ZNnAtnebTRSr3OYQvRnPlanTC/vDG9Dafu/gOwacn+5lOpgYqUure2aRnQ/iMKL0CWfJK7OSP2l0HOg1P20gCj89p7s7maDSYxbc63c6B/vS7joFetQWclYedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=Q+KCb2fsh4JVp5nx1OqegZ6YufPzQltv22tnodgPVHJ5zn8Un8j0TEXwVKMu1CqZ+ZZF9pN5+SgCO3/WK3Or1BvdseMjt8iqFmqEPeBVGW4FCd42khjjBxr9szwu1Rm+yow+YPTooZtsM/HK6wDymV2LvJLW1fZATQ7fLm76dylCIed5mLqPWNC1/FmVYKWA0F+XHmjVorRvBKtnkTkYsSIlMfqUabnoBO7kQHsUIzunT2+4x72xitnh55swZesIG7aAp5UXqS/njF2WnEWuKUUIikkDRLQiKAT6HeZSj/JIPWRrSaddDR5zigBXN66AdiwSWAlQ9F8I6z/lvfMnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=TBJlB1zoJlfYRKKW7cJ5+1TqU+L0mteIax1h6o6qHcz2HDnNe8DC6U5R88AbPW/jOGGkFPYl81w8ssBUiyTlnX/3Nwc2hjIFPpCpXpaXSGLXqgkrURRA1F7OVA8YgNjt+WryqTafBqBvmgaNrEcmRScJy01RGunkaVEi+OPNa8DP8JTx5wWtaRR3tRqf2pVkqiPlcx1Jj2RGiYqRE71TK+nqJik9lB1V2853AAO/o+tnE12LitL4FI433uOJaHnTcUhR0W/+ULCC82ZQmXv5A9N7khtympkjEcgWOEQZYMXVFHsvKBh9nM6ZY9IV/y3o6OGjOG//kyvwpx6IWfNsYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:02 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:02 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:43 +0300
Subject: [PATCH v13 20/22] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-20-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1480cccd-5d60-48a6-42b1-08df23b1fa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: uchgMO3w4Ua+t60S1QgC7EOjUp2unqDuHX9zzR8Lv7N9xvB9yPdPSfrAAlTeV9Qc0MRKJlLfN4gByXcGqyXohir66fhoBpHSbzDl7d4lhZUl3sddr/4EByM/AEDRl9L8pV0F2tJ/ZHlD2uCnQa7OYrjDzdiZB6J6hdRuHcppfr2p6XE/HxGKHx4fgA+37uwYNCirHDVOHydF5tlWprXKKSpbv3iSv+oIG13R9noB6rVINDXCLBFjyBPpIo00B9cjqJ/cby9/BrwwMVY0DOOFsU+xKrmcUrwzqzS1nUWq+9mqLWDlaR+BkymJeM6K1oTP64YrZPnfaHW+Av/TGNDFLqoxI8E47omrbIYbWbyiJQHzf7BDeBFn5v5Y/eknollYDqyC2XAQ2++OBheIKtnM+kqnUCs6CmzJE21HEtAEeQiohinPR69GGt8M31U2Hf4YJeaGPNZPBMzXU2+vOIGFjnDT4EU0ijTFxCya+AsQCSOsbvOijbiBsc9iR3brgneyXUzEBbNGushPNnFDm578enzxvZF6y8RQer9O5MIyNz8H0gEPwTIHnGqIJKCa4JwqvsS1+tuF7Y1ApuGdno6mn++KgOgYVPIk32DYSW1OYhfZlm+F/y3SyFjikwAjvUlMZA1ywYstVwc3zdVlgw8MRorhHKjHAAAmm3I8N8WKd+7KE2Zj9NhTTRiMzgefCZM/lLLqmVh/MioqG0BLYZqH9ji/EXoAhIWUDb2z2eYm28I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xkUnRDMUZxTnN3YmtPN2ZRUUN6anlPZFJlSlFLaUVyQ3BPMExBRVR2M0ky?=
 =?utf-8?B?Q1V6TlJQNS9pZzlFMlFUM0ErUWNjNVV6YkR5WUxVQS9tQi9uSlNTci9veHZV?=
 =?utf-8?B?cFdDU1REaStwOHR5elQ5d1RsUGgrcHcvRXBVY1ZNUDNIRS92VDBhVHhqT3NT?=
 =?utf-8?B?SCtsaDRrVHRqZGpwUmFMTlhZcm9nUHgyazB0eTVNN1lBV1BITElIaGRKa2g0?=
 =?utf-8?B?c1M0OUxEdm1RU2w0dWhDeWU1U0hDaVJGWEtldEd6V1VVUTNaSllsM1JPakMw?=
 =?utf-8?B?b0dnSHJ4dlczd2hrT0JOZWVldDdWTXhEcjQrTzZHU3RJZ25rSmREUUVuSTRE?=
 =?utf-8?B?SXh1cnBhRjBseFpqaEQyMVcyWmx0Z0t5SUZjWmt4SkRQZ2RMcEp1S1IxWSs1?=
 =?utf-8?B?cnRGTkhWaUwwRlFvcmgweTJTUVVHM1ByWU1vWE1URDQ2UmU4Nm4vR0J1Z3M2?=
 =?utf-8?B?RzR3OE42Ym5KalpuSG0ybGFVOGZ1bDRVa2RNTG80ZnRvbGducmpOTGNLSEdh?=
 =?utf-8?B?TUFVTlAvZ2RBZG4wTTNYbDhMelBzR1dERW1EV3MrQ240Y0h6Zi92ZHRscnl2?=
 =?utf-8?B?Znd1TmlkYVp2TWxjODIxLzV6aXVXR3o1ZUVTWWQ5Mkk3clZMU0pIT2NMckEy?=
 =?utf-8?B?ait4c3ZGVWtIdzlFSmNiKzN2MVFyRXFOSG5EcmorbGx0WnY0N21YUjZNSDd1?=
 =?utf-8?B?K3Y4UFhPVkxIdFZBKzZtUHFRSFRRSTluWnhEajk3SXJVNk5OMkxDK0FaeEVt?=
 =?utf-8?B?VEpxTytrM09rYmQxT0w5dmhTdlBiaVNIMWJKMExoMDVqTlBNZFZCNlRMK1p1?=
 =?utf-8?B?K1NtdDQyZjVPVi9qbmwwSFpOWG5JdW5qMzB1dU9aVHE3T25YcElGTGlUT0Vi?=
 =?utf-8?B?aG10bHVwdkJIMEZGM1pJUCt4dHZwcVAxODc2S0dZVERxeHhsbEVaZjBqbkZh?=
 =?utf-8?B?ay84NFNhNVFMVklGNGxpcGcwZ3Z0SXhHQzVIeFZ3bTBzYzl0MTBucXptRzhh?=
 =?utf-8?B?VW5PMFc5K2syQXpRcXU5UFdwTDdreHhyTVhaWmk0YmpTNmpIUXdKVzFJTnZw?=
 =?utf-8?B?NXFWUExaOTNmbVRpVDBKdTByOWIzZTFZNGtxWGRBN0RZdEp0YVlSUExtM0tJ?=
 =?utf-8?B?SCtQWHRWZHA3L0ZTaGtHVm9lMFcvNGkrUmovVTdxQlFVK2lISGovaTBQdzRO?=
 =?utf-8?B?Ull0WkdmTmpRS3RrTGNldmRuUmpLYU1aZWZEZ2pvaTl3Q1U5WUF1OXloL29K?=
 =?utf-8?B?Z0ozKzBsSHhGYlNpN1JZTk5ZRHJ3aUZ2Y1U2VjJCbDRtSGFLUzMwMERyWTE3?=
 =?utf-8?B?N2hRUlpOa0xPaTk0eUJNYmdPNFlQeW1uU0gxcm5PVzBZSUMvczdXeHhGU2di?=
 =?utf-8?B?MGtNV3A5ZDg0WFV5dkVENjdGNTVRNmJIZ1pIMWpLSU9DZGtFQ1RjQVBuNnUv?=
 =?utf-8?B?aHRSVEFnMmVhY1VWcCt6bHk3cmQ4TWJ5N3MxdG4vQnJZMkNNMFJEUFNMT1p6?=
 =?utf-8?B?QUdSR0FQayswYkZkenZkR3lUUnUwZE5pSkNBdzhtdlJGeVZoY3ZNRFJHYk92?=
 =?utf-8?B?VGRIOXZlY3VPdUs3SWFDalFSODF3SVVWMnIreEM0bXRyWEJyU0sxbDh5RzFB?=
 =?utf-8?B?ZWVtbktvd3RjK2M1c1AvMHJJSWZCUlFmaGNha1A5RlRJcU1QTkJadjJuTExV?=
 =?utf-8?B?bFhVR1BqWThJaWNnV29lVUx0eW9oZE5TU0FiaWtieVZVL3pMeWl1MEhDK2d3?=
 =?utf-8?B?aEVNdktCMlovZ25GU2t6WmxzQ29uNmtMODJFdDNlRmc0NENpOVR5ZTdURko2?=
 =?utf-8?B?VFVQWkhrVVVkUGJmMVM1cVBCc2k3L1BvSDU2YWVVSE5rdlNacFVYSlc0Vnha?=
 =?utf-8?B?ckp5Z1dzNnAyM3RBUmNWN3lIN1FBYUVJcVFSWWxqV05OekNscWR3a2ppRUUy?=
 =?utf-8?B?ZXNEVFl5S1BTVXo1QlNRQlYvcCtTdGlFSHMraXQ3QmZnRzJuOTdnaEw3TzVT?=
 =?utf-8?B?ckhPTDNUNkdUaTdCa0pCcjBIMTlDOWNIUnZCS3Z4bll5bk9GUEl5UXozQ0Q1?=
 =?utf-8?B?YTRROEpGSy9LSkRCbENvRitNUktySUFjUFZMbThGUWJTem9MSndBWm05ZDV3?=
 =?utf-8?B?ZXFCQ2lHZFZqSW4rNUxpWkpXZWMwU1R2dGNhcWZZQWl6VFhjUzNZZWp1RHRi?=
 =?utf-8?B?OTJqQXlyVDY1NVZDWUo4S2RHQ3F4YzQzRUUrejlZd2RQeThTMkthTGY1NW9z?=
 =?utf-8?B?Y0ZqTzRuM0EvaVA1eGVoNE1YbEx5aWZsV1krd2VVb2gzSE1scTQ5Y3IxeE83?=
 =?utf-8?B?bzEyNkI3ZmhFVFIxQUVDSTZRTnNRZENHSThSTWZHVlZyNlRZaStlVi9jNW03?=
 =?utf-8?Q?oISx7kgNRxHooxoI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1480cccd-5d60-48a6-42b1-08df23b1fa0e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:02.3044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hLdXCWkeO1xOZ35SqBVB9eWIk6yT/LRMQ4mNv7VBguiaNZkshAWOMLLGZ9o20gvDFyWPZkUJk8ox/hLMCG6yTbjRHj6NaGOr4/vrQsSsCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 05c2ac1336d..3c21b79001e 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -354,4 +429,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


