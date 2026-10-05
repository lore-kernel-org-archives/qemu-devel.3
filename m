Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E325CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCg-0008Vi-KX; Mon, 05 Oct 2026 11:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCR-0008PA-Lh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:56 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCP-00058M-62
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHLFQFeCDYYYegihiAgcQ3dgVw1F7MbMN4cpbgmtYnc5GkoJJ/UWSADQQfYpDGoXJjVATvRwje18PbRVazwVdDSp2fQwvN8hrfN3g+f97rFm05oI3GY92slkhg/zLVSikbyAm1dLdtQLfjQqVj9yf2IqaYmLJj4iNjrXhfo/buoeZUNScpK/Xl3DQAZBcPzDeFenkSrazC+F2RmjW3PayikDKl0KSKYH067YmMFCwEK9bly2cZpxMuDDTycLKjX0MT1jlxaIJkeM1c13el6l/WylWcA0UZsWGsdEHuNAJ2AWuHR+b8o77Bp5GjSBDhz+qiaYgc1OIt9WPcHqAMru/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=wG/UXj9VkzmKHRC24GL6gvN2Dnko1s57p6u9Whg6Ri8QrMlvfXZQoR6WGncv4H2YKlV/BWEcn3MpIJ1Yso/PqGE4Xj1avukdC4/prSscQj4o/uCvOLIDlwHXpqypaip6oDckIQN5MPtlOWVM3/fsmI32+OyGf0E2Q9I8hVYIZoTQXgJn8JxGEClg9OK/O9h7ErWeQsiS5srFTCcCsmfLGNZ0NQwVngE1acMLbkvEOEBfhLWMDgI0zmopj1FJVUUmVDhymyeOLzSlXVj5+a/DQesc8C7vU8C8MkusKxzdKgmeI7aDiTur2WauuOMa7qUuA6gU8uwevDqq1y/T+umUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=nj7y9fLQdzJ5mVn358CBcGkiBA1SRotMCxx2dkFwZfHCa3fJ5Lt+CQBHDd8JSScgxXhMR1zJbpi0eczNj1HLm4G9LXYuwKxHjgK0CH8sumRT5CYSd2qSH+yl0O9dPtRImnWQ6EfuKAWztdjUElSkyCisYMdD9BUPMWBzVqd/GHVwqFo0lV6MdEfY/rr/gVfFqdjLVCtsY7nL/HHHKPx994md8+aXmWOvlwqAUS4n7qlQRNHYlu51u5/VLzP41XeJs6aRg4+uCn8GdTHUnz48YsmCJ1poxblJuOMPBEW9nO7eA47YMJaSFOdgcQ760IPj5Ckriud77KljPTRtr5OoQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:28 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:28 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:58 +0300
Subject: [PATCH v12 19/21] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-19-40162390c68a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c00fda4e-e42d-42ff-fc6a-08df22f18893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|260925022911599003|6133799003|10067099003|56012099006|260925021311599003|22082099003|260925021911599003|18002099003;
X-Microsoft-Antispam-Message-Info: qDuyaDz94R8gFA5axeKHIWUM2j5t+DVrlCSgTrj7Gv5iRv2L/1oOMOwR96BOxIAwtgYp+7YNBhR2Ck8LULfFSq/vz+sDGQmJvuhl7LdG6Ew0T11KG39A5OMIWepfDyDyXhWFWIBlPonln8dAaQiX3iTdgF3V153yapxnBRP0lojBD7GKzG/H/Dl+B7C2JNmO04e7OcPNrbUBnLiXycQM+IMvZHL5E6bqPQCny/42nfPKL79a6Q5J/Db3+AFVSEHBVmXXf0qP9WxH0dmT8QnDaW7K4d8qsXhJqA2g0nzb299qx/gd4qM6Jj5bVXQugYgdroTMO2Hy36kETvcjjl8cNcjtk8EbekZDVJEsbAMPjO4nFwBei9o74/VwVD5sBLoB9kzbYd5xOWjOEXpr19g1en+wUKZheAo9dzVw0rEbDiwBU7bEWR9MF8cUC1wx2AZlN6NdSUu4UhEmyl/c76CDeUHlOynUFKdlVJ/kNZP/EvN/N8H7NlcZ47t7qgo1hfOOrH3jqdj8oBGwyIEUiCvECVkgF4wwx6dyBoXDFWASvgNW9DhsgElwnSk9NK3yzJHsVLTm9WHHpaI2xxI3LeWZ35X7PltwEnUVEfCyvMMYKhglPQ5JqQyeIgD16nMpbZT+I10KvaA63NpgdKXKWjz06+MNVx0UTKC0WJUuHOSLI4I3Lob17ccWDLxFGNH6DdLBJtFy2TbYYh/ernsb0st5SjENhOIckk6YoRZR+uzJU4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(260925022911599003)(6133799003)(10067099003)(56012099006)(260925021311599003)(22082099003)(260925021911599003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGcrMkQzL2o5U1Y5cFpXaGxxMDY0eGZxNEQ1eVRUZThmckJaZiswQ0wyQnZH?=
 =?utf-8?B?RGh5Mjdad1NJZCtpTjVDRDBQb0FNY2JJaTJhVit2cUtMRGREWnVna0kxTjJT?=
 =?utf-8?B?c013bk1rNHp4ZFhhMDAyRnRFNk9nQXAvOXVDZWc4Q2xSVDZiaVVrMGNEd25w?=
 =?utf-8?B?Mmg3cmpHQ1NMZzRNRDErVHlNeXNLZlorUWJTUFVmVmpFK21mM0pJS21ESlha?=
 =?utf-8?B?VEhWRlVTUER2UDFsSElGYzBDQTA1eVZCbXFHUG1rWS84Q3JnVGFiMFVKNGNR?=
 =?utf-8?B?S3pyWnM3Q3NSU21WSkVYMEM2OS9OMEVPSGlXTVMvM2RIaEFDeW5YcEhEcGJl?=
 =?utf-8?B?aGtKQU9OQmhUcFJGTisvdFFrdHBWbW16R0xrU1lUTnlGVXR2L1gva0Nvc3NL?=
 =?utf-8?B?M3lVbFQ2a2dsbkpqVUJ0QXFlZGRsNE9XN01sVUxIY2JYalJTa0gvQTMzR2RF?=
 =?utf-8?B?YzJRK05xWVdib2pveGQrSE1RZzlTaWlsUGFqQnh3U2phYnVnL0hEK29HZkkw?=
 =?utf-8?B?aDZ1ZWRQWVZGb1VHaHQ3Q2haVXZqSzR5Ty84dndLc1ZLd2Z6cGREUlNjd081?=
 =?utf-8?B?Q0dyU01nbzFOalRYVVBPQkNZV2J3c1pWUWNqcC94TkVVbzZncnd6QXM4MmxY?=
 =?utf-8?B?WHFOYm02cjlzZkZUQWI1YWo4Wlp0bjcrV3VUVGJHMEZQRUd2NWcvSXZiT3E3?=
 =?utf-8?B?UmJTZC84dVhXcllYT1FwUXhTUndmT0J3anlCSUNrdENWVmNENXJQcUZhdlZ5?=
 =?utf-8?B?cVBnWEhhUVgweUxiTGltU0crRHp0Yk0wZzJpUVN3c0traFFrdkY5cmgvK2h4?=
 =?utf-8?B?UnJFZk85S0pxTGY3bHVHWlRZQ2VVU3NORmo0VFJoTFNqOXludXBGT3BsUEhU?=
 =?utf-8?B?MXFlTEhEbDhocndRTXhVcEl2NlJpMXl2QXFwTlhWbDV6SnBJQk8rWXFGcnlm?=
 =?utf-8?B?SkhQMUJ6aHdDV1oyYUx1ekxra1NqR1J6dVp1bUdDbHlKMHZaTG9hMG9QMmpm?=
 =?utf-8?B?c2dGRklxRys3dVNIMGwwRmZPL085NzA1Z2RFd3dFVjBsM3dER2xRd2xRN21s?=
 =?utf-8?B?NlRZblBUektERVhkMGJxcStxeUEyK28xc3JhWjJvVGo4UG80VkFsYmo1NzVS?=
 =?utf-8?B?T1RzTzNVazFxMUxYNVlJWG5lNjE4OG44VHJrcTFWL1BnelNPalhEZGRLbzVC?=
 =?utf-8?B?YlFqRWhhVzNDY1VjSDdMSnljZ3JXYVZMeVhKeGp6QWVScDVQTUx3RmRkZUxr?=
 =?utf-8?B?WVlWcXBVT3EyMVRDMTQ3Z2FoTDdNdGY3Q0srY2kydGE3dm5ncjFPK2FKQjFp?=
 =?utf-8?B?OXF1NzVIZndxNGt0eW0xeTlMNHlTV3FSQllHWXViTHNMZTBLOXZhaFZ2TjI0?=
 =?utf-8?B?RzhocWhVOEl1MU9jTWtZRXBLWnlZcDkyVFlSV3EvWlpOQUlUblNJa1ZLUDEy?=
 =?utf-8?B?ZEVURExWS2w0TWFicUlZT2d1bitWL3E0WW9KUG80R29PNmhLNEV6L0xSN1Jr?=
 =?utf-8?B?cjEyT0dPTVdjZ1E1aUpvQnNKWmc4SXhnZXl1NkxsWDVYdGVQd1NhQXptai9n?=
 =?utf-8?B?USt2ditVSVZXSTBIcUExSm5RMW5BTkRyWCtXRzBWZU41QzVmMFdpQzFvVEZB?=
 =?utf-8?B?UExiT2hsNjNTb1JJY3FkOHRraERhM3I1dVJaL29Gc3NNbVBpYkZUdnN3Yldu?=
 =?utf-8?B?a0F5RS93dFdYdWd5RjJSWmJjNURxSGY0dmpkN1ZyQUpBaVMwQzU3QU1hbVN5?=
 =?utf-8?B?R2dpMjN3QlE4OVhMejg3SVJZZFc2TTZHak1nQ0I3aUxPKzhDTUp6TzNPWm95?=
 =?utf-8?B?TTFUMCtFeGZkeXlqNEExMkY5eWl2bDNQZ2EvbDIzbElhaTUzbTMvZzUyM0Rn?=
 =?utf-8?B?aUxuOVdCNzBYUXZrRkpMRUkvL3dneE14blJrM1JFQmJ2cTFxbXhDVG15ZXdG?=
 =?utf-8?B?QzQ4MlFWK2xuRTdKcHErbmhJU3RMdFNjYUZ2UnNxUVFNYnQvUkJCMVU5K1Z4?=
 =?utf-8?B?NHUwRVhTdFcvS1Nxc0tLUEZiOFluT2dnTWQ2SjF4UHdxTnA4emMyWjhRY0xV?=
 =?utf-8?B?MlEwZC9naVVyY2dESkFqQittTFdaV09TV2VzTEZ3bHVicmxFWnNXSjZCMytx?=
 =?utf-8?B?SW5FUENKa0JyZDNGeEthVG01Vkg1Z3VTekJsdHMwYi82WStiSUdjUGMyRU1D?=
 =?utf-8?B?SEN5U0UrZ1VZNkdYRDJGd2luUUFYSVErbjNDekwyRFRzRU9aYnQ1Ym1xZWNk?=
 =?utf-8?B?WlYzL2xxbTNnbS9BS21Ldk1HNitXSnRFN201SCtJamQ1S1d3ZVFCOEdMSmxj?=
 =?utf-8?B?VU1lQ3ova2VNWXo5UWxzc0VBNk1xTzdBMXZQVTU3MWpmOW5VTVN4YUdRU0dJ?=
 =?utf-8?Q?JkLpnYuIhCL0Ppnw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00fda4e-e42d-42ff-fc6a-08df22f18893
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:28.5040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjlvYacSujEn6qELK7MiFltWtGuXExxByXRiyNsjRP5NTzPuo+cSvrjhpUGYQMFjBBy+loAr99xhGAbb6FRjn/I6GYuPZv6+3D4q3B1p7nk=
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


